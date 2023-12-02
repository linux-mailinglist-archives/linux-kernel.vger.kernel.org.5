Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB96801BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjLBJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjLBJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:54:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA98CC;
        Sat,  2 Dec 2023 01:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510901; x=1733046901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qum6bCO8m1UvZ+EuWUSsWmgfywLvc9j17rJU1lVG7vc=;
  b=GpvP4aUkodMLkK1ZQa9oV57K5vnj9XouXDzVO88zrBYZmeFNyEiViWle
   8ipuBfa4HMy7sAhQEsJzA9Ll1SUB95xxj7I+BlcTZR3kEHHbc3C47T544
   ZmI4MaqS/GimDRi9JRi5T1moEgsBZ8OndUm78AcL+dFaw5sR1TVt+Fj3A
   fTg9Ulp22qN6AjvNBBD6rAFOqoFZoCXG36o89v/gNcqQmL+ILc0so4+mp
   CdEL5jQBzBC2J/e9NNoNJeZOsvMxteQTv1tMcUHS9cjI0R7QPhMDL0dSU
   f0B2L9x82rKuUOIyTZJfbYyQU3EdLrYG+GtlrrPbGqVrOcOtkvo9u23B/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="393322186"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="393322186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804336985"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="804336985"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:54:56 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 21/42] iommu/vt-d: Check reserved bits for IOMMU_DOMAIN_KVM domain
Date:   Sat,  2 Dec 2023 17:26:02 +0800
Message-Id: <20231202092602.14704-1-yan.y.zhao@intel.com>
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

Compatibility check between IOMMU driver and KVM.
rsvd_bits_mask is provided by KVM to guarantee that the set bits are
must-be-zero bits in PTEs. Intel vt-d driver can check it to see if all
must-be-zero bits required by IOMMU side are included.

In this RFC, only bit 11 is checked for simplicity and demo purpose.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/intel/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iommu/intel/kvm.c b/drivers/iommu/intel/kvm.c
index 1ce334785430b..998d6daaf7ea1 100644
--- a/drivers/iommu/intel/kvm.c
+++ b/drivers/iommu/intel/kvm.c
@@ -32,6 +32,18 @@ static bool is_iommu_cap_compatible_to_kvm_domain(struct dmar_domain *domain,
 	return true;
 }
 
+static int check_tdp_reserved_bits(const struct kvm_exported_tdp_meta_vmx *tdp)
+{
+	int i;
+
+	for (i = PT64_ROOT_MAX_LEVEL; --i >= 0;) {
+		if (!(tdp->rsvd_bits_mask[0][i] & BIT(11)) ||
+		    !(tdp->rsvd_bits_mask[1][i] & BIT(11)))
+			return -EFAULT;
+	}
+	return 0;
+}
+
 int prepare_kvm_domain_attach(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	if (is_iommu_cap_compatible_to_kvm_domain(domain, iommu))
@@ -90,6 +102,11 @@ intel_iommu_domain_alloc_kvm(struct device *dev, u32 flags, const void *data)
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	if (check_tdp_reserved_bits(tdp)) {
+		pr_err("Reserved bits incompatible between KVM and IOMMU\n");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	dmar_domain = alloc_domain(IOMMU_DOMAIN_KVM);
 	if (!dmar_domain)
 		return ERR_PTR(-ENOMEM);
-- 
2.17.1

