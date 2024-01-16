Return-Path: <linux-kernel+bounces-27664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD782F3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795B0B23D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E31CD24;
	Tue, 16 Jan 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMPBpuw6"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEB1D68D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428777; cv=none; b=pb6p1fNn1D89bTZ+rhU2LcIJ33hq8d0vJwUXOE23Aq3C+gF21ww2x/X0YrA2ZXzr296lpuEDTkl7JZvz1mAILhu2TO0Ws/FyaCilH6vmtwC9WB8UZs6Md1wQYNFG9D6GQ/7CZQUr4wXPVNZm8NvKhBQHo2u8VAxqg2az9QKbApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428777; c=relaxed/simple;
	bh=SG8DiOf3cYorQyJYENvv92rI8GgMIqPPsIjXOT8ucX8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ns1RsMV0ETuuO4CaxPDlC8x0l8p7fyVIF48xTwUHAsqubQTHYXmw24D6djdOCQ64zIIsWn248F+c+VMbuqcdzIY7rI1VnqATLemx/lzoRiSvpsJc9g6TLouycens13Xtb+xosm3Vfbdh8c0r/yIWsQpUdrX1Go1PyYTQCN3NBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMPBpuw6; arc=none smtp.client-ip=209.85.166.52
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bf2c826a5aso180382639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428775; x=1706033575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1zy9rBSl9mQ2yLGmosPPGFWim7xQyqanbh7O2L48e4=;
        b=tMPBpuw6J25AWJqaH3VYuSqgqWaluOAmwpDo6iVDur0RhyIZ5fply6x84Rh1PqaKHX
         J80mitc1EZVsYLXh5j0CzBviaezOsdAzjqA6l1kiCMjI5l9Z8WcvKC6da+k2wJNN1/ns
         0zNCJp931nPdneMdBORTMjyeURenININ/ZKoEQ7+LBmtnY9blP6+Z1dh74wPfAuvp/X5
         VCKz0gV7WslOvEQRMMYy6M8vUid4zs7Ltk7+NiN+8AWZBkkqJgbfGOc+jc+zRBUgS9Zv
         hZjPvNGySk/yIyUr1s4WkzWXrRhSN8lZv1D3xxgafkd9IIz2q9BvEIU2kn7jo2pv+/6A
         M4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428775; x=1706033575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1zy9rBSl9mQ2yLGmosPPGFWim7xQyqanbh7O2L48e4=;
        b=N2lL0sSALgUDtRoHYPDIh9dFvjkkm4yh/09QjDzMuA4j0+XjRV2unRsEV7GrjeVtkR
         loaLj6nmUnZNsjNzcnHy2QVHmT4ePxwGraVEempwK+xFutgBxwG1rIJ9mo8xeExTxh0S
         mJz/Ziv+1ztT/OeMKkZDJnN0C267sJ1wY0wRcjWJo624Kn2cHN+SUfpY+iLxdL6ZzVpS
         O8o4MrKbbyLdsi5iYVWsHVjw0DvEOe6hw+cRVHPD+b+vLfGL8OAEEKZBYSBP+3CfebOs
         gRCsg6m/t4wddQ+L0XQ2GEKkQrTmKXWLA03+WfNr8WO1yrxSgpus2b0w9nVG7ESU4SRJ
         u2Pg==
X-Gm-Message-State: AOJu0YzsgMxIyKN4WKFMEGU5OKQw+n1iTYH+WqKObBLEqtxw4quXra0b
	eRyUDBN+psRfw1luBc5uSL1W6Ta168/Qnn8hQMtK/d17AoI/qw==
X-Google-Smtp-Source: AGHT+IGQzMbiCpfyKCirJEubGfS3LEcjdBd2HSiutokrb/hXgwLKsqATMushPZrWZOqX0cVlmY8vB9FfbIMTpQdlzfU=
X-Received: by 2002:a6b:6c07:0:b0:7be:e783:850e with SMTP id
 a7-20020a6b6c07000000b007bee783850emr8915152ioh.39.1705428775466; Tue, 16 Jan
 2024 10:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-3-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-3-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:12:44 -0600
Message-ID: <CAPLW+4kgfvp93O9ehZrnA5qTd7YO0Ln+S06OCiGVk=kNNf8rHA@mail.gmail.com>
Subject: Re: [PATCH 02/18] tty: serial: samsung: set UPIO_MEM32 iotype for gs101
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:21=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> GS101's Connectivity Peripheral blocks (peric0/1 blocks) which
> include the I3C and USI (I2C, SPI, UART) only allow 32-bit
> register accesses.
>
> Instead of specifying the reg-io-width =3D 4 everywhere, for each node,
> the requirement should be deduced from the compatible.
>
> Infer UPIO_MEM32 iotype from the "google,gs101-uart" compatible.
> Update the uart info name to be GS101 specific in order to
> differentiate from the other exynos platforms. All the other settings
> are not changed.
>
> exynos_fifoszdt_serial_drv_data was replaced by gs101_serial_drv_data
> because the iotype restriction is gs101 specific and there was no other
> user of exynos_fifoszdt_serial_drv_data.
>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 38 +++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index b8fe9df20202..20ec6ef1a52f 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2495,25 +2495,43 @@ static const struct s3c24xx_serial_drv_data exyno=
s850_serial_drv_data =3D {
>         .fifosize =3D { 256, 64, 64, 64 },
>  };
>
> -/*
> - * Common drv_data struct for platforms that specify samsung,uart-fifosi=
ze in
> - * device tree.
> - */
> -static const struct s3c24xx_serial_drv_data exynos_fifoszdt_serial_drv_d=
ata =3D {
> -       EXYNOS_COMMON_SERIAL_DRV_DATA(),
> +static const struct s3c24xx_serial_drv_data gs101_serial_drv_data =3D {
> +       .info =3D {
> +               .name           =3D "Google GS101 UART",
> +               .type           =3D TYPE_S3C6400,
> +               .port_type      =3D PORT_S3C6400,
> +               .iotype         =3D UPIO_MEM32,
> +               .has_divslot    =3D 1,
> +               .rx_fifomask    =3D S5PV210_UFSTAT_RXMASK,
> +               .rx_fifoshift   =3D S5PV210_UFSTAT_RXSHIFT,
> +               .rx_fifofull    =3D S5PV210_UFSTAT_RXFULL,
> +               .tx_fifofull    =3D S5PV210_UFSTAT_TXFULL,
> +               .tx_fifomask    =3D S5PV210_UFSTAT_TXMASK,
> +               .tx_fifoshift   =3D S5PV210_UFSTAT_TXSHIFT,
> +               .def_clk_sel    =3D S3C2410_UCON_CLKSEL0,
> +               .num_clks       =3D 1,
> +               .clksel_mask    =3D 0,
> +               .clksel_shift   =3D 0,
> +       },
> +       .def_cfg =3D {
> +               .ucon           =3D S5PV210_UCON_DEFAULT,
> +               .ufcon          =3D S5PV210_UFCON_DEFAULT,
> +               .has_fracval    =3D 1,
> +       },
> +       /* samsung,uart-fifosize must be specified in the device tree. */
>         .fifosize =3D { 0 },
>  };
>
>  #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
>  #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
>  #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
> -#define EXYNOS_FIFOSZDT_DRV_DATA (&exynos_fifoszdt_serial_drv_data)
> +#define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
>
>  #else
>  #define EXYNOS4210_SERIAL_DRV_DATA NULL
>  #define EXYNOS5433_SERIAL_DRV_DATA NULL
>  #define EXYNOS850_SERIAL_DRV_DATA NULL
> -#define EXYNOS_FIFOSZDT_DRV_DATA NULL
> +#define GS101_SERIAL_DRV_DATA NULL
>  #endif
>
>  #ifdef CONFIG_ARCH_APPLE
> @@ -2601,7 +2619,7 @@ static const struct platform_device_id s3c24xx_seri=
al_driver_ids[] =3D {
>                 .driver_data    =3D (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DA=
TA,
>         }, {
>                 .name           =3D "gs101-uart",
> -               .driver_data    =3D (kernel_ulong_t)EXYNOS_FIFOSZDT_DRV_D=
ATA,
> +               .driver_data    =3D (kernel_ulong_t)GS101_SERIAL_DRV_DATA=
,
>         },
>         { },
>  };
> @@ -2624,7 +2642,7 @@ static const struct of_device_id s3c24xx_uart_dt_ma=
tch[] =3D {
>         { .compatible =3D "axis,artpec8-uart",
>                 .data =3D ARTPEC8_SERIAL_DRV_DATA },
>         { .compatible =3D "google,gs101-uart",
> -               .data =3D EXYNOS_FIFOSZDT_DRV_DATA },
> +               .data =3D GS101_SERIAL_DRV_DATA },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
> --
> 2.43.0.472.g3155946c3a-goog
>
>

