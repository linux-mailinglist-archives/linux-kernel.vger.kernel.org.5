Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618E67A17FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjIOIGs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 04:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjIOIGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:06:47 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD9B1BC9;
        Fri, 15 Sep 2023 01:06:42 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59be6605e1dso21129647b3.3;
        Fri, 15 Sep 2023 01:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694765201; x=1695370001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDdF9uQczjRdjh5DltQ3Kf3WBzjSgTe8Pnr+O7KM1YE=;
        b=wQByhZ9yaQmqn90fcbDfgmU6H9PY1niAWJb4O7fZLw3dawmdBvV04ULbvSPkyrofrI
         8zGdLBFTyEj7GMp7uygIV87S2/wdjfGFk5wlQNf85RSL7YXtMJGxJKTP/QmpMyAdu8ER
         ma8AC0JoQS6iwqFAp44pLo19wdDkc7CMbuSUCQPGQvoxC9ywSM4QnxD/RMEft0R+oD1i
         K+VRQ+Pgk5UOgTUbAlQgqqeik4kHqAtWX2YSfFxWutmPzDKrBcT4cb9k6aBew6WQN7ee
         M8HTfS2BEJEm+uyDajR4bC7v6LDjWD0GAUg2J7E5QSQd13TDKErj/l/zipO+E4q4bYaL
         wJAw==
X-Gm-Message-State: AOJu0YxpBLTueQgNQnCIb/H28w5K7gRqw8bZ5vbKGDgptolLvmgzUsoK
        K7lyTUzfPL9RLnlGf4ANf/89BMN3WHUTVQ==
X-Google-Smtp-Source: AGHT+IHfyHf84k81DafigIWjZ9cGVm1JY4apXsJzccQ9orBMQ+oG5wy+32Au3wIOh231/9ddGKBwnA==
X-Received: by 2002:a0d:ebc6:0:b0:58f:a190:f6b with SMTP id u189-20020a0debc6000000b0058fa1900f6bmr1100118ywe.26.1694765201151;
        Fri, 15 Sep 2023 01:06:41 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id p125-20020a0de683000000b0059b50f126fbsm747987ywe.114.2023.09.15.01.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 01:06:40 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d81b803b09aso831568276.2;
        Fri, 15 Sep 2023 01:06:40 -0700 (PDT)
X-Received: by 2002:a25:e64d:0:b0:d80:1161:5ec1 with SMTP id
 d74-20020a25e64d000000b00d8011615ec1mr867800ybh.20.1694765200505; Fri, 15 Sep
 2023 01:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-19-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdX9PYdESi6OAFSUS1NsFs9oPPV7Cd+uMHTtFRhkaq3Xzw@mail.gmail.com> <1ef2d7d4-93d4-969d-6618-3b81926418d5@tuxon.dev>
In-Reply-To: <1ef2d7d4-93d4-969d-6618-3b81926418d5@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 10:06:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvuP1M2vu9+Kptj-5AkxbtPVeymm5r_02JQbyXdA7F=g@mail.gmail.com>
Message-ID: <CAMuHMdWvuP1M2vu9+Kptj-5AkxbtPVeymm5r_02JQbyXdA7F=g@mail.gmail.com>
Subject: Re: [PATCH 18/37] clk: renesas: rzg2l: refactor sd mux driver
To:     claudiu beznea <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Fri, Sep 15, 2023 at 9:30 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 14.09.2023 18:18, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Refactor SD MUX driver to be able to reuse the same code on RZ/G3S.
> >> RZ/G2{L, UL} has a limitation with regards to switching the clock source
> >> for SD MUX (MUX clock source has to be switched to 266MHz before switching
> >> b/w 533MHz and 400MHz). This limitation has been introduced as a clock
> >> notifier that is registered on platform based initialization data thus the
> >> SD MUX code could be reused on RZ/G3S.
> >>
> >> As both RZ/G2{L, UL} and RZ/G3S has specific bits in specific registers
> >> to check if the clock switching has been done, this configuration (register
> >> offset, register bits and bits width) is now passed though
> >> struct cpg_core_clk::sconf (status configuration) from platform specific
> >> initialization code.
> >>
> >> Along with struct cpg_core_clk::sconf the mux table indexes is also
> >
> > indices are
> >
> >> passed from platform specific initialization code.
> >
> > Please also mention the passing of the mux flags, which is added so
> > you can pass CLK_SET_PARENT_GATE for G3S_SEL_PLL4 later.
>
> Ok.
>
> >
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> >> --- a/drivers/clk/renesas/r9a07g043-cpg.c
> >> +++ b/drivers/clk/renesas/r9a07g043-cpg.c
> >> @@ -21,6 +21,10 @@
> >>  #define G2UL_SEL_SDHI0         SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 0, 2)
> >>  #define G2UL_SEL_SDHI1         SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 4, 2)
> >>
> >> +/* Clock status configuration. */
> >> +#define G2UL_SEL_SDHI0_STS     SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
> >> +#define G2UL_SEL_SDHI1_STS     SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
> >
> > Just like in [PATCH 17/37], there is no real need for the "G2UL_"-prefix.
>
> Ok, I ususlly tend to guard everything with a proper namespace.

Sure, in many cases, that makes good sense.
In this case, not having the prefix makes it easier to compare clock tables:

    soc-dts-diff -b drivers/clk/renesas/r9a07g04[34]-cpg.c

(soc-dts-diff ignores the SoC part number, and can be found at
 https://github.com/geertu/linux-scripts)

> >> +int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event,
> >> +                                 void *data)
> >> +{
> >> +       struct clk_notifier_data *cnd = data;
> >> +       struct clk_hw *hw = __clk_get_hw(cnd->clk);
> >> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
> >> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
> >> +       u32 off = GET_REG_OFFSET(clk_hw_data->conf);
> >> +       u32 shift = GET_SHIFT(clk_hw_data->conf);
> >> +       const u32 clk_src_266 = 3;
> >> +       unsigned long flags;
> >> +       u32 bitmask;
> >> +       int ret;
> >> +
> >> +       if (event != PRE_RATE_CHANGE || (cnd->new_rate / MEGA == 266))
> >> +               return 0;
> >> +
> >> +       spin_lock_irqsave(&priv->rmw_lock, flags);
> >> +
> >> +       /*
> >> +        * As per the HW manual, we should not directly switch from 533 MHz to
> >> +        * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
> >> +        * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
> >> +        * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
> >> +        * (400 MHz)).
> >> +        * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
> >> +        * switching register is prohibited.
> >> +        * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
> >> +        * the index to value mapping is done by adding 1 to the index.
> >> +        */
> >> +       bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
> >> +       writel(bitmask | (clk_src_266 << shift), priv->base + off);
> >> +
> >> +       /* Wait for the update done. */
> >> +       ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
> >> +
> >> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
> >> +
> >> +       if (ret)
> >> +               dev_err(priv->dev, "failed to switch to safe clk source\n");
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
> >> +                                  struct rzg2l_cpg_priv *priv)
> >> +{
> >> +       struct notifier_block *nb;
> >> +
> >> +       if (!core->notifier)
> >> +               return 0;
> >> +
> >> +       nb = devm_kzalloc(priv->dev, sizeof(*nb), GFP_KERNEL);
> >> +       if (!nb)
> >> +               return -ENOMEM;
> >> +
> >> +       nb->notifier_call = core->notifier;
> >> +
> >> +       return clk_notifier_register(hw->clk, nb);
> >> +}
> >
> > I am not sure a notifier is the best solution.  Basically on RZ/G2L,
> > when changing the parent clock, you need to switch to a fixed
> > intermediate parent first.
> > What about just replacing the fixed clk_src_266 in the old
> > rzg2l_cpg_sd_mux_clk_set_parent() by a (signed) integer in
> > sd_mux_hw_data (specified in DEF_SD_MUX()), representing the index
> > of the intermediate clock?
> > -1 would mean an intermediate parent is not needed.
>
> That should work too but .set_rate() will be bulky for both mux and div.
>
> The idea was to have the .set_rate() common to the mux and the platform
> specificities implemented as notifiers and only the needed platforms to
> instantiate the notifier. And the same approach to be used by the divider
> (patch "[PATCH 19/37] clk: renesas: rzg2l: add a divider clock for RZ/G3S")
>
> With this it looked to me that the final code is more compact .set_rate
> being simple and platform specificities being implemented in notifier
> (valid for both MUX and DIV). The infrastructure is already there for
> notifier to be called before .set_rate().

TBH, I am not that familiar with clock notifiers, so I could use some
guidance from the clock maintainers.

Mike/Stephen: Are clock notifiers the right approach, here and in
              [PATCH 19.37]?

> >> --- a/drivers/clk/renesas/rzg2l-cpg.h
> >> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> >> @@ -272,4 +278,9 @@ extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
> >>  extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
> >>  extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
> >>
> >> +int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
> >> +
> >> +/* Macros to be used in platform specific initialization code. */
> >> +#define SD_MUX_NOTIF           (&rzg2l_cpg_sd_mux_clk_notifier)
> >
> > Any specific reason you are adding this macro?
>
> It looked to me like a better name to be used in platform specific drivers.
>
> > What is wrong with using &rzg2l_cpg_sd_mux_clk_notifier directly?
>
> Nothing, just that it is a longer than SD_MUX_NOTIF.

It adds another level of indirection for the casual reviewer, and needs
replacement when an SoC arrives that needs a different SD mux notifier.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
