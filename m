Return-Path: <linux-kernel+bounces-128917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE9D8961DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F5528A124
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE91B27D;
	Wed,  3 Apr 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwxUUJnk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F182A0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106997; cv=none; b=iRaf2v3wv9HaQuHM7xyMr2LFx2csZg6F18UWFYiqQe0NoHcWwaAEsSxGrMj9yxAzFkx5FO866z8AdzaKRVBDLVT0nDDDmKqAzn1wyfXfoDWBTNgdTtxnihyCrvb50e90Dd7v9IfivF74LI/6b9rkABXtpCxt3vqzFXMaO2b07g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106997; c=relaxed/simple;
	bh=dK0fNyZd1WIr3VTmct6pbCe1k++B9SVI6sp+uonMwzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4aA0syCudWANnTcaFziYy4LlclCV+VrECjWoFc0rAxIH3qnTJc90kzsXTltGMOIzi2iRFONOXJB8/7ghpneosjixqzyxcx1u5uOjYKU0ii4C/A/xp7jDzoCeuM5tKCdF5Id0cJ3Of0jh12gZ00J2WznmLJBTuaIPsOURYuhBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwxUUJnk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712106994; x=1743642994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dK0fNyZd1WIr3VTmct6pbCe1k++B9SVI6sp+uonMwzY=;
  b=TwxUUJnkVBAonbmIRafeMusi6oByZiNxbcOlLAyzHTVIA+Gw8yt1++Sw
   YFWMUFxqN+ZKNTN2oNtKyD2LnjAUbVJAQhHmJ+xg8XOO1mj2FMjqpsFcK
   BtgWBvPVwTkMQbIa1jAF0sUAoLBGEzjntikGGR4SQsdpYAMWyeRrTBZYs
   LDbeXtX+9EzjYMWW9F/uHNk1g8AEXz7QW9ZXjz3X9/4/C/1bNtNlWTCD+
   1H6BPEClBBFLMFI7enBa+/HlE5r37LZntmcs2M3DCTcQPgOhGh1bSJenb
   MJhcD6qF48b61YQkAylV3bFs+lDNhzCPz5gU0yuXiyAiSmF6F+m51krcC
   A==;
X-CSE-ConnectionGUID: 6NfqEuqRTXuIvEUnS5jJ/g==
X-CSE-MsgGUID: wL/hhxpcQlKPi8WU2yeFug==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439751"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439751"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:34 -0700
X-CSE-ConnectionGUID: Qc3wfx4vTlWbGrVnIAvhkQ==
X-CSE-MsgGUID: zrd241+ZT0W1Z3qqySB2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953278"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:31 -0700
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
Subject: [PATCH v4 3/9] iommu: Add attachment handle to struct iopf_group
Date: Wed,  3 Apr 2024 09:15:13 +0800
Message-Id: <20240403011519.78512-4-baolu.lu@linux.intel.com>
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

Previously, the domain that a page fault targets is stored in an
iopf_group, which represents a minimal set of page faults. With the
introduction of attachment handle, replace the domain with the handle
so that the fault handler can obtain more information as needed
when handling the faults.

iommu_report_device_fault() is currently used for SVA page faults,
which handles the page fault in an internal cycle. The domain is retrieved
with iommu_get_domain_for_dev_pasid() if the pasid in the fault message
is valid. This doesn't work in IOMMUFD case, where if the pasid table of
a device is wholly managed by user space, there is no domain attached to
the PASID of the device. Improve this code to try fetching the attachment
handle on a PASID if possible, otherwise try it on the RID.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  2 +-
 drivers/iommu/io-pgfault.c | 37 +++++++++++++++++--------------------
 drivers/iommu/iommu-sva.c  |  3 ++-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index be9c9a10169d..652a0bdd5074 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,7 +127,7 @@ struct iopf_group {
 	/* list node for iommu_fault_param::faults */
 	struct list_head pending_node;
 	struct work_struct work;
-	struct iommu_domain *domain;
+	struct iommu_attach_handle *attach_handle;
 	/* The device's fault data parameter. */
 	struct iommu_fault_param *fault_param;
 };
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 06d78fcc79fd..32004976a6b7 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -50,6 +50,9 @@ static void __iopf_free_group(struct iopf_group *group)
 
 	/* Pair with iommu_report_device_fault(). */
 	iopf_put_dev_fault_param(group->fault_param);
+
+	/* Pair with get_attach_handle_for_iopf(). */
+	iommu_attach_handle_put(group->attach_handle);
 }
 
 void iopf_free_group(struct iopf_group *group)
@@ -59,28 +62,22 @@ void iopf_free_group(struct iopf_group *group)
 }
 EXPORT_SYMBOL_GPL(iopf_free_group);
 
-static struct iommu_domain *get_domain_for_iopf(struct device *dev,
-						struct iommu_fault *fault)
+static struct iommu_attach_handle *
+get_attach_handle_for_iopf(struct device *dev, struct iommu_fault *fault)
 {
-	struct iommu_domain *domain;
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *handle;
+
+	if (!group)
+		return ERR_PTR(-ENODEV);
 
 	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
-		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
-		if (IS_ERR(domain))
-			domain = NULL;
-	} else {
-		domain = iommu_get_domain_for_dev(dev);
+		handle = iommu_attach_handle_get(group, fault->prm.pasid);
+		if (handle)
+			return handle;
 	}
 
-	if (!domain || !domain->iopf_handler) {
-		dev_warn_ratelimited(dev,
-			"iopf (pasid %d) without domain attached or handler installed\n",
-			 fault->prm.pasid);
-
-		return NULL;
-	}
-
-	return domain;
+	return iommu_attach_handle_get(group, IOMMU_NO_PASID);
 }
 
 /* Non-last request of a group. Postpone until the last one. */
@@ -206,15 +203,15 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group == &abort_group)
 		goto err_abort;
 
-	group->domain = get_domain_for_iopf(dev, fault);
-	if (!group->domain)
+	group->attach_handle = get_attach_handle_for_iopf(dev, fault);
+	if (!group->attach_handle || !group->attach_handle->domain->iopf_handler)
 		goto err_abort;
 
 	/*
 	 * On success iopf_handler must call iopf_group_response() and
 	 * iopf_free_group()
 	 */
-	if (group->domain->iopf_handler(group))
+	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
 	return;
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 35ac2e4836e9..c66cf26137bf 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -248,7 +248,8 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 		if (status != IOMMU_PAGE_RESP_SUCCESS)
 			break;
 
-		status = iommu_sva_handle_mm(&iopf->fault, group->domain->mm);
+		status = iommu_sva_handle_mm(&iopf->fault,
+					     group->attach_handle->domain->mm);
 	}
 
 	iopf_group_response(group, status);
-- 
2.34.1


