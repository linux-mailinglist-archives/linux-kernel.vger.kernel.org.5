Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFF7F6444
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbjKWQmt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 11:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjKWQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:42:45 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544F10CE;
        Thu, 23 Nov 2023 08:42:52 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b709048d8eso985955b3a.2;
        Thu, 23 Nov 2023 08:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757771; x=1701362571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQRJZMvnwWQRNg5FA4wJF1eV8mAIW4nnY5zQ1fqyCUs=;
        b=NDcRg95+uMdoQrLY/5btIpUo8GIE6foDhYOa8VUV8As40d/5PcPet0Gkkxz88wbDgL
         LPbB7oo13bfGP6+f8wA69g1VwB1aOcdxIug/AeBX8qwVgekcrYi0Aqq1GY7UlqPzoGCO
         ptoaCK3VmmpfSpbQ5Ug9est7SIR8LUgpGQ82kurqitRdv1ab5FrFw/xj4DOWdZ/lk6+2
         /sQRpYIDA67jYSZWWeqSnpxPq2MrFOZr9LAn23aL+W4+yxwX01s8z95zDc30anjvy0c2
         JWPKXdLcyTxTXqyBbzVeant4xDuOW5lnRntnhQSxMrnbi5AVbEEb0pQ5rtcgClG21LpP
         FIoA==
X-Gm-Message-State: AOJu0Yx4nDknSk8bHY66fDFsR7VEoQ8WUrcEu1lIP9snapGp7OwL8h2H
        U0jgOO5EFHmZ/dnxsG4IXi/LwbKxM/4Q6A==
X-Google-Smtp-Source: AGHT+IHvjDEs4oY10So/aGY63Ft08Vfqw+g9/8T045qlJ14hyCXXOCosSgJM72MukvO4QoxOAAhUpw==
X-Received: by 2002:a05:6a20:7f98:b0:188:290d:17dc with SMTP id d24-20020a056a207f9800b00188290d17dcmr170158pzj.60.1700757771167;
        Thu, 23 Nov 2023 08:42:51 -0800 (PST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com. [209.85.210.170])
        by smtp.gmail.com with ESMTPSA id t43-20020aa78fab000000b006c9c0705b5csm1419206pfs.48.2023.11.23.08.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 08:42:50 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6b709048d8eso985941b3a.2;
        Thu, 23 Nov 2023 08:42:50 -0800 (PST)
X-Received: by 2002:a25:5f4b:0:b0:d9b:417:139c with SMTP id
 h11-20020a255f4b000000b00d9b0417139cmr5509937ybm.60.1700757346993; Thu, 23
 Nov 2023 08:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com> <20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Nov 2023 17:35:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVMpKVY8WX7dbtHfgnwgePH+i9+2BAumb37sFmqccb44g@mail.gmail.com>
Message-ID: <CAMuHMdVMpKVY8WX7dbtHfgnwgePH+i9+2BAumb37sFmqccb44g@mail.gmail.com>
Subject: Re: [PATCH 03/14] clk: renesas: rzg2l-cpg: Add support for MSTOP
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/{G2L, V2L, G3S} based CPG versions have support for saving extra
> power when clocks are disabled by activating module standby. This is done
> though MSTOP specific registers that are part of CPG. Each individual
> module have one or more bits associated in one MSTOP register (see table
> "Registers for Module Standby Mode" from HW manuals). Hardware manual
> associates modules' clocks to one or more MSTOP bits. There are 3 mappings
> available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW manuals):
>
> case 1: N clocks mapped to N MSTOP bits (with N={0, ..., X})
> case 2: N clocks mapped to 1 MSTOP bit  (with N={0, ..., X})
> case 3: N clocks mapped to M MSTOP bits (with N={0, ..., X}, M={0, ..., Y})
>
> Case 3 has been currently identified on RZ/V2L for VCPL4 module.
>
> To cover all 3 cases the individual platform drivers will provide to
> clock driver MSTOP register offset and associated bits in this register
> as a bitmask and the clock driver will apply this bitmask to proper
> MSTOP register.
>
> As most of the modules have more than one clock and these clocks are
> mapped to 1 MSTOP bitmap that need to be applied to MSTOP registers,
> to avoid switching the module to/out of standby when the module has
> enabled/disabled clocks a counter has been associated to each module
> (though struct mstop::count) which is incremented/decremented every
> time a module's clock is enabled/disabled and the settings to MSTOP
> register are applied only when the counter reaches zero (counter zero
> means either 1st clock of the module is going to be enabled or all clocks
> of the module are going to be disabled).

Thanks for your patch!

> The MSTOP functionality has been instantiated at the moment for RZ/G3S.

Do you plan to add support for the other SoCs, too?

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- a/drivers/clk/renesas/r9a08g045-cpg.c
> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> @@ -187,23 +187,39 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
>  };
>
>  static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
> -       DEF_MOD("gic_gicclk",           R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0),
> -       DEF_MOD("ia55_clk",             R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
> -       DEF_MOD("dmac_aclk",            R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
> -       DEF_MOD("sdhi0_imclk",          R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
> -       DEF_MOD("sdhi0_imclk2",         R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1),
> -       DEF_MOD("sdhi0_clk_hs",         R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2),
> -       DEF_MOD("sdhi0_aclk",           R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3),
> -       DEF_MOD("sdhi1_imclk",          R9A08G045_SDHI1_IMCLK, CLK_SD1_DIV4, 0x554, 4),
> -       DEF_MOD("sdhi1_imclk2",         R9A08G045_SDHI1_IMCLK2, CLK_SD1_DIV4, 0x554, 5),
> -       DEF_MOD("sdhi1_clk_hs",         R9A08G045_SDHI1_CLK_HS, R9A08G045_CLK_SD1, 0x554, 6),
> -       DEF_MOD("sdhi1_aclk",           R9A08G045_SDHI1_ACLK, R9A08G045_CLK_P1, 0x554, 7),
> -       DEF_MOD("sdhi2_imclk",          R9A08G045_SDHI2_IMCLK, CLK_SD2_DIV4, 0x554, 8),
> -       DEF_MOD("sdhi2_imclk2",         R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
> -       DEF_MOD("sdhi2_clk_hs",         R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
> -       DEF_MOD("sdhi2_aclk",           R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
> -       DEF_MOD("scif0_clk_pck",        R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
> -       DEF_MOD("gpio_hclk",            R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
> +       DEF_MOD("gic_gicclk",           R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0,
> +                                       MSTOP(ACPU, BIT(3))),

According to Rev. 1.00 of the Hardware User's Manual, bit 3 of the
CPG_BUS_ACPU_MSTOP register is reserved?

Also, gic_gicclk is a critical module clock, so I guess this module
must never be put into standby?

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1177,6 +1177,17 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
>                 core->name, PTR_ERR(clk));
>  }
>
> +/**
> + * struct mstop - MSTOP specific data structure
> + * @count: reference counter for MSTOP settings (when zero the settings
> + *        are applied to register)
> + * @conf: MSTOP configuration (register offset, setup bits)
> + */
> +struct mstop {
> +       u32 count;
> +       u32 conf;
> +};
> +
>  /**
>   * struct mstp_clock - MSTP gating clock
>   *
> @@ -1186,6 +1197,7 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
>   * @enabled: soft state of the clock, if it is coupled with another clock
>   * @priv: CPG/MSTP private data
>   * @sibling: pointer to the other coupled clock
> + * @mstop: MSTOP configuration
>   */
>  struct mstp_clock {
>         struct clk_hw hw;
> @@ -1194,10 +1206,46 @@ struct mstp_clock {
>         bool enabled;
>         struct rzg2l_cpg_priv *priv;
>         struct mstp_clock *sibling;
> +       struct mstop *mstop;
>  };
>
>  #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
>
> +/* Need to be called with a lock held to avoid concurent access to mstop->count. */

concurrent

> +static void rzg2l_mod_clock_module_set_standby(struct mstp_clock *clock,
> +                                              bool standby)
> +{
> +       struct rzg2l_cpg_priv *priv = clock->priv;
> +       struct mstop *mstop = clock->mstop;
> +       bool update = false;
> +       u32 value;
> +
> +       if (!mstop)
> +               return;
> +
> +       value = MSTOP_MASK(mstop->conf) << 16;
> +
> +       if (standby) {
> +               value |= MSTOP_MASK(mstop->conf);
> +               /* Avoid overflow. */
> +               if (mstop->count > 0)
> +                       mstop->count--;

Should we add a WARN() here, or is it sufficient to rely on the WARN()
in drivers/clk/clk.c:clk_core_disable()?

> +
> +               if (!mstop->count)
> +                       update = true;
> +       } else {
> +               if (!mstop->count)
> +                       update = true;
> +
> +               /* Avoid overflow. */
> +               if (mstop->count + 1 != 0)
> +                       mstop->count++;

Trying to avoid an overflow won't help much here.  The counter
will be wrong afterwards anyway, and when decrementing again later, the
module will be put in standby too soon...

> +       }
> +
> +       if (update)
> +               writel(value, priv->base + MSTOP_OFF(mstop->conf));
> +}
> +
>  static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
>  {
>         struct mstp_clock *clock = to_mod_clock(hw);

> @@ -1401,6 +1474,37 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
>                 }
>         }
>
> +       if (mod->mstop_conf) {
> +               struct mstop *mstop = rzg2l_mod_clock_get_mstop(priv, mod->mstop_conf);
> +
> +               if (mstop) {
> +                       clock->mstop = mstop;

Please move the common assignment after the if/else block...

> +               } else {

... so this can just become "if (!mstop) {".

> +                       mstop = devm_kzalloc(dev, sizeof(*mstop), GFP_KERNEL);
> +                       if (!mstop) {
> +                               clk_unregister(clk);
> +                               goto fail;

Please use "goto unregister", and call clk_unregister() after the new
unregister label.

> +                       }
> +
> +                       mstop->conf = mod->mstop_conf;
> +                       clock->mstop = mstop;
> +               }
> +
> +               if (rzg2l_mod_clock_is_enabled(&clock->hw)) {
> +                       if (clock->sibling)
> +                               clock->mstop->count = 1;
> +                       else
> +                               clock->mstop->count++;
> +               }
> +
> +               /*
> +                * Out of reset all modules are enabled. Set module to standby
> +                * in case associated clocks are disabled at probe.

Is that always true?
What about kexec and crashdump kernels?

> +                */
> +               if (!clock->mstop->count)
> +                       rzg2l_mod_clock_module_set_standby(clock, true);
> +       }
> +
>         return;
>
>  fail:
> diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
> index 6e38c8fc888c..10ee8aa4a5da 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h

> @@ -68,6 +73,10 @@
>  #define SEL_PLL6_2     SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
>  #define SEL_GPU2       SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
>
> +#define MSTOP(name, bitmask)   ((CPG_##name##_MSTOP) << 16 | (bitmask))

I believe the bitmask is always a single bit.
So perhaps let MSTOP() take the bit number instead of the bitmaskl?
You can still store BIT(bit) inside the macro.

> +#define MSTOP_OFF(conf)                ((conf) >> 16)
> +#define MSTOP_MASK(conf)       ((conf) & GENMASK(15, 0))
> +
>  #define EXTAL_FREQ_IN_MEGA_HZ  (24)
>
>  /**

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
