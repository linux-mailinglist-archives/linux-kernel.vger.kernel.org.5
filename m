Return-Path: <linux-kernel+bounces-82575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F886868E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3E6289CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2BEED7;
	Tue, 27 Feb 2024 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw6W/AbJ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B374C9B;
	Tue, 27 Feb 2024 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999529; cv=none; b=QvqP6nfiamp9vbArzqVewJpkL+SD1RMPiG5ZH/pgcvF48bKZ3dvQYDxCcSIZMa9AaZBexlsP166RGGvOaUMHMAaZISMFXMFz8Hy2MdpjIWrowY5dh/98q2ZDkqpwH+PNkqpB4ikPVyTvVUftULz2f++Ce6eXAa+LipJB4Kq+uqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999529; c=relaxed/simple;
	bh=ErLlH/TGOo0dL5Rd8UEpsIla8TcQM25WQ4Yl4lpfKyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a85lNxwmD/oMbApztOlMjOcdj3FZZxIUt3jJ1s94eYcb7lDuHZfMfW0b5zCZis4gXtt5HH/pmmI8MCmOPRC/DGNO1OdTZYH0nCgachLGSaaPV5xZiquzfutQwceYKisNd88h2tKHWrMWD6ga5lVOeo968p7TZGIqRyjR7fBn+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw6W/AbJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d066f8239so2711186f8f.1;
        Mon, 26 Feb 2024 18:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708999526; x=1709604326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dhK7JWt2k6gkXm6u+aVq5274iL8Ug4hk7tF+Akknlns=;
        b=Iw6W/AbJghK0hTXdJToNaYeDCnrfkQ7Ceifel9uNrkd6JyLBgeSyZ3uQTgd2lQiMpd
         Do4ndllmAXznGoHF3He3imeYO1ejcBowwBSEbs2XJfduEK3+gQrWtWS52tuk4Jhz7CKU
         tg2xPUAZqMfGBbeg8UrgnaBgGQdtysFfb+PYzY1sZfIMBUxFXps/O+iaC8k+jpMZawCG
         /D8O/n3jh6FSqp9FNCldR+XNiJGTbbFR0v+CABuLw2guZ36ErSz2dllWdWfQVT/f3HjQ
         wwy8iOmpTe0rew/kmLB/5SSPC33UAPG+naU5kpZMTDbuJfhq0dwGoGYWO2sG06azcgFW
         yYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708999526; x=1709604326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhK7JWt2k6gkXm6u+aVq5274iL8Ug4hk7tF+Akknlns=;
        b=hySOFCkrQ6+lK3G6vRG8oUi51pkpBWfaEtFeO7DX6VduLaLiO9Iwm+cxpG75w1H5kB
         MVEKwdcZ6XcjIlPI5oRIg0VO4gcJaliWJXcRVaLRvJJIIrdGt53SK+HIzGlSrK/1x0uY
         e19HE1W1yE3V6k6QAB7NXYoEoxPAjCw3rqMNFxNjNCr2Acx888z5YRzQs/Adwlg2v/23
         pAk/h0QeqYXm0Y8p3FSC0xvHMBmr/ZxKY1vwuNuvc3no6/ljIPV53eBevU+kn8HmAX4t
         q9DxQ1Yv1wFhJet0rC71OsV89EzFcBw9bwsVgmok+DB478ZaaRRvmQkLeWP5hDC3nJMW
         cWTw==
X-Forwarded-Encrypted: i=1; AJvYcCU6V5y1e/Cuw6PeDsfsXloI4tTK0uTXFEfPma/GKLXryunlSRfpFrnqITbA7hc6WGKJpW8Ar7VX9bR8CDmZySAw2uVscnq8Iwer6X5MeS2FTdq1PbvxKIZP2fJ7hWgvl7O3zJYQiQwFyQ==
X-Gm-Message-State: AOJu0Yw5+RdVtrxU9w/FXi1lOZIWMQGiN4xarX7sB/7LoDKvEVaibWRv
	aC9Efkxuq6crm4oOgGqmIFqEuy2qFxRCcn2kvFIW5Vji8kEPw3qe
X-Google-Smtp-Source: AGHT+IGWoLYQu+tTdr3nwb/NPpBxokRJ7MVxE3QnJ+9qWZeHXJyZEW0RWoX8qiApwbpWHTg7Z7E46w==
X-Received: by 2002:adf:f783:0:b0:33d:23a6:56ba with SMTP id q3-20020adff783000000b0033d23a656bamr5584823wrp.42.1708999526014;
        Mon, 26 Feb 2024 18:05:26 -0800 (PST)
Received: from hermes.prahal.homelinux.net (91-175-163-178.subs.proxad.net. [91.175.163.178])
        by smtp.gmail.com with ESMTPSA id bw1-20020a0560001f8100b0033af3a43e91sm9921656wrb.46.2024.02.26.18.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:05:25 -0800 (PST)
Message-ID: <7873090c4aad382813a65e35157d8684e8842974.camel@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to
 emmc phy on rk3399
From: Alban Browaeys <alban.browaeys@gmail.com>
To: Doug Anderson <dianders@chromium.org>, Jensen Huang
	 <jensenhuang@friendlyarm.com>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Vinod Koul <vkoul@kernel.org>, Chris
 Ruehl <chris.ruehl@gtsys.com.hk>, Brian Norris <briannorris@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..."
 <linux-rockchip@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Christopher Obbard
 <chris.obbard@collabora.com>
Date: Tue, 27 Feb 2024 03:05:25 +0100
In-Reply-To: <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
	 <23552842.6Emhk5qWAg@diego>
	 <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
	 <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
	 <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 24 ao=C3=BBt 2022 =C3=A0 07:57 -0700, Doug Anderson a =C3=A9cri=
t=C2=A0:
> On Tue, Aug 23, 2022 at 8:11 PM Jensen Huang
> <jensenhuang@friendlyarm.com> wrote:
> > I realized that only some devices may be affected, so I considered
> > modifying rk3399-nanopi4.dtsi only,
> > but other boards without external pull-down should still need this
> > patch.
>=20
> I guess the other alternative would be to change how the dt property
> works. You could say:
>=20
> 1. If `enable-strobe-pulldown` is set then enable the strobe
> pulldown.
>=20
> 2. If `enable-strobe-pulldown` is not set then don't touch the pin in
> the kernel.
>=20
> 3. If someone later needs to explicitly disable the strobe pulldown
> they could add a new property like `disable-strobe-pulldown`.
>=20
>=20
> Obviously there are tradeoffs between that and what you've done and
> I'm happy to let others make the call of which they'd prefer.
>=20

Christopher could you try "ROCK Pi 4" and "ROCK Pi 4+" with=20
"enable-strobe-pulldown" instead of disabling HS400 as you did in July
2023?


Could the behavior be reverted to let the vendor kernel default for the
default case (ie enable pulldown)?




I believe 99% of the boards are now broken with this new internal
pulldown behavior (all  these with internal pulldown). More on that
later but to sum up, nobody  complained because downstream kernels like
Armbian all disabled HS400 for all boards, at least for rk3399.


Do we really want to ask 99% of the board dts to add this "enable-
strobe-pulldown" in their dts?
Chris, was your custom board not working with the vender kernel default
to enable unconditionaly?
What was the rationale to  choose the opposite default from the vendor
kernel one?


As told in the commit that introduced this new behavior the default for
the vendor kernel was the opposite of what was introduced in the Linux
kernel:
"
https://github.com/torvalds/linux/commit/8b5c2b45b8f0a11c9072da0f7baf9ee986=
d3151e

commit 8b5c2b45b8f0a11c9072da0f7baf9ee986d3151e
Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Date:   Sun Nov 29 13:44:14 2020 +0800

phy: rockchip: set pulldown for strobe line in dts

This patch add support to set the internal pulldown via dt property
and allow simplify the board design for the trace from emmc-phy to
the eMMC chipset.
Default to not set the pull-down.

This patch was inspired from the 4.4 tree of the
Rockchip SDK, where it is enabled unconditional.
The patch had been tested with our rk3399 customized board.
"



For RK3588 I see this commit which makes me believe the internal
pulldown case is the most common "
commit 37f3d6108730713c411827ab4af764909f4dfc78
Author: Sam Edwards <cfsworks@gmail.com>
Date:   Tue Dec 5 12:29:00 2023 -0800


arm64: dts: rockchip: Fix eMMC Data Strobe PD on rk3588

JEDEC standard JESD84-B51 defines the eMMC Data Strobe line, which is
currently used only in HS400 mode, as a device->host clock signal that
"is used only in read operation. The Data Strobe is always High-Z (not
driven by the device and pulled down by RDS) or Driven Low in write
operation, except during CRC status response." RDS is a pull-down
resistor specified in the 10K-100K ohm range. Thus per the standard,
the
Data Strobe is always pulled to ground (by the eMMC and/or RDS) during
write operations.

Evidently, the eMMC host controller in the RK3588 considers an active
voltage on the eMMC-DS line during a write to be an error.

The default (i.e. hardware reset, and Rockchip BSP) behavior for the
RK3588 is to activate the eMMC-DS pin's builtin pull-down. As a result,
many RK3588 board designers do not bother adding a dedicated RDS
resistor, instead relying on the RK3588's internal bias. The current
devicetree, however, disables this bias (`pcfg_pull_none`), breaking
HS400-mode writes for boards without a dedicated RDS, but with an eMMC
chip that chooses to High-Z (instead of drive-low) the eMMC-DS line.
(The Turing RK1 is one such board.)

Fix this by changing the bias in the (common) emmc_data_strobe case to
reflect the expected hardware/BSP behavior. This is unlikely to cause
regressions elsewhere: the pull-down is only relevant for High-Z eMMCs,
and if this is redundant with a (dedicated) RDS resistor, the effective
result is only a lower resistance to ground -- where the range of
tolerance is quite high. If it does, it's better fixed in the specific
devicetrees.
"






Lately two other upstream dts disabled HS400 due to this new behavior I
believe:
"
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arc=
h/arm64/boot/dts/rockchip?id=3D2bd1d2dd808c60532283e9cf05110bf1bf2f9079
author	Christopher Obbard <chris.obbard@collabora.com>	2023-
07-05 15:42:55 +0100
committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
15:43:24 +0200
commit	2bd1d2dd808c60532283e9cf05110bf1bf2f9079 (patch)
tree	57cbf7eaa91deb68f143577d5d1dbc0d9141480e
/arch/arm64/boot/dts/rockchip
parent	cee572756aa2cb46e959e9797ad4b730b78a050b (diff)
download	linux-2bd1d2dd808c60532283e9cf05110bf1bf2f9079.tar.gz
arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+


https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arc=
h/arm64/boot/dts/rockchip?id=3Dcee572756aa2cb46e959e9797ad4b730b78a050b
author	Christopher Obbard <chris.obbard@collabora.com>	2023-
07-05 15:42:54 +0100
committer	Heiko Stuebner <heiko@sntech.de>	2023-07-10
15:43:24 +0200
commit	cee572756aa2cb46e959e9797ad4b730b78a050b (patch)
tree	cf3ed8ff6230cbde04353503417c1a75ba15c249
/arch/arm64/boot/dts/rockchip
parent	5ce6971e5279c569defc2f2ac800692049bbaa90 (diff)
download	linux-cee572756aa2cb46e959e9797ad4b730b78a050b.tar.gz
arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
"


All Armbian RK3399 boards, as far as I know, had to disable HS400, I
also believe due to this commit.

You can also search google for "running cqe recovery rk3399 armbian".


This was never reported upstream though. But as HS400 is disabled
everywhere nobody notice the regression nowadays.


>=20
> > BR,
> > Jensen
> >=20
> > On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson
> > <dianders@chromium.org> wrote:
> > >=20
> > > Hi,
> > >=20
> > > On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntech.de>
> > > wrote:
> > > >=20
> > > > Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huang:
> > > > > Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was
> > > > > disabled
> > > > > by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> > > > >=20
> > > > > Tested on NanoPC-T4.
> > > > >=20
> > > > > Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe
> > > > > line in dts")
> > > > > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > > >=20
> > > > ok, so this looks like it restores previous functionality.
> > > >=20
> > > > I'm just wondering as the "offending" patch is from 2020, why
> > > > this
> > > > only turns up now. Any ideas?
> > >=20

Probbaly because the introduction of PROBE_DEFERRED in regulator core
before that (in 5.10.60) already broke at least my board HS400 due to
double init. Thus why it took me so long to see this new pulldown
behavior commit. I was testing every regulator core double init fixup
patchset while not understanding why reverting the PROBE_DEFERRED
commit on 5.10.60 worked but not on newer kernels (ie this new pulldown
behavior was introduced in 5.11...).




> > > Ah, I see. So before the offending patch we used to just leave
> > > the
> > > pull state at whatever the default was when the kernel was
> > > booted.
> > > After the offending patch we chose a default.
> > >=20
> > > On kevin I see an external pull down on this line. Enabling both
> > > the
> > > internal and external is probably not a huge deal, it'll just
> > > affect
> > > the strength of the pull.
> > >=20
> > > On bob I _think_ the external pull down is also stuffed.
> > >=20
> > > ...so I guess that would explain why it didn't cause a problem
> > > for at
> > > least those two boards?
> > >=20
> > > -Doug


In my opinion it is about these board already being broken by the
regulator core change, so nobody noticed the second regression. When
the first regression was fixed, it was very hard to correlate the still
broken behavior to the second regression.


I confirm that on Helios64, setting "enable-strobe-pulldown" fixes the
EMMC error I had when writing with HS400ES enabled:
mmc1: running CQE recovery=20
mmc1: cqhci: spurious TCN for tag 12

It also took me so long to report upstream as my board code (rk3399-
kobol-helios64.dts) is not completely upstreamed yet so I use an
Armbian patched kernel.



Alban



