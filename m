Return-Path: <linux-kernel+bounces-78036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E63860E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E3B2410D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C55D916;
	Fri, 23 Feb 2024 09:38:33 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC105D72E;
	Fri, 23 Feb 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681113; cv=none; b=Xki4PkfkUKp6MTd5Zh1A1vyfNRZeo6U6NULi1vdMNIMoMW7FTbPYby+UF06gfRRnol7TNXQk7I/skYPoDnUor/UCLll0l5JseqZXjEZ76jIhkl7qyLB+9xCaqmLd05g3h4AH/4wsKENiIWe8SKeRdYhQu9e5seDdopp2GG5Pams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681113; c=relaxed/simple;
	bh=M8d+TjAR1oWosE8d759Hb+VtQ+FYxyIdZPqoOrZHdOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUPUhtjqqH6E8hC6/NEUzKQiVQafya/ppeS0NzcNxOtJWpGZ+KzPI331Im9qcJwNOgmEGR2Vcx8/rGSm3NkIMU6aTGInOm3H9NeiyxZDojlbQT3wYL3QQi6JelbdbHFt0hFcHqiskWVV2QiwsTSG4jrQw3hZtWxucvfFP+FaBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: PQbY1Vqq0ik8tHt8Mo0gGqVnUtkkzFInPABhwNB4WsLgVEQv+hz3saUDK9QXPc6Xb0rUDzkQpJ
 5RpxM5fD8MxA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 23 Feb 2024 15:07:14 +0530
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
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v2 06/14] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Date: Fri, 23 Feb 2024 15:06:53 +0530
Message-Id: <20240223093701.66034-7-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223093701.66034-1-bhargav.r@ltts.com>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
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
 drivers/mfd/tps6594-spi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index b9428dc12..4458c5db7 100644
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
 	{ .compatible = "ti,tps6594-q1", .data = (void *)&match_data[TPS6594], },
 	{ .compatible = "ti,tps6593-q1", .data = (void *)&match_data[TPS6593], },
 	{ .compatible = "ti,lp8764-q1",  .data = (void *)&match_data[LP8764], },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)&match_data[TPS65224],},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
-- 
2.25.1


