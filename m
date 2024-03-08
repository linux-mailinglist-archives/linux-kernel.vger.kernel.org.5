Return-Path: <linux-kernel+bounces-96850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A9787622D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631F91F22DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E15A7BA;
	Fri,  8 Mar 2024 10:35:33 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C458237;
	Fri,  8 Mar 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894133; cv=none; b=KylcMve4IIF7Q7pZeVejsZsvoK/4/mYbFUcQsRYoedMHVlGMHWJrcmVNv4dHnw7m2REy1GrIxmVKmB/GZIGEYp0sL4wJ0R6Rxxf+v4yDVpDM+xDFy/nen4Gtc+5c9T3nF4oC75iZgJfZeqSW2J5eNfmDkYCdXxVnbMyuta+0fXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894133; c=relaxed/simple;
	bh=MF1vKKg3x3D/0jpycw7VmBEoSmbO8CpXWmXjg17UE3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Os+JU4VMSM8KdGq5h9ylg5uNfkqwWRzIQu6txxzyLb/BY01UGxDvCDvUXlflTdZicykjFxNN0huahcfg997EbU+n+np7SPGaubAtHx+hSHR/TKZaOQIQgtKcf+grJLhq0oIS1AJ9u2jk5vKQR5idctBBVFS6nbxXMVAgdUetGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: Ei9wXLAqro1grCT5rj/4Kv/Eil39RLzgbxYtm5Y0n4pPx6SvJNHELdjqSUnFTusjjIdaTHIiS9
 auFwRsbJGHHg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 08 Mar 2024 16:05:11 +0530
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
Subject: [PATCH v3 08/11] misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
Date: Fri,  8 Mar 2024 16:04:52 +0530
Message-Id: <20240308103455.242705-9-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308103455.242705-1-bhargav.r@ltts.com>
References: <20240308103455.242705-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TPS65224 PFSM in the TPS6594 PFSM driver as they share
significant functionality.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/misc/tps6594-pfsm.c | 48 +++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 88dcac814..9bcca1856 100644
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
@@ -39,10 +39,12 @@
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
 
@@ -211,7 +231,8 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 
 		/* Modify NSLEEP1-2 bits */
 		ret = regmap_clear_bits(pfsm->regmap, TPS6594_REG_FSM_NSLEEP_TRIGGERS,
-					TPS6594_BIT_NSLEEP2B);
+					pfsm->chip_id == TPS65224 ?
+					TPS6594_BIT_NSLEEP1B : TPS6594_BIT_NSLEEP2B);
 		break;
 	}
 
@@ -262,6 +283,7 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 					    tps->chip_id, tps->reg);
 	pfsm->miscdev.fops = &tps6594_pfsm_fops;
 	pfsm->miscdev.parent = dev->parent;
+	pfsm->chip_id = tps->chip_id;
 
 	for (i = 0 ; i < pdev->num_resources ; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
-- 
2.25.1


