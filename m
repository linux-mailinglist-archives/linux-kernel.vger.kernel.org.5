Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A227DEF24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjKBJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKBJp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:45:26 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C2A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:45:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SLdtr5ZwRz9xrtc
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:32:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.78])
        by APP1 (Coremail) with SMTP id LxC2BwAHX5CZb0NlNetiAw--.39757S2;
        Thu, 02 Nov 2023 10:45:03 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH] swiotlb: reduce area lock contention for non-primary IO TLB pools
Date:   Thu,  2 Nov 2023 10:44:45 +0100
Message-Id: <20231102094445.1738-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHX5CZb0NlNetiAw--.39757S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw48XrykuF1DtF17Gry8Zrb_yoW3GF45pF
        4rAFyftFs0qF1xG34jyayrWF1Fkw18KrW7JaySk34F9r1UJr90qFykt34YqFyrGFWxZFW7
        ta90vrWrCF47XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0Ew4C26cxK
        6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUnXdbUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

If multiple areas and multiple IO TLB pools exist, first iterate the
current CPU specific area in all pools. Then move to the next area index.

This is best illustrated by a diagram:

        area 0 |  area 1 | ... | area M |
pool 0    A         B              C
pool 1    D         E
...
pool N    F         G              H

Currently, each pool is searched before moving on to the next pool,
i.e. the search order is A, B ... C, D, E ... F, G ... H. With this patch,
each area is searched in all pools before moving on to the next area,
i.e. the search order is A, D ... F, B, E ... G ... C ... H.

Note that preemption is not disabled, and raw_smp_processor_id() may not
return a stable result, but it is called only once to determine the initial
area index. The search will iterate over all areas eventually, even if the
current task is preempted.

Next, some pools may have less (but not more) areas than default_nareas.
Skip such pools if the distance from the initial area index is greater than
pool->nareas. This logic ensures that for every pool the search starts in
the initial CPU's own area and never tries any area twice.

To verify performance impact, I booted the kernel with a minimum pool
size ("swiotlb=512,4,force"), so multiple pools get allocated, and I ran
these benchmarks:

- small: single-threaded I/O of 4 KiB blocks,
- big: single-threaded I/O of 64 KiB blocks,
- 4way: 4-way parallel I/O of 4 KiB blocks.

The "var" column in the tables below is the coefficient of variance over 5
runs of the test, the "diff" column is the relative difference against base
in read-write I/O bandwidth (MiB/s).

Tested on an x86 VM against a QEMU virtio SATA driver backed by a RAM-based
block device on the host:

	base	   patched
	var	var	diff
small	0.69%	0.62%	+25.4%
big	2.14%	2.27%	+25.7%
4way	2.65%	1.70%	+23.6%

Tested on a Raspberry Pi against a class-10 A1 microSD card:

	base	   patched
	var	var	diff
small	0.53%	1.96%	-0.3%
big	0.02%	0.57%	+0.8%
4way	6.17%	0.40%	+0.3%

These results confirm that there is significant performance boost in the
software IO TLB slot allocation itself. Where performance is dominated by
actual hardware, there is no measurable change.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/swiotlb.c | 90 +++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a1c3dabed19f..35d603ec0329 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -954,7 +954,7 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
 #endif /* CONFIG_DEBUG_FS */
 
 /**
- * swiotlb_area_find_slots() - search for slots in one IO TLB memory area
+ * swiotlb_search_pool_area() - search one memory area in one pool
  * @dev:	Device which maps the buffer.
  * @pool:	Memory pool to be searched.
  * @area_index:	Index of the IO TLB memory area to be searched.
@@ -969,7 +969,7 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
  *
  * Return: Index of the first allocated slot, or -1 on error.
  */
-static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
+static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool,
 		int area_index, phys_addr_t orig_addr, size_t alloc_size,
 		unsigned int alloc_align_mask)
 {
@@ -1063,41 +1063,50 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
 	return slot_index;
 }
 
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+
 /**
- * swiotlb_pool_find_slots() - search for slots in one memory pool
+ * swiotlb_search_area() - search one memory area in all pools
  * @dev:	Device which maps the buffer.
- * @pool:	Memory pool to be searched.
+ * @start_cpu:	Start CPU number.
+ * @cpu_offset:	Offset from @start_cpu.
  * @orig_addr:	Original (non-bounced) IO buffer address.
  * @alloc_size: Total requested size of the bounce buffer,
  *		including initial alignment padding.
  * @alloc_align_mask:	Required alignment of the allocated buffer.
+ * @retpool:	Used memory pool, updated on return.
  *
- * Search through one memory pool to find a sequence of slots that match the
+ * Search one memory area in all pools for a sequence of slots that match the
  * allocation constraints.
  *
  * Return: Index of the first allocated slot, or -1 on error.
  */
-static int swiotlb_pool_find_slots(struct device *dev, struct io_tlb_pool *pool,
-		phys_addr_t orig_addr, size_t alloc_size,
-		unsigned int alloc_align_mask)
+static int swiotlb_search_area(struct device *dev, int start_cpu,
+		int cpu_offset, phys_addr_t orig_addr, size_t alloc_size,
+		unsigned int alloc_align_mask, struct io_tlb_pool **retpool)
 {
-	int start = raw_smp_processor_id() & (pool->nareas - 1);
-	int i = start, index;
-
-	do {
-		index = swiotlb_area_find_slots(dev, pool, i, orig_addr,
-						alloc_size, alloc_align_mask);
-		if (index >= 0)
-			return index;
-		if (++i >= pool->nareas)
-			i = 0;
-	} while (i != start);
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_pool *pool;
+	int area_index;
+	int index = -1;
 
-	return -1;
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &mem->pools, node) {
+		if (cpu_offset >= pool->nareas)
+			continue;
+		area_index = (start_cpu + cpu_offset) & (pool->nareas - 1);
+		index = swiotlb_search_pool_area(dev, pool, area_index,
+						 orig_addr, alloc_size,
+						 alloc_align_mask);
+		if (index >= 0) {
+			*retpool = pool;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return index;
 }
 
-#ifdef CONFIG_SWIOTLB_DYNAMIC
-
 /**
  * swiotlb_find_slots() - search for slots in the whole swiotlb
  * @dev:	Device which maps the buffer.
@@ -1121,18 +1130,17 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	unsigned long nslabs;
 	unsigned long flags;
 	u64 phys_limit;
+	int cpu, i;
 	int index;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(pool, &mem->pools, node) {
-		index = swiotlb_pool_find_slots(dev, pool, orig_addr,
-						alloc_size, alloc_align_mask);
-		if (index >= 0) {
-			rcu_read_unlock();
+	cpu = raw_smp_processor_id();
+	for (i = 0; i < default_nareas; ++i) {
+		index = swiotlb_search_area(dev, cpu, i, orig_addr, alloc_size,
+					    alloc_align_mask, &pool);
+		if (index >= 0)
 			goto found;
-		}
 	}
-	rcu_read_unlock();
+
 	if (!mem->can_grow)
 		return -1;
 
@@ -1145,8 +1153,8 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	if (!pool)
 		return -1;
 
-	index = swiotlb_pool_find_slots(dev, pool, orig_addr,
-					alloc_size, alloc_align_mask);
+	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr,
+					 alloc_size, alloc_align_mask);
 	if (index < 0) {
 		swiotlb_dyn_free(&pool->rcu);
 		return -1;
@@ -1189,9 +1197,21 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size, unsigned int alloc_align_mask,
 		struct io_tlb_pool **retpool)
 {
-	*retpool = &dev->dma_io_tlb_mem->defpool;
-	return swiotlb_pool_find_slots(dev, *retpool,
-				       orig_addr, alloc_size, alloc_align_mask);
+	struct io_tlb_pool *pool;
+	int start, i;
+	int index;
+
+	*retpool = pool = &dev->dma_io_tlb_mem->defpool;
+	i = start = raw_smp_processor_id() & (pool->nareas - 1);
+	do {
+		index = swiotlb_search_pool_area(dev, pool, i, orig_addr,
+						 alloc_size, alloc_align_mask);
+		if (index >= 0)
+			return index;
+		if (++i >= pool->nareas)
+			i = 0;
+	} while (i != start);
+	return -1;
 }
 
 #endif /* CONFIG_SWIOTLB_DYNAMIC */
-- 
2.42.0

