Return-Path: <linux-kernel+bounces-102151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7B87AED8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C984DB24249
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE97602F;
	Wed, 13 Mar 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkzZMD4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895075811;
	Wed, 13 Mar 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349367; cv=none; b=DDIXRiBUAGTeyYVTILSs/gAtNAdxNngCKk2jDKiL7bg6ckQUNsNqxbl6H+QR9s5aLnnXIR3OPYNOV88IdWEmy8mN39vrcKvEoZEJnkraFnQawilP3p2ajgBWNBXX0Knv09rQ4Z0UrMr588fK/aUlFfZ4Y5jqEHbYcawOGFou3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349367; c=relaxed/simple;
	bh=ZVWAyljY+AhMX/8zChvX3ogQPcRmys9NtaHqrY/ZiWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGHR8G67zDEcr4ms9R93t+91z7S0UKrMrSRFU8qorXG4Vx7loc+6oWOt0nKbDIojRy3763qYOxwn04XpC8jxoBSfm/9WUNMIKmMKPMzEty4uLR77tnqrr9jFD/1CbU/At+bsKwSyqYBcoZXjosm1I1hmVmWWL1NW81t1ZZHDX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkzZMD4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CB9C433B1;
	Wed, 13 Mar 2024 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349367;
	bh=ZVWAyljY+AhMX/8zChvX3ogQPcRmys9NtaHqrY/ZiWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkzZMD4C+vcNXWkHmWKu9RWcJgkiKZiaymkZQbpIwsp+tv4L3eY/5WNvjIs59rKg5
	 7DE6l24GS82KqrKIwoiACjaEEGSL0JBhpsDOaHXzkUKo/Oa2vACbPVpOgHOwXIGKxZ
	 GMIfcsTdWkhtl782IsuhuvLNgbXremwG6xHuPHsb+eMLGdI5J93Em5aHfVDQH80VIB
	 epZoM3kOlShl8vkfM6/WQ27/SsLHCTyPP40txrzRKSjPkXxSHhOqGzsZzJ12/Cz8sG
	 T2tqzXDb99xkYrh88ra3SzxedFt3ta+iKIyHv+/JJpI/dkGrPFpwi4n7Q0NNCzEtnH
	 S/J0ayLo6TxnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 30/51] serial: max310x: Make use of device properties
Date: Wed, 13 Mar 2024 13:01:51 -0400
Message-ID: <20240313170212.616443-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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


