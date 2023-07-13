Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8EE751C97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGMJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjGMJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:02:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17D30CF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:02:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4EABC660704F;
        Thu, 13 Jul 2023 10:02:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689238923;
        bh=oUG5aPaVBnW7KO4J0dba3zD9FKxTpXnDZG8M5YcNwZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftG98zWooBfgVkTl+Rwu+dA7zVnxNicgEdq+2rSPXlR0xsn1NqsDKdfjasQXUmQDW
         ITeG0MAIQz7HjFURNJEffnV6HDXIx0C5aqnVk6QfYcqLM2muS1uN91DixjvtD9f0s8
         +5QZau7CRDMkJzPLO9tne1VIeJAuf4zpQlEGpAz3QYMPAVa6118Ar7PwItniPkCkuq
         o82x1v7uQDT7OdY2Aef0YSZNZzU1iNAmLPTV1HLI6LvnJpJxYGstvhBP0ap+f3fD9M
         mNJnLsNF5tlNkqS+KgC+U3eXC+6SwcV96mtc9wxcHPljL68/wO8VqAeuQVV8k7xMqr
         LYgTzhwPWAQ6g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v5 07/10] drm/mediatek: dp: Move PHY registration to new function
Date:   Thu, 13 Jul 2023 11:01:49 +0200
Message-Id: <20230713090152.140060-8-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for eDP, move the PHY registration
code to a new mtk_dp_register_phy() function for better readability.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 43 +++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 3cb234b502a5..1684dbf7bbff 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2473,6 +2473,29 @@ static int mtk_dp_register_audio_driver(struct device *dev)
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
@@ -2531,23 +2554,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
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
2.40.1

