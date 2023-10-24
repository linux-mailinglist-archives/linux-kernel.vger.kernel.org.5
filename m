Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1707D5A14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJXSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbjJXSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:04:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD91AC;
        Tue, 24 Oct 2023 11:04:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b44befac59so32394b3a.0;
        Tue, 24 Oct 2023 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698170648; x=1698775448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiNf7bxs7WQlL1p7N8zEaMblQKww7yLL72WVvv0ROXY=;
        b=KnPpUFwNn2yLXpt8jbEpqBAxGji9hwm7kfztgBS4/zzjnXYTjq1/jdei5ZTpIBHIYN
         bKUpqh1jfz4soy0ELIr42ZcWJymrz3R0pPWdK0YP5Rti8zeoEPKChh7bYrbO3gBNYjeM
         R9qgAN7JY0rEoPPZHXYeGwMQCu8oQI9OXXq+i7zvhdWvHRbgIEC9guUNNCEgu2bGWqIW
         uLGcYKnTEkZWYypcPF2NPtRlq8JYI3Oz/XqqaR3LOplza0uzl7U/ZPr4cW6zvnUdlhwS
         cPcF7KUpkyRAxG+w0o6ptg5JVwP/viUmd5Kk+vsTgaCNHT9HM5ta/iOSdX7nJP383/HV
         GwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170648; x=1698775448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiNf7bxs7WQlL1p7N8zEaMblQKww7yLL72WVvv0ROXY=;
        b=S/6yYqmF4hCJAe6fO1+Hbz6ynAb83CqZElzP4SgpP/RfWDOFii+bLfFg6/KoTucnnP
         9fAaq+/4Y7PjA3cbDxrU2Ja6o0ZmGBXMNxBSPqRYLZGY5W5M59OQVyfJAqXxOISVgjIU
         jzirB3/ymIWPmcO/3plpwh17V6k9zX9wb/LYNw8nK9S1bnFQ2SOID1QX3BaAdK6IwONZ
         Ls4oRc9GApTJAYm0rxsc3mBlBLPVmoZr+aP9N1YmL0vKsFl0frhDd4bfNygAOZzbZ//u
         RPpO7pIPCqI+LB4hA9v1pmeAItLKYJBie3POcmdF/gPMVI4tCd9m6R3MEVHk7xSWnxp1
         TyJw==
X-Gm-Message-State: AOJu0YxHZGjybF4xr2KlV13z95fK3xE4y7BSDUeQU0baZEnJ/7qf2Xms
        PrB4OF3qcVOzCkfWUgDdBjI=
X-Google-Smtp-Source: AGHT+IGGmy0G/+afdYUJkH5aUTsk4FzE1PuM+hOPncww8+bWosXhuzeZyzk6ESrdepCC8vjB/+o4NA==
X-Received: by 2002:a05:6a20:7348:b0:17b:2c56:70bc with SMTP id v8-20020a056a20734800b0017b2c5670bcmr4227853pzc.10.1698170648145;
        Tue, 24 Oct 2023 11:04:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e14-20020aa798ce000000b0069023d80e63sm7872398pfm.25.2023.10.24.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:04:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Oct 2023 11:04:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     j@jannau.net
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: apple: Deactivate on suspend
Message-ID: <5e975f5d-c60b-43fb-ab15-f657cb8419a3@roeck-us.net>
References: <20231016-apple-watchdog-suspend-v2-1-7ffff8042dbc@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-apple-watchdog-suspend-v2-1-7ffff8042dbc@jannau.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:58:01AM +0200, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> The watchdog remains active after putting the system into suspend. Add
> PM callbacks to deactivate the watchdog on suspend an re-activate it on
> resume.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> - use DEFINE_SIMPLE_DEV_PM_OPS
> - Link to v1: https://lore.kernel.org/r/20230930-apple-watchdog-suspend-v1-1-1998c0be9fd7@jannau.net
> ---
>  drivers/watchdog/apple_wdt.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index eddeb0fede89..d4f739932f0b 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -173,6 +173,8 @@ static int apple_wdt_probe(struct platform_device *pdev)
>  	if (!wdt->clk_rate)
>  		return -EINVAL;
>  
> +	platform_set_drvdata(pdev, wdt);
> +
>  	wdt->wdd.ops = &apple_wdt_ops;
>  	wdt->wdd.info = &apple_wdt_info;
>  	wdt->wdd.max_timeout = U32_MAX / wdt->clk_rate;
> @@ -190,6 +192,28 @@ static int apple_wdt_probe(struct platform_device *pdev)
>  	return devm_watchdog_register_device(dev, &wdt->wdd);
>  }
>  
> +static int apple_wdt_resume(struct device *dev)
> +{
> +	struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +		apple_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int apple_wdt_suspend(struct device *dev)
> +{
> +	struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +		apple_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
> +
>  static const struct of_device_id apple_wdt_of_match[] = {
>  	{ .compatible = "apple,wdt" },
>  	{},
> @@ -200,6 +224,7 @@ static struct platform_driver apple_wdt_driver = {
>  	.driver = {
>  		.name = "apple-watchdog",
>  		.of_match_table = apple_wdt_of_match,
> +		.pm = pm_sleep_ptr(&apple_wdt_pm_ops),
>  	},
>  	.probe = apple_wdt_probe,
>  };
> 
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230930-apple-watchdog-suspend-7f73831130fb
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
