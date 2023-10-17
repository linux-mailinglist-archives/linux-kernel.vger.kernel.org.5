Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30A7CC60A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJQOjg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjJQOjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:39:33 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E4B0;
        Tue, 17 Oct 2023 07:39:31 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99357737980so950854766b.2;
        Tue, 17 Oct 2023 07:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697553569; x=1698158369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSBGvJBtrmqf+urGWh+wa2QhIgHNfzUvaKB+5zrRekk=;
        b=fuvVqizpRXaQRlnGRFkJQtU+3qDUaC3iYoO9h+4vBkAoYJYMVKiVQxy1/kjb6YcfUl
         vHPKANmpb0TLcxqJ4JJum3oSApy2JxLEHZb14xkRcaL1Oy3Y96x84d7b8V6ltro4CngZ
         XJje7MUMbGQjCUbPMRkm2Jn7ukTL93hLkNUaNzHZ8oLJPjSxvbQ+klRnBMJNzVpWcAMf
         TI9Qvxj7sEsgAv87qQvcOzWuV7pmLFrXfe/C4LdoJisqr7hXA+fINcsIBMfC1Q6UbuCP
         3vF3DBIYDv4fDAM/PRxjIEe6ms7hkdDP+LtRDlX70Ze/CdD6wU5c2K+tSFF/h3KnGiGg
         uwWQ==
X-Gm-Message-State: AOJu0YxG1WIQYu9cv9ks9mb2WNnJbD7semYjkNkkHu7ZuRjzqeV0a6TO
        hoB71U6US9VdLnaaCrMrm7Boq3lhYw/DMPAE
X-Google-Smtp-Source: AGHT+IGz6UugMXmsPlXwKi2YFXeCcLbGYiX03RTDFCaHa2HS7EHIS+3pvB6jpJ4xH5AdVDjELozbUg==
X-Received: by 2002:a17:907:7211:b0:9be:1dbd:552e with SMTP id dr17-20020a170907721100b009be1dbd552emr1911947ejc.68.1697553568935;
        Tue, 17 Oct 2023 07:39:28 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906749600b009ae587ce128sm1377625ejl.216.2023.10.17.07.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:39:28 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so9983270a12.0;
        Tue, 17 Oct 2023 07:39:28 -0700 (PDT)
X-Received: by 2002:a17:907:9403:b0:99c:6692:7f76 with SMTP id
 dk3-20020a170907940300b0099c66927f76mr1833687ejc.16.1697553568208; Tue, 17
 Oct 2023 07:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-apple-watchdog-suspend-v2-1-7ffff8042dbc@jannau.net>
In-Reply-To: <20231016-apple-watchdog-suspend-v2-1-7ffff8042dbc@jannau.net>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 17 Oct 2023 10:38:51 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-UMr7ZzSjPraHqkAneoHgBKsis7jfzcYt0vcgvUADi4Q@mail.gmail.com>
Message-ID: <CAEg-Je-UMr7ZzSjPraHqkAneoHgBKsis7jfzcYt0vcgvUADi4Q@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: apple: Deactivate on suspend
To:     j@jannau.net
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 2:58 AM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> The watchdog remains active after putting the system into suspend. Add
> PM callbacks to deactivate the watchdog on suspend an re-activate it on
> resume.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
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
>         if (!wdt->clk_rate)
>                 return -EINVAL;
>
> +       platform_set_drvdata(pdev, wdt);
> +
>         wdt->wdd.ops = &apple_wdt_ops;
>         wdt->wdd.info = &apple_wdt_info;
>         wdt->wdd.max_timeout = U32_MAX / wdt->clk_rate;
> @@ -190,6 +192,28 @@ static int apple_wdt_probe(struct platform_device *pdev)
>         return devm_watchdog_register_device(dev, &wdt->wdd);
>  }
>
> +static int apple_wdt_resume(struct device *dev)
> +{
> +       struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +               apple_wdt_start(&wdt->wdd);
> +
> +       return 0;
> +}
> +
> +static int apple_wdt_suspend(struct device *dev)
> +{
> +       struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +               apple_wdt_stop(&wdt->wdd);
> +
> +       return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
> +
>  static const struct of_device_id apple_wdt_of_match[] = {
>         { .compatible = "apple,wdt" },
>         {},
> @@ -200,6 +224,7 @@ static struct platform_driver apple_wdt_driver = {
>         .driver = {
>                 .name = "apple-watchdog",
>                 .of_match_table = apple_wdt_of_match,
> +               .pm = pm_sleep_ptr(&apple_wdt_pm_ops),
>         },
>         .probe = apple_wdt_probe,
>  };
>
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230930-apple-watchdog-suspend-7f73831130fb
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
