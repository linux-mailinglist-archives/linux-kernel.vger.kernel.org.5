Return-Path: <linux-kernel+bounces-156455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D98B02F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9701F22C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77F8157A7D;
	Wed, 24 Apr 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKMi5ahd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FC156C60
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943091; cv=none; b=FO0nTghcgxsEx2ZagB7+1Ka0W3bIjfWXQesUK/kWt5/i10WFRcO1I7RZaSo+YtvApH/0k0PWSm1ZiWJAw+kHFKcqsmuy7cDRSlVsnOBsYfM3DM+MCIB+KdaXzPc9NfqIwxQa/pLyAWyJETDN7Rlwx0KaQZC0lwEbyQ5JuhNvSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943091; c=relaxed/simple;
	bh=fh6/DxXJ6QlVYvQYFKUidpUtVMeGrajPzaBj/RdCU+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mpLoLtfT14t/Nki25bYKySbvpg2cbAqrjnXjKkX03b1lzlMQPhutL5dduFyrn+jooWEK28L3eBQ8ZKPRjI+LLrCXyLrnKBXn7/UbngEiRykjaoc1i5bCc7mFl/mB1NcwGb0q0aFOy3T6O6smrQh9KNNcJdCPHGW/LO40uAiJDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKMi5ahd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943090; x=1745479090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fh6/DxXJ6QlVYvQYFKUidpUtVMeGrajPzaBj/RdCU+g=;
  b=oKMi5ahdECFQ/bvLI5AwfNnr7JHGQLSArsMowS2+n8JGcek1qizXukZT
   fdEQvi2CBAfJy19+IYObvdhgy3bLpfm6+TAB+Xt4o9zi5QSukDO8UfOyy
   wPMWuLNoqbLab+X3y6zDrfOvtnxYtuPcwJT+S5JptA26Ai+Nd26mVzNKa
   khPySd7awhlc66FkMoKFwUB2C5CBF4rabp4GEHKz8l12ek6WUsyWUyvMl
   JzRd2NV/ik6daBXjx1c09q1aGU1EEL+1fhkkty0DQ08lU+7hXaSBbHAv6
   mqNIoYirfAYYMgGrVcgyfU9pCIjtl73IdkmdL92AAvkEDTf8Z2UDqK2YB
   A==;
X-CSE-ConnectionGUID: l1d7sblvQNm3A3bL2AgXxA==
X-CSE-MsgGUID: rbyENVBwTzmp6CwvIzocig==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073065"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073065"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:10 -0700
X-CSE-ConnectionGUID: c6Nn8hQVRCmH8gGApFwHJw==
X-CSE-MsgGUID: UM3Mw8hJSR2Nw6Kg6pt8NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24664561"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/18] [PULL REQUEST] Intel IOMMU updates for v6.10
Date: Wed, 24 Apr 2024 15:16:26 +0800
Message-Id: <20240424071644.178250-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.10-rc1:

 - Consolidate domain cache invalidation
 - Remove private data from page fault message
 - Allocate DMAR fault interrupts locally
 - Cleanup and refactoring

Unfortunately, there is a merge conflict with the next branch, in
drivers/iommu/intel/iommu.c. I resolved this conflict as below.

All patches are based on v6.9-rc5. The whole code after merging into the
next branch is available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.10

diff --cc drivers/iommu/intel/iommu.c
index 916cdb65d849,7abe76f92a3c..daf0e9b067e6
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@@ -860,9 -850,9 +845,9 @@@ static struct dma_pte *pfn_to_dma_pte(s
  			break;
  
  		if (!dma_pte_present(pte)) {
 -			uint64_t pteval;
 +			uint64_t pteval, tmp;
  
- 			tmp_page = alloc_pgtable_page(domain->nid, gfp);
+ 			tmp_page = iommu_alloc_page_node(domain->nid, gfp);
  
  			if (!tmp_page)
  				return NULL;
@@@ -872,10 -862,9 +857,10 @@@
  			if (domain->use_first_level)
  				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
  
 -			if (cmpxchg64(&pte->val, 0ULL, pteval))
 +			tmp = 0ULL;
 +			if (!try_cmpxchg64(&pte->val, &tmp, pteval))
  				/* Someone else set it while we were thinking; use theirs. */
- 				free_pgtable_page(tmp_page);
+ 				iommu_free_page(tmp_page);
  			else
  				domain_flush_cache(domain, pte, sizeof(*pte));
  		}
@@@ -3226,7 -3402,16 +3211,7 @@@ static int intel_iommu_memory_notifier(
  			LIST_HEAD(freelist);
  
  			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
- 			put_pages_list(&freelist);
 -
 -			rcu_read_lock();
 -			for_each_active_iommu(iommu, drhd)
 -				iommu_flush_iotlb_psi(iommu, si_domain,
 -					start_vpfn, mhp->nr_pages,
 -					list_empty(&freelist), 0);
 -			rcu_read_unlock();
+ 			iommu_put_pages_list(&freelist);
  		}
  		break;
  	}
@@@ -3921,9 -4107,26 +3906,9 @@@ static size_t intel_iommu_unmap_pages(s
  static void intel_iommu_tlb_sync(struct iommu_domain *domain,
  				 struct iommu_iotlb_gather *gather)
  {
 -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 -	unsigned long iova_pfn = IOVA_PFN(gather->start);
 -	size_t size = gather->end - gather->start;
 -	struct iommu_domain_info *info;
 -	unsigned long start_pfn;
 -	unsigned long nrpages;
 -	unsigned long i;
 -
 -	nrpages = aligned_nrpages(gather->start, size);
 -	start_pfn = mm_to_dma_pfn_start(iova_pfn);
 -
 -	xa_for_each(&dmar_domain->iommu_array, i, info)
 -		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
 -				      start_pfn, nrpages,
 -				      list_empty(&gather->freelist), 0);
 -
 -	if (dmar_domain->nested_parent)
 -		parent_domain_flush(dmar_domain, start_pfn, nrpages,
 -				    list_empty(&gather->freelist));
 +	cache_tag_flush_range(to_dmar_domain(domain), gather->start,
 +			      gather->end, list_empty(&gather->freelist));
- 	put_pages_list(&gather->freelist);
+ 	iommu_put_pages_list(&gather->freelist);
  }
  
  static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
@@@ -4366,20 -4573,27 +4351,15 @@@ static int intel_iommu_iotlb_sync_map(s
  	return 0;
  }
  
- static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+ 					 struct iommu_domain *domain)
  {
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
+ 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
  	struct dev_pasid_info *curr, *dev_pasid = NULL;
  	struct intel_iommu *iommu = info->iommu;
- 	struct dmar_domain *dmar_domain;
- 	struct iommu_domain *domain;
  	unsigned long flags;
  
- 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
- 	if (WARN_ON_ONCE(!domain))
 -	/*
 -	 * The SVA implementation needs to handle its own stuffs like the mm
 -	 * notification. Before consolidating that code into iommu core, let
 -	 * the intel sva code handle it.
 -	 */
 -	if (domain->type == IOMMU_DOMAIN_SVA) {
 -		intel_svm_remove_dev_pasid(dev, pasid);
--		goto out_tear_down;
- 	dmar_domain = to_dmar_domain(domain);
 -	}
--
  	spin_lock_irqsave(&dmar_domain->lock, flags);
  	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
  		if (curr->dev == dev && curr->pasid == pasid) {

With above in mind, please consider them for v6.10.

Best regards,
baolu

Colin Ian King (1):
  iommu/vt-d: Remove redundant assignment to variable err

Dimitri Sivanich (1):
  iommu/vt-d: Allocate DMAR fault interrupts locally

Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Jingqi Liu (2):
  iommu/vt-d: Remove debugfs use of private data field
  iommu/vt-d: Remove private data use in fault message

Lu Baolu (12):
  iommu/vt-d: Remove caching mode check before device TLB flush
  iommu/vt-d: Add cache tag assignment interface
  iommu/vt-d: Add cache tag invalidation helpers
  iommu/vt-d: Add trace events for cache tag interface
  iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
  iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
  iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
  iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
  iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
  iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
  iommu/vt-d: Remove intel_svm_dev
  iommu/vt-d: Remove struct intel_svm

Uros Bizjak (1):
  iommu/vt-d: Use try_cmpxchg64{,_local}() in iommu.c

 include/linux/dmar.h          |   2 +-
 include/linux/iommu.h         |   6 +-
 drivers/iommu/amd/amd_iommu.h |   2 +-
 drivers/iommu/intel/iommu.h   |  86 +++++--
 drivers/iommu/intel/perf.h    |   1 -
 drivers/iommu/intel/trace.h   |  97 ++++++++
 drivers/iommu/irq_remapping.h |   2 +-
 drivers/iommu/amd/init.c      |   2 +-
 drivers/iommu/intel/cache.c   | 419 ++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/debugfs.c |   7 -
 drivers/iommu/intel/dmar.c    |  10 +-
 drivers/iommu/intel/iommu.c   | 300 +++---------------------
 drivers/iommu/intel/nested.c  |  69 ++----
 drivers/iommu/intel/svm.c     | 372 +++++++-----------------------
 drivers/iommu/iommu-sva.c     |  16 +-
 drivers/iommu/irq_remapping.c |   5 +-
 drivers/iommu/intel/Makefile  |   2 +-
 17 files changed, 743 insertions(+), 655 deletions(-)
 create mode 100644 drivers/iommu/intel/cache.c

-- 
2.34.1


