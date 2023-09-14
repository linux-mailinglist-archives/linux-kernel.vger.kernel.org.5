Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0F77A02E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjINLm0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 07:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjINLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:42:23 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40446CC3;
        Thu, 14 Sep 2023 04:42:19 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59b9d255037so9680767b3.2;
        Thu, 14 Sep 2023 04:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691738; x=1695296538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQF6azidQAjPWw/iF7OTkfye/Uwv7/91WnosuLGo4H0=;
        b=KRnazo4b3oK3Ks80sZ9YwBqZ6xe5m9l7EplvvSZ7n533Jj0sGVsmxvb7E1Ubha9X49
         3pvqgFAc0LQVRM5+uXjVO5J6hrkVd9Sltk4bM/lvxXfRURlGvW0/xhpsvu7f02kyzogs
         If6oNpnHXlTaIQH99wRBrWT3j2hM8kA8SHG5+vyzLz03uxQlqxBlNRoi1xtAQlECi45K
         10mUks1PSym7GeZ5M1iHso4qGqezTGe78jsCRkdp7SQkUiij6Rghsaf3Zq07BDQoUCns
         PCdL1+gyRApk2rOaTVBg2CzIg8jGnIWDHLxVX+U3hSS7fh7dOG27D9O5WQe2YD9czxrx
         UoaA==
X-Gm-Message-State: AOJu0YxbPVJxeSkMv5ONQ3fTr4ZrWIKhzJrOkG3s+RryLnMCmHQag6cg
        RkjZtdBGRhsaznrTFKa57v0SPj8cCFYQ1g==
X-Google-Smtp-Source: AGHT+IF0Sgpy0A5vUjYzeH274xmHzh4WNbwSDJ0nsHb0aJrnlaQDcsZtmGN7NOioeDgdpMgpB5N8vQ==
X-Received: by 2002:a81:49ca:0:b0:59b:e622:f820 with SMTP id w193-20020a8149ca000000b0059be622f820mr2817520ywa.13.1694691738247;
        Thu, 14 Sep 2023 04:42:18 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id z5-20020a81a245000000b005832fe29034sm269217ywg.89.2023.09.14.04.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 04:42:17 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d776e1f181bso855446276.3;
        Thu, 14 Sep 2023 04:42:17 -0700 (PDT)
X-Received: by 2002:a25:8683:0:b0:d7b:8d9a:4ec5 with SMTP id
 z3-20020a258683000000b00d7b8d9a4ec5mr4800309ybk.41.1694691737069; Thu, 14 Sep
 2023 04:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-7-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 13:42:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXoq96ptmm+oU_yHdkSfN4+WCfABn98tXV5xfyvM66Eig@mail.gmail.com>
Message-ID: <CAMuHMdXoq96ptmm+oU_yHdkSfN4+WCfABn98tXV5xfyvM66Eig@mail.gmail.com>
Subject: Re: [PATCH 06/37] clk: renesas: rzg2l: wait for status bit of SD mux
 before continuing
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hardware user manual of RZ/G2L (r01uh0914ej0130-rzg2l-rzg2lc.pdf,
> chapter 7.4.7 Procedure for Switching Clocks by the Dynamic Switching
> Frequency Selectors) specifies that we need to check CPG_PL2SDHI_DSEL for
> SD clock switching status.
>
> Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -188,7 +188,8 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>         u32 off = GET_REG_OFFSET(hwdata->conf);
>         u32 shift = GET_SHIFT(hwdata->conf);
>         const u32 clk_src_266 = 2;
> -       u32 bitmask;
> +       u32 msk, val, bitmask;
> +       int ret;
>
>         /*
>          * As per the HW manual, we should not directly switch from 533 MHz to
> @@ -203,9 +204,6 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>          */
>         bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
>         if (index != clk_src_266) {
> -               u32 msk, val;
> -               int ret;
> -
>                 writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
>
>                 msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
> @@ -221,7 +219,13 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
>
>         writel(bitmask | ((index + 1) << shift), priv->base + off);
>
> -       return 0;
> +       ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
> +                                !(val & msk), 100,

"msk" may be uninitialized.

> +                                CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
> +       if (ret)
> +               dev_err(priv->dev, "failed to switch clk source\n");
> +
> +       return ret;

This is now (supposed to be) doing the same thing twice, once using
clk_src_266, and then again with the wanted index, so why not introduce
a small helper? That would have avoided the uninitialized variable, too.

I know you're rewriting this code in "[PATCH 18/37] clk: renesas:
rzg2l: refactor sd mux driver", but even after that, you always do
a register write before calling rzg2l_cpg_wait_clk_update_done(),
so it may still be a net win.

>  }
>
>  static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
