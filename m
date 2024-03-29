Return-Path: <linux-kernel+bounces-123911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A98890FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9043F28B794
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE48849C;
	Fri, 29 Mar 2024 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyplVMX1"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84774136A;
	Fri, 29 Mar 2024 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672420; cv=none; b=J+6ZpqfcjcWLogTSogSSy9Mhe+SQ9pD8GTErz2O6JgqygoDdQt9rwYUwZboxMsuKlLSmBHnp3kNkVtpw2OuX3WKWdkxVFf/sqhAbwaXZbwi6s/gZYitIAbFRsM2hL+2ivhXI58No7B58MQ43eGOQPaIU6n5WVMOPwR5RP9JwxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672420; c=relaxed/simple;
	bh=zdW4OzBGiHdghHfsfUWq4VMgt7AhGx7LNJ/CBPGzJZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b48Jmwqdjz4dVm8gc2o1Nb9gDypbCIXJ2ZRpO4KthwivNEABTEyk3nAQRqwGBAu2McQTJ239lsGbCRxPPe787uzNK2MCoCpxRzOdYc7Mowg1a7DNN6WSNSbUDYFEvFJfTbXsMxvmoMyyXUvExqik4MYk8iAc/Hrr7yw3LzQACos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyplVMX1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1548969276.1;
        Thu, 28 Mar 2024 17:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672417; x=1712277217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O4on0KtY0EgM1VXwE3jwVWaHfU+h1EzXjOkdtAGd+Y=;
        b=TyplVMX1BZRXP8e+FvDL7F0Z+MM7AZ8W7TQCvgSU7T+0xsfEpHhWt2mRamEHFu/Z8G
         5zAgNk06b++LrNSFwlRfJc2U7+ZQ2T3eq+mva/TNwdwpebsRVA0Lr+mp8EkPpdavkmV5
         F15xvpZ7tYu1LlpyHmibbNcMa55NB5ZTU4RHntNSlLTXVEYhZZDwLBNxudscDQwiDJOU
         2V2TZLvgINRJAct3i7jkOLpejziklF+cAlmSRaaYuQqbbKahQ98UCvP6D7fQXxJo4raE
         6TT1yXO+I+KCJPB5xnbP/Js1yFsRluPYDVWtoDolF5kRZUFhBIJkQ12CTPgot2D+HRQu
         zW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672417; x=1712277217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O4on0KtY0EgM1VXwE3jwVWaHfU+h1EzXjOkdtAGd+Y=;
        b=s0RLQn3DK8mW4RTAo1FpWwMie6Isx6M4+O05bqWmsMir+3WymcIpqCdUxI14ypbOAt
         tp/HUr2+aIOSgYkUTOorKRGPOS/HfeMtpSeKsGaKGhOqwAzH0a+hpR3JMTlQp+hCN+YC
         YpvskC+WXukusEY0stqoj50mxWbc1MAkYeTxQkIVe1s8SyGi9hn55DfWhnmaxKHOnaB5
         RbI6R0B53+uApMaD/G9E/HqXcXn1t/Hk3VDcFxmIk71LSJKioMwycWOEqYGT47UJgs0w
         wa+PAF3qt61RU42BRo8R1iCkYiQpzb7f0zBR4Y4cNVaY11IqNbD8IHWoBFH+LWPrrldF
         cB6g==
X-Forwarded-Encrypted: i=1; AJvYcCWCUy7QnJrCZgRK0hIAukuu5b7IT4BjLR3IgpwP6142B58KImi8cgxKQjBD1gXxjE/1x+FMWcGPb8ibaLpslEopHFwSOrdVxYrg+kRyCK3yWuzRQqNr5McBTzmosWkoNhByIWSgqlW8UKGGTOeAxfURZGF9AGUHVK6pTRqtwWU7SH5Nkw==
X-Gm-Message-State: AOJu0YzoVd0pxBJKDhAguR6BLSw4EzpArV7Jh2EFOqQBx3VjLW5nl0A1
	BHMB0tUXaAVz0SXq8p5zvdjkzI0Y1Aa18bEAYprP89jDYgA1a+CesBtmtziq1A4fkLLzh7ThqFW
	Xrgc972mT5zWC2bU9cLS75AtKjmY=
X-Google-Smtp-Source: AGHT+IE0CbG2DH8bUa0K6gLjdOUJNUbFSSoMPTbY2sNxPb6Mq8SrlJG9P6OChf6FMljeVE741/D0+UZw925LsWoqVOo=
X-Received: by 2002:a25:3307:0:b0:dd1:64e6:2c80 with SMTP id
 z7-20020a253307000000b00dd164e62c80mr915934ybz.46.1711672417400; Thu, 28 Mar
 2024 17:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327220320.15509-1-l.rubusch@gmail.com> <20240327220320.15509-8-l.rubusch@gmail.com>
 <20240328133927.7e49f3bf@jic23-huawei>
In-Reply-To: <20240328133927.7e49f3bf@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 29 Mar 2024 01:33:01 +0100
Message-ID: <CAFXKEHZva5AE=sinx_i0Gec2FbB4ZfyEu8mWg52omzGBvr5uXw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 27 Mar 2024 22:03:20 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add a setup function implementation to the spi module to enable spi-3wi=
re
> > as option when specified in the device-tree.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h     |  2 ++
> >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index 4ea9341d4..e6bc3591c 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -30,6 +30,8 @@
> >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> >  #define ADXL345_POWER_CTL_STANDBY    0x00
> >
> > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6) /* 3-wire SPI mode=
 */
> > +
> >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set the g range =
*/
> >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justified (MSB) mo=
de */
> >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits resolutio=
n */
> > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl34=
5_spi.c
> > index 1c0513bd3..f145d5c1d 100644
> > --- a/drivers/iio/accel/adxl345_spi.c
> > +++ b/drivers/iio/accel/adxl345_spi.c
> > @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_regmap=
_config =3D {
> >       .read_flag_mask =3D BIT(7) | BIT(6),
> >  };
> >
> > +static int adxl345_spi_setup(struct device *dev, struct regmap *regmap=
)
> > +{
> > +     struct spi_device *spi =3D container_of(dev, struct spi_device, d=
ev);
> > +
> > +     if (spi->mode & SPI_3WIRE)
> > +             return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> > +                                 ADXL345_DATA_FORMAT_SPI_3WIRE);
> Your earlier patch carefully (I think) left one or two fields alone, then
> this write just comes in and changes them. In particular INT_INVERT.
>
Why do you refer here to INT_INVERT? In this code above I try to set
SPI to 3 lines. Since this is a SPI configuration, i.e. bus specific,
it happens in adxl345_spi.c. Passing this function to the bus
independent adxl345_core.c file allows to configure the bus first.
Therefore, I'm using the update function in core masking out the SPI
filag.

My reason why I try to keep INT_INVERT out is different. There is
another driver for the same part in the kernel:
/drivers/input/misc/adxl34x.c - This is a input driver, using the
interrupts of the adxl345 for the input device implementation. I
assumed, that in the iio implementation there won't be interrupt
handling for the adx345, since it is not an input device. Does this
make sense?

> If it doesn't makes sense to write it there, either write that bit
> every time here, or leave it alone every time.  Not decide on whether
> to write the bit based on SPI_3WIRE or not.  As far as I know they
> are unconnected features.
>
I think I did not understand. Could you please specify a bit more?
When spi-3wire is configured in the DT it has to be parsed and handled
in the bus specific part, i.e. the adxl345_spi.c Therefore I configure
SPI_3WIRE there. I don't want to place SPI specific code in the core
file.

> > +     return 0;
> > +}
> > +
> >  static int adxl345_spi_probe(struct spi_device *spi)
> >  {
> >       struct regmap *regmap;
> > @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
> >       if (IS_ERR(regmap))
> >               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error i=
nitializing regmap\n");
> >
> > -     return adxl345_core_probe(&spi->dev, regmap, NULL);
> > +     return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
> >  }
> >
> >  static const struct adxl345_chip_info adxl345_spi_info =3D {
>

