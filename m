Return-Path: <linux-kernel+bounces-27711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8828A82F48B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E40D284FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81541CF96;
	Tue, 16 Jan 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/VmS92e"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A321CF87
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430830; cv=none; b=TjUKRVxYYEVyQTTDGLTaBUl/p05VG1hG4DK3ebS1/RJ3NDkZNgV34CZrjs/+h3b1NJIUVJV4aISpNEm8Oxbwynrrj7R63Px0mcS2x/KGKE2/kszfgfhdcoxtfaTYd3GC0oR2vWynDLM7PlklY1vfrXV6T2RzJ/CGgFZ64hADAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430830; c=relaxed/simple;
	bh=gKxv+UOkndb8j78LrufMKusgJzXZYbUdkxVdxRFLmFw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=i6Ew8bdtdCWy2DOBcW6wHc6otbxJ0rqtrHkiLZv5gxvFk3cxSc/yWwl6U8KEsUABvCj/wzH4krW6D6NoqtXyX+sMoV7mUCIQJew24xS2LXkG7mKX8YHXKlI6fSAx/g7WRp5PsJWLjaMuxEt0bS3p2pNYTEMkR1GIgfkaPN6ImLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H/VmS92e; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5db9eb0e7so9930435ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705430828; x=1706035628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzOK6W+G74uDiUdt7KMX09h88wCbiDkSJ1x7zb5kpR8=;
        b=H/VmS92e0erTpXmGD81gSrxVcTk0/E3TPlie1vM0yirrS3OPF/MYKVkm9/DANEpyC3
         qPa7+0I9QmPX/E83nVDWVVu69KdcWFzlK5G2vok/To+IjK6i6vAgmc9MHKaTNjRFrgCI
         OpW10FStEqWJhcYh06CY/4gxvqHbMhQpVB1zoWl7geKl4W6FAmxtvs40kGXHozIf1pD/
         43wGvnv2VuGu4Y0KFVBHsaw4xf9Sz1JELwu3d7edutnBTRJZlk1vI3g+zd9wl+C3MpRI
         34b6IgnLOge1/BU0zERd9iDRCPDD7qflyJWAYH86n0vQQ61OF4GWmbjKVMs8NYtrSUfP
         RHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430828; x=1706035628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzOK6W+G74uDiUdt7KMX09h88wCbiDkSJ1x7zb5kpR8=;
        b=gQkNO/F0fEz8ftoJFYvk1AJ8HZR03DS8AATidTpOcqQwLGVbr0e0iUxZw+wHP1S1JO
         6fylSsc88muxDM+RGRXMIdKXTNe1fQwZY8sgrcsf5R6Z5jFlRkUeXHGaPoS4LDhIMRyW
         kTpnZP8FsL9rZCgl/XzD4bzqd1VLUDdKuuD4/F3fxQfwuZSv2w44Q5uz8OtB6dQlZ4PC
         iH+gTCB+y/1CwfZiGMBEYnCY9MVBJkBzCxkjbViSM+WBgFyVRA+oTIrBpvM0rmpdCi2E
         /oOLKv9xyDOURFvSRZ27W17jtBOUlIEefMy+OHjbn3/jUSArZoTvm59Aju5LYCsfslll
         OO3A==
X-Gm-Message-State: AOJu0Yy1MwDp+PftPw62WcSC8rdKx/wECfKlah2B2YPBXvJ6qM5lGAl2
	nVsTYCWjx1SqgEFlcwTqb2bSibOSIttVgtOHaLGNdxLFCZ+G8g==
X-Google-Smtp-Source: AGHT+IGlHP8xv65eTrLYbxdWE98VqFYwvntUR3EJnNTNFNpHq0PTKvD5rL7yNMdrMiTPUx/B9MF63dK3fN9Vv0S008o=
X-Received: by 2002:a17:90b:3547:b0:28c:f4ba:a92d with SMTP id
 lt7-20020a17090b354700b0028cf4baa92dmr3598577pjb.40.1705430828065; Tue, 16
 Jan 2024 10:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-13-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-13-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:46:57 -0600
Message-ID: <CAPLW+4knt2P5yEJMRJsKydGUaa8RSMLxdVy-Kjq=bkGw9tA8Kg@mail.gmail.com>
Subject: Re: [PATCH 12/18] tty: serial: samsung: use TIOCSER_TEMT for tx_empty()
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
> The core expects for tx_empty() either TIOCSER_TEMT when the tx is
> empty or 0 otherwise. Respect the core and use TIOCSER_TEMT.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index f2413da14b1d..46fba70f3d77 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -990,11 +990,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct =
uart_port *port)
>         if (ufcon & S3C2410_UFCON_FIFOMODE) {
>                 if ((ufstat & info->tx_fifomask) || (ufstat & info->tx_fi=
fofull))
>                         return 0;
> -
> -               return 1;
> +               return TIOCSER_TEMT;
>         }
>
> -       return s3c24xx_serial_txempty_nofifo(port);
> +       return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;

And because s3c24xx_serial_txempty_nofifo() might actually return 0x4,
and at least uart_get_lsr_info() tries to clear exactly 0x1 bit, this
brings functional change, which I think is in fact a fix. So a
"Fixed:" tag is needed here.

>  }
>
>  /* no modem control lines */
> --
> 2.43.0.472.g3155946c3a-goog
>
>

