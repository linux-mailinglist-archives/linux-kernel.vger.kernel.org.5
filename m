Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4073680188F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441992AbjLBAFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442077AbjLBAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:08 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96461FDB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:53 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cde4ac52bcso3583298b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475493; x=1702080293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J282WTyvzS7K3S/omDGX0Ansb2iBundAXJNpRXXaHcs=;
        b=B3o6tXnitqBRT79Rti4QaY+f5I3F7Dr2mXc9dpwbtkSCL6Uf94LDBur3nE+zFY3bSY
         XfpT2wdFTbyq2adxx56ivGGl8rAvgPio0Gt/VJ2/tGUtYCNMFFvwJV3SjZKFZB5JEVBV
         8jpQ155+CnbtAXrifSqa7EzJ0RZicMcI81zfbM1lwjGirlb9CG+rNYcfepnNXiBHI0K9
         MsSam8ShSEwHj8sEVFGs73DOeLmw+YfjrqgGscsHFBriDuVpR6uuT01xqADqdbZoAd+X
         7bF3XKD4bvlkZdxRAQLBYNNIDic20/TmF4j9GqJ7R3Y+ggBFt9qVguJE3Ne/Z1mr7Tiy
         NPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475493; x=1702080293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J282WTyvzS7K3S/omDGX0Ansb2iBundAXJNpRXXaHcs=;
        b=YRA3WL/w1qUcgfkmJYRXO2yemD6cIjp+Uc17lpszkaHo8s3eHBUHHVR8Vc26jvBGuH
         E5V7BGXwmRKqBcc1SnhhH8yEVnYxDyF84s0iVBq8GvpEmV0tDNvLV0pxZMoplxychIgs
         JaWr/npaZzg36Bq49VAHu4cggBcVtRZPZSIVCpz94x5eFADVHkj1wthpB351HFCPs+Vt
         QtUUvgZba90sv4/3FW4FmGkjg4lPL2KknI3x6d6jAyh+VzGb/wXqgkSFHxLh0I+SOy7z
         ljyEGvHUYRQkQkFvJtPO3/iIliayYfBV0wz+YHeWS6dpTiXxQdojPW0V5/7snM7CkJHw
         Wvuw==
X-Gm-Message-State: AOJu0YxqWQfDaijfE1RB81wwcoLBOVmv5Wy1DBTJcw34JXKRYWscCO49
        j8b6jWFlyjzf/MGsRCBlitqivmxGuus=
X-Google-Smtp-Source: AGHT+IGzbruqo0VPB6y6rDy6t/tyrwEJMRP5rd4WlaqUaGKCS+kfR5iY7ewQEHYIonCGw4en1PReEB32sFI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:21c4:b0:6cb:e3c5:7e28 with SMTP id
 t4-20020a056a0021c400b006cbe3c57e28mr6142666pfj.1.1701475493302; Fri, 01 Dec
 2023 16:04:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:06 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-18-seanjc@google.com>
Subject: [PATCH v9 17/28] KVM: selftests: Test consistency of CPUID with num
 of gp counters
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

Add a test to verify that KVM correctly emulates MSR-based accesses to
general purpose counters based on guest CPUID, e.g. that accesses to
non-existent counters #GP and accesses to existent counters succeed.

Note, for compatibility reasons, KVM does not emulate #GP when
MSR_P6_PERFCTR[0|1] is not present (writes should be dropped).

Co-developed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 663e8fbe7ff8..863418842ef8 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -270,9 +270,103 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
 	kvm_vm_free(vm);
 }
 
+/*
+ * Limit testing to MSRs that are actually defined by Intel (in the SDM).  MSRs
+ * that aren't defined counter MSRs *probably* don't exist, but there's no
+ * guarantee that currently undefined MSR indices won't be used for something
+ * other than PMCs in the future.
+ */
+#define MAX_NR_GP_COUNTERS	8
+#define MAX_NR_FIXED_COUNTERS	3
+
+#define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
+__GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
+	       "Expected %s on " #insn "(0x%x), got vector %u",			\
+	       expect_gp ? "#GP" : "no fault", msr, vector)			\
+
+#define GUEST_ASSERT_PMC_VALUE(insn, msr, val, expected)			\
+	__GUEST_ASSERT(val == expected_val,					\
+		       "Expected " #insn "(0x%x) to yield 0x%lx, got 0x%lx",	\
+		       msr, expected_val, val);
+
+static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters,
+				 uint8_t nr_counters)
+{
+	uint8_t i;
+
+	for (i = 0; i < nr_possible_counters; i++) {
+		/*
+		 * TODO: Test a value that validates full-width writes and the
+		 * width of the counters.
+		 */
+		const uint64_t test_val = 0xffff;
+		const uint32_t msr = base_msr + i;
+		const bool expect_success = i < nr_counters;
+
+		/*
+		 * KVM drops writes to MSR_P6_PERFCTR[0|1] if the counters are
+		 * unsupported, i.e. doesn't #GP and reads back '0'.
+		 */
+		const uint64_t expected_val = expect_success ? test_val : 0;
+		const bool expect_gp = !expect_success && msr != MSR_P6_PERFCTR0 &&
+				       msr != MSR_P6_PERFCTR1;
+		uint8_t vector;
+		uint64_t val;
+
+		vector = wrmsr_safe(msr, test_val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector);
+
+		vector = rdmsr_safe(msr, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, msr, expect_gp, vector);
+
+		/* On #GP, the result of RDMSR is undefined. */
+		if (!expect_gp)
+			GUEST_ASSERT_PMC_VALUE(RDMSR, msr, val, expected_val);
+
+		vector = wrmsr_safe(msr, 0);
+		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, msr, expect_gp, vector);
+	}
+	GUEST_DONE();
+}
+
+static void guest_test_gp_counters(void)
+{
+	uint8_t nr_gp_counters = 0;
+	uint32_t base_msr;
+
+	if (guest_get_pmu_version())
+		nr_gp_counters = this_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
+
+	if (this_cpu_has(X86_FEATURE_PDCM) &&
+	    rdmsr(MSR_IA32_PERF_CAPABILITIES) & PMU_CAP_FW_WRITES)
+		base_msr = MSR_IA32_PMC0;
+	else
+		base_msr = MSR_IA32_PERFCTR0;
+
+	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters);
+}
+
+static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
+			     uint8_t nr_gp_counters)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
+					 pmu_version, perf_capabilities);
+
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
+				nr_gp_counters);
+
+	run_vcpu(vcpu);
+
+	kvm_vm_free(vm);
+}
+
 static void test_intel_counters(void)
 {
 	uint8_t nr_arch_events = kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+	uint8_t nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 	uint8_t pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	unsigned int i;
 	uint8_t v, j;
@@ -336,6 +430,11 @@ static void test_intel_counters(void)
 				for (k = 0; k < nr_arch_events; k++)
 					test_arch_events(v, perf_caps[i], j, BIT(k));
 			}
+
+			pr_info("Testing GP counters, PMU version %u, perf_caps = %lx\n",
+				v, perf_caps[i]);
+			for (j = 0; j <= nr_gp_counters; j++)
+				test_gp_counters(v, perf_caps[i], j);
 		}
 	}
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

