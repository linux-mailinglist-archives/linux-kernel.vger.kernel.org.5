Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001675DE99
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGVUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGVUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:42:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE51FDF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 13:42:00 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NJQLqgycdZWkDNJQLqk8SS; Sat, 22 Jul 2023 22:41:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690058519;
        bh=bWA5n6DBMnr6LPqtlqyYrLqir8O7olbWs97Uom4gQgI=;
        h=From:To:Cc:Subject:Date;
        b=BmfgCTgHGZmPLZfgh6/5mQP4E2wdZaHbTRVBvvHjna2XPxdRTQunjAprimqsHjq//
         28oQACOKrz7hn5tCjfbN6bemF83SmLS+ApR/p9MhTQ+YjNo2MwFYtUb0PN9kUhuiJf
         inYIVqrF1IUwUyjIDKdUiEY6m+AXl/beuXy+2+yNAfRLxjcjC4YOMK9NhurBYWdaGx
         tBlD8jhpaF1DjxIfGQ8zEVQJTfDOoWiIx2O0I2ov0MJWuvjLGrwFsRHwdXiYLw5jgX
         CgIBt8suBeBH8XG66NmQWCneNIMeJNQk7l2gLZjYVM0D6rk/PwkQApOIS9+SvcUEyl
         zNkh5nN/SX/lg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 22:41:59 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH] pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper
Date:   Sat, 22 Jul 2023 22:41:56 +0200
Message-Id: <a4a586337d692f0ca396b80d275ba634eb419593.1690058500.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the need of a dedicated function used
with devm_add_action_or_reset().

While at it, use dev_err_probe() which filters -EPROBE_DEFER.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 30 ++++---------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 2f1a08210fd6..b2d05cfe5d8c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1471,11 +1471,6 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 	return 0;
 }
 
-static void rzg2l_pinctrl_clk_disable(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 {
 	struct rzg2l_pinctrl *pctrl;
@@ -1501,33 +1496,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(pctrl->base))
 		return PTR_ERR(pctrl->base);
 
-	pctrl->clk = devm_clk_get(pctrl->dev, NULL);
-	if (IS_ERR(pctrl->clk)) {
-		ret = PTR_ERR(pctrl->clk);
-		dev_err(pctrl->dev, "failed to get GPIO clk : %i\n", ret);
-		return ret;
-	}
+	pctrl->clk = devm_clk_get_enabled(pctrl->dev, NULL);
+	if (IS_ERR(pctrl->clk))
+		return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->clk),
+				     "failed to get GPIO clk\n");
 
 	spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
 
 	platform_set_drvdata(pdev, pctrl);
 
-	ret = clk_prepare_enable(pctrl->clk);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to enable GPIO clk: %i\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_pinctrl_clk_disable,
-				       pctrl->clk);
-	if (ret) {
-		dev_err(pctrl->dev,
-			"failed to register GPIO clk disable action, %i\n",
-			ret);
-		return ret;
-	}
-
 	ret = rzg2l_pinctrl_register(pctrl);
 	if (ret)
 		return ret;
-- 
2.34.1

