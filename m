Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392BB7A0EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjINUb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjINUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:31:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E424826B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:31:20 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gszUqMvFz7mcCgszfqSuj1; Thu, 14 Sep 2023 22:31:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694723479;
        bh=L4zSBrHMeKtx3k1Cx39Zzdjpsyw54yrC3izyk+zGNhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ATMsMx1XQDh6q4gSJOcwj9KwlnjMBXuJlakUA/vN5iamikjxfr3xTo6ydf3fRJziS
         yoLAArLg1MaN/b1fxKjOcQiqUZkiIS+YFmLvyuUdb64nqTHQCdc1C1y+9eNyp2KLGp
         lBiTbaqeoVdBLDz+2XSPipXUEOqwqY/np5ZNKNkcN+y3VXRGEXV3HRsh77h5mbyF9l
         8BDO2h7Z8zlrWgAcTSmwg8ZCdhAr+ynFGBmQeNl25k1Kj0qwTmxvSa4lShV1GQdsie
         QzkPy0R/cGrdHEnneHSjMDE8F8PdI0csvi9bh+4igPUmIuz1ubFruRx9Co/EkTptiD
         cty6ejsRJQcSg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Sep 2023 22:31:19 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 2/5] clk: imx: imx8: Fix an error handling path if devm_clk_hw_register_mux_parent_data_table() fails
Date:   Thu, 14 Sep 2023 22:31:03 +0200
Message-Id: <e8e5b184533fce19f185196771e77932e0c7eb6c.1694722339.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
References: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a devm_clk_hw_register_mux_parent_data_table() call fails, it is likely
that the probe should fail with an error code.

Set 'ret' before leaving the function.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/imx/clk-imx8-acm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 87025a6772d0..73b3b5354951 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -373,6 +373,7 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 										sels[i].shift, sels[i].width,
 										0, NULL, NULL);
 		if (IS_ERR(hws[sels[i].clkid])) {
+			ret = PTR_ERR(hws[sels[i].clkid]);
 			pm_runtime_disable(&pdev->dev);
 			goto err_clk_register;
 		}
-- 
2.34.1

