Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889E789CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjH0JjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjH0Ji2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:38:28 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1648E4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:38:26 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id aCDYqs7H09KIfaCDxq3na4; Sun, 27 Aug 2023 11:38:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693129105;
        bh=I6DfPJLjRMXd5IakoD9Cs1Y4bITISq9Vs0SLJnQFqZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hqotYqNZ7+Lb9zpuQe/7IGIaXgdHXl142eKk6OuVwfKjh1Fr3OD8vrRCx3DVMUFtO
         juL3qA4px/KLjNLignVmc5cCEZNmzRrcXaiWo/+n9UxirARxaIty5PEuHvqvyhf5fe
         L/2I5nlLA4j4raZlusP4/evTQ7ZoR4G7MdWGEddNDz06cqjWbkDaeFqHXgUT9aM0JJ
         B3smEwbAHN4n6frMLoJZG6tLhs50BPGCh5uhgnPlo2YrR+pSAW/Ls0JOXd3pnhPZ7g
         WnXkSQk9qq+3MDMcO9HlUcUoLm66jM9lZLDV99Uvd3QchIx8ZSIKXNlXSacqShJYag
         inDyKrYwnYt8g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Aug 2023 11:38:25 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/5] clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
Date:   Sun, 27 Aug 2023 11:37:54 +0200
Message-Id: <aa1f954f1d13fe7d2de0ede38a640124fb6974f1.1693126687.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful clk_imx_acm_attach_pm_domains() call,
it must be undone.

Add an explicit error handling path, Re-order the code and add the missing
clk_imx_acm_detach_pm_domains() call.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative, review with care.
---
 drivers/clk/imx/clk-imx8-acm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 0cd9aa3629f3..19914c1d7c39 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -374,7 +374,6 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 										0, NULL, NULL);
 		if (IS_ERR(hws[sels[i].clkid])) {
 			ret = PTR_ERR(hws[sels[i].clkid]));
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

