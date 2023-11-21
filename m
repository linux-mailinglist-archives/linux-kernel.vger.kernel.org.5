Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA067F2DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjKUMvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjKUMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:51:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF07D6F;
        Tue, 21 Nov 2023 04:51:02 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D19F1660731B;
        Tue, 21 Nov 2023 12:51:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571061;
        bh=hkZjJ7q8rV2xyxskAur6iNWuCHUO3iI4tzSStjxhlcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SthxPow9/ahxFz0vHixuSB05ua6d4W5wCR6J0gY3Y9QvjktSEMkOeSpDKOnkTZ/uJ
         VFxM4sRCZgCzDf+icOWp8HwnK/GFqMVGoogbelMg2UWILwqUQXe/v0OqEUAcfwJzlz
         m8Fmy4hIVqihYhkD79g5wcnwOQKm8yJTmJHtupxKXjdokoGKGtcUqsR0jqN7i3UK7g
         7tzQYdkqRsMKCTNY/aPQQrVsRe9ymm3uShywDTFzwScdt+txT8R9aOuO6PkZLuAfTj
         EpBjJrvpZbpe6pwaX7wRLutu6a+3oaN+x2Idn3W76YonttY/rOFd8pN6tjbKVBTHtx
         QS6ROFu8BvAOg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 10/20] soc: mediatek: mtk-svs: Commonize efuse parse function for most SoCs
Date:   Tue, 21 Nov 2023 13:50:34 +0100
Message-ID: <20231121125044.78642-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
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

Remove almost all of the per-SoC .efuse_parsing() callbacks and replace
them with one common callback svs_common_parse_efuse(): to do that, also
change the function signature of the callback to add the newly required
pointer to struct svs_platform_data, containing the SVS-global fuse map.

This is done for MT8186, MT8188, MT8192, MT8195.

As for MT8183, the efuse parse function was simplified by using the new
fuse maps.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 332 +++++++--------------------------
 1 file changed, 66 insertions(+), 266 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 1042af2aee3f..517a27c58888 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -122,6 +122,9 @@
 #define SVSB_TS_COEFF_MT8195		250460
 #define SVSB_TS_COEFF_MT8186		204650
 
+/* Algo helpers */
+#define FUSE_DATA_NOT_VALID		U32_MAX
+
 /* svs bank related setting */
 #define BITS8				8
 #define MAX_OPP_ENTRIES			16
@@ -399,7 +402,7 @@ struct svs_platform {
 struct svs_platform_data {
 	char *name;
 	struct svs_bank *banks;
-	bool (*efuse_parsing)(struct svs_platform *svsp);
+	bool (*efuse_parsing)(struct svs_platform *svsp, const struct svs_platform_data *pdata);
 	int (*probe)(struct svs_platform *svsp);
 	const struct svs_fusemap *glb_fuse_map;
 	const u32 *regs;
@@ -1838,264 +1841,83 @@ static int svs_get_efuse_data(struct svs_platform *svsp,
 	return 0;
 }
 
-static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
+static u32 svs_get_fuse_val(u32 *fuse_array, const struct svs_fusemap *fmap, u8 nbits)
 {
-	struct svs_bank *svsb;
-	u32 idx, i, ft_pgm, vmin, golden_temp;
-	int ret;
-
-	for (i = 0; i < svsp->efuse_max; i++)
-		if (svsp->efuse[i])
-			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
-				 i, svsp->efuse[i]);
-
-	if (!svsp->efuse[10]) {
-		dev_notice(svsp->dev, "svs_efuse[10] = 0x0?\n");
-		return false;
-	}
-
-	/* Svs efuse parsing */
-	ft_pgm = svsp->efuse[0] & GENMASK(7, 0);
-	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (vmin == 0x1)
-			svsb->vmin = 0x1e;
-
-		if (ft_pgm == 0)
-			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
-
-		if (svsb->type == SVSB_TYPE_LOW) {
-			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[8]) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[8] >> 8) & GENMASK(7, 0);
-		} else if (svsb->type == SVSB_TYPE_HIGH) {
-			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[8]) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[8] >> 8) & GENMASK(7, 0);
-		}
-
-		svsb->vmax += svsb->dvt_fixed;
-	}
-
-	for (i = 0; i < svsp->tefuse_max; i++)
-		if (svsp->tefuse[i] != 0)
-			break;
+	u32 val;
 
-	if (i == svsp->tefuse_max)
-		golden_temp = 50; /* All thermal efuse data are 0 */
-	else
-		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
+	if (fmap->index < 0)
+		return FUSE_DATA_NOT_VALID;
 
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-		svsb->mts = 500;
-		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
-	}
+	val = fuse_array[fmap->index] >> fmap->ofst;
+	val &= GENMASK(nbits - 1, 0);
 
-	return true;
+	return val;
 }
 
-static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
+static bool svs_is_available(struct svs_platform *svsp)
 {
-	struct svs_bank *svsb;
-	u32 idx, i, vmin, golden_temp;
-	int ret;
+	int i, num_populated = 0;
 
-	for (i = 0; i < svsp->efuse_max; i++)
+	/* If at least two fuse arrays are populated, SVS is calibrated */
+	for (i = 0; i < svsp->efuse_max; i++) {
 		if (svsp->efuse[i])
-			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
-				 i, svsp->efuse[i]);
-
-	if (!svsp->efuse[9]) {
-		dev_notice(svsp->dev, "svs_efuse[9] = 0x0?\n");
-		return false;
-	}
-
-	/* Svs efuse parsing */
-	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (vmin == 0x1)
-			svsb->vmin = 0x1e;
-
-		if (svsb->type == SVSB_TYPE_LOW) {
-			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[17]) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[17] >> 8) & GENMASK(7, 0);
-		} else if (svsb->type == SVSB_TYPE_HIGH) {
-			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
-		}
+			num_populated++;
 
-		svsb->vmax += svsb->dvt_fixed;
+		if (num_populated > 1)
+			return true;
 	}
 
-	for (i = 0; i < svsp->tefuse_max; i++)
-		if (svsp->tefuse[i] != 0)
-			break;
-
-	if (i == svsp->tefuse_max)
-		golden_temp = 50; /* All thermal efuse data are 0 */
-	else
-		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-		svsb->mts = 500;
-		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
-	}
-
-	return true;
+	return false;
 }
 
-static bool svs_mt8188_efuse_parsing(struct svs_platform *svsp)
+static bool svs_common_parse_efuse(struct svs_platform *svsp,
+				   const struct svs_platform_data *pdata)
 {
-	struct svs_bank *svsb;
-	u32 idx, i, golden_temp;
-	int ret;
+	const struct svs_fusemap *gfmap = pdata->glb_fuse_map;
+	struct svs_fusemap tfm = { 0, 24 };
+	u32 golden_temp, val;
+	u8 ft_pgm, vmin;
+	int i;
 
-	for (i = 0; i < svsp->efuse_max; i++)
-		if (svsp->efuse[i])
-			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
-				 i, svsp->efuse[i]);
-
-	if (!svsp->efuse[5]) {
-		dev_notice(svsp->dev, "svs_efuse[5] = 0x0?\n");
+	if (!svs_is_available(svsp))
 		return false;
-	}
-
-	/* Svs efuse parsing */
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (svsb->type == SVSB_TYPE_LOW) {
-			svsb->mtdes = svsp->efuse[5] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[5] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[15] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[15] >> 24) & GENMASK(7, 0);
-		} else if (svsb->type == SVSB_TYPE_HIGH) {
-			svsb->mtdes = svsp->efuse[4] & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = svsp->efuse[14] & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[14] >> 8) & GENMASK(7, 0);
-		}
-
-		svsb->vmax += svsb->dvt_fixed;
-	}
-
-	for (i = 0; i < svsp->tefuse_max; i++)
-		if (svsp->tefuse[i] != 0)
-			break;
-
-	if (i == svsp->tefuse_max)
-		golden_temp = 50; /* All thermal efuse data are 0 */
-	else
-		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-		svsb->mts = 500;
-		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
-	}
 
-	return true;
-}
+	/* Get golden temperature from SVS-Thermal calibration */
+	val = svs_get_fuse_val(svsp->tefuse, &tfm, 8);
 
-static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
-{
-	struct svs_bank *svsb;
-	u32 idx, i, golden_temp;
-	int ret;
+	/* If golden temp is not programmed, use the default of 50 */
+	golden_temp = val ? val : 50;
 
-	for (i = 0; i < svsp->efuse_max; i++)
-		if (svsp->efuse[i])
-			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
-				 i, svsp->efuse[i]);
+	/* Parse fused SVS calibration */
+	ft_pgm = svs_get_fuse_val(svsp->efuse, &gfmap[GLB_FT_PGM], 8);
+	vmin = svs_get_fuse_val(svsp->efuse, &gfmap[GLB_VMIN], 2);
 
-	if (!svsp->efuse[0]) {
-		dev_notice(svsp->dev, "svs_efuse[0] = 0x0?\n");
-		return false;
-	}
+	for (i = 0; i < svsp->bank_max; i++) {
+		struct svs_bank *svsb = &svsp->banks[i];
+		const struct svs_fusemap *dfmap = svsb->dev_fuse_map;
 
-	/* Svs efuse parsing */
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
+		if (vmin == 1)
+			svsb->vmin = 0x1e;
 
-		switch (svsb->sw_id) {
-		case SVSB_SWID_CPU_BIG:
-			if (svsb->type == SVSB_TYPE_HIGH) {
-				svsb->mdes = (svsp->efuse[2] >> 24) & GENMASK(7, 0);
-				svsb->bdes = (svsp->efuse[2] >> 16) & GENMASK(7, 0);
-				svsb->mtdes = svsp->efuse[2] & GENMASK(7, 0);
-				svsb->dcmdet = (svsp->efuse[13] >> 8) & GENMASK(7, 0);
-				svsb->dcbdet = svsp->efuse[13] & GENMASK(7, 0);
-			} else if (svsb->type == SVSB_TYPE_LOW) {
-				svsb->mdes = (svsp->efuse[3] >> 24) & GENMASK(7, 0);
-				svsb->bdes = (svsp->efuse[3] >> 16) & GENMASK(7, 0);
-				svsb->mtdes = svsp->efuse[3] & GENMASK(7, 0);
-				svsb->dcmdet = (svsp->efuse[14] >> 24) & GENMASK(7, 0);
-				svsb->dcbdet = (svsp->efuse[14] >> 16) & GENMASK(7, 0);
-			}
-			break;
-		case SVSB_SWID_CPU_LITTLE:
-			svsb->mdes = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
-			svsb->mtdes = svsp->efuse[4] & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[14] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = svsp->efuse[14] & GENMASK(7, 0);
-			break;
-		case SVSB_SWID_CCI:
-			svsb->mdes = (svsp->efuse[5] >> 24) & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
-			svsb->mtdes = svsp->efuse[5] & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[15] >> 24) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[15] >> 16) & GENMASK(7, 0);
-			break;
-		case SVSB_SWID_GPU:
-			svsb->mdes = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
-			svsb->bdes = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
-			svsb->mtdes = svsp->efuse[6] & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[15] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = svsp->efuse[15] & GENMASK(7, 0);
-			break;
-		default:
-			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
-			return false;
-		}
+		if (ft_pgm == 0)
+			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
 
+		svsb->mtdes = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_MTDES], 8);
+		svsb->bdes = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_BDES], 8);
+		svsb->mdes = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_MDES], 8);
+		svsb->dcbdet = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_DCBDET], 8);
+		svsb->dcmdet = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_DCMDET], 8);
 		svsb->vmax += svsb->dvt_fixed;
-	}
-
-	golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
-	if (!golden_temp)
-		golden_temp = 50;
 
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-		svsb->mts = 409;
-		svsb->bts = (((500 * golden_temp + 204650) / 1000) - 25) * 4;
+		svsb->mts = (svsp->ts_coeff * 2) / 1000;
+		svsb->bts = (((500 * golden_temp + svsp->ts_coeff) / 1000) - 25) * 4;
 	}
 
 	return true;
 }
 
-static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
+static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp,
+				     const struct svs_platform_data *pdata)
 {
 	struct svs_bank *svsb;
 	int format[6], x_roomt[6], o_vtsmcu[5], o_vtsabb, tb_roomt = 0;
@@ -2115,65 +1937,43 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 	}
 
 	/* Svs efuse parsing */
-	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
+	ft_pgm = svs_get_fuse_val(svsp->efuse, &pdata->glb_fuse_map[GLB_FT_PGM], 4);
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
+		const struct svs_fusemap *dfmap = svsb->dev_fuse_map;
 
 		if (ft_pgm <= 1)
 			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
 
+		svsb->mtdes = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_MTDES], 8);
+		svsb->bdes = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_BDES], 8);
+		svsb->mdes = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_MDES], 8);
+		svsb->dcbdet = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_DCBDET], 8);
+		svsb->dcmdet = svs_get_fuse_val(svsp->efuse, &dfmap[BDEV_DCMDET], 8);
+
 		switch (svsb->sw_id) {
 		case SVSB_SWID_CPU_LITTLE:
-			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
-
+		case SVSB_SWID_CCI:
 			if (ft_pgm <= 3)
 				svsb->volt_od += 10;
 			else
 				svsb->volt_od += 2;
 			break;
 		case SVSB_SWID_CPU_BIG:
-			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
-
 			if (ft_pgm <= 3)
 				svsb->volt_od += 15;
 			else
 				svsb->volt_od += 12;
 			break;
-		case SVSB_SWID_CCI:
-			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
-
-			if (ft_pgm <= 3)
-				svsb->volt_od += 10;
-			else
-				svsb->volt_od += 2;
-			break;
 		case SVSB_SWID_GPU:
-			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
-			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
-			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
-			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
-			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
-
-			if (ft_pgm >= 2) {
+			if (ft_pgm != FUSE_DATA_NOT_VALID && ft_pgm >= 2) {
 				svsb->freq_base = 800000000; /* 800MHz */
 				svsb->dvt_fixed = 2;
 			}
 			break;
 		default:
-			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
+			dev_err(svsb->dev, "unknown sw_id: %u\n", bdata->sw_id);
 			return false;
 		}
 	}
@@ -2904,7 +2704,7 @@ static struct svs_bank svs_mt8183_banks[] = {
 static const struct svs_platform_data svs_mt8195_platform_data = {
 	.name = "mt8195-svs",
 	.banks = svs_mt8195_banks,
-	.efuse_parsing = svs_mt8195_efuse_parsing,
+	.efuse_parsing = svs_common_parse_efuse,
 	.probe = svs_mt8192_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8195_banks),
@@ -2917,7 +2717,7 @@ static const struct svs_platform_data svs_mt8195_platform_data = {
 static const struct svs_platform_data svs_mt8192_platform_data = {
 	.name = "mt8192-svs",
 	.banks = svs_mt8192_banks,
-	.efuse_parsing = svs_mt8192_efuse_parsing,
+	.efuse_parsing = svs_common_parse_efuse,
 	.probe = svs_mt8192_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
@@ -2931,7 +2731,7 @@ static const struct svs_platform_data svs_mt8192_platform_data = {
 static const struct svs_platform_data svs_mt8188_platform_data = {
 	.name = "mt8188-svs",
 	.banks = svs_mt8188_banks,
-	.efuse_parsing = svs_mt8188_efuse_parsing,
+	.efuse_parsing = svs_common_parse_efuse,
 	.probe = svs_mt8192_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8188_banks),
@@ -2945,7 +2745,7 @@ static const struct svs_platform_data svs_mt8188_platform_data = {
 static const struct svs_platform_data svs_mt8186_platform_data = {
 	.name = "mt8186-svs",
 	.banks = svs_mt8186_banks,
-	.efuse_parsing = svs_mt8186_efuse_parsing,
+	.efuse_parsing = svs_common_parse_efuse,
 	.probe = svs_mt8186_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8186_banks),
@@ -3025,7 +2825,7 @@ static int svs_probe(struct platform_device *pdev)
 		goto svs_probe_free_efuse;
 	}
 
-	if (!svsp_data->efuse_parsing(svsp)) {
+	if (!svsp_data->efuse_parsing(svsp, svsp_data)) {
 		dev_err(svsp->dev, "efuse data parsing failed\n");
 		ret = -EPERM;
 		goto svs_probe_free_tefuse;
-- 
2.42.0

