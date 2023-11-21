Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE52D7F2C68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjKUL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjKUL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F09D125;
        Tue, 21 Nov 2023 03:56:48 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AA076607323;
        Tue, 21 Nov 2023 11:56:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700567807;
        bh=mvDbP9LsG0x+WjQA4KRWvixfVCE355+sCyiuJX+FpKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQzzsLAPLWVCrdYb1WdDBdgCttHjg+D0GSUKO8RjcPy/S1k2NgVgf3dkE+E0FXCdV
         W7rrIfGI8UW1pl/ucspvIOj8CKAZX1Em5cBzG54xGK+yDXik/0Ej6GAyFbVzX+MEXw
         /N533xEVo4QceCSm+oyT2e1aL8RdKexn5Mx4Y6V9L5igobnE3IJqHjkpGGZIFhSgDe
         EnEGPDuOMKWivrUJi+OfHz56fSte8UE+K7sJpVvHztWxKUff84obzi2lwfggeuy/JU
         2Iv13hIZftMUP85+47DDkz60ar/mP5ZhAuSk64Ci6MH4NuVW32zzvGlREIl+N5+Lb9
         fytD6j3AUfIsw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 15/20] soc: mediatek: mtk-svs: Cleanup of svs_probe() function
Date:   Tue, 21 Nov 2023 12:56:19 +0100
Message-ID: <20231121115624.56855-16-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
References: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
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

Cleanup the svs_probe() function: use dev_err_probe() where possible,
change some efuse read failure gotos and then remove now impossible
IS_ERR_OR_NULL() checks (as they will never return true) for nvmem
(efuse read) failures.
Also remove some unnecessary blank lines.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index ac36c2efcafa..ae0cc22a2941 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2775,14 +2775,13 @@ static int svs_probe(struct platform_device *pdev)
 	}
 
 	if (!svsp_data->efuse_parsing(svsp, svsp_data)) {
-		dev_err(svsp->dev, "efuse data parsing failed\n");
-		ret = -EPERM;
+		ret = dev_err_probe(svsp->dev, -EINVAL, "efuse data parsing failed\n");
 		goto svs_probe_free_tefuse;
 	}
 
 	ret = svs_bank_resource_setup(svsp);
 	if (ret) {
-		dev_err(svsp->dev, "svs bank resource setup fail: %d\n", ret);
+		dev_err_probe(svsp->dev, ret, "svs bank resource setup fail\n");
 		goto svs_probe_free_tefuse;
 	}
 
@@ -2794,43 +2793,40 @@ static int svs_probe(struct platform_device *pdev)
 
 	svsp->main_clk = devm_clk_get(svsp->dev, "main");
 	if (IS_ERR(svsp->main_clk)) {
-		dev_err(svsp->dev, "failed to get clock: %ld\n",
-			PTR_ERR(svsp->main_clk));
-		ret = PTR_ERR(svsp->main_clk);
+		ret = dev_err_probe(svsp->dev, PTR_ERR(svsp->main_clk),
+				    "failed to get clock\n");
 		goto svs_probe_free_tefuse;
 	}
 
 	ret = clk_prepare_enable(svsp->main_clk);
 	if (ret) {
-		dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
+		dev_err_probe(svsp->dev, ret, "cannot enable main clk\n");
 		goto svs_probe_free_tefuse;
 	}
 
 	svsp->base = of_iomap(svsp->dev->of_node, 0);
 	if (IS_ERR_OR_NULL(svsp->base)) {
-		dev_err(svsp->dev, "cannot find svs register base\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(svsp->dev, -EINVAL, "cannot find svs register base\n");
 		goto svs_probe_clk_disable;
 	}
 
 	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
 					IRQF_ONESHOT, svsp_data->name, svsp);
 	if (ret) {
-		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
-			svsp_irq, ret);
+		dev_err_probe(svsp->dev, ret, "register irq(%d) failed\n", svsp_irq);
 		goto svs_probe_iounmap;
 	}
 
 	ret = svs_start(svsp);
 	if (ret) {
-		dev_err(svsp->dev, "svs start fail: %d\n", ret);
+		dev_err_probe(svsp->dev, ret, "svs start fail\n");
 		goto svs_probe_iounmap;
 	}
 
 #ifdef CONFIG_DEBUG_FS
 	ret = svs_create_debug_cmds(svsp);
 	if (ret) {
-		dev_err(svsp->dev, "svs create debug cmds fail: %d\n", ret);
+		dev_err_probe(svsp->dev, ret, "svs create debug cmds fail\n");
 		goto svs_probe_iounmap;
 	}
 #endif
@@ -2839,18 +2835,12 @@ static int svs_probe(struct platform_device *pdev)
 
 svs_probe_iounmap:
 	iounmap(svsp->base);
-
 svs_probe_clk_disable:
 	clk_disable_unprepare(svsp->main_clk);
-
 svs_probe_free_tefuse:
-	if (!IS_ERR_OR_NULL(svsp->tefuse))
-		kfree(svsp->tefuse);
-
+	kfree(svsp->tefuse);
 svs_probe_free_efuse:
-	if (!IS_ERR_OR_NULL(svsp->efuse))
-		kfree(svsp->efuse);
-
+	kfree(svsp->efuse);
 	return ret;
 }
 
-- 
2.42.0

