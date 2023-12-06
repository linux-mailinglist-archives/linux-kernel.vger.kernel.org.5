Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C65806CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377805AbjLFK5C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 05:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377508AbjLFK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:57:00 -0500
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6461A5;
        Wed,  6 Dec 2023 02:57:01 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so5126955276.0;
        Wed, 06 Dec 2023 02:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860221; x=1702465021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxTfrYqiLxr3M+6uddkoekO0UeZOV7/CqGvJG57yRhQ=;
        b=WPbEAHUkgENLiMQCu2Q0ruGnVag8Q562hQHL7ft+YV2dPCqQpiXt0WlQPLWEZIz/SB
         P4CSItLNxpcmgsDqVhvqOfc30CIXNIHTBFbpXYWhXM1/tJ5D28GLCk5/oTgU8GwR1YFW
         rl8QQc5ScoF6McpSnWo4kb9sfWEioPj9x6B2GaPRxmq1uyXPppupC8SYFZcVT5JwWFA7
         YXKbh5qRpjxtcgXUEA3Cv3ExZR9WxxY3r65j5kpdDUq2Ct3SC7jfhBXKNGFAVJYu59gi
         kjutOuSM38+al2kdeZ7ovECJ0MyDKuyxqJNhfiV2ze6M7fo5tW9DG14HPP+Nceb0GVq9
         C2AQ==
X-Gm-Message-State: AOJu0YyaJSLF+p75/gaqXhmPW6ndbsEmqfemfk/bZSFIj06Txw8kMcPv
        oEHeIuJw1+xHJKapewMYHXOJ5eHJq+mLEg==
X-Google-Smtp-Source: AGHT+IGLeztLiZDB9xM0WxwbOKDNkEkwMuKeZIM5i82Y5PGYqOeXqmEI+Wzll6y2qtTM4d2hbwikqA==
X-Received: by 2002:a25:8010:0:b0:db5:4508:28b8 with SMTP id m16-20020a258010000000b00db5450828b8mr442065ybk.38.1701860220886;
        Wed, 06 Dec 2023 02:57:00 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id y8-20020a259288000000b00db9811e1f92sm1423221ybl.7.2023.12.06.02.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 02:57:00 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5d74186170fso41744507b3.3;
        Wed, 06 Dec 2023 02:57:00 -0800 (PST)
X-Received: by 2002:a81:b722:0:b0:5d3:a3fb:428e with SMTP id
 v34-20020a81b722000000b005d3a3fb428emr544436ywh.21.1701860220544; Wed, 06 Dec
 2023 02:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-12-claudiu.beznea.uj@bp.renesas.com> <CAMuHMdUbKe=yiXWNmk5BJFLtF2psx9khiDRGasT9WsnHz4RWsg@mail.gmail.com>
In-Reply-To: <CAMuHMdUbKe=yiXWNmk5BJFLtF2psx9khiDRGasT9WsnHz4RWsg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Dec 2023 11:56:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXwSo1L9UuFg9RL0TLL_xzVt2r6QEFc0gtPoydpr4FmSQ@mail.gmail.com>
Message-ID: <CAMuHMdXwSo1L9UuFg9RL0TLL_xzVt2r6QEFc0gtPoydpr4FmSQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] arm64: renesas: rzg3s-smarc-som: Invert the logic
 for SW_SD2_EN macro
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

On Wed, Dec 6, 2023 at 11:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Nov 20, 2023 at 8:03 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The intention of SW_SD2_EN macro was to reflect the state of SW_CONFIG3
> > switch available on RZ/G3S Smarc Module. According to documentation SD2
> > is enabled when switch is in OFF state. For this, changed the logic of
> > marco to map value 0 to switch's OFF state and value 1 to switch's ON
> > state. Along with this update the description for each state for better
> > understanding.
> >
> > The value of SW_SD2_EN macro was not changed in file because, according to
> > documentation, the default state for this switch is ON.
> >
> > Fixes: adb4f0c5699c ("arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM")
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> > @@ -14,8 +14,8 @@
> >   *     0 - SD0 is connected to eMMC
> >   *     1 - SD0 is connected to uSD0 card
> >   * @SW_SD2_EN:
> > - *     0 - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
> > - *     1 - SD2 is connected to SoC
> > + *     0 - (switch OFF) SD2 is connected to SoC
> > + *     1 - (switch ON)  SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
>
> I think this is still confusing: SW_SD2_EN refers to an active-low signal
> (SW_SD2_EN#) in the schematics.

OMG, while the signal is called "SW_SD2_EN#" in the schematics, it is
_not_ active-low!
SW_D2_EN# drives a STG3692 quad SPDT switch, and SD2 is enabled
if SW_D2_EN# is high...

The RZ/G3S SMARC Module User Manual says:

Signal SW_SD2_EN ON: SD2 is disabled.
Signal SW_SD2_EN OFF: SD2 is enabled.

So whatever we do, something will look odd :-(

> Before, SW_SD2_EN used assertion-logic (1 is enabled), and didn't
> match the physical signal level.
> After your patch, SW_SD2_EN matches the active-low physical level, but
> this is not reflected in the name...
>
> >   */
> >  #define SW_SD0_DEV_SEL 1
> >  #define SW_SD2_EN      1
> > @@ -25,7 +25,7 @@ / {
> >
> >         aliases {
> >                 mmc0 = &sdhi0;
> > -#if SW_SD2_EN
> > +#if !SW_SD2_EN
>
> ... so this condition looks really weird.

Still, I think the original looks nicer here.

So I suggest to keep the original logic, but clarify the position of
the switch.
Does that make sense?


>
> >                 mmc2 = &sdhi2;
> >  #endif
> >         };
> > @@ -116,7 +116,7 @@ &sdhi0 {
> >  };
> >  #endif
> >
> > -#if SW_SD2_EN
> > +#if !SW_SD2_EN
> >  &sdhi2 {
> >         pinctrl-0 = <&sdhi2_pins>;
> >         pinctrl-names = "default";
>
> So I think SW_SD2_EN should be renamed to SW_SD2_EN_N.
>
> Cfr. SW_ET0_EN_N on RZ/G2UL:
>
> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts- * DIP-Switch SW1 setting
> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts- * 1 : High; 0: Low
> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts- * SW1-2 :
> SW_SD0_DEV_SEL    (0: uSD; 1: eMMC)
> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts- * SW1-3 :
> SW_ET0_EN_N               (0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts- * Please change
> below macros according to SW1 setting on the SoM

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
