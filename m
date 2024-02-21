Return-Path: <linux-kernel+bounces-74628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B320985D713
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68796283546
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D5C46436;
	Wed, 21 Feb 2024 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFrIla50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546B46557;
	Wed, 21 Feb 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515322; cv=none; b=W9dw+hFt3/Jl3f7xW4sd3e1fliuwmR/rj8CDoDIbfDzyz0IWtBDl9SgS1kQmIDU9aDaaq9gtoWbGxqpbyYwg6xb+O4GPqH6GBRWfCR6CSPfCvfmB3Y2yIcFWzbON7XTmIHgtusVEcDH/HuR2RChhM8DT6y7c059SOhMuUaCfS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515322; c=relaxed/simple;
	bh=Ay0zHMle2EoSZH9+Ztkdc4xcUkKiiiqwiAyt88r4Wt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzFJy/62yG+mlm2YGSvFmrAYY5xnWnJ9Pw/pOELSvHtzaJZ/4nQinMmdhYpnX9Vz737X5rDsBzfGo7s1uhTnlV52tF/k4sU5y5CUjVnZfu2W08w40Iq4tTlVZ7PCelyvukh7lKNkZSZMonCNtukU0ea/6h0SAUz2i5dRMDNi1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFrIla50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E16AC433F1;
	Wed, 21 Feb 2024 11:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515322;
	bh=Ay0zHMle2EoSZH9+Ztkdc4xcUkKiiiqwiAyt88r4Wt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFrIla50aCwBLWXr37fkHe/ZdJAIDpLFrGPnrHHnqAbixhRkmJEhmnm9ru0HJP3Iz
	 /iuQ2EX+2nvdc9EOIepmqns7xzBxJUCpX/YFRbJJz+CriBCFWvJXbFpUW/KrYOvViA
	 qBUIDkfMTBlLg0uJlJDRV7b6S/HUN+//UlHf3/dTffDjeBSJAJ8IjUdVhbSxoZEk/4
	 eroLsFE3q7kdqrLECimCq28uGCnX+kFWO7JGO40hKUiE4KDr2aVpQdfrJB8cgTQFW2
	 U/6GzeYaAmt4vTEfVeb9+weSR+EUxJ2+0YJftJNoDw3cz22u/q42Ppq0DjdimBqFa5
	 PQrS3/qLvLDCg==
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
Subject: [PATCH v4 4/5] swiotlb: Fix alignment checks when both allocation and DMA masks are present
Date: Wed, 21 Feb 2024 11:35:03 +0000
Message-Id: <20240221113504.7161-5-will@kernel.org>
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
2.44.0.rc0.258.g7320e95886-goog


