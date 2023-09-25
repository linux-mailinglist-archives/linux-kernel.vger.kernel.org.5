Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3F7ACE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjIYCir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjIYCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E047180
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609511; x=1727145511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7zU7HAWdG3b1dGAPlY5mo7/wqSzMqXmxMMR0zvlmHZU=;
  b=EeYRuQgiEEGH6NJZA1M+skAi0Fx0U+JXzgD80rcOkl388bC52LPuU8XC
   w61k1PJnCF/elGD/qgI1AzwR4Um2s+mi36c7nx9OmF7FJuo5W52UfrdiD
   blOg56C4fbMuGmgrn1++fgKgOYOeW5zGg6vsfQdkofYQcUeWFL1/mivMs
   i0nG1QdWLptkLNe3bKs38RQTCCOu501eIzQVUqFCF9XOSaeSCln63Pti+
   bOxXNlAjNyKbr0Kby3LLgO+IUTn4+ItoZPe/wOKLQqAkXhe7dVLLzw3bK
   O0Kh/fA2wgc16OD4eKWjqmB4edDTL3UtYJk3kXgfL77UAj/+KkMFb4wX6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360534577"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360534577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777505062"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="777505062"
Received: from jingxues-mobl1.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.254.214.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:27 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 1/6] iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
Date:   Mon, 25 Sep 2023 10:38:08 +0800
Message-Id: <20230925023813.575016-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925023813.575016-1-tina.zhang@intel.com>
References: <20230925023813.575016-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

