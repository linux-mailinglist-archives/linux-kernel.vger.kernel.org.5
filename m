Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73927E2DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjKFULx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjKFULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:11:45 -0500
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B10210C9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:11:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVuFmnWl7Ai+GOwJv1yuDcJd9SrRUciNhjDptmGZnZI=;
        b=vvDAFFN6FcYKWYAGx5sCoYZo2aE996ZHT27ORsBGzAXwAllc9a/mweQGGLH+tNqC9ukgoo
        kfT6X1bqAgw8fHV/cuj8owqV2YMiINk9I1HHRRwNCkZiOyFphUoExea/Wc88Wdh/Xw3yFD
        ieHf70kObAwysIDH+u5fgJoaxYfbcAM=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH RFC 08/20] kasan: clean up __kasan_mempool_poison_object
Date:   Mon,  6 Nov 2023 21:10:17 +0100
Message-Id: <c64f3612c31d4898011a22d10d889730a2ed754b.1699297309.git.andreyknvl@google.com>
In-Reply-To: <cover.1699297309.git.andreyknvl@google.com>
References: <cover.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Reorganize the code and reword the comment in
__kasan_mempool_poison_object to improve the code readability.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6283f0206ef6..7c28d0a5af2c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -447,27 +447,22 @@ void __kasan_mempool_unpoison_pages(struct page *page, unsigned int order,
 
 bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 {
-	struct folio *folio;
-
-	folio = virt_to_folio(ptr);
+	struct folio *folio = virt_to_folio(ptr);
+	struct slab *slab;
 
 	/*
-	 * Even though this function is only called for kmem_cache_alloc and
-	 * kmalloc backed mempool allocations, those allocations can still be
-	 * !PageSlab() when the size provided to kmalloc is larger than
-	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
+	 * This function can be called for large kmalloc allocation that get
+	 * their memory from page_alloc. Thus, the folio might not be a slab.
 	 */
 	if (unlikely(!folio_test_slab(folio))) {
 		if (check_page_allocation(ptr, ip))
 			return false;
 		kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, false);
 		return true;
-	} else {
-		struct slab *slab = folio_slab(folio);
-
-		return !____kasan_slab_free(slab->slab_cache, ptr, ip,
-						false, false);
 	}
+
+	slab = folio_slab(folio);
+	return !____kasan_slab_free(slab->slab_cache, ptr, ip, false, false);
 }
 
 void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
-- 
2.25.1

