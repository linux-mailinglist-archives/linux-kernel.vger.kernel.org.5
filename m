Return-Path: <linux-kernel+bounces-122344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564988F578
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3FD29A38A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67820DF7;
	Thu, 28 Mar 2024 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4b79sfYy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885D210EC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594032; cv=none; b=S/8LedYMHtR75TGcxi+gHn2Tc1Bs6I1Pl9aR+vfknm4kAZ05/pnEJ4K4FkuyeeLooQs63mpL9l2S0adUy56DPe1vxIX68UGAnr1l79zlgHSoMJ7ap26kGNzGJuUmuoXAmN3eUEDgPtl6/o93UmSq1IpKVofTYwwnZMNS9vtpdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594032; c=relaxed/simple;
	bh=84H+cJFr0cL9Knja7weHauqkI7JHjb4wcobAfHN1EMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4W6JnCmuGRaURnu2gQai7NTHA/kWACL9E+IenH1xA+RHs92KYXuf+eoZI+H55NH/QmnlaUwx+rMtsEgvGEeM0t9OviX5y8OyhVnoV/3fR4fsE4jN/cYZwdD2OOtzeDDtMxVo5/3zuLb+rEuhUkXic4w0cLkaC/w0XnHpQ8SpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4b79sfYy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd073522cso8921247b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711594029; x=1712198829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwKAKqKSkPlBh99CpC5Ho4X+oKbKwu1UgbqAZ4JZV3w=;
        b=4b79sfYymoScQAu7/7eJoVIjBxHjWn729jowcuWP2zjtW8rHPGlp3vwhlnWPWYwOUt
         W8PMM4rT8FfVXwbWuoKqyOr3YbJUbrq4LFXnKHH3zATOYJgPhpky12vO6Ff6mo60xG6p
         8CZ7Wtw4c1UFHiM+TOWEenZln0v945G6sUViHGnY5dK1z9/FTpk+LmuYyLouWT1jfU1A
         sA9ooNbRIlJwKG387WHXaJacO286tnB1WBGiuANtWaFLSCBYQlfNgeSIhnWpuC+sWRQ3
         BX1j/a5RqHNBVqjy5e5JGGwmgsV1MnF2zn8xqDbVG3/FQdev+ZfTuKf3ViTJHiEt+fft
         RPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711594029; x=1712198829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwKAKqKSkPlBh99CpC5Ho4X+oKbKwu1UgbqAZ4JZV3w=;
        b=W+447QS5GMmbvMI0HuWJi8WJ0uBDOcF0cv3sdbWd6BEGQmvN3DQvQwE8OzqniVGxpH
         97JLYZ/t21hTig12zvb6FwemmI4HQSkOBNwZZUBlCQ0Ho37JBHlj/j0h0UI/1tGzZ8aV
         Md7q412dpGIdL0G9x8BJm8y0oJ6aB4nCfK3j82VC3RKEddVdp+4w7C/SoGyjsEJArWpI
         vg0rdHRpMNTTAvKmbvyCTbojgPwvPcmir7UDGOwOvYfxykNC83LKmzDODAP1Ex4UmFBS
         OUqjW19SBWZDHb7UcqzNa1/iij5CqXKYhC6AYWyQRrtjxOfbxXzQRpYrSkIXq+EOKK0Y
         YLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTpB0S5MpnUbwzTlcq1TmeD7dZJe9ReGCKW50lWCjput6bvkrUcH4TLKVXLapcXCBq9Ecd4cRKJA1S8UFEU4D16soDzTZnIFfxKKOr
X-Gm-Message-State: AOJu0YxfCmkWXEb8k5NRTrSp1rpvuFnToKXavdNkOzY7JK2OrALiimz5
	xa0VmhgLNyv1fYvVasfG3hKqsojMDq6ugm1zxz4LfM4W3IyKt+PUzwzbTTF0WeE8ffq0M97qOBR
	dxWSsQ3OmRV57IcLvG1gYSw==
X-Google-Smtp-Source: AGHT+IFuDAD4wtNUkP/2UEse7mwv3qapG5IVIY191z0pQp8MOjMKC9JPX6Ry++6lYE8vhg/RF4vUjCFCzCP7/uR5QA==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:30c:b0:610:c400:9e8a with
 SMTP id bg12-20020a05690c030c00b00610c4009e8amr207011ywb.2.1711594029051;
 Wed, 27 Mar 2024 19:47:09 -0700 (PDT)
Date: Thu, 28 Mar 2024 02:47:05 +0000
In-Reply-To: <20240314232637.2538648-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com> <20240314232637.2538648-10-seanjc@google.com>
Message-ID: <diqzttkrkr86.fsf@ctop-sg.c.googlers.com>
Subject: Re: [PATCH 09/18] KVM: selftests: Rename x86's vcpu_setup() to vcpu_init_sregs()
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

> Rename vcpu_setup() to be more descriptive and precise, there is a whole
> lot of "setup" that is done for a vCPU that isn't in said helper.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 3640d3290f0a..d6bfe96a6a77 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -555,7 +555,7 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
>  	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
>  }
>  
> -static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_sregs sregs;
>  
> @@ -716,7 +716,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  
>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> -	vcpu_setup(vm, vcpu);
> +	vcpu_init_sregs(vm, vcpu);
>  
>  	/* Setup guest general purpose registers */
>  	vcpu_regs_get(vcpu, &regs);
> -- 
> 2.44.0.291.gc1ea87d7ee-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

