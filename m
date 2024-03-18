Return-Path: <linux-kernel+bounces-106761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A5087F335
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098391F217EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E715A799;
	Mon, 18 Mar 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET6lVfP6"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870BA5A790;
	Mon, 18 Mar 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801844; cv=none; b=Hpx7gAXnNmvZnN9s2nnLsZ0aZo54s2ky5+UDIVStS9VvfMGUfZ41LLoddoa2Xlw7ti0I3IOEsUsPU+S+170bS5VM4CMoz1mGNJWc29/8W708W+gt9Yjfcoza9FaoCqlhRFlvqub5TOfmuQleEWAUIGvHBViAFlDH+qt5C++MBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801844; c=relaxed/simple;
	bh=dR4++XKtCxzuymi885tI+pUG7UFcQ6YF4glKSTNBAYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/9k2c0NKQCSIpE1g0FVQC8A87g7RLqgObnUrs15hBWOv+2Bd+thJg7gSq5zVgoR0gwAacrgz5NX6Ef2MrMB47rps5ylC6Eb2THI4rbtvafDdWcqkJAhSb63Vy3Vq8K+RLbJeSjPVeBs6XdfzNR8tZGuBq1dir570cBWnmGFyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET6lVfP6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so10287543a12.1;
        Mon, 18 Mar 2024 15:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710801841; x=1711406641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vjwSHT/vBTFQXhrqxZcwQTtbUn/qlMhqmqTMA3EQCQ=;
        b=ET6lVfP6mNJNEN3ElAX417DGpzhMqO2uBLzXhtQ+iQlEN5wY2CqHd+MOLWlobt2nz/
         N/085VYtJ7amZo96BBc5L9rj3b6y5mlMc/RExWe/PAbNa0upstCAzbQGrIDvPM4/j+lq
         8gaK2U5UPPw3v5T/yYnfP9ZFeowRxUaKdod7CGdD1msiwni2PdUTsfVkpyzfJZp2u58c
         KxkLinr0J4+KiNUHXq9hwJ3Ss0hc5PHi9OJdftl1t9tL6UzzLIsVBp3QwFrwcH4mN13f
         +DG5r4REWr1M88raIFkdv7VXJGkWSGPPF9+FNBUmcMIcJA+3i4MlC2Wy+rvXFek9Zr1y
         2YWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710801841; x=1711406641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vjwSHT/vBTFQXhrqxZcwQTtbUn/qlMhqmqTMA3EQCQ=;
        b=ALXe3hU+RaAmMFcocZIffU7GE2JfE75WqBcV3ZIKkIHaug6fcvr1z24zhBUPYJ330I
         yN+FrxPw3QTl/2JrC0mmhcVTi4Bud3M8UufyHCdbNiJ53i1N7ldLQwONlKYN/cTubavy
         F80KelXjNm7UqKVRHbR+X80tlG3H8BmJtdPZNmHeb2dKq/SDgbF5Zn/DLC6JvjmKyWGf
         GFL3q9NnCIYTsv1+PegPflVt8JNAvEG507sd9PUPK9EZq9w33fi095RRY+n8MvILLUQV
         eLgO1k9lTWyk5/XjJ40oWNXBrtxMQp11E1+th0hvRGdGeVCNrdyFrj5D6EArUKEw4sml
         M/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqaBzu/tK2ZOR7wVjjfBhPDQoageYqi6kemnI2ei1omek2Ve2eC7vM6zvaRyy9+SfFVJoyXJSqco4uWTAEPgSi3C+8d8yMsMTxwHqigg7wYlgBWMLHO4cDz4Oa0xurgZoTgZBIqBN
X-Gm-Message-State: AOJu0YxJj+CdEvejyRFdPDghLZYrUby1wlj9f8t74QjjYiUzSkrRRUpx
	hlz2XJQAWls85hXsYg1V9lYroGPsmNAfHBWJCRALRn3elcpB+A6Kjn1YwWiu9bk8187wX0lIsRZ
	MaMEvZ1fesaEi6hfLI6vg73a6ktE=
X-Google-Smtp-Source: AGHT+IHO4wPPMJvbT/0FCmDo59WgcjwT+d9GmvmpXK0IfU6pp2Aq7OBBclzBjsz7C15s+mRMuW/emDnXEBZ81W4ZG6I=
X-Received: by 2002:a17:906:481b:b0:a46:ab93:9848 with SMTP id
 w27-20020a170906481b00b00a46ab939848mr932540ejq.26.1710801840802; Mon, 18 Mar
 2024 15:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com>
In-Reply-To: <20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Mar 2024 00:43:24 +0200
Message-ID: <CAHp75VfKZy45RVJmAAOEPyUFTW7MhxJmOeQHj3YV7p-NPKpkvg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7944: simplify adi,spi-mode property parsing
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:57=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
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
>                 /* absence of adi,spi-mode property means default mode */
> -               adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> +               if (ret =3D=3D -EINVAL)
> +                       adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> +               else
> +                       return dev_err_probe(dev, ret,
> +                                            "getting adi,spi-mode proper=
ty failed\n");

No need to have 'else'

               if (ret !=3D -EINVAL)
                       return dev_err_probe(dev, ret, "getting
adi,spi-mode property failed\n");

               /* absence of adi,spi-mode property means default mode */
               adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;

> +       } else {
> +               adc->spi_mode =3D ret;
>         }

--=20
With Best Regards,
Andy Shevchenko

