Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545D580F872
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377445AbjLLUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjLLUv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:51:29 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F01FF3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:50 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d34350cbe8so5837095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414069; x=1703018869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8feJMu0CtGp4ESzuqj7WG5RYqMN4mFy6cD8e9ssBGqo=;
        b=HG7qWmwOXlgGGrGmadgOGxTDdB6wfYfUPjxfngvGkMMtJdwcreFxAbjlfOdytkAt15
         BYiMCw+AaC3Z4w0Dadd6/3K0R0paVsCLysXD9uYgyZjDIa5zDIBON1xFuX1x76bTXXi6
         Sof4Q6CrD746kmf/6zy0IJexGJBCZ8YhubxX65V5gTkN3MLAN7A+Ltt9DFuODazli9IQ
         0xOcl7jxiswx1raoQgsg8dyKunpkGZufi1g3ojYtE7CAABmq1SlkJa24rqVmpALh1/RO
         Jist/xPz8TT/50R6+bFowY8hts1s0iDbo6HfZruKUdkFnmb6lga6D8eT/BKC+DKItapb
         fusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414069; x=1703018869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8feJMu0CtGp4ESzuqj7WG5RYqMN4mFy6cD8e9ssBGqo=;
        b=uz8xEMV32nD4RAb2/5L4LwHny5y7RVpiCDQfODMsLfnZNa4lDMmZUhzjHXVWxZJ7+O
         F2isuct4rsPDsEg3iLd7kr5WztPURtms1OnEL+XXmbZGnXLPyxblg0FYomW67RAGHWdT
         2qJIVWr44+4GwgQdRqUa1vrLDCI6+P10oemGdxNLHzIbqD7Hsg5mxUgGKI6Hdd6yu+IJ
         GLBY3nuzWGFUiaqB5aLu8+bKdvkh6UyS09SWw5jBYoBh5SQ6k7rA7HNU0bsKAG6Y1aYf
         Yxv6flgrHDAD13AbW8eK9os0WWcDtb6ah7rkuWtW8BosVAcT6KYDuXn7voFRz1MnkYBy
         evGg==
X-Gm-Message-State: AOJu0YxksaUuIxB6Dt6rDQven0cw3UlBgbHPEb9GaGKI4WUF8/8W9ULE
        k4tob7JQMRUTZSI3RkFeU9VFI2z+eQ==
X-Google-Smtp-Source: AGHT+IFSk4F5+db5SoAoHbJjlttnLeiqRFEHGfqkJz5ocdw6pONiskwlwErk+BrOwZyHXHpPwhjJrT5LdQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:903:41cf:b0:1d0:80cd:4c44 with SMTP id
 u15-20020a17090341cf00b001d080cd4c44mr51797ple.10.1702414069034; Tue, 12 Dec
 2023 12:47:49 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:43 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-29-sagis@google.com>
Subject: [RFC PATCH v5 28/29] KVM: selftests: TDX: Add TDX UPM selftest
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

From: Ackerley Tng <ackerleytng@google.com>

This tests the use of guest memory with explicit MapGPA calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/tdx_upm_test.c       | 401 ++++++++++++++++++
 2 files changed, 402 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_upm_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 8c0a6b395ee5..2f2669af15d6 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -157,6 +157,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
 TEST_GEN_PROGS_x86_64 += x86_64/tdx_shared_mem_test
+TEST_GEN_PROGS_x86_64 += x86_64/tdx_upm_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
new file mode 100644
index 000000000000..44671874a4f1
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/kvm.h>
+#include <asm/vmx.h>
+#include <linux/kvm.h>
+#include <stdbool.h>
+#include <stdint.h>
+
+#include "kvm_util_base.h"
+#include "processor.h"
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include "test_util.h"
+
+/* TDX UPM test patterns */
+#define PATTERN_CONFIDENCE_CHECK (0x11)
+#define PATTERN_HOST_FOCUS (0x22)
+#define PATTERN_GUEST_GENERAL (0x33)
+#define PATTERN_GUEST_FOCUS (0x44)
+
+/*
+ * 0x80000000 is arbitrarily selected. The selected address need not be the same
+ * as TDX_UPM_TEST_AREA_GVA_PRIVATE, but it should not overlap with selftest
+ * code or boot page.
+ */
+#define TDX_UPM_TEST_AREA_GPA (0x80000000)
+/* Test area GPA is arbitrarily selected */
+#define TDX_UPM_TEST_AREA_GVA_PRIVATE (0x90000000)
+/* Select any bit that can be used as a flag */
+#define TDX_UPM_TEST_AREA_GVA_SHARED_BIT (32)
+/*
+ * TDX_UPM_TEST_AREA_GVA_SHARED is used to map the same GPA twice into the
+ * guest, once as shared and once as private
+ */
+#define TDX_UPM_TEST_AREA_GVA_SHARED				\
+	(TDX_UPM_TEST_AREA_GVA_PRIVATE |			\
+		BIT_ULL(TDX_UPM_TEST_AREA_GVA_SHARED_BIT))
+
+/* The test area is 2MB in size */
+#define TDX_UPM_TEST_AREA_SIZE (2 << 20)
+/* 0th general area is 1MB in size */
+#define TDX_UPM_GENERAL_AREA_0_SIZE (1 << 20)
+/* Focus area is 40KB in size */
+#define TDX_UPM_FOCUS_AREA_SIZE (40 << 10)
+/* 1st general area is the rest of the space in the test area */
+#define TDX_UPM_GENERAL_AREA_1_SIZE				\
+	(TDX_UPM_TEST_AREA_SIZE - TDX_UPM_GENERAL_AREA_0_SIZE -	\
+		TDX_UPM_FOCUS_AREA_SIZE)
+
+/*
+ * The test memory area is set up as two general areas, sandwiching a focus
+ * area.  The general areas act as control areas. After they are filled, they
+ * are not expected to change throughout the tests. The focus area is memory
+ * permissions change from private to shared and vice-versa.
+ *
+ * The focus area is intentionally small, and sandwiched to test that when the
+ * focus area's permissions change, the other areas' permissions are not
+ * affected.
+ */
+struct __packed tdx_upm_test_area {
+	uint8_t general_area_0[TDX_UPM_GENERAL_AREA_0_SIZE];
+	uint8_t focus_area[TDX_UPM_FOCUS_AREA_SIZE];
+	uint8_t general_area_1[TDX_UPM_GENERAL_AREA_1_SIZE];
+};
+
+static void fill_test_area(struct tdx_upm_test_area *test_area_base,
+			uint8_t pattern)
+{
+	memset(test_area_base, pattern, sizeof(*test_area_base));
+}
+
+static void fill_focus_area(struct tdx_upm_test_area *test_area_base,
+			    uint8_t pattern)
+{
+	memset(test_area_base->focus_area, pattern,
+	       sizeof(test_area_base->focus_area));
+}
+
+static bool check_area(uint8_t *base, uint64_t size, uint8_t expected_pattern)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++) {
+		if (base[i] != expected_pattern)
+			return false;
+	}
+
+	return true;
+}
+
+static bool check_general_areas(struct tdx_upm_test_area *test_area_base,
+				uint8_t expected_pattern)
+{
+	return (check_area(test_area_base->general_area_0,
+			   sizeof(test_area_base->general_area_0),
+			   expected_pattern) &&
+		check_area(test_area_base->general_area_1,
+			   sizeof(test_area_base->general_area_1),
+			   expected_pattern));
+}
+
+static bool check_focus_area(struct tdx_upm_test_area *test_area_base,
+			     uint8_t expected_pattern)
+{
+	return check_area(test_area_base->focus_area,
+			  sizeof(test_area_base->focus_area), expected_pattern);
+}
+
+static bool check_test_area(struct tdx_upm_test_area *test_area_base,
+			    uint8_t expected_pattern)
+{
+	return (check_general_areas(test_area_base, expected_pattern) &&
+		check_focus_area(test_area_base, expected_pattern));
+}
+
+static bool fill_and_check(struct tdx_upm_test_area *test_area_base, uint8_t pattern)
+{
+	fill_test_area(test_area_base, pattern);
+
+	return check_test_area(test_area_base, pattern);
+}
+
+#define TDX_UPM_TEST_ASSERT(x)				\
+	do {						\
+		if (!(x))				\
+			tdx_test_fatal(__LINE__);	\
+	} while (0)
+
+/*
+ * Shared variables between guest and host
+ */
+static struct tdx_upm_test_area *test_area_gpa_private;
+static struct tdx_upm_test_area *test_area_gpa_shared;
+
+/*
+ * Test stages for syncing with host
+ */
+enum {
+	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST = 1,
+	SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST,
+	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN,
+};
+
+#define TDX_UPM_TEST_ACCEPT_PRINT_PORT 0x87
+
+/**
+ * Does vcpu_run, and also manages memory conversions if requested by the TD.
+ */
+void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
+					    struct kvm_vcpu *vcpu)
+{
+	for (;;) {
+		vcpu_run(vcpu);
+		if (vcpu->run->exit_reason == KVM_EXIT_TDX &&
+			vcpu->run->tdx.type == KVM_EXIT_TDX_VMCALL &&
+			vcpu->run->tdx.u.vmcall.subfunction == TDG_VP_VMCALL_MAP_GPA) {
+			struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
+			uint64_t gpa = vmcall_info->in_r12 & ~vm->arch.s_bit;
+
+			handle_memory_conversion(vm, gpa, vmcall_info->in_r13,
+				!(vm->arch.s_bit & vmcall_info->in_r12));
+			vmcall_info->status_code = 0;
+			continue;
+		} else if (
+			vcpu->run->exit_reason == KVM_EXIT_IO &&
+			vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
+			uint64_t gpa = tdx_test_read_64bit(
+				vcpu, TDX_UPM_TEST_ACCEPT_PRINT_PORT);
+			printf("\t ... guest accepting 1 page at GPA: 0x%lx\n", gpa);
+			continue;
+		}
+
+		break;
+	}
+}
+
+static void guest_upm_explicit(void)
+{
+	uint64_t ret = 0;
+	uint64_t failed_gpa;
+
+	struct tdx_upm_test_area *test_area_gva_private =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
+	struct tdx_upm_test_area *test_area_gva_shared =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
+
+	/* Check: host reading private memory does not modify guest's view */
+	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	TDX_UPM_TEST_ASSERT(
+		check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Remap focus area as shared */
+	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_shared->focus_area,
+				    sizeof(test_area_gpa_shared->focus_area),
+				    &failed_gpa);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/*
+	 * Use memory contents to confirm that the memory allocated using mmap
+	 * is used as backing memory for shared memory - PATTERN_CONFIDENCE_CHECK
+	 * was written by the VMM at the beginning of this test.
+	 */
+	TDX_UPM_TEST_ASSERT(
+		check_focus_area(test_area_gva_shared, PATTERN_CONFIDENCE_CHECK));
+
+	/* Guest can use focus area after remapping as shared */
+	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	/* Check that guest has the same view of shared memory */
+	TDX_UPM_TEST_ASSERT(
+		check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
+
+	/* Remap focus area back to private */
+	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_private->focus_area,
+				    sizeof(test_area_gpa_private->focus_area),
+				    &failed_gpa);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(
+		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Focus area should be zeroed after remapping */
+	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_private, 0));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	/* Check that guest can use private memory after focus area is remapped as private */
+	TDX_UPM_TEST_ASSERT(
+		fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_success();
+}
+
+static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+			 struct tdx_upm_test_area *test_area_base_hva)
+{
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	/*
+	 * Check that host should read PATTERN_CONFIDENCE_CHECK from guest's
+	 * private memory. This confirms that regular memory (userspace_addr in
+	 * struct kvm_userspace_memory_region) is used to back the host's view
+	 * of private memory, since PATTERN_CONFIDENCE_CHECK was written to that
+	 * memory before starting the guest.
+	 */
+	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
+
+	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		  SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_GUEST_FOCUS),
+		"Host should have the same view of shared memory as guest.");
+	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Host's view of private memory should still be backed by regular memory.");
+
+	/* Check that host can use shared memory */
+	fill_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS);
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
+		    "Host should be able to use shared memory.");
+
+	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
+		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Host's view of private memory should be backed by regular memory.");
+	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
+		"Host's view of private memory should be backed by regular memory.");
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	printf("\t ... PASSED\n");
+}
+
+static bool address_between(uint64_t addr, void *lo, void *hi)
+{
+	return (uint64_t)lo <= addr && addr < (uint64_t)hi;
+}
+
+static void guest_ve_handler(struct ex_regs *regs)
+{
+	uint64_t ret;
+	struct ve_info ve;
+
+	ret = tdg_vp_veinfo_get(&ve);
+	TDX_UPM_TEST_ASSERT(!ret);
+
+	/* For this test, we will only handle EXIT_REASON_EPT_VIOLATION */
+	TDX_UPM_TEST_ASSERT(ve.exit_reason == EXIT_REASON_EPT_VIOLATION);
+
+	/* Validate GPA in fault */
+	TDX_UPM_TEST_ASSERT(
+		address_between(ve.gpa,
+				test_area_gpa_private->focus_area,
+				test_area_gpa_private->general_area_1));
+
+	tdx_test_send_64bit(TDX_UPM_TEST_ACCEPT_PRINT_PORT, ve.gpa);
+
+#define MEM_PAGE_ACCEPT_LEVEL_4K 0
+#define MEM_PAGE_ACCEPT_LEVEL_2M 1
+	ret = tdg_mem_page_accept(ve.gpa, MEM_PAGE_ACCEPT_LEVEL_4K);
+	TDX_UPM_TEST_ASSERT(!ret);
+}
+
+static void verify_upm_test(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm_vaddr_t test_area_gva_private;
+	struct tdx_upm_test_area *test_area_base_hva;
+	uint64_t test_area_npages;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
+
+	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
+
+	/*
+	 * Set up shared memory page for testing by first allocating as private
+	 * and then mapping the same GPA again as shared. This way, the TD does
+	 * not have to remap its page tables at runtime.
+	 */
+	test_area_npages = TDX_UPM_TEST_AREA_SIZE / vm->page_size;
+	vm_userspace_mem_region_add(vm,
+				    VM_MEM_SRC_ANONYMOUS, TDX_UPM_TEST_AREA_GPA,
+				    3, test_area_npages, KVM_MEM_PRIVATE);
+
+	test_area_gva_private = ____vm_vaddr_alloc(
+		vm, TDX_UPM_TEST_AREA_SIZE, TDX_UPM_TEST_AREA_GVA_PRIVATE,
+		TDX_UPM_TEST_AREA_GPA, 3, true);
+	TEST_ASSERT_EQ(test_area_gva_private, TDX_UPM_TEST_AREA_GVA_PRIVATE);
+
+	test_area_gpa_private = (struct tdx_upm_test_area *)
+		addr_gva2gpa(vm, test_area_gva_private);
+	virt_map_shared(vm, TDX_UPM_TEST_AREA_GVA_SHARED,
+			(uint64_t)test_area_gpa_private,
+			test_area_npages);
+	TEST_ASSERT_EQ(addr_gva2gpa(vm, TDX_UPM_TEST_AREA_GVA_SHARED),
+		  (vm_paddr_t)test_area_gpa_private);
+
+	test_area_base_hva = addr_gva2hva(vm, TDX_UPM_TEST_AREA_GVA_PRIVATE);
+
+	TEST_ASSERT(fill_and_check(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
+		"Failed to mark memory intended as backing memory for TD shared memory");
+
+	sync_global_to_guest(vm, test_area_gpa_private);
+	test_area_gpa_shared = (struct tdx_upm_test_area *)
+		((uint64_t)test_area_gpa_private | BIT_ULL(vm->pa_bits - 1));
+	sync_global_to_guest(vm, test_area_gpa_shared);
+
+	td_finalize(vm);
+
+	printf("Verifying UPM functionality: explicit MapGPA\n");
+
+	run_selftest(vm, vcpu, test_area_base_hva);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	/* Disable stdout buffering */
+	setbuf(stdout, NULL);
+
+	if (!is_tdx_enabled()) {
+		printf("TDX is not supported by the KVM\n"
+		       "Skipping the TDX tests.\n");
+		return 0;
+	}
+
+	run_in_new_process(&verify_upm_test);
+}
-- 
2.43.0.472.g3155946c3a-goog

