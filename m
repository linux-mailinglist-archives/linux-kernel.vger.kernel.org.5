Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C937E4E28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbjKHAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbjKHAdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:33:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2262120
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03390793fso7188889276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403537; x=1700008337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+33edaVs5/Z2morXGikwBPQAuHCPyAZkKikXNnwhXvI=;
        b=OLLDWRxOWm7R9VBzYxDgewf+btCdrzjWGL1mgBeudJ40o00xcU+CukFX96oatdRcFC
         CdEuuwv38a8ZtWo/crL8NEOxI0hCqDSDjzhINeLh191LSswfSCoPmkcPThBq67IRnLAs
         NLORaPAT/TsozT/Kw3Sp3URaBI+tSepoRlg5q35GiYYqRZDJI643BikBc8eKPuIYqEDe
         buI5BWUnuE6izt+VBhcXdHPqf46A0HwneT3HDdgIYg7n/J4FstFQxnQ71viY6lSKaTMm
         Cbf+kKfyFNO2fnaOL4uIdXX1ooEd5yjKubbMZYZgVdp0FKP4kAY8IuFkCXydzd+Pm+K7
         LT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403537; x=1700008337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+33edaVs5/Z2morXGikwBPQAuHCPyAZkKikXNnwhXvI=;
        b=CIF5OK+9gnbD3klNjrnt+oNLWvRAKwd+d9A4x4WSOvI2Dw9KQ3UW56skUhrT66ff7D
         ll4dVwb+MgGJieuYZvmK6QMXLkJYz/p9EllyA9thzJu7ir6myHvojroN36Wb8d/RWk90
         NN7vbNEPwn9gLtXVt5+4r9EvAkjL3OaGZJDblFSDDIBCt4QFRpro8pvB1v62ftmy93bc
         M/zXwcouY7t7mkubfjEeV/bVhzBVW/YtqvE+EowHkuxOauR6qED6NJnyvDR4i4eKOyt2
         5ItAEfyLsJ7B/ZvQjZQalI8rhke2kZ/p/wvy6TR/twfBdo9aGixWMkyvAv6XDWeJSyys
         R3+g==
X-Gm-Message-State: AOJu0YzONNsQWXf8zKq65Wau+iUI+mAYmfGM+zpseoUfCvezhDMcQO/N
        KxuX4m3Ef64Yr8yekg3YvYSGiRbMHv4=
X-Google-Smtp-Source: AGHT+IH2IqLaGw4XGC8tn18p+rgc4o7UnI0rnRhAbbNKz9ppW72ZiipJU4pSELozCz1UqmXEDYzcKM0zRfQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1fd6:0:b0:d9a:e3d9:99bd with SMTP id
 f205-20020a251fd6000000b00d9ae3d999bdmr5762ybf.5.1699403537213; Tue, 07 Nov
 2023 16:32:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:35 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-20-seanjc@google.com>
Subject: [PATCH v7 19/19] KVM: selftests: Test PMC virtualization with forced emulation
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

Extend the PMC counters test to use forced emulation to verify that KVM
emulates counter events for instructions retired and branches retired.
Force emulation for only a subset of the measured code to test that KVM
does the right thing when mixing perf events with emulated events.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index d775cc7e8fab..09332b3c0a69 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -21,6 +21,7 @@
 
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
+static bool is_forced_emulation_enabled;
 
 static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 						  void *guest_code,
@@ -34,6 +35,7 @@ static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 	vcpu_init_descriptor_tables(*vcpu);
 
 	sync_global_to_guest(vm, kvm_pmu_version);
+	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
 	/*
 	 * Set PERF_CAPABILITIES before PMU version as KVM disallows enabling
@@ -138,37 +140,50 @@ static void guest_assert_event_count(uint8_t idx,
  * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
  * start of the loop to force LLC references and misses, i.e. to allow testing
  * that those events actually count.
+ *
+ * If forced emulation is enabled (and specified), force emulation on a subset
+ * of the measured code to verify that KVM correctly emulates instructions and
+ * branches retired events in conjunction with hardware also counting said
+ * events.
  */
-#define GUEST_MEASURE_EVENT(_msr, _value, clflush)				\
+#define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
 do {										\
 	__asm__ __volatile__("wrmsr\n\t"					\
 			     clflush "\n\t"					\
 			     "mfence\n\t"					\
 			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
-			     "loop .\n\t"					\
-			     "mov %%edi, %%ecx\n\t"				\
-			     "xor %%eax, %%eax\n\t"				\
-			     "xor %%edx, %%edx\n\t"				\
+			     FEP "loop .\n\t"					\
+			     FEP "mov %%edi, %%ecx\n\t"				\
+			     FEP "xor %%eax, %%eax\n\t"				\
+			     FEP "xor %%edx, %%edx\n\t"				\
 			     "wrmsr\n\t"					\
 			     :: "a"((uint32_t)_value), "d"(_value >> 32),	\
 				"c"(_msr), "D"(_msr)				\
 	);									\
 } while (0)
 
+#define GUEST_TEST_EVENT(_idx, _event, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)	\
+do {										\
+	wrmsr(pmc_msr, 0);							\
+										\
+	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt 1f", FEP);	\
+	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush 1f", FEP);	\
+	else									\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
+										\
+	guest_assert_event_count(_idx, _event, _pmc, _pmc_msr);			\
+} while (0)
+
 static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feature event,
 				    uint32_t pmc, uint32_t pmc_msr,
 				    uint32_t ctrl_msr, uint64_t ctrl_msr_value)
 {
-	wrmsr(pmc_msr, 0);
+	GUEST_TEST_EVENT(idx, event, pmc, pmc_msr, ctrl_msr, ctrl_msr_value, "");
 
-	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))
-		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflushopt 1f");
-	else if (this_cpu_has(X86_FEATURE_CLFLUSH))
-		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "clflush 1f");
-	else
-		GUEST_MEASURE_EVENT(ctrl_msr, ctrl_msr_value, "nop");
-
-	guest_assert_event_count(idx, event, pmc, pmc_msr);
+	if (is_forced_emulation_enabled)
+		GUEST_TEST_EVENT(idx, event, pmc, pmc_msr, ctrl_msr, ctrl_msr_value, KVM_FEP);
 }
 
 #define X86_PMU_FEATURE_NULL						\
@@ -545,6 +560,7 @@ int main(int argc, char *argv[])
 
 	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	test_intel_counters();
 
-- 
2.42.0.869.gea05f2083d-goog

