Return-Path: <linux-kernel+bounces-163731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D948B6EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C78284917
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE31129E89;
	Tue, 30 Apr 2024 09:58:53 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9717127B66
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471132; cv=none; b=umR29tjSxSbw4AXO6ZQJEigO6kYYREb4YHJG5VxsnXyXorUA/dXuEoKIqp+foIei3ufLWSOX5Gh7af3FvpEqIUXmZ6+tLrv0MyhxL6Yl2oOFoTteOPN8MjyKs3Zur/9K78hY9mmewWGvUgNTABaFDjK1r0IvZTMeK5wCx3QTOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471132; c=relaxed/simple;
	bh=TAIbU6KIXHjSHkPESe/qiPcIp+0I21hFgkQKToxiK8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knOLZsV/6LVb1NgcJnM7S2R8cbCAVFAQ/4LfEee2h/VwyHOA/NWyJdRjS8ywCKod+jGyW8FeLZarUhLM6IGyabfQV/Sj3W23b51O0e9q61Kwd+mHLnuQP0A/M4hq3wS8Hdq8YxcwoBXS8XB3uYXe2dzHfCGySx9FnBTl7ILHY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367349:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 30 Apr 2024 17:58:30 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 17:58:30 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 17:58:30 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <alina_yu@richtek.com>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with both fixed and adjustable vout
Date: Tue, 30 Apr 2024 17:58:25 +0800
Message-ID: <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
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

In this patch, LDO's adjustable and fixed Vout settings are compatible.
The LDO Vout ability depends on the init_data->constraints.
If adjustable, the Vout can be set to either 1800mV or 3300mV.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 41 +++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 63d4037..80a4d2f 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -220,7 +220,7 @@ static const struct regulator_ops rtq2208_regulator_buck_ops = {
 	.set_suspend_mode = rtq2208_set_suspend_mode,
 };
 
-static const struct regulator_ops rtq2208_regulator_ldo_ops = {
+static const struct regulator_ops rtq2208_regulator_ldo_fix_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -229,6 +229,23 @@ static const struct regulator_ops rtq2208_regulator_ldo_ops = {
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
 static unsigned int rtq2208_of_map_mode(unsigned int mode)
 {
 	switch (mode) {
@@ -323,12 +340,12 @@ static irqreturn_t rtq2208_irq_handler(int irqno, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int rtq2208_of_get_fixed_voltage(struct device *dev,
+static int rtq2208_of_get_ldo_dvs_ability(struct device *dev,
 					struct of_regulator_match *rtq2208_ldo_match, int n_fixed)
 {
 	struct device_node *np;
 	struct of_regulator_match *match;
-	struct rtq2208_regulator_desc *rdesc;
+	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
 	int ret, i;
 
@@ -349,13 +366,20 @@ static int rtq2208_of_get_fixed_voltage(struct device *dev,
 	for (i = 0; i < n_fixed; i++) {
 		match = rtq2208_ldo_match + i;
 		init_data = match->init_data;
-		rdesc = (struct rtq2208_regulator_desc *)match->driver_data;
+		desc = (struct regulator_desc *)match->desc;
 
-		if (!init_data || !rdesc)
+		if (!init_data || !desc)
 			continue;
 
-		if (init_data->constraints.min_uV == init_data->constraints.max_uV)
-			rdesc->desc.fixed_uV = init_data->constraints.min_uV;
+		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
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
@@ -482,8 +506,7 @@ static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *
 			rtq2208_ldo_match[idx - RTQ2208_LDO2].desc = &rdesc[i]->desc;
 	}
 
-	/* init ldo fixed_uV */
-	ret = rtq2208_of_get_fixed_voltage(dev, rtq2208_ldo_match, ldo_idx);
+	ret = rtq2208_of_get_ldo_dvs_ability(dev, rtq2208_ldo_match, ldo_idx);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get ldo fixed_uV\n");
 
-- 
2.7.4


