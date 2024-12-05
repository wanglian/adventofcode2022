file = File.open 'input.txt'

draw = []
boards = []

def mark(board, number)
  board.each do |row|
    row.each_with_index do |n, i|
      row[i] = -1 if number == n
    end
  end
end

def check(board)
  board.each_with_index do |row, i|
    return true if row.sum == -5
    sum = board[0][i] + board[1][i] + board[2][i] + board[3][i] + board[4][i]
    return true if sum == -5
  end
  false
end

def sum(board)
  board.map do |row|
    row.select{|n| n != -1}.sum
  end.sum
end

file.readlines.map(&:chomp).each_with_index do |line, i|
  line = line.chomp
  if i == 0
    draw = line.split(',').map(&:to_i)
  elsif line != ""
    n = (i-2) / 6
    boards[n] ||= []
    boards[n] << line.split(' ').map(&:to_i)
  end
end

draw.each_with_index do |number, i|
  boards.each do |board|
    mark board, number
    if i > 4
      if check(board)
        
        p "BINGO: #{board}"
        p "Number: #{number}"
        p "Result: #{sum(board) * number}"
        return
      end
    end
  end
end