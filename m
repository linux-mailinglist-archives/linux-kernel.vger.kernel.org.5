Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F947C6A34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbjJLJ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjJLJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:57:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA589C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:55 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F24B660735D;
        Thu, 12 Oct 2023 10:57:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697104674;
        bh=gUWo3dRRaH++g0myacHkp7Vdu/naNGAgWJ0AG8LeCwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+R5v+WP/rjQf/596VINkvDzEj3wACEIOVKJ2m3YCyFG4JpySZxkrPqMxJjhy7X9H
         5XS2xnUPZgpX3nan9lVtgepFWBT3TPoIWq6OAVEs67m0f/XG+E50YqVLqEO5vZ59EE
         qJOvnWbcQMI0w1ou9eKNsFM3ZeSB0iUmra8hhUH9+bkXGSXH1lQD53u1fOrLjA1GHW
         rnSAC4ubzWSUh8oubz7Ckuj2t249HCdAmDwtnC+jFZS8dbhZDix7dk6aVHXE9+uOyB
         LFuO5UGr6b3xB4pj9K7wMxcK0A8IaN+38V7GnBdkEJJEnamhvyCd2yuk37eiXQodOR
         viVgRger7qUPg==
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
Subject: [PATCH v11 12/16] drm/mediatek: gamma: Make sure relay mode is disabled
Date:   Thu, 12 Oct 2023 11:57:32 +0200
Message-ID: <20231012095736.100784-13-angelogioacchino.delregno@collabora.com>
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

Disable relay mode at the end of LUT programming to make sure that the
processed image goes through in both DISP_GAMMA and DISP_AAL for gamma
setting.

Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c   | 4 ++++
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index a618be9b3dba..15f91cea9f20 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -18,6 +18,7 @@
 #define DISP_AAL_EN				0x0000
 #define AAL_EN						BIT(0)
 #define DISP_AAL_CFG				0x0020
+#define AAL_RELAY_MODE					BIT(0)
 #define AAL_GAMMA_LUT_EN				BIT(1)
 #define DISP_AAL_SIZE				0x0030
 #define DISP_AAL_SIZE_HSIZE				GENMASK(28, 16)
@@ -119,6 +120,9 @@ void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state)
 	/* Enable the gamma table */
 	cfg_val |= FIELD_PREP(AAL_GAMMA_LUT_EN, 1);
 
+	/* Disable RELAY mode to pass the processed image */
+	cfg_val &= ~AAL_RELAY_MODE;
+
 	writel(cfg_val, aal->regs + DISP_AAL_CFG);
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index bcc33aeca885..6746033615db 100644
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
@@ -175,6 +176,9 @@ void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
 	/* Enable the gamma table */
 	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
+	/* Disable RELAY mode to pass the processed image */
+	cfg_val &= ~GAMMA_RELAY_MODE;
+
 	writel(cfg_val, gamma->regs + DISP_GAMMA_CFG);
 }
 
-- 
2.42.0

