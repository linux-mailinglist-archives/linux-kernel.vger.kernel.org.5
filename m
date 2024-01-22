Return-Path: <linux-kernel+bounces-32373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C15E835ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808851C21741
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434FC5697;
	Mon, 22 Jan 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPqsJP+M"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BD525E;
	Mon, 22 Jan 2024 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903423; cv=none; b=eLPeOoPq0Vk296gByj6uxtW7ix/8H7IpfIeAoNKvotm4bI8paqVhZBDALIaCODWWgCjZly/B9P3k9YDg+ErBOtlw1sS2ELsHT5/a8mtVwTUhbGSqt0XuuCyVXMDtuPa4EufcGPvkNOOnPkwejIC+gPIs7qm8r1yJKa7GSnFzKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903423; c=relaxed/simple;
	bh=QcdBJu2BJtc1XmUGRo3LhTTt1NXTGmBq79M02ma8ots=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ8FyZ3SclB9FAZeSpfKJYMAhajiBDfRA7B2Sg0yl3Z9usKmlE3vKjNYSqv9lO+ZlH51C5rCkH30LukGu5NtBf84t0tmm94Vsb5VFNhITgUHr5Um7y8uEtbS+Ju4z26azBN++OqYzEa2UaUhYVa2/NqVVcEH4pTjGOPZlyHc6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPqsJP+M; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a271a28aeb4so278342266b.2;
        Sun, 21 Jan 2024 22:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705903420; x=1706508220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45sTye5gJqnIY3vvFsAZwYWClF4GnpV+u4KU1/fpkwU=;
        b=CPqsJP+MOiusoVQcy5tMlTSNVoaFtzK0M6/5sMHxwUIpnJtJJ46ezrMgzF9g74C9Op
         wnRuRYWaXYUfcG7dB7wgZfyTPpxyEsqzYuu52copp/CMBgDBzoChdl5IdXcBd2R5su1C
         +MEDBmhEEUzfkeeLcueDlDWZzKa/qppMRHi3z4Pp3MX54k9PPVH/dLGbGKq4KzPQA9Rr
         tBh9uwF1dZpbu25zrYnC0zm+2d1ZIpKZIzHvEtA6Wg57zDsXEd0NErVWQzwY1E5mAj6x
         orSzOcmGf1zS7G9hM4XmHY89BQXJf3k6JJuHl1c9yWcYCZJy61Ldc+P8CDVztCKXuSDy
         3wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705903420; x=1706508220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45sTye5gJqnIY3vvFsAZwYWClF4GnpV+u4KU1/fpkwU=;
        b=fZUv1yLGvMh33OJgOOviAPSouFVRcWZq7p5Y2BrtXoXdP8Y8LJ7GP2TvfRjsrJmEKy
         2Bbr1wsu8TyS3R2NlkkTAMQTjXmvWZiriy4b1KQno18U7MQYsZtv56r7posnBwpPhaX3
         fdOoYqR/unrth7RrzAi8tmA9fObxx0d6qMz2qn9pSYcbobmZsvgnaxuDK2H6tTcnxbaK
         Gs3lgBhGqGHhdhoAUBbvqT56VFaw7qyNogk4uPUDNPtOIaZroqiTpyaY7g85CO2b7d1j
         /BTzpDysj83pveUQdF1Frah2rRNcotz8fC7cHh3DODeMcLcn89kdGMDLgjdxp5qbJI+s
         eIow==
X-Gm-Message-State: AOJu0YwBRt1ugXHjCqQlNxX3UxuJtAzldvc1peThXK+bk/Al6SHXj5/P
	HUNzXH+KwV1VPPCyaEuseq+0uaNvPyMKnxKVDWeW4YRPYwEebrm3piG96fHw06DR3r8OUkStAZ2
	T/VnwRnDe2RBGL2DlJ5pZRpkemqI=
X-Google-Smtp-Source: AGHT+IHxs6LgpnXwTp1mswrCVo/K2UyvcupYHiBMwvPrFEjVXOvTmS9l0o9hpQ1r9DNTZJF9MEUMT5fSxCH078QK25s=
X-Received: by 2002:a17:906:dfcc:b0:a2d:a5c4:fc1d with SMTP id
 jt12-20020a170906dfcc00b00a2da5c4fc1dmr1702750ejc.12.1705903419375; Sun, 21
 Jan 2024 22:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106222357.23835-1-alchark@gmail.com> <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
 <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org> <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
 <f5c05015e042b11a51a9af26c35f18ed@manjaro.org>
In-Reply-To: <f5c05015e042b11a51a9af26c35f18ed@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 22 Jan 2024 10:03:27 +0400
Message-ID: <CABjd4Yy91MAd2wALp4KQiEub9OyxU+MR+ti5KA_c+yvZT5xaqQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring
 on rk3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Christopher Obbard <chris.obbard@collabora.com>, =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Kever Yang <kever.yang@rock-chips.com>, 
	Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alexey,
>
> On 2024-01-21 19:56, Alexey Charkov wrote:
> > On Thu, Jan 18, 2024 at 10:48=E2=80=AFPM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> On 2024-01-08 14:41, Alexey Charkov wrote:
> >> I apologize for my delayed response.  It took me almost a month to
> >> nearly fully recover from some really nasty flu that eventually went
> >> into my lungs.  It was awful and I'm still not back to my 100%. :(
> >
> > Ouch, I hope you get well soon!
>
> Thank you, let's hope so.  It's been really exhausting. :(
>
> >> > On Sun, Jan 7, 2024 at 2:54=E2=80=AFAM Dragan Simic <dsimic@manjaro.=
org> wrote:
> >> >> On 2024-01-06 23:23, Alexey Charkov wrote:
> >> >> > Include thermal zones information in device tree for rk3588 varia=
nts
> >> >> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
> >> >> >
> >> >> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> >> > ---
> >> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> > index 8aa0499f9b03..8235991e3112 100644
> >> >> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> > @@ -10,6 +10,7 @@
> >> >> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >> >> >  #include <dt-bindings/phy/phy.h>
> >> >> >  #include <dt-bindings/ata/ahci.h>
> >> >> > +#include <dt-bindings/thermal/thermal.h>
> >> >> >
> >> >> >  / {
> >> >> >       compatible =3D "rockchip,rk3588";
> >> >> > @@ -2112,6 +2113,148 @@ tsadc: tsadc@fec00000 {
> >> >> >               status =3D "disabled";
> >> >> >       };
> >> >> >
> >> >> > +     thermal_zones: thermal-zones {
> >> >> > +             soc_thermal: soc-thermal {
> >> >>
> >> >> It should be better to name it cpu_thermal instead.  In the end,
> >> >> that's what it is.
> >> >
> >> > The TRM document says the first TSADC channel (to which this section
> >> > applies) measures the temperature near the center of the SoC die,
> >> > which implies not only the CPU but also the GPU at least. RADXA's
> >> > kernel for Rock 5B also has GPU passive cooling as one of the coolin=
g
> >> > maps under this node (not included here, as we don't have the GPU no=
de
> >> > in .dtsi just yet). So perhaps naming this one cpu_thermal could be
> >> > misleading?
> >>
> >> Ah, I see now, thanks for reminding;  it's all described on page 1,372
> >> of the first part of the RK3588 TRM v1.0.
> >>
> >> Having that in mind, I'd suggest that we end up naming it
> >> package_thermal.
> >> The temperature near the center of the chip is usually considered to
> >> be
> >> the overall package temperature;  for example, that's how the
> >> user-facing
> >> CPU temperatures are measured in the x86_64 world.
> >
> > Sounds good, will rename in v3!
>
> Thanks, I'm glad you agree.
>
> >> >> > +                     trips {
> >> >> > +                             threshold: trip-point-0 {
> >> >>
> >> >> It should be better to name it cpu_alert0 instead, because that's w=
hat
> >> >> other newer dtsi files already use.
> >> >
> >> > Reflecting on your comments here and below, I'm thinking that maybe =
it
> >> > would be better to define only the critical trip point for the SoC
> >> > overall, and then have alerts along with the respective cooling maps
> >> > separately for A76-0,1, A76-2,3, A55-0,1,2,3? After all, given that =
we
> >> > have more granular temperature measurement here than in previous RK
> >> > chipsets it might be better to only throttle the "offending" cores,
> >> > not the full package.
> >> >
> >> > What do you think?
> >> >
> >> > Downstream DT doesn't follow this approach though, so maybe there's
> >> > something I'm missing here.
> >>
> >> I agree, it's better to fully utilize the higher measurement
> >> granularity
> >> made possible by having multiple temperature sensors available.
> >>
> >> I also agree that we should have only the critical trip defined for
> >> the
> >> package-level temperature sensor.  Let's have the separate temperature
> >> measurements for the CPU (sub)clusters do the thermal throttling, and
> >> let's keep the package-level measurement for the critical shutdowns
> >> only.  IIRC, some MediaTek SoC dtsi already does exactly that.
> >>
> >> Of course, there are no reasons not to have the critical trips defined
> >> for the CPU (sub)clusters as well.
> >
> > I think I'll also add a board-specific active cooling mechanism on the
> > package level in the next iteration, given that Rock 5B has a PWM fan
> > defined as a cooling device. That will go in the separate patch that
> > updates rk3588-rock-5b.dts (your feedback to v2 of this patch is also
> > duly noted, thank you!)
>
> Great, thanks.  Sure, making use of the Rock 5B's support for attaching
> a PWM-controlled cooling fan is the way to go.
>
> Just to reiterate a bit, any "active" trip points belong to the board
> dts
> file(s), because having a cooling fan is a board-specific feature.  As a
> note, you may also want to have a look at the RockPro64 dts(i) files,
> for
> example;  the RockPro64 also comes with a cooling fan connector and the
> associated PWM fan control logic.

Thanks for the pointer! There is also a helpful doc within devicetree
bindings descriptions, although it sits under hwmon which was a bit
confusing to me. I've already tested it locally (by adding to the
board dts), and it spins up and down quite nicely, and even modulates
the fan speed swiftly when the load changes - yay!

> >> >> > +                                     temperature =3D <75000>;
> >> >> > +                                     hysteresis =3D <2000>;
> >> >> > +                                     type =3D "passive";
> >> >> > +                             };
> >> >> > +                             target: trip-point-1 {
> >> >>
> >> >> It should be better to name it cpu_alert1 instead, because that's w=
hat
> >> >> other newer dtsi files already use.
> >> >>
> >> >> > +                                     temperature =3D <85000>;
> >> >> > +                                     hysteresis =3D <2000>;
> >> >> > +                                     type =3D "passive";
> >> >> > +                             };
> >> >> > +                             soc_crit: soc-crit {
> >> >>
> >> >> It should be better to name it cpu_crit instead, because that's wha=
t
> >> >> other newer dtsi files already use.
> >> >
> >> > Seems to me that if I define separate trips for the three groups of
> >> > CPU cores as mentioned above this would better stay as soc_crit, as =
it
> >> > applies to the whole die rather than the CPU cluster alone. Then
> >> > 'threshold' and 'target' will go altogether, and I'll have separate
> >> > *_alert0 and *_alert1 per CPU group.
> >>
> >> It should perhaps be the best to have "passive", "hot" and "critical"
> >> trips defined for all three CPU groups/(sub)clusters, separately of
> >> course, to have even higher granularity when it comes to the resulting
> >> thermal throttling.
> >
> > I looked through drivers/thermal/rockchip_thermal.c, and it doesn't
> > seem to provide any callback for the "hot" trip as part of its struct
> > thermal_zone_device_ops, so I guess it would be redundant in our case
> > here? I couldn't find any generic mechanism to react to "hot" trips,
> > and they seem to be purely driver-specific, thus no-op in case of
> > Rockchips - or am I missing something?
>
> That's a good question.  Please, let me go through the code in detail,
> and I'll get back with an update soon.  Also, please wait a bit with
> sending the v3, until all open questions are addressed.

Of course. Thank you for taking the time to dig through this one with me!

Best regards,
Alexey

