Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79D79161B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352725AbjIDLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjIDLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:15:37 -0400
X-Greylist: delayed 632 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 04:15:34 PDT
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EBFE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:15:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qd7YA-0000np-Ia; Mon, 04 Sep 2023 13:15:22 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1qd7Y8-003rxO-Tl; Mon, 04 Sep 2023 13:15:20 +0200
Received: from mtr by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qd7Y8-001143-IN; Mon, 04 Sep 2023 13:15:20 +0200
Date:   Mon, 4 Sep 2023 13:15:20 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Inki Dae <daeinki@gmail.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/5] drm/bridge: samsung-dsim: update PLL reference clock
Message-ID: <20230904111520.GC224131@pengutronix.de>
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-3-b39716db6b7a@pengutronix.de>
 <CAAQKjZODcKE_O-Nb_qym0BqAZymUu9j24d+8-UXFsFQekJ=unw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAQKjZODcKE_O-Nb_qym0BqAZymUu9j24d+8-UXFsFQekJ=unw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 14:44:41 +0900, Inki Dae wrote:
> 2023년 8월 29일 (화) 오전 12:59, Michael Tretter <m.tretter@pengutronix.de>님이 작성:
> >
> > The PLL requires a clock between 2 MHz and 30 MHz after the pre-divider.
> > The reference clock for the PLL may change due to changes to it's parent
> > clock. Thus, the frequency may be out of range or unsuited for
> > generating the high speed clock for MIPI DSI.
> >
> > Try to keep the pre-devider small, and set the reference clock close to
> > 30 MHz before recalculating the PLL configuration. Use a divider with a
> > power of two for the reference clock as this seems to work best in
> > my tests.
> 
> Clock frequency is specific to SoC architecture so we have to handle
> it carefully because samsung-dsim.c is a common module for I.MX and
> Exynos series.
> You mentioned "The PLL requires a clock between 2 MHz and 3MHz after
> pre-divider", and the clock means that fin_pll - PFD input frequency -
> which can be calculated with oscillator clock frequency / P value?
> According to Exynos datasheet, the fin_pll should be 6 ~ 12Mhz.
> 
> For example,
> In case of Exyhos, we use 24MHz as oscillator clock frequency, so
> fin_pll frequency, 8MHz = 24MHz / P(3).
> 
> Can you tell me the source of the constraint that clocks must be
> between 2MHz and 30MHz?

The source is the i.MX8M Nano reference manual, Table 13-40. DPHY PLL
Parameters. It documents that the P divider frequency (fin_pll) has a
frequency range of 2 MHz to 30 MHz. According to the same table, the input
frequency (fin) has a range of 6 MHz to 300 MHz.

Is the table incorrect?

I also tried to always set the reference clock to 24 MHz, but depending on the
display clock this isn't always possible.

Michael

> 
> To other I.MX and Exynos engineers, please do not merge this patch
> until two SoC platforms are tested correctly.
> 
> Thanks,
> Inki Dae
> 
> >
> > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> > index da90c2038042..4de6e4f116db 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -611,10 +611,21 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
> >         u16 m;
> >         u32 reg;
> >
> > -       if (dsi->pll_clk)
> > +       if (dsi->pll_clk) {
> > +               /*
> > +                * Ensure that the reference clock is generated with a power of
> > +                * two divider from its parent, but close to the PLLs upper
> > +                * limit of the valid range of 2 MHz to 30 MHz.
> > +                */
> > +               fin = clk_get_rate(clk_get_parent(dsi->pll_clk));
> > +               while (fin > 30 * MHZ)
> > +                       fin = fin / 2;
> > +               clk_set_rate(dsi->pll_clk, fin);
> > +
> >                 fin = clk_get_rate(dsi->pll_clk);
> > -       else
> > +       } else {
> >                 fin = dsi->pll_clk_rate;
> > +       }
> >         dev_dbg(dsi->dev, "PLL ref clock freq %lu\n", fin);
> >
> >         fout = samsung_dsim_pll_find_pms(dsi, fin, freq, &p, &m, &s);
> >
> > --
> > 2.39.2
> >
> 
