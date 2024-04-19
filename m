Return-Path: <linux-kernel+bounces-151390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066348AADF8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2985B1C20C79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AA84D35;
	Fri, 19 Apr 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xdt2xboE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6880022
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527904; cv=none; b=jrvR9iTHi7fK0/8mrzkRvbbO0U0RrZzPjEmPL6W9JouBvcZlrfkM7woBsf0AXFZc/hnQ7zXw7XzQRtiIp9x6EnzQ4zvv0L28wzGUT96qQVmkT22Jgm9R5zBpGs9frFbONBoiQIfxxtBQSZEG5z7sxPRRr+lRJ+DIvA4xPTsqypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527904; c=relaxed/simple;
	bh=wBbLhac8QaUF0O5nwHjFjj5cUq+nWt4AMbemYENl12c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6tURDDBB0dBgGmC08ETYkYfd4zo7VwP+Hx+TCpFIqRikCWRvbUIzXhzyCAdYf8WzoIudQHzY2OeI+4xP14v2tKwCdvOVah1VAXGXePUZhAZmYCC3jpc+sxPHP3kXnvqNZf5/Iqs/tcZeIpricF60TGhfcCPG8kp2//ANNP9Xvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xdt2xboE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713527902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwxWxYK6yFiOYVQyI4AiRXsN6yKGGl+jXN1TxSL+A3k=;
	b=Xdt2xboEkSlSfrgTt+K0xHvQkemxaTVbna6s7Ne4POk21y3cwQIM+eBaTGTjBy/Kq1AZJA
	20DsHL/8pnJww8RKcWRvbcDdIszs6KAGgxVzE6UcKOp7tlzW5nt/j2+Ou+LMbVlglgIGJV
	R816IploLTmTqxhdkZcMSHsLljb/lSE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Eef3vrvuOhmDTlUjoHvG2A-1; Fri, 19 Apr 2024 07:58:20 -0400
X-MC-Unique: Eef3vrvuOhmDTlUjoHvG2A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3479b511725so1358791f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713527899; x=1714132699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwxWxYK6yFiOYVQyI4AiRXsN6yKGGl+jXN1TxSL+A3k=;
        b=qbsC7YZ5cvih5rUTHsgQDH63/ftPUuUeFp/OUUJOIt5xQfHL6KTXmi4HtL94il5uBA
         dnHe7y3ReYFlXNU9fKx29igg+fQxAfwGOzmWCUThqyP65T+0Gr1nnd2h0bS5duAd3wBa
         zcg4pEaQ7Hp1d02pzfLVnGKvFa+bpiLB9TtrgPQ9oFR++a1zodagYHN7ibc3OiSTVouq
         EP9JRZ/Ufcak9yPO4s5OUNGBnqvcOZBzzRLnC4JWy2j3jSbesFTy5I9tgwYvwIIFyaRl
         O/QnOMmvmuzDx8ID2ZD7mTOurxGgbOnFa1vItkjEVBzQSpDYvjyOKF1V1b0pMFvWJf7l
         NrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUruG2rp9Pmg5HwWvjdCcfY/9QLmmkda4P1woBFd7DFDIKybG2z6rFo2GsDqDDye5Rn1civC704P/RCfUmcVzyOP5HuZKKXjO5oVCIP
X-Gm-Message-State: AOJu0YxkouXHvHojTKqsF/R60bcTQeJppF5E4czbDTafnsQfcs1zviCO
	9O0XZlLAXv2dIazJS+jETQBgf5J+nOiitj3fe9lqQAk5yMC7LUUl6PHzKyJY42xeAZGBwD+10H9
	QgrhL2LfHXLv0kMpuPS+qQlhSipTpxcQBNilCGGYdbN5l7eJT0Dg9Z357EqjyG8RKBKdXRuFvlR
	wbbTIqpOVJPc7Fp4o75xcJGPZUPj71F56O7PEz
X-Received: by 2002:a5d:50d1:0:b0:33d:b376:8a07 with SMTP id f17-20020a5d50d1000000b0033db3768a07mr1167236wrt.8.1713527899435;
        Fri, 19 Apr 2024 04:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM7xQDK90cgpkqMe8qHCL2Dpb0GVAovL4zmOZ8Y/f+iUHPX7N3URgMIDSP1Agr9DUXYvSVNpPPSl3w69ic80Y=
X-Received: by 2002:a5d:50d1:0:b0:33d:b376:8a07 with SMTP id
 f17-20020a5d50d1000000b0033db3768a07mr1167205wrt.8.1713527899035; Fri, 19 Apr
 2024 04:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418194133.1452059-1-michael.roth@amd.com> <20240418194133.1452059-9-michael.roth@amd.com>
In-Reply-To: <20240418194133.1452059-9-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 Apr 2024 13:58:07 +0200
Message-ID: <CABgObfbNd2Z85o3Wb-yr5qYSWYTadxZGuh6PP=r-5dNpa06ErA@mail.gmail.com>
Subject: Re: [PATCH v13 08/26] KVM: SEV: Add initial SEV-SNP support
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:51=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 535018f152a3..d31404953bf1 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4899,7 +4899,8 @@ static int svm_vm_init(struct kvm *kvm)
>
>         if (type !=3D KVM_X86_DEFAULT_VM &&
>             type !=3D KVM_X86_SW_PROTECTED_VM) {
> -               kvm->arch.has_protected_state =3D (type =3D=3D KVM_X86_SE=
V_ES_VM);
> +               kvm->arch.has_protected_state =3D
> +                       (type =3D=3D KVM_X86_SEV_ES_VM || type =3D=3D KVM=
_X86_SNP_VM);

I'd rather set has_private_mem here too, rather than in x86.c

Also this patch is the place to have

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d31404953bf1..6209f70ab11a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2056,6 +2056,9 @@ static int npf_interception(struct kvm_vcpu *vcpu)
     if (WARN_ON_ONCE(error_code & PFERR_SYNTHETIC_MASK))
         error_code &=3D ~PFERR_SYNTHETIC_MASK;

+    if (sev_snp_guest(vcpu) && (error_code & PFERR_GUEST_ENC_MASK))
+        error_code |=3D PFERR_PRIVATE_ACCESS;
+
     trace_kvm_page_fault(vcpu, fault_address, error_code);
     return kvm_mmu_page_fault(vcpu, fault_address, error_code,
             static_cpu_has(X86_FEATURE_DECODEASSISTS) ?


for the final shape of the MMU changes.

Paolo

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83b8260443a3..9923921904a2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12598,7 +12598,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lo=
ng type)
>
>         kvm->arch.vm_type =3D type;
>         kvm->arch.has_private_mem =3D
> -               (type =3D=3D KVM_X86_SW_PROTECTED_VM);
> +               (type =3D=3D KVM_X86_SW_PROTECTED_VM || type =3D=3D KVM_X=
86_SNP_VM);
>
>         ret =3D kvm_page_track_init(kvm);
>         if (ret)
> --
> 2.25.1
>


