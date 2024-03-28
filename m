Return-Path: <linux-kernel+bounces-122349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15888F582
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F31C2ADCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC202555B;
	Thu, 28 Mar 2024 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ziOEoNn/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85020DF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594239; cv=none; b=TlKDgVAd4XVq0EnK/5SL1kjO18MHu4q50obcCUWoAz2aU3NqdGK/YcG8v+ge80JY/soQI9hPbHW2NmJAeUVF2SBX0i/i+dcSS4XX/qP2icOPs9od1ap/sJqyS+NBbG40WWbePAqqhx28GB6bjCYYAI5ehF6WGxsJWU38V54qWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594239; c=relaxed/simple;
	bh=TgtHBQv7hWFFUsdNLEi5j9zVB+0hOvbL0vOMOT5yYkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WJmJf7AxCBHGcjx2qB31aXkhj4RKjojbhWteZFdp41Ivs5RhzaY+7N9iTJq6VRlHkbTRJRa3wFGbbT7XLCks25dOgLpXARk/BONvUTqQ3fPXNqVLAHzqboPjGJssaAGAje0PXe/U4hJSAcN8yAigvJPc06+f8RdGwNwWBkzooRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ziOEoNn/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso791534276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711594237; x=1712199037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVStFLbB5MSlLHegIF/51zA+Fjr+PzwwtmvLYBB03HM=;
        b=ziOEoNn/p+OQCmTX/hKzlwbl63OmCvGDAAZ+Z9dUipB7FYlSLoQDF6ObmyKrGYkR9Q
         jNSIT7Kk5h3k+2PBSfFiyilUQw5cW0p/SVLH7c1UgWVIv6ULdJca5IzXIZ4G2xvG5fqy
         pi+rWOwY4nqlUc5VIi0ghpiU1J227ZBjx/VFcmYFrfIfwQTz4ac7Bvae1h9pdsKjX1cq
         qd/nnS6ZKJ6GCBr36SHaienBv4CZQu7VyX7YajrmmXwwCw5BhPCwsm3ZxPdtAnMfnwOx
         0lGRbHmplBe0zhNK6SEkHT2NkCZfuvruMtExEhT8vVbRPYthdD5fPMhaSoDCa3B6rDVW
         /W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711594237; x=1712199037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVStFLbB5MSlLHegIF/51zA+Fjr+PzwwtmvLYBB03HM=;
        b=XejMIvXuArXoHTq4iDSxFmfqXt9hv7FN7MwKE0Ztm4ZRghe80sWz8NwydXGYVJoNUE
         VMYt5i/7m4Y0TQ+yGRcamTLkR78tBneSqXik/s5N9JiYbkXsHjw0JXrz7Sy9j0vZ0McI
         dHl1gp5tm530gvXCxHKjXjXIsCJomB/Fs3lyj3kG8p50v/yrdpMRA4Vr58g8LLeDZWxx
         OvxWgQzVu1BbE+ZppGSI8Vqen/XtfTBUvYhhxe3XU0WBOW6/Sv8CKmEk65aYXzCj3phg
         PPAExj+dTUGumpmH8JaDXc6WaBYZfqqQwCmESMia9L1kEKlOgIp/0vwNDFGP8tX7GNYL
         DxTA==
X-Forwarded-Encrypted: i=1; AJvYcCUurP1VFAcTMgwbjZ6/1lvGEI9saLrukB440cihcDLLhChRf8rl3SOY6fFVzg++OaJSwqGAzLz6hPLGcq//JnCh+FsQPrLcEliCIJgh
X-Gm-Message-State: AOJu0YyXZjOF1YFMQOswy8ikROv6pgxl2BkwIZLGSOfL3bggIQ9Xr0yF
	mPzy82NiZE/eulyMLekKX29YG1W0pLwfb6Qm3KIWkewubxLc1Tw+x+R+0SD3ZvlvcPxznNUSBRs
	koEOOn9uezhDBzXq9B6kDng==
X-Google-Smtp-Source: AGHT+IFMg1NFvhaztQY4Xe+ltR0SInGvBShM16M6WwX62q2RGNWNPZfAstK1O/zQ6kdEG7DNPdBNlgqWvpvw1rlnNQ==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1009:b0:ddd:7581:13ac with
 SMTP id w9-20020a056902100900b00ddd758113acmr522745ybt.2.1711594236913; Wed,
 27 Mar 2024 19:50:36 -0700 (PDT)
Date: Thu, 28 Mar 2024 02:50:32 +0000
In-Reply-To: <20240314232637.2538648-15-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com> <20240314232637.2538648-15-seanjc@google.com>
Message-ID: <diqzfrwbkr2f.fsf@ctop-sg.c.googlers.com>
Subject: Re: [PATCH 14/18] KVM: selftests: Fold x86's descriptor tables
 helpers into vcpu_init_sregs()
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Now that the per-VM, on-demand allocation logic in kvm_setup_gdt() and
> vcpu_init_descriptor_tables() is gone, fold them into vcpu_init_sregs().
>
> Note, both kvm_setup_gdt() and vcpu_init_descriptor_tables() configured the
> GDT, which is why it looks like kvm_setup_gdt() disappears.
>
> Opportunistically delete the pointless zeroing of the IDT limit (it was
> being unconditionally overwritten by vcpu_init_descriptor_tables()).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../selftests/kvm/lib/x86_64/processor.c      | 32 ++++---------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 561c0aa93608..5cf845975f66 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -516,12 +516,6 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>  	return vm_untag_gpa(vm, PTE_GET_PA(*pte)) | (gva & ~HUGEPAGE_MASK(level));
>  }
>  
> -static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
> -{
> -	dt->base = vm->arch.gdt;
> -	dt->limit = getpagesize() - 1;
> -}
> -
>  static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
>  				int selector)
>  {
> @@ -537,32 +531,19 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
>  	kvm_seg_fill_gdt_64bit(vm, segp);
>  }
>  
> -static void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
> +static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_vm *vm = vcpu->vm;
>  	struct kvm_sregs sregs;
>  
> +	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> +
> +	/* Set mode specific system register values. */
>  	vcpu_sregs_get(vcpu, &sregs);
> +
>  	sregs.idt.base = vm->arch.idt;
>  	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
>  	sregs.gdt.base = vm->arch.gdt;
>  	sregs.gdt.limit = getpagesize() - 1;
> -	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
> -	vcpu_sregs_set(vcpu, &sregs);
> -}
> -
> -static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> -{
> -	struct kvm_sregs sregs;
> -
> -	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> -
> -	/* Set mode specific system register values. */
> -	vcpu_sregs_get(vcpu, &sregs);
> -
> -	sregs.idt.limit = 0;
> -
> -	kvm_setup_gdt(vm, &sregs.gdt);
>  
>  	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
>  	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> @@ -572,12 +553,11 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  	kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
>  	kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
>  	kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
> +	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
>  	kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
>  
>  	sregs.cr3 = vm->pgd;
>  	vcpu_sregs_set(vcpu, &sregs);
> -
> -	vcpu_init_descriptor_tables(vcpu);
>  }
>  
>  static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

