Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3480F843
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjLLUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjLLUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:48:17 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B61985
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:35 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d053953954so30443845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414053; x=1703018853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFFcB69i+m00s0TO+Fs1znX5Nq1xcr5cHosByTfFHVM=;
        b=xGO+KhOZgDjPvgckKjEG04OvN69sQHxRm0lE3Mq02+s5JE+81jnrbvwKWSsjOgsHg7
         QpXEo8Ob9bkSP3TgBBcMGrSVks9VaxXxD6swkEhnhCtSGhjVbdyH0t9Cl4ofk55WemXv
         kv8R9Ho8CNeAxQTeWIANhDl2xcrVNZB1MfRiO6kJD+rHoMPESC+N4sR7n74Nh564Ge6C
         iYQbtqPzPLHlJvLW9kUPzwiQEN0iUEojjmjkEQ2bSz03TTR3IXZ9q/2sgJgrQguueF17
         em/gwPZnpMO9AOXPF4iH7Pq3DJ99xrdiF8ppuYjxzGyM5rpBpZaFUPR43FOq7txuJl/+
         AaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414053; x=1703018853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFFcB69i+m00s0TO+Fs1znX5Nq1xcr5cHosByTfFHVM=;
        b=n1vZR5zp44Nu/k2s1C3szNeeqAI+2OJOR4j1e+/3x/R7TyfyJHBpD9E1A8x/7Rc4ZL
         X4sk8RnC1mop7Hqac+yrkQzRMBuu2dppFsudF4xkNzshJ88XwyaKYitbdKWfViltE5Vd
         dyK8XGr1FMd/nk+DFwVfV9iYD0TwlJosxGBMt9RmsCnvutqvVczN6wGQ2WhnG3bU2HQY
         ESBjKCKpVpUpR7dW984RFM/Bo19IN3OJBpVRPbxMqk/8UqR4pAodMpXB+HO0eVAjRWsd
         Z2T5V2BTTpovfBkKlaLf1xrYDd/f9rcSOnuTpOFI+6Jx5apeFyVnRJsWXoXbKM/IlZ6p
         nZTw==
X-Gm-Message-State: AOJu0YxXTmB8KBB17lvuk9RjgnEakq+ahdbraCUEpSvLvlydLhQSVIQz
        u/f9gwj9PwMgNsMiIv4rICQQ2xSszg==
X-Google-Smtp-Source: AGHT+IEC508mWXKx6m7CJH79a+MfJPBjUzdcb0UDWwXb5fHS7hJ9IPvZVzBed8Sg2EZ6RDjBh2TTTwxBZg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:f54a:b0:1d0:5d31:4672 with SMTP id
 h10-20020a170902f54a00b001d05d314672mr54883plf.5.1702414053405; Tue, 12 Dec
 2023 12:47:33 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:34 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-20-sagis@google.com>
Subject: [RFC PATCH v5 19/29] KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
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

This test issues a CPUID TDVMCALL from inside the guest to get the CPUID
values as seen by KVM.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  4 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 26 +++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 94 +++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 502b670ea699..b13a533234fd 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -8,6 +8,7 @@
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
+#define TDG_VP_VMCALL_INSTRUCTION_CPUID 10
 #define TDG_VP_VMCALL_INSTRUCTION_HLT 12
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
@@ -27,5 +28,8 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 					uint64_t *data_out);
 uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 					uint64_t data_in);
+uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
+					uint32_t *ret_eax, uint32_t *ret_ebx,
+					uint32_t *ret_ecx, uint32_t *ret_edx);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index f4afa09f7e3d..a45e2ceb6eda 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -157,3 +157,29 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
+					uint32_t *ret_eax, uint32_t *ret_ebx,
+					uint32_t *ret_ecx, uint32_t *ret_edx)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_CPUID,
+		.r12 = eax,
+		.r13 = ecx,
+	};
+
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (ret_eax)
+		*ret_eax = args.r12;
+	if (ret_ebx)
+		*ret_ebx = args.r13;
+	if (ret_ecx)
+		*ret_ecx = args.r14;
+	if (ret_edx)
+		*ret_edx = args.r15;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 5e28ba828a92..6935604d768b 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -969,6 +969,99 @@ void verify_mmio_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies CPUID TDVMCALL functionality.
+ * The guest will then send the values to userspace using an IO write to be
+ * checked against the expected values.
+ */
+void guest_code_cpuid_tdcall(void)
+{
+	uint64_t err;
+	uint32_t eax, ebx, ecx, edx;
+
+	// Read CPUID leaf 0x1 from host.
+	err = tdg_vp_vmcall_instruction_cpuid(/*eax=*/1, /*ecx=*/0,
+					&eax, &ebx, &ecx, &edx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(eax);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(ebx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(ecx);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_to_user_space(edx);
+	if (err)
+		tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+
+void verify_td_cpuid_tdcall(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint32_t eax, ebx, ecx, edx;
+	const struct kvm_cpuid_entry2 *cpuid_entry;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid_tdcall);
+	td_finalize(vm);
+
+	printf("Verifying TD CPUID TDVMCALL:\n");
+
+	/* Wait for guest to report CPUID values */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	eax = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	edx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 1, 0);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	TEST_ASSERT_EQ(cpuid_entry->eax, eax);
+	// Mask lapic ID when comparing ebx.
+	TEST_ASSERT_EQ(cpuid_entry->ebx & ~0xFF000000, ebx & ~0xFF000000);
+	TEST_ASSERT_EQ(cpuid_entry->ecx, ecx);
+	TEST_ASSERT_EQ(cpuid_entry->edx, edx);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -990,6 +1083,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
 	run_in_new_process(&verify_mmio_writes);
+	run_in_new_process(&verify_td_cpuid_tdcall);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog

