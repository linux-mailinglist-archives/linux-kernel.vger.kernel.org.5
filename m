Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE69756610
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGQOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjGQOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:14:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF96E52
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:14:46 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83D0A660701C;
        Mon, 17 Jul 2023 15:14:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689603285;
        bh=Tr3orzOYDdkQGSYDctxq9UCgUZnNKjA4Jv1f4ePhHyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAlzN98F7xO+Rtfr+7t6XCh2o7uQEWNaBW+SDM2sC8CTiLUEkNWrWetY5H79XzYcd
         09yQ2wjXCSFiipcvxowwky6CwLi+/Njp2lJMzAywsiqgwLL/5H4nJskgOTOzgAvMZZ
         HlQQzrwz8078V5L1rtvUdkyIs4zCDHG7ILgV+WsGdNWaoXoyiO5Vb/o4tQzkLeDMfm
         nBgsOxz3/iXRqwyQ/CxTxZLN391gxLYNENaBTUX95TnnWuOIMCCetxkR/ZX78DAIS5
         p3JB9abSLITqZLXN42+O5W02q/yWPwXrnfBNw/uzG+1/8TwC/Xj33+Jgn0QC/jQ+Eh
         g5XO5YEpAFgoQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v6 02/11] drm/mediatek: dp: Move AUX and panel poweron/off sequence to function
Date:   Mon, 17 Jul 2023 16:14:29 +0200
Message-Id: <20230717141438.274419-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everytime we run bridge detection and/or EDID read we run a poweron
and poweroff sequence for both the AUX and the panel; moreover, this
is also done when enabling the bridge in the .atomic_enable() callback.

Move this power on/off sequence to a new mtk_dp_aux_panel_poweron()
function as to commonize it.
Note that, before this commit, in mtk_dp_bridge_atomic_enable() only
the AUX was getting powered on but the panel was left powered off if
the DP cable wasn't plugged in while now we unconditionally send a D0
request and this is done for two reasons:
 - First, whether this request fails or not, it takes the same time
   and anyway the DP hardware won't produce any error (or, if it
   does, it's ignorable because it won't block further commands)
 - Second, training the link between a sleeping/standby/unpowered
   display makes little sense.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 76 ++++++++++++-------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index c58b775877a3..77da0d002e9f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1251,6 +1251,29 @@ static void mtk_dp_audio_mute(struct mtk_dp *mtk_dp, bool mute)
 			   val[2], AU_TS_CFG_DP_ENC0_P0_MASK);
 }
 
+static void mtk_dp_aux_panel_poweron(struct mtk_dp *mtk_dp, bool pwron)
+{
+	if (pwron) {
+		/* power on aux */
+		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+				   DP_PWR_STATE_BANDGAP_TPLL_LANE,
+				   DP_PWR_STATE_MASK);
+
+		/* power on panel */
+		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D0);
+		usleep_range(2000, 5000);
+	} else {
+		/* power off panel */
+		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D3);
+		usleep_range(2000, 3000);
+
+		/* power off aux */
+		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+				   DP_PWR_STATE_BANDGAP_TPLL,
+				   DP_PWR_STATE_MASK);
+	}
+}
+
 static void mtk_dp_power_enable(struct mtk_dp *mtk_dp)
 {
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
@@ -1941,16 +1964,9 @@ static enum drm_connector_status mtk_dp_bdg_detect(struct drm_bridge *bridge)
 	if (!mtk_dp->train_info.cable_plugged_in)
 		return ret;
 
-	if (!enabled) {
-		/* power on aux */
-		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
-				   DP_PWR_STATE_BANDGAP_TPLL_LANE,
-				   DP_PWR_STATE_MASK);
+	if (!enabled)
+		mtk_dp_aux_panel_poweron(mtk_dp, true);
 
-		/* power on panel */
-		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D0);
-		usleep_range(2000, 5000);
-	}
 	/*
 	 * Some dongles still source HPD when they do not connect to any
 	 * sink device. To avoid this, we need to read the sink count
@@ -1962,16 +1978,8 @@ static enum drm_connector_status mtk_dp_bdg_detect(struct drm_bridge *bridge)
 	if (DP_GET_SINK_COUNT(sink_count))
 		ret = connector_status_connected;
 
-	if (!enabled) {
-		/* power off panel */
-		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D3);
-		usleep_range(2000, 3000);
-
-		/* power off aux */
-		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
-				   DP_PWR_STATE_BANDGAP_TPLL,
-				   DP_PWR_STATE_MASK);
-	}
+	if (!enabled)
+		mtk_dp_aux_panel_poweron(mtk_dp, false);
 
 	return ret;
 }
@@ -1987,15 +1995,7 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge *bridge,
 
 	if (!enabled) {
 		drm_atomic_bridge_chain_pre_enable(bridge, connector->state->state);
-
-		/* power on aux */
-		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
-				   DP_PWR_STATE_BANDGAP_TPLL_LANE,
-				   DP_PWR_STATE_MASK);
-
-		/* power on panel */
-		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D0);
-		usleep_range(2000, 5000);
+		mtk_dp_aux_panel_poweron(mtk_dp, true);
 	}
 
 	new_edid = drm_get_edid(connector, &mtk_dp->aux.ddc);
@@ -2015,15 +2015,7 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge *bridge,
 	}
 
 	if (!enabled) {
-		/* power off panel */
-		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D3);
-		usleep_range(2000, 3000);
-
-		/* power off aux */
-		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
-				   DP_PWR_STATE_BANDGAP_TPLL,
-				   DP_PWR_STATE_MASK);
-
+		mtk_dp_aux_panel_poweron(mtk_dp, false);
 		drm_atomic_bridge_chain_post_disable(bridge, connector->state->state);
 	}
 
@@ -2183,15 +2175,7 @@ static void mtk_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 	}
 
-	/* power on aux */
-	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
-			   DP_PWR_STATE_BANDGAP_TPLL_LANE,
-			   DP_PWR_STATE_MASK);
-
-	if (mtk_dp->train_info.cable_plugged_in) {
-		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER, DP_SET_POWER_D0);
-		usleep_range(2000, 5000);
-	}
+	mtk_dp_aux_panel_poweron(mtk_dp, true);
 
 	/* Training */
 	ret = mtk_dp_training(mtk_dp);
-- 
2.40.1

