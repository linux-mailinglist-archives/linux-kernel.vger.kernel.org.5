Return-Path: <linux-kernel+bounces-9024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D4D81BF62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E887F1C229F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068EF745ED;
	Thu, 21 Dec 2023 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b9Brp+Gw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F678745CC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSZaD965ObbhfRb2wl16gx9k0NFu/9CcW8O4J7mEceM=;
	b=b9Brp+GwaAs8486L9eFNPsKBa+ZcAtwpfYQSQNwgNbwsobfM5YdIdTv7QlTk+BZjKdK9i+
	vM+1DvB2mrXJOSHWT8Ex00o2C9qkxJuCHnbWABmaNBRFH42VhSFNwm8VJ/Zi/RdPA/9XKa
	vQ9svxQBNSQqoxiVPrTTZhhN4tftlRM=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 06/11] kasan: clean up is_kfence_address checks
Date: Thu, 21 Dec 2023 21:04:48 +0100
Message-Id: <1065732315ef4e141b6177d8f612232d4d5bc0ab.1703188911.git.andreyknvl@google.com>
In-Reply-To: <cover.1703188911.git.andreyknvl@google.com>
References: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

1. Do not untag addresses that are passed to is_kfence_address: it
   tolerates tagged addresses.

2. Move is_kfence_address checks from internal KASAN functions
   (kasan_poison/unpoison, etc.) to external-facing ones.

   Note that kasan_poison/unpoison are never called outside of KASAN/slab
   code anymore; the comment is wrong, so drop it.

3. Simplify/reorganize the code around the updated checks.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 26 +++++++++++++++++---------
 mm/kasan/kasan.h  | 16 ++--------------
 mm/kasan/shadow.c | 12 ------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index f4255e807b74..86adf80cc11a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -79,6 +79,9 @@ EXPORT_SYMBOL(kasan_disable_current);
 
 void __kasan_unpoison_range(const void *address, size_t size)
 {
+	if (is_kfence_address(address))
+		return;
+
 	kasan_unpoison(address, size, false);
 }
 
@@ -218,9 +221,6 @@ static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
 	tagged_object = object;
 	object = kasan_reset_tag(object);
 
-	if (is_kfence_address(object))
-		return false;
-
 	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) != object)) {
 		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
@@ -247,7 +247,12 @@ static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
 bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 				unsigned long ip, bool init)
 {
-	bool buggy_object = poison_slab_object(cache, object, ip, init);
+	bool buggy_object;
+
+	if (is_kfence_address(object))
+		return false;
+
+	buggy_object = poison_slab_object(cache, object, ip, init);
 
 	return buggy_object ? true : kasan_quarantine_put(cache, object);
 }
@@ -359,7 +364,7 @@ void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object
 	if (unlikely(object == NULL))
 		return NULL;
 
-	if (is_kfence_address(kasan_reset_tag(object)))
+	if (is_kfence_address(object))
 		return (void *)object;
 
 	/* The object has already been unpoisoned by kasan_slab_alloc(). */
@@ -417,7 +422,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return (void *)object;
 
-	if (is_kfence_address(kasan_reset_tag(object)))
+	if (is_kfence_address(object))
 		return (void *)object;
 
 	/*
@@ -483,6 +488,9 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		return true;
 	}
 
+	if (is_kfence_address(ptr))
+		return false;
+
 	slab = folio_slab(folio);
 	return !poison_slab_object(slab->slab_cache, ptr, ip, false);
 }
@@ -492,9 +500,6 @@ void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
 	struct slab *slab;
 	gfp_t flags = 0; /* Might be executing under a lock. */
 
-	if (is_kfence_address(kasan_reset_tag(ptr)))
-		return;
-
 	slab = virt_to_slab(ptr);
 
 	/*
@@ -507,6 +512,9 @@ void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
 		return;
 	}
 
+	if (is_kfence_address(ptr))
+		return;
+
 	/* Unpoison the object and save alloc info for non-kmalloc() allocations. */
 	unpoison_slab_object(slab->slab_cache, ptr, size, flags);
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 1c34511090d7..5fbcc1b805bc 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -466,35 +466,23 @@ static inline u8 kasan_random_tag(void) { return 0; }
 
 static inline void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
-	addr = kasan_reset_tag(addr);
-
-	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(addr))
-		return;
-
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
 	if (WARN_ON(size & KASAN_GRANULE_MASK))
 		return;
 
-	hw_set_mem_tag_range((void *)addr, size, value, init);
+	hw_set_mem_tag_range(kasan_reset_tag(addr), size, value, init);
 }
 
 static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 {
 	u8 tag = get_tag(addr);
 
-	addr = kasan_reset_tag(addr);
-
-	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(addr))
-		return;
-
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
 	size = round_up(size, KASAN_GRANULE_SIZE);
 
-	hw_set_mem_tag_range((void *)addr, size, tag, init);
+	hw_set_mem_tag_range(kasan_reset_tag(addr), size, tag, init);
 }
 
 static inline bool kasan_byte_accessible(const void *addr)
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 0154d200be40..30625303d01a 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -135,10 +135,6 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 	 */
 	addr = kasan_reset_tag(addr);
 
-	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(addr))
-		return;
-
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
 	if (WARN_ON(size & KASAN_GRANULE_MASK))
@@ -175,14 +171,6 @@ void kasan_unpoison(const void *addr, size_t size, bool init)
 	 */
 	addr = kasan_reset_tag(addr);
 
-	/*
-	 * Skip KFENCE memory if called explicitly outside of sl*b. Also note
-	 * that calls to ksize(), where size is not a multiple of machine-word
-	 * size, would otherwise poison the invalid portion of the word.
-	 */
-	if (is_kfence_address(addr))
-		return;
-
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
 
-- 
2.25.1


