Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6920D76FF1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHDK6o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjHDK5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:57:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712AA524D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:56:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-bkO1WbUpNhKPKRaGR9bvIg-1; Fri, 04 Aug 2023 11:56:23 +0100
X-MC-Unique: bkO1WbUpNhKPKRaGR9bvIg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 11:56:21 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 4 Aug 2023 11:56:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
Subject: [PATCH v3 5/5] minmax: Relax check to allow comparison between int
 and small unsigned constants.
Thread-Topic: [PATCH v3 5/5] minmax: Relax check to allow comparison between
 int and small unsigned constants.
Thread-Index: AdnGwkt6hGqNS4p3Ts2CQBK2yLMoFA==
Date:   Fri, 4 Aug 2023 10:56:21 +0000
Message-ID: <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
In-Reply-To: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
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

Convert constants between 0 and INT_MAX to 'int' prior to comparisons
so that min(signed_var, 20u) and, more commonly, min(signed_var, sizeof())
are both valid.

Signed-off-by: David Laight <david.laight@aculab.com>
---
v3: Fix compiler warnings for 'x >= 0' with unsigned/pointer types.
v2: Add cast to fix min/max with pointer types.
 include/linux/minmax.h | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index f56611ab486a..8d292aa55f5f 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,11 +8,13 @@
 /*
  * min()/max()/clamp() macros must accomplish three things:
  *
- * - avoid multiple evaluations of the arguments (so side-effects like
+ * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - perform signed v unsigned type-checking (to generate compile
+ * - Perform signed v unsigned type-checking (to generate compile
  *   errors instead of nasty runtime surprises).
- * - retain result as a constant expressions when called with only
+ *   Constants from 0 to INT_MAX are cast to (int) so can be used
+ *   in comparisons with signed types.
+ * - Retain result as a constant expressions when called with only
  *   constant expressions (to avoid tripping VLA warnings in stack
  *   allocation usage).
  */
@@ -24,9 +26,17 @@
 	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
 		is_signed_type(typeof(x)), 0)
 
-#define __types_ok(x, y) 			\
-	(__is_signed(x) == __is_signed(y) ||	\
-		__is_signed((x) + 0) == __is_signed((y) + 0))
+#define __is_noneg_int(x)						\
+	(__builtin_choose_expr(!__is_constexpr(x), false, 		\
+		__builtin_choose_expr(__is_signed(x), x, 0) >= 0 &&	\
+			(x) <= (typeof((x) + 0))(long)__INT_MAX__))
+
+#define __int_const(x)	__builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
+
+#define __types_ok(x, y) 					\
+	(__is_signed(x) == __is_signed(y) ||			\
+		__is_signed((x) + 0) == __is_signed((y) + 0) ||	\
+		__is_noneg_int(x) || __is_noneg_int(y))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
@@ -34,24 +44,24 @@
 #define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
 
 #define __cmp_once(op, x, y, unique_x, unique_y) ({	\
-	typeof(x) unique_x = (x);			\
-	typeof(y) unique_y = (y);			\
+	typeof(__int_const(x)) unique_x = (x);		\
+	typeof(__int_const(y)) unique_y = (y);		\
 	static_assert(__types_ok(x, y),			\
 		#op "(" #x ", " #y ") signedness error, fix types or consider " #op "_unsigned() before " #op "_t()"); \
 	__cmp(op, unique_x, unique_y); })
 
 #define __careful_cmp(op, x, y)					\
 	__builtin_choose_expr(__is_constexpr((x) - (y)),	\
-		__cmp(op, x, y),				\
+		__cmp(op, __int_const(x), __int_const(y)),	\
 		__cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
 
 #define __clamp(val, lo, hi)	\
 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
 
 #define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({		\
-	typeof(val) unique_val = (val);						\
-	typeof(lo) unique_lo = (lo);						\
-	typeof(hi) unique_hi = (hi);						\
+	typeof(__int_const(val)) unique_val = (val);				\
+	typeof(__int_const(lo)) unique_lo = (lo);				\
+	typeof(__int_const(hi)) unique_hi = (hi);				\
 	static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
 			(lo) <= (hi), true),					\
 		"clamp() low limit " #lo " greater than high limit " #hi);	\
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

