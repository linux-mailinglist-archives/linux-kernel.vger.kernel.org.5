Return-Path: <linux-kernel+bounces-56925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B184D17F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09701C26CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E5128811;
	Wed,  7 Feb 2024 18:43:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE185653
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331402; cv=none; b=lZ8ZISm88zVv7rKqHgzEqfKIaOI0eB8PzxEYi1MVkgav7xMS4D8+DIvcz78Q1+qn4lKw0+qNVxGrvBVqLXEYFq4RPHwqLJdZNJmtPzexzHEjTGbEeImLWvEP1P2mv02UORXy+rTMiiHZFG/P/sUKgF8oenxdFo40QEKDLfuPN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331402; c=relaxed/simple;
	bh=dhWD0Z+YKaeUZzQu8zoOP/L7SnMkWJpfcn5P3JRhYV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMCwVvHUXtXRaCC0gMTrYOXxlccxxM0xQOoWIzJPcTd+aS/xg3Jn7vqILIbsf15/iuupxuCimB4kNpO/cEGVr7MVbdFYdDazXGPv5Idlf3hvgh7rxQrC4v2y75vCZPvqJ++tv7aCToHJJj91/slxJQ6A734iuYFDU7WVMFEsbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007PM-4K; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-0054X6-W8; Wed, 07 Feb 2024 19:43:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-00HRs5-2w;
	Wed, 07 Feb 2024 19:43:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 06/32] media: mgb4: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:20 +0100
Message-ID:  <ccad7ad4176265bf90af92add18a0242652f5a84.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=dhWD0Z+YKaeUZzQu8zoOP/L7SnMkWJpfcn5P3JRhYV4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTD5+b8nvLdg0uIv+DIlSi5rQ/jvPSusKarLAqvcjfNK uf16q/vZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAip6ew/89Wu7H96PW3+reP sb/fONlNtlGfJ7JacMHpX9022uvvBx15sKcj7m2dB2/Xt3C2ewWr0vSnMXeJ/1LWLu0Q81hnxqA Qkpg+52B1rvGSktVaRoJxEk8v2vutD65lXT1BOXmrbJ6E2OtnG32N7UIy537afXqK90Z+G7mCVr 6TuamKnzb7RR39Yinva7azLtE17uOWno53Kd3nZlq8XZUsmy3wIpZLcn3L7FWMejafnnI1yXW// rh7njSzt9CWp6us0rrNH66ewZ1lu2vGNIvkoMPs+3PVO4Ku/vAqbtUVWDXdMJd92/b7S2yWG28p Sl6dPksq6uWBr59aqxTjnSUFfps5aK2/fuNBSW5OkvUuAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Reviewed-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/media/pci/mgb4/mgb4_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index 5bfb8a06202e..9bcf10a77fd3 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -144,7 +144,7 @@ static int match_spi_adap(struct device *dev, void *data)
 	return to_spi_device(dev) ? 1 : 0;
 }
 
-static struct spi_master *get_spi_adap(struct platform_device *pdev)
+static struct spi_controller *get_spi_adap(struct platform_device *pdev)
 {
 	struct device *dev;
 
@@ -152,7 +152,7 @@ static struct spi_master *get_spi_adap(struct platform_device *pdev)
 	dev = device_find_child(&pdev->dev, NULL, match_spi_adap);
 	mutex_unlock(&pdev->dev.mutex);
 
-	return dev ? container_of(dev, struct spi_master, dev) : NULL;
+	return dev ? container_of(dev, struct spi_controller, dev) : NULL;
 }
 
 static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
@@ -179,7 +179,7 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 	};
 	struct pci_dev *pdev = mgbdev->pdev;
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct spi_device *spi_dev;
 	u32 irq;
 	int rv, id;
@@ -207,8 +207,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 		return PTR_ERR(mgbdev->spi_pdev);
 	}
 
-	master = get_spi_adap(mgbdev->spi_pdev);
-	if (!master) {
+	ctlr = get_spi_adap(mgbdev->spi_pdev);
+	if (!ctlr) {
 		dev_err(dev, "failed to get SPI adapter\n");
 		rv = -EINVAL;
 		goto err_pdev;
@@ -242,8 +242,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 
 	spi_info.platform_data = &mgbdev->flash_data;
 
-	spi_dev = spi_new_device(master, &spi_info);
-	put_device(&master->dev);
+	spi_dev = spi_new_device(ctlr, &spi_info);
+	put_device(&ctlr->dev);
 	if (!spi_dev) {
 		dev_err(dev, "failed to create MTD device\n");
 		rv = -EINVAL;
-- 
2.43.0


