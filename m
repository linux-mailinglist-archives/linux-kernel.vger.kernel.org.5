Return-Path: <linux-kernel+bounces-156464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B78B0302
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA27B22C45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E727C158DC0;
	Wed, 24 Apr 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2CWu7tv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA77158D9F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943110; cv=none; b=iniEkR8AAzn4VH6SmZ6dK3B5QElmiR4C7JWVc8HZz1TxRIDmX2na6aXnETjLphCL8+hB/ugd8z5bGISPtM0V1YriJ+Qpf17yO7zqxmclgwpPsCH/kKr5hFM6rEiGbVV6VCV1/vYVjKu9rU7ueDWEYNHo1kHxeGBA6qKF1dAnJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943110; c=relaxed/simple;
	bh=gfjLjstbSb1YXyhTBIRHcTJU9gP8ZphgzyzLYbNtQLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UqcmOnjuaSNI3B79Xgwyj5BYtQrx3nCILZCEZdWkDCnFyEIRhDqTi/sf6EEB0jjgLhtOEZ2pAOBtF9++m9CDypv6nem4R7BPLgI36tEzkW1QksTVhz3bQ4pweCM5hzTq4wJ9TMfQPwY8JdebfI/U4F6CRTf42jTHJe1Ki6ILx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2CWu7tv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943109; x=1745479109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gfjLjstbSb1YXyhTBIRHcTJU9gP8ZphgzyzLYbNtQLs=;
  b=U2CWu7tvVTRjgzD1z4Ja4lqFaeh28ecjnYA1AFxwH4eeSQqWvFAoyrP+
   lTlTrU66XHLU9DBx+qHYqKudQLHSBasTkIxb/4PEM9t2aF1AwjITDj7II
   TyAZZ4ngNnIffNTAwUpV4TBbpu5zSet00NtJsDCiZ/6QOxFRRC/0Htddd
   zFKISPWYR583d+xOgXnDM46uRO8FP6ymHD6O2MpPQ2qJGYWoj+abIMf/1
   fwl95Esp6nBcm6fEII7gXJEjp5Ckr6VW5feNNFNVhNddxI4DUV4z8RbR6
   kUge7bnjYAsN2gkY+bOCPz/X7Sli21R8oTpsGCT3dQ1ilZcHL1MpMtPiG
   g==;
X-CSE-ConnectionGUID: mseul2c6TUyEC7/pZhlc4w==
X-CSE-MsgGUID: 3X7KoMLtSOSNO9/iDU7Cqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073168"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073168"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:28 -0700
X-CSE-ConnectionGUID: skLTcX+fQyCjSufbVEe3zQ==
X-CSE-MsgGUID: kB+KkLOKTLyL/G7wvo8GJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665199"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] iommu/vt-d: Add cache tag invalidation helpers
Date: Wed, 24 Apr 2024 15:16:34 +0800
Message-Id: <20240424071644.178250-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several helpers to invalidate the caches after mappings in the
affected domain are changed.

- cache_tag_flush_range() invalidates a range of caches after mappings
  within this range are changed. It uses the page-selective cache
  invalidation methods.

- cache_tag_flush_all() invalidates all caches tagged by a domain ID.
  It uses the domain-selective cache invalidation methods.

- cache_tag_flush_range_np() invalidates a range of caches when new
  mappings are created in the domain and the corresponding page table
  entries change from non-present to present.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  14 +++
 drivers/iommu/intel/cache.c | 195 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  12 ---
 3 files changed, 209 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b7c79cc19681..cb83b0995391 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -35,6 +35,8 @@
 #define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
 #define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
 
+#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
+
 #define VTD_STRIDE_SHIFT        (9)
 #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
 
@@ -1040,6 +1042,13 @@ static inline void context_set_sm_pre(struct context_entry *context)
 	context->lo |= BIT_ULL(4);
 }
 
+/* Returns a number of VTD pages, but aligned to MM page size */
+static inline unsigned long aligned_nrpages(unsigned long host_addr, size_t size)
+{
+	host_addr &= ~PAGE_MASK;
+	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
+}
+
 /* Convert value to context PASID directory size field coding. */
 #define context_pdts(pds)	(((pds) & 0x7) << 9)
 
@@ -1121,6 +1130,11 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void cache_tag_unassign_domain(struct dmar_domain *domain,
 			       struct device *dev, ioasid_t pasid);
+void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
+			   unsigned long end, int ih);
+void cache_tag_flush_all(struct dmar_domain *domain);
+void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
+			      unsigned long end);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 296f1645a739..0539275a9d20 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -12,6 +12,7 @@
 #include <linux/dmar.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 
 #include "iommu.h"
@@ -212,3 +213,197 @@ void cache_tag_unassign_domain(struct dmar_domain *domain,
 	if (domain->domain.type == IOMMU_DOMAIN_NESTED)
 		__cache_tag_unassign_parent_domain(domain->s2_domain, did, dev, pasid);
 }
+
+static unsigned long calculate_psi_aligned_address(unsigned long start,
+						   unsigned long end,
+						   unsigned long *_pages,
+						   unsigned long *_mask)
+{
+	unsigned long pages = aligned_nrpages(start, end - start + 1);
+	unsigned long aligned_pages = __roundup_pow_of_two(pages);
+	unsigned long bitmask = aligned_pages - 1;
+	unsigned long mask = ilog2(aligned_pages);
+	unsigned long pfn = IOVA_PFN(start);
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
+	*_pages = aligned_pages;
+	*_mask = mask;
+
+	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
+}
+
+/*
+ * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
+ * when the memory mappings in the target domain have been modified.
+ */
+void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
+			   unsigned long end, int ih)
+{
+	unsigned long pages, mask, addr;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct intel_iommu *iommu = tag->iommu;
+		struct device_domain_info *info;
+		u16 sid;
+
+		switch (tag->type) {
+		case CACHE_TAG_IOTLB:
+		case CACHE_TAG_NESTING_IOTLB:
+			if (domain->use_first_level) {
+				qi_flush_piotlb(iommu, tag->domain_id,
+						tag->pasid, addr, pages, ih);
+			} else {
+				/*
+				 * Fallback to domain selective flush if no
+				 * PSI support or the size is too big.
+				 */
+				if (!cap_pgsel_inv(iommu->cap) ||
+				    mask > cap_max_amask_val(iommu->cap))
+					iommu->flush.flush_iotlb(iommu, tag->domain_id,
+								 0, 0, DMA_TLB_DSI_FLUSH);
+				else
+					iommu->flush.flush_iotlb(iommu, tag->domain_id,
+								 addr | ih, mask,
+								 DMA_TLB_PSI_FLUSH);
+			}
+			break;
+		case CACHE_TAG_NESTING_DEVTLB:
+			/*
+			 * Address translation cache in device side caches the
+			 * result of nested translation. There is no easy way
+			 * to identify the exact set of nested translations
+			 * affected by a change in S2. So just flush the entire
+			 * device cache.
+			 */
+			addr = 0;
+			mask = MAX_AGAW_PFN_WIDTH;
+			fallthrough;
+		case CACHE_TAG_DEVTLB:
+			info = dev_iommu_priv_get(tag->dev);
+			sid = PCI_DEVID(info->bus, info->devfn);
+
+			if (tag->pasid == IOMMU_NO_PASID)
+				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
+						   info->ats_qdep, addr, mask);
+			else
+				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
+							 tag->pasid, info->ats_qdep,
+							 addr, mask);
+
+			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+/*
+ * Invalidates all ranges of IOVA when the memory mappings in the target
+ * domain have been modified.
+ */
+void cache_tag_flush_all(struct dmar_domain *domain)
+{
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct intel_iommu *iommu = tag->iommu;
+		struct device_domain_info *info;
+		u16 sid;
+
+		switch (tag->type) {
+		case CACHE_TAG_IOTLB:
+		case CACHE_TAG_NESTING_IOTLB:
+			if (domain->use_first_level)
+				qi_flush_piotlb(iommu, tag->domain_id,
+						tag->pasid, 0, -1, 0);
+			else
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 0, 0, DMA_TLB_DSI_FLUSH);
+			break;
+		case CACHE_TAG_DEVTLB:
+		case CACHE_TAG_NESTING_DEVTLB:
+			info = dev_iommu_priv_get(tag->dev);
+			sid = PCI_DEVID(info->bus, info->devfn);
+
+			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+					   0, MAX_AGAW_PFN_WIDTH);
+			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
+						  IOMMU_NO_PASID, info->ats_qdep);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+/*
+ * Invalidate a range of IOVA when new mappings are created in the target
+ * domain.
+ *
+ * - VT-d spec, Section 6.1 Caching Mode: When the CM field is reported as
+ *   Set, any software updates to remapping structures other than first-
+ *   stage mapping requires explicit invalidation of the caches.
+ * - VT-d spec, Section 6.8 Write Buffer Flushing: For hardware that requires
+ *   write buffer flushing, software must explicitly perform write-buffer
+ *   flushing, if cache invalidation is not required.
+ */
+void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
+			      unsigned long end)
+{
+	unsigned long pages, mask, addr;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct intel_iommu *iommu = tag->iommu;
+
+		if (!cap_caching_mode(iommu->cap) || domain->use_first_level) {
+			iommu_flush_write_buffer(iommu);
+			continue;
+		}
+
+		if (tag->type == CACHE_TAG_IOTLB ||
+		    tag->type == CACHE_TAG_NESTING_IOTLB) {
+			/*
+			 * Fallback to domain selective flush if no
+			 * PSI support or the size is too big.
+			 */
+			if (!cap_pgsel_inv(iommu->cap) ||
+			    mask > cap_max_amask_val(iommu->cap))
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 0, 0, DMA_TLB_DSI_FLUSH);
+			else
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 addr, mask,
+							 DMA_TLB_PSI_FLUSH);
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8220bb36e420..473df7cd1672 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -54,11 +54,6 @@
 				__DOMAIN_MAX_PFN(gaw), (unsigned long)-1))
 #define DOMAIN_MAX_ADDR(gaw)	(((uint64_t)__DOMAIN_MAX_PFN(gaw)) << VTD_PAGE_SHIFT)
 
-/* IO virtual address start page frame number */
-#define IOVA_START_PFN		(1)
-
-#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
@@ -1992,13 +1987,6 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 				      domain_context_mapping_cb, domain);
 }
 
-/* Returns a number of VTD pages, but aligned to MM page size */
-static unsigned long aligned_nrpages(unsigned long host_addr, size_t size)
-{
-	host_addr &= ~PAGE_MASK;
-	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
-}
-
 /* Return largest possible superpage level for a given mapping */
 static int hardware_largepage_caps(struct dmar_domain *domain, unsigned long iov_pfn,
 				   unsigned long phy_pfn, unsigned long pages)
-- 
2.34.1


