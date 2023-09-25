Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A37AD7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjIYMN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:13:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26F19C;
        Mon, 25 Sep 2023 05:13:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c60cec8041so12636415ad.3;
        Mon, 25 Sep 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695643999; x=1696248799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+sBQGiQz3C729qMtYzgf0M3OFSDBSoB6u+AGZ2aBJA=;
        b=W4j8JG3UXftAGIRUJeekc7kRi2le2ZleGDXDtAodf+C9j30uort8jKOCWbdl2Ca1u9
         qmuuHGHp2SD3J8jFTYXKyG6iic2i+8f+F7YU35CeFOK0isSeNn1B3Expou/jyVIjxzlE
         VwKwETTRpmuzDJkG9v3ssQ1fLHVrui4I4zqpZT5GWwGTdPiEMsd0B8KPowB+kUncaWeV
         1NV595P44OTIhYJxEMuBdB1T/yxDl4gQPTcf//vpHI93e+IYY4n6F1YFI5acIOAJeaw1
         xl6dCpZlhVr1elKIBX3Ss5AqdSMK07gpezrAok7GeoGeT4w5RZXQA6/aPpOFnxKbnqT2
         +Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643999; x=1696248799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+sBQGiQz3C729qMtYzgf0M3OFSDBSoB6u+AGZ2aBJA=;
        b=JgoK91mKK5aYHcKwliYLtxD2XbP9NuXMzP9YRzDzlrmzyjhTcY+MxiiHPyO4OF8APD
         Q8tkXPvLVQwRHCcLrMDiqXrmE/PL389jhlCyLIBnLsUpT6fm1iXHMy3wH8hmwgl9ucJ+
         vRBmFx9Vnnlen7IXjgZqBQeDuyS8BHh6vRHtd6PDhiR+XQvws7T5jyfSJqmt/egO76+3
         hFD42TuCRNwQeAB/z6yCEhpKMwcQ2o+5m8Wqf4M2K5HyjJ2COcU3tsxnQBn29pKw6yOq
         Q5HKozCXU6q4Gp/PFl467t+CO9GHUzgo0TpvZR1WYOfc+7LjzUHMs8RaocvxfB6OZDoJ
         L/gQ==
X-Gm-Message-State: AOJu0YzDsWIONdUPCBJ1g2dayX8y2lpRYWL3y+sPIHq9URmvKLCLBHyr
        XXOqro5Ge+wKmJeja5QSSAk=
X-Google-Smtp-Source: AGHT+IH2N8ISB7HbAdTxI83rL8VJvdDk1/DS6obpGOCgLF6GkwlKz2Edy3sauvQoObMmApq16BBGZQ==
X-Received: by 2002:a17:903:60d:b0:1c0:d7a8:a43e with SMTP id kg13-20020a170903060d00b001c0d7a8a43emr3599502plb.53.1695643999004;
        Mon, 25 Sep 2023 05:13:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b89891bfc4sm8642906plh.199.2023.09.25.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:13:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Sep 2023 05:13:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: ixp4xx: Make sure restart always works
Message-ID: <8034c824-7836-48cf-a974-05f3491f133d@roeck-us.net>
References: <20230925-ixp4xx-wdt-restart-v1-1-fe2b9b131dbf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-ixp4xx-wdt-restart-v1-1-fe2b9b131dbf@linaro.org>
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

On Mon, Sep 25, 2023 at 09:20:05AM +0200, Linus Walleij wrote:
> The IXP4xx watchdog in early "A0" silicon is unreliable and
> cannot be registered, however for some systems such as the
> USRobotics USR8200 the watchdog is the only restart option,
> so implement a "dummy" watchdog that can only support restart
> in this case.
> 
> Fixes: 1aea522809e6 ("watchdog: ixp4xx: Implement restart")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Other solutions like implementing a pure restart notifier
> callback catch in the driver is possible, but this method
> will minimize the amount of code and reuse infrastructure
> in the core.
> ---
>  drivers/watchdog/ixp4xx_wdt.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
> index 607ce4b8df57..c0bf03125ec8 100644
> --- a/drivers/watchdog/ixp4xx_wdt.c
> +++ b/drivers/watchdog/ixp4xx_wdt.c
> @@ -105,6 +105,25 @@ static const struct watchdog_ops ixp4xx_wdt_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +/*
> + * The A0 version of the IXP422 had a bug in the watchdog making
> + * is useless, but we still need to use it to restart the system
> + * as it is the only way, so in this special case we register a
> + * "dummy" watchdog that doesn't really work, but will support
> + * the restart operation.
> + */
> +static int ixp4xx_wdt_dummy(struct watchdog_device *wdd)
> +{
> +	return 0;
> +}
> +
> +static const struct watchdog_ops ixp4xx_wdt_restart_only_ops = {
> +	.start = ixp4xx_wdt_dummy,
> +	.stop = ixp4xx_wdt_dummy,
> +	.restart = ixp4xx_wdt_restart,
> +	.owner = THIS_MODULE,
> +};
> +
>  static const struct watchdog_info ixp4xx_wdt_info = {
>  	.options = WDIOF_KEEPALIVEPING
>  		| WDIOF_MAGICCLOSE
> @@ -114,14 +133,17 @@ static const struct watchdog_info ixp4xx_wdt_info = {
>  
>  static int ixp4xx_wdt_probe(struct platform_device *pdev)
>  {
> +	static const struct watchdog_ops *iwdt_ops;
>  	struct device *dev = &pdev->dev;
>  	struct ixp4xx_wdt *iwdt;
>  	struct clk *clk;
>  	int ret;
>  
>  	if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
> -		dev_err(dev, "Rev. A0 IXP42x CPU detected - watchdog disabled\n");
> -		return -ENODEV;
> +		dev_err(dev, "Rev. A0 IXP42x CPU detected - only restart supported\n");

With this change this is no longer an error.

> +		iwdt_ops = &ixp4xx_wdt_restart_only_ops;
> +	} else {
> +		iwdt_ops = &ixp4xx_wdt_ops;
>  	}
>  
>  	iwdt = devm_kzalloc(dev, sizeof(*iwdt), GFP_KERNEL);
> @@ -141,7 +163,7 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
>  		iwdt->rate = IXP4XX_TIMER_FREQ;
>  
>  	iwdt->wdd.info = &ixp4xx_wdt_info;
> -	iwdt->wdd.ops = &ixp4xx_wdt_ops;
> +	iwdt->wdd.ops = iwdt_ops;
>  	iwdt->wdd.min_timeout = 1;
>  	iwdt->wdd.max_timeout = U32_MAX / iwdt->rate;
>  	iwdt->wdd.parent = dev;
> 
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230924-ixp4xx-wdt-restart-d6bf28493173
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 
