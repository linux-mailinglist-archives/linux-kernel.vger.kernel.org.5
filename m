Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9067762FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGZIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjGZIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:32:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0576E8B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:22:57 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EAE1660711A;
        Wed, 26 Jul 2023 09:22:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690359776;
        bh=p6gmZfJJo8EhnnnFpNEwiof9/9yla+KEGH6T0UfImeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFzM3ofVtCf3lqUx6TyEtDxvrDjQcrVvPw3NPZzcI7jzYrcyucGXQElJit6uImsM+
         fSNPAXzX7C8V4mWzssLCkHbOI/Ag7x6v5C931ccXJWeMGMvq4ge9pWTDEZ8dYAp1m6
         0BVIeXg5mCOiG0xZfLmYvb1tVHN4w/EId0TdwEkj+DUcxWzd5Gwlw2xcxSxyioInz6
         f6vdN41NhZQnlXvjf+yGps0jMonwEVMEbYn9LGUesIgzPmNg4OrTIhf2mnbRJY3He8
         BPQ4sFnl3DYSLkAI/9rWp+QaHB8YouQ0Uw12lOnhbUxt4OkWp/2TGNzvmgJxe1gEue
         aMa4E8uBw+p9A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        fshao@chromium.org, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v3 2/6] drm/mediatek: mtk_dpi: Simplify with dev_err_probe()
Date:   Wed, 26 Jul 2023 10:22:41 +0200
Message-ID: <20230726082245.550929-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726082245.550929-1-angelogioacchino.delregno@collabora.com>
References: <20230726082245.550929-1-angelogioacchino.delregno@collabora.com>
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

Use dev_err_probe() across the entire probe function of this driver
to shrink the size.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 44 ++++++++++--------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index e4ee0d02893a..fdd5b7126e27 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1039,38 +1039,24 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	}
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dpi->regs = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(dpi->regs)) {
-		ret = PTR_ERR(dpi->regs);
-		dev_err(dev, "Failed to ioremap mem resource: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dpi->regs))
+		return dev_err_probe(dev, PTR_ERR(dpi->regs),
+				     "Failed to ioremap mem resource\n");
 
 	dpi->engine_clk = devm_clk_get(dev, "engine");
-	if (IS_ERR(dpi->engine_clk)) {
-		ret = PTR_ERR(dpi->engine_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get engine clock: %d\n", ret);
-
-		return ret;
-	}
+	if (IS_ERR(dpi->engine_clk))
+		return dev_err_probe(dev, PTR_ERR(dpi->engine_clk),
+				     "Failed to get engine clock\n");
 
 	dpi->pixel_clk = devm_clk_get(dev, "pixel");
-	if (IS_ERR(dpi->pixel_clk)) {
-		ret = PTR_ERR(dpi->pixel_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get pixel clock: %d\n", ret);
-
-		return ret;
-	}
+	if (IS_ERR(dpi->pixel_clk))
+		return dev_err_probe(dev, PTR_ERR(dpi->pixel_clk),
+				     "Failed to get pixel clock\n");
 
 	dpi->tvd_clk = devm_clk_get(dev, "pll");
-	if (IS_ERR(dpi->tvd_clk)) {
-		ret = PTR_ERR(dpi->tvd_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get tvdpll clock: %d\n", ret);
-
-		return ret;
-	}
+	if (IS_ERR(dpi->tvd_clk))
+		return dev_err_probe(dev, PTR_ERR(dpi->tvd_clk),
+				     "Failed to get tvdpll clock\n");
 
 	dpi->irq = platform_get_irq(pdev, 0);
 	if (dpi->irq <= 0)
@@ -1094,10 +1080,8 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = component_add(dev, &mtk_dpi_component_ops);
-	if (ret) {
-		dev_err(dev, "Failed to add component: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add component.\n");
 
 	return 0;
 }
-- 
2.41.0

