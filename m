Return-Path: <linux-kernel+bounces-70864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B10859D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 828AAB23229
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE9224D0;
	Mon, 19 Feb 2024 07:46:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177220B28
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328802; cv=none; b=bZcovw+zbvbgBubUjKKr5MYE2RZRW9svCAAbRyxyzhC9HOkIUXsK04sxj4HhGsauoaHbJ+No5Gs57ihyneZ0Ipmf7Rq2S99zyhT/MhQxirftYj0Mldr/sz+S6GdfGkFv9PV5GyPe0cqoj2XEPdN67aUkWLRESNoHvJ0KF58moZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328802; c=relaxed/simple;
	bh=84E5HYzwICcsAPLnGxCzOsWHLdNNcdnvBZ7Nk0uz224=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhBq8ulMkEAxPrpCHObnZc1SQBgvrjSKH+NqhcLLcZ6STDJPuoF6sB5I5MprUtXP0LzwuKzWQ0TDzcmTKmerRCwf2GxW2ficYvMLsJIdoEIoYrOUHyj4dqX++sa+wQEN/g4UGfc9GZww1ZBJ2OCrBjumPLRyltG20VRnzkVqaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMI-0000Qp-J0; Mon, 19 Feb 2024 08:46:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMI-001bI5-6E; Mon, 19 Feb 2024 08:46:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMI-007bww-0K;
	Mon, 19 Feb 2024 08:46:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] siox: bus-gpio: Simplify using devm_siox_* functions
Date: Mon, 19 Feb 2024 08:46:32 +0100
Message-ID:  <e3c598de536deadc7efef9c21ccb49d31eb240a9.1708328466.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=84E5HYzwICcsAPLnGxCzOsWHLdNNcdnvBZ7Nk0uz224=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0wda5i95eWYtLzV7dp2r82PwaiG/Al22sh7A4 IxDlp2A3suJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdMHWgAKCRCPgPtYfRL+ TsWVB/9o4X1BhVmx/VNaWI/raXJXVqyiMDTneymjJWwFm2+yElDqB6sQ4Gcbmy7WAOc5+ruQMjr TkBbc9cVTtL7X4W35KgRkhUUpZHjzSsaasKFW4rBxh8gtuauVmPSC8e5nRC+u0Kgv4q0cubMpNB 1xmJwqfwgbpkuMn9PyvZyQhXnv6310yqGK7MRpBorBrVmYGlcejbr6/lYsbJPJEIrhjhCsNaq3e tdffpXxxe/fkXiZ4qJWkZQHv58zpEv6LYdUax9UkHNzgb1C5OghtxcCXMwFOqaOt4EM42AMz9GS Iiqc4AD+7Vh6XzV8BXnX0NQbxV/VBRWAQl84WaT6IkjiG9Pb
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With the devm variant of siox_master_allocate() and
siox_master_register() the remove callback can be dropped. This also
simplifies the error paths in the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-bus-gpio.c | 64 +++++++++++-------------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
index fdf20fe80059..9e01642e72de 100644
--- a/drivers/siox/siox-bus-gpio.c
+++ b/drivers/siox/siox-bus-gpio.c
@@ -91,65 +91,42 @@ static int siox_gpio_probe(struct platform_device *pdev)
 	int ret;
 	struct siox_master *smaster;
 
-	smaster = siox_master_alloc(&pdev->dev, sizeof(*ddata));
-	if (!smaster) {
-		dev_err(dev, "failed to allocate siox master\n");
-		return -ENOMEM;
-	}
+	smaster = devm_siox_master_alloc(dev, sizeof(*ddata));
+	if (!smaster)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate siox master\n");
 
 	platform_set_drvdata(pdev, smaster);
 	ddata = siox_master_get_devdata(smaster);
 
 	ddata->din = devm_gpiod_get(dev, "din", GPIOD_IN);
-	if (IS_ERR(ddata->din)) {
-		ret = dev_err_probe(dev, PTR_ERR(ddata->din),
-				    "Failed to get din GPIO\n");
-		goto err;
-	}
+	if (IS_ERR(ddata->din))
+		return dev_err_probe(dev, PTR_ERR(ddata->din),
+				     "Failed to get din GPIO\n");
 
 	ddata->dout = devm_gpiod_get(dev, "dout", GPIOD_OUT_LOW);
-	if (IS_ERR(ddata->dout)) {
-		ret = dev_err_probe(dev, PTR_ERR(ddata->dout),
-				    "Failed to get dout GPIO\n");
-		goto err;
-	}
+	if (IS_ERR(ddata->dout))
+		return dev_err_probe(dev, PTR_ERR(ddata->dout),
+				     "Failed to get dout GPIO\n");
 
 	ddata->dclk = devm_gpiod_get(dev, "dclk", GPIOD_OUT_LOW);
-	if (IS_ERR(ddata->dclk)) {
-		ret = dev_err_probe(dev, PTR_ERR(ddata->dclk),
-				    "Failed to get dclk GPIO\n");
-		goto err;
-	}
+	if (IS_ERR(ddata->dclk))
+		return dev_err_probe(dev, PTR_ERR(ddata->dclk),
+				     "Failed to get dclk GPIO\n");
 
 	ddata->dld = devm_gpiod_get(dev, "dld", GPIOD_OUT_LOW);
-	if (IS_ERR(ddata->dld)) {
-		ret = dev_err_probe(dev, PTR_ERR(ddata->dld),
-				    "Failed to get dld GPIO\n");
-		goto err;
-	}
+	if (IS_ERR(ddata->dld))
+		return dev_err_probe(dev, PTR_ERR(ddata->dld),
+				     "Failed to get dld GPIO\n");
 
 	smaster->pushpull = siox_gpio_pushpull;
 	/* XXX: determine automatically like spi does */
 	smaster->busno = 0;
 
-	ret = siox_master_register(smaster);
-	if (ret) {
-		dev_err_probe(dev, ret,
-			      "Failed to register siox master\n");
-err:
-		siox_master_put(smaster);
-	}
-
-	return ret;
-}
-
-static int siox_gpio_remove(struct platform_device *pdev)
-{
-	struct siox_master *master = platform_get_drvdata(pdev);
-
-	siox_master_unregister(master);
-
-	siox_master_put(master);
+	ret = devm_siox_master_register(dev, smaster);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register siox master\n");
 
 	return 0;
 }
@@ -162,7 +139,6 @@ MODULE_DEVICE_TABLE(of, siox_gpio_dt_ids);
 
 static struct platform_driver siox_gpio_driver = {
 	.probe = siox_gpio_probe,
-	.remove = siox_gpio_remove,
 
 	.driver = {
 		.name = DRIVER_NAME,
-- 
2.43.0


