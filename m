Return-Path: <linux-kernel+bounces-87052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FB286CEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A567528BACB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35371428EA;
	Thu, 29 Feb 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KcTK0148"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69613F427
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222562; cv=none; b=c2j7PX/IV7sgFCzksU8MrnezF/JDaiSC4MHzu14aNHb7WxpcvuTEMiOIHLSJTt1mHmh50s5Cyr4WnEsL0L6HXrMEpyKljvjGeM9R4NESh2Bprk5Jm8TRHBLxMQBqFyZbD2A1Y50cJCc7Yq7/ygjniL1cF1im+YUXY2nnPUrAY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222562; c=relaxed/simple;
	bh=wA6/NCRWbGF4UBqPQpanKkBvk0zz/+RnoTAw/npQYHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGxsOZPG2PxdVMMV3mWvBd9xhV9lOe/bb9ySjkjuB4nt7f6aPQPjPs6TZLlk0aZod3uM6e+PU6BanjhQ7xuxA/Y42xYRRneq+Xhd/g5VzxF+yU7AVg+MqWoDXNeSJD7CDHDqKHt4sTLXuZF1HMJqKCzOoj+u0KY3Oa2IweohCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KcTK0148; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso1883638276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709222560; x=1709827360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAuXf0DJO8tOCKY3YV3tHsU6z5YsVb54ZKPvhRBV/xk=;
        b=KcTK0148tHfabq5jySgVFnibytuzlyP/DQ2S8ww34Nnf9svJW/E/V0H5XROLhmaXBR
         jQ9a0cL2bCdoy0f8NLcDwauMMvpugfzfvSpVctrsN/88d2bOhEBQDOefIcz3PINyIAl+
         aTgaII5oJ3m2X1p043V9bOh7j2zJidY8hw1C45Myb0POTzsDqRpWTkl+iRwNbegrHtJG
         W/jZYz3ECuJPwe88ws7oeYH2XOi0lqsCGw3kY8PVejfvoPntG+nySBfL24lFKaWk/iD7
         WTfoMrdJHVX5Y9euKT//s0PDkSQVfPWeTsgf2k/sQQMFV7eyAqJm1at5A68Hx2bNkURa
         Ba5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709222560; x=1709827360;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAuXf0DJO8tOCKY3YV3tHsU6z5YsVb54ZKPvhRBV/xk=;
        b=kmjH+lw9MpwHWLgn6ilXYgGA8ov9M42e+p9VlShapx256vudEWEx+jVo9Vswp7+ldR
         eDvcbpkaxKDhftkpadik0E9gRAwbJ0Oc3SAUtKAQ18WPnVEW22lBDODEEsZ3f0TARLNr
         7bxW3kGP7B5sSQnHBsFurm3lXClcRsqXGiPDeJoLBK4fTqqVSzzhEu0w0oRjXIcLf0fq
         a/BWPhOuR7G0JuJwhEB5XIh8l6n7OmPHd+E2/70ruIFffSNllIxngtvvwN8qvJcoR6Gp
         2ytOv/ZqD3o7tohE104A4Ew7EX4PU4fdY6mS/hJSGGNWNo8FdscYAu2N53xdoArFkgUZ
         Beew==
X-Gm-Message-State: AOJu0YzDrEb7PhLj5jG+KtQHEJYeoNqS5pFJmR0++1Ecd+rsOIfjRXsB
	Ke3d551NC5l31bhfhFMaspT7A+MoCowwz/rIE/9rl0F52vmGgdsXDtIBEKYICLYcFxQn4NvsjCA
	K1g==
X-Google-Smtp-Source: AGHT+IF5NR9OMvvFjif3DsgvK0jpQks91MFMKGd3JY1jrWeykZgUWksJDuC0Z/ca6xul8OXCuHsgaKTxvqI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:e823:9edb with SMTP id
 w2-20020a05690210c200b00dc6e8239edbmr106898ybu.12.1709222560220; Thu, 29 Feb
 2024 08:02:40 -0800 (PST)
Date: Thu, 29 Feb 2024 08:02:38 -0800
In-Reply-To: <CABgObfaPodSSzArO99Hkn=vpGotO1wZ-0dZKEZHx9EqLZ7M_XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <20240227232100.478238-11-pbonzini@redhat.com>
 <Zd6T06Qghvutp8Qw@google.com> <CABgObfaPodSSzArO99Hkn=vpGotO1wZ-0dZKEZHx9EqLZ7M_XQ@mail.gmail.com>
Message-ID: <ZeCqnq7dLcJI41O9@google.com>
Subject: Re: [PATCH 10/21] KVM: SEV: Use a VMSA physical address variable for
 populating VMCB
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024, Paolo Bonzini wrote:
> On Wed, Feb 28, 2024 at 3:00=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Feb 27, 2024, Paolo Bonzini wrote:
> > > From: Tom Lendacky <thomas.lendacky@amd.com>
> > >
> > > In preparation to support SEV-SNP AP Creation, use a variable that ho=
lds
> > > the VMSA physical address rather than converting the virtual address.
> > > This will allow SEV-SNP AP Creation to set the new physical address t=
hat
> > > will be used should the vCPU reset path be taken.
> >
> > No, this patch belongs in the SNP series.  The hanlding of vmsa_pa is b=
roken
> > (KVM leaks the page set by the guest; I need to follow-up in the SNP se=
ries).
> > On top of that, I detest duplicat variables, and I don't like that KVM =
keeps its
> > original VMSA (kernel allocation) after the guest creates its own.
> >
> > I can't possibly imagine why this needs to be pulled in early.  There's=
 no way
> > TDX needs this, and while this patch is _small_, the functional change =
it leads
> > to is not.
>=20
> Well, the point of this series (and there will be more if you agree)
> is exactly to ask "why not" in a way that is more manageable than
> through the huge TDX and SNP series. My reading of the above is that
> you believe this is small enough that it can even be merged with "KVM:
> SEV: Support SEV-SNP AP Creation NAE event" (with fixes), which I
> don't disagree with.

Maybe?  That wasn't my point.

> Otherwise, if the approach was good there's no reason _not_ to get it
> in early. It's just a refactoring.

It's not really a refactoring though, that's why I'm objecting.  If this pa=
tch
stored _just_ the physical adddress of the VMSA, then I would consider it a
refactoring and would have no problem applying it earlier.

But this patch adds a second, 100% duplicate field (as of now), and the rea=
son
it does so is to allow "svm->sev_es.vmsa" to become disconnected from the "=
real"
VMSA that is used by hardware, which is all kinds of messed up.  That's wha=
t I
meant by "the functional change it leads to is not (small)".

> Talking in general: I think I agree about keeping the gmem parts in a
> kvm-coco-queue branch (and in the meanwhile involving the mm people if
> mm/filemap.c changes are needed). #VE too, probably, but what I
> _really_ want to avoid is that these series (the plural is not a typo)
> become a new bottleneck for everybody. Basically these are meant to be
> a "these seem good to go to me, please confirm or deny" between
> comaintainers more than a real patch posting; having an extra branch
> is extra protection against screwups but we should be mindful that
> force pushes are painful for everyone.

Yes, which is largely why I suggested we separate the gmem.  I suspect we'l=
l need
to force push to fixup gmem things, whereas I'm confident the other prep wo=
rk won't
need to be tweaked once it's fully reviewed.

For the other stuff, specifically to avoid creating another bottleneck, my =
preference
is to follow the "normal" rules for posting patches, with slightly relaxed =
bundling
rules.  I.e.  post multiple, independent series so that they can be reviewe=
d,
iterated upon, and applied like any other series.

E.g. my objection to this VMSA tracking patch shouldn't get in the way of t=
he MMU
changes, the #VE patch shoudln't interfere with the vmx/main.c patch, etc. =
 In
other words, throwing everything into a kitchen sink "TDX/SNP prep work" se=
ries
just creates another (smaller) bottleneck.

I am 100% in favor of applying prep patches in advance of the larger SNP an=
d TDX
series.  That's actually partly why I ended up posting my series that inclu=
des
the PFERR_PRIVATE_ACCESS patch; I was trying to pull in using PFERR_GUEST_E=
NC_MASK
and some of the other "simple" patches, and the darn thing failed on me.

