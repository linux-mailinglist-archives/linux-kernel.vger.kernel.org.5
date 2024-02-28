Return-Path: <linux-kernel+bounces-85111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A3B86B08D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4252848FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D3155A45;
	Wed, 28 Feb 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J76irrat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8511552FD;
	Wed, 28 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127585; cv=none; b=fHzmmAtty6rHpm9ctxom1Au3pzkd4SMnNl1Ep1H9vv7awZwGdBtz53gapUCWkfNI/kipRE/2/3e3e4W1AC0TbzY+V5h93ykZ5VFolHPcHUpPLLkDN/xhkcjEApq3m+LBrpnnVh4zVoMYhm47GvFLrDZj3zXgt1JaYiaRy1hsLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127585; c=relaxed/simple;
	bh=b49x/ykHm5o5bbMJSwQ3cpWnXqcs2XbmjOgH/NQ/iTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okOc/Aw272V09JZSPPg03wlrF1r7uHwmrx/N2RmclNCpG1hxlQ/fKknad1uZLir9n5Xbi+VW7KFq4pLD8UnejZQQ+6EHgSL0j/EWY5bu93KLJHKLt5Jr5Ljf7EhUVDXjKPLwrTTibV2h9kPmr04mpBgyCCMCA6dZgMKLdNWV/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J76irrat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663EEC433A6;
	Wed, 28 Feb 2024 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709127584;
	bh=b49x/ykHm5o5bbMJSwQ3cpWnXqcs2XbmjOgH/NQ/iTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J76irratocajmW2SDy9/e8xnA86MTWtA4xigYvKgjwwqiU7OWZwV0TtDgMu/4RZgv
	 BahN412H0Btlb79CeteXuM7H93PJSljNMNet9W+MtP3SPJjIHIzf5btlJGjP7/WVkn
	 kCuJWuHCsxgdFuNVQyhgTaf8QaWHG0itHhL6A3ybkgGYS87LNMkPsl83+DZ/aAgQO3
	 ZjqBrSwlEI81LLJso7aCifnSya/zOyFwyptMWg6/x5fpPNR+/+U7T4dKoE9+TjHbsg
	 kD1v8wOLf/s8gVLxIEfJ121wRZA7/PsNtMntJs3kgE6lGEDGyunYDpBb6zIlgD6Nfr
	 yHnCtsGlW9WFQ==
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
Subject: [PATCH v5 3/6] swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
Date: Wed, 28 Feb 2024 13:39:27 +0000
Message-Id: <20240228133930.15400-4-will@kernel.org>
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
2.44.0.rc1.240.g4c46232300-goog


