Return-Path: <linux-kernel+bounces-4759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BD8181A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B811C234D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F72C15F;
	Tue, 19 Dec 2023 06:44:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB4C12A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTq9-0008Bn-5x; Tue, 19 Dec 2023 07:44:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTq8-00Gs4s-0I; Tue, 19 Dec 2023 07:44:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTq7-005oH4-NJ; Tue, 19 Dec 2023 07:44:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel@pengutronix.de,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] bus: ts-nbus: Improve error reporting
Date: Tue, 19 Dec 2023 07:44:15 +0100
Message-ID:  <08f13bf08385784814d7250066b31a735cae3d3d.1702967898.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To:  <6ae9784dfb98ff63b44735b903e7f4d4e3980222.1702967898.git.u.kleine-koenig@pengutronix.de>
References:  <6ae9784dfb98ff63b44735b903e7f4d4e3980222.1702967898.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=e7IKKIepL5PZrMx4Tu9V+DsjoB/iOlb4YfTz/Yi9L8I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgTu/+0ae8AfzHvbZ+jZNPQelAi/ZpxF1lPaeb BOlBFewrUOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYE7vwAKCRCPgPtYfRL+ Tu0MB/0bJUyYRIGF7ZqmNgg62UNAGhU7B7JuTipYpTFGpwkgzIma1+j6wfs+vN3rVu7ALfL5kJh NwX4RMHpkzb7z5oAA4OFVj41GrwxGH9z1kDgjXNquZnLKGhzdhawkH0aciuP/WwWHiQ+nNKVdCo R7WmRCWhf6URwP/Wzgbs3+zLKntwSZZ8sORdjJnn1fGVCwcCFnB6S/vZlKsHHW8x9Ccx8qRSl/0 pV38kHy0Zz0sRE9uiEJNLAkWp0i1VEypVPgQwmnJZCny7YDX9BkDJ8La0Hq+ZU3yN2cj7TBlG+V eEghNMn7vrXRJW2INU7WpSNaq28lEBpan0UXF4tOyvUBPQdh
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
Changes since (implicit) v1
(https://lore.kernel.org/linux-kernel/20702efe8ab96add9773e97ceed1a6cf91a065ee.1702160838.git.u.kleine-koenig@pengutronix.de):

- Fix return value in one error path (Christophe JAILLET)
- Rebase to today's next (trivial)

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
2.42.0


