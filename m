Return-Path: <linux-kernel+bounces-97233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBEA876761
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2ED284C56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8496D1EB56;
	Fri,  8 Mar 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnCgYEZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589D2C869;
	Fri,  8 Mar 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911727; cv=none; b=HuofwPDQGA1zmoLicIRLGtcV4JIJ0ceiR224zIza8k2xoEndq3uKuR5yk6gOuUWX6cw8EMCQHPxdoaaUxyIvj/76UjPc5b3w5deCBxeTprXhOcTz8x4duo+HveXCqT9nhLloPo6Dc2pmazTSI/Gdtm0voz0dcwk/7nYgmduV/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911727; c=relaxed/simple;
	bh=vsrvrkZU89TFmvM4wV64YJV1Q5GWDF7dRggI1U7nSbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hy3/EstDETaJPmvJwD2mMxQ7nKR2M1gCjwfGFUSzABWlQtwz4SNVCg8Tp+qfe1htg/zXSulf0QNb7eUcSwmV31ogiuLlsEC0Ne2xCY32MRrfFPjDOZyApe0kZQaRqSNqqG+DPZ47czTcb0ZuhGeRd6RAvXf6Ozz6tg09u1+5BMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnCgYEZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43033C433A6;
	Fri,  8 Mar 2024 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709911727;
	bh=vsrvrkZU89TFmvM4wV64YJV1Q5GWDF7dRggI1U7nSbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnCgYEZ4nXN7XpgODKCOquD+5BkcgKUeur8d4aB79bU2sc4SuWWcy6VAwYhwe7+zP
	 ixoNMbZ/sQVOuxsh/9cd/IpRmewfqMxY+G9hw6MjE60Gw6CwfLHAzauU2YwbzCIyXi
	 gQcWsxloGV1qbeS0shCTCsAwCthd5x1YSWScXFg+GEMUOF0+rfFfQXv/e60ZE1PJYX
	 Vml2gU8tAe3fz9qkHLN2xMnE/kN5T+Lrico/ySXdv2o/Rw6r2RygqBytam0+Sc057S
	 zVd44SHp8Bt4p39Att83L8GQOsEZtXrwOmZeSvykGG4aCAsyL3wMJ2AP1wqFoX0wlw
	 yFV8dmbVS08iw==
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
Subject: [PATCH v6 3/6] swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
Date: Fri,  8 Mar 2024 15:28:26 +0000
Message-Id: <20240308152829.25754-4-will@kernel.org>
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
Cc: Dexuan Cui <decui@microsoft.com>
Fixes: e81e99bacc9f ("swiotlb: Support aligned swiotlb buffers")
Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ab7fbb40bc55..c20324fba814 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1633,12 +1633,14 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
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
2.44.0.278.ge034bb2e1d-goog


