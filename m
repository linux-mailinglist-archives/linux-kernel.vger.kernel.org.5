Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A787E4E06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjKHAbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjKHAbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:31:48 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CA610FB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:31:45 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc5ef7e815so44359945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403505; x=1700008305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rhicNGhqq5fztpWLcEppgCSeLbp+B1utXe2pu96crUY=;
        b=KXl73FupIeZiAwtiD8+G2a8yahwlalV0b70y5pN6rHmzbJ8lu/gzhGIL2AdlwjE1/z
         GkPldipLp1NcurLpbR0vRbmB4L6PGtu86p+mNwrFy4hA1b5sjnFRvazMRudC2414uz9S
         nzOejT5f0MvEgVQwl+o8m6AsBnHR5g3lnmeI2G8rJavSHl9JziLvn3FauxOy7th3CiEP
         3FBw1PKCt67tDIJ5+LDlThBj0pV43xVPmv9AjWin0IzG2/q0dEUVS1q1l0Je2sqttknQ
         6LCx+5su1hZhB1eEBisbLxLBUhgGQ5uEQBhRIEI+I02gYdyGIZqfSiMIwVK/WKOKCcsH
         4hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403505; x=1700008305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhicNGhqq5fztpWLcEppgCSeLbp+B1utXe2pu96crUY=;
        b=Khy4COKYqNFr/NUbBajNtCRGIZU1pYLv9NvrohZQZhUP4XDsH+YqBxrtFPRs/U23ud
         CSKzTMyYGPrXXCCWU2XduZm4G0KaUF+FzB4cKYO3XhReQvv+MiTI72TzHrI4zJCwZUAh
         0Rhfi+AFfthoGeMnfQ0XlGfskGlonxdhGxvJgy5+A7CoMPv1rIloEmh/jwzAunjvb3vT
         8q3nKQieiQlWQa3BAFu8ebYdIqd2AbbXxwza4wM+4anANQwejzmV/nTABw53iYnxskD9
         QrA7x8MFcnqq+oP+lHlwa0u8ZFWaIJJ4rkWLYRQAjj9tzt5cwUGNMqHk5W0qjxrEXZNz
         M9VA==
X-Gm-Message-State: AOJu0Yztz14mySWctlkLhl60hoZh2G6a3Emw3xo4ociuzhF64VDMVFEN
        cKEAmMY2vuj2ukwvZgecKee4/Ak01dM=
X-Google-Smtp-Source: AGHT+IG8v7a0nPfTRdwa63Yd+FFa4IRcCdUpDygUIiRA/i7UlLW9mSHc4zmVqWKKZD37/Z1DDRTuiPXO4bU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:260e:b0:1ca:1e12:7c85 with SMTP id
 jd14-20020a170903260e00b001ca1e127c85mr9958plb.3.1699403505298; Tue, 07 Nov
 2023 16:31:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:19 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-4-seanjc@google.com>
Subject: [PATCH v7 03/19] KVM: x86/pmu: Remove KVM's enumeration of Intel's
 architectural encodings
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop KVM's enumeration of Intel's architectural event encodings, and
instead open code the three encodings (of which only two are real) that
KVM uses to emulate fixed counters.  Now that KVM doesn't incorrectly
enforce the availability of architectural encodings, there is no reason
for KVM to ever care about the encodings themselves, at least not in the
current format of an array indexed by the encoding's position in CPUID.

Opportunistically add a comment to explain why KVM cares about eventsel
values for fixed counters.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 72 ++++++++++++------------------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 7737ee2fc62f..c4f2c6a268e7 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -22,52 +22,6 @@
 
 #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
 
-enum intel_pmu_architectural_events {
-	/*
-	 * The order of the architectural events matters as support for each
-	 * event is enumerated via CPUID using the index of the event.
-	 */
-	INTEL_ARCH_CPU_CYCLES,
-	INTEL_ARCH_INSTRUCTIONS_RETIRED,
-	INTEL_ARCH_REFERENCE_CYCLES,
-	INTEL_ARCH_LLC_REFERENCES,
-	INTEL_ARCH_LLC_MISSES,
-	INTEL_ARCH_BRANCHES_RETIRED,
-	INTEL_ARCH_BRANCHES_MISPREDICTED,
-
-	NR_REAL_INTEL_ARCH_EVENTS,
-
-	/*
-	 * Pseudo-architectural event used to implement IA32_FIXED_CTR2, a.k.a.
-	 * TSC reference cycles.  The architectural reference cycles event may
-	 * or may not actually use the TSC as the reference, e.g. might use the
-	 * core crystal clock or the bus clock (yeah, "architectural").
-	 */
-	PSEUDO_ARCH_REFERENCE_CYCLES = NR_REAL_INTEL_ARCH_EVENTS,
-	NR_INTEL_ARCH_EVENTS,
-};
-
-static struct {
-	u8 eventsel;
-	u8 unit_mask;
-} const intel_arch_events[] = {
-	[INTEL_ARCH_CPU_CYCLES]			= { 0x3c, 0x00 },
-	[INTEL_ARCH_INSTRUCTIONS_RETIRED]	= { 0xc0, 0x00 },
-	[INTEL_ARCH_REFERENCE_CYCLES]		= { 0x3c, 0x01 },
-	[INTEL_ARCH_LLC_REFERENCES]		= { 0x2e, 0x4f },
-	[INTEL_ARCH_LLC_MISSES]			= { 0x2e, 0x41 },
-	[INTEL_ARCH_BRANCHES_RETIRED]		= { 0xc4, 0x00 },
-	[INTEL_ARCH_BRANCHES_MISPREDICTED]	= { 0xc5, 0x00 },
-	[PSEUDO_ARCH_REFERENCE_CYCLES]		= { 0x00, 0x03 },
-};
-
-/* mapping between fixed pmc index and intel_arch_events array */
-static int fixed_pmc_events[] = {
-	[0] = INTEL_ARCH_INSTRUCTIONS_RETIRED,
-	[1] = INTEL_ARCH_CPU_CYCLES,
-	[2] = PSEUDO_ARCH_REFERENCE_CYCLES,
-};
-
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	struct kvm_pmc *pmc;
@@ -442,8 +396,29 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
+/*
+ * Map fixed counter events to architectural general purpose event encodings.
+ * Perf doesn't provide APIs to allow KVM to directly program a fixed counter,
+ * and so KVM instead programs the architectural event to effectively request
+ * the fixed counter.  Perf isn't guaranteed to use a fixed counter and may
+ * instead program the encoding into a general purpose counter, e.g. if a
+ * different perf_event is already utilizing the requested counter, but the end
+ * result is the same (ignoring the fact that using a general purpose counter
+ * will likely exacerbate counter contention).
+ *
+ * Note, reference cycles is counted using a perf-defined "psuedo-encoding",
+ * as there is no architectural general purpose encoding for reference cycles.
+ */
 static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
 {
+	const struct {
+		u8 eventsel;
+		u8 unit_mask;
+	} fixed_pmc_events[] = {
+		[0] = { 0xc0, 0x00 }, /* Instruction Retired / PERF_COUNT_HW_INSTRUCTIONS. */
+		[1] = { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CPU_CYCLES. */
+		[2] = { 0x00, 0x03 }, /* Reference Cycles / PERF_COUNT_HW_REF_CPU_CYCLES*/
+	};
 	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) != KVM_PMC_MAX_FIXED);
@@ -451,10 +426,9 @@ static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		int index = array_index_nospec(i, KVM_PMC_MAX_FIXED);
 		struct kvm_pmc *pmc = &pmu->fixed_counters[index];
-		u32 event = fixed_pmc_events[index];
 
-		pmc->eventsel = (intel_arch_events[event].unit_mask << 8) |
-				 intel_arch_events[event].eventsel;
+		pmc->eventsel = (fixed_pmc_events[index].unit_mask << 8) |
+				 fixed_pmc_events[index].eventsel;
 	}
 }
 
-- 
2.42.0.869.gea05f2083d-goog

