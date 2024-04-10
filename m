Return-Path: <linux-kernel+bounces-138166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0E89ED97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783721C20FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834613DB87;
	Wed, 10 Apr 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQd2jjGP"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3579313D8A3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737715; cv=none; b=bqdrF67HvhggyBnZvAoQhpq3bJ4L1A1CbJivvzu9ci8DM+ikfowpf0zHMBqCDpNG/RAg3dRK4tLqcIQeRHEf6Urcb8Ho3HBCTYYLP1h+TEJhU5csQgHi9TG4B4bS9jUjAvUgOW8UvpyhOB2h8sRYjLVkZ+f735J5o7ZHRhRkAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737715; c=relaxed/simple;
	bh=RdoPGfTRxg4TF3BNotLs/J4hn1wlJbrn+0z/i3iKM08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGUCjT1tMeztGeHE2NfM52tHjfE/csviXt7EZn5xL+/ySzB1HaUMI3V2W6aR3qVtq/uCUYDNKuYnur1WgwpqauV6yN7F24Ovom2q3xWzldtu17/3qUvA66fdt2yV5u1sv7HjuvlLB7Q5vin7Iq1iLjcFsVkPRGJtzUZVHb1cAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CQd2jjGP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so2450936a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712737711; x=1713342511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW38Gh9I29r84lVoZWwktFq4DHYBoJff/etd3Fj/TJA=;
        b=CQd2jjGPQ+mNjGzTALoRhUoqs0P5Ca+BCxoyF0zfUWDYR/cBKSQjj4MGX+oqjX96VS
         l+fsgKV88VBrrXp907hDNQwJ1WHXgm1ktZKwXWNLUrrLmO5lGVZxUHRNzcNSvEujWL3A
         4I1hxAg6zMAVQPYd6XtiCg7ntOrtrmYqvNXD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737711; x=1713342511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW38Gh9I29r84lVoZWwktFq4DHYBoJff/etd3Fj/TJA=;
        b=XtyFLP6aSpY/EztrBwDD82DtE67xVe2+aOTiJ8BZj/VwzARouIFWKUVg+lfGKbEpRT
         6FsoSAHaP2Q1vusjYckDQh3W7wdn50bFo/rQUqpWZebz6rBd09ay4qPITYUGZE7fui/F
         DMooO3/Jq/0VTO7vBA4xCRUGWW31oqjbHE7H1Wfq7gIs4h1rssWcy+7IYISbawh+Pn+i
         Sf7JrdMKo/rST5CmpOIiB4WlJCphgrVexOWl/2kR+69Jznt1TGsfClEanf6uWAsoqnHx
         B2ZIIDG9XyAr0EUvm8UDEcSPFmQZ7lS/MDgjmEjfQgGgFdiyIoY8mCqnHdLvIkpYMsdY
         e1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVEjg0jAkjahb36aXWRWGTOAWW/aPck1C5ArjFQKb51AhN95oUsvmtzs91WthiXEQ1+3wYZH/Ohi3k1Ev4UyTokmFWpxk2QYK3D0/dC
X-Gm-Message-State: AOJu0Ywv7kg7GjW497ELWASknIvSSS9/xSlpeoyDsBu4+kh0eAsHet2J
	pP1oATrzqHV/X5Ktitq/hWMtYvzCkLjNPteam6Gn5TO/H5ix4vIA7Vh4gZ+mGpVDzIP2/Z+1J6n
	FOQ==
X-Google-Smtp-Source: AGHT+IGgEQqX3HX+tgbF4YAfud0KafxsnY3QLUskWOpITJrt3HbTXx24YMeG69QcDJm1GX+yEyrVvg==
X-Received: by 2002:a17:906:29cc:b0:a4e:7a36:4c38 with SMTP id y12-20020a17090629cc00b00a4e7a364c38mr1532412eje.20.1712737711174;
        Wed, 10 Apr 2024 01:28:31 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090646cc00b00a4e3fda23f5sm6633369ejs.165.2024.04.10.01.28.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:28:30 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso672924066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:28:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhL/djCKr1+bG/bfa2Nb7tSxBfBYVW4Uj8nF2Gh4aYrq9pVD/t8F8NwX/zNtd9wnm8j9hJV02DoPcW1ySoMgHJa5UlfJ3lgfHGXmuM
X-Received: by 2002:a17:907:a41:b0:a51:dd18:bd21 with SMTP id
 be1-20020a1709070a4100b00a51dd18bd21mr1452940ejc.16.1712737710124; Wed, 10
 Apr 2024 01:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410-upstream-torvalds-master-v1-1-852e903f0cec@chromium.org> <c3d05b3e-f784-4606-9634-52dc6feee318@collabora.com>
In-Reply-To: <c3d05b3e-f784-4606-9634-52dc6feee318@collabora.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 10 Apr 2024 16:27:53 +0800
X-Gmail-Original-Message-ID: <CAHc4DN+N7oLNiiVL-T+T0dEr2nipph5f2q5zu37NowPQC+=mkw@mail.gmail.com>
Message-ID: <CAHc4DN+N7oLNiiVL-T+T0dEr2nipph5f2q5zu37NowPQC+=mkw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Add missing trip point in
 thermal zone
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

According to the document
(https://docs.kernel.org/driver-api/thermal/power_allocator.html),
there should be two passive trip points. It seems that the switch-on
temperature will be 0 if we only have one trip point, which hurts
performance. I'll send v2 to explain this more clearly.

Regards,
Hsin-Te


On Wed, Apr 10, 2024 at 3:43=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 10/04/24 08:20, Hsin-Te Yuan ha scritto:
> > Add the missing passive trip point which is expected by kernel.
> >
> > Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes a=
nd thermal zones")
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
>
> Sorry, I don't understand what you're trying to solve here.
>
> All of the thermal zones in mt8192.dtsi already do have a passive trip po=
int
> which is also used in cooling-maps.
>
> Can you please describe the issue?
>
> Thanks,
> Angelo
>
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

