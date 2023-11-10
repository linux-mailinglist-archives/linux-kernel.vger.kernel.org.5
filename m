Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795B37E86B6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbjKJXzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjKJXzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:55:43 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB410A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:39 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so2329953a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699660539; x=1700265339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TEvKbmMv5tmjw9/hFI6q0BipOyhXYsOyAsnic4I0og0=;
        b=g4ijxBWdm17Jo+gu7XmK8BjsbsuzuBAi0/n2lAj6WcX061eGxLk69ttoZy04zZ1IX2
         IJZMEznmfBe4+VhNxr1GPWRRlyu0qEdTj2tV8YnQSbZpz8uhGbn6ef8x9hwBO7b74CqL
         dC6qd8bTg1LNZYlmt/0w29pYSUzfKoICkKtJ+2oziHkJK7p1mm1ZVy7FGPo2gTsa9wkf
         oqXwYEERZTHPGcrYzP77QQCcOUU3ie2UO1fKqKa5gk1N+EJEY59J4lNErHebff4jiPJ2
         z2d5eE4ElspeNpP+Z/6fQLEzzBelAcBQgOhgOAf3BcwM0oju7HUFWT06Md16U/lTIkjq
         xyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660539; x=1700265339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEvKbmMv5tmjw9/hFI6q0BipOyhXYsOyAsnic4I0og0=;
        b=p4tPDS70R3k3ijh9CBJelMrPiwNenLaMkdmU8zPrJB4QGpQkznIOJQhlrzPNWrYaHq
         f9df+c0DDZ4363dKaLH3NngR0A/NHuRRZnapXb7pItInrCabJA2msmKAsfb7idvE5e8C
         K+dmC6+GRZs4MXHhNFqZHpWTkpSJc7sXLA3CYqyokizO28kLJYlD6wRYQevZnNGH8uGa
         vHpNj6XzCOkHZedVEhxVYXCGx5OEQoTS5ZFXctBwL2LBPRqYbCPQUGDTMfBUsGiqzqvt
         +BcsJxHVVU+Exg71g8VqCfwdpUEvR9gCLw9gWipgoWP1zpqlPNzM1Mi6vIVl5tC3wrVX
         AUDg==
X-Gm-Message-State: AOJu0YxnhoQRuCvhwY/LCy8OyYoArM278wjEKpdWxi8pPFRd2GiYdKcI
        vicdu0m5jMskHKwkyLu8ejQft4ws9iQ=
X-Google-Smtp-Source: AGHT+IGyNbSb+ql2rI0AnGy2mw0gzvn4bCOpj75pgm5vdF/yvPUf+ux5kb15qiGz3jZtJPrUM/bpTlDslBQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:51c:b0:5bd:bb6b:78a with SMTP id
 bx28-20020a056a02051c00b005bdbb6b078amr200071pgb.6.1699660539208; Fri, 10 Nov
 2023 15:55:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Nov 2023 15:55:22 -0800
In-Reply-To: <20231110235528.1561679-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110235528.1561679-4-seanjc@google.com>
Subject: [PATCH 3/9] KVM: x86: Initialize guest cpu_caps based on guest CPUID
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize a vCPU's capabilities based on the guest CPUID provided by
userspace instead of simply zeroing the entire array.  This will allow
using cpu_caps to query *all* CPUID-based guest capabilities, i.e. will
allow converting all usage of guest_cpuid_has() to guest_cpu_cap_has().

Zeroing the array was the logical choice when using cpu_caps was opt-in,
e.g. "unsupported" was generally a safer default, and the whole point of
governed features is that KVM would need to check host and guest support,
i.e. making everything unsupported by default didn't require more code.

But requiring KVM to manually "enable" every CPUID-based feature in
cpu_caps would require an absurd amount of boilerplate code.

Follow existing CPUID/kvm_cpu_caps nomenclature where possible, e.g. for
the change() and clear() APIs.  Replace check_and_set() with restrict() to
try and capture that KVM is restricting userspace's desired guest feature
set based on KVM's capabilities.

This is intended to be gigantic nop, i.e. should not have any impact on
guest or KVM functionality.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c   | 43 +++++++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/cpuid.h   | 25 +++++++++++++++++++++---
 arch/x86/kvm/svm/svm.c | 24 +++++++++++------------
 arch/x86/kvm/vmx/vmx.c |  6 ++++--
 4 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4bf3c2d4dc7c..5cf3d697ecb3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -321,13 +321,51 @@ static bool kvm_cpuid_has_hyperv(struct kvm_cpuid_entry2 *entries, int nent)
 	return entry && entry->eax == HYPERV_CPUID_SIGNATURE_EAX;
 }
 
+/*
+ * This isn't truly "unsafe", but all callers except kvm_cpu_after_set_cpuid()
+ * should use __cpuid_entry_get_reg(), which provides compile-time validation
+ * of the input.
+ */
+static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
+{
+	switch (reg) {
+	case CPUID_EAX:
+		return entry->eax;
+	case CPUID_EBX:
+		return entry->ebx;
+	case CPUID_ECX:
+		return entry->ecx;
+	case CPUID_EDX:
+		return entry->edx;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
 static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct kvm_cpuid_entry2 *best;
 	bool allow_gbpages;
+	int i;
 
-	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
+	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS);
+
+	/*
+	 * Reset guest capabilities to userspace's guest CPUID definition, i.e.
+	 * honor userspace's definition for features that don't require KVM or
+	 * hardware management/support (or that KVM simply doesn't care about).
+	 */
+	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
+		const struct cpuid_reg cpuid = reverse_cpuid[i];
+
+		best = kvm_find_cpuid_entry_index(vcpu, cpuid.function, cpuid.index);
+		if (best)
+			vcpu->arch.cpu_caps[i] = cpuid_get_reg_unsafe(best, cpuid.reg);
+		else
+			vcpu->arch.cpu_caps[i] = 0;
+	}
 
 	/*
 	 * If TDP is enabled, let the guest use GBPAGES if they're supported in
@@ -342,8 +380,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	allow_gbpages = tdp_enabled ? boot_cpu_has(X86_FEATURE_GBPAGES) :
 				      guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES);
-	if (allow_gbpages)
-		guest_cpu_cap_set(vcpu, X86_FEATURE_GBPAGES);
+	guest_cpu_cap_change(vcpu, X86_FEATURE_GBPAGES, allow_gbpages);
 
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best && apic) {
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 9f18c4395b71..1707ef10b269 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -263,11 +263,30 @@ static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
 	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
 }
 
-static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
-							unsigned int x86_feature)
+static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
+						unsigned int x86_feature)
 {
-	if (kvm_cpu_cap_has(x86_feature) && guest_cpuid_has(vcpu, x86_feature))
+	unsigned int x86_leaf = __feature_leaf(x86_feature);
+
+	reverse_cpuid_check(x86_leaf);
+	vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
+}
+
+static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
+						 unsigned int x86_feature,
+						 bool guest_has_cap)
+{
+	if (guest_has_cap)
 		guest_cpu_cap_set(vcpu, x86_feature);
+	else
+		guest_cpu_cap_clear(vcpu, x86_feature);
+}
+
+static __always_inline void guest_cpu_cap_restrict(struct kvm_vcpu *vcpu,
+						   unsigned int x86_feature)
+{
+	if (!kvm_cpu_cap_has(x86_feature))
+		guest_cpu_cap_clear(vcpu, x86_feature);
 }
 
 static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8a99a73b6ee5..5827328e30f1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4315,14 +4315,14 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
 	 * the guest read/write access to the host's XSS.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
-	    boot_cpu_has(X86_FEATURE_XSAVES) &&
-	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
-		guest_cpu_cap_set(vcpu, X86_FEATURE_XSAVES);
+	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
+			     boot_cpu_has(X86_FEATURE_XSAVE) &&
+			     boot_cpu_has(X86_FEATURE_XSAVES) &&
+			     guest_cpuid_has(vcpu, X86_FEATURE_XSAVE));
 
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_NRIPS);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_TSCRATEMSR);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_LBRV);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_NRIPS);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_TSCRATEMSR);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_LBRV);
 
 	/*
 	 * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
@@ -4330,12 +4330,12 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * SVM on Intel is bonkers and extremely unlikely to work).
 	 */
 	if (!guest_cpuid_is_intel(vcpu))
-		guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+		guest_cpu_cap_restrict(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_PAUSEFILTER);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VGIF);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VNMI);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_PAUSEFILTER);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_PFTHRESHOLD);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VGIF);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VNMI);
 
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6328f0d47c64..5a056ad1ae55 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7757,9 +7757,11 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
 	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
-		guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_XSAVES);
+		guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVES);
+	else
+		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
 
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VMX);
+	guest_cpu_cap_restrict(vcpu, X86_FEATURE_VMX);
 
 	vmx_setup_uret_msrs(vmx);
 
-- 
2.42.0.869.gea05f2083d-goog

