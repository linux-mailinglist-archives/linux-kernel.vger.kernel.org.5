Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E07A832B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjITNVH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjITNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:21:06 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29791;
        Wed, 20 Sep 2023 06:21:00 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59be9a09c23so69922107b3.1;
        Wed, 20 Sep 2023 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216059; x=1695820859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka/OcyoPMxG4j7LyFSyUdeXyO8W0OSLZSbeuJkMK0nM=;
        b=P+NTtcFyaBc/nzxDx5U0Z7Sax4b1GfAZ37TUpwB8TAwRoc4GIf5k6/ZYwdaeLVtxHp
         IlzV9XeQvHkY4unwoKaKm5zTAh4TxwfK2EvpDi+ZxycB43I37Sf4sbQenEODKfXZvR1C
         E/CdLPL/3vcnZ1bA45SsWuaOBCvBKpQXmA6L+vcauRaLg69ztyeiySByvktptCTXUFgn
         dIz/8CEAAt5jcD2kglFDawzHCkpbFfFTqWXR9qJfVopN1IxAlapI4iYNqUtyuwZVdlqT
         X11GOPrAOVmBd+r/QenW5pbXIRGGg8RH5JBEaPNkNXwB6N/kiNGKtMhfiYFsL+v5OCwB
         v0IA==
X-Gm-Message-State: AOJu0YyJuNndb1cYfUFf7ak6bGXdk9Tmjpcrz3Sk7quBqPBkAWelf5Hd
        KNKy/doTWKCQK9Pdi0dd3mu+Eg+f8bMJjA==
X-Google-Smtp-Source: AGHT+IEtU7n0U/31lgYZvjj9wyWugYzGwgKQ95rbX2RbVhVOgffG2ZyBxOqIEddPMNw98a9QR76BQA==
X-Received: by 2002:a0d:d68d:0:b0:56d:3b91:7e78 with SMTP id y135-20020a0dd68d000000b0056d3b917e78mr2284775ywd.20.1695216057584;
        Wed, 20 Sep 2023 06:20:57 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id d145-20020a814f97000000b0059bcadded9dsm3770319ywb.116.2023.09.20.06.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:20:56 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59e8d963adbso39015297b3.0;
        Wed, 20 Sep 2023 06:20:56 -0700 (PDT)
X-Received: by 2002:a0d:d9c8:0:b0:59b:fe73:debc with SMTP id
 b191-20020a0dd9c8000000b0059bfe73debcmr2567469ywe.0.1695216056182; Wed, 20
 Sep 2023 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-24-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-24-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Sep 2023 15:20:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwnsJ0uKeLtFcwB6a2nQtaSUPu0ZR7kYwQeEhKMhfXFQ@mail.gmail.com>
Message-ID: <CAMuHMdUwnsJ0uKeLtFcwB6a2nQtaSUPu0ZR7kYwQeEhKMhfXFQ@mail.gmail.com>
Subject: Re: [PATCH 23/37] pinctrl: renesas: rzg2l: index all registers based
 on port offset
To:     Claudiu <claudiu.beznea@tuxon.dev>,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your patch!

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> To get address that needs to be read/write for specific port
> functionalities the P(), PM(), PMC(), PFC(), PIN(), IOLH() IEN(), ISEL()
> macros are used. Some of these macros received as argument the hardware
> port identifier, some hardware port offset address (e.g. ISEL() received
> port identifier, IOLH() received port offset address). This makes hard to
> extend the current driver for SoCs were port identifiers are not continuous
> in memory map of pin controller. This is the case for RZ/G3S pin controller
> were ports are mapped as follows:
>
> port offset    port identifier
> -----------    ---------------
> 0x20           P0
> 0x21           P5
> 0x22           P6
> 0x23           P11
> 0x24           P12
> 0x25           P13
> 0x26           P14
> 0x27           P15
> 0x28           P16
> 0x29           P17
> 0x2a           P18
> 0x30           P1
> 0x31           P2
> 0x32           P3
> 0x33           P4
> 0x34           P7
> 0x35           P8
> 0x36           P8
> 0x37           P10
>
> To make this achievable change all the above macros used to get the address
> of a port register for specific port functionality based on port hardware
> address. Shortly, all the above macros will get as argument the port
> offset address listed in the above table.
>
> With this RZG2L_SINGLE_PIN_GET_PORT_OFFSET() and
> RZG2L_PIN_ID_TO_PORT_OFFSET() were replaced by

and RZG2L_GPIO_PORT_GET_INDEX()?

> RZG2L_PIN_CFG_TO_PORT_OFFSET(), RZG2L_SINGLE_PIN_GET_CFGS() and
> RZG2L_GPIO_PORT_GET_CFGS() were replaced by RZG2L_PIN_CFG_TO_CAPS().
>
> Also rzg2l_pinctrl_set_pfc_mode() don't need port argument anymore.
> Also rzg2l_gpio_direction_input() and rzg2l_gpio_direction_output() don't
> need to translate port and bit locally as this can be done by
> rzg2l_gpio_set_direction().
>
> To use the same naming for port, bit/pin and register offset the
> port_offset variable names in different places was replaced by variable
> named off and there is no need to initialize anymore cfg and bit in
> different code places.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

This looks like a nice cleanup, thanks a lot!
Prabhakar: do you like it, too?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
You can find a few suggestions for improvement below...

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -202,9 +202,11 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>                                  unsigned int group_selector)
>  {
>         struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct pinctrl_pin_desc *pin_desc;
> +       unsigned int i, *psel_val, *pin_data;
>         struct function_desc *func;
> -       unsigned int i, *psel_val;
>         struct group_desc *group;
> +       u32 port, pin, off;

Please move the new variable declarations inside the for(), and
combine them with their initialization.

>         int *pins;
>
>         func = pinmux_generic_get_function(pctldev, func_selector);
> @@ -218,11 +220,17 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>         pins = group->pins;
>
>         for (i = 0; i < group->num_pins; i++) {
> -               dev_dbg(pctrl->dev, "port:%u pin: %u PSEL:%u\n",
> -                       RZG2L_PIN_ID_TO_PORT(pins[i]), RZG2L_PIN_ID_TO_PIN(pins[i]),
> -                       psel_val[i]);
> -               rzg2l_pinctrl_set_pfc_mode(pctrl, RZG2L_PIN_ID_TO_PORT(pins[i]),
> -                                          RZG2L_PIN_ID_TO_PIN(pins[i]), psel_val[i]);
> +               pin_desc = &pctrl->desc.pins[pins[i]];
> +               pin_data = pin_desc->drv_data;
> +
> +               port = RZG2L_PIN_ID_TO_PORT(pins[i]);

As port is unused but in the debug print, please drop the variable,
and use RZG2L_PIN_ID_TO_PORT() in the debug print below.

> +               pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
> +               off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
> +
> +               dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n", port,
> +                       pin, off, psel_val[i]);
> +
> +               rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
>         }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
