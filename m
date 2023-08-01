Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D676A901
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjHAG1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjHAG05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:26:57 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBAC1BF3;
        Mon, 31 Jul 2023 23:26:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFPwn0Dclz9xHw5;
        Tue,  1 Aug 2023 14:15:21 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.220.249])
        by APP1 (Coremail) with SMTP id LxC2BwCHOroapchkgAwYAA--.27948S6;
        Tue, 01 Aug 2023 07:25:57 +0100 (CET)
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
Subject: [PATCH v7 4/9] swiotlb: separate memory pool data from other allocator data
Date:   Tue,  1 Aug 2023 08:23:59 +0200
Message-Id: <08141a83c31495a8f4cac59a20c8bd6ddd129a2f.1690871004.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHOroapchkgAwYAA--.27948S6
X-Coremail-Antispam: 1UD129KBjvAXoWfCF4rZw4DCr18Wr1xWF1kGrg_yoW8Zw15Zo
        W7GFnrWw4fJryjkFW7Aan3Jr47uayqka1rAF1rZay5Xayjyr4Ygw1fta15Xw13Wr1fGFWx
        AwnxWa48WF4kAr18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOl7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
        Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
        84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
        WxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
        6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
        8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjeOJ5UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Carve out memory pool specific fields from struct io_tlb_mem. The original
struct now contains shared data for the whole allocator, while the new
struct io_tlb_pool contains data that is specific to one memory pool of
(potentially) many.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/device.h  |   2 +-
 include/linux/swiotlb.h |  45 +++++++----
 kernel/dma/swiotlb.c    | 175 +++++++++++++++++++++++++---------------
 3 files changed, 140 insertions(+), 82 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index bbaeabd04b0d..d9754a68ba95 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -625,7 +625,7 @@ struct device_physical_location {
  * @dma_pools:	Dma pools (if dma'ble device).
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
- * @dma_io_tlb_mem: Pointer to the swiotlb pool used.  Not for driver use.
+ * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 31625ae507ea..247f0ab8795a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -62,8 +62,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 #ifdef CONFIG_SWIOTLB
 
 /**
- * struct io_tlb_mem - IO TLB Memory Pool Descriptor
- *
+ * struct io_tlb_pool - IO TLB memory pool descriptor
  * @start:	The start address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
  *		API.
@@ -73,15 +72,34 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb memory pool
  *		may be remapped in the memory encrypted case and store virtual
  *		address for bounce buffer operation.
- * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
- *		@end. For default swiotlb, this is command line adjustable via
- *		setup_io_tlb_npages.
+ * @nslabs:	The number of IO TLB slots between @start and @end. For the
+ *		default swiotlb, this can be adjusted with a boot parameter,
+ *		see setup_io_tlb_npages().
+ * @late_alloc:	%true if allocated using the page allocator.
+ * @nareas:	Number of areas in the pool.
+ * @area_nslabs: Number of slots in each area.
+ * @areas:	Array of memory area descriptors.
+ * @slots:	Array of slot descriptors.
+ */
+struct io_tlb_pool {
+	phys_addr_t start;
+	phys_addr_t end;
+	void *vaddr;
+	unsigned long nslabs;
+	bool late_alloc;
+	unsigned int nareas;
+	unsigned int area_nslabs;
+	struct io_tlb_area *areas;
+	struct io_tlb_slot *slots;
+};
+
+/**
+ * struct io_tlb_mem - Software IO TLB allocator
+ * @defpool:	Default (initial) IO TLB memory pool descriptor.
+ * @nslabs:	Total number of IO TLB slabs in all pools.
  * @debugfs:	The dentry to debugfs.
- * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
- * @nareas:  The area number in the pool.
- * @area_nslabs: The slot number in the area.
  * @total_used:	The total number of slots in the pool that are currently used
  *		across all areas. Used only for calculating used_hiwater in
  *		debugfs.
@@ -89,18 +107,11 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  *		in debugfs.
  */
 struct io_tlb_mem {
-	phys_addr_t start;
-	phys_addr_t end;
-	void *vaddr;
+	struct io_tlb_pool defpool;
 	unsigned long nslabs;
 	struct dentry *debugfs;
-	bool late_alloc;
 	bool force_bounce;
 	bool for_alloc;
-	unsigned int nareas;
-	unsigned int area_nslabs;
-	struct io_tlb_area *areas;
-	struct io_tlb_slot *slots;
 #ifdef CONFIG_DEBUG_FS
 	atomic_long_t total_used;
 	atomic_long_t used_hiwater;
@@ -122,7 +133,7 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
-	return mem && paddr >= mem->start && paddr < mem->end;
+	return mem && paddr >= mem->defpool.start && paddr < mem->defpool.end;
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 66793b59c290..6fc2606e014b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -209,7 +209,7 @@ void __init swiotlb_adjust_size(unsigned long size)
 
 void swiotlb_print_info(void)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 
 	if (!mem->nslabs) {
 		pr_warn("No low mem\n");
@@ -238,7 +238,7 @@ static inline unsigned long nr_slots(u64 val)
  */
 void __init swiotlb_update_mem_attributes(void)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long bytes;
 
 	if (!mem->nslabs || mem->late_alloc)
@@ -247,9 +247,8 @@ void __init swiotlb_update_mem_attributes(void)
 	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
 }
 
-static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
-		unsigned long nslabs, unsigned int flags,
-		bool late_alloc, unsigned int nareas)
+static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
+		unsigned long nslabs, bool late_alloc, unsigned int nareas)
 {
 	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
@@ -261,8 +260,6 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->nareas = nareas;
 	mem->area_nslabs = nslabs / mem->nareas;
 
-	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
-
 	for (i = 0; i < mem->nareas; i++) {
 		spin_lock_init(&mem->areas[i].lock);
 		mem->areas[i].index = 0;
@@ -319,7 +316,7 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long nslabs;
 	unsigned int nareas;
 	size_t alloc_size;
@@ -330,6 +327,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
+	io_tlb_default_mem.force_bounce =
+		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -363,8 +363,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		return;
 	}
 
-	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false,
-				default_nareas);
+	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false,
+				 default_nareas);
+	io_tlb_default_mem.nslabs = nslabs;
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();
@@ -383,7 +384,7 @@ void __init swiotlb_init(bool addressing_limit, unsigned int flags)
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
 	unsigned int nareas;
 	unsigned char *vstart = NULL;
@@ -397,6 +398,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (swiotlb_force_disable)
 		return 0;
 
+	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
+
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -448,8 +451,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 
 	set_memory_decrypted((unsigned long)vstart,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
-	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
-				nareas);
+	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
+				 nareas);
+	io_tlb_default_mem.nslabs = nslabs;
 
 	swiotlb_print_info();
 	return 0;
@@ -463,7 +467,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 
 void __init swiotlb_exit(void)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long tbl_vaddr;
 	size_t tbl_size, slots_size;
 	unsigned int area_order;
@@ -519,7 +523,7 @@ static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
 static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_pool *mem = &dev->dma_io_tlb_mem->defpool;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
@@ -601,7 +605,7 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
 	return nr_slots(boundary_mask + 1);
 }
 
-static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
+static unsigned int wrap_area_index(struct io_tlb_pool *mem, unsigned int index)
 {
 	if (index >= mem->area_nslabs)
 		return 0;
@@ -645,6 +649,7 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
 /**
  * swiotlb_area_find_slots() - search for slots in one IO TLB memory area
  * @dev:	Device which maps the buffer.
+ * @pool:	Memory pool to be searched.
  * @area_index:	Index of the IO TLB memory area to be searched.
  * @orig_addr:	Original (non-bounced) IO buffer address.
  * @alloc_size: Total requested size of the bounce buffer,
@@ -657,15 +662,14 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
  *
  * Return: Index of the first allocated slot, or -1 on error.
  */
-static int swiotlb_area_find_slots(struct device *dev, int area_index,
-		phys_addr_t orig_addr, size_t alloc_size,
+static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
+		int area_index, phys_addr_t orig_addr, size_t alloc_size,
 		unsigned int alloc_align_mask)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	struct io_tlb_area *area = mem->areas + area_index;
+	struct io_tlb_area *area = pool->areas + area_index;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
-		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
+		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) | alloc_align_mask;
@@ -677,7 +681,7 @@ static int swiotlb_area_find_slots(struct device *dev, int area_index,
 	unsigned int slot_index;
 
 	BUG_ON(!nslots);
-	BUG_ON(area_index >= mem->nareas);
+	BUG_ON(area_index >= pool->nareas);
 
 	/*
 	 * For allocations of PAGE_SIZE or larger only look for page aligned
@@ -694,19 +698,19 @@ static int swiotlb_area_find_slots(struct device *dev, int area_index,
 	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
 
 	spin_lock_irqsave(&area->lock, flags);
-	if (unlikely(nslots > mem->area_nslabs - area->used))
+	if (unlikely(nslots > pool->area_nslabs - area->used))
 		goto not_found;
 
-	slot_base = area_index * mem->area_nslabs;
+	slot_base = area_index * pool->area_nslabs;
 	index = area->index;
 
-	for (slots_checked = 0; slots_checked < mem->area_nslabs; ) {
+	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
 		slot_index = slot_base + index;
 
 		if (orig_addr &&
 		    (slot_addr(tbl_dma_addr, slot_index) &
 		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
-			index = wrap_area_index(mem, index + 1);
+			index = wrap_area_index(pool, index + 1);
 			slots_checked++;
 			continue;
 		}
@@ -719,10 +723,10 @@ static int swiotlb_area_find_slots(struct device *dev, int area_index,
 		if (!iommu_is_span_boundary(slot_index, nslots,
 					    nr_slots(tbl_dma_addr),
 					    max_slots)) {
-			if (mem->slots[slot_index].list >= nslots)
+			if (pool->slots[slot_index].list >= nslots)
 				goto found;
 		}
-		index = wrap_area_index(mem, index + stride);
+		index = wrap_area_index(pool, index + stride);
 		slots_checked += stride;
 	}
 
@@ -732,58 +736,79 @@ static int swiotlb_area_find_slots(struct device *dev, int area_index,
 
 found:
 	for (i = slot_index; i < slot_index + nslots; i++) {
-		mem->slots[i].list = 0;
-		mem->slots[i].alloc_size = alloc_size - (offset +
+		pool->slots[i].list = 0;
+		pool->slots[i].alloc_size = alloc_size - (offset +
 				((i - slot_index) << IO_TLB_SHIFT));
 	}
 	for (i = slot_index - 1;
 	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
-	     mem->slots[i].list; i--)
-		mem->slots[i].list = ++count;
+	     pool->slots[i].list; i--)
+		pool->slots[i].list = ++count;
 
 	/*
 	 * Update the indices to avoid searching in the next round.
 	 */
-	area->index = wrap_area_index(mem, index + nslots);
+	area->index = wrap_area_index(pool, index + nslots);
 	area->used += nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
 
-	inc_used_and_hiwater(mem, nslots);
+	inc_used_and_hiwater(dev->dma_io_tlb_mem, nslots);
 	return slot_index;
 }
 
 /**
- * swiotlb_find_slots() - search for slots in the whole swiotlb
+ * swiotlb_pool_find_slots() - search for slots in one memory pool
  * @dev:	Device which maps the buffer.
+ * @pool:	Memory pool to be searched.
  * @orig_addr:	Original (non-bounced) IO buffer address.
  * @alloc_size: Total requested size of the bounce buffer,
  *		including initial alignment padding.
  * @alloc_align_mask:	Required alignment of the allocated buffer.
  *
- * Search through the whole software IO TLB to find a sequence of slots that
- * match the allocation constraints.
+ * Search through one memory pool to find a sequence of slots that match the
+ * allocation constraints.
  *
  * Return: Index of the first allocated slot, or -1 on error.
  */
-static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
-		size_t alloc_size, unsigned int alloc_align_mask)
+static int swiotlb_pool_find_slots(struct device *dev, struct io_tlb_pool *pool,
+		phys_addr_t orig_addr, size_t alloc_size,
+		unsigned int alloc_align_mask)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	int start = raw_smp_processor_id() & (mem->nareas - 1);
+	int start = raw_smp_processor_id() & (pool->nareas - 1);
 	int i = start, index;
 
 	do {
-		index = swiotlb_area_find_slots(dev, i, orig_addr, alloc_size,
-						alloc_align_mask);
+		index = swiotlb_area_find_slots(dev, pool, i, orig_addr,
+						alloc_size, alloc_align_mask);
 		if (index >= 0)
 			return index;
-		if (++i >= mem->nareas)
+		if (++i >= pool->nareas)
 			i = 0;
 	} while (i != start);
 
 	return -1;
 }
 
+/**
+ * swiotlb_find_slots() - search for slots in the whole swiotlb
+ * @dev:	Device which maps the buffer.
+ * @orig_addr:	Original (non-bounced) IO buffer address.
+ * @alloc_size: Total requested size of the bounce buffer,
+ *		including initial alignment padding.
+ * @alloc_align_mask:	Required alignment of the allocated buffer.
+ *
+ * Search through the whole software IO TLB to find a sequence of slots that
+ * match the allocation constraints.
+ *
+ * Return: Index of the first allocated slot, or -1 on error.
+ */
+static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
+		size_t alloc_size, unsigned int alloc_align_mask)
+{
+	return swiotlb_pool_find_slots(dev, &dev->dma_io_tlb_mem->defpool,
+				       orig_addr, alloc_size, alloc_align_mask);
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 /**
@@ -802,6 +827,24 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 
 #else /* !CONFIG_DEBUG_FS */
 
+/**
+ * mem_pool_used() - get number of used slots in a memory pool
+ * @pool:	Software IO TLB memory pool.
+ *
+ * The result is not accurate, see mem_used().
+ *
+ * Return: Approximate number of used slots.
+ */
+static unsigned long mem_pool_used(struct io_tlb_pool *pool)
+{
+	int i;
+	unsigned long used = 0;
+
+	for (i = 0; i < pool->nareas; i++)
+		used += pool->areas[i].used;
+	return used;
+}
+
 /**
  * mem_used() - get number of used slots in an allocator
  * @mem:	Software IO TLB allocator.
@@ -813,12 +856,7 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
  */
 static unsigned long mem_used(struct io_tlb_mem *mem)
 {
-	int i;
-	unsigned long used = 0;
-
-	for (i = 0; i < mem->nareas; i++)
-		used += mem->areas[i].used;
-	return used;
+	return mem_pool_used(&mem->defpool);
 }
 
 #endif /* CONFIG_DEBUG_FS */
@@ -830,6 +868,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
+	struct io_tlb_pool *pool;
 	unsigned int i;
 	int index;
 	phys_addr_t tlb_addr;
@@ -864,9 +903,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
+	pool = &mem->defpool;
 	for (i = 0; i < nr_slots(alloc_size + offset); i++)
-		mem->slots[index + i].orig_addr = slot_addr(orig_addr, i);
-	tlb_addr = slot_addr(mem->start, index) + offset;
+		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
+	tlb_addr = slot_addr(pool->start, index) + offset;
 	/*
 	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
 	 * to the tlb buffer, if we knew for sure the device will
@@ -880,7 +920,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 
 static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_pool *mem = &dev->dma_io_tlb_mem->defpool;
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
@@ -924,7 +964,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
 
-	dec_used(mem, nslots);
+	dec_used(dev->dma_io_tlb_mem, nslots);
 }
 
 /*
@@ -1033,7 +1073,7 @@ bool is_swiotlb_active(struct device *dev)
  */
 phys_addr_t default_swiotlb_base(void)
 {
-	return io_tlb_default_mem.start;
+	return io_tlb_default_mem.defpool.start;
 }
 
 /**
@@ -1043,7 +1083,7 @@ phys_addr_t default_swiotlb_base(void)
  */
 phys_addr_t default_swiotlb_limit(void)
 {
-	return io_tlb_default_mem.end - 1;
+	return io_tlb_default_mem.defpool.end - 1;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1119,6 +1159,7 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_pool *pool;
 	phys_addr_t tlb_addr;
 	int index;
 
@@ -1129,7 +1170,8 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	if (index == -1)
 		return NULL;
 
-	tlb_addr = slot_addr(mem->start, index);
+	pool = &mem->defpool;
+	tlb_addr = slot_addr(pool->start, index);
 
 	return pfn_to_page(PFN_DOWN(tlb_addr));
 }
@@ -1166,29 +1208,34 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	 * to it.
 	 */
 	if (!mem) {
+		struct io_tlb_pool *pool;
+
 		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 		if (!mem)
 			return -ENOMEM;
+		pool = &mem->defpool;
 
-		mem->slots = kcalloc(nslabs, sizeof(*mem->slots), GFP_KERNEL);
-		if (!mem->slots) {
+		pool->slots = kcalloc(nslabs, sizeof(*pool->slots), GFP_KERNEL);
+		if (!pool->slots) {
 			kfree(mem);
 			return -ENOMEM;
 		}
 
-		mem->areas = kcalloc(nareas, sizeof(*mem->areas),
+		pool->areas = kcalloc(nareas, sizeof(*pool->areas),
 				GFP_KERNEL);
-		if (!mem->areas) {
-			kfree(mem->slots);
+		if (!pool->areas) {
+			kfree(pool->slots);
 			kfree(mem);
 			return -ENOMEM;
 		}
 
 		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
 				     rmem->size >> PAGE_SHIFT);
-		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, SWIOTLB_FORCE,
-					false, nareas);
+		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
+					 false, nareas);
+		mem->force_bounce = true;
 		mem->for_alloc = true;
+		mem->nslabs = nslabs;
 
 		rmem->priv = mem;
 
-- 
2.25.1

