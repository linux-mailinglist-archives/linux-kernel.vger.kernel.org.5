Return-Path: <linux-kernel+bounces-53276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CDC84A300
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DD51C2482D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0924D9E2;
	Mon,  5 Feb 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmoQR25l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5B4D5A2;
	Mon,  5 Feb 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159703; cv=none; b=TEStmv/W4HEh2xs4ZnHa0gMW9L6OKfT5dd/ZnZrdYylJca7xzWOugSZFR1MzqAbnkTqyYOGJ9E9jhPdnrI/X9Wx8jActuSQ2WMcASEbf9Jp82yoz/FOn4CinjUhVinFdQj6fDaF+NAf1DQmDhhp88/PAZIDesDPc49zS/53SdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159703; c=relaxed/simple;
	bh=hQZUe3sC6qvAlN4FEOPtkqPiMEdJZuABY+olfP99JFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onhezXw0PNdLALIc2dmdLq9lhso9r6kdxNd6q45rbosFwGI5wClEpu6DyIYCXyLYeHlNgIEALwSMeglPE1Lpp+DZSzj/6BUvHlO70B0CHDp2BIEt5eqZVNHmSaYNde6pyt+JTG6CTTcmjGA53lKajO3xserM8g9Q2ztUSz4mrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmoQR25l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB3AC433F1;
	Mon,  5 Feb 2024 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159703;
	bh=hQZUe3sC6qvAlN4FEOPtkqPiMEdJZuABY+olfP99JFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmoQR25ludhgwq7pg6I1EhIk/p8uQEqt8nLNz7TzzLBOX2wlnQlMhVmrCVOaVrDmI
	 oGP61dg+FoZ3JflOYRYPQgaDLxt6gMLeGUImiWBiwoQi3A+DFrUxQWBbvpgteIh7Nf
	 RoNzLKYE075wvJp57XGu+9niQCouMmcWRsD/PyMTjOekbdS4ajwjOj4Y8yNQFANaT6
	 caBhmNO0eWy25b0h8FlrrDvpIze5J1cKCt2I8dfPMPV0j0PkszJ/02+LMdXZgYQQWn
	 BUra+IidX2GQ5qUJH3X0XnOHipUoBWgrjTEas1zkICOsnv7QJwUUWmJ53edEGpT7qN
	 FI3PM05JbV7fA==
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
Subject: [PATCH v3 3/3] swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
Date: Mon,  5 Feb 2024 19:01:27 +0000
Message-Id: <20240205190127.20685-4-will@kernel.org>
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
Fixes: e81e99bacc9f ("swiotlb: Support aligned swiotlb buffers")
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index adbb3143238b..283eea33dd22 100644
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
2.43.0.594.gd9cf4e227d-goog


