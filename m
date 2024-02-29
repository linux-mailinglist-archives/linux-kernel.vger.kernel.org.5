Return-Path: <linux-kernel+bounces-86094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1098D86BF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9473C287C95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393F374C4;
	Thu, 29 Feb 2024 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7HuM4kW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7D224DC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177516; cv=none; b=Il4crbyKLTXkzkFJI0Ue4c9QmuhdBprasC07MiiocgFVrFrj4SkEYEHqLw5jfQPj3gVfsV532pgf1KbWRC1nZywCTAnFRXddzdQyLRT4bdi8TDjxLPJxLsqFLXNpFnDyE8sXUaa4vushCEzXKV7fHUCht3SpDveg+gIi9wmv8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177516; c=relaxed/simple;
	bh=4cTVcJ3SUxPHYzHn2pDBkxHL7saiq6NY+ySDwsITglc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpM6OGOJRThgG/XasTXVfLHp8Qbm3eWTKRX4gZebyGIeRNvGpTvytKrJ5GrsI0sXsbVlaisCalkEcn7jWjRlGWBVUM1DiGFQAZfGyWwRll+DsHRqazhSA2H8F3qhB6BA3aWx+yMPWE2HcSfhwGifhGolip/icRJlCzCHsAcnUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7HuM4kW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709177514; x=1740713514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4cTVcJ3SUxPHYzHn2pDBkxHL7saiq6NY+ySDwsITglc=;
  b=T7HuM4kWJCU5jV+0OsBIU8Re1nDdfqgbg1CgO5xq1R36WokDE/y5+oFL
   lg/CvIsY1Xa1+wJ4J1zV3bda1RmodFriw7Q5/kIwtIAGQMJaC7E8OJrCc
   YwcN50/1bfFOaqGCMc0xenxpmXx/41CWQJAkhDSF+HicoHH2TGAvTsA47
   dKqyED168uGi/ASvsWlj/zHQyTYleQYSzMxJUyQpCr5UyyD9MjkaizB0W
   9il3dNnY9T3Oi22ip4rqTHSx/Dwre4Y/tZHOiT60EcegRXRRuU0+ZYAuc
   DH3l2e0MbP7UXJAoxVdjoFNgwnXIG+23P5RQJ9xbsYnSgk3sRWtOGZqHq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14772552"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14772552"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8232101"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa008.jf.intel.com with ESMTP; 28 Feb 2024 19:31:45 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH] iommu/vt-d: avoid sending explicit ATS invalidation request to released device
Date: Wed, 28 Feb 2024 22:31:38 -0500
Message-Id: <20240229033138.3379560-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction of per iommu device rbtree also defines the lifetime of
interoperation between iommu and devices, if the device has been released
from device rbtree, no need to send ATS invalidation request to it anymore,
thus avoid the possibility of later ITE fault to be triggered.

This is part of the followup of prior proposed patchset

https://do-db2.lkml.org/lkml/2024/2/22/350

To make sure all the devTLB entries to be invalidated in the device release
path, do implict invalidation by fapping the E bit of ATS control register.
see PCIe spec v6.2, sec 10.3.7 implicit invalidation events.

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++++
 drivers/iommu/intel/pasid.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6743fe6c7a36..b85d88ccb4b0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1368,6 +1368,12 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	pdev = to_pci_dev(info->dev);
 
 	if (info->ats_enabled) {
+		pci_disable_ats(pdev);
+		/*
+		 * flap the E bit of ATS control register to do implicit
+		 * ATS invlidation, see PCIe spec v6.2, sec 10.3.7
+		 */
+		pci_enable_ats(pdev, VTD_PAGE_SHIFT);
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
 		domain_update_iotlb(info->domain);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 108158e2b907..5f13e017a12c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -215,6 +215,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 		return;
 
 	sid = info->bus << 8 | info->devfn;
+	/*
+	 * If device has been released from rbtree, no need to send ATS
+	 * Invalidation	request anymore, that could cause ITE fault.
+	 */
+	if (!device_rbtree_find(iommu, sid))
+		return;
+
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-- 
2.31.1


