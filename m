Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257B076FF19
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjHDK5r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjHDK5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:57:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF744EF6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:55:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-15--2foXNzwP2iEkhCH65UiWA-1; Fri, 04 Aug 2023 11:55:41 +0100
X-MC-Unique: -2foXNzwP2iEkhCH65UiWA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 11:55:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 4 Aug 2023 11:55:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
Subject: [PATCH v3 4/5] minmax: Allow comparisons of 'int' against 'unsigned
 char/short'.
Thread-Topic: [PATCH v3 4/5] minmax: Allow comparisons of 'int' against
 'unsigned char/short'.
Thread-Index: AdnGwjJw1R+iwy+yQTyatTq077Viag==
Date:   Fri, 4 Aug 2023 10:55:39 +0000
Message-ID: <423c552b375c46ddab16488d33dee528@AcuMS.aculab.com>
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

Since 'unsigned char/short' get promoted to 'signed int' it is
safe to compare them against an 'int' value.

Signed-off-by: David Laight <david.laight@aculab.com>
---
v3; No change
v2: No change
 include/linux/minmax.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index ccfbe003a643..f56611ab486a 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -24,8 +24,9 @@
 	__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),	\
 		is_signed_type(typeof(x)), 0)
 
-#define __types_ok(x, y) \
-	(__is_signed(x) == __is_signed(y))
+#define __types_ok(x, y) 			\
+	(__is_signed(x) == __is_signed(y) ||	\
+		__is_signed((x) + 0) == __is_signed((y) + 0))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

