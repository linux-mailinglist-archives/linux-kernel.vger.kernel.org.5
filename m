Return-Path: <linux-kernel+bounces-142561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D18A2D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A391C21407
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475C54677;
	Fri, 12 Apr 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkJObC+U"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4E53804
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920770; cv=none; b=KueHq6Fr+8EgqHJrDbjBvgmFrHwHTZ41dlt1hk8gYBj2E/CmLcV6jTtIM3z4TSit9VRxUFZQqWj+0RjsqM0BCsmwXqlvkJyBVhSOH8/b3Rz2Ny7/ZsJCnaNUEmGCB/gZv2njytnzC9H+rVakd9sDLaKyKK9ab5BeTPpCaGY7PGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920770; c=relaxed/simple;
	bh=jJXQWARzxh60e8csc7f0AlY8R8u61wyoaZ5C9ACBeKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krIu/pHNz9uE6nw4WA4TGwKq0LbVkEfKea1rXKp2e5TTzY/UNwhsOodds/7b+DRoasSyr0ieI7uWqQ2lDHdRGJwCR7nIjH5tgSDriMrCjGYd1+hibRaBzni+9/DVuOkT7qDWmf3JcC49/un4jFij7dl5qXcYzGuyCAf1+p6K6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkJObC+U; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso564512276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712920767; x=1713525567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5rDLo34QYHoVsmJR+qXt/vyD8JmocFWIjXhIAKbA2M=;
        b=mkJObC+U8nDDJgklpIU2LoOmw05ZgepN0LI6hV8mIj+8ORTLPsMXz2BEsPNBXWYWwg
         bwkKqaJSOUZny7uJwMNVBWfbtQwG/bQgnmKHe5t572TgKJbqbsF0UVpQtII24Lb6qEpG
         y9FJsyUj4xrQxyPYOmShTpov9U3m6cJzzZASfQCHGa2o6MlI6U9E0YD+qGnHdonYTOIK
         fvMj0PW79tMCa3Fn/wsEH+rL3vBtI+xc0SEwbP+svld33oQzHaxkohDwQUwYBe0wB/jv
         VZ5pBXn4yKGdcDBXzbAlgPuk2vLLlka3ibPXdU00NO4GBYTRAWHknON4QLXgvFP9rRcc
         XgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712920767; x=1713525567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5rDLo34QYHoVsmJR+qXt/vyD8JmocFWIjXhIAKbA2M=;
        b=Zv3hCkqkdA7+Vny9tM7KxcbXtk6wm+QZGMii9af3BbdzzS0mBuB5XJ3uQ/kKo2Hc5d
         sAOgJpiCgJ2+GR2D0VgP5+mAQnQALgRDmf3iyf12EGlme1+FXVL8vUe6tzQl3vHXH1yz
         ead3e2kgzcXft7AeODeLlOiyCs77ECJMctwSO1dR1RKwL9pSayT8A14r85FefIIFe9Wx
         p6r4YwgzVCjJuPLXIJUaYoZ3qIbdE+KPKnqKpIlgL5vcgCPReB2EMmsWLlgeHbpvTIC0
         JuvHqRYX6NPI2gQG5Q+OJjTI6lec/P0EAIdoJvmIn4aV0VOleWrh+gbnMBSHvg6Bn3qq
         UKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0q3Wqgz6FOb28ex64YFTJYUnGlaFoOTcYI47dK8jg3JdoVb7rTTegdcGHENRFV/0sXVgYRhuNK0u+oqC3GasUBK8UZ9b0/HnlwS7t
X-Gm-Message-State: AOJu0Yx3kRyjjtg2V56VIManD7hR0iGukVIaDSw/h44TXHDzJYkKECEk
	uTjpGsUb1UAyARArONYXDjarSW4zfMVKRl6Ej7J6ptIRI4+0xMmfHyiWl4CZ7sIhzVlPxOIUQLz
	K4jhxYM7rc8/xl6aexDp33MHiz0w9IiyA/GrY8g==
X-Google-Smtp-Source: AGHT+IGjcxQfZZ4gEXpxEJHHCkUAzxFeclWwScgkVbFOPUQuv53ARt5z+a4tB0oWhU95+YIs637qHwGwylAPZ0V78DI=
X-Received: by 2002:a25:2d07:0:b0:dcc:ae3:d8a0 with SMTP id
 t7-20020a252d07000000b00dcc0ae3d8a0mr2500615ybt.48.1712920767132; Fri, 12 Apr
 2024 04:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com> <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Apr 2024 13:18:51 +0200
Message-ID: <CAPDyKFq1+cL1M9qGY0P58ETHUZHGymxQL0w92emUJPMe7a_GxA@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM
 domain in rzg2l_wdt_restart()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	geert+renesas@glider.be, magnus.damm@gmail.com, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 16:19, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt_restart() is called from atomic context. Calling
> pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
> APIs is not an option as it may lead to issues as described in commit
> e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
> that removed the pm_runtime_get_sync() and used directly the
> clk_prepare_enable() APIs.

Calling clk_prepare_enable() doesn't work from an atomic context
either as it may sleep on the clk prepare mutex.

As I said in the other reply too, it looks like we need a different
solution. I am not sure what, but I am happy to help discuss it.

>
> Starting with RZ/G3S the watchdog could be part of its own software
> controlled power domain (see the initial implementation in Link section).
> In case the watchdog is not used the power domain is off and accessing
> watchdog registers leads to aborts.
>
> To solve this the patch powers on the power domain using
> dev_pm_genpd_resume() API before enabling its clock. This is not
> sleeping or taking any other locks as the power domain will not be
> registered with GENPD_FLAG_IRQ_SAFE flags.
>
> Link: https://lore.kernel.org/all/20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Kind regards
Uffe

> ---
>
> Changes in v8:
> - none, this patch is new
>
>  drivers/watchdog/rzg2l_wdt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index c8c20cfb97a3..98e5e9914a5d 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
> @@ -164,6 +165,17 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>         struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>         int ret;
>
> +       /*
> +        * The device may be part of a power domain that is currently
> +        * powered off. We need to power it up before accessing registers.
> +        * We don't undo the dev_pm_genpd_resume() as the device need to
> +        * be up for the reboot to happen. Also, as we are in atomic context
> +        * here there is no need to increment PM runtime usage counter
> +        * (to make sure pm_runtime_active() doesn't return wrong code).
> +        */
> +       if (!pm_runtime_active(wdev->parent))
> +               dev_pm_genpd_resume(wdev->parent);
> +
>         clk_prepare_enable(priv->pclk);
>         clk_prepare_enable(priv->osc_clk);
>
> --
> 2.39.2
>
>

