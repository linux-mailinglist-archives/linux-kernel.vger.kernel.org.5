Return-Path: <linux-kernel+bounces-56929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0084D187
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725DE1C222AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF171272A4;
	Wed,  7 Feb 2024 18:43:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825F85299
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331403; cv=none; b=iBx1u5p5RBGG/zRPRHUB9bdItccs+YCa5+PCuJ+50hVi+6UGx45Gw6HUDrAEn/QVq4o3/5xLylwrqTdw6ni+bldYhQ5obwsahD4DwodzJ07NjfHaLKm4RscOw9Nzag4mitkKY/YceqU2Ne4I2KRlMrrJTUYVvYtHPpctXAx1jLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331403; c=relaxed/simple;
	bh=ilkLmZbJFb+/vAwyD9IAoZLec6Zu+zWHyeLngMmfIFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVKGzqgH6fNW864gsG7uYraD73j8yMbVw8UEMN1q1M3DD7xvfYveOIh5vAycTdetAW3ifatQa/Hbsgl/421qy2MZw08ijZfyspjjdMBeIgMxr+8faZQUnwDEEAvBm1aznqkkkTXBoHgrMUT6/V2fZjXsDbOzw0++6pdYY9Uqhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007PK-4K; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-0054X3-Nn; Wed, 07 Feb 2024 19:43:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt2-00HRs1-25;
	Wed, 07 Feb 2024 19:43:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 05/32] Input: synaptics-rmi4 - follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:19 +0100
Message-ID:  <b88413456c970a97319fa7e505768bf82966541b.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ilkLmZbJFb+/vAwyD9IAoZLec6Zu+zWHyeLngMmfIFQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86b5uqZYly+euxtkXa5tiGRisTdifEuh1Ixy mC277T9rpOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOmwAKCRCPgPtYfRL+ TjEoCAC0nEJ9m1CYYfN8CT2VU987E9pfcisamQB6slHvQYnnkIKDQ7cDsZNuhYqqB9wNG0+GXCe TjkpSkoUhRbcNKtesSG8lYCH2IwfVRo5qXpoOQ3QrsVMwf3LX1Vttey0H7ktM6HjNuXaAV9il7D FFVN4HK+ktpdAbdxAjtz7PnH4Mmr5odBWM8D1ApH6Hc5aEVc/gdMwN55cPSSSQLhmD1xcBsA4UM kfJgrghTBPids2dkXNIhnXBc2b4yzr4JkqCswoWrD2ag3POBuwbNO7OULQGqM4JoYwYOfP0ZmkW tiSoFjptqTdpseeXaMHymOMtanZV3W+pzFOdjHfdLHxDT523
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

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/input/rmi4/rmi_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 07c866f42296..9d92129aa432 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -375,7 +375,7 @@ static int rmi_spi_probe(struct spi_device *spi)
 	struct rmi_device_platform_data *spi_pdata = spi->dev.platform_data;
 	int error;
 
-	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		return -EINVAL;
 
 	rmi_spi = devm_kzalloc(&spi->dev, sizeof(struct rmi_spi_xport),
-- 
2.43.0


