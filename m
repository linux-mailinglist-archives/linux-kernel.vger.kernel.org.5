Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A91C7EEF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbjKQJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbjKQJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:43:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4E1702;
        Fri, 17 Nov 2023 01:42:48 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 177AD660738E;
        Fri, 17 Nov 2023 09:42:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700214166;
        bh=zNfya3IwOleE3gv7u+f222r6Eh2oBHfy4LgRig9Wjl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcfSZVjPvbDH0V17L4oTyWt9EEHqzCLWSfiJeUDxVEJor48SmNLP2VnYRyS5OCYiQ
         jnVdbQkL711tsjT3U0fQ/4zfdmKP18YqbQoGv9r/f9W+MOqlG/q1VULlNlLTThTpPr
         4zNXeDnimqSfeUoo8dqkopL4Fc9ljIiTGd1CMYHBk9gJkvDStFWv4GL06G6sbDiE4g
         ZUlHhigq9ohM08Cw/DzKw0U/QBZFkf/9heu1+FA4vNKjZM4tNGVvJzv7wQURiUdLnm
         ixm9xL7C6dmVRl6meYojS23sXtZeQMg5jSNFcJEQVGhe1FrcBxNEoMI8xF0L4hbV2k
         sXNAsDgEiM0Ww==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v1 12/20] soc: mediatek: mtk-svs: Commonize MT8192 probe function for MT8186
Date:   Fri, 17 Nov 2023 10:42:20 +0100
Message-ID: <20231117094228.40013-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117094228.40013-1-angelogioacchino.delregno@collabora.com>
References: <20231117094228.40013-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

