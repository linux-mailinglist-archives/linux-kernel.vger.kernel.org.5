Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616FE7578C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGRKCb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjGRKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:02:12 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F91B6;
        Tue, 18 Jul 2023 03:02:11 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-579e5d54e68so59397397b3.1;
        Tue, 18 Jul 2023 03:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689674530; x=1692266530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxfecajh7LakVWsGzhfvx2yBPK9ZrfliTdUgb+tNhHc=;
        b=Gg8L6ytWvcMK4bmQdVqUaan3zGtLk3v27M77tXRNJH+nrV6tKNl8hZDN+w4qkxeKNX
         3ilIDMOaL3prKYUvIJ8cpDLLo2xJ350kOq/FQfIpQZM7zUEhgIE/afv7GDYJRN4fts/8
         tCGLKZZfYh/OmI0P0OxqnDWEeZMt/GtLDyRUZxiyKwxQgqQMJJ+aNJ3HrQp8erFkY5iR
         DUmuG9lFn3aGn55pS6AQWq31kcwlcwM9uzBMgaqo5vvN7B2Rh6vRpc8S/hxyp7qNm4UG
         dzGrwjEXRrzfxRh8h0xPkOQ4x+EN0ab526QF0KyA4LvoTP9kGWTZUHDJ9yC8j1mzLxvp
         Akvw==
X-Gm-Message-State: ABy/qLYP7kb+1OiBivAoZTSQzHkOXUghjT2Ro5u0W/F+28mf5Q6RyLAP
        H+SiUyTQKgBgwPSkE5x6A6PxalKDFuQBgw==
X-Google-Smtp-Source: APBJJlEMYLizvb/uPfAFOnhD7hOUEcOM1s3m8Wr4YK+zgNZFIDlAA67/SAwLzWgJgnZUBZJ5zWbEgw==
X-Received: by 2002:a81:6fc4:0:b0:561:d25b:672a with SMTP id k187-20020a816fc4000000b00561d25b672amr15364245ywc.21.1689674530542;
        Tue, 18 Jul 2023 03:02:10 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id u75-20020a81844e000000b0057a44e20fb8sm357253ywf.73.2023.07.18.03.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 03:02:10 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bff27026cb0so5647967276.1;
        Tue, 18 Jul 2023 03:02:09 -0700 (PDT)
X-Received: by 2002:a25:13c8:0:b0:bcb:9b43:5a89 with SMTP id
 191-20020a2513c8000000b00bcb9b435a89mr13444895ybt.61.1689674529762; Tue, 18
 Jul 2023 03:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com> <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jul 2023 12:01:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_4wmim_R0oA=4df8-0JKGwTkJJMxEiZSMwtVtv1wuFg@mail.gmail.com>
Message-ID: <CAMuHMdX_4wmim_R0oA=4df8-0JKGwTkJJMxEiZSMwtVtv1wuFg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] pinctrl: renesas: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 7:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
