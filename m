Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956877625A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjGYWEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjGYWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A226A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:02:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d0d27cd9db9so577852276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322542; x=1690927342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPrItVFfOA+QxaSM3H7aj2euV9UftrIgRmfyaO4sOoo=;
        b=MLKZ3833ppB6gji3U5na3t0bXj9VlUkW3P8HaVKyqBk37iF8eDfTdxxMVsZht9/YHD
         Rfa7AP+Ynpl8luzTj/ue5RDSG10cZem9v+JX1nu7Hsw8YhEkmFwjhtItldEAReGrdvOA
         rm9DBetfx5MpsBllR+GfNae/qYPHkn6pBa8Vlejyo2gsbxugfPVz5d//Tu+dANZgxXIc
         /m3u76EPqjEVozHZvKAFq+qK1Sm+VAArMwpSD7X2vPj9GWGmfZ5JECErjhpl6f2a+1BD
         KO/bUo/xOlq3DqS0ytdmiVbnWmBnarYIPrqjxtvIFoBEPflYwnM94K2Jj6/8Z8Vq6uG7
         GwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322542; x=1690927342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPrItVFfOA+QxaSM3H7aj2euV9UftrIgRmfyaO4sOoo=;
        b=e1Z8lbMnKBhayzOHlZpHJ1eLKt2fSoYij06a/5BYsff2WL4x4wT2B/oZlHNCdqYqHH
         jbjl+Fk49hD/et+UEmb3M+JvS3zMlSzV6dsPeFfMJcbjdcXt4EWoXhTJ10ilP/kjQ1Jg
         Js1oTkbXi5KS4fEgNKnCpfaw14FI0vJnZ/rKTsd+b0CgizL56Pd0MHGiPd+hS5JAx5Di
         0TWVGsMFXNDzuY2zZwwuaaLmGPitLoU3/dYGRrZhydvLpJLF78flWjYmWQUXjjU5Us9u
         IbLIuj2gM56z6CjdjIimcOoHbm17WDXb78P0UAVhs8vvYROFiV7x+3cHpBFRDdAvbrUg
         AFfA==
X-Gm-Message-State: ABy/qLZSEXsA2QAlu2kDCFQBu7phmWutxkZ8cq0qlL+uublEcBq2hICz
        raeVw8lw8iQ9VTAul+snhn8P4LZJLUlX
X-Google-Smtp-Source: APBJJlFxgYiETJSP+DJ3KysP+/mDXMsnWB2PiOVU7SwOZQuKYNDMR4VH4UlPiliVQnHQj5BNTqsiXaxmkyOC
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:482:0:b0:d08:95:76d with SMTP id
 124-20020a250482000000b00d080095076dmr3767ybe.6.1690322542481; Tue, 25 Jul
 2023 15:02:22 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:11 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-19-afranji@google.com>
Subject: [PATCH v4 18/28] KVM: selftests: TDX: Add TDX MMIO writes test
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test verifies MMIO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I6586906e279ef896649a77be81c688e4832629cb
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 14 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 13ce60df5684..502b670ea699 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -25,5 +25,7 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
 uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 					uint64_t *data_out);
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					uint64_t data_in);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index b19f07ebc0e7..f4afa09f7e3d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -143,3 +143,17 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					uint64_t data_in)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE,
+		.r14 = address,
+		.r15 = data_in,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 88cb219ae9b4..79fe56c1052d 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -885,6 +885,90 @@ void verify_mmio_reads(void)
 	printf("\t ... PASSED\n");
 }
 
+void guest_mmio_writes(void)
+{
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 1, 0x12);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 2, 0x1234);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 4, 0x12345678);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 8, 0x1234567890ABCDEF);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	// Write across page boundary.
+	ret = tdg_vp_vmcall_ve_request_mmio_write(PAGE_SIZE - 1, 8, 0);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+/*
+ * Varifies guest MMIO writes.
+ */
+void verify_mmio_writes(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint8_t byte_1;
+	uint16_t byte_2;
+	uint32_t byte_4;
+	uint64_t byte_8;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_mmio_writes);
+	td_finalize(vm);
+
+	printf("Verifying TD MMIO writes:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_1 = *(uint8_t *)(vcpu->run->mmio.data);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_2 = *(uint16_t *)(vcpu->run->mmio.data);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_4 = *(uint32_t *)(vcpu->run->mmio.data);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_8 = *(uint64_t *)(vcpu->run->mmio.data);
+
+	ASSERT_EQ(byte_1, 0x12);
+	ASSERT_EQ(byte_2, 0x1234);
+	ASSERT_EQ(byte_4, 0x12345678);
+	ASSERT_EQ(byte_8, 0x1234567890ABCDEF);
+
+	td_vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -905,6 +989,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
+	run_in_new_process(&verify_mmio_writes);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

