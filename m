Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BBC7A4482
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbjIRIWB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 04:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjIRIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:20:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8438B9D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:17:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-2SRS8BxFMv6AplXEOeuilA-1; Mon, 18 Sep 2023 09:17:27 +0100
X-MC-Unique: 2SRS8BxFMv6AplXEOeuilA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Sep
 2023 09:17:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Sep 2023 09:17:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: [PATCH next v4 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Topic: [PATCH next v4 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Index: AdnqCIofD0I8GlDTTDy+QzGyRXQA3Q==
Date:   Mon, 18 Sep 2023 08:17:15 +0000
Message-ID: <fe7e6c542e094bfca655abcd323c1c98@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
In-Reply-To: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type-check in min()/max() is there to stop unexpected results if a
negative value gets converted to a large unsigned value.
However it also rejects 'unsigned int' v 'unsigned long' compares
which are common and never problematc.

Replace the 'same type' check with a 'same signedness' check.

The new test isn't itself a compile time error, so use static_assert()
to report the error and give a meaningful error message.

Due to the way builtin_choose_expr() works detecting the error in the
'non-constant' side (where static_assert() can be used) also detects
errors when the arguments are constant.

Signed-off-by: David Laight <david.laight@aculab.com>
---
V4: No change.
v3:
- Wrap is_signed_type() in __builtin_choose_expr() and __is_constexpr().
  Generates a compile-time 0 for pointer types avoiding a bug in clang < 16.

v2:
- #include <linux/build_bug.h> to fix 'um' build.
  This matches a separate commit from Andy.
- Do not delete __typecheck() - used outside this file.
- Use __builtin_choose_expr() in __clamp_once() to fix clang builds.

 include/linux/minmax.h | 61 +++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 0e89c78810f6..a3705eb2dc3e 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MINMAX_H
 #define _LINUX_MINMAX_H
 
+#include <linux/build_bug.h>
 #include <linux/const.h>
 #include <linux/types.h>
 
@@ -10,9 +11,8 @@
  *
  * - avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - perform strict type-checking (to generate warnings instead of
- *   nasty runtime surprises). See the "unnecessary" pointer comparison
- *   in __typecheck().
+ * - perform signed v unsigned type-checking (to generate compile
+ *   errors instead of nasty runtime surprises).
  * - retain result as a constant expressions when called with only
  *   constant expressions (to avoid tripping VLA warnings in stack
  *   allocation usage).
@@ -20,23 +20,30 @@
 #define __typecheck(x, y) \
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
-#define __no_side_effects(x, y) \
-		(__is_constexpr(x) && __is_constexpr(y))
+/* is_signed_type() isn't a constexpr for pointer types */
+#define __is_signed(x) 								\
+	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
+		is_signed_type(typeof(x)), 0)
 
-#define __safe_cmp(x, y) \
-		(__typecheck(x, y) && __no_side_effects(x, y))
+#define __types_ok(x, y) \
+	(__is_signed(x) == __is_signed(y))
 
-#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
+#define __cmp_op_min <
+#define __cmp_op_max >
 
-#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
+#define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
+
+#define __cmp_once(op, x, y, unique_x, unique_y) ({	\
 		typeof(x) unique_x = (x);		\
 		typeof(y) unique_y = (y);		\
-		__cmp(unique_x, unique_y, op); })
+		static_assert(__types_ok(x, y),		\
+			#op "(" #x ", " #y ") signedness error, fix types or consider u" #op "() before " #op "_t()"); \
+		__cmp(op, unique_x, unique_y); })
 
-#define __careful_cmp(x, y, op) \
-	__builtin_choose_expr(__safe_cmp(x, y), \
-		__cmp(x, y, op), \
-		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
+#define __careful_cmp(op, x, y)					\
+	__builtin_choose_expr(__is_constexpr((x) - (y)),	\
+		__cmp(op, x, y),				\
+		__cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
 
 #define __clamp(val, lo, hi)	\
 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
@@ -45,17 +52,15 @@
 		typeof(val) unique_val = (val);				\
 		typeof(lo) unique_lo = (lo);				\
 		typeof(hi) unique_hi = (hi);				\
+		static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
+				(lo) <= (hi), true),					\
+			"clamp() low limit " #lo " greater than high limit " #hi);	\
+		static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");	\
+		static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");	\
 		__clamp(unique_val, unique_lo, unique_hi); })
 
-#define __clamp_input_check(lo, hi)					\
-        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(			\
-                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))
-
 #define __careful_clamp(val, lo, hi) ({					\
-	__clamp_input_check(lo, hi) +					\
-	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) && \
-			      __typecheck(hi, lo) && __is_constexpr(val) && \
-			      __is_constexpr(lo) && __is_constexpr(hi),	\
+	__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),	\
 		__clamp(val, lo, hi),					\
 		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),		\
 			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
@@ -65,14 +70,14 @@
  * @x: first value
  * @y: second value
  */
-#define min(x, y)	__careful_cmp(x, y, <)
+#define min(x, y)	__careful_cmp(min, x, y)
 
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
-#define max(x, y)	__careful_cmp(x, y, >)
+#define max(x, y)	__careful_cmp(max, x, y)
 
 /**
  * umin - return minimum of two non-negative values
@@ -81,7 +86,7 @@
  * @y: second value
  */
 #define umin(x, y)	\
-	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
+	__careful_cmp(min, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 /**
  * umax - return maximum of two non-negative values
@@ -89,7 +94,7 @@
  * @y: second value
  */
 #define umax(x, y)	\
-	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, >)
+	__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 /**
  * min3 - return minimum of three values
@@ -141,7 +146,7 @@
  * @x: first value
  * @y: second value
  */
-#define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)
+#define min_t(type, x, y)	__careful_cmp(min, (type)(x), (type)(y))
 
 /**
  * max_t - return maximum of two values, using the specified type
@@ -149,7 +154,7 @@
  * @x: first value
  * @y: second value
  */
-#define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
+#define max_t(type, x, y)	__careful_cmp(max, (type)(x), (type)(y))
 
 /*
  * Remove a const qualifier from integer types
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

