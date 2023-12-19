Return-Path: <linux-kernel+bounces-6043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CD819385
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF67B28713D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D93D557;
	Tue, 19 Dec 2023 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UmTZEubK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E43D0B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703024953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UD/Zwt/pPZV96U3h6ZFDRBLd7zSWBzdFKqeEs3HVWEE=;
	b=UmTZEubKzQoH/lyQhsn4scksM491Jqbo0EpqojoHRU0E+cXktICkazzTkFV4YlK3P70GL4
	dgY6Fs06IrKmOBcUEU27QhbAyaN4aO/daowtIz1mMORsloednidVgfydYvYT7U3SjZHFk/
	+5imE9/lInyqZ2hSS3qnfUmxERlUWdM=
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
Subject: [PATCH mm 02/21] kasan: move kasan_mempool_poison_object
Date: Tue, 19 Dec 2023 23:28:46 +0100
Message-Id: <23ea215409f43c13cdf9ecc454501a264c107d67.1703024586.git.andreyknvl@google.com>
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

Move kasan_mempool_poison_object after all slab-related KASAN hooks.

This is a preparatory change for the following patches in this series.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 16 +++++++--------
 mm/kasan/common.c     | 46 +++++++++++++++++++++----------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6310435f528b..0d1f925c136d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -172,13 +172,6 @@ static __always_inline void kasan_kfree_large(void *ptr)
 		__kasan_kfree_large(ptr, _RET_IP_);
 }
 
-void __kasan_mempool_poison_object(void *ptr, unsigned long ip);
-static __always_inline void kasan_mempool_poison_object(void *ptr)
-{
-	if (kasan_enabled())
-		__kasan_mempool_poison_object(ptr, _RET_IP_);
-}
-
 void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
 				       void *object, gfp_t flags, bool init);
 static __always_inline void * __must_check kasan_slab_alloc(
@@ -219,6 +212,13 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
 	return (void *)object;
 }
 
+void __kasan_mempool_poison_object(void *ptr, unsigned long ip);
+static __always_inline void kasan_mempool_poison_object(void *ptr)
+{
+	if (kasan_enabled())
+		__kasan_mempool_poison_object(ptr, _RET_IP_);
+}
+
 /*
  * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
  * the hardware tag-based mode that doesn't rely on compiler instrumentation.
@@ -256,7 +256,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init
 	return false;
 }
 static inline void kasan_kfree_large(void *ptr) {}
-static inline void kasan_mempool_poison_object(void *ptr) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags, bool init)
 {
@@ -276,6 +275,7 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
+static inline void kasan_mempool_poison_object(void *ptr) {}
 static inline bool kasan_check_byte(const void *address)
 {
 	return true;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index e0394d0ee7f1..fc7f711607e1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -282,29 +282,6 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 	____kasan_kfree_large(ptr, ip);
 }
 
-void __kasan_mempool_poison_object(void *ptr, unsigned long ip)
-{
-	struct folio *folio;
-
-	folio = virt_to_folio(ptr);
-
-	/*
-	 * Even though this function is only called for kmem_cache_alloc and
-	 * kmalloc backed mempool allocations, those allocations can still be
-	 * !PageSlab() when the size provided to kmalloc is larger than
-	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
-	 */
-	if (unlikely(!folio_test_slab(folio))) {
-		if (____kasan_kfree_large(ptr, ip))
-			return;
-		kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, false);
-	} else {
-		struct slab *slab = folio_slab(folio);
-
-		____kasan_slab_free(slab->slab_cache, ptr, ip, false, false);
-	}
-}
-
 void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 					void *object, gfp_t flags, bool init)
 {
@@ -452,6 +429,29 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 		return ____kasan_kmalloc(slab->slab_cache, object, size, flags);
 }
 
+void __kasan_mempool_poison_object(void *ptr, unsigned long ip)
+{
+	struct folio *folio;
+
+	folio = virt_to_folio(ptr);
+
+	/*
+	 * Even though this function is only called for kmem_cache_alloc and
+	 * kmalloc backed mempool allocations, those allocations can still be
+	 * !PageSlab() when the size provided to kmalloc is larger than
+	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
+	 */
+	if (unlikely(!folio_test_slab(folio))) {
+		if (____kasan_kfree_large(ptr, ip))
+			return;
+		kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, false);
+	} else {
+		struct slab *slab = folio_slab(folio);
+
+		____kasan_slab_free(slab->slab_cache, ptr, ip, false, false);
+	}
+}
+
 bool __kasan_check_byte(const void *address, unsigned long ip)
 {
 	if (!kasan_byte_accessible(address)) {
-- 
2.25.1


