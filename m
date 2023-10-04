Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE27B7E35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbjJDLbO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbjJDLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:31:12 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59809A7;
        Wed,  4 Oct 2023 04:31:08 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1dd1db54d42so1319762fac.3;
        Wed, 04 Oct 2023 04:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696419067; x=1697023867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm6sz8FblgWT0YVLOcQ3cK2z8WT9exIQjwp4AMuRqJQ=;
        b=FIvDkeol9jRBgalEZ6+OnqMqfJ+PNpgzlPg/zN7Fyk7JBZviSEsrhOMy7gq4u9+e+K
         4ytDSPBTfFkiOVPt5cJegsd4jMiY4tFAzHNQReyAoA4X+zssNz+nS0OjdcP3MZPSX8n+
         MVSlOrFlzCb0XiHF2zMwBhj02GY0T8fFHiyvO3gZrJwl/h6Psug1TlG2ggQAcJyjWqNy
         SiOqB2Nh03q46mC7JQZzE8wXf8MPxs7EJ1+evuQZDZPGgoDNGJNaNN1gFlXVeVThgW6L
         kBikTCbFO9I7z30++o0Y+n4QK1dLqw/Tc3i0LDioTB5EkoFj7qAX9KetVn1gujbjSQ44
         ZJ1g==
X-Gm-Message-State: AOJu0YzZJj/FhN6/eGsfWcyww+Ahw/h/+aoLS+sdxzge/Z0xHuU9t88R
        tSOfFnBZyw83DQBmZLZsc+cJFs3uqyvqhw==
X-Google-Smtp-Source: AGHT+IES6mTASs6ofGmEqPVGSEReAyYSPsGg1luXSNH6ohNwi2o6Wgu50apUx7iRhw74tV/1Ya3I9w==
X-Received: by 2002:a05:6870:c6a4:b0:1b0:3637:2bbe with SMTP id cv36-20020a056870c6a400b001b036372bbemr2302083oab.54.1696419067022;
        Wed, 04 Oct 2023 04:31:07 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id s185-20020a8182c2000000b00582b239674esm1076693ywf.129.2023.10.04.04.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 04:31:06 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f1dff5298so24256647b3.3;
        Wed, 04 Oct 2023 04:31:06 -0700 (PDT)
X-Received: by 2002:a81:918f:0:b0:59b:51d9:1d6e with SMTP id
 i137-20020a81918f000000b0059b51d91d6emr2122018ywg.6.1696419065791; Wed, 04
 Oct 2023 04:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-11-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-11-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 13:30:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJj+h5LfhQXTNkN3Cp2wP62SX6fY3frzytJQBcKXDJJQ@mail.gmail.com>
Message-ID: <CAMuHMdUJj+h5LfhQXTNkN3Cp2wP62SX6fY3frzytJQBcKXDJJQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/28] clk: renesas: rzg2l: refactor sd mux driver
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
> Refactor SD MUX driver to be able to reuse the same code on RZ/G3S.
> RZ/G2{L, UL} has a limitation with regards to switching the clock source
> for SD MUX (MUX clock source has to be switched to 266MHz before switching
> b/w 533MHz and 400MHz). This limitation has been introduced as a clock
> notifier that is registered on platform based initialization data thus the
> SD MUX code could be reused on RZ/G3S.
>
> As both RZ/G2{L, UL} and RZ/G3S has specific bits in specific registers
> to check if the clock switching has been done, this configuration (register
> offset, register bits and bits width) is now passed though
> struct cpg_core_clk::sconf (status configuration) from platform specific
> initialization code.
>
> Along with struct cpg_core_clk::sconf the mux table indices are also
> passed from platform specific initialization code.
>
> Also, mux flags are now passed to DEF_SD_MUX() as they will be later
> used by RZ/G3S.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - s/indexes/indices in commit description
> - mentioned in commit description that mux flags can now be passed to
>   driver though DEF_SD_MUX() macro
> - removed SoC specific names from macros' names
> - added spaces after { and before } when initializing arrays
> - preserved the order of .[gs]set_parent() API definitions for simpler
>   diff b/w versions
> - removed SD_MUX_NOTIF macro

Thanks for the update!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c

> @@ -142,6 +146,77 @@ static void rzg2l_cpg_del_clk_provider(void *data)
>         of_clk_del_provider(data);
>  }
>
> +/* Must be called in atomic context. */
> +static int rzg2l_cpg_wait_clk_update_done(void __iomem *base, u32 conf)
> +{
> +       u32 bitmask = GENMASK(GET_WIDTH(conf) - 1, 0) << GET_SHIFT(conf);
> +       u32 off = GET_REG_OFFSET(conf);
> +       u32 val;
> +
> +       return readl_poll_timeout_atomic(base + off, val, !(val & bitmask), 10, 200);
> +}
> +
> +int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event,
> +                                 void *data)
> +{
> +       struct clk_notifier_data *cnd = data;
> +       struct clk_hw *hw = __clk_get_hw(cnd->clk);
> +       struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
> +       struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
> +       u32 off = GET_REG_OFFSET(clk_hw_data->conf);
> +       u32 shift = GET_SHIFT(clk_hw_data->conf);
> +       const u32 clk_src_266 = 3;
> +       unsigned long flags;
> +       u32 bitmask;
> +       int ret;
> +
> +       if (event != PRE_RATE_CHANGE || (cnd->new_rate / MEGA == 266))
> +               return 0;

include/linux/clk.h:

 * PRE_RATE_CHANGE - called immediately before the clk rate is changed,
 *     to indicate that the rate change will proceed.  Drivers must
 *     immediately terminate any operations that will be affected by the
 *     rate change.  Callbacks may either return NOTIFY_DONE, NOTIFY_OK,
 *     NOTIFY_STOP or NOTIFY_BAD.

> +
> +       spin_lock_irqsave(&priv->rmw_lock, flags);
> +
> +       /*
> +        * As per the HW manual, we should not directly switch from 533 MHz to
> +        * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
> +        * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
> +        * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
> +        * (400 MHz)).
> +        * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
> +        * switching register is prohibited.
> +        * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
> +        * the index to value mapping is done by adding 1 to the index.
> +        */
> +       bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
> +       writel(bitmask | (clk_src_266 << shift), priv->base + off);
> +
> +       /* Wait for the update done. */
> +       ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
> +
> +       spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +
> +       if (ret)
> +               dev_err(priv->dev, "failed to switch to safe clk source\n");
> +
> +       return ret;

Likewise.

> +}

>
>  static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
>         .determine_rate = __clk_mux_determine_rate_closest,
> -       .set_parent     = rzg2l_cpg_sd_clk_mux_set_parent,
> -       .get_parent     = rzg2l_cpg_sd_clk_mux_get_parent,
> +       .set_parent     = rzg2l_cpg_sd_mux_clk_set_parent,
> +       .get_parent     = rzg2l_cpg_sd_mux_clk_get_parent,

Please keep the old names, for consistency with
__clk_mux_determine_rate_closest() and drivers/clk/clk-mux.c, and to
reduce the diff.

Any existing inconsistent use of "clk_mux" vs. "mux_clk" can be resolved
later with a separate patch, if anyone cares.

> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h

> @@ -272,4 +276,6 @@ extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
>  extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
>  extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
>
> +int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);

rzg2l_cpg_sd_clk_mux_notifier()?

> +
>  #endif

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
