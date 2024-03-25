Return-Path: <linux-kernel+bounces-116630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB1B88A173
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962AF2C4A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A0D1534E0;
	Mon, 25 Mar 2024 09:45:23 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06358153569
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355505; cv=none; b=RtOhTGhRUjcg4d8bq3duuxza8cnzN4jSuzmOAm5SGpZC1a8Ulr2G/jcQPSX9O8CkXvs/k/HHvIR2yBJOWpHJkejfeZObumpCvV7bPNNnoitlwYjUnegvxhnGpbu0dk+3zHQb9Ip6yq05K85LffTMol8ki4hW5kXWXe9FcwF0aC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355505; c=relaxed/simple;
	bh=EkQxsNvCXCeshoxUED/Toq5N6LaWQfiIkoXL3HFn6ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6oQDNGQYUDn6iesa5jH4/JZ30h2+rFipzHtTJwS1M5yzjUnarSIEum14IExJ5A/WAl3ssVrmP90UcyWfDwbVO64xBeh0MwfkXyd8LXY13LXCjGT3RGN0q9G/HLmjlwWPH6gBKzkVNaBB8yEX4/lRsUGMmof/onxiSpDmuoDKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4V35H93l05z9xHMY
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:11:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 02A0D14059F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:31:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.223.214])
	by APP2 (Coremail) with SMTP id GxC2BwB3sCRPNgFmUPztBA--.12038S3;
	Mon, 25 Mar 2024 09:31:27 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH v4 1/2] swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
Date: Mon, 25 Mar 2024 09:31:04 +0100
Message-Id: <20240325083105.658-2-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325083105.658-1-petrtesarik@huaweicloud.com>
References: <20240325083105.658-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwB3sCRPNgFmUPztBA--.12038S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rZr4xXw1furyDCrW5Awb_yoW3JrW5pF
	4fJa1rtFWIqF1xCwsF9a95GF1F9w1kCry7Gr4SgryY9ryDXF98XF98A3yYga4FqrWkuF47
	Zas5ur48CF47Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQCb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRsL0oUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Allow a buffer pre-padding of up to alloc_align_mask, even if it requires
allocating additional IO TLB slots.

If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
covers any non-zero bits in the original address between IO_TLB_SIZE and
alloc_align_mask, these bits are not preserved in the swiotlb buffer
address.

To fix this case, increase the allocation size and use a larger offset
within the allocated buffer. As a result, extra padding slots may be
allocated before the mapping start address.

Leave orig_addr in these padding slots initialized to INVALID_PHYS_ADDR.
These slots do not correspond to any CPU buffer, so attempts to sync the
data should be ignored.

The padding slots should be automatically released when the buffer is
unmapped. However, swiotlb_tbl_unmap_single() takes only the address of the
DMA buffer slot, not the first padding slot. Save the number of padding
slots in struct io_tlb_slot and use it to adjust the slot index in
swiotlb_release_slots(), so all allocated slots are properly freed.

Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation and DMA masks are present")
Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshulam.tesarici.cz/
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/swiotlb.c | 59 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 86fe172b5958..d7a8cb93ef2d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -69,11 +69,14 @@
  * @alloc_size:	Size of the allocated buffer.
  * @list:	The free list describing the number of free entries available
  *		from each index.
+ * @pad_slots:	Number of preceding padding slots. Valid only in the first
+ *		allocated non-padding slot.
  */
 struct io_tlb_slot {
 	phys_addr_t orig_addr;
 	size_t alloc_size;
-	unsigned int list;
+	unsigned short list;
+	unsigned short pad_slots;
 };
 
 static bool swiotlb_force_bounce;
@@ -287,6 +290,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 					 mem->nslabs - i);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		mem->slots[i].pad_slots = 0;
 	}
 
 	memset(vaddr, 0, bytes);
@@ -821,12 +825,30 @@ void swiotlb_dev_init(struct device *dev)
 #endif
 }
 
-/*
- * Return the offset into a iotlb slot required to keep the device happy.
+/**
+ * swiotlb_align_offset() - Get required offset into an IO TLB allocation.
+ * @dev:         Owning device.
+ * @align_mask:  Allocation alignment mask.
+ * @addr:        DMA address.
+ *
+ * Return the minimum offset from the start of an IO TLB allocation which is
+ * required for a given buffer address and allocation alignment to keep the
+ * device happy.
+ *
+ * First, the address bits covered by min_align_mask must be identical in the
+ * original address and the bounce buffer address. High bits are preserved by
+ * choosing a suitable IO TLB slot, but bits below IO_TLB_SHIFT require extra
+ * padding bytes before the bounce buffer.
+ *
+ * Second, @align_mask specifies which bits of the first allocated slot must
+ * be zero. This may require allocating additional padding slots, and then the
+ * offset (in bytes) from the first such padding slot is returned.
  */
-static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
+static unsigned int swiotlb_align_offset(struct device *dev,
+					 unsigned int align_mask, u64 addr)
 {
-	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
+	return addr & dma_get_min_align_mask(dev) &
+		(align_mask | (IO_TLB_SIZE - 1));
 }
 
 /*
@@ -847,7 +869,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 		return;
 
 	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
-	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
+	orig_addr_offset = swiotlb_align_offset(dev, 0, orig_addr);
 	if (tlb_offset < orig_addr_offset) {
 		dev_WARN_ONCE(dev, 1,
 			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
@@ -1005,7 +1027,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
+	unsigned int offset = swiotlb_align_offset(dev, 0, orig_addr);
 	unsigned int index, slots_checked, count = 0, i;
 	unsigned long flags;
 	unsigned int slot_base;
@@ -1328,11 +1350,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		unsigned long attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
+	unsigned int offset;
 	struct io_tlb_pool *pool;
 	unsigned int i;
 	int index;
 	phys_addr_t tlb_addr;
+	unsigned short pad_slots;
 
 	if (!mem || !mem->nslabs) {
 		dev_warn_ratelimited(dev,
@@ -1349,6 +1372,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
+	offset = swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
 	index = swiotlb_find_slots(dev, orig_addr,
 				   alloc_size + offset, alloc_align_mask, &pool);
 	if (index == -1) {
@@ -1364,6 +1388,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
+	pad_slots = offset >> IO_TLB_SHIFT;
+	offset &= (IO_TLB_SIZE - 1);
+	index += pad_slots;
+	pool->slots[index].pad_slots = pad_slots;
 	for (i = 0; i < nr_slots(alloc_size + offset); i++)
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
@@ -1384,13 +1412,17 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 {
 	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
 	unsigned long flags;
-	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
-	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
-	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
-	int aindex = index / mem->area_nslabs;
-	struct io_tlb_area *area = &mem->areas[aindex];
+	unsigned int offset = swiotlb_align_offset(dev, 0, tlb_addr);
+	int index, nslots, aindex;
+	struct io_tlb_area *area;
 	int count, i;
 
+	index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
+	index -= mem->slots[index].pad_slots;
+	nslots = nr_slots(mem->slots[index].alloc_size + offset);
+	aindex = index / mem->area_nslabs;
+	area = &mem->areas[aindex];
+
 	/*
 	 * Return the buffer to the free list by setting the corresponding
 	 * entries to indicate the number of contiguous entries available.
@@ -1413,6 +1445,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		mem->slots[i].pad_slots = 0;
 	}
 
 	/*
-- 
2.34.1


