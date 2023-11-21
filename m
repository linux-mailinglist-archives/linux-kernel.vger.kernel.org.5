Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902287F2C63
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjKUL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjKUL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83525D66;
        Tue, 21 Nov 2023 03:56:45 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E1276607319;
        Tue, 21 Nov 2023 11:56:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700567804;
        bh=zNfya3IwOleE3gv7u+f222r6Eh2oBHfy4LgRig9Wjl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVrM2xjiiOpHT1WFNYbQiLOIm4IKSnWHVz2zRUlCmWgwE/GQt53wmVCsAmEnwWVfy
         32oyNkeJgVEYR8iF+2tifdd06ecgapOcqHD54aUPdnEfG1cZIpnaE8oIStUuvXYLTA
         +fcCh+mlyrUNuV7G2K6OPynHzm80/G+cIbw8oOnq2ZrIELrwN65KkBWiaojO/W86M8
         /t3YaV0oIILzFMahy7TT4k4Wm9W8Rz62Na0CS0pGr2TUi1rFexgCeiAkiitL0suLE6
         zG7c0zIO1AgaSAi2oNrfUUF66tUYQIY4HwvGXgCOMXOhnMFPvntbZPoZL+krzeMyFZ
         Q6zNJzDresGDg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 12/20] soc: mediatek: mtk-svs: Commonize MT8192 probe function for MT8186
Date:   Tue, 21 Nov 2023 12:56:16 +0100
Message-ID: <20231121115624.56855-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
References: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
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

Include the additions of svs_mt8186_platform_probe() in the common
svs_mt8192_platform_probe() function, remove the former, and use the
latter as .probe() callback for MT8186.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 44 ++++++----------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index e7df3a577b4c..cd5064683506 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2119,7 +2119,6 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
-	struct svs_bank *svsb;
 	u32 idx;
 
 	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
@@ -2133,40 +2132,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 				     "failed to get lvts device\n");
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
-
-		if (svsb->type == SVSB_TYPE_HIGH)
-			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
-		else if (svsb->type == SVSB_TYPE_LOW)
-			svsb->opp_dev = svs_get_subsys_device(svsp, "gpu");
-
-		if (IS_ERR(svsb->opp_dev))
-			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
-					     "failed to get OPP device for bank %d\n",
-					     idx);
-	}
-
-	return 0;
-}
-
-static int svs_mt8186_platform_probe(struct svs_platform *svsp)
-{
-	struct device *dev;
-	struct svs_bank *svsb;
-	u32 idx;
-
-	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
-	if (IS_ERR(svsp->rst))
-		return dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
-				     "cannot get svs reset control\n");
-
-	dev = svs_add_device_link(svsp, "thermal-sensor");
-	if (IS_ERR(dev))
-		return dev_err_probe(svsp->dev, PTR_ERR(dev),
-				     "failed to get lvts device\n");
-
-	for (idx = 0; idx < svsp->bank_max; idx++) {
-		svsb = &svsp->banks[idx];
+		struct svs_bank *svsb = &svsp->banks[idx];
 
 		switch (svsb->sw_id) {
 		case SVSB_SWID_CPU_LITTLE:
@@ -2177,7 +2143,11 @@ static int svs_mt8186_platform_probe(struct svs_platform *svsp)
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
 			break;
 		case SVSB_SWID_GPU:
-			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
+			if (svsb->type == SVSB_TYPE_LOW)
+				svsb->opp_dev = svs_get_subsys_device(svsp, "gpu");
+			else
+				svsb->opp_dev = svs_add_device_link(svsp, "gpu");
+			break;
 			break;
 		default:
 			dev_err(svsb->dev, "unknown sw_id: %u\n", svsb->sw_id);
@@ -2739,7 +2709,7 @@ static const struct svs_platform_data svs_mt8186_platform_data = {
 	.name = "mt8186-svs",
 	.banks = svs_mt8186_banks,
 	.efuse_parsing = svs_common_parse_efuse,
-	.probe = svs_mt8186_platform_probe,
+	.probe = svs_mt8192_platform_probe,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8186_banks),
 	.ts_coeff = SVSB_TS_COEFF_MT8186,
-- 
2.42.0

