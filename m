Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865D87E4E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjKHAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjKHAcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:32:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA1D1BCA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:04 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ee6a1801so85683167b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403524; x=1700008324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hPsaF5MvjEojCPzVh5GmBO1K8rW4186JxKylBK7c9PE=;
        b=OAFBfY9XypCElQ9k0vy2MllCoFB3uTTEepZ7kCSFZjBphuaBe1UEd6dbFR43J/0CVG
         opg5u8gl8bceVULcY2ryirxNriurdu1rsf+KFgfCxwNZ+FFsMQeLNRGVqTHYHYQLhngh
         tJLBMgcNm7jU0lazUCG/P58UR+e/ogqasGk0DWbyMUGBrnp85SHjNNjRgxjyo3EmDFu1
         teENiPrIJOTqHyemf1Jqr7WwnfIXPZhK0HVRvYw1Ictffk+8/8ktDw2WwOy6nG7wE8ki
         Vn2siG2GsnbbsERyRq/6q84+h8qhRF+18CLPrPFvMJ8Qpa3JQ0HrTsV9cgIv5i/ce2h2
         d24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403524; x=1700008324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPsaF5MvjEojCPzVh5GmBO1K8rW4186JxKylBK7c9PE=;
        b=igTNTC3sbyi1DlzA0I819CQGU/qUTrhtL/ikQDfvko1m7lyPSvGYyW05yG2FzqN0MB
         Ux/7E8N57VpdkVpXBckwv1yCq8MLVunNoT9QPzV8O+oK0nkdooMq7q+LhNDSLUftifu7
         xRSqoHGczyTI5PhOgtuSohUASJGXGwognjxIwXzcYyS6HszmS2ehdC1rC0jaffTZVGnE
         hXDsV2Pqv04s79ge1Cf4pP6wlDIi/AV+0MukQ5XtV4xpku3JWpxwGDwFabwutEQRwRoV
         QSn29cx45Tr6QSffH7R6Us0lUV+Ym00Efym4ZXZs8sbLYlH5VOABH93XvktgW0o3EUhH
         GbTA==
X-Gm-Message-State: AOJu0Yx+4nJxLbwve3knpFXwfuIq4ISL4lVYqH58P53i+RyHapqA2XCP
        +0AsOMew9aU7sz8k6oXZBZUsVNQkze0=
X-Google-Smtp-Source: AGHT+IFZOkAuqpaEes5eakubHQkZwSfLWkSKSMe9zWJ5Aq0ttgcRZFvc98SDXT5WVNDYltvOWNv8eeDrBUs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:24c:b0:da3:ba0f:c84f with SMTP id
 k12-20020a056902024c00b00da3ba0fc84fmr6339ybs.4.1699403523759; Tue, 07 Nov
 2023 16:32:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:28 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-13-seanjc@google.com>
Subject: [PATCH v7 12/19] KVM: selftests: Test consistency of CPUID with num
 of fixed counters
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

Extend the PMU counters test to verify KVM emulation of fixed counters in
addition to general purpose counters.  Fixed counters add an extra wrinkle
in the form of an extra supported bitmask.  Thus quoth the SDM:

  fixed-function performance counter 'i' is supported if ECX[i] || (EDX[4:0] > i)

Test that KVM handles a counter being available through either method.

Co-developed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 60 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 6f2d3a64a118..8c934e261f2d 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -285,13 +285,19 @@ __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
 	       expect_gp ? "#GP" : "no fault", msr, vector)			\
 
 static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters,
-				 uint8_t nr_counters)
+				 uint8_t nr_counters, uint32_t or_mask)
 {
 	uint8_t i;
 
 	for (i = 0; i < nr_possible_counters; i++) {
 		const uint32_t msr = base_msr + i;
-		const bool expect_success = i < nr_counters;
+
+		/*
+		 * Fixed counters are supported if the counter is less than the
+		 * number of enumerated contiguous counters *or* the counter is
+		 * explicitly enumerated in the supported counters mask.
+		 */
+		const bool expect_success = i < nr_counters || (or_mask & BIT(i));
 
 		/*
 		 * KVM drops writes to MSR_P6_PERFCTR[0|1] if the counters are
@@ -335,7 +341,7 @@ static void guest_test_gp_counters(void)
 	else
 		base_msr = MSR_IA32_PERFCTR0;
 
-	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters);
+	guest_rd_wr_counters(base_msr, MAX_NR_GP_COUNTERS, nr_gp_counters, 0);
 }
 
 static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
@@ -355,9 +361,50 @@ static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
 	kvm_vm_free(vm);
 }
 
+static void guest_test_fixed_counters(void)
+{
+	uint64_t supported_bitmask = 0;
+	uint8_t nr_fixed_counters = 0;
+
+	/* Fixed counters require Architectural vPMU Version 2+. */
+	if (guest_get_pmu_version() >= 2)
+		nr_fixed_counters = this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+
+	/*
+	 * The supported bitmask for fixed counters was introduced in PMU
+	 * version 5.
+	 */
+	if (guest_get_pmu_version() >= 5)
+		supported_bitmask = this_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK);
+
+	guest_rd_wr_counters(MSR_CORE_PERF_FIXED_CTR0, MAX_NR_FIXED_COUNTERS,
+			     nr_fixed_counters, supported_bitmask);
+}
+
+static void test_fixed_counters(uint8_t pmu_version, uint64_t perf_capabilities,
+				uint8_t nr_fixed_counters,
+				uint32_t supported_bitmask)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_fixed_counters,
+					 pmu_version, perf_capabilities);
+
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK,
+				supported_bitmask);
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_FIXED_COUNTERS,
+				nr_fixed_counters);
+
+	run_vcpu(vcpu);
+
+	kvm_vm_free(vm);
+}
+
 static void test_intel_counters(void)
 {
 	uint8_t nr_arch_events = kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
 	uint8_t nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 	uint8_t pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	unsigned int i;
@@ -427,6 +474,13 @@ static void test_intel_counters(void)
 				v, perf_caps[i]);
 			for (j = 0; j <= nr_gp_counters; j++)
 				test_gp_counters(v, perf_caps[i], j);
+
+			pr_info("Testing fixed counters, PMU version %u, perf_caps = %lx\n",
+				v, perf_caps[i]);
+			for (j = 0; j <= nr_fixed_counters; j++) {
+				for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
+					test_fixed_counters(v, perf_caps[i], j, k);
+			}
 		}
 	}
 }
-- 
2.42.0.869.gea05f2083d-goog

