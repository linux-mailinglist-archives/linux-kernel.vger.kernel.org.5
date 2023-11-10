Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F667E7745
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbjKJCPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjKJCOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E723547A7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:57 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7c97d5d5aso22277367b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582437; x=1700187237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ds3MvKH8kVzgSsc7o55jwRMvzgXZJWlQSFfImJG8HBA=;
        b=DukZr36XKXnoUAft4AlGt1fHSk0S6ypv7QUpB+1MUsGcgm4cK4JjH36BLiOl/dz0jy
         Nif7c/zpd7/U8q6VxENAnQvtD8LeQYVc4uOyhRmcG8UZCeZBWe0c+J2jfEZ3+29i4k1T
         4KSGm97K7LC1uyXCq8huE9HnoBai6p9hpc+TErJ4TCCHLi+d30ZFJ+X69qa8m9Yj+bJJ
         l0ucRvPCJTPD6IP+qX4zcIVQ6Bm0NaZylYKWdXfxOy11PDbNluLJZCMllWmcWJOShCcu
         A+cZZrinw2OKXb1Zn2Gg+6vgf9oxea9ywvmtb8ZxYHCdBkjAZlw43LNSWMSlPdy5Ydwc
         o5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582437; x=1700187237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds3MvKH8kVzgSsc7o55jwRMvzgXZJWlQSFfImJG8HBA=;
        b=b0jXB9+fn5/eFanvMTTeY8I4ZWwswmH8XCyIaSRGe2sX3PVzN7ohR2Ptl37LBc+Hlo
         70sccFKFJgdOJhdNqSraQzTFcgZbq1hGHtEyk328u1p/Bki1HEiJYcLm11W1Hz5EE2+C
         HTuo0V8y2VCo/JaWEOnJbX4zgt4bfAHIYyrqCKUWt+MkRXCXhTv9f2Rkq9obVDClY4+t
         cm5rkhhLevNJJfeZ6UxO2qzU3Jz1uOxvo1H4avE0X0sClfgpm9lQGqXrY1UO/8grpLUq
         4qPSnLqGe9vu87r5oF5hk7Ybqhq11lfdsojNtgMzWkZk8OA+aDhcD2F8kc0kk3nC6r+8
         yx7Q==
X-Gm-Message-State: AOJu0YzjPwtZ8SX/RQ3IhY9tjtwd4QY2zYsb1PSlnh6hhxX4+fidsoWW
        K6cI25flORfFk+e5v07NQbGpXakEhDM=
X-Google-Smtp-Source: AGHT+IGVSq2vUtOEhrlYJW++VX5sbfrBPkYviGH8SgJ+LDE1dLyKGYzsIMHEhozr1WK40vhWBtLvk/aqeQo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4849:0:b0:5a7:aa51:c08e with SMTP id
 v70-20020a814849000000b005a7aa51c08emr180425ywa.1.1699582437106; Thu, 09 Nov
 2023 18:13:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:13:03 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-24-seanjc@google.com>
Subject: [PATCH v8 23/26] KVM: selftests: Test PMC virtualization with forced emulation
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

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 9e9dc4084c0d..cb808ac827ba 100644
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
@@ -553,6 +568,7 @@ int main(int argc, char *argv[])
 
 	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	test_intel_counters();
 
-- 
2.42.0.869.gea05f2083d-goog

