Return-Path: <linux-kernel+bounces-78758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E17E86186E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321F81C238EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E61272D9;
	Fri, 23 Feb 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FreiXuFB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606F12838B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706909; cv=none; b=qonaTkER4rHYz3B5vlULew1YpPfIY6afjAeCAqLPAF4fDr+tZzbrYyYQyrpv/N2ZTA9dOSj/c2PH6Nk49FoIcr/Fzyn/TTUno8A23cHr0WaVwLPTYK+vdBk2URrxddczTOX9MP39qx9Xu9mPLFU0JnswA9mMu3poBn1yKcmGxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706909; c=relaxed/simple;
	bh=NL6Poyql//ChqFYnAITXk/nlto//1JQfy0RIuysn5XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBHbxSUTXpefTiGU3FC/94jgyIaWDWy4COb6TYw4kphtom9TSSK1pgZ+H3KSwcGKSEwM1hdd4b/S/O8wOzO0R+PRASCHlnwGGVyCLMNlh/BWD8DirGxcj3+puh8Y1tGV+Fokko2N6D8xK5L8HwWgfkJLbyeEeiFASLoj8DBw7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FreiXuFB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708706906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWTBT8l0r4+LfEgX4DGPyzuq25NZlKjkAYRK5GPaE0Y=;
	b=FreiXuFB6WWvFMidsenDSNh+/o5QmJTus2Mbf+aQq3B2KHXodBScY2Yn1J4NskmSHoHOaa
	VSNZmPBkYszQogpLtgal7LirC4JTG590J3ygjMVdNEJUkLz4qb777OHXLI5Vkd1ElMNWpc
	NZJu8eg/wgoeXmuZnaQjxaw2GQu5Rno=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-ERYiSnppOX-CvdKW_0j9Tg-1; Fri, 23 Feb 2024 11:48:24 -0500
X-MC-Unique: ERYiSnppOX-CvdKW_0j9Tg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d2399a08c0so8374321fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708706903; x=1709311703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWTBT8l0r4+LfEgX4DGPyzuq25NZlKjkAYRK5GPaE0Y=;
        b=HP6wjET2gOzkzeayq5zc2HE9HClHfbl5KMtx3xskWxUWlTflPLCu9E23ykJHkfsPBc
         M2jMP6cT6MYRpM4XtUy9O31EYad0TmpcIO4g9gbZQjM5+RI9YoPVHt2lw0gzwPItrHKv
         KNmGhXOKnD4280aoI6j+PTpTt/oF0wvXN9xplEF4d36GLZGjeI0YY2GWLAF2cAw36Xkp
         S2pEyL8b+AAudTWu1UECIH02SEIfTOOyRjkO/JUF7G/m3+NppNGEug5j7MQVHy1m/0IM
         qGLD3OcbNhT4oLJDvtdC4giTkTsYUtAVKRhEO6YFMfqhwNdmlCNIR15XAIAOsFHanSSW
         725A==
X-Gm-Message-State: AOJu0Yw74YXxlN3xLJNR36cM5t2bYoAHAKBM9cRsjOZnXxCjUTVI55iJ
	OnM1p8D2tikr4Rjz/qd/tIMwO6F4/1v41/y/clTAfhe9/O+IalMXeyEW5lQ+0eMB9jqaDtjwg0i
	7nDwDilgYHCsvWGRNzSUydGaX3uYIKx14uoCZ5CprlK8ZZMfNbrnC6eReIlIjD+c6SDr5TCMx30
	afp/ItKoIjxy0Yp/IVphKe9Xakdx8OizbuazOe
X-Received: by 2002:a2e:97cf:0:b0:2d2:3b61:a2b with SMTP id m15-20020a2e97cf000000b002d23b610a2bmr240914ljj.11.1708706903113;
        Fri, 23 Feb 2024 08:48:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3L8Jq/Pr0xzR++9DOj5OHGNQPCSNmFwB1mlOHfr9+KdeJXsyxiieOyfL6BKk400aamUP6IrcyHDkdN1To+jY=
X-Received: by 2002:a2e:97cf:0:b0:2d2:3b61:a2b with SMTP id
 m15-20020a2e97cf000000b002d23b610a2bmr240905ljj.11.1708706902739; Fri, 23 Feb
 2024 08:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223104009.632194-1-pbonzini@redhat.com> <20240223104009.632194-8-pbonzini@redhat.com>
 <ZdjL783FazB6V6Cy@google.com>
In-Reply-To: <ZdjL783FazB6V6Cy@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2024 17:48:10 +0100
Message-ID: <CABgObfYF4pyUDpf0E98xqoJkDsjwXuViasoib-CbB0MUtRNBuQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] KVM: x86: define standard behavior for bits 0/1
 of VM type
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:46=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Feb 23, 2024, Paolo Bonzini wrote:
> > Some VM types have characteristics in common; in fact, the only use
> > of VM types right now is kvm_arch_has_private_mem and it assumes that
> > _all_ VM types have private memory.
> >
> > So, let the low bits specify the characteristics of the VM type.  As
> > of we have two special things: whether memory is private, and whether
> > guest state is protected.  The latter is similar to
> > kvm->arch.guest_state_protected, but the latter is only set on a fully
> > initialized VM.  If both are set, ioctls to set registers will cause
> > an error---SEV-ES did not do so, which is a problematic API.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Message-Id: <20240209183743.22030-7-pbonzini@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  9 +++-
> >  arch/x86/kvm/x86.c              | 93 +++++++++++++++++++++++++++------
> >  2 files changed, 85 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index 0bcd9ae16097..15db2697863c 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2135,8 +2135,15 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_=
t new_pgd);
> >  void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
> >                      int tdp_max_root_level, int tdp_huge_page_level);
> >
> > +
> > +/* Low bits of VM types provide confidential computing capabilities.  =
*/
> > +#define __KVM_X86_PRIVATE_MEM_TYPE   1
> > +#define __KVM_X86_PROTECTED_STATE_TYPE       2
> > +#define __KVM_X86_VM_TYPE_FEATURES   3
> > +static_assert((KVM_X86_SW_PROTECTED_VM & __KVM_X86_VM_TYPE_FEATURES) =
=3D=3D __KVM_X86_PRIVATE_MEM_TYPE);
>
> Aliasing bit 0 to KVM_X86_SW_PROTECTED_VM is gross, e.g. this
>
>  #define KVM_X86_DEFAULT_VM     0
>  #define KVM_X86_SW_PROTECTED_VM        1
> +#define KVM_X86_SEV_VM         8
> +#define KVM_X86_SEV_ES_VM      10
>
> is _super_ confusing and bound to cause problems.
>
> Oh, good gravy, you're also aliasing __KVM_X86_PROTECTED_STATE_TYPE into =
SEV_ES_VM.
> Curse you and your Rami Code induced decimal-based bitwise shenanigans!!!

v1 was less gross but Mike talked me into this one. :)

> I don't see any reason to bleed the flags into KVM's ABI.  Even shoving t=
he flags
> into kvm->arch.vm_type is unncessary.  Aha!  As is storing vm_type as an =
"unsigned
> long", since (a) it can't ever be bigger than u32, and (b) in practice a =
u8 will
> suffice since as Mike pointed out we're effectively limited to 31 types b=
efore
> kvm_vm_ioctl_check_extension() starts returning error codes.
>
> So I vote to skip the aliasing and simply do:

Fair enough.

Paolo


