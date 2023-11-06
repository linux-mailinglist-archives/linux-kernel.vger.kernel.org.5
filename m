Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1967E2DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKFUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjKFUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:12:48 -0500
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A76D75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:12:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzcd7T6SaBRo5t2Dalks3vRx+ahOG8KGm+CRn7Qcn4c=;
        b=pwv3dkzff3LD7yWHcbYcgAz4JV6yfUR59dhP8YxPHgOJqBy44vK2HoY3LSsvhd8ac/r+Kw
        YjUTxsAxtuUXSOSqxissVE/DJambefCo5UZhQA3OpygTzSXNBEkWw+ttz9+sRuo965g4Qr
        dO5rxteHGvoYv4f78rDOUpqGsj2A/J4=
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
Subject: [PATCH RFC 12/20] kasan: save alloc stack traces for mempool
Date:   Mon,  6 Nov 2023 21:10:21 +0100
Message-Id: <325b1285d95f7bb6d2865750aa0088ab4cb5e0c3.1699297309.git.andreyknvl@google.com>
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

Update kasan_mempool_unpoison_object to properly poison the redzone and
save alloc strack traces for kmalloc and slab pools.

As a part of this change, split out and use a unpoison_slab_object helper
function from __kasan_slab_alloc.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  7 +++---
 mm/kasan/common.c     | 50 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index e636a00e26ba..7392c5d89b92 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -303,9 +303,10 @@ void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip);
  * mempool).
  *
  * This function unpoisons a slab allocation that was previously poisoned via
- * kasan_mempool_poison_object() without initializing its memory. For the
- * tag-based modes, this function does not assign a new tag to the allocation
- * and instead restores the original tags based on the pointer value.
+ * kasan_mempool_poison_object() and saves an alloc stack trace for it without
+ * initializing the allocation's memory. For the tag-based modes, this function
+ * does not assign a new tag to the allocation and instead restores the
+ * original tags based on the pointer value.
  *
  * This function operates on all slab allocations including large kmalloc
  * allocations (the ones returned by kmalloc_large() or by kmalloc() with the
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b50e4fbaf238..65850d37fd27 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -267,6 +267,20 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 	/* The object will be poisoned by kasan_poison_pages(). */
 }
 
+void unpoison_slab_object(struct kmem_cache *cache, void *object, gfp_t flags,
+			  bool init)
+{
+	/*
+	 * Unpoison the whole object. For kmalloc() allocations,
+	 * poison_kmalloc_redzone() will do precise poisoning.
+	 */
+	kasan_unpoison(object, cache->object_size, init);
+
+	/* Save alloc info (if possible) for non-kmalloc() allocations. */
+	if (kasan_stack_collection_enabled() && !is_kmalloc_cache(cache))
+		kasan_save_alloc_info(cache, object, flags);
+}
+
 void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 					void *object, gfp_t flags, bool init)
 {
@@ -289,15 +303,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	tag = assign_tag(cache, object, false);
 	tagged_object = set_tag(object, tag);
 
-	/*
-	 * Unpoison the whole object.
-	 * For kmalloc() allocations, kasan_kmalloc() will do precise poisoning.
-	 */
-	kasan_unpoison(tagged_object, cache->object_size, init);
-
-	/* Save alloc info (if possible) for non-kmalloc() allocations. */
-	if (kasan_stack_collection_enabled() && !is_kmalloc_cache(cache))
-		kasan_save_alloc_info(cache, tagged_object, flags);
+	/* Unpoison the object and save alloc info for non-kmalloc() allocations. */
+	unpoison_slab_object(cache, tagged_object, flags, init);
 
 	return tagged_object;
 }
@@ -472,7 +479,30 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 
 void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
 {
-	kasan_unpoison(ptr, size, false);
+	struct slab *slab;
+	gfp_t flags = 0; /* Might be executing under a lock. */
+
+	if (is_kfence_address(kasan_reset_tag(ptr)))
+		return;
+
+	slab = virt_to_slab(ptr);
+
+	/*
+	 * This function can be called for large kmalloc allocation that get
+	 * their memory from page_alloc.
+	 */
+	if (unlikely(!slab)) {
+		kasan_unpoison(ptr, size, false);
+		poison_kmalloc_large_redzone(ptr, size, flags);
+		return;
+	}
+
+	/* Unpoison the object and save alloc info for non-kmalloc() allocations. */
+	unpoison_slab_object(slab->slab_cache, ptr, size, flags);
+
+	/* Poison the redzone and save alloc info for kmalloc() allocations. */
+	if (is_kmalloc_cache(slab->slab_cache))
+		poison_kmalloc_redzone(slab->slab_cache, ptr, size, flags);
 }
 
 bool __kasan_check_byte(const void *address, unsigned long ip)
-- 
2.25.1

