Return-Path: <linux-kernel+bounces-6061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7A8193B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EDA1C20DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ACA4D11F;
	Tue, 19 Dec 2023 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bmAVzIYf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B64CB43
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlYQJh3Zrut4xXu3wLWLs7KGtUj3CeTDuDfdtjdzU7g=;
	b=bmAVzIYfyYppWmvGTLBiS5nG8obTrmbbdL0D6+ClOLIyRzStyC0cUpgaQoGRj4B9negloZ
	gDBuxMa0ozyhE+nyywcFc4sF3IFTOtfxFhASYlhLoyPMu0p611lKZY7InRWt+SuofDu71+
	8EC/bvZUjw4CO1A7j3BBvX7vr2/bJog=
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
Subject: [PATCH mm 19/21] kasan: rename and document kasan_(un)poison_object_data
Date: Tue, 19 Dec 2023 23:29:03 +0100
Message-Id: <eab156ebbd635f9635ef67d1a4271f716994e628.1703024586.git.andreyknvl@google.com>
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

Rename kasan_unpoison_object_data to kasan_unpoison_new_object and add
a documentation comment. Do the same for kasan_poison_object_data.

The new names and the comments should suggest the users that these hooks
are intended for internal use by the slab allocator.

The following patch will remove non-slab-internal uses of these hooks.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 35 +++++++++++++++++++++++++++--------
 mm/kasan/common.c     |  4 ++--
 mm/slab.c             | 10 ++++------
 mm/slub.c             |  4 ++--
 net/core/skbuff.c     |  8 ++++----
 5 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 7392c5d89b92..d49e3d4c099e 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -129,20 +129,39 @@ static __always_inline void kasan_poison_slab(struct slab *slab)
 		__kasan_poison_slab(slab);
 }
 
-void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
-static __always_inline void kasan_unpoison_object_data(struct kmem_cache *cache,
+void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object);
+/**
+ * kasan_unpoison_new_object - Temporarily unpoison a new slab object.
+ * @cache: Cache the object belong to.
+ * @object: Pointer to the object.
+ *
+ * This function is intended for the slab allocator's internal use. It
+ * temporarily unpoisons an object from a newly allocated slab without doing
+ * anything else. The object must later be repoisoned by
+ * kasan_poison_new_object().
+ */
+static __always_inline void kasan_unpoison_new_object(struct kmem_cache *cache,
 							void *object)
 {
 	if (kasan_enabled())
-		__kasan_unpoison_object_data(cache, object);
+		__kasan_unpoison_new_object(cache, object);
 }
 
-void __kasan_poison_object_data(struct kmem_cache *cache, void *object);
-static __always_inline void kasan_poison_object_data(struct kmem_cache *cache,
+void __kasan_poison_new_object(struct kmem_cache *cache, void *object);
+/**
+ * kasan_unpoison_new_object - Repoison a new slab object.
+ * @cache: Cache the object belong to.
+ * @object: Pointer to the object.
+ *
+ * This function is intended for the slab allocator's internal use. It
+ * repoisons an object that was previously unpoisoned by
+ * kasan_unpoison_new_object() without doing anything else.
+ */
+static __always_inline void kasan_poison_new_object(struct kmem_cache *cache,
 							void *object)
 {
 	if (kasan_enabled())
-		__kasan_poison_object_data(cache, object);
+		__kasan_poison_new_object(cache, object);
 }
 
 void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
@@ -342,9 +361,9 @@ static inline bool kasan_unpoison_pages(struct page *page, unsigned int order,
 	return false;
 }
 static inline void kasan_poison_slab(struct slab *slab) {}
-static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
+static inline void kasan_unpoison_new_object(struct kmem_cache *cache,
 					void *object) {}
-static inline void kasan_poison_object_data(struct kmem_cache *cache,
+static inline void kasan_poison_new_object(struct kmem_cache *cache,
 					void *object) {}
 static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
 				const void *object)
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b8e7416f83af..ebb1b23d6480 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -143,12 +143,12 @@ void __kasan_poison_slab(struct slab *slab)
 		     KASAN_SLAB_REDZONE, false);
 }
 
-void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
+void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object)
 {
 	kasan_unpoison(object, cache->object_size, false);
 }
 
-void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
+void __kasan_poison_new_object(struct kmem_cache *cache, void *object)
 {
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
 			KASAN_SLAB_REDZONE, false);
diff --git a/mm/slab.c b/mm/slab.c
index 9ad3d0f2d1a5..773c79e153f3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2327,11 +2327,9 @@ static void cache_init_objs_debug(struct kmem_cache *cachep, struct slab *slab)
 		 * They must also be threaded.
 		 */
 		if (cachep->ctor && !(cachep->flags & SLAB_POISON)) {
-			kasan_unpoison_object_data(cachep,
-						   objp + obj_offset(cachep));
+			kasan_unpoison_new_object(cachep, objp + obj_offset(cachep));
 			cachep->ctor(objp + obj_offset(cachep));
-			kasan_poison_object_data(
-				cachep, objp + obj_offset(cachep));
+			kasan_poison_new_object(cachep, objp + obj_offset(cachep));
 		}
 
 		if (cachep->flags & SLAB_RED_ZONE) {
@@ -2472,9 +2470,9 @@ static void cache_init_objs(struct kmem_cache *cachep,
 
 		/* constructor could break poison info */
 		if (DEBUG == 0 && cachep->ctor) {
-			kasan_unpoison_object_data(cachep, objp);
+			kasan_unpoison_new_object(cachep, objp);
 			cachep->ctor(objp);
-			kasan_poison_object_data(cachep, objp);
+			kasan_poison_new_object(cachep, objp);
 		}
 
 		if (!shuffled)
diff --git a/mm/slub.c b/mm/slub.c
index 782bd8a6bd34..891742e5932a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1860,9 +1860,9 @@ static void *setup_object(struct kmem_cache *s, void *object)
 	setup_object_debug(s, object);
 	object = kasan_init_slab_obj(s, object);
 	if (unlikely(s->ctor)) {
-		kasan_unpoison_object_data(s, object);
+		kasan_unpoison_new_object(s, object);
 		s->ctor(object);
-		kasan_poison_object_data(s, object);
+		kasan_poison_new_object(s, object);
 	}
 	return object;
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..63bb6526399d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -337,7 +337,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	}
 
 	skb = nc->skb_cache[--nc->skb_count];
-	kasan_unpoison_object_data(skbuff_cache, skb);
+	kasan_unpoison_new_object(skbuff_cache, skb);
 
 	return skb;
 }
@@ -1309,13 +1309,13 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 	u32 i;
 
-	kasan_poison_object_data(skbuff_cache, skb);
+	kasan_poison_new_object(skbuff_cache, skb);
 	nc->skb_cache[nc->skb_count++] = skb;
 
 	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
 		for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
-			kasan_unpoison_object_data(skbuff_cache,
-						   nc->skb_cache[i]);
+			kasan_unpoison_new_object(skbuff_cache,
+						  nc->skb_cache[i]);
 
 		kmem_cache_free_bulk(skbuff_cache, NAPI_SKB_CACHE_HALF,
 				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
-- 
2.25.1


