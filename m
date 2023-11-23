Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C337F6359
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbjKWPx2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 10:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbjKWPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:53:26 -0500
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACAD41;
        Thu, 23 Nov 2023 07:53:32 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9beb865a40so918933276.1;
        Thu, 23 Nov 2023 07:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700754812; x=1701359612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4a8muWVJERlW0eLxhsAPKkg7UICmbIYUzNpVBBHRwc=;
        b=XYfzrHsa0W0DAj70+yfUOMJO6hqVmc58/a2AkSqPqbQBqFb1PLGGeclV4YYb75+vvl
         ugN26NOFhUlNivOGlewDIcFh1RgwLq/iVwHvI4M9AcDUDdM2lYekfvc+nNcto4TzxIus
         XLM/mQXnzfVzVmWpd9AoCXKiLAbCN8iCg6ZE2SpDU+6r6kyCrEIZYmd80T64KFl8i8Qu
         JkE8i+zGErTamwLSjGhWbmE07csu53DSiHxrk3V15cbudipccVs1MOSKChqJzLYvuWhx
         YvcEJ0+FGiZL+q98yPEXwcLr3REvC0FDRWJCMxiWOfUY0OLfmDLyVTtlPBWF6Y2rAA45
         Uaag==
X-Gm-Message-State: AOJu0YwIh1Td87oWrLXWPHalpbss6hGFs6WNjKkLmbHE/ARmTioJ4TXb
        ey2SGFyuPRiWhXEH1MUTM/PYn7mCh0AAwg==
X-Google-Smtp-Source: AGHT+IESv+mekVU042XyNpJBoa7y814zndA1PZSmoRYZqLTLb8YwWyEgu3HqeKRyd5ijcLw1Tsb/kQ==
X-Received: by 2002:a25:c094:0:b0:d9c:7d48:3020 with SMTP id c142-20020a25c094000000b00d9c7d483020mr5514911ybf.20.1700754811733;
        Thu, 23 Nov 2023 07:53:31 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 123-20020a250b81000000b00db3fca90d6esm378661ybl.2.2023.11.23.07.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:53:31 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5cc5988f85eso10390567b3.2;
        Thu, 23 Nov 2023 07:53:30 -0800 (PST)
X-Received: by 2002:a0d:fe43:0:b0:5cb:95e8:16ba with SMTP id
 o64-20020a0dfe43000000b005cb95e816bamr6373455ywf.46.1700754810638; Thu, 23
 Nov 2023 07:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com> <20231120070024.4079344-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-3-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Nov 2023 16:53:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXTO+cteN7fW+n3=Vzpa5Nk7oxj+sF2vBMLf2gwS=aNGw@mail.gmail.com>
Message-ID: <CAMuHMdXTO+cteN7fW+n3=Vzpa5Nk7oxj+sF2vBMLf2gwS=aNGw@mail.gmail.com>
Subject: Re: [PATCH 02/14] clk: renesas: rzg2l-cpg: Check reset monitor registers
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, geert+renesas@glider.be,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hardware manual of both RZ/G2L and RZ/G3S specifies that reset monitor
> registers need to be interrogated when the reset signals are toggled
> (chapters "Procedures for Supplying and Stopping Reset Signals" and
> "Procedure for Activating Modules"). Without this there is a chance that
> different modules (e.g. Ethernet) to not be ready after reset signal is
> toggled leading to failures (on probe or resume from deep sleep states).
>
> Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> In case you apply this patch and patch 1/13 as is, please add a Depend-on
> tag on this patch to point to patch 1/13 for proper backporting.

There is no such Depend-on tag? Anyway, this patch won't apply if 1/13
is not backported...

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1416,12 +1416,23 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
>         struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
>         const struct rzg2l_cpg_info *info = priv->info;
>         unsigned int reg = info->resets[id].off;
> -       u32 value = BIT(info->resets[id].bit) << 16;
> +       u32 dis = BIT(info->resets[id].bit);
> +       u32 value = dis << 16;
> +       int ret = 0;
>
>         dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
>
>         writel(value, priv->base + CLK_RST_R(reg));
> -       return 0;
> +
> +       if (info->has_clk_mon_regs) {
> +               ret = readl_poll_timeout_atomic(priv->base + CLK_MRST_R(reg), value,
> +                                               value & dis, 10, 200);
> +       } else {
> +               /* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
> +               udelay(35);
> +       }

I think this should also take into account CPG_RST_MON on RZ/V2M,
cfr. rzg2l_cpg_status().

> +
> +       return ret;
>  }
>
>  static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
> @@ -1432,12 +1443,22 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
>         unsigned int reg = info->resets[id].off;
>         u32 dis = BIT(info->resets[id].bit);
>         u32 value = (dis << 16) | dis;
> +       int ret = 0;
>
>         dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
>                 CLK_RST_R(reg));
>
>         writel(value, priv->base + CLK_RST_R(reg));
> -       return 0;
> +
> +       if (info->has_clk_mon_regs) {
> +               ret = readl_poll_timeout_atomic(priv->base + CLK_MRST_R(reg), value,
> +                                               !(value & dis), 10, 200);
> +       } else {
> +               /* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
> +               udelay(35);
> +       }

Likewise.

> +
> +       return ret;
>  }
>
>  static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
