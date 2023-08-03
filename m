Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399E676E64C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjHCLDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjHCLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:02:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBE3A87
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:02:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57EFA66071AD;
        Thu,  3 Aug 2023 12:02:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691060552;
        bh=zIuIzaHEwa0qol/Hd+tCNwDoAKXf8h/2l/cB7d8v3GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Po47SfpDrO8QRYfh0Yp8n/3/DG8uV8OPZDWAW5oGlWFlN/OcQldRt9V5K00nt4rBI
         FatYBUomIfPRUid+uc0kq4gd06Tu/s0EZl4KtRdO7BuDEUbL8yvqGM4SDRxlMLcFy8
         XYzqfLAr24pdGftUSjxvLPJ3afUb4I1TZ34PE3auFfrFrAROZ7BYhy9DQIpc1xPsA9
         HSpcyh/fKLfxpSD98o2M9fCHbrU011baabPTI7wnrwxirP9LjkAfdjO6EdLWAv4bjM
         oZS+ueRN48f8iF6IPmkp8/sCj0qhxDEbJk3gAsSSw32YCh5V2Rjy9Au478njkV/Tn7
         9Fgnz3RmIVHyg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v9 12/16] drm/mediatek: gamma: Make sure relay mode is disabled
Date:   Thu,  3 Aug 2023 13:02:10 +0200
Message-ID: <20230803110214.163645-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803110214.163645-1-angelogioacchino.delregno@collabora.com>
References: <20230803110214.163645-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable relay mode at the end of LUT programming to make sure that the
processed image goes through in both DISP_GAMMA and DISP_AAL for gamma
setting.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c   | 3 +++
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index 21b25470e9b7..992dc1424c91 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -122,6 +122,9 @@ void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state)
 		writel(word, (aal->regs + DISP_AAL_GAMMA_LUT) + (i * 4));
 	}
 
+	/* Disable RELAY mode to pass the processed image */
+	cfg_val &= ~AAL_RELAY_MODE;
+
 	writel(cfg_val, aal->regs + DISP_AAL_CFG);
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 7d2f8042ace0..fbff9f97b737 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -19,6 +19,7 @@
 #define DISP_GAMMA_EN				0x0000
 #define GAMMA_EN					BIT(0)
 #define DISP_GAMMA_CFG				0x0020
+#define GAMMA_RELAY_MODE				BIT(0)
 #define GAMMA_LUT_EN					BIT(1)
 #define GAMMA_DITHERING					BIT(2)
 #define DISP_GAMMA_SIZE				0x0030
@@ -177,6 +178,9 @@ void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
 	/* Enable the gamma table */
 	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
+	/* Disable RELAY mode to pass the processed image */
+	cfg_val &= ~GAMMA_RELAY_MODE;
+
 	writel(cfg_val, gamma->regs + DISP_GAMMA_CFG);
 }
 
-- 
2.41.0

