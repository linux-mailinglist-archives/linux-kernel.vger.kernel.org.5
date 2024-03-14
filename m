Return-Path: <linux-kernel+bounces-103895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7D87C655
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DC0282DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE218AEA;
	Thu, 14 Mar 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+TvWrqx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322117BCE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458809; cv=none; b=AUHhAjWl+PI65/ftYNhaeXhNJwyDEH2bWu4ixhlkqsyy6xhg079VDHVrrN1YOVgLvT6NZK3FUzrMsXZiKS7sy+WmXwniBvZLQD6pHRnuxVt2ruYN2pjeqvqPgG+dVO5rExd7kN96nmJPSx4OBnyjgo79TcXAoMvcgEZ+x0s3boA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458809; c=relaxed/simple;
	bh=/DFVgwUADJ8044CUozTzdVo66BI55qOtEwmADQ190vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ykutrwyo4pJKPEk484ACBmTtSFEafBEEw6Tb4Hybj01kPkC8pYx+2sRIiBLcyCBqLAVE0w4RspVJZ5zb0bhsxKFfyu6sbRYRNn+yOTav5hQkuDdFe7OblvFXOYsvu6XEA9MjSf1p4/nLjdxS0WzDW74Bjlx7Xxle6/+UKZX/YKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+TvWrqx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so2013090276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458805; x=1711063605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RlUxziw8BSQloGiMQruhCdJKG6uB341JDYak+7wFF+E=;
        b=f+TvWrqx9Qoxu2uez5MEwW7fDmLfzpRcBHwVSFm4GtFcAQq9x5g5BRbphZyPIuOJIT
         dWFpJdv2pKhCgUCkAkJ0iuTDlnHiwTheo3mbXmc7/SnczMSIpBtcwpBxu6GBAfufX0j/
         67noqXvIv1pGqY6QVuOGblkeUNLnqU7mldWWklpYFKtTRlXmVvweWnF1CoumzDcuLz6s
         H4ZB8UYc8rul2y9ZdHPjO3wdGt3R4Za/VAdRTHOMzx41DP+SUf/8dzEMvA7qsB2EBllJ
         X9XcS+2QGVUUYppwLSfLBf596FlZq19H6KYJCIMn1KLoogDFCafL+qtYp01Fj8A3OZzW
         wRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458805; x=1711063605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlUxziw8BSQloGiMQruhCdJKG6uB341JDYak+7wFF+E=;
        b=kVR4LU6GXeQbbOrdFklAWq+5SlWrEn8KJre4cXFTDk/Tm0sTGPZeKwVTRlzZIsQ9lu
         QaNTxd4L7xHi+Q7P+qXvUI3tVYK8u+bl/RPvqM1HhfuW62wVhg7S9ktYYXA0W0TrxCsH
         UmVNNANNs+BHn3G+h/78+bNbBESt+YbS2/ARTd/deNFu0hhftOymsdh3RKuooy9bVpbR
         jVj/T2z6hLPGsd6KtGla2+h9jE3CQn4UFvXlbhE9ZO0WyTA+2PK80pLKJGZvi07H36SU
         fbBxMEYive3GJ9FWGoJf340spE7KU75t9nMgkag3oVyKYR4b0DFyu6kgRkLpBXTq9qzw
         C9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWteZuRzjtS9njS2dFbZCt254eBOR0U5AUyy7DzxlZJ9GfUiaDt1kxY8J8mxIbBJpHd3dXnjpAccKRiCFtJrwkSbkVi3/4JOkcTJBFN
X-Gm-Message-State: AOJu0YyoQ7ujbX+E0y/jVjvTzfYY13xKMR+DFJaP+YHR8pc9jic4+8UL
	JND2kWF9QEr5a4IQuXMcK66+6G9RZqONbHpJFnlhys4CGjt6Usj50DY90miN1e5KbG5kkLpSh97
	xnw==
X-Google-Smtp-Source: AGHT+IH4/ZMXFC2bouhklnoQYb0n6FnYJheuUMSCo2hpU0HMSJmGgKAAvzyEpu0qKMWThNjUG8Cmprp+aaY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b08:b0:dc6:c94e:fb85 with SMTP id
 eh8-20020a0569021b0800b00dc6c94efb85mr188198ybb.2.1710458805679; Thu, 14 Mar
 2024 16:26:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:22 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-4-seanjc@google.com>
Subject: [PATCH 03/18] KVM: selftests: Move GDT, IDT, and TSS fields to x86's kvm_vm_arch
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that kvm_vm_arch exists, move the GDT, IDT, and TSS fields to x86's
implementation, as the structures are firmly x86-only.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 ---
 .../kvm/include/x86_64/kvm_util_arch.h        |  6 +++++
 .../selftests/kvm/lib/x86_64/processor.c      | 22 +++++++++----------
 .../kvm/x86_64/svm_nested_shutdown_test.c     |  2 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c  |  2 +-
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index acdcddf78e3f..58d6a4d6ce4f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -94,9 +94,6 @@ struct kvm_vm {
 	bool pgd_created;
 	vm_paddr_t ucall_mmio_addr;
 	vm_paddr_t pgd;
-	vm_vaddr_t gdt;
-	vm_vaddr_t tss;
-	vm_vaddr_t idt;
 	vm_vaddr_t handlers;
 	uint32_t dirty_ring_size;
 	uint64_t gpa_tag_mask;
diff --git a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
index 9f1725192aa2..b14ff3a88b4a 100644
--- a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
@@ -5,7 +5,13 @@
 #include <stdbool.h>
 #include <stdint.h>
 
+#include "kvm_util_types.h"
+
 struct kvm_vm_arch {
+	vm_vaddr_t gdt;
+	vm_vaddr_t tss;
+	vm_vaddr_t idt;
+
 	uint64_t c_bit;
 	uint64_t s_bit;
 	int sev_fd;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 74a4c736c9ae..45f965c052a1 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -417,7 +417,7 @@ static void kvm_seg_set_unusable(struct kvm_segment *segp)
 
 static void kvm_seg_fill_gdt_64bit(struct kvm_vm *vm, struct kvm_segment *segp)
 {
-	void *gdt = addr_gva2hva(vm, vm->gdt);
+	void *gdt = addr_gva2hva(vm, vm->arch.gdt);
 	struct desc64 *desc = gdt + (segp->selector >> 3) * 8;
 
 	desc->limit0 = segp->limit & 0xFFFF;
@@ -518,21 +518,21 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 
 static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
 {
-	if (!vm->gdt)
-		vm->gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
+	if (!vm->arch.gdt)
+		vm->arch.gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 
-	dt->base = vm->gdt;
+	dt->base = vm->arch.gdt;
 	dt->limit = getpagesize();
 }
 
 static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 				int selector)
 {
-	if (!vm->tss)
-		vm->tss = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
+	if (!vm->arch.tss)
+		vm->arch.tss = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 
 	memset(segp, 0, sizeof(*segp));
-	segp->base = vm->tss;
+	segp->base = vm->arch.tss;
 	segp->limit = 0x67;
 	segp->selector = selector;
 	segp->type = 0xb;
@@ -1091,7 +1091,7 @@ static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
 			  int dpl, unsigned short selector)
 {
 	struct idt_entry *base =
-		(struct idt_entry *)addr_gva2hva(vm, vm->idt);
+		(struct idt_entry *)addr_gva2hva(vm, vm->arch.idt);
 	struct idt_entry *e = &base[vector];
 
 	memset(e, 0, sizeof(*e));
@@ -1144,7 +1144,7 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
 	extern void *idt_handlers;
 	int i;
 
-	vm->idt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
+	vm->arch.idt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 	vm->handlers = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 	/* Handlers have the same address in both address spaces.*/
 	for (i = 0; i < NUM_INTERRUPTS; i++)
@@ -1158,9 +1158,9 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 	struct kvm_sregs sregs;
 
 	vcpu_sregs_get(vcpu, &sregs);
-	sregs.idt.base = vm->idt;
+	sregs.idt.base = vm->arch.idt;
 	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
-	sregs.gdt.base = vm->gdt;
+	sregs.gdt.base = vm->arch.gdt;
 	sregs.gdt.limit = getpagesize() - 1;
 	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
 	vcpu_sregs_set(vcpu, &sregs);
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
index d6fcdcc3af31..f4a1137e04ab 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
@@ -53,7 +53,7 @@ int main(int argc, char *argv[])
 
 	vcpu_alloc_svm(vm, &svm_gva);
 
-	vcpu_args_set(vcpu, 2, svm_gva, vm->idt);
+	vcpu_args_set(vcpu, 2, svm_gva, vm->arch.idt);
 
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index 0c7ce3d4e83a..2478a9e50743 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -166,7 +166,7 @@ static void run_test(bool is_nmi)
 
 		idt_alt_vm = vm_vaddr_alloc_page(vm);
 		idt_alt = addr_gva2hva(vm, idt_alt_vm);
-		idt = addr_gva2hva(vm, vm->idt);
+		idt = addr_gva2hva(vm, vm->arch.idt);
 		memcpy(idt_alt, idt, getpagesize());
 	} else {
 		idt_alt_vm = 0;
-- 
2.44.0.291.gc1ea87d7ee-goog


