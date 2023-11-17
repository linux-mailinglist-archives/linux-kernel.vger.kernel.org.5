Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C479A7EF39E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbjKQNSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345808AbjKQNSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:18:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1251C194;
        Fri, 17 Nov 2023 05:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700227100; x=1731763100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VdVJ6lFF2T1wzzLTbNcHA38NvnSY911siVQVfOeeDsM=;
  b=E40/huDiU5g53u9KDCKLynKmDHZmwgPrsKopkuRHXnYdVcEppd/8q5kt
   6sjJKtrBKTPPArAQUStkNOhpXbFvdvQ1UzvVeVu7ijLr+XDgFB437oLom
   5AOcOUUhZg/DUkTTOByZokmDNgkfUYh0U9A/bI8KbTEo83RFDt45/GFbw
   emcVNDOxg6j+gdCOozVlC4/gizEy/n7mRuXZNGzsoIUVsXhmo1kkU/fzB
   Dr8w77b/W0bCTbVTmekRbD+as/hcLWpU5UeYItPkIe18XsmIwE6Iueph1
   CntI2YEcP7tQo9mHQYJBKvzTf3Ho9e+aoxdRvsxz2OFHHgyUKLugfSuiE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381685588"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="381685588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:18:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="794831195"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="794831195"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2023 05:18:18 -0800
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
Subject: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
Date:   Fri, 17 Nov 2023 05:18:14 -0800
Message-Id: <20231117131816.24359-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117131816.24359-1-yi.l.liu@intel.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the data structure for flushing iotlb for the nested domain
allocated with IOMMU_HWPT_DATA_VTD_S1 type.

This only supports invalidating IOTLB, but no for device-TLB as device-TLB
invalidation will be covered automatically in the IOTLB invalidation if the
underlying IOMMU driver has enabled ATS for the affected device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/uapi/linux/iommufd.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 7f92cecc87d7..cafd98642abf 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -614,6 +614,42 @@ struct iommu_hwpt_get_dirty_bitmap {
 #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
 					IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
 
+/**
+ * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
+ *                                           stage-1 cache invalidation
+ * @IOMMU_VTD_INV_FLAGS_LEAF: The LEAF flag indicates whether only the
+ *                            leaf PTE caching needs to be invalidated
+ *                            and other paging structure caches can be
+ *                            preserved.
+ */
+enum iommu_hwpt_vtd_s1_invalidate_flags {
+	IOMMU_VTD_INV_FLAGS_LEAF = 1 << 0,
+};
+
+/**
+ * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
+ *                                       (IOMMU_HWPT_DATA_VTD_S1)
+ * @addr: The start address of the addresses to be invalidated. It needs
+ *        to be 4KB aligned.
+ * @npages: Number of contiguous 4K pages to be invalidated.
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
+ * @__reserved: Must be 0
+ *
+ * The Intel VT-d specific invalidation data for user-managed stage-1 cache
+ * invalidation in nested translation. Userspace uses this structure to
+ * tell the impacted cache scope after modifying the stage-1 page table.
+ *
+ * Invalidating all the caches related to the page table by setting @addr
+ * to be 0 and @npages to be __aligned_u64(-1). This includes the
+ * corresponding device-TLB if ATS is enabled on the attached devices.
+ */
+struct iommu_hwpt_vtd_s1_invalidate {
+	__aligned_u64 addr;
+	__aligned_u64 npages;
+	__u32 flags;
+	__u32 __reserved;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.34.1

