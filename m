Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0770F801891
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442070AbjLBAFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441967AbjLBAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:04 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA051FC1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:48 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c604d8e6f5so1263955a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475487; x=1702080287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yZvyyTmwornriWdLtRjQlfOBoGaPzHCKDTz+hdibijw=;
        b=nRV1abZ4QsxgupBup6Czor7mchZx+eHelfbC/go7cB9vhpxKHsPmynGwwbJ/k9p3BA
         KsPz8M5de3V0kxuolgIpw6tA2LJk1ciHXY60ud7gFUpPxCHWEkB9yg8vkHRcrk/Hxoel
         lV74U1hB8CNiImITS8+R/YIaRsHm7jL8IRVO1rlQRUoaMkqDupYKBwUNHWERJjjxClUz
         Ow7tuy3WIqHsomVja1tQDhqI30qWzLB6i2RVYFSfqbvpgdMFa2ilGAcDjoj8Wo55zdO/
         nL61ABl01vS23wgEMqMMzQyrcqdIq9l/ahPeEq+jOOfuMZSpBi5EjDZJUWhhw60C9R1D
         aBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475487; x=1702080287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZvyyTmwornriWdLtRjQlfOBoGaPzHCKDTz+hdibijw=;
        b=mdj/1Be6t+JQXJmCvyznHJrNddNDvFNOmHGUAEl8W46l0pftN68HNkRIXYKATM0NUv
         qBYdqV5qIrVgw9SQPNneffLJmygKuTGrqVyojqCZ2e3PE0VPbgJ9bR6M6EhWu4o54Mck
         sdTsyftpmYeYLhR4oBrR2lDkrMzd98riY93dkHm1CJEG0UF7deaTiNmsmSbFWz5W6ytn
         oPdVftcxLncUz34heJcQNfoSJqrHZd0FblS5+vqMYggaIJrjN2caiQ+YuE2oU8UEkPE8
         OnsoXt77N/zy1uBW1RSMet7UHCnh1+1WB0AhaQ6e/c+Cn3ryENnW8ldSClssFgBG4SXE
         Qdtg==
X-Gm-Message-State: AOJu0YyprggmjWUfh9k7IzOTD2lRgNiQ2Ic9TwqxPQxNESq0noOfbuB0
        dSy0i0A2upvSrPddI87GgnJ/i2NAVoE=
X-Google-Smtp-Source: AGHT+IFqbPa1EIs0K+9PGASzx2R6LvxNgZMGpzJ8HojJYQDKNxBJJ0a5YXYBVtODu5hdIjqYCH0W0Ges3AA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:481a:0:b0:585:6402:41e4 with SMTP id
 v26-20020a63481a000000b00585640241e4mr3922225pga.7.1701475487679; Fri, 01 Dec
 2023 16:04:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:03 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-15-seanjc@google.com>
Subject: [PATCH v9 14/28] KVM: selftests: Add pmu.h and lib/pmu.c for common
 PMU assets
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add a PMU library for x86 selftests to help eliminate open-coded event
encodings, and to reduce the amount of copy+paste between PMU selftests.

Use the new common macro definitions in the existing PMU event filter test.

Cc: Aaron Lewis <aaronlewis@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/include/pmu.h     |  97 ++++++++++++
 tools/testing/selftests/kvm/lib/pmu.c         |  31 ++++
 .../kvm/x86_64/pmu_event_filter_test.c        | 141 ++++++------------
 4 files changed, 173 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/pmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/pmu.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4412b42d95de..ccc354882d1a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,6 +32,7 @@ LIBKVM += lib/guest_modes.c
 LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
 LIBKVM += lib/memstress.c
+LIBKVM += lib/pmu.c
 LIBKVM += lib/guest_sprintf.c
 LIBKVM += lib/rbtree.c
 LIBKVM += lib/sparsebit.c
diff --git a/tools/testing/selftests/kvm/include/pmu.h b/tools/testing/selftests/kvm/include/pmu.h
new file mode 100644
index 000000000000..3c10c4dc0ae8
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/pmu.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023, Tencent, Inc.
+ */
+#ifndef SELFTEST_KVM_PMU_H
+#define SELFTEST_KVM_PMU_H
+
+#include <stdint.h>
+
+#define KVM_PMU_EVENT_FILTER_MAX_EVENTS			300
+
+/*
+ * Encode an eventsel+umask pair into event-select MSR format.  Note, this is
+ * technically AMD's format, as Intel's format only supports 8 bits for the
+ * event selector, i.e. doesn't use bits 24:16 for the selector.  But, OR-ing
+ * in '0' is a nop and won't clobber the CMASK.
+ */
+#define RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) |	\
+				    ((eventsel) & 0xff) |		\
+				    ((umask) & 0xff) << 8)
+
+/*
+ * These are technically Intel's definitions, but except for CMASK (see above),
+ * AMD's layout is compatible with Intel's.
+ */
+#define ARCH_PERFMON_EVENTSEL_EVENT		GENMASK_ULL(7, 0)
+#define ARCH_PERFMON_EVENTSEL_UMASK		GENMASK_ULL(15, 8)
+#define ARCH_PERFMON_EVENTSEL_USR		BIT_ULL(16)
+#define ARCH_PERFMON_EVENTSEL_OS		BIT_ULL(17)
+#define ARCH_PERFMON_EVENTSEL_EDGE		BIT_ULL(18)
+#define ARCH_PERFMON_EVENTSEL_PIN_CONTROL	BIT_ULL(19)
+#define ARCH_PERFMON_EVENTSEL_INT		BIT_ULL(20)
+#define ARCH_PERFMON_EVENTSEL_ANY		BIT_ULL(21)
+#define ARCH_PERFMON_EVENTSEL_ENABLE		BIT_ULL(22)
+#define ARCH_PERFMON_EVENTSEL_INV		BIT_ULL(23)
+#define ARCH_PERFMON_EVENTSEL_CMASK		GENMASK_ULL(31, 24)
+
+/* RDPMC control flags, Intel only. */
+#define INTEL_RDPMC_METRICS			BIT_ULL(29)
+#define INTEL_RDPMC_FIXED			BIT_ULL(30)
+#define INTEL_RDPMC_FAST			BIT_ULL(31)
+
+/* Fixed PMC controls, Intel only. */
+#define FIXED_PMC_GLOBAL_CTRL_ENABLE(_idx)	BIT_ULL((32 + (_idx)))
+
+#define FIXED_PMC_KERNEL			BIT_ULL(0)
+#define FIXED_PMC_USER				BIT_ULL(1)
+#define FIXED_PMC_ANYTHREAD			BIT_ULL(2)
+#define FIXED_PMC_ENABLE_PMI			BIT_ULL(3)
+#define FIXED_PMC_NR_BITS			4
+#define FIXED_PMC_CTRL(_idx, _val)		((_val) << ((_idx) * FIXED_PMC_NR_BITS))
+
+#define PMU_CAP_FW_WRITES			BIT_ULL(13)
+#define PMU_CAP_LBR_FMT				0x3f
+
+#define	INTEL_ARCH_CPU_CYCLES			RAW_EVENT(0x3c, 0x00)
+#define	INTEL_ARCH_INSTRUCTIONS_RETIRED		RAW_EVENT(0xc0, 0x00)
+#define	INTEL_ARCH_REFERENCE_CYCLES		RAW_EVENT(0x3c, 0x01)
+#define	INTEL_ARCH_LLC_REFERENCES		RAW_EVENT(0x2e, 0x4f)
+#define	INTEL_ARCH_LLC_MISSES			RAW_EVENT(0x2e, 0x41)
+#define	INTEL_ARCH_BRANCHES_RETIRED		RAW_EVENT(0xc4, 0x00)
+#define	INTEL_ARCH_BRANCHES_MISPREDICTED	RAW_EVENT(0xc5, 0x00)
+#define	INTEL_ARCH_TOPDOWN_SLOTS		RAW_EVENT(0xa4, 0x01)
+
+#define	AMD_ZEN_CORE_CYCLES			RAW_EVENT(0x76, 0x00)
+#define	AMD_ZEN_INSTRUCTIONS_RETIRED		RAW_EVENT(0xc0, 0x00)
+#define	AMD_ZEN_BRANCHES_RETIRED		RAW_EVENT(0xc2, 0x00)
+#define	AMD_ZEN_BRANCHES_MISPREDICTED		RAW_EVENT(0xc3, 0x00)
+
+/*
+ * Note!  The order and thus the index of the architectural events matters as
+ * support for each event is enumerated via CPUID using the index of the event.
+ */
+enum intel_pmu_architectural_events {
+	INTEL_ARCH_CPU_CYCLES_INDEX,
+	INTEL_ARCH_INSTRUCTIONS_RETIRED_INDEX,
+	INTEL_ARCH_REFERENCE_CYCLES_INDEX,
+	INTEL_ARCH_LLC_REFERENCES_INDEX,
+	INTEL_ARCH_LLC_MISSES_INDEX,
+	INTEL_ARCH_BRANCHES_RETIRED_INDEX,
+	INTEL_ARCH_BRANCHES_MISPREDICTED_INDEX,
+	INTEL_ARCH_TOPDOWN_SLOTS_INDEX,
+	NR_INTEL_ARCH_EVENTS,
+};
+
+enum amd_pmu_zen_events {
+	AMD_ZEN_CORE_CYCLES_INDEX,
+	AMD_ZEN_INSTRUCTIONS_INDEX,
+	AMD_ZEN_BRANCHES_INDEX,
+	AMD_ZEN_BRANCH_MISSES_INDEX,
+	NR_AMD_ZEN_EVENTS,
+};
+
+extern const uint64_t intel_pmu_arch_events[];
+extern const uint64_t amd_pmu_zen_events[];
+
+#endif /* SELFTEST_KVM_PMU_H */
diff --git a/tools/testing/selftests/kvm/lib/pmu.c b/tools/testing/selftests/kvm/lib/pmu.c
new file mode 100644
index 000000000000..f31f0427c17c
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/pmu.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Tencent, Inc.
+ */
+
+#include <stdint.h>
+
+#include <linux/kernel.h>
+
+#include "kvm_util.h"
+#include "pmu.h"
+
+const uint64_t intel_pmu_arch_events[] = {
+	INTEL_ARCH_CPU_CYCLES,
+	INTEL_ARCH_INSTRUCTIONS_RETIRED,
+	INTEL_ARCH_REFERENCE_CYCLES,
+	INTEL_ARCH_LLC_REFERENCES,
+	INTEL_ARCH_LLC_MISSES,
+	INTEL_ARCH_BRANCHES_RETIRED,
+	INTEL_ARCH_BRANCHES_MISPREDICTED,
+	INTEL_ARCH_TOPDOWN_SLOTS,
+};
+kvm_static_assert(ARRAY_SIZE(intel_pmu_arch_events) == NR_INTEL_ARCH_EVENTS);
+
+const uint64_t amd_pmu_zen_events[] = {
+	AMD_ZEN_CORE_CYCLES,
+	AMD_ZEN_INSTRUCTIONS_RETIRED,
+	AMD_ZEN_BRANCHES_RETIRED,
+	AMD_ZEN_BRANCHES_MISPREDICTED,
+};
+kvm_static_assert(ARRAY_SIZE(amd_pmu_zen_events) == NR_AMD_ZEN_EVENTS);
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 283cc55597a4..7ec9fbed92e0 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -11,72 +11,18 @@
  */
 
 #define _GNU_SOURCE /* for program_invocation_short_name */
-#include "test_util.h"
+
 #include "kvm_util.h"
+#include "pmu.h"
 #include "processor.h"
-
-/*
- * In lieu of copying perf_event.h into tools...
- */
-#define ARCH_PERFMON_EVENTSEL_OS			(1ULL << 17)
-#define ARCH_PERFMON_EVENTSEL_ENABLE			(1ULL << 22)
-
-/* End of stuff taken from perf_event.h. */
-
-/* Oddly, this isn't in perf_event.h. */
-#define ARCH_PERFMON_BRANCHES_RETIRED		5
+#include "test_util.h"
 
 #define NUM_BRANCHES 42
-#define INTEL_PMC_IDX_FIXED		32
-
-/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
-#define MAX_FILTER_EVENTS		300
 #define MAX_TEST_EVENTS		10
 
 #define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
 #define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAGS_VALID_MASK << 1)
-#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
-
-/*
- * This is how the event selector and unit mask are stored in an AMD
- * core performance event-select register. Intel's format is similar,
- * but the event selector is only 8 bits.
- */
-#define EVENT(select, umask) ((select & 0xf00UL) << 24 | (select & 0xff) | \
-			      (umask & 0xff) << 8)
-
-/*
- * "Branch instructions retired", from the Intel SDM, volume 3,
- * "Pre-defined Architectural Performance Events."
- */
-
-#define INTEL_BR_RETIRED EVENT(0xc4, 0)
-
-/*
- * "Retired branch instructions", from Processor Programming Reference
- * (PPR) for AMD Family 17h Model 01h, Revision B1 Processors,
- * Preliminary Processor Programming Reference (PPR) for AMD Family
- * 17h Model 31h, Revision B0 Processors, and Preliminary Processor
- * Programming Reference (PPR) for AMD Family 19h Model 01h, Revision
- * B1 Processors Volume 1 of 2.
- */
-
-#define AMD_ZEN_BR_RETIRED EVENT(0xc2, 0)
-
-
-/*
- * "Retired instructions", from Processor Programming Reference
- * (PPR) for AMD Family 17h Model 01h, Revision B1 Processors,
- * Preliminary Processor Programming Reference (PPR) for AMD Family
- * 17h Model 31h, Revision B0 Processors, and Preliminary Processor
- * Programming Reference (PPR) for AMD Family 19h Model 01h, Revision
- * B1 Processors Volume 1 of 2.
- *                      --- and ---
- * "Instructions retired", from the Intel SDM, volume 3,
- * "Pre-defined Architectural Performance Events."
- */
-
-#define INST_RETIRED EVENT(0xc0, 0)
+#define PMU_EVENT_FILTER_INVALID_NEVENTS		(KVM_PMU_EVENT_FILTER_MAX_EVENTS + 1)
 
 struct __kvm_pmu_event_filter {
 	__u32 action;
@@ -84,26 +30,28 @@ struct __kvm_pmu_event_filter {
 	__u32 fixed_counter_bitmap;
 	__u32 flags;
 	__u32 pad[4];
-	__u64 events[MAX_FILTER_EVENTS];
+	__u64 events[KVM_PMU_EVENT_FILTER_MAX_EVENTS];
 };
 
 /*
- * This event list comprises Intel's eight architectural events plus
- * AMD's "retired branch instructions" for Zen[123] (and possibly
- * other AMD CPUs).
+ * This event list comprises Intel's known architectural events, plus AMD's
+ * "retired branch instructions" for Zen1-Zen3 (and* possibly other AMD CPUs).
+ * Note, AMD and Intel use the same encoding for instructions retired.
  */
+kvm_static_assert(INTEL_ARCH_INSTRUCTIONS_RETIRED == AMD_ZEN_INSTRUCTIONS_RETIRED);
+
 static const struct __kvm_pmu_event_filter base_event_filter = {
 	.nevents = ARRAY_SIZE(base_event_filter.events),
 	.events = {
-		EVENT(0x3c, 0),
-		INST_RETIRED,
-		EVENT(0x3c, 1),
-		EVENT(0x2e, 0x4f),
-		EVENT(0x2e, 0x41),
-		EVENT(0xc4, 0),
-		EVENT(0xc5, 0),
-		EVENT(0xa4, 1),
-		AMD_ZEN_BR_RETIRED,
+		INTEL_ARCH_CPU_CYCLES,
+		INTEL_ARCH_INSTRUCTIONS_RETIRED,
+		INTEL_ARCH_REFERENCE_CYCLES,
+		INTEL_ARCH_LLC_REFERENCES,
+		INTEL_ARCH_LLC_MISSES,
+		INTEL_ARCH_BRANCHES_RETIRED,
+		INTEL_ARCH_BRANCHES_MISPREDICTED,
+		INTEL_ARCH_TOPDOWN_SLOTS,
+		AMD_ZEN_BRANCHES_RETIRED,
 	},
 };
 
@@ -165,9 +113,9 @@ static void intel_guest_code(void)
 	for (;;) {
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 		wrmsr(MSR_P6_EVNTSEL0, ARCH_PERFMON_EVENTSEL_ENABLE |
-		      ARCH_PERFMON_EVENTSEL_OS | INTEL_BR_RETIRED);
+		      ARCH_PERFMON_EVENTSEL_OS | INTEL_ARCH_BRANCHES_RETIRED);
 		wrmsr(MSR_P6_EVNTSEL1, ARCH_PERFMON_EVENTSEL_ENABLE |
-		      ARCH_PERFMON_EVENTSEL_OS | INST_RETIRED);
+		      ARCH_PERFMON_EVENTSEL_OS | INTEL_ARCH_INSTRUCTIONS_RETIRED);
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0x3);
 
 		run_and_measure_loop(MSR_IA32_PMC0);
@@ -189,9 +137,9 @@ static void amd_guest_code(void)
 	for (;;) {
 		wrmsr(MSR_K7_EVNTSEL0, 0);
 		wrmsr(MSR_K7_EVNTSEL0, ARCH_PERFMON_EVENTSEL_ENABLE |
-		      ARCH_PERFMON_EVENTSEL_OS | AMD_ZEN_BR_RETIRED);
+		      ARCH_PERFMON_EVENTSEL_OS | AMD_ZEN_BRANCHES_RETIRED);
 		wrmsr(MSR_K7_EVNTSEL1, ARCH_PERFMON_EVENTSEL_ENABLE |
-		      ARCH_PERFMON_EVENTSEL_OS | INST_RETIRED);
+		      ARCH_PERFMON_EVENTSEL_OS | AMD_ZEN_INSTRUCTIONS_RETIRED);
 
 		run_and_measure_loop(MSR_K7_PERFCTR0);
 		GUEST_SYNC(0);
@@ -312,7 +260,7 @@ static void test_amd_deny_list(struct kvm_vcpu *vcpu)
 		.action = KVM_PMU_EVENT_DENY,
 		.nevents = 1,
 		.events = {
-			EVENT(0x1C2, 0),
+			RAW_EVENT(0x1C2, 0),
 		},
 	};
 
@@ -347,9 +295,9 @@ static void test_not_member_deny_list(struct kvm_vcpu *vcpu)
 
 	f.action = KVM_PMU_EVENT_DENY;
 
-	remove_event(&f, INST_RETIRED);
-	remove_event(&f, INTEL_BR_RETIRED);
-	remove_event(&f, AMD_ZEN_BR_RETIRED);
+	remove_event(&f, INTEL_ARCH_INSTRUCTIONS_RETIRED);
+	remove_event(&f, INTEL_ARCH_BRANCHES_RETIRED);
+	remove_event(&f, AMD_ZEN_BRANCHES_RETIRED);
 	test_with_filter(vcpu, &f);
 
 	ASSERT_PMC_COUNTING_INSTRUCTIONS();
@@ -361,9 +309,9 @@ static void test_not_member_allow_list(struct kvm_vcpu *vcpu)
 
 	f.action = KVM_PMU_EVENT_ALLOW;
 
-	remove_event(&f, INST_RETIRED);
-	remove_event(&f, INTEL_BR_RETIRED);
-	remove_event(&f, AMD_ZEN_BR_RETIRED);
+	remove_event(&f, INTEL_ARCH_INSTRUCTIONS_RETIRED);
+	remove_event(&f, INTEL_ARCH_BRANCHES_RETIRED);
+	remove_event(&f, AMD_ZEN_BRANCHES_RETIRED);
 	test_with_filter(vcpu, &f);
 
 	ASSERT_PMC_NOT_COUNTING_INSTRUCTIONS();
@@ -452,9 +400,9 @@ static bool use_amd_pmu(void)
  *  - Sapphire Rapids, Ice Lake, Cascade Lake, Skylake.
  */
 #define MEM_INST_RETIRED		0xD0
-#define MEM_INST_RETIRED_LOAD		EVENT(MEM_INST_RETIRED, 0x81)
-#define MEM_INST_RETIRED_STORE		EVENT(MEM_INST_RETIRED, 0x82)
-#define MEM_INST_RETIRED_LOAD_STORE	EVENT(MEM_INST_RETIRED, 0x83)
+#define MEM_INST_RETIRED_LOAD		RAW_EVENT(MEM_INST_RETIRED, 0x81)
+#define MEM_INST_RETIRED_STORE		RAW_EVENT(MEM_INST_RETIRED, 0x82)
+#define MEM_INST_RETIRED_LOAD_STORE	RAW_EVENT(MEM_INST_RETIRED, 0x83)
 
 static bool supports_event_mem_inst_retired(void)
 {
@@ -486,9 +434,9 @@ static bool supports_event_mem_inst_retired(void)
  * B1 Processors Volume 1 of 2.
  */
 #define LS_DISPATCH		0x29
-#define LS_DISPATCH_LOAD	EVENT(LS_DISPATCH, BIT(0))
-#define LS_DISPATCH_STORE	EVENT(LS_DISPATCH, BIT(1))
-#define LS_DISPATCH_LOAD_STORE	EVENT(LS_DISPATCH, BIT(2))
+#define LS_DISPATCH_LOAD	RAW_EVENT(LS_DISPATCH, BIT(0))
+#define LS_DISPATCH_STORE	RAW_EVENT(LS_DISPATCH, BIT(1))
+#define LS_DISPATCH_LOAD_STORE	RAW_EVENT(LS_DISPATCH, BIT(2))
 
 #define INCLUDE_MASKED_ENTRY(event_select, mask, match) \
 	KVM_PMU_ENCODE_MASKED_ENTRY(event_select, mask, match, false)
@@ -729,14 +677,14 @@ static void add_dummy_events(uint64_t *events, int nevents)
 
 static void test_masked_events(struct kvm_vcpu *vcpu)
 {
-	int nevents = MAX_FILTER_EVENTS - MAX_TEST_EVENTS;
-	uint64_t events[MAX_FILTER_EVENTS];
+	int nevents = KVM_PMU_EVENT_FILTER_MAX_EVENTS - MAX_TEST_EVENTS;
+	uint64_t events[KVM_PMU_EVENT_FILTER_MAX_EVENTS];
 
 	/* Run the test cases against a sparse PMU event filter. */
 	run_masked_events_tests(vcpu, events, 0);
 
 	/* Run the test cases against a dense PMU event filter. */
-	add_dummy_events(events, MAX_FILTER_EVENTS);
+	add_dummy_events(events, KVM_PMU_EVENT_FILTER_MAX_EVENTS);
 	run_masked_events_tests(vcpu, events, nevents);
 }
 
@@ -809,20 +757,19 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 	TEST_ASSERT(!r, "Masking non-existent fixed counters should be allowed");
 }
 
-static void intel_run_fixed_counter_guest_code(uint8_t fixed_ctr_idx)
+static void intel_run_fixed_counter_guest_code(uint8_t idx)
 {
 	for (;;) {
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
-		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx, 0);
+		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + idx, 0);
 
 		/* Only OS_EN bit is enabled for fixed counter[idx]. */
-		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, BIT_ULL(4 * fixed_ctr_idx));
-		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL,
-		      BIT_ULL(INTEL_PMC_IDX_FIXED + fixed_ctr_idx));
+		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(idx, FIXED_PMC_KERNEL));
+		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, FIXED_PMC_GLOBAL_CTRL_ENABLE(idx));
 		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 
-		GUEST_SYNC(rdmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx));
+		GUEST_SYNC(rdmsr(MSR_CORE_PERF_FIXED_CTR0 + idx));
 	}
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

