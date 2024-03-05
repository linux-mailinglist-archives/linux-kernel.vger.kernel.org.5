Return-Path: <linux-kernel+bounces-91431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8725871168
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308C3B231C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083DFEDE;
	Tue,  5 Mar 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HqNU/HwM"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8B19E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597294; cv=none; b=TW9Wsm1NkoXZ2ZslCN8HQISz/FaflsiIVUla63pqesA7hHFdMGEFfLyIR1itz8GtKxb6+KTtAgag4risB9ph8wO2EKZ9oiNe+0SZ8A1GGWLV0+zxyJi5/u/WWz8a0eLsuIJQvc4IPiFRkxx6BXeBkkBn0YQxfKxRdKRkcVCgY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597294; c=relaxed/simple;
	bh=iBD/lWgE32zXC2QBHxGi//O0lo0WtY3b6Y89v266YRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfZRaniJRPT/3HT5CHy7Spkb/HKDqxHLjjORLqKgDx2rj0HHZI7Hha9kuWlz1F9GyxOPbtLZVIgu++Ljs+W0P2OagvElOFSxvah4REbEGw51R1J0iVyP1oSrMCJkY+dZmAy7B6pJbngxPhkuw5Q+g3NjrJDE7d035+Z/nIe1hmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HqNU/HwM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d309a23d76so38463061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709597290; x=1710202090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09gjUa1aNcaW8opSfWpZn+d038/7XmkYe107VGCZCIo=;
        b=HqNU/HwMJojUyz7FtaNRbupydTeXR2g7v53SFHgK0tz1oDHIb8pD9EZVXlej7N0Akd
         la5MGK8zmB0y+Fla9yJY6YzCjt1y6rNW5ATmbonl3k80n5d0ohFIXsDt5nNRHsYsrvoA
         ZpXEAHbvR+NIAiaM6Tr2AebUD9kggTCr9VJekSWzWGWZhvrEU8749h3yXYHd+JTLEFOp
         fCWIIopAx3jhAHlC6lcgE8EYJwJd58JZjpIuP0L8Qhdx9X5x2Ci/xv76gJDzKZHMCgp/
         C1oGIM04zQg5MpH/Ha8xa4CQiiDbYaAlFqvhE7d65C7Sv+KxorSXBokzmcOubsO1nGyO
         1nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709597290; x=1710202090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09gjUa1aNcaW8opSfWpZn+d038/7XmkYe107VGCZCIo=;
        b=bBNzPnpxqnLffWK2vXAG/Ja6aWH1fNcSHHIs/jhpm2jvFR06jEgNNlOZyyK/ei14/v
         lyVsp/LoVR0MIPQ7H9hOG8tsluDH9Xoel9bKKCSXl1FGim+loyIgcjxJpZRzj2pQCzUf
         Y/7Mp4/F42slFzSH1webza8MIQnNc6xCdtg6GYfAh10+9dzx3iHYdnW6p2uhq+H5Ejc8
         nmPluIu8vJwSHSQsFx62yewuAorDXJUJrnam8FrbB+BKvVT7RFcO+o+lSG2MvOG0qiWB
         RM0lRTD6oFzlib1o14whmAjgdj3JwMiDYuiX++hNKIjlgOXabLkZHtKHAsrnbzim5VwP
         CMVw==
X-Forwarded-Encrypted: i=1; AJvYcCX4qSp/51gUhReGLuCAjHzt3LOCFPIItJT29Nr7USukhK157VWTrBCMEbCdxIw470bQyUZK2/USKm2yLYahSOmzg3prjwzfLIErwCgI
X-Gm-Message-State: AOJu0Yx0a29BVY3V1M/OixbjcuHVqt9dSgRlX0sJ7+XyUJhyGCCpmrVA
	7AmGlPLFiiE/p/MHz4PgX8sHUFDIj5CrTmIwzd0F9wQ7Nb8wgIjDD8VGik7uEYNJO2LXtmfwUyj
	pR+Z7mZsyvvN/bb2v6B85aCHqpUoaaA42+1fdwQ==
X-Google-Smtp-Source: AGHT+IF6jOcbxgpV5XnETtLmcngNiEFaSfy9AoFXhR2CKsQ+k92FKANJqu2HvZwGqa3iyBWwRU+kqKS0bmNwUI/avkY=
X-Received: by 2002:a05:651c:b06:b0:2d2:b5cb:cc3f with SMTP id
 b6-20020a05651c0b0600b002d2b5cbcc3fmr124275ljr.2.1709597290067; Mon, 04 Mar
 2024 16:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228135532.30761-1-mitrutzceclan@gmail.com> <20240228135532.30761-3-mitrutzceclan@gmail.com>
In-Reply-To: <20240228135532.30761-3-mitrutzceclan@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 4 Mar 2024 18:07:58 -0600
Message-ID: <CAMknhBGv5vfFPRJ_4nKrYWgxiovgHqTEtJoRs+EzvbvpF8a+Bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for additional models
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:55=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@gmail=
com> wrote:
>
> Add support for Analog Devices AD7172-2, AD7175-8, AD7177-2.
>
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  drivers/iio/adc/ad7173.c | 82 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index b42fbe28a325..e60ecce20e08 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1,6 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
> + * AD717x family SPI ADC driver
> + *
> + * Supported devices:
> + *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
> + *  AD7175-8/AD7176-2/AD7177-2
> + *
>   * Copyright (C) 2015, 2024 Analog Devices, Inc.
>   */
>
> @@ -61,10 +66,13 @@
>  #define AD7173_AIN_TEMP_POS    17
>  #define AD7173_AIN_TEMP_NEG    18
>
> -#define AD7172_ID                      0x00d0
> -#define AD7173_ID                      0x30d0
> -#define AD7175_ID                      0x0cd0
> +#define AD7172_2_ID                    0x00d0
>  #define AD7176_ID                      0x0c90
> +#define AD7175_2_ID                    0x0cd0
> +#define AD7172_4_ID                    0x2050
> +#define AD7173_ID                      0x30d0
> +#define AD7175_8_ID                    0x3cd0
> +#define AD7177_ID                      0x4fd0

It would be nice to keep these sorted by name/number like they were.

>  #define AD7173_ID_MASK                 GENMASK(15, 4)
>
>  #define AD7173_ADC_MODE_REF_EN         BIT(15)
> @@ -110,15 +118,19 @@
>  #define AD7173_SETUP_REF_SEL_EXT_REF   0x0
>  #define AD7173_VOLTAGE_INT_REF_uV      2500000
>  #define AD7173_TEMP_SENSIIVITY_uV_per_C        477
> +#define AD7177_ODR_START_VALUE         0x07
>
>  #define AD7173_FILTER_ODR0_MASK                GENMASK(5, 0)
>  #define AD7173_MAX_CONFIGS             8
>
>  enum ad7173_ids {
>         ID_AD7172_2,
> +       ID_AD7172_4,
>         ID_AD7173_8,
>         ID_AD7175_2,
> +       ID_AD7175_8,
>         ID_AD7176_2,
> +       ID_AD7177_2,
>  };
>
>  struct ad7173_device_info {
> @@ -190,7 +202,7 @@ static const unsigned int ad7175_sinc5_data_rates[] =
=3D {
>  static const struct ad7173_device_info ad7173_device_info[] =3D {
>         [ID_AD7172_2] =3D {
>                 .name =3D "ad7172-2",
> -               .id =3D AD7172_ID,
> +               .id =3D AD7172_2_ID,

It would be nice to put these renames in a separate patch since it is
unrelated to the parts being added.

