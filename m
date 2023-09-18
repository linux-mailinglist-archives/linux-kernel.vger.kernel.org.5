Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505617A49B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjIRMcQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 08:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjIRMbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:31:48 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F610A;
        Mon, 18 Sep 2023 05:31:33 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59ea6064e2eso9094107b3.2;
        Mon, 18 Sep 2023 05:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040292; x=1695645092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vZn8aRnX4VoY8JPw/hEccA0SHUiwHYytafqLmP0x8Y=;
        b=uGKlfSsOZ5E/6IrbU731gb8N2qByBOwwtv/Rp97cMAQ8gtBODQ+DqGrDv/tzJeUGlU
         O+qBgwMP8/ATR3T5HoTMelhuH46+7f1Pg5NrtIBNECS0p2HsfcnmsNDxZY0DT7BHaQUC
         +CmMmA5xGn6CyMSbWpUaFce9rLW81au1ay8K5/CCD4H358qnjP7FjBoPDWFgSe5tayds
         TsDisjMbirDWJRBGP2zoZEEq4abhIG21jfDCTLCaa42kq1BAJQh/XbVWMF3vi/p7/CbF
         rRg+oUPeWIKZncxAfmDQ+uEq+HG7JQmNx9YXHXtrFqbJ9bjw4fGgZrNZ2RN65yxh5bFM
         QJ2Q==
X-Gm-Message-State: AOJu0YyLtV3d4YEkvL6hfZYCNgz8rmBBUGBA0/2tpuUbfbX9Q5QHjXAk
        LU3f9Y2g99qz2BwxjLNW1hSqFGOapdFs7w==
X-Google-Smtp-Source: AGHT+IEgR0OTI9eS2nf2T5bdFe7qhiwzIAhQ+FCENo34oC8vXiawJsuf0sN3hZB5NII4/tp8woGo2A==
X-Received: by 2002:a81:82c5:0:b0:59b:ec85:54ee with SMTP id s188-20020a8182c5000000b0059bec8554eemr9949066ywf.39.1695040292376;
        Mon, 18 Sep 2023 05:31:32 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id u11-20020a0deb0b000000b0059ae483b89dsm2543221ywe.50.2023.09.18.05.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:31:32 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59bcd927b45so46807497b3.1;
        Mon, 18 Sep 2023 05:31:32 -0700 (PDT)
X-Received: by 2002:a81:8351:0:b0:586:b686:8234 with SMTP id
 t78-20020a818351000000b00586b6868234mr10283333ywf.8.1695040291964; Mon, 18
 Sep 2023 05:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131638.443055-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230911131638.443055-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 14:31:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcuMGTwNaTY8v-hcbov22zTU268meU28J7+FrWiPioxw@mail.gmail.com>
Message-ID: <CAMuHMdVcuMGTwNaTY8v-hcbov22zTU268meU28J7+FrWiPioxw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: pinctrl-rzg2l: Add validation of
 GPIO pin in rzg2l_gpio_request()
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Mon, Sep 11, 2023 at 3:17 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Validate the GPIO pin request in rzg2l_gpio_request() callback using
> rzg2l_validate_gpio_pin() function. This stops any accidental usage
> of GPIO pins which are not supported by the SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> v1->v2
> * Maintained reverse christmas tree order.
> * Included RB/TB tags from Claudiu.

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -795,12 +795,18 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
>  static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
>  {
>         struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
> +       const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[offset];
>         u32 port = RZG2L_PIN_ID_TO_PORT(offset);
>         u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
> +       u64 *pin_data = pin->drv_data;

isn't drv_data a pointer to unsigned int aka u32?

>         unsigned long flags;
>         u8 reg8;
>         int ret;
>
> +       ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
> +       if (ret)
> +               return ret;
> +
>         ret = pinctrl_gpio_request(chip->base + offset);
>         if (ret)
>                 return ret;

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
