Return-Path: <linux-kernel+bounces-103907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ADC87C66E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D50B1C21675
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A4E5733D;
	Thu, 14 Mar 2024 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ReKB1Qn2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097254FA7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458830; cv=none; b=gWm9JWCwDvZJuBBTGIHY6medieKxp3xP2+wfz6+sLojxaRWj94SVt1MqiPOmlx1UEREpmKL2u4F3xyLM6kFQX1bL5if9OQYxGJdWCyYjaVGPYeoft+hZbFrDeipHSz3DuxykphwMpWOc9cTxstkbN8k5bAkHi3W/dm/ZgpVMVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458830; c=relaxed/simple;
	bh=jUV1XZXOApDn8WUrRGJsIujEhPRAE62JvDa/WRT16zw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9Hwntw52di28OYqoXRa9Tj/cNYkqgimCG95MyBYdOhaV7zALR1/FIWQP6MxvjaykR+YdMbDM8KDswaCsvtp4Oo9+TDxJdjkIZDKvg+qGIXwRbSAdfz+vmbqhb5OhJjzgEXnQnvpkPfNDIJQLFd0Pr3RCqt5pjKrO/MXrTwEOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ReKB1Qn2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so2618220276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458828; x=1711063628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uF6G18lAXQi7SGjNgTcxotaL8n8pv6tjDstW0Eyh3/8=;
        b=ReKB1Qn2+k9AbxeqOKDN15hZigiNAx4WBg47yVUrPgZ996NzhhQqOptjWcfpVPTPio
         lRkMdf9UykW4zGTBTzW10IS7BowxAtBwgSrNihTarK2kV0jUvW0BrI0oWKHrFsDjmtX0
         UEIIvioN5dm0sYs44R1joQ4oBrgrgr+r4i33+y5PzYXpJhG/D90UqJFt9YB0A/p0b/yz
         beyrI4dd0QzJ0VzK5z3QhGzi1yxo4Nxka5zDSwojvsw57mXibBRYOkkyb1Gc1ZqhLC89
         9gfEUSYnjQyTF8OBBA3bnPU2ge7WRoJa4ryjGe+i+QVxO8XYcOgGmhjX9d056olnjryk
         ujjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458828; x=1711063628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uF6G18lAXQi7SGjNgTcxotaL8n8pv6tjDstW0Eyh3/8=;
        b=ViAA2/63VLMNm93xkIUCgT8UQ8tpfnREjUglHVesugOhsqMWG+KkZUMhIBWzJhtWfb
         ExQcCk4vXv0jT26KU7VJpZHV61QLq9GjpGZr+LmA/dPrf2Hy8C/gfoF0gaErvbm2IoE4
         da5S4nCg7JCk1BX6Fr/SCScrenUvl+XgK63+No1Ff1KBX2dPKU6Uqi8gI4QbsxHA/mao
         r4TkeOFDAmNGHcSamO7YZ5gFbU0JPHMKBVCe0JUWnTBxUAgzE3wBRnk3khlRRHsUlmRm
         PAppK2dQs2hu8s/sgbk19UdolRZQ3pZyFWca2BBP3llWdsP8VVIbKZN7008HYfbJkU2q
         Ormw==
X-Forwarded-Encrypted: i=1; AJvYcCU8jm6i+izLFatBeowehpmprjZIJTfS5NqIpQUS4LzSS5qdo+YwJ5/9hLFPl4XLkLyFooDoir08o1gPmC1cnZBBNs1I74+25MNvlNfg
X-Gm-Message-State: AOJu0Yy0mDliv6aZfolznkVxWqZw+OGRfmI+VRra2+49/LTVhj9wc0dE
	HfN+TPxPjlt9m7FgjmiB5XZXJQIVAuuFNvPTvxv2PJbAf7ktiXsz9eUDVyLNyX4vfmBDlai0cc2
	iog==
X-Google-Smtp-Source: AGHT+IGMAa0pMvN41GmLVswUQh74G2T7pDQzvawBbi03BR+h8KyfNdFr8QIGXJ12aJ6DdfK8GuReLQ77fHo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18d5:b0:dc7:68b5:4f21 with SMTP id
 ck21-20020a05690218d500b00dc768b54f21mr168369ybb.9.1710458827844; Thu, 14 Mar
 2024 16:27:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:34 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-16-seanjc@google.com>
Subject: [PATCH 15/18] KVM: selftests: Allocate x86's TSS at VM creation
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

Allocate x86's per-VM TSS at creation of a non-barebones VM.  Like the
GDT, the TSS is needed to actually run vCPUs, i.e. every non-barebones VM
is all but guaranteed to allocate the TSS sooner or later.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 5cf845975f66..03b9387a1d2e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -519,9 +519,6 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 				int selector)
 {
-	if (!vm->arch.tss)
-		vm->arch.tss = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
-
 	memset(segp, 0, sizeof(*segp));
 	segp->base = vm->arch.tss;
 	segp->limit = 0x67;
@@ -619,6 +616,8 @@ static void vm_init_descriptor_tables(struct kvm_vm *vm)
 	vm->arch.gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 	vm->arch.idt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 	vm->handlers = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
+	vm->arch.tss = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
+
 	/* Handlers have the same address in both address spaces.*/
 	for (i = 0; i < NUM_INTERRUPTS; i++)
 		set_idt_entry(vm, i, (unsigned long)(&idt_handlers)[i], 0,
-- 
2.44.0.291.gc1ea87d7ee-goog


