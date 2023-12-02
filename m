Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6067F801BDD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjLBJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:52:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CF0134;
        Sat,  2 Dec 2023 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510730; x=1733046730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qgwPOU0dccalAjjMk9ImV6B09aYt2Eqp8Z37kksWeQw=;
  b=exT2k//CH2x7cUhAJhUegDfTCDhV71i78bd0gAb/uE0KpTicm/uXnRly
   rd5BX4U4jpO+4ZnXXBskmf+HbPTAaGoxkYSGTIUYC+ZQGX9Co/ikeA+QV
   M0kN07q46Q8GLWExk61fN6jckTLAYhig/95FHtyY44kpx2zoIA0zdiDGf
   hIA9TI8myjUZezXYjYvDuH1CVRrWsYFgmDLTCzlsKjR+nYMfCarkG1g0N
   6yvlo4IOxBvvcZWRbDvr7aIjXxLgL0icm+DfhB7GzNQIWajujJmxXlG/M
   frOT8coGfYEO2nhT+WYQuyVE2PMiBr0BdRCbAVPK12msBK7R+51faR/F2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="6886663"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="6886663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="746280168"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="746280168"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:52:05 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 16/42] iommufd: Enable device feature IOPF during device attachment to KVM HWPT
Date:   Sat,  2 Dec 2023 17:23:11 +0800
Message-Id: <20231202092311.14392-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable device feature IOPF during device attachment to KVM HWPT and abort
the attachment if feature enabling is failed.

"pin" is not done by KVM HWPT. If VMM wants to create KVM HWPT, it must
know that all devices attached to this HWPT support IOPF so that pin-all
is skipped.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/iommufd/device.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 83af6b7e2784b..4ea447e052ce1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -381,10 +381,26 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
 	}
+	if (hwpt_is_kvm(hwpt)) {
+		/*
+		 * Feature IOPF requires ats is enabled which is true only
+		 * after device is attached to iommu domain.
+		 * So enable dev feature IOPF after iommu_attach_group().
+		 * -EBUSY will be returned if feature IOPF is already on.
+		 */
+		rc = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+		if (rc && rc != -EBUSY)
+			goto err_detach;
+	}
 	refcount_inc(&hwpt->obj.users);
 	list_add_tail(&idev->group_item, &idev->igroup->device_list);
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
+err_detach:
+	if (list_empty(&idev->igroup->device_list)) {
+		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		idev->igroup->hwpt = NULL;
+	}
 err_unresv:
 	if (hwpt_is_paging(hwpt))
 		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
@@ -408,6 +424,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	if (hwpt_is_paging(hwpt))
 		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
 					  idev->dev);
+	if (hwpt_is_kvm(hwpt))
+		iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
-- 
2.17.1

