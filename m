Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C0578B4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjH1P7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjH1P7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:59:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989E119
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:59:19 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1qaee0-0005pk-N8; Mon, 28 Aug 2023 17:59:12 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
Date:   Mon, 28 Aug 2023 17:59:09 +0200
Subject: [PATCH 4/5] drm/bridge: samsung-dsim: adjust porches by rounding
 up
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-samsung-dsim-v1-4-b39716db6b7a@pengutronix.de>
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
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
        kernel@pengutronix.de, Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
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

The porches must be rounded up to make the samsung-dsim work.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 4de6e4f116db..459be953be55 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -974,9 +974,9 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
 		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
-		int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
-		int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
-		int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
+		int hfp = DIV_ROUND_UP((m->hsync_start - m->hdisplay) * byte_clk_khz, m->clock);
+		int hbp = DIV_ROUND_UP((m->htotal - m->hsync_end) * byte_clk_khz, m->clock);
+		int hsa = DIV_ROUND_UP((m->hsync_end - m->hsync_start) * byte_clk_khz, m->clock);
 
 		/* remove packet overhead when possible */
 		hfp = max(hfp - 6, 0);

-- 
2.39.2

