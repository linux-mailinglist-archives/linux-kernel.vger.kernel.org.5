Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E557E49D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjKGU3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjKGUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:20:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100A19A0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7c97d5d5aso82552597b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388441; x=1699993241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1V4+Et005QJyrGUczzSsikCp14fOuNidjGUDkS2EJpY=;
        b=0PZ2Nb62UbwQlTwZCwQNcE/FomtCS0ODHdh5S499fvWrVMTAWWAdBbjqcc/GgzKj2j
         nOuOSr7ZvTK/7nL/rQIV55HrHZPOUa5PXTh24e6cGNQJ1ljOxcAYbrNZPSlTnRv0bBt6
         QLPQGpbPdptkZ/NzY35DMFn8GbA3Op8bWzAfFlkty0pKE/Tbh2Gu/Xa8raYk+nQEkKus
         Z1KFUXU0+B286x7KvBMTffpw1CUcDkTlACZR+1FlcyCMOrG2bRupuS23ZO3lojbTlwp+
         tPOHkXfUaVXa6NrU3imjqEc5IJV9m6n6WovWVMQeuTWTzppDg53wbYKTUUtyY+5tqeXd
         h9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388441; x=1699993241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1V4+Et005QJyrGUczzSsikCp14fOuNidjGUDkS2EJpY=;
        b=tBvgwG0M0uhekJWiMzFkzwhcFxCKyutabVrGw5FcpGT7VGNm1xdrWxLMhsqcooTiJP
         xDYNCzkVzaJjssWSsO3zfbi7/J7k87QyGLXSO8IrHrRWluHL8ozfZrcI7eDKjlVPRF4H
         viLyOxqEKvYzKnzeyUsuaXMBn6VhqaKsn/19IaFEUAAW4yt4oE0PvUqaQwnBhXYH6fFg
         F6KoPpdxeyuOQ+HLxG7KQjfsVpKrcmHg+14f2esIBjzirLtv9ZiCdsvRSyra0nBHtBSo
         DafpVZ8IVv2OvmtoiaQYwLf56zJHJrTDYxL4GMtmC9gVJrtjCekth6yoNpYCzf7hfWEt
         2evQ==
X-Gm-Message-State: AOJu0YyZd5IF2joB/Aco0eKVea4H3mHX8C5CkCgltg6Da2o2DcTlF8lf
        goV90cEYbG1aculeU1Vk+8JN+S73U35ASQ==
X-Google-Smtp-Source: AGHT+IHiPhnv5451fxIbU3P30oe9MlsDRpH+sM3C6+FrWzD3iboYDQurYZDkpBOeDnhg0NFS+iunebigWu8FvA==
X-Received: from aghulati-dev.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:18bb])
 (user=aghulati job=sendgmr) by 2002:a0d:d708:0:b0:5a7:b54e:bfc1 with SMTP id
 z8-20020a0dd708000000b005a7b54ebfc1mr289947ywd.10.1699388441084; Tue, 07 Nov
 2023 12:20:41 -0800 (PST)
Date:   Tue,  7 Nov 2023 20:20:00 +0000
In-Reply-To: <20231107202002.667900-1-aghulati@google.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107202002.667900-13-aghulati@google.com>
Subject: [RFC PATCH 12/14] KVM: x86: Move VMX and SVM support checks into VAC
From:   Anish Ghulati <aghulati@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Anish Ghulati <aghulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_is_***_supported checks to see if VMX and SVM are supported on the
host. Move this to VAC because it needs to be called before each h/w
enable and disable call.

Signed-off-by: Anish Ghulati <aghulati@google.com>
---
 arch/x86/kvm/svm/svm.c | 45 +-----------------------------------------
 arch/x86/kvm/svm/vac.c | 43 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vac.h     |  4 ++++
 arch/x86/kvm/vmx/vac.c | 29 +++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c | 31 +----------------------------
 arch/x86/kvm/x86.h     |  6 ------
 6 files changed, 78 insertions(+), 80 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 752f769c0333..df5673c98e7b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -515,52 +515,9 @@ static void svm_init_osvw(struct kvm_vcpu *vcpu)
 		vcpu->arch.osvw.status |= 1;
 }
 
-static bool __kvm_is_svm_supported(void)
-{
-	int cpu = smp_processor_id();
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
-
-	u64 vm_cr;
-
-	if (c->x86_vendor != X86_VENDOR_AMD &&
-	    c->x86_vendor != X86_VENDOR_HYGON) {
-		pr_err("CPU %d isn't AMD or Hygon\n", cpu);
-		return false;
-	}
-
-	if (!cpu_has(c, X86_FEATURE_SVM)) {
-		pr_err("SVM not supported by CPU %d\n", cpu);
-		return false;
-	}
-
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
-		pr_info("KVM is unsupported when running as an SEV guest\n");
-		return false;
-	}
-
-	rdmsrl(MSR_VM_CR, vm_cr);
-	if (vm_cr & (1 << SVM_VM_CR_SVM_DISABLE)) {
-		pr_err("SVM disabled (by BIOS) in MSR_VM_CR on CPU %d\n", cpu);
-		return false;
-	}
-
-	return true;
-}
-
-bool kvm_is_svm_supported(void)
-{
-	bool supported;
-
-	migrate_disable();
-	supported = __kvm_is_svm_supported();
-	migrate_enable();
-
-	return supported;
-}
-
 static int svm_check_processor_compat(void)
 {
-	if (!__kvm_is_svm_supported())
+	if (!kvm_is_svm_supported())
 		return -EIO;
 
 	return 0;
diff --git a/arch/x86/kvm/svm/vac.c b/arch/x86/kvm/svm/vac.c
index 2dd1c763f7d6..7c4db99ca7d5 100644
--- a/arch/x86/kvm/svm/vac.c
+++ b/arch/x86/kvm/svm/vac.c
@@ -10,6 +10,49 @@
 DEFINE_PER_CPU(struct svm_cpu_data, svm_data);
 unsigned int max_sev_asid;
 
+static bool __kvm_is_svm_supported(void)
+{
+	int cpu = smp_processor_id();
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+	u64 vm_cr;
+
+	if (c->x86_vendor != X86_VENDOR_AMD &&
+	    c->x86_vendor != X86_VENDOR_HYGON) {
+		pr_err("CPU %d isn't AMD or Hygon\n", cpu);
+		return false;
+	}
+
+	if (!cpu_has(c, X86_FEATURE_SVM)) {
+		pr_err("SVM not supported by CPU %d\n", cpu);
+		return false;
+	}
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		pr_info("KVM is unsupported when running as an SEV guest\n");
+		return false;
+	}
+
+	rdmsrl(MSR_VM_CR, vm_cr);
+	if (vm_cr & (1 << SVM_VM_CR_SVM_DISABLE)) {
+		pr_err("SVM disabled (by BIOS) in MSR_VM_CR on CPU %d\n", cpu);
+		return false;
+	}
+
+	return true;
+}
+
+bool kvm_is_svm_supported(void)
+{
+	bool supported;
+
+	migrate_disable();
+	supported = __kvm_is_svm_supported();
+	migrate_enable();
+
+	return supported;
+}
+
 static inline void kvm_cpu_svm_disable(void)
 {
 	uint64_t efer;
diff --git a/arch/x86/kvm/vac.h b/arch/x86/kvm/vac.h
index 6c0a480ee9e3..5be30cce5a1c 100644
--- a/arch/x86/kvm/vac.h
+++ b/arch/x86/kvm/vac.h
@@ -9,9 +9,11 @@ int __init vac_init(void);
 void vac_exit(void);
 
 #ifdef CONFIG_KVM_INTEL
+bool kvm_is_vmx_supported(void);
 int __init vac_vmx_init(void);
 void vac_vmx_exit(void);
 #else
+bool kvm_is_vmx_supported(void) { return false }
 int __init vac_vmx_init(void)
 {
 	return 0;
@@ -20,9 +22,11 @@ void vac_vmx_exit(void) {}
 #endif
 
 #ifdef CONFIG_KVM_AMD
+bool kvm_is_svm_supported(void);
 int __init vac_svm_init(void);
 void vac_svm_exit(void);
 #else
+bool kvm_is_svm_supported(void) { return false }
 int __init vac_svm_init(void)
 {
 	return 0;
diff --git a/arch/x86/kvm/vmx/vac.c b/arch/x86/kvm/vmx/vac.c
index 202686ccbaec..cdfdeb67a719 100644
--- a/arch/x86/kvm/vmx/vac.c
+++ b/arch/x86/kvm/vmx/vac.c
@@ -31,6 +31,35 @@ struct vmcs *vac_get_vmxarea(int cpu)
 static DECLARE_BITMAP(vmx_vpid_bitmap, VMX_NR_VPIDS);
 static DEFINE_SPINLOCK(vmx_vpid_lock);
 
+static bool __kvm_is_vmx_supported(void)
+{
+	int cpu = smp_processor_id();
+
+	if (!(cpuid_ecx(1) & feature_bit(VMX))) {
+		pr_err("VMX not supported by CPU %d\n", cpu);
+		return false;
+	}
+
+	if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
+	    !this_cpu_has(X86_FEATURE_VMX)) {
+		pr_err("VMX not enabled (by BIOS) in MSR_IA32_FEAT_CTL on CPU %d\n", cpu);
+		return false;
+	}
+
+	return true;
+}
+
+bool kvm_is_vmx_supported(void)
+{
+	bool supported;
+
+	migrate_disable();
+	supported = __kvm_is_vmx_supported();
+	migrate_enable();
+
+	return supported;
+}
+
 int allocate_vpid(void)
 {
 	int vpid;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 46e2d5c69d1d..6301b49e0e80 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2625,42 +2625,13 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	return 0;
 }
 
-static bool __kvm_is_vmx_supported(void)
-{
-	int cpu = smp_processor_id();
-
-	if (!(cpuid_ecx(1) & feature_bit(VMX))) {
-		pr_err("VMX not supported by CPU %d\n", cpu);
-		return false;
-	}
-
-	if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
-	    !this_cpu_has(X86_FEATURE_VMX)) {
-		pr_err("VMX not enabled (by BIOS) in MSR_IA32_FEAT_CTL on CPU %d\n", cpu);
-		return false;
-	}
-
-	return true;
-}
-
-bool kvm_is_vmx_supported(void)
-{
-	bool supported;
-
-	migrate_disable();
-	supported = __kvm_is_vmx_supported();
-	migrate_enable();
-
-	return supported;
-}
-
 static int vmx_check_processor_compat(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct vmcs_config vmcs_conf;
 	struct vmx_capability vmx_cap;
 
-	if (!__kvm_is_vmx_supported())
+	if (!kvm_is_vmx_supported())
 		return -EIO;
 
 	if (setup_vmcs_config(&vmcs_conf, &vmx_cap) < 0) {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 322be05e6c5b..1da8efcd3e9c 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -10,18 +10,12 @@
 #include "kvm_emulate.h"
 
 #ifdef CONFIG_KVM_AMD
-bool kvm_is_svm_supported(void);
 int __init svm_init(void);
 void svm_module_exit(void);
-#else
-bool kvm_is_svm_supported(void) { return false; }
 #endif
 #ifdef CONFIG_KVM_INTEL
-bool kvm_is_vmx_supported(void);
 int __init vmx_init(void);
 void vmx_module_exit(void);
-#else
-bool kvm_is_vmx_supported(void) { return false; }
 #endif
 
 struct kvm_caps {
-- 
2.42.0.869.gea05f2083d-goog

