Return-Path: <linux-kernel+bounces-85378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B916286B529
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC141C22CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316AB159588;
	Wed, 28 Feb 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6FzsXR8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972313541F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138353; cv=none; b=ihbZDX7LFK/FHntMphUrDf2DfRull6ywuY5YoP8ifIsKJv1ChspxkyfwC/umU2/KMc0c6lcFTCd43Tcy+fjfluF2QlNieIyj1OTFq3lDnBw+V+1TyrFQYmLNzC+WVL3zOZswOg65t3iyqELo6b0z8F3j50g5V0me8SOj+FGknus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138353; c=relaxed/simple;
	bh=WiX9KtC09wJJPUJJv7ze4L+SsXIBO6G3kahrWm3FGSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgWjHetskof+Y74FNyuDdvjbktCp5hnilqAJBgqEUs8G9ll0D+tdUyzVhToROnyYu2mSqd3qWs2hqTba4ac0syka2muvI4vQg1T2I2daS5BXU5SNdZkwbj7I68SOdyszpKhv3RnqwU/YNNsFNwcIR2NNLX+I2q6vS5/u8Z7828Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6FzsXR8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so10877883276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709138351; x=1709743151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=in1G4Nf0xBzdZL+ZLfa80V34ZfSkT4yQR98VuhCKCF4=;
        b=a6FzsXR8SB7SYky2iq60UtmubtZYgpRK3/8bDVgPdSyPZADqtHa4FlWe9i75HSi6f2
         BJGHqGR8USbY4jqa4+mScSkTrT/2LbfLyrX4DTBwQcP8qk7cLlzWoJfIizAhBBFoVMSC
         6FDI4qoujRKKzbz1bmaMgQH15GOHYznlWqTj5GLOnPY/SSde1i11bUgg5Sqg5gah2jhR
         UgR2J+D03P/+lkXTBEEjMK3eOuIlGvoCByvYCcGOl1dZ+/Z1+pwWPf1CoOMCgOx/wDp9
         cYSHF4JACV/Qi1nbTs1TQ1rmyA0h+f6pW7soj8hro5Xuyd7+LhM3+lvZv2B2X2VOm9zv
         tzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138351; x=1709743151;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=in1G4Nf0xBzdZL+ZLfa80V34ZfSkT4yQR98VuhCKCF4=;
        b=LS6EuQYsjx33p1vRkZ5f1+a3leRGhZ58SdPbm1IKJRuEvOMLjbIO58H+AnZSAVSgix
         g5zISXrd3DNYdKecmqx2lsKlGgr6qKL8qdVjSpPKcei3jwPbA+zhKo8sz42qnq3xH0+O
         W3aIy4tEN85LJHzs5+3xWkCMn0b0tcJ65SiZNq/Hv7FZognRAiIbIhR3C4b0pZfowMzP
         gcwxUaVQL3HM7VhJ+XxR5/9IT+k2Male11jzuUAvqpuQxg1zm5xAb/IWXNfFVB4iOOJN
         DtgWpEfWAMfLFxflCULmswUPEvmhRYtGdMjySfXc83m3gb81wkA+uThq3TGAhLtg/f/A
         S5ZA==
X-Gm-Message-State: AOJu0Yz3Z+dgq1aUOLu2kY7Y8vPg2dKhTiSUHa1lFvw2ptmbag2BRt6d
	2sEYVF6oY+ZePXRzeEQD7+k0yFY8O47FOxO7UTFABpSn7+DdwzOvSUaBBFt03+sGsICzErpKUMn
	Lvw==
X-Google-Smtp-Source: AGHT+IFhfNyqrQkVj+BlwOzo9dGaRw3xoN6XW/JX6zn2UpjdUQ3bd6mSpfQCrTVfNzBjz3V+p7x34Jhjb18=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1507:b0:dc6:e1ed:bd1a with SMTP id
 q7-20020a056902150700b00dc6e1edbd1amr835132ybu.2.1709138350982; Wed, 28 Feb
 2024 08:39:10 -0800 (PST)
Date: Wed, 28 Feb 2024 08:39:09 -0800
In-Reply-To: <CABgObfYpRJnDdQrxp=OgjhbT9A+LHK36MHjMvzcQJsHAmfX++w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <Zd6LK7RpZZ8t-5CY@google.com>
 <CABgObfYpRJnDdQrxp=OgjhbT9A+LHK36MHjMvzcQJsHAmfX++w@mail.gmail.com>
Message-ID: <Zd9hrfJ5xRI6HeZp@google.com>
Subject: Re: [PATCH 00/21] TDX/SNP part 1 of n, for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024, Paolo Bonzini wrote:
> On Wed, Feb 28, 2024 at 2:25=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > Michael Roth (2):
> > >   KVM: x86: Add gmem hook for invalidating memory
> > >   KVM: x86: Add gmem hook for determining max NPT mapping level
> > >
> > > Paolo Bonzini (6):
> > >   KVM: x86/mmu: pass error code back to MMU when async pf is ready
> > >   KVM: x86/mmu: Use PFERR_GUEST_ENC_MASK to indicate fault is private
> >
> > This doesn't work.  The ENC flag gets set on any SNP *capable* CPU, whi=
ch results
> > in false positives for SEV and SEV-ES guests[*].
>=20
> You didn't look at the patch did you? :)

Guilty, sort of.  I looked (and tested) the patch from the TDX series, but =
I didn't
look at what you postd.  But it's a moot point, because now I did look at w=
hat you
posted, and it's still broken :-)

> It does check for has_private_mem (alternatively I could have dropped the=
 bit
> in SVM code for SEV and SEV-ES guests).

The problem isn't with *KVM* setting the bit, it's with *hardware* setting =
the
bit for SEV and SEV-ES guests.  That results in this:

  .is_private =3D vcpu->kvm->arch.has_private_mem && (err & PFERR_GUEST_ENC=
_MASK),

marking the fault as private.  Which, in a vacuum, isn't technically wrong,=
 since
from hardware's perspective the vCPU access was "private".  But from KVM's
perspective, SEV and SEV-ES guests don't have private memory, they have mem=
ory
that can be *encrypted*, and marking the access as "private" results in vio=
lations
of KVM's rules for private memory.  Specifically, it results in KVM trigger=
ing
emulated MMIO for faults that are marked private, which we want to disallow=
 for
SNP and TDX.

And because the flag only gets set on SNP capable hardware (in my limited t=
esting
of a whole two systems), running the same VM on different hardware would re=
sult
in faults being marked private on one system, but not the other.  Which mea=
ns that
KVM can't rely on the flag being set for SEV or SEV-ES guests, i.e. we can'=
t
retroactively enforce anything (not to mention that that might break existi=
ng VMs).

