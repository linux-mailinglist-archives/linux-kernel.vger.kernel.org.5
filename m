Return-Path: <linux-kernel+bounces-71192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC6D85A1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE0B1C229D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFFE2C68B;
	Mon, 19 Feb 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRmNCfDb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D92E419
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341730; cv=none; b=OY7TRF8vr3hQrQyE1MOMX51+ukzmVS7XdtfILLPqUPXGXrNE3c5gUj0JV55Ai2LdqVOPUyjyXCJBbW9a47KgCJb249DS3+WpZA10Tw3odR3Ta86tK7xGrslEIZrTp+fCJMOAGo93Kp8R9RITtGOj113J5QABgMaPspfGMS5Sm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341730; c=relaxed/simple;
	bh=Om6H6iwWgvEutVF7JX31pE1Rc0YLY3cg+69mPyvK1B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKvYJIiV87hQ4m+T7mnso2diAsUSoBQqf6HVp/MimJhiQgxy+PfawwsMD8z3hVWsg1k97SEwfRszkR/HeRf31HEpqzZyLLHUnndcr5A2WDVa1IfyRx5QY3Sv2+FKXimjEiQr8wvCKKYgDeJCx9ZhoiBRXvVtfg8mRN4WWcqTcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRmNCfDb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341729; x=1739877729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Om6H6iwWgvEutVF7JX31pE1Rc0YLY3cg+69mPyvK1B8=;
  b=QRmNCfDbtXfJHheQksjy6rvvKgAHF5N2nLjrVRt7l0KY8UkGfZnap99K
   ZhMPhD9xKwmrHIhqiKGS5Cmy23ir32hLka7Nijsr5ShuTUeAIUJ4nyWYa
   qXdWPAnSzEDxxXyCNXArKkIbt3gf2STsNpA98yRFu4gLxsb+TU6x8OUjB
   /4faVzYh/qpvmdZOnJEryFGuOs9LNSRdLVL81RL5RkTLxY2QAmIY11xEi
   //Kr/Uc3hxEO+l/ybJbBJRzAXhOsUHRIlV90HOgXUwbFQu7gfe1bKmCBU
   mMuTnIf2wK1f7PPeBPqnXBwhr39XVddGGcZBcwan6nF8TUKFGPKL/8uvh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823390"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823390"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826856"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:22:06 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] iommu/vt-d: Wrap the dirty tracking loop to be a helper
Date: Mon, 19 Feb 2024 19:15:58 +0800
Message-Id: <20240219111601.96405-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Add device_set_dirty_tracking() to loop all the devices and set the dirty
tracking per the @enable parameter.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20240208082307.15759-8-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d286b8554227..2ad8fbe6dc21 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4729,23 +4729,38 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	return vtd;
 }
 
+/*
+ * Set dirty tracking for the device list of a domain. The caller must
+ * hold the domain->lock when calling it.
+ */
+static int device_set_dirty_tracking(struct list_head *devices, bool enable)
+{
+	struct device_domain_info *info;
+	int ret = 0;
+
+	list_for_each_entry(info, devices, link) {
+		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
+						       IOMMU_NO_PASID, enable);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					  bool enable)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct device_domain_info *info;
 	int ret;
 
 	spin_lock(&dmar_domain->lock);
 	if (dmar_domain->dirty_tracking == enable)
 		goto out_unlock;
 
-	list_for_each_entry(info, &dmar_domain->devices, link) {
-		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
-						       IOMMU_NO_PASID, enable);
-		if (ret)
-			goto err_unwind;
-	}
+	ret = device_set_dirty_tracking(&dmar_domain->devices, enable);
+	if (ret)
+		goto err_unwind;
 
 	dmar_domain->dirty_tracking = enable;
 out_unlock:
@@ -4754,10 +4769,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 
 err_unwind:
-	list_for_each_entry(info, &dmar_domain->devices, link)
-		intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
-						 IOMMU_NO_PASID,
-						 dmar_domain->dirty_tracking);
+	device_set_dirty_tracking(&dmar_domain->devices,
+				  dmar_domain->dirty_tracking);
 	spin_unlock(&dmar_domain->lock);
 	return ret;
 }
-- 
2.34.1


