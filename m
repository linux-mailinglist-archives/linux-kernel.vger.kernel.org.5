Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9327F7A41AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjIRHBB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbjIRHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:00:37 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC9F1;
        Mon, 18 Sep 2023 00:00:30 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-493639d616eso1354153e0c.0;
        Mon, 18 Sep 2023 00:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695020429; x=1695625229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37fpoq0Mdhc+DRKUSXeLkG6CRGdl6l+61BM4V42y2OQ=;
        b=wg0X65Wp1LoBixsuQjWPsXOcpcHIT5OF1kZGNfxBj0IWz0xjIp9Odqr22pgoXE4HWs
         W/fatH3ajRi8RhyA8XFifPrVlBO/DM48EJrO4+21gFVurFy4PQTnbv9LptOacQUHXO3+
         jD1Py4Bpcv6fAPlzF/+daHnmBMaPUyFIuqI6gIhdbNfVe+gpBOqfPmgy/AKThx4rzn/v
         4B7ZOHfEWQsQ2VvFUNYSIEtDsuZkv1K3fLJ3xhdYfFTdUSn+/3GStNWG+f0R0cveAzoR
         5gLqVHt/ZeUt99zKXU9ONeuNRoNYvA6Pkmmi3R7mi+d0MSkedTM0ja0q4WNfeaENF5EQ
         FFhA==
X-Gm-Message-State: AOJu0YwI1ybc6GkWNXe1KXSkAsN3iY8x+ukNGMzDoCkR6h55vqa7Ah1k
        BqUQiv+cDMpXjTgl/mTd4bnwc70o7vli+Q==
X-Google-Smtp-Source: AGHT+IHMVvCmkRdoxk5z09MmDyIlMYkNVzcAoWPhbFuOQ8oW8zqpPKAPXZkAgHXpWGs3V4o7GDG/qg==
X-Received: by 2002:a1f:48c3:0:b0:486:de54:b11 with SMTP id v186-20020a1f48c3000000b00486de540b11mr3185969vka.16.1695020429257;
        Mon, 18 Sep 2023 00:00:29 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id dt9-20020a05690c250900b0058ddb62f99bsm1685821ywb.38.2023.09.18.00.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 00:00:28 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59bc956b029so39683977b3.2;
        Mon, 18 Sep 2023 00:00:28 -0700 (PDT)
X-Received: by 2002:a0d:d808:0:b0:59b:cff1:a8eb with SMTP id
 a8-20020a0dd808000000b0059bcff1a8ebmr7661269ywe.34.1695020428210; Mon, 18 Sep
 2023 00:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-23-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUCpbPA3cDjNAq1irvr6z4Jux-5-tVDBuyr6nx_qOQGpg@mail.gmail.com> <e8d3f59a-fa1d-9993-6e84-99d976eb05fa@tuxon.dev>
In-Reply-To: <e8d3f59a-fa1d-9993-6e84-99d976eb05fa@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 09:00:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcfK0GjKsho5+SOQT0mk9pRXTfPgu2rc-peAM2yeiV-Q@mail.gmail.com>
Message-ID: <CAMuHMdWcfK0GjKsho5+SOQT0mk9pRXTfPgu2rc-peAM2yeiV-Q@mail.gmail.com>
Subject: Re: [PATCH 22/37] clk: renesas: add minimal boot support for RZ/G3S SoC
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
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

Hi Claudiu,

On Mon, Sep 18, 2023 at 8:20 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 15.09.2023 15:52, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Add minimal clock and reset support for RZ/G3S SoC to be able to boot
> >> Linux from SD Card/eMMC. This includes necessary core clocks for booting
> >> and GIC, SCIF, GPIO, SD0 mod clocks and resets.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> >> @@ -0,0 +1,217 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * RZ/G3S CPG driver
> >> + *
> >> + * Copyright (C) 2023 Renesas Electronics Corp.
> >> + */
> >> +
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/device.h>
> >> +#include <linux/init.h>
> >> +#include <linux/kernel.h>
> >> +
> >> +#include <dt-bindings/clock/r9a08g045-cpg.h>
> >> +
> >> +#include "rzg2l-cpg.h"
> >> +
> >> +/* RZ/G3S Specific registers. */
> >> +#define G3S_CPG_PL2_DDIV               (0x204)
> >> +#define G3S_CPG_SDHI_DDIV              (0x218)
> >> +#define G3S_CPG_PLL_DSEL               (0x240)
> >> +#define G3S_CPG_SDHI_DSEL              (0x244)
> >> +#define G3S_CLKSELSTATUS               (0x284)
> >> +
> >> +/* RZ/G3S Specific division configuration.  */
> >> +#define G3S_DIVPL2B            DDIV_PACK(G3S_CPG_PL2_DDIV, 4, 3)
> >> +#define G3S_DIV_SDHI0          DDIV_PACK(G3S_CPG_SDHI_DDIV, 0, 1)
> >> +
> >> +/* RZ/G3S Clock status configuration. */
> >> +#define G3S_DIVPL1A_STS                DDIV_PACK(CPG_CLKSTATUS, 0, 1)
> >> +#define G3S_DIVPL2B_STS                DDIV_PACK(CPG_CLKSTATUS, 5, 1)
> >> +#define G3S_DIVPL3A_STS                DDIV_PACK(CPG_CLKSTATUS, 8, 1)
> >> +#define G3S_DIVPL3B_STS                DDIV_PACK(CPG_CLKSTATUS, 9, 1)
> >> +#define G3S_DIVPL3C_STS                DDIV_PACK(CPG_CLKSTATUS, 10, 1)
> >> +#define G3S_DIV_SDHI0_STS      DDIV_PACK(CPG_CLKSTATUS, 24, 1)
> >
> > The register at offset 0x280 is called CPG_CLKDIVSTATUS, so
> > you probably want to add and use a G3S-specific definition.
>
> I just used the already definition as there is no conflict at the moment,
> it points to the same offset and is almost identical in name. With this
> would you still prefer to have it separately ?

I think that would be clearer for the casual reader.
On RZ/G2L, there is a single CPG_CLKSTATUS register to monitor frequency
dividers and selectors.
On RZ/G3S, this register was split into separate registers to monitor
frequency dividers (CPG_CLKDIVSTATUS) and selectors (CPG_CLKSELSTATUS).
You had to add a new definition for the latter anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
