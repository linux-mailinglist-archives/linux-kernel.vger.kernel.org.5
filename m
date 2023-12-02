Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB87801C17
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjLBKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjLBKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:04:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16B1A6;
        Sat,  2 Dec 2023 02:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511449; x=1733047449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TMgeUuQ49CQ1kIvreWulUxr+utMzPKzhJ7mH5ahCx+8=;
  b=MkAQbsSBTH+R5d87sfxQdIO7c479rVEIBbz81oK1Nvi5MBQLQxQvy2Y/
   09eB6KhTl5lRhUFEWSNPPZEuDqwMlbvHS3FpSNhYPUbSYc/eemsSnMnfO
   XeuJ3kdX8df/hZBYFIOq8EIK1o6PrgPGmvfTkLhgES4qeVgbZSENGhPXi
   EPdMOQx0SpfwBK/gRaoKYtS/RECswHPKeu7cfffYKukls2lkTTaw0P+WK
   o7XCbdCJK9tPvW5YrQXg5F1Q/5usa02SFUk+OEt+pfIany/gs38PdYL4D
   C3Q9QZz93CRjz9JWbns4g99imQ9JlpwqVwRsK/N/N3PMmWnJNo07hB6w6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="392459598"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="392459598"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887939763"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="887939763"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:04:05 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 38/42] KVM: x86: "compose" and "get" interface for meta data of exported TDP
Date:   Sat,  2 Dec 2023 17:35:10 +0800
Message-Id: <20231202093510.15817-1-yan.y.zhao@intel.com>
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

Added two fields .exported_tdp_meta_size and .exported_tdp_meta_compose in
kvm_x86_ops to allow vendor specific code to compose meta data of exported
TDP and provided an arch interface for external components to get the
composed meta data.

As the meta data is consumed in IOMMU's vendor driver to check if the
exported TDP is compatible to the IOMMU hardware before reusing them as
IOMMU's stage 2 page tables, it's better to compose them in KVM's vendor
spcific code too.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  3 +++
 arch/x86/include/asm/kvm_host.h    |  7 +++++++
 arch/x86/kvm/x86.c                 | 23 ++++++++++++++++++++++-
 include/linux/kvm_host.h           |  6 ++++++
 virt/kvm/tdp_fd.c                  |  2 +-
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index d751407b1056c..baf3efaa148c2 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -136,6 +136,9 @@ KVM_X86_OP(msr_filter_changed)
 KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
+#if IS_ENABLED(CONFIG_HAVE_KVM_EXPORTED_TDP)
+KVM_X86_OP_OPTIONAL(exported_tdp_meta_compose);
+#endif
 
 #undef KVM_X86_OP
 #undef KVM_X86_OP_OPTIONAL
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 860502720e3e7..412a1b2088f09 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -26,6 +26,7 @@
 #include <linux/irqbypass.h>
 #include <linux/hyperv.h>
 #include <linux/kfifo.h>
+#include <linux/kvm_tdp_fd.h>
 
 #include <asm/apic.h>
 #include <asm/pvclock-abi.h>
@@ -1493,6 +1494,7 @@ struct kvm_exported_tdp_mmu {
 };
 struct kvm_arch_exported_tdp {
 	struct kvm_exported_tdp_mmu mmu;
+	void *meta;
 };
 #endif
 
@@ -1784,6 +1786,11 @@ struct kvm_x86_ops {
 	 * Returns vCPU specific APICv inhibit reasons
 	 */
 	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
+
+#ifdef CONFIG_HAVE_KVM_EXPORTED_TDP
+	unsigned long exported_tdp_meta_size;
+	void (*exported_tdp_meta_compose)(struct kvm_exported_tdp *tdp);
+#endif
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2886eac0590d8..468bcde414691 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13432,18 +13432,39 @@ EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
 #ifdef CONFIG_HAVE_KVM_EXPORTED_TDP
 int kvm_arch_exported_tdp_init(struct kvm *kvm, struct kvm_exported_tdp *tdp)
 {
+	void *meta;
 	int ret;
 
+	if (!kvm_x86_ops.exported_tdp_meta_size ||
+	    !kvm_x86_ops.exported_tdp_meta_compose)
+		return -EOPNOTSUPP;
+
+	meta = __vmalloc(kvm_x86_ops.exported_tdp_meta_size,
+			 GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!meta)
+		return -ENOMEM;
+
+	tdp->arch.meta = meta;
+
 	ret = kvm_mmu_get_exported_tdp(kvm, tdp);
-	if (ret)
+	if (ret) {
+		kvfree(meta);
 		return ret;
+	}
 
+	static_call(kvm_x86_exported_tdp_meta_compose)(tdp);
 	return 0;
 }
 
 void kvm_arch_exported_tdp_destroy(struct kvm_exported_tdp *tdp)
 {
 	kvm_mmu_put_exported_tdp(tdp);
+	kvfree(tdp->arch.meta);
+}
+
+void *kvm_arch_exported_tdp_get_metadata(struct kvm_exported_tdp *tdp)
+{
+	return tdp->arch.meta;
 }
 
 int kvm_arch_fault_exported_tdp(struct kvm_exported_tdp *tdp, unsigned long gfn,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a8af95194767f..48324c846d90b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2348,6 +2348,7 @@ int kvm_arch_exported_tdp_init(struct kvm *kvm, struct kvm_exported_tdp *tdp);
 void kvm_arch_exported_tdp_destroy(struct kvm_exported_tdp *tdp);
 int kvm_arch_fault_exported_tdp(struct kvm_exported_tdp *tdp, unsigned long gfn,
 				struct kvm_tdp_fault_type type);
+void *kvm_arch_exported_tdp_get_metadata(struct kvm_exported_tdp *tdp);
 #else
 static inline int kvm_arch_exported_tdp_init(struct kvm *kvm,
 					     struct kvm_exported_tdp *tdp)
@@ -2364,6 +2365,11 @@ static inline int kvm_arch_fault_exported_tdp(struct kvm_exported_tdp *tdp,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void *kvm_arch_exported_tdp_get_metadata(struct kvm_exported_tdp *tdp)
+{
+	return NULL;
+}
 #endif /* __KVM_HAVE_ARCH_EXPORTED_TDP */
 
 void kvm_tdp_fd_flush_notify(struct kvm *kvm, unsigned long gfn, unsigned long npages);
diff --git a/virt/kvm/tdp_fd.c b/virt/kvm/tdp_fd.c
index 8c16af685a061..e4a2453a5547f 100644
--- a/virt/kvm/tdp_fd.c
+++ b/virt/kvm/tdp_fd.c
@@ -217,7 +217,7 @@ static void kvm_tdp_unregister_all_importers(struct kvm_exported_tdp *tdp)
 
 static void *kvm_tdp_get_metadata(struct kvm_tdp_fd *tdp_fd)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return kvm_arch_exported_tdp_get_metadata(tdp_fd->priv);
 }
 
 static int kvm_tdp_fault(struct kvm_tdp_fd *tdp_fd, struct mm_struct *mm,
-- 
2.17.1

