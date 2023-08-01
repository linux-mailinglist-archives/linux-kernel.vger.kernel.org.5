Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C876A910
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjHAG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHAG2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:28:23 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CC7E7;
        Mon, 31 Jul 2023 23:28:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RFPyB14MHz9y7l8;
        Tue,  1 Aug 2023 14:16:34 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.220.249])
        by APP1 (Coremail) with SMTP id LxC2BwCHOroapchkgAwYAA--.27948S10;
        Tue, 01 Aug 2023 07:27:08 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR ARM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        iommu@lists.linux.dev (open list:XEN SWIOTLB SUBSYSTEM),
        linux-mm@kvack.org (open list:SLAB ALLOCATOR)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v7 8/9] swiotlb: allocate a new memory pool when existing pools are full
Date:   Tue,  1 Aug 2023 08:24:03 +0200
Message-Id: <e6fc5b3d0695870774f01a8c2416aa5b639ee2b5.1690871004.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHOroapchkgAwYAA--.27948S10
X-Coremail-Antispam: 1UD129KBjvJXoW3ZrWfGFyxAryxCr4UJFWfAFb_yoWkXrW3pF
        y5Aa47KFWUXrn7CFy2k3WUCF1a9w4vkr47CrWa9rn8Zrn7Wrn8tFyqkryYqr95JF4DZF13
        tFWYvF15uw47Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0
        owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JU2XdbUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

When swiotlb_find_slots() cannot find suitable slots, schedule the
allocation of a new memory pool. It is not possible to allocate the pool
immediately, because this code may run in interrupt context, which is not
suitable for large memory allocations. This means that the memory pool will
be available too late for the currently requested mapping, but the stress
on the software IO TLB allocator is likely to continue, and subsequent
allocations will benefit from the additional pool eventually.

Keep all memory pools for an allocator in an RCU list to avoid locking on
the read side. For modifications, add a new spinlock to struct io_tlb_mem.

The spinlock also protects updates to the total number of slabs (nslabs in
struct io_tlb_mem), but not reads of the value. Readers may therefore
encounter a stale value, but this is not an issue:

- swiotlb_tbl_map_single() and is_swiotlb_active() only check for non-zero
  value. This is ensured by the existence of the default memory pool,
  allocated at boot.

- The exact value is used only for non-critical purposes (debugfs, kernel
  messages).

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h |   8 +++
 kernel/dma/swiotlb.c    | 148 +++++++++++++++++++++++++++++++++-------
 2 files changed, 131 insertions(+), 25 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 9825fa14abe4..8371c92a0271 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/limits.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 struct device;
 struct page;
@@ -104,12 +105,16 @@ struct io_tlb_pool {
 /**
  * struct io_tlb_mem - Software IO TLB allocator
  * @defpool:	Default (initial) IO TLB memory pool descriptor.
+ * @pool:	IO TLB memory pool descriptor (if not dynamic).
  * @nslabs:	Total number of IO TLB slabs in all pools.
  * @debugfs:	The dentry to debugfs.
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
  * @can_grow:	%true if more pools can be allocated dynamically.
  * @phys_limit:	Maximum allowed physical address.
+ * @lock:	Lock to synchronize changes to the list.
+ * @pools:	List of IO TLB memory pool descriptors (if dynamic).
+ * @dyn_alloc:	Dynamic IO TLB pool allocation work.
  * @total_used:	The total number of slots in the pool that are currently used
  *		across all areas. Used only for calculating used_hiwater in
  *		debugfs.
@@ -125,6 +130,9 @@ struct io_tlb_mem {
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	bool can_grow;
 	u64 phys_limit;
+	spinlock_t lock;
+	struct list_head pools;
+	struct work_struct dyn_alloc;
 #endif
 #ifdef CONFIG_DEBUG_FS
 	atomic_long_t total_used;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0fa081defdbd..adf80dec42d7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -79,8 +79,23 @@ struct io_tlb_slot {
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+
+static void swiotlb_dyn_alloc(struct work_struct *work);
+
+static struct io_tlb_mem io_tlb_default_mem = {
+	.lock = __SPIN_LOCK_UNLOCKED(io_tlb_default_mem.lock),
+	.pools = LIST_HEAD_INIT(io_tlb_default_mem.pools),
+	.dyn_alloc = __WORK_INITIALIZER(io_tlb_default_mem.dyn_alloc,
+					swiotlb_dyn_alloc),
+};
+
+#else  /* !CONFIG_SWIOTLB_DYNAMIC */
+
 static struct io_tlb_mem io_tlb_default_mem;
 
+#endif	/* CONFIG_SWIOTLB_DYNAMIC */
+
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
 
@@ -278,6 +293,23 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 	return;
 }
 
+/**
+ * add_mem_pool() - add a memory pool to the allocator
+ * @mem:	Software IO TLB allocator.
+ * @pool:	Memory pool to be added.
+ */
+static void add_mem_pool(struct io_tlb_mem *mem, struct io_tlb_pool *pool)
+{
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	spin_lock(&mem->lock);
+	list_add_rcu(&pool->node, &mem->pools);
+	mem->nslabs += pool->nslabs;
+	spin_unlock(&mem->lock);
+#else
+	mem->nslabs = pool->nslabs;
+#endif
+}
+
 static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 		unsigned int flags,
 		int (*remap)(void *tlb, unsigned long nslabs))
@@ -375,7 +407,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false,
 				 default_nareas);
-	io_tlb_default_mem.nslabs = nslabs;
+	add_mem_pool(&io_tlb_default_mem, mem);
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();
@@ -474,7 +506,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
 				 nareas);
-	io_tlb_default_mem.nslabs = nslabs;
+	add_mem_pool(&io_tlb_default_mem, mem);
 
 	swiotlb_print_info();
 	return 0;
@@ -625,44 +657,83 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
 /**
  * swiotlb_alloc_pool() - allocate a new IO TLB memory pool
  * @dev:	Device for which a memory pool is allocated.
- * @nslabs:	Desired number of slabs.
+ * @minslabs:	Minimum number of slabs.
+ * @nslabs:	Desired (maximum) number of slabs.
+ * @nareas:	Number of areas.
  * @phys_limit:	Maximum DMA buffer physical address.
  * @gfp:	GFP flags for the allocations.
  *
- * Allocate and initialize a new IO TLB memory pool.
+ * Allocate and initialize a new IO TLB memory pool. The actual number of
+ * slabs may be reduced if allocation of @nslabs fails. If even
+ * @minslabs cannot be allocated, this function fails.
  *
  * Return: New memory pool, or %NULL on allocation failure.
  */
 static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
-		unsigned int nslabs, u64 phys_limit, gfp_t gfp)
+		unsigned long minslabs, unsigned long nslabs,
+		unsigned int nareas, u64 phys_limit, gfp_t gfp)
 {
 	struct io_tlb_pool *pool;
+	unsigned int slot_order;
 	struct page *tlb;
 	size_t pool_size;
 	size_t tlb_size;
 
-	pool_size = sizeof(*pool) + array_size(sizeof(*pool->areas), 1) +
-		array_size(sizeof(*pool->slots), nslabs);
+	pool_size = sizeof(*pool) + array_size(sizeof(*pool->areas), nareas);
 	pool = kzalloc(pool_size, gfp);
 	if (!pool)
 		goto error;
 	pool->areas = (void *)pool + sizeof(*pool);
-	pool->slots = (void *)pool->areas + sizeof(*pool->areas);
 
 	tlb_size = nslabs << IO_TLB_SHIFT;
-	tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp);
-	if (!tlb)
-		goto error_tlb;
+	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
+		if (nslabs <= minslabs)
+			goto error_tlb;
+		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
+		nareas = limit_nareas(nareas, nslabs);
+		tlb_size = nslabs << IO_TLB_SHIFT;
+	}
 
-	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, 1);
+	slot_order = get_order(array_size(sizeof(*pool->slots), nslabs));
+	pool->slots = (struct io_tlb_slot *)
+		__get_free_pages(gfp, slot_order);
+	if (!pool->slots)
+		goto error_slots;
+
+	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, nareas);
 	return pool;
 
+error_slots:
+	swiotlb_free_tlb(page_address(tlb), tlb_size);
 error_tlb:
 	kfree(pool);
 error:
 	return NULL;
 }
 
+/**
+ * swiotlb_dyn_alloc() - dynamic memory pool allocation worker
+ * @work:	Pointer to dyn_alloc in struct io_tlb_mem.
+ */
+static void swiotlb_dyn_alloc(struct work_struct *work)
+{
+	struct io_tlb_mem *mem =
+		container_of(work, struct io_tlb_mem, dyn_alloc);
+	struct io_tlb_pool *pool;
+
+	pool = swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
+				  default_nareas, mem->phys_limit, GFP_KERNEL);
+	if (!pool) {
+		pr_warn_ratelimited("Failed to allocate new pool");
+		return;
+	}
+
+	add_mem_pool(mem, pool);
+
+	/* Pairs with smp_rmb() in swiotlb_find_pool(). */
+	smp_wmb();
+}
+
 /**
  * swiotlb_dyn_free() - RCU callback to free a memory pool
  * @rcu:	RCU head in the corresponding struct io_tlb_pool.
@@ -670,8 +741,10 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 static void swiotlb_dyn_free(struct rcu_head *rcu)
 {
 	struct io_tlb_pool *pool = container_of(rcu, struct io_tlb_pool, rcu);
+	size_t slots_size = array_size(sizeof(*pool->slots), pool->nslabs);
 	size_t tlb_size = pool->end - pool->start;
 
+	free_pages((unsigned long)pool->slots, get_order(slots_size));
 	swiotlb_free_tlb(pool->vaddr, tlb_size);
 	kfree(pool);
 }
@@ -689,15 +762,19 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
 struct io_tlb_pool *swiotlb_find_pool(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	struct io_tlb_pool *pool = &mem->defpool;
-
-	if (paddr >= pool->start && paddr < pool->end)
-		return pool;
+	struct io_tlb_pool *pool;
 
-	/* Pairs with smp_wmb() in swiotlb_find_slots(). */
+	/* Pairs with smp_wmb() in swiotlb_find_slots() and
+	 * swiotlb_dyn_alloc(), which modify the RCU lists.
+	 */
 	smp_rmb();
 
 	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &mem->pools, node) {
+		if (paddr >= pool->start && paddr < pool->end)
+			goto out;
+	}
+
 	list_for_each_entry_rcu(pool, &dev->dma_io_tlb_pools, node) {
 		if (paddr >= pool->start && paddr < pool->end)
 			goto out;
@@ -1046,18 +1123,24 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	u64 phys_limit;
 	int index;
 
-	pool = &mem->defpool;
-	index = swiotlb_pool_find_slots(dev, pool, orig_addr,
-					alloc_size, alloc_align_mask);
-	if (index >= 0)
-		goto found;
-
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &mem->pools, node) {
+		index = swiotlb_pool_find_slots(dev, pool, orig_addr,
+						alloc_size, alloc_align_mask);
+		if (index >= 0) {
+			rcu_read_unlock();
+			goto found;
+		}
+	}
+	rcu_read_unlock();
 	if (!mem->can_grow)
 		return -1;
 
+	schedule_work(&mem->dyn_alloc);
+
 	nslabs = nr_slots(alloc_size);
 	phys_limit = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
-	pool = swiotlb_alloc_pool(dev, nslabs, phys_limit,
+	pool = swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
 				  GFP_NOWAIT | __GFP_NOWARN);
 	if (!pool)
 		return -1;
@@ -1141,7 +1224,19 @@ static unsigned long mem_pool_used(struct io_tlb_pool *pool)
  */
 static unsigned long mem_used(struct io_tlb_mem *mem)
 {
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	struct io_tlb_pool *pool;
+	unsigned long used = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &mem->pools, node)
+		used += mem_pool_used(pool);
+	rcu_read_unlock();
+
+	return used;
+#else
 	return mem_pool_used(&mem->defpool);
+#endif
 }
 
 #endif /* CONFIG_DEBUG_FS */
@@ -1562,7 +1657,10 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 					 false, nareas);
 		mem->force_bounce = true;
 		mem->for_alloc = true;
-		mem->nslabs = nslabs;
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+		spin_lock_init(&mem->lock);
+#endif
+		add_mem_pool(mem, pool);
 
 		rmem->priv = mem;
 
-- 
2.25.1

