Return-Path: <linux-kernel+bounces-77963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC699860D62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8105F1F26196
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE092260B;
	Fri, 23 Feb 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pHvuC0UG"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D91A701
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678722; cv=none; b=cLYgVAVAimreHQzaKf+1eqOTJM9OHwxVjkvY0/w5Vqys3VXNJuMCi3OYRadtUMLS43xKM34UV/T+6SL7tRV/BQ61SzTgkSAzbJjEMZZZTGJxT9KCRBB3xy43oPNc95oSOrXmMHrIB7DQLPfYxKxzL8QLBhtpZQtJ3NQalKgkzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678722; c=relaxed/simple;
	bh=+yfpLLpZWAzKz86AqXEvDNFXJ1Hdw5Pn1ilNbhhTWig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkwmnKGbv1wIYIGVzG8oh8pMkUTemJn7dhuXJoBxu3n8YVtxETspjNIZrQp7Qm8+q3TPnE/J3d9/IAqlbjim0LHyrsskhennZfje04P6Z4J3LgEUO7CgTSmw0qDqDCzfTd7LO8T5iJuYhWS1tgmJsI7v8n15w4yLlpSdszWlDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pHvuC0UG; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4caabc3f941so65715e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708678718; x=1709283518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdhNAyZCWCmuGbu8IjdQhrtmlJ78u8sw3DjSXkphGFg=;
        b=pHvuC0UGKBlJzmU+qpnU6PxlLHfxqSMLAY39b+nymTx4jyNnD7aZXGKhhBRkX8wfpM
         VK3PYxZGoKvwqoS4sS0apL6HYnxqOy38Fyc84EoUdlvKJzi+QMLf2pmAqdnNQADo8bmd
         +6phrn3PvPCcfQFnO/eAIfv4Lb5kQuDE6oViG1i7DU4NdQaEjzgyr7SSqVO9nmr99RYd
         73WNK/Qv2rK+z4nCVapx3Ac3NRpj2RnrNs3/Q766BVA82f2k+H9wqflfqXovKGqeaP78
         b229y7gXUKYlsN/MdjNej1J6O8/4sLYFFHTV1hZFVbUEWGb5/ze3N64EVVwVdSK+BRiE
         WCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678718; x=1709283518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdhNAyZCWCmuGbu8IjdQhrtmlJ78u8sw3DjSXkphGFg=;
        b=sju5sDY7QoaUv0LE0Txd1l3bfow+drbdesLUjsMz+tx2kbAo1ZnomSKoE/pgpcspAS
         tbqkN2VBojGQNkP89kVyRwmUlsFc/40PBjdXhNvXXULogix5Vox09VZb2nZzA9u34ab1
         nN8/H7PIqVgQGIbb1CDo+tuQnhwCYG8NV+VtByn3OwPbcYl5HmdtyfHaKutQbCbrdjMw
         8SrBoNSlxjvmtPIFeumezJaHLvarctJO35MXIfG62kMfR4shxxkOfaymjIdO9kXvNFF2
         mpqou2piCBKsuVS2XxQ/pdvq0Utc9JMfwvlEv2tPw4nAM9qHcNX9FXj7/GafsPR+gSur
         Iv6A==
X-Forwarded-Encrypted: i=1; AJvYcCUg3dJ+klgAXH0NeKWfJ5sVvBnXGaii8o2tFmCcLnz1bdyBa3RooV+olFk01iTEQyAEP9R+1AunSixQGGbq7+RNIrERMvJ+IA3yKHKP
X-Gm-Message-State: AOJu0YzQe2BRUUNHgmj/MDom6roTugGRi5Njj6jfdvg3Z9TISXPM3H5N
	DEVElXy71cMCd0+0/UCCUL6gA1l0gRvH3nBSNS5vGA1FQr6R9EJ8910ehwzAG98JaTsIQJakw+H
	Op/Ka/PzN6gu4AREVPfbpNm/5/Wbo9Uw0Gml8vUFj/39VGKTyF/U=
X-Google-Smtp-Source: AGHT+IH/PuFa3ZX9ceqi0RhPMhD/IqzC8jGrzkDvj0duK9Qb15rHIQeZ6EPgApOdFsGimGCy9iCbqP/KB9wryHDyYng=
X-Received: by 2002:a1f:eac3:0:b0:4bd:54d0:e6df with SMTP id
 i186-20020a1feac3000000b004bd54d0e6dfmr1047299vkh.1.1708678718667; Fri, 23
 Feb 2024 00:58:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222102513.16975-1-brgl@bgdev.pl>
In-Reply-To: <20240222102513.16975-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2024 09:58:27 +0100
Message-ID: <CAMRc=Mcc8Kj4ANWHiq_MWmAoXh==BSjxV0KyaUF-2jcoga_o5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: provide for_each_hwgpio()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:25=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We only provide iterators for requested GPIOs to provider drivers. In
> order to allow them to display debug information about all GPIOs, let's
> provide a variant for iterating over all GPIOs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - rename the iterator to for_each_hwgpio()
>
>  include/linux/gpio/driver.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 9c1fbfaebaa8..175129a92656 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -551,6 +551,21 @@ DEFINE_CLASS(_gpiochip_for_each_data,
>              }),
>              const char **label, int *i)
>
> +/**
> + * for_each_hwgpio - Iterates over all GPIOs for given chip.
> + * @_chip: Chip to iterate over.
> + * @_i: Loop counter.
> + * @_label: Place to store the address of the label if the GPIO is reque=
sted.
> + *          Set to NULL for unused GPIOs.
> + */
> +#define for_each_hwgpio(_chip, _i, _label) \
> +       for (CLASS(_gpiochip_for_each_data, _data)(&_label, &_i); \
> +            *_data.i < _chip->ngpio; \
> +            (*_data.i)++, kfree(*(_data.label)), *_data.label =3D NULL) =
\
> +               if (IS_ERR(*_data.label =3D \
> +                       gpiochip_dup_line_label(_chip, *_data.i))) {} \
> +               else
> +
>  /**
>   * for_each_requested_gpio_in_range - iterates over requested GPIOs in a=
 given range
>   * @_chip:     the chip to query
> --
> 2.40.1
>

Patch applied.

Bart

