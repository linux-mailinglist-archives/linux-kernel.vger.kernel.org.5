Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C767C6A28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjJLJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjJLJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:57:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2FBA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:48 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC1936607348;
        Thu, 12 Oct 2023 10:57:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697104667;
        bh=KlnYZ3Z57VDCZfFhh+UwghQixUf4esaXMSIcKtMmbP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKp2dFfcKA81iQpEHXop2fX8jb8z7V6zWCI/pxHB1i+MPu7aZDpZQsMmPRIxBKNIY
         BMRf93lxL4E8SlXyWN/Zdskdm6LoPIPzNll1PvMmc0/k3R53YAHDUhh9n+QLEmQpEJ
         Blu5Hd4YrBFU/ZThera+ThxnzCaHsmOHhG5itg2D/yxV4ekJaXljmLPzZT8HE2icJ3
         SR2QubIkiNf9LAHV1vEL7lFWA6xbV+G3bb7lBdwna1+xLuyYzZK+5J9lxK+AXCLE4R
         P1VT3doy57/Im7owYFfhR+0umDDTCf3W9wDDFZ1pVEH7wWMIjO8IPN6o/FBGd2CAAz
         sluN5SOMzNOCQ==
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
        Alexandre Mergnat <amergnat@baylibre.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v11 05/16] drm/mediatek: gamma: Enable the Gamma LUT table only after programming
Date:   Thu, 12 Oct 2023 11:57:25 +0200
Message-ID: <20231012095736.100784-6-angelogioacchino.delregno@collabora.com>
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

Move the write to DISP_GAMMA_CFG to enable the Gamma LUT to after
programming the actual table to avoid potential visual glitches during
table modification.

Note:
GAMMA should get enabled in between vblanks, but this requires many
efforts in order to make this happen, as that requires migrating all
of the writes to make use of CMDQ instead of cpu writes and that's
not trivial. For this reason, this patch only moves the LUT enable.
The CMDQ rework will come at a later time.

Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 8506b9a0a811..d35eaf6dbc2d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -65,12 +65,12 @@ unsigned int mtk_gamma_get_lut_size(struct device *dev)
 void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crtc_state *state)
 {
 	struct mtk_disp_gamma *gamma;
-	unsigned int i, reg;
+	unsigned int i;
 	struct drm_color_lut *lut;
 	void __iomem *lut_base;
 	bool lut_diff;
 	u16 lut_size;
-	u32 word;
+	u32 cfg_val, word;
 
 	/* If there's no gamma lut there's nothing to do here. */
 	if (!state->gamma_lut)
@@ -87,9 +87,6 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 		lut_size = 512;
 	}
 
-	reg = readl(regs + DISP_GAMMA_CFG);
-	reg = reg | GAMMA_LUT_EN;
-	writel(reg, regs + DISP_GAMMA_CFG);
 	lut_base = regs + DISP_GAMMA_LUT;
 	lut = (struct drm_color_lut *)state->gamma_lut->data;
 	for (i = 0; i < lut_size; i++) {
@@ -119,6 +116,13 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 		}
 		writel(word, (lut_base + i * 4));
 	}
+
+	cfg_val = readl(regs + DISP_GAMMA_CFG);
+
+	/* Enable the gamma table */
+	cfg_val |= GAMMA_LUT_EN;
+
+	writel(cfg_val, regs + DISP_GAMMA_CFG);
 }
 
 void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
-- 
2.42.0

