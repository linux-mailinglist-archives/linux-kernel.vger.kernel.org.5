Return-Path: <linux-kernel+bounces-69711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A5858D97
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE3DB21677
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BE1CAB8;
	Sat, 17 Feb 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XElIW9Lk"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2CC149E08
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708153327; cv=none; b=n0fH7f++lu5AkKbkQaQO3wJn+2hedWRaSqLN5ZewtMf4Fbzr7KpKwjcYcxN71480QVtMHSAmq/TY8JvWWtKBMF393qLNvfDH9pgc40edfbBZ3YXvk+FhXRv4jbNobv43FUu2tOLRqRrWIQuJZ5gahIVlQBl0kSCeHHYNjUFK8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708153327; c=relaxed/simple;
	bh=8NpmbJ+gfmJTEv37/idmLOJq2YThJe1CWEE0taqRs0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B15qUFcOi9n19Ie5oV8hTQhUpvgu0z3KlWT4TyGXY4qHYAmOYriXAhNaq2PdfHBSF1aewLGip1W1pIRlTG2nxrqQ6lcRQro8aHeETd0XSyyO75s3nTnhZUt7MPFI8U5tPLb6mhRY+1fNb9zfaHypRWL9zAEGZdoz//FGuqe/IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XElIW9Lk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso2943606a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708153323; x=1708758123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs1VlpZsxeC5GOLK06WGcIjDrl11J8nbAUzkDUfDeRs=;
        b=XElIW9LkRKVbpYA2NGsfyLWSUsyvM6YwvEtJVWn4pXUiBGAbroyV7BtgGRgNoIW5Jg
         KVu+okL/AuvbPbkys0VdvUsQj5o7zyzyBvizjJCWn6kuWWAbWNjPS6hNOdhtjUB9Nx1t
         baNIY7jge0fQoeR/9qCVwIJIBkd8zilV+HOvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708153323; x=1708758123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs1VlpZsxeC5GOLK06WGcIjDrl11J8nbAUzkDUfDeRs=;
        b=VDAL1SHyjQ3+w0IwAa6HaNt3WAHluqmdCUVkjQDVf6eMfwHf7mkDdcRGFqBn+qr1tz
         wIHVOjGgoT3nNpV37iyczJ8stAd11HSPFHYQJ9IvChS3SKM0oTHV/epPIC4RB9YYlS2M
         97mWt97nrrqEKPvx4B2MWDz67SkukWyMkjMf0MyXAK7kZpyUuvIqV18jsqVOStALtQKQ
         ZGPZ0Tvjh8q8Qb+VZKin48SmxG9o28UIuSXB+/rLvActLU8SSANjTso/lO3I56r7T+03
         wJY0wUG0WeQdD4XagBtV8j6rzo5HgsiBzFCnc6NvCA6esnkoxNG6Su+7EF2/YK/AZm7g
         ET1g==
X-Forwarded-Encrypted: i=1; AJvYcCWihXieRBYXJqTOw/HplRptS9DeJQs/5KStvpLmm5hCYnsVkxf/lKZpXW9/sUxiK8P2Ft8e+aC9hINeqv6WaWUJmfj30U235z2ZFEne
X-Gm-Message-State: AOJu0YwmJj/0+lgIlbFfmw4Gr/AHgaNZgvsjs9YXHH2xvhafauFYtuxn
	Fu2H9BwSqe2oi+oYMn8EH5ScNkWlOCd+OowMfEyLRyA/NRZ1bfn2SuWut6OMePcVXre60eCzfVg
	=
X-Google-Smtp-Source: AGHT+IGDx6L82+kYK0LPXsXryHMo+y/7N4EsmGsZC6BGxFcCpRjGO9ZxIKvCs2wxasbjUSLH+0+3mQ==
X-Received: by 2002:aa7:ce09:0:b0:564:154:6802 with SMTP id d9-20020aa7ce09000000b0056401546802mr1599229edv.40.1708153323002;
        Fri, 16 Feb 2024 23:02:03 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id ij26-20020a056402159a00b005621bdbfdb0sm672116edb.75.2024.02.16.23.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 23:02:02 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3566c0309fso333263666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:02:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHjyfw1w+CariS6VteGSzD2DN4yvl2A5kJw9Qi8ZRNcTV1CaHSo3SA0x1+NHpQAzXFdLhDo4r3sm/xFbfz7y13++eWLtoENI3Qy4SD
X-Received: by 2002:a17:906:c2d7:b0:a3c:9bc7:7a0e with SMTP id
 ch23-20020a170906c2d700b00a3c9bc77a0emr4749372ejb.9.1708153321660; Fri, 16
 Feb 2024 23:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-send-upstream-v3-1-5097c9862a73@chromium.org>
 <786c85c7-7b38-4a2a-85ec-282196de7b5e@collabora.com> <CAHc4DNKXOb54v7qJZJ2EsVP1KkMq7WnSJJLWhb2SzuhW_=qnxQ@mail.gmail.com>
In-Reply-To: <CAHc4DNKXOb54v7qJZJ2EsVP1KkMq7WnSJJLWhb2SzuhW_=qnxQ@mail.gmail.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Sat, 17 Feb 2024 15:01:25 +0800
X-Gmail-Original-Message-ID: <CAHc4DNKSj5MK5Pfi5DYm9hUqh=uxUs4S3uakqfht-3O18vgLTA@mail.gmail.com>
Message-ID: <CAHc4DNKSj5MK5Pfi5DYm9hUqh=uxUs4S3uakqfht-3O18vgLTA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mt8195-cherry-tomato: change watchdog
 reset boot flow
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello AngeloGioacchino,

I noticed that this patch does not seem to have been landed yet.
Please let me know if there are any issues.

Thank you,
Hsin-Te


On Wed, Jan 24, 2024 at 5:04=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> Hi AngeloGioacchino,
>
> This bug can be triggered by stopping watchdog daemon and running
> `sleep 60 > /dev/watchdog`.
>
> Regards,
> Hsin-Te
>
>
>
> On Wed, Jan 24, 2024 at 4:27=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 24/01/24 08:51, Hsin-Te Yuan ha scritto:
> > > From: Hsin-Te Yuan <yuanhsinte@google.com>
> > >
> > > The external output reset signal was originally disabled and sent fro=
m
> > > firmware. However, an unfixed bug in the firmware on tomato prevents
> > > the signal from being sent, causing the device to fail to boot. To fi=
x
> > > this, enable external output reset signal to allow the device to rebo=
ot
> > > normally.
> > >
> > > Fixes: 5eb2e303ec6b ("arm64: dts: mediatek: Introduce MT8195 Cherry p=
latform's Tomato")
> > > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> >
> > Can't trigger the bug, but also this commit gives no side effects, so:
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> >
> >
> > > ---
> > > Changes in v3:
> > > - Add Fixes tag
> > >
> > > Changes in v2:
> > > - Limit the effect only on tomato.
> > > ---
> > >   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
> > >   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
> > >   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
> > >   3 files changed, 12 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts=
 b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > > index 2d5e8f371b6de..a82d716f10d44 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> > > @@ -23,3 +23,7 @@ &sound {
> > >   &ts_10 {
> > >       status =3D "okay";
> > >   };
> > > +
> > > +&watchdog {
> > > +     /delete-property/ mediatek,disable-extrst;
> > > +};
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts=
 b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> > > index 2586c32ce6e6f..2fe20e0dad836 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> > > @@ -43,3 +43,7 @@ &sound {
> > >   &ts_10 {
> > >       status =3D "okay";
> > >   };
> > > +
> > > +&watchdog {
> > > +     /delete-property/ mediatek,disable-extrst;
> > > +};
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts=
 b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> > > index f54f9477b99da..dd294ca98194c 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> > > @@ -44,3 +44,7 @@ &sound {
> > >   &ts_10 {
> > >       status =3D "okay";
> > >   };
> > > +
> > > +&watchdog {
> > > +     /delete-property/ mediatek,disable-extrst;
> > > +};
> > >
> > > ---
> > > base-commit: 64b50fcb03649ca7f0d762a50e7a3484cfc1d586
> > > change-id: 20230818-send-upstream-e91e615a893c
> > >
> > > Best regards,
> >

