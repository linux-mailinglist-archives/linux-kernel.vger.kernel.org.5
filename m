Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06677BBB47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJFPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjJFPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:07:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC25CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:07:16 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1qomPy-00051v-2n; Fri, 06 Oct 2023 17:07:06 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
Date:   Fri, 06 Oct 2023 17:07:03 +0200
Subject: [PATCH v2 1/5] drm/bridge: samsung-dsim: add more mipi-dsi device
 debug information
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-samsung-dsim-v2-1-846603df0e0a@pengutronix.de>
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
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
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

From: Marco Felsch <m.felsch@pengutronix.de>

Since the MIPI configuration can be changed on demand it is very useful
to print more MIPI settings during the MIPI device attach step.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
Reviewed-by: Inki Dae <inki.dae@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM + Waveshare 10.1inch HDMI LCD (E)
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

---
Changes in v2: None
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index cf777bdb25d2..3e8ee9d73a72 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1712,7 +1712,10 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 		return ret;
 	}
 
-	DRM_DEV_INFO(dev, "Attached %s device\n", device->name);
+	DRM_DEV_INFO(dev, "Attached %s device (lanes:%d bpp:%d mode-flags:0x%lx)\n",
+		     device->name, device->lanes,
+		     mipi_dsi_pixel_format_to_bpp(device->format),
+		     device->mode_flags);
 
 	drm_bridge_add(&dsi->bridge);
 

-- 
2.39.2

