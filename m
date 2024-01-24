Return-Path: <linux-kernel+bounces-37787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168C83B501
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C295FB23471
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD44136656;
	Wed, 24 Jan 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhIKCunL"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CF86157
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136707; cv=none; b=V6bd53EmAoJzBxPKqF/adU+yMmVqsh9/rgB0ZA1+I7UYNoXtnNV7Wira52GM1MunG43qtR2DwBO0s+muEop2WiOUCNRIGEeG5mnljnpV/sFj/beP+ajhRnoRceg9hWt6mFngJSLUpcmPeARnf5m0ICg1CwOKrhDqttRwl4Wek7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136707; c=relaxed/simple;
	bh=y7HxV+Np84h3b7pFhizDvvwdV72exh3vv8aNoSMmLIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UFFTKIXM8aZgVRanoCFM6rFC2k957eFikMifUCi5Jhu95HTl69KWrRQOuGum749Ihzvn4qoTC4yII5LVoFC83CGGu3RcWnR9+ZuHlViTP7jN8TddjJY+f1/vjRd/pHCzfmoK2wSs4CsaVCZ3eS0KwRkbQ6wmdD9N9HIIJAJZ/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhIKCunL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6dbcdfde0eeso3330393b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706136704; x=1706741504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSbhtgohGq6DFg+wGmtT8BdfOQwttX56L77yjeBITeU=;
        b=DhIKCunLpMhFW0QSfP15NrcP/m9j7U3Hn7O760/l3ZQNiNnIJfWnSjo/UOPo63o8hi
         rUJeaY8CA9mITtvYPXfbmHUxH/8nuotzo0yf0mannP3iHQ5or/n4eSdxTPolWQ5RY4u/
         zVoeLjI24MKP+KO+CtEPYvc1UXkRwlLwpXDmBhh64qAAnIXvV6edXX6mm81swHbA/5gB
         fP1JvmXwJfXBjcEFEh9aLHu5DrBvNyPJ6HllYexAh0tlGjMudBvZeP9Om0FPDJJAIqts
         I3Nu9hnRxjc+5TWlw5RxHWI1qSjBn+rRQTlNhLmOrweZzw7Dq84wdTDxzHdwKkJYx+Qu
         4rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136704; x=1706741504;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rSbhtgohGq6DFg+wGmtT8BdfOQwttX56L77yjeBITeU=;
        b=voD9zsvYnPULoqF57IJxohogV9srkgL84Ek/r0ly5MUFyZPx6DJCvJTFoRoU8F/Muu
         zcnft1NwE4OGSYn6E6nLdez5DBf1gek4U0esbywzsK/et/dT9l26v400enY6DINWUirB
         IJ/XXDB8QwaLqcZRZBqcjgveGePZS/Ql52winQyCvgDIfkxnx0LBi/KazlPwNsGFIKsg
         jCcyy9u/7OwLTj/cCkI53D5QorDrGHOgs+Z31oL9ITkU5b1QI0glG3DTk5IhrqhO6RAI
         zm4RMr9hhJpLefZBriwiWAA0C1eHRqk3lkd8TIHbdBTxVgdGWamk6DhkdACn6qNjtx3D
         f5rQ==
X-Gm-Message-State: AOJu0Yy3s1Y5FPqS7l/l8npZlDTSgXlBVJUml5DbOAPQ2r+Eu4C2GCTt
	91SwT8DrZo5ieDQp24Mb/P3FsEXfuVB15ln+9p40l86WeIZTxUUWyqZj2hEYikXz3v5Zw7c/UVn
	qSA==
X-Google-Smtp-Source: AGHT+IFm8oubNdRBgNaQ9Mu4OrYjWXUylJvpMx3BJ4yGVDTXCO+qVZubo+OT0sSxQplEMU4UIy+VDvaC1Q4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1889:b0:6da:53fc:b263 with SMTP id
 x9-20020a056a00188900b006da53fcb263mr24862pfh.5.1706136703888; Wed, 24 Jan
 2024 14:51:43 -0800 (PST)
Date: Wed, 24 Jan 2024 14:51:42 -0800
In-Reply-To: <ZbGOK9m6UKkQ38bK@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124003858.3954822-1-mizhang@google.com> <20240124003858.3954822-2-mizhang@google.com>
 <ZbExcMMl-IAzJrfx@google.com> <CAAAPnDFAvJBuETUsBScX6WqSbf_j=5h_CpWwrPHwXdBxDg_LFQ@mail.gmail.com>
 <ZbGAXpFUso9JzIjo@google.com> <ZbGOK9m6UKkQ38bK@google.com>
Message-ID: <ZbGUfmn-ZAe4lkiN@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/pmu: Reset perf_capabilities in vcpu to 0 if
 PDCM is disabled
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024, Mingwei Zhang wrote:
> On Wed, Jan 24, 2024, Sean Christopherson wrote:
> > On Wed, Jan 24, 2024, Aaron Lewis wrote:
> > > On Wed, Jan 24, 2024 at 7:49=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Wed, Jan 24, 2024, Mingwei Zhang wrote:
> > > > No, this is just papering over the underlying bug.  KVM shouldn't b=
e stuffing
> > > > vcpu->arch.perf_capabilities without explicit writes from host user=
space.  E.g
> > > > KVM_SET_CPUID{,2} is allowed multiple times, at which point KVM cou=
ld clobber a
> > > > host userspace write to MSR_IA32_PERF_CAPABILITIES.  It's unlikely =
any userspace
> > > > actually does something like that, but KVM overwriting guest state =
is almost
> > > > never a good thing.
> > > >
> > > > I've been meaning to send a patch for a long time (IIRC, Aaron also=
 ran into this?).
> > > > KVM needs to simply not stuff vcpu->arch.perf_capabilities.  I beli=
eve we are
> > > > already fudging around this in our internal kernels, so I don't thi=
nk there's a
> > > > need to carry a hack-a-fix for the destination kernel.
> > > >
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index 27e23714e960..fdef9d706d61 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -12116,7 +12116,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *v=
cpu)
> > > >
> > > >         kvm_async_pf_hash_reset(vcpu);
> > > >
> > > > -       vcpu->arch.perf_capabilities =3D kvm_caps.supported_perf_ca=
p;
> > >=20
> > > Yeah, that will fix the issue we are seeing.  The only thing that's
> > > not clear to me is if userspace should expect KVM to set this or if
> > > KVM should expect userspace to set this.  How is that generally
> > > decided?
> >=20
> > By "this", you mean the effective RESET value for vcpu->arch.perf_capab=
ilities?
> > To be consistent with KVM's CPUID module at vCPU creation, which is com=
pletely
> > empty (vCPU has no PMU and no PDCM support) KVM *must* zero
> > vcpu->arch.perf_capabilities.
> >=20
> > If userspace wants a non-zero value, then userspace needs to set CPUID =
to enable
> > PDCM and set MSR_IA32_PERF_CAPABILITIES.
> >=20
> > MSR_IA32_ARCH_CAPABILITIES is in the same boat, e.g. a vCPU without
> > X86_FEATURE_ARCH_CAPABILITIES can end up seeing a non-zero MSR value.  =
That too
> > should be excised.
> >=20
> hmm, does that mean KVM just allows an invalid vcpu state exist from
> host point of view?

Yes.

https://lore.kernel.org/all/ZC4qF90l77m3X1Ir@google.com

> I think this makes a lot of confusions on migration where VMM on the sour=
ce
> believes that a non-zero value from KVM_GET_MSRS is valid and the VMM on =
the
> target will find it not true.

Yes, but seeing a non-zero value is a KVM bug that should be fixed.

> If we follow the suggestion by removing the initial value at vCPU
> creation time, then I think it breaks the existing VMM code, since that
> requires VMM to explicitly set the MSR, which I am not sure we do today.

Yeah, I'm hoping we can squeak by without breaking existing setups.

I'm 99% certain QEMU is ok, as QEMU has explicitly set MSR_IA32_PERF_CAPABI=
LITIES
since support for PDCM/PERF_CAPABILITIES was added by commit ea39f9b643
("target/i386: define a new MSR based feature word - FEAT_PERF_CAPABILITIES=
").

Frankly, if our VMM doesn't do the same, then it's wildly busted.  Relying =
on
KVM to define the vCPU is irresponsible, to put it nicely.

> The following code below is different. The key difference is that the
> following code preserves a valid value, but this case is to not preserve
> an invalid value.=20

But it's a completely different fix.  I referenced that commit to call out =
that
the need for the commit and changelog suggests that someone (*cough* us) is=
 relying
on KVM to initialize MSR_PLATFORM_INFO, and has been doing so for a very lo=
ng time.
That doesn't mean it's the correct KVM behavior, just that it's much riskie=
r to
change.

