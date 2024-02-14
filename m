Return-Path: <linux-kernel+bounces-66033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E48555A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4231C1F23BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDC61419A9;
	Wed, 14 Feb 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5S7unmQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986413B7BB;
	Wed, 14 Feb 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949091; cv=none; b=t9lHldG9Vxse638AIVNWdtUdhEWL81fSxpJBVumofXRmdTSgziUV/ZRHFoff3DaigRbrZ21KrpQu76BTVUZ1Y9eOYKsmQ7EoVzN68HOKHIbWaEy6QcupFb+v1tUg7fmULrtoIdzJIEzBl7C6+Ndu4r7RaEflV5ku1R8Bv6m7KOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949091; c=relaxed/simple;
	bh=Sd3LHiIC/HJ8oQfgv8x2Xjbdlj3ryLnafieXwXO0BMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odAjyL0yjoVc5ERXotDYAfEkCWrSBfZxQdEXDpUB1VOtmBBwsRsXEmIu1iZ3INTaY6Q0ZYTTOzhWocQSaoWgU09n3LJnuYfi5F5qpZZhEhI8Y7Ms2ybnaiWQcCFLSztc6jKUkqyjViEYBnZ2W76eqVUjuEejg/noUU5WtP1xqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5S7unmQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d090c83d45so2443711fa.3;
        Wed, 14 Feb 2024 14:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707949087; x=1708553887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H64vWKrMscP+UtU2SdNH5gXCgsbTGntQcLU1ahmajlM=;
        b=e5S7unmQAITFlpZ4RZlDClR9qnmpuFqG5/tghXl9aYj18Y+ZVNA69VnATi26TpO9vs
         vsqbLlYn4zWGAHt6ahu0d922wI4ubgk82jZG7Mzo26b6+vYC8vjktNe0iP97P+mCjTAK
         j5EQAS/ooYAVFNe9QFNGYDH02hmXkKVMxGQDDIgKC4VSC7klq2s9KD0vh/vMm8jO4RI6
         z40mHTkFYVFxWPsfXyrkrnU8XiEjYL6CAGrhIKhZaxy6Yyf7UhOvrDQtQ9LRFWnRTgpe
         CkYNBLSmbRY8YNE0Q0Urs2cz2JIPGaTKX53kDcwxvHc7pC2ug1zNyhOQR5rovAvFFdoe
         Je7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707949087; x=1708553887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H64vWKrMscP+UtU2SdNH5gXCgsbTGntQcLU1ahmajlM=;
        b=IhZfOrNg9bJljwC4mj9lBsSGI8af2H8sVcY5lonFcUKraPIYvMWl5YnqxmFY4D3Gb6
         5xJ8ucgmgAVe2V3kQJ7KVNhzRzmw7V8lPG5kl6oTvwu9gQYuI4wlkGqyblc9d5pCARCv
         QJoBNTY5Gh+r15Suc6a1W29CPykcVc1kuNpLoOpNT8kwponWHjp1jGJb4k9t3B2oii6/
         /Co4T0KleCZLXR9p6wQmRKDz7QJDRtV5t8qhGaEA/UYm8WRTcVZdj78YXNgXg3JBuylz
         t38dB5g1YFnEJF+xI7WSqu4lgAqBsGTuT8K9E8IVmtJfjN5tWDF4YbatKWf+JLfP8DMW
         YcZw==
X-Forwarded-Encrypted: i=1; AJvYcCV2DI23ObioxixFqSlCbBt0gLVtASuSkwWrZNMQwS3dVOLHO1PhZ3kBU8EnjMUAR4tJIABIxO9y6k12mTAcIBnh9kityN+d+OB4VJ+d2YbEP1Ua5TkI2cXjBGvEipxypbMmaR/GO42sVz91h5aj9Jr0qiEcngLTNGoWMspM32FUJw==
X-Gm-Message-State: AOJu0Yyv22gKaOPImQLeFuyOtLf32UgaVBMrsBBRbAvh9XDo9ZYhxmLR
	MaTc5qY93n3ZLe+Rhy5aP1w7zWHIaLDmV8QWxzmW2KTBNbCaDbbOGalij3wIHorRzgr+OS/54nR
	Og1A+BTlCiWUsVXhL2Q0cIx3zkL0=
X-Google-Smtp-Source: AGHT+IFQIRkjDKKh52f3N53ULv5NQX4VDybjFiEKg7Wa8QdAp/w3/BrWTCQUd+VlDE8Yc0CacNPfriQZpDwuZPWLPoE=
X-Received: by 2002:a2e:870f:0:b0:2d1:188b:c3fb with SMTP id
 m15-20020a2e870f000000b002d1188bc3fbmr21382lji.34.1707949087077; Wed, 14 Feb
 2024 14:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
 <20240213-realtek-reset-v3-3-37837e574713@gmail.com> <CACRpkdZELbOmZieZTDLfA81VuThM7h399BWtuQuQ6U7o8Xb7LA@mail.gmail.com>
In-Reply-To: <CACRpkdZELbOmZieZTDLfA81VuThM7h399BWtuQuQ6U7o8Xb7LA@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 14 Feb 2024 19:17:55 -0300
Message-ID: <CAJq09z4wgPo=1_OtA6Y-0O4gLJ2nxy1jdf0BDoZwVmL=TkOdUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: dsa: realtek: support reset controller
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi Luiz,

Hi Linus,

> thanks for your patch!

I'm glad to help ;-)

> On Wed, Feb 14, 2024 at 1:54=E2=80=AFAM Luiz Angelo Daros de Luca
> <luizluca@gmail.com> wrote:
>
> > The 'reset-gpios' will not work when the switch reset is controlled by =
a
> > reset controller.
> >
> > Although the reset is optional and the driver performs a soft reset
> > during setup, if the initial reset state was asserted, the driver will
> > not detect it.
> >
> > The reset controller will take precedence over the reset GPIO.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> (...)
> > +void rtl83xx_reset_assert(struct realtek_priv *priv)
> > +{
> > +       int ret;
> > +
> > +       if (priv->reset_ctl) {
> > +               ret =3D reset_control_assert(priv->reset_ctl);
>
> Actually, reset_control_assert() is NULL-tolerand (as well as the
> stubs) so you can just issue this unconditionally. If priv->reset_ctl
> is NULL it will just return 0.

The idea was to avoid gpiod_set_value if the reset_control_assert was
configured and worked. However, I don't see a big issue in calling
them both as you don't expect both to be configured.
I'll remove the "ifs not null" and let both be called.

>
> > +               if (!ret)
> > +                       return;
> > +
> > +               dev_warn(priv->dev,
> > +                        "Failed to assert the switch reset control: %p=
e\n",
> > +                        ERR_PTR(ret));
> > +       }
> > +
> > +       if (priv->reset)
> > +               gpiod_set_value(priv->reset, true);
>
> Same here! Also NULL-tolerant. You do not need to check priv->reset.
> Just issue it.
>
> > +void rtl83xx_reset_deassert(struct realtek_priv *priv)
>
> Same comments for deassert.
>
> With this fixed (the rest looks just fine):
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

