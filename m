Return-Path: <linux-kernel+bounces-116419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B2889AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863FA1C33D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCA14A090;
	Mon, 25 Mar 2024 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivvMJAAC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B2155391
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333109; cv=none; b=P8ZXDVEmcQLFVQzWQygAPDxZrSfiaGKVmTo9upZQMPINhkyRnD6sO4S93egPIC4ZaZDGPeZA65ThoFSf/iffWTcGpN8Xdx8u+FdP5I72BEnLLUcjwqCT0YjUVb1dK3ZP/h5LBxLLIwCvb9uiXUkPoJdOO6HJoyqSFXzUTIj7RhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333109; c=relaxed/simple;
	bh=UjPXkQ6AmKr1iNLH78v2nHs2xpUcx0lFy26N8z4uNc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jP9DEHht7WyjwNUaK/cClNRh8iT8bDVGa174Ygu745OfG27VqvkVZTaal2rJ8AQcYU/TP0NU5gDMlYs9rFqxhO14HLpQM8BW5QOPcs7uI1ven9K2ZHRnt2hgfMj6Xp1jjDwEdT1P9SDN4imHGpNiHb8v0KPiXbs6VayvpQepxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivvMJAAC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333107; x=1742869107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UjPXkQ6AmKr1iNLH78v2nHs2xpUcx0lFy26N8z4uNc8=;
  b=ivvMJAACE6A95XhAvTR1FimfFOyWyMgaIlODixcmBt0np1pFWtmTFWvt
   OvikrXbv+d3vfBJYxZe5WzuBrMQdxxJHNsYjv5ogBa88+NdEaci3NnTPQ
   bg4NFbd74+kJrLmXR8HRNKybLeFdCguT4PVh+Z5o45wZCSGt5D6No4QJs
   SjSrSaFHw9iPL/BhYCu6xQf9ootaIH0I4JM+QPsd+KdTJmecQdb5LEI8w
   Qc1VNXYPw6pROvvR86QEzAY/icaheGCUzyA3VVaC7YWrBKihXGnAc72cC
   lGahwK8PG6kM2DgVSwv/Jk8j5rFsTm4oLnf/QkepxgZ7L7TpDHw16b3Zl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271428"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353997"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:23 -0700
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
Subject: [PATCH 09/12] iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
Date: Mon, 25 Mar 2024 10:17:02 +0800
Message-Id: <20240325021705.249769-10-baolu.lu@linux.intel.com>
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

The arch_invalidate_secondary_tlbs callback is called in the SVA mm
notification path. It invalidates all or a range of caches after the
CPU page table is modified. Use the cache tag helps in this path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/svm.c   | 76 +++----------------------------------
 2 files changed, 6 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d05fa0122d65..2575ded9f354 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1148,6 +1148,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 	u32 pasid;
 	struct list_head devs;
+	struct dmar_domain *domain;
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d706226e84ee..751fab476fa2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -168,88 +168,20 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void __flush_svm_range_dev(struct intel_svm *svm,
-				  struct intel_svm_dev *sdev,
-				  unsigned long address,
-				  unsigned long pages, int ih)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(sdev->dev);
-
-	if (WARN_ON(!pages))
-		return;
-
-	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
-	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-					 svm->pasid, sdev->qdep, address,
-					 order_base_2(pages));
-		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  svm->pasid, sdev->qdep);
-	}
-}
-
-static void intel_flush_svm_range_dev(struct intel_svm *svm,
-				      struct intel_svm_dev *sdev,
-				      unsigned long address,
-				      unsigned long pages, int ih)
-{
-	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
-	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
-	unsigned long start = ALIGN_DOWN(address, align);
-	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
-
-	while (start < end) {
-		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
-		start += align;
-	}
-}
-
-static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
-				unsigned long pages, int ih)
-{
-	struct intel_svm_dev *sdev;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_flush_svm_range_dev(svm, sdev, address, pages, ih);
-	rcu_read_unlock();
-}
-
-static void intel_flush_svm_all(struct intel_svm *svm)
-{
-	struct device_domain_info *info;
-	struct intel_svm_dev *sdev;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list) {
-		info = dev_iommu_priv_get(sdev->dev);
-
-		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
-		if (info->ats_enabled) {
-			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-						 svm->pasid, sdev->qdep,
-						 0, 64 - VTD_PAGE_SHIFT);
-			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
-						  svm->pasid, sdev->qdep);
-		}
-	}
-	rcu_read_unlock();
-}
-
 /* Pages have been freed at this point */
 static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long start, unsigned long end)
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
+	struct dmar_domain *domain = svm->domain;
 
 	if (start == 0 && end == -1UL) {
-		intel_flush_svm_all(svm);
+		cache_tag_flush_all(domain);
 		return;
 	}
 
-	intel_flush_svm_range(svm, start,
-			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
+	cache_tag_flush_range(domain, start, end, 0);
 }
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -336,6 +268,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
 		svm->notifier.ops = &intel_mmuops;
+		svm->domain = to_dmar_domain(domain);
 		ret = mmu_notifier_register(&svm->notifier, mm);
 		if (ret) {
 			kfree(svm);
@@ -803,6 +736,7 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	if (!domain)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
+	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
 
-- 
2.34.1


