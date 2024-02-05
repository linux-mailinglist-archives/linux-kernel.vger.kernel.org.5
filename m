Return-Path: <linux-kernel+bounces-52958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE636849ED0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2728B342
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF572E629;
	Mon,  5 Feb 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iP4sVD7h"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936E39856
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148405; cv=none; b=hz8HecHt4cHjdAu4FN0fGoQipsnqjNwS7M08WstRW/IAF7SZfezi3vOpTzzPmB6f6vRN/gfKZ5frEwZiRhm6wNUYCevI9YNi2KBYaJo2N1s2NIvIOX2o+Q2jVwfpBUM8etCx8FDbTGsHdtUkg/P6pPzxPGiJkYNX5E16Pizl2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148405; c=relaxed/simple;
	bh=Tj/tSyznD6niSn67AzAu0cOFqdiubGqC2gQgO7+0PPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAxFe/hUanMzaY8tGL85EituX3McQ/9DZIZgcepxAa4uB6eb4wDqy/d1+6yOZXlWE7byeevQ0NyyjPJXsDg2DdIn+xmbqZvgwnoDPcAaKKkzoxtLOJrhwOQQHENWSLIlqHiYSc78n3crDL/Y+VdegYg5IUo/D9phUdNqco3Oh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iP4sVD7h; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4082848a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707148403; x=1707753203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKMXANMb2L0d4cSkguf2jw1WiTCcS41jyvz5JuSTL3Q=;
        b=iP4sVD7h7Lpr2wvcPYz6y0GbWFJelJ3+aAe3FeRtzyWsY0/c0j2zUtFOEKclalXZ09
         q282t57sGhCT52qVfKCNm4cl61+tdCGlDuVQytigyLcgoaIb5oxqZi005reA1RJfFcma
         dd3ginGfpxwH0can8qIXe0CgRifQrPZ5+bDxXRS2KikU5AXlfgKy/mQNjx5TLiDPmCfH
         hfCKG8nfmoCf3MlL4k0OjheUoLR3mPV8NDnuvRrr3wU6o4LhUkWmN+0iFQvpP+5aGr6J
         a+zjndPPIhWWzBhOf5H0gwBxrpQ9GaQodusiyFpYy8I5ImPvfzN+mZJIuYw65zus5c98
         nQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148403; x=1707753203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKMXANMb2L0d4cSkguf2jw1WiTCcS41jyvz5JuSTL3Q=;
        b=vOhF2hdvZ/pvgGVjwxMPb+AkQvvKIuTR3Hy1y8xXuKoQiOvyxJruKr+PCxYM/Ds7G+
         OP0WB1+2WxvLbNOzHqJxqyaeqwcblTflE92drrX/771ynfw46EsqMQ+AzU35/0ayTiP+
         kz4dHCPQYSvsdy5xKvl+R8uhHC91SE39ZQAeG9ura5qsVJ+sc79V/UgrwCPVlUc/rt0p
         sEE75IzPCD4ay8oCfy6KXcMnspB8tvXxFKHXgLsWrKOAuwBC1cxy0zcdUw656LtVBc25
         K3amNBXs0gdIKI/Yvypsa4womAwLbzWk75nawL6ln3C4GzpbaIMIQCxb+UiTQQYCL61f
         hIfg==
X-Gm-Message-State: AOJu0YyRpaWWORGoPpbQSs7ifAPjFgM6whO7NMnvkVrpcEcZeUDVByqt
	9M7xlYwyEwgLmafqmeV9ekq+ZsWSoAfQUvnviIyHJerBED5+kBGL3dUwwyKxh4ioo8ejSfh91xV
	7KJoh6vWKBU/bx8Mm85LxaYZGn3CaS9+sZdc1+w==
X-Google-Smtp-Source: AGHT+IGiQ8mgXBzzUxrLOOHInjCHEUGgvmdllRmofPYa6NtB9hGeupI8S22TOVaYwtQCQLIyLsSLsY86I4vrGeoUsvs=
X-Received: by 2002:a05:6a20:c891:b0:19e:4ae5:730f with SMTP id
 hb17-20020a056a20c89100b0019e4ae5730fmr57615pzb.30.1707148402893; Mon, 05 Feb
 2024 07:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-7-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-7-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 5 Feb 2024 09:53:11 -0600
Message-ID: <CAPLW+4=S7+ur0Csd-qQcEBo2_Z3Dy9ZtarYY0=jYhY33kc4WDA@mail.gmail.com>
Subject: Re: [PATCH v4 06/16] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:45=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> of_device_id::data is an opaque pointer. No explicit cast is needed.
> Remove unneeded (void *) casts in of_match_table.
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index ccb700312d64..807270ec3c8a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1512,31 +1512,31 @@ static const struct platform_device_id s3c64xx_sp=
i_driver_ids[] =3D {
>
>  static const struct of_device_id s3c64xx_spi_dt_match[] =3D {
>         { .compatible =3D "samsung,s3c2443-spi",
> -                       .data =3D (void *)&s3c2443_spi_port_config,
> +                       .data =3D &s3c2443_spi_port_config,
>         },
>         { .compatible =3D "samsung,s3c6410-spi",
> -                       .data =3D (void *)&s3c6410_spi_port_config,
> +                       .data =3D &s3c6410_spi_port_config,
>         },
>         { .compatible =3D "samsung,s5pv210-spi",
> -                       .data =3D (void *)&s5pv210_spi_port_config,
> +                       .data =3D &s5pv210_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos4210-spi",
> -                       .data =3D (void *)&exynos4_spi_port_config,
> +                       .data =3D &exynos4_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos7-spi",
> -                       .data =3D (void *)&exynos7_spi_port_config,
> +                       .data =3D &exynos7_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos5433-spi",
> -                       .data =3D (void *)&exynos5433_spi_port_config,
> +                       .data =3D &exynos5433_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynos850-spi",
> -                       .data =3D (void *)&exynos850_spi_port_config,
> +                       .data =3D &exynos850_spi_port_config,
>         },
>         { .compatible =3D "samsung,exynosautov9-spi",
> -                       .data =3D (void *)&exynosautov9_spi_port_config,
> +                       .data =3D &exynosautov9_spi_port_config,
>         },
>         { .compatible =3D "tesla,fsd-spi",
> -                       .data =3D (void *)&fsd_spi_port_config,
> +                       .data =3D &fsd_spi_port_config,
>         },
>         { },
>  };
> --
> 2.43.0.594.gd9cf4e227d-goog
>

