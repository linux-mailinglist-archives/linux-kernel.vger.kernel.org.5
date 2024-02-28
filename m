Return-Path: <linux-kernel+bounces-85115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AC86B094
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167B51F24F02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE7158D95;
	Wed, 28 Feb 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHQNrkmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AF158D83;
	Wed, 28 Feb 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127592; cv=none; b=CWtVK5q5VSgRtIiypKjQwA/UYgbBrKEFYF/4eRiuSxYNkjDqmpzUXHQrVdQsAi/BvehnYecJKXgNFkSfUFaukmEa2ZsYJ6Qe5s5HbHBj4aWIUPyKxq22Jf6q9l9agcsxk8jMqp5VB5JyU+ekSa2y3zFgM7wfMtmbDuy3rhpst6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127592; c=relaxed/simple;
	bh=aD3tZMex9G2YUndtdrq37+tQDE+4+Pl1DCirhnA679E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTA7KXf2yOI5fF1qjcRs65BuzpXmMpJHT0EAtlB1vci3rlaoQdswlacdQScfCeU0FTUEJOPqwzcsJgFTPPAmv5JJ9WIakXQcMFh4DQJpifhNNZ6k8VhtvRtpovD7ypn69WsJO6G84xYwQGYJDJbKQ94n5E3DPQjFSWqLb2KCKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHQNrkmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2895CC433A6;
	Wed, 28 Feb 2024 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709127592;
	bh=aD3tZMex9G2YUndtdrq37+tQDE+4+Pl1DCirhnA679E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHQNrkmEgy12WEFe8Jv/6qBhkOgpWG2e1degZiyvn0LRnsKBkD8hP4JCuu/CpirRZ
	 E5WF8pyyGcE2r60DIS5WmAChmo8/4oGap1B0RpdsQBkyekKbiqQXkgZisyOndf5F1I
	 CslGRSqiwlNv/3k8HP/jQ3oEozzZ9SRJVXLmjraro47W5uHsqGvgl5iwzEv+p8g86Y
	 SuAOP/Yv0HD5yJun+tFlSvNzuxnwf9mQzayPmRpn9BwYrwTDEu+aLsLwpQoYNHbO3W
	 VugD2V8V/AXwfyavEVwlfOy6PrZtVkypRCqeIldUmtlJVwuBTG8baksKhrDOgEV83W
	 grPbgFR7fX4bQ==
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
Subject: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for allocations >= PAGE_SIZE
Date: Wed, 28 Feb 2024 13:39:30 +0000
Message-Id: <20240228133930.15400-7-will@kernel.org>
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

For swiotlb allocations >= PAGE_SIZE, the slab search historically
adjusted the stride to avoid checking unaligned slots. However, this is
no longer needed now that the code around it has evolved and the
stride is calculated from the required alignment.

Either 'alloc_align_mask' is used to specify the allocation alignment or
the DMA 'min_align_mask' is used to align the allocation with 'orig_addr'.
At least one of these masks is always non-zero.

In light of that, remove the redundant (and slightly confusing) check.

Link: https://lore.kernel.org/r/SN6PR02MB4157089980E6FC58D5557BCED4572@SN6PR02MB4157.namprd02.prod.outlook.com
Reported-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c381a7ed718f..0d8805569f5e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1006,13 +1006,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
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
2.44.0.rc1.240.g4c46232300-goog


