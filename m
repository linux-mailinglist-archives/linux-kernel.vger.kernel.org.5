Return-Path: <linux-kernel+bounces-23342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8985782AB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F06B21452
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCE611C8C;
	Thu, 11 Jan 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4R/cmbP"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411511722
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eaf2f00d1so1572e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704966831; x=1705571631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgQBYPpCMJHmwQQ7MSzJ01g6p5sRnkxOOVnMipT4Y9o=;
        b=M4R/cmbPPFMtheK6MY5VP8zGnWpdohfVWm+x9WKSvZF5WtWCuvkNo/2GI6PvmWFTMP
         saQTvRVOERWO+3jQA0hGSJa5Sw/92IyryAExdD++EtMw4lHXCrfurI5XoEzVuSTcuoZW
         bKfTBljLccXwTF+hIgor6mg3Rgg2uAJCuVbv1IUEbdkhbjtecdSPlhRSTPgZHCpHibAK
         9QtyyuF7TonUR57BYztpFGGqm3xSkukBNWwWU/bjNJlO0YDHkvd+hyQpk7OMChIfqGBS
         mcRQtW2d57URce4VlTarkTX8yf/LmzCKd3mSNG0y42cquGQ9DhVznWQZnlkdQs0xYZb3
         budw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704966831; x=1705571631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgQBYPpCMJHmwQQ7MSzJ01g6p5sRnkxOOVnMipT4Y9o=;
        b=K3kI52FU2o/xiCmUoIUoQhiKpJoiwSL/GsUp8khyBU9iHsNK/bZvRowbnwPfcH+mQz
         CYM3tUEUFIOpeC3bihci4lkyw0DnaZyjd1zFY9OGfwCERSY4WJI+ze1at33izx/hKmyE
         tNxFLJU5Py2TPUsgsRKlD1jiWBfmEKOD9OtntWR7DRd95Nu7Ke5coy1rYLOpHSjnLaAR
         tL7O5vw6Te0Cc5iHHX0L8rhMTy1OtvBfTcCgfTN6IMB4IdJvKNZRbQIGs7ocKV03Dcf2
         gfcRHMmP9teXcZKdcyErkyp9rr7GLFINSdRUU66OYc/dS9LobE34oBQIJfnPwfx/XyMN
         W+xQ==
X-Gm-Message-State: AOJu0Yz4P38BD2Afu/mV5xqoNQA4ya+3trjfMltjG0ZRTImuxZjFWgL7
	LK90h5tYmis8YdbwiHqevFfq9jXXlzIodc5B/TtiE0XPa0Q4
X-Google-Smtp-Source: AGHT+IFcPP/fziapp2cRbLUbIpvWNNm4ul19qV7vlrMJDwTWz429M1Mdty01i/XOSnrbItydGtslek/0jRKgNjOXwBI=
X-Received: by 2002:a05:6512:e90:b0:50e:6b4e:1bb9 with SMTP id
 bi16-20020a0565120e9000b0050e6b4e1bb9mr42600lfb.5.1704966831382; Thu, 11 Jan
 2024 01:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111002056.28205-1-mcpratt@pm.me>
In-Reply-To: <20240111002056.28205-1-mcpratt@pm.me>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Thu, 11 Jan 2024 15:23:39 +0530
Message-ID: <CAMTSyjrh8msOWqFu+0PYRVoy74Uubur-NV7nPY6AmhR_wx_Qfw@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND] serial: 8250: Set fifo timeout with uart_fifo_timeout()
To: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Wander Lairson Costa <wander@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 5:57=E2=80=AFAM Michael Pratt <mcpratt@pm.me> wrote=
:
>
> Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> reworked functions for basic 8250 and 16550 type serial devices
> in order to enable and use the internal FIFO device for buffering,
> however the default timeout of 10 ms remained, which is proving
> to be insufficient for low baud rates like 9600, causing data overrun.
>
> Unforunately, that commit was written and accepted just before commit
> 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> which introduced the frame_time member of the uart_port struct
> in order to store the amount of time it takes to send one UART frame
> relative to the baud rate and other serial port configuration,
> and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> which established function uart_fifo_timeout() in order to
> calculate a reasonable timeout to wait for all frames
> in the FIFO device to flush before writing data again
> using the now stored frame_time value and size of the buffer.
>
> Fix this by using the new function to calculate the timeout
> whenever the buffer is larger than 1 byte (unknown port default).
>
> Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.
>
> Signed-off-by: Michael Pratt <mcpratt@pm.me>
> ---
> v1 thread: https://lore.kernel.org/linux-serial/20231125063552.517-1-mcpr=
att@pm.me/
>
>  drivers/tty/serial/8250/8250_port.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 8ca061d3bbb9..777b61a79c5e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2076,7 +2076,10 @@ static void wait_for_lsr(struct uart_8250_port *up=
, int bits)
>  {
>         unsigned int status, tmout =3D 10000;
>
> -       /* Wait up to 10ms for the character(s) to be sent. */
> +       /* Wait for a time relative to buffer size and baud */
> +       if (up->port.fifosize > 1)
> +               tmout =3D jiffies_to_usecs(uart_fifo_timeout(&up->port));
> +
Michael, I have copied you onto a patch addressing the similar issue, where
it was considered to avoid the computation of timeout on call to wait_for_l=
sr.
>         for (;;) {
>                 status =3D serial_lsr_in(up);
>
> --
> 2.30.2
>
>
>

