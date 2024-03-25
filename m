Return-Path: <linux-kernel+bounces-116413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909EB889AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4664E2A3B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2771494C5;
	Mon, 25 Mar 2024 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsmUHEbP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DB15538E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333104; cv=none; b=mvoAWuHpaVdmVgY3qQCWrV3AAQPnySQzdJGkC3xgG2iX7ISesQDov9P1TdG/JukFLj52BtlGKrPUYwMCFLtgTTnkLe+dXwlfJuFFPtUHVG380CyBJk9+PxAqm4z1PkgmdfOzSU3qIYTrJQbFu2Q/6GFIvsBjXD1facdEU6ZEzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333104; c=relaxed/simple;
	bh=0tIbvWia2r+172vtYeoeqKPSZ4y6wUN/0xRGVLV++4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2rt9sAsWqUydVh3xmMwc5uGKcJaOyD5HTTUnahFvMciUig4KSiAhLKknjOSimN+CcLcnHEKwdZSOcJcw2QkGm/YT/Yw7TQFbEy486253TqLb+tRaZBiqmFa8QgM/F2Km6Vpif/eqTtBSZFvhmk4J/Z17pBxsdk3UBVrDnyA5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsmUHEbP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333102; x=1742869102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0tIbvWia2r+172vtYeoeqKPSZ4y6wUN/0xRGVLV++4s=;
  b=ZsmUHEbPUtmHlLJTw8bICxdK9uJhSQ0SviwXMhMEjm2jrp4rvm+GC+tR
   CVHVBJc3xABDO8mJLJi/pjbIS2ekPgzJ7trAb1lL2ClNLAcyuVSf77NIC
   0CTy6MhfRzOytiglLcOpuaCwcG0jwG2gjW9eWpKoyLbIHCetF1VXgWPVy
   C1kdyfPQ7BuhQ6Jyg3/ZiUgFvv80pRFXjBP6UO8AfWWNCGXq7ZoaHYxqM
   CD8q28KUcTdyu+Jppw6JFsXt4k74kO486HqtFiGx6jpawmwRExgOwAW1W
   ggKdeVJQbtap6UF7XRzhCAM4y8cgCghfnsjszSKyBPl4A3LLOGgKrHt3W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271391"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271391"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353970"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 07/12] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
Date: Mon, 25 Mar 2024 10:17:00 +0800
Message-Id: <20240325021705.249769-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cache_tag_flush_range() in switch_to_super_page() to invalidate the
necessary caches when switching mappings from normal to super pages. The
iommu_flush_iotlb_psi() call in intel_iommu_memory_notifier() is
unnecessary since there should be no cache invalidation for the identity
domain.

Clean up iommu_flush_iotlb_psi() after the last call site is removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 175 +-----------------------------------
 1 file changed, 2 insertions(+), 173 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2dcab1e5cd4d..6e019297843b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1389,161 +1389,6 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
 }
 
-static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
-				  u64 addr, unsigned mask)
-{
-	struct dev_pasid_info *dev_pasid;
-	struct device_domain_info *info;
-	unsigned long flags;
-
-	if (!domain->has_iotlb_device)
-		return;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link)
-		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
-		info = dev_iommu_priv_get(dev_pasid->dev);
-
-		if (!info->ats_enabled)
-			continue;
-
-		qi_flush_dev_iotlb_pasid(info->iommu,
-					 PCI_DEVID(info->bus, info->devfn),
-					 info->pfsid, dev_pasid->pasid,
-					 info->ats_qdep, addr,
-					 mask);
-	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
-static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
-				     struct dmar_domain *domain, u64 addr,
-				     unsigned long npages, bool ih)
-{
-	u16 did = domain_id_iommu(domain, iommu);
-	struct dev_pasid_info *dev_pasid;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
-		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages, ih);
-
-	if (!list_empty(&domain->devices))
-		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
-static void __iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
-				    unsigned long pfn, unsigned int pages,
-				    int ih)
-{
-	unsigned int aligned_pages = __roundup_pow_of_two(pages);
-	unsigned long bitmask = aligned_pages - 1;
-	unsigned int mask = ilog2(aligned_pages);
-	u64 addr = (u64)pfn << VTD_PAGE_SHIFT;
-
-	/*
-	 * PSI masks the low order bits of the base address. If the
-	 * address isn't aligned to the mask, then compute a mask value
-	 * needed to ensure the target range is flushed.
-	 */
-	if (unlikely(bitmask & pfn)) {
-		unsigned long end_pfn = pfn + pages - 1, shared_bits;
-
-		/*
-		 * Since end_pfn <= pfn + bitmask, the only way bits
-		 * higher than bitmask can differ in pfn and end_pfn is
-		 * by carrying. This means after masking out bitmask,
-		 * high bits starting with the first set bit in
-		 * shared_bits are all equal in both pfn and end_pfn.
-		 */
-		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
-	}
-
-	/*
-	 * Fallback to domain selective flush if no PSI support or
-	 * the size is too big.
-	 */
-	if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu->cap))
-		iommu->flush.flush_iotlb(iommu, did, 0, 0,
-					 DMA_TLB_DSI_FLUSH);
-	else
-		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
-					 DMA_TLB_PSI_FLUSH);
-}
-
-static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
-				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
-				  int ih, int map)
-{
-	unsigned int aligned_pages = __roundup_pow_of_two(pages);
-	unsigned int mask = ilog2(aligned_pages);
-	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
-	u16 did = domain_id_iommu(domain, iommu);
-
-	if (WARN_ON(!pages))
-		return;
-
-	if (ih)
-		ih = 1 << 6;
-
-	if (domain->use_first_level)
-		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
-	else
-		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
-
-	/*
-	 * In caching mode, changes of pages from non-present to present require
-	 * flush. However, device IOTLB doesn't need to be flushed in this case.
-	 */
-	if (!cap_caching_mode(iommu->cap) || !map)
-		iommu_flush_dev_iotlb(domain, addr, mask);
-}
-
-/*
- * Flush the relevant caches in nested translation if the domain
- * also serves as a parent
- */
-static void parent_domain_flush(struct dmar_domain *domain,
-				unsigned long pfn,
-				unsigned long pages, int ih)
-{
-	struct dmar_domain *s1_domain;
-
-	spin_lock(&domain->s1_lock);
-	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
-		struct device_domain_info *device_info;
-		struct iommu_domain_info *info;
-		unsigned long flags;
-		unsigned long i;
-
-		xa_for_each(&s1_domain->iommu_array, i, info)
-			__iommu_flush_iotlb_psi(info->iommu, info->did,
-						pfn, pages, ih);
-
-		if (!s1_domain->has_iotlb_device)
-			continue;
-
-		spin_lock_irqsave(&s1_domain->lock, flags);
-		list_for_each_entry(device_info, &s1_domain->devices, link)
-			/*
-			 * Address translation cache in device side caches the
-			 * result of nested translation. There is no easy way
-			 * to identify the exact set of nested translations
-			 * affected by a change in S2. So just flush the entire
-			 * device cache.
-			 */
-			__iommu_flush_dev_iotlb(device_info, 0,
-						MAX_AGAW_PFN_WIDTH);
-		spin_unlock_irqrestore(&s1_domain->lock, flags);
-	}
-	spin_unlock(&domain->s1_lock);
-}
-
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	cache_tag_flush_all(to_dmar_domain(domain));
@@ -1995,9 +1840,7 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				 unsigned long end_pfn, int level)
 {
 	unsigned long lvl_pages = lvl_to_nr_pages(level);
-	struct iommu_domain_info *info;
 	struct dma_pte *pte = NULL;
-	unsigned long i;
 
 	while (start_pfn <= end_pfn) {
 		if (!pte)
@@ -2009,13 +1852,8 @@ static void switch_to_super_page(struct dmar_domain *domain,
 					       start_pfn + lvl_pages - 1,
 					       level + 1);
 
-			xa_for_each(&domain->iommu_array, i, info)
-				iommu_flush_iotlb_psi(info->iommu, domain,
-						      start_pfn, lvl_pages,
-						      0, 0);
-			if (domain->nested_parent)
-				parent_domain_flush(domain, start_pfn,
-						    lvl_pages, 0);
+			cache_tag_flush_range(domain, start_pfn << VTD_PAGE_SHIFT,
+					      end_pfn << VTD_PAGE_SHIFT, 0);
 		}
 
 		pte++;
@@ -3387,18 +3225,9 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 	case MEM_OFFLINE:
 	case MEM_CANCEL_ONLINE:
 		{
-			struct dmar_drhd_unit *drhd;
-			struct intel_iommu *iommu;
 			LIST_HEAD(freelist);
 
 			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
-
-			rcu_read_lock();
-			for_each_active_iommu(iommu, drhd)
-				iommu_flush_iotlb_psi(iommu, si_domain,
-					start_vpfn, mhp->nr_pages,
-					list_empty(&freelist), 0);
-			rcu_read_unlock();
 			put_pages_list(&freelist);
 		}
 		break;
-- 
2.34.1


