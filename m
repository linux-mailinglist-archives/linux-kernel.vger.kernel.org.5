Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A17E2E00
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjKFUOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjKFUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:14:06 -0500
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB7173D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:13:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAC2S7cvKWC0F44BA8JFK/nUEMkMZjl2M4MUzuWuDcc=;
        b=gW/TzhDfZHPF/6G1OrNDQlLOWzEZX/fdM1cYbnvPQJyE+kylQJLDKf+bdGnEZPKJYJFBTJ
        4QEyp11eHyzBaGYnGOiz5gn3Q6Jl2PEmI90MIeHA3Z1ZMwOIDu2AEjJhNEEem2iCH7tksZ
        EO/mX3B4YVf6+hMEYQMPvEmF3YvoFx4=
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
Subject: [PATCH RFC 18/20] kasan: rename and document kasan_(un)poison_object_data
Date:   Mon,  6 Nov 2023 21:10:27 +0100
Message-Id: <1128fd5cf1051270bc7e5978479a983a918626f5.1699297309.git.andreyknvl@google.com>
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
index 65850d37fd27..9f11be6b00a8 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -133,12 +133,12 @@ void __kasan_poison_slab(struct slab *slab)
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
index 63d281dfacdb..973f091ec5d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1849,9 +1849,9 @@ static void *setup_object(struct kmem_cache *s, void *object)
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

