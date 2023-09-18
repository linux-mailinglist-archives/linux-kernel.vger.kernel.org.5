Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FD7A4A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbjIRM6E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbjIRM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:57:41 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1992E1;
        Mon, 18 Sep 2023 05:57:30 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59c26aa19b7so23336717b3.2;
        Mon, 18 Sep 2023 05:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041849; x=1695646649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghqR6VgUzzNB93DAOLoo6x8xK8PRt3XMnEVJ++79oKM=;
        b=pEAMqvrRRUvSC1a8+i6vfkP62/646epb/4fyck3j4YBpDm5eiCEqXjYHQwrv99lNUi
         ba3gL5XJXMKQoZ1Z1OgJDMhK3B2D8vqr8jG2H+Cn7ZhHVQxEKHcGrKxRjWmVdWiwQTaZ
         9+i6tyxuCGoAyV6GW+x1/BI45NhjAMZqrDQI7/ACMlYw+bS5ULMfLXm3/zfz8OsktEwc
         scXk6iJ50LHu/IAlEtHnNaY0kL92Qr/RAGq2ZOG1ueUydaG8CdQ9rhxKWPDGzLU8kvf3
         jYYJ+hhaB5gAFz6a27i3NZvmN4qfVpgwh6d4CgK4af4PAEVKcdppa06dol8Lub911ajI
         3D8Q==
X-Gm-Message-State: AOJu0YwGku8q1X5x5SyYjsk27sJmquer/gMDeaVyO1ghvsRslP8ROxDH
        kFzVtfm4WIYYiOMO9Z4+Mzr2JZZ33N4WwQ==
X-Google-Smtp-Source: AGHT+IGWb86K/BEOlq8aqxWvbffRw2d+gVhyFTfWu20xyhLDDOPbfk4HR9Co1wYaeGmcfKqdtwyekg==
X-Received: by 2002:a81:73d5:0:b0:59c:3f8:b0ab with SMTP id o204-20020a8173d5000000b0059c03f8b0abmr10515520ywc.41.1695041849513;
        Mon, 18 Sep 2023 05:57:29 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id p4-20020a0dff04000000b005837b48d16csm2548593ywf.84.2023.09.18.05.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:57:29 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59c0281d72dso35302897b3.0;
        Mon, 18 Sep 2023 05:57:29 -0700 (PDT)
X-Received: by 2002:a81:4e4f:0:b0:56c:f32d:1753 with SMTP id
 c76-20020a814e4f000000b0056cf32d1753mr9477356ywb.44.1695041849132; Mon, 18
 Sep 2023 05:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com> <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 14:57:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcy82eQNKtqufk8Nb6PKYTgmZw_b_mC+qgmGMHt1gyiw@mail.gmail.com>
Message-ID: <CAMuHMdVcy82eQNKtqufk8Nb6PKYTgmZw_b_mC+qgmGMHt1gyiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO
 interrupt input
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
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

Hi Biju,

On Mon, Sep 18, 2023 at 2:34 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> As per RZ/G2L hardware manual Rev.1.30 section 8.7.3 GPIO Interrupt (TINT)
> and 41.4.1 Operation for GPIO function, we need to set digital noise
> filter for GPIO interrupt.
>
> This patch enables noise filter for GPIO interrupt in
> rzg2l_gpio_irq_enable() and disable it in rzg2l_gpio_irq_disable().
>
> Fixes: db2e5f21a48e ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -96,6 +96,7 @@
>  #define PIN(n)                 (0x0800 + 0x10 + (n))
>  #define IOLH(n)                        (0x1000 + (n) * 8)
>  #define IEN(n)                 (0x1800 + (n) * 8)
> +#define FILONOFF(n)            (0x2080 + (n) * 8)
>  #define ISEL(n)                        (0x2c80 + (n) * 8)
>  #define PWPR                   (0x3014)
>  #define SD_CH(n)               (0x3000 + (n) * 4)

LGTM, but shouldn't you configure the Digital Noise Filter Number
(FILNUM) and Clock Selection (FILCLKSEL) registers, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
