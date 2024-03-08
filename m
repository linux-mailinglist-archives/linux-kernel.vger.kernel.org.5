Return-Path: <linux-kernel+bounces-97234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA6876762
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42FC1C2184D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FE3EA8D;
	Fri,  8 Mar 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTUGVGZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1F1EEFD;
	Fri,  8 Mar 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911730; cv=none; b=FnqfgdJzvhV1wqIy+os+vJWSsRNqXSoD1HupzZtuo5/5oWqoGz78Vb5Ox2nko7gMfG2v/iI30lAGcGmMnTJXH67edzlymDWya/2gVpYmiJKQPQVioQdcR3e3922aWF3XsZzUxzQ8ITeekWKxniZQ+ahlLZSLtYlCO9O3rgUkdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911730; c=relaxed/simple;
	bh=n76N/QmTxWzDYO3g7VF7EKTPs6uGGLuTDor+G+M6gCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9plknX4LUBMv30vGIditcy70Ljq/4+U29OJAX9X+95KKqNUpPYg303dmvZGsvNN7a7DZ4ijrEBDmtXssey+portSir27zqHK6p7aMKwflq/jWaVamkOmcYoPspR5e9PGV14WtN8hwPs1pPJXcmFBWS0g/PO5PwC3ZQOqk5vkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTUGVGZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3782C433F1;
	Fri,  8 Mar 2024 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709911730;
	bh=n76N/QmTxWzDYO3g7VF7EKTPs6uGGLuTDor+G+M6gCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTUGVGZz5UkT+wKearzCBeceKmqF7KhauGIuliGwu3VwgUiqOjnIygC569njryNLU
	 3O3iSRsZrDckfRk45+HSxH6MhWSLe2lOxbhh46wWJiXqNiHppDomb6uXKyBiC7WfDR
	 MiCdBsEV7z6XSOvyKwof/V6kW1pS4swtLTQW7xSOotAsbV/NiScHmuB4XY5MLXPHOl
	 Kc6mpbe2FQejG55weRLA5aEHN/DRC9nqkdlhIIPSr9h0KpfnIkV9Y2dITdw3aTGLSd
	 GAIrHnBfr+Rc6dASfIa0RWsfEHCgZ/KEg+Cskl818j00KlRj5gioBBjX0ZfYRFmfbu
	 4+pmM9+zWELZQ==
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
Subject: [PATCH v6 4/6] swiotlb: Fix alignment checks when both allocation and DMA masks are present
Date: Fri,  8 Mar 2024 15:28:27 +0000
Message-Id: <20240308152829.25754-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240308152829.25754-1-will@kernel.org>
References: <20240308152829.25754-1-will@kernel.org>
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
2.44.0.278.ge034bb2e1d-goog


