Return-Path: <linux-kernel+bounces-64853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B08543BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB61283789
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CECC125A6;
	Wed, 14 Feb 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eN1yfqrB"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BF11729
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897858; cv=none; b=hDiHBzjsPU1siK2wmFD1Twwyig/4lUHBIZ+i9+njycvZ5jySWqeUlginINEwgxc0C1t4Psik5jnbHvdTGdrwegKXNueAfIrhroA4eHVfi14dJKNsDQkTNPrTHKs1HcE556S9YJwD9mHpQSVMuWF04vm5a2LX5qj3XUYhqopEgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897858; c=relaxed/simple;
	bh=oGgic3vnUOjdVhRrwzAue5deTTVv+g8YkD46l440lI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJT00kdwuzswV67STvmDj2VLtp7E4PTSqzj9hmNWKwauJ5t1/EwsDz1y/56YkFEm6W9yhTy/T1uHqRXzSmzrOQTPF2GrcIYjt0yDIiizHlA9iuTlpyCRKRBmDko3VMP3pNxl6U/pn6a7BoUfrp6ALuHrFcvysnif0+7pymMcw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eN1yfqrB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6077d2b3bb1so13503797b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707897856; x=1708502656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCIHkt/RO66tMjTR/JKRcfY+u5vjPPcFqKDnWCtMpJI=;
        b=eN1yfqrBGkE4eybV6rdhh/QZGxaulnTO8S+ZrGaNKFqJpku5EOsmsDG+CMWhQt2DrT
         09vaPeWqFHl6PZcA2yG+QqOafhDFuaza5pV16Pushf0qDvmwvugyDgPfdSwvHY64bpbm
         20AeQL1bmt7G7VtHYoynYn6CYx9XhTUU5XzYUsB2BnLWohr/2mCs2GeRrUjVolXdZlv2
         MNgF9nCFmLyidfuRQXzscYkwgPWlYT5HXNCCuxXWnFrWNzFy3wAlySTZRglIp6Q0avw1
         GlfDxePCtbFcqGFGgXTcC8bazJCZtFC7xC466uJlz2dZlJH3r9onRnXDIw2xCkQ7OSHA
         2rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707897856; x=1708502656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCIHkt/RO66tMjTR/JKRcfY+u5vjPPcFqKDnWCtMpJI=;
        b=eku3dNNR839TqvIyJRcSGxnlXlePK5H+Nwz0vdPXYYX9/o3/vz4GKWlAxdMREmR5VV
         pgYUtOLSBt9msi2E4w4CPRrAxAFKndAtX8Zqyv6/tCoaNQidpApecX1hQ1Jg58rkCs5V
         YHFKUIsW6LUzmE4L4d93p/ekPb58C5kNx8Rbml1X9ugW3vyhJD+xf3sb1Qk+yMbfGdr/
         vH8gkTQogJ5aXNm3UV8RjBYSHeeD3WrFycs3du4hWfFn6gr80D5gxVEJE3zZ5DcR0RTX
         Nsf0dYCV+f7zvL7Ot2jgSr5NWrhXIJjiHdf2ioIamTznYF4i3Gu7JcfBWpiws0K1xSl4
         wtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjlTQMZk8ErAESEtG5kQ4ZVwzfJsYXftzze42LOkmlj6pxRDT8LQbijxCeAJGQSzmBVHMCi+5qJmaeNSz/+ETW/62LdA3KufIVO6HH
X-Gm-Message-State: AOJu0YyjHaDrtUF005SiSxxyS5hfcRUnSyoz6dHU1i+Bp0NsgV1P54bU
	kTeCnUVen3D8HqwxP3D26uqhUFX6LD25ZAKZFpRep6q9/8Ghz3tjTqQW5XmlVl8H6oXPLvcZVtz
	ei3rkOrP1RyYmd3oJDSkA3UxYAgfLyPExzfuNtA==
X-Google-Smtp-Source: AGHT+IGzNRpLA81W0hjnC7KJeTUQCzfe+celuZG951rB1y0PAGLvDF844F01g8batoU5C7Yy62cr58AJowvdFleB/Lk=
X-Received: by 2002:a25:c786:0:b0:dcd:3663:b5e5 with SMTP id
 w128-20020a25c786000000b00dcd3663b5e5mr1852459ybe.25.1707897855760; Wed, 14
 Feb 2024 00:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com> <20240213-realtek-reset-v3-3-37837e574713@gmail.com>
In-Reply-To: <20240213-realtek-reset-v3-3-37837e574713@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 09:04:03 +0100
Message-ID: <CACRpkdZELbOmZieZTDLfA81VuThM7h399BWtuQuQ6U7o8Xb7LA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: dsa: realtek: support reset controller
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
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

Hi Luiz,

thanks for your patch!

On Wed, Feb 14, 2024 at 1:54=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The 'reset-gpios' will not work when the switch reset is controlled by a
> reset controller.
>
> Although the reset is optional and the driver performs a soft reset
> during setup, if the initial reset state was asserted, the driver will
> not detect it.
>
> The reset controller will take precedence over the reset GPIO.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
(...)
> +void rtl83xx_reset_assert(struct realtek_priv *priv)
> +{
> +       int ret;
> +
> +       if (priv->reset_ctl) {
> +               ret =3D reset_control_assert(priv->reset_ctl);

Actually, reset_control_assert() is NULL-tolerand (as well as the
stubs) so you can just issue this unconditionally. If priv->reset_ctl
is NULL it will just return 0.

> +               if (!ret)
> +                       return;
> +
> +               dev_warn(priv->dev,
> +                        "Failed to assert the switch reset control: %pe\=
n",
> +                        ERR_PTR(ret));
> +       }
> +
> +       if (priv->reset)
> +               gpiod_set_value(priv->reset, true);

Same here! Also NULL-tolerant. You do not need to check priv->reset.
Just issue it.

> +void rtl83xx_reset_deassert(struct realtek_priv *priv)

Same comments for deassert.

With this fixed (the rest looks just fine):
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

