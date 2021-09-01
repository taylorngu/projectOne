# n is an integer >= 0
# return the nth Fibonacci number, starting with 0,1,1,2,...
# Iterative
# The recursive solution is provided
def fibonacci(n)
 return 1 if n <= 2
  fir = 0
  sec = 1
  n.times do
    temp = fir
    fir = sec
    sec = temp + sec
  end
  return fir
end

# f is a symbol of a function name and n is an integer >= 1
# return the sum of f(k) for 1<=k<=n
# Recursive or Iterative
def superSum(f, n, k = 1)
  sum = 0
  for i in (k..n)
    sum += method(f).call(i)
    i += 1
  end 
  return sum 
end 

# f is a symbol of a function name and n is an integer >= 1
# return the product of f(k) for 1<=k<=n
# Recursive or Iterative
def superProduct(f, n, k = 1)
  product = 1
  for i in (k..n)
    product *= method(f).call(i)
    i += 1
  end
  return product 
end

# test function for superSum and superProd
def cube(x)
  return x*x*x
end

# n and k are integers >= 0
# return n choose k
# Recursive  
def choose(n, k)
  return 1 if n == k || k == 0 
  return 0 if k < 0 || k > n 
  return n if k == 1 || k == n - 1
  choose(n - 1, k) + choose(n - 1,k - 1)
end 

# n is an integer >= 2
# returns smallest factor of n, including n if n is prime
# Iterative
# Why must this be prime?
def smallestFactor(n)
  return n if n <= 3
  return 2 if n % 2 == 0
  k = 3
  while k < n
    if n % k == 0 
      return k
    else 
      k += 1
    end
  end
  return k
end

# n is an integer >= 1
# returns an empty list if n == 1
# otherwise returns a list containing the prime factors of n
# Iterative or Recursive
def factorInteger(n)
  arr = []
  k = 2
  while n > 1
    if n % k == 0
      n /= k
      arr << k
    else
      k += 1
    end
  end
  return arr
end

# n is an integer >= 0 and pool is an array of integers
# returns an array of numbers in pool that sum to n
# otherwise return nil if no numbers in pool sum to n
# Recursive
def sumFrom(n, pool)
  return pool if pool.sum == n
  return n if pool.include?(n)
  pool.select!{|i| n > i}
  return nil if pool.empty?
  for i in pool
    if pool.include?(n-i) && i != n - i
      return [i, n - i]
    elsif n < i
      temp = pool
      temp.delete(i)
      return sumFrom(n - i, temp)
    end
  end
end

#Iteratively
#return nil if n <= 1
# pool.select!{|i| n > i && pool.include?(n - i)}
# return nil if pool.empty?
# return pool.sort


# n is an integer >= 0 and pool is an array of integers
# return an array of all arrays of numbers in pool that sum to n
# otherwise return an empty list if no numbers in pool sum to n
# Recursive
# This is ever so slightly ugly.
def sumFromList(n, pool)
  bleh = []
  return pool if pool.sum == n
  return n if pool.include?(n)
  pool.select!{|i| n > i}
  return nil if pool.empty?
  for i in pool
    if pool.include?(n-i) && i != n - i
      if bleh.include?([n - i, i]) == false
        bleh << [i, n - i]
      end
    elsif n < i
      temp = pool
      temp.delete(i)
      return sumFrom(n - i, temp)
    end
  end
  return(bleh.uniq!)
end

puts('Testing fibonacci:')
puts("Case %d: #{fibonacci(8) == 21}" % [8])
puts("Case %d: #{fibonacci(27) == 196418}\n\n" % [27])

puts('Testing superSum:')
puts("Case :cube, %d: #{superSum(:cube, 4) == 100}" % [4])
puts("Case :cube %d: #{superSum(:cube, 27) == 142884}\n\n" % [27])

puts('Testing superProduct:')
puts("Case :cube, %d: #{superProduct(:cube, 6) == 373248000}" % [6])
puts("Case :cube %d: #{superProduct(:cube, 100) == 812851037046656979290580347413945278009541752752031190770857947476708884823373059685672018837505047813877622071264712592314115920641160919935403754583649069843601261900051908970248135107234498895796609463150334493880799668742586291763030205250590988746228607583652771623341365916290092476956859429554672135618951275111007717373291473301054034842043089511584699570992741469705476383547415329993647980544000000000000000000000000000000000000000000000000000000000000000000000000}\n\n" % [100])

puts('Testing choose:')
puts("Case %d, %d: #{choose(10, 3) == 120}" % [10, 3])
puts("Case %d, %d: #{choose(1000, 2) == 499500}\n\n" % [1000, 2])

puts('Testing smallestFactor:')
puts("Case %d: #{smallestFactor(47) == 47}" % [47])
puts("Case %d: #{smallestFactor(21) == 3}\n\n" % [21])

puts('Testing factorInteger:')
puts("Case %d: #{factorInteger(21) == [3, 7]}" % [21])
puts("Case %d: #{factorInteger(40) == [2, 2, 2, 5]}\n\n" % [20])

puts('Testing sumFrom:')
puts("Case %d, [1, 2, 3, 4]: #{sumFrom(6, [1, 5, 3, 2, 3, 4]) == [1, 5]}" % [6])
puts("Case %d, [2, 3, 2, 3, 11, 15, 21, 4, 6, 7]: #{sumFrom(10, [2, 3, 2, 3, 11, 15, 21, 4, 6, 7]) == [3, 7]}\n\n" % [10])

puts('Testing sumFromList:')
puts("Case %d, [1, 3, 2, 3, 4, 8, 7, 9, 10, 4]: #{sumFromList(5, [1, 3, 2, 3, 4, 8, 7, 9, 10, 4]) == [[1, 4], [3, 2]]}" % [5])
puts("Case %d, [2, 3, 2, 3, 11, 15, 21, 4, 6, 7]: #{sumFrom(13, [2, 3, 2, 3, 11, 15, 21, 4, 6]) == [2, 11]}\n\n" % [13])