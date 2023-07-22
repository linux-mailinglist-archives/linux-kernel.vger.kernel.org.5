Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85D75D8AB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGVBYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjGVBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:24:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEE3A91
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:24:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b89e3715acso14554015ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689989041; x=1690593841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UWMhkNgMbNQj7ZnQNio+vf6z7pD8eN3w4tJfm1Vde8c=;
        b=OsfVm6o/VAqNlcpylHC5doRDd0YXzKj4TvUCiPKNfITxCM+JS+jLmnU5A6Df/DNryR
         4z6I+m0o9c8PgWqkhxYn8nybAEBlHRog0ZZ1biQJSMYPzXQhKX9r7rzBO7uQ8ps6Di9M
         VuEi5AR6Epj+ctL34uaLw4hNSNbY05UdkH4B5vFJXrlwPl90Iv+Bq9lfQ23XjamqbISt
         iALQlJe5HsAlKij8WucbkKqJBeOKhdDzexyWPffqu8e5xnpPZX3XWGYdQUhjIhfc0RDo
         rK4pyuMLZKqx4k1LdYhbiAkgtJdQPetJF0Kn+YVJ9Jh1dIV9vkIvCL76IbpoE7js7hSE
         GQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689989041; x=1690593841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWMhkNgMbNQj7ZnQNio+vf6z7pD8eN3w4tJfm1Vde8c=;
        b=BOkFE3ryB3r7pHS7H5Fs3Yv5i4KJV6r1anD8mcTvOVuxnZ0mytvgwmR+D+nP0GYYco
         LpnH2Ilzb7tVR+LAQEsHIDMLlKCKNbrb7H4uWB5+pRE897L1kvzXHGAkCDO0imeIlFYc
         lfnpP5QGsyzzeH0rJvp0ZCGdQEZ9oU218Tz80qHe8DuOkHPKG95wZloaqCsNR8nvgalw
         rjFbVy0Isneqwo9YW1vOe7K0KsEtcfzgeQXWQMQBUnvb87BSo+Ixy5e2X6KwJ17V0fQD
         buxusYS02GI+nT9PDhZpgmJD/kZ2bqlG9mTgG/+8+D9iGD+oKWvwBoN49wbuQfHaWfcc
         fslg==
X-Gm-Message-State: ABy/qLbcBhHC5rclbXPh9oLU/PQlxgaxA27Ui3Tc8zTVu4HVZOL8Jifd
        6H/x6Z7H7qrE46iiUHHBfU2+dBIP5rY=
X-Google-Smtp-Source: APBJJlEWlSRtodZ1KEZreYhZkgWW43XAEabqUvDcyF68PtyD9bhXpgaFThFLm/bd9+FnMOUBN2lkMc+wCGU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1c9:b0:1b9:df8f:888c with SMTP id
 e9-20020a17090301c900b001b9df8f888cmr13094plh.8.1689989041203; Fri, 21 Jul
 2023 18:24:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 18:23:50 -0700
In-Reply-To: <20230722012350.2371049-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230722012350.2371049-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230722012350.2371049-6-seanjc@google.com>
Subject: [PATCH 5/5] KVM: x86/mmu: Use dummy root, backed by zero page, for
 !visible guest roots
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reima Ishii <ishiir@g.ecc.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to allocate a shadow root for a !visible guest root gfn,
e.g. that resides in MMIO space, load a dummy root that is backed by the
zero page instead of immediately synthesizing a triple fault shutdown
(using the zero page ensures any attempt to translate memory will generate
a !PRESENT fault and thus VM-Exit).

Unless the vCPU is racing with memslot activity, KVM will inject a page
fault due to not finding a visible slot in FNAME(walk_addr_generic), i.e.
the end result is mostly same, but critically KVM will inject a fault only
*after* KVM runs the vCPU with the bogus root.

Waiting to inject a fault until after running the vCPU fixes a bug where
KVM would bail from nested VM-Enter if L1 tried to run L2 with TDP enabled
and a !visible root.  Even though a bad root will *probably* lead to
shutdown, (a) it's not guaranteed and (b) the CPU won't read the
underlying memory until after VM-Enter succeeds.  E.g. if L1 runs L2 with
a VMX preemption timer value of '0', then architecturally the preemption
timer VM-Exit is guaranteed to occur before the CPU executes any
instruction, i.e. before the CPU needs to translate a GPA to a HPA (so
long as there are no injected events with higher priority than the
preemption timer).

If KVM manages to get to FNAME(fetch) with a dummy root, e.g. because
userspace created a memslot between installing the dummy root and handling
the page fault, simply unload the MMU to allocate a new root and retry the
instruction.

Reported-by: Reima Ishii <ishiir@g.ecc.u-tokyo.ac.jp>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 41 +++++++++++++++------------------
 arch/x86/kvm/mmu/mmu_internal.h | 10 ++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  | 11 +++++++++
 arch/x86/kvm/mmu/spte.h         |  3 +++
 4 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dd8cc46551b2..20e289e872eb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3620,7 +3620,9 @@ void kvm_mmu_free_roots(struct kvm *kvm, struct kvm_mmu *mmu,
 					   &invalid_list);
 
 	if (free_active_root) {
-		if (root_to_sp(mmu->root.hpa)) {
+		if (kvm_mmu_is_dummy_root(mmu->root.hpa)) {
+			/* Nothing to cleanup for dummy roots. */
+		} else if (root_to_sp(mmu->root.hpa)) {
 			mmu_free_root_page(kvm, &mmu->root.hpa, &invalid_list);
 		} else if (mmu->pae_root) {
 			for (i = 0; i < 4; ++i) {
@@ -3668,19 +3670,6 @@ void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_free_guest_mode_roots);
 
-
-static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
-{
-	int ret = 0;
-
-	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
-		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
-		ret = 1;
-	}
-
-	return ret;
-}
-
 static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 			    u8 level)
 {
@@ -3818,8 +3807,10 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	root_pgd = kvm_mmu_get_guest_pgd(vcpu, mmu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
 
-	if (mmu_check_root(vcpu, root_gfn))
-		return 1;
+	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
+		mmu->root.hpa = kvm_mmu_get_dummy_root();
+		return 0;
+	}
 
 	/*
 	 * On SVM, reading PDPTRs might access guest memory, which might fault
@@ -3831,8 +3822,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			if (!(pdptrs[i] & PT_PRESENT_MASK))
 				continue;
 
-			if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
-				return 1;
+			if (!kvm_vcpu_is_visible_gfn(vcpu, pdptrs[i] >> PAGE_SHIFT))
+				pdptrs[i] = 0;
 		}
 	}
 
@@ -3999,7 +3990,7 @@ static bool is_unsync_root(hpa_t root)
 {
 	struct kvm_mmu_page *sp;
 
-	if (!VALID_PAGE(root))
+	if (!VALID_PAGE(root) || kvm_mmu_is_dummy_root(root))
 		return false;
 
 	/*
@@ -4405,6 +4396,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 {
 	int r;
 
+	/* Dummy roots are used only for shadowing bad guest roots. */
+	if (WARN_ON_ONCE(kvm_mmu_is_dummy_root(vcpu->arch.mmu->root.hpa)))
+		return RET_PF_RETRY;
+
 	if (page_fault_handle_page_track(vcpu, fault))
 		return RET_PF_EMULATE;
 
@@ -4642,9 +4637,8 @@ static bool fast_pgd_switch(struct kvm *kvm, struct kvm_mmu *mmu,
 			    gpa_t new_pgd, union kvm_mmu_page_role new_role)
 {
 	/*
-	 * For now, limit the caching to 64-bit hosts+VMs in order to avoid
-	 * having to deal with PDPTEs. We may add support for 32-bit hosts/VMs
-	 * later if necessary.
+	 * Limit reuse to 64-bit hosts+VMs without "special" roots in order to
+	 * avoid having to deal with PDPTEs and other complexities.
 	 */
 	if (VALID_PAGE(mmu->root.hpa) && !root_to_sp(mmu->root.hpa))
 		kvm_mmu_free_roots(kvm, mmu, KVM_MMU_ROOT_CURRENT);
@@ -5561,7 +5555,8 @@ static bool is_obsolete_root(struct kvm *kvm, hpa_t root_hpa)
 	 * positives and free roots that don't strictly need to be freed, but
 	 * such false positives are relatively rare:
 	 *
-	 *  (a) only PAE paging and nested NPT has roots without shadow pages
+	 *  (a) only PAE paging and nested NPT have roots without shadow pages
+	 *      (or any shadow paging flavor with a dummy root)
 	 *  (b) remote reloads due to a memslot update obsoletes _all_ roots
 	 *  (c) KVM doesn't track previous roots for PAE paging, and the guest
 	 *      is unlikely to zap an in-use PGD.
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index d39af5639ce9..3ca986450393 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -44,6 +44,16 @@ extern bool dbg;
 #define INVALID_PAE_ROOT	0
 #define IS_VALID_PAE_ROOT(x)	(!!(x))
 
+static inline hpa_t kvm_mmu_get_dummy_root(void)
+{
+	return my_zero_pfn(0) << PAGE_SHIFT;
+}
+
+static inline bool kvm_mmu_is_dummy_root(hpa_t shadow_page)
+{
+	return is_zero_pfn(shadow_page >> PAGE_SHIFT);
+}
+
 typedef u64 __rcu *tdp_ptep_t;
 
 struct kvm_mmu_page {
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 122bfc0124d3..e9d4d7b66111 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -646,6 +646,17 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
 		goto out_gpte_changed;
 
+	/*
+	 * Load a new root and retry the faulting instruction in the extremely
+	 * unlikely scenario that the guest root gfn became visible between
+	 * loading a dummy root and handling the resulting page fault, e.g. if
+	 * userspace create a memslot in the interim.
+	 */
+	if (unlikely(kvm_mmu_is_dummy_root(vcpu->arch.mmu->root.hpa))) {
+		kvm_mmu_unload(vcpu);
+		goto out_gpte_changed;
+	}
+
 	for_each_shadow_entry(vcpu, fault->addr, it) {
 		gfn_t table_gfn;
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 9f8e8cda89e8..ac8ad12f9698 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -238,6 +238,9 @@ static inline struct kvm_mmu_page *sptep_to_sp(u64 *sptep)
 
 static inline struct kvm_mmu_page *root_to_sp(hpa_t root)
 {
+	if (kvm_mmu_is_dummy_root(root))
+		return NULL;
+
 	/*
 	 * The "root" may be a special root, e.g. a PAE entry, treat it as a
 	 * SPTE to ensure any non-PA bits are dropped.
-- 
2.41.0.487.g6d72f3e995-goog

