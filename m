Return-Path: <linux-kernel+bounces-27717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B482F4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA1F2852E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350811CF9A;
	Tue, 16 Jan 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPW1C0Gj"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8F1CF82
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431298; cv=none; b=JSKuWrI3Em1EJpRkkBSvbOmY0MPlsuTXYJu/kbLhexQztHwpR5GKFLHZ7pv6Soqe28Axuf00XdP+I6EJp38wqk7gYdbPyA4f5nXAAD0W8NtWj+KBZkpD4gPqMv47g5At/frIvxxKRLyihjGnv0/CoSOO0ndD15Gh/lunzXpDHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431298; c=relaxed/simple;
	bh=AcaArvIGHBhawjXJC5ECINtq4Y4+SY0odW2qhBtPErc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=LKMsHIzyKRjNgULkOyKUrmVBZU6F8QrVzuLDp0JlNiOPp+KGoCfhN6Tv0GfUf6K2+1g7RT5reBtNvFfZI0MCDejrW3a7BN8hrNWvBpkfaOaWRqStY7OMfag+1+1/3CsXfXZCdAHWRUSitkAIHniSEaE6WTsrrpUE0U+FWUfqAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPW1C0Gj; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28e7933c317so724182a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705431296; x=1706036096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKWI3GBw8XVmkGMp4kp5cBnwP168mn/eNzlkwz0VmsY=;
        b=LPW1C0GjQTtRBXCTSL8vE54wbRZcUF2FCm90doXtgvTocIfBhx8nuai4B2e+JaoUZL
         3OpOvfyQD+yHxNDECrJ2fNg0i8uzvC0tkdgyO6AEhyyqitrWIqNcsNi0ChuGhR98poom
         5CMy4AkPP8fCMU3EJ1lNmKVpObw0D3i5pquVN4/ZznWjccaxss7lCadAA6tRrYOJvxHA
         CmKf6mqWGhPTuVb+fOLJDZYGIaLWwIHf7jQuxoRDY8NzmRGbS1lzCEfGbMYQj5EHias3
         C+e4xhI/zZmERz0G2RXhGEkJJszvKQ4iluCoFTWBdQ2dDEAaZjYEwY22dcCpSSOQoFWx
         /Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431296; x=1706036096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKWI3GBw8XVmkGMp4kp5cBnwP168mn/eNzlkwz0VmsY=;
        b=eZ3DJHjsqhKwGQG9GAtQM+O2e/HRw5DOjrGUzfj37Li2poW7Y51DVmdHfVj9ek/fuP
         Ckoiumcylf4zrvKriDTpDNTg6QRs9i9ynsUJsN7uRIDe3AHs0XM1hWQ3E9Jb3CBWbiGu
         aPO9VEselezae+Z+N+ITQjqG8PBJXBs7LaG0TaBsGfIc8v0wnonT/BWUyx1F3t0ZmvXx
         0jYZmyNsgL5fkxz3w76P1QwbrBIVRmg42+jej6FwymOPIqoMv0VP/A+yD/qbWotYYFan
         8Bw9q+r4CwUMAGzyVgTX57/9G3mFmKtg15JMoLCAi++aMmq2D3XtyXp850PyPrjldlao
         yEbQ==
X-Gm-Message-State: AOJu0YxltkTQpcAJ07taknNX2a3kwYzkp3Rh/IDFRWO8GPNwkEYVT3cm
	7hEqfqCwXxbPFPZCzDyrn8t3bLf//9G76kIAndwwjZudOendvw==
X-Google-Smtp-Source: AGHT+IEFtoFGlnGt6DKWSN181qFbFfM7zhz4boriHOhF5W2AqSgVEM830AlQr0zgGUviJ0so7F2IEofXyY64Nwjuneo=
X-Received: by 2002:a17:90a:3484:b0:28e:79a4:979c with SMTP id
 p4-20020a17090a348400b0028e79a4979cmr982068pjb.58.1705431296571; Tue, 16 Jan
 2024 10:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-15-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-15-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:54:45 -0600
Message-ID: <CAPLW+4=O2OaDsC7KNeLPt4UC-OLjD3_VVL1xL6PnrOBPUmcDrw@mail.gmail.com>
Subject: Re: [PATCH 14/18] tty: serial: samsung: return bool for s3c24xx_serial_console_txrdy()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:25=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> s3c24xx_serial_console_txrdy() returned just 0 or 1 to indicate whether
> the TX is empty or not. Change its return type to bool.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 63e993bed296..37c0ba2a122c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2183,7 +2183,7 @@ static const struct dev_pm_ops s3c24xx_serial_pm_op=
s =3D {
>
>  static struct uart_port *cons_uart;
>
> -static int
> +static bool
>  s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
> @@ -2193,13 +2193,13 @@ s3c24xx_serial_console_txrdy(struct uart_port *po=
rt, u32 ufcon)
>                 /* fifo mode - check amount of data in fifo registers... =
*/
>
>                 ufstat =3D rd_regl(port, S3C2410_UFSTAT);
> -               return (ufstat & info->tx_fifofull) ? 0 : 1;
> +               return !(ufstat & info->tx_fifofull);
>         }
>
>         /* in non-fifo mode, we go and use the tx buffer empty */
>
>         utrstat =3D rd_regl(port, S3C2410_UTRSTAT);
> -       return (utrstat & S3C2410_UTRSTAT_TXE) ? 1 : 0;
> +       return !!(utrstat & S3C2410_UTRSTAT_TXE);

Again, personally I think !! is just clutters the code here, as the
function already returns bool. Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  }
>
>  static bool
> --
> 2.43.0.472.g3155946c3a-goog
>
>

