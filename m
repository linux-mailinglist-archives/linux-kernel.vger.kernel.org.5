Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619E47E0CAE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjKDAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjKDACy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:54 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C6CD5F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:50 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso20496745ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056170; x=1699660970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2pNxubyeriZ6Kmw42WjydTECjrsrFHiPrAbYW9CF/sc=;
        b=gJetzBr3CpqUMGpntCX81WvKyVoDErGXgWpelljZ+JuXMZBIad+wHV/kct0zjLw1fk
         Y3p/IdCpj+toBYjOoFNtCx3ziHGp194N165Bqb6wegPhDQ/zlzrL8a3usYikAfAKCND4
         q/Tc9z6XesvJnufC0Pbq3wrVTZczXI/fRdyvDvyviSUk+bXPqhJRa6FlVN6HPtfu+way
         +vspEeTVoX+BnL4w9Do0kAyf4Yuh5CYg0tX/pd7/in81SKVDkXjuen+aXqhe8YbLPSn1
         r1e72IdDkMeBN5f/uQQmvMihaPA3qCmdq7P8BYiNgJJjS/h46jYf/rc4QgOxi849U9Kf
         iUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056170; x=1699660970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pNxubyeriZ6Kmw42WjydTECjrsrFHiPrAbYW9CF/sc=;
        b=da9ehy8t0DM3s0zEJcIbhXxWRZn+YZ6sW0oJjWe4F0BoX53kyrQFSsq2HBYmUIpcTY
         s1PgGNUbigG6TyLItjoNP0AR5cbbvJQomphw+CdxDjdByBxQftUc/XpZSe3iOhGqpI5l
         1USHS/QgqGLa5UkXgKlF4OKSYP7pOcxq7nYPADahNpdhBzvUdGGIyVaBSlgk0VZf/XHR
         hT/dyYVfD2027JJlYYbSPTF9AJrRcUyFt5lV03BbHb/j7Os7OmGYUtgiW9FvHhanDmZB
         vLFzrYMs0ei6w/CuB900UnmNWrJKmIA3KwxafrPM833+riZxAuuiLT50En1P+QkbNfgE
         ZgBg==
X-Gm-Message-State: AOJu0Yyz4JScx4eXkLaP/B5ggOm7kDn0JIqNzHDbGIRW8mW75P/yar3o
        F4tcbP2065heG+JBbJ7u+Km/xp6Wn2k=
X-Google-Smtp-Source: AGHT+IH2+5mojji7zEoMjMrzCTSwGzDwt7lgukPyzMV9CIrg/7JBSpqwd//N7kM1LacJ029i8Pe3LesZ8GY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efd1:b0:1c6:2b9d:570b with SMTP id
 ja17-20020a170902efd100b001c62b9d570bmr414315plb.7.1699056170302; Fri, 03 Nov
 2023 17:02:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:23 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-6-seanjc@google.com>
Subject: [PATCH v6 05/20] KVM: x86/pmu: Allow programming events that match
 unsupported arch events
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
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

Remove KVM's bogus restriction that the guest can't program an event whose
encoding matches an unsupported architectural event.  The enumeration of
an architectural event only says that if a CPU supports an architectural
event, then the event can be programmed using the architectural encoding.
The enumeration does NOT say anything about the encoding when the CPU
doesn't report support the architectural event.

Preventing the guest from counting events whose encoding happens to match
an architectural event breaks existing functionality whenever Intel adds
an architectural encoding that was *ever* used for a CPU that doesn't
enumerate support for the architectural event, even if the encoding is for
the exact same event!

E.g. the architectural encoding for Top-Down Slots is 0x01a4.  Broadwell
CPUs, which do not support the Top-Down Slots architectural event, 0x10a4
is a valid, model-specific event.  Denying guest usage of 0x01a4 if/when
KVM adds support for Top-Down slots would break any Broadwell-based guest.

Reported-by: Kan Liang <kan.liang@linux.intel.com>
Closes: https://lore.kernel.org/all/2004baa6-b494-462c-a11f-8104ea152c6a@linux.intel.com
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Fixes: a21864486f7e ("KVM: x86/pmu: Fix available_event_types check for REF_CPU_CYCLES event")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 -
 arch/x86/kvm/pmu.c                     |  1 -
 arch/x86/kvm/pmu.h                     |  1 -
 arch/x86/kvm/svm/pmu.c                 |  6 ----
 arch/x86/kvm/vmx/pmu_intel.c           | 38 --------------------------
 5 files changed, 47 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 6c98f4bb4228..884af8ef7657 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -12,7 +12,6 @@ BUILD_BUG_ON(1)
  * a NULL definition, for example if "static_call_cond()" will be used
  * at the call sites.
  */
-KVM_X86_PMU_OP(hw_event_available)
 KVM_X86_PMU_OP(pmc_idx_to_pmc)
 KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
 KVM_X86_PMU_OP(msr_idx_to_pmc)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9ae07db6f0f6..99ed72966528 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -374,7 +374,6 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
 static bool pmc_event_is_allowed(struct kvm_pmc *pmc)
 {
 	return pmc_is_globally_enabled(pmc) && pmc_speculative_in_use(pmc) &&
-	       static_call(kvm_x86_pmu_hw_event_available)(pmc) &&
 	       check_pmu_event_filter(pmc);
 }
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 5341e8f69a22..f3e7a356fd81 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -20,7 +20,6 @@
 
 struct kvm_pmu_ops {
 	void (*init_pmu_capability)(void);
-	bool (*hw_event_available)(struct kvm_pmc *pmc);
 	struct kvm_pmc *(*pmc_idx_to_pmc)(struct kvm_pmu *pmu, int pmc_idx);
 	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
 		unsigned int idx, u64 *mask);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 373ff6a6687b..5596fe816ea8 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -73,11 +73,6 @@ static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
 	return amd_pmc_idx_to_pmc(pmu, idx);
 }
 
-static bool amd_hw_event_available(struct kvm_pmc *pmc)
-{
-	return true;
-}
-
 static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -249,7 +244,6 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
 }
 
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
-	.hw_event_available = amd_hw_event_available,
 	.pmc_idx_to_pmc = amd_pmc_idx_to_pmc,
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index b239e7dbdc9b..9bf700da1e17 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -140,43 +140,6 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
 	}
 }
 
-static bool intel_hw_event_available(struct kvm_pmc *pmc)
-{
-	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
-	u8 event_select = pmc->eventsel & ARCH_PERFMON_EVENTSEL_EVENT;
-	u8 unit_mask = (pmc->eventsel & ARCH_PERFMON_EVENTSEL_UMASK) >> 8;
-	int i;
-
-	/*
-	 * Fixed counters are always available if KVM reaches this point.  If a
-	 * fixed counter is unsupported in hardware or guest CPUID, KVM doesn't
-	 * allow the counter's corresponding MSR to be written.  KVM does use
-	 * architectural events to program fixed counters, as the interface to
-	 * perf doesn't allow requesting a specific fixed counter, e.g. perf
-	 * may (sadly) back a guest fixed PMC with a general purposed counter.
-	 * But if _hardware_ doesn't support the associated event, KVM simply
-	 * doesn't enumerate support for the fixed counter.
-	 */
-	if (pmc_is_fixed(pmc))
-		return true;
-
-	BUILD_BUG_ON(ARRAY_SIZE(intel_arch_events) != NR_INTEL_ARCH_EVENTS);
-
-	/*
-	 * Disallow events reported as unavailable in guest CPUID.  Note, this
-	 * doesn't apply to pseudo-architectural events (see above).
-	 */
-	for (i = 0; i < NR_REAL_INTEL_ARCH_EVENTS; i++) {
-		if (intel_arch_events[i].eventsel != event_select ||
-		    intel_arch_events[i].unit_mask != unit_mask)
-			continue;
-
-		return pmu->available_event_types & BIT(i);
-	}
-
-	return true;
-}
-
 static bool intel_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -842,7 +805,6 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
 
 struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.init_pmu_capability = intel_init_pmu_capability,
-	.hw_event_available = intel_hw_event_available,
 	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
 	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
-- 
2.42.0.869.gea05f2083d-goog

