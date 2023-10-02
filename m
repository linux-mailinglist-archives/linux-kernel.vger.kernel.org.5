Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0467B55BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjJBOeQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjJBOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:34:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E244FAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:34:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-323-BFh42y3gPLOfgOGwjWsmYQ-1; Mon, 02 Oct 2023 15:34:07 +0100
X-MC-Unique: BFh42y3gPLOfgOGwjWsmYQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 2 Oct
 2023 15:34:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 2 Oct 2023 15:34:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "'linux@rasmusvillemoes.dk'" <linux@rasmusvillemoes.dk>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "'bvanassche@acm.org'" <bvanassche@acm.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH next] compiler.h: Move __is_constexpr() to compiler.h.
Thread-Topic: [PATCH next] compiler.h: Move __is_constexpr() to compiler.h.
Thread-Index: Adn1PNrdhhFKapOtSdeAhH/r8REupw==
Date:   Mon, 2 Oct 2023 14:34:05 +0000
Message-ID: <6d2b584e26544ee6a0810e494352d432@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to f747e6667ebb2 __is_constexpr() was in its only user minmax.h.
That commit moved it to const.h - but that file just defined ULL(x) and
  UL(x) so that constants can be defined for .S and .c files.
So apart from the word 'const' it wasn't really a good location.
Instead move the definition to compiler.h just before the similar
  is_signed_type() and is_unsigned_type().
(Which were moved there by dcf8e5633e2e6)
This may not be a good long-term home, but the three definitions
  belong together.

Signed-off-by: David Laight <david.laight@aculab.com>
---
This makes it possible to use __is_constexpr() inside is_signed_type()
so that the result is constant integer expression for pointer types.
In particular (void *)1 isn't constant enough.

 include/linux/compiler.h    | 8 ++++++++
 include/linux/const.h       | 8 --------
 tools/include/linux/const.h | 8 --------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a18b24f..2efec9bfcc40 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -230,6 +230,14 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
 /*
  * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
  * bool and also pointer types.
diff --git a/include/linux/const.h b/include/linux/const.h
index 435ddd72d2c4..81b8aae5a855 100644
--- a/include/linux/const.h
+++ b/include/linux/const.h
@@ -3,12 +3,4 @@
 
 #include <vdso/const.h>
 
-/*
- * This returns a constant expression while determining if an argument is
- * a constant expression, most importantly without evaluating the argument.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
- */
-#define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-
 #endif /* _LINUX_CONST_H */
diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
index 435ddd72d2c4..81b8aae5a855 100644
--- a/tools/include/linux/const.h
+++ b/tools/include/linux/const.h
@@ -3,12 +3,4 @@
 
 #include <vdso/const.h>
 
-/*
- * This returns a constant expression while determining if an argument is
- * a constant expression, most importantly without evaluating the argument.
- * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
- */
-#define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
-
 #endif /* _LINUX_CONST_H */
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

