Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBEC78B583
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjH1Qmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjH1QmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:42:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F13131
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:42:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qafJH-0003M3-Bj; Mon, 28 Aug 2023 18:41:51 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qafJF-00053a-0M; Mon, 28 Aug 2023 18:41:49 +0200
Date:   Mon, 28 Aug 2023 18:41:48 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
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
Message-ID: <20230828164148.tm23yudt76eqefzh@pengutronix.de>
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-3-b39716db6b7a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-samsung-dsim-v1-3-b39716db6b7a@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-28, Michael Tretter wrote:
> The PLL requires a clock between 2 MHz and 30 MHz after the pre-divider.
> The reference clock for the PLL may change due to changes to it's parent
> clock. Thus, the frequency may be out of range or unsuited for
> generating the high speed clock for MIPI DSI.
> 
> Try to keep the pre-devider small, and set the reference clock close to
> 30 MHz before recalculating the PLL configuration. Use a divider with a
> power of two for the reference clock as this seems to work best in
> my tests.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index da90c2038042..4de6e4f116db 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -611,10 +611,21 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
>  	u16 m;
>  	u32 reg;
>  
> -	if (dsi->pll_clk)
> +	if (dsi->pll_clk) {
> +		/*
> +		 * Ensure that the reference clock is generated with a power of
> +		 * two divider from its parent, but close to the PLLs upper
> +		 * limit of the valid range of 2 MHz to 30 MHz.
> +		 */
> +		fin = clk_get_rate(clk_get_parent(dsi->pll_clk));
> +		while (fin > 30 * MHZ)
> +			fin = fin / 2;

Really just a cosmetic nit: fin /= 2;

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> +		clk_set_rate(dsi->pll_clk, fin);
> +
>  		fin = clk_get_rate(dsi->pll_clk);
> -	else
> +	} else {
>  		fin = dsi->pll_clk_rate;
> +	}
>  	dev_dbg(dsi->dev, "PLL ref clock freq %lu\n", fin);
>  
>  	fout = samsung_dsim_pll_find_pms(dsi, fin, freq, &p, &m, &s);
> 
> -- 
> 2.39.2
> 
> 
> 
