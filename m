Return-Path: <linux-kernel+bounces-164210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7238A8B7ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EA1B248E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295367710F;
	Tue, 30 Apr 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7ja24c+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684813D28D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489134; cv=none; b=CrtgufbE3axDrJFZyg4jB9De5wiEjlZLAwFe7Xa0sv7NzKVGI76lg6bdMSTnJ2O7L53EgSMWlWu+Xtm3kwvUeZvw07SGcYEGLqb7UtC6/BmU2wPRAPSzmClILmaTTNvVn9HOl+gba9Pa+zsA1EmetcS1mzFE5B32xDSDsIk5zk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489134; c=relaxed/simple;
	bh=UW8EMzuVfZ86632yFdTVNJtPdNnW2P19zdIqEH8dwck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LKkebPnkSElDtc8CwK/ycZzlNzRnR9Mp5nm5nRfeHEAxrwoNv/QMSk0SK/bhtN8r0SL//07ZcI/thWg06/E4Tqfh77/MKgBf7Mstu0G+ztpkr9w2yvQB8ObGkT0MvSCpu2ggzLHggxzfNfoNT0OzsWspBb/565C9RVKzNCXfl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7ja24c+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489133; x=1746025133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UW8EMzuVfZ86632yFdTVNJtPdNnW2P19zdIqEH8dwck=;
  b=X7ja24c+WTh5yKDFjqaUhFjHS7IhR9ZN8PYn13mMex8bw0ZRTteGHxeI
   288Ix46gV89o/TA0NITZoA1pzZ7vHR7SiMuIB2kvqV5+gXIHghc6hz4SS
   OriIUpYoPUdtj1w8JbJvuFdFbhR0mEcGo1pZO+HihtGbA/Y5JkW1hpyMf
   FXVKDO9+VW0xbuczoATb2xSYhTGUAj4PkHhSdRCBrBr73AmbWibGzraEy
   WNQLBDjOZ56CDrwcUeG8ThKTq/dsX5oNYeEoKb2wPY5scR4KFb7k1ieMW
   pmUdbE6sxdmjRFlvaZrlcpcKynfH7oxr1nAbxQZJagwujqujsHrCwTH+K
   Q==;
X-CSE-ConnectionGUID: huHRl8ihSSaYlpJ0vpfCvQ==
X-CSE-MsgGUID: VEwHUbm+R8+3LXt5p4VO4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059838"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059838"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:58:53 -0700
X-CSE-ConnectionGUID: MKyGhIhYQ1CbzJJnC7m3Bw==
X-CSE-MsgGUID: Wk33+9hiSCeKNHrYfxqjSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282132"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:58:49 -0700
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
Subject: [PATCH v5 1/9] iommu: Introduce domain attachment handle
Date: Tue, 30 Apr 2024 22:57:02 +0800
Message-Id: <20240430145710.68112-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430145710.68112-1-baolu.lu@linux.intel.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
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
Caller-specific data fields can be added later to store additional
information beyond a domain pointer, depending on its specific use case.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu-priv.h |   6 ++
 drivers/iommu/iommu.c      | 156 ++++++++++++++++++++++++++++++++-----
 2 files changed, 142 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 5f731d994803..da1addaa1a31 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -28,4 +28,10 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
 				 struct notifier_block *nb);
 
+struct iommu_attach_handle {
+	struct iommu_domain		*domain;
+};
+
+struct iommu_attach_handle *
+iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a95a483def2d..0cdd58e69e20 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2039,6 +2039,89 @@ void iommu_domain_free(struct iommu_domain *domain)
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
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, handle, GFP_KERNEL);
+	if (curr) {
+		kfree(handle);
+		return xa_err(curr) ? curr : ERR_PTR(-EBUSY);
+	}
+
+	return handle;
+}
+
+/* Remove the attach handle stored in group's pasid array. */
+static void iommu_attach_handle_remove(struct iommu_group *group, ioasid_t pasid)
+{
+	struct iommu_attach_handle *handle;
+
+	handle = xa_erase(&group->pasid_array, pasid);
+	kfree(handle);
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
+	curr = xa_store(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	if (xa_err(curr)) {
+		kfree(handle);
+		return curr;
+	}
+	kfree(curr);
+
+	return handle;
+}
+
+/*
+ * iommu_attach_handle_get - Return the attach handle
+ * @group: the iommu group that domain was attached to
+ * @pasid: the pasid within the group
+ * @type: matched domain type, 0 for any match
+ *
+ * Return handle or ERR_PTR(-ENOENT) on none, ERR_PTR(-EBUSY) on mismatch.
+ *
+ * Return the attach handle to the caller. The life cycle of an iommu attach
+ * handle is from the time when the domain is attached to the time when the
+ * domain is detached. Callers are required to synchronize the call of
+ * iommu_attach_handle_get() with domain attachment and detachment. The attach
+ * handle can only be used during its life cycle.
+ */
+struct iommu_attach_handle *
+iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type)
+{
+	struct iommu_attach_handle *handle;
+
+	xa_lock(&group->pasid_array);
+	handle = xa_load(&group->pasid_array, pasid);
+	if (!handle)
+		handle = ERR_PTR(-ENOENT);
+	else if (type && handle->domain->type != type)
+		handle = ERR_PTR(-EBUSY);
+	xa_unlock(&group->pasid_array);
+
+	return handle;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
+
 /*
  * Put the group's domain back to the appropriate core-owned domain - either the
  * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
@@ -2187,12 +2270,25 @@ static int __iommu_attach_group(struct iommu_domain *domain,
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
+		goto out_remove_handle;
 	mutex_unlock(&group->mutex);
 
+	return 0;
+out_remove_handle:
+	iommu_attach_handle_remove(group, IOMMU_NO_PASID);
+out_unlock:
+	mutex_unlock(&group->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
@@ -2211,13 +2307,33 @@ EXPORT_SYMBOL_GPL(iommu_attach_group);
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
@@ -2352,6 +2468,7 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
 	__iommu_group_set_core_domain(group);
+	iommu_attach_handle_remove(group, IOMMU_NO_PASID);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
@@ -3354,8 +3471,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *handle;
 	struct group_device *device;
-	void *curr;
 	int ret;
 
 	if (!domain->ops->set_dev_pasid)
@@ -3376,17 +3493,22 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
+	iommu_attach_handle_remove(group, pasid);
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
@@ -3410,7 +3532,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid);
-	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
+	iommu_attach_handle_remove(group, pasid);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
@@ -3433,20 +3555,14 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 						    ioasid_t pasid,
 						    unsigned int type)
 {
-	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
-	struct iommu_domain *domain;
+	struct iommu_attach_handle *handle;
 
-	if (!group)
-		return NULL;
+	handle = iommu_attach_handle_get(group, pasid, type);
+	if (IS_ERR(handle))
+		return (void *)handle;
 
-	xa_lock(&group->pasid_array);
-	domain = xa_load(&group->pasid_array, pasid);
-	if (type && domain && domain->type != type)
-		domain = ERR_PTR(-EBUSY);
-	xa_unlock(&group->pasid_array);
-
-	return domain;
+	return handle->domain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_pasid);
 
-- 
2.34.1


