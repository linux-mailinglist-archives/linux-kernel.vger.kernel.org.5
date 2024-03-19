Return-Path: <linux-kernel+bounces-107684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D988002E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E0B229B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF65651AC;
	Tue, 19 Mar 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC6r3HpT"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407241E861;
	Tue, 19 Mar 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860515; cv=none; b=MTeKZUviFVJOQEomIY6hi9MyAmk5S7n/U7ZfZTnCMs/mSE1o0vmlfmFX5TFP0OZt/kAbibP6OAdSaNwAdcR14AjRQnSsDuOpAyX8cOYXzGqBOc170J0ejgJIfxexenitwqLZNHImu82hE62cRlExQ3hvvALrFitaInieRF4obzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860515; c=relaxed/simple;
	bh=0pg+p+nf+gQwZknlBsp0E0M/W9JhPC25HviPI27Kock=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCIp3FwBiwhH2eMx1VElhsGTS9SVj/LSNGveo5GxqpB3aYI2gQlzEtWOcysPngii2j3WlS8tp+5yqSXZIOHBeOpNa2dquhm+LyVCS4Q/aCkR42qaK+FzR7eElX5FV/lI39YWNViDdDuT7s1tR4fXE5bYeKfWXV1OT7HXnKSeEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC6r3HpT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a468004667aso605829366b.2;
        Tue, 19 Mar 2024 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710860512; x=1711465312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCpiZXeeM4+jAqCK5wbO1N4j3AitpXA6Bk+sr2xjkM4=;
        b=fC6r3HpTG0cqgCAmznqa8Iyfnp82rka17IfrcIVYYf5vzhXED6JkiKFUL4niPK0vnO
         xOhf0RZVOARPro7u9ld9ptK1BYnUE44St73EBK/9pi5NtoHUiHTxyNfZHl1Vr7W1jajL
         UOYXQJ8g7Kk0sJVJ++ZTHydBCDH1NjP0dGsUA+ccPbAgJqU9I2UBBVGnvZxsFNelljGB
         AZ7WowSj1YFCQ02f/yAJr8Gda6C2ranMXvh44HeCAn8cihmnZImrNuvhxRYpQVyd1wUR
         ng9qVtZ4YoawHDdovdZZbI8Vh6Zdpo0FYVQqj5VC+P8SQmxokO8Niahcn85gM8zbPrbR
         tzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710860512; x=1711465312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCpiZXeeM4+jAqCK5wbO1N4j3AitpXA6Bk+sr2xjkM4=;
        b=pLiXlOHRlIk139EyKjr4BB/8ouj2ZnhfQItdQMHN22bvSYApWQXRR6phlL8NvDqVwx
         Pq+n34L3bi5WX4ZYrPFF3g8HVLgmej1fca/B/4HabCQkWbjir4Wgh+EDYYU+HcWupPgS
         F+5JeDLIV2GZdM0SmDnB8GP2X6CNgVX91MpgifwGm+iEW8Z3cmI7A0lvw5r8/asz+7k0
         SCCyGOoUpJFSwLjouIabsgzhH9xVgz6xTIxe4qkVi8fSvq40amzvffWvJKWv3bf38xX9
         MWx893rnewNKLI8VLZboIPdiGMLoJHAG0jZdOTQQWkYvzM9bIlKA3qGmL7+V0MTMDyAO
         cTJw==
X-Forwarded-Encrypted: i=1; AJvYcCWU+SEb6BdXLOdsTTaBzs4y9rlEFI314HB54XYntYb5R8N4g8xWtGA33k/uJ6/Q4JcuJ2CZG4fZ+sbkijCnXA5JF3hrSBTfux5rajghFRO/VKb/YBiGWmVqLP5exsrR0a8uvNwoJQex
X-Gm-Message-State: AOJu0YwBQ6D1Y8rY+HGIrbW3KZmtlx1DLVRAYqwkuHjBvNx9bhXt5Atg
	SvoWN4idbE2vwkyzx5+vxhytgyBAvtzeeYGhahQGVFKpFHde0zkc/hGS8AIPdq3NzU5yGo4Eacz
	il9dlJzTKIKIt2xwwXlNW8k3auNU=
X-Google-Smtp-Source: AGHT+IG2KbfB+Fa0Kp3oMunxbY4onHSxKF5Z6dnUG7eEBjFBKgM3wpkQCIsQkb+Nayq/fu3OGTqEWxU5wzGvL3pfJ5E=
X-Received: by 2002:a17:907:20e4:b0:a44:7ad0:8069 with SMTP id
 rh4-20020a17090720e400b00a447ad08069mr8723201ejb.72.1710860512111; Tue, 19
 Mar 2024 08:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
In-Reply-To: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Mar 2024 17:01:15 +0200
Message-ID: <CAHp75VeO_=r_pMBUTaQQYKDRAV-OVfTnPYPwV8f7KDzOhaBCvQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property parsing
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 4:28=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> This simplifies the adi,spi-mode property parsing by using
> device_property_match_property_string() instead of two separate
> functions. Also, the error return value is now more informative
> in cases where there was problem parsing the property.

a problem

..

> +       ret =3D device_property_match_property_string(dev, "adi,spi-mode"=
,
> +                                                   ad7944_spi_modes,
> +                                                   ARRAY_SIZE(ad7944_spi=
_modes));
> +       if (ret < 0) {
> +               if (ret !=3D -EINVAL)
> +                       return dev_err_probe(dev, ret,
> +                                            "getting adi,spi-mode proper=
ty failed\n");

> -               adc->spi_mode =3D ret;
> -       } else {

Actually we may even leave these unchanged

>                 /* absence of adi,spi-mode property means default mode */
>                 adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> +       } else {
> +               adc->spi_mode =3D ret;
>         }

       ret =3D device_property_match_property_string(dev, "adi,spi-mode",
                                                   ad7944_spi_modes,

ARRAY_SIZE(ad7944_spi_modes));
       if (ret >=3D 0) {
               adc->spi_mode =3D ret;
       } else if (ret !=3D -EINVAL) {
                       return dev_err_probe(dev, ret,
                                            "getting adi,spi-mode
property failed\n");
       } else {
               /* absence of adi,spi-mode property means default mode */
               adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
       }

But I can admit this is not an often used approach.

--=20
With Best Regards,
Andy Shevchenko

