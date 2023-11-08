Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F637E4E24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjKHAdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjKHAcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:32:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6341FFA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b59662ff67so2196417b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403533; x=1700008333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=k2UNp8+7yoYn4+LUw6sJaKJMtfEPLdWk0fOhhGx9xpo=;
        b=Iixq3tzORT+IgX0wWdsTYe39XjCfjri+3hqq5sstdz+dasYFEvmohUH+rvLL9STACe
         ej1M4fazP5kxKwlBy4FixDsc5HqRyZjn+SRZOAfS/qprX3iQUboRsemrw+p4GxKSF/41
         i0fOy9vkChzbL5Ry7ZRnKVXC3hx7ZT4dTzKGtW+t/K3xoWn7sUtbHeG31XYVLsfRJVP0
         cx2j4nSNzRlGjddHnjHirc827YGrt25Q+OdbwCApnQJnkR1VCNIVNVtvCRPqJleJdkbh
         jHsFJeOwtkYouduLUK0l1YgtHaVyJlkLTcXv3WUpzZduq+N14LD3sjwg6Xs4k8BLOude
         EKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403533; x=1700008333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2UNp8+7yoYn4+LUw6sJaKJMtfEPLdWk0fOhhGx9xpo=;
        b=JtjfCAam5185CmA+cONc7AicwHquhywG1s6FoHQeLWlPVQZp4DM4EAQF0hKePqKchR
         gQnsV2gVTflujeRfHpzIPhMOcIatBGSRAx36izCvFt2Vm1DewSrMAUPkjUEL25sk/Ydo
         0SKPaVekWWKguVaCnnbPN1ZmEJBocFlr+xT0JSxf5jbHETCgD5IKI1N1owMlhonngimh
         6z1xRHfpxZHM76pin6KP1T6Sbk0Roj+WtkJ8PysnSwsiOAFjgGr8fgVwWhGGKVgvbmOL
         fZ/DiulhbVCtgCoHpYF5qXfgUwqQAp8ynALt9325dRb882tv4NUDAirDZ6YBL2p6DrV3
         IAdw==
X-Gm-Message-State: AOJu0YyS/YpcEQj8iQQD0SRpLsRyGMm+I88QADnLAxnPlgVXgd9xjZ3z
        Bk2GMZtCbqXC6yrkFQJzms+RLn/mdpU=
X-Google-Smtp-Source: AGHT+IHzk92d9DpgEg5k7JHEYJEhj6vZYFUKoC0XOAyUOstvk1Ixla2Mi6+3LwavXr0bE+aGGJ4OR/LJfqU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:d844:0:b0:5b8:d09e:704d with SMTP id
 n4-20020a81d844000000b005b8d09e704dmr99902ywl.1.1699403533438; Tue, 07 Nov
 2023 16:32:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:33 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-18-seanjc@google.com>
Subject: [PATCH v7 17/19] KVM: selftests: Query module param to detect FEP in
 MSR filtering test
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

Add a helper to detect KVM support for forced emulation by querying the
module param, and use the helper to detect support for the MSR filtering
test instead of throwing a noodle/NOP at KVM to see if it sticks.

Cc: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  5 ++++
 .../kvm/x86_64/userspace_msr_exit_test.c      | 27 +++++++------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index c261e0941dfe..8a404faafb21 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1221,6 +1221,11 @@ static inline bool kvm_is_pmu_enabled(void)
 	return get_kvm_param_bool("enable_pmu");
 }
 
+static inline bool kvm_is_forced_emulation_enabled(void)
+{
+	return !!get_kvm_param_integer("force_emulation_prefix");
+}
+
 uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 				    int *level);
 uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr);
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index 3533dc2fbfee..9e12dbc47a72 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -14,8 +14,7 @@
 
 /* Forced emulation prefix, used to invoke the emulator unconditionally. */
 #define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
-#define KVM_FEP_LENGTH 5
-static int fep_available = 1;
+static bool fep_available;
 
 #define MSR_NON_EXISTENT 0x474f4f00
 
@@ -260,13 +259,6 @@ static void guest_code_filter_allow(void)
 	GUEST_ASSERT(data == 2);
 	GUEST_ASSERT(guest_exception_count == 0);
 
-	/*
-	 * Test to see if the instruction emulator is available (ie: the module
-	 * parameter 'kvm.force_emulation_prefix=1' is set).  This instruction
-	 * will #UD if it isn't available.
-	 */
-	__asm__ __volatile__(KVM_FEP "nop");
-
 	if (fep_available) {
 		/* Let userspace know we aren't done. */
 		GUEST_SYNC(0);
@@ -388,12 +380,6 @@ static void guest_fep_gp_handler(struct ex_regs *regs)
 			   &em_wrmsr_start, &em_wrmsr_end);
 }
 
-static void guest_ud_handler(struct ex_regs *regs)
-{
-	fep_available = 0;
-	regs->rip += KVM_FEP_LENGTH;
-}
-
 static void check_for_guest_assert(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
@@ -531,9 +517,11 @@ static void test_msr_filter_allow(void)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
+	uint64_t cmd;
 	int rc;
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code_filter_allow);
+	sync_global_to_guest(vm, fep_available);
 
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
@@ -561,11 +549,11 @@ static void test_msr_filter_allow(void)
 	run_guest_then_process_wrmsr(vcpu, MSR_NON_EXISTENT);
 	run_guest_then_process_rdmsr(vcpu, MSR_NON_EXISTENT);
 
-	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 	vcpu_run(vcpu);
-	vm_install_exception_handler(vm, UD_VECTOR, NULL);
+	cmd = process_ucall(vcpu);
 
-	if (process_ucall(vcpu) != UCALL_DONE) {
+	if (fep_available) {
+		TEST_ASSERT_EQ(cmd, UCALL_SYNC);
 		vm_install_exception_handler(vm, GP_VECTOR, guest_fep_gp_handler);
 
 		/* Process emulated rdmsr and wrmsr instructions. */
@@ -583,6 +571,7 @@ static void test_msr_filter_allow(void)
 		/* Confirm the guest completed without issues. */
 		run_guest_then_process_ucall_done(vcpu);
 	} else {
+		TEST_ASSERT_EQ(cmd, UCALL_DONE);
 		printf("To run the instruction emulated tests set the module parameter 'kvm.force_emulation_prefix=1'\n");
 	}
 
@@ -804,6 +793,8 @@ static void test_user_exit_msr_flags(void)
 
 int main(int argc, char *argv[])
 {
+	fep_available = kvm_is_forced_emulation_enabled();
+
 	test_msr_filter_allow();
 
 	test_msr_filter_deny();
-- 
2.42.0.869.gea05f2083d-goog

