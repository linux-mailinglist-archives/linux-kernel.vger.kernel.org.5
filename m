Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A307FE39B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbjK2WtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjK2WtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:49:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50CA112
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:23 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cc3e334d16so5156397b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701298163; x=1701902963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jt3afr9C/NIzRrhpIhGigrnj+umWBaK2U3Kv0056zgw=;
        b=oFDeVaszqKVpYECsszkTNp3hDCq4mOQ/hhLZwwKbGX/2IbL05++SIxSHozA+I1Zx0F
         JOasnrDzTVBYPGnoCxfQ+CcaHqrWnkxk2TlilZQF4LvxMZN8bI522kR8ma6nPg7gb5nQ
         vTCUu1knw80Zz/VdVbpkWeT69SC8elC1NqwsXvMQqw2aNbArNf8FrrxMi2y+8fEhOCyc
         jn+OVT3jIUi60yYeYvdWIZ0tyS/9/RnwSTDgmOAUMIeQ2uFFyTBGDe+GM7Hbx6boMtQ6
         NC1CJrztFe5zsDq3gh7YBbLBJ9ecbWc4VOlfU+u63V0MbzljfYGxn1yBVB0vEI2V53sk
         K4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701298163; x=1701902963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jt3afr9C/NIzRrhpIhGigrnj+umWBaK2U3Kv0056zgw=;
        b=RjAfQ1KWsGKl16AMhaOsqOAM3rsNJIE/NhZzyLgcwWRU/VuN20KuaBfTlwnQeWu4Dc
         NxtJZj7FORtDO8YCxygBboO64RaoYHCjYepU5FhWX68/EXVc8rGYQwx/VmMQWWkJU/pK
         h0WZA5YkTfNd+qCRscOdSJqV+lPF5bIYNoCsqgYKDvD5wTMNmGuASiWq5nt+ffyxcBuw
         1EOKm1KRYUhdNSbbn/9UpPzm2F8Pmnenna/fv72BKrP27s7VkXxBT1LuO6PG0MoPuCwZ
         fm/RBQoQ6+f1QRys+qw4ScG4y+OFjkIU0+dKN/gbbRMZjDLEiaHS6feMRubKQiToR+rA
         LVpw==
X-Gm-Message-State: AOJu0Ywc3C+cKxdkPBF45WHycr10WJrT87CPn92cJDswBCSI0J6KJtkW
        mW1vebeN0H5tz3KFOvRZ8XaeLYCdziM=
X-Google-Smtp-Source: AGHT+IGulxVXRNgaFOL2lJyl25oFAVWs5bdYEbG4SzfwCCsdRMsJGWH3Ec6G/kWD9vUh4OgGxi+dx9bVB6k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b614:0:b0:5cc:3af6:291 with SMTP id
 u20-20020a81b614000000b005cc3af60291mr614082ywh.5.1701298163174; Wed, 29 Nov
 2023 14:49:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Nov 2023 14:49:14 -0800
In-Reply-To: <20231129224916.532431-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231129224916.532431-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129224916.532431-3-seanjc@google.com>
Subject: [PATCH v2 2/4] KVM: selftests: Fix benign %llx vs. %lx issues in
 guest asserts
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
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

Convert %llx to %lx as appropriate in guest asserts.  The guest printf
implementation treats them the same as KVM selftests are 64-bit only, but
strictly adhering to the correct format will allow annotating the
underlying helpers with __printf() without introducing new warnings in the
build.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c      | 6 +++---
 tools/testing/selftests/kvm/x86_64/hyperv_features.c      | 2 +-
 .../selftests/kvm/x86_64/private_mem_conversions_test.c   | 2 +-
 .../selftests/kvm/x86_64/svm_nested_soft_inject_test.c    | 4 ++--
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c    | 2 +-
 tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c      | 8 ++++----
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 6637a0845acf..03ec7efd19aa 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -157,17 +157,17 @@ static void guest_code_move_memory_region(void)
 	 */
 	val = guest_spin_on_val(0);
 	__GUEST_ASSERT(val == 1 || val == MMIO_VAL,
-		       "Expected '1' or MMIO ('%llx'), got '%llx'", MMIO_VAL, val);
+		       "Expected '1' or MMIO ('%lx'), got '%lx'", MMIO_VAL, val);
 
 	/* Spin until the misaligning memory region move completes. */
 	val = guest_spin_on_val(MMIO_VAL);
 	__GUEST_ASSERT(val == 1 || val == 0,
-		       "Expected '0' or '1' (no MMIO), got '%llx'", val);
+		       "Expected '0' or '1' (no MMIO), got '%lx'", val);
 
 	/* Spin until the memory region starts to get re-aligned. */
 	val = guest_spin_on_val(0);
 	__GUEST_ASSERT(val == 1 || val == MMIO_VAL,
-		       "Expected '1' or MMIO ('%llx'), got '%llx'", MMIO_VAL, val);
+		       "Expected '1' or MMIO ('%lx'), got '%lx'", MMIO_VAL, val);
 
 	/* Spin until the re-aligning memory region move completes. */
 	val = guest_spin_on_val(MMIO_VAL);
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 9f28aa276c4e..4bb63b6ee4a0 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -66,7 +66,7 @@ static void guest_msr(struct msr_data *msr)
 
 	if (msr->write)
 		__GUEST_ASSERT(!vector,
-			       "WRMSR(0x%x) to '0x%llx', RDMSR read '0x%llx'",
+			       "WRMSR(0x%x) to '0x%lx', RDMSR read '0x%lx'",
 			       msr->idx, msr->write_val, msr_val);
 
 	/* Invariant TSC bit appears when TSC invariant control MSR is written to */
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index 4d6a37a5d896..65ad38b6be1f 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -35,7 +35,7 @@ do {												\
 												\
 	for (i = 0; i < size; i++)								\
 		__GUEST_ASSERT(mem[i] == pattern,						\
-			       "Guest expected 0x%x at offset %lu (gpa 0x%llx), got 0x%x",	\
+			       "Guest expected 0x%x at offset %lu (gpa 0x%lx), got 0x%x",	\
 			       pattern, i, gpa + i, mem[i]);					\
 } while (0)
 
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index 7ee44496cf97..0c7ce3d4e83a 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -103,7 +103,7 @@ static void l1_guest_code(struct svm_test_data *svm, uint64_t is_nmi, uint64_t i
 
 	run_guest(vmcb, svm->vmcb_gpa);
 	__GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL,
-		       "Expected VMMCAL #VMEXIT, got '0x%x', info1 = '0x%llx, info2 = '0x%llx'",
+		       "Expected VMMCAL #VMEXIT, got '0x%x', info1 = '0x%lx, info2 = '0x%lx'",
 		       vmcb->control.exit_code,
 		       vmcb->control.exit_info_1, vmcb->control.exit_info_2);
 
@@ -133,7 +133,7 @@ static void l1_guest_code(struct svm_test_data *svm, uint64_t is_nmi, uint64_t i
 
 	run_guest(vmcb, svm->vmcb_gpa);
 	__GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_HLT,
-		       "Expected HLT #VMEXIT, got '0x%x', info1 = '0x%llx, info2 = '0x%llx'",
+		       "Expected HLT #VMEXIT, got '0x%x', info1 = '0x%lx, info2 = '0x%lx'",
 		       vmcb->control.exit_code,
 		       vmcb->control.exit_info_1, vmcb->control.exit_info_2);
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index ebbcb0a3f743..2a8d4ac2f020 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -56,7 +56,7 @@ static void guest_test_perf_capabilities_gp(uint64_t val)
 	uint8_t vector = wrmsr_safe(MSR_IA32_PERF_CAPABILITIES, val);
 
 	__GUEST_ASSERT(vector == GP_VECTOR,
-		       "Expected #GP for value '0x%llx', got vector '0x%x'",
+		       "Expected #GP for value '0x%lx', got vector '0x%x'",
 		       val, vector);
 }
 
diff --git a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
index 77d04a7bdadd..dc6217440db3 100644
--- a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
@@ -25,7 +25,7 @@ do {											\
 											\
 	__GUEST_ASSERT((__supported & (xfeatures)) != (xfeatures) ||			\
 		       __supported == ((xfeatures) | (dependencies)),			\
-		       "supported = 0x%llx, xfeatures = 0x%llx, dependencies = 0x%llx",	\
+		       "supported = 0x%lx, xfeatures = 0x%llx, dependencies = 0x%llx",	\
 		       __supported, (xfeatures), (dependencies));			\
 } while (0)
 
@@ -42,7 +42,7 @@ do {									\
 	uint64_t __supported = (supported_xcr0) & (xfeatures);		\
 									\
 	__GUEST_ASSERT(!__supported || __supported == (xfeatures),	\
-		       "supported = 0x%llx, xfeatures = 0x%llx",	\
+		       "supported = 0x%lx, xfeatures = 0x%llx",		\
 		       __supported, (xfeatures));			\
 } while (0)
 
@@ -81,7 +81,7 @@ static void guest_code(void)
 
 	vector = xsetbv_safe(0, supported_xcr0);
 	__GUEST_ASSERT(!vector,
-		       "Expected success on XSETBV(0x%llx), got vector '0x%x'",
+		       "Expected success on XSETBV(0x%lx), got vector '0x%x'",
 		       supported_xcr0, vector);
 
 	for (i = 0; i < 64; i++) {
@@ -90,7 +90,7 @@ static void guest_code(void)
 
 		vector = xsetbv_safe(0, supported_xcr0 | BIT_ULL(i));
 		__GUEST_ASSERT(vector == GP_VECTOR,
-			       "Expected #GP on XSETBV(0x%llx), supported XCR0 = %llx, got vector '0x%x'",
+			       "Expected #GP on XSETBV(0x%llx), supported XCR0 = %lx, got vector '0x%x'",
 			       BIT_ULL(i), supported_xcr0, vector);
 	}
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

