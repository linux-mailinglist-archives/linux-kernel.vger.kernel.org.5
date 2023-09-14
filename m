Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6720A7A06A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjINN61 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbjINN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:58:24 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF411FD5;
        Thu, 14 Sep 2023 06:58:20 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d8162698f0dso1054130276.0;
        Thu, 14 Sep 2023 06:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699899; x=1695304699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89wnnpn5qWRvVKp5fLbV+KH4FRgXN/OCspIecwMYI/I=;
        b=jbmpWgb3dtD3ty4tskGVo7/WjuwqKJqVri3v42osYvuew8OkBloDf3Qr/dMA1kNeHb
         MKxrmL4wkzeeluRdc90m7Y/wt/6I7nnHJVY3L/TvlQPpcTqFg9Tsph+E86wEbCOctR3p
         +6nthQyLSJPRbVb+CsOvdWwgHcbBrGvDx3oWpuKUWVeHivnOJcfmgwbOUAbcte+U5ML5
         v4cDRl++O4XMN3IDycyC3dZJeozz7YjJ2NsqADrmHhshUFDO3jHpc533N9bTv76Vh2cj
         JJvijX9gnyO/U3L0eT40+VPP0p/83UsQP34u0WC2WuXt+DyRGuPahX+Y7xkYsbs+Rqbw
         rGEQ==
X-Gm-Message-State: AOJu0YzbHxbC0B+bEVGfR/1klciZjJBTcmJyIFVY9PdD/DTI4lEbtpSR
        cv/hVuE7wBc7l4iA3e4AzouBSVD8sIU2HA==
X-Google-Smtp-Source: AGHT+IFu83r7/LnH/QO9nc6pxfEozxawaMj+9NYuVcUrCUwHggHW4VZOMjiUH7ef9a5iNkdv+krHGw==
X-Received: by 2002:a25:603:0:b0:d62:b8f5:d745 with SMTP id 3-20020a250603000000b00d62b8f5d745mr4653761ybg.52.1694699899511;
        Thu, 14 Sep 2023 06:58:19 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id v20-20020a25ab94000000b00d7360e0b240sm343654ybi.31.2023.09.14.06.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:58:18 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d7f0048b042so1036218276.2;
        Thu, 14 Sep 2023 06:58:18 -0700 (PDT)
X-Received: by 2002:a25:ff0a:0:b0:d36:58a6:3281 with SMTP id
 c10-20020a25ff0a000000b00d3658a63281mr4967250ybe.39.1694699897744; Thu, 14
 Sep 2023 06:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-16-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-16-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 15:58:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5S6noFjkdYeyQjVSfa4oM780e0mMCAiScDoBjF=Rpqw@mail.gmail.com>
Message-ID: <CAMuHMdU5S6noFjkdYeyQjVSfa4oM780e0mMCAiScDoBjF=Rpqw@mail.gmail.com>
Subject: Re: [PATCH 15/37] clk: renesas: rzg2l: add support for RZ/G3S PLL
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
> Add support for reading the frequency of PLL1/4/6 available on RZ/G3S.
> The computation formula for PLL frequency is as follows:
> Fout = (nir + nfr / 4096) * Fin / (mr * pr)
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -718,11 +718,43 @@ static const struct clk_ops rzg2l_cpg_pll_ops = {
>         .recalc_rate = rzg2l_cpg_pll_clk_recalc_rate,
>  };
>
> +static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
> +                                                  unsigned long parent_rate)
> +{
> +       struct pll_clk *pll_clk = to_pll(hw);
> +       struct rzg2l_cpg_priv *priv = pll_clk->priv;
> +       u32 nir, nfr, mr, pr, val;
> +       u64 rate;
> +
> +       if (pll_clk->type != CLK_TYPE_G3S_SAM_PLL)
> +               return parent_rate;
> +
> +       val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
> +
> +       pr = 1 << FIELD_GET(GENMASK(28, 26), val);

Please add defines for the various GENMASK(...) fields.

> +       /* Hardware interprets values higher than 8 as p = 16. */
> +       if (pr > 8)
> +               pr = 16;
> +
> +       mr  = FIELD_GET(GENMASK(25, 22), val) + 1;
> +       nir = FIELD_GET(GENMASK(21, 13), val) + 1;
> +       nfr = FIELD_GET(GENMASK(12, 1), val);
> +
> +       rate = DIV_ROUND_CLOSEST_ULL((u64)parent_rate * nfr, 4096);
> +       rate += (u64)parent_rate * nir;

When rewriting the formula as:

    Fout = (4096 * nir + nfr) * Fin / (4096 * mr * pr)

you can simplify to:

    rate = mul_u64_u32_shr(parent_rate, 4096 * nir + nfr, 12);

> +       return DIV_ROUND_CLOSEST_ULL(rate, (mr + pr));

mr * pr

> +}

> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -102,6 +102,7 @@ enum clk_types {
>         CLK_TYPE_IN,            /* External Clock Input */
>         CLK_TYPE_FF,            /* Fixed Factor Clock */
>         CLK_TYPE_SAM_PLL,
> +       CLK_TYPE_G3S_SAM_PLL,

CLK_TYPE_G3S_PLL, as the documentation doesn't use SAM?

>
>         /* Clock with divider */
>         CLK_TYPE_DIV,
> @@ -129,6 +130,8 @@ enum clk_types {
>         DEF_TYPE(_name, _id, _type, .parent = _parent)
>  #define DEF_SAMPLL(_name, _id, _parent, _conf) \
>         DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
> +#define DEF_G3S_SAMPLL(_name, _id, _parent, _conf) \

DEF_G3S_PLL

> +       DEF_TYPE(_name, _id, CLK_TYPE_G3S_SAM_PLL, .parent = _parent, .conf = _conf)
>  #define DEF_INPUT(_name, _id) \
>         DEF_TYPE(_name, _id, CLK_TYPE_IN)
>  #define DEF_FIXED(_name, _id, _parent, _mult, _div) \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
