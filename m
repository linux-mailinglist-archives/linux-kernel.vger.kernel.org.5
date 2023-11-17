Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD977EEF12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbjKQJnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbjKQJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:43:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115191737;
        Fri, 17 Nov 2023 01:42:51 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E94C6607398;
        Fri, 17 Nov 2023 09:42:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700214169;
        bh=mvDbP9LsG0x+WjQA4KRWvixfVCE355+sCyiuJX+FpKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrNscpr3H8gtnvLMycWzXSDftQpQwnaxSmVNNPac2BpkGrvR5ZfjuYyCEAhaILwvA
         2uPKBLjksdMUtRM69uxkXXLniW9aBmhw83Zemh42auXu7N1mEUcktX5YcmaYcUTVM6
         Lcmb4dT9rar1ijTsKlqcvW5d2YfsmF+uHAI22xZJW9IHJjUqB5AHMIucj1V/2jGXoa
         ah8uiWmzpqOzsAyZdgkY4BCPF72rAZlufmfz2HiXs3lD3DXJJjCyvQ36QBWsWaRNWg
         c+DF5lrqtLI0B6x6rgW/VP7gKOxhLxarko3+lvv86f4Lgf0MkEYyChYeqX0cBfDJwH
         +JrSQqk6kM0Ng==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v1 15/20] soc: mediatek: mtk-svs: Cleanup of svs_probe() function
Date:   Fri, 17 Nov 2023 10:42:23 +0100
Message-ID: <20231117094228.40013-16-angelogioacchino.delregno@collabora.com>
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

