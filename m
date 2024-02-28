Return-Path: <linux-kernel+bounces-85113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5986B091
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F981C230AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B66F15699F;
	Wed, 28 Feb 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmB8OHgS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3E157E8E;
	Wed, 28 Feb 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127587; cv=none; b=ndBGOhCuLHxmQh5HLPBhUCqqDsr7mUCBptVA4dJOfdobcxdf7MzksqTJ1S2n7bZI2MMqnARIGww+QLT+XMvqqzWnD407yMhGmAmRQbcj/TDBeKHoCFyjy4V5fxmy4amLfb7IAYyecuKSH33fGAs9i5tI7uNugxxrz8xbQZLN+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127587; c=relaxed/simple;
	bh=dxwWmvXzdSSRNkdcGEkNTrMB/45mYo1YIJ2aRH5yEZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+ovFCLKM92PZeiebaVgYiNVlPnss2iIoAwjK3wRHxkWqf/Qwd+cU9+HRRdhjfscUDi1/vTQZHb8uLRyhjNnYnmJKtlYRudWm+oxhBB4vElbtL8akqHUBxXG1tzmgOwWWMoVqG+lfO02C9APMKbUAsFpq27WNrqnAmTWAHVV2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmB8OHgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0115DC433B1;
	Wed, 28 Feb 2024 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709127587;
	bh=dxwWmvXzdSSRNkdcGEkNTrMB/45mYo1YIJ2aRH5yEZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmB8OHgSZHzFyoRS0a5E0qlqyW60IZS83omqXJKgkbElBp3VnU4QXVUd96IDeHblS
	 cQnTR0bae0YQ/gc6istY2EiMzL6JL1E4rDDzEerKy9Cu6Z5p7I3byzknb96ojXpXUp
	 xlsxWkYkV4AnmOwjJEUByvnuRIuuP9j4AsDcGz9GW3klb7tIO3MzE5rVuewi2Qp2pO
	 cvC99Grhqb7/Azhwm7dk9+IDo/crbeloSM40ecGTSKW0c8ix2DYZ+VwcoSLYgYCHAK
	 eW1U88dFw7jyoSAqIITEJfZlDvkeeBx5URecupCW3YEdpzTCSLk+cDeY+9BwxfUpJA
	 CEs6IgHRiddbg==
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
Subject: [PATCH v5 4/6] swiotlb: Fix alignment checks when both allocation and DMA masks are present
Date: Wed, 28 Feb 2024 13:39:28 +0000
Message-Id: <20240228133930.15400-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240228133930.15400-1-will@kernel.org>
References: <20240228133930.15400-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nicolin reports that swiotlb buffer allocations fail for an NVME device
behind an IOMMU using 64KiB pages. This is because we end up with a
minimum allocation alignment of 64KiB (for the IOMMU to map the buffer
safely) but a minimum DMA alignment mask corresponding to a 4KiB NVME
page (i.e. preserving the 4KiB page offset from the original allocation).
If the original address is not 4KiB-aligned, the allocation will fail
because swiotlb_search_pool_area() erroneously compares these unmasked
bits with the 64KiB-aligned candidate allocation.

Tweak swiotlb_search_pool_area() so that the DMA alignment mask is
reduced based on the required alignment of the allocation.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Reported-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/cover.1707851466.git.nicolinc@nvidia.com
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c20324fba814..c381a7ed718f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
-	unsigned int iotlb_align_mask =
-		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
+	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
 	unsigned int nslots = nr_slots(alloc_size), stride;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, slots_checked, count = 0, i;
@@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= pool->nareas);
 
+	/*
+	 * Ensure that the allocation is at least slot-aligned and update
+	 * 'iotlb_align_mask' to ignore bits that will be preserved when
+	 * offsetting into the allocation.
+	 */
+	alloc_align_mask |= (IO_TLB_SIZE - 1);
+	iotlb_align_mask &= ~alloc_align_mask;
+
 	/*
 	 * For mappings with an alignment requirement don't bother looping to
 	 * unaligned slots once we found an aligned one.
-- 
2.44.0.rc1.240.g4c46232300-goog


