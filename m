Return-Path: <linux-kernel+bounces-97236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB297876764
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3241F2320D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEBB56B60;
	Fri,  8 Mar 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWbYXEOa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328E5674C;
	Fri,  8 Mar 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911735; cv=none; b=iO2hrzPkdoi3qrLDmb1dAY0cLifzR2qDUXNVj/NWb7c6GoVng7MkXT+Zmte4VFbzb/PJahB2Hq7EYNHR8egh4rU77KZ0Xct6BfYT7CFr4bLGYllEFPk3n6dFRyyxaqY8atPTvNEik7h+3pCk8n6GGVnpf4C78hYCnbyuM1pWfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911735; c=relaxed/simple;
	bh=bMtbuNa4OfY3K2WJdXy/zJcV5S/fCzZ4bwmKbkY1b0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyAhIp+RHj60HXP9ePW06+K6mV1GSwvi+FhT3jQxcu43u2/4cgWRaS9GMJfQjPYCce0sfc7umX58XNUl+oRlbZR5tMf5U/ctumdE+W+M5OOYDwbbQi1ZCOp+6ACSxE8YVZMysVkny7ysB3NiIlxvXRbP/sCPDv6Qdzong1Jw3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWbYXEOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4AAC43399;
	Fri,  8 Mar 2024 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709911735;
	bh=bMtbuNa4OfY3K2WJdXy/zJcV5S/fCzZ4bwmKbkY1b0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWbYXEOa6wE27t0jsLOmA9bTsLR6V2AlvBrk9RktDdS3R6g9SZe+VXXgiqY5iCmQM
	 BLsOZxtpGCfCeilWAcXaUoe01rL/2+jfsdkGBtf1Mp8hYwzzgT/apZ99IIIK5kBrVq
	 RhHjx7Tb8sR7LP3hknRbpH86ZV/wDKXlRloDx6rQUHWfHd6KgoAIpmzBNdLrPOiE9s
	 RP6DvfPeGP+eQfGB1u93rLXhVuGS+TUzmblBNlnulL7USEx9Z6yh9tPswczTDxQ3m4
	 wGbeGkVm1EKuGnWCWy/P1ueOqelDsezPCP+2b43C3kIcartNXssO36WKyf+3i2OP6B
	 AdWdNeBf6S+TQ==
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
Subject: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE
Date: Fri,  8 Mar 2024 15:28:29 +0000
Message-Id: <20240308152829.25754-7-will@kernel.org>
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

For swiotlb allocations >= PAGE_SIZE, the slab search historically
adjusted the stride to avoid checking unaligned slots. This had the
side-effect of aligning large mapping requests to PAGE_SIZE, but that
was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").

Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
alignment for swiotlb mappings >= PAGE_SIZE.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c381a7ed718f..c5851034523f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -992,6 +992,17 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= pool->nareas);
 
+	/*
+	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
+	 * page-aligned in the absence of any other alignment requirements.
+	 * 'alloc_align_mask' was later introduced to specify the alignment
+	 * explicitly, however this is passed as zero for streaming mappings
+	 * and so we preserve the old behaviour there in case any drivers are
+	 * relying on it.
+	 */
+	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
+		alloc_align_mask = PAGE_SIZE - 1;
+
 	/*
 	 * Ensure that the allocation is at least slot-aligned and update
 	 * 'iotlb_align_mask' to ignore bits that will be preserved when
@@ -1006,13 +1017,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
 	 */
 	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
 
-	/*
-	 * For allocations of PAGE_SIZE or larger only look for page aligned
-	 * allocations.
-	 */
-	if (alloc_size >= PAGE_SIZE)
-		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
-
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > pool->area_nslabs - area->used))
 		goto not_found;
-- 
2.44.0.278.ge034bb2e1d-goog


