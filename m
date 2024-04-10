Return-Path: <linux-kernel+bounces-138470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89489F1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3A1C231B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A203A15B0FF;
	Wed, 10 Apr 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UtgZY/IS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A215B100
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750834; cv=none; b=oGiQHGIIg/dgfyl+pR66CdcGrxa3YaiUyx/t1XQRPDQTlWpFChnh3vBFCwzobKOo6EMz0HcqzlktH1Z2C9OeUwKen+9qNUcXtaxXlXoL6Wl47H0NTfFsSZ2C0h8h7Z6WG2GrJptyF5nvHCfOnMklKG12yIAqkIKUxT2Sgrv7RkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750834; c=relaxed/simple;
	bh=JeLs9WU+n3dFBi/71GVKzouJbohebsHMG3JE6YDGZ+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQpOSkiUxonNlNSa9771Ta2jbZql6WAUFbcquMkVL4rCpD3kvu5Fn7SpZbJNMhpin55lauvEBTs1b+tkk/9RbH6bfYv0cHG7DRsZXAeZjWRXYNgIEcIrTxK4I1WMmhh1E3DQiaoVFpx9Z8qiBP0U+EDup/0CobdOXmjhgO6TplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UtgZY/IS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51c8274403so466042566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712750831; x=1713355631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8P5WqVrHeK2zaTvdI8Gl1QefEqSb/GOhR4ipVI1tvQ=;
        b=UtgZY/ISy/GVSMhPWVCZEjx36BI+wu6njo1We+BYA2h/AJxp1nnK06svLhFEtUocFx
         qPftjQpVZk/RA4yZQN0jjzvxD1kE0ht70zNi7psswrsR+hKKMwcIbfbtn5lGus3gcjCt
         u9a02KNw4EY/71R1hgpYwXa+O71UTdB34sbMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712750831; x=1713355631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8P5WqVrHeK2zaTvdI8Gl1QefEqSb/GOhR4ipVI1tvQ=;
        b=UOLlNEKcA/KyFPmAkLjdvmLLJ8DwO4rySpgObRV4snmT86xTIlKUzndaeM5T+KjVJM
         7YSmC+ui1xhJbR1/y+eH6MMNT8crsQ7qLNs8t8XdCTtKn74o6QT5Py+A32SRsurqieZ1
         hoDI6s8i422lZZxq9axBPgBm4Nk9DmMJU2Fsw64+asVoKp85PieJFtY5CpW/22X5ME6X
         zxoI2UtHCoIsmCVrfQhOSAX0lZQbPtoqCRHCxTNeXseRRptfPuRGX/HqRo9qjV0BQ5hE
         QTaq20U2oXsGK08pyk9yRoFxww/k5Sqm2kg7+U5OLa7aXJLEEj7/RKAbFJsA/2/8qHJK
         IzMg==
X-Forwarded-Encrypted: i=1; AJvYcCXgpCjY/vz4GfLE3dukyHtclr3CKhe90ayk+lYHKtK3AdewHJ1Z2bRcPZ0tM970VXaLDVEV7c65WOo4jIKRGch6jcwNGF8t0TJ13bRo
X-Gm-Message-State: AOJu0YwOj/NADhKY51Wef8FVg0RTxRRZ9HrRG8oY6Nr6mcK849EmcqYc
	Z8q3wN1kdKxEnyi/e5p/VkLSIer/Grqg2n0DpjUJfUNWM5Hoiiut81iy+i1JnEV9ENXZ1b/HUH5
	O4Q==
X-Google-Smtp-Source: AGHT+IFk547M7Vv1NAZouKsetIfRbzu6OIDT+ZEnZkIjC9NafW20tMNP5dsZCkhjuo9rqNqlgbKYPQ==
X-Received: by 2002:a17:906:b109:b0:a51:b1b1:b772 with SMTP id u9-20020a170906b10900b00a51b1b1b772mr1322833ejy.65.1712750830820;
        Wed, 10 Apr 2024 05:07:10 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id nb33-20020a1709071ca100b00a4628cacad4sm6853372ejc.195.2024.04.10.05.07.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:07:10 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e6282dd72so4010813a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:07:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPU1ohIBxd5D4Fvfrxu1wCVh2/6/CAitWqtVTVNvw3nzWroymaVbASYZPdczUjv5eAjETT8oAYj561WCp0UpkeAJuMC4TNG4rF1+x0
X-Received: by 2002:a17:907:7202:b0:a51:9d21:2a1e with SMTP id
 dr2-20020a170907720200b00a519d212a1emr1872195ejc.73.1712750829549; Wed, 10
 Apr 2024 05:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410-upstream-torvalds-master-v2-1-679777847b63@chromium.org> <d1dafc46-9b14-4752-822c-86cbabdcfb8b@collabora.com>
In-Reply-To: <d1dafc46-9b14-4752-822c-86cbabdcfb8b@collabora.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 10 Apr 2024 20:06:33 +0800
X-Gmail-Original-Message-ID: <CAHc4DNLrU=QVWODOzHXW16Ko1V=W31zkSHOi7rztiJMOMDcKqg@mail.gmail.com>
Message-ID: <CAHc4DNLrU=QVWODOzHXW16Ko1V=W31zkSHOi7rztiJMOMDcKqg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8192: Add missing trip point
 in thermal zone
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	=?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
	Balsam CHIHI <bchihi@baylibre.com>, Alexandre Mergnat <amergnat@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

1. 68=C2=B0C is provided by MediaTek previously in downstream
2. I think sustainable power will be estimated by
estimate_sustainable_power in drivers/thermal/gov_power_allocator.c,
but I'll ask MediaTek if they can provide the precise value.
3. Sure. I'll do it in v3 after I check 2. with MediaTek

Regards,
Hsin-Te

On Wed, Apr 10, 2024 at 5:50=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 10/04/24 10:40, Hsin-Te Yuan ha scritto:
> > According to Documentation/driver-api/thermal/power_allocator.rst, ther=
e
> > should be two passive trip points. Adding the missing trip point to
> > ensure that the governor works optimally.
> >
> > Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes a=
nd thermal zones")
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
>
> That's better - but while I can agree about setting a general temperature
> for that, I still have a few questions and requests:
>
> 1. Why is this 68=C2=B0C? Was that value provided by MediaTek, or was it =
calculated?
>   1b. If this was calculated, please, can you explain how?
>
> 2. The power allocator documentation also says that the governor works go=
od
>     when a "sustainable dissipatable power" parameter is fed to it throug=
h the
>     `sustainable-power` devicetree property (with that being strictly boa=
rd
>     specific and never SoC-global, as that depends on the form factor and=
 on
>     the cooling method of the machine), can you please also add the right
>     sustainable power indication to the Chromebook devicetrees?
>     In the MT8192 specific case, that's mt8192-asurada.dtsi.
>
> 3. I just noticed that MT8192 is not the only one that would be affected =
by
>     the issue that you're describing in this commit; can you please perfo=
rm a
>     similar change on the others, if parameters are known?
>
> Thanks,
> Angelo
>
> > ---
> > Changes in v2:
> > - Clearify the reason of adding another passive trip point
> > - Link to v1: https://lore.kernel.org/r/20240410-upstream-torvalds-mast=
er-v1-1-852e903f0cec@chromium.org
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 40 +++++++++++++++++++++++=
+++++++++
> >   1 file changed, 40 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8192.dtsi
> > index 05e401670bced..08d8bccc84669 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -1959,6 +1959,11 @@ cpu0-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_LITTLE_=
CPU0>;
> >
> >                       trips {
> > +                             cpu0_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu0_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> > @@ -1989,6 +1994,11 @@ cpu1-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_LITTLE_=
CPU1>;
> >
> >                       trips {
> > +                             cpu1_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu1_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> > @@ -2019,6 +2029,11 @@ cpu2-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_LITTLE_=
CPU2>;
> >
> >                       trips {
> > +                             cpu2_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu2_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> > @@ -2049,6 +2064,11 @@ cpu3-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_LITTLE_=
CPU3>;
> >
> >                       trips {
> > +                             cpu3_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu3_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> > @@ -2079,6 +2099,11 @@ cpu4-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_BIG_CPU=
0>;
> >
> >                       trips {
> > +                             cpu4_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu4_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> > @@ -2109,6 +2134,11 @@ cpu5-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_BIG_CPU=
1>;
> >
> >                       trips {
> > +                             cpu5_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu5_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> > @@ -2139,6 +2169,11 @@ cpu6-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_BIG_CPU=
2>;
> >
> >                       trips {
> > +                             cpu6_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu6_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> > @@ -2169,6 +2204,11 @@ cpu7-thermal {
> >                       thermal-sensors =3D <&lvts_mcu MT8192_MCU_BIG_CPU=
3>;
> >
> >                       trips {
> > +                             cpu7_thres: trip-point {
> > +                                     temperature =3D <68000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> >                               cpu7_alert: trip-alert {
> >                                       temperature =3D <85000>;
> >                                       hysteresis =3D <2000>;
> >
> > ---
> > base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
> > change-id: 20240410-upstream-torvalds-master-40aeff5416c7
> >
> > Best regards,
>
>

