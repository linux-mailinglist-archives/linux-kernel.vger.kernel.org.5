Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FEA7542F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjGNTBp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjGNTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:01:42 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170A2D4B;
        Fri, 14 Jul 2023 12:01:40 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso4387895e9.1;
        Fri, 14 Jul 2023 12:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689361299; x=1689966099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCSKhEEwFxtZc44vFjegpd2e4UjCV+0u8Bi/ih1l7lo=;
        b=VOizt0TrX/act/a8lT7d/iAwl+9bP1LOn/k6nuARIdt07TpWQ7rfCOYOT96lgj1ZZK
         T+19RGq6NPotR+YfApfOQjjqVz4TirYvTudewO8MYIvUCuwPyuxX+/PKZQUMEVoBW+A7
         jWwPDQj/VtZeIqwgdbDrgmud989HbgK/x83hJAwht/WZWmMW8VGdjGA2sgfXdUGKN9ys
         7aaZcxPW0ZTNYY7ofWxz8aXoi0TaMwfFipCg4S21DrZCaIdjxnyCSZauoFtXqHxp5BTI
         vWhD8oU8rF+xHqFNBxGUqtYyVoFS12HOyRNPSXvLnyAB16dkJZYD9lPbqzSeihubd6GW
         Jo7A==
X-Gm-Message-State: ABy/qLZESxsUTc+ahP7sFpIsumeWN8MWyBpHvpXiVYaPcAT89b7gPjBm
        7Mtlu+yOgRsjstYfB/4XefHBdgPSZAgF2NDJPYw=
X-Google-Smtp-Source: APBJJlEk4dSowlcEHuKJWTAji6jfja+Ys/2z4tz24oer1kVW/20RnuoSbRV5G9Ys1DkgRR1Xx1TaOBtb8hR0sC++YqA=
X-Received: by 2002:a05:600c:3111:b0:3f6:8a3:8e59 with SMTP id
 g17-20020a05600c311100b003f608a38e59mr5102421wmo.1.1689361299261; Fri, 14 Jul
 2023 12:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230712081258.29254-1-frank.li@vivo.com> <20230712081258.29254-27-frank.li@vivo.com>
In-Reply-To: <20230712081258.29254-27-frank.li@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 21:01:28 +0200
Message-ID: <CAJZ5v0gw=vddN9kHMSECwCye9q3qbN0Hr=DL6EC=fQ9eHF9faA@mail.gmail.com>
Subject: Re: [PATCH 27/27] thermal: intel: int340x: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:14 AM Yangtao Li <frank.li@vivo.com> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

or please let me know if you want me to pick this up.

Thanks!

> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 5 ++---
>  drivers/thermal/intel/int340x_thermal/int3401_thermal.c | 6 ++----
>  drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 6 ++----
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 6 ++----
>  drivers/thermal/intel/int340x_thermal/int3406_thermal.c | 5 ++---
>  5 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 5e1164226ada..8fbc97641740 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -674,7 +674,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>         return result;
>  }
>
> -static int int3400_thermal_remove(struct platform_device *pdev)
> +static void int3400_thermal_remove(struct platform_device *pdev)
>  {
>         struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
>
> @@ -698,7 +698,6 @@ static int int3400_thermal_remove(struct platform_device *pdev)
>         kfree(priv->trts);
>         kfree(priv->arts);
>         kfree(priv);
> -       return 0;
>  }
>
>  static const struct acpi_device_id int3400_thermal_match[] = {
> @@ -714,7 +713,7 @@ MODULE_DEVICE_TABLE(acpi, int3400_thermal_match);
>
>  static struct platform_driver int3400_thermal_driver = {
>         .probe = int3400_thermal_probe,
> -       .remove = int3400_thermal_remove,
> +       .remove_new = int3400_thermal_remove,
>         .driver = {
>                    .name = "int3400 thermal",
>                    .acpi_match_table = ACPI_PTR(int3400_thermal_match),
> diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> index 217786fba185..714f4cb59cfd 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> @@ -36,11 +36,9 @@ static int int3401_add(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int int3401_remove(struct platform_device *pdev)
> +static void int3401_remove(struct platform_device *pdev)
>  {
>         proc_thermal_remove(platform_get_drvdata(pdev));
> -
> -       return 0;
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> @@ -62,7 +60,7 @@ static SIMPLE_DEV_PM_OPS(int3401_proc_thermal_pm, int3401_thermal_suspend,
>
>  static struct platform_driver int3401_driver = {
>         .probe = int3401_add,
> -       .remove = int3401_remove,
> +       .remove_new = int3401_remove,
>         .driver = {
>                 .name = "int3401 thermal",
>                 .acpi_match_table = int3401_device_ids,
> diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> index 43fa351e2b9e..ab8bfb5a3946 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> @@ -71,15 +71,13 @@ static int int3402_thermal_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int int3402_thermal_remove(struct platform_device *pdev)
> +static void int3402_thermal_remove(struct platform_device *pdev)
>  {
>         struct int3402_thermal_data *d = platform_get_drvdata(pdev);
>
>         acpi_remove_notify_handler(d->handle,
>                                    ACPI_DEVICE_NOTIFY, int3402_notify);
>         int340x_thermal_zone_remove(d->int340x_zone);
> -
> -       return 0;
>  }
>
>  static const struct acpi_device_id int3402_thermal_match[] = {
> @@ -91,7 +89,7 @@ MODULE_DEVICE_TABLE(acpi, int3402_thermal_match);
>
>  static struct platform_driver int3402_thermal_driver = {
>         .probe = int3402_thermal_probe,
> -       .remove = int3402_thermal_remove,
> +       .remove_new = int3402_thermal_remove,
>         .driver = {
>                    .name = "int3402 thermal",
>                    .acpi_match_table = int3402_thermal_match,
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index e418d270bc76..9b33fd3a66da 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -262,7 +262,7 @@ static int int3403_add(struct platform_device *pdev)
>         return result;
>  }
>
> -static int int3403_remove(struct platform_device *pdev)
> +static void int3403_remove(struct platform_device *pdev)
>  {
>         struct int3403_priv *priv = platform_get_drvdata(pdev);
>
> @@ -277,8 +277,6 @@ static int int3403_remove(struct platform_device *pdev)
>         default:
>                 break;
>         }
> -
> -       return 0;
>  }
>
>  static const struct acpi_device_id int3403_device_ids[] = {
> @@ -293,7 +291,7 @@ MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
>
>  static struct platform_driver int3403_driver = {
>         .probe = int3403_add,
> -       .remove = int3403_remove,
> +       .remove_new = int3403_remove,
>         .driver = {
>                 .name = "int3403 thermal",
>                 .acpi_match_table = int3403_device_ids,
> diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> index f5e42fc2acc0..1c266493c1aa 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> @@ -178,13 +178,12 @@ static int int3406_thermal_probe(struct platform_device *pdev)
>         return -ENODEV;
>  }
>
> -static int int3406_thermal_remove(struct platform_device *pdev)
> +static void int3406_thermal_remove(struct platform_device *pdev)
>  {
>         struct int3406_thermal_data *d = platform_get_drvdata(pdev);
>
>         thermal_cooling_device_unregister(d->cooling_dev);
>         kfree(d->br);
> -       return 0;
>  }
>
>  static const struct acpi_device_id int3406_thermal_match[] = {
> @@ -196,7 +195,7 @@ MODULE_DEVICE_TABLE(acpi, int3406_thermal_match);
>
>  static struct platform_driver int3406_thermal_driver = {
>         .probe = int3406_thermal_probe,
> -       .remove = int3406_thermal_remove,
> +       .remove_new = int3406_thermal_remove,
>         .driver = {
>                    .name = "int3406 thermal",
>                    .acpi_match_table = int3406_thermal_match,
> --
> 2.39.0
>
