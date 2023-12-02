Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD980188E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442121AbjLBAFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441988AbjLBAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:07 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26A1FCE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:52 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so1287368a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475491; x=1702080291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pFreupbkDM72Lg9VXbt3uhD5eL3MlA+w2z7WkHNK64w=;
        b=cx9jtUmQ/itREeQ3zPZ6HEhY1Ji/eRVx+NxlEUsaKcesbnzji0eEvYKLietWzyYs0j
         68hfxRvv3ObPtqHtiKHTvQO14v58R3pwhKJfWnU3EMrRKvdQ+vAgRpZFzoq4V8wH7/Z0
         YLEU7FgvPMNUCA1VYcUxcluULrEIe+deB9SnNLAhu2PBPFKRei5W2gB/beYWy35/1IPw
         NoeGlrVoBLt55maDLScOyx55J4Wu6qw+g4WZ/8cVvpzOBrqxES2vz6utSJWTbkVNAxcg
         0Cqbe4QOufisdSyQSsbgNwjRxRjOEVsY7v/YceEPEBEtvKEUo9dpf+0WSreX13JPDNn9
         PzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475491; x=1702080291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFreupbkDM72Lg9VXbt3uhD5eL3MlA+w2z7WkHNK64w=;
        b=kv+klpg2QXzXDbNYiYMzikJOy2zUOFnWTJdTOILFpyRwJ2i44RLGXCM7AgfQzQSisG
         378p/olK+yXKQXk2oIvQLrD8VN6n7Y8et/mLuLlqxJaMBBTAzQVmnGZAbxAAEGyzefjl
         5ojfYt43z5rl08E/L1VxRETCT1QYroP/Y0n+MxhKcEwNmCQrdg9uImSgnKE3Zd+Xlfwr
         rTkWP2zdBuOApGk4JOkhMwWiuaNEZtMZ5dk44nHnic8gCDEXhLl7WvlrBH++m3DtpGm2
         l/o3DXl/QMfG+83UqEs1AQ0emVDLaEk/Z5bCJbUvY2JlUzQXCopCgsVr86W/Z2kAYJ3V
         tsug==
X-Gm-Message-State: AOJu0YzlkKKx9HSlPX6Q63c7UFHzuRjrQL+35B39dQDAidGlxjBCPoXJ
        Hep227siRhH0/ogDETVLks+liX6cXOQ=
X-Google-Smtp-Source: AGHT+IEubbDPtMfnKUKT3StWcq1d1UbQ5gQgTTOpqeK44obHj7WNiHuJSFhy1OBm3lpRBRwoo0hv8AICwGw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:f146:0:b0:5c6:5f11:4d82 with SMTP id
 o6-20020a63f146000000b005c65f114d82mr26268pgk.12.1701475491490; Fri, 01 Dec
 2023 16:04:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:05 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-17-seanjc@google.com>
Subject: [PATCH v9 16/28] KVM: selftests: Test Intel PMU architectural events
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

From: Jinrong Liang <cloudliang@tencent.com>

Extend the PMU counters test to validate architectural events using fixed
counters.  The core logic is largely the same, the biggest difference
being that if a fixed counter exists, its associated event is available
(the SDM doesn't explicitly state this to be true, but it's KVM's ABI and
letting software program a fixed counter that doesn't actually count would
be quite bizarre).

Note, fixed counters rely on PERF_GLOBAL_CTRL.

Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 54 +++++++++++++++----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 5b8687bb4639..663e8fbe7ff8 100644
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
+	__guest_test_arch_event(idx, fixed_event, i | INTEL_RDPMC_FIXED,
+				MSR_CORE_PERF_FIXED_CTR0 + i,
+				MSR_CORE_PERF_GLOBAL_CTRL,
+				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
 }
 
 static void guest_test_arch_events(void)
-- 
2.43.0.rc2.451.g8631bc7472-goog

