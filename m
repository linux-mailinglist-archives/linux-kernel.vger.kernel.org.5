Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E17617B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGYLyI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjGYLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:53:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CAE7B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:53:25 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-ynE3GkS8M1eGKh0OmdtE4w-1; Tue, 25 Jul 2023 12:53:23 +0100
X-MC-Unique: ynE3GkS8M1eGKh0OmdtE4w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 25 Jul
 2023 12:53:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 25 Jul 2023 12:53:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: [PATCH next resend 4/5] minmax: Allow comparisons of 'int' against
 'unsigned char/short'.
Thread-Topic: [PATCH next resend 4/5] minmax: Allow comparisons of 'int'
 against 'unsigned char/short'.
Thread-Index: Adm+7pBZ9m8pSBI1SiGSpdnyAYxAOg==
Date:   Tue, 25 Jul 2023 11:53:22 +0000
Message-ID: <a3309fcd947a4fb3826f1e8b8b9da585@AcuMS.aculab.com>
References: <caa84582f9414de895ac6c4fe2b53489@AcuMS.aculab.com>
In-Reply-To: <caa84582f9414de895ac6c4fe2b53489@AcuMS.aculab.com>
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

Resend as reply to 0/5

 include/linux/minmax.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 179034479d5e..baffbe5c855d 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -16,7 +16,8 @@
  *   allocation usage).
  */
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

