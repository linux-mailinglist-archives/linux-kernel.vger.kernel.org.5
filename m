Return-Path: <linux-kernel+bounces-40605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A183E310
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C048F1F255D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5F22EE7;
	Fri, 26 Jan 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpeTIaq7"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372422612
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299587; cv=none; b=ns+gGOPxq61c9Q7nEm6oaTNmB4mUyNVwH+NeHqUDMw3M+l1CvSV1n0kkhIfZUAlKfGFiiV+4f+He6cXzDT4a+YuDn7KnJ4pOwXI9YTEbwSk5ZmrwxbrxEdzZH3DIzVYWQc4ftIgiKbvQzC/DxPQjcBAUIXgQDMD6SeKm7vLuGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299587; c=relaxed/simple;
	bh=sXzD9XF1wSaVbPB4WStHBUPn9mQ3LnoVAJQIQPjGFCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgZ6wDHOJ9e6DHMb3J2THQZwVO5jvUyCrb80tacLGglkjBnOyNtQuajJOlOILj9FQnuCpr+gAIk6m33LLYe7i4b77kQdbiSLLJe6DsT9Nsd2UP56RiB3NmPg1peK3wT8/WSYPhukYdvZDKRsSQ0p+LGhnQA2FlVzmWYPp9DCol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpeTIaq7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d76943baafso7217085ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706299585; x=1706904385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyg3j+csLi06Njb0QnNOSR4IamfFLKs7cHM9SdWTGrs=;
        b=TpeTIaq7IX8Sk0qIykPHMI+nhtRswTcFT4Q/YxvnUuT5y6NCscCsMgIjwEbuN4Ws5l
         Ro10ZuxdR7W4xBrq/CpgRB9Cl/dLyOAkStOCJnqF7HpRH0bNzd1m1EKaFP2RIN7H5e1H
         /yTEzj3rQMqCBcH5OobR1mLujeuMXTYA5hzJXWqefq6v+/l4iBaeesfrHv0eWTS7axiO
         jWJaDME21+MG1Z8sRBdtQsBo7KYEWAJ3neDAfEcUYLTZP6Z4rUxKZhR3iwCGI2pu2Yqc
         nA9+VutT0pJO0WokyMFHiJU6bCU48S8vCA2V2h36deGhWQovVl0FIeKy7jAqJY45aopE
         Eq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299585; x=1706904385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyg3j+csLi06Njb0QnNOSR4IamfFLKs7cHM9SdWTGrs=;
        b=MZdaak8yhUJAHD2OUqgxwKUJ+Qm9fX5JsGpBJhGA7MadRvNFBp1q32p0zkv+g9QRSE
         4q694mdfvrDtzA+bUBWuZhEClwvqY5AE89dTa0/zfAlF9JfxGjpyT+OGAeTTEedlpIWM
         ZS6VpVdeOZXpg/5Rg92jJz+Nui4i9WokziuqBMLYsuw70I4E96BJsH55uW5Vf1wJc9X3
         F0FAVaf4Bjoc/H4aibwcxgagd0XGKN1G+8Bf+70r7rFGlRdp/xo80jjzv8LZdbleElxG
         D7sK8hPrSz/NRnYN1MYGO7sXxpRI0kVl6RXBKC9zn4191ZSgZs6a72BuhBhi37tHRY9N
         H+VA==
X-Gm-Message-State: AOJu0Yxy/l0o9L4eFUO49q74JnAIuHbks8k4Sv/+9fPNCagzmX+6/qES
	IdzJoCa8syMYoXjUfs5wsskKcySkaqCrU7+U7M69DInpm5kpczdIfed44QZAXVQtgpvH8LXVP0V
	X+rFAbiSLF6tqckGxC+6Bxrov/dLPtmMg7RwjzQ==
X-Google-Smtp-Source: AGHT+IHgdqErwTfGR1mFoEDcqPBsabyANjOebK1CnmeVuHVeU8ZeySVoIUaSHRxYDZBvVhcJJEb+aNWGA4Q7/3O0PBk=
X-Received: by 2002:a17:90b:1947:b0:290:1cd6:6acf with SMTP id
 nk7-20020a17090b194700b002901cd66acfmr384009pjb.37.1706299584939; Fri, 26 Jan
 2024 12:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org> <20240126171546.1233172-16-tudor.ambarus@linaro.org>
In-Reply-To: <20240126171546.1233172-16-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 14:06:13 -0600
Message-ID: <CAPLW+4mpWXzt=Tvf9OP5ru8uyBLtBWqqCzn4D7i9MZFi1basng@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] spi: s3c64xx: remove duplicated definition
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, jassi.brar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:16=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
> S3C64XX_SPI_TRAILCNT brings no benefit in terms of name over
> S3C64XX_SPI_MAX_TRAILCNT. Remove the duplicated definition.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index dc779d5305a5..e9344fe71e56 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -115,8 +115,6 @@
>  #define S3C64XX_SPI_MAX_TRAILCNT       0x3ff
>  #define S3C64XX_SPI_TRAILCNT_OFF       19
>
> -#define S3C64XX_SPI_TRAILCNT           S3C64XX_SPI_MAX_TRAILCNT
> -
>  #define S3C64XX_SPI_POLLING_SIZE       32
>
>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
> @@ -1092,7 +1090,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_d=
river_data *sdd)
>         val =3D readl(regs + S3C64XX_SPI_MODE_CFG);
>         val &=3D ~S3C64XX_SPI_MODE_4BURST;
>         val &=3D ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
> -       val |=3D (S3C64XX_SPI_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
> +       val |=3D (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>
>         s3c64xx_flush_fifo(sdd);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

