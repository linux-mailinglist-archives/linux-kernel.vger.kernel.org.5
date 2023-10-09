Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F87C7BDA80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbjJIL54 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 07:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346354AbjJIL5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:57:54 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D6C99;
        Mon,  9 Oct 2023 04:57:52 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7af20c488so766257b3.1;
        Mon, 09 Oct 2023 04:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852671; x=1697457471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f0PTv84uwB8e7Frsy1nJ0Q69ieHgE7cDk3dtnj/+BE=;
        b=rWO97CYX/yvxXutuSPIEOSpJUP7+A8mPmqV2fhJsqbISajtO1X44kbUGgdhRwMI9Cw
         5TaUjO35xq8EI8nF+Zt7EHI39YK+OMb4x4wMHUTSjwJKNy80blc9C7fhokD7ZEvo7zbA
         LCJ/492kc6EIDOrvA5mMnwm/SMr3dgI7v5N7lWHMHzo8T/L4fUnQqA1uO5uxtXeIWcuQ
         9w0iGfpN8ghTn0OqrnaTNzgVcwG4qlQjOrrKLfLvHzcu3xZ35TpaXyKuJ7EMv5PqPzRf
         RPrz0LuMXiQJJqvrEIOcnMyt7tIomAEec0cqBGktxLWN94ghrmdQmvr24xpL9xhsKOp7
         98CQ==
X-Gm-Message-State: AOJu0YyxgwUHv5tUPHVuKUVT0NS0jBS7ISjKretPGSRi9+ageTNg7IOu
        NOb2N2KYFR/Pivww0DlUKSM1/HvxRMWxAw==
X-Google-Smtp-Source: AGHT+IHhc33szlhZCOgodX5aT1yqL7F0k04W0I4Y5OfqHlKE0gqx1D4i4dS8q2o7cfiCtAu8OARmDg==
X-Received: by 2002:a81:5387:0:b0:591:8d06:e4e8 with SMTP id h129-20020a815387000000b005918d06e4e8mr15952268ywb.38.1696852671468;
        Mon, 09 Oct 2023 04:57:51 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id u17-20020a81a511000000b0059af9f2ee68sm3563640ywg.66.2023.10.09.04.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:57:51 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a505762c9dso54520607b3.2;
        Mon, 09 Oct 2023 04:57:50 -0700 (PDT)
X-Received: by 2002:a0d:ea95:0:b0:5a1:ed8d:111f with SMTP id
 t143-20020a0dea95000000b005a1ed8d111fmr15870851ywe.1.1696852670754; Mon, 09
 Oct 2023 04:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-12-claudiu.beznea@bp.renesas.com> <CAMuHMdX8wPNr4LsPJR7zk3Ktb8NnqcSMUEjsAURc2NJ_dpiDHw@mail.gmail.com>
In-Reply-To: <CAMuHMdX8wPNr4LsPJR7zk3Ktb8NnqcSMUEjsAURc2NJ_dpiDHw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 13:57:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5W60nG_iPgDzcQiD2zByu734gM3d8J5Bn3V2RTTG=jg@mail.gmail.com>
Message-ID: <CAMuHMdX5W60nG_iPgDzcQiD2zByu734gM3d8J5Bn3V2RTTG=jg@mail.gmail.com>
Subject: Re: [PATCH v2 11/28] clk: renesas: rzg2l: add a divider clock for RZ/G3S
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Wed, Oct 4, 2023 at 2:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Add a divider clock driver for RZ/G3S. This will be used in RZ/G3S
> > by SDHI, SPI, OCTA, I, I2, I3, P0, P1, P2, P3 core clocks.
> > The divider has some limitation for SDHI and OCTA clocks:
> > - SD div cannot be 1 if parent rate is 800MHz
> > - OCTA div cannot be 1 if parent rate is 400MHz
> > For these clocks a notifier could be registered from platform specific
> > clock driver and proper actions are taken before clock rate is changed,
> > if needed.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >
> > Changes in v2:
> > - removed DIV_NOTIF macro

> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c

> > +static struct clk * __init
> > +rzg3s_cpg_div_clk_register(const struct cpg_core_clk *core, struct clk **clks,
> > +                          void __iomem *base, struct rzg2l_cpg_priv *priv)
> > +{
> > +       struct div_hw_data *div_hw_data;
> > +       struct clk_init_data init = {};
> > +       const struct clk_div_table *clkt;
> > +       struct clk_hw *clk_hw;
> > +       const struct clk *parent;
> > +       const char *parent_name;
> > +       u32 max;
> > +       int ret;
> > +
> > +       parent = clks[core->parent & 0xffff];
> > +       if (IS_ERR(parent))
> > +               return ERR_CAST(parent);
> > +
> > +       parent_name = __clk_get_name(parent);
> > +
> > +       div_hw_data = devm_kzalloc(priv->dev, sizeof(*div_hw_data), GFP_KERNEL);
> > +       if (!div_hw_data)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       init.name = core->name;
> > +       init.flags = core->flag;
> > +       init.ops = &rzg3s_div_clk_ops;
> > +       init.parent_names = &parent_name;
> > +       init.num_parents = 1;
> > +
> > +       /* Get the maximum divider to retrieve div width. */
> > +       for (clkt = core->dtable; clkt->div; clkt++) {
> > +               if (max < clkt->div)
>
> "max" is used uninitialized
>
> > +                       max = clkt->div;
> > +       }
> > +
> > +       div_hw_data->hw_data.priv = priv;
> > +       div_hw_data->hw_data.conf = core->conf;
> > +       div_hw_data->hw_data.sconf = core->sconf;
> > +       div_hw_data->dtable = core->dtable;
> > +       div_hw_data->invalid_rate = core->invalid_rate;
> > +       div_hw_data->width = fls(max) - 1;
>
> Isn't that

My apologies for not finishing my sentence; I wanted to write "Isn't
that identical to __fls(max)?".  But as the latter generates slightly
worse code, it's not worth making that change.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
