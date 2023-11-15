Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04DE7EBB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjKODIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjKODHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:07:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F821720;
        Tue, 14 Nov 2023 19:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700017652; x=1731553652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+Yg/spqjl3lbOQyq1c1j/kiy1AnFo0msZxv07NYnZU=;
  b=gy+3Bn9b73/6lrmOvQoe647uchFbKH079x4L9ipEuNnaZMPVIyULdLgI
   M2gGhy5cz6fxxJzkjfY8wwJqi2l4S5rglaJZgY1Le1aS4MO+ijlBAWXHS
   77fnXnP6rgnUu/7ZZMeNtqGDER+0ZZLTFrXlt1cyFsrM4wdA+o1ZDM/Mr
   00BEIzxF78/2BgG9oP+Qu0mUJPd9XrH6bAzP949JHjlrqsBfSRWSowBk5
   MLVjIex2XZBXKf5O6RML3dvmDK3uY3Hkcw8dphfvtIyqr70zJhmOKQfJh
   JTbcPO5ANTQl8lhEUzjXgESSV+Qins1clUOjmaHZou9kB9su1ZRJYTlgj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394715518"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="394715518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 19:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012128954"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="1012128954"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2023 19:07:22 -0800
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
Subject: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Date:   Wed, 15 Nov 2023 11:02:26 +0800
Message-Id: <20231115030226.16700-13-baolu.lu@linux.intel.com>
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

The iopf_queue_flush_dev() is called by the iommu driver before releasing
a PASID. It ensures that all pending faults for this PASID have been
handled or cancelled, and won't hit the address space that reuses this
PASID. The driver must make sure that no new fault is added to the queue.

The SMMUv3 driver doesn't use it because it only implements the
Arm-specific stall fault model where DMA transactions are held in the SMMU
while waiting for the OS to handle iopf's. Since a device driver must
complete all DMA transactions before detaching domain, there are no
pending iopf's with the stall model. PRI support requires adding a call to
iopf_queue_flush_dev() after flushing the hardware page fault queue.

The current implementation of iopf_queue_flush_dev() is a simplified
version. It is only suitable for SVA case in which the processing of iopf
is implemented in the inner loop of the iommu subsystem.

Improve this interface to make it also work for handling iopf out of the
iommu core. Rename the function with a more meaningful name. Remove a
warning message in iommu_page_response() since the iopf queue might get
flushed before possible pending responses.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/iommu.h      |  4 +--
 drivers/iommu/intel/svm.c  |  2 +-
 drivers/iommu/io-pgfault.c | 60 ++++++++++++++++++++++++++++++--------
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c17d5979d70d..cd3cdeb69f49 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1431,7 +1431,7 @@ iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
 #ifdef CONFIG_IOMMU_IOPF
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
 int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev);
-int iopf_queue_flush_dev(struct device *dev);
+int iopf_queue_discard_dev_pasid(struct device *dev, ioasid_t pasid);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
@@ -1453,7 +1453,7 @@ iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 	return -ENODEV;
 }
 
-static inline int iopf_queue_flush_dev(struct device *dev)
+static inline int iopf_queue_discard_dev_pasid(struct device *dev, ioasid_t pasid)
 {
 	return -ENODEV;
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 780c5bd73ec2..659de9c16024 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -495,7 +495,7 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 		goto prq_retry;
 	}
 
-	iopf_queue_flush_dev(dev);
+	iopf_queue_discard_dev_pasid(dev, pasid);
 
 	/*
 	 * Perform steps described in VT-d spec CH7.10 to drain page
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index b80574323cbc..b288c73f2b22 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -260,10 +260,9 @@ int iommu_page_response(struct device *dev,
 
 	/* Only send response if there is a fault report pending */
 	mutex_lock(&fault_param->lock);
-	if (list_empty(&fault_param->faults)) {
-		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
+	if (list_empty(&fault_param->faults))
 		goto done_unlock;
-	}
+
 	/*
 	 * Check if we have a matching page request pending to respond,
 	 * otherwise return -EINVAL
@@ -304,30 +303,67 @@ int iommu_page_response(struct device *dev,
 EXPORT_SYMBOL_GPL(iommu_page_response);
 
 /**
- * iopf_queue_flush_dev - Ensure that all queued faults have been processed
- * @dev: the endpoint whose faults need to be flushed.
+ * iopf_queue_discard_dev_pasid - Discard all pending faults for a PASID
+ * @dev: the endpoint whose faults need to be discarded.
+ * @pasid: the PASID of the endpoint.
  *
  * The IOMMU driver calls this before releasing a PASID, to ensure that all
- * pending faults for this PASID have been handled, and won't hit the address
- * space of the next process that uses this PASID. The driver must make sure
- * that no new fault is added to the queue. In particular it must flush its
- * low-level queue before calling this function.
+ * pending faults for this PASID have been handled or dropped, and won't hit
+ * the address space of the next process that uses this PASID. The driver
+ * must make sure that no new fault is added to the queue. In particular it
+ * must flush its low-level queue before calling this function.
  *
  * Return: 0 on success and <0 on error.
  */
-int iopf_queue_flush_dev(struct device *dev)
+int iopf_queue_discard_dev_pasid(struct device *dev, ioasid_t pasid)
 {
 	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_page_response resp;
+	struct iopf_fault *iopf, *next;
+	int ret = 0;
 
 	if (!iopf_param)
 		return -ENODEV;
 
 	flush_workqueue(iopf_param->queue->wq);
+
+	mutex_lock(&iopf_param->lock);
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
+		if (!(iopf->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
+		    iopf->fault.prm.pasid != pasid)
+			break;
+
+		list_del(&iopf->list);
+		kfree(iopf);
+	}
+
+	list_for_each_entry_safe(iopf, next, &iopf_param->faults, list) {
+		if (!(iopf->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
+		    iopf->fault.prm.pasid != pasid)
+			continue;
+
+		memset(&resp, 0, sizeof(struct iommu_page_response));
+		resp.pasid = iopf->fault.prm.pasid;
+		resp.grpid = iopf->fault.prm.grpid;
+		resp.code = IOMMU_PAGE_RESP_INVALID;
+
+		if (iopf->fault.prm.flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID)
+			resp.flags = IOMMU_PAGE_RESP_PASID_VALID;
+
+		ret = ops->page_response(dev, iopf, &resp);
+		if (ret)
+			break;
+
+		list_del(&iopf->list);
+		kfree(iopf);
+	}
+	mutex_unlock(&iopf_param->lock);
 	iopf_put_dev_fault_param(iopf_param);
 
-	return 0;
+	return ret;
 }
-EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
+EXPORT_SYMBOL_GPL(iopf_queue_discard_dev_pasid);
 
 /**
  * iopf_group_response - Respond a group of page faults
-- 
2.34.1

