Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB4762FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjGZIcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjGZIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:32:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209283E7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:22:56 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8B916607118;
        Wed, 26 Jul 2023 09:22:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690359775;
        bh=Q3C1A1/WPCB7GbI1qxZ2/JfxdcuHFERjBQhqhmiBaJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W30kAM9VjbsptC4LXUxcchKuSEOJnLC9ADzIMueGjuYiDFH+AOvz3ncVSpl9zL3e8
         wz5SeJfGapt4RQccVkA43tD9ddC7rrfeTfAMHJhkqu7t7F/2HriKC/D5DZGdCgP122
         eVuiFWhc/EXAsiHVQtbnCpqTW+2vwr2j9oke+HkTviebSi5NWXBEUwYogLNBaThS8T
         5GZJ0NVWdx8b/AHBtAYlJXenJAZEbd9msG0v+OOcjRaFRGeKBYCNk5IAsixxtPi5TD
         64iZqYNm0Uvm2fkjGZxmf9Lw5vynEbYxXO1bqw54ix7LRZw9F27r2UmqLJWYS17dND
         oxL1pkItFLJCw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        fshao@chromium.org
Subject: [PATCH v3 1/6] drm/mediatek: mtk_dpi: Simplify with devm_drm_bridge_add()
Date:   Wed, 26 Jul 2023 10:22:40 +0200
Message-ID: <20230726082245.550929-2-angelogioacchino.delregno@collabora.com>
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

Change drm_bridge_add() to its devm variant to slightly simplify the
probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 28bdb1f427ff..e4ee0d02893a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1089,11 +1089,12 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	dpi->bridge.of_node = dev->of_node;
 	dpi->bridge.type = DRM_MODE_CONNECTOR_DPI;
 
-	drm_bridge_add(&dpi->bridge);
+	ret = devm_drm_bridge_add(dev, &dpi->bridge);
+	if (ret)
+		return ret;
 
 	ret = component_add(dev, &mtk_dpi_component_ops);
 	if (ret) {
-		drm_bridge_remove(&dpi->bridge);
 		dev_err(dev, "Failed to add component: %d\n", ret);
 		return ret;
 	}
@@ -1103,10 +1104,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 
 static int mtk_dpi_remove(struct platform_device *pdev)
 {
-	struct mtk_dpi *dpi = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &mtk_dpi_component_ops);
-	drm_bridge_remove(&dpi->bridge);
 
 	return 0;
 }
-- 
2.41.0

