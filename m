Return-Path: <linux-kernel+bounces-74625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865DC85D710
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96A81C22321
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F745945;
	Wed, 21 Feb 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmlv1oAy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76F40BE0;
	Wed, 21 Feb 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515315; cv=none; b=gJQCfjF4pKiHnmfdEz2/PNCFOrFzlEpfN3gnVar5oVrGfQfZYvTVCrR8df5DYXfjEEuNP1dNWou68UfzVKb3AOCDUrahKsqVLkpMc13EpBi68Vuof+STWHRDVlARkQKIASjKydeXL+u5Mg9KgY+g3D53seejN3650iMfqq7G4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515315; c=relaxed/simple;
	bh=DZkEV6s5aP5quEZxpzFqOQnvutbKA7WWR4M+rQsKFsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/nSX8uw+Ot/EsB4zC1lwX4bY1Cx+rWLhHxf7kEaqJeMzMV75MBHbP7sI9Da1lnhFfYGF7fZLi0kOGv2x0uh4k0pjUNUjgh2vsgug3q1mIY3wNqV5ivJMMEFG1Ll6kyqHOL0KW+BmjZs9z+4m/KVL7WyMz2AbKX+MMl7n5E9QEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmlv1oAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FD2C43390;
	Wed, 21 Feb 2024 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515314;
	bh=DZkEV6s5aP5quEZxpzFqOQnvutbKA7WWR4M+rQsKFsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hmlv1oAyagKNMDZ7lQk1uRkrQuLUDueXty1RTJlXzC5X4FVDcTBCLw2r3XqB6z144
	 3MfYBcfu/VqxGA8Gatg71oS8BkXr+V1ZMHns7BL5n+hw8iMSqAxMT7NRdS38XEEIV5
	 TcKeEA4Wb/k3HQt6p2Sm5kzJ9FKJXi59S4rCBAY5TqELNRVlA5QXKR14Qy4tABzMSR
	 XWyo1HmZI3t096eQkKbZ4AHTQfdyKCu8CpDgSiBPvYp6jaY3kT+7X9Me1yirdPPg0z
	 fbER28UFGtG/4Hvb4M/EaoZxmhtBe5NbHvdf1J4+MwduXALUqYyk+OLWR3EAOj4n9C
	 C4/MiqYEkpc3Q==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v4 1/5] swiotlb: Fix double-allocation of slots due to broken alignment handling
Date: Wed, 21 Feb 2024 11:35:00 +0000
Message-Id: <20240221113504.7161-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240221113504.7161-1-will@kernel.org>
References: <20240221113504.7161-1-will@kernel.org>
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
dma_alloc_coherent(), the SWIOTLB search can return page-unaligned
allocations if 'area->index' was left unaligned by a previous allocation
from the buffer:

 # Final address in brackets is the SWIOTLB address returned to the caller
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
 | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)

This ends badly (typically buffer corruption and/or a hang) because
swiotlb_alloc() is expecting a page-aligned allocation and so blindly
returns a pointer to the 'struct page' corresponding to the allocation,
therefore double-allocating the first half (2KiB slot) of the 4KiB page.

Fix the problem by treating the allocation alignment separately to any
additional alignment requirements from the device, using the maximum
of the two as the stride to search the buffer slots and taking care
to ensure a minimum of page-alignment for buffers larger than a page.

Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b079a9a8e087..2ec2cc81f1a2 100644
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
@@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= pool->nareas);
 
+	/*
+	 * For mappings with an alignment requirement don't bother looping to
+	 * unaligned slots once we found an aligned one.
+	 */
+	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
+
 	/*
 	 * For allocations of PAGE_SIZE or larger only look for page aligned
 	 * allocations.
 	 */
 	if (alloc_size >= PAGE_SIZE)
-		iotlb_align_mask |= ~PAGE_MASK;
-	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
-
-	/*
-	 * For mappings with an alignment requirement don't bother looping to
-	 * unaligned slots once we found an aligned one.
-	 */
-	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
+		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > pool->area_nslabs - area->used))
@@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	index = area->index;
 
 	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
-		slot_index = slot_base + index;
+		phys_addr_t tlb_addr;
 
-		if (orig_addr &&
-		    (slot_addr(tbl_dma_addr, slot_index) &
-		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
+		slot_index = slot_base + index;
+		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
+
+		if ((tlb_addr & alloc_align_mask) ||
+		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
+				  (orig_addr & iotlb_align_mask))) {
 			index = wrap_area_index(pool, index + 1);
 			slots_checked++;
 			continue;
-- 
2.44.0.rc0.258.g7320e95886-goog


