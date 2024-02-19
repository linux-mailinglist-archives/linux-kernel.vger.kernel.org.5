Return-Path: <linux-kernel+bounces-71187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950785A1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB61B22434
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BC2C69F;
	Mon, 19 Feb 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cT59GSDj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A022C1B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341718; cv=none; b=E+UdSRmirVWSbbJ4myD+oUA+HTauu35M3K+GdZIryFTRQ662UzW5iq+2VhlYMOq9kSgAOcEKGgJJjC5hmAXWvM8M2iPgn54JV9xlQ1YRxK6l/zYPdAtqJySL2i5E2OLEbC62AZe1keL3JnDkcVcv0+a8IaaXXih8t8i0bBVLuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341718; c=relaxed/simple;
	bh=Zqh+3Mt2v/emqmQjBVUt1eEzkbGDcsPozbxTYVR4sOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9FeFbTjLIqFL4RtVGr7G4HozGpznxB9Y9Z5yJGM1mJYNJXIqEQr4zlZ/K4ptmu5E8WA3Ocb+6N4r0DHJ3cvTAKhj7D5YE324opnDvqdyrbQ4BdOZJIKa+51vCtcWpdYvDNcj8l3Dc1dfGzksir9yzExpXJI9QBzmD8E22V4Vhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cT59GSDj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341718; x=1739877718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zqh+3Mt2v/emqmQjBVUt1eEzkbGDcsPozbxTYVR4sOQ=;
  b=cT59GSDj9BKSYHkESZJQfxxbx549XxChlEJ0kUbCrOiKYjfGIdiAJ1KP
   niBA9QLCyw/ZhZOUgx3veOIhhV2/EfbAvF4LK4Th+9THqLVmff09INclS
   nm84AzkmaaRm+9zBFGtrDBcAL/SCAXHyuLboPlNLzsF8cz/oXLAoO3Jzt
   s6temF4ThxSlnuDKHiPT4VmjHAspj3lvJKG8agQDgxaZslIzDlwmwbBS/
   wDGVpoxPF2+8aHwhZzJikzQ9k1n/HHDJbADTLNqW9T/v8ZS/4ambMXaFf
   1kJM+69aMpgiKhQ+U1PrrBCmGj9JT9DhrQRNeGv5HidVrmmlHGJnAezJE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823343"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823343"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826798"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:21:55 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] iommu/vt-d: Add __iommu_flush_iotlb_psi()
Date: Mon, 19 Feb 2024 19:15:53 +0800
Message-Id: <20240219111601.96405-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Add __iommu_flush_iotlb_psi() to do the psi iotlb flush with a DID input
rather than calculating it within the helper.

This is useful when flushing cache for parent domain which reuses DIDs of
its nested domains.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-3-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 78 ++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e393c62776f3..dbdb8366c42a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1368,6 +1368,46 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+static void __iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
+				    unsigned long pfn, unsigned int pages,
+				    int ih)
+{
+	unsigned int aligned_pages = __roundup_pow_of_two(pages);
+	unsigned long bitmask = aligned_pages - 1;
+	unsigned int mask = ilog2(aligned_pages);
+	u64 addr = (u64)pfn << VTD_PAGE_SHIFT;
+
+	/*
+	 * PSI masks the low order bits of the base address. If the
+	 * address isn't aligned to the mask, then compute a mask value
+	 * needed to ensure the target range is flushed.
+	 */
+	if (unlikely(bitmask & pfn)) {
+		unsigned long end_pfn = pfn + pages - 1, shared_bits;
+
+		/*
+		 * Since end_pfn <= pfn + bitmask, the only way bits
+		 * higher than bitmask can differ in pfn and end_pfn is
+		 * by carrying. This means after masking out bitmask,
+		 * high bits starting with the first set bit in
+		 * shared_bits are all equal in both pfn and end_pfn.
+		 */
+		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
+		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+	}
+
+	/*
+	 * Fallback to domain selective flush if no PSI support or
+	 * the size is too big.
+	 */
+	if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu->cap))
+		iommu->flush.flush_iotlb(iommu, did, 0, 0,
+					 DMA_TLB_DSI_FLUSH);
+	else
+		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
+					 DMA_TLB_PSI_FLUSH);
+}
+
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
 				  unsigned long pfn, unsigned int pages,
@@ -1384,42 +1424,10 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (ih)
 		ih = 1 << 6;
 
-	if (domain->use_first_level) {
+	if (domain->use_first_level)
 		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
-	} else {
-		unsigned long bitmask = aligned_pages - 1;
-
-		/*
-		 * PSI masks the low order bits of the base address. If the
-		 * address isn't aligned to the mask, then compute a mask value
-		 * needed to ensure the target range is flushed.
-		 */
-		if (unlikely(bitmask & pfn)) {
-			unsigned long end_pfn = pfn + pages - 1, shared_bits;
-
-			/*
-			 * Since end_pfn <= pfn + bitmask, the only way bits
-			 * higher than bitmask can differ in pfn and end_pfn is
-			 * by carrying. This means after masking out bitmask,
-			 * high bits starting with the first set bit in
-			 * shared_bits are all equal in both pfn and end_pfn.
-			 */
-			shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-			mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
-		}
-
-		/*
-		 * Fallback to domain selective flush if no PSI support or
-		 * the size is too big.
-		 */
-		if (!cap_pgsel_inv(iommu->cap) ||
-		    mask > cap_max_amask_val(iommu->cap))
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-							DMA_TLB_DSI_FLUSH);
-		else
-			iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
-							DMA_TLB_PSI_FLUSH);
-	}
+	else
+		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
 
 	/*
 	 * In caching mode, changes of pages from non-present to present require
-- 
2.34.1


