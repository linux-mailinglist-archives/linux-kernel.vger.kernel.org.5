Return-Path: <linux-kernel+bounces-156471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88548B030D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719C1287609
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A613815A482;
	Wed, 24 Apr 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhXWYqjo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779191598F7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943125; cv=none; b=fC5V5XXGZRUTBv5In8CtlU0x9VeBPbz0EBw/BhVaRH02MWMNosmFLhiklF1aBVCXlQZB3RY8V7uX5xmKTS0RKs0nQpbNKuW0c2y3VVXLHO8EuVu8mOgyDoTw2hG5gnLLTEdhuLLCaEv3x0rHA8gGjd5BGq3/xaEMYtEO6ebVN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943125; c=relaxed/simple;
	bh=aYddYaiq7VlrsrcMI1IKgj73p5JRHYG0D1larc63h8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhLNkCpj15hxBwB0U6/o4C/4r+J6KYwQauFXgpupAujX8Cvosf03+3wFxMFriz59+ZZdrl7RpRavtlN1UI5l/OT7OtTvGUWbvK3br/CCjmh8JyjxN89kb/nOy6vUuWg+VRqR8Pd4toEpK4fE/E0qkYtS2M0kZ7aMTusBqw4B7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhXWYqjo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943125; x=1745479125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYddYaiq7VlrsrcMI1IKgj73p5JRHYG0D1larc63h8c=;
  b=nhXWYqjof+TFhhlpRmQD7fYjtg70jDEvNKIghkiGCZSVevPCJpGR935g
   Zg/kM6fK7FspIQImRY4feKp1/9Y6YN4f6MhuXITFC+W1zosu1n5C+QbE/
   xHFAOBLZWIPfJOaEf8dQKuPI6bowGjGelS6Bg5rzbNFPkmHLv2phC/i0r
   tYwacIO4EtiB3zaxEFtBzfg+HXDNiWxTgeB29cwutHD9MMPWWlN+eTvTo
   f9vTOXt+76IQMY2RMSyUFMEpwqyDNOTH5W+eEdkGn33IXPZmduc9VC0T8
   sr5Oc7v91rZW9ttTqdj5U8gu6enIz2I1TBjwKFhJM26PCsJDuGOXqqrlf
   w==;
X-CSE-ConnectionGUID: MMUhhlmsSVKl1+z2wG23Jw==
X-CSE-MsgGUID: sa5XNzIVQdGfLFJOnjf+RA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073231"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:44 -0700
X-CSE-ConnectionGUID: STGQTjU5TwCqXM3IFx0hrg==
X-CSE-MsgGUID: 2z/48UO5TcKvuDnGs7qo7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665763"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
Date: Wed, 24 Apr 2024 15:16:41 +0800
Message-Id: <20240424071644.178250-16-baolu.lu@linux.intel.com>
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

The arch_invalidate_secondary_tlbs callback is called in the SVA mm
notification path. It invalidates all or a range of caches after the
CPU page table is modified. Use the cache tag helps in this path.

The mm_types defines vm_end as the first byte after the end address
which is different from the iommu gather API, hence convert the end
parameter from mm_types to iommu gather scheme before calling the
cache_tag helper.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-10-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/svm.c   | 81 +++++--------------------------------
 2 files changed, 11 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1d705a983dd7..fc0b4b048635 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1166,6 +1166,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 	u32 pasid;
 	struct list_head devs;
+	struct dmar_domain *domain;
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2e627fbd5adb..5ba0a7baa455 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -168,88 +168,25 @@ void intel_svm_check(struct intel_iommu *iommu)
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
+	/*
+	 * The mm_types defines vm_end as the first byte after the end address,
+	 * different from IOMMU subsystem using the last address of an address
+	 * range.
+	 */
+	cache_tag_flush_range(domain, start, end - 1, 0);
 }
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -336,6 +273,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
 		svm->notifier.ops = &intel_mmuops;
+		svm->domain = to_dmar_domain(domain);
 		ret = mmu_notifier_register(&svm->notifier, mm);
 		if (ret) {
 			kfree(svm);
@@ -747,6 +685,7 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	if (!domain)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
+	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
 
-- 
2.34.1


