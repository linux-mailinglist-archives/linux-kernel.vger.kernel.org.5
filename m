Return-Path: <linux-kernel+bounces-103901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7BE87C662
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9221C2132B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210D376F3;
	Thu, 14 Mar 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vzbz7azS"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898829428
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458818; cv=none; b=QT+P84JjyGeudJqVG4N69wVISRQgQdsCYGB8O56RsmVdUUt7gY/EtVRhpPSvK+EwMQ1s4oaEFXDNP4gad6Tl0DU5pLSSnXeEDVBr8uFNnONU+5hEwz264xDe8eT/nWATl4JBAfrfKdLJDVCFyFM0HcdsHDZzY8wNlQTLbfuHKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458818; c=relaxed/simple;
	bh=o49cGQaFGV2lqCGlt41zmvUnsUxiYRWJVSbJwfYRFlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V0t9lFs6AFXfPkwdMf680fYFr3rZtISm65jrlN91EFyt6q2z9gwcOnPqqVLjBCjhlVjZcrO8hMwuUqxA9lgwComyG4OOGUcf2rYCnoIuFh+ohBjajbvu1E3h9ZOyHeLheAeSRmlRv8L6Gg774zC0twkz4Rql5ZJjCAfNKldx8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vzbz7azS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dda34bf052so14569855ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458816; x=1711063616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pTVZRdXyCVTnuQGgLheWcCsaF7bim4F1PK5VbaXQ+t0=;
        b=Vzbz7azSdWAECY3/f9td/ZB9C0I5KLZtFHpys5R31pciTd4riUy0It6QEH8PqFYETl
         toaGEnvc322SQ8bVrLu3UvYSJJCL957+e2uXNkduoqUt9PhDwFeBQpjezCHrQvKkYPcM
         rst7FdqOvxa7yW1VboqJZkXWySV4bBTphasFJQmfKk5vB+ZAFqV35POtdwwBevJH7Enj
         VvrhGYRHZJ9E+jodxVCq++/bIl74NfLQ4zRNrQhJSHcJFifBnVK5ryb0dC+BRxoqs+fj
         aa30aVd82R0W+i7HC2lt1Kjh2O9eTuQ4tTX+zrI1WSnB7WgqwDaCVTpXf/D0rMBj0G5H
         sv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458816; x=1711063616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTVZRdXyCVTnuQGgLheWcCsaF7bim4F1PK5VbaXQ+t0=;
        b=QS4oTNpDvPlv6OBvmKuHibhQ8ZUoGgo9ce+VN+01uZlxGcu2LQcvuTu9BHji27Yi+b
         9hj8so/67cdypBFbWs1h2xNn162urHHGQFzivhCgjFmz4b20w2dzIyccosxL2ei3svc5
         YBKC40zk+yNXakJ7K0aaqj137ind6ZgTCzLAfCcJtp1LDIyQT1dG4o9hMsfVWAS+ST1O
         pJD16YksLHMIZtFDQyKC/yq6rU7xMngh6li+wd1hoT59uVHLxRyxn7eb3sJQY/sPYiCV
         c7pfdVqhYE8dvJxdzcytAXRNQhvXwPHNIPSN2373l9ztKoWQNCnhHOdbW3EIMQOyzUu1
         +5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEMrLKiaVQgRhwFr7oBcmf8/GmusAE8Zis5EI6Y1ONEZamOBBYdZNnvv3tZGdYVkdonLuiABzB6Ms7kyglmEaOQdjs93AHwH7ko+8x
X-Gm-Message-State: AOJu0YzaQg+nhZNw/RKsBuToSxFQU415OQxYhjaB0QI8n7c2z9P9eLc0
	bvyAOgzkahTBBtW1P+J+GVvuXaslLF/ye+auZBEB3KaUNPh9KUWEEYI0yAxfQRvXpnmroinb9jP
	Ayg==
X-Google-Smtp-Source: AGHT+IH7S37OXvdlnB5BIBxBCKNBsO+Ay6MTHPEIT19iC3iZ0sD1f7oPcvL0HSDVvR5Ys+olPa2yoMgb6k0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4ca:b0:1dd:a324:30b5 with SMTP id
 o10-20020a170902d4ca00b001dda32430b5mr9294plg.9.1710458816466; Thu, 14 Mar
 2024 16:26:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:28 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-10-seanjc@google.com>
Subject: [PATCH 09/18] KVM: selftests: Rename x86's vcpu_setup() to vcpu_init_sregs()
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

Rename vcpu_setup() to be more descriptive and precise, there is a whole
lot of "setup" that is done for a vCPU that isn't in said helper.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 3640d3290f0a..d6bfe96a6a77 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -555,7 +555,7 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
 }
 
-static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
 
@@ -716,7 +716,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_setup(vm, vcpu);
+	vcpu_init_sregs(vm, vcpu);
 
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
-- 
2.44.0.291.gc1ea87d7ee-goog


