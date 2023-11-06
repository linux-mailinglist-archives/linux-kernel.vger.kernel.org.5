Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14EF7E2DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjKFUMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjKFULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:11:46 -0500
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB744D75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:11:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCp2zVxGwC1RwRlWPaWBJT09DIYULTSyRat3kYinLuo=;
        b=d537NTwRPy7XHKrbuKDfSOCLE08WU2ewkqbATysLDcBjkJxGbnCtGoml9BLyk6/HLbiYso
        RIWijpSbPsp80ot8o8jmcjVSegnslv45cg4Nvd81jyQ1AX00FXznhsA0/PT1hlWfYlVBc3
        NcK/vgYL8Yq2KxPrM8UJdzKMgl1NbA8=
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
Subject: [PATCH RFC 10/20] kasan: clean up and rename ____kasan_kmalloc
Date:   Mon,  6 Nov 2023 21:10:19 +0100
Message-Id: <ac4e6fd5fde6f8d87fba1745860d93087c53b2cd.1699297309.git.andreyknvl@google.com>
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

Introduce a new poison_kmalloc_redzone helper function that poisons
the redzone for kmalloc object.

Drop the confusingly named ____kasan_kmalloc function and instead use
poison_kmalloc_redzone along with the other required parts of
____kasan_kmalloc in the callers' code.

This is a preparatory change for the following patches in this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 683d0dad32f2..ceb06d5f169f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -302,26 +302,12 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	return tagged_object;
 }
 
-static inline void *____kasan_kmalloc(struct kmem_cache *cache,
+static inline void poison_kmalloc_redzone(struct kmem_cache *cache,
 				const void *object, size_t size, gfp_t flags)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
 
-	if (gfpflags_allow_blocking(flags))
-		kasan_quarantine_reduce();
-
-	if (unlikely(object == NULL))
-		return NULL;
-
-	if (is_kfence_address(kasan_reset_tag(object)))
-		return (void *)object;
-
-	/*
-	 * The object has already been unpoisoned by kasan_slab_alloc() for
-	 * kmalloc() or by kasan_krealloc() for krealloc().
-	 */
-
 	/*
 	 * The redzone has byte-level precision for the generic mode.
 	 * Partially poison the last object granule to cover the unaligned
@@ -345,14 +331,25 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
 	if (kasan_stack_collection_enabled() && is_kmalloc_cache(cache))
 		kasan_save_alloc_info(cache, (void *)object, flags);
 
-	/* Keep the tag that was set by kasan_slab_alloc(). */
-	return (void *)object;
 }
 
 void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object,
 					size_t size, gfp_t flags)
 {
-	return ____kasan_kmalloc(cache, object, size, flags);
+	if (gfpflags_allow_blocking(flags))
+		kasan_quarantine_reduce();
+
+	if (unlikely(object == NULL))
+		return NULL;
+
+	if (is_kfence_address(kasan_reset_tag(object)))
+		return (void *)object;
+
+	/* The object has already been unpoisoned by kasan_slab_alloc(). */
+	poison_kmalloc_redzone(cache, object, size, flags);
+
+	/* Keep the tag that was set by kasan_slab_alloc(). */
+	return (void *)object;
 }
 EXPORT_SYMBOL(__kasan_kmalloc);
 
@@ -398,6 +395,9 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return (void *)object;
 
+	if (is_kfence_address(kasan_reset_tag(object)))
+		return (void *)object;
+
 	/*
 	 * Unpoison the object's data.
 	 * Part of it might already have been unpoisoned, but it's unknown
@@ -410,8 +410,10 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	/* Piggy-back on kmalloc() instrumentation to poison the redzone. */
 	if (unlikely(!slab))
 		return __kasan_kmalloc_large(object, size, flags);
-	else
-		return ____kasan_kmalloc(slab->slab_cache, object, size, flags);
+	else {
+		poison_kmalloc_redzone(slab->slab_cache, object, size, flags);
+		return (void *)object;
+	}
 }
 
 bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
-- 
2.25.1

