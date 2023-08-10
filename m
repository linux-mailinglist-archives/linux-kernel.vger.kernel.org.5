Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0A777E67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjHJQgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjHJQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:36:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5CA8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:36:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3EE71F45B;
        Thu, 10 Aug 2023 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691685392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EGfAOQz6XY1pXT3KWDaIKebAxzMbhko7rkj0tHhhE0=;
        b=axrt0kxgXTo5iJR9/RB/ZPx9oJoNVwf4NlPkAjES0QAbRrNPLa3OjPKPN0kNr2/KHTGtzp
        BQAFShiw1Z61i8my7P8znJ0mhytmUseVm7s7b8xdVnVkkiwkYuXBeg0CVxBX1FH6fYFyb8
        U/xjyYxMQ5kyalhxcjfk3qTq8gzI2AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691685392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EGfAOQz6XY1pXT3KWDaIKebAxzMbhko7rkj0tHhhE0=;
        b=g5qxQbbiIaGIdqNSVfvnr6oKuz/ZAZnUCeH5CWbOmCgyhBUdV1Xl7+1HiJGFIox9Qufmol
        9YrzUGt7xdheeBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90FA7138E0;
        Thu, 10 Aug 2023 16:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qBLNIhAS1WSEPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Aug 2023 16:36:32 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v2 2/7] mm, slub: add opt-in slub_percpu_array
Date:   Thu, 10 Aug 2023 18:36:30 +0200
Message-ID: <20230810163627.6206-11-vbabka@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810163627.6206-9-vbabka@suse.cz>
References: <20230810163627.6206-9-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_setup_percpu_array() will allocate a per-cpu array for
caching alloc/free objects of given size for the cache. The cache
has to be created with SLAB_NO_MERGE flag.

The array is filled by freeing. When empty for alloc or full for
freeing, it's simply bypassed by the operation, there's currently no
batch freeing/allocations.

The locking is copied from the page allocator's pcplists, based on
embedded spin locks. Interrupts are not disabled, only preemption (cpu
migration on RT). Trylock is attempted to avoid deadlock due to
an intnerrupt, trylock failure means the array is bypassed.

Sysfs stat counters alloc_cpu_cache and free_cpu_cache count operations
that used the percpu array.

Bulk allocation bypasses the array, bulk freeing does not.

kmem_cache_prefill_percpu_array() can be called to ensure the array on
the current cpu to at least the given number of objects. However this is
only opportunistic as there's no cpu pinning and the trylocks may always
fail. Therefore allocations cannot rely on the array for success even
after the prefill. But misses should be rare enough that e.g. GFP_ATOMIC
allocations should be acceptable after the refill.
The operation is currently not optimized.

Mark SLAB_DEPRECATED as BROKEN so the new APIs don't need to be
reimplemented there and the bots don't complain. SLAB has percpu arrays
by design but their sizes are determined internally.

More TODO/FIXMEs:

- NUMA awareness - preferred node currently ignored, __GFP_THISNODE not
  honored
- slub_debug - will not work for allocations from the array. Normally in
  SLUB implementation the slub_debug kills all fast paths, but that
  could lead to depleting the reserves if we ignore the prefill and use
  GFP_ATOMIC. Needs more thought.
---
 include/linux/slab.h     |   4 +
 include/linux/slub_def.h |  10 ++
 mm/Kconfig               |   1 +
 mm/slub.c                | 210 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 848c7c82ad5a..f6c91cbc1544 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -196,6 +196,8 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 void kmem_cache_destroy(struct kmem_cache *s);
 int kmem_cache_shrink(struct kmem_cache *s);
 
+int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int count);
+
 /*
  * Please use this macro to create slab caches. Simply specify the
  * name of the structure and maybe some flags that are listed above.
@@ -494,6 +496,8 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
 int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
 
+int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int count, gfp_t gfp);
+
 static __always_inline void kfree_bulk(size_t size, void **p)
 {
 	kmem_cache_free_bulk(NULL, size, p);
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..c85434668419 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -13,8 +13,10 @@
 #include <linux/local_lock.h>
 
 enum stat_item {
+	ALLOC_PERCPU_CACHE,	/* Allocation from percpu array cache */
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
 	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
+	FREE_PERCPU_CACHE,	/* Free to percpu array cache */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
 	FREE_FROZEN,		/* Freeing to frozen slab */
@@ -66,6 +68,13 @@ struct kmem_cache_cpu {
 };
 #endif /* CONFIG_SLUB_TINY */
 
+struct slub_percpu_array {
+	spinlock_t lock;
+	unsigned int count;
+	unsigned int used;
+	void * objects[];
+};
+
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 #define slub_percpu_partial(c)		((c)->partial)
 
@@ -99,6 +108,7 @@ struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
 #endif
+	struct slub_percpu_array __percpu *cpu_array;
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
 	unsigned long min_partial;
diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..84f4dff70d39 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -237,6 +237,7 @@ choice
 config SLAB_DEPRECATED
 	bool "SLAB (DEPRECATED)"
 	depends on !PREEMPT_RT
+	depends on BROKEN
 	help
 	  Deprecated and scheduled for removal in a few cycles. Replaced by
 	  SLUB.
diff --git a/mm/slub.c b/mm/slub.c
index a9437d48840c..f41c69bac07d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -188,6 +188,79 @@ do {					\
 #define USE_LOCKLESS_FAST_PATH()	(false)
 #endif
 
+/* copy/pasted  from mm/page_alloc.c */
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+/*
+ * On SMP, spin_trylock is sufficient protection.
+ * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
+ */
+#define pcp_trylock_prepare(flags)	do { } while (0)
+#define pcp_trylock_finish(flag)	do { } while (0)
+#else
+
+/* UP spin_trylock always succeeds so disable IRQs to prevent re-entrancy. */
+#define pcp_trylock_prepare(flags)	local_irq_save(flags)
+#define pcp_trylock_finish(flags)	local_irq_restore(flags)
+#endif
+
+/*
+ * Locking a pcp requires a PCP lookup followed by a spinlock. To avoid
+ * a migration causing the wrong PCP to be locked and remote memory being
+ * potentially allocated, pin the task to the CPU for the lookup+lock.
+ * preempt_disable is used on !RT because it is faster than migrate_disable.
+ * migrate_disable is used on RT because otherwise RT spinlock usage is
+ * interfered with and a high priority task cannot preempt the allocator.
+ */
+#ifndef CONFIG_PREEMPT_RT
+#define pcpu_task_pin()		preempt_disable()
+#define pcpu_task_unpin()	preempt_enable()
+#else
+#define pcpu_task_pin()		migrate_disable()
+#define pcpu_task_unpin()	migrate_enable()
+#endif
+
+/*
+ * Generic helper to lookup and a per-cpu variable with an embedded spinlock.
+ * Return value should be used with equivalent unlock helper.
+ */
+#define pcpu_spin_lock(type, member, ptr)				\
+({									\
+	type *_ret;							\
+	pcpu_task_pin();						\
+	_ret = this_cpu_ptr(ptr);					\
+	spin_lock(&_ret->member);					\
+	_ret;								\
+})
+
+#define pcpu_spin_trylock(type, member, ptr)				\
+({									\
+	type *_ret;							\
+	pcpu_task_pin();						\
+	_ret = this_cpu_ptr(ptr);					\
+	if (!spin_trylock(&_ret->member)) {				\
+		pcpu_task_unpin();					\
+		_ret = NULL;						\
+	}								\
+	_ret;								\
+})
+
+#define pcpu_spin_unlock(member, ptr)					\
+({									\
+	spin_unlock(&ptr->member);					\
+	pcpu_task_unpin();						\
+})
+
+/* struct slub_percpu_array specific helpers. */
+#define pca_spin_lock(ptr)						\
+	pcpu_spin_lock(struct slub_percpu_array, lock, ptr)
+
+#define pca_spin_trylock(ptr)						\
+	pcpu_spin_trylock(struct slub_percpu_array, lock, ptr)
+
+#define pca_spin_unlock(ptr)						\
+	pcpu_spin_unlock(lock, ptr)
+
 #ifndef CONFIG_SLUB_TINY
 #define __fastpath_inline __always_inline
 #else
@@ -3440,6 +3513,32 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 			0, sizeof(void *));
 }
 
+static inline void *alloc_from_pca(struct kmem_cache *s)
+{
+	unsigned long __maybe_unused UP_flags;
+	struct slub_percpu_array *pca;
+	void *object = NULL;
+
+	pcp_trylock_prepare(UP_flags);
+	pca = pca_spin_trylock(s->cpu_array);
+
+	if (unlikely(!pca))
+		goto failed;
+
+	if (likely(pca->used > 0)) {
+		object = pca->objects[--pca->used];
+		pca_spin_unlock(pca);
+		pcp_trylock_finish(UP_flags);
+		stat(s, ALLOC_PERCPU_CACHE);
+		return object;
+	}
+	pca_spin_unlock(pca);
+
+failed:
+	pcp_trylock_finish(UP_flags);
+	return NULL;
+}
+
 /*
  * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
  * have the fastpath folded into their functions. So no function call
@@ -3465,7 +3564,11 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
+	if (s->cpu_array)
+		object = alloc_from_pca(s);
+
+	if (!object)
+		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
 
 	maybe_wipe_obj_freeptr(s, object);
 	init = slab_want_init_on_alloc(gfpflags, s);
@@ -3715,6 +3818,34 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	discard_slab(s, slab);
 }
 
+static inline bool free_to_pca(struct kmem_cache *s, void *object)
+{
+	unsigned long __maybe_unused UP_flags;
+	struct slub_percpu_array *pca;
+	bool ret = false;
+
+	pcp_trylock_prepare(UP_flags);
+	pca = pca_spin_trylock(s->cpu_array);
+
+	if (!pca) {
+		pcp_trylock_finish(UP_flags);
+		return false;
+	}
+
+	if (pca->used < pca->count) {
+		pca->objects[pca->used++] = object;
+		ret = true;
+	}
+
+	pca_spin_unlock(pca);
+	pcp_trylock_finish(UP_flags);
+
+	if (ret)
+		stat(s, FREE_PERCPU_CACHE);
+
+	return ret;
+}
+
 #ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
@@ -3740,6 +3871,11 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	unsigned long tid;
 	void **freelist;
 
+	if (s->cpu_array && cnt == 1) {
+		if (free_to_pca(s, head))
+			return;
+	}
+
 redo:
 	/*
 	 * Determine the currently cpus per cpu slab.
@@ -3793,6 +3929,11 @@ static void do_slab_free(struct kmem_cache *s,
 {
 	void *tail_obj = tail ? : head;
 
+	if (s->cpu_array && cnt == 1) {
+		if (free_to_pca(s, head))
+			return;
+	}
+
 	__slab_free(s, slab, head, tail_obj, cnt, addr);
 }
 #endif /* CONFIG_SLUB_TINY */
@@ -4060,6 +4201,45 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
+int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int count,
+		gfp_t gfp)
+{
+	struct slub_percpu_array *pca;
+	void *objects[32];
+	unsigned int used;
+	unsigned int allocated;
+
+	if (!s->cpu_array)
+		return -EINVAL;
+
+	/* racy but we don't care */
+	pca = raw_cpu_ptr(s->cpu_array);
+
+	used = READ_ONCE(pca->used);
+
+	if (used >= count)
+		return 0;
+
+	if (pca->count < count)
+		return -EINVAL;
+
+	count -= used;
+
+	/* TODO fix later */
+	if (count > 32)
+		count = 32;
+
+	for (int i = 0; i < count; i++)
+		objects[i] = NULL;
+	allocated = kmem_cache_alloc_bulk(s, gfp, count, &objects[0]);
+
+	for (int i = 0; i < count; i++) {
+		if (objects[i]) {
+			kmem_cache_free(s, objects[i]);
+		}
+	}
+	return allocated;
+}
 
 /*
  * Object placement in a slab is made very easy because we always start at
@@ -5131,6 +5311,30 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
+int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int count)
+{
+	int cpu;
+
+	if (WARN_ON_ONCE(!(s->flags & SLAB_NO_MERGE)))
+		return -EINVAL;
+
+	s->cpu_array = __alloc_percpu(struct_size(s->cpu_array, objects, count),
+					sizeof(void *));
+
+	if (!s->cpu_array)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct slub_percpu_array *pca = per_cpu_ptr(s->cpu_array, cpu);
+
+		spin_lock_init(&pca->lock);
+		pca->count = count;
+		pca->used = 0;
+	}
+
+	return 0;
+}
+
 #ifdef SLAB_SUPPORTS_SYSFS
 static int count_inuse(struct slab *slab)
 {
@@ -5908,8 +6112,10 @@ static ssize_t text##_store(struct kmem_cache *s,		\
 }								\
 SLAB_ATTR(text);						\
 
+STAT_ATTR(ALLOC_PERCPU_CACHE, alloc_cpu_cache);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
+STAT_ATTR(FREE_PERCPU_CACHE, free_cpu_cache);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_FROZEN, free_frozen);
@@ -5995,8 +6201,10 @@ static struct attribute *slab_attrs[] = {
 	&remote_node_defrag_ratio_attr.attr,
 #endif
 #ifdef CONFIG_SLUB_STATS
+	&alloc_cpu_cache_attr.attr,
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
+	&free_cpu_cache_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_frozen_attr.attr,
-- 
2.41.0

