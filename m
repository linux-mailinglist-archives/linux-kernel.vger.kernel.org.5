Return-Path: <linux-kernel+bounces-103900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371387C660
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911BF1F21348
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B452E64E;
	Thu, 14 Mar 2024 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDTv2Mvo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE19250EA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458816; cv=none; b=QP1E7VSLjdWq2ymrv+4DxnlWy6MX3jsywGtEvOlwz3BeZx8R0qBTwabxhA6UleheESx44aSYab8hFfJVHHInkij/FaSNdXdN/CsJhWKLxH7Leuw9OHDAPpW7phBn8A5rKPULZiPrpAmRCvy+IozJst3xDYV0mNuQg8JV3iRVBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458816; c=relaxed/simple;
	bh=D6rTKBL1Fq2w6V4jF48WMytPJlDVkKznNk4kApfQjLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=icmBLMilkUf4blym7SSwNMLCfm9DeXT5OMaMuufQBNjL3YSeKkiA1sgmCZGQhywzlxD9EZz7hF3YBnOrWtFT34pYQ3+xKTjmalCx1KTZSbgbuQWcW4a4yBaT8lcp0F67ZrpchAe7HMz1LpU8i9cr+gy7QU4iNvnh4vFo5X/cRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDTv2Mvo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29deeb2fc13so222637a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458815; x=1711063615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cYt0UxRFPQqzYn7Vpx6g+tvPS4Iw5cklVXoJXhkYY7M=;
        b=tDTv2Mvof4055MZP97Dn14widAMxz8/WUyKDrXg68ZXHge2jfpLyGgWHRPaWxoUYrI
         xMBGRg5NP68qKqMZvK61Stgrk7KmBn3AMl8z7frXsdWZJrE7swR/GJrKDeTpEcnVIu0s
         WgJ5KxXfqWreThiBPYv4T5rBCoQbqI3b+7MzlPSjI4lqwJg633w0CTFLMPEe7pBy7NVj
         oTrKDXzI51uootfMD0bp7Z9ifri4nNwJa1uTvAZcYQOn1QV9rluAvGmZn6zJvYovUINe
         lFHmQZ7GOam4C2Vo2LzhCRMNQ4C+/tC1ZypdnVZQ0s/u1DdR3Ky/uADG+jd+MIZHTBBh
         P49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458815; x=1711063615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYt0UxRFPQqzYn7Vpx6g+tvPS4Iw5cklVXoJXhkYY7M=;
        b=Rmhxwysw4/fVD/n/kgxs3M0HjJAeMbUUQ30Qh8ZN9Ax8vZofmcHNf0OIFZxk5+YVC3
         qCZ4//+Z6YmWdpb6Vf8Deblsw2QHJsmnZ6IL0w/2CmieyWVWmqDO2u+TihTJQEOEDKcC
         rFG0OKaQuPjqs4Sc3YE2mH/tbQ9pZRA891if5LfegcLwSxyxg5DM/muxmYORP+EFHQ0b
         n11+0mkHktlk745tJYpQKanukDwDim/hoa8eQzjymTlUi5a9+h0Z9/Zf33eIKNkzL8ui
         L4WTmzyiDn+WWROmssqaR1ilHMeqwM9DcdKJoHVuHbt0S32z/0dx2dchRI2qYrlPv6pF
         7Wfw==
X-Forwarded-Encrypted: i=1; AJvYcCX+4yqC02DJCWx5fRdFkmq8IEJWsZB4qYNacjQY2P2sxlYbhv1sDIi2hqRmiXIBlk6xECbkdC4PU7Cnf6BII8ZT9R+8jckMGLjs+Ha5
X-Gm-Message-State: AOJu0YxHPZu9kK7nCrKKO07Z0rCyLLG/fjuADTUpaiIO0KVsQc5o/Zcr
	NeZhjEutfyM+zEKyRAR6/WpJA9PQpCY6W3ipHlnkMZS71otKljOI0iAyzOgf82Bse+2AtHUJrwh
	yng==
X-Google-Smtp-Source: AGHT+IFrr0eJ7KJEPLhApMpHRts0gPRzkT9mvlTzswaB+7MaMjHLiz+sM47iUPlzqqkPyfHstCgHwuftTuc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:bc94:b0:29b:c2b7:7d29 with SMTP id
 x20-20020a17090abc9400b0029bc2b77d29mr3418pjr.9.1710458814574; Thu, 14 Mar
 2024 16:26:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:27 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-9-seanjc@google.com>
Subject: [PATCH 08/18] KVM: selftests: Move x86's descriptor table helpers
 "up" in processor.c
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

Move x86's various descriptor table helpers in processor.c up above
kvm_arch_vm_post_create() and vcpu_setup() so that the helpers can be
made static and invoked from the aforementioned functions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c      | 191 +++++++++---------
 1 file changed, 95 insertions(+), 96 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index eaeba907bb53..3640d3290f0a 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -540,6 +540,21 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 	kvm_seg_fill_gdt_64bit(vm, segp);
 }
 
+void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vm *vm = vcpu->vm;
+	struct kvm_sregs sregs;
+
+	vcpu_sregs_get(vcpu, &sregs);
+	sregs.idt.base = vm->arch.idt;
+	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	sregs.gdt.base = vm->arch.gdt;
+	sregs.gdt.limit = getpagesize() - 1;
+	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
+	vcpu_sregs_set(vcpu, &sregs);
+	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+}
+
 static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
@@ -572,6 +587,86 @@ static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_sregs_set(vcpu, &sregs);
 }
 
+static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
+			  int dpl, unsigned short selector)
+{
+	struct idt_entry *base =
+		(struct idt_entry *)addr_gva2hva(vm, vm->arch.idt);
+	struct idt_entry *e = &base[vector];
+
+	memset(e, 0, sizeof(*e));
+	e->offset0 = addr;
+	e->selector = selector;
+	e->ist = 0;
+	e->type = 14;
+	e->dpl = dpl;
+	e->p = 1;
+	e->offset1 = addr >> 16;
+	e->offset2 = addr >> 32;
+}
+
+static bool kvm_fixup_exception(struct ex_regs *regs)
+{
+	if (regs->r9 != KVM_EXCEPTION_MAGIC || regs->rip != regs->r10)
+		return false;
+
+	if (regs->vector == DE_VECTOR)
+		return false;
+
+	regs->rip = regs->r11;
+	regs->r9 = regs->vector;
+	regs->r10 = regs->error_code;
+	return true;
+}
+
+void route_exception(struct ex_regs *regs)
+{
+	typedef void(*handler)(struct ex_regs *);
+	handler *handlers = (handler *)exception_handlers;
+
+	if (handlers && handlers[regs->vector]) {
+		handlers[regs->vector](regs);
+		return;
+	}
+
+	if (kvm_fixup_exception(regs))
+		return;
+
+	ucall_assert(UCALL_UNHANDLED,
+		     "Unhandled exception in guest", __FILE__, __LINE__,
+		     "Unhandled exception '0x%lx' at guest RIP '0x%lx'",
+		     regs->vector, regs->rip);
+}
+
+void vm_init_descriptor_tables(struct kvm_vm *vm)
+{
+	extern void *idt_handlers;
+	int i;
+
+	vm->arch.idt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
+	vm->handlers = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
+	/* Handlers have the same address in both address spaces.*/
+	for (i = 0; i < NUM_INTERRUPTS; i++)
+		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0,
+			DEFAULT_CODE_SELECTOR);
+}
+
+void vm_install_exception_handler(struct kvm_vm *vm, int vector,
+			       void (*handler)(struct ex_regs *))
+{
+	vm_vaddr_t *handlers = (vm_vaddr_t *)addr_gva2hva(vm, vm->handlers);
+
+	handlers[vector] = (vm_vaddr_t)handler;
+}
+
+void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED)
+		REPORT_GUEST_ASSERT(uc);
+}
+
 void kvm_arch_vm_post_create(struct kvm_vm *vm)
 {
 	vm_create_irqchip(vm);
@@ -1087,102 +1182,6 @@ void kvm_init_vm_address_properties(struct kvm_vm *vm)
 	}
 }
 
-static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
-			  int dpl, unsigned short selector)
-{
-	struct idt_entry *base =
-		(struct idt_entry *)addr_gva2hva(vm, vm->arch.idt);
-	struct idt_entry *e = &base[vector];
-
-	memset(e, 0, sizeof(*e));
-	e->offset0 = addr;
-	e->selector = selector;
-	e->ist = 0;
-	e->type = 14;
-	e->dpl = dpl;
-	e->p = 1;
-	e->offset1 = addr >> 16;
-	e->offset2 = addr >> 32;
-}
-
-
-static bool kvm_fixup_exception(struct ex_regs *regs)
-{
-	if (regs->r9 != KVM_EXCEPTION_MAGIC || regs->rip != regs->r10)
-		return false;
-
-	if (regs->vector == DE_VECTOR)
-		return false;
-
-	regs->rip = regs->r11;
-	regs->r9 = regs->vector;
-	regs->r10 = regs->error_code;
-	return true;
-}
-
-void route_exception(struct ex_regs *regs)
-{
-	typedef void(*handler)(struct ex_regs *);
-	handler *handlers = (handler *)exception_handlers;
-
-	if (handlers && handlers[regs->vector]) {
-		handlers[regs->vector](regs);
-		return;
-	}
-
-	if (kvm_fixup_exception(regs))
-		return;
-
-	ucall_assert(UCALL_UNHANDLED,
-		     "Unhandled exception in guest", __FILE__, __LINE__,
-		     "Unhandled exception '0x%lx' at guest RIP '0x%lx'",
-		     regs->vector, regs->rip);
-}
-
-void vm_init_descriptor_tables(struct kvm_vm *vm)
-{
-	extern void *idt_handlers;
-	int i;
-
-	vm->arch.idt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
-	vm->handlers = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
-	/* Handlers have the same address in both address spaces.*/
-	for (i = 0; i < NUM_INTERRUPTS; i++)
-		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0,
-			DEFAULT_CODE_SELECTOR);
-}
-
-void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
-{
-	struct kvm_vm *vm = vcpu->vm;
-	struct kvm_sregs sregs;
-
-	vcpu_sregs_get(vcpu, &sregs);
-	sregs.idt.base = vm->arch.idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
-	sregs.gdt.base = vm->arch.gdt;
-	sregs.gdt.limit = getpagesize() - 1;
-	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
-	vcpu_sregs_set(vcpu, &sregs);
-	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
-}
-
-void vm_install_exception_handler(struct kvm_vm *vm, int vector,
-			       void (*handler)(struct ex_regs *))
-{
-	vm_vaddr_t *handlers = (vm_vaddr_t *)addr_gva2hva(vm, vm->handlers);
-
-	handlers[vector] = (vm_vaddr_t)handler;
-}
-
-void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
-{
-	struct ucall uc;
-
-	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED)
-		REPORT_GUEST_ASSERT(uc);
-}
-
 const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 					       uint32_t function, uint32_t index)
 {
-- 
2.44.0.291.gc1ea87d7ee-goog


