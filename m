Return-Path: <linux-kernel+bounces-91254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E8870BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB322829C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B9FC09;
	Mon,  4 Mar 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+EizRfY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498DDF67
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585395; cv=none; b=C6Psx7SOZ4ld/V0NK3xNlYpcAeN3CrI3qMgPQO0SWdAHOz0IqvA7EYjfyxj+xkQQDjycCRCi+n92gC1ngYKusKfCOMwnrihVnnnKPhCBhhZXg/mOmnR3U/mAWQbpAaTfylzXQzb7N3uE+YVVOaPoUN8/BHmTCoMGka7eWx+iB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585395; c=relaxed/simple;
	bh=A+CXBTKX4i/CDGbxfMAyWrBuJdNoNwdpxzflMVoCsm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mia1Dw0F+MxyOyidKCstIS9k2rHUJBZ32IOR4QvHR9CTxES5fuoECNSPp3vCfx7TxddP3fvn8bDME+5d0SonTu2NzeKlPFrTiC5D3o4gGWO5LszpA5LDrB3QH5YUgig0YUw+D2L0lCg2bCPS1Z+ay/lwksgYDoWVdZTcu689ZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+EizRfY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6092bf785d7so91451217b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709585393; x=1710190193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wvrqw1J4AWCkZRLQPrePGKOZL8AsSzVG85lzhBNbxRo=;
        b=Z+EizRfYzytRxcDccGpWaCRqTz52e+cvrhSjDaPmvJ7y+1nbOboCu0Lsqb9kYU82r5
         OiK8LZ9DOCPq7vUNcaYJXhuvlaUbqwPRxJ+eEFj0xZz9bzq632kAoXHsuDEWFzL/iLwR
         r/6yuAU+Q2OZ6bZCbRsYBogaFwVsORrq0mIao4wVPol5d8GY59fbRiMT16dGOj/+wpix
         7JU5VrkTPI2xwz8VPT+BLRdlLdBEdG/fZppsyU/NbisXhykecJL/3F4Ukr8Ar2JnjAZL
         TdFvldoj7e/Ighdc/vDHMjmB+SETSaaVW6ry2V0NucgbeRZdEShzaNx21bx+3rEspP52
         4vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585393; x=1710190193;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wvrqw1J4AWCkZRLQPrePGKOZL8AsSzVG85lzhBNbxRo=;
        b=QIxytfO7PzoMo5qc+jgDyrC6pAK3C+CdQ6nwTY7kgYFAEcP7w6LtlRNOTx3pVXRQOx
         SemFMkuSF/dMOS3wkD+Z9KsAn9scFpennlIgjLtOSCns4NuNw8SfM/u/L44kXOYuiIfS
         xblo96uL12JO/NfSO3HtvW+vc4MqFOyjPbJ/m/k6WsjR4RPHLFihDkSzeQDAG2JCMzQK
         vSmCdtcEDr6K5g4bxLR82IxLkD1ysJY5rrHNNwrKVHqMkmkf2ldyrBFEu8Tx1etTeqaN
         SLR2vj/Ae2BIQZeRl5zCtpzK8s5ViQ2Hc00mUwzsPuBKMkf66u6e1sW0GVPuyHR5QJ5R
         eyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK0yRQIqQ8xK/Wg/PoS+ZjGktmSjD5vkkG4v2ysIvK1vjpohhw3MG4xY99AMcrjMxXv7EeM9EXOTZBeVviHbqXA1ybAC8DjV0jXfF0
X-Gm-Message-State: AOJu0YyMoCA4AHbLn1fFMxea9+tLuy17SB0JcNOUhrxwnZhTzE7OplJi
	N6ttQW3IuW+GXGCz5NYweG+NQzFE9NHPZ2P5H36i5G7Iy0B7M2iOwhrNSGFYiQSX1pB2SAGV1a1
	kdg==
X-Google-Smtp-Source: AGHT+IGx/EOpNHqZBkjjnh3CQgKgdI+yO/NSSlFdJYsMld/AjY8gzl6UOYL4ami7Qc4x5X6dBra5pAht7wM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr2589331ybt.6.1709585392894; Mon, 04 Mar
 2024 12:49:52 -0800 (PST)
Date: Mon, 4 Mar 2024 12:49:51 -0800
In-Reply-To: <CALMp9eRbOQpVsKkZ9N1VYTyOrKPWCmvi0B5WZCFXAPsSkShmEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301074423.643779-1-sandipan.das@amd.com> <CALMp9eRbOQpVsKkZ9N1VYTyOrKPWCmvi0B5WZCFXAPsSkShmEA@mail.gmail.com>
Message-ID: <ZeYz7zPGcIQSH_NI@google.com>
Subject: Re: [PATCH] KVM: x86: Do not mask LVTPC when handling a PMI on AMD platforms
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Sandipan Das <sandipan.das@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mlevitsk@redhat.com, vkuznets@redhat.com, mizhang@google.com, 
	tao1.su@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	ravi.bangoria@amd.com, ananth.narayan@amd.com, nikunj.dadhania@amd.com, 
	santosh.shukla@amd.com, manali.shukla@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024, Jim Mattson wrote:
> On Thu, Feb 29, 2024 at 11:44=E2=80=AFPM Sandipan Das <sandipan.das@amd.c=
om> wrote:
> >
> > On AMD and Hygon platforms, the local APIC does not automatically set
> > the mask bit of the LVTPC register when handling a PMI and there is
> > no need to clear it in the kernel's PMI handler.
>=20
> I don't know why it didn't occur to me that different x86 vendors
> wouldn't agree on this specification. :)

Because you're sane?  :-D

> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 3242f3da2457..0959a887c306 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -2768,7 +2768,7 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic=
, int lvt_type)
> >                 trig_mode =3D reg & APIC_LVT_LEVEL_TRIGGER;
> >
> >                 r =3D __apic_accept_irq(apic, mode, vector, 1, trig_mod=
e, NULL);
> > -               if (r && lvt_type =3D=3D APIC_LVTPC)
> > +               if (r && lvt_type =3D=3D APIC_LVTPC && !guest_cpuid_is_=
amd_or_hygon(apic->vcpu))
>=20
> Perhaps we could use a positive predicate instead:
> guest_cpuid_is_intel(apic->vcpu)?

AFAICT, Zhaoxin follows intel behavior, so we'd theoretically have to allow=
 for
that too.  The many checks of guest_cpuid_is_intel() in KVM suggest that no=
 one
actually cares about about correctly virtualizing Zhaoxin CPUs, but it's an=
 easy
enough problem to solve.

I'm also very tempted to say KVM should cache the Intel vs. AMD vCPU model.=
  E.g.
if userspace does something weird with guest CPUID and puts CPUID.0x0 somew=
here
other than the zeroth entry, KVM's linear walk to find a CPUID entry will m=
ake
this a pretty slow lookup.

Then we could also encapsulate the gory details for Intel vs. Zhaoxin vs. C=
entaur,
and AMD vs. Hygon, e.g.

		if (r && lvt_type =3D=3D APIC_LVTPC &&
		    apic->vcpu->arch.is_model_intel_compatible)

