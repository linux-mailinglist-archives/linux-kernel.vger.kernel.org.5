Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48CC80811D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377791AbjLGGtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjLGGsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:48:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74410FC;
        Wed,  6 Dec 2023 22:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701931737; x=1733467737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jeZZdGZpEk8AVP9NHWYxOrw7zWKgtXoYLj8OAF7ECP0=;
  b=oIO7rZI4xTQ8pfz7aVaFX49JT6bPl2dQnC7+4/O4bYnJgBWTxeIWWATI
   ZdvHPsfJlamePeb9HJQhAFG4Mn/rQX5jNiwBNYVjxatGM4/zJtl8mKlzs
   ys7kwhQTejvbRDfc23wu7TEYt0PuP3lf05ULBQSZWIk2ycrKtGnDx+BFj
   wfYWUp+p9HzK3tMR/bPS2RhCI10GWi/uURGM6zMCMgEi20FwKtW83iO0N
   BFsNCMElGLVA/e7BJ7drgy9gHKWArtZg16hBJ++IyE0TA/qoRpYPFymTB
   uYhjo3/BCl6xjTgsqeR/JfB/ffY5xrGklRfNmxv2JK7rV7L/c0jhU5IF+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1015081"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1015081"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 22:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771611830"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771611830"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2023 22:48:51 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v8 11/12] iommu: Refine locking for per-device fault data management
Date:   Thu,  7 Dec 2023 14:43:07 +0800
Message-Id: <20231207064308.313316-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207064308.313316-1-baolu.lu@linux.intel.com>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-device fault data is a data structure that is used to store
information about faults that occur on a device. This data is allocated
when IOPF is enabled on the device and freed when IOPF is disabled. The
data is used in the paths of iopf reporting, handling, responding, and
draining.

The fault data is protected by two locks:

- dev->iommu->lock: This lock is used to protect the allocation and
  freeing of the fault data.
- dev->iommu->fault_parameter->lock: This lock is used to protect the
  fault data itself.

Apply the locking mechanism to the fault reporting and responding paths.

The fault_parameter->lock is also added in iopf_queue_discard_partial().
It does not fix any real issue, as iopf_queue_discard_partial() is only
used in the VT-d driver's prq_event_thread(), which is a single-threaded
path that reports the IOPFs.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/iommu/io-pgfault.c | 61 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index f501197a2892..9439eaf54928 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -29,7 +29,7 @@ EXPORT_SYMBOL_GPL(iopf_free_group);
 /**
  * iommu_handle_iopf - IO Page Fault handler
  * @fault: fault event
- * @dev: struct device.
+ * @iopf_param: the fault parameter of the device.
  *
  * Add a fault to the device workqueue, to be handled by mm.
  *
@@ -66,29 +66,21 @@ EXPORT_SYMBOL_GPL(iopf_free_group);
  *
  * Return: 0 on success and <0 on error.
  */
-static int iommu_handle_iopf(struct iommu_fault *fault, struct device *dev)
+static int iommu_handle_iopf(struct iommu_fault *fault,
+			     struct iommu_fault_param *iopf_param)
 {
 	int ret;
 	struct iopf_group *group;
 	struct iopf_fault *iopf, *next;
 	struct iommu_domain *domain = NULL;
-	struct iommu_fault_param *iopf_param;
-	struct dev_iommu *param = dev->iommu;
+	struct device *dev = iopf_param->dev;
 
-	lockdep_assert_held(&param->lock);
+	lockdep_assert_held(&iopf_param->lock);
 
 	if (fault->type != IOMMU_FAULT_PAGE_REQ)
 		/* Not a recoverable page fault */
 		return -EOPNOTSUPP;
 
-	/*
-	 * As long as we're holding param->lock, the queue can't be unlinked
-	 * from the device and therefore cannot disappear.
-	 */
-	iopf_param = param->fault_param;
-	if (!iopf_param)
-		return -ENODEV;
-
 	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
 		iopf = kzalloc(sizeof(*iopf), GFP_KERNEL);
 		if (!iopf)
@@ -173,18 +165,19 @@ static int iommu_handle_iopf(struct iommu_fault *fault, struct device *dev)
  */
 int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
-	struct dev_iommu *param = dev->iommu;
+	struct iommu_fault_param *fault_param;
 	struct iopf_fault *evt_pending = NULL;
-	struct iommu_fault_param *fparam;
+	struct dev_iommu *param = dev->iommu;
 	int ret = 0;
 
-	if (!param || !evt)
-		return -EINVAL;
-
-	/* we only report device fault if there is a handler registered */
 	mutex_lock(&param->lock);
-	fparam = param->fault_param;
+	fault_param = param->fault_param;
+	if (!fault_param) {
+		mutex_unlock(&param->lock);
+		return -EINVAL;
+	}
 
+	mutex_lock(&fault_param->lock);
 	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
 	    (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
 		evt_pending = kmemdup(evt, sizeof(struct iopf_fault),
@@ -193,20 +186,18 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 			ret = -ENOMEM;
 			goto done_unlock;
 		}
-		mutex_lock(&fparam->lock);
-		list_add_tail(&evt_pending->list, &fparam->faults);
-		mutex_unlock(&fparam->lock);
+		list_add_tail(&evt_pending->list, &fault_param->faults);
 	}
 
-	ret = iommu_handle_iopf(&evt->fault, dev);
+	ret = iommu_handle_iopf(&evt->fault, fault_param);
 	if (ret && evt_pending) {
-		mutex_lock(&fparam->lock);
 		list_del(&evt_pending->list);
-		mutex_unlock(&fparam->lock);
 		kfree(evt_pending);
 	}
 done_unlock:
+	mutex_unlock(&fault_param->lock);
 	mutex_unlock(&param->lock);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);
@@ -219,18 +210,23 @@ int iommu_page_response(struct device *dev,
 	struct iopf_fault *evt;
 	struct iommu_fault_page_request *prm;
 	struct dev_iommu *param = dev->iommu;
+	struct iommu_fault_param *fault_param;
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
 
 	if (!ops->page_response)
 		return -ENODEV;
 
-	if (!param || !param->fault_param)
+	mutex_lock(&param->lock);
+	fault_param = param->fault_param;
+	if (!fault_param) {
+		mutex_unlock(&param->lock);
 		return -EINVAL;
+	}
 
 	/* Only send response if there is a fault report pending */
-	mutex_lock(&param->fault_param->lock);
-	if (list_empty(&param->fault_param->faults)) {
+	mutex_lock(&fault_param->lock);
+	if (list_empty(&fault_param->faults)) {
 		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
 		goto done_unlock;
 	}
@@ -238,7 +234,7 @@ int iommu_page_response(struct device *dev,
 	 * Check if we have a matching page request pending to respond,
 	 * otherwise return -EINVAL
 	 */
-	list_for_each_entry(evt, &param->fault_param->faults, list) {
+	list_for_each_entry(evt, &fault_param->faults, list) {
 		prm = &evt->fault.prm;
 		if (prm->grpid != msg->grpid)
 			continue;
@@ -266,7 +262,8 @@ int iommu_page_response(struct device *dev,
 	}
 
 done_unlock:
-	mutex_unlock(&param->fault_param->lock);
+	mutex_unlock(&fault_param->lock);
+	mutex_unlock(&param->lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_page_response);
@@ -349,11 +346,13 @@ int iopf_queue_discard_partial(struct iopf_queue *queue)
 
 	mutex_lock(&queue->lock);
 	list_for_each_entry(iopf_param, &queue->devices, queue_list) {
+		mutex_lock(&iopf_param->lock);
 		list_for_each_entry_safe(iopf, next, &iopf_param->partial,
 					 list) {
 			list_del(&iopf->list);
 			kfree(iopf);
 		}
+		mutex_unlock(&iopf_param->lock);
 	}
 	mutex_unlock(&queue->lock);
 	return 0;
-- 
2.34.1

