Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39D37E0C99
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjKDAER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjKDADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:03:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074A91736
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:03:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da39d244087so3392665276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056199; x=1699660999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yilGYXp68Gbkah/X+aiEqo69eD6DcRs1k7jq3pnaJG0=;
        b=PrhYXGRQXDy2Ufld/nmOej2eX0/rRRKB0FLcxie6dNxN4DNLBqb756aOgohALGvpgn
         NDo95V+7d7ZtI9iT5SWw32bMVk22ylN1S3QKup6zovh8lXgBAvuP8NZtAfKi0gXJNjrt
         u//eorY5smk8dIHKZU3wzVTVcnqh1k1ZJlbequh/iFH40LW1rC4nGUeaKyrSKbyHKQXH
         Jh6JfDF/oIHs9kaTMz3TC+7MN+cyKlebh6AYsmUsLvtRgkS9+7qmotRNJR8ysk7zCDZd
         Ja8TjC6YEeyoI3avxBoPNLk7PAcGmaLJ8DOzxqt9Oue9KcbJ0Mmf2aiQ6uYe/EPk4XU9
         DRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056199; x=1699660999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yilGYXp68Gbkah/X+aiEqo69eD6DcRs1k7jq3pnaJG0=;
        b=nyZnLvhnPz6X0R7QtiPd2pmVwtAHm+1QzWvN9x4DP0cpwq8kfLceL8E0xBse/bfBcK
         b9huJJGr9FPjFiaV8Ti8qeY2BfSezhk4E011mMj3+uXlLmN6OxilQAY9MDykT3WQR0Ko
         kfC7OIuGmfKewqV2U39R6yc5F5mskloroVVChAmIoigBa6rPYzGoW9GUiXwQQdv0QjY1
         cG3Fe3Rtfj9TPYr7THrSBpWAkH3kGQ5xTmgSdKMpIADybX6mrQNV3hI7bjaa3JisucTT
         mICOX24a9eERVNSw2U/anJc2nWLcc8cKxYyX0cYr9rSTtYcQRblbTPIyTLZ2ShDCXYLU
         jxaw==
X-Gm-Message-State: AOJu0Yz/NjVxq2PRyHLZRNv5Hq+Y0sOE+M2zAZqr+9FpWttHlNzd5/nN
        dnU4uYSjnJ/+Pn+s6uPguqD86l/+ETw=
X-Google-Smtp-Source: AGHT+IEicFfkBpZ2m9QbCFIL/o0Vua2YTrgtnpUv+V0BpPEsG8P69HWK7wUOZjk1sFEN97lq90Ji7Khz4nM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:565:b0:da0:c979:fd70 with SMTP id
 a5-20020a056902056500b00da0c979fd70mr474880ybt.9.1699056199021; Fri, 03 Nov
 2023 17:03:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:38 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-21-seanjc@google.com>
Subject: [PATCH v6 20/20] KVM: selftests: Test PMC virtualization with forced emulation
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index e6cf76d3499b..c66cf92cc9cc 100644
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
@@ -544,6 +559,7 @@ int main(int argc, char *argv[])
 
 	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	test_intel_counters();
 
-- 
2.42.0.869.gea05f2083d-goog

