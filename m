Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7985A789CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjH0JjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjH0Jid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:38:33 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D8BE4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:38:30 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id aCDYqs7H09KIfaCE1q3naj; Sun, 27 Aug 2023 11:38:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693129109;
        bh=i5qoU1N0Ijqq+IRjIQaG9uUkOL+C8Y0RRn+B9L4Ow7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rOBttUZYKGhbmMprEne7+McQ0FBU3WSbssxOHdFLcpJ31dcw0+EEhZd4vy3uwAd0V
         YhYpN1PqH95lKqoaC8dOxYp2jbSncOacMIb57yMiD052ZIUGdfSJ3/zL+F16pCPTfx
         xLOXQn9/QohJfQoN/1/j/eX5g9+5cjOLW65osmAK/kZ2mp7dGKPj6gwJcBksJsL8DO
         MmKY5n/4e+AUTPKacSkIR3yz57kw1oyy7/5pq/HtD0Cv/o6NF5Z80mT9cyHjLAKASO
         c8jEGxiOzLipdqobaf0HJqbXqapCm8Tfe87ibX/vCbfmK4YJaZGPpOBY9krMDHku/Z
         bMFqFQts0sRjw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Aug 2023 11:38:29 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/5] clk: imx: imx8: Add a message in case of devm_clk_hw_register_mux_parent_data_table() error
Date:   Sun, 27 Aug 2023 11:37:55 +0200
Message-Id: <92d1e1355a216b1304a9d988aaa499553528a3b9.1693126687.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_clk_hw_register_mux_parent_data_table() fails, we branch to the
error handling path and imx_check_clk_hws() is never called.

Actually, imx_check_clk_hws() is a no-op because values in hws are either
valid, either NULL.

Move the call to imx_check_clk_hws() in the error handling path, so that
an error is logged.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/imx/clk-imx8-acm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 19914c1d7c39..33157bc706ae 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -374,12 +374,11 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 										0, NULL, NULL);
 		if (IS_ERR(hws[sels[i].clkid])) {
 			ret = PTR_ERR(hws[sels[i].clkid]));
+			imx_check_clk_hws(hws, IMX_ADMA_ACM_CLK_END);
 			goto err_clk_register;
 		}
 	}
 
-	imx_check_clk_hws(hws, IMX_ADMA_ACM_CLK_END);
-
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
 		dev_err(dev, "failed to register hws for ACM\n");
-- 
2.34.1

