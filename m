Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C010775FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjHIMuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjHIMuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:50:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67E2108
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585433; x=1723121433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q97WzXCK6i2hC49d5NozMEhqvYe2vprBvZi0/iS7G6U=;
  b=Uj/+5GH/YULMRrUtnvRpJex4o3zv8oE45FgDtvDdKwYkuaydV+4ygLFj
   Le7R1QMg70D9XX1ZIk/VmY/Od1tw7XES4mMHXm6Vi2NefeAPx9zPlfaE7
   d2CIXgfpZXCklvmq8NGPcdbvxRDvijPuMpzLlX4ZM904HBPimORtUL8vj
   F1cBIEodd1rVKWyussDvNTRQ4tIGr0dlpi+9V9JVXI1ywU3LWCftFx7ph
   myrrNjFrFisk/plAb6j2dqFCflmzUNdsX3pEoW/SEwExDDcjJTg4ukhQe
   hygpJC7tQ83IPLRMCsyTrNl28C0ZkRyddpoYYcHbzBrPk5Ee1QUuhH7U2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821709"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521729"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521729"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Yanfei Xu <yanfei.xu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] iommu/vt-d: Make prq draining code generic
Date:   Wed,  9 Aug 2023 20:47:58 +0800
Message-Id: <20230809124806.45516-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently draining page requests and responses for a pasid is part of SVA
implementation. This is because the driver only supports attaching an SVA
domain to a device pasid. As we are about to support attaching other types
of domains to a device pasid, the prq draining code becomes generic.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20230802212427.1497170-6-jacob.jun.pan@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/iommu.c | 30 +++++++++++++++++++-----------
 drivers/iommu/intel/svm.c   | 17 ++---------------
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1c5e1d88862b..6d94a29f5d52 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -844,6 +844,7 @@ int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
 void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 
 struct intel_svm_dev {
 	struct list_head list;
@@ -862,6 +863,7 @@ struct intel_svm {
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
+static inline void intel_drain_pasid_prq(struct device *dev, u32 pasid) {}
 static inline struct iommu_domain *intel_svm_domain_alloc(void)
 {
 	return NULL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bb8316fec1aa..bdde38a5e43a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4720,21 +4720,29 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct iommu_domain *domain;
 
-	/* Domain type specific cleanup: */
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (domain) {
-		switch (domain->type) {
-		case IOMMU_DOMAIN_SVA:
-			intel_svm_remove_dev_pasid(dev, pasid);
-			break;
-		default:
-			/* should never reach here */
-			WARN_ON(1);
-			break;
-		}
+	if (WARN_ON_ONCE(!domain))
+		goto out_tear_down;
+
+	/*
+	 * The SVA implementation needs to handle its own stuffs like the mm
+	 * notification. Before consolidating that code into iommu core, let
+	 * the intel sva code handle it.
+	 */
+	if (domain->type == IOMMU_DOMAIN_SVA) {
+		intel_svm_remove_dev_pasid(dev, pasid);
+		goto out_tear_down;
 	}
 
+	/*
+	 * Should never reach here until we add support for attaching
+	 * non-SVA domain to a pasid.
+	 */
+	WARN_ON(1);
+
+out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	intel_drain_pasid_prq(dev, pasid);
 }
 
 const struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2a82864e9d57..9fbae9af6615 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -26,8 +26,6 @@
 #include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
-static void intel_svm_drain_prq(struct device *dev, u32 pasid);
-#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 
 static DEFINE_XARRAY_ALLOC(pasid_private_array);
 static int pasid_private_add(ioasid_t pasid, void *priv)
@@ -382,17 +380,6 @@ void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 
 	if (sdev) {
 		list_del_rcu(&sdev->list);
-		/*
-		 * Flush the PASID cache and IOTLB for this device.
-		 * Note that we do depend on the hardware *not* using
-		 * the PASID any more. Just as we depend on other
-		 * devices never using PASIDs that they have no right
-		 * to use. We have a *shared* PASID table, because it's
-		 * large and has to be physically contiguous. So it's
-		 * hard to be as defensive as we might like.
-		 */
-		intel_pasid_tear_down_entry(iommu, dev, svm->pasid, false);
-		intel_svm_drain_prq(dev, svm->pasid);
 		kfree_rcu(sdev, rcu);
 
 		if (list_empty(&svm->devs)) {
@@ -449,7 +436,7 @@ static bool is_canonical_address(u64 addr)
 }
 
 /**
- * intel_svm_drain_prq - Drain page requests and responses for a pasid
+ * intel_drain_pasid_prq - Drain page requests and responses for a pasid
  * @dev: target device
  * @pasid: pasid for draining
  *
@@ -463,7 +450,7 @@ static bool is_canonical_address(u64 addr)
  * described in VT-d spec CH7.10 to drain all page requests and page
  * responses pending in the hardware.
  */
-static void intel_svm_drain_prq(struct device *dev, u32 pasid)
+void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
 	struct dmar_domain *domain;
-- 
2.34.1

