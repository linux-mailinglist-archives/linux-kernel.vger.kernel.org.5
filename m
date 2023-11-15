Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89B7EBB88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjKODHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjKODHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:07:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46872E3;
        Tue, 14 Nov 2023 19:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700017636; x=1731553636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+cm2eJlk7HCg1F89RtVb5YQYZCcjYi3fNDOXfPjMnM=;
  b=Tq13Quw+oopowqN84SJEkwHJsRxW7I20/Db8ak0y/YU693H5Ip0UsssL
   B9MZ6CD+YjPRLIBgWkGUtJ3e93DhGq2UontVxUdohn0qi6Ut7CBvSbbnF
   HiBdqGl8ynD8B0AjLaADkoWUE3vTNXDktpT4gEK9IUMk2DjFpLGUu077H
   4/7gbTnm+LKIRyuD1GrUVmAoIQsyoNf4UsVtzwR1+8o37KMNiqj9C6DzU
   RyS5XshTie/eViemMlozyhEu1LFIMgILgWYpYYtKVy0W+Kvch8EjTXfPB
   FujeERDP6xqubzpGTShYNWenqcPlKGwFuI2gtbsP2qHL/EkHEtM4Hjlvw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394715473"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="394715473"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 19:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012128864"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="1012128864"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2023 19:07:12 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 09/12] iommu: Make iommu_queue_iopf() more generic
Date:   Wed, 15 Nov 2023 11:02:23 +0800
Message-Id: <20231115030226.16700-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115030226.16700-1-baolu.lu@linux.intel.com>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make iommu_queue_iopf() more generic by making the iopf_group a minimal
set of iopf's that an iopf handler of domain should handle and respond
to. Add domain parameter to struct iopf_group so that the handler can
retrieve and use it directly.

Change iommu_queue_iopf() to forward groups of iopf's to the domain's
iopf handler. This is also a necessary step to decouple the sva iopf
handling code from this interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/iommu.h      |  4 +--
 drivers/iommu/iommu-sva.h  |  6 ++---
 drivers/iommu/io-pgfault.c | 55 +++++++++++++++++++++++++++++---------
 drivers/iommu/iommu-sva.c  |  3 +--
 4 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0d3c5a56b078..96f6f210093e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -130,6 +130,7 @@ struct iopf_group {
 	struct list_head faults;
 	struct work_struct work;
 	struct device *dev;
+	struct iommu_domain *domain;
 };
 
 /**
@@ -209,8 +210,7 @@ struct iommu_domain {
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
-	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
-						      void *data);
+	int (*iopf_handler)(struct iopf_group *group);
 	void *fault_data;
 	union {
 		struct {
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index de7819c796ce..27c8da115b41 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -22,8 +22,7 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
-enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault, void *data);
+int iommu_sva_handle_iopf(struct iopf_group *group);
 
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
@@ -62,8 +61,7 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 	return -ENODEV;
 }
 
-static inline enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+static inline int iommu_sva_handle_iopf(struct iopf_group *group)
 {
 	return IOMMU_PAGE_RESP_INVALID;
 }
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 09e05f483b4f..544653de0d45 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -13,6 +13,9 @@
 
 #include "iommu-sva.h"
 
+enum iommu_page_response_code
+iommu_sva_handle_mm(struct iommu_fault *fault, struct mm_struct *mm);
+
 static void iopf_free_group(struct iopf_group *group)
 {
 	struct iopf_fault *iopf, *next;
@@ -45,23 +48,18 @@ static void iopf_handler(struct work_struct *work)
 {
 	struct iopf_fault *iopf;
 	struct iopf_group *group;
-	struct iommu_domain *domain;
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
 
 	group = container_of(work, struct iopf_group, work);
-	domain = iommu_get_domain_for_dev_pasid(group->dev,
-				group->last_fault.fault.prm.pasid, 0);
-	if (!domain || !domain->iopf_handler)
-		status = IOMMU_PAGE_RESP_INVALID;
-
 	list_for_each_entry(iopf, &group->faults, list) {
 		/*
 		 * For the moment, errors are sticky: don't handle subsequent
 		 * faults in the group if there is an error.
 		 */
-		if (status == IOMMU_PAGE_RESP_SUCCESS)
-			status = domain->iopf_handler(&iopf->fault,
-						      domain->fault_data);
+		if (status != IOMMU_PAGE_RESP_SUCCESS)
+			break;
+
+		status = iommu_sva_handle_mm(&iopf->fault, group->domain->mm);
 	}
 
 	iopf_complete_group(group->dev, &group->last_fault, status);
@@ -113,6 +111,7 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 	int ret;
 	struct iopf_group *group;
 	struct iopf_fault *iopf, *next;
+	struct iommu_domain *domain = NULL;
 	struct iommu_fault_param *iopf_param;
 	struct dev_iommu *param = dev->iommu;
 
@@ -143,6 +142,23 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 		return 0;
 	}
 
+	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
+		if (IS_ERR(domain))
+			domain = NULL;
+	}
+
+	if (!domain)
+		domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain || !domain->iopf_handler) {
+		dev_warn_ratelimited(dev,
+			"iopf (pasid %d) without domain attached or handler installed\n",
+			 fault->prm.pasid);
+		ret = -ENODEV;
+		goto cleanup_partial;
+	}
+
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group) {
 		/*
@@ -157,8 +173,8 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 	group->dev = dev;
 	group->last_fault.fault = *fault;
 	INIT_LIST_HEAD(&group->faults);
+	group->domain = domain;
 	list_add(&group->last_fault.list, &group->faults);
-	INIT_WORK(&group->work, iopf_handler);
 
 	/* See if we have partial faults for this group */
 	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
@@ -167,9 +183,13 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 			list_move(&iopf->list, &group->faults);
 	}
 
-	queue_work(iopf_param->queue->wq, &group->work);
-	return 0;
+	mutex_unlock(&iopf_param->lock);
+	ret = domain->iopf_handler(group);
+	mutex_lock(&iopf_param->lock);
+	if (ret)
+		iopf_free_group(group);
 
+	return ret;
 cleanup_partial:
 	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
 		if (iopf->fault.prm.grpid == fault->prm.grpid) {
@@ -181,6 +201,17 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_queue_iopf);
 
+int iommu_sva_handle_iopf(struct iopf_group *group)
+{
+	struct iommu_fault_param *fault_param = group->dev->iommu->fault_param;
+
+	INIT_WORK(&group->work, iopf_handler);
+	if (!queue_work(fault_param->queue->wq, &group->work))
+		return -EBUSY;
+
+	return 0;
+}
+
 /**
  * iopf_queue_flush_dev - Ensure that all queued faults have been processed
  * @dev: the endpoint whose faults need to be flushed.
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b78671a8a914..ba0d5b7e106a 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -149,11 +149,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  * I/O page fault handler for SVA
  */
 enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+iommu_sva_handle_mm(struct iommu_fault *fault, struct mm_struct *mm)
 {
 	vm_fault_t ret;
 	struct vm_area_struct *vma;
-	struct mm_struct *mm = data;
 	unsigned int access_flags = 0;
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 	struct iommu_fault_page_request *prm = &fault->prm;
-- 
2.34.1

