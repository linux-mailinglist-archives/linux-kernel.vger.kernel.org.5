Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0386789CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjH0JjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjH0Jig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:38:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DFFA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:38:34 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id aCDYqs7H09KIfaCE4q3nb5; Sun, 27 Aug 2023 11:38:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693129113;
        bh=+P4qXG0DNFgTzSGfPFxL6rolcGOhTs7nFhwTKxuBpPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e6GGeHkclzkSFZH7b6d6bA40oWV879quuR7gMm0OtFDdxiowVxHxfUZX1s7d07Leb
         DEJp+gg/Gpf25duCNb11870Z4mHvaKw6tJf2E4LebCkZ3RIR7kJ58aY9RpoRDflVH1
         QGnGlABHepua5oBa8YUlSsaoOKaW/tzFUAOT92VPQdlKZodOlrU64tNjzBz/9iLjaK
         T13d+u6IKBC0Jb7QSga2ltLIpcytHTAG/hW1V7c6vCRq1NCe76ymUimiCdjXSDJQBf
         YTi2VzcGJWyP6uA68pxqmY4h9el5F8EW/Y/UUp9947zjRxrIgrVlGpx4a6+sYIVIoV
         OAKxmTCEWmzkA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Aug 2023 11:38:33 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 5/5] clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()
Date:   Sun, 27 Aug 2023 11:37:56 +0200
Message-Id: <9046676220e3f5362d3aa638cb5cd4ffcbae797d.1693126687.git.christophe.jaillet@wanadoo.fr>
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

The return value of clk_imx_acm_detach_pm_domains() never used.
Simplify the code and turn it into a void function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/imx/clk-imx8-acm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 33157bc706ae..2c920091d678 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -310,20 +310,18 @@ static int clk_imx_acm_attach_pm_domains(struct device *dev,
  * @dev: deivice pointer
  * @dev_pm: multi power domain for device
  */
-static int clk_imx_acm_detach_pm_domains(struct device *dev,
-					 struct clk_imx_acm_pm_domains *dev_pm)
+static void clk_imx_acm_detach_pm_domains(struct device *dev,
+					  struct clk_imx_acm_pm_domains *dev_pm)
 {
 	int i;
 
 	if (dev_pm->num_domains <= 1)
-		return 0;
+		return;
 
 	for (i = 0; i < dev_pm->num_domains; i++) {
 		device_link_del(dev_pm->pd_dev_link[i]);
 		dev_pm_domain_detach(dev_pm->pd_dev[i], false);
 	}
-
-	return 0;
 }
 
 static int imx8_acm_clk_probe(struct platform_device *pdev)
-- 
2.34.1

