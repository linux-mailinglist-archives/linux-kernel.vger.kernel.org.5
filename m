Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E47578C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGRKBp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjGRKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:01:35 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B316E4F;
        Tue, 18 Jul 2023 03:01:27 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1bac0e25891so79814fac.2;
        Tue, 18 Jul 2023 03:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689674486; x=1692266486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMWNFsiRP079B5LYbYLQZfm+Mzjz5LU2gLm2aCCBKHU=;
        b=gQmr3YApxV2Jhjpqyvd72TBslFNKanvStKead9ackCb+XfH1HfKfOeFsWE+MnmHnxd
         u8ULDNZ+uBzApx/sEdncdt8/3ST1LFWbgKDKgJvUiskmOzlrFfdTeUI0o6E66s8gVfI9
         QlbziFW7SPaAEaPXcIATqr8xD4H2OUHDd/n/KVsVEGv4fYUC5UQh99FMEKM/47HRxa99
         lo9WEvv8VBwrvY5Bj1LsOveJdkIpGvmYw1eVBSDsbjprgaQ/9R9sjOjz+9uY5IjCy536
         YACC/AXrch9DB9bXN6GaKE+yhC0J+AQ/MUfBsCUNsfNGy6zW0vWrtqZXChuLp5APiwhc
         y71Q==
X-Gm-Message-State: ABy/qLb1ENz5f2W4v22OqgpZa3UNgv+jEq4yezx2EaOX/92iC1+z/Hzd
        7ezETDY3+VGvaa0zvc2kUYwh86sAPud+iA==
X-Google-Smtp-Source: APBJJlGpPMp+VLxaQawE6UPllhsXVy9xKvYavIrRlsmt/g8J7Uxueo9LVlIW53BnfC3abFoolGYlmw==
X-Received: by 2002:aca:bd06:0:b0:3a4:11a1:4cd8 with SMTP id n6-20020acabd06000000b003a411a14cd8mr11993989oif.4.1689674486551;
        Tue, 18 Jul 2023 03:01:26 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w207-20020a8149d8000000b00570589c5aedsm369201ywa.7.2023.07.18.03.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 03:01:26 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so5634794276.2;
        Tue, 18 Jul 2023 03:01:26 -0700 (PDT)
X-Received: by 2002:a5b:c47:0:b0:ced:271:950a with SMTP id d7-20020a5b0c47000000b00ced0271950amr437150ybr.47.1689674485821;
 Tue, 18 Jul 2023 03:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com> <20230717172821.62827-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230717172821.62827-2-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jul 2023 12:01:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVgRDrWwQ6PKtgDE1Kmbp_zsmfrbswvG9Sq30zUVMZRAw@mail.gmail.com>
Message-ID: <CAMuHMdVgRDrWwQ6PKtgDE1Kmbp_zsmfrbswvG9Sq30zUVMZRAw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 7:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> _DEFINE_DEV_PM_OPS() helps to define PM operations for the system sleep
> and/or runtime PM cases. Some of the existing users want to have _noirq()
> variants to be set. For that purpose introduce a new helper which sets
> up _noirq() callbacks to be set and struct dev_pm_ops be provided.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
