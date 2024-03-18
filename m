Return-Path: <linux-kernel+bounces-106143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A50887E9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3066F2822EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DA38F99;
	Mon, 18 Mar 2024 13:05:21 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B138DCC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767120; cv=none; b=XDBKTakYpqvvAYlMpODniQ4RLyDA+TYWoyvWtr8mEFvrzxdiK3ptdZMHedzfhs2m2AiDmKHZ+4OTUaIrpDIFvuxdLHZfwN670TF8BNr9nraVjsbfR+6g9NB0dU7LJR4V4yikyTW5NFLyQg8XyjC7DqfO3+xEGypqRgnvDb1Hkc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767120; c=relaxed/simple;
	bh=vQaqESiP9PmB3DSOWVjUhFKloyVl4seUx+HjrrDxJfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D5WS5E9o4QmdJYy3oESosLQgYxlpz71hoVvplqskhU6Vw5G5TJX5plKGbwmyhsnMsSVfpaePKh6xWBp0OKoH5byHuFnYhPwbpmqFkUr3S/6IyRXv/1KoiaEYR1yvxoD/4MO34Felz+NmlCL3AYkDe0q1/rwUALK6ujOFnJ37YDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TyvnB4N5mz9xqx5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:49:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 325A11400E8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:05:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.220.121])
	by APP2 (Coremail) with SMTP id GxC2BwDXECX4O_hl1WCFBA--.53744S3;
	Mon, 18 Mar 2024 14:05:13 +0100 (CET)
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
Subject: [PATCH v2 1/2] swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
Date: Mon, 18 Mar 2024 14:04:46 +0100
Message-Id: <20240318130447.594-2-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318130447.594-1-petrtesarik@huaweicloud.com>
References: <20240318130447.594-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDXECX4O_hl1WCFBA--.53744S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rZr4xXw1fZw4fKrW5trb_yoW7XFWUpF
	1fta1rKFWDJF1xCanFka18GF1ru34kCrW5CF4SgryY9r1kXrn8ZF98A3yYga4FqFWv9FW2
	v34rur40kF47Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pNPfmDUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Allow a buffer pre-padding of up to alloc_align_mask. If the allocation
alignment is bigger than IO_TLB_SIZE and min_align_mask covers any non-zero
bits in the original address between IO_TLB_SIZE and alloc_align_mask,
these bits are not preserved in the swiotlb buffer address.

To fix this case, increase the allocation size and use a larger offset
within the allocated buffer. As a result, extra padding slots may be
allocated before the mapping start address.

Set the orig_addr in these padding slots to INVALID_PHYS_ADDR, because they
do not correspond to any CPU buffer and the data must never be synced.

The padding slots should be automatically released when the buffer is
unmapped. However, swiotlb_tbl_unmap_single() takes only the address of the
DMA buffer slot, not the first padding slot. Save the number of padding
slots in struct io_tlb_slot and use it to adjust the slot index in
swiotlb_release_slots(), so all allocated slots are properly freed.

Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation and DMA masks are present")
Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshulam.tesarici.cz/
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/swiotlb.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 86fe172b5958..aefb05ff55e7 100644
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
@@ -1328,11 +1332,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
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
@@ -1349,6 +1354,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
+	/*
+	 * Calculate buffer pre-padding within the allocated space. Use it to
+	 * preserve the low bits of the original address according to device's
+	 * min_align_mask. Limit the padding to alloc_align_mask or slot size
+	 * (whichever is bigger); higher bits of the original address are
+	 * preserved by selecting a suitable IO TLB slot.
+	 */
+	offset = orig_addr & dma_get_min_align_mask(dev) &
+		(alloc_align_mask | (IO_TLB_SIZE - 1));
 	index = swiotlb_find_slots(dev, orig_addr,
 				   alloc_size + offset, alloc_align_mask, &pool);
 	if (index == -1) {
@@ -1364,6 +1378,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
+	pad_slots = offset / IO_TLB_SIZE;
+	offset %= IO_TLB_SIZE;
+	index += pad_slots;
+	pool->slots[index].pad_slots = i;
 	for (i = 0; i < nr_slots(alloc_size + offset); i++)
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
@@ -1385,12 +1403,16 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
-	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
-	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
-	int aindex = index / mem->area_nslabs;
-	struct io_tlb_area *area = &mem->areas[aindex];
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
@@ -1413,6 +1435,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		mem->slots[i].pad_slots = 0;
 	}
 
 	/*
-- 
2.34.1


