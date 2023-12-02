Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC04801890
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442018AbjLBAGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442022AbjLBAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF61993
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d67fc68a82so15662147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475499; x=1702080299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fOdabH/g46d6xRuDOtRpRWQaZjt/LCOBmjBqxWO12uk=;
        b=krHJKKEWTKTYlrI0r903tP8kbXKmN19vwuP3kqy1ptmYLKaUPQ7MZ2+EkEyX2CAbCX
         8zf6mrbWLMYhbv54kI4H2xJ7gGmnEeyZhvg46t0I5yzu1Q0ujdZS6+BORlbIVsbKZXz4
         vsyf0KG28ekR8ldXz7FljvUtf3NTAxz4kuhTYpz6E2x4js24RJ2TK6gjDGMwJ8IjfGug
         vlyoYDfEZ6bptj4l8qk/g/AxaE94oqj/R6CXSe3mQ9A18FbDcNhdlU/nni5RMoLZB04e
         fovlqfYYGp3SCY1j1nLb2JZkxs2ZcB+NRH6vVa60PwP1HLFGNlA7UKTfaFtp/4G/aMyo
         qewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475499; x=1702080299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOdabH/g46d6xRuDOtRpRWQaZjt/LCOBmjBqxWO12uk=;
        b=AjcOy/xbPncPbYC9i64NPWohEfe72Ih66s33OpzAUcBN8DYXKrYn1sdPsVPZFq1TXI
         j7BBTRhxtIdeBa4T7h7JqRo7tEdSZ+HESZryZNmsY9WKQKY9AiNZQODsPBKGOF8n9Ua1
         a7OeIqLnGBJVLDifbJT3s5TZhcN2SiJVg3nBBcRbEZEA6Vr/L5kNUPhUlxzj06k6MrHR
         qi0nuI5doylf4eM8Vac/vwXJU9DPrgaIf7wiYhi15h5epvFGa8elTAu9coKLxiafanSM
         NsgRXgufGE5mc0rgsw4JAVC0pVAGyruO5dCvDvcecLQsrzb16B8KqLO7Bamq2jy/eDnG
         EUdQ==
X-Gm-Message-State: AOJu0YyuyOM8NDSjkd/7YE0/QMYElB+6r2lANXx+auoDH4ajfhot8Npq
        KcbvNlyw8pvRm77WfpdJTT4eWB42I6I=
X-Google-Smtp-Source: AGHT+IEPaZdqGcVV7ptWew9WX6PIrjqI/X5WSqY+KmYPulZfOQ0QklnHkmdCsnSRAhuwu5HT+JsOmSaH7fg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2710:b0:5d5:5183:ebd7 with SMTP id
 dy16-20020a05690c271000b005d55183ebd7mr88949ywb.7.1701475498887; Fri, 01 Dec
 2023 16:04:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:09 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-21-seanjc@google.com>
Subject: [PATCH v9 20/28] KVM: selftests: Expand PMU counters test to verify
 LLC events
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

Expand the PMU counters test to verify that LLC references and misses have
non-zero counts when the code being executed while the LLC event(s) is
active is evicted via CFLUSH{,OPT}.  Note, CLFLUSH{,OPT} requires a fence
of some kind to ensure the cache lines are flushed before execution
continues.  Use MFENCE for simplicity (performance is not a concern).

Suggested-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 59 +++++++++++++------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index f5dedd112471..4c7133ddcda8 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -14,9 +14,9 @@
 /*
  * Number of "extra" instructions that will be counted, i.e. the number of
  * instructions that are needed to set up the loop and then disabled the
- * counter.  2 MOV, 2 XOR, 1 WRMSR.
+ * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
  */
-#define NUM_EXTRA_INSNS		5
+#define NUM_EXTRA_INSNS		7
 #define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
 
 static uint8_t kvm_pmu_version;
@@ -107,6 +107,12 @@ static void guest_assert_event_count(uint8_t idx,
 	case INTEL_ARCH_BRANCHES_RETIRED_INDEX:
 		GUEST_ASSERT_EQ(count, NUM_BRANCHES);
 		break;
+	case INTEL_ARCH_LLC_REFERENCES_INDEX:
+	case INTEL_ARCH_LLC_MISSES_INDEX:
+		if (!this_cpu_has(X86_FEATURE_CLFLUSHOPT) &&
+		    !this_cpu_has(X86_FEATURE_CLFLUSH))
+			break;
+		fallthrough;
 	case INTEL_ARCH_CPU_CYCLES_INDEX:
 	case INTEL_ARCH_REFERENCE_CYCLES_INDEX:
 		GUEST_ASSERT_NE(count, 0);
@@ -123,29 +129,44 @@ static void guest_assert_event_count(uint8_t idx,
 	GUEST_ASSERT_EQ(_rdpmc(pmc), 0xdead);
 }
 
+/*
+ * Enable and disable the PMC in a monolithic asm blob to ensure that the
+ * compiler can't insert _any_ code into the measured sequence.  Note, ECX
+ * doesn't need to be clobbered as the input value, @pmc_msr, is restored
+ * before the end of the sequence.
+ *
+ * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
+ * start of the loop to force LLC references and misses, i.e. to allow testing
+ * that those events actually count.
+ */
+#define GUEST_MEASURE_EVENT(_msr, _value, clflush)				\
+do {										\
+	__asm__ __volatile__("wrmsr\n\t"					\
+			     clflush "\n\t"					\
+			     "mfence\n\t"					\
+			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
+			     "loop .\n\t"					\
+			     "mov %%edi, %%ecx\n\t"				\
+			     "xor %%eax, %%eax\n\t"				\
+			     "xor %%edx, %%edx\n\t"				\
+			     "wrmsr\n\t"					\
+			     :: "a"((uint32_t)_value), "d"(_value >> 32),	\
+				"c"(_msr), "D"(_msr)				\
+	);									\
+} while (0)
+
 static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feature event,
 				    uint32_t pmc, uint32_t pmc_msr,
 				    uint32_t ctrl_msr, uint64_t ctrl_msr_value)
 {
 	wrmsr(pmc_msr, 0);
 
-	/*
-	 * Enable and disable the PMC in a monolithic asm blob to ensure that
-	 * the compiler can't insert _any_ code into the measured sequence.
-	 * Note, ECX doesn't need to be clobbered as the input value, @pmc_msr,
-	 * is restored before the end of the sequence.
-	 */
-	__asm__ __volatile__("wrmsr\n\t"
-			     "mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"
-			     "loop .\n\t"
-			     "mov %%edi, %%ecx\n\t"
-			     "xor %%eax, %%eax\n\t"
-			     "xor %%edx, %%edx\n\t"
-			     "wrmsr\n\t"
-			     :: "a"((uint32_t)ctrl_msr_value),
-				"d"(ctrl_msr_value >> 32),
-				"c"(ctrl_msr), "D"(ctrl_msr)
-			     );
+	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))
+		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflushopt 1f");
+	else if (this_cpu_has(X86_FEATURE_CLFLUSH))
+		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflush 1f");
+	else
+		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "nop");
 
 	guest_assert_event_count(idx, event, pmc, pmc_msr);
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

