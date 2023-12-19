Return-Path: <linux-kernel+bounces-6056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25638193A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7C8B22FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706A40C1B;
	Tue, 19 Dec 2023 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2ZaOIS6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A553D0D0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+O4MJvijsH/fxNfhEtO0ZT1bhv1NQvjMHnoD8zQplM=;
	b=r2ZaOIS6ZMwbcRwAxJW59qk9nmH2ETUbfqjNUSa+35AQ7mxBRhFueCynEMDfgvcNnxrrtH
	sElLzMZVBT/HNZgRFD9eQQjvBsU+nFyNWnkw46nJ6bBbaBE5Zd1NMueq/it/uzQfhtXh75
	B0otrG1zpXfsZNehE7M3FBuN9mYYkzY=
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
Subject: [PATCH mm 12/21] kasan: save alloc stack traces for mempool
Date: Tue, 19 Dec 2023 23:28:56 +0100
Message-Id: <05ad235da8347cfe14d496d01b2aaf074b4f607c.1703024586.git.andreyknvl@google.com>
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
index 962805bf5f62..b8e7416f83af 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -277,6 +277,20 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
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
@@ -299,15 +313,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
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
@@ -482,7 +489,30 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 
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


