Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B47AD4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjIYJmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjIYJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:42:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663AE116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:42:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CB5C433C7;
        Mon, 25 Sep 2023 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695634938;
        bh=WEhgtWnYg5+osMu0mMQWpk2i9+DgOX4tJ4oOQ1iLNEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S7/bwwDgQ7MoN8ll/gOT93LbakNrIw0biLIErkwbw5U9E6Zw4F8OCt8rJm4CIx1Ld
         jLJDhFyShwlAkTKWylthHfPQYQxu0NVhnsPhT+mMfTvBAHvuWuUKAXuEXgRZzPwhOn
         OVYrBMdhQtG2q0QzdPKnbhJ1M7zbuM297Im8DYYpbCcjjkD/XzYLONX/aXcVPxLVoJ
         Joaycd13SCERObhLpNv9h0C78muDNlCWDleelLzkPswt7stnePR1p+9P8ysl2OmmVy
         S8qGso4A1A+qxKDt/hBXp8YJ/YPunMIsj92l/ZhbFy7rF+//GX4//F7xLzBd4ho3Qe
         gNe69zPKU5p9A==
Date:   Mon, 25 Sep 2023 18:42:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v9 1/5] lib: objpool added: ring-array based lockless
 MPMC
Message-Id: <20230925184212.5a0b6c627a837b50424c4a75@kernel.org>
In-Reply-To: <20230905015255.81545-2-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
        <20230905015255.81545-2-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wuqiang,

On Tue,  5 Sep 2023 09:52:51 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> The object pool is a scalable implementaion of high performance queue
> for object allocation and reclamation, such as kretprobe instances.
> 
> With leveraging percpu ring-array to mitigate the hot spot of memory
> contention, it could deliver near-linear scalability for high parallel
> scenarios. The objpool is best suited for following cases:
> 1) Memory allocation or reclamation are prohibited or too expensive
> 2) Consumers are of different priorities, such as irqs and threads
> 
> Limitations:
> 1) Maximum objects (capacity) is determined during pool initializing
>    and can't be modified (extended) after objpool creation
> 2) The memory of objects won't be freed until objpool is finalized
> 3) Object allocation (pop) may fail after trying all cpu slots

I made a simplifying patch on this by (mainly) removing ages array.
I also rename local variable to use more readable names, like slot,
pool, and obj.

Here the results which I run the test_objpool.ko.

Original:
[   50.500235] Summary of testcases:
[   50.503139]     duration: 1027135us 	hits:   30628293 	miss:          0 	sync: percpu objpool
[   50.510416]     duration: 1047977us 	hits:   30453023 	miss:          0 	sync: percpu objpool from vmalloc
[   50.517421]     duration: 1047098us 	hits:   31145034 	miss:          0 	sync & hrtimer: percpu objpool
[   50.524671]     duration: 1053233us 	hits:   30919640 	miss:          0 	sync & hrtimer: percpu objpool from vmalloc
[   50.531382]     duration: 1055822us 	hits:    3407221 	miss:     830219 	sync overrun: percpu objpool
[   50.538135]     duration: 1055998us 	hits:    3404624 	miss:     854160 	sync overrun: percpu objpool from vmalloc
[   50.546686]     duration: 1046104us 	hits:   19464798 	miss:          0 	async: percpu objpool
[   50.552989]     duration: 1033054us 	hits:   18957836 	miss:          0 	async: percpu objpool from vmalloc
[   50.560289]     duration: 1041778us 	hits:   33806868 	miss:          0 	async & hrtimer: percpu objpool
[   50.567425]     duration: 1048901us 	hits:   34211860 	miss:          0 	async & hrtimer: percpu objpool from vmalloc

Simplified:
[   48.393236] Summary of testcases:
[   48.395384]     duration: 1013002us 	hits:   29661448 	miss:          0 	sync: percpu objpool
[   48.400351]     duration: 1057231us 	hits:   31035578 	miss:          0 	sync: percpu objpool from vmalloc
[   48.405660]     duration: 1043196us 	hits:   30546652 	miss:          0 	sync & hrtimer: percpu objpool
[   48.411216]     duration: 1047128us 	hits:   30601306 	miss:          0 	sync & hrtimer: percpu objpool from vmalloc
[   48.417231]     duration: 1051695us 	hits:    3468287 	miss:     892881 	sync overrun: percpu objpool
[   48.422405]     duration: 1054003us 	hits:    3549491 	miss:     898141 	sync overrun: percpu objpool from vmalloc
[   48.428425]     duration: 1052946us 	hits:   19005228 	miss:          0 	async: percpu objpool
[   48.433597]     duration: 1051757us 	hits:   19670866 	miss:          0 	async: percpu objpool from vmalloc
[   48.439280]     duration: 1042951us 	hits:   37135332 	miss:          0 	async & hrtimer: percpu objpool
[   48.445085]     duration: 1029803us 	hits:   37093248 	miss:          0 	async & hrtimer: percpu objpool from vmalloc

Can you test it too?

Thanks,

From f1f442ff653e329839e5452b8b88463a80a12ff3 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 25 Sep 2023 16:07:12 +0900
Subject: [PATCH] objpool: Simplify objpool by removing ages array

Simplify the objpool code by removing ages array from per-cpu slot.
It chooses enough big capacity (which is a rounded up power of 2 value
of nr_objects + 1) for the entries array, the tail never catch up to
the head in per-cpu slot. Thus tail == head means the slot is empty.

This also uses consistent local variable names for pool, slot and obj.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/objpool.h |  61 ++++----
 lib/objpool.c           | 310 ++++++++++++++++------------------------
 2 files changed, 147 insertions(+), 224 deletions(-)

diff --git a/include/linux/objpool.h b/include/linux/objpool.h
index 33c832216b98..ecd5ecaffcd3 100644
--- a/include/linux/objpool.h
+++ b/include/linux/objpool.h
@@ -38,33 +38,23 @@
  * struct objpool_slot - percpu ring array of objpool
  * @head: head of the local ring array (to retrieve at)
  * @tail: tail of the local ring array (to append at)
- * @bits: log2 of capacity (for bitwise operations)
- * @mask: capacity - 1
+ * @mask: capacity of entries - 1
+ * @entries: object entries on this slot.
  *
  * Represents a cpu-local array-based ring buffer, its size is specialized
  * during initialization of object pool. The percpu objpool slot is to be
  * allocated from local memory for NUMA system, and to be kept compact in
- * continuous memory: ages[] is stored just after the body of objpool_slot,
- * and then entries[]. ages[] describes revision of each item, solely used
- * to avoid ABA; entries[] contains pointers of the actual objects
- *
- * Layout of objpool_slot in memory:
- *
- * 64bit:
- *        4      8      12     16        32                 64
- * | head | tail | bits | mask | ages[4] | ents[4]: (8 * 4) | objects
- *
- * 32bit:
- *        4      8      12     16        32        48       64
- * | head | tail | bits | mask | ages[4] | ents[4] | unused | objects
+ * continuous memory: CPU assigned number of objects are stored just after
+ * the body of objpool_slot.
  *
  */
 struct objpool_slot {
-	uint32_t                head;
-	uint32_t                tail;
-	uint32_t                bits;
-	uint32_t                mask;
-} __packed;
+	uint32_t	head;
+	uint32_t	tail;
+	uint32_t	mask;
+	uint32_t	dummyr;
+	void *		entries[];
+};
 
 struct objpool_head;
 
@@ -82,12 +72,11 @@ typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
  * @obj_size:   object & element size
  * @nr_objs:    total objs (to be pre-allocated)
  * @nr_cpus:    nr_cpu_ids
- * @capacity:   max objects per cpuslot
+ * @capacity:   max objects on percpu slot
  * @gfp:        gfp flags for kmalloc & vmalloc
  * @ref:        refcount for objpool
  * @flags:      flags for objpool management
  * @cpu_slots:  array of percpu slots
- * @slot_sizes:	size in bytes of slots
  * @release:    resource cleanup callback
  * @context:    caller-provided context
  */
@@ -100,7 +89,6 @@ struct objpool_head {
 	refcount_t              ref;
 	unsigned long           flags;
 	struct objpool_slot   **cpu_slots;
-	int                    *slot_sizes;
 	objpool_fini_cb         release;
 	void                   *context;
 };
@@ -108,9 +96,12 @@ struct objpool_head {
 #define OBJPOOL_FROM_VMALLOC	(0x800000000)	/* objpool allocated from vmalloc area */
 #define OBJPOOL_HAVE_OBJECTS	(0x400000000)	/* objects allocated along with objpool */
 
+#define OBJPOOL_NR_OBJECT_MAX	(1 << 24)
+#define OBJPOOL_OBJECT_SIZE_MAX	(1 << 16)
+
 /**
  * objpool_init() - initialize objpool and pre-allocated objects
- * @head:    the object pool to be initialized, declared by caller
+ * @pool:    the object pool to be initialized, declared by caller
  * @nr_objs: total objects to be pre-allocated by this object pool
  * @object_size: size of an object (should be > 0)
  * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
@@ -128,47 +119,47 @@ struct objpool_head {
  * pop (object allocation) or do clearance before each push (object
  * reclamation).
  */
-int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
+int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
 		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
 		 objpool_fini_cb release);
 
 /**
  * objpool_pop() - allocate an object from objpool
- * @head: object pool
+ * @pool: object pool
  *
  * return value: object ptr or NULL if failed
  */
-void *objpool_pop(struct objpool_head *head);
+void *objpool_pop(struct objpool_head *pool);
 
 /**
  * objpool_push() - reclaim the object and return back to objpool
  * @obj:  object ptr to be pushed to objpool
- * @head: object pool
+ * @pool: object pool
  *
  * return: 0 or error code (it fails only when user tries to push
  * the same object multiple times or wrong "objects" into objpool)
  */
-int objpool_push(void *obj, struct objpool_head *head);
+int objpool_push(void *obj, struct objpool_head *pool);
 
 /**
  * objpool_drop() - discard the object and deref objpool
  * @obj:  object ptr to be discarded
- * @head: object pool
+ * @pool: object pool
  *
  * return: 0 if objpool was released or error code
  */
-int objpool_drop(void *obj, struct objpool_head *head);
+int objpool_drop(void *obj, struct objpool_head *pool);
 
 /**
  * objpool_free() - release objpool forcely (all objects to be freed)
- * @head: object pool to be released
+ * @pool: object pool to be released
  */
-void objpool_free(struct objpool_head *head);
+void objpool_free(struct objpool_head *pool);
 
 /**
  * objpool_fini() - deref object pool (also releasing unused objects)
- * @head: object pool to be dereferenced
+ * @pool: object pool to be dereferenced
  */
-void objpool_fini(struct objpool_head *head);
+void objpool_fini(struct objpool_head *pool);
 
 #endif /* _LINUX_OBJPOOL_H */
diff --git a/lib/objpool.c b/lib/objpool.c
index 22e752371820..f8e8f70d7253 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -15,104 +15,55 @@
  * Copyright: wuqiang.matt@bytedance.com
  */
 
-#define SLOT_AGES(s) ((uint32_t *)((char *)(s) + sizeof(struct objpool_slot)))
-#define SLOT_ENTS(s) ((void **)((char *)(s) + sizeof(struct objpool_slot) + \
-			(sizeof(uint32_t) << (s)->bits)))
-#define SLOT_OBJS(s) ((void *)((char *)(s) + sizeof(struct objpool_slot) + \
-			((sizeof(uint32_t) + sizeof(void *)) << (s)->bits)))
-#define SLOT_CORE(n) cpumask_nth((n) % num_possible_cpus(), cpu_possible_mask)
-
-/* compute the suitable num of objects to be managed per slot */
-static int objpool_nobjs(int size)
-{
-	return rounddown_pow_of_two((size - sizeof(struct objpool_slot)) /
-			(sizeof(uint32_t) + sizeof(void *)));
-}
-
 /* allocate and initialize percpu slots */
 static int
-objpool_init_percpu_slots(struct objpool_head *head, int nobjs,
-			void *context, objpool_init_obj_cb objinit)
+objpool_init_percpu_slots(struct objpool_head *pool, void *context,
+			  objpool_init_obj_cb objinit)
 {
-	int i, j, n, size, objsz, cpu = 0, nents = head->capacity;
-
-	/* aligned object size by sizeof(void *) */
-	objsz = ALIGN(head->obj_size, sizeof(void *));
-	/* shall we allocate objects along with percpu-slot */
-	if (objsz)
-		head->flags |= OBJPOOL_HAVE_OBJECTS;
-
-	/* vmalloc is used in default to allocate percpu-slots */
-	if (!(head->gfp & GFP_ATOMIC))
-		head->flags |= OBJPOOL_FROM_VMALLOC;
-
-	for (i = 0; i < head->nr_cpus; i++) {
-		struct objpool_slot *os;
+	int i, j, n, size, slot_size, cpu_count = 0;
+	struct objpool_slot *slot;
 
+	for (i = 0; i < pool->nr_cpus; i++) {
 		/* skip the cpus which could never be present */
 		if (!cpu_possible(i))
 			continue;
 
 		/* compute how many objects to be managed by this slot */
-		n = nobjs / num_possible_cpus();
-		if (cpu < (nobjs % num_possible_cpus()))
+		n = pool->nr_objs / num_possible_cpus();
+		if (cpu_count < (pool->nr_objs % num_possible_cpus()))
 			n++;
-		size = sizeof(struct objpool_slot) + sizeof(void *) * nents +
-		       sizeof(uint32_t) * nents + objsz * n;
+		cpu_count++;
+
+		slot_size = struct_size(slot, entries, pool->capacity);
+		size = slot_size + pool->obj_size * n;
 
 		/*
 		 * here we allocate percpu-slot & objects together in a single
-		 * allocation, taking advantage of warm caches and TLB hits as
-		 * vmalloc always aligns the request size to pages
+		 * allocation, taking advantage on NUMA.
 		 */
-		if (head->flags & OBJPOOL_FROM_VMALLOC)
-			os = __vmalloc_node(size, sizeof(void *), head->gfp,
+		if (pool->flags & OBJPOOL_FROM_VMALLOC)
+			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
 				cpu_to_node(i), __builtin_return_address(0));
 		else
-			os = kmalloc_node(size, head->gfp, cpu_to_node(i));
-		if (!os)
+			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
+		if (!slot)
 			return -ENOMEM;
 
 		/* initialize percpu slot for the i-th slot */
-		memset(os, 0, size);
-		os->bits = ilog2(head->capacity);
-		os->mask = head->capacity - 1;
-		head->cpu_slots[i] = os;
-		head->slot_sizes[i] = size;
-		cpu = cpu + 1;
-
-		/*
-		 * manually set head & tail to avoid possible conflict:
-		 * We assume that the head item is ready for retrieval
-		 * iff head is equal to ages[head & mask]. but ages is
-		 * initialized as 0, so in view of the caller of pop(),
-		 * the 1st item (0th) is always ready, but the reality
-		 * could be: push() is stalled before the final update,
-		 * thus the item being inserted will be lost forever
-		 */
-		os->head = os->tail = head->capacity;
-
-		if (!objsz)
-			continue;
+		memset(slot, 0, size);
+		slot->mask = pool->capacity - 1;
+		pool->cpu_slots[i] = slot;
 
 		for (j = 0; j < n; j++) {
-			uint32_t *ages = SLOT_AGES(os);
-			void **ents = SLOT_ENTS(os);
-			void *obj = SLOT_OBJS(os) + j * objsz;
-			uint32_t ie = os->tail & os->mask;
+			void *obj = (void *)slot + slot_size + pool->obj_size * j;
 
-			/* perform object initialization */
 			if (objinit) {
 				int rc = objinit(obj, context);
 				if (rc)
 					return rc;
 			}
-
-			/* add obj into the ring array */
-			ents[ie] = obj;
-			ages[ie] = os->tail;
-			os->tail++;
-			head->nr_objs++;
+			slot->entries[j] = obj;
+			slot->tail++;
 		}
 	}
 
@@ -120,164 +71,135 @@ objpool_init_percpu_slots(struct objpool_head *head, int nobjs,
 }
 
 /* cleanup all percpu slots of the object pool */
-static void objpool_fini_percpu_slots(struct objpool_head *head)
+static void objpool_fini_percpu_slots(struct objpool_head *pool)
 {
 	int i;
 
-	if (!head->cpu_slots)
+	if (!pool->cpu_slots)
 		return;
 
-	for (i = 0; i < head->nr_cpus; i++) {
-		if (!head->cpu_slots[i])
-			continue;
-		if (head->flags & OBJPOOL_FROM_VMALLOC)
-			vfree(head->cpu_slots[i]);
-		else
-			kfree(head->cpu_slots[i]);
-	}
-	kfree(head->cpu_slots);
-	head->cpu_slots = NULL;
-	head->slot_sizes = NULL;
+	for (i = 0; i < pool->nr_cpus; i++)
+		kvfree(pool->cpu_slots[i]);
+	kfree(pool->cpu_slots);
 }
 
 /* initialize object pool and pre-allocate objects */
-int objpool_init(struct objpool_head *head, int nr_objs, int object_size,
+int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
 		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
 		objpool_fini_cb release)
 {
 	int nents, rc;
 
 	/* check input parameters */
-	if (nr_objs <= 0 || object_size <= 0)
+	if (nr_objs <= 0 || object_size <= 0 ||
+	    nr_objs > OBJPOOL_NR_OBJECT_MAX || object_size > OBJPOOL_OBJECT_SIZE_MAX)
+		return -EINVAL;
+
+	/* Align up to unsigned long size */
+	object_size = ALIGN(object_size, sizeof(unsigned long));
+
+	/*
+	 * To avoid filling up the entries array in the per-cpu slot,
+	 * use the power of 2 which is more than N + 1. Thus, the tail never
+	 * catch up to the pool, and able to use pool/tail as the sequencial
+	 * number.
+	 */
+	nents = roundup_pow_of_two(nr_objs + 1);
+	if (!nents)
 		return -EINVAL;
 
-	/* calculate percpu slot size (rounded to pow of 2) */
-	nents = max_t(int, roundup_pow_of_two(nr_objs),
-			objpool_nobjs(L1_CACHE_BYTES));
-
-	/* initialize objpool head */
-	memset(head, 0, sizeof(struct objpool_head));
-	head->nr_cpus = nr_cpu_ids;
-	head->obj_size = object_size;
-	head->capacity = nents;
-	head->gfp = gfp & ~__GFP_ZERO;
-	head->context = context;
-	head->release = release;
-
-	/* allocate array for percpu slots */
-	head->cpu_slots = kzalloc(head->nr_cpus * sizeof(void *) +
-			       head->nr_cpus * sizeof(int), head->gfp);
-	if (!head->cpu_slots)
+	/* initialize objpool pool */
+	memset(pool, 0, sizeof(struct objpool_head));
+	pool->nr_cpus = nr_cpu_ids;
+	pool->obj_size = object_size;
+	pool->nr_objs = nr_objs;
+	/* just prevent to fullfill the per-cpu ring array */
+	pool->capacity = nents;
+	pool->gfp = gfp & ~__GFP_ZERO;
+	pool->context = context;
+	pool->release = release;
+	/* vmalloc is used in default to allocate percpu-slots */
+	if (!(pool->gfp & GFP_ATOMIC))
+		pool->flags |= OBJPOOL_FROM_VMALLOC;
+
+	pool->cpu_slots = kzalloc(pool->nr_cpus * sizeof(void *), pool->gfp);
+	if (!pool->cpu_slots)
 		return -ENOMEM;
-	head->slot_sizes = (int *)&head->cpu_slots[head->nr_cpus];
 
 	/* initialize per-cpu slots */
-	rc = objpool_init_percpu_slots(head, nr_objs, context, objinit);
+	rc = objpool_init_percpu_slots(pool, context, objinit);
 	if (rc)
-		objpool_fini_percpu_slots(head);
+		objpool_fini_percpu_slots(pool);
 	else
-		refcount_set(&head->ref, nr_objs + 1);
+		refcount_set(&pool->ref, nr_objs + 1);
 
 	return rc;
 }
 EXPORT_SYMBOL_GPL(objpool_init);
 
 /* adding object to slot, abort if the slot was already full */
-static inline int objpool_try_add_slot(void *obj, struct objpool_slot *os)
+static inline int objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
 {
-	uint32_t *ages = SLOT_AGES(os);
-	void **ents = SLOT_ENTS(os);
-	uint32_t head, tail;
+	struct objpool_slot *slot = pool->cpu_slots[cpu];
+	uint32_t tail, next;
 
 	do {
-		/* perform memory loading for both head and tail */
-		head = READ_ONCE(os->head);
-		tail = READ_ONCE(os->tail);
-		/* just abort if slot is full */
-		if (tail - head > os->mask)
-			return -ENOENT;
-		/* try to extend tail by 1 using CAS to avoid races */
-		if (try_cmpxchg_acquire(&os->tail, &tail, tail + 1))
-			break;
-	} while (1);
+		uint32_t head = READ_ONCE(slot->head);
 
-	/* the tail-th of slot is reserved for the given obj */
-	WRITE_ONCE(ents[tail & os->mask], obj);
-	/* update epoch id to make this object available for pop() */
-	smp_store_release(&ages[tail & os->mask], tail);
+		tail = READ_ONCE(slot->tail);
+		next = tail + 1;
+
+		/* This must never happen because capacity >= N + 1 */
+		if (WARN_ON_ONCE((next > head && next - head > pool->nr_objs) ||
+				 (next < head && next > head + pool->nr_objs)))
+			return -EINVAL;
+
+	} while (!try_cmpxchg_acquire(&slot->tail, &tail, next));
+
+	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
 	return 0;
 }
 
 /* reclaim an object to object pool */
-int objpool_push(void *obj, struct objpool_head *oh)
+int objpool_push(void *obj, struct objpool_head *pool)
 {
 	unsigned long flags;
-	int cpu, rc;
+	int rc;
 
 	/* disable local irq to avoid preemption & interruption */
 	raw_local_irq_save(flags);
-	cpu = raw_smp_processor_id();
-	do {
-		rc = objpool_try_add_slot(obj, oh->cpu_slots[cpu]);
-		if (!rc)
-			break;
-		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
-	} while (1);
+	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
 	raw_local_irq_restore(flags);
 
 	return rc;
 }
 EXPORT_SYMBOL_GPL(objpool_push);
 
-/* drop the allocated object, rather reclaim it to objpool */
-int objpool_drop(void *obj, struct objpool_head *head)
-{
-	if (!obj || !head)
-		return -EINVAL;
-
-	if (refcount_dec_and_test(&head->ref)) {
-		objpool_free(head);
-		return 0;
-	}
-
-	return -EAGAIN;
-}
-EXPORT_SYMBOL_GPL(objpool_drop);
-
 /* try to retrieve object from slot */
-static inline void *objpool_try_get_slot(struct objpool_slot *os)
+static inline void *objpool_try_get_slot(struct objpool_slot *slot)
 {
-	uint32_t *ages = SLOT_AGES(os);
-	void **ents = SLOT_ENTS(os);
 	/* do memory load of head to local head */
-	uint32_t head = smp_load_acquire(&os->head);
+	uint32_t head = smp_load_acquire(&slot->head);
 
 	/* loop if slot isn't empty */
-	while (head != READ_ONCE(os->tail)) {
-		uint32_t id = head & os->mask, prev = head;
+	while (head != READ_ONCE(slot->tail)) {
 
 		/* do prefetching of object ents */
-		prefetch(&ents[id]);
-
-		/* check whether this item was ready for retrieval */
-		if (smp_load_acquire(&ages[id]) == head) {
-			/* node must have been udpated by push() */
-			void *node = READ_ONCE(ents[id]);
-			/* commit and move forward head of the slot */
-			if (try_cmpxchg_release(&os->head, &head, head + 1))
-				return node;
-			/* head was already updated by others */
-		}
+		prefetch(&slot->entries[head & slot->mask]);
+
+		/* commit and move forward head of the slot */
+		if (try_cmpxchg_release(&slot->head, &head, head + 1))
+			/*
+			 * TBD: check overwrap the tail/head counter and warn
+			 * if it is broken. But this happens only if this
+			 * process slows down a lot and another CPU updates
+			 * the haed/tail just 2^32 + 1 times, and this slot
+			 * is empty.
+			 */
+			return slot->entries[head & slot->mask];
 
 		/* re-load head from memory and continue trying */
-		head = READ_ONCE(os->head);
-		/*
-		 * head stays unchanged, so it's very likely there's an
-		 * ongoing push() on other cpu nodes but yet not update
-		 * ages[] to mark it's completion
-		 */
-		if (head == prev)
-			break;
+		head = READ_ONCE(slot->head);
 	}
 
 	return NULL;
@@ -307,32 +229,42 @@ void *objpool_pop(struct objpool_head *head)
 EXPORT_SYMBOL_GPL(objpool_pop);
 
 /* release whole objpool forcely */
-void objpool_free(struct objpool_head *head)
+void objpool_free(struct objpool_head *pool)
 {
-	if (!head->cpu_slots)
+	if (!pool->cpu_slots)
 		return;
 
 	/* release percpu slots */
-	objpool_fini_percpu_slots(head);
+	objpool_fini_percpu_slots(pool);
 
 	/* call user's cleanup callback if provided */
-	if (head->release)
-		head->release(head, head->context);
+	if (pool->release)
+		pool->release(pool, pool->context);
 }
 EXPORT_SYMBOL_GPL(objpool_free);
 
-/* drop unused objects and defref objpool for releasing */
-void objpool_fini(struct objpool_head *head)
+/* drop the allocated object, rather reclaim it to objpool */
+int objpool_drop(void *obj, struct objpool_head *pool)
 {
-	void *nod;
+	if (!obj || !pool)
+		return -EINVAL;
 
-	do {
-		/* grab object from objpool and drop it */
-		nod = objpool_pop(head);
+	if (refcount_dec_and_test(&pool->ref)) {
+		objpool_free(pool);
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+EXPORT_SYMBOL_GPL(objpool_drop);
+
+/* drop unused objects and defref objpool for releasing */
+void objpool_fini(struct objpool_head *pool)
+{
+	void *obj;
 
-		/* drop the extra ref of objpool */
-		if (refcount_dec_and_test(&head->ref))
-			objpool_free(head);
-	} while (nod);
+	/* grab object from objpool and drop it */
+	while ((obj = objpool_pop(pool)))
+		objpool_drop(obj, pool);
 }
 EXPORT_SYMBOL_GPL(objpool_fini);
-- 
2.34.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
