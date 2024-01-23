Return-Path: <linux-kernel+bounces-36076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B2839B28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F12A1F228B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A13CF5B;
	Tue, 23 Jan 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bIlwqCIQ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057803A8C1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045257; cv=none; b=r3g78mBauIf0cScZmlgaAPfypnxg2W9uKMy+b30FnJ5Ah2FfQorZ/Ip7+NRfwBDJb5p4G5bmml/2lkA4EOmaNXLrHWHa2pLmeyCLVOOVm8NL94kBSPigDlaGc7MmceBFE9Fw2fK+iBgn1jn+N8DzTTifGxe4+N0kQ0zuoagqGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045257; c=relaxed/simple;
	bh=WHRRlVrbMsNr2m9iIM74o09O1vVBEF14r0pYhM5zcZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3sHf5403hlh/nrZkwPCwFKqqeZvkM/xTh6BS+xCQqqhdsEqxRohrtNssZXS47cOosvhgfiKqfFHmb5RNi0cZEbX705fHgntvyP6Yy9n+6gjpeBk+NUmhKkT3uZjfpSIBsVa+gnoWri85v2MFQPoCpCsOh0yO7pRaDKOxjXFR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bIlwqCIQ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso24877491fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706045253; x=1706650053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi3ZlLFRaWl3llLgoUVJtdy7ycenerFoJUoH/tVxvBI=;
        b=bIlwqCIQFSvwMGs/XNTwCxNe8mFGEAuQrC+tmmDKsCuzDhfJ/jqmBMTP5UiQmvI+DI
         KolpBtjmzE8HIMvuOtbX7DjIYfWvLW3Fg4SgUjdoZb9SfTMzWGv62ju1auvagO5gbWg0
         ltqLYZt4tpwjA2WfdSLaS6+/jXNclnfFgPzmXxyiD1rKzYRkTLU4ZnlGAf2vfAaX1erf
         HpwpJDNoVBXqdcng5MSW02C1RLaPSTG2Cf6n1pdE4iiaCrDuxIIoh3SzRrbyj6EfrFs4
         sOOpGIbcfmMVU89guUP1RoIMmPW/8daT5/tClUt1d6PgHwPBicGzLb52bc/mmac6Y+R0
         dkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045253; x=1706650053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi3ZlLFRaWl3llLgoUVJtdy7ycenerFoJUoH/tVxvBI=;
        b=Lt8wQlWHZQb+NO0efbpjlAq/TpkyLR8CtRqmxaozMa3NefWemKkE4HyNpIlpkcLKiD
         4lx95Sc55sCS+PfT/jwV8/k0BOboI6RCuSKVJqSACDvW6WFNaFuz7pkcbGQCUxmZauni
         4HqgKDtYqZoBFSWADsUbZwVHklekNESqIBf4X3aRc17mC5L39Mli/5OnovjAqh1kyxTE
         qS4Du4FmvyUhlFqjdF+j78zl6MY6rW2GUlg6tZfa+yXV2XPVPRFkSF1JYWOZSvF6Km4M
         UsekX3m1Ool63lueIDKi7LS1vtrg7yee/LpIx4vz00ha42Pfrk6guYKkxD4rkdtcVUpU
         7fbw==
X-Gm-Message-State: AOJu0YzBbypTW5cWEV/mA0orP4vE39QS41L12oAAB1p07w0muP5ydF3v
	8zkAUy+gea8xpyyn/C02u0NAoq/ae4ZFCOv8CtoPS4IkmiFKRtt4WkYVp9ruR/8dbAFqBhaZi27
	G0pDVkaCR/HonSKnwjjBZ/JNz3/FLnOooh+PbjQ==
X-Google-Smtp-Source: AGHT+IFBfB/j4H6bp50/Z6pRmYsnFbGBGPv4q2zl8w01+auMt/332faChZc969Zd420+r0FwAMn+gIZ0MAa1JjhTsEE=
X-Received: by 2002:a2e:b8cb:0:b0:2ce:211:31b9 with SMTP id
 s11-20020a2eb8cb000000b002ce021131b9mr334667ljp.1.1706045252958; Tue, 23 Jan
 2024 13:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123212135.2607178-1-dlechner@baylibre.com>
In-Reply-To: <20240123212135.2607178-1-dlechner@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Jan 2024 15:27:21 -0600
Message-ID: <CAMknhBHtcPSVHikL4AWscFcLNKWO33rT77Ed7mkRYqpaBfBvsw@mail.gmail.com>
Subject: Re: [PATCH] wifi: wilc1000: remove setting msg.spi
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:22=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>

Not sure what happened with git send-email, but most of the commit
message seems to have disappeared. This should have included the
following:

```
Calling spi_sync() unconditionally sets the spi field of struct
spi_message. Therefore setting msg.spi =3D spi before calling spi_sync()
has no effect and can be removed.
```

I can resend if there are no further comments.

> (spi_message_add_tail() does not access this field.)
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/net/wireless/microchip/wilc1000/spi.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/=
wireless/microchip/wilc1000/spi.c
> index 77b4cdff73c3..7eb0f8a421a3 100644
> --- a/drivers/net/wireless/microchip/wilc1000/spi.c
> +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
> @@ -300,7 +300,6 @@ static int wilc_spi_tx(struct wilc *wilc, u8 *b, u32 =
len)
>
>                 memset(&msg, 0, sizeof(msg));
>                 spi_message_init(&msg);
> -               msg.spi =3D spi;
>                 spi_message_add_tail(&tr, &msg);
>
>                 ret =3D spi_sync(spi, &msg);
> @@ -343,7 +342,6 @@ static int wilc_spi_rx(struct wilc *wilc, u8 *rb, u32=
 rlen)
>
>                 memset(&msg, 0, sizeof(msg));
>                 spi_message_init(&msg);
> -               msg.spi =3D spi;
>                 spi_message_add_tail(&tr, &msg);
>
>                 ret =3D spi_sync(spi, &msg);
> @@ -381,8 +379,6 @@ static int wilc_spi_tx_rx(struct wilc *wilc, u8 *wb, =
u8 *rb, u32 rlen)
>
>                 memset(&msg, 0, sizeof(msg));
>                 spi_message_init(&msg);
> -               msg.spi =3D spi;
> -
>                 spi_message_add_tail(&tr, &msg);
>                 ret =3D spi_sync(spi, &msg);
>                 if (ret < 0)
> --
> 2.43.0
>

