Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F7801BF7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjLBJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:57:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B9419F;
        Sat,  2 Dec 2023 01:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511069; x=1733047069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=55tsKcT+FAhok+Xkgfzjx0zHipfnMqIv8/jCkGwDm9g=;
  b=lXEjt0FzZuDXYIEH5JkY5eNLzil4BbGWwfV3tA/c7zAhNUmH52SdTQML
   8LN9jgr8bSOeCaVsSUR/IhgSLpE7fcQKMucT3nfEhEWDf/2G3E9j6E+3d
   34H05kRy0mqf5g/M3GPfgSCzomefEK/iDuggEVVNlmXAOH1B1Y3w68zrl
   6OojjSfWMI4vLPLKOtAbyE7mT2hES98aAfRr7dbXc1g4RUf/QmD23Hcxs
   K/803m2dIrNKg/tyYArCI0VL/kDl5uj3M2hUwDbY9ahEstDvG2wFyfgxv
   JnYQbRNj7tjjcpQYDQ1wQm88u7EgblUvZSyOznhaNaTnNLcgPSt6oWLdb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="12304410"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="12304410"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1101537132"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="1101537132"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:57:44 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 27/42] KVM: x86/mmu: change param "vcpu" to "kvm" in kvm_mmu_hugepage_adjust()
Date:   Sat,  2 Dec 2023 17:28:50 +0800
Message-Id: <20231202092850.15107-1-yan.y.zhao@intel.com>
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

kvm_mmu_hugepage_adjust() requires "vcpu" only to get "vcpu->kvm".
Switch to pass in "kvm" directly.

No functional changes expected.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/mmu/mmu.c          | 8 ++++----
 arch/x86/kvm/mmu/mmu_internal.h | 2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cfeb066f38687..b461bab51255e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3159,7 +3159,7 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 	return min(host_level, max_level);
 }
 
-void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+void kvm_mmu_hugepage_adjust(struct kvm *kvm, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
 	kvm_pfn_t mask;
@@ -3179,8 +3179,8 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * Enforce the iTLB multihit workaround after capturing the requested
 	 * level, which will be used to do precise, accurate accounting.
 	 */
-	fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
-						     fault->gfn, fault->max_level);
+	fault->req_level = kvm_mmu_max_mapping_level(kvm, slot, fault->gfn,
+						     fault->max_level);
 	if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
 		return;
 
@@ -3222,7 +3222,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	int ret;
 	gfn_t base_gfn = fault->gfn;
 
-	kvm_mmu_hugepage_adjust(vcpu, fault);
+	kvm_mmu_hugepage_adjust(vcpu->kvm, fault);
 
 	trace_kvm_mmu_spte_requested(fault);
 	for_each_shadow_entry(vcpu, fault->addr, it) {
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 7699596308386..1e9be0604e348 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -339,7 +339,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			      const struct kvm_memory_slot *slot, gfn_t gfn,
 			      int max_level);
-void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
+void kvm_mmu_hugepage_adjust(struct kvm *kvm, struct kvm_page_fault *fault);
 void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_level);
 
 void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 84509af0d7f9d..13c6390824a3e 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -716,7 +716,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	 * are being shadowed by KVM, i.e. allocating a new shadow page may
 	 * affect the allowed hugepage size.
 	 */
-	kvm_mmu_hugepage_adjust(vcpu, fault);
+	kvm_mmu_hugepage_adjust(vcpu->kvm, fault);
 
 	trace_kvm_mmu_spte_requested(fault);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6657685a28709..5d76d4849e8aa 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1047,7 +1047,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	struct kvm_mmu_page *sp;
 	int ret = RET_PF_RETRY;
 
-	kvm_mmu_hugepage_adjust(vcpu, fault);
+	kvm_mmu_hugepage_adjust(vcpu->kvm, fault);
 
 	trace_kvm_mmu_spte_requested(fault);
 
-- 
2.17.1

