Return-Path: <linux-kernel+bounces-27663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C682F3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E14E287D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0C1D540;
	Tue, 16 Jan 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEXjQx4f"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68961D53D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428763; cv=none; b=EkXYXJqXGT9MtDDlwPvZgOJQTc8tBZ3uOpsgDByR6A0Elpn39KD8mspI+ynD/gmS7x4QfiZi0fc8bMCs9xrv89Kjy4pqww1vrBhRAAY8h4KDNte82VCnTa9xpUy0YuIAULmAzTcQp44Mpp8NUn9LzAIMWjc3GwLqtNKQ3fVdXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428763; c=relaxed/simple;
	bh=ZbOM1bu5cjFjk4zYWaRFdyLilrDy9vA0J/xM/tBuRRQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=MVpt6V2/S6bI4iy0TmQ+y/AOTqw97CZi6nu9iRnIc+SheNsXMuP5yn/b+iymqWElZUn2Y7GJuHw2mkKXaYBINggN5BEEuqlr2LzIRUsxV9HUmW4Opp9viIclJnXhvupCzPpk34pG4ddDd431Lj8WMAnrlORGhu3YpRQQ6t3/nyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEXjQx4f; arc=none smtp.client-ip=209.85.166.45
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bf617dcedaso5603639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428761; x=1706033561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsw0Y1ya1uuqQW7F3Kv8ai7chNdrtK1tF8GNiYzbLyY=;
        b=IEXjQx4fFr9GWrfwtHpDJIXIOqTSsrYEaMQZQalgteHcsIwrDTfL4bDNIskfS0JmnX
         aeKeg+uVybK/hZjzmpwBIxoGNQOV+pmBJ0kc0tB03DopO9M+pCEkMBAec1wQFap1ocEc
         2oihUDkFfAPIRmzj3tOoMDyvMTe8JQrFMChpnjgTEyfQPlSj9yBuUW5lETE4FAW5Oatb
         s4Fb41YToIQXEDH5pNaGQQSSMHsHOdi3tFD8uD2UbbNuMAgRlpgKjAk6K0hZawnbgBQd
         iY8RXofmM8Sg5Q1xFVYPRVNPJ7RP3jAmwpNMt/d0RyMdoGe8CAR4Hmezyxpe9KjLhldu
         xtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428761; x=1706033561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsw0Y1ya1uuqQW7F3Kv8ai7chNdrtK1tF8GNiYzbLyY=;
        b=P3acdubxrXh0iPUOTsNvSYN3vecmS1W+sC6OfWMCGqOWRu6ppabL2j01ofBucn8Z2p
         88H+LeB+39FPlkev7+vJF2yyTYuVFWKTa5XNIWUhdtVe2gDu/VWxnOSy8dcEMphmpfOZ
         wE4NmALm8aDYcodhPrT1perj+TR6MC3gixXXANkCPiAtjDXqfwDQK5QCkTAtDhv5F6Co
         zN15fG0zjMkB2ILUyASZ+2GxKaP1sihSwEClzk/x4p6evdxOZ3IIbmwiFPO+fFyyVJCI
         ZPbGgsgZEaIlWPbhHxOZD1VC88zMq/s7/CDKywG3hx23uVxrcrA46gjeKC52cY7m9m4f
         uPvA==
X-Gm-Message-State: AOJu0Yzc8wZn1MY3qi2uP0uhLCY4k/NP9GL1iFy6jgRD3ie9ko1p3GSp
	FpU5GOdKx+Qn55XatoJIUIY8OYUS/k9UMsCO68QE0HSarfoOvg==
X-Google-Smtp-Source: AGHT+IHsTZN8Hh2PBiqRYmvVF1oqi281eXU5A/Ytv6gA5Rfcjg510T4d0Xlr9PLKT5w/4djQJrnCcPZkqN7Sx16pNBE=
X-Received: by 2002:a05:6602:42d6:b0:7be:fac5:76a5 with SMTP id
 ce22-20020a05660242d600b007befac576a5mr9115659iob.43.1705428760966; Tue, 16
 Jan 2024 10:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-2-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:12:29 -0600
Message-ID: <CAPLW+4ndoSq-u7=m40BXrDHa20eyUrNq1-RMwtJJDdXGLBWUWg@mail.gmail.com>
Subject: Re: [PATCH 01/18] tty: serial: samsung: prepare for different IO types
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
> register accesses. If using 8-bit register accesses, a SError
> Interrupt is raised causing the system unusable.
>
> Instead of specifying the reg-io-width =3D 4 everywhere, for each node,
> the requirement should be deduced from the compatible.
>
> Prepare the samsung tty driver to allow IO types different than
> UPIO_MEM. ``struct uart_port::iotype`` is an unsigned char where all
> its 8 bits are exposed to uapi. We can't make NULL checks on it to
> verify if it's set, thus always set it from the driver's data.
> Use u8 for the ``iotype`` member of ``struct s3c24xx_uart_info`` to
> emphasize that the iotype is an 8 bit mask.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 71d17d804fda..b8fe9df20202 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -84,6 +84,7 @@ struct s3c24xx_uart_info {
>         unsigned long           clksel_mask;
>         unsigned long           clksel_shift;
>         unsigned long           ucon_mask;
> +       u8                      iotype;
>
>         /* uart port features */
>
> @@ -1742,7 +1743,6 @@ static void s3c24xx_serial_init_port_default(int in=
dex) {
>
>         spin_lock_init(&port->lock);
>
> -       port->iotype =3D UPIO_MEM;
>         port->uartclk =3D 0;
>         port->fifosize =3D 16;
>         port->flags =3D UPF_BOOT_AUTOCONF;
> @@ -1989,6 +1989,8 @@ static int s3c24xx_serial_probe(struct platform_dev=
ice *pdev)
>                 break;
>         }
>
> +       ourport->port.iotype =3D ourport->info->iotype;
> +
>         if (np) {
>                 of_property_read_u32(np,
>                         "samsung,uart-fifosize", &ourport->port.fifosize)=
;
> @@ -2399,6 +2401,7 @@ static const struct s3c24xx_serial_drv_data s3c6400=
_serial_drv_data =3D {
>                 .name           =3D "Samsung S3C6400 UART",
>                 .type           =3D TYPE_S3C6400,
>                 .port_type      =3D PORT_S3C6400,
> +               .iotype         =3D UPIO_MEM,
>                 .fifosize       =3D 64,
>                 .has_divslot    =3D 1,
>                 .rx_fifomask    =3D S3C2440_UFSTAT_RXMASK,
> @@ -2428,6 +2431,7 @@ static const struct s3c24xx_serial_drv_data s5pv210=
_serial_drv_data =3D {
>                 .name           =3D "Samsung S5PV210 UART",
>                 .type           =3D TYPE_S3C6400,
>                 .port_type      =3D PORT_S3C6400,
> +               .iotype         =3D UPIO_MEM,
>                 .has_divslot    =3D 1,
>                 .rx_fifomask    =3D S5PV210_UFSTAT_RXMASK,
>                 .rx_fifoshift   =3D S5PV210_UFSTAT_RXSHIFT,
> @@ -2457,6 +2461,7 @@ static const struct s3c24xx_serial_drv_data s5pv210=
_serial_drv_data =3D {
>                 .name           =3D "Samsung Exynos UART",        \
>                 .type           =3D TYPE_S3C6400,                 \
>                 .port_type      =3D PORT_S3C6400,                 \
> +               .iotype         =3D UPIO_MEM,                     \
>                 .has_divslot    =3D 1,                            \
>                 .rx_fifomask    =3D S5PV210_UFSTAT_RXMASK,        \
>                 .rx_fifoshift   =3D S5PV210_UFSTAT_RXSHIFT,       \
> @@ -2517,6 +2522,7 @@ static const struct s3c24xx_serial_drv_data s5l_ser=
ial_drv_data =3D {
>                 .name           =3D "Apple S5L UART",
>                 .type           =3D TYPE_APPLE_S5L,
>                 .port_type      =3D PORT_8250,
> +               .iotype         =3D UPIO_MEM,
>                 .fifosize       =3D 16,
>                 .rx_fifomask    =3D S3C2410_UFSTAT_RXMASK,
>                 .rx_fifoshift   =3D S3C2410_UFSTAT_RXSHIFT,
> @@ -2546,6 +2552,7 @@ static const struct s3c24xx_serial_drv_data artpec8=
_serial_drv_data =3D {
>                 .name           =3D "Axis ARTPEC-8 UART",
>                 .type           =3D TYPE_S3C6400,
>                 .port_type      =3D PORT_S3C6400,
> +               .iotype         =3D UPIO_MEM,
>                 .fifosize       =3D 64,
>                 .has_divslot    =3D 1,
>                 .rx_fifomask    =3D S5PV210_UFSTAT_RXMASK,
> --
> 2.43.0.472.g3155946c3a-goog
>
>

