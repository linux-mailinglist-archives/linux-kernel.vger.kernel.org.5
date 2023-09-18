Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754E17A4E88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjIRQSv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjIRQSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:18:38 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951F274AD;
        Mon, 18 Sep 2023 09:15:49 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3adcec86a8cso903542b6e.3;
        Mon, 18 Sep 2023 09:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053748; x=1695658548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7dgcdQA0BxA6uxrPcgZG7zRAgTuR6bE+wss81BpvFI=;
        b=pkSUPj3H7bPK9w75u9rieO9wC5kvpqN2x/X+9YYpr7ev3YrZkphBtBCOEoeYK3cEoY
         0zqu3RsjEpVpQG1PLnRKpt9J3HIcNIy8+cze6BUiQq8fHWhNiMgBhuD6lJCqbg/yLc+J
         RuNb+BWiWRQFzajIQFde+X7UnIAAWxdLr4/dwO7RsxBOQEZ1sV2cTObrUF36gdLEZlPH
         DgdSUnoJ9p7N6Xmf7tIah48eU2GsWmsQPSbJjsYtPJsTw+3k4NLAiufOv7XeKEU289W1
         TYJgd7Rx0LheqklpQn1wBtAUTbs0+sIWT2e/5oRtvMfel13t6JcXqm12usDhr+1aRgiS
         bTww==
X-Gm-Message-State: AOJu0Yzs1aLPntMQC2E2c3HM9BsChy7GOh8KNMXZJ7xzFjBZI9+EgAla
        E02dNSd/hyN2E5o7hX1rn0Hmr2PEa1zNUA==
X-Google-Smtp-Source: AGHT+IE2m9SI7J4ee/V2/V8uShuTeKtTeMxzv7/lqSJJ9l9e+1lBZTn/KNgd5/08OzU78hRM3KD36g==
X-Received: by 2002:a81:9108:0:b0:583:f78c:994e with SMTP id i8-20020a819108000000b00583f78c994emr8725543ywg.42.1695043566967;
        Mon, 18 Sep 2023 06:26:06 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b00585e2c112fdsm2537505ywc.111.2023.09.18.06.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:26:06 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d801c83325fso4134244276.0;
        Mon, 18 Sep 2023 06:26:06 -0700 (PDT)
X-Received: by 2002:a25:d105:0:b0:d78:3a4e:c19e with SMTP id
 i5-20020a25d105000000b00d783a4ec19emr8161004ybg.24.1695043566396; Mon, 18 Sep
 2023 06:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
 <20230918123355.262115-3-biju.das.jz@bp.renesas.com> <CAMuHMdVcy82eQNKtqufk8Nb6PKYTgmZw_b_mC+qgmGMHt1gyiw@mail.gmail.com>
 <OS0PR01MB5922356278D492FC32F0583586FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922356278D492FC32F0583586FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 15:25:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtHawgor2Hs3vZDcTv8WXWhUAzSRYBpM1cD=ozKT4G2w@mail.gmail.com>
Message-ID: <CAMuHMdWtHawgor2Hs3vZDcTv8WXWhUAzSRYBpM1cD=ozKT4G2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO
 interrupt input
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
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

On Mon, Sep 18, 2023 at 3:18 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for
> > GPIO interrupt input
> >
> > On Mon, Sep 18, 2023 at 2:34 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > As per RZ/G2L hardware manual Rev.1.30 section 8.7.3 GPIO Interrupt
> > > (TINT) and 41.4.1 Operation for GPIO function, we need to set digital
> > > noise filter for GPIO interrupt.
> > >
> > > This patch enables noise filter for GPIO interrupt in
> > > rzg2l_gpio_irq_enable() and disable it in rzg2l_gpio_irq_disable().
> > >
> > > Fixes: db2e5f21a48e ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
> > > to handle GPIO interrupt")
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > @@ -96,6 +96,7 @@
> > >  #define PIN(n)                 (0x0800 + 0x10 + (n))
> > >  #define IOLH(n)                        (0x1000 + (n) * 8)
> > >  #define IEN(n)                 (0x1800 + (n) * 8)
> > > +#define FILONOFF(n)            (0x2080 + (n) * 8)
> > >  #define ISEL(n)                        (0x2c80 + (n) * 8)
> > >  #define PWPR                   (0x3014)
> > >  #define SD_CH(n)               (0x3000 + (n) * 4)
> >
> > LGTM, but shouldn't you configure the Digital Noise Filter Number
> > (FILNUM) and Clock Selection (FILCLKSEL) registers, too?
>
> Currently it uses reset values.
>
> 00b: 4-stage filter (41.666 ns x 4 = 166.666 ns) (initial value) for FILNUM and
>
> 00b: Not divided (initial value) for FILCLKSEL
>
> Do you mean we should provide these settings to DT, so that
> it is customised based on the PCB design and the environment
> the board is used in? I guess this will make it easier for
> customers to make the required changes for their application.

If the optimal values are board-dependent, you should indeed add
a way to configure this from DT.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
