Return-Path: <linux-kernel+bounces-122337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2388F55D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB741F28A54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431F2B9DA;
	Thu, 28 Mar 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhk42HML"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92D25760
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592940; cv=none; b=ngaws9TR4Pvr3DyvSnRdI6tPuEXeszvsEoc/WdGx4eR/C3szD8N3VW7eedHpmwvP4iDXhCKZWM253rHPPspFcLq3TIw4ZzrNoVoRxZM9PMYV1SQSRYi3uFNmmbALBjOH1LaE8aFwJCrra6MIrJgh0AAXHvtm+Azy8Ic8Hvg+Nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592940; c=relaxed/simple;
	bh=qJqf+gspYBFRI2K5imH74xBgzF2f9aynWHZqrtIDj+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UB7CClCt4o53HMZ/r0g2FbbbtVFTbesle0zsctguhRBeIGLaAHZ3biIfgptC+FTyRlBAtljwxQPF5/ErpRG+IkGJRypIPnFo2CbNWIOs/hTB1IjUURiaJN4Sn3RJa386bFf7tXGVD6loQSuTCy8pUQ822aAAt+UnJnUhueAxeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhk42HML; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so846513276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711592938; x=1712197738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QmOyqM5X2MNASCMJ2dyKBKMwyn+XBPI/URXs6ak0lY=;
        b=rhk42HMLIfXvjMyIuNQ1KAsmWHS2F3VZ7xM529MKMOc9qjyuoKjr/XOmBBvR6KXvjF
         NNpwNIpqhFCDVoBJ4Uzi5Rl4v0/HkoGaFpHj03VUpDhIpNOfNcQ+dhzYWTAcCbJYlUvX
         I00+UsIUkDjVQaLkEGkIRVzwt49HorrgRtBvaRcjfbH4EPU5HN0MmVOIliFaYmzSLIYe
         03Q6602D/PaMndefNu0Q8+km6V/DdxctqRDEr5YsGyFhzY2grawQZFXuVgESvadrW1bG
         Q9GEzmI/yKA8T1RdWOUVOHDB+gqiSDnzDz2Y1W3X1s2P/fYBlgB2bWUS3xzV/JDXdECS
         ssbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592938; x=1712197738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QmOyqM5X2MNASCMJ2dyKBKMwyn+XBPI/URXs6ak0lY=;
        b=p68LE+e8wIIddM/W1/50dh320g+5uPTrIUpaIzyKhrqW28QiZX/b+zId4lEfrbVhgx
         AZiblP7kV9im5CZsE/yhHq79JD/w8r4KCfqmfLh5EcNMcznprpPldEP/ymsYwInkUDKP
         LWm22am3KxVhZ95MwjqyRSZ0K/RHKbtlt+5FgdTcGKJZz2SzMUa0yKAggfY2yFWH2/0Y
         oO0EoIbo5eWdDWf9gPL0fT78TeLd1PIPqN6QJjHIzIaaKtVPEh2sF0BI7/SB2ZaI265Q
         vuej4Ddc+y8EcBThp/bHOyGdon8wlikJKUlVAPXNs8GFBmVVBl6rR7E1IOWdq3lJsh8m
         3NXw==
X-Forwarded-Encrypted: i=1; AJvYcCUnlCLNa6ZR5Mp9Ds13AWHXWeFbS9H9JOeqrGYjD9J0KI6kqf6D4DSyZwoFCdL832Rvznn8Yd5/YQhvyMWS2QlB4/eNHSySgLBxbroA
X-Gm-Message-State: AOJu0YwtAJ3SzEwtmjKKgPCExMdTyYuAT+6qRvR9etiy78shF3fdeGsz
	H3oZIpGWHJlagA43clasiJ6TfLrBIshUs0AS+Me+KlU0kXPVZ8Q9O+xjuaYSokwHbvC7B/qaTiz
	pDBBNrJtrwGEigZSwIXBSVQ==
X-Google-Smtp-Source: AGHT+IG3h7UFptSbhQThXKYXVUxHjXW9GcRNRwfD8DnNx4fzNFxp960mZTVoDNqHvfoMy5v3WIivsTHuarJXGtUe7A==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:2290:b0:dc7:48ce:d17f with
 SMTP id dn16-20020a056902229000b00dc748ced17fmr489931ybb.10.1711592938320;
 Wed, 27 Mar 2024 19:28:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 02:28:51 +0000
In-Reply-To: <20240314232637.2538648-14-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com> <20240314232637.2538648-14-seanjc@google.com>
Message-ID: <diqz7chnm6n0.fsf@ctop-sg.c.googlers.com>
Subject: Re: [PATCH 13/18] KVM: selftests: Drop superfluous switch() on
 vm->mode in vcpu_init_sregs()
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

> Replace the switch statement on vm->mode in x86's vcpu_init_sregs()'s with
> a simple assert that the VM has a 48-bit virtual address space.  A switch
> statement is both overkill and misleading, as the existing code incorrectly
> implies that VMs with LA57 would need different to configuration for the
> LDT, TSS, and flat segments.  In all likelihood, the only difference that
> would be needed for selftests is CR4.LA57 itself.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../selftests/kvm/lib/x86_64/processor.c      | 25 ++++++++-----------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 8547833ffa26..561c0aa93608 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -555,6 +555,8 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_sregs sregs;
>  
> +	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> +
>  	/* Set mode specific system register values. */
>  	vcpu_sregs_get(vcpu, &sregs);
>  
> @@ -562,22 +564,15 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  
>  	kvm_setup_gdt(vm, &sregs.gdt);
>  
> -	switch (vm->mode) {
> -	case VM_MODE_PXXV48_4K:
> -		sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -		sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> -		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
> +	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> +	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> +	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
>  
> -		kvm_seg_set_unusable(&sregs.ldt);
> -		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
> -		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
> -		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
> -		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
> -		break;
> -
> -	default:
> -		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
> -	}
> +	kvm_seg_set_unusable(&sregs.ldt);
> +	kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
> +	kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
> +	kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
> +	kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
>  
>  	sregs.cr3 = vm->pgd;
>  	vcpu_sregs_set(vcpu, &sregs);
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

