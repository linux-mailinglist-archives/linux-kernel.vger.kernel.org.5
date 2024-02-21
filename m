Return-Path: <linux-kernel+bounces-74627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261EF85D712
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC3BB229EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1745BE3;
	Wed, 21 Feb 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0sBwdZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5546436;
	Wed, 21 Feb 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515320; cv=none; b=gzpaFFJsbA0iJQnL2sK8AnVaFDDl7SpoXwjEB3j8eZprJJB2Lv2g0rS1A0Y3JahHerdeDZAKn3WKCPQugCXNFkvkTYUsPpFbDnPiXd8qiss+onToZA17xSjZGUJNvNzdt862W0Xmmk9PvQqO4IOsUGMzcH8g1iusoYA9G99D9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515320; c=relaxed/simple;
	bh=VIfdB40mPKeGpRjLdseuZPhrPH2I9FgxnF4NhRToiQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOrboZjzz0gg7EWqZhKzb/6LGZyuxzhNS4xyuJM31bMC89Wg1LglmzN6hQvU96Ki+Mj+1HWbHXbWttqI6g0JzME8drTsRrh4ZvljrC2c0Hr3it4zkeFx9Y4I85/DVorOWfFydfcw8UNfx9HRKF+0y1OCJIRcx0IIBz+udw+vqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0sBwdZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F70C43390;
	Wed, 21 Feb 2024 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515319;
	bh=VIfdB40mPKeGpRjLdseuZPhrPH2I9FgxnF4NhRToiQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0sBwdZ43tBOm8bQ6pbQMpxjNYBZGxcdwUAVZR9mCB1h2pGI/Zarvg+PUGCEocdC8
	 5Me8Id80ygsdrJQqtOloQh9dbvaMLdvaWzsNgs9InPJQGSB+QJKslKsm2eVvRcvWIn
	 TdAERFKSxNAWbd7MnHnhdHNXNIlW3uFh08nXz6peJ2UyJRYOs9WGYNM88NcuCcETbD
	 KPOzgm4u8M0SdtFm9PiD/BHFlTv5ZjyxDV6FCnNs4YKub1cTJjj4RYD/GEbzuUnvB0
	 UnRpBQBtVgi4cve1lBQFy6AjtTQU1V5nHYu3IdrWhru/iIoUCA202dCBQjeA0cTUKA
	 B9L5v0vySUmEw==
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
Subject: [PATCH v4 3/5] swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
Date: Wed, 21 Feb 2024 11:35:02 +0000
Message-Id: <20240221113504.7161-4-will@kernel.org>
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
2.44.0.rc0.258.g7320e95886-goog


