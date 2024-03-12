Return-Path: <linux-kernel+bounces-100490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88D879888
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B15B225B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFEC7D410;
	Tue, 12 Mar 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tuBTs/vq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC37AE40
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259635; cv=none; b=TWplKm7Qe+9jnKViElr0zuUIHeN/v9EjElt760cv4J2ZctMFa8jIcRsJhjLF+wGRtK5e2GXTRJUYE3f1cN72jiiszAskvo7GtL0Q58XSTYtHkiWWTqIen7uV1JcqT1n4ZNhSH+AxwBvsQz6TO81iob/szaS/9h1pR0CGJexBnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259635; c=relaxed/simple;
	bh=47TghUwia3cDXWzAp+/WdYGMW2Xw4pp2SA8uGm+22R8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6gJK+eWbeZFGoBeWl0BkvqN1P450H4doqcjPRpwR3IR/4V9eN52yt2EN6kfvO67jzpG+OO9uNMk95ZWZGLNVv/MT8NaHUOt/m4O9Jnj3xyy+iph1CczNS11GPnqX0VH8i4R0gWph5dX7U+YlkMgQzZMTMb7XT25bmsCVYMVQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuBTs/vq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso337284276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710259633; x=1710864433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7e0yop2/9+XMKAheD47D9K6LZNyzgq+q+UXRKcgLqk=;
        b=tuBTs/vqIOggA55Pl4RnrzAr7JOJPFsO9whNKTNbbCzAQJyuK7gWcZafNs/qdAIyMi
         pnlGSJ3D6Swr26/Y9+iymRe3Rb5GfdOhPg3lZrsPw8sILHf8+pG8bsVfOVNeOIIjhLng
         XvQxEKYvWTO6oQXAo9DAEP4QgIFRGUcc10t+oW/vVF59jAr4nXukwko/IfTlVhXT6LR9
         GP1Jm7VRDAoGkPSHGCSndw7MoEMzk3x3YEUajoV5UHyiDSybNVp07FjsIF8wMdyA5dTL
         8QKjRJwvf4/MgUFs9WdMn1QrtADb/gwwUJ0jAutwlreIgT04pvkKrCnGLnPXV1lmPvwv
         MCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259633; x=1710864433;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7e0yop2/9+XMKAheD47D9K6LZNyzgq+q+UXRKcgLqk=;
        b=VR/TJQtKjoz5icSvTl7GEeQVe6u+tl3vQUZFL5XA9eelHCHQLcJSY3qFLhrWnD/nA/
         UctXITqsx3hk4RjmQzz05fiHN7zC4mulfUNMKkyCqY2TjKpLLSoLp8UAtvGRzZ9aIBqT
         dCrGYyj6L5nb/4St+36x8wLsUrjsCQZqcJRknQpen8KutIlRb+2ic0O6ep9DXJQvjU8o
         IkcDGmGD+i6XSU4l4oh7If6IvyGQnZxN0KxCQTcZGFjIBxpeYNCkyWoOgbLtfBzSiezV
         8YTSwWrnJ5iBlRo040ty6QZRAPmkuvoshFxjxmYyG/Jizv54gRaGIM1CCDhzbEBngpOb
         7upQ==
X-Forwarded-Encrypted: i=1; AJvYcCWel7GVFq8WIb5REL2J9tqDkW0P9drxHHoVAkiheJA/eJpj/sU9iRzeCamqHR7I3yVQG/+G0IT4UAT42/tuqo6ktexvgPygphVdEP8n
X-Gm-Message-State: AOJu0Yyy7fU0gp4JecewOTZ80/3WRnvylRWBt3Zw6TK/V0R9o9KbZCfW
	atXNdGZRaXUCPqDklgeA+ivDiaihxbgYOrNE+k5dMiPq+ZVNLTym8xfXXRxr8cqLEfKaRwP3YPD
	5Sg==
X-Google-Smtp-Source: AGHT+IFwdZ9eOBSFBgjZo0PZa4mDo+kneFiPsNfkgVCecBExcgqHC6KVLvlgXd85cKUbVjuC6QrJ/n9KmJc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:98c5:0:b0:dc6:e884:2342 with SMTP id
 m5-20020a2598c5000000b00dc6e8842342mr3079063ybo.5.1710259633210; Tue, 12 Mar
 2024 09:07:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 09:07:11 -0700
In-Reply-To: <BN9PR11MB527600EC915D668127B97E3C8C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-6-seanjc@google.com>
 <Ze5bee/qJ41IESdk@yzhao56-desk.sh.intel.com> <Ze-hC8NozVbOQQIT@google.com> <BN9PR11MB527600EC915D668127B97E3C8C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Message-ID: <ZfB9rzqOWmbaOeHd@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Kevin Tian <kevin.tian@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024, Kevin Tian wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > Sent: Tuesday, March 12, 2024 8:26 AM
> >=20
> > On Mon, Mar 11, 2024, Yan Zhao wrote:
> > > For the case of !static_cpu_has(X86_FEATURE_SELFSNOOP) &&
> > > kvm_arch_has_noncoherent_dma(vcpu->kvm), I think we at least should w=
arn
> > > about unsafe before honoring guest memory type.
> >=20
> > I don't think it gains us enough to offset the potential pain such a
> > message would bring.  Assuming the warning isn't outright ignored, the =
most
> > likely scenario is that the warning will cause random end users to worr=
y
> > that the setup they've been running for years is broken, when in realit=
y
> > it's probably just fine for their
> > use case.
>=20
> Isn't the 'worry' necessary to allow end users evaluate whether "it's
> probably just fine for their use case"?

Realistically, outside of large scale deployments, no end user is going to =
be able
to make that evaluation, because practically speaking it requires someone w=
ith
quite low-level hardware knowledge to be able to make that judgment call.  =
And
counting by number of human end users (as opposed to number of VMs being ru=
n), I
am willing to bet that the overwhelming majority of KVM users aren't kernel=
 or
systems engineers.

Understandably, users tend to be alarmed by (or suspicious of) new warnings=
 that
show up.  E.g. see the ancient KVM_SET_TSS_ADDR pr_warn[*].  And recently, =
we had
an internal bug report filed against KVM because they observed a performanc=
e
regression when booting a KVM guest, and saw a new message about some CPU
vulnerability being mitigated on VM-Exit that showed up in their *guest* ke=
rnel.

In short, my concern is that adding a new pr_warn() will generate noise for=
 end
users *and* for KVM developers/maintainers, because even if we phrase the m=
essage
to talk specifically about "untrusted workloads", the majority of affected =
users
will not have the necessary knowledge to make an informed decision.

[*] https://lore.kernel.org/all/f1afa6c0-cde2-ab8b-ea71-bfa62a45b956@tarent=
de

> I saw the old comment already mentioned that doing so may lead to unexpec=
ted
> behaviors. But I'm not sure whether such code-level caveat has been visib=
le
> enough to end users.

Another point to consider: KVM is _always_ potentially broken on such CPUs,=
 as
KVM forces WB for guest accesses.  I.e. KVM will create memory aliasing if =
the
host has guest memory mapped as non-WB in the PAT, without non-coherent DMA
exposed to the guest.

> > I would be quite surprised if there are people running untrusted worklo=
ads
> > on 10+ year old silicon *and* have passthrough devices and non-coherent
> > IOMMUs/DMA.
>=20
> this is probably true.
>=20
> > And anyone exposing a device directly to an untrusted workload really
> > should have done their homework.
>=20
> or they run trusted workloads which might be tampered by virus to
> exceed the scope of their homework. =F0=9F=98=8A

If a workload is being run in a KVM guest for host isolation/security purpo=
ses,
and a device was exposed to said workload, then I would firmly consider ana=
lyzing
the impact of a compromised guest to be part of their homework.

> > And it's not like we're going to change KVM's historical behavior at th=
is point.
>=20
> I agree with your point of not breaking userspace. But still think a warn=
ing
> might be informative to let users evaluate their setup against a newly
> identified "unexpected behavior"  which has security implication beyond
> the guest, while the previous interpretation of "unexpected behavior"=20
> might be that the guest can at most shoot its own foot...

If this issue weren't limited to 10+ year old hardware, I would be more inc=
lined
to add a message.  But at this point, realistically the only thing KVM woul=
d be
saying is "you're running old hardware, that might be unsafe in today's wor=
ld".

For users that care about security, we'd be telling them something they alr=
eady
know (and if they don't know, they've got bigger problems).  And for everyo=
ne
else, it'd be scary noise without any meaningful benefit.

