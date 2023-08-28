Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1878B584
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjH1QnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjH1Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:42:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C3139
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:42:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qafJw-0003St-3U; Mon, 28 Aug 2023 18:42:32 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qafJu-00054D-Rv; Mon, 28 Aug 2023 18:42:30 +0200
Date:   Mon, 28 Aug 2023 18:42:30 +0200
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
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/5] drm/bridge: samsung-dsim: fix various modes with
 ADV7535 bridge
Message-ID: <20230828164230.e2qnh4qe7w6xy6rn@pengutronix.de>
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
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
> I tested the i.MX8M Nano EVK with the NXP supplied MIPI-DSI adapter,
> which uses an ADV7535 MIPI-DSI to HDMI converter. I found that a few
> modes were working, but in many modes my monitor stayed dark.
> 
> This series fixes the Samsung DSIM bridge driver to bring up a few more
> modes:
> 
> The driver read the rate of the PLL ref clock only during probe.
> However, if the clock is re-parented to the VIDEO_PLL, changes to the
> pixel clock have an effect on the PLL ref clock. Therefore, the driver
> must read and potentially update the PLL ref clock on every modeset.
> 
> I also found that the rounding mode of the porches and active area has
> an effect on the working modes. If the driver rounds up instead of
> rounding down and be calculates them in Hz instead of kHz, more modes
> start to work.
> 
> The following table shows the modes that were working in my test without
> this patch set and the modes that are working now:
> 
> |            Mode | Before | Now |
> | 1920x1080-60.00 | X      | X   |
> | 1920x1080-59.94 |        | X   |
> | 1920x1080-50.00 |        | X   |
> | 1920x1080-30.00 |        | X   |
> | 1920x1080-29.97 |        | X   |
> | 1920x1080-25.00 |        | X   |
> | 1920x1080-24.00 |        |     |
> | 1920x1080-23.98 |        |     |
> | 1680x1050-59.88 |        | X   |
> | 1280x1024-75.03 | X      | X   |
> | 1280x1024-60.02 | X      | X   |
> |  1200x960-59.99 |        | X   |
> |  1152x864-75.00 | X      | X   |
> |  1280x720-60.00 |        |     |
> |  1280x720-59.94 |        |     |
> |  1280x720-50.00 |        | X   |
> |  1024x768-75.03 |        | X   |
> |  1024x768-60.00 |        | X   |
> |   800x600-75.00 | X      | X   |
> |   800x600-60.32 | X      | X   |
> |   720x576-50.00 | X      | X   |
> |   720x480-60.00 |        |     |
> |   720x480-59.94 | X      |     |
> |   640x480-75.00 | X      | X   |
> |   640x480-60.00 |        | X   |
> |   640x480-59.94 |        | X   |
> |   720x400-70.08 |        |     |
> 
> Interestingly, the 720x480-59.94 mode stopped working. However, I am
> able to bring up the 720x480 modes by manually hacking the active area
> (hsa) to 40 and carefully adjusting the clocks, but something still
> seems to be off.
> 
> Unfortunately, a few more modes are still not working at all. The NXP
> downstream kernel has some quirks to handle some of the modes especially
> wrt. to the porches, but I cannot figure out, what the driver should
> actually do in these cases. Maybe there is still an error in the
> calculation of the porches and someone at NXP can chime in.
> 
> Michael
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
> Marco Felsch (1):
>       drm/bridge: samsung-dsim: add more mipi-dsi device debug information
> 
> Michael Tretter (4):
>       drm/bridge: samsung-dsim: reread ref clock before configuring PLL
>       drm/bridge: samsung-dsim: update PLL reference clock
>       drm/bridge: samsung-dsim: adjust porches by rounding up
>       drm/bridge: samsung-dsim: calculate porches in Hz

Feel free to add my r-b for your patches.

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
