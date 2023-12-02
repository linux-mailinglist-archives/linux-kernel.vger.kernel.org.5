Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116BC801875
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441995AbjLBAEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441952AbjLBAEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:38 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97DD1730
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:34 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6ce0af61329so1029775b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475474; x=1702080274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cEYLtrPOOaLARZLa9sm17PRst0mFxCm8VxSITDHXjiU=;
        b=ff6gIBR0nJl/TcrVfSxlLtpdWHgtC7Zs8m0uZi3JAGIEJJnNcKnBSgt2qnvDzFjy/t
         jIvNwvUR5WFm+7vbghQik0QqmoIB4wg55tA94AcESIejyLJxGb77sX74QgTX2/2hd0C7
         3egr+xlAX09PoJpL1eSjuZEWKkf5nd7mGWwOF+jgCt5gEEFYrQmZMy5zbmH4N/Zoq/au
         O6z1NvkCL668eY1raLGDtLfWD2UQ624JXWE1SMFZbNfFRIFG/54iYJISWdqLz7ymJ/Vp
         BB7kpuyGGM7alkCxeqKwjmr/g7cLHBQ3PN1R5tbrj7tdIucmxzC5itAIWTEP1JLaXTGj
         MZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475474; x=1702080274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEYLtrPOOaLARZLa9sm17PRst0mFxCm8VxSITDHXjiU=;
        b=wL0U/TfVHC1iAjSuJuMUcemLfpQTapAe2FXdihH4X9QR7BAEGmWRIw5JzSBKPo7BX3
         fnB8p/kYpwLOqS+2yg0uE76GbyBBg+w2/yHQzQHA7O9OFRcUSngIty+c/13OXANPClUK
         /J7dGez51uydqHYawiZZDiijR/8XQvVdLXabnNCoUNp9idIisdSGuI6/4Wo6jsP4JWrr
         c7S4GyhC2iF8EVvMZogqHwBUx8Y8szoL7oQgmmIz+Huyawx0mOig42aY5ZiouqTz4tUa
         0bIcvpMbvy87u/lXv0S/oMJ0WmLXXIfDJx09E3M/kkQHLYXUIvHxyzf7HfZXRuEmaCgz
         mMZg==
X-Gm-Message-State: AOJu0YysFT1Zh8N70K4+D43lOMEs7YWmKt1CowjVBWynXDTDiKR3T00u
        sToRVHwBXxzK1WyrhPvEhnMi63Wy8dg=
X-Google-Smtp-Source: AGHT+IHugQCb0AHwUpCFvWZ1QFWa9xWZLNTx2JwCAqHJbJZDQHk1F62lMBXo6DJFvByDR2y1roz0csvwN0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3a03:b0:6cd:810:3875 with SMTP id
 fj3-20020a056a003a0300b006cd08103875mr4972590pfb.5.1701475474054; Fri, 01 Dec
 2023 16:04:34 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:56 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-8-seanjc@google.com>
Subject: [PATCH v9 07/28] KVM: x86/pmu: Prioritize VMX interception over #GP
 on RDPMC due to bad index
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply the pre-intercepts RDPMC validity check only to AMD, and rename all
relevant functions to make it as clear as possible that the check is not a
standard PMC index check.  On Intel, the basic rule is that only invalid
opcodes and privilege/permission/mode checks have priority over VM-Exit,
i.e. RDPMC with an invalid index should VM-Exit, not #GP.  While the SDM
doesn't explicitly call out RDPMC, it _does_ explicitly use RDMSR of a
non-existent MSR as an example where VM-Exit has priority over #GP, and
RDPMC is effectively just a variation of RDMSR.

Manually testing on various Intel CPUs confirms this behavior, and the
inverted priority was introduced for SVM compatibility, i.e. was not an
intentional change for Intel PMUs.  On AMD, *all* exceptions on RDPMC have
priority over VM-Exit.

Check for a NULL kvm_pmu_ops.check_rdpmc_early instead of using a RET0
static call so as to provide a convenient location to document the
difference between Intel and AMD, and to again try to make it as obvious
as possible that the early check is a one-off thing, not a generic "is
this PMC valid?" helper.

Fixes: 8061252ee0d2 ("KVM: SVM: Add intercept checks for remaining twobyte instructions")
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  2 +-
 arch/x86/kvm/emulate.c                 |  2 +-
 arch/x86/kvm/kvm_emulate.h             |  2 +-
 arch/x86/kvm/pmu.c                     | 16 +++++++++++++---
 arch/x86/kvm/pmu.h                     |  4 ++--
 arch/x86/kvm/svm/pmu.c                 |  9 ++++++---
 arch/x86/kvm/vmx/pmu_intel.c           | 12 ------------
 arch/x86/kvm/x86.c                     |  9 +++------
 8 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index d7eebee4450c..f0cd48222133 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -15,7 +15,7 @@ BUILD_BUG_ON(1)
 KVM_X86_PMU_OP(pmc_idx_to_pmc)
 KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
 KVM_X86_PMU_OP(msr_idx_to_pmc)
-KVM_X86_PMU_OP(is_valid_rdpmc_ecx)
+KVM_X86_PMU_OP_OPTIONAL(check_rdpmc_early)
 KVM_X86_PMU_OP(is_valid_msr)
 KVM_X86_PMU_OP(get_msr)
 KVM_X86_PMU_OP(set_msr)
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index e223043ef5b2..695ab5b6055c 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3962,7 +3962,7 @@ static int check_rdpmc(struct x86_emulate_ctxt *ctxt)
 	 * protected mode.
 	 */
 	if ((!(cr4 & X86_CR4_PCE) && ctxt->ops->cpl(ctxt)) ||
-	    ctxt->ops->check_pmc(ctxt, rcx))
+	    ctxt->ops->check_rdpmc_early(ctxt, rcx))
 		return emulate_gp(ctxt, 0);
 
 	return X86EMUL_CONTINUE;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index e6d149825169..4351149484fb 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -208,7 +208,7 @@ struct x86_emulate_ops {
 	int (*set_msr_with_filter)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 data);
 	int (*get_msr_with_filter)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 *pdata);
 	int (*get_msr)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 *pdata);
-	int (*check_pmc)(struct x86_emulate_ctxt *ctxt, u32 pmc);
+	int (*check_rdpmc_early)(struct x86_emulate_ctxt *ctxt, u32 pmc);
 	int (*read_pmc)(struct x86_emulate_ctxt *ctxt, u32 pmc, u64 *pdata);
 	void (*halt)(struct x86_emulate_ctxt *ctxt);
 	void (*wbinvd)(struct x86_emulate_ctxt *ctxt);
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 30945fea6988..0b0d804ee239 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -524,10 +524,20 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 		kvm_pmu_cleanup(vcpu);
 }
 
-/* check if idx is a valid index to access PMU */
-bool kvm_pmu_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
+int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 {
-	return static_call(kvm_x86_pmu_is_valid_rdpmc_ecx)(vcpu, idx);
+	/*
+	 * On Intel, VMX interception has priority over RDPMC exceptions that
+	 * aren't already handled by the emulator, i.e. there are no additional
+	 * check needed for Intel PMUs.
+	 *
+	 * On AMD, _all_ exceptions on RDPMC have priority over SVM intercepts,
+	 * i.e. an invalid PMC results in a #GP, not #VMEXIT.
+	 */
+	if (!kvm_pmu_ops.check_rdpmc_early)
+		return 0;
+
+	return static_call(kvm_x86_pmu_check_rdpmc_early)(vcpu, idx);
 }
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx)
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 87ecf22f5b25..51bbb01b21c8 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -23,7 +23,7 @@ struct kvm_pmu_ops {
 	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
 		unsigned int idx, u64 *mask);
 	struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, u32 msr);
-	bool (*is_valid_rdpmc_ecx)(struct kvm_vcpu *vcpu, unsigned int idx);
+	int (*check_rdpmc_early)(struct kvm_vcpu *vcpu, unsigned int idx);
 	bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
 	int (*get_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
@@ -215,7 +215,7 @@ static inline bool pmc_is_globally_enabled(struct kvm_pmc *pmc)
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
-bool kvm_pmu_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx);
+int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
 bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
 int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 1fafc46f61c9..e886300f0f97 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -73,11 +73,14 @@ static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
 	return amd_pmc_idx_to_pmc(pmu, idx);
 }
 
-static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
+static int amd_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
-	return idx < pmu->nr_arch_gp_counters;
+	if (idx >= pmu->nr_arch_gp_counters)
+		return -EINVAL;
+
+	return 0;
 }
 
 /* idx is the ECX register of RDPMC instruction */
@@ -229,7 +232,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.pmc_idx_to_pmc = amd_pmc_idx_to_pmc,
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
-	.is_valid_rdpmc_ecx = amd_is_valid_rdpmc_ecx,
+	.check_rdpmc_early = amd_check_rdpmc_early,
 	.is_valid_msr = amd_is_valid_msr,
 	.get_msr = amd_pmu_get_msr,
 	.set_msr = amd_pmu_set_msr,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index ec4feaef3d55..1b1f888ad32b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -55,17 +55,6 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 	}
 }
 
-static bool intel_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
-{
-	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	bool fixed = idx & (1u << 30);
-
-	idx &= ~(3u << 30);
-
-	return fixed ? idx < pmu->nr_arch_fixed_counters
-		     : idx < pmu->nr_arch_gp_counters;
-}
-
 static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 					    unsigned int idx, u64 *mask)
 {
@@ -718,7 +707,6 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
-	.is_valid_rdpmc_ecx = intel_is_valid_rdpmc_ecx,
 	.is_valid_msr = intel_is_valid_msr,
 	.get_msr = intel_pmu_get_msr,
 	.set_msr = intel_pmu_set_msr,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d19bbca6a44c..17ffadc61a45 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8348,12 +8348,9 @@ static int emulator_get_msr(struct x86_emulate_ctxt *ctxt,
 	return kvm_get_msr(emul_to_vcpu(ctxt), msr_index, pdata);
 }
 
-static int emulator_check_pmc(struct x86_emulate_ctxt *ctxt,
-			      u32 pmc)
+static int emulator_check_rdpmc_early(struct x86_emulate_ctxt *ctxt, u32 pmc)
 {
-	if (kvm_pmu_is_valid_rdpmc_ecx(emul_to_vcpu(ctxt), pmc))
-		return 0;
-	return -EINVAL;
+	return kvm_pmu_check_rdpmc_early(emul_to_vcpu(ctxt), pmc);
 }
 
 static int emulator_read_pmc(struct x86_emulate_ctxt *ctxt,
@@ -8485,7 +8482,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.set_msr_with_filter = emulator_set_msr_with_filter,
 	.get_msr_with_filter = emulator_get_msr_with_filter,
 	.get_msr             = emulator_get_msr,
-	.check_pmc	     = emulator_check_pmc,
+	.check_rdpmc_early   = emulator_check_rdpmc_early,
 	.read_pmc            = emulator_read_pmc,
 	.halt                = emulator_halt,
 	.wbinvd              = emulator_wbinvd,
-- 
2.43.0.rc2.451.g8631bc7472-goog

