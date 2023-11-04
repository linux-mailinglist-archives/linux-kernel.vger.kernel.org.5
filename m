Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C78F7E0C8A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjKDADb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjKDADH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:03:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6BB10C7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:03:02 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso20498015ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056181; x=1699660981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=huxX/xt+b9dPHfuMpHR5dh+UJzcxoKeSK8eYFJnQY04=;
        b=xyWlo+0PhDtyZBfITYk1h+NiUbcJlkmoXY7aNJO0GYNnJYonbNcZqCLrmzbG0ShycX
         cFsFpC85m89eHUXRtRhrTlYbfCQje4Xxs4mApvouuKRzz8otwv1XJK9iDI5cQEGw8TRJ
         vUD0rfzI6F6ZQRswQvQDbIGd/xcNBQP4FsHtCALMSxPRKdQ2K/8uJJmydUOpvTUK1CW2
         JMDQ4YQuo17Jf09Yg8LLPF149noJA4jN3f8j2ZKMdLTwIs+xo5xuv26fSOQmml3ZAlKg
         SwKjL9j9DLbV6LO2CFHHRNtdxokBJDiKl3niVQ3ZrswB2/AWqVU5Ly7szIkBoDQYteKl
         vBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056181; x=1699660981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huxX/xt+b9dPHfuMpHR5dh+UJzcxoKeSK8eYFJnQY04=;
        b=eq5yXQc1XXmdEpdnGhqyzQxgnRDpceBeVd5FT9cZvFCTUvgjXyX5irRh+d9KCXYXNe
         2zI05A2c6cpTHcfG1SWt68mqU5PgDqDc6GFSBf7u01d/1hr63/uM36aI7fQZQxj23W7l
         jqfvg8iHLX+KleafgMlFOLbjHBjHhkmne6mFjwg8G2ZZB/u4sSdr2q9syU7HnaGbOT14
         bA4If+48wYj8Q3byEosu7nxofZP9OChJ0+zAZY7novs3UHm66acDAE7spFc/m6wd5qYd
         1cJuuK1p+bm2GdxMCGVMUo0Zsm8Q9fY7OkZl8C6ObvDIAes8FoG+BsvH4g9FQWyAvFzT
         1cDw==
X-Gm-Message-State: AOJu0Yyboc0Dwa9VkntckP5YS2Xbte9jKAP1WcoTMUsBxgCh6ASVXiuo
        lZpddenMMqL4xXJiq6sGXJeXqxjnCKw=
X-Google-Smtp-Source: AGHT+IFB1K09JzPWaQ59nalHXl5/iog4zxKzuE/c4guWe8d0N5OC3W/euaS1KW35bpmUHU00WC2Y0XCYMKY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efd1:b0:1c6:2b9d:570b with SMTP id
 ja17-20020a170902efd100b001c62b9d570bmr414318plb.7.1699056181585; Fri, 03 Nov
 2023 17:03:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:29 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-12-seanjc@google.com>
Subject: [PATCH v6 11/20] KVM: selftests: Test Intel PMU architectural events
 on fixed counters
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Co-developed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 53 ++++++++++++++++---
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index dd9a7864410c..4d3a5c94b8ba 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -150,25 +150,46 @@ static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feature even
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
-		[INTEL_ARCH_CPU_CYCLES]		   = { X86_PMU_FEATURE_CPU_CYCLES },
-		[INTEL_ARCH_INSTRUCTIONS_RETIRED]  = { X86_PMU_FEATURE_INSNS_RETIRED },
-		[INTEL_ARCH_REFERENCE_CYCLES]	   = { X86_PMU_FEATURE_REFERENCE_CYCLES },
-		[INTEL_ARCH_LLC_REFERENCES]	   = { X86_PMU_FEATURE_LLC_REFERENCES },
-		[INTEL_ARCH_LLC_MISSES]		   = { X86_PMU_FEATURE_LLC_MISSES },
-		[INTEL_ARCH_BRANCHES_RETIRED]	   = { X86_PMU_FEATURE_BRANCH_INSNS_RETIRED },
-		[INTEL_ARCH_BRANCHES_MISPREDICTED] = { X86_PMU_FEATURE_BRANCHES_MISPREDICTED },
+		[INTEL_ARCH_CPU_CYCLES]		   = { X86_PMU_FEATURE_CPU_CYCLES, X86_PMU_FEATURE_CPU_CYCLES_FIXED },
+		[INTEL_ARCH_INSTRUCTIONS_RETIRED]  = { X86_PMU_FEATURE_INSNS_RETIRED, X86_PMU_FEATURE_INSNS_RETIRED_FIXED },
+		/*
+		 * Note, the fixed counter for reference cycles is NOT the same
+		 * as the general purpose architectural event (because the GP
+		 * event is garbage).  The fixed counter explicitly counts at
+		 * the same frequency as the TSC, whereas the GP event counts
+		 * at a fixed, but uarch specific, frequency.  Bundle them here
+		 * for simplicity.
+		 */
+		[INTEL_ARCH_REFERENCE_CYCLES]	   = { X86_PMU_FEATURE_REFERENCE_CYCLES, X86_PMU_FEATURE_REFERENCE_CYCLES_FIXED },
+		[INTEL_ARCH_LLC_REFERENCES]	   = { X86_PMU_FEATURE_LLC_REFERENCES, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_LLC_MISSES]		   = { X86_PMU_FEATURE_LLC_MISSES, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_BRANCHES_RETIRED]	   = { X86_PMU_FEATURE_BRANCH_INSNS_RETIRED, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_BRANCHES_MISPREDICTED] = { X86_PMU_FEATURE_BRANCHES_MISPREDICTED, X86_PMU_FEATURE_NULL },
 	};
 
 	uint32_t nr_gp_counters = this_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 	uint32_t pmu_version = guest_get_pmu_version();
 	/* PERF_GLOBAL_CTRL exists only for Architectural PMU Version 2+. */
 	bool guest_has_perf_global_ctrl = pmu_version >= 2;
-	struct kvm_x86_pmu_feature gp_event;
+	struct kvm_x86_pmu_feature gp_event, fixed_event;
 	uint32_t base_pmc_msr;
 	unsigned int i;
 
@@ -198,6 +219,22 @@ static void guest_test_arch_event(uint8_t idx)
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
+	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, BIT_ULL(4 * i));
+
+	__guest_test_arch_event(idx, fixed_event, PMC_FIXED_RDPMC_BASE | i,
+				MSR_CORE_PERF_FIXED_CTR0 + i,
+				MSR_CORE_PERF_GLOBAL_CTRL,
+				BIT_ULL(PMC_IDX_FIXED + i));
 }
 
 static void guest_test_arch_events(void)
-- 
2.42.0.869.gea05f2083d-goog

