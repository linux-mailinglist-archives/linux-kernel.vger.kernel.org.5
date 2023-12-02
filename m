Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB590801BD1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjLBJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjLBJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:48:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4C181;
        Sat,  2 Dec 2023 01:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510545; x=1733046545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hOSJlPe1dfesUGDszntE2ySqLMhZ74ABDSSs+Yf065E=;
  b=UH2Q45X6iGIkbfzmkiFKTDoRJ3efHQne4QGlODGJghZe/cMifXJu7CEF
   4VkcJnLoPg/rSDMkEG9e6bYogWkfZjlwfaBMnnPPd7bT23iocz+lyp0Vu
   CHG0loxZq0CfmJyjH+MInDs6M+0H5BIv9sk9Ey4+poykFickaTuguNDLe
   vNX8k1KG9QPnLRjQW7jjSVahPrWmwI4zHhMYQYGr5cL4H1eOpiYuTtpBm
   LxFCLOmrCOEkSeix+EuBD3+YKcTfT97bGM1U+37mPEIuZilIAS5o4ya/d
   aBne3Jyhz7ObNjt5pdv1OxYxqeMl+KISILmVz4+hDrtKqwjXuC+VztpAP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="373774703"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="373774703"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1017293275"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="1017293275"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:49:02 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 10/42] iommu: Add new iommu op to create domains managed by KVM
Date:   Sat,  2 Dec 2023 17:20:07 +0800
Message-Id: <20231202092007.14026-1-yan.y.zhao@intel.com>
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

Introduce a new iommu_domain op to create domains managed by KVM through
IOMMUFD.

These domains have a few different properties compares to kernel owned
domains and user owned domains:

- They must not be PAGING domains. Page mapping/unmapping is controlled by
  KVM.

- They must be stage 2 mappings translating GPA to HPA.

- Paging structure allocation/free is not managed by IOMMU driver, but
  by KVM.

- TLBs flushes are notified by KVM.

The new op clearly says the domain is being created by IOMMUFD.
A driver specific structure to the meta data of paging structures from KVM
is passed in via the op param "data".

IOMMU drivers that cannot support VFIO/IOMMUFD should not support this op.

This new op for now is only supposed to be used by IOMMUFD, hence no
wrapper for it. IOMMUFD would call the callback directly. As for domain
free, IOMMUFD would use iommu_domain_free().

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/iommu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9ecee72e2d6c4..0ce23ee399d35 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -522,6 +522,13 @@ __iommu_copy_struct_from_user_array(void *dst_data,
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
  * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
+ * @domain_alloc_kvm: Allocate an iommu domain with type IOMMU_DOMAIN_KVM.
+ *                    It's called by IOMMUFD and must fully initialize the new
+ *                    domain before return.
+ *                    The @data is of type "const void *" whose format is defined
+ *                    in kvm arch specific header "asm/kvm_exported_tdp.h".
+ *                    Unpon success, domain of type IOMMU_DOMAIN_KVM is returned.
+ *                    Upon failure, ERR_PTR is returned.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -564,6 +571,8 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
 	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
 						 struct mm_struct *mm);
+	struct iommu_domain *(*domain_alloc_kvm)(struct device *dev, u32 flags,
+						 const void *data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.17.1

