Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BD80F829
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377369AbjLLUrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377371AbjLLUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:47:26 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC0191
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e20c9c4080so11326987b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414039; x=1703018839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeLWUyiP/wO8xtMoo+vlGGvYyGcJ6kthyZbia5KZ2g4=;
        b=JbTR0JbFkl/zb1WihjXaeUgwhgKH+GZvmaaCf7LpiKfZZnRgqPc/fz2PPXGExlBbZl
         YRQ6TknZziqm8L78LntvCKSduNrIdp1FIYHzqnjRW7gzgfYzYRoIIsaUouGjrFCgI+AC
         vue9fQw6XVEHPnztfQXniHrCrsF8MYzL9fbB0ZMMS3Wn7Sf5K9VGP6644CnAGQJU1JGw
         hKqwa6kF9HJ5HVBt2e53xZkHyMZEBcWXNx6Kh6iy2c3ADEE+xMtWndxVDntmNDUwWGCJ
         nYWtRlK4+oigdl/bPTBpt+9rrZjtXa+DOPwbZE+rUBezgjJrmoz+BmOq/HP/FJgsdP54
         3KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414039; x=1703018839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeLWUyiP/wO8xtMoo+vlGGvYyGcJ6kthyZbia5KZ2g4=;
        b=Ql53VCUXhZam8ye8EKquZVAA/yIdkML1YmIM7MZAN/HMjk/GBF0nn+5M02m9EIKzak
         LuMeIDzWZayP8Muu+v3fY9QxwSdBIWAoO62hnqr+3dSz4eZ/2XroeXmsz3xN9yobxrQG
         Tslxx8wLJccKCS3RPfxXdw8XCuyVxeOLXxVHQP2pM80LhL2/Y/INl2SSxIWx2COV+Vdw
         nM6qZtTy5FdwqiCLI8sZrgn2sz9CLFFLdiM3fweZuA0vs9pTNOB7n28KO4jDaCHkdGlJ
         shTE8dAzEh9amM6dh+sK2gFmRU5m+4Cwo2mhbmEhWMWZzN2Ti0X1c2c3nhmIsb6YTvYJ
         qp1A==
X-Gm-Message-State: AOJu0YxOAzngZf+0EFoMCWfY3ENOGnMVoCUPBFMSOhVYZbEcwppEyws7
        tiF1GaLOzZxDSmM9NgkZoPTUf37YiA==
X-Google-Smtp-Source: AGHT+IE5N+kuLbahhMDX59Z0zuObBfc5I7jEWD21qixoGjX8y/mofmjWwRaghUF2QwlVYLPSt8arVNojlg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:690c:c09:b0:5d3:3aa4:6f3a with SMTP id
 cl9-20020a05690c0c0900b005d33aa46f3amr68898ywb.3.1702414037003; Tue, 12 Dec
 2023 12:47:17 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:26 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-12-sagis@google.com>
Subject: [RFC PATCH v5 11/29] KVM: selftests: TDX: Add basic TDX CPUID test
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>,
        Ryan Afranji <afranji@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Roger Wang <runanwang@google.com>,
        Vipin Sharma <vipinsh@google.com>, jmattson@google.com,
        dmatlack@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org
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

The test reads CPUID values from inside a TD VM and compare them
to expected values.

The test targets CPUID values which are virtualized as "As Configured",
"As Configured (if Native)", "Calculated", "Fixed" and "Native"
according to the TDX spec.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../kvm/include/x86_64/tdx/test_util.h        |   9 ++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  |  11 ++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 106 ++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 95a5d5be7f0b..af0ddbfe8d71 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -9,6 +9,9 @@
 #define TDX_TEST_SUCCESS_PORT 0x30
 #define TDX_TEST_SUCCESS_SIZE 4
 
+#define TDX_TEST_REPORT_PORT 0x31
+#define TDX_TEST_REPORT_SIZE 4
+
 /**
  * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
  * called in the guest.
@@ -102,4 +105,10 @@ void tdx_test_fatal(uint64_t error_code);
  */
 void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
 
+/**
+ * Report a 32 bit value from the guest to user space using TDG.VP.VMCALL
+ * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
+ */
+uint64_t tdx_test_report_to_user_space(uint32_t data);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
index 7f3cd8089cea..55c5a1e634df 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
@@ -42,3 +42,14 @@ void tdx_test_fatal(uint64_t error_code)
 {
 	tdx_test_fatal_with_data(error_code, 0);
 }
+
+uint64_t tdx_test_report_to_user_space(uint32_t data)
+{
+	/* Upcast data to match tdg_vp_vmcall_instruction_io signature */
+	uint64_t data_64 = data;
+
+	return tdg_vp_vmcall_instruction_io(TDX_TEST_REPORT_PORT,
+					TDX_TEST_REPORT_SIZE,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&data_64);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 75467c407ca7..1b30e6f5a569 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include <signal.h>
 #include "kvm_util_base.h"
+#include "processor.h"
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
@@ -155,6 +156,110 @@ void verify_td_ioexit(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies CPUID functionality by reading CPUID values in guest. The guest
+ * will then send the values to userspace using an IO write to be checked
+ * against the expected values.
+ */
+void guest_code_cpuid(void)
+{
+	uint64_t err;
+	uint32_t ebx, ecx;
+
+	/* Read CPUID leaf 0x1 */
+	asm volatile (
+		"cpuid"
+		: "=b" (ebx), "=c" (ecx)
+		: "a" (0x1)
+		: "edx");
+
+	err = tdx_test_report_to_user_space(ebx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(ecx);
+	if (err)
+		tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+
+void verify_td_cpuid(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint32_t ebx, ecx;
+	const struct kvm_cpuid_entry2 *cpuid_entry;
+	uint32_t guest_clflush_line_size;
+	uint32_t guest_max_addressable_ids, host_max_addressable_ids;
+	uint32_t guest_sse3_enabled;
+	uint32_t guest_fma_enabled;
+	uint32_t guest_initial_apic_id;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid);
+	td_finalize(vm);
+
+	printf("Verifying TD CPUID:\n");
+
+	/* Wait for guest to report ebx value */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to report either ecx value or error */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to complete execution */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	/* Verify the CPUID values we got from the guest. */
+	printf("\t ... Verifying CPUID values from guest\n");
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 1, 0);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	host_max_addressable_ids = (cpuid_entry->ebx >> 16) & 0xFF;
+
+	guest_sse3_enabled = ecx & 0x1;  // Native
+	guest_clflush_line_size = (ebx >> 8) & 0xFF;  // Fixed
+	guest_max_addressable_ids = (ebx >> 16) & 0xFF;  // As Configured
+	guest_fma_enabled = (ecx >> 12) & 0x1;  // As Configured (if Native)
+	guest_initial_apic_id = (ebx >> 24) & 0xFF;  // Calculated
+
+	TEST_ASSERT_EQ(guest_sse3_enabled, 1);
+	TEST_ASSERT_EQ(guest_clflush_line_size, 8);
+	TEST_ASSERT_EQ(guest_max_addressable_ids, host_max_addressable_ids);
+
+	/* TODO: This only tests the native value. To properly test
+	 * "As Configured (if Native)" we need to override this value
+	 * in the TD params
+	 */
+	TEST_ASSERT_EQ(guest_fma_enabled, 1);
+
+	/* TODO: guest_initial_apic_id is calculated based on the number of
+	 * VCPUs in the TD. From the spec: "Virtual CPU index, starting from 0
+	 * and allocated sequentially on each successful TDH.VP.INIT"
+	 * To test non-trivial values we either need a TD with multiple VCPUs
+	 * or to pick a different calculated value.
+	 */
+	TEST_ASSERT_EQ(guest_initial_apic_id, 0);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -167,6 +272,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
+	run_in_new_process(&verify_td_cpuid);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog

