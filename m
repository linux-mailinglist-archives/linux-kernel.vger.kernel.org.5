Return-Path: <linux-kernel+bounces-39153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688983CB99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC981F27987
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A74134720;
	Thu, 25 Jan 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccRxUOWu"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC1133431
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208670; cv=none; b=h8OQVkOp2pFfoTsygnpn2Pcju1R4kWfXDipsM0ZstkGCft5ewucCF0/Icnb77oEeyn4+aRZldmrX+8K5bdhc5Sv7jnsArkEaDh6boFOzTOjlWgBnlWyEpFVQ1Kri7bwSwHZlad6J/qYxid5tPg3xGPUBLxOS86B0wU0nIqB8JpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208670; c=relaxed/simple;
	bh=q7gKc6Apge2sQy105JuIf4idKvW+b7qRsLUR9d7cLSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLv16PpBjvnS7EGGD3eOaG36Y8w2Y2SzDEisb2xwvocZonTmKbitSuxt8uTXYjMUHZ0CeqEXBOzeAWKIxtUmryd8zRHqqwd/89rgaEw1DGP17akWcN14WJJH6o+WrNJS9DQGHm8gdmM00iJbAQPDhIxeDsk3HCsuPiMyA/8vnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ccRxUOWu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d70a986c4aso33815155ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706208666; x=1706813466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xczzOozUj+fiGiPxhEFgyd4CpF4V7poYvzk3EKH51s=;
        b=ccRxUOWu3xOd67VHPRNkjNW7yLdwoXLof8uej+ai3Eck2b+HmxWDdrAzjs9D5HHSb9
         em8Ha4sQgHQVRWvFok2gh5XmhS2W5+utVXQIcerVd0LTUcMxkynU/XGd1w2lo6FuVx3Z
         3ZX88hocXfiQu5+pg4u045hAlWoFuNySNVFLvCWi3sD2fnnWxC3RKWEDfCC4m8YxwqE4
         xkq0fG22B65/Dl7hZB3/r4l2l6fqQi+uWpdzUjRHNRwHwsqFusT5GF/mlBWezWbvltda
         J2GoU9gclHGvwK856Tjl9GyM4lI7ogCSGls8MXgIrWbpAgeTcSYSDFgdyKhKfn0kTf/b
         6a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208666; x=1706813466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xczzOozUj+fiGiPxhEFgyd4CpF4V7poYvzk3EKH51s=;
        b=Lyb4ndJAi+l6UyVzM5Eqvl2GcxGNrfusxiWlDU/Sku9et4S5s+gBinoE8nONRWJkwH
         +mwGn6goHWc8vycHAYHi4Z9zzR4pLg9d8HK6ToyfjY0OVKCDh/xsVjOKVvtC8elZ8/Me
         Tk3X7u5XF102xyLdziaW0O8KX1z1F7R1RKv+mLOpuIkqdToITcqij404vKDGX8E3NCmY
         932JYM6tQi1/c2BcZaETTUu3lrH4yDZ5SDgnkhhhaw4pTRi9UyyuIvPhar7yUH3oxy9S
         CU1TGqfxbT55WG/H5mDpryV7qWYm+Yg99zPInSpSzoJTJ6dzx3smSK14Qy/KmtWKSdb/
         A9Fw==
X-Gm-Message-State: AOJu0YwONTzWnKy4+XyZ2JShYaDz4s55cU5YH/dDD4XeMIGpVjD6q7PP
	z8LC0mWqHh6oQlQ1DttZwZIpjIHEdvpDoc2iK3oGT7UxPReYOhMMUwnGk4azY+MT8Jxbf8wN66r
	4wfGxMLN5/hTdmlXfMQIa7n1+WAcFKjThD4hSew==
X-Google-Smtp-Source: AGHT+IEPw4+qnJKnu8/72hWD3+ir40BwKI7V80y8L/LevdXWM+UyxESBOwoXUHE4dz6OutK8TfRuGPAqSz2EqqS3CCM=
X-Received: by 2002:a17:902:ed0c:b0:1d7:54f2:b572 with SMTP id
 b12-20020a170902ed0c00b001d754f2b572mr168175pld.45.1706208666465; Thu, 25 Jan
 2024 10:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-4-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 12:50:55 -0600
Message-ID: <CAPLW+4=hYRvLEHgA2DL4SQyg4i91J8kT0jdJdAedW=YrJG_vtQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] spi: s3c64xx: avoid possible negative array index
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:50=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> The platform id is used as an index into the fifo_lvl_mask array.
> Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
> thus we risked a negative array index. Catch such cases and fail to
> probe.
>
> Fixes: 2b90807549e5 ("spi: s3c64xx: add device tree support")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 2b5bb7604526..c3176a510643 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1189,6 +1189,9 @@ static int s3c64xx_spi_probe(struct platform_device=
 *pdev)
>                                              "Failed to get alias id\n");
>                 sdd->port_id =3D ret;
>         } else {
> +               if (pdev->id < 0)

I'd add { } braces around this block, but that's a matter of taste.
Also, I'm not sure why do we still want to handle !of_node case for
drivers like these at all: there is no mfd case for this driver, and
board files are long gone; it seems to be OF only driver in a sense,
from its users POV. Anyways, LGTM:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +                       return dev_err_probe(&pdev->dev, -EINVAL,
> +                                            "Negative platform ID is not=
 allowed\n");
>                 sdd->port_id =3D pdev->id;
>         }
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

