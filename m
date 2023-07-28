Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76469766FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbjG1Ouv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 10:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbjG1Out (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:50:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4E4220
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:50:44 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-7-phKjDKwJNyO08x5yzEPeiQ-1; Fri, 28 Jul 2023 15:50:41 +0100
X-MC-Unique: phKjDKwJNyO08x5yzEPeiQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jul
 2023 15:50:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jul 2023 15:50:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: [PATCH next v2 1/5] minmax: Add min_unsigned(a, b) and
 max_unsigned(a, b)
Thread-Topic: [PATCH next v2 1/5] minmax: Add min_unsigned(a, b) and
 max_unsigned(a, b)
Thread-Index: AdnBYtpf8rFndSOOTs6KhZSYh6/0Dg==
Date:   Fri, 28 Jul 2023 14:50:40 +0000
Message-ID: <f4a158aaac794996ba77d85be6986158@AcuMS.aculab.com>
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

These can be used when min()/max() errors a signed v unsigned
compare when the signed value is known to be non-negative.

Unlike min_t(some_unsigned_type, a, b) min_unsigned() will never
mask off high bits if an inappropriate type is selected.

The '+ 0u + 0ul + 0ull' may look strange.
The '+ 0u' is needed for 'signed int' on 64bit systems.
The '+ 0ul' is needed for 'signed long' on 32bit systems.
The '+ 0ull' is needed for 'signed long long'.

Signed-off-by: David Laight <david.laight@aculab.com>
---
v2: Updated commit message.
 include/linux/minmax.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 396df1121bff..531860e9cc55 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -73,6 +73,23 @@
  */
 #define max(x, y)	__careful_cmp(x, y, >)
 
+/**
+ * min_unsigned - return minimum of two non-negative values
+ *   Signed types are zero extended to match a larger unsigned type.
+ * @x: first value
+ * @y: second value
+ */
+#define min_unsigned(x, y)	\
+	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
+
+/**
+ * max_unsigned - return maximum of two non-negative values
+ * @x: first value
+ * @y: second value
+ */
+#define max_unsigned(x, y)	\
+	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, >)
+
 /**
  * min3 - return minimum of three values
  * @x: first value
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

