Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3F78C006
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjH2IMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjH2ILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BA9E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5009969be25so6453467e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296709; x=1693901509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ov9GwojXyegJrClaNh+dNhWRQYcZI0mb3uhXBk2808=;
        b=bJ6I4buxddwJbnV5khklHoNr8shneI1m2Pfz7Cn7lVn3Ct2TGx4NVrKFHMw0JCJm8K
         BMxCwi6WzwDxhS7jisbwydWfPFF2RvZ9E57hhAlUgeG9s7dO57fHKynARQd58sn5xkOu
         YU0ixCbxOslMZOn2Ct4ZXQKkUsSykzQLISy/dmgxa7AINLLz/rHk0FOsAmwAflAGW9NQ
         v56thAg/0Xxos/mutifkNdfXyC7i18IwGX5o1DFx7V18+tzrK/cckhszynKC6QzAYsBQ
         jA7iiREStn7vJ048+ZFJEwrzQz+pz+MPg0dv1ZXI+XOTiVY6jT9Isa7Aty3vQzXJb1JY
         Fevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296709; x=1693901509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ov9GwojXyegJrClaNh+dNhWRQYcZI0mb3uhXBk2808=;
        b=DOBAXWDZ1kW7amjNhkBuLOl3IwyxLqIUOcmmdFT2yVZ/qAeZVyUxQsD5pUsbni6rpI
         ho3Zv99HsWfwDcgh3ZivcDTCVI3zzek/hXMN6uQ+NkfdAI9cYakpyPRskSbr0flKDbad
         eVQo9IzI1osAa05B5ogTHZlD1g+pxDTtD43xG306+SI7DJ0+UN2f5T8dwTlF2l/NNt0/
         ZgprQvhY0AkLOf0VT5ydxbGsyu8xZ4xgO94neqERv9DRdVekN/ojubPEmFSt6YYILXo6
         2eYYTiRoAfo4c7RXXg0AlHCC0jETxBplf0faUsww7FJwjYKOK4P3IQ6DWQVGDQHnJtNi
         XXrA==
X-Gm-Message-State: AOJu0YwxAfE2o8gt1BuHn85sUZfS7DBJZ1o8IN9qOnD/Vc0lazDg09Do
        ks/DjyjH4VbQ1oRkb0xXTk4=
X-Google-Smtp-Source: AGHT+IFvidEopg5kx+6gzDu497/g2a1bwH0SJKpU7lfNruEN5J+4hnUh3jCCpR0AMiZy4S6Hr/ENbQ==
X-Received: by 2002:a05:6512:282c:b0:4ff:8f1b:8ccf with SMTP id cf44-20020a056512282c00b004ff8f1b8ccfmr22489868lfb.21.1693296708620;
        Tue, 29 Aug 2023 01:11:48 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:48 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 6/9] mm: vmalloc: Offload free_vmap_area_lock lock
Date:   Tue, 29 Aug 2023 10:11:39 +0200
Message-Id: <20230829081142.3619-7-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230829081142.3619-1-urezki@gmail.com>
References: <20230829081142.3619-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concurrent access to a global vmap space is a bottle-neck.
We can simulate a high contention by running a vmalloc test
suite.

To address it, introduce an effective vmap node logic. Each
node behaves as independent entity. When a node is accessed
it serves a request directly(if possible) also it can fetch
a new block from a global heap to its internals if no space
or low capacity is left.

This technique reduces a pressure on the global vmap lock.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 316 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 279 insertions(+), 37 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5a8a9c1370b6..4fd4915c532d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -779,6 +779,7 @@ struct rb_list {
 
 struct vmap_node {
 	/* Bookkeeping data of this node. */
+	struct rb_list free;
 	struct rb_list busy;
 	struct rb_list lazy;
 
@@ -786,6 +787,13 @@ struct vmap_node {
 	 * Ready-to-free areas.
 	 */
 	struct list_head purge_list;
+	struct work_struct purge_work;
+	unsigned long nr_purged;
+
+	/*
+	 * Control that only one user can pre-fetch this node.
+	 */
+	atomic_t fill_in_progress;
 };
 
 static struct vmap_node *nodes, snode;
@@ -804,6 +812,32 @@ addr_to_node(unsigned long addr)
 	return &nodes[addr_to_node_id(addr)];
 }
 
+static inline struct vmap_node *
+id_to_node(int id)
+{
+	return &nodes[id % nr_nodes];
+}
+
+static inline int
+this_node_id(void)
+{
+	return raw_smp_processor_id() % nr_nodes;
+}
+
+static inline unsigned long
+encode_vn_id(int node_id)
+{
+	/* Can store U8_MAX [0:254] nodes. */
+	return (node_id + 1) << BITS_PER_BYTE;
+}
+
+static inline int
+decode_vn_id(unsigned long val)
+{
+	/* Can store U8_MAX [0:254] nodes. */
+	return (val >> BITS_PER_BYTE) - 1;
+}
+
 static __always_inline unsigned long
 va_size(struct vmap_area *va)
 {
@@ -1586,6 +1620,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 static void free_vmap_area(struct vmap_area *va)
 {
 	struct vmap_node *vn = addr_to_node(va->va_start);
+	int vn_id = decode_vn_id(va->flags);
 
 	/*
 	 * Remove from the busy tree/list.
@@ -1594,12 +1629,19 @@ static void free_vmap_area(struct vmap_area *va)
 	unlink_va(va, &vn->busy.root);
 	spin_unlock(&vn->busy.lock);
 
-	/*
-	 * Insert/Merge it back to the free tree/list.
-	 */
-	spin_lock(&free_vmap_area_lock);
-	merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
-	spin_unlock(&free_vmap_area_lock);
+	if (vn_id >= 0) {
+		vn = id_to_node(vn_id);
+
+		/* Belongs to this node. */
+		spin_lock(&vn->free.lock);
+		merge_or_add_vmap_area_augment(va, &vn->free.root, &vn->free.head);
+		spin_unlock(&vn->free.lock);
+	} else {
+		/* Goes to global. */
+		spin_lock(&free_vmap_area_lock);
+		merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
+		spin_unlock(&free_vmap_area_lock);
+	}
 }
 
 static inline void
@@ -1625,6 +1667,134 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
 		kmem_cache_free(vmap_area_cachep, va);
 }
 
+static unsigned long
+node_alloc_fill(struct vmap_node *vn,
+		unsigned long size, unsigned long align,
+		gfp_t gfp_mask, int node)
+{
+	struct vmap_area *va;
+	unsigned long addr;
+
+	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
+	if (unlikely(!va))
+		return VMALLOC_END;
+
+	/*
+	 * Please note, an allocated block is not aligned to its size.
+	 * Therefore it can span several zones what means addr_to_node()
+	 * can point to two different nodes:
+	 *      <----->
+	 * -|-----|-----|-----|-----|-
+	 *     1     2     0     1
+	 *
+	 * an alignment would just increase fragmentation thus more heap
+	 * consumption what we would like to avoid.
+	 */
+	spin_lock(&free_vmap_area_lock);
+	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
+		node_size, 1, VMALLOC_START, VMALLOC_END);
+	spin_unlock(&free_vmap_area_lock);
+
+	if (addr == VMALLOC_END) {
+		kmem_cache_free(vmap_area_cachep, va);
+		return VMALLOC_END;
+	}
+
+	/*
+	 * Statement and condition of the problem:
+	 *
+	 * a) where to free allocated areas from a node:
+	 *   - directly to a global heap;
+	 *   - to a node that we got a VA from;
+	 *     - what is a condition to return allocated areas
+	 *       to a global heap then;
+	 * b) how to properly handle left small free fragments
+	 *    of a node in order to mitigate a fragmentation.
+	 *
+	 * How to address described points:
+	 * When a new block is allocated(from a global heap) we shrink
+	 * it deliberately by one page from both sides and place it to
+	 * this node to serve a request.
+	 *
+	 * Why we shrink. We would like to distinguish VAs which were
+	 * obtained from a node and a global heap. This is for a free
+	 * path. A va->flags contains a node-id it belongs to. No VAs
+	 * merging is possible between each other unless they are part
+	 * of same block.
+	 *
+	 * A free-path in its turn can detect a correct node where a
+	 * VA has to be returned. Thus as a block is freed entirely,
+	 * its size becomes(merging): node_size - (2 * PAGE_SIZE) it
+	 * recovers its edges, thus is released to a global heap for
+	 * reuse elsewhere. In partly freed case, VAs go back to the
+	 * node not bothering a global vmap space.
+	 *
+	 *        1               2              3
+	 * |<------------>|<------------>|<------------>|
+	 * |..<-------->..|..<-------->..|..<-------->..|
+	 */
+	va->va_start = addr + PAGE_SIZE;
+	va->va_end = (addr + node_size) - PAGE_SIZE;
+
+	spin_lock(&vn->free.lock);
+	/* Never merges. See explanation above. */
+	insert_vmap_area_augment(va, NULL, &vn->free.root, &vn->free.head);
+	addr = va_alloc(va, &vn->free.root, &vn->free.head,
+		size, align, VMALLOC_START, VMALLOC_END);
+	spin_unlock(&vn->free.lock);
+
+	return addr;
+}
+
+static unsigned long
+node_alloc(int vn_id, unsigned long size, unsigned long align,
+		unsigned long vstart, unsigned long vend,
+		gfp_t gfp_mask, int node)
+{
+	struct vmap_node *vn = id_to_node(vn_id);
+	unsigned long extra = align > PAGE_SIZE ? align : 0;
+	bool do_alloc_fill = false;
+	unsigned long addr;
+
+	/*
+	 * Fallback to a global heap if not vmalloc.
+	 */
+	if (vstart != VMALLOC_START || vend != VMALLOC_END)
+		return vend;
+
+	/*
+	 * A maximum allocation limit is 1/4 of capacity. This
+	 * is done in order to prevent a fast depleting of zone
+	 * by few requests.
+	 */
+	if (size + extra > (node_size >> 2))
+		return vend;
+
+	spin_lock(&vn->free.lock);
+	addr = __alloc_vmap_area(&vn->free.root, &vn->free.head,
+		size, align, vstart, vend);
+
+	if (addr == vend) {
+		/*
+		 * Set the fetch flag under the critical section.
+		 * This guarantees that only one user is eligible
+		 * to perform a pre-fetch. A reset operation can
+		 * be concurrent.
+		 */
+		if (!atomic_xchg(&vn->fill_in_progress, 1))
+			do_alloc_fill = true;
+	}
+	spin_unlock(&vn->free.lock);
+
+	/* Only if fails a previous attempt. */
+	if (do_alloc_fill) {
+		addr = node_alloc_fill(vn, size, align, gfp_mask, node);
+		atomic_set(&vn->fill_in_progress, 0);
+	}
+
+	return addr;
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend.
@@ -1640,7 +1810,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	unsigned long freed;
 	unsigned long addr;
 	int purged = 0;
-	int ret;
+	int ret, vn_id;
 
 	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
 		return ERR_PTR(-EINVAL);
@@ -1661,11 +1831,17 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 */
 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
 
+	vn_id = this_node_id();
+	addr = node_alloc(vn_id, size, align, vstart, vend, gfp_mask, node);
+	va->flags = (addr != vend) ? encode_vn_id(vn_id) : 0;
+
 retry:
-	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
-	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
-		size, align, vstart, vend);
-	spin_unlock(&free_vmap_area_lock);
+	if (addr == vend) {
+		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
+		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
+			size, align, vstart, vend);
+		spin_unlock(&free_vmap_area_lock);
+	}
 
 	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
 
@@ -1679,7 +1855,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->va_start = addr;
 	va->va_end = addr + size;
 	va->vm = NULL;
-	va->flags = va_flags;
+	va->flags |= va_flags;
 
 	vn = addr_to_node(va->va_start);
 
@@ -1772,31 +1948,58 @@ static DEFINE_MUTEX(vmap_purge_lock);
 static void purge_fragmented_blocks_allcpus(void);
 static cpumask_t purge_nodes;
 
-/*
- * Purges all lazily-freed vmap areas.
- */
-static unsigned long
-purge_vmap_node(struct vmap_node *vn)
+static void
+reclaim_list_global(struct list_head *head)
+{
+	struct vmap_area *va, *n;
+
+	if (list_empty(head))
+		return;
+
+	spin_lock(&free_vmap_area_lock);
+	list_for_each_entry_safe(va, n, head, list)
+		merge_or_add_vmap_area_augment(va,
+			&free_vmap_area_root, &free_vmap_area_list);
+	spin_unlock(&free_vmap_area_lock);
+}
+
+static void purge_vmap_node(struct work_struct *work)
 {
-	unsigned long num_purged_areas = 0;
+	struct vmap_node *vn = container_of(work,
+		struct vmap_node, purge_work);
 	struct vmap_area *va, *n_va;
+	LIST_HEAD(global);
+
+	vn->nr_purged = 0;
 
 	if (list_empty(&vn->purge_list))
-		return 0;
+		return;
 
-	spin_lock(&free_vmap_area_lock);
+	spin_lock(&vn->free.lock);
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
 		unsigned long orig_end = va->va_end;
+		int vn_id = decode_vn_id(va->flags);
 
-		/*
-		 * Finally insert or merge lazily-freed area. It is
-		 * detached and there is no need to "unlink" it from
-		 * anything.
-		 */
-		va = merge_or_add_vmap_area_augment(va, &free_vmap_area_root,
-				&free_vmap_area_list);
+		list_del_init(&va->list);
+
+		if (vn_id >= 0) {
+			if (va_size(va) != node_size - (2 * PAGE_SIZE))
+				va = merge_or_add_vmap_area_augment(va, &vn->free.root, &vn->free.head);
+
+			if (va_size(va) == node_size - (2 * PAGE_SIZE)) {
+				if (!list_empty(&va->list))
+					unlink_va_augment(va, &vn->free.root);
+
+				/* Restore the block size. */
+				va->va_start -= PAGE_SIZE;
+				va->va_end += PAGE_SIZE;
+				list_add(&va->list, &global);
+			}
+		} else {
+			list_add(&va->list, &global);
+		}
 
 		if (!va)
 			continue;
@@ -1806,11 +2009,10 @@ purge_vmap_node(struct vmap_node *vn)
 					      va->va_start, va->va_end);
 
 		atomic_long_sub(nr, &vmap_lazy_nr);
-		num_purged_areas++;
+		vn->nr_purged++;
 	}
-	spin_unlock(&free_vmap_area_lock);
-
-	return num_purged_areas;
+	spin_unlock(&vn->free.lock);
+	reclaim_list_global(&global);
 }
 
 /*
@@ -1818,11 +2020,17 @@ purge_vmap_node(struct vmap_node *vn)
  */
 static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 {
-	unsigned long num_purged_areas = 0;
+	unsigned long nr_purged_areas = 0;
+	unsigned int nr_purge_helpers;
+	unsigned int nr_purge_nodes;
 	struct vmap_node *vn;
 	int i;
 
 	lockdep_assert_held(&vmap_purge_lock);
+
+	/*
+	 * Use cpumask to mark which node has to be processed.
+	 */
 	purge_nodes = CPU_MASK_NONE;
 
 	for (i = 0; i < nr_nodes; i++) {
@@ -1847,17 +2055,45 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 		cpumask_set_cpu(i, &purge_nodes);
 	}
 
-	if (cpumask_weight(&purge_nodes) > 0) {
+	nr_purge_nodes = cpumask_weight(&purge_nodes);
+	if (nr_purge_nodes > 0) {
 		flush_tlb_kernel_range(start, end);
 
+		/* One extra worker is per a lazy_max_pages() full set minus one. */
+		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
+		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
+
+		for_each_cpu(i, &purge_nodes) {
+			vn = &nodes[i];
+
+			if (nr_purge_helpers > 0) {
+				INIT_WORK(&vn->purge_work, purge_vmap_node);
+
+				if (cpumask_test_cpu(i, cpu_online_mask))
+					schedule_work_on(i, &vn->purge_work);
+				else
+					schedule_work(&vn->purge_work);
+
+				nr_purge_helpers--;
+			} else {
+				vn->purge_work.func = NULL;
+				purge_vmap_node(&vn->purge_work);
+				nr_purged_areas += vn->nr_purged;
+			}
+		}
+
 		for_each_cpu(i, &purge_nodes) {
 			vn = &nodes[i];
-			num_purged_areas += purge_vmap_node(vn);
+
+			if (vn->purge_work.func) {
+				flush_work(&vn->purge_work);
+				nr_purged_areas += vn->nr_purged;
+			}
 		}
 	}
 
-	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
-	return num_purged_areas > 0;
+	trace_purge_vmap_area_lazy(start, end, nr_purged_areas);
+	return nr_purged_areas > 0;
 }
 
 /*
@@ -1886,9 +2122,11 @@ static void drain_vmap_area_work(struct work_struct *work)
  */
 static void free_vmap_area_noflush(struct vmap_area *va)
 {
-	struct vmap_node *vn = addr_to_node(va->va_start);
 	unsigned long nr_lazy_max = lazy_max_pages();
 	unsigned long va_start = va->va_start;
+	int vn_id = decode_vn_id(va->flags);
+	struct vmap_node *vn = vn_id >= 0 ? id_to_node(vn_id):
+		addr_to_node(va->va_start);;
 	unsigned long nr_lazy;
 
 	if (WARN_ON_ONCE(!list_empty(&va->list)))
@@ -4574,6 +4812,10 @@ static void vmap_init_nodes(void)
 		vn->lazy.root = RB_ROOT;
 		INIT_LIST_HEAD(&vn->lazy.head);
 		spin_lock_init(&vn->lazy.lock);
+
+		vn->free.root = RB_ROOT;
+		INIT_LIST_HEAD(&vn->free.head);
+		spin_lock_init(&vn->free.lock);
 	}
 }
 
-- 
2.30.2

