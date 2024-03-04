Return-Path: <linux-kernel+bounces-90541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209488700EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45A41F21FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCE3B79E;
	Mon,  4 Mar 2024 12:05:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D03A8E1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553950; cv=none; b=tJdc2xGo4ozsAbag/ipzBXiGDJx2Ysn2ZA28BpoepXlC4YXfAJMa78qZS+MavcTwI8qGT4rLP5K6r6HnooUu6YRbSwZykbHCULkKZzaFhHEOvokZsBuJ1olWdgSwuz/TMFa+vRo6HULVfcf3LnnXYoML3XZy+c1KH1O1lTyzfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553950; c=relaxed/simple;
	bh=KAwUc2Kbgvw1J573Drd3ZQTYc3qRXADwMtlZMDBhq2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NGCQHOUXIMSxGoblIOBp5MnlD+pvUBn8AXTTE8milBuNcDDw2+Yl6Czc6WFScL/7mmcACPlC8We9sy1rnl86S8xxjodmsi66W+MSBXlCHr81fOqdqxo8B+/3mzIcnrlnQAYy1pbdj6jznCYFS/5Mv8Nl7n/pp5IoOh7Hbl9nEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E22411FB;
	Mon,  4 Mar 2024 04:06:24 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BC463F738;
	Mon,  4 Mar 2024 04:05:46 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	mhklinux@outlook.com,
	petr@tesarici.cz,
	hch@lst.de
Subject: [PATCH] iommu/dma: Document min_align_mask assumption
Date: Mon,  4 Mar 2024 12:05:42 +0000
Message-Id: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu-dma does not explicitly reference min_align_mask since we already
assume that that will be less than or equal to any typical IOVA granule.
We wouldn't realistically expect to see the case where it is larger, and
that would be non-trivial to support, however for the sake of reasoning
(particularly around the interaction with SWIOTLB), let's clearly
enforce the assumption.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..b58f5a3311c3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -859,6 +859,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	    iommu_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
+	/* If anyone ever wants this we'd need support in the IOVA allocator */
+	if (dev_WARN_ONCE(dev, dma_get_min_align_mask(dev) > iova_mask(iovad),
+	    "Unsupported alignment constraint\n"))
+		return DMA_MAPPING_ERROR;
+
 	size = iova_align(iovad, size + iova_off);
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
-- 
2.39.2.101.g768bb238c484.dirty


