Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315B75661D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGQOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjGQOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:14:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4926D1A3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:14:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 61E4B6607073;
        Mon, 17 Jul 2023 15:14:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689603292;
        bh=0hGL/8LzIM49OnwR70sh4p7tQJGg8O110NQk4ZNHwd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlRzY3+6MjLfPwDht+YhnrAPXd0qTP00SI/ZJs2PVH+7PXopK2VH41JfJu/yqRZzu
         1Ad1vWTsiHqOmy6zhyDLWO8WjlCbsKGY17jGmGS0bHQoxHh39rf0h4m4FeM7IVnRDD
         lgT1dksa5r6wqTpQRKJgmBNx3ayp554dNJaNO/vOzkzxmU1PoUrcQ5tiY4eeT5bXoD
         ara+vDSZng/mTtHOJlayeZYvGC5N0B7orm+01qASJttnJhBEVx2olZWnK50jk4J5Oc
         IDRIykJmehSe7uMioWTLaO7qRrCPrJ77MGrt3c5K4EIYzjL4pHhI8zC0bWJFLrHMwA
         9RY0AWrj3uhTg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v6 10/11] drm/mediatek: dp: Add .wait_hpd_asserted() for AUX bus
Date:   Mon, 17 Jul 2023 16:14:37 +0200
Message-Id: <20230717141438.274419-11-angelogioacchino.delregno@collabora.com>
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

In order to support usecases in which the panel regulator can be
switched on and off to save power, and usecases in which the panel
regulator is off at boot, add a .wait_hpd_asserted() callback for
the AUX bus: this will make sure to wait until the panel is fully
ready after power-on before trying to communicate with it.

Also, parse the eDP display capabilities in that callback, so that
we can also avoid using the .get_edid() callback from this bridge.

Since at this point the hpd machinery is performed in the new hpd
callback and the detection and edid reading are done outside of
this driver, assign the DRM_BRIDGE_OP_{DETECT, EDID, HPD} ops and
register the bridge unconditionally at probe time only if we are
probing full DisplayPort and not eDP while, for the latter, we
register the bridge in the .done_probing() callback and only if
the panel was found and triggered HPD.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 45 ++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index acdd457b5449..e74295ba9707 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1920,6 +1920,31 @@ static irqreturn_t mtk_dp_hpd_event(int hpd, void *dev)
 	return IRQ_WAKE_THREAD;
 }
 
+static int mtk_dp_wait_hpd_asserted(struct drm_dp_aux *mtk_aux, unsigned long wait_us)
+{
+	struct mtk_dp *mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
+	u32 val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(mtk_dp->regs, MTK_DP_TRANS_P0_3414,
+				       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
+				       wait_us / 100, wait_us);
+	if (ret) {
+		mtk_dp->train_info.cable_plugged_in = false;
+		return ret;
+	}
+
+	mtk_dp->train_info.cable_plugged_in = true;
+
+	ret = mtk_dp_parse_capabilities(mtk_dp);
+	if (ret) {
+		drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mtk_dp_dt_parse(struct mtk_dp *mtk_dp,
 			   struct platform_device *pdev)
 {
@@ -2532,6 +2557,12 @@ static int mtk_dp_edp_link_panel(struct drm_dp_aux *mtk_aux)
 		mtk_dp->next_bridge = NULL;
 		return ret;
 	}
+
+	/* For eDP, we add the bridge only if the panel was found */
+	ret = devm_drm_bridge_add(dev, &mtk_dp->bridge);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2568,6 +2599,7 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	mtk_dp->aux.name = "aux_mtk_dp";
 	mtk_dp->aux.dev = dev;
 	mtk_dp->aux.transfer = mtk_dp_aux_transfer;
+	mtk_dp->aux.wait_hpd_asserted = mtk_dp_wait_hpd_asserted;
 	drm_dp_aux_init(&mtk_dp->aux);
 
 	spin_lock_init(&mtk_dp->irq_thread_lock);
@@ -2600,15 +2632,8 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	mtk_dp->bridge.funcs = &mtk_dp_bridge_funcs;
 	mtk_dp->bridge.of_node = dev->of_node;
-
-	mtk_dp->bridge.ops =
-		DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
 	mtk_dp->bridge.type = mtk_dp->data->bridge_type;
 
-	ret = devm_drm_bridge_add(dev, &mtk_dp->bridge);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add bridge\n");
-
 	mtk_dp->need_debounce = true;
 	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
 
@@ -2647,6 +2672,12 @@ static int mtk_dp_probe(struct platform_device *pdev)
 				return ret;
 			}
 		}
+	} else {
+		mtk_dp->bridge.ops = DRM_BRIDGE_OP_DETECT |
+				     DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
+		ret = devm_drm_bridge_add(dev, &mtk_dp->bridge);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to add bridge\n");
 	}
 
 	pm_runtime_enable(dev);
-- 
2.40.1

