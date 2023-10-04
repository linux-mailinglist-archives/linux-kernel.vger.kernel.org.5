Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CA7B7FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjJDMwt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:52:47 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B1B0;
        Wed,  4 Oct 2023 05:52:43 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d89ba259964so2146260276.2;
        Wed, 04 Oct 2023 05:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696423962; x=1697028762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBL5QUqe0Kh8uzoko40pp2HXZhfkObRutzBhYjUaXf4=;
        b=VS8uP8eNRTFrwI/2q5U/IlzvKlsuMhhuxIFfuamDJ34N/rZLyVNpeBnRiVZgf9YDmS
         r9pbyprHon6u2BNlXdtbhaJn6UOtfSKOSIZu+N1lddAHs8U6d5MGn3f3qjN+oFUzuKMJ
         RAshjDec72BOlIQ4eZOVHNpp06kox01Dg1nbgDJ09OUpmS2mJ1tssS3ASiWR2x8iJF9i
         sdNiIHs8J8YR+WKg8zxhajWo7GsdK4+gtdQfZiCPvUZckt/aK7s4QZt9mj8vZsk72uD5
         jmBoG3O2lc/DH/mcZuWPSRi3lBGch78OYc6Pc9Mm54dI/8yWgTMqC/Kh1YHtDpiljnVO
         Ib6g==
X-Gm-Message-State: AOJu0Yw3/DkuIU06PKhKpa5/MqssnhGVq/0cEZL5yWnI/ayd78T+J7Jb
        ZvZ2HtQ1doj6zUJX4mSrVvoO1xmmMnEbZA==
X-Google-Smtp-Source: AGHT+IGR9YC3TA37FUPT0izo16noKpGS8cKa7IAZZs3Z6jE1noCuRwJznhQx3Q+N+dSfBAc0K9g5Yg==
X-Received: by 2002:a5b:70d:0:b0:d8b:d12:87a5 with SMTP id g13-20020a5b070d000000b00d8b0d1287a5mr1857047ybq.34.1696423961971;
        Wed, 04 Oct 2023 05:52:41 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id c11-20020a25880b000000b00c62e0df7ca8sm1003969ybl.24.2023.10.04.05.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:52:41 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59f6e6b206fso25029897b3.3;
        Wed, 04 Oct 2023 05:52:41 -0700 (PDT)
X-Received: by 2002:a81:d54e:0:b0:577:189b:ad4 with SMTP id
 l14-20020a81d54e000000b00577189b0ad4mr2280819ywj.48.1696423961482; Wed, 04
 Oct 2023 05:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-15-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-15-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 14:52:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX17ZwHpCC75Xr4BxK69+1bumbDFYrYqLWLaybRkoRtXg@mail.gmail.com>
Message-ID: <CAMuHMdX17ZwHpCC75Xr4BxK69+1bumbDFYrYqLWLaybRkoRtXg@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] pinctrl: renesas: rzg2l: index all registers
 based on port offset
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
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
> With this RZG2L_SINGLE_PIN_GET_PORT_OFFSET(), RZG2L_PIN_ID_TO_PORT_OFFSET()
> and RZG2L_GPIO_PORT_GET_INDEX() were replaced by
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>
> Changes in v2:
> - mentioned in commit description about the replacement of
>   RZG2L_GPIO_PORT_GET_INDEX() with RZG2L_PIN_CFG_TO_PORT_OFFSET()
> - moved variable declaration inside for()
> - got rid of local variable and used directly RZG2L_PIN_ID_TO_PORT() in
>   debug message from rzg2l_pinctrl_set_mux() function
> - collected tags

Thanks for the update! Sill queue in renesas-pinctrl-for-v6.7.

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -202,9 +202,11 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>                                  unsigned int group_selector)
>  {
>         struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct pinctrl_pin_desc *pin_desc;
> +       unsigned int *psel_val, *pin_data;
>         struct function_desc *func;
> -       unsigned int i, *psel_val;
>         struct group_desc *group;
> +       u32 pin, off;
>         int *pins;
>
>         func = pinmux_generic_get_function(pctldev, func_selector);
> @@ -217,12 +219,17 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>         psel_val = func->data;
>         pins = group->pins;
>
> -       for (i = 0; i < group->num_pins; i++) {
> -               dev_dbg(pctrl->dev, "port:%u pin: %u PSEL:%u\n",
> -                       RZG2L_PIN_ID_TO_PORT(pins[i]), RZG2L_PIN_ID_TO_PIN(pins[i]),
> -                       psel_val[i]);
> -               rzg2l_pinctrl_set_pfc_mode(pctrl, RZG2L_PIN_ID_TO_PORT(pins[i]),
> -                                          RZG2L_PIN_ID_TO_PIN(pins[i]), psel_val[i]);
> +       for (unsigned int i = 0; i < group->num_pins; i++) {
> +               pin_desc = &pctrl->desc.pins[pins[i]];
> +               pin_data = pin_desc->drv_data;
> +
> +               pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
> +               off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);

In my comments on v1, I actually meant to combine these assignments
to variables with the variable declarations.  I will handle that while applying.

> +
> +               dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
> +                       RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i]);
> +
> +               rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
>         }
>
>         return 0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
