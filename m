Return-Path: <linux-kernel+bounces-162030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A807D8B54E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D71B2194A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0E381C7;
	Mon, 29 Apr 2024 10:17:11 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36132C84F;
	Mon, 29 Apr 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385830; cv=none; b=YYx0HQI2o/jBwrLImsMrUp6RPDOItpBLVyFiRYHhs/92x7VUmHQrkon9RczYkiRzeNFdBYIv72uBntSNLio1rWEbQ+5l+WV6ofs875BozYL9ai4uuOL5jTebDIw9Aeyiv+1ui1SgIP3H6esd+MhhISuXQVrNrj2YPAGmQ+aWvvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385830; c=relaxed/simple;
	bh=UswNmkIlmpDJWaTCvpashaUMDYtVBxVhG+VFfDRC2hI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXMkLKVp3Xkf1rK4hUwZ9vXeTZ1/9UlGu5nIaM0hqYa+fmnZl9P52uDLA0cuC2oUielB3hOUqNFelvZTCSbqZpTMLmiPtyU57Jc+loFFXlp5O+QkXyGS/3RcL/kiRQ9IzifN6YJpYSPDWTKdIpJdiza3T0r0lfT3EtYHxKLKFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367368:1:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 29 Apr 2024 18:16:56 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 18:16:55 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 18:16:55 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH 2/2] regulator: rtq2208: Fix RTQ2208 buck ramp delay and ldo vout setting and segmentaion fault when devm_of_regulator_put_matches is called
Date: Mon, 29 Apr 2024 18:16:47 +0800
Message-ID: <1714385807-22393-3-git-send-email-alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714385807-22393-1-git-send-email-alina_yu@richtek.com>
References: <1714385807-22393-1-git-send-email-alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

ramp_delay range of bucks is changed.
The maximum ramp up and down range is shorten from 64mVstep/us tor 16mVstep/us/.
The LDO's Vout is adjustable if the haardware setting allow it, and it can be set either 1800mv or 3300mv.
Additionally, the discharge register is chaned to other position.
The discharge register has been moved to another position.
In this version, a software bug has been fixed. rtq2208_ldo_match is no longer a local variable,
which prevents invalid memory access when devm_of_regulator_put_matches is called.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 169 ++++++++++++++++++++++------------
 1 file changed, 109 insertions(+), 60 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 2d54844..95612cc 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -26,6 +26,7 @@
 #define RTQ2208_REG_BUCK_H_CFG0			0xA2
 #define RTQ2208_REG_LDO1_CFG			0xB1
 #define RTQ2208_REG_LDO2_CFG			0xC1
+#define RTQ2208_REG_LDO_DVS_CTRL		0xD0
 
 /* Mask */
 #define RTQ2208_BUCK_NR_MTP_SEL_MASK		GENMASK(7, 0)
@@ -40,6 +41,10 @@
 #define RTQ2208_EN_DIS_MASK			BIT(0)
 #define RTQ2208_BUCK_RAMP_SEL_MASK		GENMASK(2, 0)
 #define RTQ2208_HD_INT_MASK			BIT(0)
+#define RTQ2208_LDO1_DISCHG_EN_MASK		BIT(4)
+#define RTQ2208_LDO1_VOSEL_SD_MASK		BIT(5)
+#define RTQ2208_LDO2_DISCHG_EN_MASK		BIT(6)
+#define RTQ2208_LDO2_VOSEL_SD_MASK		BIT(7)
 
 /* Size */
 #define RTQ2208_VOUT_MAXNUM			256
@@ -48,7 +53,7 @@
 
 /* Value */
 #define RTQ2208_RAMP_VALUE_MIN_uV		500
-#define RTQ2208_RAMP_VALUE_MAX_uV		64000
+#define RTQ2208_RAMP_VALUE_MAX_uV		16000
 
 #define RTQ2208_BUCK_MASK(uv_irq, ov_irq)	(1 << ((uv_irq) % 8) | 1 << ((ov_irq) % 8))
 
@@ -142,12 +147,11 @@ static int rtq2208_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 	 * Because the relation of seleltion and value is like that
 	 *
 	 * seletion: value
-	 * 000: 64mv
-	 * 001: 32mv
+	 * 010: 16mv
 	 * ...
 	 * 111: 0.5mv
 	 *
-	 * For example, if I would like to select 64mv, the fls(ramp_delay) - 1 will be 0b111,
+	 * For example, if I would like to select 16mv, the fls(ramp_delay) - 1 will be 0b010,
 	 * and I need to use 0b111 - sel to do the shifting
 	 */
 
@@ -215,7 +219,7 @@ static const struct regulator_ops rtq2208_regulator_buck_ops = {
 	.set_suspend_mode = rtq2208_set_suspend_mode,
 };
 
-static const struct regulator_ops rtq2208_regulator_ldo_ops = {
+static const struct regulator_ops rtq2208_regulator_ldo_fix_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -224,6 +228,28 @@ static const struct regulator_ops rtq2208_regulator_ldo_ops = {
 	.set_suspend_disable = rtq2208_set_suspend_disable,
 };
 
+static const struct regulator_ops rtq2208_regulator_ldo_adj_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_suspend_enable = rtq2208_set_suspend_enable,
+	.set_suspend_disable = rtq2208_set_suspend_disable,
+};
+
+static const unsigned int rtq2208_ldo_volt_table[] = {
+	1800000,
+	3300000,
+};
+
+static struct of_regulator_match rtq2208_ldo_match[] = {
+	{.name = "ldo2", },
+	{.name = "ldo1", },
+};
+
 static unsigned int rtq2208_of_map_mode(unsigned int mode)
 {
 	switch (mode) {
@@ -318,30 +344,13 @@ static irqreturn_t rtq2208_irq_handler(int irqno, void *devid)
 	return IRQ_HANDLED;
 }
 
-#define RTQ2208_REGULATOR_INFO(_name, _base) \
-{ \
-	.name = #_name, \
-	.base = _base, \
-}
-#define BUCK_RG_BASE(_id)	RTQ2208_REG_BUCK_##_id##_CFG0
-#define BUCK_RG_SHIFT(_base, _shift)	(_base + _shift)
-#define LDO_RG_BASE(_id)	RTQ2208_REG_LDO##_id##_CFG
-#define LDO_RG_SHIFT(_base, _shift)	(_base + _shift)
-#define	VSEL_SHIFT(_sel)	(_sel ? 3 : 1)
-#define MTP_SEL_MASK(_sel)	RTQ2208_BUCK_EN_NR_MTP_SEL##_sel##_MASK
-
-static const struct linear_range rtq2208_vout_range[] = {
-	REGULATOR_LINEAR_RANGE(400000, 0, 180, 5000),
-	REGULATOR_LINEAR_RANGE(1310000, 181, 255, 10000),
-};
-
-static int rtq2208_of_get_fixed_voltage(struct device *dev,
-					struct of_regulator_match *rtq2208_ldo_match, int n_fixed)
+static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 {
 	struct device_node *np;
 	struct of_regulator_match *match;
-	struct rtq2208_regulator_desc *rdesc;
+	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
+	bool fixed_uV;
 	int ret, i;
 
 	if (!dev->of_node)
@@ -351,46 +360,87 @@ static int rtq2208_of_get_fixed_voltage(struct device *dev,
 	if (!np)
 		np = dev->of_node;
 
-	ret = of_regulator_match(dev, np, rtq2208_ldo_match, n_fixed);
+	ret = of_regulator_match(dev, np, rtq2208_ldo_match, ARRAY_SIZE(rtq2208_ldo_match));
 
 	of_node_put(np);
 
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < n_fixed; i++) {
+	for (i = 0; i < ARRAY_SIZE(rtq2208_ldo_match); i++) {
 		match = rtq2208_ldo_match + i;
 		init_data = match->init_data;
-		rdesc = (struct rtq2208_regulator_desc *)match->driver_data;
+		desc = (struct regulator_desc *)match->desc;
 
-		if (!init_data || !rdesc)
+		if (!init_data || !desc)
 			continue;
 
-		if (init_data->constraints.min_uV == init_data->constraints.max_uV)
-			rdesc->desc.fixed_uV = init_data->constraints.min_uV;
+		fixed_uV = of_property_read_bool(match->of_node, "richtek,use-fix-dvs");
+
+		if (fixed_uV) {
+			desc->n_voltages = 1;
+			desc->fixed_uV = init_data->constraints.min_uV;
+			desc->ops = &rtq2208_regulator_ldo_fix_ops;
+		} else {
+			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
+			desc->volt_table = rtq2208_ldo_volt_table;
+			desc->ops = &rtq2208_regulator_ldo_adj_ops;
+		}
 	}
 
 	return 0;
 }
 
-static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel,
-					int idx, struct of_regulator_match *rtq2208_ldo_match, int *ldo_idx)
+
+#define BUCK_INFO(_name, _id)						\
+{									\
+	.name = _name,							\
+	.base = RTQ2208_REG_BUCK_##_id##_CFG0,				\
+	.enable_reg = BUCK_RG_SHIFT(RTQ2208_REG_BUCK_##_id##_CFG0, 2),	\
+	.dis_reg = RTQ2208_REG_BUCK_##_id##_CFG0,			\
+}
+
+#define LDO_INFO(_name, _id)						\
+{									\
+	.name = _name,							\
+	.base = RTQ2208_REG_LDO##_id##_CFG,				\
+	.enable_reg = RTQ2208_REG_LDO##_id##_CFG,			\
+	.dis_mask = RTQ2208_LDO##_id##_DISCHG_EN_MASK,			\
+	.dis_on = RTQ2208_LDO##_id##_DISCHG_EN_MASK,			\
+	.vsel_mask = RTQ2208_LDO##_id##_VOSEL_SD_MASK,			\
+}
+
+#define BUCK_RG_SHIFT(_base, _shift)	(_base + _shift)
+#define	VSEL_SHIFT(_sel)	(_sel ? 3 : 1)
+#define MTP_SEL_MASK(_sel)	RTQ2208_BUCK_EN_NR_MTP_SEL##_sel##_MASK
+
+static const struct linear_range rtq2208_vout_range[] = {
+	REGULATOR_LINEAR_RANGE(400000, 0, 180, 5000),
+	REGULATOR_LINEAR_RANGE(1310000, 181, 255, 10000),
+};
+
+static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel, int idx)
 {
 	struct regulator_desc *desc;
 	static const struct {
 		char *name;
 		int base;
+		int enable_reg;
+		int dis_reg;
+		int dis_mask;
+		int dis_on;
+		int vsel_mask;
 	} regulator_info[] = {
-		RTQ2208_REGULATOR_INFO(buck-b, BUCK_RG_BASE(B)),
-		RTQ2208_REGULATOR_INFO(buck-c, BUCK_RG_BASE(C)),
-		RTQ2208_REGULATOR_INFO(buck-d, BUCK_RG_BASE(D)),
-		RTQ2208_REGULATOR_INFO(buck-a, BUCK_RG_BASE(A)),
-		RTQ2208_REGULATOR_INFO(buck-f, BUCK_RG_BASE(F)),
-		RTQ2208_REGULATOR_INFO(buck-g, BUCK_RG_BASE(G)),
-		RTQ2208_REGULATOR_INFO(buck-h, BUCK_RG_BASE(H)),
-		RTQ2208_REGULATOR_INFO(buck-e, BUCK_RG_BASE(E)),
-		RTQ2208_REGULATOR_INFO(ldo2, LDO_RG_BASE(2)),
-		RTQ2208_REGULATOR_INFO(ldo1, LDO_RG_BASE(1)),
+		BUCK_INFO("buck-b", B),
+		BUCK_INFO("buck-c", C),
+		BUCK_INFO("buck-d", D),
+		BUCK_INFO("buck-a", A),
+		BUCK_INFO("buck-f", F),
+		BUCK_INFO("buck-g", G),
+		BUCK_INFO("buck-h", H),
+		BUCK_INFO("buck-e", E),
+		LDO_INFO("ldo2", 2),
+		LDO_INFO("ldo1", 1),
 	}, *curr_info;
 
 	curr_info = regulator_info + idx;
@@ -402,15 +452,13 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 	desc->owner = THIS_MODULE;
 	desc->type = REGULATOR_VOLTAGE;
 	desc->enable_mask = mtp_sel ? MTP_SEL_MASK(1) : MTP_SEL_MASK(0);
-	desc->active_discharge_on = RTQ2208_EN_DIS_MASK;
+	desc->enable_reg = curr_info->enable_reg;
 	desc->active_discharge_off = 0;
-	desc->active_discharge_mask = RTQ2208_EN_DIS_MASK;
 
 	rdesc->mode_mask = RTQ2208_BUCK_NRMODE_MASK;
 
 	if (idx >= RTQ2208_BUCK_B && idx <= RTQ2208_BUCK_E) {
 		/* init buck desc */
-		desc->enable_reg = BUCK_RG_SHIFT(curr_info->base, 2);
 		desc->ops = &rtq2208_regulator_buck_ops;
 		desc->vsel_reg = curr_info->base + VSEL_SHIFT(mtp_sel);
 		desc->vsel_mask = RTQ2208_BUCK_NR_MTP_SEL_MASK;
@@ -418,8 +466,10 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 		desc->linear_ranges = rtq2208_vout_range;
 		desc->n_linear_ranges = ARRAY_SIZE(rtq2208_vout_range);
 		desc->ramp_reg = BUCK_RG_SHIFT(curr_info->base, 5);
-		desc->active_discharge_reg = curr_info->base;
 		desc->of_map_mode = rtq2208_of_map_mode;
+		desc->active_discharge_reg = curr_info->dis_reg;
+		desc->active_discharge_on = RTQ2208_EN_DIS_MASK;
+		desc->active_discharge_mask = RTQ2208_EN_DIS_MASK;
 
 		rdesc->mode_reg = BUCK_RG_SHIFT(curr_info->base, 2);
 		rdesc->suspend_config_reg = BUCK_RG_SHIFT(curr_info->base, 4);
@@ -427,14 +477,11 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 		rdesc->suspend_mode_mask = RTQ2208_BUCK_STRMODE_MASK;
 	} else {
 		/* init ldo desc */
-		desc->enable_reg = curr_info->base;
-		desc->ops = &rtq2208_regulator_ldo_ops;
-		desc->n_voltages = 1;
-		desc->active_discharge_reg = LDO_RG_SHIFT(curr_info->base, 2);
-
-		rtq2208_ldo_match[*ldo_idx].name = desc->name;
-		rtq2208_ldo_match[*ldo_idx].driver_data = rdesc;
-		rtq2208_ldo_match[(*ldo_idx)++].desc = desc;
+		desc->active_discharge_reg = RTQ2208_REG_LDO_DVS_CTRL;
+		desc->active_discharge_on = curr_info->dis_on;
+		desc->active_discharge_mask = curr_info->dis_mask;
+		desc->vsel_reg = RTQ2208_REG_LDO_DVS_CTRL;
+		desc->vsel_mask = curr_info->vsel_mask;
 
 		rdesc->suspend_config_reg = curr_info->base;
 		rdesc->suspend_enable_mask = RTQ2208_LDO_EN_STR_MASK;
@@ -444,8 +491,7 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *regulator_idx_table,
 		struct rtq2208_regulator_desc *rdesc[RTQ2208_LDO_MAX], struct device *dev)
 {
-	struct of_regulator_match rtq2208_ldo_match[2];
-	int mtp_sel, ret, i, idx, ldo_idx = 0;
+	int mtp_sel, i, idx, ret;
 
 	/* get mtp_sel0 or mtp_sel1 */
 	mtp_sel = device_property_read_bool(dev, "richtek,mtp-sel-high");
@@ -457,11 +503,14 @@ static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *
 		if (!rdesc[i])
 			return -ENOMEM;
 
-		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx, rtq2208_ldo_match, &ldo_idx);
+		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx);
+
+		/* init ldo dvs ability */
+		if (idx >= RTQ2208_LDO2)
+			rtq2208_ldo_match[idx - RTQ2208_LDO2].desc = &rdesc[i]->desc;
 	}
 
-	/* init ldo fixed_uV */
-	ret = rtq2208_of_get_fixed_voltage(dev, rtq2208_ldo_match, ldo_idx);
+	ret = rtq2208_of_get_ldo_dvs_ability(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get ldo fixed_uV\n");
 
-- 
2.7.4


