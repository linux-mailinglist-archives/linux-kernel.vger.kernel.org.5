Return-Path: <linux-kernel+bounces-61379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C8851191
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D0C284A10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFAF3BB3A;
	Mon, 12 Feb 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4V85FiM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941773B78E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735045; cv=none; b=gAyUusj1+0UyEDuB71il4Q6p1wckAqit75YcCHV+pSS4+E8ZG16sXosiCtQ/cKOTIzJR2f8js6wQRtj+ZvQmD1tMHx63JDioHz2N8yYqLDXJ4U/0Hbb3kyg/5Yob5vlhC0nwJgkbuuqtJb6qatxYjXp8L7LMHGfnQm5ySRspKyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735045; c=relaxed/simple;
	bh=Lr66KmZnVLS82nRgdt+beezb2jJBazpmkeYHKLN/A9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy03VMpyraMKrikMTDiLMRuYaZi1/OrbND13Oq6rRy0sipzPtBx4wESsqGDYl4/wJaGFF/YbqqmLQzQcpMXafOOj5iR/VIukh/o6RmiQSpqxefdua3+UPY7pGnevbRDsitBESXMouMetrkrM3IEuGvA3gOtNx61tWDMpFMXWI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4V85FiM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707735042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGzi02Tn24h+4KX7saOQvUPo/IOGq4TShidAZaCvX4Q=;
	b=M4V85FiMpVf9ad8urNi0YLTZhEIaligdCP40ZSJMQuB/+e88t892IdYfQf7tpsPXcVVIRU
	lNvneXKfh6Qhgysh2A7uaPzLn4Ky6H1JlxEvfcY/5k919GzwiqhcwaaOXwTehtM2Yrwi0x
	SLJyCK4L9RQwg6lRXGq9H4HAyCbo0Jc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-tXh2x5FaM6yVmA2B_wqw9Q-1; Mon, 12 Feb 2024 05:50:41 -0500
X-MC-Unique: tXh2x5FaM6yVmA2B_wqw9Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a29bb25df84so214521766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735040; x=1708339840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGzi02Tn24h+4KX7saOQvUPo/IOGq4TShidAZaCvX4Q=;
        b=gqnrxjKYujHA9xiuOry1KXN3aDdkX50WdVD/BZt8lXlogBmnOJvD8J+H2MNcfdSVIj
         B/IGXT4VF8oBUHYBlL5XNoEe4QlpQdLz1b5O0Ljo732z/24df9OBk1wNZXjvrpS04Q5k
         OPg7rFBHSbVcjR8EiHm8Mu6oL67i2rsjxianOq323PlHRU9hcXu2upmghpAKp93FQUAp
         1XXfXgiLLsZ5ZqO1T+ZTcIvY+h758p8bJxknGUcz/6xr+N0CibMsE7tBTd5ucbciE3ni
         9verVhskwh98o1cIEpxxWNUNfTX/qWIEuEMPMjMy6BY6+9Zo1aoaNm2KM538lt7RiYZQ
         Guig==
X-Gm-Message-State: AOJu0Yy7M6HSdFIBmvt3r5bPd8rHGUu/R0+KZ+kTKnAV/R8bJOTc4V22
	Nl5egih/X8x0n2gn0p2KI509EXXrSr1p2BAFthlo/hGNo8IIQtXXP9KppIl3asNUcYIGI2SujOE
	pggapRGvjnwgwxTKDudU4q11jQCNZnQP23TP7WzYIlKOIzCGKQPPk5ZsqgS4ln07l/wc6dVlQ8p
	GoAX7UP/iJkzkfVW4YBT/i+GPBSv4cxbmUb7zp
X-Received: by 2002:a17:906:3507:b0:a3c:2293:6500 with SMTP id r7-20020a170906350700b00a3c22936500mr3694526eja.62.1707735039900;
        Mon, 12 Feb 2024 02:50:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs/dTfWeYlV2h3bAXvOeCpDOIaWG7ELxlYs012S707SouVNragOMr+4A+e87Se2En7qrc/XFhuu59BW51wQ4A=
X-Received: by 2002:a17:906:3507:b0:a3c:2293:6500 with SMTP id
 r7-20020a170906350700b00a3c22936500mr3694493eja.62.1707735039576; Mon, 12 Feb
 2024 02:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230172351.574091-1-michael.roth@amd.com> <20231230172351.574091-31-michael.roth@amd.com>
In-Reply-To: <20231230172351.574091-31-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Feb 2024 11:50:26 +0100
Message-ID: <CABgObfYX74NwYPV8dHGfLjBBp5JMGsN5OSQaJrgHQTghVdrD1g@mail.gmail.com>
Subject: Re: [PATCH v11 30/35] KVM: x86: Add gmem hook for determining max NPT
 mapping level
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
	pankaj.gupta@amd.com, liam.merwick@oracle.com, zhi.a.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 6:32=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
>         int max_order, r;
> +       u8 max_level;
>
>         if (!kvm_slot_can_be_private(fault->slot)) {
>                 kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> @@ -4321,8 +4322,15 @@ static int kvm_faultin_pfn_private(struct kvm_vcpu=
 *vcpu,
>                 return r;
>         }
>
> -       fault->max_level =3D min(kvm_max_level_for_order(max_order),
> -                              fault->max_level);
> +       max_level =3D kvm_max_level_for_order(max_order);
> +       r =3D static_call(kvm_x86_gmem_max_level)(vcpu->kvm, fault->pfn,
> +                                               fault->gfn, &max_level);

Might as well pass &fault->max_level directly to the callback, with no
change to the vendor-specific code.

I'll include the MMU part in a generic series to be the base for both
Intel TDX and AMD SEV-SNP, and will do that change.

Paolo

> +       if (r) {
> +               kvm_release_pfn_clean(fault->pfn);
> +               return r;
> +       }
> +
> +       fault->max_level =3D min(max_level, fault->max_level);
>         fault->map_writable =3D !(fault->slot->flags & KVM_MEM_READONLY);
>
>         return RET_PF_CONTINUE;
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 85f63b6842b6..5eb836b73131 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4315,3 +4315,30 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_=
t end)
>                 pfn +=3D use_2m_update ? PTRS_PER_PMD : 1;
>         }
>  }
> +
> +int sev_gmem_max_level(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, u8 *ma=
x_level)
> +{
> +       int level, rc;
> +       bool assigned;
> +
> +       if (!sev_snp_guest(kvm))
> +               return 0;
> +
> +       rc =3D snp_lookup_rmpentry(pfn, &assigned, &level);
> +       if (rc) {
> +               pr_err_ratelimited("SEV: RMP entry not found: GFN %llx PF=
N %llx level %d error %d\n",
> +                                  gfn, pfn, level, rc);
> +               return -ENOENT;
> +       }
> +
> +       if (!assigned) {
> +               pr_err_ratelimited("SEV: RMP entry is not assigned: GFN %=
llx PFN %llx level %d\n",
> +                                  gfn, pfn, level);
> +               return -EINVAL;
> +       }
> +
> +       if (level < *max_level)
> +               *max_level =3D level;
> +
> +       return 0;
> +}
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f26b8c2a8be4..f745022f7454 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5067,6 +5067,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata =
=3D {
>         .alloc_apic_backing_page =3D svm_alloc_apic_backing_page,
>
>         .gmem_prepare =3D sev_gmem_prepare,
> +       .gmem_max_level =3D sev_gmem_max_level,
>         .gmem_invalidate =3D sev_gmem_invalidate,
>  };
>
> --
> 2.25.1
>


