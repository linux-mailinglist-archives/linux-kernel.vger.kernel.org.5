Return-Path: <linux-kernel+bounces-102066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B622C87AE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517EBB21451
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D915A4A2;
	Wed, 13 Mar 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMmSysbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40F15A482;
	Wed, 13 Mar 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348446; cv=none; b=Rgor2NYssGxZmgGB5htKod1fsp9hs8SppT0/ae7lBxjGH/L57yTxKWYtobrM9k4kUr6+NpwYCPMcIIMaqLj1xz6TvzihXXrdhaAjfmlb2JFVISHKq0KyxizYn4RIMlK3irR+S9MvthSLCjINph/lOJLmQzJZjroQmLeyMuq9MYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348446; c=relaxed/simple;
	bh=ZVWAyljY+AhMX/8zChvX3ogQPcRmys9NtaHqrY/ZiWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG/jSv6kkXfDGkOsA/yEe55GZChKDBtfPUpD79SUFA7H9dhgKv9EYb3M4a2NVotj4cNB68VCh+lp8V/d7KJ+n+wK2m4h1RDzoAYK/kssCRBhto53WWlFL/4aJLmPF21nviV+CY4tEx/sL3ClN7R52uur7SATrx3ZvHBxic/fQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMmSysbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866D9C433F1;
	Wed, 13 Mar 2024 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348446;
	bh=ZVWAyljY+AhMX/8zChvX3ogQPcRmys9NtaHqrY/ZiWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMmSysbq2x8wHUoE7Hdgj2ieGF2c6qkM1keO2LK+aJVtzdUaAerSaBmSrGhT4H0zP
	 QPAiMo5x3f0vQemsPaHk8/fGpe8afq5wZ52hyqZG+uwEutP+tt+ycYzVWXrGM+G/J1
	 egigXoFi3HQjN1cYCmzfRqQFYF5zO1v5BrxUMItoLEc5ZqR5d94Z54Hk8p8ADoj50r
	 fmtgLisYyn84Jvju8wwaGpNGXv3H5LC3I2RvccIFnSQjEejWgoIH5gKlBEYXA7c20y
	 bgMDDP7pQdYWVqHNcPROdiDc0Ct1d2SFa/AuoOb1Mg9dXkMxub2MXPzhyvwRpW9Xq0
	 miUC0zlImJy+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 40/73] serial: max310x: Make use of device properties
Date: Wed, 13 Mar 2024 12:46:07 -0400
Message-ID: <20240313164640.616049-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andy.shevchenko@gmail.com>

[ Upstream commit c808fab604ca62cff19ee6b261211483830807aa ]

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20201007084635.594991-1-andy.shevchenko@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b35f8dbbce81 ("serial: max310x: prevent infinite while() loop in port startup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index bbf45c0626681..8d42c537ee5ea 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -15,8 +15,8 @@
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
@@ -271,7 +271,7 @@ struct max310x_one {
 	container_of(_port, struct max310x_one, port)
 
 struct max310x_port {
-	struct max310x_devtype	*devtype;
+	const struct max310x_devtype *devtype;
 	struct regmap		*regmap;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
@@ -1262,7 +1262,7 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 }
 #endif
 
-static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
+static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
 	int i, ret, fmin, fmax, freq;
@@ -1488,7 +1488,7 @@ static struct regmap_config regcfg = {
 #ifdef CONFIG_SPI_MASTER
 static int max310x_spi_probe(struct spi_device *spi)
 {
-	struct max310x_devtype *devtype;
+	const struct max310x_devtype *devtype;
 	struct regmap *regmap;
 	int ret;
 
@@ -1500,18 +1500,9 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (spi->dev.of_node) {
-		const struct of_device_id *of_id =
-			of_match_device(max310x_dt_ids, &spi->dev);
-		if (!of_id)
-			return -ENODEV;
-
-		devtype = (struct max310x_devtype *)of_id->data;
-	} else {
-		const struct spi_device_id *id_entry = spi_get_device_id(spi);
-
-		devtype = (struct max310x_devtype *)id_entry->driver_data;
-	}
+	devtype = device_get_match_data(&spi->dev);
+	if (!devtype)
+		devtype = (struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
 
 	regcfg.max_register = devtype->nr * 0x20 - 1;
 	regmap = devm_regmap_init_spi(spi, &regcfg);
@@ -1536,7 +1527,7 @@ MODULE_DEVICE_TABLE(spi, max310x_id_table);
 static struct spi_driver max310x_spi_driver = {
 	.driver = {
 		.name		= MAX310X_NAME,
-		.of_match_table	= of_match_ptr(max310x_dt_ids),
+		.of_match_table	= max310x_dt_ids,
 		.pm		= &max310x_pm_ops,
 	},
 	.probe		= max310x_spi_probe,
-- 
2.43.0


