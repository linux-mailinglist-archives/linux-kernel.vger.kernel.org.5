Return-Path: <linux-kernel+bounces-39232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0283CD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC99929A8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C389D13666F;
	Thu, 25 Jan 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJdMDinM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F813664D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213391; cv=none; b=Ew0D9xFtvbWtic/uk1l8x/cEbjNGzF6EtC0XknMEls4QgGKApmRllA2gI4/TLB0PZWpBGrvXhYDbb00kP52dVDIUlPyvn9KEMLvP2gyIOfYlQ/7VFrHC1dkMX5WvIzDeD+SGiVfJwtoSwgz7ZdkslnLartZ/QBmMhjnhd9mq/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213391; c=relaxed/simple;
	bh=5cGXXrKqoeukbgGo952DirLmJH1RR6DCQpuh+hev/sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnoHgfBAf7kNamiBtIZH17A1K3WxIg0nr8/fov1b6PYztBDu6H7/QsBJ+kMGH8AI0FDbHzrvsX7VF6XekV48ORibA9J4mYQMaDIZL6ajI7yPl3ev/ZkXK8+LYNoguWu43PXD8FaIiZLmdcKwzRAP6IUY+E4xY336fdpwl/DSpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJdMDinM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d72f71f222so32873975ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706213389; x=1706818189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHqHxLkb1hywzmJ0hKTje+e39G/rmk5dGXSZnkMYEhE=;
        b=qJdMDinM3IuWioDPkNuITqxm8r9qzXzSG/k/6c0L4LuzpnHobxuaBqWeOvfbypu5bm
         OgIDmgcieYx84yW06eOymPr/dcIJ5QKEmqD1XBOpi9/KWMMUW44hkRR3AweMYX3/jtT9
         jpRKIuWaiKDdBTdg8aGgD00fAplrQIHEr52FRx7bmbe+2Xo6peOq3+GFL8SMUzmRD1po
         c8wDkzvp+rnsQtX//a1abgCiYmRRDKHg8JhsbFMx1pNeSMgYspRKrG5TcWF/2ZEzDNn6
         j5TXhD02JOOM0hXRyMOSOITrwQgyRI0N9AQYkGQi/bLCI9hDloR9LSDnoeFAYpRlTx7Y
         IYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213389; x=1706818189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHqHxLkb1hywzmJ0hKTje+e39G/rmk5dGXSZnkMYEhE=;
        b=K7vjSrrAS7E+iSaPWtdI41wMEyIgSoU2hWB4BK8wv8ucFsrTRCq72LWEdYfZSYhL/1
         XXGNpz0v4V0B4zw26EG/+GvZAnVHcgrRHEjdw9JDU/hMzaqLNLJRbCGCzbuv90FPTy9A
         iOsgNjmbXTtIXgyX//tMGnZPlRXC1VWARvmidXuuhcohxkKN3FFI46ZnLMgRUUPNJ3x2
         43MZoiF+6ydQvtbYPCHT4pfS8ef9PioHHmEJ04M7nrmH4FNL37hXNC4/2WsfSxc6vZyy
         JptPExO8k1MpZd5qESANeO3yCE/Zennb0bug6IRoPl11gIMfTYkr5VOPaL4po1jlFQ8i
         b9Pw==
X-Gm-Message-State: AOJu0YybAZ2HqKriuFhS1dDrCk1fsEMspRxblELrdswJzLCqlQWhkZzr
	OKM7CCQpOJYK5QPVpTLpGf+Em96L95qjCroto5OfyIOXDOO1tW5wCFOVIpECqm5e7+FvGoj05nG
	Qnp5oAf4iw8Kk+/HtdRK3jP1f5jUeqIXV1jRbbw==
X-Google-Smtp-Source: AGHT+IHVeildWvfGHdKxmcDztlboMhXAQHuVimKBzuEogXpGOXLpSYCQSwzr07F2VAol84VlLD5pI17OluDfry1agk8=
X-Received: by 2002:a17:903:2346:b0:1d7:3ad7:f24c with SMTP id
 c6-20020a170903234600b001d73ad7f24cmr239302plh.36.1706213388907; Thu, 25 Jan
 2024 12:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-12-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-12-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:09:37 -0600
Message-ID: <CAPLW+4=je3wEL_5YwvrRJmPcTDvo7=9maMWcs_WNaA2Bz6bTgg@mail.gmail.com>
Subject: Re: [PATCH v2 11/28] spi: s3c64xx: move common code outside if else
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
> Move common code outside if else to avoid code duplication.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b048e81e6207..107b4200ab00 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -286,20 +286,18 @@ static int prepare_dma(struct s3c64xx_spi_dma_data =
*dma,
>         if (dma->direction =3D=3D DMA_DEV_TO_MEM) {
>                 sdd =3D container_of((void *)dma,
>                         struct s3c64xx_spi_driver_data, rx_dma);
> -               config.direction =3D dma->direction;
>                 config.src_addr =3D sdd->sfr_start + S3C64XX_SPI_RX_DATA;
>                 config.src_addr_width =3D sdd->cur_bpw / 8;
>                 config.src_maxburst =3D 1;
> -               dmaengine_slave_config(dma->ch, &config);
>         } else {
>                 sdd =3D container_of((void *)dma,
>                         struct s3c64xx_spi_driver_data, tx_dma);
> -               config.direction =3D dma->direction;
>                 config.dst_addr =3D sdd->sfr_start + S3C64XX_SPI_TX_DATA;
>                 config.dst_addr_width =3D sdd->cur_bpw / 8;
>                 config.dst_maxburst =3D 1;
> -               dmaengine_slave_config(dma->ch, &config);
>         }
> +       config.direction =3D dma->direction;
> +       dmaengine_slave_config(dma->ch, &config);
>
>         desc =3D dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>                                        dma->direction, DMA_PREP_INTERRUPT=
);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

