Return-Path: <linux-kernel+bounces-106181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACED687EA65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C5E2834C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9AE4AEDC;
	Mon, 18 Mar 2024 13:51:02 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599B482F2;
	Mon, 18 Mar 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769862; cv=none; b=D3fjX43z1+QY81H25Kpnoj9J460uxb4z1ngewQV0rVJ8xrgbrIGYGP/30Is1BRbIBqEA39LZyrI9hpA2siPMNrnACC627qVHJNqOJQBaeezStDi0v7gPE+ougutFE4MfT+Rx3G2I4a9GwNHigzatQHojHc7Ip93mnFQ+nNSg784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769862; c=relaxed/simple;
	bh=po+xrY1xC1IdfvvAGhGiKp9tL3TxSWg0q8EjjelD5N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5nsIEcqubna9Wu/yHWX4W9oR+hwoIFNQiyk1xGGDV2oujACn8KK8OXSAy1UzOdFXZi4VHjOjvbRmeXRTsgmVwa6+vKDgkQTiq2c+LPKsOGLXlCjDodNLVegVdfHfifBYNQTKwj4KmNmV2ISSmki1KFtOFBT3XYTDbisxrsPg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-221d4c52759so611719fac.1;
        Mon, 18 Mar 2024 06:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710769859; x=1711374659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frJQpGP/jsZFYv57qEo/cVAJgItldw9pamarEjBSknc=;
        b=rD/LTZuw3Q2wAD5TUfVdzOA+dvoYm0XBJEGfRAKMsasnxzbeP8MN3zaMMeeiJ6ze4B
         IHplLORIukKAJfzyju1g3XGQ4CZR05qMxaFvbqwXKnoK6cV8Y03aO+PuGI71JfqfiSEK
         Ps6eqF5TNJ1chVLyuQ2GJuwYhNOnG7eCztHq2P/QGOq4TbrS3VEiJTAc9EVGyywn6wzs
         xQhEZ9/LccBwaYIxeCJh05AVgMoG0XX1PVZGKoRnM4cQxXWvKK+YPOEDZvaZ9Ehg97Nt
         JKUtpRUXztnzSbGcNO5QVkBGgmwFpseFIPS3cjYG+zVBK8/ugyKD6n1sHsgEu4MGK6oF
         Rfhw==
X-Forwarded-Encrypted: i=1; AJvYcCVL0bCrV7O7v5p5LYlmWn7ucmSwNQFAfgejlBzma2WhcvYr7MzIuhhxqluhZFt2+DGOdDZBwbEaceGHxZKbTn22rxh0rUBRZsa/GOKk1btA1xCExQAnHFge5oGUjI6xoRoSFZKtTkfcwDpT/5C3+OE3+DDLSmQY7B6IxdJCylOU+Hg=
X-Gm-Message-State: AOJu0YylYvdoBeSFcVlDpD6IpE1qFmi3A6jwg9qySr2g8UX1UsHKelFK
	ZH+B/kj8BiUYMIYVbpAjiFJcTE9+REwPt/H/hVEqULF3BLrKUnpdEWtUiyDxc65dlKqNbJayhH2
	PSPyQR9KuAlA5lL6bBVduSVY8kSc=
X-Google-Smtp-Source: AGHT+IGcje0HAYgR5zgzw8XrdokZ6nxATEL+LWCZlyZzvAQrUtSXjnpimK4rvpyIaPOTSakm8kkh1bPs44z0GzpjnHg=
X-Received: by 2002:a05:6871:5b11:b0:221:a151:7f3d with SMTP id
 op17-20020a0568715b1100b00221a1517f3dmr12036854oac.2.1710769859602; Mon, 18
 Mar 2024 06:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318055054.1564696-1-d-gole@ti.com> <20240318055054.1564696-4-d-gole@ti.com>
In-Reply-To: <20240318055054.1564696-4-d-gole@ti.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 14:50:48 +0100
Message-ID: <CAJZ5v0h4k+dmPXJT_CnPw9EwB0GYmL5YxG_DF1TTJynAWm73Hg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-pci: Use device_set_wakeup_enable for
 en/disable wakeups
To: Dhruva Gole <d-gole@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Tony Lindgren <tony@atomide.com>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	theo.lebrun@bootlin.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 6:55=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> There exists device_set_wakeup_enable for wrapping device_wakeup_enable
> and device_wakeup_disable. Use that instead to avoid confusion in
> returning from a void vs int function.
>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>
> I do not have the hardware to test out this driver, hence requesting
> someone to review/ test it if atall you suspect that this change can
> break existing functionality.
>
>  drivers/mmc/host/sdhci-pci-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index 025b31aa712c..db614389a5fc 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -61,9 +61,9 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip =
*chip)
>         }
>
>         if ((pm_flags & MMC_PM_KEEP_POWER) && (pm_flags & MMC_PM_WAKE_SDI=
O_IRQ))
> -               return device_wakeup_enable(&chip->pdev->dev);
> +               return device_set_wakeup_enable(&chip->pdev->dev, true);

This change is not necessary.

>         else if (!cap_cd_wake)
> -               return device_wakeup_disable(&chip->pdev->dev);
> +               return device_set_wakeup_enable(&chip->pdev->dev, false);

It would be sufficient to simply drop the return statement from here, that =
is

+               device_wakeup_disable(&chip->pdev->dev);

and it can be done in the first patch (which would be less confusing even I=
MO).

>
>         return 0;
>  }
> --

