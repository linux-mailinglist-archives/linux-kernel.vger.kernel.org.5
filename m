Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC11766FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjG1Ow4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjG1Owy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:52:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8262BCE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:52:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-236-Fp2cxm8lMJC0BQqv7saK6A-1; Fri, 28 Jul 2023 15:52:50 +0100
X-MC-Unique: Fp2cxm8lMJC0BQqv7saK6A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jul
 2023 15:52:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jul 2023 15:52:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: [PATCH next v2 4/5] minmax: Allow comparisons of 'int' against
 'unsigned char/short'.
Thread-Topic: [PATCH next v2 4/5] minmax: Allow comparisons of 'int' against
 'unsigned char/short'.
Thread-Index: AdnBYyrMGD35ZuQNSpqtqF8DHKMGsw==
Date:   Fri, 28 Jul 2023 14:52:49 +0000
Message-ID: <34492660a17e44c19a98c4f0f37f6320@AcuMS.aculab.com>
References: <bde3d2dc933848bbaceeb9b7102f6f4c@AcuMS.aculab.com>
In-Reply-To: <bde3d2dc933848bbaceeb9b7102f6f4c@AcuMS.aculab.com>
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

Since 'unsigned char/short' get promoted to 'signed int' it is
safe to compare them against an 'int' value.

Signed-off-by: David Laight <david.laight@aculab.com>
---
v2: No change
 include/linux/minmax.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 4c77ac9ed284..7d3ad9cbbff6 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -20,7 +20,8 @@
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
 #define __types_ok(x, y) \
-	(is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
+	(is_signed_type(typeof(x)) == is_signed_type(typeof(y)) ||	\
+		is_signed_type(typeof((x) + 0)) == is_signed_type(typeof((y) + 0)))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

