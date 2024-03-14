Return-Path: <linux-kernel+bounces-103700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF787C320
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583AF1F2510F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607BC74E29;
	Thu, 14 Mar 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01U4SkH4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3776045
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442509; cv=none; b=tGN80eahdMoiYPjzVSUhHdjBV+xPKmC+vTeYkxH+O8hP0/bYNy6nGw2hPY+54Ppny0OxrKqB2lhIQ3iaCNVSzaVcoKG7OSN8+jUMl8Ac37XeHM0EltmWIJcgSj2UvIspuQr/nFOtbJBnnZ6nh8oBklsAFlbosrEwEfJ2Je5kVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442509; c=relaxed/simple;
	bh=fSwPPzmsRz/TgahTC4xFleLaimU9HNgia1ALtn+LPvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b2KNn8uZ6Stp5F7MCiF9QwNpiJRI1V6jaVf/IaBGkCcVBlaRmGEy3VuXZji7H8K5S3O96AR20/1mAopZK1Ixc2LNzKMMEQhMkrSiyL2uOJj6z1glTJYXLZdBtIH6YkMGaXrmCWZwKYQH6hofmqIpyT8FWWlgQygsFD0PUmPHjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01U4SkH4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so2140435276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710442507; x=1711047307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VbXUdBanzmQlcr1pluWbD2KPY1+lV9seEY77FVlY+o0=;
        b=01U4SkH4xybtGVPXPMl3N7LndttGH0Y1Qm7RF2S6xluKthfJp/UvsReNww/k+sNYET
         m7LEzD+6xuRee7VlHfPLnWPbSqgcUSyGNN+XXfloDF0QtGGejfg+9RcUN6Def4df8M31
         Rl3JYMJ+thrFXWADNgKn5QOxh9v8ju2hg286miWlvCyNUmDzWTdgkubb/5na+aO6pLkH
         kreczGEkVTtAnoohfev7wMDtaCNq+W8ZXCHS1y7CBgylImKVtAQ4ht/Gpl6XDXrpp15B
         Y5Gse4dO3LzcXd+xCMJ15tWhjpuQ4WJL4LLgeaQuILcNfCmSJmXKIhnjtn2xi1A29Wo3
         cuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442507; x=1711047307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbXUdBanzmQlcr1pluWbD2KPY1+lV9seEY77FVlY+o0=;
        b=J5FYFKyXPRgDjrRVm7TrPeRX5iKqTGunU51wJQktknylV5qb2zINozKAhEZyF1I9EE
         XCL8DW5tlQ+8LoJezLMJtMtgNOt5HBj/Anu6O76kwNjT9KyEt4TYT7hu4t/EjvQEzwgi
         N6ce5E5w2KHJyJXAJEx9aZLGNxw4GJmB8uyQ4YeAIcx/m34qn25QYrT1+E3PfBIaX7ko
         1OBN+PX5LDr5YAesvm+zPk+j0Cb7Uup/hIlIHNF+T+TxlXlJ1KRKlxVNLIY+VyT3jhlW
         ubSxO6xa5duVLW414gIPF91vZyzJa+DyyNHzvonYtJnoSoFfHgAYJ5MovcylxbR3MRMq
         +T+A==
X-Forwarded-Encrypted: i=1; AJvYcCWvDYeLwdv5jEaRP1dwua2n4dO69PEK9HN7EPW/K4Inph4evBIWGk1cLV0zar4O4qFSsGg+CVOVTNVkRu3H4W99A2937VChKMUWiQHd
X-Gm-Message-State: AOJu0YxYt/EJplN7KliUAE1ee5PhzchtPdUbPN9/S/ufqIAII8PaxX5K
	316Yi8GlgGx/peU+Nnmhx00lSC99JjEKubnQQg/e/+F4XvmDLhtuDSYE13JvNm55f83BeJAfbud
	X+w==
X-Google-Smtp-Source: AGHT+IEZ1OSipPSTe0kz7Kmt0BvaB8Qd172jYpkSyu+Jxyc/YLpAFg+WYFLQGLhtIK+ZYeLsJcygKAry7Dg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1502:b0:dc6:e823:9edb with SMTP id
 q2-20020a056902150200b00dc6e8239edbmr29ybu.12.1710442507014; Thu, 14 Mar 2024
 11:55:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 11:54:56 -0700
In-Reply-To: <20240314185459.2439072-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314185459.2439072-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314185459.2439072-4-seanjc@google.com>
Subject: [PATCH 3/5] KVM: selftests: Add global snapshot of kvm_is_forced_emulation_enabled()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a global snapshot of kvm_is_forced_emulation_enabled() and sync it to
all VMs by default so that core library code can force emulation, e.g. to
allow for easier testing of the intersections between emulation and other
features in KVM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/kvm_util_arch.h       |  2 ++
 tools/testing/selftests/kvm/lib/x86_64/processor.c     |  3 +++
 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c |  3 ---
 .../selftests/kvm/x86_64/userspace_msr_exit_test.c     | 10 ++--------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
index 9f1725192aa2..41aba476640a 100644
--- a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
@@ -5,6 +5,8 @@
 #include <stdbool.h>
 #include <stdint.h>
 
+extern bool is_forced_emulation_enabled;
+
 struct kvm_vm_arch {
 	uint64_t c_bit;
 	uint64_t s_bit;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 74a4c736c9ae..452d092ae050 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -23,6 +23,7 @@
 vm_vaddr_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;
+bool is_forced_emulation_enabled;
 
 static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
@@ -577,6 +578,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	vm_create_irqchip(vm);
 	sync_global_to_guest(vm, host_cpu_is_intel);
 	sync_global_to_guest(vm, host_cpu_is_amd);
+	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
 	if (vm->subtype == VM_SUBTYPE_SEV)
 		sev_vm_init(vm);
@@ -1344,6 +1346,7 @@ void kvm_selftest_arch_init(void)
 {
 	host_cpu_is_intel = this_cpu_is_intel();
 	host_cpu_is_amd = this_cpu_is_amd();
+	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 }
 
 bool sys_clocksource_is_based_on_tsc(void)
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 29609b52f8fa..7f7d4348e85c 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -21,7 +21,6 @@
 
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
-static bool is_forced_emulation_enabled;
 
 static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 						  void *guest_code,
@@ -35,7 +34,6 @@ static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 	vcpu_init_descriptor_tables(*vcpu);
 
 	sync_global_to_guest(vm, kvm_pmu_version);
-	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
 	/*
 	 * Set PERF_CAPABILITIES before PMU version as KVM disallows enabling
@@ -612,7 +610,6 @@ int main(int argc, char *argv[])
 
 	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
-	is_forced_emulation_enabled = kvm_is_forced_emulation_enabled();
 
 	test_intel_counters();
 
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index f4f61a2d2464..69917bde69dc 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -13,8 +13,6 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
-static bool fep_available;
-
 #define MSR_NON_EXISTENT 0x474f4f00
 
 static u64 deny_bits = 0;
@@ -258,7 +256,7 @@ static void guest_code_filter_allow(void)
 	GUEST_ASSERT(data == 2);
 	GUEST_ASSERT(guest_exception_count == 0);
 
-	if (fep_available) {
+	if (is_forced_emulation_enabled) {
 		/* Let userspace know we aren't done. */
 		GUEST_SYNC(0);
 
@@ -520,8 +518,6 @@ KVM_ONE_VCPU_TEST(user_msr, msr_filter_allow, guest_code_filter_allow)
 	uint64_t cmd;
 	int rc;
 
-	sync_global_to_guest(vm, fep_available);
-
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
 	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
@@ -551,7 +547,7 @@ KVM_ONE_VCPU_TEST(user_msr, msr_filter_allow, guest_code_filter_allow)
 	vcpu_run(vcpu);
 	cmd = process_ucall(vcpu);
 
-	if (fep_available) {
+	if (is_forced_emulation_enabled) {
 		TEST_ASSERT_EQ(cmd, UCALL_SYNC);
 		vm_install_exception_handler(vm, GP_VECTOR, guest_fep_gp_handler);
 
@@ -774,7 +770,5 @@ KVM_ONE_VCPU_TEST(user_msr, user_exit_msr_flags, NULL)
 
 int main(int argc, char *argv[])
 {
-	fep_available = kvm_is_forced_emulation_enabled();
-
 	return test_harness_run(argc, argv);
 }
-- 
2.44.0.291.gc1ea87d7ee-goog


