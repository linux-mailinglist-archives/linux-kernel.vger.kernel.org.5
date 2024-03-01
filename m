Return-Path: <linux-kernel+bounces-87907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81086DAEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8041C1C233F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025850271;
	Fri,  1 Mar 2024 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD+X0RV+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C03FE23;
	Fri,  1 Mar 2024 05:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709269981; cv=none; b=RaamxUZq+RsbGJtB0DekP0UIUqFswhhG+aD/hME9pv9qvU63/JksKUIST7grYF1Ar/CLe5SsdpTaj9qdef06gW9ZR1jAYiuCgmZs+ynFhA7BfjUh2dsaL4AW7tZilNvGj8Z+nyMWIjdjNPMWum1DTpK2uMHv/HE+iHTGm0DLU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709269981; c=relaxed/simple;
	bh=qD/IA5tub8dvGI0ruKEbe8uuRvgVF69TMrFYrEmMNjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxq5ba8yCxslg/Nt8OW3KjqOxrtMNDpBQQujoP0zn/0osMLSLoVauXbjFgE38nnSni08E8I5AuQdUjfZPEcf6H+egvczM8gZ0794P5pNsMPeTpWnQec2kz61dDXPYzyGczaW794HCC2pljtQcA3lkXUB/dxjAnyXm6uMkKCmIL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD+X0RV+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3d484a58f6so272577366b.3;
        Thu, 29 Feb 2024 21:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709269978; x=1709874778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpSMaxLHOZBLhzSSp7ZYNdckYQGJqypZw8rFLh1tAiM=;
        b=mD+X0RV+vBuUMWK1T3MmPPxEGwPNmo35JiUMU3T+sfYRu+c/A9qaZ8ZovVlQMWzsab
         QiZDeFrcGP3jh9QYyuBbGIABCgeFCLWC3+miWdajPALsw9AfziGe9mBYF5PeqNJHs9mQ
         ry2aWC5Ago9yiAcryfMAZi2nbgWCkKCfpGth7tjFps/lKx6bbqNVNS010BJlNtCCO3AN
         NJMiZmtevhvw9k07mBX4G1ycgXquV71tbWUlODTP7iErXlAg0QidThSkp/v2FvbETLHj
         7Phke9MBMJrb8b93aRX4FEdbxBdX8xXV8p6TGLhWfWlq3APl/NLHu2g6gZroiWMWbtxo
         c2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709269978; x=1709874778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpSMaxLHOZBLhzSSp7ZYNdckYQGJqypZw8rFLh1tAiM=;
        b=AXzggckzrFdy1bVEzxtBnvXboNS80Kvo5RlH78Q/LPaBQzDst6z/lr9VLWQvjy3A3v
         adxORRoHgsDAd5/MnutwA2FuqnfVb55DFL+jxZC/EjpE04Z0u8u7R7V/BbzfLCE3gj0c
         YII1GD14YSR/ioqkFAlVEV/yYyM8Ibir6hhu89iGok1jn250cPxuHPqLA8JLqjYEIhQQ
         I/lTPMATM0MQFSP7CfaD0vCCqmerUy0CD6WkMh6NxQmJSv0wL46kwMHrAFhm9fX3Qm9N
         uyyN8imFWW/fGr87I/si7G/QiUL7V+iYn5dx9QHwdsxUjMhQgPUPE8JANQ0uH4Sr7SjE
         mRXg==
X-Forwarded-Encrypted: i=1; AJvYcCWMovCmaOKitJrtSWAXTS5yDAhK0CWi06FhCijlN3R6e2Z/qS47rvyfhv7Xr2Wzm0CjEB1qQlau1DpwxpAbZYa32NIM+cVi3EGNx/gT26kREeHnz7FQ9YhgbW8QCogTyXcBSZ4VDvKDmw==
X-Gm-Message-State: AOJu0YzQS7RaCtyUWcQrkQOMCFZeSPc7oshA4+F0MIfXO8PcpDosN/+/
	0HWV5g+6sScPaysxWbmMyxZOcgbqJYTqpm1d2gK5dRRlBgBfo8/IGYAhZS+lyIzPVx3X/eY6qlG
	mWhnKdq0/zjkVn3IPwVtJEYVBW98iQhWblrQCmFyo
X-Google-Smtp-Source: AGHT+IHYWOS3Z3rIeyJhR53EO9xdVKH4kb0vhRlRutjWAUXPsNmoNiwk8ZAeve8zdBGwAytJJLrgA202MBvW0ygn1Xg=
X-Received: by 2002:a17:906:c31a:b0:a44:7209:4c67 with SMTP id
 s26-20020a170906c31a00b00a4472094c67mr379475ejz.45.1709269977903; Thu, 29 Feb
 2024 21:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com> <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
In-Reply-To: <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 1 Mar 2024 09:12:46 +0400
Message-ID: <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Fri, Mar 1, 2024 at 12:21=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alexey,
>
> On 2024-02-29 20:26, Alexey Charkov wrote:
> > Include thermal zones information in device tree for RK3588 variants.
> >
> > This also enables the TSADC controller unconditionally on all boards
> > to ensure that thermal protections are in place via throttling and
> > emergency reset, once OPPs are added to enable CPU DVFS.
> >
> > The default settings (using CRU as the emergency reset mechanism)
> > should work on all boards regardless of their wiring, as CRU resets
> > do not depend on any external components. Boards that have the TSHUT
> > signal wired to the reset line of the PMIC may opt to switch to GPIO
> > tshut mode instead (rockchip,hw-tshut-mode =3D <1>;)
>
> Quite frankly, I'm still not sure that enabling this on the SoC level
> is the way to go.  As I already described in detail, [4] according to
> the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, we
> should actually use GPIO-based handling for the thermal runaways on
> the Rock 5B.  Other boards should also be investigated individually,
> and the TSADC should be enabled on a board-to-board basis.

With all due respect, I disagree, here is why:
 - Neither the schematic nor the hardware design guide, on which the
schematic seems to be based, prescribes a particular way to handle
thermal runaways. They only provide the possibility of GPIO based
resets, along with the CRU based one
 - My strong belief is that defaults (regardless of context) should be
safe and reasonable, and should also minimize the need to override
them
 - In context of dts/dtsi, as far as I understand the general logic
behind the split, the SoC .dtsi should contain all the things that are
fully contained within the SoC and do not depend on the wiring of a
particular board or its target use case. Boards then
add/remove/override settings to match their wiring and use case more
closely

In the light of the last two points, I believe that enabling TSADC by
default is the more safe and reasonable choice, because it provides
crucial thermal protection logic for the SoC, and it can do so in a
board-agnostic way (if the CRU based reset is selected, which is the
current default).

Furthermore, TSADC and CRU are fully contained within the SoC, and I
cannot think of a use case where a board might be somehow
disadvantaged by TSADC being enabled, and thus need to disable it
altogether (maybe I'm missing something). The only thing that the
board might be adjusting is the thermal reset handling, and even then
it's rather a matter of choice/preference to switch away from CRU to
GPIO resets where the wiring permits it, rather than an existential
need. I presume that a PMIC-assisted reset causes deeper power cycling
of the SoC and might therefore help in some rare cases where the CRU
reset alone is not enough, but that would be niche.

All summed up, I believe that the default of "fry my board if I have
no heatsink and forget to include &tsadc {status =3D <okay>;}; in my
dts" is substantially inferior to the default of "my board could do a
deep power-cycle in this weird corner-case thermal-runaway situation
that somehow didn't get handled by active cooling, then by passive
cooling, then by a CRU reset, but I didn't include
rockchip,hw-tshut-mode =3D <1>; so poor luck for me".

Would be great to hear other perspectives from people on the list.

Best regards,
Alexey

> [4]
> https://lore.kernel.org/linux-rockchip/4e7c2b5a938bd7c919b852699c951701@m=
anjaro.org/
>
> > It seems though that downstream kernels don't use that, even for
> > those boards where the wiring allows for GPIO based tshut, such as
> > Radxa Rock 5B [1], [2], [3]
> >
> > [1]
> > https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/=
dts/rockchip/rk3588-rock-5b.dts#L540
> > [2]
> > https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/=
dts/rockchip/rk3588s.dtsi#L5433
> > [3] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf
> > page 11 (TSADC_SHUT_H)
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 176
> > +++++++++++++++++++++++++++++-
> >  1 file changed, 175 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > index 36b1b7acfe6a..9bf197358642 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -10,6 +10,7 @@
> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/ata/ahci.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       compatible =3D "rockchip,rk3588";
> > @@ -2225,7 +2226,180 @@ tsadc: tsadc@fec00000 {
> >               pinctrl-1 =3D <&tsadc_shut>;
> >               pinctrl-names =3D "gpio", "otpout";
> >               #thermal-sensor-cells =3D <1>;
> > -             status =3D "disabled";
> > +             status =3D "okay";
> > +     };
> > +
> > +     thermal_zones: thermal-zones {
> > +             /* sensor near the center of the SoC */
> > +             package_thermal: package-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 0>;
> > +
> > +                     trips {
> > +                             package_crit: package-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 0 and 1 */
> > +             bigcore0_thermal: bigcore0-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 1>;
> > +
> > +                     trips {
> > +                             /* threshold to start collecting temperat=
ure
> > +                              * statistics e.g. with the IPA governor
> > +                              */
> > +                             bigcore0_alert0: bigcore0-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             /* actual control temperature */
> > +                             bigcore0_alert1: bigcore0-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore0_crit: bigcore0-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&bigcore0_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_b0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_b1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 2 and 3 */
> > +             bigcore2_thermal: bigcore2-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 2>;
> > +
> > +                     trips {
> > +                             /* threshold to start collecting temperat=
ure
> > +                              * statistics e.g. with the IPA governor
> > +                              */
> > +                             bigcore2_alert0: bigcore2-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             /* actual control temperature */
> > +                             bigcore2_alert1: bigcore2-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             bigcore2_crit: bigcore2-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&bigcore2_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_b2 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_b3 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between the four A55 cores */
> > +             little_core_thermal: littlecore-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 3>;
> > +
> > +                     trips {
> > +                             /* threshold to start collecting temperat=
ure
> > +                              * statistics e.g. with the IPA governor
> > +                              */
> > +                             littlecore_alert0: littlecore-alert0 {
> > +                                     temperature =3D <75000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             /* actual control temperature */
> > +                             littlecore_alert1: littlecore-alert1 {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +                             littlecore_crit: littlecore-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&littlecore_alert1>;
> > +                                     cooling-device =3D
> > +                                             <&cpu_l0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_l1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_l2 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> > +                                             <&cpu_l3 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor near the PD_CENTER power domain */
> > +             center_thermal: center-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 4>;
> > +
> > +                     trips {
> > +                             center_crit: center-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             gpu_thermal: gpu-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 5>;
> > +
> > +                     trips {
> > +                             gpu_crit: gpu-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             npu_thermal: npu-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 6>;
> > +
> > +                     trips {
> > +                             npu_crit: npu-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> >       };
> >
> >       saradc: adc@fec10000 {

