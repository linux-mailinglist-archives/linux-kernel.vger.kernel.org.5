Return-Path: <linux-kernel+bounces-27715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB182F4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EF1F242D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02A1CF9C;
	Tue, 16 Jan 2024 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrMwwuI8"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F861CF82
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431135; cv=none; b=NJg6aPeEsAEvYZSYV/mPpPLQGNOaGW9H3Qhz92t49EN8U4zGDVay77mH+wperVwv2FEQhFyG7YuO1YRC1ZzGwbG+p9/xvVnSRcGbtV3bQj7pUCAWffoqobgu82DQMKjEvIt/gO3PTV54XnVD+iap2BmUADlTiyKL07gyx79Hdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431135; c=relaxed/simple;
	bh=/K8VPhKa0ZQLIT4I+YaGXUtaKJqi701MWyn53qqVPWI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hFh8IfJDRNxO9xj3ohj1nBmf+qrZIKFbLzxtdQQKGea8nSXKrRIxGgnf19m3N29utc/B6uXHICz5xn+zlmDEngFwy2LKpw2k/YQd7p/Qh+5TMdu4gEVDAaZYqheTvo5RIiQ9pUx0p+DkTMaj81+9JBnTb8UggKGYwOx9q3S3/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrMwwuI8; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so3731732a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705431133; x=1706035933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiEq2TIzBLf+TCDCHFATauUGuzABkkErqxkgwaaXJeo=;
        b=wrMwwuI8RUIcnh2KTX+ByqhOEme8pcHVUEQKYlWJEqsff7GajcuwNwrbXhfPCPxJo7
         /PuSDq77CszFQbJqHbRY3GxcXoe4tECLjt3H/9mIHsOS3DEWh3l1wxxe9dtTlpObdV0+
         QObr6NiqMoBF+t/suN072uTchOYXyrxRNk6o1NqZi/w2j5fCk53NApT/COKe9CAujkSE
         GjOq2Tks2WoCDSes9Q46OGtE/kvjOgdD8i4OYver09B+C11jDYbG3+5/MgOw9S70wcuN
         79puRRMGPLDNQO15uH4A2s9I5Atc+IuTpZJ0OR4dY1aITVEsOVvisjghfKKt1xIF4Zga
         s2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431133; x=1706035933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiEq2TIzBLf+TCDCHFATauUGuzABkkErqxkgwaaXJeo=;
        b=f/4uKPaKZSkiGBKj144l6wS6cdpISIErkI1+gR33WtEX72odJkeR4NzpQoJRxkEX/m
         +3pGxtrhcs1Ii31nipfE4gRFRqjrAs+fJV5E1TLmDd6fv3WZjoModbZ1ldp32PChkslq
         0ZAX+Vrhq5TInsn8H/6AyVYnJBrMeDJVC/XCkzuM/HdjxKmkVUhrFJbeQqSXIHMQZ688
         jEIXrZYxnwFsw0v18YUdQfpY/Pvel32ZZpcdmCZEYHxWZbdfU4OMFiVHMAh/4lY97jIq
         Dpu2P2KAcL+Ke9dyupclduPpM6I9ERmxyNPl9mxp0TYLYFFHK+PPkwAg8i1/Ms3JUrTS
         e71g==
X-Gm-Message-State: AOJu0YwbEcxlBWVDLmn9iyCZDVzemjaEU4vjJpiTvygQZCUN+/sJVC2n
	XEBfQEYvGJzcJkvGn2nMrTwZr3bu5p7G497c9nQmWkt4sTUYEg==
X-Google-Smtp-Source: AGHT+IHdCZd4ZqNmemGEvDzjokCVj4WZXw4hl6Tiw1c8DaYEhSVVgr3R/qzrTboYQEsCXmc7zuHIs6OPQiFIH8Yn004=
X-Received: by 2002:a17:90a:fb8a:b0:28b:187:2db with SMTP id
 cp10-20020a17090afb8a00b0028b018702dbmr4403962pjb.82.1705431133288; Tue, 16
 Jan 2024 10:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-14-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-14-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:52:02 -0600
Message-ID: <CAPLW+4nH0o4fsKTBwO6XwynK2DYCiMLMkmK7LgYepHc87jHJ5g@mail.gmail.com>
Subject: Re: [PATCH 13/18] tty: serial: samsung: return bool for s3c24xx_serial_txempty_nofifo()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:24=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> s3c24xx_serial_txempty_nofifo() returned either 0 or BIT(2), which is
> counterintuitive. Make the method return bool, and return true when TX
> is empty and false otherwise.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 46fba70f3d77..63e993bed296 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -236,9 +236,9 @@ static inline const char *s3c24xx_serial_portname(con=
st struct uart_port *port)
>         return to_platform_device(port->dev)->name;
>  }
>
> -static int s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
> +static bool s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
>  {
> -       return rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE;
> +       return !!(rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE);

If the function already returns bool, I'm not sure doing !! is
necessary. But I don't mind.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  }
>
>  static void s3c24xx_serial_rx_enable(struct uart_port *port)
> @@ -782,7 +782,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24=
xx_uart_port *ourport)
>                 ch =3D rd_reg(port, S3C2410_URXH);
>
>                 if (port->flags & UPF_CONS_FLOW) {
> -                       int txe =3D s3c24xx_serial_txempty_nofifo(port);
> +                       bool txe =3D s3c24xx_serial_txempty_nofifo(port);
>
>                         if (ourport->rx_enabled) {
>                                 if (!txe) {
> --
> 2.43.0.472.g3155946c3a-goog
>
>

