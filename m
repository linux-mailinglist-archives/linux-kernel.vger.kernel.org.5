Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC637F2DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjKUMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjKUMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:51:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AAA1AA;
        Tue, 21 Nov 2023 04:51:01 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C8E4F6607314;
        Tue, 21 Nov 2023 12:50:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700571060;
        bh=YAm2XwYefU2Wi2EmslwaPruVfwk8nKNQAa35BFgYSvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXtid+ivp1dSih09MgnuxB4/ZRA4pjGsxDuGrhSKwwYcVK0UMLDH0eWsBzpUYBULB
         XkPzk17UGPJj9qII/QGy1AKPOVKl+k72O6cbbYaYsz6/S4b9lpuCJ632A6PYH659ZU
         LT5Lz5/KwXwbw326hHl0PO4uNsgCwNdxwoI1IiBmqgYAjyWUWN9VmMuYrW7Qv1kaRA
         hX2aEmUc5WgzHTf59V/Q8Ydty51DJ1ig8+cPlNb20L2uS21/kHxClGt+Hi+EreKmin
         OyvnPwbiaOb2uQs6pYcvDtn+X7oaV5EEn8v8GvJwv+i18NYdLuvx+H8PxOeNlkLqei
         xBuD6EZCNjuog==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v3 09/20] soc: mediatek: mtk-svs: Move t-calibration-data retrieval to svs_probe()
Date:   Tue, 21 Nov 2023 13:50:33 +0100
Message-ID: <20231121125044.78642-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
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

The t-calibration-data (SVS-Thermal calibration data) shall exist for
all SoCs or SVS won't work anyway: move it to the common svs_probe()
function and remove it from all of the per-SoC efuse_parsing() probe
callbacks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index ab564d48092b..1042af2aee3f 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1884,11 +1884,6 @@ static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	ret = svs_get_efuse_data(svsp, "t-calibration-data",
-				 &svsp->tefuse, &svsp->tefuse_max);
-	if (ret)
-		return false;
-
 	for (i = 0; i < svsp->tefuse_max; i++)
 		if (svsp->tefuse[i] != 0)
 			break;
@@ -1949,11 +1944,6 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	ret = svs_get_efuse_data(svsp, "t-calibration-data",
-				 &svsp->tefuse, &svsp->tefuse_max);
-	if (ret)
-		return false;
-
 	for (i = 0; i < svsp->tefuse_max; i++)
 		if (svsp->tefuse[i] != 0)
 			break;
@@ -2009,11 +1999,6 @@ static bool svs_mt8188_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	ret = svs_get_efuse_data(svsp, "t-calibration-data",
-				 &svsp->tefuse, &svsp->tefuse_max);
-	if (ret)
-		return false;
-
 	for (i = 0; i < svsp->tefuse_max; i++)
 		if (svsp->tefuse[i] != 0)
 			break;
@@ -2097,11 +2082,6 @@ static bool svs_mt8186_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	ret = svs_get_efuse_data(svsp, "t-calibration-data",
-				 &svsp->tefuse, &svsp->tefuse_max);
-	if (ret)
-		return false;
-
 	golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
 	if (!golden_temp)
 		golden_temp = 50;
@@ -2198,11 +2178,6 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		}
 	}
 
-	ret = svs_get_efuse_data(svsp, "t-calibration-data",
-				 &svsp->tefuse, &svsp->tefuse_max);
-	if (ret)
-		return false;
-
 	/* Thermal efuse parsing */
 	adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
 	adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
@@ -3040,8 +3015,13 @@ static int svs_probe(struct platform_device *pdev)
 
 	ret = svs_get_efuse_data(svsp, "svs-calibration-data",
 				 &svsp->efuse, &svsp->efuse_max);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Cannot read SVS calibration\n");
+
+	ret = svs_get_efuse_data(svsp, "t-calibration-data",
+				 &svsp->tefuse, &svsp->tefuse_max);
 	if (ret) {
-		ret = -EPERM;
+		dev_err_probe(&pdev->dev, ret, "Cannot read SVS-Thermal calibration\n");
 		goto svs_probe_free_efuse;
 	}
 
-- 
2.42.0

