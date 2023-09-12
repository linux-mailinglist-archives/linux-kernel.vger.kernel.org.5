Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D179C983
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjILIOU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjILIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:14:15 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F710C6;
        Tue, 12 Sep 2023 01:14:10 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 793D124E305;
        Tue, 12 Sep 2023 16:14:07 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Sep
 2023 16:14:07 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 12 Sep 2023 16:14:06 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v2 2/3] mmc: starfive: Change tuning implementation
Date:   Tue, 12 Sep 2023 16:14:01 +0800
Message-ID: <20230912081402.51477-6-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912081402.51477-1-william.qiu@starfivetech.com>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, we used syscon to achieve tuning, but the actual measurement
showed little effect, so the tuning implementation was modified here,
and it was realized by reading and writing the UHS_REG_EXT register.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 drivers/mmc/host/dw_mmc-starfive.c | 137 +++++++++--------------------
 1 file changed, 40 insertions(+), 97 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
index fd05a648a8bb..ad8f39c62fed 100644
--- a/drivers/mmc/host/dw_mmc-starfive.c
+++ b/drivers/mmc/host/dw_mmc-starfive.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022 StarFive Technology Co., Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
@@ -20,13 +21,7 @@
 #define ALL_INT_CLR		0x1ffff
 #define MAX_DELAY_CHAIN		32
 
-struct starfive_priv {
-	struct device *dev;
-	struct regmap *reg_syscon;
-	u32 syscon_offset;
-	u32 syscon_shift;
-	u32 syscon_mask;
-};
+#define STARFIVE_SMPL_PHASE     GENMASK(20, 16)
 
 static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
@@ -44,117 +39,65 @@ static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	}
 }
 
+static void dw_mci_starfive_set_sample_phase(struct dw_mci *host, u32 smpl_phase)
+{
+	/* change driver phase and sample phase */
+	u32 reg_value = mci_readl(host, UHS_REG_EXT);
+
+	/* In UHS_REG_EXT, only 5 bits valid in DRV_PHASE and SMPL_PHASE */
+	reg_value &= ~STARFIVE_SMPL_PHASE;
+	reg_value |= FIELD_PREP(STARFIVE_SMPL_PHASE, smpl_phase);
+	mci_writel(host, UHS_REG_EXT, reg_value);
+
+	/* We should delay 1ms wait for timing setting finished. */
+	mdelay(1);
+}
+
 static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
 					     u32 opcode)
 {
 	static const int grade  = MAX_DELAY_CHAIN;
 	struct dw_mci *host = slot->host;
-	struct starfive_priv *priv = host->priv;
-	int rise_point = -1, fall_point = -1;
-	int err, prev_err = 0;
-	int i;
-	bool found = 0;
-	u32 regval;
-
-	/*
-	 * Use grade as the max delay chain, and use the rise_point and
-	 * fall_point to ensure the best sampling point of a data input
-	 * signals.
-	 */
-	for (i = 0; i < grade; i++) {
-		regval = i << priv->syscon_shift;
-		err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
-						priv->syscon_mask, regval);
-		if (err)
-			return err;
+	int smpl_phase, smpl_raise = -1, smpl_fall = -1;
+	int ret;
+
+	for (smpl_phase = 0; smpl_phase < grade; smpl_phase++) {
+		dw_mci_starfive_set_sample_phase(host, smpl_phase);
 		mci_writel(host, RINTSTS, ALL_INT_CLR);
 
-		err = mmc_send_tuning(slot->mmc, opcode, NULL);
-		if (!err)
-			found = 1;
+		ret = mmc_send_tuning(slot->mmc, opcode, NULL);
 
-		if (i > 0) {
-			if (err && !prev_err)
-				fall_point = i - 1;
-			if (!err && prev_err)
-				rise_point = i;
+		if (!ret && smpl_raise < 0) {
+			smpl_raise = smpl_phase;
+		} else if (ret && smpl_raise >= 0) {
+			smpl_fall = smpl_phase - 1;
+			break;
 		}
-
-		if (rise_point != -1 && fall_point != -1)
-			goto tuning_out;
-
-		prev_err = err;
-		err = 0;
 	}
 
-tuning_out:
-	if (found) {
-		if (rise_point == -1)
-			rise_point = 0;
-		if (fall_point == -1)
-			fall_point = grade - 1;
-		if (fall_point < rise_point) {
-			if ((rise_point + fall_point) >
-			    (grade - 1))
-				i = fall_point / 2;
-			else
-				i = (rise_point + grade - 1) / 2;
-		} else {
-			i = (rise_point + fall_point) / 2;
-		}
-
-		regval = i << priv->syscon_shift;
-		err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
-						priv->syscon_mask, regval);
-		if (err)
-			return err;
-		mci_writel(host, RINTSTS, ALL_INT_CLR);
+	if (smpl_phase >= grade && smpl_raise >= 0)
+		smpl_fall = grade - 1;
 
-		dev_info(host->dev, "Found valid delay chain! use it [delay=%d]\n", i);
-	} else {
+	if (smpl_raise < 0) {
+		smpl_phase = 0;
 		dev_err(host->dev, "No valid delay chain! use default\n");
-		err = -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	mci_writel(host, RINTSTS, ALL_INT_CLR);
-	return err;
-}
-
-static int dw_mci_starfive_parse_dt(struct dw_mci *host)
-{
-	struct of_phandle_args args;
-	struct starfive_priv *priv;
-	int ret;
-
-	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	smpl_phase = (smpl_raise + smpl_fall) / 2;
+	dev_dbg(host->dev, "Found valid delay chain! use it [delay=%d]\n", smpl_phase);
+	ret = 0;
 
-	ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
-						"starfive,sysreg", 3, 0, &args);
-	if (ret) {
-		dev_err(host->dev, "Failed to parse starfive,sysreg\n");
-		return -EINVAL;
-	}
-
-	priv->reg_syscon = syscon_node_to_regmap(args.np);
-	of_node_put(args.np);
-	if (IS_ERR(priv->reg_syscon))
-		return PTR_ERR(priv->reg_syscon);
-
-	priv->syscon_offset = args.args[0];
-	priv->syscon_shift  = args.args[1];
-	priv->syscon_mask   = args.args[2];
-
-	host->priv = priv;
-
-	return 0;
+out:
+	dw_mci_starfive_set_sample_phase(host, smpl_phase);
+	mci_writel(host, RINTSTS, ALL_INT_CLR);
+	return ret;
 }
 
 static const struct dw_mci_drv_data starfive_data = {
 	.common_caps		= MMC_CAP_CMD23,
 	.set_ios		= dw_mci_starfive_set_ios,
-	.parse_dt		= dw_mci_starfive_parse_dt,
 	.execute_tuning		= dw_mci_starfive_execute_tuning,
 };
 
-- 
2.34.1

