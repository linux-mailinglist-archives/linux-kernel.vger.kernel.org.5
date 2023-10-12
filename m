Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0618B7C6A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjJLJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjJLJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:57:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271BC6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:49 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E59D8660734F;
        Thu, 12 Oct 2023 10:57:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697104668;
        bh=g6E3fxIKPvoRIxYyIalEHPKr1wjXJhcLHDzCWD7sXOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYh9fZlTwwRKh3f6ncbNjdAC/jYP0MWda5uZ0nMhrxw0dArORyQag1Ilav+3niuG1
         xInX4fJ9T9R/ym2IVFew3VG64f0M/eNJRjW9ryCYXWRxoo9JUsSO8HUL64BJaKsrPe
         YmEo+52PHwoonILQp93VLCZc8tzNN8C3QdkPdxZLCAVi91ohFFRKY4zgpZGZW9SR5M
         QufsK2nWYPocxGKMX3dxU+K5HraqXgOtGWYw3fTjsErXzyMz51zU8qgRd/5MbqD5t2
         /BMxOgNXJXJBpf0SWxyhqA3/NGh9zpHikjCbxAjl38Qz7eD0LRkTl+kzKpE9/VQHnw
         FBCsXiv18DZMQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        nfraprado@collabora.com,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v11 06/16] drm/mediatek: gamma: Use bitfield macros
Date:   Thu, 12 Oct 2023 11:57:26 +0200
Message-ID: <20231012095736.100784-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
References: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more robust and improve readability by using bitfield
macros instead of open coding bit operations.
While at it, also add a definition for LUT_BITS_DEFAULT.

Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 28 +++++++++++++++--------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index d35eaf6dbc2d..81c04518a5eb 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021 MediaTek Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/module.h>
@@ -21,8 +22,14 @@
 #define GAMMA_LUT_EN					BIT(1)
 #define GAMMA_DITHERING					BIT(2)
 #define DISP_GAMMA_SIZE				0x0030
+#define DISP_GAMMA_SIZE_HSIZE				GENMASK(28, 16)
+#define DISP_GAMMA_SIZE_VSIZE				GENMASK(12, 0)
 #define DISP_GAMMA_LUT				0x0700
 
+#define DISP_GAMMA_LUT_10BIT_R			GENMASK(29, 20)
+#define DISP_GAMMA_LUT_10BIT_G			GENMASK(19, 10)
+#define DISP_GAMMA_LUT_10BIT_B			GENMASK(9, 0)
+
 struct mtk_disp_gamma_data {
 	bool has_dither;
 	bool lut_diff;
@@ -97,9 +104,9 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 		hwlut.blue = drm_color_lut_extract(lut[i].blue, 10);
 
 		if (!lut_diff || (i % 2 == 0)) {
-			word = hwlut.red << 20 +
-			       hwlut.green << 10 +
-			       hwlut.red;
+			word = FIELD_PREP(DISP_GAMMA_LUT_10BIT_R, hwlut.red);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_G, hwlut.green);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_B, hwlut.blue);
 		} else {
 			diff.red = lut[i].red - lut[i - 1].red;
 			diff.red = drm_color_lut_extract(diff.red, 10);
@@ -110,9 +117,9 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 			diff.blue = lut[i].blue - lut[i - 1].blue;
 			diff.blue = drm_color_lut_extract(diff.blue, 10);
 
-			word = diff.blue << 20 +
-			       diff.green << 10 +
-			       diff.red;
+			word = FIELD_PREP(DISP_GAMMA_LUT_10BIT_R, diff.red);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_G, diff.green);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_B, diff.blue);
 		}
 		writel(word, (lut_base + i * 4));
 	}
@@ -120,7 +127,7 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	cfg_val = readl(regs + DISP_GAMMA_CFG);
 
 	/* Enable the gamma table */
-	cfg_val |= GAMMA_LUT_EN;
+	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
 	writel(cfg_val, regs + DISP_GAMMA_CFG);
 }
@@ -137,9 +144,12 @@ void mtk_gamma_config(struct device *dev, unsigned int w,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
 	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+	u32 sz;
+
+	sz = FIELD_PREP(DISP_GAMMA_SIZE_HSIZE, w);
+	sz |= FIELD_PREP(DISP_GAMMA_SIZE_VSIZE, h);
 
-	mtk_ddp_write(cmdq_pkt, h << 16 | w, &gamma->cmdq_reg, gamma->regs,
-		      DISP_GAMMA_SIZE);
+	mtk_ddp_write(cmdq_pkt, sz, &gamma->cmdq_reg, gamma->regs, DISP_GAMMA_SIZE);
 	if (gamma->data && gamma->data->has_dither)
 		mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc,
 				      DISP_GAMMA_CFG, GAMMA_DITHERING, cmdq_pkt);
-- 
2.42.0

