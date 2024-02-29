Return-Path: <linux-kernel+bounces-86710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9186C963
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C8C285AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051387D3EB;
	Thu, 29 Feb 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W52H4Zoh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3876F03
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210674; cv=none; b=kTIV95TavdJYe1h4B1LvNHqOTMR4DIVuyW5OWv1nnJIevYvLi+NE3xN/1jdO5aP+1QdRjnm5xMhb1yNlQ7Jv2SZKLyDQV6L6KCf+PxRv0nuSI5i4xwkdB8vKa8GPx8cZNAP3NBV7DI0i2yRwAlLpIRvAcN/RhcrHYYXGjy3JgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210674; c=relaxed/simple;
	bh=PFbKm9oVKbiYCFV4Te4gZX/SgyWpu5Ye7VYR9JHaY+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL9a65tKSrDQF0E2J/6OlCEheIAk19nQNdKmpjU71AA+2jcExJH2a3FZgiUZR30R+TjQkj+9DVkcDBynCrfYFvOcmGtyWehZqK0WAQdF6/ikV1qnZD41BfNQ3ZNS5q120bnyllw3xmvk8/Sj0PraQ7nl9eLfzqr2WpdfwxQULro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W52H4Zoh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709210671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkOonY3la2hSmoRffKrf9jEAOm9sMbK1Xqob1w0aSr4=;
	b=W52H4ZohyPHTnPYIa2HxEQZzODLQxwHn4LeBgn29CnA+mu3yLu9gGLyKe6obSFavhKfMgR
	SrTuEHSMwNIBPPRSADp4HgK8knxnd/6XEPEqXK9S5Cb1aKkHU1yGYjNxcaNaV4YeP7hEzk
	OUngxQn4z/urIlImeeTPn02o+HiNN2U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-kLYA2S9sOwm0xGZ-XnsxRw-1; Thu, 29 Feb 2024 07:44:29 -0500
X-MC-Unique: kLYA2S9sOwm0xGZ-XnsxRw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d29de76abso429814f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709210668; x=1709815468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkOonY3la2hSmoRffKrf9jEAOm9sMbK1Xqob1w0aSr4=;
        b=m6VtPPeoFoDsc2XzXZ0hD7mOKaR1KVcBhuNWm6fNq1fVJDN/YxU/80honT6x0SGZd7
         ZRrzq2OX+LIB4cO1svopOydoPnXQ1ueKdCj+UmhWySmpTiHwYujTGvVz9sDg83hW7xR5
         NmQJzd3FWPSmGNdG0v6w7X2fKl3C9REp4jOFqIVsVTal7dbLRq1xyQR3Jd/PJ2mcdMvP
         VjoTurPWfKQxGNGYbszq6h9LDUkcBOxnQL+MtTsBftTT+5TVKQBZ/52aWPc6zt0jHiYY
         g9ZvLUzFHehIkecaXxieN1RZzLp7iuQ7xjTjEtkLlwlb6JhQzlitakCbzzGsmpQ8DcP/
         E83A==
X-Forwarded-Encrypted: i=1; AJvYcCWuu1trr03xyd4Q1I/5E1lBj2Tfocllh2+fZ3V7wIp89PYG9Y4gAgJA+3QKkQ7RmbAoOyrjnnQmF/64rFTrSVn3fxUe6x3WsulrrByw
X-Gm-Message-State: AOJu0Yx8vo8D19xPxBB6bBw+yk1acxaOLvvG1z1Jr8x53v9DCx9JaMKu
	W+CapAWHJnmsLZqIW3wbgSj4QQvhvndJoObMAF8vKnG4OQLce2HKFbO3Cqx5UTnt6ILn7U765Um
	dn5gekBF8xTa+dh9ttUrFXtk6H87Y8a0pk95+SAFpplEDsQ5kErbEGhyBVBoc0va3NnsLTi5r1V
	BhSTfl7PZ8g8lTZWett2roZlYlrgmNDLGQahMC
X-Received: by 2002:adf:ed89:0:b0:33d:afbc:6c76 with SMTP id c9-20020adfed89000000b0033dafbc6c76mr1309773wro.1.1709210668667;
        Thu, 29 Feb 2024 04:44:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEglXVoZOe+ZU/1XST6B32cGfv1HAd9jHRkeNp9F1qKgaZm3JWYARDroQFeN1J5fe1YJyfx6e92lYSUEKJHyoM=
X-Received: by 2002:adf:ed89:0:b0:33d:afbc:6c76 with SMTP id
 c9-20020adfed89000000b0033dafbc6c76mr1309759wro.1.1709210668323; Thu, 29 Feb
 2024 04:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-3-seanjc@google.com>
In-Reply-To: <20240228024147.41573-3-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Feb 2024 13:44:16 +0100
Message-ID: <CABgObfbtPJ6AAX9GnjNscPRTbNAOtamdxX677kx_r=zd4scw6w@mail.gmail.com>
Subject: Re: [PATCH 02/16] KVM: x86: Remove separate "bit" defines for page
 fault error code masks
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:46=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Open code the bit number directly in the PFERR_* masks and drop the
> intermediate PFERR_*_BIT defines, as having to bounce through two macros
> just to see which flag corresponds to which bit is quite annoying, as is
> having to define two macros just to add recognition of a new flag.
>
> Use ilog2() to derive the bit in permission_fault(), the one function tha=
t
> actually needs the bit number (it does clever shifting to manipulate flag=
s
> in order to avoid conditional branches).
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 32 ++++++++++----------------------
>  arch/x86/kvm/mmu.h              |  4 ++--
>  2 files changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index aaf5a25ea7ed..88cc523bafa8 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -254,28 +254,16 @@ enum x86_intercept_stage;
>         KVM_GUESTDBG_INJECT_DB | \
>         KVM_GUESTDBG_BLOCKIRQ)
>
> -
> -#define PFERR_PRESENT_BIT 0
> -#define PFERR_WRITE_BIT 1
> -#define PFERR_USER_BIT 2
> -#define PFERR_RSVD_BIT 3
> -#define PFERR_FETCH_BIT 4
> -#define PFERR_PK_BIT 5
> -#define PFERR_SGX_BIT 15
> -#define PFERR_GUEST_FINAL_BIT 32
> -#define PFERR_GUEST_PAGE_BIT 33
> -#define PFERR_IMPLICIT_ACCESS_BIT 48
> -
> -#define PFERR_PRESENT_MASK     BIT(PFERR_PRESENT_BIT)
> -#define PFERR_WRITE_MASK       BIT(PFERR_WRITE_BIT)
> -#define PFERR_USER_MASK                BIT(PFERR_USER_BIT)
> -#define PFERR_RSVD_MASK                BIT(PFERR_RSVD_BIT)
> -#define PFERR_FETCH_MASK       BIT(PFERR_FETCH_BIT)
> -#define PFERR_PK_MASK          BIT(PFERR_PK_BIT)
> -#define PFERR_SGX_MASK         BIT(PFERR_SGX_BIT)
> -#define PFERR_GUEST_FINAL_MASK BIT_ULL(PFERR_GUEST_FINAL_BIT)
> -#define PFERR_GUEST_PAGE_MASK  BIT_ULL(PFERR_GUEST_PAGE_BIT)
> -#define PFERR_IMPLICIT_ACCESS  BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
> +#define PFERR_PRESENT_MASK     BIT(0)
> +#define PFERR_WRITE_MASK       BIT(1)
> +#define PFERR_USER_MASK                BIT(2)
> +#define PFERR_RSVD_MASK                BIT(3)
> +#define PFERR_FETCH_MASK       BIT(4)
> +#define PFERR_PK_MASK          BIT(5)
> +#define PFERR_SGX_MASK         BIT(15)
> +#define PFERR_GUEST_FINAL_MASK BIT_ULL(32)
> +#define PFERR_GUEST_PAGE_MASK  BIT_ULL(33)
> +#define PFERR_IMPLICIT_ACCESS  BIT_ULL(48)
>
>  #define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |       \
>                                  PFERR_WRITE_MASK |             \
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 60f21bb4c27b..e8b620a85627 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -213,7 +213,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vc=
pu, struct kvm_mmu *mmu,
>          */
>         u64 implicit_access =3D access & PFERR_IMPLICIT_ACCESS;
>         bool not_smap =3D ((rflags & X86_EFLAGS_AC) | implicit_access) =
=3D=3D X86_EFLAGS_AC;
> -       int index =3D (pfec + (not_smap << PFERR_RSVD_BIT)) >> 1;
> +       int index =3D (pfec + (not_smap << ilog2(PFERR_RSVD_MASK))) >> 1;

Just use "(pfec + (not_smap ? PFERR_RSVD_MASK : 0)) >> 1".

Likewise below, "pte_access & PT_USER_MASK ? PFERR_RSVD_MASK : 0"/

No need to even check what the compiler produces, it will be either
exactly the same code or a bunch of cmov instructions.

Paolo

>         u32 errcode =3D PFERR_PRESENT_MASK;
>         bool fault;
>
> @@ -235,7 +235,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vc=
pu, struct kvm_mmu *mmu,
>
>                 /* clear present bit, replace PFEC.RSVD with ACC_USER_MAS=
K. */
>                 offset =3D (pfec & ~1) +
> -                       ((pte_access & PT_USER_MASK) << (PFERR_RSVD_BIT -=
 PT_USER_SHIFT));
> +                       ((pte_access & PT_USER_MASK) << (ilog2(PFERR_RSVD=
_MASK) - PT_USER_SHIFT));
>
>                 pkru_bits &=3D mmu->pkru_mask >> offset;
>                 errcode |=3D -pkru_bits & PFERR_PK_MASK;
> --
> 2.44.0.278.ge034bb2e1d-goog
>


