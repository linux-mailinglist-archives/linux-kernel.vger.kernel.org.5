Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730A780B6E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjLIWf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:35:26 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5410C7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 14:35:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rC5uw-00032j-Ox; Sat, 09 Dec 2023 23:35:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rC5uw-00EjdO-6I; Sat, 09 Dec 2023 23:35:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rC5uv-00HPIV-TP; Sat, 09 Dec 2023 23:35:25 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] bus: ts-nbus: Improve error reporting
Date:   Sat,  9 Dec 2023 23:35:09 +0100
Message-ID:  <20702efe8ab96add9773e97ceed1a6cf91a065ee.1702160838.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702160838.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702160838.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4311; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8lzqMiv8dr6oNnog2haq92zmbN0yI9Y65SNt9GRuK+U=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSS18tP5CTKCZYfm9VTU9H/nH3B4b7yWrabh5ubU4Tst vxbwdzVyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBErp1m/6f37b84p5vl9Ofm 8+f6yiWxGRU168THrJyYLi5155OC+dfIa4sqrI2Ln35+rLko7dPDfzcnsUmEeC3SrfJsuCe7TzV UQqXW9kv+u//ilgz7fQVCk5R43p6P0vzKsOwkz7vUHd+E285P05yzYLaeKuNNSfastZfjO23OCy h3Komn525nN1QSy7lyi+lw+ny1m6oXbvYk9wT+EJ2rXC9RejH87coV9mbPPCyeN7GpWSyo5RLvc tihK/1ykupdqw0O2ZHVrus+ck1v8JHU/DPp8YYDryt3svdKtv19Z2v+b3pMwZroSsfQt1L1Hmt9 FlZ7S2T8vRnyonxu944Gvv5HyYyBGyvb9z6ZJTPNeMsbAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err_probe() brings several improvements:

 - emits the symbolic error code
 - properly handles EPROBE_DEFER
 - combines error message generation and return value handling

While at it add error messages to two error paths that were silent
before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/ts-nbus.c | 65 ++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 19c5d1f4e4d7..89c6ce1403e3 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -39,45 +39,39 @@ struct ts_nbus {
 /*
  * request all gpios required by the bus.
  */
-static int ts_nbus_init_pdata(struct platform_device *pdev, struct ts_nbus
-		*ts_nbus)
+static int ts_nbus_init_pdata(struct platform_device *pdev,
+			      struct ts_nbus *ts_nbus)
 {
 	ts_nbus->data = devm_gpiod_get_array(&pdev->dev, "ts,data",
 			GPIOD_OUT_HIGH);
-	if (IS_ERR(ts_nbus->data)) {
-		dev_err(&pdev->dev, "failed to retrieve ts,data-gpio from dts\n");
-		return PTR_ERR(ts_nbus->data);
-	}
+	if (IS_ERR(ts_nbus->data))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->data),
+				     "failed to retrieve ts,data-gpio from dts\n");
 
 	ts_nbus->csn = devm_gpiod_get(&pdev->dev, "ts,csn", GPIOD_OUT_HIGH);
-	if (IS_ERR(ts_nbus->csn)) {
-		dev_err(&pdev->dev, "failed to retrieve ts,csn-gpio from dts\n");
-		return PTR_ERR(ts_nbus->csn);
-	}
+	if (IS_ERR(ts_nbus->csn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->csn),
+			      "failed to retrieve ts,csn-gpio from dts\n");
 
 	ts_nbus->txrx = devm_gpiod_get(&pdev->dev, "ts,txrx", GPIOD_OUT_HIGH);
-	if (IS_ERR(ts_nbus->txrx)) {
-		dev_err(&pdev->dev, "failed to retrieve ts,txrx-gpio from dts\n");
-		return PTR_ERR(ts_nbus->txrx);
-	}
+	if (IS_ERR(ts_nbus->txrx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->txrx),
+				     "failed to retrieve ts,txrx-gpio from dts\n");
 
 	ts_nbus->strobe = devm_gpiod_get(&pdev->dev, "ts,strobe", GPIOD_OUT_HIGH);
-	if (IS_ERR(ts_nbus->strobe)) {
-		dev_err(&pdev->dev, "failed to retrieve ts,strobe-gpio from dts\n");
-		return PTR_ERR(ts_nbus->strobe);
-	}
+	if (IS_ERR(ts_nbus->strobe))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->strobe),
+				     "failed to retrieve ts,strobe-gpio from dts\n");
 
 	ts_nbus->ale = devm_gpiod_get(&pdev->dev, "ts,ale", GPIOD_OUT_HIGH);
-	if (IS_ERR(ts_nbus->ale)) {
-		dev_err(&pdev->dev, "failed to retrieve ts,ale-gpio from dts\n");
-		return PTR_ERR(ts_nbus->ale);
-	}
+	if (IS_ERR(ts_nbus->ale))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->ale),
+				     "failed to retrieve ts,ale-gpio from dts\n");
 
 	ts_nbus->rdy = devm_gpiod_get(&pdev->dev, "ts,rdy", GPIOD_IN);
-	if (IS_ERR(ts_nbus->rdy)) {
-		dev_err(&pdev->dev, "failed to retrieve ts,rdy-gpio from dts\n");
-		return PTR_ERR(ts_nbus->rdy);
-	}
+	if (IS_ERR(ts_nbus->rdy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ts_nbus->rdy),
+				     "failed to retrieve ts,rdy-gpio from dts\n");
 
 	return 0;
 }
@@ -289,25 +283,19 @@ static int ts_nbus_probe(struct platform_device *pdev)
 		return ret;
 
 	pwm = devm_pwm_get(dev, NULL);
-	if (IS_ERR(pwm)) {
-		ret = PTR_ERR(pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "unable to request PWM\n");
-		return ret;
-	}
+	if (IS_ERR(pwm))
+		return dev_err_probe(dev, ret, "unable to request PWM\n");
 
 	pwm_init_state(pwm, &state);
-	if (!state.period) {
-		dev_err(&pdev->dev, "invalid PWM period\n");
-		return -EINVAL;
-	}
+	if (!state.period)
+		return dev_err_probe(dev, -EINVAL, "invalid PWM period\n");
 
 	state.duty_cycle = state.period;
 	state.enabled = true;
 
 	ret = pwm_apply_state(pwm, &state);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to configure PWM\n");
 
 	/*
 	 * we can now start the FPGA and populate the peripherals.
@@ -321,7 +309,8 @@ static int ts_nbus_probe(struct platform_device *pdev)
 
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "failed to populate platform devices on bus\n");
 
 	dev_info(dev, "initialized\n");
 
-- 
2.42.0

