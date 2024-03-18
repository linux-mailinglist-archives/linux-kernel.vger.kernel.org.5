Return-Path: <linux-kernel+bounces-106175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C587EA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50987283414
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050A148CFD;
	Mon, 18 Mar 2024 13:48:00 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16419249EB;
	Mon, 18 Mar 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769679; cv=none; b=lRE97jMpWVeBPYCGJyB6h3r7CyNIPhfmPynMR8QSHvbCsy2PEB71AwqtYobiNbfOf0T6fHJFXEOCq9B/WJXppgZIlB4jQYmox7n/JBUZi/PB5ibN7zlyoOUhHffWQvMSnPWXyssKr18DJL8FI1FUpWpdKzbLRbvOtfi6WNBA4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769679; c=relaxed/simple;
	bh=5Skdb5Ea92mVl7TGZULbUxUWfzAoFJQETlY3oyw2PcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNG3xDEjnb4IfXY1Fxr71oqnDYsgire8/alSc0m8Xxo2SaUhIX2NSBcX/8EZfwxc8xE8/aOYv3SXBPtGB+PWp2WW1OFwo+HRq77IsL8V3l8nhnHXAH4wVkIIsJNr/15ussFQ+lKp2mk/xQtbAAQ5JRcqbLAJrDhQQOLhTWekeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2219edd959dso969639fac.0;
        Mon, 18 Mar 2024 06:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710769677; x=1711374477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOakJZuItJeZn6wLR+x/UlhCnYwyTT+eEj3X3hD9lPo=;
        b=hK9mIBJGDuErwrG6h33ESMIxKFU3Jfv8zS/59wp+qWOHsFp0yV2Ih5UF8V9ryozADq
         RarpZE+PNqXInXFn8sJ/LHfx/2U6s7UKWlX0ZI83kc0lmXa+iq41lOfMWMnp5hVvgPb5
         /mrwMLJYvwq5iuOoZn42H+CR4lgR9XQDfVZTpAy7tlsE6syLKUz5+12GjQE7wbR8pAkG
         D4uLiVhsId0zJvH4c/8npaoqJBriWFeCmPLeVGLWJQy9e4LpCPZNXDutbj/tmrzJvShI
         iqwUw/yPUPcPUU5qYRYZsG1yZ04/nVSm+OvB18zqU2GPA4u1rMQLIxoe5uubxL4NW9A4
         8Z4w==
X-Forwarded-Encrypted: i=1; AJvYcCX3B8x1MyHL8lsWcjJAz/GiOCuztLouuZj/IrA5+Ikf5i+bDOeN06lQl7iCphBeSFYHzrCBQQAMHqL2ExqsGjrrbAjsuRqqkqGbLCf/qKi1ULrpsXY459WZGWPghqRoFi9ci3F6g+/bL2bLIJCHWk9eN8fZjEbx8xcmHO6tBrWmRj0=
X-Gm-Message-State: AOJu0YytJxCISTGERBgLXtlSL80lL28KepO1A3leBxLHCflnQv8Iubqs
	VrcyS+L8RfUvzVi0L4b9hRADYRsZy6CV6dHBjiNgwoNC8cle5BH/beFR3wLhad6XxxoW5hXAq1C
	S2IkzGb+fXrVfOUno/b/iygCW/Pg=
X-Google-Smtp-Source: AGHT+IFoSB4pNMjT9eDWxlv9et7vQdUvZO/ohJsDwLmjTJ7nGFl6EeMS2OOdzuevk8LMxXSz61oACRUuzh5y2kPvKi4=
X-Received: by 2002:a05:6871:58a4:b0:221:cb1b:cc05 with SMTP id
 ok36-20020a05687158a400b00221cb1bcc05mr13208337oac.0.1710769677154; Mon, 18
 Mar 2024 06:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318055054.1564696-1-d-gole@ti.com> <20240318055054.1564696-2-d-gole@ti.com>
In-Reply-To: <20240318055054.1564696-2-d-gole@ti.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 14:47:45 +0100
Message-ID: <CAJZ5v0giafbnGFHgT7pZm+o6KzKznxVDJvc04K6XvP1ShG2YKw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: wakeup: make device_wakeup_disable return void
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
> The device_wakeup_disable call only returns an error if no dev exists
> however there's not much a user can do at that point.
> Rather make this function return void.
>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/base/power/wakeup.c | 11 +++++++----
>  include/linux/pm_wakeup.h   |  5 ++---
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index a917219feea6..752b417e8129 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -451,16 +451,15 @@ static struct wakeup_source *device_wakeup_detach(s=
truct device *dev)
>   * Detach the @dev's wakeup source object from it, unregister this wakeu=
p source
>   * object and destroy it.
>   */
> -int device_wakeup_disable(struct device *dev)
> +void device_wakeup_disable(struct device *dev)
>  {
>         struct wakeup_source *ws;
>
>         if (!dev || !dev->power.can_wakeup)
> -               return -EINVAL;
> +               return;
>
>         ws =3D device_wakeup_detach(dev);
>         wakeup_source_unregister(ws);
> -       return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_wakeup_disable);
>
> @@ -502,7 +501,11 @@ EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
>   */
>  int device_set_wakeup_enable(struct device *dev, bool enable)
>  {
> -       return enable ? device_wakeup_enable(dev) : device_wakeup_disable=
(dev);
> +       if (enable)
> +               return device_wakeup_enable(dev);
> +
> +       device_wakeup_disable(dev);
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
>
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 6eb9adaef52b..428803eed798 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -107,7 +107,7 @@ extern void wakeup_sources_read_unlock(int idx);
>  extern struct wakeup_source *wakeup_sources_walk_start(void);
>  extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_sour=
ce *ws);
>  extern int device_wakeup_enable(struct device *dev);
> -extern int device_wakeup_disable(struct device *dev);
> +extern void device_wakeup_disable(struct device *dev);

This change will introduce a build error in sdhci-pci-core.c AFAICS,
so you need to modify this file in the same patch to avoid bisection
breakage.

>  extern void device_set_wakeup_capable(struct device *dev, bool capable);
>  extern int device_set_wakeup_enable(struct device *dev, bool enable);
>  extern void __pm_stay_awake(struct wakeup_source *ws);
> @@ -154,10 +154,9 @@ static inline int device_wakeup_enable(struct device=
 *dev)
>         return 0;
>  }
>
> -static inline int device_wakeup_disable(struct device *dev)
> +static inline void device_wakeup_disable(struct device *dev)
>  {
>         dev->power.should_wakeup =3D false;
> -       return 0;
>  }
>
>  static inline int device_set_wakeup_enable(struct device *dev, bool enab=
le)
> --
> 2.34.1
>

