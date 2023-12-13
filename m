Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3C8112C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjLMN0Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 08:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjLMN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:26:23 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848391;
        Wed, 13 Dec 2023 05:26:29 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e263e43ff2so12275317b3.0;
        Wed, 13 Dec 2023 05:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473988; x=1703078788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/dW7y/88rRyjaO7r00R6o21E2y2IyUgTVUEboam7dg=;
        b=Oz+yXYJpq+Oct7FrkI1dqm8rpVBHqo2R5SHLaG6h5EcjNQHCdNMHay8Q8EKkw6wB7c
         tTq46YkMbHxT8AJiBIFuriCIysg403prfas+oCNFJQiYgOpZTj3tpOlfm7cjko2pPebU
         +b9+kC4xJu2thZPy8lQGb37eVcS1h9DcKHDj7tq0DldInrUzBH1vxgLvrrmDMB6ZStBq
         7wjcEB09iiIBATMaoOPCnBL7of9PVe3ieHGxSDsxlzRGq0xQ7dy9vowALELBukDivO2V
         B8PQWroNhq6H8Un+pPhkHol8XrcnRf+zJEKtZaNfuM3q4V3UjQtvtrazJirzkEWkyYzc
         shGQ==
X-Gm-Message-State: AOJu0YyksD0PKXPM92NAJatNFvU6YrKtsSLFDqVdmAtEPZgIA8Wzv5bG
        je4K5S2JU2pyD7o2xJt0qYVuexnX64qApg==
X-Google-Smtp-Source: AGHT+IGxXAV5YJNHjGtnfjrTF6PsWA95v4gJZvwnyes1B2rIui/NwQOTqCwPeq3xFEYM+5W4Z7whrw==
X-Received: by 2002:a81:df06:0:b0:5d7:1940:53c2 with SMTP id c6-20020a81df06000000b005d7194053c2mr6746365ywn.58.1702473988427;
        Wed, 13 Dec 2023 05:26:28 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id u11-20020a0deb0b000000b005af5bb5e840sm4666932ywe.34.2023.12.13.05.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:26:28 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-da819902678so6335862276.1;
        Wed, 13 Dec 2023 05:26:28 -0800 (PST)
X-Received: by 2002:a25:e655:0:b0:dbc:bbff:68fe with SMTP id
 d82-20020a25e655000000b00dbcbbff68femr1786964ybh.76.1702473988098; Wed, 13
 Dec 2023 05:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com> <20231207070700.4156557-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-2-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 14:26:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWfh7U6WqAgO85bLwZDKWpMgmviNdNfKRYtcxs4VEXsgQ@mail.gmail.com>
Message-ID: <CAMuHMdWfh7U6WqAgO85bLwZDKWpMgmviNdNfKRYtcxs4VEXsgQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] clk: renesas: rzg2l-cpg: Check reset monitor registers
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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

Hi Claudiu,

On Thu, Dec 7, 2023 at 8:08 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The hardware manual of both RZ/G2L and RZ/G3S specifies that the reset
> monitor registers need to be interrogated when the reset signals are
> toggled (chapters "Procedures for Supplying and Stopping Reset Signals"
> and "Procedure for Activating Modules"). Without this, there is a chance
> that different modules (e.g., Ethernet) to not be ready after their reset
> signal is toggled, leading to failures (on probe or resume from deep sleep
> states).
>
> The same indications are available for RZ/V2M for TYPE-B reset controls.
>
> Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
> Fixes: 8090bea32484 ("clk: renesas: rzg2l: Add support for RZ/V2M reset monitor reg")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - adapted for CPG versions with monbit (e.g., RZ/V2M)
> - added a fixes tag for RZ/V2M
> - fixed typos in commit description

Thanks for the update!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1416,12 +1416,27 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
>         struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
>         const struct rzg2l_cpg_info *info = priv->info;
>         unsigned int reg = info->resets[id].off;
> -       u32 value = BIT(info->resets[id].bit) << 16;
> +       u32 mask = BIT(info->resets[id].bit);
> +       s8 monbit = info->resets[id].monbit;
> +       u32 value = mask << 16;
>
>         dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
>
>         writel(value, priv->base + CLK_RST_R(reg));
> -       return 0;
> +
> +       if (info->has_clk_mon_regs) {
> +               reg = CLK_MRST_R(reg);
> +       } else if (monbit >= 0) {
> +               reg = CPG_RST_MON;
> +               mask = BIT(monbit);
> +       } else {
> +               /* Wait for at least one cyc le of the RCLK clock (@ ca. 32 kHz) */

cycle

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.8 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
