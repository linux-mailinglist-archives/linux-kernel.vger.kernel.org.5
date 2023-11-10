Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAB7E7FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjKJR5j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 12:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjKJR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2439929519
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:34:35 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-NLj8pjl0NeexzFnZFOuGjA-1; Fri, 10 Nov 2023 10:34:33 +0000
X-MC-Unique: NLj8pjl0NeexzFnZFOuGjA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 10 Nov
 2023 10:34:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 10 Nov 2023 10:34:32 +0000
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "'Martin.Uecker@med.uni-goettingen.de'" 
        <Martin.Uecker@med.uni-goettingen.de>
Subject: [PATCH next 1/1] Use _Generic() to implement __is_constexpr()
Thread-Topic: [PATCH next 1/1] Use _Generic() to implement __is_constexpr()
Thread-Index: AdoTwNq3GB/cQ14jTf+rcVCPI8O2eg==
Date:   Fri, 10 Nov 2023 10:34:31 +0000
Message-ID: <083d8bc4740246408dd2cc4510502530@AcuMS.aculab.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is somewhat more obvious than relying on sizeof(void) being 1.
It is also portable to any c11 compiler.

Change the constants to 0 - they have no bearing on the result and
just confuse the reader.

It relies on the type of (expr ? NULL : (type *)any) being 'type *'
but that of (expr ? (void *)x : (type *)any) being 'void *'.

Signed-off-by: David Laight <david.laight@aculab.com>
---

I'm not 100% sure all of 'tools' sets -std=gnu99 or -std=c11 to get
_Generic() supported.

This version will also be usable in 'nolibc' where sizeof(void) is
an error.

 include/linux/compiler.h       | 2 +-
 tools/include/linux/compiler.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index bb1339c7057b..2e11e216fd69 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -233,7 +233,7 @@ static inline void *offset_to_ptr(const int *off)
  * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
  */
 #define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+	_Generic(0 ? (void *)((long)(x) * 0) : (char *)0, char *: 1, void *: 0)
 
 /*
  * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 7b65566f3e42..6e7f05196414 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -69,7 +69,7 @@
  * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
  */
 #define __is_constexpr(x) \
-	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+	_Generic(0 ? (void *)((long)(x) * 0) : (char *)0, char *: 1, void *: 0)
 
 #ifdef __ANDROID__
 /*
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

