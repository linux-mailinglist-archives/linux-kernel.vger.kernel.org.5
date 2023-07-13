Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12967751C98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjGMJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjGMJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:02:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4C30DB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:02:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE1BA6607053;
        Thu, 13 Jul 2023 10:02:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689238925;
        bh=PYI+JO0rcW6CSRRbNcpz6yRrOkgaYF52PNv7n+IILpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgTrLr24tt4w4iFcdSNtVdIvgUTd67OCB6msx2c79XtbBOdfx0XiW8Zkr76Hn8AHa
         kEdqTpiIbrL8dyKWaUzt6R4+Utwa+MGXoRf/89rhMAtt7Bhl9EAv6Luey9FxM9+qxh
         AqSQ485AkuePxcUVdqXOKKqYWgvQhFbYNK64SGwbajLRGPXB3yjeRmqGdT626BAfPr
         v6gqCpApDnjKskxUvfTfDc+VTLs7ZYz8W/4K/aNoYSyfjiILAG8QHi0gOcf7fhO3SH
         ZfMCUTwBakK8yzQn1MB3M/7+w/uuGTyiJEZk3CrHFIFvbfSlDLBHWv7UkWUwq8tUbs
         Yr5onWlPj3Gxw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v5 09/10] drm/mediatek: dp: Add .wait_hpd_asserted() for AUX bus
Date:   Thu, 13 Jul 2023 11:01:51 +0200
Message-Id: <20230713090152.140060-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
References: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
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
this driver, assign the DRM_BRIDGE_OP_{DETECT, EDID, HPD} ops only
if we're probing full DisplayPort and not eDP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 8668ab17135d..a00bf6693b28 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1915,6 +1915,29 @@ static irqreturn_t mtk_dp_hpd_event(int hpd, void *dev)
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
+	if (ret)
+		return ret;
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
@@ -2564,6 +2587,7 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	mtk_dp->aux.name = "aux_mtk_dp";
 	mtk_dp->aux.dev = dev;
 	mtk_dp->aux.transfer = mtk_dp_aux_transfer;
+	mtk_dp->aux.wait_hpd_asserted = mtk_dp_wait_hpd_asserted;
 	drm_dp_aux_init(&mtk_dp->aux);
 
 	spin_lock_init(&mtk_dp->irq_thread_lock);
@@ -2596,11 +2620,12 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	mtk_dp->bridge.funcs = &mtk_dp_bridge_funcs;
 	mtk_dp->bridge.of_node = dev->of_node;
-
-	mtk_dp->bridge.ops =
-		DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
 	mtk_dp->bridge.type = mtk_dp->data->bridge_type;
 
+	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP)
+		mtk_dp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
+				     DRM_BRIDGE_OP_HPD;
+
 	devm_drm_bridge_add(dev, &mtk_dp->bridge);
 
 	mtk_dp->need_debounce = true;
-- 
2.40.1

