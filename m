Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30107E42FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjKGPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjKGPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:11:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D8561A1;
        Tue,  7 Nov 2023 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369322; x=1730905322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OUVQYH8tGD1GjKHwVs4m6rotG1u9g8ZzFX1XSzVcyHc=;
  b=IAOLPOaaLtBredq0MvkY6iNb+OSSIHMJw0TLaeYn9xLOgaUlRCmtdouH
   kecLGF6oomZtE1PYr2JI0nhjtUd8mxua2tgNofqR3hyOFQAVBLmS9vGze
   08XcB4Pz9sRyGBuDe+66/hgwhcM2N80PsTdT4yAYdvUPY5/aADo+Zw+6u
   g9ex8tAo3MvYJUQ1KuohLo36IL2q179QbFVLjRkvd8YvARt78tY1cXvM6
   b0UCLs3bGyoSxL8ryP71EeN/oOcwuB/x0oJ753Sx3SCJe4UOqhHIulhR4
   k8apAoThttmoVCqLE1kWtrnl6f1X1GafLk6RYlzeU08elcYQ2dseNhMxJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="388397619"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="388397619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 07:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10446860"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 07:01:02 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v6 12/16] KVM: x86/tdp_mmu, TDX: Split a large page when 4KB page within it converted to shared
Date:   Tue,  7 Nov 2023 07:00:39 -0800
Message-Id: <051d18f03ff70a66387ec37988d1ffd29f43f4f5.1699368363.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368363.git.isaku.yamahata@intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

When mapping the shared page for TDX, it needs to zap private alias.

In the case that private page is mapped as large page (2MB), it can be
removed directly only when the whole 2MB is converted to shared.
Otherwise, it has to split 2MB page into 512 4KB page, and only remove
the pages that converted to shared.

When a present large leaf spte switches to present non-leaf spte, TDX needs
to split the corresponding SEPT page to reflect it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/mmu/tdp_mmu.c         | 21 ++++++++++++++++-----
 arch/x86/kvm/vmx/tdx.c             | 25 +++++++++++++++++++++++--
 arch/x86/kvm/vmx/tdx_arch.h        |  1 +
 arch/x86/kvm/vmx/tdx_ops.h         |  7 +++++++
 6 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 8ef0ed217f6e..3deb6ab4f291 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -103,6 +103,7 @@ KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL(link_private_spt)
 KVM_X86_OP_OPTIONAL(free_private_spt)
+KVM_X86_OP_OPTIONAL(split_private_spt)
 KVM_X86_OP_OPTIONAL(set_private_spte)
 KVM_X86_OP_OPTIONAL(remove_private_spte)
 KVM_X86_OP_OPTIONAL(zap_private_spte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c16823f3326e..e75a461bdea7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1753,6 +1753,8 @@ struct kvm_x86_ops {
 				void *private_spt);
 	int (*free_private_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				void *private_spt);
+	int (*split_private_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
+				  void *private_spt);
 	int (*set_private_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				 kvm_pfn_t pfn);
 	int (*remove_private_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a209a67decae..734ee822b43c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -599,23 +599,34 @@ static int __must_check __set_private_spte_present(struct kvm *kvm, tdp_ptep_t s
 {
 	bool was_present = is_shadow_present_pte(old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
+	bool was_leaf = was_present && is_last_spte(old_spte, level);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	kvm_pfn_t new_pfn = spte_to_pfn(new_spte);
+	void *private_spt;
 	int ret = 0;
 
 	lockdep_assert_held(&kvm->mmu_lock);
-	/* TDP MMU doesn't change present -> present */
-	KVM_BUG_ON(was_present, kvm);
 
 	/*
 	 * Use different call to either set up middle level
 	 * private page table, or leaf.
 	 */
-	if (is_leaf)
+	if (level > PG_LEVEL_4K && was_leaf && !is_leaf) {
+		/*
+		 * splitting large page into 4KB.
+		 * tdp_mmu_split_huage_page() => tdp_mmu_link_sp()
+		 */
+		private_spt = get_private_spt(gfn, new_spte, level);
+		KVM_BUG_ON(!private_spt, kvm);
+		ret = static_call(kvm_x86_zap_private_spte)(kvm, gfn, level);
+		kvm_flush_remote_tlbs(kvm);
+		if (!ret)
+			ret = static_call(kvm_x86_split_private_spt)(kvm, gfn,
+								     level, private_spt);
+	} else if (is_leaf)
 		ret = static_call(kvm_x86_set_private_spte)(kvm, gfn, level, new_pfn);
 	else {
-		void *private_spt = get_private_spt(gfn, new_spte, level);
-
+		private_spt = get_private_spt(gfn, new_spte, level);
 		KVM_BUG_ON(!private_spt, kvm);
 		ret = static_call(kvm_x86_link_private_spt)(kvm, gfn, level, private_spt);
 	}
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c614ab20c191..91eca578a7da 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1662,6 +1662,28 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
 	return 0;
 }
 
+static int tdx_sept_split_private_spt(struct kvm *kvm, gfn_t gfn,
+				      enum pg_level level, void *private_spt)
+{
+	int tdx_level = pg_level_to_tdx_sept_level(level);
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	gpa_t gpa = gfn_to_gpa(gfn) & KVM_HPAGE_MASK(level);
+	hpa_t hpa = __pa(private_spt);
+	struct tdx_module_args out;
+	u64 err;
+
+	/* See comment in tdx_sept_set_private_spte() */
+	err = tdh_mem_page_demote(kvm_tdx->tdr_pa, gpa, tdx_level, hpa, &out);
+	if (unlikely(err == TDX_ERROR_SEPT_BUSY))
+		return -EAGAIN;
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error(TDH_MEM_PAGE_DEMOTE, err, &out);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
 				      enum pg_level level)
 {
@@ -1675,8 +1697,6 @@ static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
 	if (unlikely(!is_hkid_assigned(kvm_tdx)))
 		return 0;
 
-	/* For now large page isn't supported yet. */
-	WARN_ON_ONCE(level != PG_LEVEL_4K);
 	err = tdh_mem_range_block(kvm_tdx->tdr_pa, gpa, tdx_level, &out);
 	if (unlikely(err == TDX_ERROR_SEPT_BUSY))
 		return -EAGAIN;
@@ -3183,6 +3203,7 @@ int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops)
 
 	x86_ops->link_private_spt = tdx_sept_link_private_spt;
 	x86_ops->free_private_spt = tdx_sept_free_private_spt;
+	x86_ops->split_private_spt = tdx_sept_split_private_spt;
 	x86_ops->set_private_spte = tdx_sept_set_private_spte;
 	x86_ops->remove_private_spte = tdx_sept_remove_private_spte;
 	x86_ops->zap_private_spte = tdx_sept_zap_private_spte;
diff --git a/arch/x86/kvm/vmx/tdx_arch.h b/arch/x86/kvm/vmx/tdx_arch.h
index ba41fefa47ee..cab6a74446a0 100644
--- a/arch/x86/kvm/vmx/tdx_arch.h
+++ b/arch/x86/kvm/vmx/tdx_arch.h
@@ -21,6 +21,7 @@
 #define TDH_MNG_CREATE			9
 #define TDH_VP_CREATE			10
 #define TDH_MNG_RD			11
+#define TDH_MEM_PAGE_DEMOTE		15
 #define TDH_MR_EXTEND			16
 #define TDH_MR_FINALIZE			17
 #define TDH_VP_FLUSH			18
diff --git a/arch/x86/kvm/vmx/tdx_ops.h b/arch/x86/kvm/vmx/tdx_ops.h
index 0f2df7198bde..38ab0ab1509c 100644
--- a/arch/x86/kvm/vmx/tdx_ops.h
+++ b/arch/x86/kvm/vmx/tdx_ops.h
@@ -183,6 +183,13 @@ static inline u64 tdh_mng_rd(hpa_t tdr, u64 field, struct tdx_module_args *out)
 	return tdx_seamcall(TDH_MNG_RD, tdr, field, 0, 0, out);
 }
 
+static inline u64 tdh_mem_page_demote(hpa_t tdr, gpa_t gpa, int level, hpa_t page,
+				      struct tdx_module_args *out)
+{
+	tdx_clflush_page(page, PG_LEVEL_4K);
+	return tdx_seamcall_sept(TDH_MEM_PAGE_DEMOTE, gpa | level, tdr, page, 0, out);
+}
+
 static inline u64 tdh_mr_extend(hpa_t tdr, gpa_t gpa,
 				struct tdx_module_args *out)
 {
-- 
2.25.1

