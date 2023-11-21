Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54F7F2D72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjKUMm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjKULzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:55:49 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81B0116;
        Tue, 21 Nov 2023 03:55:45 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1cc2fc281cdso37520715ad.0;
        Tue, 21 Nov 2023 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567745; x=1701172545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a2UvIVQOk+mF3Xt68Og+a1lPhUsU3gq66oL0/Q5kAA=;
        b=QjzyWU5+MxfF4KYTSMxHf5c+ZuFlhh6pPNVn3/c6V7Qwqr7U03APmCXtJ28E7AnlGe
         p+PglQ343HBhq3OFRjc5c5tUu58uKuzFdQ16KLpPcr4ASCzdxiy3IDNlCsPQaq/cmKlS
         HJ5EeC6cdO9BnbIbWn9A3kyzpzGE7MpsTVHlPvV8/J6geEw9m+rJ2E2GvecvLKzFCVr5
         nr8k+IbJM9JhzzDeGnZLGXZDkABBY7KGJtdipwj2bI+dyR4VeBwwQgbRdPITIqXxxZcg
         LWPGnCGq7cHj8WRFeFSouiveSQ7344IYpdwCi7q+N/rnzkejC6QQQdZS7F5F1qw29bYj
         1qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567745; x=1701172545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a2UvIVQOk+mF3Xt68Og+a1lPhUsU3gq66oL0/Q5kAA=;
        b=iO+RnDPIYlqOgt66sWRP7jgE4g/dudvZG3zvFAlQDrZpt4L0wwmT82j4bYDPT6aBuS
         2OPpCQDOOYNvezcfvUKYd4Rk+gmD0RwzqfuluL/tWG3a+qfdrTEU8BO2OqqlpiF5MJUg
         VtFjF0Vn62IrxdC3iRU7tDJc+kGCQqiiMIHmbK4tR93pY00BpXVMUlzvQH4WWQzWBs2C
         OiBlZzm1uGWtRYuCP7bdmJ98kUigMWgwWJBZTNHbcJ5KlcuVoMD30dxcvJvo2NWBVLiV
         T1jxuhJ/7Tdmv8Q0yLZCtjwEreE0sn+jpjRiHbCkDQHjX5q6Bz4j+3JflN64IDJEAfd8
         uVcw==
X-Gm-Message-State: AOJu0YxAXCrPsj7e3lAlYJtnn2Y+y8REtNpFPEHYjv7maBTScpm67WB5
        wMm4FzMDG/B/AqaTiyPqE0I=
X-Google-Smtp-Source: AGHT+IEvjwRCdgy6JMsMIrf6Jl2kRTZG+1NXXxiUW0DHGSnPybpc3msHxuLOBkKWBSZ20tIb83ANqg==
X-Received: by 2002:a17:902:db02:b0:1cf:5cb5:95bf with SMTP id m2-20020a170902db0200b001cf5cb595bfmr6363181plx.45.1700567745403;
        Tue, 21 Nov 2023 03:55:45 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001cc1dff5b86sm7685431pll.244.2023.11.21.03.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:55:45 -0800 (PST)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Jinrong Liang <ljr.kernel@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] KVM: selftests: Test AMD PMU performance counters basic functions
Date:   Tue, 21 Nov 2023 19:54:53 +0800
Message-Id: <20231121115457.76269-6-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121115457.76269-1-cloudliang@tencent.com>
References: <20231121115457.76269-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add tests to check AMD PMU performance counters basic functions.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 84 +++++++++++++++++--
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index efd8c61e1c16..3c4081a508b0 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -21,6 +21,8 @@
 #define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
 
 #define PMI_VECTOR		0x20
+#define AMD64_NR_COUNTERS	4
+#define AMD64_NR_COUNTERS_CORE	6
 
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
@@ -411,7 +413,6 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		rdpmc_idx = i;
 		if (base_msr == MSR_CORE_PERF_FIXED_CTR0)
 			rdpmc_idx |= INTEL_RDPMC_FIXED;
-
 		guest_test_rdpmc(rdpmc_idx, expect_success, expected_val);
 
 		/*
@@ -421,7 +422,6 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 		 */
 		GUEST_ASSERT(!expect_success || !pmu_has_fast_mode);
 		rdpmc_idx |= INTEL_RDPMC_FAST;
-
 		guest_test_rdpmc(rdpmc_idx, false, -1ull);
 
 		vector = wrmsr_safe(msr, 0);
@@ -701,19 +701,85 @@ static void test_intel_counters(void)
 	}
 }
 
+static void set_amd_counters(uint8_t *nr_amd_ounters, uint64_t *ctrl_msr,
+			     uint32_t *pmc_msr, uint8_t *flag)
+{
+	if (this_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		*nr_amd_ounters = this_cpu_property(X86_PROPERTY_PMU_NR_CORE_COUNTERS);
+		*ctrl_msr = MSR_F15H_PERF_CTL0;
+		*pmc_msr = MSR_F15H_PERF_CTR0;
+		*flag = 2;
+	} else if (this_cpu_has(X86_FEATURE_PERFCTR_CORE)) {
+		*nr_amd_ounters = AMD64_NR_COUNTERS_CORE;
+		*ctrl_msr = MSR_F15H_PERF_CTL0;
+		*pmc_msr = MSR_F15H_PERF_CTR0;
+		*flag = 2;
+	} else {
+		*nr_amd_ounters = AMD64_NR_COUNTERS;
+		*ctrl_msr = MSR_K7_EVNTSEL0;
+		*pmc_msr = MSR_K7_PERFCTR0;
+		*flag = 1;
+	}
+}
+
+static void guest_test_amd_counters(void)
+{
+	bool guest_pmu_is_perfmonv2 = this_cpu_has(X86_FEATURE_PERFMON_V2);
+	uint8_t nr_amd_counters, flag;
+	uint64_t ctrl_msr;
+	unsigned int i, j;
+	uint32_t pmc_msr;
+
+	set_amd_counters(&nr_amd_counters, &ctrl_msr, &pmc_msr, &flag);
+
+	for (i = 0; i < nr_amd_counters; i++) {
+		for (j = 0; j < NR_AMD_ZEN_EVENTS; j++) {
+			wrmsr(pmc_msr + i * flag, 0);
+			wrmsr(ctrl_msr + i * flag, ARCH_PERFMON_EVENTSEL_OS |
+			ARCH_PERFMON_EVENTSEL_ENABLE | amd_pmu_zen_events[j]);
+
+			if (guest_pmu_is_perfmonv2)
+				wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, BIT_ULL(i));
+
+			__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+
+			GUEST_ASSERT(rdmsr(pmc_msr + i * flag));
+		}
+	}
+
+	GUEST_DONE();
+}
+
+static void test_amd_zen_events(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_amd_counters);
+
+	run_vcpu(vcpu);
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_is_pmu_enabled());
 
-	TEST_REQUIRE(host_cpu_is_intel);
-	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
-	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+	if (host_cpu_is_intel) {
+		TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
+		TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
 
-	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
-	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
-	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
+		kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
+		kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+		is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
-	test_intel_counters();
+		test_intel_counters();
+	} else if (host_cpu_is_amd) {
+		test_amd_zen_events();
+	} else {
+		TEST_FAIL("Unknown CPU vendor");
+	}
 
 	return 0;
 }
-- 
2.39.3

