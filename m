Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0677E7731
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbjKJCOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbjKJCOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E14C0D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:42 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b4128814ffso1485499a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582421; x=1700187221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yXjd8ycJk5ludACFb6UaTDaVuxV6wDMcAqjphn76qEE=;
        b=HKJTskqQu6YiGXlMPmrjOKKrhfDNecLKhlmkof+ZLnlSUB3P7NKvgBzdTdKEfkLZNr
         5fXWheDN/PffaVUrbawIE5L962N4KawZRjVkAl2lfuwJLeg7WzqAZvVYP/vG9p2d2dw1
         YNNrPXDxxnZnl8Oaf1sO6H/dDshMSJIjQeL8tWfdWI1PO9ENof8Te16BawYLLJIbTwAz
         H7PROpOPNWFbJW4bEiac7DM59tFNr79Ia8rdnnd3/c0XscD25WSOaqPsIOWZbD6Ajc9W
         E2/PxcuBVLwvd7Zgyotci0qz8E4L31UZTzn/ym2ZtbL1cTaECe/ixDO+hmEXZzZWEAje
         JkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582421; x=1700187221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXjd8ycJk5ludACFb6UaTDaVuxV6wDMcAqjphn76qEE=;
        b=d7zhM5WRJkI7LvLnIrv7OADzGqhQ3Y9K93myjHKCkvn4r5jEE74YE9i7BR61w7rbSi
         MDX7UCavCMjSUJ/KP1f5T6QRMcgiGOPFQxOajJA6o5ren/d9ndExkXl3cZUMsrh87Rot
         RbLvM/S/k/1MfqYvxUs+0j545ypqSp4v95xBm2wAcK4wN4m9JCq//MyT1DIdvrk64l/B
         5xSASGpiZULXWL6P62Jz2VUPk3jWPwgg6BHNLOpDxZZEzop20KIUBTbqI+ZzQraD/Chx
         JyCdH1p6FuugKuJ39KpX6wr+IZlgwXIbnk+b6jWmzZ+pzLYt/QhnPRZko4T/ZvGfuAy6
         S84w==
X-Gm-Message-State: AOJu0Yw0LNYvQZEuVyC90FF/a02DuCowrJkXADpjuztxdOdDtFsio3JA
        NMEQ7TzFES+ZMs8G32ULyFIhr/mEg7o=
X-Google-Smtp-Source: AGHT+IGPmmu9z9+mnedcdM3IEA8XJ7zwmVtyIiM6VmHt8zHdYQWO46yj6fsHt34IOUVe50tLKaQLqumdygc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:efc1:b0:1cc:56cc:787e with SMTP id
 ja1-20020a170902efc100b001cc56cc787emr950117plb.4.1699582421536; Thu, 09 Nov
 2023 18:13:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:55 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-16-seanjc@google.com>
Subject: [PATCH v8 15/26] KVM: selftests: Test consistency of CPUID with num
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
2.42.0.869.gea05f2083d-goog

