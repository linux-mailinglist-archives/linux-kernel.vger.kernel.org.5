Return-Path: <linux-kernel+bounces-72418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34DC85B301
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC801F223E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD11EB46;
	Tue, 20 Feb 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0KX6nZ2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0F259C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411262; cv=none; b=iloXxZ65k3CwHsm3PyHoDrbk4Pb0bQ3Wojuym8JUPmlRhzbOMZY7sHWQaIfDxg51qqEPtEyweDD+o5jj6+2ETr1+asUg/yCtSGp45jnXzAg86F6olV7GyUd5ATiDKGRGmIInSg8DSw3xWFXEeImFJRIG9VFl9EAKVve9wrBV6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411262; c=relaxed/simple;
	bh=3BRKh0OZqztmogBu6WVQXWFd0gr9hr1F/JdbkVwa7VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJI9CTX8C4Y/f7BCszNG31HPdlvRUCsBMVUs7cpXahikk/PRUs2820JsQU62SOiMC15XPvvg0YZMWgxCabyn70222Fchg95o1t5S4mME3catzQH7Yj4cAL+UGw6CtkedhCit8n8OYnohSyMgQU1/orVQLbAJi5LKmYIFLcMqGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0KX6nZ2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d23114b19dso25419781fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708411258; x=1709016058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/5CK/+MMawYXzgUqe9nAD7tYKluMjye+ze/3Lc+fRc=;
        b=P0KX6nZ2X9MwmOEajOoxmVQA9aORZdP3o5QcxAcO0LhZ1bpM51YXSsV03vMS7vtF/B
         DO1qo64OThOqdZWkr4rD1KYwmhOkb2M+BXc2ned6XlE4tuf5JIyt8pR84PdBgrX4ZHsn
         NnFE453FFDsh4ZXNJO5HLJODkfc2bUQBO2scs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708411258; x=1709016058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/5CK/+MMawYXzgUqe9nAD7tYKluMjye+ze/3Lc+fRc=;
        b=aNEkDAukLjllfjLaJwZPjvhhr9r/z7RtJZFoeX52Iqq+SC2WvKN6Syjok0q0M8jX5r
         LBt5U5/Mh2vHaPeVq3lr4QmN6Im2QFovGsTJjZxkvC4i0NunLUXxc5qXXrtVys++JW1K
         S17heGjlgVjH1n9nX68p5L1096SK+vZRzwKIwdl1JA4x3rm1jmDAgFvaiITPYeK1ILdR
         tBCTc2T23RBvd2Bob3xP+yRHZ1Z1bbAxxXBiUZCRhicW5vi0Sumdgr9dXjZx+SdokR2N
         B45yEDOf/9sFL5YBGipkWtZbudpB4r5TtpOf2kTItpeIHD8V1xk/+/HD44ZLe5sYX4Et
         vRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/uchYwkAH48bfX6FJA9n8vx+O1t+y5hfSMqbgrd3mBqmolpJa8boPZohRR4ytHxZhRY9E7GVb+9hBtMnZquBHB/DsRlLiY2Ks84u4
X-Gm-Message-State: AOJu0Yw14b3vyAF+rMMSqYy9Ix43vPC+ihCb8q45EN3MNNKm4JFcA9pH
	7htrzSlQYpBqR1MmNLiSpB7Ib7P7As4y8FfwMzHXHu1OvodI7viROMFnJpjwVwtz+MAOeLOpZLY
	2zDHKhFbWa4INLU3B/4rGll5x9yChnypyRz7ISbjG81ZmiDk=
X-Google-Smtp-Source: AGHT+IFAvIfiLLEefmtgMPYY07Aqu1hwGfMKyTgdkfDKmAASXhQwN2PXQaCsktOFc75kGcOj9WcbRcx14GnXb0fm0fY=
X-Received: by 2002:a05:651c:b21:b0:2d2:360a:2810 with SMTP id
 b33-20020a05651c0b2100b002d2360a2810mr7133668ljr.22.1708411258681; Mon, 19
 Feb 2024 22:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org>
In-Reply-To: <cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 20 Feb 2024 14:40:47 +0800
Message-ID: <CAGXv+5EKCrvsvZwc2zYiMWAeT9vqvU0JnDrz=WBoebBBbcgp0g@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	William-tw Lin <william-tw.lin@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:43=E2=80=AFAM Daniel Golle <daniel@makrotopia.org>=
 wrote:
>
> The mtk-socinfo driver uses symbols 'soc_device_register' and
> 'soc_device_unregister' which are part of the bus driver for
> System-on-Chip devices.
>
> Select SOC_BUS to make sure that driver is built and the symbols are
> available.
>
> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting =
chip information")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Angelo, I believe this should be picked up for -next?

Also, mediatek/v6.8-next/soc is missing from mediatek/for-next in today's
linux-next.

> ---
>  drivers/soc/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 50c664b65f4d4..1b7afb19ccd63 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -72,6 +72,7 @@ config MTK_SOCINFO
>         tristate "MediaTek SoC Information"
>         default y
>         depends on NVMEM_MTK_EFUSE
> +       select SOC_BUS
>         help
>           The MediaTek SoC Information (mtk-socinfo) driver provides
>           information about the SoC to the userspace including the
> --
> 2.43.0
>
>

