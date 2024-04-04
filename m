Return-Path: <linux-kernel+bounces-131886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE05898D2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA051F2B593
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFB12D75D;
	Thu,  4 Apr 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFTpsqRA"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3012D1ED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251698; cv=none; b=MpaCAxMY/iv8G0KjiDyd3Row/7vKyfvPF9Ct71Q9qMraZQYf/WRr8PX/1aQOfsp9yQXcFt7S6Jr07nw+AZDtuErwf6Y3W2dkcD11u/ngyMU3kZcdtia/iKBl9QPERLFHWpZFkqaF7cVWTNzuwq9d+FFTbVkxf8YacUYrPyqUW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251698; c=relaxed/simple;
	bh=D3aYiOPIxPOZS3eRbKRLXj6Y5q1Ef56Wx4Df7OIWkgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pWDg1kjR4ghqkVsEcEinNtVo5VODUBigsfJWE+Jlhhc1+sK01dKrUE21C+uS+oMra/QjMfNszApXX0FhGqismHN8Ezm7O+N+CHEPYXoPzpp1xrJBDeXzqH/1Mt3ma8weXBrPcA3mty/xmvgUtDeh2V0o98KOHUsKpZpS6uMmTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFTpsqRA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e71495a60dso1167248b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712251696; x=1712856496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSwC3j2BdhIS9vxwcZkcKh/sBAuW7HXm2ZENh5jro+E=;
        b=OFTpsqRAy1fZobYnZnKnVxOVFYhn+zm2na9p7VsFW9yR1gypf0Sg7JGnrO5VpenL59
         G1nm0qN+n/ltBmAcT+fnBFmbPYpwAhOZmI+mAC0oO0THzlMCPy4cj2z37ucDd1wcsjhP
         NuH/oca9kHXg7HLHXO0vNvguhAeCHFJyHv5Xe26+7dbCYmcE47onxbpvd+N9Ion1fUQq
         qrxIf43imLvjpo33siuYlmZCEQPqgq6K/FElB1qB/vKFkCS8QXzrXg0R+uzqM3sFOWF0
         LfNUO8cdlswf6L52KPGNJb/cmrU19KecIxoOcDvrnCVsrHOg0CB5+t2dssHy8wAmjQl9
         n3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712251696; x=1712856496;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zSwC3j2BdhIS9vxwcZkcKh/sBAuW7HXm2ZENh5jro+E=;
        b=p2ZG1LBdpdhbCD8DARYcb14hCnec5i8WwQOBhjbRUXVASMHXD5zgX74jWspTKdAwLS
         +Dho5EOKCvjrmI7dPy6JC4pybu1SuXvROoUN9FwDYDsD93I59KAgnFO2maxKqWXR71V+
         8ay0OspBtC1AiPC2whjSxtQ6LPN/mhr132jsE9rAGRYWb4JrlEc3WyNmTty+467Xm9hS
         zcIa58WvSGyfntNmfvP3BMubDmiRe86wK5cA5hQdc2toaxhUxyEH4lwMpSQPA8HLDljV
         gfqlmH+ACPgfTaxKakpVtOCsbN/8izfOhFFIalsyX2QxC425JIzJ2N5dp82DWMxSmKVY
         CufA==
X-Forwarded-Encrypted: i=1; AJvYcCXnGC5Z9W/rtmtLPCCRRNH8t0XhVWNpOlBF/RQP6n68F3WlpLkUz+eDXqsZKktTDJezeCBtpF1r3cIlqurNI1vHmHn9cwKWUcOh5mxl
X-Gm-Message-State: AOJu0YwDQnI1/oJG8XM00QcUFojMymSm01LREL4AwOjIQml+SoFVhFb0
	nKApphq1yfcHhKBb5SLsYzof4uu23ymgTBkV//ICGF4NZkD3O7hSO2j0+g5zWqkssEiW2eUzqNU
	z6A==
X-Google-Smtp-Source: AGHT+IFHho3ljmmEFOSUmSO7f/Uvf9/SnlAEf3GEtjn193NWfmqjqrx8B0XGGvIWckHh/6UjnA/5hwcOQH0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9296:b0:6ea:c44e:bc8c with SMTP id
 jw22-20020a056a00929600b006eac44ebc8cmr5728pfb.3.1712251696106; Thu, 04 Apr
 2024 10:28:16 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:28:14 -0700
In-Reply-To: <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240324190503.116160-1-xry111@xry111.site> <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zg7S5dk3J4Zc82nj@google.com> <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
Message-ID: <Zg7jLn-lV55Yh6mH@google.com>
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Sean Christopherson <seanjc@google.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Xi Ruoyao <xry111@xry111.site>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024, Andrew Cooper wrote:
> On 04/04/2024 5:18 pm, Sean Christopherson wrote:
> > On Mon, Mar 25, 2024, Michael Kelley wrote:
> >>>  static void setup_pcid(void)
> >>>  {
> >>> +	const struct x86_cpu_id *invlpg_miss_match;
> >>> +
> >>>  	if (!IS_ENABLED(CONFIG_X86_64))
> >>>  		return;
> >>>
> >>>  	if (!boot_cpu_has(X86_FEATURE_PCID))
> >>>  		return;
> >>>
> >>> -	if (x86_match_cpu(invlpg_miss_ids)) {
> >>> +	invlpg_miss_match =3D x86_match_cpu(invlpg_miss_ids);
> >>> +	if (invlpg_miss_match &&
> >>> +	    invlpg_miss_match->driver_data > boot_cpu_data.microcode) {
> >>>  		pr_info("Incomplete global flushes, disabling PCID");
> >>>  		setup_clear_cpu_cap(X86_FEATURE_PCID);
> >>>  		return;
> >> As noted in similar places where microcode versions are
> >> checked, hypervisors often lie to guests about microcode versions.
> >> For example, see comments in bad_spectre_microcode().  I
> >> know Hyper-V guests always see the microcode version as
> >> 0xFFFFFFFF (max u32 value).  So in a Hyper-V guest the above
> >> code will always leave PCID enabled.
> > Enumerating broken PCID support to a guest is very arguably a hyperviso=
r bug.
> > Hypervisors also lie to guest about FMS.  As KVM *user* with affected h=
ardware
> > (home box), I would want the kernel to assume PCID works if X86_FEATURE=
_HYPERVISOR
> > is present.
>=20
> I have very mixed feelings about all of this.
>=20
> The Gracemont INVLPG vs PCID bug was found in the field, so PCID will
> have been enumerated to guests at that point.=C2=A0 You can't blindly dro=
p
> PCID until the VM next reboots.
>=20
> A related example.=C2=A0 I wrote the patch to hide XSAVES to work around =
an
> AMD erratum where XSAVEC sufficed, and the consequences were so dire for
> some versions of Windows that there was a suggestion to simply revert
> the workaround to make VMs run again.=C2=A0 Windows intentionally asserts
> sanity (=3D=3D expectations) in what it can see; I have no idea whether i=
t
> would object in this case but hiding PCID is definitely playing with fire=
.

Yeah, KVM users got burned by that too.  d52734d00b8e ("KVM: x86: Give a hi=
nt when
Win2016 might fail to boot due to XSAVES erratum").

But practically speaking, that ship has sailed for KVM, as KVM advertises P=
CID
support if and only if the host kernel supports it, i.e. clearing X86_FEATU=
RE_PCID
in setup_pcid() means KVM stops advertising to userspace, which in turn mea=
ns
QEMU stops enumerating it VMs by default.

> I am frequently dismayed at how many FMS abuses there are in Linux, and
> I'm this >< close to talking a leaf out of HyperV's book and poisoning
> FMS to 0 or ~0 just like the microcode revision.=C2=A0=C2=A0 Any use of F=
MS for
> anything other than diagnostic purposes under virt is live migration bug
> waiting to happen.
>=20
> Xen's current TLB algorithms ensure never to have both PCID and PGE
> active together, so we managed to dodge this particular mess.=C2=A0 But a=
s a
> consequence, we've got no logic to spot it, or to consider changing PCID
> visibility.=C2=A0 That said, for better or worse, the ucode revision is
> visible (for now), and a guest which polls the revision will even spot
> the hypervisor doing a late ucode load.
>=20
> Sorry I don't have any better suggestions.=C2=A0 The only nice(ish) of fi=
xing
> this for the guest kernel is for Intel to allocate a $FOO_NO bit, and
> it's horrible in every other way.

Hmm, one crazy idea would be to carve out a hypervisor CPUID range for enum=
erating
(potentially) broken features.  Dealing with the Intel/AMD (and Centaur, LO=
L),
0 / 0x8000_0000 split would be annoying, but not hard.  E.g. use 0x4{0,8,C}=
01_xxxx
to enumerate broken features, and then the guest could do:

	support =3D CPUID(leaf).reg & ~CPUID(to_pv_broken(leaf)).reg;

It'd require a decent amount of churn for the initial support, but it would=
 give
hypervisors a way to inform guests that _any_ CPUID-based feature is broken=
,
without requiring guest changes (after the initial code is merged) or expli=
cit
action from hardware vendors.

And if we got Windows/Hyper-V in on the game, it would allow them to keep t=
heir
sanity checks while (hopefully) degrading gracefully if a feature is enumer=
ated
as broken.

