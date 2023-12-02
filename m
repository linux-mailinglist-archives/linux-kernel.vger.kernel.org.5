Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A247E801C05
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjLBKB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjLBKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:01:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89FD197;
        Sat,  2 Dec 2023 02:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511293; x=1733047293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uSoSY6TiRDOPE0HLSqzCfFuL+LmvcCuprKj793XIBHM=;
  b=WwNJySS6Cr0O/UYFtRhXvzlgYvQtaB6XcPn+ZduIu0tpIeOqaHwQ1xiM
   mgvFNrZtI4XggLjue5kigE/R458Ok89nlcSBPpVf0/hZmiZ2u+tr79+oK
   NWO0PWHUlatzrwYxnzAN5XVbqDadwO5Pk/X8mG27b13nolLGoNJIZW469
   20RchAugsiJIO4nB6uvP8pSmlj6BFM7GK9+mRrDSFbPqM3kLp/FT1Zloz
   j6fRSOGrM+a/O/ptHBydRSEqdPcLsv05bzWkiD1+/mHZ/vbFXmcjDcjSB
   cs2wmhcv1iBWHZlnHKwGvPkQ10l1h6VT0prNRpHdkziTLFoIlMoOkn506
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="396395349"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="396395349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="799015715"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="799015715"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:01:17 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 34/42] KVM: x86/mmu: add extra param "kvm" to tdp_mmu_map_handle_target_level()
Date:   Sat,  2 Dec 2023 17:32:22 +0800
Message-Id: <20231202093222.15534-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extra param "kvm" to tdp_mmu_map_handle_target_level() to allow for
mapping in non-vCPU context in future.

"vcpu" is only required in tdp_mmu_map_handle_target_level() for accounting
of MMIO SPTEs. As kvm_faultin_pfn() now will return error for non-slot
PFNs, no MMIO SPTEs should be generated and accounted in non-vCPU context.
So, just let tdp_mmu_map_handle_target_level() warn if MMIO SPTEs are
encountered in non-vCPU context.

This is a preparation patch for later KVM MMU to export TDP.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a45d1b71cd62a..5edff3b4698b7 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -949,7 +949,9 @@ void kvm_tdp_mmu_invalidate_all_roots(struct kvm *kvm)
  * Installs a last-level SPTE to handle a TDP page fault.
  * (NPT/EPT violation/misconfiguration)
  */
-static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
+static int tdp_mmu_map_handle_target_level(struct kvm *kvm,
+					  struct kvm_vcpu *vcpu,
+					  struct kvm_mmu_common *mmu_common,
 					  struct kvm_page_fault *fault,
 					  struct tdp_iter *iter)
 {
@@ -958,24 +960,26 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	int ret = RET_PF_FIXED;
 	bool wrprot = false;
 
+	WARN_ON(!kvm);
+
 	if (WARN_ON_ONCE(sp->role.level != fault->goal_level))
 		return RET_PF_RETRY;
 
 	if (unlikely(!fault->slot))
 		new_spte = make_mmio_spte(vcpu->kvm, vcpu, iter->gfn, ACC_ALL);
 	else
-		wrprot = make_spte(vcpu->kvm, vcpu, &vcpu->arch.mmu->common, sp, fault->slot,
+		wrprot = make_spte(kvm, vcpu, mmu_common, sp, fault->slot,
 				   ACC_ALL, iter->gfn, fault->pfn, iter->old_spte,
 				   fault->prefetch, true, fault->map_writable,
 				   &new_spte);
 
 	if (new_spte == iter->old_spte)
 		ret = RET_PF_SPURIOUS;
-	else if (tdp_mmu_set_spte_atomic(vcpu->kvm, iter, new_spte))
+	else if (tdp_mmu_set_spte_atomic(kvm, iter, new_spte))
 		return RET_PF_RETRY;
 	else if (is_shadow_present_pte(iter->old_spte) &&
 		 !is_last_spte(iter->old_spte, iter->level))
-		kvm_flush_remote_tlbs_gfn(vcpu->kvm, iter->gfn, iter->level);
+		kvm_flush_remote_tlbs_gfn(kvm, iter->gfn, iter->level);
 
 	/*
 	 * If the page fault was caused by a write but the page is write
@@ -989,10 +993,13 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 
 	/* If a MMIO SPTE is installed, the MMIO will need to be emulated. */
 	if (unlikely(is_mmio_spte(new_spte))) {
-		vcpu->stat.pf_mmio_spte_created++;
-		trace_mark_mmio_spte(rcu_dereference(iter->sptep), iter->gfn,
-				     new_spte);
-		ret = RET_PF_EMULATE;
+		/* if without vcpu, no mmio spte should be installed */
+		if (!WARN_ON(!vcpu)) {
+			vcpu->stat.pf_mmio_spte_created++;
+			trace_mark_mmio_spte(rcu_dereference(iter->sptep), iter->gfn,
+					new_spte);
+			ret = RET_PF_EMULATE;
+		}
 	} else {
 		trace_kvm_mmu_set_spte(iter->level, iter->gfn,
 				       rcu_dereference(iter->sptep));
@@ -1114,7 +1121,8 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	goto retry;
 
 map_target_level:
-	ret = tdp_mmu_map_handle_target_level(vcpu, fault, &iter);
+	ret = tdp_mmu_map_handle_target_level(vcpu->kvm, vcpu, &vcpu->arch.mmu->common,
+					      fault, &iter);
 
 retry:
 	rcu_read_unlock();
-- 
2.17.1

