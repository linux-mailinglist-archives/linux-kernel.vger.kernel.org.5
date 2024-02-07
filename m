Return-Path: <linux-kernel+bounces-56944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E784D1A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80761F24F53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193DF134738;
	Wed,  7 Feb 2024 18:43:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07345129A61
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331408; cv=none; b=rHKAdUbFL8++xMfaDrfx+TyHSUCY08sovqX+xEDTMfTgiwXenZYAk2hzMhp6a27KyKdcLozp7q34zJV2PxdnHc7A7XGbG04Vzc5Z7Wmf91tsQAbW62atDVwBkZAmv0sFQT8PsyF94hFnfCIcSzfsw1BBhAsKFgXQp0yjUA1lDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331408; c=relaxed/simple;
	bh=bUQZzxWEsC38j5u4o12sYWtgM3xTR+LDUOMiAhoEnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q13E/+4ok4cS2u/4qjTGq+fo6QKp5TO5WfnRONCFtGuNGtFNWHBKoBzhA/55GsEWBGwWRO7sbn3iDrCGiqgvGalPTYUDeUtpdSbbCNUoryuSuPM95sQMXh3QCW4YJUb8HVMzHLernTuKL4LPlJZwPcF0PUXUi5VEdAg3HcXoB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtE-00088R-Ok; Wed, 07 Feb 2024 19:43:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtD-0054Yj-Sn; Wed, 07 Feb 2024 19:43:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtD-00HRtp-2c;
	Wed, 07 Feb 2024 19:43:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 30/32] spi: fsl-lib: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:44 +0100
Message-ID:  <b3d724ca2b641f1d717a7ddb9810bdf27168dc35.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bUQZzxWEsC38j5u4o12sYWtgM3xTR+LDUOMiAhoEnzE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw87ltl4tVo3cFqk/0IdUsQFIoJbQHkNzE5gWK EWgNSMBcf+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPO5QAKCRCPgPtYfRL+ TicdCAC1XkEoNZMlg4ApVYE8yo8ttSKyIOhZLZ9vhIHhpoPwmTY55khxCExzpRGRHKKS5TEf4PP NYRkeoYEuXLdIfw0KhNIyw29zsD75wITrujNmwjefNrWdGo8r+/gZYKLtiWbi9RJkaUCzfz1jg9 I90pMe0UtlcKlA6+id+4aXTDbH61Ux3cc73flTWYLBPuJO00f8+5LjTDeqlq9l5WLrIMG01iOv4 57Nkg5xSKFe+Gl+7e9Ig9+kP0Z4yhumT/qaHKfJrIaWR9BEzDyjfU7xduZvbb4x7Wmw8SgsiYkE MmksSAVm//EJZbufNzFR2LIr5vpR3g3fRNc8vpXCwHswwUaT
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-fsl-lib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 885757c29fbb..4fc2c56555b5 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -82,18 +82,18 @@ void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 			unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct mpc8xxx_spi *mpc8xxx_spi;
 
-	master = dev_get_drvdata(dev);
+	ctlr = dev_get_drvdata(dev);
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
 			| SPI_LSB_FIRST | SPI_LOOP;
 
-	master->dev.of_node = dev->of_node;
+	ctlr->dev.of_node = dev->of_node;
 
-	mpc8xxx_spi = spi_master_get_devdata(master);
+	mpc8xxx_spi = spi_controller_get_devdata(ctlr);
 	mpc8xxx_spi->dev = dev;
 	mpc8xxx_spi->get_rx = mpc8xxx_spi_rx_buf_u8;
 	mpc8xxx_spi->get_tx = mpc8xxx_spi_tx_buf_u8;
@@ -104,8 +104,8 @@ void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 	mpc8xxx_spi->rx_shift = 0;
 	mpc8xxx_spi->tx_shift = 0;
 
-	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->max_chipselect;
+	ctlr->bus_num = pdata->bus_num;
+	ctlr->num_chipselect = pdata->max_chipselect;
 
 	init_completion(&mpc8xxx_spi->done);
 }
-- 
2.43.0


