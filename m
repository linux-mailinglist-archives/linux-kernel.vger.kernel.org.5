Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C013801BF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjLBJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:58:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4791E3;
        Sat,  2 Dec 2023 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511103; x=1733047103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/sZNp1HTRIQfF9DKgY191Av3Iz3lMdrk+plprrEgK+w=;
  b=g0FBx8eHz1PxIow3zhCSsV9sgvMBKfNWPsderNGvX4z2P4Osbh2W+86+
   Htv6ql1KBx9jl8Bi/Y2IJdgudgZhVqQHc4g69C89XHmAdHZ9UTfsX7Ix0
   xgxE+xv43w+Ttt1ScmAWkCTMZVPdSiTckVk13M5xqwoUqx9nUXuFvyWWY
   cvY6tmWpIB6SsisubCuda4vyfFdCZh8I+m37+tMkNmPq/cVP1+X8r2OjV
   dtjIe02uxLQvkzruxukuwcLaGxFIY8mO3f+u/FkoMCbv+J6kNzhLHv5u4
   j83luoNNQojQ+DjMFhHNf9pDH2hIab80iYrCqJz/hNdVDwFOXWizKyQx2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="393322323"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="393322323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804337625"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="804337625"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:58:19 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 28/42] KVM: x86/mmu: change "vcpu" to "kvm" in page_fault_handle_page_track()
Date:   Sat,  2 Dec 2023 17:29:20 +0800
Message-Id: <20231202092920.15167-1-yan.y.zhao@intel.com>
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

page_fault_handle_page_track() only uses param "vcpu" to refer to
"vcpu->kvm", change it to "kvm" directly.

No functional changes expected.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 8 ++++----
 arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b461bab51255e..73437c1b1943e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4186,7 +4186,7 @@ static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
 	return RET_PF_RETRY;
 }
 
-static bool page_fault_handle_page_track(struct kvm_vcpu *vcpu,
+static bool page_fault_handle_page_track(struct kvm *kvm,
 					 struct kvm_page_fault *fault)
 {
 	if (unlikely(fault->rsvd))
@@ -4199,7 +4199,7 @@ static bool page_fault_handle_page_track(struct kvm_vcpu *vcpu,
 	 * guest is writing the page which is write tracked which can
 	 * not be fixed by page fault handler.
 	 */
-	if (kvm_gfn_is_write_tracked(vcpu->kvm, fault->slot, fault->gfn))
+	if (kvm_gfn_is_write_tracked(kvm, fault->slot, fault->gfn))
 		return true;
 
 	return false;
@@ -4378,7 +4378,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (WARN_ON_ONCE(kvm_mmu_is_dummy_root(vcpu->arch.mmu->common.root.hpa)))
 		return RET_PF_RETRY;
 
-	if (page_fault_handle_page_track(vcpu, fault))
+	if (page_fault_handle_page_track(vcpu->kvm, fault))
 		return RET_PF_EMULATE;
 
 	r = fast_page_fault(vcpu, fault);
@@ -4458,7 +4458,7 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 {
 	int r;
 
-	if (page_fault_handle_page_track(vcpu, fault))
+	if (page_fault_handle_page_track(vcpu->kvm, fault))
 		return RET_PF_EMULATE;
 
 	r = fast_page_fault(vcpu, fault);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 13c6390824a3e..f685b036f6637 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -803,7 +803,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	fault->max_level = walker.level;
 	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
 
-	if (page_fault_handle_page_track(vcpu, fault)) {
+	if (page_fault_handle_page_track(vcpu->kvm, fault)) {
 		shadow_page_table_clear_flood(vcpu, fault->addr);
 		return RET_PF_EMULATE;
 	}
-- 
2.17.1

