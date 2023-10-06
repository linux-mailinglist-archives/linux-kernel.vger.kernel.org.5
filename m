Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0807BBB3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjJFPHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjJFPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:07:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975348F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:07:08 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1qomPy-00051v-D3; Fri, 06 Oct 2023 17:07:06 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
Date:   Fri, 06 Oct 2023 17:07:07 +0200
Subject: [PATCH v2 5/5] drm/bridge: samsung-dsim: calculate porches in Hz
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-samsung-dsim-v2-5-846603df0e0a@pengutronix.de>
References: <20230818-samsung-dsim-v2-0-846603df0e0a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v2-0-846603df0e0a@pengutronix.de>
To:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Michael Tretter <m.tretter@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculating the byte_clk in kHz is imprecise for a hs_clock of 55687500
Hz, which may be used with a pixel clock of 74.25 MHz with mode
1920x1080-30.

Fix the calculation by using HZ instead of kHZ.

This requires to change the type to u64 to prevent overflows of the
integer type.

Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM + Waveshare 10.1inch HDMI LCD (E)
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

---
Changes in v2: None
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 714e1e833606..63a0d8dbe37c 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -986,10 +986,12 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
 	u32 reg;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
-		int hfp = DIV_ROUND_UP((m->hsync_start - m->hdisplay) * byte_clk_khz, m->clock);
-		int hbp = DIV_ROUND_UP((m->htotal - m->hsync_end) * byte_clk_khz, m->clock);
-		int hsa = DIV_ROUND_UP((m->hsync_end - m->hsync_start) * byte_clk_khz, m->clock);
+		u64 byte_clk = dsi->hs_clock / 8;
+		u64 pix_clk = m->clock * 1000;
+
+		int hfp = DIV64_U64_ROUND_UP((m->hsync_start - m->hdisplay) * byte_clk, pix_clk);
+		int hbp = DIV64_U64_ROUND_UP((m->htotal - m->hsync_end) * byte_clk, pix_clk);
+		int hsa = DIV64_U64_ROUND_UP((m->hsync_end - m->hsync_start) * byte_clk, pix_clk);
 
 		/* remove packet overhead when possible */
 		hfp = max(hfp - 6, 0);

-- 
2.39.2

