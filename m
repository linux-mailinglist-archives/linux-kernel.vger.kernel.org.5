Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09FB806E41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377777AbjLFLoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLFLoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:44:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B0E8F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:44:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF876C433C8;
        Wed,  6 Dec 2023 11:44:16 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hdanton@sina.com,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] kmemleak: Avoid RCU stalls when freeing metadata for per-CPU pointers
Date:   Wed,  6 Dec 2023 11:44:14 +0000
Message-Id: <20231206114414.2085824-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with large number of CPUs, the following soft lockup splat
might sometimes happen:

[ 2656.001617] watchdog: BUG: soft lockup - CPU#364 stuck for 21s! [ksoftirqd/364:2206]
  :
[ 2656.141194] RIP: 0010:_raw_spin_unlock_irqrestore+0x3d/0x70
  :
 2656.241214] Call Trace:
[ 2656.243971]  <IRQ>
[ 2656.246237]  ? show_trace_log_lvl+0x1c4/0x2df
[ 2656.251152]  ? show_trace_log_lvl+0x1c4/0x2df
[ 2656.256066]  ? kmemleak_free_percpu+0x11f/0x1f0
[ 2656.261173]  ? watchdog_timer_fn+0x379/0x470
[ 2656.265984]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 2656.271179]  ? __hrtimer_run_queues+0x5f3/0xd00
[ 2656.276283]  ? __pfx___hrtimer_run_queues+0x10/0x10
[ 2656.281783]  ? ktime_get_update_offsets_now+0x95/0x2c0
[ 2656.287573]  ? ktime_get_update_offsets_now+0xdd/0x2c0
[ 2656.293380]  ? hrtimer_interrupt+0x2e9/0x780
[ 2656.298221]  ? __sysvec_apic_timer_interrupt+0x184/0x640
[ 2656.304211]  ? sysvec_apic_timer_interrupt+0x8e/0xc0
[ 2656.309807]  </IRQ>
[ 2656.312169]  <TASK>
[ 2656.326110]  kmemleak_free_percpu+0x11f/0x1f0
[ 2656.331015]  free_percpu.part.0+0x1b/0xe70
[ 2656.335635]  free_vfsmnt+0xb9/0x100
[ 2656.339567]  rcu_do_batch+0x3c8/0xe30
[ 2656.363693]  rcu_core+0x3de/0x5a0
[ 2656.367433]  __do_softirq+0x2d0/0x9a8
[ 2656.381119]  run_ksoftirqd+0x36/0x60
[ 2656.385145]  smpboot_thread_fn+0x556/0x910
[ 2656.394971]  kthread+0x2a4/0x350
[ 2656.402826]  ret_from_fork+0x29/0x50
[ 2656.406861]  </TASK>

The issue is caused by kmemleak registering each per_cpu_ptr()
corresponding to the __percpu pointer. This is unnecessary since such
individual per-CPU pointers are not tracked anyway. Create a new
object_percpu_tree_root rbtree that stores a single __percpu pointer
together with an OBJECT_PERCPU flag for the kmemleak metadata. Scanning
needs to be done for all per_cpu_ptr() pointers with a cond_resched()
between each CPU iteration to avoid RCU stalls.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Waiman Long <longman@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20231127194153.289626-1-longman@redhat.com
Cc: Andrew Morton <akpm@linux-foundation.org>
---

Changes in v2: updated the comment to include the *_percpu() callbacks, not
just the *_phys().

 mm/kmemleak.c | 178 +++++++++++++++++++++++++++-----------------------
 1 file changed, 97 insertions(+), 81 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eacca03bedd..6664da4f409f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -14,17 +14,15 @@
  * The following locks and mutexes are used by kmemleak:
  *
  * - kmemleak_lock (raw_spinlock_t): protects the object_list as well as
- *   del_state modifications and accesses to the object_tree_root (or
- *   object_phys_tree_root). The object_list is the main list holding the
- *   metadata (struct kmemleak_object) for the allocated memory blocks.
- *   The object_tree_root and object_phys_tree_root are red
- *   black trees used to look-up metadata based on a pointer to the
- *   corresponding memory block. The object_phys_tree_root is for objects
- *   allocated with physical address. The kmemleak_object structures are
- *   added to the object_list and object_tree_root (or object_phys_tree_root)
- *   in the create_object() function called from the kmemleak_alloc() (or
- *   kmemleak_alloc_phys()) callback and removed in delete_object() called from
- *   the kmemleak_free() callback
+ *   del_state modifications and accesses to the object trees
+ *   (object_tree_root, object_phys_tree_root, object_percpu_tree_root). The
+ *   object_list is the main list holding the metadata (struct
+ *   kmemleak_object) for the allocated memory blocks. The object trees are
+ *   red black trees used to look-up metadata based on a pointer to the
+ *   corresponding memory block. The kmemleak_object structures are added to
+ *   the object_list and the object tree root in the create_object() function
+ *   called from the kmemleak_alloc{,_phys,_percpu}() callback and removed in
+ *   delete_object() called from the kmemleak_free{,_phys,_percpu}() callback
  * - kmemleak_object.lock (raw_spinlock_t): protects a kmemleak_object.
  *   Accesses to the metadata (e.g. count) are protected by this lock. Note
  *   that some members of this structure may be protected by other means
@@ -178,6 +176,8 @@ struct kmemleak_object {
 #define OBJECT_FULL_SCAN	(1 << 3)
 /* flag set for object allocated with physical address */
 #define OBJECT_PHYS		(1 << 4)
+/* flag set for per-CPU pointers */
+#define OBJECT_PERCPU		(1 << 5)
 
 /* set when __remove_object() called */
 #define DELSTATE_REMOVED	(1 << 0)
@@ -206,6 +206,8 @@ static LIST_HEAD(mem_pool_free_list);
 static struct rb_root object_tree_root = RB_ROOT;
 /* search tree for object (with OBJECT_PHYS flag) boundaries */
 static struct rb_root object_phys_tree_root = RB_ROOT;
+/* search tree for object (with OBJECT_PERCPU flag) boundaries */
+static struct rb_root object_percpu_tree_root = RB_ROOT;
 /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
 static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
@@ -298,7 +300,7 @@ static void hex_dump_object(struct seq_file *seq,
 	const u8 *ptr = (const u8 *)object->pointer;
 	size_t len;
 
-	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
+	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
 		return;
 
 	/* limit the number of lines to HEX_MAX_LINES */
@@ -392,6 +394,15 @@ static void dump_object_info(struct kmemleak_object *object)
 		stack_depot_print(object->trace_handle);
 }
 
+static struct rb_root *object_tree(unsigned long objflags)
+{
+	if (objflags & OBJECT_PHYS)
+		return &object_phys_tree_root;
+	if (objflags & OBJECT_PERCPU)
+		return &object_percpu_tree_root;
+	return &object_tree_root;
+}
+
 /*
  * Look-up a memory block metadata (kmemleak_object) in the object search
  * tree based on a pointer value. If alias is 0, only values pointing to the
@@ -399,10 +410,9 @@ static void dump_object_info(struct kmemleak_object *object)
  * when calling this function.
  */
 static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
-					       bool is_phys)
+					       unsigned int objflags)
 {
-	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
-			     object_tree_root.rb_node;
+	struct rb_node *rb = object_tree(objflags)->rb_node;
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
 	while (rb) {
@@ -431,7 +441,7 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 /* Look-up a kmemleak object which allocated with virtual address. */
 static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
 {
-	return __lookup_object(ptr, alias, false);
+	return __lookup_object(ptr, alias, 0);
 }
 
 /*
@@ -544,14 +554,14 @@ static void put_object(struct kmemleak_object *object)
  * Look up an object in the object search tree and increase its use_count.
  */
 static struct kmemleak_object *__find_and_get_object(unsigned long ptr, int alias,
-						     bool is_phys)
+						     unsigned int objflags)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
 	rcu_read_lock();
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = __lookup_object(ptr, alias, is_phys);
+	object = __lookup_object(ptr, alias, objflags);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	/* check whether the object is still available */
@@ -565,19 +575,16 @@ static struct kmemleak_object *__find_and_get_object(unsigned long ptr, int alia
 /* Look up and get an object which allocated with virtual address. */
 static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 {
-	return __find_and_get_object(ptr, alias, false);
+	return __find_and_get_object(ptr, alias, 0);
 }
 
 /*
- * Remove an object from the object_tree_root (or object_phys_tree_root)
- * and object_list. Must be called with the kmemleak_lock held _if_ kmemleak
- * is still enabled.
+ * Remove an object from its object tree and object_list. Must be called with
+ * the kmemleak_lock held _if_ kmemleak is still enabled.
  */
 static void __remove_object(struct kmemleak_object *object)
 {
-	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
-				   &object_phys_tree_root :
-				   &object_tree_root);
+	rb_erase(&object->rb_node, object_tree(object->flags));
 	if (!(object->del_state & DELSTATE_NO_DELETE))
 		list_del_rcu(&object->object_list);
 	object->del_state |= DELSTATE_REMOVED;
@@ -585,11 +592,11 @@ static void __remove_object(struct kmemleak_object *object)
 
 static struct kmemleak_object *__find_and_remove_object(unsigned long ptr,
 							int alias,
-							bool is_phys)
+							unsigned int objflags)
 {
 	struct kmemleak_object *object;
 
-	object = __lookup_object(ptr, alias, is_phys);
+	object = __lookup_object(ptr, alias, objflags);
 	if (object)
 		__remove_object(object);
 
@@ -597,19 +604,18 @@ static struct kmemleak_object *__find_and_remove_object(unsigned long ptr,
 }
 
 /*
- * Look up an object in the object search tree and remove it from both
- * object_tree_root (or object_phys_tree_root) and object_list. The
- * returned object's use_count should be at least 1, as initially set
- * by create_object().
+ * Look up an object in the object search tree and remove it from both object
+ * tree root and object_list. The returned object's use_count should be at
+ * least 1, as initially set by create_object().
  */
 static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int alias,
-						      bool is_phys)
+						      unsigned int objflags)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = __find_and_remove_object(ptr, alias, is_phys);
+	object = __find_and_remove_object(ptr, alias, objflags);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
@@ -648,7 +654,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 }
 
 static int __link_object(struct kmemleak_object *object, unsigned long ptr,
-			 size_t size, int min_count, bool is_phys)
+			 size_t size, int min_count, unsigned int objflags)
 {
 
 	struct kmemleak_object *parent;
@@ -661,7 +667,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
-	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
+	object->flags = OBJECT_ALLOCATED | objflags;
 	object->pointer = ptr;
 	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
@@ -697,12 +703,11 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 	 * Only update min_addr and max_addr with object
 	 * storing virtual address.
 	 */
-	if (!is_phys) {
+	if (!(objflags & (OBJECT_PHYS | OBJECT_PERCPU))) {
 		min_addr = min(min_addr, untagged_ptr);
 		max_addr = max(max_addr, untagged_ptr + size);
 	}
-	link = is_phys ? &object_phys_tree_root.rb_node :
-		&object_tree_root.rb_node;
+	link = &object_tree(objflags)->rb_node;
 	rb_parent = NULL;
 	while (*link) {
 		rb_parent = *link;
@@ -724,8 +729,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 		}
 	}
 	rb_link_node(&object->rb_node, rb_parent, link);
-	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
-					  &object_tree_root);
+	rb_insert_color(&object->rb_node, object_tree(objflags));
 	list_add_tail_rcu(&object->object_list, &object_list);
 
 	return 0;
@@ -733,11 +737,10 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 
 /*
  * Create the metadata (struct kmemleak_object) corresponding to an allocated
- * memory block and add it to the object_list and object_tree_root (or
- * object_phys_tree_root).
+ * memory block and add it to the object_list and object tree.
  */
 static void __create_object(unsigned long ptr, size_t size,
-				int min_count, gfp_t gfp, bool is_phys)
+				int min_count, gfp_t gfp, unsigned int objflags)
 {
 	struct kmemleak_object *object;
 	unsigned long flags;
@@ -748,7 +751,7 @@ static void __create_object(unsigned long ptr, size_t size,
 		return;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	ret = __link_object(object, ptr, size, min_count, is_phys);
+	ret = __link_object(object, ptr, size, min_count, objflags);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 	if (ret)
 		mem_pool_free(object);
@@ -758,14 +761,21 @@ static void __create_object(unsigned long ptr, size_t size,
 static void create_object(unsigned long ptr, size_t size,
 			  int min_count, gfp_t gfp)
 {
-	__create_object(ptr, size, min_count, gfp, false);
+	__create_object(ptr, size, min_count, gfp, 0);
 }
 
 /* Create kmemleak object which allocated with physical address. */
 static void create_object_phys(unsigned long ptr, size_t size,
 			       int min_count, gfp_t gfp)
 {
-	__create_object(ptr, size, min_count, gfp, true);
+	__create_object(ptr, size, min_count, gfp, OBJECT_PHYS);
+}
+
+/* Create kmemleak object corresponding to a per-CPU allocation. */
+static void create_object_percpu(unsigned long ptr, size_t size,
+				 int min_count, gfp_t gfp)
+{
+	__create_object(ptr, size, min_count, gfp, OBJECT_PERCPU);
 }
 
 /*
@@ -792,11 +802,11 @@ static void __delete_object(struct kmemleak_object *object)
  * Look up the metadata (struct kmemleak_object) corresponding to ptr and
  * delete it.
  */
-static void delete_object_full(unsigned long ptr)
+static void delete_object_full(unsigned long ptr, unsigned int objflags)
 {
 	struct kmemleak_object *object;
 
-	object = find_and_remove_object(ptr, 0, false);
+	object = find_and_remove_object(ptr, 0, objflags);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Freeing unknown object at 0x%08lx\n",
@@ -812,7 +822,8 @@ static void delete_object_full(unsigned long ptr)
  * delete it. If the memory block is partially freed, the function may create
  * additional metadata for the remaining parts of the block.
  */
-static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
+static void delete_object_part(unsigned long ptr, size_t size,
+			       unsigned int objflags)
 {
 	struct kmemleak_object *object, *object_l, *object_r;
 	unsigned long start, end, flags;
@@ -826,7 +837,7 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 		goto out;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = __find_and_remove_object(ptr, 1, is_phys);
+	object = __find_and_remove_object(ptr, 1, objflags);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
@@ -844,11 +855,11 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 	end = object->pointer + object->size;
 	if ((ptr > start) &&
 	    !__link_object(object_l, start, ptr - start,
-			   object->min_count, is_phys))
+			   object->min_count, objflags))
 		object_l = NULL;
 	if ((ptr + size < end) &&
 	    !__link_object(object_r, ptr + size, end - ptr - size,
-			   object->min_count, is_phys))
+			   object->min_count, objflags))
 		object_r = NULL;
 
 unlock:
@@ -879,11 +890,11 @@ static void paint_it(struct kmemleak_object *object, int color)
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
-static void paint_ptr(unsigned long ptr, int color, bool is_phys)
+static void paint_ptr(unsigned long ptr, int color, unsigned int objflags)
 {
 	struct kmemleak_object *object;
 
-	object = __find_and_get_object(ptr, 0, is_phys);
+	object = __find_and_get_object(ptr, 0, objflags);
 	if (!object) {
 		kmemleak_warn("Trying to color unknown object at 0x%08lx as %s\n",
 			      ptr,
@@ -901,16 +912,16 @@ static void paint_ptr(unsigned long ptr, int color, bool is_phys)
  */
 static void make_gray_object(unsigned long ptr)
 {
-	paint_ptr(ptr, KMEMLEAK_GREY, false);
+	paint_ptr(ptr, KMEMLEAK_GREY, 0);
 }
 
 /*
  * Mark the object as black-colored so that it is ignored from scans and
  * reporting.
  */
-static void make_black_object(unsigned long ptr, bool is_phys)
+static void make_black_object(unsigned long ptr, unsigned int objflags)
 {
-	paint_ptr(ptr, KMEMLEAK_BLACK, is_phys);
+	paint_ptr(ptr, KMEMLEAK_BLACK, objflags);
 }
 
 /*
@@ -1046,8 +1057,6 @@ EXPORT_SYMBOL_GPL(kmemleak_alloc);
 void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 				 gfp_t gfp)
 {
-	unsigned int cpu;
-
 	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
 
 	/*
@@ -1055,9 +1064,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	 * (min_count is set to 0).
 	 */
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		for_each_possible_cpu(cpu)
-			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
-				      size, 0, gfp);
+		create_object_percpu((unsigned long)ptr, size, 0, gfp);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -1098,7 +1105,7 @@ void __ref kmemleak_free(const void *ptr)
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
-		delete_object_full((unsigned long)ptr);
+		delete_object_full((unsigned long)ptr, 0);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free);
 
@@ -1116,7 +1123,7 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		delete_object_part((unsigned long)ptr, size, false);
+		delete_object_part((unsigned long)ptr, size, 0);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_part);
 
@@ -1129,14 +1136,10 @@ EXPORT_SYMBOL_GPL(kmemleak_free_part);
  */
 void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
-	unsigned int cpu;
-
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
-		for_each_possible_cpu(cpu)
-			delete_object_full((unsigned long)per_cpu_ptr(ptr,
-								      cpu));
+		delete_object_full((unsigned long)ptr, OBJECT_PERCPU);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
 
@@ -1204,7 +1207,7 @@ void __ref kmemleak_ignore(const void *ptr)
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		make_black_object((unsigned long)ptr, false);
+		make_black_object((unsigned long)ptr, 0);
 }
 EXPORT_SYMBOL(kmemleak_ignore);
 
@@ -1278,7 +1281,7 @@ void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 	pr_debug("%s(0x%px)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
-		delete_object_part((unsigned long)phys, size, true);
+		delete_object_part((unsigned long)phys, size, OBJECT_PHYS);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
 
@@ -1292,7 +1295,7 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
 	pr_debug("%s(0x%px)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
-		make_black_object((unsigned long)phys, true);
+		make_black_object((unsigned long)phys, OBJECT_PHYS);
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
@@ -1303,7 +1306,7 @@ static bool update_checksum(struct kmemleak_object *object)
 {
 	u32 old_csum = object->checksum;
 
-	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
+	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
 		return false;
 
 	kasan_disable_current();
@@ -1459,7 +1462,6 @@ static void scan_object(struct kmemleak_object *object)
 {
 	struct kmemleak_scan_area *area;
 	unsigned long flags;
-	void *obj_ptr;
 
 	/*
 	 * Once the object->lock is acquired, the corresponding memory block
@@ -1472,14 +1474,27 @@ static void scan_object(struct kmemleak_object *object)
 		/* already freed object */
 		goto out;
 
-	obj_ptr = object->flags & OBJECT_PHYS ?
-		  __va((phys_addr_t)object->pointer) :
-		  (void *)object->pointer;
+	if (object->flags & OBJECT_PERCPU) {
+		unsigned int cpu;
 
-	if (hlist_empty(&object->area_list) ||
+		for_each_possible_cpu(cpu) {
+			void *start = per_cpu_ptr((void __percpu *)object->pointer, cpu);
+			void *end = start + object->size;
+
+			scan_block(start, end, object);
+
+			raw_spin_unlock_irqrestore(&object->lock, flags);
+			cond_resched();
+			raw_spin_lock_irqsave(&object->lock, flags);
+			if (!(object->flags & OBJECT_ALLOCATED))
+				break;
+		}
+	} else if (hlist_empty(&object->area_list) ||
 	    object->flags & OBJECT_FULL_SCAN) {
-		void *start = obj_ptr;
-		void *end = obj_ptr + object->size;
+		void *start = object->flags & OBJECT_PHYS ?
+				__va((phys_addr_t)object->pointer) :
+				(void *)object->pointer;
+		void *end = start + object->size;
 		void *next;
 
 		do {
@@ -1494,11 +1509,12 @@ static void scan_object(struct kmemleak_object *object)
 			cond_resched();
 			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
-	} else
+	} else {
 		hlist_for_each_entry(area, &object->area_list, node)
 			scan_block((void *)area->start,
 				   (void *)(area->start + area->size),
 				   object);
+	}
 out:
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
