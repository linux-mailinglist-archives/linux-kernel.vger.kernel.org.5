Return-Path: <linux-kernel+bounces-103904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B087C668
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C00C8B2138F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F2535C9;
	Thu, 14 Mar 2024 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kd/u8TnO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6751C5F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458824; cv=none; b=br8I/3MEqUG1L0+Psb3rZnmtRjPfTgwKo2c5OMbfxmOt1uaHteD5mtfprUf0CCTNkMmUMRi2doypJ9EGDdnzU74WWzaXDFU4Ax3bpqGXddAaPGVxfmqlJ+zB0jgFAb1KAtOGRZn1flq6N7R+lhP9rOy3cbwg8hLm19E63gkFWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458824; c=relaxed/simple;
	bh=UQIrurCe0zuaeY9y89rSu7jemDgb1Rydb7LX7x9KcOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=twfVdQVTTWUAeZr1k9zOrbuPSzyoe1JgJgvtVbYNsMTNeMRKuW7Iw1OWGCpjilTv/LcpL0PMjW+701p5GAzEKdWJz3/+FKJnk147FSKGuWjgcCDSEw9wggevIKY0ww4tiM0lvcj4EZv4bdUWV5S5hV7gdku2iuDXxQKAYVt19HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kd/u8TnO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29bad40eca2so1247582a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458822; x=1711063622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uvANWFYN1jpIYLHOo6AYUHWQUhBZT4UdCnC51A9DHBc=;
        b=kd/u8TnOapvbedi8gIOUCncUpN48bTQMar6D5tnU5L4OxT5pf3IQ7DjXpZgxiXhON/
         rFecnyibFESwh3oI13531PHY4lslPuvQx2w5CM8XKe3nycfQetfFHT85hNVlOaEL5xaA
         NTcG9qz8uf0lup64cUrlxycSaSsrkTrA5c5fhTKryDlhU8inrpdXPvzeXf6afR2T2VD3
         X2BduE5bMeRf9JftLlvHqvL1EuJ17GP6EzqFlBA8Iwr4NPmLUnpz+wttaEn6/1ghh4GM
         hq82SScFZ1iWPtykwRr29azS+xSpj9X2WIpVEkizYZdXFGWX5UNdwcUaHMzUIJVkONc+
         VOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458822; x=1711063622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvANWFYN1jpIYLHOo6AYUHWQUhBZT4UdCnC51A9DHBc=;
        b=un3kFdeIsWiWLJSFZ77UsiddYy7tg+rUu2HhsQlZVpMjleQG2ULalABW1JYWhc0Q10
         R+AFmym2FAl9yHJIi9d/icY01qU/ggX4sNsfDNtKGMR0IFfrlYkEytVWCQsV4N28zvVH
         c+nSKebrDdIG9/v1ixCH+fWQ2DBK+mrHWUuYKZem52QIJROdHJoextJy7ah6czZbHXuD
         gKIA+8NzGWNos1G8H4J6FXqfhULnjcKmXQsHK2uNZt1JFpE0qtSah/aWRKupIDVFw3aD
         5M74u4ksipO2YJMskMe0eZZNFkkDUBVofedMCw49TJzhcLbz/3ZzKMjrD+Nvw7T8N687
         phzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCWIyUQe0vBnkAKtqk9vBPmE95ptup+czx6QyW2T/ZLtdx4mOHpYBbFE97WuQ8oMqrRDWGZquKLPt8Lari0sgzDznH7kZ0f+IbcvAW
X-Gm-Message-State: AOJu0Yyw36lHG/xvU7oCtk9nWJKHadrPdQczwxoD/1MPzkgNk5kANeGZ
	ebGnRbsNcGii+s0lZPb/ems8MBcHFsJrGvjcykX1rb35jsYWcfvir6hgaCU/KeX2YweOtuFVJn2
	MCg==
X-Google-Smtp-Source: AGHT+IEmqFL1IXL1pIFLbyp7eKBr0s6FFOiXRR1g8DgzlSysrKWmAergLMAyluCim6XJlXtnyauxch/eeT4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:b07:b0:29c:6d5f:a6a8 with SMTP id
 bf7-20020a17090b0b0700b0029c6d5fa6a8mr8117pjb.0.1710458822156; Thu, 14 Mar
 2024 16:27:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:31 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-13-seanjc@google.com>
Subject: [PATCH 12/18] KVM: selftests: Allocate x86's GDT during VM creation
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

Allocate the GDT during creation of non-barebones VMs instead of waiting
until the first vCPU is created, as the whole point of non-barebones VMs
is to be able to run vCPUs, i.e. the GDT is going to get allocated no
matter what.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index f4046029f168..8547833ffa26 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -518,9 +518,6 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 
 static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
 {
-	if (!vm->arch.gdt)
-		vm->arch.gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
-
 	dt->base = vm->arch.gdt;
 	dt->limit = getpagesize() - 1;
 }
@@ -644,6 +641,7 @@ static void vm_init_descriptor_tables(struct kvm_vm *vm)
 	extern void *idt_handlers;
 	int i;
 
+	vm->arch.gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 	vm->arch.idt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 	vm->handlers = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
 	/* Handlers have the same address in both address spaces.*/
-- 
2.44.0.291.gc1ea87d7ee-goog


