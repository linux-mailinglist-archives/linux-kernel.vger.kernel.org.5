Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC17F99E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjK0Geb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjK0GeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:34:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C34B9E;
        Sun, 26 Nov 2023 22:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701066872; x=1732602872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THSTj804tptnmR/MFvHQIO8aGmu5XCp9mxbj13d6iE8=;
  b=IRZOYP70pBBTrijivqsNTyBsR7LQJyJdwcxFJ95nPJIyeh+rfK3XUua2
   hm5VKfER+vvm5wzFh3hUf9nQl2ozFFfMUegX/I3iDEy8L5qV2YV1T+Pnh
   zlcAMSrYMQD9KuizRwac0Ko5ZMzRQKznAW/AWsyt7KAHs5XF8NOgx8ltL
   oNfutFb2op9LfYjCZAzQ/sdC+HJPO5Lx3TViNsbREzhnIJOsDGTORNgbE
   FtOzD3MCI118uR5RiM1BVKI+xiBAa6cCp2ngaUNAamxo4YInFFNq5nm0z
   ioXXksxYPtfh9OTMyaUzZicjUuuaSHTCPDdsYAJCQgqbHZuvxLFUa+58o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391518132"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="391518132"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838608926"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="838608926"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2023 22:34:31 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Date:   Sun, 26 Nov 2023 22:34:21 -0800
Message-Id: <20231127063428.127436-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127063428.127436-1-yi.l.liu@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

Provide a high-level API to allow replacements of one domain with
another for specific pasid of a device. This is similar to
iommu_group_replace_domain() and it is also expected to be used
only by IOMMUFD.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h |  2 +
 drivers/iommu/iommu.c      | 82 +++++++++++++++++++++++++++++++-------
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 2024a2313348..5c32637f6325 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -19,6 +19,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
 
 int iommu_device_register_bus(struct iommu_device *iommu,
 			      const struct iommu_ops *ops, struct bus_type *bus,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9d573e971aff..ec213ebd5ecc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3430,6 +3430,27 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	}
 }
 
+static int __iommu_group_attach_pasid(struct iommu_domain *domain,
+				      struct iommu_group *group, ioasid_t pasid)
+{
+	void *curr;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (curr)
+		return xa_err(curr) ? : -EBUSY;
+
+	ret = __iommu_set_group_pasid(domain, group, pasid);
+	if (ret) {
+		__iommu_remove_group_pasid(group, pasid);
+		xa_erase(&group->pasid_array, pasid);
+	}
+
+	return ret;
+}
+
 /*
  * iommu_attach_device_pasid() - Attach a domain to pasid of device
  * @domain: the iommu domain.
@@ -3453,19 +3474,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		return -ENODEV;
 
 	mutex_lock(&group->mutex);
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
-		goto out_unlock;
-	}
-
-	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret) {
-		__iommu_remove_group_pasid(group, pasid);
-		xa_erase(&group->pasid_array, pasid);
-	}
-out_unlock:
+	ret = __iommu_group_attach_pasid(domain, group, pasid);
 	mutex_unlock(&group->mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
@@ -3479,8 +3490,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
  * The @domain must have been attached to @pasid of the @dev with
  * iommu_attach_device_pasid().
  */
-void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
-			       ioasid_t pasid)
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
@@ -3492,6 +3503,49 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
 
+/**
+ * iommu_replace_device_pasid - replace the domain that a pasid is attached to
+ * @domain: new IOMMU domain to replace with
+ * @dev: the physical device
+ * @pasid: pasid that will be attached to the new domain
+ *
+ * This API allows the pasid to switch domains. Return 0 on success, or an
+ * error. The pasid will roll back to use the old domain if failure. The
+ * caller could call iommu_detach_device_pasid() before free the old domain
+ * in order to avoid use-after-free case.
+ */
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_domain *old_domain;
+	int ret;
+
+	if (!domain)
+		return -EINVAL;
+
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	__iommu_remove_group_pasid(group, pasid);
+	old_domain = xa_erase(&group->pasid_array, pasid);
+	ret = __iommu_group_attach_pasid(domain, group, pasid);
+	if (ret)
+		goto err_rollback;
+	mutex_unlock(&group->mutex);
+
+	return 0;
+
+err_rollback:
+	if (old_domain)
+		__iommu_group_attach_pasid(old_domain, group, pasid);
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
+
 /*
  * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
  * @dev: the queried device
-- 
2.34.1

