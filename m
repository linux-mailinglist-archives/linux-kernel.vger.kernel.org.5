Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF1801BEA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjLBJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjLBJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:55:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD001A6;
        Sat,  2 Dec 2023 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510929; x=1733046929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BZYTTtyQtvoxZgxXT0A+sCWE4cIHFzWJmMiUL2ynGlI=;
  b=dYmF9aQnVmkJu07WnrokIVdrrNK9YE4DbiE3Nqmtjm6cynHIf0YWYgH0
   6BCgO/jI1g2n/b0zcjGw55hAujJNPX7Jb4R2uGd1gqgcmtCAYbdNxWAOY
   nqyJBC/15s6TjfQVxKrKedMxfKMR50TJimQ3Yob9z8x76AFWfKuhalSw+
   zo/cXC/FT9IKNo9SHsuPeqcxsgfKOvAioRtHcfKzC2rfh562cLHnfTZy0
   +6XkkyalKT9TAombryRzQEnIlB9zA9hdKuhCQhzePMvPAjJk05LtyS9Uv
   2CVCsg86/1jnWJ/+yZKgKA5c00SakhhoMB7IoPgS0Wb7I4LFe2FZmKkMT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="393322196"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="393322196"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804337094"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="804337094"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:55:24 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 22/42] iommu/vt-d: Support cache invalidate of IOMMU_DOMAIN_KVM domain
Date:   Sat,  2 Dec 2023 17:26:30 +0800
Message-Id: <20231202092630.14764-1-yan.y.zhao@intel.com>
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

Support invalidation of hardware TLBs on KVM invalidates mappings on
domain of type IOMMU_DOMAIN_KVM.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/intel/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/intel/kvm.c b/drivers/iommu/intel/kvm.c
index 998d6daaf7ea1..56cb8f9bf1da0 100644
--- a/drivers/iommu/intel/kvm.c
+++ b/drivers/iommu/intel/kvm.c
@@ -62,10 +62,41 @@ static bool kvm_domain_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+static void domain_flush_iotlb_psi(struct dmar_domain *domain,
+				   unsigned long iova, unsigned long size)
+{
+	struct iommu_domain_info *info;
+	unsigned long i;
+
+	if (!IS_ALIGNED(size, VTD_PAGE_SIZE) ||
+	    !IS_ALIGNED(iova, VTD_PAGE_SIZE)) {
+		pr_err("Invalid KVM domain invalidation: iova=0x%lx, size=0x%lx\n",
+		       iova, size);
+		return;
+	}
+
+	xa_for_each(&domain->iommu_array, i, info)
+		iommu_flush_iotlb_psi(info->iommu, domain,
+				      iova >> VTD_PAGE_SHIFT,
+				      size >> VTD_PAGE_SHIFT, 1, 0);
+}
+
+static void kvm_domain_cache_invalidate(struct iommu_domain *domain,
+					unsigned long iova, unsigned long size)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (iova == 0 && size == -1UL)
+		intel_flush_iotlb_all(domain);
+	else
+		domain_flush_iotlb_psi(dmar_domain, iova, size);
+}
+
 static const struct iommu_domain_ops intel_kvm_domain_ops = {
 	.attach_dev		= intel_iommu_attach_device,
 	.free			= intel_iommu_domain_free,
 	.enforce_cache_coherency = kvm_domain_enforce_cache_coherency,
+	.cache_invalidate_kvm	= kvm_domain_cache_invalidate,
 };
 
 struct iommu_domain *
-- 
2.17.1

