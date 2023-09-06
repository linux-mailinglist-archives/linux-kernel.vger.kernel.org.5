Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B179793705
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjIFISf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIFISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:18:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9718BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:18:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-272-IP8p3ZuMPfaowpqSVhG-ZA-1; Wed, 06 Sep 2023 09:18:25 +0100
X-MC-Unique: IP8p3ZuMPfaowpqSVhG-ZA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Sep
 2023 09:18:21 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Sep 2023 09:18:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>
CC:     'Kees Cook' <keescook@chromium.org>,
        'Vlastimil Babka' <vbabka@suse.cz>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Eric Dumazet'" <edumazet@google.com>
Subject: [PATCH] slab: kmalloc_size_roundup() must not return 0 for non-zero
 size
Thread-Topic: [PATCH] slab: kmalloc_size_roundup() must not return 0 for
 non-zero size
Thread-Index: AdngmrOo1jL765q1RK2Ib5JvSvHtFw==
Date:   Wed, 6 Sep 2023 08:18:21 +0000
Message-ID: <fcfee37ead054de19871139167aca787@AcuMS.aculab.com>
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

The typical use of kmalloc_size_roundup() is:
	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
	if (!ptr) return -ENOMEM.
This means it is vitally important that the returned value isn't
less than the argument even if the argument is insane.
In particular if kmalloc_slab() fails or the value is above
(MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
it's single zero-length buffer.

Fix by returning the input size on error or if the size exceeds
a 'sanity' limit.
kmalloc() will then return NULL is the size really is too big.

Signed-off-by: David Laight <david.laight@aculab.com>
Fixes: 05a940656e1eb ("slab: Introduce kmalloc_size_roundup()")
---
The 'sanity limit' value doesn't really matter (even if too small)
It could be 'MAX_ORDER + PAGE_SHIFT' but one ppc64 has MAX_ORDER 16
and I don't know if that also has large pages.
Maybe it could be 1ul << 30 on 64bit, but it really doesn't matter
if it is too big.

The original patch also added kmalloc_size_roundup() to mm/slob.c
that can also round up a value to zero - but has since been removed.

 mm/slab_common.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index cd71f9581e67..8418eccda8cf 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -747,22 +747,21 @@ size_t kmalloc_size_roundup(size_t size)
 {
 	struct kmem_cache *c;
 
-	/* Short-circuit the 0 size case. */
-	if (unlikely(size == 0))
-		return 0;
-	/* Short-circuit saturated "too-large" case. */
-	if (unlikely(size == SIZE_MAX))
-		return SIZE_MAX;
-	/* Above the smaller buckets, size is a multiple of page size. */
-	if (size > KMALLOC_MAX_CACHE_SIZE)
-		return PAGE_SIZE << get_order(size);
+	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
+		/*
+		 * The flags don't matter since size_index is common to all.
+		 * Neither does the caller for just getting ->object_size.
+		 */
+		c = kmalloc_slab(size, GFP_KERNEL, 0);
+		return likely(c) ? c->object_size : size;
+	}
 
-	/*
-	 * The flags don't matter since size_index is common to all.
-	 * Neither does the caller for just getting ->object_size.
-	 */
-	c = kmalloc_slab(size, GFP_KERNEL, 0);
-	return c ? c->object_size : 0;
+	/* Return 'size' for 0 and very large - kmalloc() may fail. */
+	if (unlikely((size - 1) >> (sizeof (long) == 8 ? 34 : 30)))
+		return size;
+
+	/* Above the smaller buckets, size is a multiple of page size. */
+	return PAGE_SIZE << get_order(size);
 }
 EXPORT_SYMBOL(kmalloc_size_roundup);
 
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

