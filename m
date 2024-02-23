Return-Path: <linux-kernel+bounces-78037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95419860E41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3791D2827D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B795C8F8;
	Fri, 23 Feb 2024 09:38:37 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190D5D8FE;
	Fri, 23 Feb 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681116; cv=none; b=rNUVifHwYnkYkpxun7yoR8g23OVzlf7JQm8NSouvdBWnCBOVr8JG//KbaSUzrKmEslau7373BazYnKa8JEYCXKb03p15/mQCoW0iu3NGxheEcbVoQ7R6b03YxNmw6Zmbu0FV4DbBtD/8GyZOFlB5ZfLY+r8aX05vDwUJN2uEAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681116; c=relaxed/simple;
	bh=IxGn927BGFRmm/ygF3LwDNCQJWTN1CLV232sRxge5WA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLs6xdXE6EQwVbeg5yEuqkSnl/heOKvJMmcdp9te28uSe23+08ao7R9GFZ6yd0Yhkx7kBkBS7WYd+qPoO4E8+wacSmPZEXdsPlsRKUwgL+w1jCMs6FkIqKBW5oPjseXjvD2Mdk+RmfiIvG5K8T2tnJ7kpWg3a1Fgp91nCX94hwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: 4z+h5Ryn3S4fklvhBY9Bnn3sYLsXvBk0YGJoqfwuI9uuuR9xsYw5Gyk8Fc/isDDB3Qjimo5mfq
 ILzrh2XM1cPA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 23 Feb 2024 15:07:16 +0530
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
Subject: [PATCH v2 08/14] misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
Date: Fri, 23 Feb 2024 15:06:55 +0530
Message-Id: <20240223093701.66034-9-bhargav.r@ltts.com>
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

Add support for TPS65224 PFSM in the TPS6594 PFSM driver
as they share significant functionality.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/misc/tps6594-pfsm.c | 55 +++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 88dcac814..4fa071093 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * PFSM (Pre-configurable Finite State Machine) driver for TI TPS6594/TPS6593/LP8764 PMICs
+ * PFSM (Pre-configurable Finite State Machine) driver for TI TPS65224/TPS6594/TPS6593/LP8764 PMICs
  *
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
@@ -34,15 +34,17 @@
 
 #define TPS6594_FILE_TO_PFSM(f) container_of((f)->private_data, struct tps6594_pfsm, miscdev)
 
-/**
+/*
  * struct tps6594_pfsm - device private data structure
  *
  * @miscdev: misc device infos
  * @regmap:  regmap for accessing the device registers
+ * @chip_id: chip identifier of the device
  */
 struct tps6594_pfsm {
 	struct miscdevice miscdev;
 	struct regmap *regmap;
+	unsigned long chip_id;
 };
 
 static ssize_t tps6594_pfsm_read(struct file *f, char __user *buf,
@@ -133,21 +135,29 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
 	struct pmic_state_opt state_opt;
 	void __user *argp = (void __user *)arg;
+	unsigned int regmap_reg, mask;
 	int ret = -ENOIOCTLCMD;
 
 	switch (cmd) {
 	case PMIC_GOTO_STANDBY:
-		/* Disable LP mode */
-		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
-					TPS6594_BIT_LP_STANDBY_SEL);
-		if (ret)
-			return ret;
+		/* Disable LP mode on TPS6594 Family PMIC */
+		if (pfsm->chip_id != TPS65224) {
+			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
+						TPS6594_BIT_LP_STANDBY_SEL);
+
+			if (ret)
+				return ret;
+		}
 
 		/* Force trigger */
 		ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_FSM_I2C_TRIGGERS,
 					TPS6594_BIT_TRIGGER_I2C(0), TPS6594_BIT_TRIGGER_I2C(0));
 		break;
 	case PMIC_GOTO_LP_STANDBY:
+		/* TPS65224 does not support LP STANDBY */
+		if (pfsm->chip_id == TPS65224)
+			return ret;
+
 		/* Enable LP mode */
 		ret = regmap_set_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
 				      TPS6594_BIT_LP_STANDBY_SEL);
@@ -169,6 +179,10 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 				      TPS6594_BIT_NSLEEP1B | TPS6594_BIT_NSLEEP2B);
 		break;
 	case PMIC_SET_MCU_ONLY_STATE:
+		/* TPS65224 does not support MCU_ONLY_STATE */
+		if (pfsm->chip_id == TPS65224)
+			return ret;
+
 		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
 			return -EFAULT;
 
@@ -192,14 +206,20 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 			return -EFAULT;
 
 		/* Configure wake-up destination */
+		if (pfsm->chip_id == TPS65224) {
+			regmap_reg = TPS65224_REG_STARTUP_CTRL;
+			mask = TPS65224_MASK_STARTUP_DEST;
+		} else {
+			regmap_reg = TPS6594_REG_RTC_CTRL_2;
+			mask = TPS6594_MASK_STARTUP_DEST;
+		}
+
 		if (state_opt.mcu_only_startup_dest)
-			ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
-						TPS6594_MASK_STARTUP_DEST,
-						TPS6594_STARTUP_DEST_MCU_ONLY);
+			ret = regmap_write_bits(pfsm->regmap, regmap_reg,
+						mask, TPS6594_STARTUP_DEST_MCU_ONLY);
 		else
-			ret = regmap_write_bits(pfsm->regmap, TPS6594_REG_RTC_CTRL_2,
-						TPS6594_MASK_STARTUP_DEST,
-						TPS6594_STARTUP_DEST_ACTIVE);
+			ret = regmap_write_bits(pfsm->regmap, regmap_reg,
+						mask, TPS6594_STARTUP_DEST_ACTIVE);
 		if (ret)
 			return ret;
 
@@ -210,8 +230,12 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 			return ret;
 
 		/* Modify NSLEEP1-2 bits */
-		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
-					TPS6594_BIT_NSLEEP2B);
+		if (pfsm->chip_id == TPS65224)
+			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+						TPS6594_BIT_NSLEEP1B);
+		else
+			ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
+						TPS6594_BIT_NSLEEP2B);
 		break;
 	}
 
@@ -262,6 +286,7 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 					    tps->chip_id, tps->reg);
 	pfsm->miscdev.fops = &tps6594_pfsm_fops;
 	pfsm->miscdev.parent = dev->parent;
+	pfsm->chip_id = tps->chip_id;
 
 	for (i = 0 ; i < pdev->num_resources ; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
-- 
2.25.1


