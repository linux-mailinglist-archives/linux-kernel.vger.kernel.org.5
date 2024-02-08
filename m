Return-Path: <linux-kernel+bounces-58788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16E784EBB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229671C233CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE34F88F;
	Thu,  8 Feb 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pqwo9RHM"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7974F885
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707431243; cv=none; b=aROIoYo7tQyzso4AglYC7wWHavR01DCUd9Pux6Uu350h4d08YWWGjn7sN9hFIXtu0GGRHKYFBBNaHsNYo2gaSXNaiNo4fAfjrfNETm+Yuru7/lFq7PHEI8P9o8T3xdaC+zO07Prqdn4Pja3GYdfv0DgmSHAwE5uw5hUIbSYiinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707431243; c=relaxed/simple;
	bh=3KTBafBsAg2zYzerUAdOI3XNSZZv2cFNbMjrcv50Zu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ew2e0kYVN/9rErarxslwEwf+T7P0ZEX7qPK14udA3rJtGwItcgL7Wlvcad6wG7bkJXl2ZRwhoLXpEZ01nqgcWo4qLWDSAKkbcBmeviwXmSD4cZjEWvH4FrhB/lyFrrbDNAOQqqJhA3brmS/+G49GOeOCy0KRMNu+hgWoohvFudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pqwo9RHM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so4629061fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 14:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707431238; x=1708036038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRcHJqFRKqCO3zrCpX/zFhJEA7trRAQAUkuZ3JCJS04=;
        b=Pqwo9RHMl0KOMxI2kvC9sjcnHJEOSixuzVqv4HFUTC0fu+MgP4NPKuUVlcb11z6hhe
         HYSCAs1cyhFXXOjqKL6QSq3J8KU4CLjdMNlLNqcHEG4xANpjpO3WGnbG1BfBX2btH5eP
         9Xv2ePOzFb5i6WFQQYZ7v5KOGQptndQ+tUPrhneWrPCxWUyIC7Awev0P3Thglmjafi9b
         RTckiMFOzz8K4GyIPkk+QjFOHsd2OgBxLCQ7myk1UcG2d9ErTKOWQtitJQuuHNYBj9JX
         +2kOiD3/7LWFDw3pBJ3saCTezR5yv4wZ148RDmPu5kSM7iDwzdAkkYbrmaLXg897dXp1
         z2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707431238; x=1708036038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRcHJqFRKqCO3zrCpX/zFhJEA7trRAQAUkuZ3JCJS04=;
        b=oDQbaWpahP9cHb6imjJp3YYnnvtn1kMxKW+Y82/B82Y3eXLB0kcV3TbEeYHKrs9bq6
         DKLY41pXoJCJx/jlSwWit7Y1qdlNGumMCvE/DxipBroeRQXb/1ngmchTh01gqzthIZ+F
         TIgjdmDymrPVZb9MT3pvoONyCD63KlfLdG/aSzXUx3ml6PUQcFb6e4tyH/eD0XcwCuAU
         ux2VScrk+1MupVvrKLmU78k2aRFVyEnvJZgOBy5/G6nOqGKttADRkQfhP0MFBGsH/VNt
         ubNK+dOdW9kghbODn5wTpvhg+wFFvm7huKQhbGLENiGd6gczfwWzXWvQTvH/D4bTJsFm
         VkKA==
X-Gm-Message-State: AOJu0YzEHKswwwBhV9Ts6YONCdiGYcUGzknpdmhUUzS6uUyJeaYrahvu
	UhaqsysXfsbmmU7sFLz7J5+SonEJpPS9xWzEDARnYE215r4pgBUCFyr2JDmjH0rPxXWblGMjX72
	cI5NAys9mioBu6zUc593QeDtDwGvNBmXiD4/J+g==
X-Google-Smtp-Source: AGHT+IEAYKcRTJlZG05NMlwgiMeKV9Q1FZxLhv+UUiRRAzP3DCL5m6lwOFaD2fYdwpSy7UU7sur9wQH+afMoGqMDn0U=
X-Received: by 2002:a2e:9302:0:b0:2d0:d967:b12a with SMTP id
 e2-20020a2e9302000000b002d0d967b12amr467206ljh.51.1707431238273; Thu, 08 Feb
 2024 14:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208172459.280189-1-alisa.roman@analog.com> <20240208172459.280189-6-alisa.roman@analog.com>
In-Reply-To: <20240208172459.280189-6-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 8 Feb 2024 16:27:07 -0600
Message-ID: <CAMknhBHU6k8J_PLCmGYF48S1q3uXByiCwzcd+B3q3Cd-02CUow@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, robh+dt@kernel.org, 
	Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:25=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
>
> The default configuration is hardcoded in order to have a stable number
> of channels.
>
> Also modify config AD7192 description for better scaling.
>
> Moved ad7192_chip_info struct definition to allow use of callback
> function parse_channels().
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |  11 ++-
>  drivers/iio/adc/ad7192.c | 150 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 148 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 59ae1d17b50d..8062a4d1cbe7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -71,12 +71,17 @@ config AD7124
>           called ad7124.
>
>  config AD7192
> -       tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
> +       tristate "Analog Devices AD7192 and similar ADC driver"
>         depends on SPI
>         select AD_SIGMA_DELTA
>         help
> -         Say yes here to build support for Analog Devices AD7190,
> -         AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC)=
.
> +         Say yes here to build support for Analog Devices SPI analog to =
digital
> +         converters (ADC):
> +         - AD7190
> +         - AD7192
> +         - AD7193
> +         - AD7194
> +         - AD7195
>           If unsure, say N (but it's safe to say "Y").
>
>           To compile this driver as a module, choose M here: the
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d8393ac048e7..a3ff60ed6f63 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
> + * AD7192 and similar SPI ADC driver
>   *
>   * Copyright 2011-2015 Analog Devices Inc.
>   */
> @@ -125,10 +125,39 @@
>  #define AD7193_CH_AIN8         0x480 /* AIN7 - AINCOM */
>  #define AD7193_CH_AINCOM       0x600 /* AINCOM - AINCOM */
>
> +#define AD7194_CH_TEMP         0x100 /* Temp sensor */
> +#define AD7194_CH_AIN1         0x400 /* AIN1 - AINCOM */
> +#define AD7194_CH_AIN2         0x410 /* AIN2 - AINCOM */
> +#define AD7194_CH_AIN3         0x420 /* AIN3 - AINCOM */
> +#define AD7194_CH_AIN4         0x430 /* AIN4 - AINCOM */
> +#define AD7194_CH_AIN5         0x440 /* AIN5 - AINCOM */
> +#define AD7194_CH_AIN6         0x450 /* AIN6 - AINCOM */
> +#define AD7194_CH_AIN7         0x460 /* AIN7 - AINCOM */
> +#define AD7194_CH_AIN8         0x470 /* AIN8 - AINCOM */
> +#define AD7194_CH_AIN9         0x480 /* AIN9 - AINCOM */
> +#define AD7194_CH_AIN10                0x490 /* AIN10 - AINCOM */
> +#define AD7194_CH_AIN11                0x4A0 /* AIN11 - AINCOM */
> +#define AD7194_CH_AIN12                0x4B0 /* AIN12 - AINCOM */
> +#define AD7194_CH_AIN13                0x4C0 /* AIN13 - AINCOM */
> +#define AD7194_CH_AIN14                0x4D0 /* AIN14 - AINCOM */
> +#define AD7194_CH_AIN15                0x4E0 /* AIN15 - AINCOM */
> +#define AD7194_CH_AIN16                0x4F0 /* AIN16 - AINCOM */
> +#define AD7194_CH_POS_MASK     GENMASK(7, 4)
> +#define AD7194_CH_POS(x)       FIELD_PREP(AD7194_CH_POS_MASK, (x))

AD7194_CH_POS_MASK isn't used elsewhere, so maybe just this?

#define AD7194_CH_POS(x)       FIELD_PREP(GENMASK(7, 4), (x))

> +#define AD7194_CH_NEG_MASK     GENMASK(3, 0)
> +#define AD7194_CH_NEG(x)       FIELD_PREP(AD7194_CH_NEG_MASK, (x))
> +#define AD7194_CH_DIFF(pos, neg) \
> +               (AD7194_CH_POS(pos) | AD7194_CH_NEG(neg))

You could also add `((neg) =3D=3D 0 ? BIT(10) : 0) | ...` and then use
this macro to define AD7194_CH_AINx.

#define AD7194_CH_AIN1    AD7194_CH_DIFF(1, 0)

> +#define AD7194_CH_DIFF_START   0
> +#define AD7194_CH_DIFF_NR      8
> +#define AD7194_CH_AIN_START    1
> +#define AD7194_CH_AIN_NR       16
> +
>  /* ID Register Bit Designations (AD7192_REG_ID) */
>  #define CHIPID_AD7190          0x4
>  #define CHIPID_AD7192          0x0
>  #define CHIPID_AD7193          0x2
> +#define CHIPID_AD7194          0x3
>  #define CHIPID_AD7195          0x6
>  #define AD7192_ID_MASK         GENMASK(3, 0)
>
> @@ -166,17 +195,10 @@ enum {
>         ID_AD7190,
>         ID_AD7192,
>         ID_AD7193,
> +       ID_AD7194,
>         ID_AD7195,
>  };
>
> -struct ad7192_chip_info {
> -       unsigned int                    chip_id;
> -       const char                      *name;
> -       const struct iio_chan_spec      *channels;
> -       u8                              num_channels;
> -       const struct iio_info           *info;
> -};
> -
>  struct ad7192_state {
>         const struct ad7192_chip_info   *chip_info;
>         struct regulator                *avdd;
> @@ -197,6 +219,15 @@ struct ad7192_state {
>         struct ad_sigma_delta           sd;
>  };
>
> +struct ad7192_chip_info {
> +       unsigned int                    chip_id;
> +       const char                      *name;
> +       const struct iio_chan_spec      *channels;
> +       u8                              num_channels;
> +       const struct iio_info           *info;
> +       int (*parse_channels)(struct ad7192_state *st);
> +};
> +
>  static const char * const ad7192_syscalib_modes[] =3D {
>         [AD7192_SYSCALIB_ZERO_SCALE] =3D "zero_scale",
>         [AD7192_SYSCALIB_FULL_SCALE] =3D "full_scale",
> @@ -918,6 +949,15 @@ static const struct iio_info ad7192_info =3D {
>         .update_scan_mode =3D ad7192_update_scan_mode,
>  };
>
> +static const struct iio_info ad7194_info =3D {
> +       .read_raw =3D ad7192_read_raw,
> +       .write_raw =3D ad7192_write_raw,
> +       .write_raw_get_fmt =3D ad7192_write_raw_get_fmt,
> +       .read_avail =3D ad7192_read_avail,
> +       .validate_trigger =3D ad_sd_validate_trigger,
> +       .update_scan_mode =3D ad7192_update_scan_mode,
> +};

Isn't this identical to ad7192_info and ad7195_info now that .attrs is
removed? It seems like we could consolidate here.

> +
>  static const struct iio_info ad7195_info =3D {
>         .read_raw =3D ad7192_read_raw,
>         .write_raw =3D ad7192_write_raw,
> @@ -1009,6 +1049,80 @@ static const struct iio_chan_spec ad7193_channels[=
] =3D {
>         IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>
> +static struct iio_chan_spec ad7194_channels[] =3D {
> +       AD7193_DIFF_CHANNEL(0, 1, 2, 0x001),
> +       AD7193_DIFF_CHANNEL(1, 3, 4, 0x023),
> +       AD7193_DIFF_CHANNEL(2, 5, 6, 0x045),
> +       AD7193_DIFF_CHANNEL(3, 7, 8, 0x067),
> +       AD7193_DIFF_CHANNEL(4, 9, 10, 0x089),
> +       AD7193_DIFF_CHANNEL(5, 11, 12, 0x0AB),
> +       AD7193_DIFF_CHANNEL(6, 13, 14, 0x0CD),
> +       AD7193_DIFF_CHANNEL(7, 15, 16, 0x0EF),
> +       AD719x_TEMP_CHANNEL(8, AD7194_CH_TEMP),
> +       AD7193_CHANNEL(9, 1, AD7194_CH_AIN1),
> +       AD7193_CHANNEL(10, 2, AD7194_CH_AIN2),
> +       AD7193_CHANNEL(11, 3, AD7194_CH_AIN3),
> +       AD7193_CHANNEL(12, 4, AD7194_CH_AIN4),
> +       AD7193_CHANNEL(13, 5, AD7194_CH_AIN5),
> +       AD7193_CHANNEL(14, 6, AD7194_CH_AIN6),
> +       AD7193_CHANNEL(15, 7, AD7194_CH_AIN7),
> +       AD7193_CHANNEL(16, 8, AD7194_CH_AIN8),
> +       AD7193_CHANNEL(17, 9, AD7194_CH_AIN9),
> +       AD7193_CHANNEL(18, 10, AD7194_CH_AIN10),
> +       AD7193_CHANNEL(19, 11, AD7194_CH_AIN11),
> +       AD7193_CHANNEL(20, 12, AD7194_CH_AIN12),
> +       AD7193_CHANNEL(21, 13, AD7194_CH_AIN13),
> +       AD7193_CHANNEL(22, 14, AD7194_CH_AIN14),
> +       AD7193_CHANNEL(23, 15, AD7194_CH_AIN15),
> +       AD7193_CHANNEL(24, 16, AD7194_CH_AIN16),

Shouldn't these be differential channels since they are
pseudo-differential inputs measuring the difference between AINx and
AINCOM?

> +       IIO_CHAN_SOFT_TIMESTAMP(25),
> +};

i.e. like this (where AINCOM is voltage0 AINx is voltagex)

static struct iio_chan_spec ad7194_channels[] =3D {
       AD7193_DIFF_CHANNEL(0, 1, 0, AD7194_CH_AIN1),
       AD7193_DIFF_CHANNEL(1, 2, 0, AD7194_CH_AIN2),
       AD7193_DIFF_CHANNEL(2, 3, 0, AD7194_CH_AIN3),
       AD7193_DIFF_CHANNEL(3, 4, 0, AD7194_CH_AIN4),
       AD7193_DIFF_CHANNEL(4, 5, 0, AD7194_CH_AIN5),
       AD7193_DIFF_CHANNEL(5, 6, 0, AD7194_CH_AIN6),
       AD7193_DIFF_CHANNEL(6, 7, 0, AD7194_CH_AIN7),
       AD7193_DIFF_CHANNEL(7, 8, 0, AD7194_CH_AIN8),
       AD7193_DIFF_CHANNEL(8, 9, 0, AD7194_CH_AIN9),
       AD7193_DIFF_CHANNEL(9, 10, 0, AD7194_CH_AIN10),
       AD7193_DIFF_CHANNEL(10, 11, 0, AD7194_CH_AIN11),
       AD7193_DIFF_CHANNEL(11, 12, 0, AD7194_CH_AIN12),
       AD7193_DIFF_CHANNEL(12, 13, 0, AD7194_CH_AIN13),
       AD7193_DIFF_CHANNEL(13, 14, 0, AD7194_CH_AIN14),
       AD7193_DIFF_CHANNEL(14, 15, 0, AD7194_CH_AIN15),
       AD7193_DIFF_CHANNEL(15, 16, 0, AD7194_CH_AIN16),
       AD719x_TEMP_CHANNEL(16, AD7194_CH_TEMP),
       IIO_CHAN_SOFT_TIMESTAMP(17),
};

> +
> +static int ad7192_parse_channel(struct fwnode_handle *child)
> +{
> +       u32 reg, ain[2];
> +       int ret;
> +
> +       ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +       if (ret)
> +               return ret;
> +
> +       if (!in_range(reg, AD7194_CH_DIFF_START, AD7194_CH_DIFF_NR))
> +               return -EINVAL;
> +
> +       ret =3D fwnode_property_read_u32_array(child, "diff-channels", ai=
n,
> +                                            ARRAY_SIZE(ain));
> +       if (ret)
> +               return ret;
> +
> +       if (!in_range(ain[0], AD7194_CH_AIN_START, AD7194_CH_AIN_NR) ||
> +           !in_range(ain[1], AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
> +               return -EINVAL;
> +
> +       ad7194_channels[reg].channel =3D ain[0];
> +       ad7194_channels[reg].channel2 =3D ain[1];
> +       ad7194_channels[reg].address =3D AD7194_CH_DIFF(ain[0], ain[1]);

.. then the suggested change to AD7194_CH_DIFF above also make this
work when ain[1] is zero which should be allowed in the range check
immediately before this.

> +
> +       return 0;
> +}
> +
> +static int ad7192_parse_channels(struct ad7192_state *st)
> +{
> +       struct device *dev =3D &st->sd.spi->dev;
> +       struct fwnode_handle *child;
> +       int ret;
> +
> +       device_for_each_child_node(dev, child) {
> +               ret =3D ad7192_parse_channel(child);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct ad7192_chip_info ad7192_chip_info_tbl[] =3D {
>         [ID_AD7190] =3D {
>                 .chip_id =3D CHIPID_AD7190,
> @@ -1031,6 +1145,14 @@ static const struct ad7192_chip_info ad7192_chip_i=
nfo_tbl[] =3D {
>                 .num_channels =3D ARRAY_SIZE(ad7193_channels),
>                 .info =3D &ad7192_info,
>         },
> +       [ID_AD7194] =3D {
> +               .chip_id =3D CHIPID_AD7194,
> +               .name =3D "ad7194",
> +               .channels =3D ad7194_channels,
> +               .num_channels =3D ARRAY_SIZE(ad7194_channels),
> +               .info =3D &ad7194_info,
> +               .parse_channels =3D ad7192_parse_channels,
> +       },
>         [ID_AD7195] =3D {
>                 .chip_id =3D CHIPID_AD7195,
>                 .name =3D "ad7195",
> @@ -1142,6 +1264,12 @@ static int ad7192_probe(struct spi_device *spi)
>                 }
>         }
>
> +       if (st->chip_info->parse_channels) {
> +               ret =3D st->chip_info->parse_channels(st);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         ret =3D ad7192_setup(st);
>         if (ret)
>                 return ret;
> @@ -1153,6 +1281,7 @@ static const struct of_device_id ad7192_of_match[] =
=3D {
>         { .compatible =3D "adi,ad7190", .data =3D &ad7192_chip_info_tbl[I=
D_AD7190] },
>         { .compatible =3D "adi,ad7192", .data =3D &ad7192_chip_info_tbl[I=
D_AD7192] },
>         { .compatible =3D "adi,ad7193", .data =3D &ad7192_chip_info_tbl[I=
D_AD7193] },
> +       { .compatible =3D "adi,ad7194", .data =3D &ad7192_chip_info_tbl[I=
D_AD7194] },
>         { .compatible =3D "adi,ad7195", .data =3D &ad7192_chip_info_tbl[I=
D_AD7195] },
>         {}
>  };
> @@ -1162,6 +1291,7 @@ static const struct spi_device_id ad7192_ids[] =3D =
{
>         { "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
>         { "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
>         { "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
> +       { "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
>         { "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
>         {}
>  };
> @@ -1178,6 +1308,6 @@ static struct spi_driver ad7192_driver =3D {
>  module_spi_driver(ad7192_driver);
>
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
> +MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
> --
> 2.34.1
>

