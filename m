Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CEA7A0F05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjINUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjINUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:31:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2252696
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:31:22 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gszUqMvFz7mcCgszhqSujj; Thu, 14 Sep 2023 22:31:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694723481;
        bh=NmPmvwDti8A6+vjVsHfI78i7GC2N7ByVUqJXUWyMtrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KbMHK1tKAqubigEX7gqvjQPN1a2Wgx4kPtqV64SP8HWfCFo3FNz5rmVOADA5MpXoU
         jSWY6IXMpVvezcVNjTmfUq8BU3NpOgRQHlzzB5idUFmFnn2Gr/pF2SjltqO8gl7yII
         4CLNmZS0Z/PsSNECSWoWjt0M1h5ZozlUx3ohSE12jKbiClkwKzF3nWUyOwLwPbwxBG
         c9UdcbM7q09zmdUXZB5+fHG3ZNPhnYIxp1kCXs5f5quyimC4yERSw4HjxX2fsF0Usx
         eP31FbKILpkM4G5BJCvi5VuAdoCQzGhEFfxkicV7Gn4EEsOpHn5Vx9QLCiZ4NjXeIX
         fAZ3A5eoH30sg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Sep 2023 22:31:21 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 4/5] clk: imx: imx8: Add a message in case of devm_clk_hw_register_mux_parent_data_table() error
Date:   Thu, 14 Sep 2023 22:31:05 +0200
Message-Id: <3b883db73c1ad093ea914f008db92738482734a5.1694722339.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
References: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_clk_hw_register_mux_parent_data_table() fails, we branch to the
error handling path and imx_check_clk_hws() is never called.

Actually, imx_check_clk_hws() is a no-op because values in 'hws' are either
valid, either NULL.

Move the call to imx_check_clk_hws() in the error handling path, so that
an error is logged.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/imx/clk-imx8-acm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 1c95ae905eec..c744fb78bb44 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -374,12 +374,11 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 										0, NULL, NULL);
 		if (IS_ERR(hws[sels[i].clkid])) {
 			ret = PTR_ERR(hws[sels[i].clkid]);
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

