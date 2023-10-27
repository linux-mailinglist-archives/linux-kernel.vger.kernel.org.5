Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03837D8C72
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjJ0AGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjJ0AGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:06:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A821B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698365167; x=1729901167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhGsLPqcLdYBHRjixMBCo4I5kFXzGXLaiyOCHceWDKU=;
  b=RU+QRvQ+tr/oZbJFbHtABYJ9jBcqMDAUV/Y8FeGqChl7a2KBjnIU30ZN
   hdJIHUjog8d6jwhwNXK6Ndtr4LFMnnF7YKSUlI3nDF3hcN70LgLYXs8gw
   38xvmWmhREI8+6KNR8dbWz3E0//9Pd3eW8ad9ApC+Z7Dbp+XGw2FTMbar
   oKzIXtcZFvvHFfB/6nwp7j+kmUsFNX1rwdd7Hv8pPQs3+7Lmct5J0Ki+j
   hjJb63PQWKwDuCqHAetG24P50z6r1EZBnnVJC3N0GlqNHDkfDZg/aPW4H
   IemoNYUVnuZY2VbKp+RkMdEPRV6zyHKbU18apVxuUL8WpSw6tVKh0xqke
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="390535941"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="390535941"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 17:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="883017483"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="883017483"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2023 17:06:03 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tina Zhang <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v10 2/6] iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
Date:   Fri, 27 Oct 2023 08:05:21 +0800
Message-Id: <20231027000525.1278806-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231027000525.1278806-1-tina.zhang@intel.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pasid is passed in as a parameter through .set_dev_pasid() callback.
Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
pasid value from mm->pasid.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/svm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 50a481c895b8..3c531af58658 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -290,21 +290,22 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 }
 
 static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
-			     struct mm_struct *mm)
+			     struct iommu_domain *domain, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct mm_struct *mm = domain->mm;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	unsigned long sflags;
 	int ret = 0;
 
-	svm = pasid_private_find(mm->pasid);
+	svm = pasid_private_find(pasid);
 	if (!svm) {
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm)
 			return -ENOMEM;
 
-		svm->pasid = mm->pasid;
+		svm->pasid = pasid;
 		svm->mm = mm;
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
@@ -342,7 +343,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
+	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
 		goto free_sdev;
@@ -356,7 +357,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 free_svm:
 	if (list_empty(&svm->devs)) {
 		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(mm->pasid);
+		pasid_private_remove(pasid);
 		kfree(svm);
 	}
 
@@ -796,9 +797,8 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
-	struct mm_struct *mm = domain->mm;
 
-	return intel_svm_bind_mm(iommu, dev, mm);
+	return intel_svm_bind_mm(iommu, dev, domain, pasid);
 }
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
-- 
2.39.3

