Return-Path: <linux-kernel+bounces-39244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7583CD63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C47E1C235BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71D137C3F;
	Thu, 25 Jan 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nwwzl74i"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94F137C20
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214311; cv=none; b=sbdazItsQRi10A0Oi83H/gIbw5jtrCFbG/yTTAofzPI8/lQhspJrkZzyROv/f4eDsGGLiD1IPBXp9KK+oqnMf9PWnsD/VEGFXQmPb35Ev/uXwXlwe/aU1EvTPiaBUjClvhzABC3TdaWE0rSLBsqVdb/5N31Rb/fHWPjNvXBdlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214311; c=relaxed/simple;
	bh=QMJU6URIKYk7AaGLODC/jjsXVBRijeTjUJ1oKlfR3K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tdfis8/TP4hgcjNCeuxpTkx0lHzphN9quMm03Wtba74t4b1v9So5Hyt9amotRIkhQbz6ReclceiWMcsj9iWdNSYqHSXqqoZrk5jf9eVvR0KG+Gt9u3YGqZWYJ0dyeq76l1t1tdgjWo6noR2JUU54+gIPJsFIMVvGUYXkokyug8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nwwzl74i; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d62aab8fecso1073781a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706214309; x=1706819109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaxY27IhcgcbXrkepc9FHJUpKGy9Xey/yg5kDXIpb4c=;
        b=Nwwzl74iro5zwk39uZkmov2Yr/LqZAcpWwNekYaJQUGVdBooQGCVBmK+vWPC+4mFFt
         xI1x947Om8quaTCo9k/SCYiNv59wP3XYglvLvLpTp6SE7+M0l5Qz0H4wq5TbCzlLj0Lz
         jK9B1chfg++uVyA6OlCuQp+jS57s2MYhdMsRhLbm8lO1F0u2RTYpNIHvi10x7vE726tc
         a9VLuImINMgC4x/E6CDcX8mWD3Onfj5nkfwmGeQAtUkNo3XbFrGOgBwrHuzz6SvSOr1t
         hbPdKQIkMpbqqo8YpLR4/W8g5g5TX6RVuFPjlN5wvYeJmrYTsnTOOIfWg/kzYezBUteG
         nE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706214309; x=1706819109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaxY27IhcgcbXrkepc9FHJUpKGy9Xey/yg5kDXIpb4c=;
        b=RsnT12XAfp69s9rRan2XbpNV0EPaAH6ftEVw+QTmlDbvPznmkQdXdGkhpQpt6ZFIcL
         rcH8Fd9EAWqYmy6CTNsuKR8q6kpJPzcHsdYZbqEQ2SAPXswpdVT7NimQ/WAOucTNnlhv
         wr9WmjhSofSROa3gvyhTmZkWezm/oowADigyKu3halPXEDpbIU+jqI8v8IF/HGQpI6Te
         /ZDDn7V9NTLO0GWAHI0k4UopOxhWic2AuanZ6GvfdIPYrV3hy4N9Ivg1o6Xu+3UuYY4O
         MCE5BGS1IfhBgTzWj64f2qFkHKMrMdankMtCg3n/cNqXA0WNsy5U99nOUIkY+LEny8WO
         r1Fg==
X-Gm-Message-State: AOJu0Yw+rgjIEplqzZqDrstMTSAexplH2EjyCZlB2/TZuLu+QzrVOnJh
	BiYeJJfeQIGDeMeVbo5KzSwBhrcZYtPFRjdCgVk7bEw3F5MdjFnBoFH+yOD4p1AujaDjQGdw+/j
	O6gaHeadSxfg+x8WNJbEEK493U1lIHoOlXZNWZw==
X-Google-Smtp-Source: AGHT+IFb6esBMXgIN6eJVdeTHuH7VuUDww4b7lmtscjFNG2s6JBRpL/mLqpy1bnm9qR62+/gT5NooL9ZgsRZaHpDQbA=
X-Received: by 2002:a17:90a:c503:b0:28b:2f4f:75e7 with SMTP id
 k3-20020a17090ac50300b0028b2f4f75e7mr163034pjt.13.1706214309739; Thu, 25 Jan
 2024 12:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-15-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-15-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:24:58 -0600
Message-ID: <CAPLW+4k8FvdnMmN-7CbvFG2matiKwDBDT_LM++O5HpnmctHnSw@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
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
> Don't monopolize the name. Prepend the driver prefix to the function
> name.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 25d642f99278..447320788697 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -273,8 +273,8 @@ static void s3c64xx_spi_dmacb(void *data)
>         spin_unlock_irqrestore(&sdd->lock, flags);
>  }
>
> -static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
> -                       struct sg_table *sgt)
> +static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
> +                              struct sg_table *sgt)
>  {
>         struct s3c64xx_spi_driver_data *sdd;
>         struct dma_slave_config config;
> @@ -440,7 +440,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi=
_driver_data *sdd,
>                 chcfg |=3D S3C64XX_SPI_CH_TXCH_ON;
>                 if (dma_mode) {
>                         modecfg |=3D S3C64XX_SPI_MODE_TXDMA_ON;
> -                       ret =3D prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
> +                       ret =3D s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->=
tx_sg);
>                 } else {
>                         switch (sdd->cur_bpw) {
>                         case 32:
> @@ -472,7 +472,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi=
_driver_data *sdd,
>                         writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
>                                         | S3C64XX_SPI_PACKET_CNT_EN,
>                                         regs + S3C64XX_SPI_PACKET_CNT);
> -                       ret =3D prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
> +                       ret =3D s3c64xx_prepare_dma(&sdd->rx_dma, &xfer->=
rx_sg);
>                 }
>         }
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

