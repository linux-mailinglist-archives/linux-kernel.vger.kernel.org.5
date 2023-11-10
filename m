Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE317E7773
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjKJC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345753AbjKJC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:29:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1C644BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:29:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9b9aeb4962so1961694276.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699583347; x=1700188147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=md27dvFGlb5hqViLj+F5m5pmIHcQvWG8IIW5rr2ILTg=;
        b=MSmY0KNgVhLeYaew0QFsjs3FhLSTvxKXPCl04y8eigQ4iZAjyj32iNrc4OJ/6lVGRo
         nPxi+Bf1Itdbj1o1H0zFi/+8P2GwNy7UiJzZJv1+hZobGr9B4D1y2VoRd8cNdDbmD2sv
         bV7kA4NdXkPspzg8DmOnwD4iHsY7Qzc5Sm95D/Oj2kCk8OrN6RnA2dAtYarMbtss78iE
         g5ZYP6IbsTxsdIeKXJyc2FideiWJUtFWR1IbADepTbIdAf9bQuRXkFW3g1dDcm9VnWs5
         kPXWH9+KuWLiEjp/WcT+AAGCaqe5zx8YJeRpfVAeWwCl9um+QajmUKvvpH01lRDKkAIv
         zqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583347; x=1700188147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md27dvFGlb5hqViLj+F5m5pmIHcQvWG8IIW5rr2ILTg=;
        b=RB+MQGusPyKMaXVRgCrJciSHnrNg87T0w94Fh25zjXiKsfhP+/Y1J9EzBq/enfFR73
         sd5UhcWaEGbbq2/7uGrtyfNpPJQ5TZHvLUQPHjfdNajrINg7h0nb/Pgzwy0Rn7OVIskm
         1Ap4bEoXgyqqh6klJT1tm0Osm0xF8ZZaoDHOHb8D5b4c+EnIxE7Wuut2i26VvLbUFMjQ
         p+YSh6XtU0NiJQaV/oFEBiEKkWuvqhCTncyRlPJLtM1lDmJ6sxSyU/C9HGkpSu44n/XA
         wI8QCjjeIgEaJ0DgvSyciyExjgGrp+K7MR53u1wdyJ3LrOhEUTShjMjOFFQr+crJDXoq
         cfrw==
X-Gm-Message-State: AOJu0YxCQ3q9CFBDszJdmxFCXfvx6jWSDVxgci/oqWUIAbdkK5vZKD2a
        1LRqSGGxm4ADSjHpJavCFacQImAj9lg=
X-Google-Smtp-Source: AGHT+IEPIA5i6GwZZmuF2E4xXE3dLgW/PVXTWanSm3nsZNSdpMXZWr3b6o61SS8QwqedZXfcgDN7oTKXJ64=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cb97:0:b0:da0:73c2:db78 with SMTP id
 b145-20020a25cb97000000b00da073c2db78mr188375ybg.9.1699583347379; Thu, 09 Nov
 2023 18:29:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:28:50 -0800
In-Reply-To: <20231110022857.1273836-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110022857.1273836-4-seanjc@google.com>
Subject: [PATCH 03/10] KVM: x86/pmu: Move pmc_idx => pmc translation helper to
 common code
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common helper for *internal* PMC lookups, and delete the ops hook
and Intel's implementation.  Keep AMD's implementation, but rename it to
amd_pmu_get_pmc() to make it somewhat more obvious that it's suited for
both KVM-internal and guest-initiated lookups.

Because KVM tracks all counters in a single bitmap, getting a counter
when iterating over a bitmap, e.g. of all valid PMCs, requires a small
amount of math, that while simple, isn't super obvious and doesn't use the
same semantics as PMC lookups from RDPMC!  Although AMD doesn't support
fixed counters, the common PMU code still behaves as if there a split, the
high half of which just happens to always be empty.

Opportunstically add a comment to explain both what is going on, and why
KVM uses a single bitmap, e.g. the boilerplate for iterating over separate
bitmaps could be done via macros, so it's not (just) about deduplicating
code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 -
 arch/x86/kvm/pmu.c                     |  8 +++----
 arch/x86/kvm/pmu.h                     | 29 +++++++++++++++++++++++++-
 arch/x86/kvm/svm/pmu.c                 |  7 +++----
 arch/x86/kvm/vmx/pmu_intel.c           | 15 +------------
 5 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index d7eebee4450c..e5e7f036587f 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -12,7 +12,6 @@ BUILD_BUG_ON(1)
  * a NULL definition, for example if "static_call_cond()" will be used
  * at the call sites.
  */
-KVM_X86_PMU_OP(pmc_idx_to_pmc)
 KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
 KVM_X86_PMU_OP(msr_idx_to_pmc)
 KVM_X86_PMU_OP(is_valid_rdpmc_ecx)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 714fa6dd912e..6ee05ad35f55 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -505,7 +505,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	int bit;
 
 	for_each_set_bit(bit, pmu->reprogram_pmi, X86_PMC_IDX_MAX) {
-		struct kvm_pmc *pmc = static_call(kvm_x86_pmu_pmc_idx_to_pmc)(pmu, bit);
+		struct kvm_pmc *pmc = kvm_pmc_idx_to_pmc(pmu, bit);
 
 		if (unlikely(!pmc)) {
 			clear_bit(bit, pmu->reprogram_pmi);
@@ -715,7 +715,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 
 	for_each_set_bit(i, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX) {
-		pmc = static_call(kvm_x86_pmu_pmc_idx_to_pmc)(pmu, i);
+		pmc = kvm_pmc_idx_to_pmc(pmu, i);
 		if (!pmc)
 			continue;
 
@@ -791,7 +791,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
 		      pmu->pmc_in_use, X86_PMC_IDX_MAX);
 
 	for_each_set_bit(i, bitmask, X86_PMC_IDX_MAX) {
-		pmc = static_call(kvm_x86_pmu_pmc_idx_to_pmc)(pmu, i);
+		pmc = kvm_pmc_idx_to_pmc(pmu, i);
 
 		if (pmc && pmc->perf_event && !pmc_speculative_in_use(pmc))
 			pmc_stop_counter(pmc);
@@ -846,7 +846,7 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 perf_hw_id)
 	int i;
 
 	for_each_set_bit(i, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX) {
-		pmc = static_call(kvm_x86_pmu_pmc_idx_to_pmc)(pmu, i);
+		pmc = kvm_pmc_idx_to_pmc(pmu, i);
 
 		if (!pmc || !pmc_event_is_allowed(pmc))
 			continue;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 7ffa4f1dedb0..2235772a495b 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -4,6 +4,8 @@
 
 #include <linux/nospec.h>
 
+#include <asm/kvm_host.h>
+
 #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu)
 #define pmu_to_vcpu(pmu)  (container_of((pmu), struct kvm_vcpu, arch.pmu))
 #define pmc_to_pmu(pmc)   (&(pmc)->vcpu->arch.pmu)
@@ -21,7 +23,6 @@
 #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED
 
 struct kvm_pmu_ops {
-	struct kvm_pmc *(*pmc_idx_to_pmc)(struct kvm_pmu *pmu, int pmc_idx);
 	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
 		unsigned int idx, u64 *mask);
 	struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, u32 msr);
@@ -56,6 +57,32 @@ static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
 	return pmu->version > 1;
 }
 
+/*
+ * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
+ * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
+ * is tracked internally via index 32.  On Intel, (AMD doesn't support fixed
+ * counters), this mirrors how fixed counters are mapped to PERF_GLOBAL_CTRL
+ * and similar MSRs, i.e. tracking fixed counters at base index 32 reduces the
+ * amounter of boilerplate needed to iterate over PMCs *and* simplifies common
+ * enabling/disable/reset operations.
+ *
+ * WARNING!  This helper is only for lookups that are initiated by KVM, it is
+ * NOT safe for guest lookups, e.g. will do the wrong thing if passed a raw
+ * ECX value from RDPMC (fixed counters are accessed by setting bit 30 in ECX
+ * for RDPMC, not by adding 32 to the fixed counter index).
+ */
+static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
+{
+	if (idx < pmu->nr_arch_gp_counters)
+		return &pmu->gp_counters[idx];
+
+	idx -= KVM_FIXED_PMC_BASE_IDX;
+	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
+		return &pmu->fixed_counters[idx];
+
+	return NULL;
+}
+
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 1fafc46f61c9..b6c1d1c3f204 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -25,7 +25,7 @@ enum pmu_type {
 	PMU_TYPE_EVNTSEL,
 };
 
-static struct kvm_pmc *amd_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
+static struct kvm_pmc *amd_pmu_get_pmc(struct kvm_pmu *pmu, int pmc_idx)
 {
 	unsigned int num_counters = pmu->nr_arch_gp_counters;
 
@@ -70,7 +70,7 @@ static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
 		return NULL;
 	}
 
-	return amd_pmc_idx_to_pmc(pmu, idx);
+	return amd_pmu_get_pmc(pmu, idx);
 }
 
 static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
@@ -84,7 +84,7 @@ static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
 static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	unsigned int idx, u64 *mask)
 {
-	return amd_pmc_idx_to_pmc(vcpu_to_pmu(vcpu), idx);
+	return amd_pmu_get_pmc(vcpu_to_pmu(vcpu), idx);
 }
 
 static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
@@ -226,7 +226,6 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
-	.pmc_idx_to_pmc = amd_pmc_idx_to_pmc,
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
 	.is_valid_rdpmc_ecx = amd_is_valid_rdpmc_ecx,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 61252bb733c4..4254411be467 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -47,18 +47,6 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	}
 }
 
-static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
-{
-	if (pmc_idx < KVM_FIXED_PMC_BASE_IDX) {
-		return get_gp_pmc(pmu, MSR_P6_EVNTSEL0 + pmc_idx,
-				  MSR_P6_EVNTSEL0);
-	} else {
-		u32 idx = pmc_idx - KVM_FIXED_PMC_BASE_IDX;
-
-		return get_fixed_pmc(pmu, idx + MSR_CORE_PERF_FIXED_CTR0);
-	}
-}
-
 static u32 intel_rdpmc_get_masked_idx(struct kvm_pmu *pmu, u32 idx)
 {
 	/*
@@ -710,7 +698,7 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 
 	for_each_set_bit(bit, (unsigned long *)&pmu->global_ctrl,
 			 X86_PMC_IDX_MAX) {
-		pmc = intel_pmc_idx_to_pmc(pmu, bit);
+		pmc = kvm_pmc_idx_to_pmc(pmu, bit);
 
 		if (!pmc || !pmc_speculative_in_use(pmc) ||
 		    !pmc_is_globally_enabled(pmc) || !pmc->perf_event)
@@ -727,7 +715,6 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 }
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
-	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
 	.is_valid_rdpmc_ecx = intel_is_valid_rdpmc_ecx,
-- 
2.42.0.869.gea05f2083d-goog

