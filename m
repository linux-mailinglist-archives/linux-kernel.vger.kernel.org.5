Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F213E767AAF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjG2BSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjG2BRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:17:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17855A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:17:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bbbc4ae328so20393585ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690593398; x=1691198198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBstFzzUxVyW0UD2LT3q1n62xfHDtx4xPYrvh1DuKtE=;
        b=AWA3eueKfdIcRemXTjYfiddcMtJI0gM8qgAv12KCTw4HqUU0shQMSFOxKJIqy4vXKo
         o6PGd++MfofA37Ilb4CdFRIImOYn0LHj5TT/u1y6lKa9cwtHyqNqTYJcxTPFrFc5HcMg
         EzkaGymUsTaNE6uXUIiX2/rTAeuI23PlQHZzCKwbbJLVpdsqh7sHcY7VRZn0qolmfCBn
         sXyDMqpc2/A4JbuFGUtM7AmJ5Kvx2y7QHKtKaD736u9Q81xpRZHnJtwpiSI05j1+W0Hx
         gPZA0p3nGewQVfW/euy/AuhF4Bt3UH3aB9Rmw0+o18MlQzaEbSF8ZXWj2V8m1ocyJGws
         Bj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593398; x=1691198198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBstFzzUxVyW0UD2LT3q1n62xfHDtx4xPYrvh1DuKtE=;
        b=BpMghsoJtiZG7BkzrF1eXNCnhUDC+Ih7FDx8bHsSDrO/RsqxVfcZchR8D7tTWFuIut
         WueIx+snl+kynWmOGrPRAdkhuc0EQWfCq/KHEQxXgRqnXqbgrCaaMxChEZghNHzgeZUW
         GtYvz/wfbLMWw5WMhT/pK1EqZdJj/D9RoC5i32ckDUtwURg1Xnf7oLBGWGivZyBSaboi
         VJXv9xymmlvVf7plt1x49Sl/gEY4SgimrovQqMOgMbAsFwzg6MUpaUfVLz3QJaoJY+xp
         m0wwmDIY+GFDODc0l9FwKkCbRZCPPEVnWNfhKOpEI9pVJMByAV84a8oHtJpibF2qeARk
         QJ7A==
X-Gm-Message-State: ABy/qLZP5njHzNBZAVzkFR5V++Q2rFdt1BsQuT6FZWl2WDqtL/wSFdhZ
        aM+9Akv1D37Wu7D8+O3Fdqmul/6Nfzk=
X-Google-Smtp-Source: APBJJlE9gJP2mXJxfkwEVOlLCgzzX3TWKCeVQjYElvF6CgWBwkyCaatBW6oKGQdFMvEvR4lm9CkyS6Qtl1s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e542:b0:1b8:c666:207a with SMTP id
 n2-20020a170902e54200b001b8c666207amr13470plf.9.1690593398073; Fri, 28 Jul
 2023 18:16:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:16:00 -0700
In-Reply-To: <20230729011608.1065019-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729011608.1065019-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729011608.1065019-14-seanjc@google.com>
Subject: [PATCH v2 13/21] KVM: nVMX: Use KVM-governed feature framework to
 track "nested VMX enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track "VMX exposed to L1" via a governed feature flag instead of using a
dedicated helper to provide the same functionality.  The main goal is to
drive convergence between VMX and SVM with respect to querying features
that are controllable via module param (SVM likes to cache nested
features), avoiding the guest CPUID lookups at runtime is just a bonus
and unlikely to provide any meaningful performance benefits.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/governed_features.h |  1 +
 arch/x86/kvm/vmx/nested.c        |  7 ++++---
 arch/x86/kvm/vmx/vmx.c           | 21 ++++++---------------
 arch/x86/kvm/vmx/vmx.h           |  1 -
 4 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index b896a64e4ac3..22446614bf49 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -7,6 +7,7 @@ BUILD_BUG()
 
 KVM_GOVERNED_X86_FEATURE(GBPAGES)
 KVM_GOVERNED_X86_FEATURE(XSAVES)
+KVM_GOVERNED_X86_FEATURE(VMX)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 22e08d30baef..c5ec0ef51ff7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6426,7 +6426,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	vmx = to_vmx(vcpu);
 	vmcs12 = get_vmcs12(vcpu);
 
-	if (nested_vmx_allowed(vcpu) &&
+	if (guest_can_use(vcpu, X86_FEATURE_VMX) &&
 	    (vmx->nested.vmxon || vmx->nested.smm.vmxon)) {
 		kvm_state.hdr.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
 		kvm_state.hdr.vmx.vmcs12_pa = vmx->nested.current_vmptr;
@@ -6567,7 +6567,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 		if (kvm_state->flags & ~KVM_STATE_NESTED_EVMCS)
 			return -EINVAL;
 	} else {
-		if (!nested_vmx_allowed(vcpu))
+		if (!guest_can_use(vcpu, X86_FEATURE_VMX))
 			return -EINVAL;
 
 		if (!page_address_valid(vcpu, kvm_state->hdr.vmx.vmxon_pa))
@@ -6601,7 +6601,8 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if ((kvm_state->flags & KVM_STATE_NESTED_EVMCS) &&
-		(!nested_vmx_allowed(vcpu) || !vmx->nested.enlightened_vmcs_enabled))
+	    (!guest_can_use(vcpu, X86_FEATURE_VMX) ||
+	     !vmx->nested.enlightened_vmcs_enabled))
 			return -EINVAL;
 
 	vmx_leave_nested(vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3100ed62615c..fdf932cfc64d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1894,17 +1894,6 @@ static void vmx_write_tsc_multiplier(struct kvm_vcpu *vcpu)
 	vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio);
 }
 
-/*
- * nested_vmx_allowed() checks whether a guest should be allowed to use VMX
- * instructions and MSRs (i.e., nested VMX). Nested VMX is disabled for
- * all guests if the "nested" module option is off, and can also be disabled
- * for a single guest by disabling its VMX cpuid bit.
- */
-bool nested_vmx_allowed(struct kvm_vcpu *vcpu)
-{
-	return nested && guest_cpuid_has(vcpu, X86_FEATURE_VMX);
-}
-
 /*
  * Userspace is allowed to set any supported IA32_FEATURE_CONTROL regardless of
  * guest CPUID.  Note, KVM allows userspace to set "VMX in SMX" to maintain
@@ -2032,7 +2021,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			[msr_info->index - MSR_IA32_SGXLEPUBKEYHASH0];
 		break;
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
-		if (!nested_vmx_allowed(vcpu))
+		if (!guest_can_use(vcpu, X86_FEATURE_VMX))
 			return 1;
 		if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
 				    &msr_info->data))
@@ -2340,7 +2329,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!msr_info->host_initiated)
 			return 1; /* they are read-only */
-		if (!nested_vmx_allowed(vcpu))
+		if (!guest_can_use(vcpu, X86_FEATURE_VMX))
 			return 1;
 		return vmx_set_vmx_msr(vcpu, msr_index, data);
 	case MSR_IA32_RTIT_CTL:
@@ -7727,13 +7716,15 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
 		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);
 
+	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VMX);
+
 	vmx_setup_uret_msrs(vmx);
 
 	if (cpu_has_secondary_exec_ctrls())
 		vmcs_set_secondary_exec_control(vmx,
 						vmx_secondary_exec_control(vmx));
 
-	if (nested_vmx_allowed(vcpu))
+	if (guest_can_use(vcpu, X86_FEATURE_VMX))
 		vmx->msr_ia32_feature_control_valid_bits |=
 			FEAT_CTL_VMX_ENABLED_INSIDE_SMX |
 			FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
@@ -7742,7 +7733,7 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 			~(FEAT_CTL_VMX_ENABLED_INSIDE_SMX |
 			  FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX);
 
-	if (nested_vmx_allowed(vcpu))
+	if (guest_can_use(vcpu, X86_FEATURE_VMX))
 		nested_vmx_cr_fixed1_bits_update(vcpu);
 
 	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index cde902b44d97..c2130d2c8e24 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -374,7 +374,6 @@ struct kvm_vmx {
 	u64 *pid_table;
 };
 
-bool nested_vmx_allowed(struct kvm_vcpu *vcpu);
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 			struct loaded_vmcs *buddy);
 int allocate_vpid(void);
-- 
2.41.0.487.g6d72f3e995-goog

