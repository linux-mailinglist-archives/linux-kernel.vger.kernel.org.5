Return-Path: <linux-kernel+bounces-163730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B723F8B6EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCF11C22DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB1129A72;
	Tue, 30 Apr 2024 09:58:52 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED254127B52
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471131; cv=none; b=XYyPUZ5z2kV+v+XrrpiBZkz6MY+tTay0uzK2Af3IcdvRluSI5+fMvQD2YdD3ewuCgSl9JbKpoqL2ks/An4JC1CKy60GiN4HjVuN5uXg4SbTVlhkrTX2QYPF4JMpv65NxrpnhgikhEZUIkh32Ry2vb/suG3NAA73Ae+Q3CZFggiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471131; c=relaxed/simple;
	bh=WzSLblxs7n5kOPkFyGc4PsooUIWAas7udMZaq7lB7+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOelARk89vhvz8t/BDfrfXvLGeT/pWMa9SUhMbvNPSsVAqdXWjPVx9m9kwvXyYyQ9VjHB27Dr+TfJLtWBf3hLvOfjIbPOBYMPXVXg0TZqG2Wdst59FA37mwtdlNSKPZnuVH1ZbbPMnY8Q4BIILnncqzRW15NYc/D5In7uce9hAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367349:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 30 Apr 2024 17:58:29 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 17:58:29 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 17:58:29 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <alina_yu@richtek.com>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 1/4] regulator: rtq2208: Fix LDO discharge register and add vsel setting
Date: Tue, 30 Apr 2024 17:58:24 +0800
Message-ID: <5d56b79c94de63fc86b5a70b7e374da4240fee8b.1714467553.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1714467553.git.alina_yu@richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The LDO's Vout is adjustable if the hardware setting allows it,
and it can be set either 1800mv or 3300mv.
Additionally, the discharge register has been moved to another position.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 100 +++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 2d54844..63d4037 100644
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
@@ -318,23 +323,6 @@ static irqreturn_t rtq2208_irq_handler(int irqno, void *devid)
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
 static int rtq2208_of_get_fixed_voltage(struct device *dev,
 					struct of_regulator_match *rtq2208_ldo_match, int n_fixed)
 {
@@ -373,6 +361,34 @@ static int rtq2208_of_get_fixed_voltage(struct device *dev,
 	return 0;
 }
 
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
 static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel,
 					int idx, struct of_regulator_match *rtq2208_ldo_match, int *ldo_idx)
 {
@@ -380,17 +396,22 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
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
@@ -402,15 +423,13 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
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
@@ -418,8 +437,10 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
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
@@ -427,14 +448,11 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
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
@@ -458,6 +476,10 @@ static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *
 			return -ENOMEM;
 
 		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx, rtq2208_ldo_match, &ldo_idx);
+
+		/* init ldo dvs ability */
+		if (idx >= RTQ2208_LDO2)
+			rtq2208_ldo_match[idx - RTQ2208_LDO2].desc = &rdesc[i]->desc;
 	}
 
 	/* init ldo fixed_uV */
-- 
2.7.4


