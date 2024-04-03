Return-Path: <linux-kernel+bounces-128915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26FC8961D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E30B23B73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C415AF1;
	Wed,  3 Apr 2024 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGiJnaZh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F884125BA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106989; cv=none; b=lik/FDhC3jQWnKBdDtoOb23TlHCY5M1fswmudyMpmcfDOxRUswcL3zNCiU57a1zjEc4zntykI7M2EhYG6o9kR/HguNoQdXda7eeK5EG/eN2VQ12nwYcgdu2knoUDs+CnSjrEonvLimIHSjIL6rui0lKQ1bllDDZxUNnWJnppO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106989; c=relaxed/simple;
	bh=FBGUPCTNxWOMWjnzleaC2maOOJOWMB+ATa7ZAGFJJAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRHjolF+tCaVDDlNrFZtP8+T/gWXwn2bsfBJ1YUa7aR52lKJoJwh0LrVb4evLWN1V2YMH6f9EmzL1uh6EionODoE1S7RkW0g2u+YDaMTzG7dzjNNckyGEAfz8RlEjeBGKL1hMXtTZk6IE29rteplws3fbK6txdM9p8Yi7y3H3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGiJnaZh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712106987; x=1743642987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FBGUPCTNxWOMWjnzleaC2maOOJOWMB+ATa7ZAGFJJAU=;
  b=nGiJnaZhuO3KxqfNzM1kazpe9eIw8CFTq3/HNzw8Ui8STPrKmUBT40Pw
   03cwQYYDY6wrdSJy4V7inyr0LdG3x6mYgU5hPcBEYOCbrdf68cW+WZN4/
   oObjEgFXfGIlMItYpvbvEUzshuiC9ivHCNWBzr9PGR1dAKDmFwitUW2uu
   LBeta2D4XsWne0rkiD9BFFfhyHeAZ2DhXbA3l5D0c3DyLYa29gtHZrdv2
   QpyoEdVlSnUADtbDvgkvPOIuIvbAI8KXAp9OIUNQ32kuZK11nVym8gCsA
   XRUOxl065mY4q8VWu3QSrhoZ2rAFAYVY27R61rEYTlCOLxzRtT1e/KiGj
   A==;
X-CSE-ConnectionGUID: obC/itaLSwWV/Nko2F7+wQ==
X-CSE-MsgGUID: fRweXhaZTIStXyWBGHxCaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439720"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439720"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:27 -0700
X-CSE-ConnectionGUID: cfmB93LzQJiiRWqj11XNXA==
X-CSE-MsgGUID: 1Vmh/tGbSTiMW8xVNnYamw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953267"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 1/9] iommu: Introduce domain attachment handle
Date: Wed,  3 Apr 2024 09:15:11 +0800
Message-Id: <20240403011519.78512-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403011519.78512-1-baolu.lu@linux.intel.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when attaching a domain to a device or its PASID, domain is
stored within the iommu group. It could be retrieved for use during the
window between attachment and detachment.

With new features introduced, there's a need to store more information
than just a domain pointer. This information essentially represents the
association between a domain and a device. For example, the SVA code
already has a custom struct iommu_sva which represents a bond between
sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
a place to store the iommufd_device pointer in the core, so that the
device object ID could be quickly retrieved in the critical fault handling
path.

Introduce domain attachment handle that explicitly represents the
attachment relationship between a domain and a device or its PASID.
A caller-specific data field can be used by the caller to store additional
information beyond a domain pointer, depending on its specific use case.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu-priv.h |   9 +++
 drivers/iommu/iommu.c      | 158 +++++++++++++++++++++++++++++++++----
 2 files changed, 153 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 5f731d994803..08c0667cef54 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -28,4 +28,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
 				 struct notifier_block *nb);
 
+struct iommu_attach_handle {
+	struct iommu_domain		*domain;
+	refcount_t			users;
+	void				*priv;
+};
+
+struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
+						    ioasid_t pasid);
+void iommu_attach_handle_put(struct iommu_attach_handle *handle);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a95a483def2d..8bbff3bf7c26 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2039,6 +2039,94 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
+/* Add an attach handle to the group's pasid array. */
+static struct iommu_attach_handle *
+iommu_attach_handle_set(struct iommu_domain *domain,
+			struct iommu_group *group, ioasid_t pasid)
+{
+	struct iommu_attach_handle *handle;
+	void *curr;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+
+	handle->domain = domain;
+	refcount_set(&handle->users, 1);
+
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, handle, GFP_KERNEL);
+	if (curr) {
+		kfree(handle);
+		return xa_err(curr) ? curr : ERR_PTR(-EBUSY);
+	}
+
+	return handle;
+}
+
+static struct iommu_attach_handle *
+iommu_attach_handle_replace(struct iommu_domain *domain,
+			    struct iommu_group *group, ioasid_t pasid)
+{
+	struct iommu_attach_handle *handle, *curr;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+
+	handle->domain = domain;
+	refcount_set(&handle->users, 1);
+
+	curr = xa_store(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	if (xa_err(curr)) {
+		kfree(handle);
+		return curr;
+	}
+
+	if (curr)
+		iommu_attach_handle_put(curr);
+
+	return handle;
+}
+
+/*
+ * Return caller the attach handle. The caller holds a refcount of the handle.
+ * This refcount should be released by calling iommu_attach_handle_put().
+ */
+struct iommu_attach_handle *
+iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid)
+{
+	struct iommu_attach_handle *handle;
+
+	xa_lock(&group->pasid_array);
+	handle = xa_load(&group->pasid_array, pasid);
+	if (handle)
+		refcount_inc(&handle->users);
+	xa_unlock(&group->pasid_array);
+
+	return handle;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
+
+/* Put the refcount of the attach handle. */
+void iommu_attach_handle_put(struct iommu_attach_handle *handle)
+{
+	if (!handle)
+		return;
+
+	if (refcount_dec_and_test(&handle->users))
+		kfree(handle);
+}
+EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_put, IOMMUFD_INTERNAL);
+
+/* Remove the attach handle stored in group's pasid array. */
+static void iommu_attach_handle_remove(struct iommu_group *group, ioasid_t pasid)
+{
+	struct iommu_attach_handle *handle;
+
+	handle = xa_erase(&group->pasid_array, pasid);
+	iommu_attach_handle_put(handle);
+}
+
 /*
  * Put the group's domain back to the appropriate core-owned domain - either the
  * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
@@ -2187,12 +2275,25 @@ static int __iommu_attach_group(struct iommu_domain *domain,
  */
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
+	struct iommu_attach_handle *handle;
 	int ret;
 
 	mutex_lock(&group->mutex);
+	handle = iommu_attach_handle_set(domain, group, IOMMU_NO_PASID);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_unlock;
+	}
 	ret = __iommu_attach_group(domain, group);
+	if (ret)
+		goto out_put_handle;
 	mutex_unlock(&group->mutex);
 
+	return 0;
+out_put_handle:
+	iommu_attach_handle_put(handle);
+out_unlock:
+	mutex_unlock(&group->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
@@ -2211,13 +2312,33 @@ EXPORT_SYMBOL_GPL(iommu_attach_group);
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain)
 {
+	struct iommu_domain *old_domain = group->domain;
+	struct iommu_attach_handle *handle;
 	int ret;
 
 	if (!new_domain)
 		return -EINVAL;
 
+	if (new_domain == old_domain)
+		return 0;
+
 	mutex_lock(&group->mutex);
 	ret = __iommu_group_set_domain(group, new_domain);
+	if (ret)
+		goto out_unlock;
+
+	handle = iommu_attach_handle_replace(new_domain, group, IOMMU_NO_PASID);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_old_domain;
+	}
+	mutex_unlock(&group->mutex);
+
+	return 0;
+
+out_old_domain:
+	__iommu_group_set_domain(group, old_domain);
+out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
 }
@@ -2352,6 +2473,7 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
 	__iommu_group_set_core_domain(group);
+	iommu_attach_handle_remove(group, IOMMU_NO_PASID);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
@@ -3354,8 +3476,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *handle;
 	struct group_device *device;
-	void *curr;
 	int ret;
 
 	if (!domain->ops->set_dev_pasid)
@@ -3376,17 +3498,22 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+	handle = iommu_attach_handle_set(domain, group, pasid);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
 		goto out_unlock;
 	}
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret) {
-		__iommu_remove_group_pasid(group, pasid);
-		xa_erase(&group->pasid_array, pasid);
-	}
+	if (ret)
+		goto out_put_handle;
+	mutex_unlock(&group->mutex);
+
+	return 0;
+
+out_put_handle:
+	__iommu_remove_group_pasid(group, pasid);
+	iommu_attach_handle_put(handle);
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
@@ -3410,7 +3537,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid);
-	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
+	iommu_attach_handle_remove(group, pasid);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
@@ -3433,18 +3560,21 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 						    ioasid_t pasid,
 						    unsigned int type)
 {
-	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
-	struct iommu_domain *domain;
+	struct iommu_attach_handle *handle;
+	struct iommu_domain *domain = NULL;
 
 	if (!group)
 		return NULL;
 
-	xa_lock(&group->pasid_array);
-	domain = xa_load(&group->pasid_array, pasid);
+	handle = iommu_attach_handle_get(group, pasid);
+	if (handle) {
+		domain = handle->domain;
+		iommu_attach_handle_put(handle);
+	}
+
 	if (type && domain && domain->type != type)
 		domain = ERR_PTR(-EBUSY);
-	xa_unlock(&group->pasid_array);
 
 	return domain;
 }
-- 
2.34.1


