DUMP_FILE_NAME="backup_`date +%Y-%m-%d-%H-%M`.dump"
echo "Creating dump: $DUMP_FILE_NAME"

cd pg_backup

find . -type f -mtime +30 -exec rm -vf {} \;

pg_dump -C -w --format=p --blobs > $DUMP_FILE_NAME

ls -1t | head -10 | tr '\r\n' ' '

if [ $? -ne 0 ]; then
  rm $DUMP_FILE_NAME
  echo "Back up not created, check db connection settings"
  exit 1
fi

echo 'Successfully Backed Up'
exit 0
