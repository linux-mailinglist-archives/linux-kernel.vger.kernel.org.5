Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA37A441A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbjIRILE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbjIRIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:10:47 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573E91;
        Mon, 18 Sep 2023 01:10:42 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-65642ade0easo12524116d6.1;
        Mon, 18 Sep 2023 01:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024641; x=1695629441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX+6XiZ9i9bduvS7LsPDJJ/qIaDd1B/wTxi5s+/d5gs=;
        b=gLQe+fp4gNihvquT5rZUYAslzC0hDLrDAWD5jjhkHvnBeaO2uu3f3h+aU1LC8/xKvZ
         RKYj7h9T1qR2iyfHaAxr5zkz2Me7v9d21PscfG1wci0KHJFOvheYKzNIfJKCJHbC97/+
         W/1GtCm+x55PDjX178BPuPfsiB4j/q0ESHKUh3Ra/q5/1E+q7Zc31ldQY4NWLpWeKKo6
         AdoKWcwMRQdQna5X1M4rCwmtFZaJfNsTSCco7wJ1nMc87A6zHR0nGk1gb2/iZ1HsAoeY
         asdozON9i86aGTXqCdEcDPaGpAPOUaOjdTIZPfE6Vzo0wZMASTnq7THOLBYtU7zq3uCL
         xHpg==
X-Gm-Message-State: AOJu0Yw1O1KjXXtnbClHolvj8duyPGwzTZhbFhzuvW+IltAEWUQPaw3n
        kNs8U1GnXjEB+rwxzhd7glMgrtBWO2aE/w==
X-Google-Smtp-Source: AGHT+IEssz/h2MzmVPfY/xAB1BaTSjOhI/Bwq5sx6gVrWw2l9kRGzoEy1ex5EvPT1YRDd3dVZtTFBQ==
X-Received: by 2002:a05:6214:4b12:b0:656:1c7b:5aa1 with SMTP id pj18-20020a0562144b1200b006561c7b5aa1mr9485316qvb.29.1695024641328;
        Mon, 18 Sep 2023 01:10:41 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id mu7-20020a056214328700b0064f42b1ab05sm3179770qvb.39.2023.09.18.01.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 01:10:41 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-65631aa8b93so18948376d6.3;
        Mon, 18 Sep 2023 01:10:41 -0700 (PDT)
X-Received: by 2002:a81:6d84:0:b0:58f:c452:74da with SMTP id
 i126-20020a816d84000000b0058fc45274damr9139447ywc.42.1695024249288; Mon, 18
 Sep 2023 01:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-15-claudiu.beznea.uj@bp.renesas.com> <CAMuHMdWRxaBsPAn0OR15WFua_5HZVPTmWabFnnex5gDLKjE9Cw@mail.gmail.com>
In-Reply-To: <CAMuHMdWRxaBsPAn0OR15WFua_5HZVPTmWabFnnex5gDLKjE9Cw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 10:03:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1_Hyqzkf73k2-Vou_qJX8eUzEG+hJ-yP+9TYErWjyGg@mail.gmail.com>
Message-ID: <CAMuHMdV1_Hyqzkf73k2-Vou_qJX8eUzEG+hJ-yP+9TYErWjyGg@mail.gmail.com>
Subject: Re: [PATCH 14/37] clk: renesas: rzg2l: use u32 for flag and mux_flags
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 3:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > flag and mux_flags are intended to keep bit masks. Use u32 type for it.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/clk/renesas/rzg2l-cpg.h
> > +++ b/drivers/clk/renesas/rzg2l-cpg.h
> > @@ -92,8 +92,8 @@ struct cpg_core_clk {
> >         unsigned int conf;
> >         const struct clk_div_table *dtable;
> >         const char * const *parent_names;
> > -       int flag;
> > -       int mux_flags;
> > +       u32 flag;
>
> "flag" is used for several purposes, which expected different types:
>     - clk_init_data.flags is unsigned long,
>     - The clk_divider_flags parameter of clk_hw_register_divider_table() is u8,
>     - The clk_divider_flags parameter of __clk_hw_register_divider() is u8,
>     - The flags parameter of __devm_clk_hw_register_mux() is unsigned long.
>
> > +       u32 mux_flags;
>
> Actually the clk_mux_flags parameter of __devm_clk_hw_register_mux() is u8.
>
> >         int num_parents;
> >  };
>
> I guess u32 is fine for all.
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thx, will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
