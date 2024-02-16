Return-Path: <linux-kernel+bounces-68162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF238576B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7D41F2305B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E614AB7;
	Fri, 16 Feb 2024 07:18:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCC2F44
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067928; cv=none; b=D5v5Y/OSumXChn5gTZZg+0LFjVGR9wq64++MOy+qyEeGMinuvYDxyb32Gll67imWqRn5XKqjfIPOse9FW5S+KGsrC4YFWBNC/Uj205sOBZbTPaZnp1SEPMH7r/bOcT1uIHRO56lZro3TXm0d4ln1SYhwkjum014/LmmJ/ajRpEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067928; c=relaxed/simple;
	bh=5YYd1mc9oE4gQ6nfD69b18mEEMCG2oT720uDPviPQGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K32jw17CSqz+u2gjOlnx4Jwf0wr3qdYvaXMK64k9kQW9KxwA6ZITRhKAMy5B0Yg5Jh0wu8c7Ejs7OYfrcdeKdNo128VqOEsTEKfR8ds4i4uZy1JPkv24ELoK3k1W0kSYkkieYpXMljxJE2MSyr6SHhBp4xp5YzDSHH3JKUKmpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rasUc-00020h-0H; Fri, 16 Feb 2024 08:18:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rasUb-001244-2w; Fri, 16 Feb 2024 08:18:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rasUb-005pqX-01;
	Fri, 16 Feb 2024 08:18:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] regulator: pwm-regulator: Use dev_err_probe() for error paths in .probe()
Date: Fri, 16 Feb 2024 08:18:30 +0100
Message-ID: <20240216071829.1513748-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3378; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5YYd1mc9oE4gQ6nfD69b18mEEMCG2oT720uDPviPQGk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzwxGyClUmA1tGdWbOOkZJ5+vxLG7c/5ZA3CfU b/KKog8kgCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZc8MRgAKCRCPgPtYfRL+ TgV2B/9xLhveg3237uG5nURdadNydHctCiCuZ9fxi+jMDEK3Oue+rcxZcc8Szd/qvkrUNZJAivU 6ZvNBvup9Z0xHY1vk2+7HuUJQ+1/4scf8dDO9v+RMvwcECH15viq88pzHK3+PVs2rvn+RkIjG7C 5FvQTRiq52bbBiUSwP/uipgpLvljCLSNIEev5QDrA3LKfSKQ1UZkuevp7ReMeSGsNctlMPf8P8q e14fXn6or2l3mrUfgMn0C8DJAVfOayiWzgeJDIRP9dXGpvaY96X1LiqdMtzaIfvv1bZCOvNG6NE bVQy71HdiJm7x8+vT1iluzYUaw6I4PDiARCPB+RSQlPUxvsC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

One error path already used the dev_err_probe() helper. Make use of it
in the other error paths, too, for consistent output. This results in a
more compact source code and symbolic output of the error code.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/regulator/pwm-regulator.c | 40 +++++++++++++------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 60cfcd741c2a..7434b6b22d32 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -271,11 +271,10 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 	of_find_property(np, "voltage-table", &length);
 
 	if ((length < sizeof(*duty_cycle_table)) ||
-	    (length % sizeof(*duty_cycle_table))) {
-		dev_err(&pdev->dev, "voltage-table length(%d) is invalid\n",
-			length);
-		return -EINVAL;
-	}
+	    (length % sizeof(*duty_cycle_table)))
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "voltage-table length(%d) is invalid\n",
+				     length);
 
 	duty_cycle_table = devm_kzalloc(&pdev->dev, length, GFP_KERNEL);
 	if (!duty_cycle_table)
@@ -284,10 +283,9 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 	ret = of_property_read_u32_array(np, "voltage-table",
 					 (u32 *)duty_cycle_table,
 					 length / sizeof(u32));
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to read voltage-table: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to read voltage-table\n");
 
 	drvdata->state			= -ENOTRECOVERABLE;
 	drvdata->duty_cycle_table	= duty_cycle_table;
@@ -359,10 +357,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	enum gpiod_flags gpio_flags;
 	int ret;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Device Tree node missing\n");
-		return -EINVAL;
-	}
+	if (!np)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Device Tree node missing\n");
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -400,8 +397,7 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 						    gpio_flags);
 	if (IS_ERR(drvdata->enb_gpio)) {
 		ret = PTR_ERR(drvdata->enb_gpio);
-		dev_err(&pdev->dev, "Failed to get enable GPIO: %d\n", ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret, "Failed to get enable GPIO\n");
 	}
 
 	ret = pwm_adjust_config(drvdata->pwm);
@@ -409,19 +405,17 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = pwm_regulator_init_boot_on(pdev, drvdata, init_data);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to apply boot_on settings: %d\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to apply boot_on settings\n");
 
 	regulator = devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
 	if (IS_ERR(regulator)) {
 		ret = PTR_ERR(regulator);
-		dev_err(&pdev->dev, "Failed to register regulator %s: %d\n",
-			drvdata->desc.name, ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register regulator %s\n",
+				     drvdata->desc.name);
 	}
 
 	return 0;

base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
-- 
2.43.0


