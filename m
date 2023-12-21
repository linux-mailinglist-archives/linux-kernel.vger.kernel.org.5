Return-Path: <linux-kernel+bounces-8935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF681BE52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9AC28646E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53C64AA1;
	Thu, 21 Dec 2023 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tbPj3uPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC15BA30
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703183747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DILt3p53uNIRMlyKqLmSfi67XoCveJqLdgVMwZq9yXA=;
	b=tbPj3uPoBR5fvyz4IQYqOUCK1dVNmUbtUl682TOpZhrRNOI2YNW915Z6Ra8mnw382p2lYY
	HAd5JqqGBNdGgKffBGvfA3Jgnw4Cwc00qn3tU0JtUl5qPdxqASFQcj+BykHY8fWr1UcDvc
	K8EcdixFixDgAws3WeDglq4de+F8pvM=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>,
	Juntong Deng <juntong.deng@outlook.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 1/4] kasan: clean up kasan_cache_create
Date: Thu, 21 Dec 2023 19:35:37 +0100
Message-Id: <20231221183540.168428-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Reorganize the code to avoid nested if/else checks to improve the
readability.

Also drop the confusing comments about KMALLOC_MAX_SIZE checks: they
are relevant for both SLUB and SLAB (originally, the comments likely
confused KMALLOC_MAX_SIZE with KMALLOC_MAX_CACHE_SIZE).

Fixes: a5989d4ed40c ("kasan: improve free meta storage in Generic KASAN")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/generic.c | 67 +++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 54e20b2bc3e1..769e43e05d0b 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -381,16 +381,11 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 
 	ok_size = *size;
 
-	/* Add alloc meta into redzone. */
+	/* Add alloc meta into the redzone. */
 	cache->kasan_info.alloc_meta_offset = *size;
 	*size += sizeof(struct kasan_alloc_meta);
 
-	/*
-	 * If alloc meta doesn't fit, don't add it.
-	 * This can only happen with SLAB, as it has KMALLOC_MAX_SIZE equal
-	 * to KMALLOC_MAX_CACHE_SIZE and doesn't fall back to page_alloc for
-	 * larger sizes.
-	 */
+	/* If alloc meta doesn't fit, don't add it. */
 	if (*size > KMALLOC_MAX_SIZE) {
 		cache->kasan_info.alloc_meta_offset = 0;
 		*size = ok_size;
@@ -401,36 +396,52 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	orig_alloc_meta_offset = cache->kasan_info.alloc_meta_offset;
 
 	/*
-	 * Add free meta into redzone when it's not possible to store
+	 * Store free meta in the redzone when it's not possible to store
 	 * it in the object. This is the case when:
 	 * 1. Object is SLAB_TYPESAFE_BY_RCU, which means that it can
 	 *    be touched after it was freed, or
 	 * 2. Object has a constructor, which means it's expected to
-	 *    retain its content until the next allocation, or
-	 * 3. Object is too small and SLUB DEBUG is enabled. Avoid
-	 *    free meta that exceeds the object size corrupts the
-	 *    SLUB DEBUG metadata.
-	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
-	 * If the object is smaller than the free meta and SLUB DEBUG
-	 * is not enabled, it is still possible to store part of the
-	 * free meta in the object.
+	 *    retain its content until the next allocation.
 	 */
 	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
 		cache->kasan_info.free_meta_offset = *size;
 		*size += sizeof(struct kasan_free_meta);
-	} else if (cache->object_size < sizeof(struct kasan_free_meta)) {
-		if (__slub_debug_enabled()) {
-			cache->kasan_info.free_meta_offset = *size;
-			*size += sizeof(struct kasan_free_meta);
-		} else {
-			rem_free_meta_size = sizeof(struct kasan_free_meta) -
-									cache->object_size;
-			*size += rem_free_meta_size;
-			if (cache->kasan_info.alloc_meta_offset != 0)
-				cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
-		}
+		goto free_meta_added;
+	}
+
+	/*
+	 * Otherwise, if the object is large enough to contain free meta,
+	 * store it within the object.
+	 */
+	if (sizeof(struct kasan_free_meta) <= cache->object_size) {
+		/* cache->kasan_info.free_meta_offset = 0 is implied. */
+		goto free_meta_added;
 	}
 
+	/*
+	 * For smaller objects, store the beginning of free meta within the
+	 * object and the end in the redzone. And thus shift the location of
+	 * alloc meta to free up space for free meta.
+	 * This is only possible when slub_debug is disabled, as otherwise
+	 * the end of free meta will overlap with slub_debug metadata.
+	 */
+	if (!__slub_debug_enabled()) {
+		rem_free_meta_size = sizeof(struct kasan_free_meta) -
+							cache->object_size;
+		*size += rem_free_meta_size;
+		if (cache->kasan_info.alloc_meta_offset != 0)
+			cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
+		goto free_meta_added;
+	}
+
+	/*
+	 * If the object is small and slub_debug is enabled, store free meta
+	 * in the redzone after alloc meta.
+	 */
+	cache->kasan_info.free_meta_offset = *size;
+	*size += sizeof(struct kasan_free_meta);
+
+free_meta_added:
 	/* If free meta doesn't fit, don't add it. */
 	if (*size > KMALLOC_MAX_SIZE) {
 		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
@@ -440,7 +451,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 
 	/* Calculate size with optimal redzone. */
 	optimal_size = cache->object_size + optimal_redzone(cache->object_size);
-	/* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */
+	/* Limit it with KMALLOC_MAX_SIZE. */
 	if (optimal_size > KMALLOC_MAX_SIZE)
 		optimal_size = KMALLOC_MAX_SIZE;
 	/* Use optimal size if the size with added metas is not large enough. */
-- 
2.25.1


