Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A707E7737
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345791AbjKJCOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjKJCO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:27 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BD4ED1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:48 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc23f2226bso14962505ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582427; x=1700187227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BVzcnUhnJk6Ozpv5h7yM61YwOo0u+UzthGDzNrYv9nU=;
        b=AL/hLOwt4IfgMnN1sNbGQLOmsXc8OM0u65/b9fqc3zy8CI82dVtu4QcQ4w5LbG+5bG
         Z6yDuP1uxa312iyvLOzuoJMcKsx+4IptjlTARbeV7UqHxCyXPgFBFe7Dk5F1w11ZvMW5
         YBYFwdo91QRs5rwpQ93UuhexVcty2SM7fQv+O1XExYZVOvhuFtCVEXOLF32cNlWk/lRc
         gqbBgTd+4tZGr0qLHCXXk4aJp3P+v27bAt+YB02zFNQ8gryF+fw9/L1iG3AMJPFs3+dB
         38s4m3biQAsFS5Czf6JK1vx+C/ThiHSGjnfzKV6sZtyni4N+VJ4GzaV0BZhVlmD312Tl
         X1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582427; x=1700187227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVzcnUhnJk6Ozpv5h7yM61YwOo0u+UzthGDzNrYv9nU=;
        b=hUSDbWSENccUJdAHPuj9hGYNgRLAvWnVmctjf7oP9cXbjZ21MLYDiqdzX/WWq7xynJ
         a5BR9ojYmdnBTA7KeQkVcUB6LOMHGAiT+lg1FX77oq7pYkEMke0z4cy4gvUPW3+h3RVf
         Ceg9GQJiwGhZ08D9qg1Smo+PzDY/a/jrJDJKYNm9ZeQUTXf28ZUIA0sJsl5guy5tJm63
         QftUlm3Qb5IunXpTBs7eTXDOON7zw0NE8F++ZDmtL8M6DX1eGhyz96oEkR9Yg6+UcB12
         o3uTi1GBduGRN+c016iwcd6pL5W4lsUZh0+sHNAIrZUuxvHmMhtyfMPhv8KhU+6eo/nX
         FJFw==
X-Gm-Message-State: AOJu0Yxf61v9ByHOgZ11P+JcgUk7N29gm0csNPSDCTtp+zRuL9/r7Wi4
        Q4EjdhkCo/GJGDEPFBaAUJT7gWuCDt8=
X-Google-Smtp-Source: AGHT+IG6nYP0Esx4vgDgJes3DQnFwHuI2d5uguFahvO8WZYzbCQTLxnpde62XWqbL4zxqSf1XT5bWwjS0So=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2695:b0:1cc:3c0d:6126 with SMTP id
 jf21-20020a170903269500b001cc3c0d6126mr876759plb.12.1699582427596; Thu, 09
 Nov 2023 18:13:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:58 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-19-seanjc@google.com>
Subject: [PATCH v8 18/26] KVM: selftests: Expand PMU counters test to verify
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
2.42.0.869.gea05f2083d-goog

