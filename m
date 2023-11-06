Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCB57E2DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjKFUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjKFUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:10:40 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45BD77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:10:35 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zUveeaHubKwNWv/mUHyod8asGDxf8HEl2nDgxq3m5s=;
        b=L3cpdQsl8rkb7JZtwAIC4eCSnezYGVtiw98SxiDVzYCV5xe1AfbsSj6usun1a4l+c+qqRu
        z1J/4gwLmo5D3p+Kwl2i4n8TQXJgQGILOLkaKmpXlQWt0svPMKOeoNq+e2E1zahPLmA8Hc
        UdUKlPDzpckCJ729haSLr62Qg8EuqI4=
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
Subject: [PATCH RFC 01/20] kasan: rename kasan_slab_free_mempool to kasan_mempool_poison_object
Date:   Mon,  6 Nov 2023 21:10:10 +0100
Message-Id: <bc70b448d766ef7f78a631d1fb6b98919f12b197.1699297309.git.andreyknvl@google.com>
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

Rename kasan_slab_free_mempool to kasan_mempool_poison_object.

kasan_slab_free_mempool is a slightly confusing name: it is unclear
whether this function poisons the object when it is freed into mempool
or does something when the object is freed from mempool to the underlying
allocator.

The new name also aligns with other mempool-related KASAN hooks added in
the following patches in this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h  | 8 ++++----
 io_uring/alloc_cache.h | 3 +--
 mm/kasan/common.c      | 4 ++--
 mm/mempool.c           | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 72cb693b075b..6310435f528b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -172,11 +172,11 @@ static __always_inline void kasan_kfree_large(void *ptr)
 		__kasan_kfree_large(ptr, _RET_IP_);
 }
 
-void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
-static __always_inline void kasan_slab_free_mempool(void *ptr)
+void __kasan_mempool_poison_object(void *ptr, unsigned long ip);
+static __always_inline void kasan_mempool_poison_object(void *ptr)
 {
 	if (kasan_enabled())
-		__kasan_slab_free_mempool(ptr, _RET_IP_);
+		__kasan_mempool_poison_object(ptr, _RET_IP_);
 }
 
 void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
@@ -256,7 +256,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init
 	return false;
 }
 static inline void kasan_kfree_large(void *ptr) {}
-static inline void kasan_slab_free_mempool(void *ptr) {}
+static inline void kasan_mempool_poison_object(void *ptr) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags, bool init)
 {
diff --git a/io_uring/alloc_cache.h b/io_uring/alloc_cache.h
index 241245cb54a6..8de0414e8efe 100644
--- a/io_uring/alloc_cache.h
+++ b/io_uring/alloc_cache.h
@@ -16,8 +16,7 @@ static inline bool io_alloc_cache_put(struct io_alloc_cache *cache,
 	if (cache->nr_cached < cache->max_cached) {
 		cache->nr_cached++;
 		wq_stack_add_head(&entry->node, &cache->list);
-		/* KASAN poisons object */
-		kasan_slab_free_mempool(entry);
+		kasan_mempool_poison_object(entry);
 		return true;
 	}
 	return false;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 256930da578a..e42d6f349ae2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -261,7 +261,7 @@ static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 
 	/*
 	 * The object will be poisoned by kasan_poison_pages() or
-	 * kasan_slab_free_mempool().
+	 * kasan_mempool_poison_object().
 	 */
 
 	return false;
@@ -272,7 +272,7 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 	____kasan_kfree_large(ptr, ip);
 }
 
-void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
+void __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 {
 	struct folio *folio;
 
diff --git a/mm/mempool.c b/mm/mempool.c
index 734bcf5afbb7..768cb39dc5e2 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -107,7 +107,7 @@ static inline void poison_element(mempool_t *pool, void *element)
 static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_slab_free_mempool(element);
+		kasan_mempool_poison_object(element);
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_poison_pages(element, (unsigned long)pool->pool_data,
 				   false);
-- 
2.25.1

