Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BCF7AD75E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjIYMAC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjIYMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:00:01 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658A2A9;
        Mon, 25 Sep 2023 04:59:54 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59e77e4f707so74461267b3.0;
        Mon, 25 Sep 2023 04:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643193; x=1696247993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rAJ86cN+xrwluhtuXjfUlYkU73XqMR8cTagUgAndoo=;
        b=HXBY4O4MyDAzV4xqmA4tzPYMTXs03XNhBGFhRmfdmGQbLmHnqEYQPaMbL+4m/CG/c8
         IQz7ZBYKTkbR+WmLy6bQchm3R/OovuQT0ai/NY1S7nsqguYbH2KG1uGM1C3xINFFlqJF
         A7DYOEz0Ldb7vue00GrX3yDsoooxhYL9c+ODPUoYTlnGzH5VYlIgIaXtH5wgOdYxOCQ7
         /NVZVx0n6TgGS0pWye/BRlFjJMxV3VjsdubPhJgXmzwAnYr8AB/Fw+YLha1tJhZkHaOH
         QBEjj0QcC9/JXk4d7URhqpH1uoKVOv44y9n+BOFtIg3MZl8pYjWbxbHYG3oJy69vYFkS
         /tkg==
X-Gm-Message-State: AOJu0YyfAZKAbqHp+GxISSQTA3dEaqVInY52wkNDfaPpG6u0/Zt84Mm/
        9NXOAtsGKOZp+x8zb81jZ9yGyk4J2o8J9A==
X-Google-Smtp-Source: AGHT+IFAr3VsepoMskF1gDCakA6IzY2ljOU5ewMX0q+Rri2USPg6wYjlyQ7uU+OLUqQI2SGSVX8Zhw==
X-Received: by 2002:a81:7b83:0:b0:595:89b0:6b41 with SMTP id w125-20020a817b83000000b0059589b06b41mr6713081ywc.38.1695643193156;
        Mon, 25 Sep 2023 04:59:53 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id m18-20020a81ae12000000b005922c29c025sm590935ywh.108.2023.09.25.04.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 04:59:52 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59e77e4f707so74460667b3.0;
        Mon, 25 Sep 2023 04:59:52 -0700 (PDT)
X-Received: by 2002:a05:690c:4246:b0:59f:4e6d:b565 with SMTP id
 gi6-20020a05690c424600b0059f4e6db565mr4869645ywb.11.1695643192435; Mon, 25
 Sep 2023 04:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230922073714.6164-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230922073714.6164-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 13:59:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDhkhd9rOK7Ns5ViT3JMdDD3OB_sU9tSX4QGJ=7chKqA@mail.gmail.com>
Message-ID: <CAMuHMdXDhkhd9rOK7Ns5ViT3JMdDD3OB_sU9tSX4QGJ=7chKqA@mail.gmail.com>
Subject: Re: [PATCH] drm: tilcdc: don't use devm_pinctrl_get_select_default()
 in probe
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC pinctrl

On Fri, Sep 22, 2023 at 6:26 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Since commit ab78029ecc34 ("drivers/pinctrl: grab default handles from
> device core"), we can rely on device core for setting the default pins.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> @@ -6,7 +6,6 @@
>
>  #include <linux/backlight.h>
>  #include <linux/gpio/consumer.h>
> -#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>
>  #include <video/display_timing.h>
> @@ -308,7 +307,6 @@ static int panel_probe(struct platform_device *pdev)
>         struct backlight_device *backlight;
>         struct panel_module *panel_mod;
>         struct tilcdc_module *mod;
> -       struct pinctrl *pinctrl;
>         int ret;
>
>         /* bail out early if no DT data: */
> @@ -342,10 +340,6 @@ static int panel_probe(struct platform_device *pdev)
>
>         tilcdc_module_init(mod, "panel", &panel_module_ops);
>
> -       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> -       if (IS_ERR(pinctrl))
> -               dev_warn(&pdev->dev, "pins are not configured\n");
> -
>         panel_mod->timings = of_get_display_timings(node);
>         if (!panel_mod->timings) {
>                 dev_err(&pdev->dev, "could not get panel timings\n");

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
