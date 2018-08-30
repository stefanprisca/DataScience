#
# Find all files in this dir that contain ".answers.R" in the filename
# Remove all lines with ##
# Save file to same name - without the ".answers." part
#

filenames = Sys.glob(paths = "*.answers.Rmd")

filter_lines = function(inlines) {
i=1
outlines = c()

while(i < length(inlines)+1){
  line = inlines[i]
  # Filter out block
  if (length(grep("#!begin", line))) {
    while (!length(grep("#!end", line))) {
      i = i +1
      line = inlines[i]
    }
  }
  # Filter out single lines
  if (!length(grep("#!", line))) {
    outlines = c(outlines, line)
    print(i)
  }
  i = i + 1
}
return(outlines)
}



for (f in filenames) {
  filename.in   = f
  filename.out  = gsub(pattern = ".answers", replacement = "", x = filename.in)
  inlines  = readLines(filename.in)
  outlines = filter_lines(inlines)
  cat("File:", f, "\n")
  cat("Lines in:", length(inlines), "Lines out: ", length(outlines), "\n")
  writeLines(text = outlines, con = filename.out)
}


