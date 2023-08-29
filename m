Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20A378C003
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjH2IMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjH2ILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27903BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso6374413e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296707; x=1693901507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IWUAKCJIzOp/gxV9EkyFZD0b+FcbujfqgJIfgCDsRU=;
        b=drYl4gUd+Jtb9pJbnkmWDw0WW9znwqfm/dN9edYWOz5h87Zk4m0CZviGo0tqS209ji
         7VllomAwTwIXfIpMe+6KrvXr6F1IRj+WCNZvkLczNr61sBgvSNMuVN/kJ8mEWH2X6nX0
         uuj1sm2KsNDMVcam+3JEmn7cWzUahEwLgLL2nwnedEfakWQpVGG+Q7S+18rT44j8Dzpq
         ATERh9jcoFaEnq1Ed/WsI1swE7aFwgUQoLhOvI01UFm7uQIkzqXeEF5RNOuqplOGcqhV
         OI6BaeR2dQa3xX9JA5JQKEioDYYkPMYwPRQU0RLQg5irN7C6Y2ey+azm0BbbyJmONyR1
         ZjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296707; x=1693901507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IWUAKCJIzOp/gxV9EkyFZD0b+FcbujfqgJIfgCDsRU=;
        b=mGsxDBH1f6nQeR91qH0qPjS09cPEgq4DsW2uxmDxK2e2LUkDXGIG48Op3B+RQqO1zZ
         OAY3EeKcKuADsxXm+kJ3WyhPKvZN/eTxhVoxPDRhDBhVfyJks/Ute/EpfUayJC/Hl9v2
         jKEIhS+y9ykhaGL966oxAPdTpq09TVbDTZxPdRN0jZYJOEfJATJf64Ym3jiuKPmS7YR+
         88fppQfbKiMVO4vMHyxSqhxKkNimhKBsNSEUX+DKdxuikRy2IQQVbQhvkXePfzfSDqy3
         +OqcwGqgR1sRh8j4n+B9aBMfALYvq1BUlNt6f4hOy3cpBibAMjfs2GAtlv14BLbAI5f7
         ux7w==
X-Gm-Message-State: AOJu0YyyU/MdMzUDcMLJCiXVJ9qQdUkhiDLIQU+25syTivAnKC2Uu5nX
        Ufy8AgpBkRqZ0tgDeDYHFr8=
X-Google-Smtp-Source: AGHT+IF4shimJXURLpT/BCINR6HV4dj6RneDkH6uQA661sVN+/c+lRcPx1Hj3E6H1bDmojzFC3+KaQ==
X-Received: by 2002:a19:6451:0:b0:4fd:bc33:e508 with SMTP id b17-20020a196451000000b004fdbc33e508mr18034118lfj.49.1693296707014;
        Tue, 29 Aug 2023 01:11:47 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:46 -0700 (PDT)
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
Subject: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Date:   Tue, 29 Aug 2023 10:11:37 +0200
Message-Id: <20230829081142.3619-5-urezki@gmail.com>
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

Store allocated objects in a separate nodes. A va->va_start
address is converted into a correct node where it should
be placed and resided. An addr_to_node() function is used
to do a proper address conversion to determine a node that
contains a VA.

Such approach balances VAs across nodes as a result an access
becomes scalable. Number of nodes in a system depends on number
of CPUs divided by two. The density factor in this case is 1/2.

Please note:

1. As of now allocated VAs are bound to a node-0. It means the
   patch does not give any difference comparing with a current
   behavior;

2. The global vmap_area_lock, vmap_area_root are removed as there
   is no need in it anymore. The vmap_area_list is still kept and
   is _empty_. It is exported for a kexec only;

3. The vmallocinfo and vread() have to be reworked to be able to
   handle multiple nodes.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 209 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 161 insertions(+), 48 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b7deacca1483..ae0368c314ff 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -728,11 +728,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
 
-static DEFINE_SPINLOCK(vmap_area_lock);
 static DEFINE_SPINLOCK(free_vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
-static struct rb_root vmap_area_root = RB_ROOT;
 static bool vmap_initialized __read_mostly;
 
 static struct rb_root purge_vmap_area_root = RB_ROOT;
@@ -772,6 +770,38 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
  */
 static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
 
+/*
+ * An effective vmap-node logic. Users make use of nodes instead
+ * of a global heap. It allows to balance an access and mitigate
+ * contention.
+ */
+struct rb_list {
+	struct rb_root root;
+	struct list_head head;
+	spinlock_t lock;
+};
+
+struct vmap_node {
+	/* Bookkeeping data of this node. */
+	struct rb_list busy;
+};
+
+static struct vmap_node *nodes, snode;
+static __read_mostly unsigned int nr_nodes = 1;
+static __read_mostly unsigned int node_size = 1;
+
+static inline unsigned int
+addr_to_node_id(unsigned long addr)
+{
+	return (addr / node_size) % nr_nodes;
+}
+
+static inline struct vmap_node *
+addr_to_node(unsigned long addr)
+{
+	return &nodes[addr_to_node_id(addr)];
+}
+
 static __always_inline unsigned long
 va_size(struct vmap_area *va)
 {
@@ -803,10 +833,11 @@ unsigned long vmalloc_nr_pages(void)
 }
 
 /* Look up the first VA which satisfies addr < va_end, NULL if none. */
-static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
+static struct vmap_area *
+find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 {
 	struct vmap_area *va = NULL;
-	struct rb_node *n = vmap_area_root.rb_node;
+	struct rb_node *n = root->rb_node;
 
 	addr = (unsigned long)kasan_reset_tag((void *)addr);
 
@@ -1552,12 +1583,14 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
  */
 static void free_vmap_area(struct vmap_area *va)
 {
+	struct vmap_node *vn = addr_to_node(va->va_start);
+
 	/*
 	 * Remove from the busy tree/list.
 	 */
-	spin_lock(&vmap_area_lock);
-	unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	spin_lock(&vn->busy.lock);
+	unlink_va(va, &vn->busy.root);
+	spin_unlock(&vn->busy.lock);
 
 	/*
 	 * Insert/Merge it back to the free tree/list.
@@ -1600,6 +1633,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				int node, gfp_t gfp_mask,
 				unsigned long va_flags)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
 	unsigned long freed;
 	unsigned long addr;
@@ -1645,9 +1679,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = va_flags;
 
-	spin_lock(&vmap_area_lock);
-	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
-	spin_unlock(&vmap_area_lock);
+	vn = addr_to_node(va->va_start);
+
+	spin_lock(&vn->busy.lock);
+	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
+	spin_unlock(&vn->busy.lock);
 
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
 	BUG_ON(va->va_start < vstart);
@@ -1871,26 +1907,61 @@ static void free_unmap_vmap_area(struct vmap_area *va)
 
 struct vmap_area *find_vmap_area(unsigned long addr)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
+	int i, j;
+
+	/*
+	 * An addr_to_node_id(addr) converts an address to a node index
+	 * where a VA is located. If VA spans several zones and passed
+	 * addr is not the same as va->va_start, what is not common, we
+	 * may need to scan an extra nodes. See an example:
+	 *
+	 *      <--va-->
+	 * -|-----|-----|-----|-----|-
+	 *     1     2     0     1
+	 *
+	 * VA resides in node 1 whereas it spans 1 and 2. If passed
+	 * addr is within a second node we should do extra work. We
+	 * should mention that it is rare and is a corner case from
+	 * the other hand it has to be covered.
+	 */
+	i = j = addr_to_node_id(addr);
+	do {
+		vn = &nodes[i];
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+		spin_lock(&vn->busy.lock);
+		va = __find_vmap_area(addr, &vn->busy.root);
+		spin_unlock(&vn->busy.lock);
 
-	return va;
+		if (va)
+			return va;
+	} while ((i = (i + 1) % nr_nodes) != j);
+
+	return NULL;
 }
 
 static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
+	int i, j;
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr, &vmap_area_root);
-	if (va)
-		unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	i = j = addr_to_node_id(addr);
+	do {
+		vn = &nodes[i];
 
-	return va;
+		spin_lock(&vn->busy.lock);
+		va = __find_vmap_area(addr, &vn->busy.root);
+		if (va)
+			unlink_va(va, &vn->busy.root);
+		spin_unlock(&vn->busy.lock);
+
+		if (va)
+			return va;
+	} while ((i = (i + 1) % nr_nodes) != j);
+
+	return NULL;
 }
 
 /*** Per cpu kva allocator ***/
@@ -2092,6 +2163,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 static void free_vmap_block(struct vmap_block *vb)
 {
+	struct vmap_node *vn;
 	struct vmap_block *tmp;
 	struct xarray *xa;
 
@@ -2099,9 +2171,10 @@ static void free_vmap_block(struct vmap_block *vb)
 	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
 	BUG_ON(tmp != vb);
 
-	spin_lock(&vmap_area_lock);
-	unlink_va(vb->va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	vn = addr_to_node(vb->va->va_start);
+	spin_lock(&vn->busy.lock);
+	unlink_va(vb->va, &vn->busy.root);
+	spin_unlock(&vn->busy.lock);
 
 	free_vmap_area_noflush(vb->va);
 	kfree_rcu(vb, rcu_head);
@@ -2525,9 +2598,11 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 			      unsigned long flags, const void *caller)
 {
-	spin_lock(&vmap_area_lock);
+	struct vmap_node *vn = addr_to_node(va->va_start);
+
+	spin_lock(&vn->busy.lock);
 	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&vn->busy.lock);
 }
 
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
@@ -3711,6 +3786,7 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
  */
 long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
 	struct vm_struct *vm;
 	char *vaddr;
@@ -3724,8 +3800,11 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 	remains = count;
 
-	spin_lock(&vmap_area_lock);
-	va = find_vmap_area_exceed_addr((unsigned long)addr);
+	/* Hooked to node_0 so far. */
+	vn = addr_to_node(0);
+	spin_lock(&vn->busy.lock);
+
+	va = find_vmap_area_exceed_addr((unsigned long)addr, &vn->busy.root);
 	if (!va)
 		goto finished_zero;
 
@@ -3733,7 +3812,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 	if ((unsigned long)addr + remains <= va->va_start)
 		goto finished_zero;
 
-	list_for_each_entry_from(va, &vmap_area_list, list) {
+	list_for_each_entry_from(va, &vn->busy.head, list) {
 		size_t copied;
 
 		if (remains == 0)
@@ -3792,12 +3871,12 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 	}
 
 finished_zero:
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&vn->busy.lock);
 	/* zero-fill memory holes */
 	return count - remains + zero_iter(iter, remains);
 finished:
 	/* Nothing remains, or We couldn't copy/zero everything. */
-	spin_unlock(&vmap_area_lock);
+	spin_unlock(&vn->busy.lock);
 
 	return count - remains;
 }
@@ -4131,14 +4210,15 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 
 	/* insert all vm's */
-	spin_lock(&vmap_area_lock);
 	for (area = 0; area < nr_vms; area++) {
-		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
+		struct vmap_node *vn = addr_to_node(vas[area]->va_start);
 
+		spin_lock(&vn->busy.lock);
+		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
 		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
+		spin_unlock(&vn->busy.lock);
 	}
-	spin_unlock(&vmap_area_lock);
 
 	/*
 	 * Mark allocated areas as accessible. Do it now as a best-effort
@@ -4261,25 +4341,26 @@ bool vmalloc_dump_obj(void *object)
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
-	__acquires(&vmap_purge_lock)
-	__acquires(&vmap_area_lock)
 {
+	struct vmap_node *vn = addr_to_node(0);
+
 	mutex_lock(&vmap_purge_lock);
-	spin_lock(&vmap_area_lock);
+	spin_lock(&vn->busy.lock);
 
-	return seq_list_start(&vmap_area_list, *pos);
+	return seq_list_start(&vn->busy.head, *pos);
 }
 
 static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	return seq_list_next(p, &vmap_area_list, pos);
+	struct vmap_node *vn = addr_to_node(0);
+	return seq_list_next(p, &vn->busy.head, pos);
 }
 
 static void s_stop(struct seq_file *m, void *p)
-	__releases(&vmap_area_lock)
-	__releases(&vmap_purge_lock)
 {
-	spin_unlock(&vmap_area_lock);
+	struct vmap_node *vn = addr_to_node(0);
+
+	spin_unlock(&vn->busy.lock);
 	mutex_unlock(&vmap_purge_lock);
 }
 
@@ -4322,9 +4403,11 @@ static void show_purge_info(struct seq_file *m)
 
 static int s_show(struct seq_file *m, void *p)
 {
+	struct vmap_node *vn;
 	struct vmap_area *va;
 	struct vm_struct *v;
 
+	vn = addr_to_node(0);
 	va = list_entry(p, struct vmap_area, list);
 
 	if (!va->vm) {
@@ -4375,7 +4458,7 @@ static int s_show(struct seq_file *m, void *p)
 	 * As a final step, dump "unpurged" areas.
 	 */
 final:
-	if (list_is_last(&va->list, &vmap_area_list))
+	if (list_is_last(&va->list, &vn->busy.head))
 		show_purge_info(m);
 
 	return 0;
@@ -4406,7 +4489,8 @@ static void vmap_init_free_space(void)
 {
 	unsigned long vmap_start = 1;
 	const unsigned long vmap_end = ULONG_MAX;
-	struct vmap_area *busy, *free;
+	struct vmap_area *free;
+	struct vm_struct *busy;
 
 	/*
 	 *     B     F     B     B     B     F
@@ -4414,12 +4498,12 @@ static void vmap_init_free_space(void)
 	 *  |           The KVA space           |
 	 *  |<--------------------------------->|
 	 */
-	list_for_each_entry(busy, &vmap_area_list, list) {
-		if (busy->va_start - vmap_start > 0) {
+	for (busy = vmlist; busy; busy = busy->next) {
+		if (busy->addr - vmap_start > 0) {
 			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
 			if (!WARN_ON_ONCE(!free)) {
 				free->va_start = vmap_start;
-				free->va_end = busy->va_start;
+				free->va_end = (unsigned long) busy->addr;
 
 				insert_vmap_area_augment(free, NULL,
 					&free_vmap_area_root,
@@ -4427,7 +4511,7 @@ static void vmap_init_free_space(void)
 			}
 		}
 
-		vmap_start = busy->va_end;
+		vmap_start = (unsigned long) busy->addr + busy->size;
 	}
 
 	if (vmap_end - vmap_start > 0) {
@@ -4443,9 +4527,31 @@ static void vmap_init_free_space(void)
 	}
 }
 
+static void vmap_init_nodes(void)
+{
+	struct vmap_node *vn;
+	int i;
+
+	nodes = &snode;
+
+	if (nr_nodes > 1) {
+		vn = kmalloc_array(nr_nodes, sizeof(*vn), GFP_NOWAIT);
+		if (vn)
+			nodes = vn;
+	}
+
+	for (i = 0; i < nr_nodes; i++) {
+		vn = &nodes[i];
+		vn->busy.root = RB_ROOT;
+		INIT_LIST_HEAD(&vn->busy.head);
+		spin_lock_init(&vn->busy.lock);
+	}
+}
+
 void __init vmalloc_init(void)
 {
 	struct vmap_area *va;
+	struct vmap_node *vn;
 	struct vm_struct *tmp;
 	int i;
 
@@ -4467,6 +4573,11 @@ void __init vmalloc_init(void)
 		xa_init(&vbq->vmap_blocks);
 	}
 
+	/*
+	 * Setup nodes before importing vmlist.
+	 */
+	vmap_init_nodes();
+
 	/* Import existing vmlist entries. */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
@@ -4476,7 +4587,9 @@ void __init vmalloc_init(void)
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
 		va->vm = tmp;
-		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+
+		vn = addr_to_node(va->va_start);
+		insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
 	}
 
 	/*
-- 
2.30.2

