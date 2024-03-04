Return-Path: <linux-kernel+bounces-90732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13287041F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A424528962E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A040BF0;
	Mon,  4 Mar 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kFoPDBUl"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F33FB8B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562548; cv=none; b=q0OuXn8+cSiAlluWWbOjeBZfpQWpZ6gabgHED6ZonOrWUiBSczUF5ddai0L6jmuM9EeFM765pTarSb4OVP+V+XylS5ynArj6XeHk/AvD7etNczlsY4Vd3COtv3MYeTfq5jumiV6gL7OontY6Dt9C2lrbBQo4GPGTweF11x9nIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562548; c=relaxed/simple;
	bh=gV/b+qA5KVEGKiKWm/zfGRZwkWT8RLOeLLQr/iVoN4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqYdGBRzbjIWlgjpz1zbw5uRjqA1hm1EH6hNRmxvQwh+GsBmyWP+liprX1qdq/LYokzWdnCVznD194/iv2473Gs/Vm7Mits49+qkPyjPt5Jpc3INDRFOQVaVf9kxm+BzwrhwYzMwmELXMvqpGcE4h8+Pa7pVFykUnqb7VelRMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kFoPDBUl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2509c66daso57011611fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 06:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709562544; x=1710167344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iaw5xhUG4Aj8G7CnWQRBmfpPKQL5MFpdOIILwmIvtEw=;
        b=kFoPDBUlStaUeMB2xlid/1AGUvPTBnljuysDn70fcfOcor9UQ10+NwwzsCBqkiEPgC
         xRSaAMiQEdK3F7hqn+hC5QqGL790g57UEvO2RUn8zdze74ZHh7tpBk6iDVdTqbVTLpb1
         /+cklCGMrqCCOQB/rDDAASlP0AUTGn6SEal9eJct6e1ml8wAuVhlXatio8vAqAVsIH/s
         fxURxBbjM+Q61OWZk1OqFG4tpbYtRZeR17dGcIXaL4kd8sGMi4Ett1cfcmzlT/OyeL7k
         /VnUhUOztptONtr/HbysQ2U6PNqyA4+yp5Inl9//svwofu8iAeYw3agIJhLj7V9ZkkZt
         QzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709562544; x=1710167344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iaw5xhUG4Aj8G7CnWQRBmfpPKQL5MFpdOIILwmIvtEw=;
        b=COpf/ZiOi691a8JgCRCQ/z9f5vO7SepcBDOdsyo1IW4OW8alJNsNfz58xc3p0Tr4sT
         Xyej39A0OGEvEkxAysB3SntJj82QMH+MSpmwtmwFUC/kV35zS4g3sjM7gBlENOKm9ygK
         oTTJ9xVHVkcwsMpctrVAE5nR2jqlSbvox+RyMW26Z/F0uYkQmpz5AMa8jBkqOyjUvAO4
         lqMfw0BNwIDuFflw37kB/euYw2zAmD1FmQbf+WJxt4ZbsdAlM4ldsoovTH+m0an4EiFh
         L4G1qJ+atZ6pdp9kwj8pVK3wry7dvVkpuTR12o/+jyeuUMWJ1wxvrSZajI8lmGE72SG+
         qFZw==
X-Forwarded-Encrypted: i=1; AJvYcCX+LrmyNUVWD1NQ4EWms9ufTClNmXGWM4J6GrRxXRDuZEJXS7sMGZyXqOsBy9eLTBrM9g6D4uZxDN1O+mcMam4F/zt6e8s+gUeUQmEU
X-Gm-Message-State: AOJu0YxodIWKEbBnQS7mJqfZY4OiOhx3+ghKENQbE3zwxE38Osa2t2/t
	kWgLPWmwdynpbGwiA0HBATAascIksRcl4apMRqicqlMo4SP7MSz3uk90CSSTVWcBlTXxplOHZON
	dU1UDM4foq4xlyffFsKczVrb8OjVSGAwqP1m8ZA==
X-Google-Smtp-Source: AGHT+IET7LODBdoZNl+GGg65TD4CtUdpf8gj/b7Xj+UvmWcUszyvhkn6G1kvOct99i5iNOQW5nXdw88nUSu6bY5Z35g=
X-Received: by 2002:a05:651c:1501:b0:2d3:74ce:38cd with SMTP id
 e1-20020a05651c150100b002d374ce38cdmr4513415ljf.51.1709562543894; Mon, 04 Mar
 2024 06:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-ad7944-mainline-v4-0-f88b5ec4baed@baylibre.com>
 <20240229-ad7944-mainline-v4-2-f88b5ec4baed@baylibre.com> <20240303134359.16d5e5f1@jic23-huawei>
In-Reply-To: <20240303134359.16d5e5f1@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 4 Mar 2024 08:28:52 -0600
Message-ID: <CAMknhBGYd8v=t-LB7PEz3OzFRKfVXhw=4Tm7RBKbxSoi_QWh-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 7:44=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 29 Feb 2024 10:25:51 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> > AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> > at rates up to 2.5 MSPS.
> >
> > The initial driver adds support for sampling at lower rates using the
> > usual IIO triggered buffer and can handle all 3 possible reference
> > voltage configurations.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> >
> Hi David,
>
> Fresh read through showed up a few more things.  They are all trivial exc=
ept
> for what I think is an inverted error condition which would break
> cases where ref was not supplied in DT.

Thanks. All suggestions seems reasonable to me.

> >
> > +
> > +     /*
> > +      * Sort out what is being used for the reference voltage. Options=
 are:
> > +      * - internal reference: neither REF or REFIN is connected
> > +      * - internal reference with external buffer: REF not connected, =
REFIN
> > +      *   is connected
> > +      * - external reference: REF is connected, REFIN is not connected
> > +      */
> > +
> > +     ref =3D devm_regulator_get_optional(&spi->dev, "ref");
> > +     if (IS_ERR(ref)) {
> > +             if (PTR_ERR(ref) !=3D -ENODEV)
>
> Confused. Isn't this inverse of what we want?

Yes, thanks for catching.

> return an error if we got anything other than -ENODEV.
>                 if (PTR_ERR(ref) |=3D -ENODEV)
>                         return dev_err_probe(&spi->dev, PTR_ERR(ref),
>                                              "failed to get REF supply\n"=
);
>                 ref =3D NULL;
>         }
>
> > +                     ref =3D NULL;
> > +             else
> > +                     return dev_err_probe(&spi->dev, PTR_ERR(ref),
> > +                                          "failed to get REF supply\n"=
);
> > +     }
> > +
>
> > +
> > +     adc->cnv =3D devm_gpiod_get(&spi->dev, "cnv", GPIOD_OUT_LOW);
> > +     if (IS_ERR(adc->cnv))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(adc->cnv),
> > +                                  "failed to get CNV GPIO\n");
>
> Is this optional?  If we don't yet support the case the dt binding talks
> about worth a comment here to say we don't yet support XYZ so this
> is not optional.

For now, it is required since we have only implemented 4-wire mode.

