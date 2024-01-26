Return-Path: <linux-kernel+bounces-40616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4F83E33B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2257E1F26DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5F22EFA;
	Fri, 26 Jan 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLiKPXkj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34550241F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300278; cv=none; b=hgNnEXjuV5Qd5f88FpRSB6Bvxru9v/YqbXRTfhiocwqyhZVtfh74kLwQL0GDnGZ/3fv5WGWl7t2HKbHWO3Vmv3q6Xp5zP2F9Pu52yycqH6wuOy/Zy/+z6V1AN77nERf1tyPkcGKadHezLgr7YAdN3RC3NKw/puzHAk+9Hn04L8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300278; c=relaxed/simple;
	bh=rpdW6PURYqzbeQ3X/TN6LDESW+qA+/o5fzR/Z99lIQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8xHfxEww2Nv7V14SxgNfQCNTV+iOHb/L6a9J7Lw/qFBq166N1liKeUxJl3EWOs3nErvSOrlRgdL24WlNon5+Z2XT0PMljFUgmScKMlRMMnx2V8G1QzaH656n6nfc5jBkIBGDv8CVXu0iI9l6yJXB6mzh3gT4xlzXC0MBKFsE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLiKPXkj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6daa89a6452so571746b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706300276; x=1706905076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY8f4fU4xwCCs2Pdc3Pqh77KDrWj9ON9heZB0LQFAlc=;
        b=SLiKPXkjzwrGU69bESZr0W2LNgbdVZqIU1Q5hq0t9Gb4gtuAIXohvs9thHdwpGf2DP
         YTK/P6Zw+dttvCGLzvQS7bKlgaey4sO/Y0QYhEinOvRbZBEwBKgFdCwd1xvia9Z5K+zd
         I8IAnzqAIoFNt/ln10I+thjY0NnK9X0vR3e+DSGy+YreiE1LYQYLpvcVC9y3UKn2beSo
         eXHuALnXb2gYupD0pNc0Kv6xgz2lrQ/e9qisAs6p9VOFGxzNWH1WX5kxyVhtn/SJkn6m
         y8WMF31W4FL6o7u6/xkgql34seVt/erduU+rJpQWq6wWD9MQ6mAJN7YtKgrFAdJaAP48
         Q6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300276; x=1706905076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY8f4fU4xwCCs2Pdc3Pqh77KDrWj9ON9heZB0LQFAlc=;
        b=r+EsGtpS3lps7sx2mFPzSRkkV9ddYrQI/ohBRn9mVKrgdtGtv2AACuq6DzFCiQzmcs
         CcBOsBreVairH6Iag5Y8rm2gX2Un/CM0oBduM3zM1DPBqDbaCSxTFmtxK9HN8pADG8lC
         sucbRYGX84fFaTebqsLHn9AAy3fqaeaQvsTk7HNX6nFjDrVE/O2gbWzmEDW2RDFlTmJA
         /NuFJrijZZ8MVvGVcK4zXl5rhgAv7DwOPxUk0t/O4UEqxNpxx2HxS9mIKAN+eSOiIsWr
         JVaEt67sm9HqH39kDepGPHWzVgdIZNZagJm45AbYyiKU6hGGr8fQ3dgTEqv5GzCCdnXG
         373w==
X-Gm-Message-State: AOJu0YzSnSPoC9GTD7N4S5u1OSziFXE4hKzxl2shYe6Ut938t7rdp4u6
	vci96V0+I7G41HKtNsm7TmU0s1VTe2xQ2AkylfoQV3E/Iec4MCO1vuRYQWSwNge2WDCt51dIkjC
	obiFEUEjTfG+geK3bdeCRI2yD0a5t/mSDzYcCXg==
X-Google-Smtp-Source: AGHT+IEVno4GW1APRXy6CPjOmvt3Vs5lrryB091gy4k1flSkZKDEqIxcbmIAdUm7FOOUCra4B7CAVfveGkTLIY2p1hk=
X-Received: by 2002:aa7:8699:0:b0:6da:84ae:c209 with SMTP id
 d25-20020aa78699000000b006da84aec209mr353702pfo.45.1706300276388; Fri, 26 Jan
 2024 12:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org> <20240126171546.1233172-7-tudor.ambarus@linaro.org>
In-Reply-To: <20240126171546.1233172-7-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 14:17:45 -0600
Message-ID: <CAPLW+4n3U99cm0Bv5XhceXyEtp4pTh1TWjtB1ci+f2fO+i1_ag@mail.gmail.com>
Subject: Re: [PATCH v3 06/17] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, jassi.brar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:15=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
> of_device_id::data is an opaque pointer. No explicit cast is needed.
> Remove unneeded (void *) casts in of_match_table. While here align the
> compatible and data members.
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 45 +++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index ccb700312d64..9bf54c1044b3 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1511,32 +1511,41 @@ static const struct platform_device_id s3c64xx_sp=
i_driver_ids[] =3D {
>  };
>
>  static const struct of_device_id s3c64xx_spi_dt_match[] =3D {
> -       { .compatible =3D "samsung,s3c2443-spi",
> -                       .data =3D (void *)&s3c2443_spi_port_config,
> +       {
> +               .compatible =3D "samsung,s3c2443-spi",
> +               .data =3D &s3c2443_spi_port_config,
>         },
> -       { .compatible =3D "samsung,s3c6410-spi",
> -                       .data =3D (void *)&s3c6410_spi_port_config,
> +       {

The braces style is not fixed. Yet that's a style patch, which on one
hand fixes the issue (unnecessary void * cast), but OTOH brings
another issue (non-canonical braces placement). Please see my comments
for your previous submission.

> +               .compatible =3D "samsung,s3c6410-spi",
> +               .data =3D &s3c6410_spi_port_config,
>         },
> -       { .compatible =3D "samsung,s5pv210-spi",
> -                       .data =3D (void *)&s5pv210_spi_port_config,
> +       {
> +               .compatible =3D "samsung,s5pv210-spi",
> +               .data =3D &s5pv210_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos4210-spi",
> -                       .data =3D (void *)&exynos4_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos4210-spi",
> +               .data =3D &exynos4_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos7-spi",
> -                       .data =3D (void *)&exynos7_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos7-spi",
> +               .data =3D &exynos7_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos5433-spi",
> -                       .data =3D (void *)&exynos5433_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos5433-spi",
> +               .data =3D &exynos5433_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos850-spi",
> -                       .data =3D (void *)&exynos850_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos850-spi",
> +               .data =3D &exynos850_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynosautov9-spi",
> -                       .data =3D (void *)&exynosautov9_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynosautov9-spi",
> +               .data =3D &exynosautov9_spi_port_config,
>         },
> -       { .compatible =3D "tesla,fsd-spi",
> -                       .data =3D (void *)&fsd_spi_port_config,
> +       {
> +               .compatible =3D "tesla,fsd-spi",
> +               .data =3D &fsd_spi_port_config,
>         },
>         { },
>  };
> --
> 2.43.0.429.g432eaa2c6b-goog
>

