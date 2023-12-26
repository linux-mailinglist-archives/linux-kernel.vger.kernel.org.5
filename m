Return-Path: <linux-kernel+bounces-11712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDE81EA63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5968A1F218A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109185394;
	Tue, 26 Dec 2023 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KsKHNPqD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6E5257
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703631091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KAcZVWUdwxMgEguWO/ipgfFw4d2BOub4xvB7dxmq+gU=;
	b=KsKHNPqDeqoEeAJoRpQZG4yWXxJWmQq2+AcxQm+Busl0tPEWJWU4/fqxWpQGGxTvf7k1vq
	Szj8Tq6B+qN48kKlRbItk5DzB2dvWd++Mi863otmoP2s1LGT3V5Ep+WP0vnfQSNHeDW92e
	DRyIKyGgCs+z/VAHI+ViGjP8HSLLhhw=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] kasan: stop leaking stack trace handles
Date: Tue, 26 Dec 2023 23:51:21 +0100
Message-Id: <20231226225121.235865-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Commit 773688a6cb24 ("kasan: use stack_depot_put for Generic mode") added
support for stack trace eviction for Generic KASAN.

However, that commit didn't evict stack traces when the object is not put
into quarantine. As a result, some stack traces are never evicted from
the stack depot.

In addition, with the "kasan: save mempool stack traces" series, the
free stack traces for mempool objects are also not properly evicted from
the stack depot.

Fix both issues by:

1. Evicting all stack traces when an object if freed if it was not put
   into quarantine;

2. Always evicting an existing free stack trace when a new one is saved.

Also do a few related clean-ups:

- Do not zero out free track when initializing/invalidating free meta:
  set a value in shadow memory instead;

- Rename KASAN_SLAB_FREETRACK to KASAN_SLAB_FREE_META;

- Drop the kasan_init_cache_meta function as it's not used by KASAN;

- Add comments for the kasan_alloc_meta and kasan_free_meta structs.

Fixes: 773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Andrew, please put this as a separate patch on top of all KASAN patches
in mm.
---
 mm/kasan/common.c         | 27 +++++++++++++++---
 mm/kasan/generic.c        | 60 +++++++++++++++++++++++++++++++++------
 mm/kasan/kasan.h          | 25 ++++++++++++----
 mm/kasan/quarantine.c     | 20 +------------
 mm/kasan/report_generic.c |  6 ++--
 5 files changed, 97 insertions(+), 41 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a486e9b1ac68..223af53d4338 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -255,14 +255,33 @@ static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
 bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 				unsigned long ip, bool init)
 {
-	bool buggy_object;
-
 	if (is_kfence_address(object))
 		return false;
 
-	buggy_object = poison_slab_object(cache, object, ip, init);
+	/*
+	 * If the object is buggy, do not let slab put the object onto the
+	 * freelist. The object will thus never be allocated again and its
+	 * metadata will never get released.
+	 */
+	if (poison_slab_object(cache, object, ip, init))
+		return true;
+
+	/*
+	 * If the object is put into quarantine, do not let slab put the object
+	 * onto the freelist for now. The object's metadata is kept until the
+	 * object gets evicted from quarantine.
+	 */
+	if (kasan_quarantine_put(cache, object))
+		return true;
+
+	/*
+	 * If the object is not put into quarantine, it will likely be quickly
+	 * reallocated. Thus, release its metadata now.
+	 */
+	kasan_release_object_meta(cache, object);
 
-	return buggy_object ? true : kasan_quarantine_put(cache, object);
+	/* Let slab put the object onto the freelist. */
+	return false;
 }
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 0e77c43c559e..fc22ea1af775 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -480,10 +480,10 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 {
 	struct kasan_alloc_meta *alloc_meta;
-	struct kasan_free_meta *free_meta;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (alloc_meta) {
+		/* Zero out alloc meta to mark it as invalid. */
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 
 		/*
@@ -495,9 +495,50 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 		raw_spin_lock_init(&alloc_meta->aux_lock);
 		kasan_enable_current();
 	}
+
+	/*
+	 * Explicitly marking free meta as invalid is not required: the shadow
+	 * value for the first 8 bytes of a newly allocated object is not
+	 * KASAN_SLAB_FREE_META.
+	 */
+}
+
+void release_alloc_meta(struct kasan_alloc_meta *meta)
+{
+	/* Evict the stack traces from stack depot. */
+	stack_depot_put(meta->alloc_track.stack);
+	stack_depot_put(meta->aux_stack[0]);
+	stack_depot_put(meta->aux_stack[1]);
+
+	/* Zero out alloc meta to mark it as invalid. */
+	__memset(meta, 0, sizeof(*meta));
+}
+
+void release_free_meta(const void *object, struct kasan_free_meta *meta)
+{
+	/* Check if free meta is valid. */
+	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
+		return;
+
+	/* Evict the stack trace from the stack depot. */
+	stack_depot_put(meta->free_track.stack);
+
+	/* Mark free meta as invalid. */
+	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
+}
+
+void kasan_release_object_meta(struct kmem_cache *cache, const void *object)
+{
+	struct kasan_alloc_meta *alloc_meta;
+	struct kasan_free_meta *free_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (alloc_meta)
+		release_alloc_meta(alloc_meta);
+
 	free_meta = kasan_get_free_meta(cache, object);
 	if (free_meta)
-		__memset(free_meta, 0, sizeof(*free_meta));
+		release_free_meta(object, free_meta);
 }
 
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
@@ -573,11 +614,8 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	if (!alloc_meta)
 		return;
 
-	/* Evict previous stack traces (might exist for krealloc). */
-	stack_depot_put(alloc_meta->alloc_track.stack);
-	stack_depot_put(alloc_meta->aux_stack[0]);
-	stack_depot_put(alloc_meta->aux_stack[1]);
-	__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	/* Evict previous stack traces (might exist for krealloc or mempool). */
+	release_alloc_meta(alloc_meta);
 
 	kasan_save_track(&alloc_meta->alloc_track, flags);
 }
@@ -590,7 +628,11 @@ void kasan_save_free_info(struct kmem_cache *cache, void *object)
 	if (!free_meta)
 		return;
 
+	/* Evict previous stack trace (might exist for mempool). */
+	release_free_meta(object, free_meta);
+
 	kasan_save_track(&free_meta->free_track, 0);
-	/* The object was freed and has free track set. */
-	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
+
+	/* Mark free meta as valid. */
+	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE_META;
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 814e89523c64..645ae04539c9 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -156,7 +156,7 @@ static inline bool kasan_requires_meta(void)
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_SLAB_FREETRACK	0xFA  /* freed slab object with free track */
+#define KASAN_SLAB_FREE_META	0xFA  /* freed slab object with free meta */
 #define KASAN_GLOBAL_REDZONE	0xF9  /* redzone for global variable */
 
 /* Stack redzone shadow values. Compiler ABI, do not change. */
@@ -253,6 +253,15 @@ struct kasan_global {
 
 #ifdef CONFIG_KASAN_GENERIC
 
+/*
+ * Alloc meta contains the allocation-related information about a slab object.
+ * Alloc meta is saved when an object is allocated and is kept until either the
+ * object returns to the slab freelist (leaves quarantine for quarantined
+ * objects or gets freed for the non-quarantined ones) or reallocated via
+ * krealloc or through a mempool.
+ * Alloc meta is stored inside of the object's redzone.
+ * Alloc meta is considered valid whenever it contains non-zero data.
+ */
 struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
 	/* Free track is stored in kasan_free_meta. */
@@ -278,8 +287,12 @@ struct qlist_node {
 #define KASAN_NO_FREE_META INT_MAX
 
 /*
- * Free meta is only used by Generic mode while the object is in quarantine.
- * After that, slab allocator stores the freelist pointer in the object.
+ * Free meta contains the freeing-related information about a slab object.
+ * Free meta is only kept for quarantined objects and for mempool objects until
+ * the object gets allocated again.
+ * Free meta is stored within the object's memory.
+ * Free meta is considered valid whenever the value of the shadow byte that
+ * corresponds to the first 8 bytes of the object is KASAN_SLAB_FREE_META.
  */
 struct kasan_free_meta {
 	struct qlist_node quarantine_link;
@@ -380,15 +393,15 @@ void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report
 struct slab *kasan_addr_to_slab(const void *addr);
 
 #ifdef CONFIG_KASAN_GENERIC
-void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int *size);
-void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 						const void *object);
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
+void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
+void kasan_release_object_meta(struct kmem_cache *cache, const void *object);
 #else
-static inline void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int *size) { }
 static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *object) { }
+static inline void kasan_release_object_meta(struct kmem_cache *cache, const void *object) { }
 #endif
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 782e045da911..8afa77bc5d3b 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -143,22 +143,10 @@ static void *qlink_to_object(struct qlist_node *qlink, struct kmem_cache *cache)
 static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 {
 	void *object = qlink_to_object(qlink, cache);
-	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
 	struct kasan_free_meta *free_meta = kasan_get_free_meta(cache, object);
 	unsigned long flags;
 
-	if (alloc_meta) {
-		stack_depot_put(alloc_meta->alloc_track.stack);
-		stack_depot_put(alloc_meta->aux_stack[0]);
-		stack_depot_put(alloc_meta->aux_stack[1]);
-		__memset(alloc_meta, 0, sizeof(*alloc_meta));
-	}
-
-	if (free_meta &&
-	    *(u8 *)kasan_mem_to_shadow(object) == KASAN_SLAB_FREETRACK) {
-		stack_depot_put(free_meta->free_track.stack);
-		__memset(&free_meta->free_track, 0, sizeof(free_meta->free_track));
-	}
+	kasan_release_object_meta(cache, object);
 
 	/*
 	 * If init_on_free is enabled and KASAN's free metadata is stored in
@@ -170,12 +158,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	    cache->kasan_info.free_meta_offset == 0)
 		memzero_explicit(free_meta, sizeof(*free_meta));
 
-	/*
-	 * As the object now gets freed from the quarantine,
-	 * take note that its free track is no longer exists.
-	 */
-	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
-
 	if (IS_ENABLED(CONFIG_SLAB))
 		local_irq_save(flags);
 
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 99cbcd73cff7..f5b8e37b3805 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -110,7 +110,7 @@ static const char *get_shadow_bug_type(struct kasan_report_info *info)
 		bug_type = "use-after-free";
 		break;
 	case KASAN_SLAB_FREE:
-	case KASAN_SLAB_FREETRACK:
+	case KASAN_SLAB_FREE_META:
 		bug_type = "slab-use-after-free";
 		break;
 	case KASAN_ALLOCA_LEFT:
@@ -173,8 +173,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 		memcpy(&info->alloc_track, &alloc_meta->alloc_track,
 		       sizeof(info->alloc_track));
 
-	if (*(u8 *)kasan_mem_to_shadow(info->object) == KASAN_SLAB_FREETRACK) {
-		/* Free meta must be present with KASAN_SLAB_FREETRACK. */
+	if (*(u8 *)kasan_mem_to_shadow(info->object) == KASAN_SLAB_FREE_META) {
+		/* Free meta must be present with KASAN_SLAB_FREE_META. */
 		free_meta = kasan_get_free_meta(info->cache, info->object);
 		memcpy(&info->free_track, &free_meta->free_track,
 		       sizeof(info->free_track));
-- 
2.25.1


