Return-Path: <linux-kernel+bounces-32458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4AA835BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C4EB25D81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A663182DC;
	Mon, 22 Jan 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1dRxPXb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC82374E5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909499; cv=none; b=Dy6JgG+2eV5xTHpQViJGHpg7Wqq+xWaHxBRKOajnWrYCM9rWxdFy9lT3g9Ns/SqDHZuDocQ70ei5uKycrua0LZIFnI4vfKtRdJGMdgHDZdyj9pbAhzki/EsigEg1+OTrTfDTUiHml/MiKv7A+ttibXCEC2eWqO5m+0nyGJlr1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909499; c=relaxed/simple;
	bh=AAA7ZFqCERjHLbjdGyFGZVuugtSq3l9iPfmyQAbJj78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CX0LolqukOZ0xUySm0MnzT8U33HYxkxbGIhTIAx/Fx4GLV++EQBdjAanMq3oEGy7H7PofTMf4BPdF7V5ju6npf/SeqAN6FUh4hgaQwp0ItT9HITJsfYH8Dh2jUZLpRx982w9vKVNOUGQdODe/KeSo3nmu4bGepXUYzHlqxy+Pfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1dRxPXb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705909498; x=1737445498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAA7ZFqCERjHLbjdGyFGZVuugtSq3l9iPfmyQAbJj78=;
  b=h1dRxPXbmtxUJc+Nu8KIfhPju6kKEcyJlOb6TbxmMkW189CzuNaqvrXo
   XY6S5d7JEZjg2WfxEgwg5nbkDLZKn9P26BviKhuuddUF6kQPfmmwxkI0q
   CEiU7JM3lntHdl0X2oAuk+dxrU78sVCjFn7Lj0HUElNkMX1ry3hkKckdV
   buKo6BbnvswTVttG0UsyWSsHK3p5qdHl8gq6hu2cxDVeAOL2BEYhJihEF
   BkCYSWDyroGTSmVNOPwprVlfOJTiDTCU/2Da+WDuMk4fVfCH0JDt3ALbF
   3WbuzCwpP27/8b2GEFRUYRQGXG/xnhEhVrBeMdBIIyDw8lgMuKk9Y1EIW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22611624"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22611624"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778505018"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778505018"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2024 23:44:53 -0800
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 6/8] iommufd: IOPF-capable hw page table attach/detach/replace
Date: Mon, 22 Jan 2024 15:39:01 +0800
Message-Id: <20240122073903.24406-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122073903.24406-1-baolu.lu@linux.intel.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iopf-capable hw page table attach/detach/replace should use the iommu
iopf-specific interfaces. The pointer to iommufd_device is stored in the
private field of the attachment cookie, so that it can be easily retrieved
in the fault handling paths. The references to iommufd_device and
iommufd_hw_pagetable objects are held until the cookie is released, which
happens after the hw_pagetable is detached from the device and all
outstanding iopf's are responded to. This guarantees that both the device
and hw_pagetable are valid before domain detachment and outstanding faults
are handled.

The iopf-capable hw page tables can only be attached to devices that
support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
the device. Similarly, after the last iopf-capable hwpt is detached from
the device, the IOPF feature is disabled on the device.

The current implementation allows a replacement between iopf-capable and
non-iopf-capable hw page tables. This matches the nested translation use
case, where a parent domain is attached by default and can then be
replaced with a nested user domain with iopf support.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   7 ++
 drivers/iommu/iommufd/device.c          |  15 ++-
 drivers/iommu/iommufd/fault.c           | 122 ++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2780bed0c6b1..9844a1289c01 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -398,6 +398,7 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	bool iopf_enabled;
 	/* outstanding faults awaiting response indexed by fault group id */
 	struct xarray faults;
 };
@@ -459,6 +460,12 @@ iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
 int iommufd_fault_iopf_handler(struct iopf_group *group);
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev);
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev);
+int iommufd_fault_domain_replace_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d70913ee8fdf..c4737e876ebc 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -377,7 +377,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault_capable)
+			rc = iommufd_fault_domain_attach_dev(hwpt, idev);
+		else
+			rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -403,7 +406,10 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault_capable)
+			iommufd_fault_domain_detach_dev(hwpt, idev);
+		else
+			iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
@@ -498,7 +504,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
+	if (old_hwpt->fault_capable || hwpt->fault_capable)
+		rc = iommufd_fault_domain_replace_dev(hwpt, idev);
+	else
+		rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
 	if (rc)
 		goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index e752d1c49dde..a4a49f3cd4c2 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -267,3 +267,125 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 
 	return 0;
 }
+
+static void release_attach_cookie(struct iopf_attach_cookie *cookie)
+{
+	struct iommufd_hw_pagetable *hwpt = cookie->domain->fault_data;
+	struct iommufd_device *idev = cookie->private;
+
+	refcount_dec(&idev->obj.users);
+	refcount_dec(&hwpt->obj.users);
+	kfree(cookie);
+}
+
+static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+{
+	int ret;
+
+	if (idev->iopf_enabled)
+		return 0;
+
+	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		return ret;
+
+	idev->iopf_enabled = true;
+
+	return 0;
+}
+
+static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+{
+	if (!idev->iopf_enabled)
+		return;
+
+	iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	idev->iopf_enabled = false;
+}
+
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev)
+{
+	struct iopf_attach_cookie *cookie;
+	int ret;
+
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	if (!cookie)
+		return -ENOMEM;
+
+	refcount_inc(&hwpt->obj.users);
+	refcount_inc(&idev->obj.users);
+	cookie->release = release_attach_cookie;
+	cookie->private = idev;
+
+	if (!idev->iopf_enabled) {
+		ret = iommufd_fault_iopf_enable(idev);
+		if (ret)
+			goto out_put_cookie;
+	}
+
+	ret = iopf_domain_attach(hwpt->domain, idev->dev, IOMMU_NO_PASID, cookie);
+	if (ret)
+		goto out_disable_iopf;
+
+	return 0;
+out_disable_iopf:
+	iommufd_fault_iopf_disable(idev);
+out_put_cookie:
+	release_attach_cookie(cookie);
+
+	return ret;
+}
+
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	iopf_domain_detach(hwpt->domain, idev->dev, IOMMU_NO_PASID);
+	iommufd_fault_iopf_disable(idev);
+}
+
+int iommufd_fault_domain_replace_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	bool iopf_enabled_originally = idev->iopf_enabled;
+	struct iopf_attach_cookie *cookie = NULL;
+	int ret;
+
+	if (hwpt->fault_capable) {
+		cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+		if (!cookie)
+			return -ENOMEM;
+
+		refcount_inc(&hwpt->obj.users);
+		refcount_inc(&idev->obj.users);
+		cookie->release = release_attach_cookie;
+		cookie->private = idev;
+
+		if (!idev->iopf_enabled) {
+			ret = iommufd_fault_iopf_enable(idev);
+			if (ret) {
+				release_attach_cookie(cookie);
+				return ret;
+			}
+		}
+	}
+
+	ret = iopf_domain_replace(hwpt->domain, idev->dev, IOMMU_NO_PASID, cookie);
+	if (ret) {
+		goto out_put_cookie;
+	}
+
+	if (iopf_enabled_originally && !hwpt->fault_capable)
+		iommufd_fault_iopf_disable(idev);
+
+	return 0;
+out_put_cookie:
+	if (hwpt->fault_capable)
+		release_attach_cookie(cookie);
+	if (iopf_enabled_originally && !idev->iopf_enabled)
+		iommufd_fault_iopf_enable(idev);
+	else if (!iopf_enabled_originally && idev->iopf_enabled)
+		iommufd_fault_iopf_disable(idev);
+
+	return ret;
+}
-- 
2.34.1


