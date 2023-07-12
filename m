Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69543750E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjGLQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGLQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:29:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF993106
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689179342; x=1720715342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYTyr4AKwuKZfShoDGuBFHDXyYVuIob2FcxiuKdH0+0=;
  b=CfwXpWrDt0i0q+ef0Vfo1Xc6Rz5Dfy+YrNLNSkMM9jGnmzvQm1rEwHh3
   Abh5z/n5IGmD79BJIB1HxRsTcEM0vyS9Bo/ydgTSXPe1/KKykX6belqw3
   0TRfGllmpGrIyIJlTbgFEqnFXvjw4LM/ywTrxUZI7U/y85e1qfmBFKhoq
   RqI4hvMgxhbYOO85fqK2rR93aULVOIFGtRK2KmEGogxUxGNpD0OeTpJqU
   oMP4hJDmR4jJScU1EJYoUwTu9BtcuhJ80LfzZeVwcT7f6X4/NPfeeSECM
   sxa01Wzi/dfxung1bK/4bMBuefRMp2UF1pQxxe4oF6uHAocmeF7ZYRTF0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431072729"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431072729"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="715639025"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="715639025"
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
Subject: [PATCH v10 2/7] iommu: Move global PASID allocation from SVA to core
Date:   Wed, 12 Jul 2023 09:33:50 -0700
Message-Id: <20230712163355.3177511-3-jacob.jun.pan@linux.intel.com>
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

Global PASID can be used beyond SVA. For example, drivers that use
Intel ENQCMD to submit work must use global PASIDs in that PASID
is stored in a per CPU MSR. When such device need to submit work
for in-kernel DMA with PASID, it must allocate PASIDs from the same
global number space to avoid conflict.

This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
Reserved PASIDs, currently only RID_PASID, are excluded from the global
PASID allocation.

It is expected that device drivers will use the allocated PASIDs to
attach to appropriate IOMMU domains for use.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v8: fix off-by-one in max_pasid check
v7: simplify range check (Baolu)
v6: explicitly exclude reserved a range from SVA PASID allocation
    check mm PASID compatibility with device
v5: move PASID range check inside API so that device drivers only pass
    in struct device* (Kevin)
v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
---
 drivers/iommu/iommu-sva.c | 28 ++++++++++------------------
 drivers/iommu/iommu.c     | 28 ++++++++++++++++++++++++++++
 include/linux/iommu.h     | 10 ++++++++++
 3 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 3ebd4b6586b3..8627acc6e60c 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,33 +10,30 @@
 #include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
-static DEFINE_IDA(iommu_global_pasid_ida);
 
 /* Allocate a PASID for the mm within range (inclusive) */
-static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
 {
+	ioasid_t pasid;
 	int ret = 0;
 
-	if (min == IOMMU_PASID_INVALID ||
-	    max == IOMMU_PASID_INVALID ||
-	    min == 0 || max < min)
-		return -EINVAL;
-
 	if (!arch_pgtable_dma_compat(mm))
 		return -EBUSY;
 
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
 	if (mm_valid_pasid(mm)) {
-		if (mm->pasid < min || mm->pasid > max)
+		if (mm->pasid >= dev->iommu->max_pasids)
 			ret = -EOVERFLOW;
 		goto out;
 	}
 
-	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < min)
+	pasid = iommu_alloc_global_pasid_dev(dev);
+	if (pasid == IOMMU_PASID_INVALID) {
+		ret = -ENOSPC;
 		goto out;
-	mm->pasid = ret;
+	}
+	mm->pasid = pasid;
 	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
@@ -63,15 +60,10 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 {
 	struct iommu_domain *domain;
 	struct iommu_sva *handle;
-	ioasid_t max_pasids;
 	int ret;
 
-	max_pasids = dev->iommu->max_pasids;
-	if (!max_pasids)
-		return ERR_PTR(-EOPNOTSUPP);
-
 	/* Allocate mm->pasid if necessary. */
-	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
+	ret = iommu_sva_alloc_pasid(mm, dev);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -216,5 +208,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 	if (likely(!mm_valid_pasid(mm)))
 		return;
 
-	ida_free(&iommu_global_pasid_ida, mm->pasid);
+	iommu_free_global_pasid(mm->pasid);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index da340f11c5f5..37d5e1b8ed01 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -39,6 +39,7 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+static DEFINE_IDA(iommu_global_pasid_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
@@ -3399,3 +3400,30 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
+{
+	int ret;
+
+	/* max_pasids == 0 means that the device does not support PASID */
+	if (!dev->iommu->max_pasids)
+		return IOMMU_PASID_INVALID;
+
+	/*
+	 * max_pasids is set up by vendor driver based on number of PASID bits
+	 * supported but the IDA allocation is inclusive.
+	 */
+	ret = ida_alloc_range(&iommu_global_pasid_ida, IOMMU_FIRST_GLOBAL_PASID,
+			      dev->iommu->max_pasids - 1, GFP_KERNEL);
+	return ret < 0 ? IOMMU_PASID_INVALID : ret;
+}
+EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);
+
+void iommu_free_global_pasid(ioasid_t pasid)
+{
+	if (WARN_ON(pasid == IOMMU_PASID_INVALID))
+		return;
+
+	ida_free(&iommu_global_pasid_ida, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_free_global_pasid);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2870bc29d456..e97148f31038 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -197,6 +197,7 @@ enum iommu_dev_features {
 };
 
 #define IOMMU_NO_PASID	(0U) /* Reserved for DMA w/o PASID */
+#define IOMMU_FIRST_GLOBAL_PASID	(1U) /*starting range for allocation */
 #define IOMMU_PASID_INVALID	(-1U)
 typedef unsigned int ioasid_t;
 
@@ -728,6 +729,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 struct iommu_domain *
 iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
 			       unsigned int type);
+ioasid_t iommu_alloc_global_pasid_dev(struct device *dev);
+void iommu_free_global_pasid(ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1089,6 +1092,13 @@ iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
 {
 	return NULL;
 }
+
+static inline ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
+{
+	return IOMMU_PASID_INVALID;
+}
+
+static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
 /**
-- 
2.25.1

