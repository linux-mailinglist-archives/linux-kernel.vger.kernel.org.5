Return-Path: <linux-kernel+bounces-122906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461A88FF45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956F41C29535
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4C7F487;
	Thu, 28 Mar 2024 12:40:42 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA28003B;
	Thu, 28 Mar 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629642; cv=none; b=J5lPmLg67uWjZ2D2iJHUEImGcpE6xSMJvgJt21OaMtonzZk4hwk+ikLS8yxMFxB2ryu1xIM8lMZLBxe5rRj/Rks5Zo37kn5bWYab+JiDxLW/Nh1FzlIUb+P2JVl6WyLXPmCEQnVXVH7L07OBrfsk7CujZkPlam+2k5O0ilcgQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629642; c=relaxed/simple;
	bh=meFra01wSqvik460QI1BkYgoMrU6jS4EmDaaP6c1kkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h73GTt5wPJWx1GzkA0VqccjVkzpigTt1yFK5GBJCc1fuWwfvF1EdtfH+sOteXph/25vpE86o9QQUNDi3OBzMn8z6y5AilA19FoLy7HojDYa6JavbEoPaLt6G+Cj08AAZGK4nyoJR45g3aHDduM8WrTouAHKo1mzxtlz+5OXbDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: BuIRpoMSo6y6zxi47wvQXWLtxNzdoWmp/CkcbQSj/vVbQGFfdAg8hwaVffQEae9H3YBAdQFj9+
 VujdFcF4aNDg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 28 Mar 2024 18:10:37 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jpanis@baylibre.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	eblanc@baylibre.com,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v5 06/11] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Thu, 28 Mar 2024 18:10:11 +0530
Message-Id: <20240328124016.161959-7-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328124016.161959-1-bhargav.r@ltts.com>
References: <20240328124016.161959-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TPS65224 PMIC in TPS6594's SPI driver which has
significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Acked-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/mfd/tps6594-spi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index 82a1c02e3..a9cdc524f 100644
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
@@ -77,16 +77,29 @@ static const struct regmap_config tps6594_spi_regmap_config = {
 	.use_single_write = true,
 };
 
+static const struct regmap_config tps65224_spi_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = TPS6594_REG_DWD_FAIL_CNT_REG,
+	.volatile_table = &tps65224_volatile_table,
+	.reg_read = tps6594_spi_reg_read,
+	.reg_write = tps6594_spi_reg_write,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
 static const struct tps6594_match_data match_data[] = {
 	[TPS6594] = {TPS6594, &tps6594_spi_regmap_config},
 	[TPS6593] = {TPS6593, &tps6594_spi_regmap_config},
 	[LP8764] = {LP8764, &tps6594_spi_regmap_config},
+	[TPS65224] = {TPS65224, &tps65224_spi_regmap_config},
 };
 
 static const struct of_device_id tps6594_spi_of_match_table[] = {
 	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
 	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
 	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },
+	{ .compatible = "ti,tps65224-q1", .data = &match_data[TPS65224],},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
@@ -133,5 +146,5 @@ static struct spi_driver tps6594_spi_driver = {
 module_spi_driver(tps6594_spi_driver);
 
 MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
-MODULE_DESCRIPTION("TPS6594 SPI Interface Driver");
+MODULE_DESCRIPTION("SPI Interface Driver for TPS65224, TPS6594/3, and LP8764");
 MODULE_LICENSE("GPL");
-- 
2.25.1


