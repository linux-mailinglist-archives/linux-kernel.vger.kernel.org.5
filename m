Return-Path: <linux-kernel+bounces-110482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33585885F87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590631C236E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E412C522;
	Thu, 21 Mar 2024 17:19:37 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6A56768
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041577; cv=none; b=EffO9pejxiVk32CGD+LGDbSWc2vqFDbVAOzJkAPqcrzLMbKqHmbmbgbnlSbXS5I1qRc8Rqhlu4mGPRmSvTvaXS4RPV63A67jqAJgKg1cfD5wzC7qKP9YywlvWq7zgKtaAvtdQTggWHYIUu/vRNKA80WluZDDq0Uu25vs1ahGwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041577; c=relaxed/simple;
	bh=QjWpu69ZB2LapPnVRTCp2NWYirB57rkknXUmKx7p4XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eW6+pxkUjv4WzxdUC49PRvfGyVYjxkYF2ODlkf6hV5oFGXa3dtphiJvJ/ld2iFWWyokvsD+cE27YfJvwzliLetivEmMFrp3lMr4L/97YR7yl3W+6H+j049ZofoeT9RoEgEK4ZuHY2Q2Ez/Gd0uFaeFwg6YvOfmQEbij2VFt+sp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4V0sBL0CKSz9xGWm
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:59:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D3B7D140135
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:19:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.213.73])
	by APP1 (Coremail) with SMTP id LxC2BwAH_BQNbPxlII6+BA--.51964S3;
	Thu, 21 Mar 2024 18:19:29 +0100 (CET)
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
Subject: [PATCH v3 1/2] swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
Date: Thu, 21 Mar 2024 18:19:01 +0100
Message-Id: <20240321171902.85-2-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321171902.85-1-petrtesarik@huaweicloud.com>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAH_BQNbPxlII6+BA--.51964S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rZr4xXw1furyDCrW5Awb_yoW7Xw4kpF
	1fta1rKFWUJF1xCanFka18GF1ru34kCry5CF4SgryY9r1kXrn8XF90y3yYga4FqrWv9FW2
	va4rur48CF47Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRlfOrUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Allow a buffer pre-padding of up to alloc_align_mask. If the allocation
alignment is bigger than IO_TLB_SIZE and min_align_mask covers any non-zero
bits in the original address between IO_TLB_SIZE and alloc_align_mask,
these bits are not preserved in the swiotlb buffer address.

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
 kernel/dma/swiotlb.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 86fe172b5958..3779a48eec9b 100644
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
+	pool->slots[index].pad_slots = pad_slots;
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


