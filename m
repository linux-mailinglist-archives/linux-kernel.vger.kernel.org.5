Return-Path: <linux-kernel+bounces-11139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886D81E1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B626B217B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08930537F0;
	Mon, 25 Dec 2023 18:13:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93452F99
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS2-00024Z-Ur; Mon, 25 Dec 2023 19:13:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS1-001TaX-2O; Mon, 25 Dec 2023 19:13:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS2-000xTC-0G;
	Mon, 25 Dec 2023 19:13:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v2 2/2] bus: ts-nbus: Improve error reporting
Date: Mon, 25 Dec 2023 19:12:53 +0100
Message-ID:  <6543044bcf6f53d7807ea8c8e92de5d05405b5e4.1703527372.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703527372.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703527372.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4331; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Ra+uYWwhblxNzXJQDojcVngsE0ksUba1CDXh77gitc4=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBlicYtP4Bsv6XoCUWLumYfdlBcOH/lmL/J3wdW3 gS/l1WuwrmJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYnGLQAKCRCPgPtYfRL+ TgVZB/inikIMAJsyIcXqIsf+Mthfnbuh/VpeyC4TXTzX4nObrfoVM6qotd6i5szlkJCT8NORSlU FIRsV3e14JrBGnVcOPwQL/39HR8sllkf9IjYLBblUWTpD1WOKpcXEH9IxUPgMTnbjccSEeXCCfG f01VYSeRndcWXvtopjJ1HrltCbgk7hCP/QLLUCr4m6Vb8wSOgWdOda6SDWxieHVMpBhVhXfUfyd cbYte5MoKCbraJdx9CGzKQB03xHnpUdIVBMdFW5JlKKo+6XjpPSdC7Vz4y/YNKnGXWBHziLIsGR sQiO+ZwyY5W0STa3sLIGkbkYJCxzchvLJTDP3cbSp5ZADis=
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Using dev_err_probe() brings several improvements:

 - emits the symbolic error code
 - properly handles EPROBE_DEFER
 - combines error message generation and return value handling

While at it add error messages to two error paths that were silent
before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/ts-nbus.c | 66 ++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 19c5d1f4e4d7..baf22a82c47a 100644
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
@@ -289,25 +283,20 @@ static int ts_nbus_probe(struct platform_device *pdev)
 		return ret;
 
 	pwm = devm_pwm_get(dev, NULL);
-	if (IS_ERR(pwm)) {
-		ret = PTR_ERR(pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "unable to request PWM\n");
-		return ret;
-	}
+	if (IS_ERR(pwm))
+		return dev_err_probe(dev, PTR_ERR(pwm),
+				     "unable to request PWM\n");
 
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
@@ -321,7 +310,8 @@ static int ts_nbus_probe(struct platform_device *pdev)
 
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "failed to populate platform devices on bus\n");
 
 	dev_info(dev, "initialized\n");
 
-- 
2.43.0


