Return-Path: <linux-kernel+bounces-139205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110C89FFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA68928CFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64F18132B;
	Wed, 10 Apr 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjA/U0Cg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CB1802C6;
	Wed, 10 Apr 2024 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773743; cv=none; b=G0FeMNr31J2EYl2fi33yX8Us4WuHxxEkFac4aujnPK06lGMWCXEl9bVUfYQX2pRHkPlcrQbei0xRGLdKY+wNVKL6UKLzcTFJaS+MzYyPvxwxxirBFP9FhbiSE2nlzGZ/x5XPQLg3oDtpRX0NB7bkSx8zes5FzekqtGHUsQ9b25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773743; c=relaxed/simple;
	bh=fJVsxJdGGft0HPjJ1zIJIsbImXpLsrnlA1j90glnbO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mASwwgbBQB/9qn9pxbgGhfLYDoOglzQWoeMFLwPp5zUXobLeEoDEaYJWT7sRyNIykRlvyjMmVCLSNwcCvZIyBKAR6rL9jlw/GQ4TEje0m157lF3lWCLNdy4VXsG7lfZ7uxF/w6Lb4MqVRFdlMhkDRj3nM6wn9p2cIPCyefHZwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjA/U0Cg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41551639550so48722055e9.2;
        Wed, 10 Apr 2024 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712773740; x=1713378540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JI1AgTVk6MXUe5oDuA7l/wJDaO70IF6SzJhre7ToBr4=;
        b=EjA/U0Cg+52fnONazprzVlWqA/PzqJEYB2IpBlVOSe7FjnDtKVREDewsEcp9EluDFF
         zkCEb+x3+3wMz5R9WvcWuKhs1p5nLQX/81TkYlup/G0UYieYd9pJF7Lx2ue7rzQCFt2v
         jB5ik/5pr+cD9k4dqZzEi5owvhos8N36LYMohiqprkSwtF93vlXBUvkuBeW73A8XZ09B
         OgatprMRIlDNdF8hOENgGg7kDQMotud3Q+rynRdDeLD4FKwONP3/mIz/hNqe9SndCCAs
         2pOxDMA0KKi1QIqJckGU7sgxE9ceesTOc1mCOiseomDY2Medc/Dt7drMsz+pPIvbKaB8
         UYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712773740; x=1713378540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JI1AgTVk6MXUe5oDuA7l/wJDaO70IF6SzJhre7ToBr4=;
        b=pKkvrH1o/qdNLELvnrM+vzsOr6KdKLfvplhX387CS6IhiRPExFZJVngkFlp1tA69yg
         7u7kZ1T7fS36XBBZDePWr7SCnpa9rmedbh2pEVwGPindVTkKSaq1N+huHMB9vw5TnY+C
         3Fo1snLJ5qrL2qF2EvuXVi1OVuRIOTqtXBNSO8m7Q2E5o5I0hY3hj8MnuD9JmYufmRXh
         ze5E31AFQ5v+aKpEbBUILm3hKQas2IYHfg5bK58428WbkgXFlUvUA+wVN4gZY4uqLrvz
         tpJeVWkbw7G5JO86NLV5ZUXRv0dlcLzzv17cnEoW+Bg335sdWcc6MtXJtXsAKe11mqu8
         Or6g==
X-Forwarded-Encrypted: i=1; AJvYcCWBa4sgBXgSCeuydRnTcZX/nFSVDsHYPKCF63/pgBD8vKJdk58Wjk9ZshEm07iv+upv5tC8hUZf32GHWvtBPE5lHZAQaRnnkJb1Lgcjy5bdMlOmwcD3C82DRYiXqBr8WW8pfv5SckUwBw==
X-Gm-Message-State: AOJu0Yw838aKy01LC0/GBcHTq9o0fjdJMUz+0Z6roOprOqLsoHIoLHZ3
	UBoLOH08vYH8ujP96IifN/ZxXzeAVZWiIT1mNVwULlgvU/G8YVO3
X-Google-Smtp-Source: AGHT+IE426W3RLEuWaqKyZnPvLv3Gj7D8LXxMP7iGupNxt0Ar8EG4gEDKeGsr/vNDGPK+XMnuV1tPA==
X-Received: by 2002:a05:600c:3585:b0:416:bbf7:f18a with SMTP id p5-20020a05600c358500b00416bbf7f18amr2645013wmq.28.1712773739579;
        Wed, 10 Apr 2024 11:28:59 -0700 (PDT)
Received: from hermes.prahal.homelinux.net (91-175-163-178.subs.proxad.net. [91.175.163.178])
        by smtp.gmail.com with ESMTPSA id dx18-20020a0560000e1200b00343d840b3f8sm14247670wrb.33.2024.04.10.11.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:28:59 -0700 (PDT)
Message-ID: <313d5a24b6cffa1a9160e624bb6855aa7f66589e.camel@gmail.com>
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
From: Alban Browaeys <alban.browaeys@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: dev@folker-schwesinger.de, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Chris
 Ruehl <chris.ruehl@gtsys.com.hk>,  Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Christopher Obbard <chris.obbard@collabora.com>,
 Doug Anderson <dianders@chromium.org>, Brian Norris
 <briannorris@chromium.org>, Jensen Huang <jensenhuang@friendlyarm.com>,
 linux-phy@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Wed, 10 Apr 2024 20:28:57 +0200
In-Reply-To: <20240328-unnatural-unsorted-e53a13f5e87e@spud>
References: 
	<20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
	 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
	 <20240326-tactical-onlooker-3df8d2352dc2@spud>
	 <871f0b24a38208d9c5d6abc87d83b067162c103e.camel@gmail.com>
	 <20240328-unnatural-unsorted-e53a13f5e87e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 28 mars 2024 =C3=A0 18:01 +0000, Conor Dooley a =C3=A9crit=C2=A0:
> On Thu, Mar 28, 2024 at 06:00:03PM +0100, Alban Browaeys wrote:
> > Le mardi 26 mars 2024 =C3=A0 19:46 +0000, Conor Dooley a =C3=A9crit=C2=
=A0:
> > > On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via
> > > B4
> > > Relay wrote:
> > > > From: Folker Schwesinger <dev@folker-schwesinger.de>
> > > > -	if (of_property_read_bool(dev->of_node,
> > > > "rockchip,enable-
> > > > strobe-pulldown"))
> > > > -		rk_phy->enable_strobe_pulldown =3D
> > > > PHYCTRL_REN_STRB_ENABLE;
> > > > +	if (of_property_read_bool(dev->of_node,
> > > > "rockchip,disable-
> > > > strobe-pulldown"))
> > > > +		rk_phy->enable_strobe_pulldown =3D
> > > > PHYCTRL_REN_STRB_DISABLE;
> > >=20
> > > Unfortunately you cannot do this.
> > > Previously no property at all meant disabled and a property was
> > > required
> > > to enable it. With this change the absence of a property means
> > > that
> > > it
> > > will be enabled.
> > > An old devicetree is that wanted this to be disabled would have
> > > no
> > > property and will now end up with it enabled. This is an ABI
> > > break
> > > and is
> > > clearly not backwards compatible, that's a NAK unless it is
> > > demonstrable
> > > that noone actually wants to disable it at all.
> >=20
> >=20
> > But the patch that introduced the new default to disable the
> > pulldown
> > explicitely introduced a regression for at least 4 boards.
> > It took time to sort out that the default to disable pulldown was
> > the
> > culprit but still.
> > Will we carry this new behavor that breaks the default design for
> > rk3399 because since the regression was introduced new board
> > definition
> > might have expceted this new behavior.
> >=20
> > Could the best option be to revert to =C3=A9not set a default
> > enable/disable
> > pulldown" (as before the commit that introduced the regression) and
> > allow one to force the pulldown via the enable/disable pulldown
> > property?
> > I mean the commit that introduced a default value for the pulldown
> > did
> > not seem to be about fixing anything. But it broke a lot. ANd it
> > was
> > really really hard to find the description of this commit to
> > understand
> > that one had to enable pulldown to restore hs400.
> >=20
> > In more than 3 years, only one board maintainer noticed that this
> > property was required to get back HS400=C2=A0 and thanks to a user
> > telling
> > me that this board was working I found from this board that this
> > property was "missing" from most board definitions (while it was
> > not
> > required before).
> >=20
> >=20
> > I am all for not breaking ABI. But what about not reverting a patch
> > that already broke ABI because this patch introduced a new ABI that
> > we
> > don't want to break?
> > I mean shouldn't a new commit with a new ABI that regressed the
> > kernel
> > be reverted?
>=20
> I think I said it after OP replied to me yesterday, but this is a
> pretty
> shitty situation in that the original default picked for the property
> was actually incorrect. Given it's been like this for four years
> before
> anyone noticed, and others probably depend on the current behaviour,
> that's hard to justify.
>=20

A lot of people noticed fast that HS400 was broken in the 5.10 branch
but due to another commit (more later, ie double regulator init that
messed up emmc) this second breakage was not detected. But mostly
downstream. And most if not all rk3399 boards in Armbian had HS400
disabled.


It took 3 years to detect that HS400 was broken on a few boards like
Rock Pi4 in the upstream kernel. Any might still be broken.
I would not count on the fact that keeping the current behavior equals
no more broken boards.

From the previous exchanges the boards that requires the pulldown to be
disabled seems well known.

Though I am fine with adding a property to set enable pulldown to any
board definition file where that is required.

Only I do not believe keeping the statu quo equal everything works
because it has been 3 years.
In fact this commit reached the downstream kernels way later. Any
stayed with the 5.10 branch for years.

But on the other side the disable pulldown by default is alraedy in
stable/linux-rolling-lts .



> > Mind fixing the initial regression 8b5c2b45b8f0 "phy: rockchip: set
> > pulldown for strobe line in dts" does not necessarily mean changing
> > the
> > default to the opposite value but could also be reverting to not
> > setting a default.
>=20
> That's also problematic, as the only way to do this is make setting
> one of the enabled or disabled properties required, which is also an
> ABI
> break, since you'd then be rejecting probe if one is not present.


I don't understand.
How reverting to not set either pulldown enabled or disabled by default
force all board to set either enabled or disabled.
I was telling about making the pulldown set by kernel optional be it
enabled or disabled to revert to the previous behavior.=20

I mean before the patch to set a default pulldown value (to disabled)
there were no forced value.



> > Though I don't know if there are pros to setting a default.
>=20
> What you probably have to weigh up is the cons of each side. If what
> you
> lose is HS400 mode with what's in the kernel right now but switching
> to
> what's been proposed would entirely break some boards, I know which
> I think the lesser of two evils is.

More boards (even if not the most wide spread it seems) are broken by
the current behavior.

I agree that only HS400 is broken by keeping the status quo. But as far
as I understand only HS400 will be broken either way.
Be that by keeping the current disable pulldown which break the boards
based on the rockchip default design or the boards that are non-
standard or have a broken design.
Both case this lead to data corruption on boot to eMMC.

The only pro of keeping the current value the default is that most
board broken by the new default introduced in 2020 "might" already be
fixed (but that is just a guess).



> It's probably up to the platform maintainer to weigh in at this
> point.

I am not knowledged into the delegation scope. You mean that from now
on it is up to the rockchip maintainer?
I am fine with it either way.

I just wanted to point out that maybe we don't have to set a pulldown
value after all. And that then all boards will be fine as before
setting the pulldown explicitly was introduced.


In fact I am more eager to get this fixed be it by adding a enable-
pulldown property to the board definitions, than to change the current
behavior.
Just wanted to sort out if that was not the wrong way to fix this
issue. (ie if adding a setting on most boards was wrong).


> Hope that helps?
> Conor.


During more than 2 years, I tried various patches and discussed on
forums about the HS400 breakage. I had bisected the regulator init
issue in the 5.10 branch. Sadly it took so much time for this issue to
be understood that when the force pulldown to disable commit was
introduced downstream before the first issue go fixed.
This only made the matter worse because when one fixed the double
regulator init issue HS400 was still broken, this time because the
pulldown was forced to disable. But nobody noticed this commit that
forced a default pulldown state (that was older than the regulator
commit from 5.13 backported to the 5.10 stable branch commit, but that
reached downstream later due to not having been backported to 5.10 from
5.11).
Otherwise we would have emailed immeditaly.
Bisecting was only able to catch the first breakage (as it was only
fixed after the second breakage was introduced).

Maybe the problem is that me and others did not complained to the
kernel upstream ML because we were using heavily patched downstream
kernels (like most if not all downstream ARM kernels). So sadly, the
forums from back then are filled with complaints but nothing seemed to
have reached the Linux ML.



About the regulator double init, stable downstream branches were hit by
a bug in the 5.10 stable branch in May 2021 before they switched to
5.11 were this default pulldown was introduced. Thus they could not
detect that this pulldown broke HS400 because HS400 was already broken
by a double regulator init, backported in 5.10 from 5.13:
"
commit 06653ebc0ad2e0b7d799cd71a5c2933ed2fb7a66
Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu May 20 01:12:23 2021 +0300

	regulator: core: resolve supply for boot-on/always-on
regulators
  =20
	commit 98e48cd9283dbac0e1445ee780889f10b3d1db6a upstream.
  =20
	For the boot-on/always-on regulators the
set_machine_constrainst() is
	called before resolving rdev->supply. Thus the code would try
to enable
	rdev before enabling supplying regulator. Enforce resolving
supply
	regulator before enabling rdev.
  =20
	Fixes: aea6cb99703e ("regulator: resolve supply after creating
regulator")
	Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
	Link:
https://lore.kernel.org/r/20210519221224.2868496-1-dmitry.baryshkov@linaro.=
org
	Signed-off-by: Mark Brown <broonie@kernel.org>
	Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
"
and which to my knowledge was only fixed in v6.1-rc1 "
commit 8a866d527ac0441c0eb14a991fa11358b476b11d
Author: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
Date:   Thu Aug 18 12:46:47 2022 +0000

    regulator: core: Resolve supply name earlier to prevent double-init
   =20
    Previously, an unresolved regulator supply reference upon calling
    regulator_register on an always-on or boot-on regulator caused
    set_machine_constraints to be called twice.
   =20
    This in turn may initialize the regulator twice, leading to voltage
    glitches that are timing-dependent. A simple, unrelated
configuration
    change may be enough to hide this problem, only to be surfaced by
    chance.
   =20
    One such example is the SD-Card voltage regulator in a NanoPI R4S
that
    would not initialize reliably unless the registration flow was just
    complex enough to allow the regulator to properly reset between
calls.
   =20
    Fix this by re-arranging regulator_register, trying resolve the
    regulator's supply early enough that set_machine_constraints does
not
    need to be called twice.
   =20
    Signed-off-by: Christian Kohlschu=CC=88tter <christian@kohlschutter.com=
>
    Link:
https://lore.kernel.org/r/20220818124646.6005-1-christian@kohlschutter.com
    Signed-off-by: Mark Brown <broonie@kernel.org>

"

So most boards were already broken when the commit to force a pulldown
value was introduced.




Regards
Alban

