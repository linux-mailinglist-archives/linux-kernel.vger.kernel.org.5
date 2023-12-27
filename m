Return-Path: <linux-kernel+bounces-12078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9831B81EFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38615B223DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250A45C14;
	Wed, 27 Dec 2023 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="YoaHfAea"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C345957;
	Wed, 27 Dec 2023 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 14300440F4B;
	Wed, 27 Dec 2023 17:02:44 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1703689364;
	bh=st9CHgymVQhW3AqOhh2Rin5cH7JUg2qvgO/LnRxoumc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoaHfAeaNk4IPaAWZfUwbo1ubF56b+leDPEd4c4QmVuIHJy/OFHORP1tdrd0ZBHih
	 GEeHhUgDHV1h40Dm0kVpFDVWGczdYLfWSqAG1frkc4xywnvHxHbuv1SeJJ1tlepZBs
	 tKuxvMy56I8tNUFNZT88w+a/5nPWUwhaJZEgjiYkF4VbUxsNB2VHAlhGp63I8f+btv
	 SFUEnGnn4fgpmh7m10km6y4VqfClzcNVQpB+7O9paBCoYgKksirVPXIh+fcV0xikaj
	 z5Qcpw1ROUGDFlH8BBsmv/kKhaz7blHANDbenLCXGPyyEFuEI/nQStojzw5fwt4pw+
	 ONZwK5p79Fhbw==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>
Subject: [PATCH RFC 3/4] dma-direct: add offset to zone_dma_bits
Date: Wed, 27 Dec 2023 17:04:27 +0200
Message-ID: <fae5b1180161a7d8cd626a96f5df80b0a0796b8b.1703683642.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703683642.git.baruch@tkos.co.il>
References: <cover.1703683642.git.baruch@tkos.co.il>
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

Add 'zone_dma_off' for platform code to set base address for DMA zone.

Rename the dma_direct_supported() local 'min_mask' variable to better
describe its use as limit.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        | 10 ++++++----
 kernel/dma/pool.c          |  2 +-
 kernel/dma/swiotlb.c       |  5 +++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 18aade195884..77c52019c1ff 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -13,6 +13,7 @@
 #include <linux/swiotlb.h>
 
 extern unsigned int zone_dma_bits;
+extern phys_addr_t zone_dma_off;
 
 /*
  * Record the mapping of CPU physical to DMA addresses for a given region.
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 73c95815789a..7a54fa71a174 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -21,6 +21,7 @@
  * override the variable below for dma-direct to work properly.
  */
 unsigned int zone_dma_bits __ro_after_init = 24;
+phys_addr_t zone_dma_off __ro_after_init;
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
@@ -59,7 +60,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 	 * zones.
 	 */
 	*phys_limit = dma_to_phys(dev, dma_limit);
-	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (*phys_limit <= zone_dma_off + DMA_BIT_MASK(zone_dma_bits))
 		return GFP_DMA;
 	if (*phys_limit <= DMA_BIT_MASK(32))
 		return GFP_DMA32;
@@ -566,7 +567,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
+	u64 min_limit = (max_pfn - 1) << PAGE_SHIFT;
 
 	/*
 	 * Because 32-bit DMA masks are so common we expect every architecture
@@ -583,8 +584,9 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * part of the check.
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		min_mask = min_t(u64, min_mask, DMA_BIT_MASK(zone_dma_bits));
-	return mask >= phys_to_dma_unencrypted(dev, min_mask);
+		min_limit = min_t(u64, min_limit,
+				zone_dma_off + DMA_BIT_MASK(zone_dma_bits));
+	return mask >= phys_to_dma_unencrypted(dev, min_limit);
 }
 
 /*
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index b481c48a31a6..0103e932444d 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -70,7 +70,7 @@ static bool cma_in_zone(gfp_t gfp)
 	/* CMA can't cross zone boundaries, see cma_activate_area() */
 	end = cma_get_base(cma) + size - 1;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
-		return end <= DMA_BIT_MASK(zone_dma_bits);
+		return end <= zone_dma_off + DMA_BIT_MASK(zone_dma_bits);
 	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
 		return end <= DMA_BIT_MASK(32);
 	return true;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 33d942615be5..bd3071894d2b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -446,7 +446,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
-		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
+		io_tlb_default_mem.phys_limit =
+			zone_dma_off + DMA_BIT_MASK(zone_dma_bits);
 	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
 		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
 	else
@@ -625,7 +626,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-	if (phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (phys_limit <= zone_dma_off + DMA_BIT_MASK(zone_dma_bits))
 		gfp |= __GFP_DMA;
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
-- 
2.43.0


