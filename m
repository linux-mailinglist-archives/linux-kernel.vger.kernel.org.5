Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA06C7A0F02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjINUb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjINUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:31:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B123F2701
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:31:21 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gszUqMvFz7mcCgszgqSujL; Thu, 14 Sep 2023 22:31:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694723480;
        bh=uJUbD44KFFzWixdbKCNvbFqaLxCfMEIUABC+xCGz+h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YsX/EaRdLBP85K/6bBP2Aha5OcT3dD8fBN9dwo5VUfI+WskzbbHIhG5SdMV5qrLxq
         4mynLaS+CwsO9EC4d2UpwkhaWR+aSXd8iH82HeTiD7GMUb5dIPEtzH4TG4qH4/WgTS
         LcxbGiDsJiMBiskch95I5TdB1H4uEt4+4NBzSy5kGnLDVu/PEgMtiucXDDUubaQa8k
         fEQJuagJOCtIHSY48dsi2OF8nqMQhlwAgteuiscn8tqM9CS//lYwicdnkc7pwd0J2z
         74tonesYF6Z4mKsSv5+8Zl/MqUDRqDMEFp7MhZdgggnYj2lrClchrqNo0wMtvIYuOz
         P88jgwDJCB4/A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Sep 2023 22:31:20 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 3/5] clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
Date:   Thu, 14 Sep 2023 22:31:04 +0200
Message-Id: <64da5952f807f37f29f0c4420ac1bde416551a13.1694722339.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
References: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful clk_imx_acm_attach_pm_domains() call,
it must be undone.

Add an explicit error handling path, re-order the code and add the missing
clk_imx_acm_detach_pm_domains() call.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/imx/clk-imx8-acm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 73b3b5354951..1c95ae905eec 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -374,7 +374,6 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 										0, NULL, NULL);
 		if (IS_ERR(hws[sels[i].clkid])) {
 			ret = PTR_ERR(hws[sels[i].clkid]);
-			pm_runtime_disable(&pdev->dev);
 			goto err_clk_register;
 		}
 	}
@@ -384,12 +383,16 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
 		dev_err(dev, "failed to register hws for ACM\n");
-		pm_runtime_disable(&pdev->dev);
+		goto err_clk_register;
 	}
 
-err_clk_register:
+	pm_runtime_put_sync(&pdev->dev);
+	return 0;
 
+err_clk_register:
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	clk_imx_acm_detach_pm_domains(&pdev->dev, &priv->dev_pm);
 
 	return ret;
 }
-- 
2.34.1

