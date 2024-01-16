Return-Path: <linux-kernel+bounces-27702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EAE82F466
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31112844D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396991CD38;
	Tue, 16 Jan 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGxH89Dd"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5121CD27
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430295; cv=none; b=VX4b9h/5D+a7nq2om7qY5y7EXngIK8o/iJeBKVYy4oXhHahjyu5MGKs7RfKV1JrOegSOJwqVreMvdGIWP0rnSdudBUn7HY1U5ff1NJrNREige34+U4LkFjk9qYtoyIA9q7YsDfNWEIBK+V7FMnLaaHgMggKjMFVPbP5qNli+cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430295; c=relaxed/simple;
	bh=TB6bL0w3hLWUcnDcaIay8oWyOu6RzNDf0O17kPM6VXw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=OwbOto3W0MGaWYuvMFm9yNEAWcfKWONvuYCl5hADYB/gJw+s4MS09JjDyfXu6FnEDALIgyodeo6ZYFQgUDtF55BRHaJisfTKTMzZZGvXXR3Y3SxJE6Q1jrj30+FWzUGkZk2YhBIS6NAlKvF0aQTPQGu0hGD/wT4O+HCWOf78buA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oGxH89Dd; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso4524498a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705430293; x=1706035093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jDglbZBWktYfWTPUcusyZr2j2GiYOxnIQXGiD8Doo4=;
        b=oGxH89DdczRxZnF4aohIqsU78Z+Srdlzge3Ji/jgAa6Fb6Spd1BEJNiI8rE4hG1goZ
         rlKPoeg/ln2gFfGQPZB38Qs5lb9u8CxAn4Pi/gwVDwaucUSYrgOYh58f3dE7YbUIvlXm
         MdGi78pL3TYyVpYjiogoopMxxTZBPDgBp6V4OnE6AI0vIx67m6zyPegIvLot2gsbej3p
         NBH3Ne1vIxD5CVXV4SoJd3wRu59Lnu5euQWMLxYtQVKNhR2fnBneTI7/nlysuybv2OtG
         qgGTDdu1PGCb6za71j3MyI9uvJIEO2OLdqN7txZgHNVo4W86zdiMEqWse5auX4MTpjeP
         pJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430293; x=1706035093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jDglbZBWktYfWTPUcusyZr2j2GiYOxnIQXGiD8Doo4=;
        b=Z1A/hs9nq4EJsQxtkt8GkSnAF4iyxUxCraKsceyt2WBqSCS0LQwL5KCRmg5jAUJalb
         4VhUq4WBEhOMGhFh2TorlT9XfGkaYWLFUK3BN5O8+wj9BC33aeyVkZuMTT7x3phkPsIS
         ZyDS4sMNWWuVK7UsSMw4j/fQHIQxQ4AF3by+39piGLmvGIFYFlqgub0OFI/G5zUhZRqt
         NrXJmFr2+JaF4rkJ9WKek6mtahxjmxEXVvj49paXS7+VW2ZboImr9ZRJvGf4SdrfwupW
         SoEUDh1zllSwlBiefpdk8lA/Ck1i/yU4zVquhs/yXcuOwX5On35ByIzpx1LB9juzQ++J
         aR0g==
X-Gm-Message-State: AOJu0YwpB2bmNAmdmH9fwBHGrLMa0xYuh0Y2jYb9aeakOG0/IAfvd68o
	DZRBj3cHfZmF2IpEiC5YLPtaN3u+vl8sfQpVT96zqgsj7lBz2g==
X-Google-Smtp-Source: AGHT+IF1E60nyMxp0rq+piEAJAls/q3iuzPDrclS7edvISLFAbWxO/l+vo81dtOlaSnpPsalLHC1RtyIGgPAaFAsaDo=
X-Received: by 2002:a17:90a:d913:b0:28e:1d1e:f2eb with SMTP id
 c19-20020a17090ad91300b0028e1d1ef2ebmr2701244pjv.90.1705430293457; Tue, 16
 Jan 2024 10:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-12-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-12-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:38:02 -0600
Message-ID: <CAPLW+4mKBwsc9VLrGTd2k6d0n-K9TZAjH6M8trcK3Av8TQ2Ngg@mail.gmail.com>
Subject: Re: [PATCH 11/18] tty: serial: samsung: don't compare with zero an if
 (bitwise expression)
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
> Since an if tests the numeric value of an expression, certain coding
> shortcuts can be used. The most obvious one is writing
>     if (expression)
> instead of
>     if (expression !=3D 0)
>
> Since our case is a bitwise expression, it's more natural and clear to
> use the ``if (expression)`` shortcut.

Maybe the author of this code:

    (ufstat & info->tx_fifomask) !=3D 0

just wanted to outline (logically) that the result of this bitwise
operation produces FIFO length, which he checks to have non-zero
length? Mechanically of course it doesn't matter much, and I guess
everyone can understand what's going on there even without '!=3D 0'
part. But it looks quite intentional to me, because in the same 'if'
block the author uses this as well:

    (ufstat & info->tx_fifofull)

without any comparison operators.

>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index dbbe6b8e3ceb..f2413da14b1d 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -988,8 +988,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct ua=
rt_port *port)
>         u32 ufcon =3D rd_regl(port, S3C2410_UFCON);
>
>         if (ufcon & S3C2410_UFCON_FIFOMODE) {
> -               if ((ufstat & info->tx_fifomask) !=3D 0 ||
> -                   (ufstat & info->tx_fifofull))
> +               if ((ufstat & info->tx_fifomask) || (ufstat & info->tx_fi=
fofull))

Does this line fit into 80 characters? If no, please rework it so it
does. I guess it's also possible to get rid of superfluous braces
there, but then the code might look confusing, and I'm not sure if
checkpatch would be ok with that.

>                         return 0;
>
>                 return 1;
> --
> 2.43.0.472.g3155946c3a-goog
>
>

