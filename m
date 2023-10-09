Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83B17BD6BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbjJIJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345796AbjJIJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD4A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-0006sV-83; Mon, 09 Oct 2023 11:22:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-000NWN-5W; Mon, 09 Oct 2023 11:22:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTB-00C4op-Sc; Mon, 09 Oct 2023 11:22:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] pinctrl: stmfx: Improve error message in .remove()'s error path
Date:   Mon,  9 Oct 2023 10:38:37 +0200
Message-Id: <20231009083856.222030-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oQvuwpLV6jEvG8nPX5IRlTZZ5eR2ugHk+8EMhpV4SKQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wAB8YUxAlLBbwC7CIKjUbWm11DxuAGLQFuF PnKvZq8Ol2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8AAAKCRCPgPtYfRL+ TjJjCAC4Tdc4fTfh4VtpKisfvbBZZ0D+fqAmRlGB0zNqfrv706XALbviXa7gthDeHwPd4lv8wKr Ite+awd5fMyaGbl9XHLZ5gAHQ3JEjV6lPNk8v0CuXjFzEW82fkKMEJSL1Z+1aUG3IFE70SUBZDf 2Od7RaLozqLEEOO+6oerRQDP9UycvcJGkfXOwZ5ZZYOExGr51w3ex6RuIsYMEbniwO7//3JHVdP ZQpEEZvabqVPS+mx/fuF07qQlbpItj0UzV6FspmOKyC1ZVkXk+KMLjbrCzGEcYD5CzrbaKN3daX Yvrtl6ebPOFQICKlYIpv7t5owBQhbumI9X3ZqpTeaTE879qF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core has no handling for errors returned by the .remove()
callback. The only action on error is a dev_warn() with generic error
message that the returned value is returned.

Replace it by a more specific and useful message. Then returning zero is
the right thing to do, the only effect is to suppress the core's
warning.

This prepares the driver for the conversion to .remove_new().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/pinctrl-stmfx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 0974bbf57b54..d7ab82432a52 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -737,11 +737,17 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 static int stmfx_pinctrl_remove(struct platform_device *pdev)
 {
 	struct stmfx *stmfx = dev_get_drvdata(pdev->dev.parent);
+	int ret;
 
-	return stmfx_function_disable(stmfx,
-				      STMFX_FUNC_GPIO |
-				      STMFX_FUNC_ALTGPIO_LOW |
-				      STMFX_FUNC_ALTGPIO_HIGH);
+	ret = stmfx_function_disable(stmfx,
+				     STMFX_FUNC_GPIO |
+				     STMFX_FUNC_ALTGPIO_LOW |
+				     STMFX_FUNC_ALTGPIO_HIGH);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to disable pins (%pe)\n",
+			ERR_PTR(ret));
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.40.1

