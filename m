Return-Path: <linux-kernel+bounces-21190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF88828B84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF288282C88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F43BB26;
	Tue,  9 Jan 2024 17:51:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023373D0B6;
	Tue,  9 Jan 2024 17:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFECC433C7;
	Tue,  9 Jan 2024 17:51:26 +0000 (UTC)
Date: Tue, 9 Jan 2024 17:51:24 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC 3/4] dma-direct: add offset to zone_dma_bits
Message-ID: <ZZ2HnHJV3gdzu1Aj@arm.com>
References: <cover.1703683642.git.baruch@tkos.co.il>
 <fae5b1180161a7d8cd626a96f5df80b0a0796b8b.1703683642.git.baruch@tkos.co.il>
 <ZZw3FDy8800NScEk@arm.com>
 <87msterf7b.fsf@tarshish>
 <ZZ0mAxGupZKRPzWR@arm.com>
 <871qaqr477.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qaqr477.fsf@tarshish>

On Tue, Jan 09, 2024 at 03:54:13PM +0200, Baruch Siach wrote:
> On Tue, Jan 09 2024, Catalin Marinas wrote:
> > On Tue, Jan 09, 2024 at 12:03:43PM +0200, Baruch Siach wrote:
> >> On Mon, Jan 08 2024, Catalin Marinas wrote:
> >> > On Wed, Dec 27, 2023 at 05:04:27PM +0200, Baruch Siach wrote:
> >> >> Current code using zone_dma_bits assume that all addresses range in the
> >> >> bits mask are suitable for DMA. For some existing platforms this
> >> >> assumption is not correct. DMA range might have non zero lower limit.
> >> >> 
> >> >> Add 'zone_dma_off' for platform code to set base address for DMA zone.
> >> >> 
> >> >> Rename the dma_direct_supported() local 'min_mask' variable to better
> >> >> describe its use as limit.
> >> >> 
> >> >> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> >> >
> >> > When I suggested taking the DMA offsets into account, that's not exactly
> >> > what I meant. Based on patch 4, it looks like zone_dma_off is equivalent
> >> > to the lower CPU address. Let's say a system has DRAM starting at 2GB
> >> > and all 32-bit DMA-capable devices has a DMA offset of 0. We want
> >> > ZONE_DMA32 to end at 4GB rather than 6GB.
> >> 
> >> Patch 4 sets zone_dma_off to the lower limit from 'dma-ranges' property
> >> that determines zone_dma_bits. This is not necessarily equivalent to
> >> start of DRAM, though it happens to be that way on my platform.
> >
> > A bit better but it still assumes that all devices have the same DMA
> > offset which may not be the case.
> 
> Current code calculates zone_dma_bits based on the lowest high limit of
> all 'dma-ranges' properties. The assumption appears to be that this
> limit fits all devices. This series does not change this assumption. It
> only extends the logic to the lower limit of the "winning" 'dma-ranges'
> to set the base address for DMA zone.
> 
> Moving to dma_zone_limit would not change that logic. Unless I'm missing
> something.

Indeed, the logic here stays the same. What doesn't work currently is
that we use fls64() of this address and we also cap it to 32 in the
arm64 zone_sizes_init(). On a system where RAM starts at 4GB and we have
a (for example) 30-bit device, zone_dma_bits ends up as 32 (fls64(5G)).
With your patch, IIUC, zone_dma_off would be 4GB in such scenario and
adding DMA_BIT_MASK(zone_dma_bits) to it results in 8GB, not the 5GB
limit that we actually need (the first GB of the RAM).

> Breaking the "one DMA zone fits all devices" assumption as Petr
> suggested is a much larger change.

I don't think we should go this way, we just need to make sure the DMA
zone does not extend above the lowest upper limit of the cpu addresses
in the 'dma-ranges' property. Basically what
of_dma_get_max_cpu_address() gives us but without any capping or
conversion into a power of two. This should cover those sub-32-bit
devices.

See the partial patch below, not really tested (and it breaks powerpc,
s390) but it's easier to discuss on code. In addition, we need to figure
out what to do with ZONE_DMA32 in such case. Do we consider the first
4GB of the RAM or we just don't bother with setting up this zone if the
RAM starts above 4GB, only rely on ZONE_DMA? I'd go with the latter but
needs some thinking.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..0a15628ece7e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -113,36 +113,24 @@ static void __init arch_reserve_crashkernel(void)
 				    low_size, high);
 }
 
-/*
- * Return the maximum physical address for a zone accessible by the given bits
- * limit. If DRAM starts above 32-bit, expand the zone to the maximum
- * available memory, otherwise cap it at 32-bit.
- */
-static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
+static phys_addr_t __init max_zone_phys(phys_addr_t zone_mask)
 {
-	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
-	phys_addr_t phys_start = memblock_start_of_DRAM();
-
-	if (phys_start > U32_MAX)
-		zone_mask = PHYS_ADDR_MAX;
-	else if (phys_start > zone_mask)
-		zone_mask = U32_MAX;
-
 	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
 }
 
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
-	unsigned int __maybe_unused acpi_zone_dma_bits;
-	unsigned int __maybe_unused dt_zone_dma_bits;
-	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
+	phys_addr_t __maybe_unused acpi_zone_dma_limit;
+	phys_addr_t __maybe_unused dt_zone_dma_limit;
+	phys_addr_t __maybe_unused dma32_phys_limit =
+		max_zone_phys(DMA_BIT_MASK(32));
 
 #ifdef CONFIG_ZONE_DMA
-	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
-	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
-	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
-	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
+	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
+	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
+	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
+	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 18aade195884..f55de778612b 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -12,7 +12,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/swiotlb.h>
 
-extern unsigned int zone_dma_bits;
+extern phys_addr_t zone_dma_limit;
 
 /*
  * Record the mapping of CPU physical to DMA addresses for a given region.
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 73c95815789a..1e12c593b6f3 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -20,7 +20,7 @@
  * it for entirely different regions. In that case the arch code needs to
  * override the variable below for dma-direct to work properly.
  */
-unsigned int zone_dma_bits __ro_after_init = 24;
+phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
@@ -59,7 +59,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 	 * zones.
 	 */
 	*phys_limit = dma_to_phys(dev, dma_limit);
-	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (*phys_limit <= zone_dma_limit)
 		return GFP_DMA;
 	if (*phys_limit <= DMA_BIT_MASK(32))
 		return GFP_DMA32;
@@ -583,7 +583,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * part of the check.
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		min_mask = min_t(u64, min_mask, DMA_BIT_MASK(zone_dma_bits));
+		min_mask = min_t(u64, min_mask, zone_dma_limit);
 	return mask >= phys_to_dma_unencrypted(dev, min_mask);
 }
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index b481c48a31a6..af02948adfff 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -70,7 +70,7 @@ static bool cma_in_zone(gfp_t gfp)
 	/* CMA can't cross zone boundaries, see cma_activate_area() */
 	end = cma_get_base(cma) + size - 1;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
-		return end <= DMA_BIT_MASK(zone_dma_bits);
+		return end <= zone_dma_limit;
 	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
 		return end <= DMA_BIT_MASK(32);
 	return true;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 33d942615be5..be76816b3ff9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -446,7 +446,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
 	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA))
-		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(zone_dma_bits);
+		io_tlb_default_mem.phys_limit = zone_dma_limit;
 	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32))
 		io_tlb_default_mem.phys_limit = DMA_BIT_MASK(32);
 	else
@@ -625,7 +625,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-	if (phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (phys_limit <= zone_dma_limit)
 		gfp |= __GFP_DMA;
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;

-- 
Catalin

