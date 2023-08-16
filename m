Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B577E04F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbjHPL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244522AbjHPLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:25:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55FE2128
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:25:56 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C6E56C85;
        Wed, 16 Aug 2023 13:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692185080;
        bh=TDI9Cw23pqxLneDtSVZkuUlDvO2vp0pomzNNIvZxHCc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QIC7b8wtDQq343JfVZiOv8UxRfxqiA6M0EuMLhsWNfSwXfqqahpHdsyZcry8qP7hS
         y9jxSi+6MHyPmqwyW7wyArU3XOeiGHfRatmEm7eoAShlQOzd+Iv7eRbQK060nRwAUe
         CHfezxMIAu/Sk4j5Sz8pqaG0L57Y7NGcbbhPARoY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 16 Aug 2023 14:25:10 +0300
Subject: [PATCH v2 07/12] drm/bridge: tc358768: Use dev for dbg prints, not
 priv->dev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-tc358768-v2-7-242b9d5f703a@ideasonboard.com>
References: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
In-Reply-To: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6214;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=TDI9Cw23pqxLneDtSVZkuUlDvO2vp0pomzNNIvZxHCc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk3LI2fpKL9jYf8dK7rw0vj9p1eDroE+nPWWrDj
 PAWAMYREriJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZNyyNgAKCRD6PaqMvJYe
 9fN8D/oDH88P+HhDCDxftBnFSrYr4aE4DKD0okCKMz+BXwhy3IkxOK+TiUB+C7TVM29CNbIqNlP
 D00cN4u2SgkKIvSzXCdrAeDRi26JurSJD2GVEJVpKZpd+JgTda0HIsvWg0Ff0HkVDFXCszzsJlw
 GYSnXjKgtPirEZivoY5DuLW1Gzh62sL/z+6swgNxdr26JmT7u4UdQYnzyzCfO7qIb9I7Z4Nk2M+
 lT9QL9Gl2WKz+75allkP37TvS28FVj1/FRXFI06mRsJHUnKNgGkfnJpaGYlVI+zgSErVWwgfIYn
 eMP6/icdh9me+phJypMMGCBUZr1WnT4Iyb3LErwthNznhv3qVSZG7V03mSC5L3Fj2hxD99kthSs
 66RjMa3RZFgXu4iaEa+yqadj1ru9WODPgfRAbnGDfPdcf797wKWgostkp4sVZA/V0CJ0uqAx6bI
 7VvAO15GBQGSKkq9p7K/BzmNkmFP8KcYXh8UCPYV92pR2SWD9jYaNUgfFvdkqoz20ptTtibSw4O
 kADlLNJSb1FbhHqIqUpbZRXeXl+CckgTM5afcy72u8j1Wz4a9WBw1N+eCWOLI3FIN1ousAK+jQw
 PfVqAiiPhh093Ulkh6VmR9yuFcjOSNTgesiw6xwZX+zWtztuPWnz9W2VJzdxDXjHJKVu0+5RkS+
 Yyz7gzH/sGFV91Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by capturing the priv->dev value to dev variable, and
use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 41 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0ef51d04bb21..3266c08d9bf1 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -651,9 +651,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	const u32 internal_delay = 40;
 	int ret, i;
 	struct videomode vm;
+	struct device *dev = priv->dev;
 
 	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
-		dev_warn_once(priv->dev, "Non-continuous mode unimplemented, falling back to continuous\n");
+		dev_warn_once(dev, "Non-continuous mode unimplemented, falling back to continuous\n");
 		mode_flags &= ~MIPI_DSI_CLOCK_NON_CONTINUOUS;
 	}
 
@@ -661,7 +662,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	ret = tc358768_sw_reset(priv);
 	if (ret) {
-		dev_err(priv->dev, "Software reset failed: %d\n", ret);
+		dev_err(dev, "Software reset failed: %d\n", ret);
 		tc358768_hw_disable(priv);
 		return;
 	}
@@ -669,7 +670,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 	ret = tc358768_setup_pll(priv, mode);
 	if (ret) {
-		dev_err(priv->dev, "PLL setup failed: %d\n", ret);
+		dev_err(dev, "PLL setup failed: %d\n", ret);
 		tc358768_hw_disable(priv);
 		return;
 	}
@@ -709,7 +710,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		break;
 	default:
-		dev_err(priv->dev, "Invalid data format (%u)\n",
+		dev_err(dev, "Invalid data format (%u)\n",
 			dsi_dev->format);
 		tc358768_hw_disable(priv);
 		return;
@@ -733,65 +734,65 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 				  dsibclk);
 	dsiclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION, dsiclk);
 	ui_nsk = dsiclk_nsk / 2;
-	dev_dbg(priv->dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
-	dev_dbg(priv->dev, "ui_nsk: %u\n", ui_nsk);
-	dev_dbg(priv->dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
+	dev_dbg(dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
+	dev_dbg(dev, "ui_nsk: %u\n", ui_nsk);
+	dev_dbg(dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
 
 	/* LP11 > 100us for D-PHY Rx Init */
 	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "LINEINITCNT: %u\n", val);
+	dev_dbg(dev, "LINEINITCNT: %u\n", val);
 	tc358768_write(priv, TC358768_LINEINITCNT, val);
 
 	/* LPTimeCnt > 50ns */
 	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
 	lptxcnt = val;
-	dev_dbg(priv->dev, "LPTXTIMECNT: %u\n", val);
+	dev_dbg(dev, "LPTXTIMECNT: %u\n", val);
 	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
 
 	/* 38ns < TCLK_PREPARE < 95ns */
 	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "TCLK_PREPARECNT %u\n", val);
+	dev_dbg(dev, "TCLK_PREPARECNT %u\n", val);
 	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
 	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
 				  dsibclk_nsk) - 2;
-	dev_dbg(priv->dev, "TCLK_ZEROCNT %u\n", val2);
+	dev_dbg(dev, "TCLK_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
 	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
 	val = clamp(raw_val, 0, 127);
-	dev_dbg(priv->dev, "TCLK_TRAILCNT: %u\n", val);
+	dev_dbg(dev, "TCLK_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "THS_PREPARECNT %u\n", val);
+	dev_dbg(dev, "THS_PREPARECNT %u\n", val);
 	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
 	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
 	val2 = clamp(raw_val, 0, 127);
-	dev_dbg(priv->dev, "THS_ZEROCNT %u\n", val2);
+	dev_dbg(dev, "THS_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
 	/* TWAKEUP > 1ms in lptxcnt steps */
 	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
 	val = val / (lptxcnt + 1) - 1;
-	dev_dbg(priv->dev, "TWAKEUP: %u\n", val);
+	dev_dbg(dev, "TWAKEUP: %u\n", val);
 	tc358768_write(priv, TC358768_TWAKEUP, val);
 
 	/* TCLK_POSTCNT > 60ns + 52*UI */
 	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
 				 dsibclk_nsk) - 3;
-	dev_dbg(priv->dev, "TCLK_POSTCNT: %u\n", val);
+	dev_dbg(dev, "TCLK_POSTCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
 	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
 				     dsibclk_nsk) - 4;
 	val = clamp(raw_val, 0, 15);
-	dev_dbg(priv->dev, "THS_TRAILCNT: %u\n", val);
+	dev_dbg(dev, "THS_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
 
 	val = BIT(0);
@@ -805,10 +806,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
-	dev_dbg(priv->dev, "TXTAGOCNT: %u\n", val);
+	dev_dbg(dev, "TXTAGOCNT: %u\n", val);
 	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
 				  dsibclk_nsk) - 2;
-	dev_dbg(priv->dev, "RXTASURECNT: %u\n", val2);
+	dev_dbg(dev, "RXTASURECNT: %u\n", val2);
 	val = val << 16 | val2;
 	tc358768_write(priv, TC358768_BTACNTRL1, val);
 
@@ -902,7 +903,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	ret = tc358768_clear_error(priv);
 	if (ret) {
-		dev_err(priv->dev, "Bridge pre_enable failed: %d\n", ret);
+		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
 		tc358768_bridge_disable(bridge);
 		tc358768_bridge_post_disable(bridge);
 	}

-- 
2.34.1

