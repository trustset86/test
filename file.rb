# vulnerable_script.rb

require 'sqlite3'
require 'json'

# Hardcoded secret (sensitive info in code)
API_KEY = "sk_test_1234567890abcdef"

# Insecure file permissions
File.open("log.txt", "w", 0666) do |file|
  file.puts("Script started at #{Time.now}")
end

# Simulated user input
puts "Enter a shell command to run:"
user_input = gets.chomp

# Command injection vulnerability
system("echo Running your command: #{user_input}")

# Set up an in-memory SQLite DB for demo
db = SQLite3::Database.new ":memory:"
db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, password TEXT)")
db.execute("INSERT INTO users (name, password) VALUES ('alice', 'secret123')")

# SQL injection vulnerability
puts "Enter username to search:"
username = gets.chomp
result = db.execute("SELECT * FROM users WHERE name = '#{username}'")
puts "Query result: #{result.inspect}"

# Insecure deserialization
puts "Paste some JSON:"
input_json = gets.chomp
begin
  obj = JSON.parse(input_json, object_class: OpenStruct)
  puts "Deserialized object: #{obj.inspect}"
rescue => e
  puts "Error deserializing: #{e.message}"
end
