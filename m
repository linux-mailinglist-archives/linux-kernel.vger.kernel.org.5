Return-Path: <linux-kernel+bounces-78042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CB860E51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675EA1F233FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE15F463;
	Fri, 23 Feb 2024 09:38:44 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C85D48C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681123; cv=none; b=oneu9RTq9JAGMD4xUEafAYS/ynp3OkIIiQ6Yz6c6S7WXOS+BTnhRCzvm77RwOBo8vo1mSwuPvAccav32FkrTs94ns6KKtoCntp3S1Xh4owI1Uaiy/uUoX07JnsIJhefi6N3ewJBVjtS5lumkFlK3O17PZQj6qVRe2u3+OP+HSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681123; c=relaxed/simple;
	bh=X/0C8gH+4iS5PBRoda/vevF4KHgfxDRlL2N3/9o4zAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7sGm4O2W0El5gaXyCIVipr6wTLJqm2UymVcgiTl7XVCkpBBrLaq+m9/tQq0vTKIwoTVi5kOGMijkpBA3p72CrHyDd7GOpOdRZV+5oy1wDw+7BDKMbbcquyFjjimst6bSuMxOGLIMqGQYiP+0YI4Hch86Nsjg+aNfYVLvtVAc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: xAtFdAQn6JB/h7RyB9nbyWdCquQnr6kyZol68cXXihfhpIKn/Y5YpwSuinLby/mUevbUGTN+gb
 gAnuc37zOFUQ==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 23 Feb 2024 15:07:19 +0530
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
Subject: [PATCH v2 12/14] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Fri, 23 Feb 2024 15:06:59 +0530
Message-Id: <20240223093701.66034-13-bhargav.r@ltts.com>
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

From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>

Add support for TPS65224 regulators (bucks and LDOs) to TPS6594 driver
as they have significant functional overlap.
TPS65224 PMIC has 4 buck regulators and 3 LDOs. BUCK12 can operate in
dual phase.
The output voltages are configurable and are meant to supply power to
the main processor and other components.

Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/regulator/Kconfig             |   4 +-
 drivers/regulator/tps6594-regulator.c | 244 +++++++++++++++++++++++---
 2 files changed, 218 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7db0a29b5..1e4119f00 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1563,13 +1563,15 @@ config REGULATOR_TPS6594
 	depends on MFD_TPS6594 && OF
 	default MFD_TPS6594
 	help
-	  This driver supports TPS6594 voltage regulator chips.
+	  This driver supports TPS6594 series and TPS65224 voltage regulator chips.
 	  TPS6594 series of PMICs have 5 BUCKs and 4 LDOs
 	  voltage regulators.
 	  BUCKs 1,2,3,4 can be used in single phase or multiphase mode.
 	  Part number defines which single or multiphase mode is i used.
 	  It supports software based voltage control
 	  for different voltage domains.
+	  TPS65224 PMIC has 4 BUCKs and 3 LDOs. BUCK12 can be used in dual phase.
+	  All BUCKs and LDOs volatge can be controlled through software.
 
 config REGULATOR_TPS6524X
 	tristate "TI TPS6524X Power regulators"
diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index b7f0c8779..3f32dba90 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -66,6 +66,15 @@ static struct tps6594_regulator_irq_type tps6594_ext_regulator_irq_types[] = {
 	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
 };
 
+static struct tps6594_regulator_irq_type tps65224_ext_regulator_irq_types[] = {
+	{ TPS65224_IRQ_NAME_VCCA_UVOV, "VCCA", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS65224_IRQ_NAME_VMON1_UVOV, "VMON1", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS65224_IRQ_NAME_VMON2_UVOV, "VMON2", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
 struct tps6594_regulator_irq_data {
 	struct device *dev;
 	struct tps6594_regulator_irq_type *type;
@@ -122,6 +131,27 @@ static const struct linear_range ldos_4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x20, 0x74, 25000),
 };
 
+/* Voltage range for TPS65224 Bucks and LDOs */
+static const struct linear_range tps65224_bucks_1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0a, 0x0e, 20000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0f, 0x72, 5000),
+	REGULATOR_LINEAR_RANGE(1100000, 0x73, 0xaa, 10000),
+	REGULATOR_LINEAR_RANGE(1660000, 0xab, 0xfd, 20000),
+};
+
+static const struct linear_range tps65224_bucks_2_3_4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x1a, 25000),
+	REGULATOR_LINEAR_RANGE(1200000, 0x1b, 0x45, 50000),
+};
+
+static const struct linear_range tps65224_ldos_1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0xC, 0x36, 50000),
+};
+
+static const struct linear_range tps65224_ldos_2_3_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x38, 50000),
+};
+
 /* Operations permitted on BUCK1/2/3/4/5 */
 static const struct regulator_ops tps6594_bucks_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -197,6 +227,38 @@ static const struct regulator_desc buck_regs[] = {
 			  4, 0, 0, NULL, 0, 0),
 };
 
+/* Buck configuration for TPS65224 */
+static const struct regulator_desc tps65224_buck_regs[] = {
+	TPS6594_REGULATOR("BUCK1", "buck1", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(0),
+			  TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_CTRL(0),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_1_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK2", "buck2", TPS6594_BUCK_2,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK3", "buck3", TPS6594_BUCK_3,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(2),
+			  TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(2),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK4", "buck4", TPS6594_BUCK_4,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(3),
+			  TPS65224_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(3),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
+			  4, 0, 0, NULL, 0, 0),
+};
+
 static struct tps6594_regulator_irq_type tps6594_buck1_irq_types[] = {
 	{ TPS6594_IRQ_NAME_BUCK1_OV, "BUCK1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
 	{ TPS6594_IRQ_NAME_BUCK1_UV, "BUCK1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
@@ -269,6 +331,41 @@ static struct tps6594_regulator_irq_type tps6594_ldo4_irq_types[] = {
 	  REGULATOR_EVENT_OVER_CURRENT },
 };
 
+static struct tps6594_regulator_irq_type tps65224_buck1_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK1_UVOV, "BUCK1", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
+static struct tps6594_regulator_irq_type tps65224_buck2_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK2_UVOV, "BUCK2", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
+static struct tps6594_regulator_irq_type tps65224_buck3_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK3_UVOV, "BUCK3", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
+static struct tps6594_regulator_irq_type tps65224_buck4_irq_types[] = {
+	{ TPS65224_IRQ_NAME_BUCK4_UVOV, "BUCK4", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
+static struct tps6594_regulator_irq_type tps65224_ldo1_irq_types[] = {
+	{ TPS65224_IRQ_NAME_LDO1_UVOV, "LDO1", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
+static struct tps6594_regulator_irq_type tps65224_ldo2_irq_types[] = {
+	{ TPS65224_IRQ_NAME_LDO2_UVOV, "LDO2", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
+static struct tps6594_regulator_irq_type tps65224_ldo3_irq_types[] = {
+	{ TPS65224_IRQ_NAME_LDO3_UVOV, "LDO3", "voltage out of range",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
 static struct tps6594_regulator_irq_type *tps6594_bucks_irq_types[] = {
 	tps6594_buck1_irq_types,
 	tps6594_buck2_irq_types,
@@ -284,7 +381,20 @@ static struct tps6594_regulator_irq_type *tps6594_ldos_irq_types[] = {
 	tps6594_ldo4_irq_types,
 };
 
-static const struct regulator_desc multi_regs[] = {
+static struct tps6594_regulator_irq_type *tps65224_bucks_irq_types[] = {
+	tps65224_buck1_irq_types,
+	tps65224_buck2_irq_types,
+	tps65224_buck3_irq_types,
+	tps65224_buck4_irq_types,
+};
+
+static struct tps6594_regulator_irq_type *tps65224_ldos_irq_types[] = {
+	tps65224_ldo1_irq_types,
+	tps65224_ldo2_irq_types,
+	tps65224_ldo3_irq_types,
+};
+
+static const struct regulator_desc tps6594_multi_regs[] = {
 	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
 			  TPS6594_REG_BUCKX_VOUT_1(1),
@@ -315,7 +425,17 @@ static const struct regulator_desc multi_regs[] = {
 			  4, 4000, 0, NULL, 0, 0),
 };
 
-static const struct regulator_desc ldo_regs[] = {
+static const struct regulator_desc tps65224_multi_regs[] = {
+	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(0),
+			  TPS65224_MASK_BUCK1_VSET,
+			  TPS6594_REG_BUCKX_CTRL(0),
+			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_1_ranges,
+			  4, 4000, 0, NULL, 0, 0),
+};
+
+static const struct regulator_desc tps6594_ldo_regs[] = {
 	TPS6594_REGULATOR("LDO1", "ldo1", TPS6594_LDO_1,
 			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
 			  TPS6594_REG_LDOX_VOUT(0),
@@ -346,6 +466,30 @@ static const struct regulator_desc ldo_regs[] = {
 			  1, 0, 0, NULL, 0, 0),
 };
 
+static const struct regulator_desc tps65224_ldo_regs[] = {
+	TPS6594_REGULATOR("LDO1", "ldo1", TPS6594_LDO_1,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(0),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(0),
+			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_1_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+	TPS6594_REGULATOR("LDO2", "ldo2", TPS6594_LDO_2,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(1),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(1),
+			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_2_3_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+	TPS6594_REGULATOR("LDO3", "ldo3", TPS6594_LDO_3,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(2),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(2),
+			  TPS6594_BIT_LDO_EN, 0, 0, tps65224_ldos_2_3_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+};
+
 static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
 {
 	struct tps6594_regulator_irq_data *irq_data = data;
@@ -374,11 +518,17 @@ static int tps6594_request_reg_irqs(struct platform_device *pdev,
 {
 	struct tps6594_regulator_irq_type *irq_type;
 	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
-	int j;
+	size_t j;
 	int irq;
 	int error;
+	size_t interrupt_cnt;
 
-	for (j = 0; j < REGS_INT_NB; j++) {
+	/* Number of interrupts supported by each voltage source */
+	interrupt_cnt = (tps->chip_id == TPS6594) ?
+			 ARRAY_SIZE(tps6594_buck1_irq_types) :
+			 ARRAY_SIZE(tps65224_buck1_irq_types);
+
+	for (j = 0; j < interrupt_cnt; j++) {
 		irq_type = &tps6594_regs_irq_types[j];
 		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
 		if (irq < 0)
@@ -412,14 +562,20 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
 	struct tps6594_regulator_irq_type *irq_type;
 	u8 buck_configured[BUCK_NB] = { 0 };
+	u8 ldo_configured[LDO_NB] = { 0 };
 	u8 buck_multi[MULTI_PHASE_NB] = { 0 };
 	static const char * const multiphases[] = {"buck12", "buck123", "buck1234", "buck34"};
+	static const char * const tps65224_multiphases[] = {"buck12"};
 	static const char *npname;
 	int error, i, irq, multi, delta;
 	int irq_idx = 0;
 	int buck_idx = 0;
+	unsigned int multi_phase_cnt = 0;
 	size_t ext_reg_irq_nb = 2;
 	size_t reg_irq_nb;
+	struct tps6594_regulator_irq_type **bucks_irq_types = (tps->chip_id == TPS65224) ?
+							       tps65224_bucks_irq_types :
+							       tps6594_bucks_irq_types;
 	enum {
 		MULTI_BUCK12,
 		MULTI_BUCK123,
@@ -434,6 +590,10 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	config.driver_data = tps;
 	config.regmap = tps->regmap;
 
+	multi_phase_cnt = (tps->chip_id == TPS65224) ?
+			   ARRAY_SIZE(tps65224_multiphases) :
+			   ARRAY_SIZE(multiphases);
+
 	/*
 	 * Switch case defines different possible multi phase config
 	 * This is based on dts buck node name.
@@ -442,7 +602,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	 * In case of Multiphase configuration, value should be defined for
 	 * buck_configured to avoid creating bucks for every buck in multiphase
 	 */
-	for (multi = MULTI_FIRST; multi < MULTI_NUM; multi++) {
+	for (multi = MULTI_FIRST; multi < multi_phase_cnt; multi++) {
 		np = of_find_node_by_name(tps->dev->of_node, multiphases[multi]);
 		npname = of_node_full_name(np);
 		np_pmic_parent = of_get_parent(of_get_parent(np));
@@ -486,6 +646,11 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		/* There is only 4 buck on LP8764 */
 		buck_configured[4] = 1;
 		reg_irq_nb = size_mul(REGS_INT_NB, (BUCK_NB - 1));
+	} else if (tps->chip_id == TPS65224) {
+		/* TPS65224 has 4 bucks and 3 LDOs. 1 Interrupt for each buck and ldo */
+		buck_configured[4] = 1;
+		ldo_configured[3] = 1;
+		reg_irq_nb = size_mul(1, (size_add((BUCK_NB - 1), (LDO_NB - 1))));
 	} else {
 		reg_irq_nb = size_mul(REGS_INT_NB, (size_add(BUCK_NB, LDO_NB)));
 	}
@@ -495,25 +660,30 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	if (!irq_data)
 		return -ENOMEM;
 
-	for (i = 0; i < MULTI_PHASE_NB; i++) {
+	for (i = 0; i < multi_phase_cnt; i++) {
 		if (buck_multi[i] == 0)
 			continue;
 
+		const struct regulator_desc *multi_regs = (tps->chip_id == TPS65224) ?
+							   tps65224_multi_regs :
+							   tps6594_multi_regs;
 		rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
-		if (IS_ERR(rdev))
-			return dev_err_probe(tps->dev, PTR_ERR(rdev),
-					     "failed to register %s regulator\n",
-					     pdev->name);
+			if (IS_ERR(rdev))
+				return dev_err_probe(tps->dev, PTR_ERR(rdev),
+						     "failed to register %s regulator\n",
+						     pdev->name);
 
 		/* config multiphase buck12+buck34 */
 		if (i == 1)
 			buck_idx = 2;
+
 		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-						 tps6594_bucks_irq_types[buck_idx], &irq_idx);
+						 bucks_irq_types[buck_idx], &irq_idx);
 		if (error)
 			return error;
+
 		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-						 tps6594_bucks_irq_types[buck_idx + 1], &irq_idx);
+						 bucks_irq_types[buck_idx + 1], &irq_idx);
 		if (error)
 			return error;
 
@@ -537,37 +707,49 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		if (buck_configured[i] == 1)
 			continue;
 
-		rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
+		const struct regulator_desc *buck_cfg = (tps->chip_id == TPS65224) ?
+							 tps65224_buck_regs : buck_regs;
+
+		rdev = devm_regulator_register(&pdev->dev, &buck_cfg[i], &config);
 		if (IS_ERR(rdev))
 			return dev_err_probe(tps->dev, PTR_ERR(rdev),
-					     "failed to register %s regulator\n",
-					     pdev->name);
+					     "failed to register %s regulator\n", pdev->name);
 
 		error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-						 tps6594_bucks_irq_types[i], &irq_idx);
+						 bucks_irq_types[i], &irq_idx);
 		if (error)
 			return error;
 	}
 
-	/* LP8764 dosen't have LDO */
+	/* LP8764 doesn't have LDO */
 	if (tps->chip_id != LP8764) {
-		for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
-			rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
-			if (IS_ERR(rdev))
-				return dev_err_probe(tps->dev, PTR_ERR(rdev),
-						     "failed to register %s regulator\n",
-						     pdev->name);
+		for (i = 0; i < LDO_NB; i++) {
+			if (ldo_configured[i] == 1)
+				continue;
 
-			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
-							 tps6594_ldos_irq_types[i],
-							 &irq_idx);
-			if (error)
-				return error;
+		struct tps6594_regulator_irq_type **ldos_irq_types = (tps->chip_id == TPS65224) ?
+								       tps65224_ldos_irq_types :
+								       tps6594_ldos_irq_types;
+
+		const struct regulator_desc *ldo_regs = (tps->chip_id == TPS65224) ?
+							 tps65224_ldo_regs :
+							 tps6594_ldo_regs;
+
+		rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(tps->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n", pdev->name);
+
+		error = tps6594_request_reg_irqs(pdev, rdev, irq_data, ldos_irq_types[i], &irq_idx);
+		if (error)
+			return error;
 		}
 	}
 
 	if (tps->chip_id == LP8764)
 		ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
+	else if (tps->chip_id == TPS65224)
+		ext_reg_irq_nb = ARRAY_SIZE(tps65224_ext_regulator_irq_types);
 
 	irq_ext_reg_data = devm_kmalloc_array(tps->dev,
 					ext_reg_irq_nb,
@@ -577,7 +759,10 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < ext_reg_irq_nb; ++i) {
-		irq_type = &tps6594_ext_regulator_irq_types[i];
+		if (tps->chip_id == TPS65224)
+			irq_type = &tps65224_ext_regulator_irq_types[i];
+		else
+			irq_type = &tps6594_ext_regulator_irq_types[i];
 
 		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
 		if (irq < 0)
@@ -610,5 +795,6 @@ module_platform_driver(tps6594_regulator_driver);
 
 MODULE_ALIAS("platform:tps6594-regulator");
 MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
+MODULE_AUTHOR("Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>");
 MODULE_DESCRIPTION("TPS6594 voltage regulator driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1


