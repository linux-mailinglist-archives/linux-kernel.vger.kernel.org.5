Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF776D95C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjHBVTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjHBVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:19:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30002708
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691011165; x=1722547165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tvap/bP4frIrjwhw5ezK85sfojLa+kIMDMriKn0x2mM=;
  b=FbviRvL/rhLk9rPHmpPaRGF6IsWJR20kQMxbSqYknQWhdOAIAdNfggyd
   fuckyZgDl5tammdYQjELIcbGSSkihDGyV17Gv1zRqLCG+zbOBUuqY7Vd6
   amJ2/XLN5wU07C/jBCpkOaQikcCvo1dwIaD8lyKh8k8WPDH9ONmqEk2Pe
   QApst8/9gcyefjsykuxZkga1JwcnTUJm+pLA7aJdYAGRONX1CAGgjgG4T
   XPWujWyuGcIarSXER/mmXTxdnKzgeyej8nKTgVaq2LwqDrjrvJUjrMRuJ
   Guialn4ofQ19aVh/uyyTsKzOq7w/1EeJArNWfYKpoEV+x+pVW544uPTZe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372436155"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372436155"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729290787"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="729290787"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 14:19:22 -0700
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
Subject: [PATCH v12 4/8] iommu/vt-d: Remove pasid_mutex
Date:   Wed,  2 Aug 2023 14:24:23 -0700
Message-Id: <20230802212427.1497170-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

The pasid_mutex was used to protect the paths of set/remove_dev_pasid().
It's duplicate with iommu_sva_lock. Remove it to avoid duplicate code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

