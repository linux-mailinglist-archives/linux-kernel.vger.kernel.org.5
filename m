Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD27C6A20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjJLJ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjJLJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:57:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB583B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:47 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFAAD660734B;
        Thu, 12 Oct 2023 10:57:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697104666;
        bh=skAu7ZS20gD3ZXT+OV72kM7TJ+5GEtjNjK2WnVYj0aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtX10vzIdQ7pXXAttUPQR1RzBhy9peMo6gqfWewec4zrCLJErj7h8pfOfmFBNAiiZ
         LCBST07K7i4jzbnmXB+poEcJnyzwit8b8XIfmM9yLL+sL2Bt7O+2f/H+/2BrEhUgrq
         Avf3BJkgViZ+0upe7ibFiavIsUqPYOV+bPh6+2lrRvLbZgraJhRqlE+PZ7j49Cz3tB
         zkGcPQpNSPzkFk07yk6nG9ABQTHSVkHFIBOhhGkHpwFQxI2sTG3JQ9XboZ1iWTTMVU
         M26P/Q3GjTQNMU6+gVdbu5Wce+5IGBDZn6Q19Mv1KY6SUmkOKtg6rCuyzQ/KvbM/ke
         EQuWG+sRvFVBw==
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
Subject: [PATCH v11 04/16] drm/mediatek: gamma: Improve and simplify HW LUT calculation
Date:   Thu, 12 Oct 2023 11:57:24 +0200
Message-ID: <20231012095736.100784-5-angelogioacchino.delregno@collabora.com>
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

Use drm_color_lut_extract() to avoid open-coding the bits reduction
calculations for each color channel and use a struct drm_color_lut
to temporarily store the information instead of an array of u32.

Also, slightly improve the precision of the HW LUT calculation in the
LUT DIFF case by performing the subtractions on the 16-bits values and
doing the 10 bits conversion later.

Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 32 ++++++++++++++---------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index bb237523d4b7..8506b9a0a811 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -23,8 +23,6 @@
 #define DISP_GAMMA_SIZE				0x0030
 #define DISP_GAMMA_LUT				0x0700
 
-#define LUT_10BIT_MASK				0x03ff
-
 struct mtk_disp_gamma_data {
 	bool has_dither;
 	bool lut_diff;
@@ -73,7 +71,6 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	bool lut_diff;
 	u16 lut_size;
 	u32 word;
-	u32 diff[3] = {0};
 
 	/* If there's no gamma lut there's nothing to do here. */
 	if (!state->gamma_lut)
@@ -96,18 +93,29 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	lut_base = regs + DISP_GAMMA_LUT;
 	lut = (struct drm_color_lut *)state->gamma_lut->data;
 	for (i = 0; i < lut_size; i++) {
+		struct drm_color_lut diff, hwlut;
+
+		hwlut.red = drm_color_lut_extract(lut[i].red, 10);
+		hwlut.green = drm_color_lut_extract(lut[i].green, 10);
+		hwlut.blue = drm_color_lut_extract(lut[i].blue, 10);
+
 		if (!lut_diff || (i % 2 == 0)) {
-			word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
-				(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
-				((lut[i].blue >> 6) & LUT_10BIT_MASK);
+			word = hwlut.red << 20 +
+			       hwlut.green << 10 +
+			       hwlut.red;
 		} else {
-			diff[0] = (lut[i].red >> 6) - (lut[i - 1].red >> 6);
-			diff[1] = (lut[i].green >> 6) - (lut[i - 1].green >> 6);
-			diff[2] = (lut[i].blue >> 6) - (lut[i - 1].blue >> 6);
+			diff.red = lut[i].red - lut[i - 1].red;
+			diff.red = drm_color_lut_extract(diff.red, 10);
+
+			diff.green = lut[i].green - lut[i - 1].green;
+			diff.green = drm_color_lut_extract(diff.green, 10);
+
+			diff.blue = lut[i].blue - lut[i - 1].blue;
+			diff.blue = drm_color_lut_extract(diff.blue, 10);
 
-			word = ((diff[0] & LUT_10BIT_MASK) << 20) +
-				((diff[1] & LUT_10BIT_MASK) << 10) +
-				(diff[2] & LUT_10BIT_MASK);
+			word = diff.blue << 20 +
+			       diff.green << 10 +
+			       diff.red;
 		}
 		writel(word, (lut_base + i * 4));
 	}
-- 
2.42.0

