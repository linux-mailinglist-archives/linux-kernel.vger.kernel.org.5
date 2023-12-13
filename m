Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F44811458
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441830AbjLMOMD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 09:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378965AbjLMOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:12:01 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA89D5;
        Wed, 13 Dec 2023 06:12:08 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ba00fe4e94so3166020b6e.1;
        Wed, 13 Dec 2023 06:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476727; x=1703081527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w48gI2HFmrTH0rc6ZXDfPNcqi3jFvN66ZhY2cGzxgyc=;
        b=i+ng0N0FoZFwBOKDKYcDVtHtAhtqzOKkCqErJejrfBo28atZI7U9XWTWw8Dwc5dbaq
         TIYbAMDyGqR/HPrmoL3xXpqG7jmoBDDeRdj+Vw01HK0u7pEurmKtPfDxZ4AsUvgtww1m
         /v2UD5djuZHnXga8I81JPaHt8k4VKxkqsMuxUh4mvzOu4n+hPJ+sbiYet3FHhDBJAtvh
         m303CPn3xeHt33Smcl0saKIDwXqdg8EPOAlNPGCsqQmOnVZmsX6nifEjiM3wN5Ittocq
         hBKcar0CnGBNXhaK8Rju/KF8RQBhxVKOdhrSHRuT5hU16U/X13Pr6A9U2tnfGPaI5MV5
         bqNg==
X-Gm-Message-State: AOJu0Yx37v0duITaXZdGdCTd1fn4xQ0Lh+wvbUvdw/VAhE1vszj1ASTu
        9wDRQ+cIFnLwwhRe6lnBAXubuaUa56TFEg==
X-Google-Smtp-Source: AGHT+IG39O+Sc1d2bs6DgYskFab3MrseA5o7VralX03dxK7k20ZDG+F+o/hLq3RckW1lhzivYaNbBA==
X-Received: by 2002:a05:6808:219c:b0:3b8:b1bd:b36a with SMTP id be28-20020a056808219c00b003b8b1bdb36amr11491180oib.49.1702476727174;
        Wed, 13 Dec 2023 06:12:07 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id h6-20020a056808014600b003b9d5e265f1sm2969756oie.2.2023.12.13.06.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:12:06 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b8b8372e30so5209170b6e.3;
        Wed, 13 Dec 2023 06:12:06 -0800 (PST)
X-Received: by 2002:a05:6870:858d:b0:1fa:df72:9ed5 with SMTP id
 f13-20020a056870858d00b001fadf729ed5mr9138641oal.38.1702476726457; Wed, 13
 Dec 2023 06:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120111820.87398-2-claudiu.beznea.uj@bp.renesas.com> <e8637d39-911d-d8a3-b8da-548914df6ac@linux-m68k.org>
In-Reply-To: <e8637d39-911d-d8a3-b8da-548914df6ac@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 15:11:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMxoHqqh7uXjVbvwXsUUVHj2U0S6N7yLGPK=yh3NejmA@mail.gmail.com>
Message-ID: <CAMuHMdWMxoHqqh7uXjVbvwXsUUVHj2U0S6N7yLGPK=yh3NejmA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] clk: renesas: r9a08g045: Add IA55 pclk and its reset
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
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

On Tue, Nov 21, 2023 at 10:59 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, 20 Nov 2023, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > IA55 interrupt controller is available on RZ/G3S SoC. Add IA55 pclk and
> > its reset.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/clk/renesas/r9a08g045-cpg.c
> > +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> > @@ -188,6 +188,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
> >
> > static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
> >       DEF_MOD("gic_gicclk",           R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0),
> > +     DEF_MOD("ia55_pclk",            R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
>
> This conflicts with [1], which you sent just before.
>
> If that patch goes in first, I guess this new entry should gain
> ", MSTOP(PERI_CPU, BIT(13))", just like the entry for ia55_clk?
>
> >       DEF_MOD("ia55_clk",             R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
> >       DEF_MOD("dmac_aclk",            R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
> >       DEF_MOD("sdhi0_imclk",          R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> [1] "clk: renesas: rzg2l-cpg: Add support for MSTOP"
>      https://lore.kernel.org/r/20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com

As the MSTOP support is on hold, I will queue this in renesas-clk-for-v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
