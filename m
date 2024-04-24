Return-Path: <linux-kernel+bounces-156463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF18B0301
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5A11F247E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2391581E2;
	Wed, 24 Apr 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYZPb9rB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70315158D9B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943109; cv=none; b=YT0d97BsscbJrUKXhnpRj720PkJJ6zOzJIWtBqdjQK79TG3vMj889eZ4vLlxP1hUU+Kbm/n916VHoTtCNY4tkdnhSGRvFk5FXALbIetvfWKQTfeaDqUiX1ViEDLpDWajQpWwqgGECkNMKN5GsvoH0sYhWe4r2aCxtYqPTem/8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943109; c=relaxed/simple;
	bh=YzyPDAK2IuV4mY/SQNEY5OwxVGqO4DRvIMOe12sbL4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/MMhk5u1lq4J93x8h9QFoQPiEgThvYfTiWaZ9M6eTwUoIsBcG4Bn7x5T3hnuyuGvEjUzfmsZenlWibuxLnGzCu7sVvWCF0PVwPCp9JeIX5lvkUr9drpOVkO9FsDyuT+ObsWhkF1F6k/To/vYg/w+kaQK4r6AF8IFIcVGbm1Ck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYZPb9rB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943107; x=1745479107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzyPDAK2IuV4mY/SQNEY5OwxVGqO4DRvIMOe12sbL4U=;
  b=iYZPb9rBaWTSsMy5PBH8HgRfCHRwBWU9fAjGwO0iyGxys9qtfLQxdejg
   E6w+Fc0HHm0aaf98xYr4xK9Tr2dEh3+2iNno2n/pwhDqig35hqGnc17t+
   aOZkg2GPWFoHgJtJWikxsC7VsXjdT+L44/iWiQ2M7Xsp32Ta7B1mza3dJ
   iUMEdiY4x3Tqa+XyEDLlcrfTZ8n9FH6PvzerhxBPhzo6VfWVbPaEvJXuE
   5x+1FOfmLUvwFeL++yjeNk1zOex+s4yeYmyWsVSKPpGSX9VSCY8rp59f3
   JbLjImaEx50y+Ejl7NEqTxK1LlnwNP0ksVlJ3l3HVqHd9mcGqqmYapezM
   w==;
X-CSE-ConnectionGUID: ZCGLaYcIR+2638Bo8lZyFw==
X-CSE-MsgGUID: Fyzb8YIzTFuYtWiL68B4cQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073151"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073151"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:26 -0700
X-CSE-ConnectionGUID: 6C/Qh242QO+UhyAzh1CIbg==
X-CSE-MsgGUID: NH6VzWwoTquuPLtgkLYtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665107"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:23 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] iommu/vt-d: Add cache tag assignment interface
Date: Wed, 24 Apr 2024 15:16:33 +0800
Message-Id: <20240424071644.178250-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caching tag is a combination of tags used by the hardware to cache various
translations. Whenever a mapping in a domain is changed, the IOMMU driver
should invalidate the caches with the caching tags. The VT-d specification
describes caching tags in section 6.2.1, Tagging of Cached Translations.

Add interface to assign caching tags to an IOMMU domain when attached to a
RID or PASID, and unassign caching tags when a domain is detached from a
RID or PASID. All caching tags are listed in the per-domain tag list and
are protected by a dedicated lock.

In addition to the basic IOTLB and devTLB caching tag types, NESTING_IOTLB
and NESTING_DEVTLB tag types are also introduced. These tags are used for
caches that store translations for DMA accesses through a nested user
domain. They are affected by changes to mappings in the parent domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h  |  31 +++++
 drivers/iommu/intel/cache.c  | 214 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c  |  28 ++++-
 drivers/iommu/intel/nested.c |  19 +++-
 drivers/iommu/intel/svm.c    |  10 +-
 drivers/iommu/intel/Makefile |   2 +-
 6 files changed, 295 insertions(+), 9 deletions(-)
 create mode 100644 drivers/iommu/intel/cache.c

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 9ee326f7bf62..b7c79cc19681 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -606,6 +606,9 @@ struct dmar_domain {
 	struct list_head devices;	/* all devices' list */
 	struct list_head dev_pasids;	/* all attached pasids */
 
+	spinlock_t cache_lock;		/* Protect the cache tag list */
+	struct list_head cache_tags;	/* Cache tag list */
+
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
@@ -1091,6 +1094,34 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
 struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
 
+enum cache_tag_type {
+	CACHE_TAG_IOTLB,
+	CACHE_TAG_DEVTLB,
+	CACHE_TAG_NESTING_IOTLB,
+	CACHE_TAG_NESTING_DEVTLB,
+};
+
+struct cache_tag {
+	struct list_head node;
+	enum cache_tag_type type;
+	struct intel_iommu *iommu;
+	/*
+	 * The @dev field represents the location of the cache. For IOTLB, it
+	 * resides on the IOMMU hardware. @dev stores the device pointer to
+	 * the IOMMU hardware. For DevTLB, it locates in the PCIe endpoint.
+	 * @dev stores the device pointer to that endpoint.
+	 */
+	struct device *dev;
+	u16 domain_id;
+	ioasid_t pasid;
+	unsigned int users;
+};
+
+int cache_tag_assign_domain(struct dmar_domain *domain,
+			    struct device *dev, ioasid_t pasid);
+void cache_tag_unassign_domain(struct dmar_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 int intel_svm_enable_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
new file mode 100644
index 000000000000..296f1645a739
--- /dev/null
+++ b/drivers/iommu/intel/cache.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cache.c - Intel VT-d cache invalidation
+ *
+ * Copyright (C) 2024 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/dmar.h>
+#include <linux/iommu.h>
+#include <linux/memory.h>
+#include <linux/spinlock.h>
+
+#include "iommu.h"
+#include "pasid.h"
+
+/* Check if an existing cache tag can be reused for a new association. */
+static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
+			     struct intel_iommu *iommu, struct device *dev,
+			     ioasid_t pasid, enum cache_tag_type type)
+{
+	if (tag->type != type)
+		return false;
+
+	if (tag->domain_id != domain_id || tag->pasid != pasid)
+		return false;
+
+	if (type == CACHE_TAG_IOTLB || type == CACHE_TAG_NESTING_IOTLB)
+		return tag->iommu == iommu;
+
+	if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_NESTING_DEVTLB)
+		return tag->dev == dev;
+
+	return false;
+}
+
+/* Assign a cache tag with specified type to domain. */
+static int cache_tag_assign(struct dmar_domain *domain, u16 did,
+			    struct device *dev, ioasid_t pasid,
+			    enum cache_tag_type type)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct cache_tag *tag, *temp;
+	unsigned long flags;
+
+	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
+	if (!tag)
+		return -ENOMEM;
+
+	tag->type = type;
+	tag->iommu = iommu;
+	tag->domain_id = did;
+	tag->pasid = pasid;
+	tag->users = 1;
+
+	if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_NESTING_DEVTLB)
+		tag->dev = dev;
+	else
+		tag->dev = iommu->iommu.dev;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(temp, &domain->cache_tags, node) {
+		if (cache_tage_match(temp, did, iommu, dev, pasid, type)) {
+			temp->users++;
+			spin_unlock_irqrestore(&domain->cache_lock, flags);
+			kfree(tag);
+			return 0;
+		}
+	}
+	list_add_tail(&tag->node, &domain->cache_tags);
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+
+	return 0;
+}
+
+/* Unassign a cache tag with specified type from domain. */
+static void cache_tag_unassign(struct dmar_domain *domain, u16 did,
+			       struct device *dev, ioasid_t pasid,
+			       enum cache_tag_type type)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		if (cache_tage_match(tag, did, iommu, dev, pasid, type)) {
+			if (--tag->users == 0) {
+				list_del(&tag->node);
+				kfree(tag);
+			}
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+static int __cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
+				     struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
+	if (ret || !info->ats_enabled)
+		return ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_DEVTLB);
+	if (ret)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
+
+	return ret;
+}
+
+static void __cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
+					struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
+
+	if (info->ats_enabled)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_DEVTLB);
+}
+
+static int __cache_tag_assign_parent_domain(struct dmar_domain *domain, u16 did,
+					    struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
+	if (ret || !info->ats_enabled)
+		return ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_DEVTLB);
+	if (ret)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
+
+	return ret;
+}
+
+static void __cache_tag_unassign_parent_domain(struct dmar_domain *domain, u16 did,
+					       struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
+
+	if (info->ats_enabled)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_DEVTLB);
+}
+
+static u16 domain_get_id_for_dev(struct dmar_domain *domain, struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	/*
+	 * The driver assigns different domain IDs for all domains except
+	 * the SVA type.
+	 */
+	if (domain->domain.type == IOMMU_DOMAIN_SVA)
+		return FLPT_DEFAULT_DID;
+
+	return domain_id_iommu(domain, iommu);
+}
+
+/*
+ * Assign cache tags to a domain when it's associated with a device's
+ * PASID using a specific domain ID.
+ *
+ * On success (return value of 0), cache tags are created and added to the
+ * domain's cache tag list. On failure (negative return value), an error
+ * code is returned indicating the reason for the failure.
+ */
+int cache_tag_assign_domain(struct dmar_domain *domain,
+			    struct device *dev, ioasid_t pasid)
+{
+	u16 did = domain_get_id_for_dev(domain, dev);
+	int ret;
+
+	ret = __cache_tag_assign_domain(domain, did, dev, pasid);
+	if (ret || domain->domain.type != IOMMU_DOMAIN_NESTED)
+		return ret;
+
+	ret = __cache_tag_assign_parent_domain(domain->s2_domain, did, dev, pasid);
+	if (ret)
+		__cache_tag_unassign_domain(domain, did, dev, pasid);
+
+	return ret;
+}
+
+/*
+ * Remove the cache tags associated with a device's PASID when the domain is
+ * detached from the device.
+ *
+ * The cache tags must be previously assigned to the domain by calling the
+ * assign interface.
+ */
+void cache_tag_unassign_domain(struct dmar_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	u16 did = domain_get_id_for_dev(domain, dev);
+
+	__cache_tag_unassign_domain(domain, did, dev, pasid);
+	if (domain->domain.type == IOMMU_DOMAIN_NESTED)
+		__cache_tag_unassign_parent_domain(domain->s2_domain, did, dev, pasid);
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 002fee5fcb80..8220bb36e420 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1746,7 +1746,9 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
+	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->cache_lock);
 	xa_init(&domain->iommu_array);
 
 	return domain;
@@ -1758,6 +1760,9 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	unsigned long ndomains;
 	int num, ret = -ENOSPC;
 
+	if (domain->domain.type == IOMMU_DOMAIN_SVA)
+		return 0;
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -1805,6 +1810,9 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
+	if (domain->domain.type == IOMMU_DOMAIN_SVA)
+		return;
+
 	spin_lock(&iommu->lock);
 	info = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (--info->refcnt == 0) {
@@ -2323,6 +2331,13 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	ret = domain_attach_iommu(domain, iommu);
 	if (ret)
 		return ret;
+
+	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
+	if (ret) {
+		domain_detach_iommu(domain, iommu);
+		return ret;
+	}
+
 	info->domain = domain;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
@@ -3811,6 +3826,7 @@ void device_block_translation(struct device *dev)
 	list_del(&info->link);
 	spin_unlock_irqrestore(&info->domain->lock, flags);
 
+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 	domain_detach_iommu(info->domain, iommu);
 	info->domain = NULL;
 }
@@ -4598,6 +4614,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (WARN_ON_ONCE(!domain))
 		goto out_tear_down;
+	dmar_domain = to_dmar_domain(domain);
 
 	/*
 	 * The SVA implementation needs to handle its own stuffs like the mm
@@ -4606,10 +4623,10 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	 */
 	if (domain->type == IOMMU_DOMAIN_SVA) {
 		intel_svm_remove_dev_pasid(dev, pasid);
+		cache_tag_unassign_domain(dmar_domain, dev, pasid);
 		goto out_tear_down;
 	}
 
-	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
@@ -4621,6 +4638,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
@@ -4660,6 +4678,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_free;
 
+	ret = cache_tag_assign_domain(dmar_domain, dev, pasid);
+	if (ret)
+		goto out_detach_iommu;
+
 	if (domain_type_is_si(dmar_domain))
 		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
 	else if (dmar_domain->use_first_level)
@@ -4669,7 +4691,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
 	if (ret)
-		goto out_detach_iommu;
+		goto out_unassign_tag;
 
 	dev_pasid->dev = dev;
 	dev_pasid->pasid = pasid;
@@ -4681,6 +4703,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
+out_unassign_tag:
+	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 out_detach_iommu:
 	domain_detach_iommu(dmar_domain, iommu);
 out_free:
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index a7d68f3d518a..13406ee742bf 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -52,13 +52,14 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 		return ret;
 	}
 
+	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
+	if (ret)
+		goto detach_iommu;
+
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       IOMMU_NO_PASID, dmar_domain);
-	if (ret) {
-		domain_detach_iommu(dmar_domain, iommu);
-		dev_err_ratelimited(dev, "Failed to setup pasid entry\n");
-		return ret;
-	}
+	if (ret)
+		goto unassign_tag;
 
 	info->domain = dmar_domain;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
@@ -68,6 +69,12 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	domain_update_iotlb(dmar_domain);
 
 	return 0;
+unassign_tag:
+	cache_tag_unassign_domain(dmar_domain, dev, IOMMU_NO_PASID);
+detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+
+	return ret;
 }
 
 static void intel_nested_domain_free(struct iommu_domain *domain)
@@ -206,7 +213,9 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 	domain->domain.type = IOMMU_DOMAIN_NESTED;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
+	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->cache_lock);
 	xa_init(&domain->iommu_array);
 
 	spin_lock(&s2_domain->s1_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e05c6c4cb8c3..2e627fbd5adb 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -366,17 +366,23 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 			sdev->qdep = 0;
 	}
 
+	ret = cache_tag_assign_domain(to_dmar_domain(domain), dev, pasid);
+	if (ret)
+		goto free_sdev;
+
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
-		goto free_sdev;
+		goto unassign_tag;
 
 	list_add_rcu(&sdev->list, &svm->devs);
 
 	return 0;
 
+unassign_tag:
+	cache_tag_unassign_domain(to_dmar_domain(domain), dev, pasid);
 free_sdev:
 	kfree(sdev);
 free_svm:
@@ -741,6 +747,8 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	if (!domain)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
+	INIT_LIST_HEAD(&domain->cache_tags);
+	spin_lock_init(&domain->cache_lock);
 
 	return &domain->domain;
 }
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 5402b699a122..c8beb0281559 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o
 obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
 obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
-- 
2.34.1


