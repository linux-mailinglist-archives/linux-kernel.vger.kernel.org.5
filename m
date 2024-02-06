Return-Path: <linux-kernel+bounces-55356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44884BBA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129E7280A16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690686FB0;
	Tue,  6 Feb 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW6O7qxE"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D498BA37;
	Tue,  6 Feb 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239327; cv=none; b=o/wuI56ZvSy7QyRHuiE8k/fTINlCYEwyOSQJ3kj1qq/K+rAZFjpSd6IwP/Ue2JavnvOgAorOSnPM2JwariFYVq2VRI+aH+yuKdqaUKrnK1svSexMK0PjxI7CDFVTZxtsgH6pMM7yKp8j01a2SxRI3gtfqckVw91ab4mZKZEyA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239327; c=relaxed/simple;
	bh=fQuH5gae4/jtj7Jvclr1Bq6Avdjh/fZlSzg3CplVdBQ=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HwOXAAhfpf43xZcfdHr2I73whJCd7kiIOQWSRZyaS1dITq0J973LgPfhMPf/w2S2xuyDbzVkMkLhxc2+MVt0ct09zTjKkcwjqLHoPAPeqwsWzfy8he0JMjA0cHpsu5oOWhtTUKwnCppUebRZytSikisEZYVFpdsvgDJDv2rh8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW6O7qxE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511616b73ddso784741e87.0;
        Tue, 06 Feb 2024 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707239323; x=1707844123; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpQTe2h2oxBHyoPv/D7jE20XJ1UFxE2lToYLPmHaGcw=;
        b=XW6O7qxEQkepi34b+RQu0p0cC5nKonygLvaA2AWDtgOE+gVF1GLf3tDGb9TV+CJhXU
         mVbb4xMcAp1DLMskDnTbEvXEvcGLn6+VBP38D/u9+tZsCRBfN8y+oVfQTLplmbwgrsmj
         Tn9m32OvV53z7lsruckWPCTu7ilm1X5nDMYXFEDj+rU3t85xcv/tV4FfEdM3Pu3QCT2W
         A5A27hALlJkAMstjMqDmixmRBk+yTZTvZsY0hWysakkkrRTeAzy3l5vbsYtuDskgNXk4
         xmuv8cdUvAjxmr1eUx/eIEyJUcDaERhP925CULlkVQEJvRzO7c19LTDgh5sbsXG+lRi4
         JJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239323; x=1707844123;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpQTe2h2oxBHyoPv/D7jE20XJ1UFxE2lToYLPmHaGcw=;
        b=oRmLYh90B0RDoMTNtIfpTJOk5eNCjkewnPApwsQrliiaQlcI+km+qIjObkfqefXrRw
         ibTDWu2Yijq81hjJfwXrpOvURBXN6ngqGr18LdtcS7XTGaHxwpI2Q6b7JNg3BZMbJ84t
         qDAmqSyCpFrDKONnmbzJ7n+pGXwylNRNlTBBCshiFaIUm4skTx5SlrvTQXPR7F3EbGk4
         J4rh25Y1wGCyK1YKpG3zSNY22OWsas1Sq5BJHpXne8MdzBAbBy/5QdJKRmYPQB0hcSEs
         rlh9raY7etbP/wzbos0pGifep82m+b7ozgYq+zDViVD7yweNfLGdjRLxTyVtTCbiVzDf
         I9Qw==
X-Gm-Message-State: AOJu0YxUrpD+IKE/7lS30QIzX/Dzo7KiJWmctFB+BjvhfY7JE3c9p4NI
	vlTGeQdSSSy2Oc3cL8VijOE0St8PRZ5o5wcBQd+rghL7wXE5IApP
X-Google-Smtp-Source: AGHT+IEb4ESWq80x9G4qWVQKxT1Sy4daESyla/LQFOGK2+senhCZfkVrs/vUJiGJfps78YVlXUbAww==
X-Received: by 2002:ac2:5e8a:0:b0:511:5533:aa32 with SMTP id b10-20020ac25e8a000000b005115533aa32mr2030617lfq.58.1707239323238;
        Tue, 06 Feb 2024 09:08:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+CyQ1690FYFkM++5rcqI6gLoJT6PktKXZFP5bTRZYlg5zSc2maHCe8Ymi7S6WE1nbDv2kg97R6+GzV2RlrP7nzTDHIvcvt07gWeoo0SkVtxTCcqkPJ25Lk3NhcXW5pVlskrzLzE5d66yrQjvEkxOVi1DPHAwRVKcRNcpIW0z6QmOmcVjgBZUVG0AOajxRhlcLD21M6CaOwyNiKM0PsNWiuR3UYxEjUccRNqheKtdXVUg/RHm+NBlUtvENYrD34/qJ7XS5DdFlCgM+yvt4p+9rFJekyJBvgWCp6ND4Sk4UZP3EUNpLqDv4dlxFlw==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qh22-20020a170906ecb600b00a37319aada3sm1343314ejb.153.2024.02.06.09.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 09:08:42 -0800 (PST)
Content-Type: multipart/signed;
 boundary=71c3b1bcd69fb97be5bbb7b0a08a9cbdbd93a8a4a2ab0314ed1e07133598;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 06 Feb 2024 18:08:42 +0100
Message-Id: <CYY5TXBRWCVF.6KNIROYGM631@gmail.com>
Cc: "Jon Hunter" <jonathanh@nvidia.com>, "Sumit Gupta" <sumitg@nvidia.com>,
 <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
 <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>
Subject: Re: [Patch] memory: tegra: Skip SID override from Guest VM
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Marc Zyngier" <maz@kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240206114852.8472-1-sumitg@nvidia.com>
 <86wmrh6b2n.wl-maz@kernel.org>
 <252d6094-b2d6-496d-b28f-93507a193ede@nvidia.com>
 <86v87169g2.wl-maz@kernel.org> <CYY1YXL0FWK2.1L5CRNMKUF22J@gmail.com>
 <86sf2563u3.wl-maz@kernel.org>
In-Reply-To: <86sf2563u3.wl-maz@kernel.org>

--71c3b1bcd69fb97be5bbb7b0a08a9cbdbd93a8a4a2ab0314ed1e07133598
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Feb 6, 2024 at 3:54 PM CET, Marc Zyngier wrote:
> On Tue, 06 Feb 2024 14:07:10 +0000,
> "Thierry Reding" <thierry.reding@gmail.com> wrote:
> >=20
> > [1  <text/plain; UTF-8 (quoted-printable)>]
> > On Tue Feb 6, 2024 at 1:53 PM CET, Marc Zyngier wrote:
> > > On Tue, 06 Feb 2024 12:28:27 +0000, Jon Hunter <jonathanh@nvidia.com>=
 wrote:
> > > > On 06/02/2024 12:17, Marc Zyngier wrote:
> > [...]
> > > > > - My own tegra186 HW doesn't have VHE, since it is ARMv8.0, and t=
his
> > > > >    helper will always return 'false'. How could this result in
> > > > >    something that still works? Can I get a free CPU upgrade?
> > > >=20
> > > > I thought this API just checks to see if we are in EL2?
> > >
> > > It does. And that's the problem. On ARMv8.0, we run the Linux kernel
> > > at EL1. Tegra186 is ARMv8.0 (Denver + A57). So as written, this chang=
e
> > > breaks the very platform it intends to support.
> >=20
> > To clarify, the code that accesses these registers is shared across
> > Tegra186 and later chips. Tegra194 and later do support ARMv8.1 VHE.
>
> But even on these machines that are VHE-capable, not running at EL2
> doesn't mean we're running as a guest. The user can force the kernel
> to stick to EL1, using a command-line option such as kvm-arm.mode=3Dnvhe
> which will force the kernel to stay at EL1 while deploying KVM at EL2.
>
> > Granted, if it always returns false on Tegra186 that's not what we
> > want.
>
> I'm glad we agree here.
>
> > > > > - If you assign this device to a VM and that the hypervisor doesn=
't
> > > > >    correctly virtualise it, then it is a different device and you
> > > > >    should simply advertise it something else. Or even better, fix=
 your
> > > > >    hypervisor.
> > > >=20
> > > > Sumit can add some more details on why we don't completely disable =
the
> > > > device for guest OSs.
> > >
> > > It's not about disabling it. It is about correctly supporting it
> > > (providing full emulation for it), or advertising it as something
> > > different so that SW can handle it differently.
> >=20
> > It's really not a different device. It's exactly the same device except
> > that accessing some registers isn't permitted. We also can't easily
> > remove parts of the register region from device tree because these are
> > intermixed with other registers that we do want access to.
>
> But that's the definition of being a different device. It has a
> different programming interface, hence it is different. The fact that
> it is the same HW block mediated by a hypervisor doesn't really change
> that.

The programming model isn't really different in these cases, but rather
restricted. I think a compatible string is a suboptimal way to describe
this.

> > > Poking into the internals of how the kernel is booted for a driver
> > > that isn't tied to the core architecture (because it would need to
> > > access system registers, for example) is not an acceptable outcome.
> >=20
> > So what would be the better option? Use a different compatible string t=
o
> > make the driver handle the device differently? Or adding a custom
> > property to the device tree node to mark this as running in a
> > virtualized environment?
>
> A different compatible string would be my preferred option. An extra
> property would work as well. As far as I am concerned, these two
> options are the right way to express the fact that you have something
> that isn't quite like the real thing.

Coincidentally there's another discussion with a lot of similarities
regarding simulated platforms. For these it's usually less about the
register set being restricted and more about certain quirks that are
needed which will not ultimately be necessary for silicon.

This could be a timeout that's longer in simulation, or it could be
certain programming that would be needed in silicon but isn't necessary
or functional in simulation (think I/O calibration, that sort of thing).
One could argue that these are also different devices when in simulation
but they really aren't. They're more like an approximation of the actual
device that will be in silicon chips.

Another problem that both of the cases have in common is that they are
parameters that usually apply to the entire system. For some devices it
is easier to parameterize via DT (for example for certain devices we
have bindings with special register regions that are only available in
host OS mode), but for others this may not be true. Adding extra
compatible strings for virtualization/simulation is going to get quite
complex very quickly if we need to differentiate between all of these
scenarios.

> > Perhaps we can reuse the top-level hypervisor node? That seems to only
> > ever have been used for Xen on 32-bit ARM, so not sure if that'd still
> > be appropriate.
>
> I'd shy away from this. You would be deriving properties from a
> hypervisor implementation, instead of expressing those properties
> directly. In my experience, the direct method is always preferable.

I would generally agree. However, I think especially the compatible
string solution could turn very ugly for this. If we express these
properties via compatible strings we may very well end up with many
different compatible strings to cover all cases.

Say you've got one hypervisor that changes the programming model in a
certain way and a second hypervisor that constrains in a different way.
Do we now need one compatible string for each hypervisor? Do we add
compatible strings for each restriction and have potentially very long
compatible string lists? Separate properties would work slightly better
for this.

There are some cases where we can use register contents to determine
what the OS is allowed to do, but these registers don't exist for all HW
blocks. We may be able to get more added to new chips, but we obviously
can't retroactively add them for existing ones.

A central node or property would at least allow broad parameterization.
I would hope that at least hypervisor implementations don't vary too
much in terms of what they restrict and what they don't, so perhaps it
wouldn't be that bad. Perhaps that's also overly optimistic.

Thierry

--71c3b1bcd69fb97be5bbb7b0a08a9cbdbd93a8a4a2ab0314ed1e07133598
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXCZ5oACgkQ3SOs138+
s6GUVQ//Y9rouXKsWsjjJpHdWYzaCsgOR+kimlfXomhSDm4tMy4m80OUb6rEZg5E
SRKYmCeWjtv9Cj+NaHi3yV+WZmcOXqU4YAlUFwkEw6sL9HX6CS9+AzpFmx7rPUpN
ujN78g/TboU1IZRuoo2mszZEqnpO7mQlEpbyeL1jmLpF1cRxmaKryKvsC8uzDMtv
Jbc1Fkl9I6tzz4wTR/l66Ro+KBKWOzFWvNlaisd+KhBtdpmU3ttHLUAtQzCiTsSI
G4/mlTXfB53A59AjtrkdZe7lOZzar8T2LoEHGrNwfqjO/hdhq08AFDnmWeAmYGDQ
nyk6671VXqMoFHc8NlIEV7ReXTxtKNU5FbtZLJh14znHhgLQN8uSWRnLbCmPoMVQ
e8gjupcdeku+31UapyaAU1HNzfNSDk9QHqLHWCjl0ItMbhIynL2oQXKLI8rK/zCm
pqQMnMCreN6t/kSOZJg9WH7NtQ3WzUiW7Nilz5NSq6MJAQ4BdgkmIg9R6zbslXot
FstiIavv6dmh4IVuL7D1HBnb8dckRM5jUiDO+fNM6cc7Z8euMi601J2EEgJlWMax
wgS36umZDpg3xdh6AGV+vR+sppaJGF7Uv09Ypm7tmW3ny2gOlWJkR38qoTQx1GIh
VjYnemOaUVmMCbSMJMqqaUEzPGfF8SNN3GXFPSpWRkY+BalaJr4=
=LNkf
-----END PGP SIGNATURE-----

--71c3b1bcd69fb97be5bbb7b0a08a9cbdbd93a8a4a2ab0314ed1e07133598--

