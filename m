Return-Path: <linux-kernel+bounces-53274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1B84A2FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844BAB26AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6EE4B5BF;
	Mon,  5 Feb 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKWhAX/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E648CFE;
	Mon,  5 Feb 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159699; cv=none; b=CYkotU4VhUsCGFsEW/zABKhkgGfUMXlVoI64HYywpCMF5L4lw4HFLej6WudTs+wORuijmPKeq+n2v6ws4gw7RlEvzWdVtbcyRcMB+wIhsNdE7xdP33/rbuvah70xlbf/brshj5Ad9Xtd3acvIdkU+/VRE0OEgqSJjJcC+ZeWMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159699; c=relaxed/simple;
	bh=q1DctEBmJoDY/umidsjcFfwC11ROonZMe8mf1M+EGs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucKUDpSybKyNGZoM6nMGO4a87yY7QEYJ5bvvBxMKNvdy9pMqBsGSGc3SRRjtiwIChmncXvmTlfLMuRJmEjfLKXBFX+s3nAxZkV/g5Oo0UqkoXqRK1fcTkUoUiVm/Ooqa23Rhd+jZhjU1Mu5ZuDfZjwyOby37rv8p8e6zrTsUcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKWhAX/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123FCC433F1;
	Mon,  5 Feb 2024 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159698;
	bh=q1DctEBmJoDY/umidsjcFfwC11ROonZMe8mf1M+EGs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKWhAX/r0SSww5PSxbVGrO4q2dskM4sK4uZZ20Cpo4oNq83EEsVORFqLLBcsvg2PP
	 HKkKJovaEtF1aHtMHpBu2M5FPMx0c1sJxQb1gA+XcsTU4pf4fhFDl62zvf64zjJtQ/
	 ita18vLaf9lcnMzi5tCBJwA9imsVMITnGmHMtiEbthic8DgGcxJtodc0TAkAjYtrgN
	 GjJo8Y6kvNlhwGNlEh5TN4qVIYDBhazuusrfnLULMhYABHT19ga+W6U2ixDywLJ14W
	 RSRt65VyZSRcDSb4GyYeQLWsskDlQUsx2CRsESpH2uRT6BzhL9bDRz+4dOVsSrxaGX
	 8W5Z7Wqdx/uCg==
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
Subject: [PATCH v3 1/3] swiotlb: Fix double-allocation of slots due to broken alignment handling
Date: Mon,  5 Feb 2024 19:01:25 +0000
Message-Id: <20240205190127.20685-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240205190127.20685-1-will@kernel.org>
References: <20240205190127.20685-1-will@kernel.org>
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
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b079a9a8e087..9ff909a0039a 100644
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
+		stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
 
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
2.43.0.594.gd9cf4e227d-goog


