Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5B760BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjGYHfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGYHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:34:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5947A1BFD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:32:55 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F5526607114;
        Tue, 25 Jul 2023 08:32:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690270374;
        bh=DR/G12pe4yglh3RcpLL0KLQLNBPShOVl9PCUQ7J4/Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ek3/7nOuynkGeshEIIpPIWjcnB7Gyvspt1najiSjv7jbsHZkmWg32O6pMn3eAYa45
         0kjKXhuSton6Pblpu4M0Xn2XV1hjR7lRNGx5okExSn6bxjcyenGwdwKWLg5YVi4hJ8
         E+sy8oJ8YYyoWxD86nda6/VkTJAJVzAUfcUKnLFtQ5zlhb45D9RAfBjITnMlLfr+HW
         d69sz+N+Vo55k64SmbMZrpvOeKFuUrBu7+M2f76HW7YTszA5vC/rJ4pvhm5HRSkB85
         3fdtsN2V0Fky8cY43mARZix+RU46FIr4B9bMmWLfyC81NcGGjwFB4LWbx5xvwWTd6J
         dSxRTfvWnU1dA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com,
        ehristev@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v7 08/11] drm/mediatek: dp: Move PHY registration to new function
Date:   Tue, 25 Jul 2023 09:32:31 +0200
Message-ID: <20230725073234.55892-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725073234.55892-1-angelogioacchino.delregno@collabora.com>
References: <20230725073234.55892-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for eDP, move the PHY registration
code to a new mtk_dp_register_phy() function for better readability.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 43 +++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index c1d1a882f1db..1b4219e6a00b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2478,6 +2478,29 @@ static int mtk_dp_register_audio_driver(struct device *dev)
 	return PTR_ERR_OR_ZERO(mtk_dp->audio_pdev);
 }
 
+static int mtk_dp_register_phy(struct mtk_dp *mtk_dp)
+{
+	struct device *dev = mtk_dp->dev;
+
+	mtk_dp->phy_dev = platform_device_register_data(dev, "mediatek-dp-phy",
+							PLATFORM_DEVID_AUTO,
+							&mtk_dp->regs,
+							sizeof(struct regmap *));
+	if (IS_ERR(mtk_dp->phy_dev))
+		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
+				     "Failed to create device mediatek-dp-phy\n");
+
+	mtk_dp_get_calibration_data(mtk_dp);
+
+	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
+	if (IS_ERR(mtk_dp->phy)) {
+		platform_device_unregister(mtk_dp->phy_dev);
+		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy), "Failed to get phy\n");
+	}
+
+	return 0;
+}
+
 static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
@@ -2536,23 +2559,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		}
 	}
 
-	mtk_dp->phy_dev = platform_device_register_data(dev, "mediatek-dp-phy",
-							PLATFORM_DEVID_AUTO,
-							&mtk_dp->regs,
-							sizeof(struct regmap *));
-	if (IS_ERR(mtk_dp->phy_dev))
-		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
-				     "Failed to create device mediatek-dp-phy\n");
-
-	mtk_dp_get_calibration_data(mtk_dp);
-
-	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
-
-	if (IS_ERR(mtk_dp->phy)) {
-		platform_device_unregister(mtk_dp->phy_dev);
-		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy),
-				     "Failed to get phy\n");
-	}
+	ret = mtk_dp_register_phy(mtk_dp);
+	if (ret)
+		return ret;
 
 	mtk_dp->bridge.funcs = &mtk_dp_bridge_funcs;
 	mtk_dp->bridge.of_node = dev->of_node;
-- 
2.41.0

