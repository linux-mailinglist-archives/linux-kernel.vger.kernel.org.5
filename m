Return-Path: <linux-kernel+bounces-36675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA383A4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EE128923A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6EF17BC5;
	Wed, 24 Jan 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WcIIr6q1"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5B17BB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087117; cv=none; b=HzqQ6JdO2b7DbYSvrlG5doYwvwmZ8GpohF254tkBMb0FyqSDH80SABwzciPAEl5Qjz3pWGA51MQGhV76zQw2tznPVDqwfM4+572oNsDMeSQhkGG2ut2JCaOhtFDS+IMAR1i4cRPvjKOMSd4kf5PutFMERlwvirrxk5EYzOb3FWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087117; c=relaxed/simple;
	bh=bYGjWyfNDuuEy/uhJ2BsahwEeQkQmwNi/I2B366Ra5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckuqldGufjeFFoejXmixmbkFu7Ts3bjgt/FsnmmeLlJAvg/NVdM+9av6XqQyiNXIPM44NQ18jnxkWQs8erxj2n2Qsju6QIEtPk2VqYhDDSo+DqVL/QgMLv9IFhz2uPJIKQ0sPde1O3rPQtrYSDuq0fEdaQDGq2n+MuRQIxCcVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WcIIr6q1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5100b424f8fso1308117e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706087113; x=1706691913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TdYwfAa3Kb++bbinJAM8F6n7j06tuxaI+2yyckzaPc=;
        b=WcIIr6q1JjNbUJ44GICbccxKaSJ2iIJ7tzpKtG9ffIPrtoR5l0+qXYJ6/qWg4ucD6A
         PrgDTdSXKxI5o3hLlWT+OGXXqCiJNaSaeRUjObAT6VSMyuVpvUXuqLgyCPnAjPYkx7oi
         LJBozvVgB8INR5E6l303x/Ypyv66yvXwfAswQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087113; x=1706691913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TdYwfAa3Kb++bbinJAM8F6n7j06tuxaI+2yyckzaPc=;
        b=KjAyzMKYz7ow82DyDla62dzM7edR2U/gsMl1B1o77nTE+WmdhXdBFWkFBKUg3+A6pL
         qDnnCoApvRKPRrNYMNDFvuf6QhjLX2knaoD/7DnTbNaZfy6NiJH7yiKx7CmvMXba+r5T
         NTtfSt8XAM36IJ/gRkne8vAznojcLIQ4FLtUfHrYFVIKnUr5BuJpyLlqPCpGFHGGtptH
         JhbVhvoJt5MtPDQbtZK65TbXG+AzllNbM0NTef/tpktnI4k23s7l6gYhqcR/h6tMlISe
         zhD0R0iukEYpfFTAYaSH8wy0EU50U8CIvFGdfYCiGrorcB/TCnse3eSEUilr3tDaewuG
         KEvA==
X-Gm-Message-State: AOJu0YzEtUEZ9gtlfpxw/UNHZC0Nfs9zdbeG3b7ziWx57CYjYYM0R+Rd
	q3+K0DsC6szku3Ximdlikknqw9rOnAE3jCI/w1dff5Ei71aX9LDCjrj5Ei7OYUiMIjW9t50rvRp
	89yGbH4s=
X-Google-Smtp-Source: AGHT+IE9fD6P5YWF0X5LhrLGvHRVXYARSd3FElyorN15GvNyG66wjXP2y5GOm+eqT9AyZrYixx8ZSQ==
X-Received: by 2002:a05:6512:23a4:b0:510:e95:3b32 with SMTP id c36-20020a05651223a400b005100e953b32mr723311lfv.109.1706087112793;
        Wed, 24 Jan 2024 01:05:12 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id j9-20020a508a89000000b00554930be765sm16741570edj.97.2024.01.24.01.05.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 01:05:12 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso515744466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:05:12 -0800 (PST)
X-Received: by 2002:a17:906:1756:b0:a30:cc71:7340 with SMTP id
 d22-20020a170906175600b00a30cc717340mr560441eje.120.1706087112019; Wed, 24
 Jan 2024 01:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-send-upstream-v3-1-5097c9862a73@chromium.org> <786c85c7-7b38-4a2a-85ec-282196de7b5e@collabora.com>
In-Reply-To: <786c85c7-7b38-4a2a-85ec-282196de7b5e@collabora.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 24 Jan 2024 17:04:35 +0800
X-Gmail-Original-Message-ID: <CAHc4DNKXOb54v7qJZJ2EsVP1KkMq7WnSJJLWhb2SzuhW_=qnxQ@mail.gmail.com>
Message-ID: <CAHc4DNKXOb54v7qJZJ2EsVP1KkMq7WnSJJLWhb2SzuhW_=qnxQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mt8195-cherry-tomato: change watchdog
 reset boot flow
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi AngeloGioacchino,

This bug can be triggered by stopping watchdog daemon and running
`sleep 60 > /dev/watchdog`.

Regards,
Hsin-Te



On Wed, Jan 24, 2024 at 4:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 24/01/24 08:51, Hsin-Te Yuan ha scritto:
> > From: Hsin-Te Yuan <yuanhsinte@google.com>
> >
> > The external output reset signal was originally disabled and sent from
> > firmware. However, an unfixed bug in the firmware on tomato prevents
> > the signal from being sent, causing the device to fail to boot. To fix
> > this, enable external output reset signal to allow the device to reboot
> > normally.
> >
> > Fixes: 5eb2e303ec6b ("arm64: dts: mediatek: Introduce MT8195 Cherry pla=
tform's Tomato")
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
>
> Can't trigger the bug, but also this commit gives no side effects, so:
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
>
> > ---
> > Changes in v3:
> > - Add Fixes tag
> >
> > Changes in v2:
> > - Limit the effect only on tomato.
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
> >   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
> >   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
> >   3 files changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b=
/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > index 2d5e8f371b6de..a82d716f10d44 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > @@ -23,3 +23,7 @@ &sound {
> >   &ts_10 {
> >       status =3D "okay";
> >   };
> > +
> > +&watchdog {
> > +     /delete-property/ mediatek,disable-extrst;
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b=
/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> > index 2586c32ce6e6f..2fe20e0dad836 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> > @@ -43,3 +43,7 @@ &sound {
> >   &ts_10 {
> >       status =3D "okay";
> >   };
> > +
> > +&watchdog {
> > +     /delete-property/ mediatek,disable-extrst;
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b=
/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> > index f54f9477b99da..dd294ca98194c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> > @@ -44,3 +44,7 @@ &sound {
> >   &ts_10 {
> >       status =3D "okay";
> >   };
> > +
> > +&watchdog {
> > +     /delete-property/ mediatek,disable-extrst;
> > +};
> >
> > ---
> > base-commit: 64b50fcb03649ca7f0d762a50e7a3484cfc1d586
> > change-id: 20230818-send-upstream-e91e615a893c
> >
> > Best regards,
>

