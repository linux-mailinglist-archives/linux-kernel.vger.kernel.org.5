Return-Path: <linux-kernel+bounces-46418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB2843F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B56C29496C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CDC7BAE5;
	Wed, 31 Jan 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS8Lt+3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891479938;
	Wed, 31 Jan 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703956; cv=none; b=phvaHaEcwLKqBV2fiNoGuOD/ucxEQvoY0bd+Xy23s5ZZ64kfb2y2C/ODJBwmEDlyjAw59+ezHOsO1YuwIa2ocu2mVgmeSqAwBsuecNLLAeWLmV+AfPCbjnHGW5hUWIeOnqZakIQNyARAGkx8R9qcC60VaD/4DTOVOOh+AAAwAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703956; c=relaxed/simple;
	bh=97FSX4oU5s9ZlUZoIaV1rFcSltgv+fl+Z/Ia3ZsihrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdgpoiukA4FV2jxJ4idtvsyjbiE5U9LLtO5VxEEPlNbG0ecZljKTvoEjT51/r27YjA8Q4j7oOxXVSqzJC1soqCnrnaOPm1d6VWkfWY4+Ha035OXis+IdrEVNepm27wmE/c3RWPEX/a/Lb8mSGoElS4W7AR+6ty9yNtKWv8LYFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS8Lt+3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAD9C43390;
	Wed, 31 Jan 2024 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706703956;
	bh=97FSX4oU5s9ZlUZoIaV1rFcSltgv+fl+Z/Ia3ZsihrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PS8Lt+3J3Xs0kHh+rJD0hfTP0DSeJUPH7CN4ilOfxfaxEBTtABTQKFhU1Vt6Fpl2h
	 SXSdHDwsTGoxoDqLkFJctSVVpGe6bcg8D+ruZJSMQ9FtOZvbd2j6ArIUmJTydEP6Vq
	 EtyOYy0RIbZaKV+hZb32fZ/s5BBWwSM3KYRey7qNdeHvVKj0KOC2C77zkelgMAGfM6
	 f1BcJFsEuDj8878ZiNGUZ8oz51mPpdupW5+NYpRewfsMIkoqZRWfkwondppd3ymkBO
	 vNd4nflHvdfxun1SphQ32VxWLLgyY6a49tQ2rU989y6BJ5OHpugMz8mm/PWTuiVa8W
	 nJvTjeNIafLhA==
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
Subject: [PATCH v2 3/3] swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
Date: Wed, 31 Jan 2024 12:25:43 +0000
Message-Id: <20240131122543.14791-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240131122543.14791-1-will@kernel.org>
References: <20240131122543.14791-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

core-api/dma-api-howto.rst states the following properties of
dma_alloc_coherent():

  | The CPU virtual address and the DMA address are both guaranteed to
  | be aligned to the smallest PAGE_SIZE order which is greater than or
  | equal to the requested size.

However, swiotlb_alloc() passes zero for the 'alloc_align_mask'
parameter of swiotlb_find_slots() and so this property is not upheld.
Instead, allocations larger than a page are aligned to PAGE_SIZE,

Calculate the mask corresponding to the page order suitable for holding
the allocation and pass that to swiotlb_find_slots().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4485f216e620..8ec37006ac70 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1632,12 +1632,14 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
 	phys_addr_t tlb_addr;
+	unsigned int align;
 	int index;
 
 	if (!mem)
 		return NULL;
 
-	index = swiotlb_find_slots(dev, 0, size, 0, &pool);
+	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
+	index = swiotlb_find_slots(dev, 0, size, align, &pool);
 	if (index == -1)
 		return NULL;
 
-- 
2.43.0.429.g432eaa2c6b-goog


