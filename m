Return-Path: <linux-kernel+bounces-62030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3E851A90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CFD2887C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E183DBA1;
	Mon, 12 Feb 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzGLhoNJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9D3D0C6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757336; cv=none; b=qvMyR1EyuoV1iZx6wkDYcKJKwlZpylxzIjOYxQGhsX7Zd3GM7svvypdZgyPPrrQ7eI4g+Tk/qt3omydUzWrvVyjslIM5m2+J/cYveG3uutKgCCBcJIb599Uwmke68dRSI48w4Zwg+B4gctigAJCUEKMDFIvLn4w7/41MEsTSZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757336; c=relaxed/simple;
	bh=r+fd6gc2wHOtnEcUyphtPRN7b9wjmwB3NER9JLbp2/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZS4CW0nfed7tw5vkIt4rWXArhS/xV6Byw2iRqmlphjQMoKVQskFRORABKZkO94sF6gnsLQ4sog0PbTL13k5nIdSuRSKRLzYbbCIBywt9UM3fSXIo56J/eW64ncdemninQMhqdLNxz5AR6U7875m6TjKSqFIhLeNHOA88ZIrWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzGLhoNJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xp7gNBv2Jdgu6ipEnFwfAZMrvYa1++S5m681LZp5tw=;
	b=HzGLhoNJeKx9lSA4r8mZjHEDd9NXLaJshBBRj92BueCVisn9BKcgZHiPwP053m0odtCAgV
	tgmlJj2+9tm3/8bID6hVzMTpPy2Px1MqFn+m3sadz0TURL1TT7WM3L5fgmp12nrCprLdB0
	h0CDkQCNcpP2H7VktMK2+re4o6XEyzg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-QeFnQR17P_aJdpzUYr87pw-1; Mon, 12 Feb 2024 12:02:09 -0500
X-MC-Unique: QeFnQR17P_aJdpzUYr87pw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bfd890774eso2531650b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757327; x=1708362127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xp7gNBv2Jdgu6ipEnFwfAZMrvYa1++S5m681LZp5tw=;
        b=EszYSW+Oq2tOIUdyencABw2b1Pws5Wsn81CrY/OwOl98CBvOJhjkbcUOpRDFHW6GaG
         0FCOfMZN/xDB0q4qae8nToADC9wUvkvK8GJMzmEuRYzYyXd02osixTN7u/rxDyg7nOED
         o3RyyZKdbCngsZd4p0q0ceIf1UVik60LKUJ68wmrCaKnjP54Lx+e3fHV3EKgIrfJoG15
         ZbWi0epkKRvfCTN1/e/PBsFTCGk/KU+MVi+K8lQvbLeuEg6b3wwdPQ9S7ksSTrIYW567
         Dupxz0UM8vdPZsCcrEdVP81q4jDXoqSPDMFLsXt9apd4mFXttZq/6lYHEC5wBkZAbZ0D
         2sMg==
X-Gm-Message-State: AOJu0YyLH9ybbqxipi/khTshFtq2dxrIXlDORDjZUFcV7yBqSnrWu2z8
	iBNPtLVYPhyO720Yrc9gbDcK3OaxLFt5tk7u8Hh0Wghup2QXRrKc0OdOxLcmzNN2W0FTrn0DHCY
	SvvthMcmx3tqkxdpbrtMVrZt4R/OZlnXn1g1I4Zzuo2SFjV2LFyJBslJKDdJoiVq7Blj9FP8zF7
	QiuJxYE530b8isIECr4f1uzdG8DdivTQSE4Bz7
X-Received: by 2002:a05:6808:138b:b0:3c0:31e5:35f1 with SMTP id c11-20020a056808138b00b003c031e535f1mr6116248oiw.36.1707757327454;
        Mon, 12 Feb 2024 09:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCFax7iOyuTjts+iORw8GZdLYnDFGPnLUiSaDSP/ju4W8BO+P1UaZiXkLE5e/PfH3uG4VPrFduuFeVfmg1qE8=
X-Received: by 2002:a05:6808:138b:b0:3c0:31e5:35f1 with SMTP id
 c11-20020a056808138b00b003c031e535f1mr6116210oiw.36.1707757327107; Mon, 12
 Feb 2024 09:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <91c797997b57056224571e22362321a23947172f.1705965635.git.isaku.yamahata@intel.com>
In-Reply-To: <91c797997b57056224571e22362321a23947172f.1705965635.git.isaku.yamahata@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Feb 2024 18:01:54 +0100
Message-ID: <CABgObfYP4n12HOSx5XsibA==hmPCVe9hHZFTsJTTxBHA5pffwA@mail.gmail.com>
Subject: Re: [PATCH v18 040/121] KVM: x86/mmu: Disallow fast page fault on
 private GPA
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, 
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:55=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> TDX requires TDX SEAMCALL to operate Secure EPT instead of direct memory
> access and TDX SEAMCALL is heavy operation.  Fast page fault on private G=
PA
> doesn't make sense.  Disallow fast page fault on private GPA.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b2924bd9b668..54d4c8f1ba68 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3339,8 +3339,16 @@ static int kvm_handle_noslot_fault(struct kvm_vcpu=
 *vcpu,
>         return RET_PF_CONTINUE;
>  }
>
> -static bool page_fault_can_be_fast(struct kvm_page_fault *fault)
> +static bool page_fault_can_be_fast(struct kvm *kvm, struct kvm_page_faul=
t *fault)
>  {
> +       /*
> +        * TDX private mapping doesn't support fast page fault because th=
e EPT
> +        * entry is read/written with TDX SEAMCALLs instead of direct mem=
ory
> +        * access.
> +        */
> +       if (kvm_is_private_gpa(kvm, fault->addr))
> +               return false;

I think this does not apply to SNP? If so, it would be better to check
the SPTE against the shared-page mask inside the do...while loop.

Paolo

>         /*
>          * Page faults with reserved bits set, i.e. faults on MMIO SPTEs,=
 only
>          * reach the common page fault handler if the SPTE has an invalid=
 MMIO
> @@ -3450,7 +3458,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, s=
truct kvm_page_fault *fault)
>         u64 *sptep;
>         uint retry_count =3D 0;
>
> -       if (!page_fault_can_be_fast(fault))
> +       if (!page_fault_can_be_fast(vcpu->kvm, fault))
>                 return ret;
>
>         walk_shadow_page_lockless_begin(vcpu);
> --
> 2.25.1
>


