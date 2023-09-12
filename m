Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639179D17E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjILNAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjILM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:59:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254510CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694523593; x=1726059593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KfYy3F3Rl5zG+xoLgJl8yhPbh8RLafKcWQHwtyfaBaA=;
  b=ctsn/YQlCzuijcKACTjr1fTFFtXC8ktxPlPvxhhyF+YGufmMogWAWiIs
   F7y+xrlqSmpVs25DThcithpXcl1/kN9vB+DFbdTGK2iqJspbx56fFyYBd
   gAgscOmnsw6ExakZm6IAhgqx64UKTta00ilkqEtQkOi3h3fikdX4tFC30
   1T5Xw+mEhvM0Gp0IEUkHSe1+8J6MvnwQ3fiWo/5yHWyz1LFPyfU1ucCQy
   QDrecmjuL6miNLhRItLjyOQx3MSdGVLMBze9Gu2RtiShT9l0yoU3nBi9h
   xf33fS7gIbCCNF0oLlE5Y7PUYdafVGtBeT2rQrpDER+jHK1beOE/KtNrO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378277313"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378277313"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858799297"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858799297"
Received: from tongshi-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.255.28.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:59:50 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v4 2/6] iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
Date:   Tue, 12 Sep 2023 20:59:32 +0800
Message-Id: <20230912125936.722348-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912125936.722348-1-tina.zhang@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pasid is passed in as a parameter through .set_dev_pasid() callback.
Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
pasid value from mm->pasid.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
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
2.34.1

