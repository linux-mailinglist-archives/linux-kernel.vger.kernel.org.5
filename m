Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234057E4E14
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjKHAc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjKHAcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:32:10 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2945C199C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:00 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af592fed43so74641047b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403520; x=1700008320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=694GN2yhKF8CrRVn5s3EqhYau/KZr9xDvX1ZDohDyv0=;
        b=Syp0sL31YLpOc/hFnopDkEgW6HeDPFFnq4boVIw6hL9Qy35bcCXtIgK8eV6TvSUjGP
         uPtapynzbQyakDWARLHRbsiawMraCM/rnBCuIayeGojOc2CTG900BMGNy7bIBM2Gm/c4
         ufPSLBd5JBkHM8V/y+FeiM869Qoh4LKcJ7qcq28sTwD6wCBZFVZgamvJqkQw0VLBTQz2
         u2HNybCPjG8h+F+o7U6JX9agm4jaHUuRFTa+RpPAc3mmP4nEDp/kGj5cqIQud0MMw9fN
         Qg6VKQX/2/odGU7YjzrEisSjjqTABl1EWVpB2Q/+Zd6PzKl/Rg42o2OMKYeOc/mbEm+5
         9GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403520; x=1700008320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=694GN2yhKF8CrRVn5s3EqhYau/KZr9xDvX1ZDohDyv0=;
        b=Ltk9eNbTszTjZWfUxoIYI4L+gO6/M6ufpqhE1SyJl+gYDhPQQSTurpPhwfNwmzN9s1
         lI8mURw7h0eEfIRkIKy/C86Wa0kfVNtT1L7jJPdGPKQhvfSuvGPpAmLJL0IGlTkVYTCd
         usXiuIWyWEdEW04hz9NrqEPvdXjy8XUj4PPqefhKIhkrQXp6neOkJNHXy+r7vbSbmCvy
         /LoqRRqrD5upzwnFCVXMv/EPutlrv001+SdOK6gRdYIHgGGsMRtg6xKEhCxIuzp5bpBz
         FJOJm+1vqGJQ7wb8NM/eiHsc/E+Qv/HXEwyL5DOnZ5jfsP3aM29tF7SwzsSud9OVHm5u
         BkDA==
X-Gm-Message-State: AOJu0Yy8qXmdFSVKWOJnLrGrdp9wAtM9036IexJrjJosbq6QzPw5Lj/H
        K1Te+vTlZW3nS+DWPioHW3Ka50H+6cc=
X-Google-Smtp-Source: AGHT+IH1A3kK5hDcQh/ShzUyxBZkRIs3Y4YH8rWv6hCkghiliOQWrqcnbdaqZTFnJEPKP14s5nejlCCYGbc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ebca:0:b0:5a7:acc1:5142 with SMTP id
 u193-20020a0debca000000b005a7acc15142mr4020ywe.8.1699403519923; Tue, 07 Nov
 2023 16:31:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:26 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-11-seanjc@google.com>
Subject: [PATCH v7 10/19] KVM: selftests: Test Intel PMU architectural events
 on fixed counters
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

From: Jinrong Liang <cloudliang@tencent.com>

Extend the PMU counters test to validate architectural events using fixed
counters.  The core logic is largely the same, the biggest difference
being that if a fixed counter exists, its associated event is available
(the SDM doesn't explicitly state this to be true, but it's KVM's ABI and
letting software program a fixed counter that doesn't actually count would
be quite bizarre).

Note, fixed counters rely on PERF_GLOBAL_CTRL.

Reviewed-by: Jim Mattson <jmattson@google.com>
Co-developed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 54 +++++++++++++++----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 5b8687bb4639..9cd308417aeb 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -150,26 +150,46 @@ static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feature even
 	guest_assert_event_count(idx, event, pmc, pmc_msr);
 }
 
+#define X86_PMU_FEATURE_NULL						\
+({									\
+	struct kvm_x86_pmu_feature feature = {};			\
+									\
+	feature;							\
+})
+
+static bool pmu_is_null_feature(struct kvm_x86_pmu_feature event)
+{
+	return !(*(u64 *)&event);
+}
+
 static void guest_test_arch_event(uint8_t idx)
 {
 	const struct {
 		struct kvm_x86_pmu_feature gp_event;
+		struct kvm_x86_pmu_feature fixed_event;
 	} intel_event_to_feature[] = {
-		[INTEL_ARCH_CPU_CYCLES_INDEX]		 = { X86_PMU_FEATURE_CPU_CYCLES },
-		[INTEL_ARCH_INSTRUCTIONS_RETIRED_INDEX]	 = { X86_PMU_FEATURE_INSNS_RETIRED },
-		[INTEL_ARCH_REFERENCE_CYCLES_INDEX]	 = { X86_PMU_FEATURE_REFERENCE_CYCLES },
-		[INTEL_ARCH_LLC_REFERENCES_INDEX]	 = { X86_PMU_FEATURE_LLC_REFERENCES },
-		[INTEL_ARCH_LLC_MISSES_INDEX]		 = { X86_PMU_FEATURE_LLC_MISSES },
-		[INTEL_ARCH_BRANCHES_RETIRED_INDEX]	 = { X86_PMU_FEATURE_BRANCH_INSNS_RETIRED },
-		[INTEL_ARCH_BRANCHES_MISPREDICTED_INDEX] = { X86_PMU_FEATURE_BRANCHES_MISPREDICTED },
-		[INTEL_ARCH_TOPDOWN_SLOTS_INDEX]	 = { X86_PMU_FEATURE_TOPDOWN_SLOTS },
+		[INTEL_ARCH_CPU_CYCLES_INDEX]		 = { X86_PMU_FEATURE_CPU_CYCLES, X86_PMU_FEATURE_CPU_CYCLES_FIXED },
+		[INTEL_ARCH_INSTRUCTIONS_RETIRED_INDEX]	 = { X86_PMU_FEATURE_INSNS_RETIRED, X86_PMU_FEATURE_INSNS_RETIRED_FIXED },
+		/*
+		 * Note, the fixed counter for reference cycles is NOT the same
+		 * as the general purpose architectural event.  The fixed counter
+		 * explicitly counts at the same frequency as the TSC, whereas
+		 * the GP event counts at a fixed, but uarch specific, frequency.
+		 * Bundle them here for simplicity.
+		 */
+		[INTEL_ARCH_REFERENCE_CYCLES_INDEX]	 = { X86_PMU_FEATURE_REFERENCE_CYCLES, X86_PMU_FEATURE_REFERENCE_TSC_CYCLES_FIXED },
+		[INTEL_ARCH_LLC_REFERENCES_INDEX]	 = { X86_PMU_FEATURE_LLC_REFERENCES, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_LLC_MISSES_INDEX]		 = { X86_PMU_FEATURE_LLC_MISSES, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_BRANCHES_RETIRED_INDEX]	 = { X86_PMU_FEATURE_BRANCH_INSNS_RETIRED, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_BRANCHES_MISPREDICTED_INDEX] = { X86_PMU_FEATURE_BRANCHES_MISPREDICTED, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_TOPDOWN_SLOTS_INDEX]	 = { X86_PMU_FEATURE_TOPDOWN_SLOTS, X86_PMU_FEATURE_TOPDOWN_SLOTS_FIXED },
 	};
 
 	uint32_t nr_gp_counters = this_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 	uint32_t pmu_version = guest_get_pmu_version();
 	/* PERF_GLOBAL_CTRL exists only for Architectural PMU Version 2+. */
 	bool guest_has_perf_global_ctrl = pmu_version >= 2;
-	struct kvm_x86_pmu_feature gp_event;
+	struct kvm_x86_pmu_feature gp_event, fixed_event;
 	uint32_t base_pmc_msr;
 	unsigned int i;
 
@@ -199,6 +219,22 @@ static void guest_test_arch_event(uint8_t idx)
 		__guest_test_arch_event(idx, gp_event, i, base_pmc_msr + i,
 					MSR_P6_EVNTSEL0 + i, eventsel);
 	}
+
+	if (!guest_has_perf_global_ctrl)
+		return;
+
+	fixed_event = intel_event_to_feature[idx].fixed_event;
+	if (pmu_is_null_feature(fixed_event) || !this_pmu_has(fixed_event))
+		return;
+
+	i = fixed_event.f.bit;
+
+	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(i, FIXED_PMC_KERNEL));
+
+	__guest_test_arch_event(idx, fixed_event, FIXED_PMC_RDPMC_BASE + i,
+				MSR_CORE_PERF_FIXED_CTR0 + i,
+				MSR_CORE_PERF_GLOBAL_CTRL,
+				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
 }
 
 static void guest_test_arch_events(void)
-- 
2.42.0.869.gea05f2083d-goog

