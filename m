Return-Path: <linux-kernel+bounces-40261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D186C83DD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F66C1C20D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC561DDDB;
	Fri, 26 Jan 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3ayE/Fn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B021DA40;
	Fri, 26 Jan 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282406; cv=none; b=bEwBj9qGdbsrP0RvbADro1wmCBBWJhVDUxbNgGFzkUX3R2RHV8Np28CldSqFmNLss0qsYMuxUYUpwuypKEJjTcR1TdHLzoGBOEabwRlxmNPWqVh5elYIls01QaypDx6QmgQLhOIatSRtU9R243/gauAyoflIyWWaDX3ccSeLxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282406; c=relaxed/simple;
	bh=IaOTRHj9LPjp5M9eMm2qdVLUP107aSzf91gidTkSvWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9sMN2pJZc7wzUY66NslXmPocl5b3JNRkHXTZaTw6mtoAbdmiVf8Z+Ow6VvleZPQ6FrV4+G9qhikTgFn2mQqMdZtrWF7S5SuZqhwhz66Q3XSs8mSqFByQRDwoQ6Ku+DRfC/0H9aazvhikHH7Qbav1OVvZ9fM+M0aaCBOKaJFi3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3ayE/Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836BAC43390;
	Fri, 26 Jan 2024 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706282405;
	bh=IaOTRHj9LPjp5M9eMm2qdVLUP107aSzf91gidTkSvWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3ayE/Fn9qUrBpPZq+5W3FJyuX5GqBTp63p58l2qxg7+H6blNd9wZlwDWF7kcotLe
	 mAQ2M2cVMY7U+Afe9+LBQsIVuIIfrdxAOqwmkzgqfFQ5+5FDytVYwG1Q8tGcDgqY8j
	 70x0R47XfBFdy4K9tpHoeSU4wl2lPUAgAsWGeKToypUqizBXlTRJGJ+dDD+8Wyt67h
	 pSDEWw+/o0yt7LETmE437KAvjuLf1pEqtJF+YOMBmY9ZJaR4kUlhmJXnTJIygKbr+b
	 EPl0ToIEDe7sMwtpdtwarv3G13udX8uXCAeJBkQ0WOrwIfKHO3M+8YtuWcDKMTSyO6
	 rBzIpBpng8Rwg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 1/2] swiotlb: Fix allocation alignment requirement when searching slots
Date: Fri, 26 Jan 2024 15:19:55 +0000
Message-Id: <20240126151956.10014-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240126151956.10014-1-will@kernel.org>
References: <20240126151956.10014-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
checks"), causes a functional regression with vsock in a virtual machine
using bouncing via a restricted DMA SWIOTLB pool.

When virtio allocates the virtqueues for the vsock device using
dma_alloc_coherent(), the SWIOTLB search fails to take into account the
8KiB buffer size and returns page-unaligned allocations if 'area->index'
was left unaligned by a previous allocation from the buffer:

 # Final address in brackets is the SWIOTLB address returned to the caller
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)

This ends in tears (typically buffer corruption and/or a hang) because
swiotlb_alloc() blindly returns the 'struct page' corresponding to the
allocation and therefore the first half of the page ends up being
allocated twice.

Fix the problem by treating the allocation alignment separately to any
additional alignment requirements from the device, using the maximum
of the two as the stride to search the buffer slots.

Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b079a9a8e087..25febb9e670c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
-		dma_get_min_align_mask(dev) | alloc_align_mask;
+		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, slots_checked, count = 0, i;
@@ -998,14 +998,13 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	 * allocations.
 	 */
 	if (alloc_size >= PAGE_SIZE)
-		iotlb_align_mask |= ~PAGE_MASK;
-	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
+		alloc_align_mask |= ~PAGE_MASK;
 
 	/*
 	 * For mappings with an alignment requirement don't bother looping to
 	 * unaligned slots once we found an aligned one.
 	 */
-	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
+	stride = (max(alloc_align_mask, iotlb_align_mask) >> IO_TLB_SHIFT) + 1;
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > pool->area_nslabs - area->used))
@@ -1015,15 +1014,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	index = area->index;
 
 	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
+		phys_addr_t tlb_addr;
+
 		slot_index = slot_base + index;
+		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
+
+		if (tlb_addr & alloc_align_mask)
+			goto next_slot;
 
 		if (orig_addr &&
-		    (slot_addr(tbl_dma_addr, slot_index) &
-		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
-			index = wrap_area_index(pool, index + 1);
-			slots_checked++;
-			continue;
-		}
+		    (tlb_addr & iotlb_align_mask) !=
+		    (orig_addr & iotlb_align_mask))
+			goto next_slot;
 
 		if (!iommu_is_span_boundary(slot_index, nslots,
 					    nr_slots(tbl_dma_addr),
@@ -1033,6 +1035,10 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 		}
 		index = wrap_area_index(pool, index + stride);
 		slots_checked += stride;
+		continue;
+next_slot:
+		index = wrap_area_index(pool, index + 1);
+		slots_checked++;
 	}
 
 not_found:
-- 
2.43.0.429.g432eaa2c6b-goog


