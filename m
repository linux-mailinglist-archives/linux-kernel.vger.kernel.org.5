Return-Path: <linux-kernel+bounces-116414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D4889AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380CC1F33FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693091494DB;
	Mon, 25 Mar 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCX9zIIi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3E15539B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333116; cv=none; b=M2b4DazPcazh762IRRt24Z1Qb57kJAVztpXd2AqD4xT+JpGIe78rZv7eR5WjGmNDC6CG69n2/zTsiXxiVkQHJpL6iWL3O0YFOg0rJ9wuq/JMUEMCjhtXCOE9PDgTAmZhvWI0L0le1Z4ce7R3CRrRQWuMFHh+XJ7gPbfYWk2NWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333116; c=relaxed/simple;
	bh=jEIymX71O072SVGexRyBOj25jZMdFHRVH49ILGdL1mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAz/4NxtwBNyExMnl8xlKx1CGwEwo+xHs9qPPdWRkU3uLn08jVtse71PCYTSvcOLBZUOi+OqaWW6Z/8P4yWA1+37r3xDyAFFB6GYInWk+X3wmuWCPczSFv2JDpyT7kQHIGzlGENn9DMCcbFpTBTNb/CRUUnptIz/rT9R2BUI7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCX9zIIi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333115; x=1742869115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jEIymX71O072SVGexRyBOj25jZMdFHRVH49ILGdL1mc=;
  b=CCX9zIIi5CuY8zBKCyoimnSa6JssG9tjzaQQTBewjfrJXgV9fcSGJ4yt
   Ss2c7Q2laBKLa2mM+v1kBjdUbjsNRTcblEbOFDolOxLqExtSgRMtwj+wQ
   MYyV6yKADW2UY3A/xQnncpm1hVGrKsmJ6PrNm30bQYa6OYOhsSvbdHWJo
   1HR0WdYEzcQdDACbs40OWdysihhzMqSCyyDrc3EaxzM0nvS8PvbcVEfOt
   5VVNTptVp9YHnhRa9WvyeuOAtgaIywGPLkDSEsS8Z02AIbEv4ExwpCxJy
   yDL7rmTUi5vWUz0RNQhYknDkytn6CjkOcTTP2UzjgaK5UJYlqoygzBlAV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271479"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271479"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15354019"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:32 -0700
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
Subject: [PATCH 12/12] iommu/vt-d: Retire struct intel_svm
Date: Mon, 25 Mar 2024 10:17:05 +0800
Message-Id: <20240325021705.249769-13-baolu.lu@linux.intel.com>
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

The struct intel_svm was used for keeping attached devices info for sva
domain. Since sva domain is a kind of iommu_domain, the struct
dmar_domain should centralize all info of a sva domain, including the
info of attached devices. Therefore, retire struct intel_svm to clean up
the code.

Besides, allocate sva domain in domain_alloc_sva() callback which allows
the memory management notifier lifetime to follow the lifetime of the
iommu_domain.

Co-developed-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 26 ++++------
 drivers/iommu/intel/iommu.c |  9 +---
 drivers/iommu/intel/svm.c   | 94 +++++++++----------------------------
 3 files changed, 32 insertions(+), 97 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5dcced6f3634..7a4645e06bb7 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -649,8 +649,12 @@ struct dmar_domain {
 			/* link to parent domain siblings */
 			struct list_head s2_link;
 		};
+
+		/* SVA domain */
+		struct {
+			struct mmu_notifier notifier;
+		};
 	};
-	struct intel_svm *svm;
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
@@ -1131,26 +1135,16 @@ int intel_svm_enable_prq(struct intel_iommu *iommu);
 int intel_svm_finish_prq(struct intel_iommu *iommu);
 void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *msg);
-struct iommu_domain *intel_svm_domain_alloc(void);
-void intel_svm_remove_dev_pasid(struct iommu_domain *domain);
+struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
-
-struct intel_svm {
-	struct mmu_notifier notifier;
-	struct mm_struct *mm;
-	u32 pasid;
-	struct dmar_domain *domain;
-};
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
 static inline void intel_drain_pasid_prq(struct device *dev, u32 pasid) {}
-static inline struct iommu_domain *intel_svm_domain_alloc(void)
-{
-	return NULL;
-}
-
-static inline void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
+static inline struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+							  struct mm_struct *mm)
 {
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2ac1fc041333..cdf7882f58f3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3687,8 +3687,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
-	case IOMMU_DOMAIN_SVA:
-		return intel_svm_domain_alloc();
 	default:
 		return NULL;
 	}
@@ -4395,14 +4393,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
-	/*
-	 * The SVA implementation needs to handle its own stuffs like the mm
-	 * notification. Before consolidating that code into iommu core, let
-	 * the intel sva code handle it.
-	 */
 	if (domain->type == IOMMU_DOMAIN_SVA) {
 		cache_tag_unassign_domain(dmar_domain, FLPT_DEFAULT_DID, dev, pasid);
-		intel_svm_remove_dev_pasid(domain);
 	} else {
 		did = domain_id_iommu(dmar_domain, iommu);
 		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
@@ -4631,6 +4623,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
+	.domain_alloc_sva	= intel_svm_domain_alloc,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0b767d16fb71..47e475f67046 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -26,23 +26,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-static DEFINE_XARRAY_ALLOC(pasid_private_array);
-static int pasid_private_add(ioasid_t pasid, void *priv)
-{
-	return xa_alloc(&pasid_private_array, &pasid, priv,
-			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
-}
-
-static void pasid_private_remove(ioasid_t pasid)
-{
-	xa_erase(&pasid_private_array, pasid);
-}
-
-static void *pasid_private_find(ioasid_t pasid)
-{
-	return xa_load(&pasid_private_array, pasid);
-}
-
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct iopf_queue *iopfq;
@@ -156,8 +139,7 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long start, unsigned long end)
 {
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-	struct dmar_domain *domain = svm->domain;
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
 
 	if (start == 0 && end == -1UL) {
 		cache_tag_flush_all(domain);
@@ -169,8 +151,7 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-	struct dmar_domain *domain = svm->domain;
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
 	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	unsigned long flags;
@@ -210,41 +191,13 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct dev_pasid_info *dev_pasid;
-	struct intel_svm *svm;
 	unsigned long sflags;
 	unsigned long flags;
 	int ret = 0;
 
-	svm = pasid_private_find(pasid);
-	if (!svm) {
-		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
-		if (!svm)
-			return -ENOMEM;
-
-		svm->pasid = pasid;
-		svm->mm = mm;
-
-		svm->notifier.ops = &intel_mmuops;
-		svm->domain = to_dmar_domain(domain);
-		ret = mmu_notifier_register(&svm->notifier, mm);
-		if (ret) {
-			kfree(svm);
-			return ret;
-		}
-
-		ret = pasid_private_add(svm->pasid, svm);
-		if (ret) {
-			mmu_notifier_unregister(&svm->notifier, mm);
-			kfree(svm);
-			return ret;
-		}
-	}
-
-	dmar_domain->svm = svm;
-
 	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
 	if (!dev_pasid)
-		goto free_svm;
+		return -ENOMEM;
 
 	dev_pasid->dev = dev;
 	dev_pasid->pasid = pasid;
@@ -272,30 +225,10 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				  FLPT_DEFAULT_DID, dev, pasid);
 free_dev_pasid:
 	kfree(dev_pasid);
-free_svm:
-	if (list_empty(&dmar_domain->dev_pasids)) {
-		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(pasid);
-		kfree(svm);
-	}
 
 	return ret;
 }
 
-void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
-{
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct intel_svm *svm = dmar_domain->svm;
-	struct mm_struct *mm = domain->mm;
-
-	if (list_empty(&dmar_domain->dev_pasids)) {
-		if (svm->notifier.ops)
-			mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(svm->pasid);
-		kfree(svm);
-	}
-}
-
 /* Page request queue descriptor */
 struct page_req_dsc {
 	union {
@@ -663,7 +596,12 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
-	kfree(to_dmar_domain(domain));
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (dmar_domain->notifier.ops)
+		mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);
+
+	kfree(dmar_domain);
 }
 
 static const struct iommu_domain_ops intel_svm_domain_ops = {
@@ -671,13 +609,16 @@ static const struct iommu_domain_ops intel_svm_domain_ops = {
 	.free			= intel_svm_domain_free
 };
 
-struct iommu_domain *intel_svm_domain_alloc(void)
+struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+					    struct mm_struct *mm)
 {
 	struct dmar_domain *domain;
+	int ret;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
 	domain->domain.ops = &intel_svm_domain_ops;
 	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->dev_pasids);
@@ -685,5 +626,12 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	spin_lock_init(&domain->cache_lock);
 	spin_lock_init(&domain->lock);
 
+	domain->notifier.ops = &intel_mmuops;
+	ret = mmu_notifier_register(&domain->notifier, mm);
+	if (ret) {
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
+
 	return &domain->domain;
 }
-- 
2.34.1


