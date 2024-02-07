Return-Path: <linux-kernel+bounces-56735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ABF84CE55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F13C1F26AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41787FBC9;
	Wed,  7 Feb 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELlOjE0w"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE347FBD8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320680; cv=none; b=rmdk3zqu3CI7KKvgs25wtxHMSCy2x1OUhaGb0mDDbUE6tzCB3LXKDSGbNOwJ/u7ZvuBJs1aO244129Kj7RblapJ0bFF2SIMqq0GJSOnYxPQLLN6CpiOI1QI5VX3agV1GQHpj2hh3BLcxZ3ZrsIaQxrNkaL6Cja2SIfSkZJRXnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320680; c=relaxed/simple;
	bh=hkvLvW5bir63qGmigcs+g/1lCwmcJeYVQAJXfmIzNFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCmxrqqpulamP3EZeNO1fuzLyMpUnOeqPaie93z/PjemANdkNelCHtjz/bKjgNfHtESfrvii15KdhSqNM9nxjbb+uE62dAHki0uxpfNBCSdeO2bTdKviVr0FxkjeOsF0PkuhrMQoLlMJ/5wPhr6gLuSD/IunWgC9cJNmnoHsP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ELlOjE0w; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2909a632e40so566721a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707320678; x=1707925478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjM9X4mSlwFPt/1gwrjtYdpsyoYU4c7cfCOblUpLYMA=;
        b=ELlOjE0wWbwSKt/f2BcpxFm3rpijzImxHkj9nGQ8AI4x4GBlVFDRoxLbNchWSBOC0g
         O8S+6jcpFpdMA19jcPKtIYfezGgfNYmW0QuWvqeFRTDezY9T+gGG9c71LLmY/wGCpEws
         x+xQ+3+lrGW/9NkSaXqr/1xX11kbaqTBs3JRi8XavDC2PSaZots4iL8dHJBEcP95vUDV
         aTiSJbQ0PeuYWghvxZ+ovg6UhHXC8NsMPdlTyvJG3seWyGKtNNr4TS6Rw589owarxAl4
         pFmPbBkxRF7esKLP6o9Jk7MHddmLhP7kS2IVGkv8FI1ZKEpgHFjfAWNeK3fzqfytiKSi
         NuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320678; x=1707925478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjM9X4mSlwFPt/1gwrjtYdpsyoYU4c7cfCOblUpLYMA=;
        b=PRCwokwQRsqWU/9vd7CWNcVqQUqXNLdvAo/ashwFaDBU0AOD6hDYj7dSNXRgX1UFLJ
         vCktO+KXG6OIZAok+PHxYeq2uFoLD4tYWsMVQ+2gRtLSkjgFH37vSiqclK1RzbkbMoKl
         J8/TMO7v67692FV9W4v7X5BdPi/joz+4a+B36OlkkSx+hbEJFJoOsSW6gtX8elH6BfES
         0isfw1GPlreT6i45QKh47J40v1KWIjbBnS5jsO+8PoUI0Fetl2yR78pRF8PRprX/Eog3
         boXND2OeqD301aPPb/kA37f3CN38cXBmfIBFJzkAyvxAVHAyd2RgrVPVU/NIMUWcoFZP
         gP2A==
X-Gm-Message-State: AOJu0YxqNM2FiWV0yzz0nFtKmuRHrt2OsZqcqQxu5t5lmS9cLKnACiCz
	4YK1HnBYydGwOI2IUtO9IF6t+OG6+xnB8j1Mbv8ZIYiJDQqEp/07IiaZNh42IhRGPXBic9Vst2N
	16wczlEM76Fxm07v+9Nbsyt16Vc/40DbIkr9KAw==
X-Google-Smtp-Source: AGHT+IEOlo/KPrp4YPJuYvFD5Blwu/nidyNMltgHO7/0dpAc6+9Bv8bsnV+2FJETRdJtJxCs7qFvqtu+bC4a80lxed0=
X-Received: by 2002:a17:90b:4c85:b0:296:2057:28c with SMTP id
 my5-20020a17090b4c8500b002962057028cmr3040845pjb.31.1707320677939; Wed, 07
 Feb 2024 07:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207111516.2563218-1-tudor.ambarus@linaro.org> <20240207111516.2563218-3-tudor.ambarus@linaro.org>
In-Reply-To: <20240207111516.2563218-3-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 7 Feb 2024 09:44:27 -0600
Message-ID: <CAPLW+4nyYxeZcvmrK8FJ4cvpxOs4=mPzBC5JcCPB5yNBNqkVAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: prepare for a different flavor of
 iowrite rep
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:15=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> There are SoCs (gs101) that allow only 32 bit register accesses. As the
> requirement is rare enough, for those SoCs we'll open code in the driver
> some s3c64xx_iowrite{8,16}_32_rep() accessors. Prepare for such addition.
>
> Suggested-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 7f7eb8f742e4..eb79c6e4f509 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -414,6 +414,26 @@ static bool s3c64xx_spi_can_dma(struct spi_controlle=
r *host,
>
>  }
>
> +static void s3c64xx_iowrite_rep(const struct s3c64xx_spi_driver_data *sd=
d,
> +                               struct spi_transfer *xfer)
> +{
> +       void __iomem *addr =3D sdd->regs + S3C64XX_SPI_TX_DATA;
> +       const void *buf =3D xfer->tx_buf;
> +       unsigned int len =3D xfer->len;
> +
> +       switch (sdd->cur_bpw) {
> +       case 32:
> +               iowrite32_rep(addr, buf, len / 4);
> +               break;
> +       case 16:
> +               iowrite16_rep(addr, buf, len / 2);
> +               break;
> +       default:
> +               iowrite8_rep(addr, buf, len);
> +               break;
> +       }
> +}
> +
>  static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>                                     struct spi_transfer *xfer, int dma_mo=
de)
>  {
> @@ -447,20 +467,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_sp=
i_driver_data *sdd,
>                         modecfg |=3D S3C64XX_SPI_MODE_TXDMA_ON;
>                         ret =3D prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
>                 } else {
> -                       switch (sdd->cur_bpw) {
> -                       case 32:
> -                               iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len / 4);
> -                               break;
> -                       case 16:
> -                               iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len / 2);
> -                               break;
> -                       default:
> -                               iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len);
> -                               break;
> -                       }
> +                       s3c64xx_iowrite_rep(sdd, xfer);
>                 }
>         }
>
> --
> 2.43.0.687.g38aa6559b0-goog
>

