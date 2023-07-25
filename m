Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E500076100E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGYKBG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 06:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjGYKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:00:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F710E3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:00:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-124-SA4uouzBO965Nt6ACHgVHg-1; Tue, 25 Jul 2023 11:00:46 +0100
X-MC-Unique: SA4uouzBO965Nt6ACHgVHg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 25 Jul
 2023 11:00:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 25 Jul 2023 11:00:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH next 1/5] minmax: Add min_unsigned(a, b) and max_unsigned(a,
 b)
Thread-Topic: [PATCH next 1/5] minmax: Add min_unsigned(a, b) and
 max_unsigned(a, b)
Thread-Index: Adm+2zJY+ejT7PjHQ52rHHfvsNPoKA==
Date:   Tue, 25 Jul 2023 10:00:45 +0000
Message-ID: <eb4a78e460d040058f7f6299c083e25a@AcuMS.aculab.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These can be used when min()/max() errors a signed v unsigned
compare when the signed value is known to be non-negative.

Unlike min_t(some_unsigned_type, a, b) min_unsigned() will never
mask off high bits if an inappropriate type is selected.

Signed-off-by: David Laight <david.laight@aculab.com>
---
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

