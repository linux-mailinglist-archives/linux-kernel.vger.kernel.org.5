Return-Path: <linux-kernel+bounces-57718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5040084DCB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838A21C21796
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB076E2B3;
	Thu,  8 Feb 2024 09:20:57 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6116BFA9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384057; cv=none; b=B59atcQ71mKlGOA49EA0GbYsMCk2wAsZtfAsOdExfzoy/WgM/KpfCsBWp0HbAGVBiELT+cnld5h2eeW5EbCVf2cQh/IibgVUKE3VpJGtDuS8ZD7/VLAYAJiAu8yzJMtdjpKm9dO2AMOjiZBa523wC8IQBFG6CMRVMaB7pBNW4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384057; c=relaxed/simple;
	bh=QEhLrpWSamTGYLYMwHJ3aLQ/OdCpxb6FCO3gAWHGCTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOrfbKqQZrpJvTPBtEEeTmEkqmZJ6ApBsEhcuABK+aZSNQP0eYU//hN1uzfydiVAzp+xNbiKf+q/YJ0F/FmGvDtSl4BvtW1pM1TP0nZVTGb5CfWeOdxnnpJn5W6OiIhQksOucNfREMG5+z/YnFhHLAuKexQ0iC3oGCBqV6dN1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: kYbrwjj5HXgnK2Aj2YIBiLoonUN60hvCRRStpk6I1rrFem8+AZFTTna9JzSaBhqObcXcjX7ZE4
 Cjp/oceqdIvQ==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 08 Feb 2024 14:50:48 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 05/13] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Thu,  8 Feb 2024 14:50:33 +0530
Message-Id: <20240208092034.1207057-2-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208092034.1207057-1-bhargav.r@ltts.com>
References: <20240208092034.1207057-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TPS65224 PMIC in the TPS6594 driver as they share
significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/mfd/tps6594-spi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index 5afb1736f..7ec66d31b 100644
--- a/drivers/mfd/tps6594-spi.c
+++ b/drivers/mfd/tps6594-spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SPI access driver for TI TPS6594/TPS6593/LP8764 PMICs
+ * SPI access driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -66,7 +66,7 @@ static int tps6594_spi_reg_write(void *context, unsigned int reg, unsigned int v
 	return spi_write(spi, buf, count);
 }
 
-static const struct regmap_config tps6594_spi_regmap_config = {
+static struct regmap_config tps6594_spi_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
@@ -81,6 +81,7 @@ static const struct of_device_id tps6594_spi_of_match_table[] = {
 	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
 	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
 	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
@@ -101,15 +102,18 @@ static int tps6594_spi_probe(struct spi_device *spi)
 	tps->reg = spi_get_chipselect(spi, 0);
 	tps->irq = spi->irq;
 
-	tps->regmap = devm_regmap_init(dev, NULL, spi, &tps6594_spi_regmap_config);
-	if (IS_ERR(tps->regmap))
-		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
-
 	match = of_match_device(tps6594_spi_of_match_table, dev);
 	if (!match)
 		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
 	tps->chip_id = (unsigned long)match->data;
 
+	if (tps->chip_id == TPS65224)
+		tps6594_spi_regmap_config.volatile_table = &tps65224_volatile_table;
+
+	tps->regmap = devm_regmap_init(dev, NULL, spi, &tps6594_spi_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
+
 	crc8_populate_msb(tps6594_spi_crc_table, TPS6594_CRC8_POLYNOMIAL);
 
 	return tps6594_device_init(tps, enable_crc);
-- 
2.25.1


