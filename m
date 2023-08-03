Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88B376E64D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjHCLDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbjHCLCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:02:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147C73A89
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:02:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BCA46607198;
        Thu,  3 Aug 2023 12:02:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691060552;
        bh=Xw0ZEaJZnUUVzop6jWBNiSdfQOZObWFWliMoyYC7chw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbqNvPN1XTJBra7lLbOaKJo6fVzcfqvVevuuGLM18Ac3OTkrJTpkf7I5ta6xOaxd+
         43tI5yFRGtWStBFQYL+/MWUAsAxCO4bt5R+ws0MDDaRo/J02UZZgq6cLOv/9p0cFt9
         rYt19gpnzmNSlwNrytkcWr6feLCRAlg/Et8O3dvvi4HqTi/eIqfxPgk7k1HmLPMAJH
         crG1yoo4SaCb0YSf3/SndEdg6eZZabqhG/8/lWUG60uQw8IjZ4YYFom8uROH3TcTeh
         JrKzU4JU4IWUTtqhVjBirZzVkOvntljlh5wV4ZNxlqKiaNVdSR+OJ2F3OnRfdZx4pN
         +JFunLhd0qMbg==
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
Subject: [PATCH v9 13/16] drm/mediatek: gamma: Program gamma LUT type for descending or rising
Date:   Thu,  3 Aug 2023 13:02:11 +0200
Message-ID: <20230803110214.163645-14-angelogioacchino.delregno@collabora.com>
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

All of the SoCs that don't have dithering control in the gamma IP
have got a GAMMA_LUT_TYPE bit that tells to the IP if the LUT is
"descending" (bit set) or "rising" (bit cleared): make sure to set
it correctly after programming the LUT.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index fbff9f97b737..d9a70238d524 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -22,6 +22,7 @@
 #define GAMMA_RELAY_MODE				BIT(0)
 #define GAMMA_LUT_EN					BIT(1)
 #define GAMMA_DITHERING					BIT(2)
+#define GAMMA_LUT_TYPE					BIT(2)
 #define DISP_GAMMA_SIZE				0x0030
 #define DISP_GAMMA_SIZE_HSIZE				GENMASK(28, 16)
 #define DISP_GAMMA_SIZE_VSIZE				GENMASK(12, 0)
@@ -86,6 +87,17 @@ unsigned int mtk_gamma_get_lut_size(struct device *dev)
 	return LUT_SIZE_DEFAULT;
 }
 
+static bool mtk_gamma_lut_is_descending(struct drm_color_lut *lut, u32 lut_size)
+{
+	u64 first, last;
+	int last_entry = lut_size - 1;
+
+	first = lut[0].red + lut[0].green + lut[0].blue;
+	last = lut[last_entry].red + lut[last_entry].green + lut[last_entry].blue;
+
+	return !!(first > last);
+}
+
 /*
  * SoCs supporting 12-bits LUTs are using a new register layout that does
  * always support (by HW) both 12-bits and 10-bits LUT but, on those, we
@@ -175,6 +187,14 @@ void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
 		}
 	}
 
+	if (!gamma->data->has_dither) {
+		/* Descending or Rising LUT */
+		if (mtk_gamma_lut_is_descending(lut, gamma->data->lut_size - 1))
+			cfg_val |= FIELD_PREP(GAMMA_LUT_TYPE, 1);
+		else
+			cfg_val &= ~GAMMA_LUT_TYPE;
+	}
+
 	/* Enable the gamma table */
 	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
-- 
2.41.0

