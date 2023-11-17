Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269ED7EF39F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbjKQNS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346030AbjKQNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:18:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA26D57;
        Fri, 17 Nov 2023 05:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700227101; x=1731763101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RidyZbnJH2WdtltNPSz30z+b1yF96itdW/+pcCRzRqI=;
  b=KvkNphZwcQJDJPzACTFBEPDxSYNRnFcW9d8eykHnG0qqJxusfSZrpLD8
   cZKoaeDM7/kKj/6XWfqtaOIypnGd0rZOtMHoMAQj6+mvxJHKRYMgS0h3L
   VvhIz/XasdEfnAS/8/RAL/QPOLRU0PRpQWsco72StfmM4pIvoHpsPzSVG
   l/GR4RhSVPNoQ0b5sniLBfVnIDGEz/LZ9wHrvFzUR6yBrGn3cEBbCV/QZ
   G6tpSRq9bVWyn1quUFa3DG5JIEMYYDosnPha42LYgYO3FfBuvEdmHLbyg
   oleSUcnHPZyEsJRPln3QO1A4OCUaW8dEl2lcWWnedPZfekwCYZ9JmpZn6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381685614"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="381685614"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:18:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="794831206"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="794831206"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2023 05:18:20 -0800
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
Subject: [PATCH v7 3/3] iommu/vt-d: Add iotlb flush for nested domain
Date:   Fri, 17 Nov 2023 05:18:16 -0800
Message-Id: <20231117131816.24359-4-yi.l.liu@intel.com>
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

This implements the .cache_invalidate_user() callback to support iotlb
flush for nested domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index b5a5563ab32c..44ad48db7ea0 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -73,9 +73,63 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(to_dmar_domain(domain));
 }
 
+static void domain_flush_iotlb_psi(struct dmar_domain *domain,
+				   u64 addr, unsigned long npages)
+{
+	struct iommu_domain_info *info;
+	unsigned long i;
+
+	xa_for_each(&domain->iommu_array, i, info)
+		iommu_flush_iotlb_psi(info->iommu, domain,
+				      addr >> VTD_PAGE_SHIFT, npages, 1, 0);
+}
+
+static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
+					      struct iommu_user_data_array *array,
+					      u32 *cerror_idx)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_hwpt_vtd_s1_invalidate inv_info;
+	u32 index;
+	int ret;
+
+	/* REVISIT:
+	 * VT-d has defined ITE, ICE, IQE for invalidation failure per hardware,
+	 * but no error code yet, so just set the error code to be 0.
+	 */
+	*cerror_idx = 0;
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_info, array,
+							IOMMU_HWPT_DATA_VTD_S1,
+							index, __reserved);
+		if (ret) {
+			pr_err_ratelimited("Failed to fetch invalidation request\n");
+			break;
+		}
+
+		if (inv_info.__reserved || (inv_info.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) ||
+		    !IS_ALIGNED(inv_info.addr, VTD_PAGE_SIZE)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (inv_info.addr == 0 && inv_info.npages == -1)
+			intel_flush_iotlb_all(domain);
+		else
+			domain_flush_iotlb_psi(dmar_domain,
+					       inv_info.addr, inv_info.npages);
+	}
+
+	array->entry_num = index;
+
+	return ret;
+}
+
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
 	.free			= intel_nested_domain_free,
+	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
 
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
-- 
2.34.1

