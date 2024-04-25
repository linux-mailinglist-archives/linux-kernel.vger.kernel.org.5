Return-Path: <linux-kernel+bounces-159007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AEA8B2807
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E514E1F21548
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009DD14F9ED;
	Thu, 25 Apr 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpoEmEE/"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEB155A4E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068885; cv=none; b=Qku98BVXO7Zd9xc6rcImmOQ8FrAI9+iAJnMJu/hh3BYqIkvazvRuzM5QETHFAoLDjx/pXQQE3dkkr+PIiy3gPVj1koBuhqN6zgitiSyHHqoxIyGfy0iUSYmyD0jrkNb6qdmZyeyaWv6ThpFZ8dmFJZl5kCVG6JRDielay1COpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068885; c=relaxed/simple;
	bh=EBMKPetibCe1fk8IIl6DuzqE13SDO5ENAO3qdArUqpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I19nfbRGIVYG9wzdEEGD1R9fuf7NYQAll4nLLNv7+RXQNOLnnqWJiOWyLqg/zmuWWfDH/dc1N+xE9M3xyqBvTgIwx8J7S/cLubl7DBLJAE4rLaxXhn8XjOknCEfw19h7oNLz0W2/9LPcEFm6Kk6flbi/uodPuPTypux9RWGLw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BpoEmEE/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed2f4e685bso1273732b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714068883; x=1714673683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FIOMYYhe7hoUfRGO54+WDBb/x/QzKRVyKe5KVJBy8Sk=;
        b=BpoEmEE/+S2erZHCXyjCcY0SnRUnsOZguR8+YaV9tp8SSoDCL0qBAMhWvyQ7FB32f2
         lAb2VO52Qd5eokg8mDofg7aBaRDActr4TvYf6Q80i26Rusoc7nTPPAKaTmH+BaYN+6NI
         0OZtZ4RByoya/zyHOeBVs8G2p81JVdNWEVt50dFFJis5EXpdDs8byMMofOpHhK6sfPkO
         nCurIXxMED2TKir4XB6Ei1UtkuIjdBNsjdJMHkiDxLW45lilM0Eve1Zx3o9TJwE0kCOE
         wuOJBOfVBcOqY+sprYvw3ADYwRFv5e10SAUC5kjP2+m/ITCFYZLNKy4qQXbWy2RvBh/Y
         KK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068883; x=1714673683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIOMYYhe7hoUfRGO54+WDBb/x/QzKRVyKe5KVJBy8Sk=;
        b=MsLso1HvjCWTkXL3Ig5JknHQbcHdzsnkNFoeh5nG5mS6LJxP7+n/9J3hcmOyc/8Zsl
         ygCdATbbzAeyi+ocQiUTtPo5ScGQsI8xm3Z+ack39ekbKfWR9ttdq5ys2GkFAjYXJCor
         M4hf2vDWlY2DbBKOjBzsSQ6uYIHx0IOTQp+dBJmyFsiAmpCx3A39/FNZaKr7Qh5p++v8
         MjjYziubKSFda6mM+TlFRq/BqYFa+3dH7Ubpc4HzVi3m22jGzfR7i8HGVy66+dh8+DyX
         UVxRsGGLVqUHdSOlA1IgZvb0TapnMzNCqycebURKWIflsWKKSexIKtFIzmnjNPJwUHJ/
         x3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaknj9Qw7pAYxOfdJnz85qEC4xFaf7z0fqeJ3fuZI85imZJP8ZiLFq/7lLMDs4+05qyHJrZ7AHh1Gp4p7GXPn5seuRWcH9jlgfN/d2
X-Gm-Message-State: AOJu0YwKxdvclnZveu28zLDxGTn2KwBszVKGuDSNzOl6NQU8Bhs2jepX
	mTUEbPylV5o1moCiojaiJoZg4IZds2/4gjDRmEuQLQgglsVvyK6CokD6jdiYbN+TJAfGPHwmmvQ
	/JQ==
X-Google-Smtp-Source: AGHT+IHAReYHzQ+UaXLGIDLEHp2zod/ikcL6IlTa1/Jlexj3BDRolEdIdLsCPfxdpltJjtWg17vzoLARWeg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:8cc6:b0:6ec:f3e8:46a8 with SMTP id
 ij6-20020a056a008cc600b006ecf3e846a8mr38817pfb.1.1714068883127; Thu, 25 Apr
 2024 11:14:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 11:14:20 -0700
In-Reply-To: <20240425181422.3250947-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425181422.3250947-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425181422.3250947-9-seanjc@google.com>
Subject: [PATCH 08/10] KVM: x86: Hoist x86.c's global msr_* variables up above kvm_do_msr_access()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the definitions of the various MSR arrays above kvm_do_msr_access()
so that kvm_do_msr_access() can query the arrays when handling failures,
e.g. to squash errors if userspace tries to read an MSR that isn't fully
supported, but that KVM advertised as being an MSR-to-save.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 368 ++++++++++++++++++++++-----------------------
 1 file changed, 184 insertions(+), 184 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a0506878d58e..04a5ae853774 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -319,6 +319,190 @@ u64 __read_mostly host_xcr0;
 
 static struct kmem_cache *x86_emulator_cache;
 
+/*
+ * The three MSR lists(msrs_to_save, emulated_msrs, msr_based_features) track
+ * the set of MSRs that KVM exposes to userspace through KVM_GET_MSRS,
+ * KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.  msrs_to_save holds MSRs that
+ * require host support, i.e. should be probed via RDMSR.  emulated_msrs holds
+ * MSRs that KVM emulates without strictly requiring host support.
+ * msr_based_features holds MSRs that enumerate features, i.e. are effectively
+ * CPUID leafs.  Note, msr_based_features isn't mutually exclusive with
+ * msrs_to_save and emulated_msrs.
+ */
+
+static const u32 msrs_to_save_base[] = {
+	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
+	MSR_STAR,
+#ifdef CONFIG_X86_64
+	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
+#endif
+	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
+	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
+	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
+	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
+	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
+	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
+	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
+	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
+	MSR_IA32_UMWAIT_CONTROL,
+
+	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
+};
+
+static const u32 msrs_to_save_pmu[] = {
+	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
+	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
+	MSR_CORE_PERF_GLOBAL_CTRL, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
+	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
+
+	/* This part of MSRs should match KVM_INTEL_PMC_MAX_GENERIC. */
+	MSR_ARCH_PERFMON_PERFCTR0, MSR_ARCH_PERFMON_PERFCTR1,
+	MSR_ARCH_PERFMON_PERFCTR0 + 2, MSR_ARCH_PERFMON_PERFCTR0 + 3,
+	MSR_ARCH_PERFMON_PERFCTR0 + 4, MSR_ARCH_PERFMON_PERFCTR0 + 5,
+	MSR_ARCH_PERFMON_PERFCTR0 + 6, MSR_ARCH_PERFMON_PERFCTR0 + 7,
+	MSR_ARCH_PERFMON_EVENTSEL0, MSR_ARCH_PERFMON_EVENTSEL1,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 2, MSR_ARCH_PERFMON_EVENTSEL0 + 3,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 4, MSR_ARCH_PERFMON_EVENTSEL0 + 5,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 6, MSR_ARCH_PERFMON_EVENTSEL0 + 7,
+
+	MSR_K7_EVNTSEL0, MSR_K7_EVNTSEL1, MSR_K7_EVNTSEL2, MSR_K7_EVNTSEL3,
+	MSR_K7_PERFCTR0, MSR_K7_PERFCTR1, MSR_K7_PERFCTR2, MSR_K7_PERFCTR3,
+
+	/* This part of MSRs should match KVM_AMD_PMC_MAX_GENERIC. */
+	MSR_F15H_PERF_CTL0, MSR_F15H_PERF_CTL1, MSR_F15H_PERF_CTL2,
+	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
+	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
+	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
+
+	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+};
+
+static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
+			ARRAY_SIZE(msrs_to_save_pmu)];
+static unsigned num_msrs_to_save;
+
+static const u32 emulated_msrs_all[] = {
+	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
+	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
+
+#ifdef CONFIG_KVM_HYPERV
+	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
+	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
+	HV_X64_MSR_TSC_FREQUENCY, HV_X64_MSR_APIC_FREQUENCY,
+	HV_X64_MSR_CRASH_P0, HV_X64_MSR_CRASH_P1, HV_X64_MSR_CRASH_P2,
+	HV_X64_MSR_CRASH_P3, HV_X64_MSR_CRASH_P4, HV_X64_MSR_CRASH_CTL,
+	HV_X64_MSR_RESET,
+	HV_X64_MSR_VP_INDEX,
+	HV_X64_MSR_VP_RUNTIME,
+	HV_X64_MSR_SCONTROL,
+	HV_X64_MSR_STIMER0_CONFIG,
+	HV_X64_MSR_VP_ASSIST_PAGE,
+	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
+	HV_X64_MSR_TSC_EMULATION_STATUS, HV_X64_MSR_TSC_INVARIANT_CONTROL,
+	HV_X64_MSR_SYNDBG_OPTIONS,
+	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
+	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
+	HV_X64_MSR_SYNDBG_PENDING_BUFFER,
+#endif
+
+	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
+	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
+
+	MSR_IA32_TSC_ADJUST,
+	MSR_IA32_TSC_DEADLINE,
+	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_PERF_CAPABILITIES,
+	MSR_IA32_MISC_ENABLE,
+	MSR_IA32_MCG_STATUS,
+	MSR_IA32_MCG_CTL,
+	MSR_IA32_MCG_EXT_CTL,
+	MSR_IA32_SMBASE,
+	MSR_SMI_COUNT,
+	MSR_PLATFORM_INFO,
+	MSR_MISC_FEATURES_ENABLES,
+	MSR_AMD64_VIRT_SPEC_CTRL,
+	MSR_AMD64_TSC_RATIO,
+	MSR_IA32_POWER_CTL,
+	MSR_IA32_UCODE_REV,
+
+	/*
+	 * KVM always supports the "true" VMX control MSRs, even if the host
+	 * does not.  The VMX MSRs as a whole are considered "emulated" as KVM
+	 * doesn't strictly require them to exist in the host (ignoring that
+	 * KVM would refuse to load in the first place if the core set of MSRs
+	 * aren't supported).
+	 */
+	MSR_IA32_VMX_BASIC,
+	MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+	MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+	MSR_IA32_VMX_TRUE_EXIT_CTLS,
+	MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+	MSR_IA32_VMX_MISC,
+	MSR_IA32_VMX_CR0_FIXED0,
+	MSR_IA32_VMX_CR4_FIXED0,
+	MSR_IA32_VMX_VMCS_ENUM,
+	MSR_IA32_VMX_PROCBASED_CTLS2,
+	MSR_IA32_VMX_EPT_VPID_CAP,
+	MSR_IA32_VMX_VMFUNC,
+
+	MSR_K7_HWCR,
+	MSR_KVM_POLL_CONTROL,
+};
+
+static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
+static unsigned num_emulated_msrs;
+
+/*
+ * List of MSRs that control the existence of MSR-based features, i.e. MSRs
+ * that are effectively CPUID leafs.  VMX MSRs are also included in the set of
+ * feature MSRs, but are handled separately to allow expedited lookups.
+ */
+static const u32 msr_based_features_all_except_vmx[] = {
+	MSR_AMD64_DE_CFG,
+	MSR_IA32_UCODE_REV,
+	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_PERF_CAPABILITIES,
+};
+
+static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
+			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
+static unsigned int num_msr_based_features;
+
+/*
+ * All feature MSRs except uCode revID, which tracks the currently loaded uCode
+ * patch, are immutable once the vCPU model is defined.
+ */
+static bool kvm_is_immutable_feature_msr(u32 msr)
+{
+	int i;
+
+	if (msr >= KVM_FIRST_EMULATED_VMX_MSR && msr <= KVM_LAST_EMULATED_VMX_MSR)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++) {
+		if (msr == msr_based_features_all_except_vmx[i])
+			return msr != MSR_IA32_UCODE_REV;
+	}
+
+	return false;
+}
+
+static bool kvm_is_msr_to_save(u32 msr_index)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_msrs_to_save; i++) {
+		if (msrs_to_save[i] == msr_index)
+			return true;
+	}
+
+	return false;
+}
+
 typedef int (*msr_access_t)(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 			    bool host_initiated);
 
@@ -1448,178 +1632,6 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_rdpmc);
 
-/*
- * The three MSR lists(msrs_to_save, emulated_msrs, msr_based_features) track
- * the set of MSRs that KVM exposes to userspace through KVM_GET_MSRS,
- * KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.  msrs_to_save holds MSRs that
- * require host support, i.e. should be probed via RDMSR.  emulated_msrs holds
- * MSRs that KVM emulates without strictly requiring host support.
- * msr_based_features holds MSRs that enumerate features, i.e. are effectively
- * CPUID leafs.  Note, msr_based_features isn't mutually exclusive with
- * msrs_to_save and emulated_msrs.
- */
-
-static const u32 msrs_to_save_base[] = {
-	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
-	MSR_STAR,
-#ifdef CONFIG_X86_64
-	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
-#endif
-	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
-	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
-	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
-	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
-	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
-	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
-	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
-	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
-	MSR_IA32_UMWAIT_CONTROL,
-
-	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
-};
-
-static const u32 msrs_to_save_pmu[] = {
-	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
-	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
-	MSR_CORE_PERF_GLOBAL_CTRL, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
-	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
-
-	/* This part of MSRs should match KVM_INTEL_PMC_MAX_GENERIC. */
-	MSR_ARCH_PERFMON_PERFCTR0, MSR_ARCH_PERFMON_PERFCTR1,
-	MSR_ARCH_PERFMON_PERFCTR0 + 2, MSR_ARCH_PERFMON_PERFCTR0 + 3,
-	MSR_ARCH_PERFMON_PERFCTR0 + 4, MSR_ARCH_PERFMON_PERFCTR0 + 5,
-	MSR_ARCH_PERFMON_PERFCTR0 + 6, MSR_ARCH_PERFMON_PERFCTR0 + 7,
-	MSR_ARCH_PERFMON_EVENTSEL0, MSR_ARCH_PERFMON_EVENTSEL1,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 2, MSR_ARCH_PERFMON_EVENTSEL0 + 3,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 4, MSR_ARCH_PERFMON_EVENTSEL0 + 5,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 6, MSR_ARCH_PERFMON_EVENTSEL0 + 7,
-
-	MSR_K7_EVNTSEL0, MSR_K7_EVNTSEL1, MSR_K7_EVNTSEL2, MSR_K7_EVNTSEL3,
-	MSR_K7_PERFCTR0, MSR_K7_PERFCTR1, MSR_K7_PERFCTR2, MSR_K7_PERFCTR3,
-
-	/* This part of MSRs should match KVM_AMD_PMC_MAX_GENERIC. */
-	MSR_F15H_PERF_CTL0, MSR_F15H_PERF_CTL1, MSR_F15H_PERF_CTL2,
-	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
-	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
-	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
-
-	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
-	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
-	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
-};
-
-static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
-			ARRAY_SIZE(msrs_to_save_pmu)];
-static unsigned num_msrs_to_save;
-
-static const u32 emulated_msrs_all[] = {
-	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
-	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
-
-#ifdef CONFIG_KVM_HYPERV
-	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
-	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
-	HV_X64_MSR_TSC_FREQUENCY, HV_X64_MSR_APIC_FREQUENCY,
-	HV_X64_MSR_CRASH_P0, HV_X64_MSR_CRASH_P1, HV_X64_MSR_CRASH_P2,
-	HV_X64_MSR_CRASH_P3, HV_X64_MSR_CRASH_P4, HV_X64_MSR_CRASH_CTL,
-	HV_X64_MSR_RESET,
-	HV_X64_MSR_VP_INDEX,
-	HV_X64_MSR_VP_RUNTIME,
-	HV_X64_MSR_SCONTROL,
-	HV_X64_MSR_STIMER0_CONFIG,
-	HV_X64_MSR_VP_ASSIST_PAGE,
-	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
-	HV_X64_MSR_TSC_EMULATION_STATUS, HV_X64_MSR_TSC_INVARIANT_CONTROL,
-	HV_X64_MSR_SYNDBG_OPTIONS,
-	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
-	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
-	HV_X64_MSR_SYNDBG_PENDING_BUFFER,
-#endif
-
-	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
-	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
-
-	MSR_IA32_TSC_ADJUST,
-	MSR_IA32_TSC_DEADLINE,
-	MSR_IA32_ARCH_CAPABILITIES,
-	MSR_IA32_PERF_CAPABILITIES,
-	MSR_IA32_MISC_ENABLE,
-	MSR_IA32_MCG_STATUS,
-	MSR_IA32_MCG_CTL,
-	MSR_IA32_MCG_EXT_CTL,
-	MSR_IA32_SMBASE,
-	MSR_SMI_COUNT,
-	MSR_PLATFORM_INFO,
-	MSR_MISC_FEATURES_ENABLES,
-	MSR_AMD64_VIRT_SPEC_CTRL,
-	MSR_AMD64_TSC_RATIO,
-	MSR_IA32_POWER_CTL,
-	MSR_IA32_UCODE_REV,
-
-	/*
-	 * KVM always supports the "true" VMX control MSRs, even if the host
-	 * does not.  The VMX MSRs as a whole are considered "emulated" as KVM
-	 * doesn't strictly require them to exist in the host (ignoring that
-	 * KVM would refuse to load in the first place if the core set of MSRs
-	 * aren't supported).
-	 */
-	MSR_IA32_VMX_BASIC,
-	MSR_IA32_VMX_TRUE_PINBASED_CTLS,
-	MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
-	MSR_IA32_VMX_TRUE_EXIT_CTLS,
-	MSR_IA32_VMX_TRUE_ENTRY_CTLS,
-	MSR_IA32_VMX_MISC,
-	MSR_IA32_VMX_CR0_FIXED0,
-	MSR_IA32_VMX_CR4_FIXED0,
-	MSR_IA32_VMX_VMCS_ENUM,
-	MSR_IA32_VMX_PROCBASED_CTLS2,
-	MSR_IA32_VMX_EPT_VPID_CAP,
-	MSR_IA32_VMX_VMFUNC,
-
-	MSR_K7_HWCR,
-	MSR_KVM_POLL_CONTROL,
-};
-
-static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
-static unsigned num_emulated_msrs;
-
-/*
- * List of MSRs that control the existence of MSR-based features, i.e. MSRs
- * that are effectively CPUID leafs.  VMX MSRs are also included in the set of
- * feature MSRs, but are handled separately to allow expedited lookups.
- */
-static const u32 msr_based_features_all_except_vmx[] = {
-	MSR_AMD64_DE_CFG,
-	MSR_IA32_UCODE_REV,
-	MSR_IA32_ARCH_CAPABILITIES,
-	MSR_IA32_PERF_CAPABILITIES,
-};
-
-static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
-			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
-static unsigned int num_msr_based_features;
-
-/*
- * All feature MSRs except uCode revID, which tracks the currently loaded uCode
- * patch, are immutable once the vCPU model is defined.
- */
-static bool kvm_is_immutable_feature_msr(u32 msr)
-{
-	int i;
-
-	if (msr >= KVM_FIRST_EMULATED_VMX_MSR && msr <= KVM_LAST_EMULATED_VMX_MSR)
-		return true;
-
-	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++) {
-		if (msr == msr_based_features_all_except_vmx[i])
-			return msr != MSR_IA32_UCODE_REV;
-	}
-
-	return false;
-}
-
 /*
  * Some IA32_ARCH_CAPABILITIES bits have dependencies on MSRs that KVM
  * does not yet virtualize. These include:
@@ -3770,18 +3782,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
-static bool kvm_is_msr_to_save(u32 msr_index)
-{
-	unsigned int i;
-
-	for (i = 0; i < num_msrs_to_save; i++) {
-		if (msrs_to_save[i] == msr_index)
-			return true;
-	}
-
-	return false;
-}
-
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u32 msr = msr_info->index;
-- 
2.44.0.769.g3c40516874-goog


