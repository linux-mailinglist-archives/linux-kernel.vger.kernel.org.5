Return-Path: <linux-kernel+bounces-136298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFC489D25F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0707B284CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CA7BB07;
	Tue,  9 Apr 2024 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="QHxxcWbm"
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF657441A;
	Tue,  9 Apr 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643941; cv=none; b=gCBM1HJfOihzHluhZYypLBqVvUvP97wb1cvDXk+LmhAQm4CVSRZ8F0Yf4vSMvE57PBAEt8WzPA8LQVMDgJBPmim3ppw+s2mRMaE3rvBQlZCfGsEDFCCpN3QgBpdQi+BqCaWgiZhdVDf4uLDUj4fPxojZTUPRpa6rxinX//quQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643941; c=relaxed/simple;
	bh=0hgo4O4gn7WmugyfT+01Avn3n1mKMQvAQDRnfRZipYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpV6+8Ie7TOm8y6XwnIA7OjaIHyth0qqXiDHzWPEpiUZQPTqIu+W3HN0bUDvh0QOAok0NWiAIsYU5GM1wBQednFuoIPuVQltMKzJuf/E0s7JOg6Xm89oMUYoMUlk3uIAToOFtv8573bDiKssnFULtf0DMNhHFqwumTKrUGALNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=QHxxcWbm; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 9BB83440317;
	Tue,  9 Apr 2024 09:17:44 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1712643465;
	bh=0hgo4O4gn7WmugyfT+01Avn3n1mKMQvAQDRnfRZipYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHxxcWbmyQfXE4BxeT+gjPvaPi11vN5dFnOJCh6m6YGFDE6Ayf9vzoDbb3jvclyxE
	 CV+N6wKFW2R2QiAAHIPg0WoSZZCitar4W0XwFxeOCU6Ai2D0ILnBH7bKtmwl1G17dI
	 SPr0H3+mxsawR/qdRsnQdCnOV/VK98dRPCJ809l6+9bN/SvD8QTz0eTB9sXfTF1Ni7
	 R/Zs0VH2/FkwT+DDYxbE+PCqeb/FK48Sonx6NvR6U5lrErLPSaqzewMWw3lNyhhzyE
	 VNVoE4h+tIMMbffxgZfaLdETp8y05fRfAS+iarX8zrJZJAxr15pEpm6dtoLvfg7ZQr
	 qq+dMKlFlARfw==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH RFC v2 4/5] dma-direct: add base offset to zone_dma_bits
Date: Tue,  9 Apr 2024 09:17:57 +0300
Message-ID: <1d7b0d59590aae631b6f0b894257ab961b907b44.1712642324.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712642324.git.baruch@tkos.co.il>
References: <cover.1712642324.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code using zone_dma_bits assume that all addresses range in the
bits mask are suitable for DMA. For some existing platforms this
assumption is not correct. DMA range might have non zero lower limit.

Add 'zone_dma_base' for platform code to set base address for DMA zone.

Rename the dma_direct_supported() local 'min_mask' variable to better
describe its use as limit.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 include/linux/dma-direct.h | 1 +
 kernel/dma/direct.c        | 9 +++++----
 kernel/dma/pool.c          | 2 +-
 kernel/dma/swiotlb.c       | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 7cf76f1d3239..dd0330cbef81 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -13,6 +13,7 @@
 #include <linux/swiotlb.h>
 
 extern phys_addr_t zone_dma_limit;
+extern phys_addr_t zone_dma_base;
 
 /*
  * Record the mapping of CPU physical to DMA addresses for a given region.
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3b2ebcd4f576..92bb241645d6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -21,6 +21,7 @@
  * override the variable below for dma-direct to work properly.
  */
 phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
+phys_addr_t zone_dma_base __ro_after_init;
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
@@ -59,7 +60,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 	 * zones.
 	 */
 	*phys_limit = dma_to_phys(dev, dma_limit);
-	if (*phys_limit <= zone_dma_limit)
+	if (*phys_limit <= zone_dma_base + zone_dma_limit)
 		return GFP_DMA;
 	if (*phys_limit <= DMA_BIT_MASK(32))
 		return GFP_DMA32;
@@ -567,7 +568,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
+	u64 min_limit = (max_pfn - 1) << PAGE_SHIFT;
 
 	/*
 	 * Because 32-bit DMA masks are so common we expect every architecture
@@ -584,8 +585,8 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * part of the check.
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		min_mask = min_t(u64, min_mask, zone_dma_limit);
-	return mask >= phys_to_dma_unencrypted(dev, min_mask);
+		min_limit = min_t(u64, min_limit, zone_dma_base + zone_dma_limit);
+	return mask >= phys_to_dma_unencrypted(dev, min_limit);
 }
 
 /*
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 410a7b40e496..61a86f3d83ae 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -70,7 +70,7 @@ static bool cma_in_zone(gfp_t gfp)
 	/* CMA can't cross zone boundaries, see cma_activate_area() */
 	end = cma_get_base(cma) + size - 1;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
-		return end <= zone_dma_limit;
+		return end <= zone_dma_base + zone_dma_limit;
 	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
 		return end <= DMA_BIT_MASK(32);
 	return true;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 96d6eee7d215..814052df07c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -446,7 +446,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
-		io_tlb_default_mem.phys_limit = zone_dma_limit;
+		io_tlb_default_mem.phys_limit = zone_dma_base + zone_dma_limit;
 	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
 		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
 	else
@@ -625,7 +625,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-	if (phys_limit <= zone_dma_limit)
+	if (phys_limit <= zone_dma_base + zone_dma_limit)
 		gfp |= __GFP_DMA;
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
-- 
2.43.0


