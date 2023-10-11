Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085777C4E91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjJKJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjJKJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:26:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF29E;
        Wed, 11 Oct 2023 02:26:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so1143024966b.2;
        Wed, 11 Oct 2023 02:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1697016404; x=1697621204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+gXxCxi6vp030i+agdceTeSycONQUjyDJd68wM+eSmw=;
        b=hH4ZAk8GBQuWvOuaQs8u+SAYGqoBk+k/NPadLSFWpJzh1k2E27d1K9Hj8BadhivUpB
         pIW6zgTaM4pp8Pvi697w0XlLr6YEB1IrGqNArKNi05o03wlaUs+bbjW1eu0vXqfjwGG0
         oPB/gcKXnfRePefAikpGpVQpC2Zh1Mv9T0eJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016404; x=1697621204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gXxCxi6vp030i+agdceTeSycONQUjyDJd68wM+eSmw=;
        b=WaGrpNASuKF9rMO6JNNhuGuCiYCNc2dFqPzvI3wGKTuP4bvwvHJPthefJCIcyJiN98
         IyUykVQM6l/AfJ+LEUTqu/zmq3LBI94EEBDR6D0ojuq5RI++Pgx+GOidvL31mob4FAcJ
         UTG1HS7wrOO0MURukUwQCJ5UjSrLpmfL5cIUeFwJC4cKDvbpWEpUHVmCLovg0bj84dQB
         myTdVfD9q7jN65ZXSZA1t6rr2WyNJi5kDgPQiigW+rV+bLo8+/C4S9QrC1LhxrrGjgZs
         jw4pxoK2g+1bMDb0Y6ga4hcT6eoVhSjef+JCYPlS7oYpcK39ZdBhWYVcZHp3ceNQsCfY
         kHAg==
X-Gm-Message-State: AOJu0YyMvWcHc1Pyv8UGDvnVeEDSk4LalqSEfdfoRZzOoGpip4Q6/h1N
        vvaMdsTkG7PWhac0KSkznv4OS5Ex0VUHSrXKSz0=
X-Google-Smtp-Source: AGHT+IHApwH+q9IPC29LKXoGHb2xdanm+kml7BeaRr/3PjuQ3NKQJoVq6Zhgzq28/yAtLmjZHjvfQbxoOnsjY+1Rl5M=
X-Received: by 2002:a17:907:7817:b0:9ad:e17c:464e with SMTP id
 la23-20020a170907781700b009ade17c464emr17132987ejc.68.1697016403957; Wed, 11
 Oct 2023 02:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230922104231.1434-4-zev@bewilderbeest.net> <20230922104231.1434-6-zev@bewilderbeest.net>
In-Reply-To: <20230922104231.1434-6-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Oct 2023 19:56:32 +1030
Message-ID: <CACPK8Xe5UEDt+ko_FtF-fi1TZDNZeZMtzaU_ZBxt6CO+UHJEpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: aspeed: Add support for aspeed,reset-mask
 DT property
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 20:12, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This property allows the device-tree to specify how the Aspeed
> watchdog timer's reset mask register(s) should be set, so that
> peripherals can be individually exempted from (or opted in to) being
> reset when the watchdog timer expires.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

A note below.

> ---
>  drivers/watchdog/aspeed_wdt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b72a858bbac7..b4773a6aaf8c 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -79,6 +79,8 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>  #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY    BIT(1)
>  #define WDT_CLEAR_TIMEOUT_STATUS       0x14
>  #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION    BIT(0)
> +#define WDT_RESET_MASK1                0x1c
> +#define WDT_RESET_MASK2                0x20
>
>  /*
>   * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
> @@ -402,6 +404,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>
>         if ((of_device_is_compatible(np, "aspeed,ast2500-wdt")) ||
>                 (of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
> +               u32 reset_mask[2];
> +               size_t nrstmask = of_device_is_compatible(np, "aspeed,ast2600-wdt") ? 2 : 1;
>                 u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>
>                 reg &= wdt->cfg->ext_pulse_width_mask;
> @@ -419,6 +423,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>                         reg |= WDT_OPEN_DRAIN_MAGIC;
>
>                 writel(reg, wdt->base + WDT_RESET_WIDTH);
> +
> +               ret = of_property_read_u32_array(np, "aspeed,reset-mask", reset_mask, nrstmask);
> +               if (!ret) {
> +                       writel(reset_mask[0], wdt->base + WDT_RESET_MASK1);
> +                       if (nrstmask > 1)
> +                               writel(reset_mask[1], wdt->base + WDT_RESET_MASK2);
> +               }

This will do funky things if someone is careless enough to put the
property in an ast2400 device tree.

The ast2700 has four reset mask registers. Not really your problem at
this point, but we might need to move to a per-soc callback in the
platform data or similar.

>         }
>
>         if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
> --
> 2.40.0.5.gf6e3b97ba6d2.dirty
>
