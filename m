Return-Path: <linux-kernel+bounces-108766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3C880FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F60B23681
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9647F6B;
	Wed, 20 Mar 2024 10:26:27 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29940843;
	Wed, 20 Mar 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930386; cv=none; b=tmxww8bcEnvm6y8fZXPveC1ttvVJi2+S42eBQR8wr9mTDDREzpq6faFb8VfRNUyQZoijWY+fnjWdE/8qhra3K42CS/snhssmHZbWu/xdkb6BKLTUnYUcRSH86571KrlbASkTq7Hh1yxAT5X/U3ZNqX/Ag2NLzpnXIVx4/jnK5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930386; c=relaxed/simple;
	bh=meFra01wSqvik460QI1BkYgoMrU6jS4EmDaaP6c1kkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RFVkZsugyPPcGjYAh5OH3Tc8ZGKnlGYAN67+WbyHT6675fN67wxFs9kG5B3UWj2+42BOAg28jsOsNbF8BXZVEvzDjk5GO3RIk6Wc3uSjDQRGOcBNsQmPpPwrt4mP4xI1WyANq49oyZ5HjHlOD3jDFd1gdsy/nPUoFVczdwUDO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: DGqQ5P+8fHtHKecCscuy5+Eb73BNAZLwdU7bSHyKRWwrPaeq36rZ9FsUZiet8YW7waB3uKtQ1L
 cdEUPWIBxr/Q==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 20 Mar 2024 15:56:17 +0530
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
Subject: [PATCH v4 06/11] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Wed, 20 Mar 2024 15:55:54 +0530
Message-Id: <20240320102559.464981-7-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320102559.464981-1-bhargav.r@ltts.com>
References: <20240320102559.464981-1-bhargav.r@ltts.com>
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


