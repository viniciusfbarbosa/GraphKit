/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*/

import XCTest
import GraphKit

class TreeTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testSetInt() {
		let s: Tree<Int, Int> = Tree<Int, Int>()
		
		XCTAssert(0 == s.count, "Test failed, got \(s.count).")
		
		for (var i: Int = 1000; i > 0; --i) {
			s.insert(1, value: 1)
			s.insert(2, value: 2)
			s.insert(3, value: 3)
		}
		
		XCTAssert(3 == s.count, "Test failed.\(s)")
		XCTAssert(1 == s[0]!, "Test failed.")
		XCTAssert(2 == s[1]!, "Test failed.")
		XCTAssert(3 == s[2]!, "Test failed.")
		
		for (var i: Int = 500; i > 0; --i) {
			s.remove(1)
			s.remove(3)
		}
		
		XCTAssert(1 == s.count, "Test failed.")
		XCTAssert(true == s.remove(2), "Test failed.")
		XCTAssert(false == s.remove(2), "Test failed.")
		XCTAssert(true == s.insert(2, value: 10), "Test failed.")
		XCTAssert(1 == s.count, "Test failed.")
		XCTAssert(10 == s.find(2)!, "Test failed.")
		XCTAssert(10 == s[0]!, "Test failed.")
		XCTAssert(true == (s.remove(2) && 0 == s.count), "Test failed.")
		
		s.insert(1, value: 1)
		s.insert(2, value: 2)
		s.insert(3, value: 3)
		
		s.update(3, value: 5)
		let subs: Tree<Int, Int> = s.search(3)
		XCTAssert(1 == subs.count, "Test failed.")
		
		var generator = subs.generate()
		while let x = generator.next() {
			XCTAssert(5 == x, "Test failed.")
		}
		
		for (var i: Int = s.endIndex - 1; i >= s.startIndex; --i) {
			s[i] = 100
			XCTAssert(100 == s[i], "Test failed.")
		}
		
		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}
	
	func testSetString() {
		let s: Tree<String, Array<Int>> = Tree<String, Array<Int>>()
		s.insert("friends", value: [1, 2, 3])
		s["menu"] = [11, 22, 33]
		
		XCTAssert(s["friends"]! == s[0]!, "Test failed.")
		XCTAssert(s["menu"]! == s[1]!, "Test failed.")
		XCTAssert(s["empty"] == nil, "Test failed.")
		s["menu"] = [22, 33, 44]
		XCTAssert(s["menu"]! == [22, 33, 44], "Test failed.")
		s["menu"] = nil
		XCTAssert(2 == s.count, "Test failed.")
	}
	
	func testSearch() {
		let t1: Tree<Int, Int> = Tree<Int, Int>()
		XCTAssert(0 == t1.count, "Test failed, got \(t1.count).")
		
		for (var i: Int = 1000; i > 0; --i) {
			t1.insert(1, value: 1)
			t1.insert(2, value: 2)
			t1.insert(3, value: 3)
		}
		
		XCTAssert(3 == t1.count, "Test failed.")
		
		let t2: Tree<Int, Int> = t1.search(1)
		XCTAssert(1 == t2.count, "Test failed, got \(t2.count).")
		
		let t3: Tree<Int, Int> = t1.search(2)
		XCTAssert(1 == t3.count, "Test failed, got \(t3.count).")
		
		let t4: Tree<Int, Int> = t1.search(3)
		XCTAssert(1 == t4.count, "Test failed, got \(t4.count).")
	}
	
	func testConcat() {
		let t1: Tree<Int, Int> = Tree<Int, Int>()
		t1.insert(1, value: 1)
		t1.insert(2, value: 2)
		t1.insert(3, value: 3)
		
		let t2: Tree<Int, Int> = Tree<Int, Int>()
		t2.insert(4, value: 4)
		t2.insert(5, value: 5)
		t2.insert(6, value: 6)
		
		let t3: Tree<Int, Int> = t1 + t2
		
		for var i: Int = t1.count - 1; i >= 0; --i {
			XCTAssert(t1[i] == t3.find(t1[i]!), "Test failed.")
		}
		
		for var i: Int = t2.count - 1; i >= 0; --i {
			XCTAssert(t2[i] == t3.find(t2[i]!), "Test failed.")
		}
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measureBlock() {
			// Put the code you want to measure the time of here.
		}
	}
	
}
