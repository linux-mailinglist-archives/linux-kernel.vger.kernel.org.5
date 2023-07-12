Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28562750E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjGLQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjGLQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:29:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F8E8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689179344; x=1720715344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mm0RBRlxNTWUVWGSjZmJqXmc9M/wdroaapVIA3ESeqk=;
  b=PuIEwM0clHBWpMwDYyu/6DnEHt9iONvrO+2IHKCBirVcFoT95Zqi3GCq
   dLebspaNK6naXWmzYylfU335dVFRPl1oOJg/v6fwG5Bcp1uPs3BU0x9EN
   S5K4tEukRyobqkMmhqmQt2DU1B0CExuCqTRqU6PxsZ3TdIAPUTsFci4We
   t/TsvKZTPdBGsC2vrRf5AKt/R8/WZCfFx3MDw+ksdBbUV2W6axteBlPem
   LOMdcev+tV3vVarH+ZG12q2xs6Wne09dyTKuKmICNdsWAmYpym+2bp5aJ
   GnoP3ic8RzmeBOWHQ93RSd2QSCAHtuWA2OJArijc661Jvvf8MgwqK3IBq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431072743"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431072743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="715639035"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="715639035"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga007.jf.intel.com with ESMTP; 12 Jul 2023 09:29:01 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Will Deacon" <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v10 4/7] iommu/vt-d: Remove pasid_mutex
Date:   Wed, 12 Jul 2023 09:33:52 -0700
Message-Id: <20230712163355.3177511-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

The pasid_mutex was used to protect the paths of set/remove_dev_pasid().
It's duplicate with iommu_sva_lock. Remove it to avoid duplicate code.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 45 +++++----------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e95b339e9cdc..2a82864e9d57 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -259,8 +259,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
-
 static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 			     struct intel_svm **rsvm,
 			     struct intel_svm_dev **rsdev)
@@ -268,10 +266,6 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	struct intel_svm_dev *sdev = NULL;
 	struct intel_svm *svm;
 
-	/* The caller should hold the pasid_mutex lock */
-	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
-		return -EINVAL;
-
 	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
 		return -EINVAL;
 
@@ -371,22 +365,19 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 	return ret;
 }
 
-/* Caller must hold pasid_mutex */
-static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
+void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 {
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
 	struct intel_svm *svm;
 	struct mm_struct *mm;
-	int ret = -EINVAL;
 
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
-		goto out;
+		return;
 
-	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
-	if (ret)
-		goto out;
+	if (pasid_to_svm_sdev(dev, pasid, &svm, &sdev))
+		return;
 	mm = svm->mm;
 
 	if (sdev) {
@@ -418,8 +409,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree(svm);
 		}
 	}
-out:
-	return ret;
 }
 
 /* Page request queue descriptor */
@@ -520,19 +509,7 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 		goto prq_retry;
 	}
 
-	/*
-	 * A work in IO page fault workqueue may try to lock pasid_mutex now.
-	 * Holding pasid_mutex while waiting in iopf_queue_flush_dev() for
-	 * all works in the workqueue to finish may cause deadlock.
-	 *
-	 * It's unnecessary to hold pasid_mutex in iopf_queue_flush_dev().
-	 * Unlock it to allow the works to be handled while waiting for
-	 * them to finish.
-	 */
-	lockdep_assert_held(&pasid_mutex);
-	mutex_unlock(&pasid_mutex);
 	iopf_queue_flush_dev(dev);
-	mutex_lock(&pasid_mutex);
 
 	/*
 	 * Perform steps described in VT-d spec CH7.10 to drain page
@@ -827,26 +804,14 @@ int intel_svm_page_response(struct device *dev,
 	return ret;
 }
 
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
-{
-	mutex_lock(&pasid_mutex);
-	intel_svm_unbind_mm(dev, pasid);
-	mutex_unlock(&pasid_mutex);
-}
-
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
-	int ret;
 
-	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(iommu, dev, mm);
-	mutex_unlock(&pasid_mutex);
-
-	return ret;
+	return intel_svm_bind_mm(iommu, dev, mm);
 }
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
-- 
2.25.1

