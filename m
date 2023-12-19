Return-Path: <linux-kernel+bounces-6042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881ED819384
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4911C23632
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635173D0D6;
	Tue, 19 Dec 2023 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qtqOsejh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557E3D0AB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703024952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65Nj55va0LyidH/qJFPAhjUaSN3kZxL0lL8iCsNvyX4=;
	b=qtqOsejhFRAQXz/SAXNo9IB1G73IEgw3a9jUz4FGb8dWQiMSemlTQ9pIavZ+Zr7zX4kUJ8
	0olVIm0l45jMoaa0ZeX7DsQotFdRhNCybCgNQh0s4gGlUfcs17lifVGwAZhMGf9p4P7gCO
	LcI0++R63ENC8BHKVFsfmjkGqnOvA4Y=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <alobakin@pm.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 01/21] kasan: rename kasan_slab_free_mempool to kasan_mempool_poison_object
Date: Tue, 19 Dec 2023 23:28:45 +0100
Message-Id: <c5618685abb7cdbf9fb4897f565e7759f601da84.1703024586.git.andreyknvl@google.com>
In-Reply-To: <cover.1703024586.git.andreyknvl@google.com>
References: <cover.1703024586.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
index fe6c4b43ad9f..e0394d0ee7f1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -271,7 +271,7 @@ static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 
 	/*
 	 * The object will be poisoned by kasan_poison_pages() or
-	 * kasan_slab_free_mempool().
+	 * kasan_mempool_poison_object().
 	 */
 
 	return false;
@@ -282,7 +282,7 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 	____kasan_kfree_large(ptr, ip);
 }
 
-void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
+void __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 {
 	struct folio *folio;
 
diff --git a/mm/mempool.c b/mm/mempool.c
index b3d2084fd989..7e1c729f292b 100644
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


