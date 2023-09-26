Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25777AE4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjIZEkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjIZEkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:40:25 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD152E9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:17 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1dc863efb61so4327790fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695703217; x=1696308017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsTEiGLEIoP2dw7+MHGjmKSR5eD5gS3NgglU4Z920oU=;
        b=hJh5odHSTYM75ZLxrFqVlIjD3UVv9BdKWmRk/gGy2EupwemjTA309VD5ZtjszxHqRo
         HkVjXK0Yf43uUGouP+xOc1+S28LQFK/rnTj6SQzFSQyZxB1JPNiiIDrGvHsq/ylNtuoR
         XwqUOBRQ4B2r8AjDQPqwoAlkbODMNfzJqIcic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703217; x=1696308017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsTEiGLEIoP2dw7+MHGjmKSR5eD5gS3NgglU4Z920oU=;
        b=qynmKmufPHv+mmu5euAVaJ4PHPIiqfJQLtSUMnrXnAY9H1GE/CYd3vQqfg6r0b/9CA
         c1aymE5VPTHAyqKIQSacsuAV35MRPoClDxyGyTX+srjzQZgSwL92W80S4Ow8pIYcon6u
         qxpAXWRjY4RV6gTwKd4BO+rBuxVt2c8oVShpU7QPu3gwqAtCvMGO4RArsbcrd7+7BS6K
         scaVXj4hRxR7gsfqll3o7FdzT/THG3tnkzqKzcXex/RiZeBNr9EYm6J5zv6f19t6cTZL
         NzCTRji9/f+6UBx5SXvhJM+q9tkDYoK/9Cb51rBnb9U8NnNpCYvwBO5qUy3Pmmch+K8T
         Pu3w==
X-Gm-Message-State: AOJu0YzYJvAU2xiEZlgVePFZAYUGBqShZbaGZ8D9Bc6OYNEyCskradCj
        uJ51l88lHM2cavAer4jur4rdNQ==
X-Google-Smtp-Source: AGHT+IFz+38AnulHRK8KSajuFBpuds9/FzZn/SgTmE237zYOufSKmzP1S0S4i0NkHmQhv68y0tAsBA==
X-Received: by 2002:a05:6870:470c:b0:1d5:8da3:f057 with SMTP id b12-20020a056870470c00b001d58da3f057mr10366065oaq.59.1695703216823;
        Mon, 25 Sep 2023 21:40:16 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ba86:87c4:df1a:be60])
        by smtp.gmail.com with ESMTPSA id p11-20020a63ab0b000000b00563590be25esm8667210pgf.29.2023.09.25.21.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 21:40:16 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND v3 3/3] regulator: mt6358: Add output voltage fine tuning to variable LDOs
Date:   Tue, 26 Sep 2023 12:34:48 +0800
Message-ID: <20230926043450.2353320-4-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926043450.2353320-1-wenst@chromium.org>
References: <20230926043450.2353320-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the LDO regulators in the MT6358/MT6366 have sparsely populated
voltage tables, supported by custom get/set operators. While it works,
it requires more code and an extra field to store the lookup table.
These LDOs also have fine voltage calibration settings that can slightly
boost the output voltage from 0 mV to 100 mV, in 10 mV increments.

These combined could be modeled as a pickable set of linear ranges. The
coarse voltage setting is modeled as the range selector, while each
range has 11 selectors, starting from the range's base voltage, up to
+100 mV, in 10mV increments.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mt6358-regulator.c | 275 +++++++++++----------------
 1 file changed, 115 insertions(+), 160 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index f2eb0c14d1ed..c4ecac5f3fc8 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -26,8 +26,6 @@ struct mt6358_regulator_info {
 	struct regulator_desc desc;
 	u32 status_reg;
 	u32 qi;
-	const u32 *index_table;
-	unsigned int n_table;
 	u32 da_vsel_reg;
 	u32 da_vsel_mask;
 	u32 modeset_reg;
@@ -64,9 +62,7 @@ struct mt6358_regulator_info {
 	.modeset_mask = BIT(_modeset_shift),	\
 }
 
-#define MT6358_LDO(match, vreg, ldo_volt_table,	\
-	ldo_index_table, enreg, enbit, vosel,	\
-	vosel_mask)	\
+#define MT6358_LDO(match, vreg, volt_ranges, enreg, enbit, vosel, vosel_mask) \
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
@@ -75,17 +71,19 @@ struct mt6358_regulator_info {
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
-		.n_voltages = ARRAY_SIZE(ldo_volt_table),	\
-		.volt_table = ldo_volt_table,	\
-		.vsel_reg = vosel,	\
-		.vsel_mask = vosel_mask,	\
+		.n_voltages = ARRAY_SIZE(volt_ranges##_ranges) * 11,	\
+		.linear_ranges = volt_ranges##_ranges,		\
+		.linear_range_selectors_bitfield = volt_ranges##_selectors,	\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges##_ranges),	\
+		.vsel_range_reg = vosel,	\
+		.vsel_range_mask = vosel_mask,	\
+		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
+		.vsel_mask = GENMASK(3, 0),	\
 		.enable_reg = enreg,	\
 		.enable_mask = BIT(enbit),	\
 	},	\
 	.status_reg = MT6358_LDO_##vreg##_CON1,	\
 	.qi = BIT(15),	\
-	.index_table = ldo_index_table,	\
-	.n_table = ARRAY_SIZE(ldo_index_table),	\
 }
 
 #define MT6358_LDO1(match, vreg, min, max, step,	\
@@ -163,9 +161,7 @@ struct mt6358_regulator_info {
 	.modeset_mask = BIT(_modeset_shift),	\
 }
 
-#define MT6366_LDO(match, vreg, ldo_volt_table,	\
-	ldo_index_table, enreg, enbit, vosel,	\
-	vosel_mask)	\
+#define MT6366_LDO(match, vreg, volt_ranges, enreg, enbit, vosel, vosel_mask) \
 [MT6366_ID_##vreg] = {	\
 	.desc = {	\
 		.name = #vreg,	\
@@ -174,17 +170,19 @@ struct mt6358_regulator_info {
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6366_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
-		.n_voltages = ARRAY_SIZE(ldo_volt_table),	\
-		.volt_table = ldo_volt_table,	\
-		.vsel_reg = vosel,	\
-		.vsel_mask = vosel_mask,	\
+		.n_voltages = ARRAY_SIZE(volt_ranges##_ranges) * 11,	\
+		.linear_ranges = volt_ranges##_ranges,		\
+		.linear_range_selectors_bitfield = volt_ranges##_selectors,	\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges##_ranges),	\
+		.vsel_range_reg = vosel,	\
+		.vsel_range_mask = vosel_mask,	\
+		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
+		.vsel_mask = GENMASK(3, 0),	\
 		.enable_reg = enreg,	\
 		.enable_mask = BIT(enbit),	\
 	},	\
 	.status_reg = MT6358_LDO_##vreg##_CON1,	\
 	.qi = BIT(15),	\
-	.index_table = ldo_index_table,	\
-	.n_table = ARRAY_SIZE(ldo_index_table),	\
 }
 
 #define MT6366_LDO1(match, vreg, min, max, step,	\
@@ -235,95 +233,95 @@ struct mt6358_regulator_info {
 }
 
 
-static const unsigned int vdram2_voltages[] = {
-	600000, 1800000,
-};
-
-static const unsigned int vsim_voltages[] = {
-	1700000, 1800000, 2700000, 3000000, 3100000,
-};
-
-static const unsigned int vibr_voltages[] = {
-	1200000, 1300000, 1500000, 1800000,
-	2000000, 2800000, 3000000, 3300000,
+/* VDRAM2 voltage selector not shown in datasheet */
+static const unsigned int vdram2_selectors[] = { 0, 12 };
+static const struct linear_range vdram2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
 };
 
-static const unsigned int vusb_voltages[] = {
-	3000000, 3100000,
+static const unsigned int vsim_selectors[] = { 3, 4, 8, 11, 12 };
+static const struct linear_range vsim_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
 };
 
-static const unsigned int vcamd_voltages[] = {
-	900000, 1000000, 1100000, 1200000,
-	1300000, 1500000, 1800000,
+static const unsigned int vibr_selectors[] = { 0, 1, 2, 4, 5, 9, 11, 13 };
+static const struct linear_range vibr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
 };
 
-static const unsigned int vefuse_voltages[] = {
-	1700000, 1800000, 1900000,
+/* VUSB voltage selector not shown in datasheet */
+static const unsigned int vusb_selectors[] = { 3, 4 };
+static const struct linear_range vusb_ranges[] = {
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
 };
 
-static const unsigned int vmch_vemc_voltages[] = {
-	2900000, 3000000, 3300000,
+static const unsigned int vcamd_selectors[] = { 3, 4, 5, 6, 7, 9, 12 };
+static const struct linear_range vcamd_ranges[] = {
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
 };
 
-static const unsigned int vcama_voltages[] = {
-	1800000, 2500000, 2700000,
-	2800000, 2900000, 3000000,
+static const unsigned int vefuse_selectors[] = { 11, 12, 13 };
+static const struct linear_range vefuse_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0, 10, 10000),
 };
 
-static const unsigned int vcn33_voltages[] = {
-	3300000, 3400000, 3500000,
+static const unsigned int vmch_vemc_selectors[] = { 2, 3, 5 };
+static const struct linear_range vmch_vemc_ranges[] = {
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
 };
 
-static const unsigned int vmc_voltages[] = {
-	1800000, 2900000, 3000000, 3300000,
+static const unsigned int vcama_selectors[] = { 0, 7, 9, 10, 11, 12 };
+static const struct linear_range vcama_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
 };
 
-static const unsigned int vldo28_voltages[] = {
-	2800000, 3000000,
+static const unsigned int vcn33_selectors[] = { 1, 2, 3 };
+static const struct linear_range vcn33_ranges[] = {
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0, 10, 10000),
 };
 
-static const u32 vdram2_idx[] = {
-	0, 12,
+static const unsigned int vmc_selectors[] = { 4, 10, 11, 13 };
+static const struct linear_range vmc_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
 };
 
-static const u32 vsim_idx[] = {
-	3, 4, 8, 11, 12,
-};
-
-static const u32 vibr_idx[] = {
-	0, 1, 2, 4, 5, 9, 11, 13,
-};
-
-static const u32 vusb_idx[] = {
-	3, 4,
-};
-
-static const u32 vcamd_idx[] = {
-	3, 4, 5, 6, 7, 9, 12,
-};
-
-static const u32 vefuse_idx[] = {
-	11, 12, 13,
-};
-
-static const u32 vmch_vemc_idx[] = {
-	2, 3, 5,
-};
-
-static const u32 vcama_idx[] = {
-	0, 7, 9, 10, 11, 12,
-};
-
-static const u32 vcn33_idx[] = {
-	1, 2, 3,
-};
-
-static const u32 vmc_idx[] = {
-	4, 10, 11, 13,
-};
-
-static const u32 vldo28_idx[] = {
-	1, 3,
+static const unsigned int vldo28_selectors[] = { 1, 3 };
+static const struct linear_range vldo28_ranges[] = {
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
 };
 
 static unsigned int mt6358_map_mode(unsigned int mode)
@@ -332,49 +330,6 @@ static unsigned int mt6358_map_mode(unsigned int mode)
 		REGULATOR_MODE_NORMAL : REGULATOR_MODE_FAST;
 }
 
-static int mt6358_set_voltage_sel(struct regulator_dev *rdev,
-				  unsigned int selector)
-{
-	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
-	int idx, ret;
-	const u32 *pvol;
-
-	pvol = info->index_table;
-
-	idx = pvol[selector];
-	idx <<= ffs(info->desc.vsel_mask) - 1;
-	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
-				 info->desc.vsel_mask, idx);
-
-	return ret;
-}
-
-static int mt6358_get_voltage_sel(struct regulator_dev *rdev)
-{
-	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
-	int idx, ret;
-	u32 selector;
-	const u32 *pvol;
-
-	ret = regmap_read(rdev->regmap, info->desc.vsel_reg, &selector);
-	if (ret != 0) {
-		dev_info(&rdev->dev,
-			 "Failed to get mt6358 %s vsel reg: %d\n",
-			 info->desc.name, ret);
-		return ret;
-	}
-
-	selector = (selector & info->desc.vsel_mask) >>
-			(ffs(info->desc.vsel_mask) - 1);
-	pvol = info->index_table;
-	for (idx = 0; idx < info->desc.n_voltages; idx++) {
-		if (pvol[idx] == selector)
-			return idx;
-	}
-
-	return -EINVAL;
-}
-
 static int mt6358_get_buck_voltage_sel(struct regulator_dev *rdev)
 {
 	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
@@ -483,10 +438,10 @@ static const struct regulator_ops mt6358_volt_range_ops = {
 };
 
 static const struct regulator_ops mt6358_volt_table_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_iterate,
-	.set_voltage_sel = mt6358_set_voltage_sel,
-	.get_voltage_sel = mt6358_get_voltage_sel,
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.map_voltage = regulator_map_voltage_pickable_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -546,34 +501,34 @@ static const struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_REG_FIXED("ldo_vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
 	MT6358_REG_FIXED("ldo_vaud28", VAUD28,
 			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
-	MT6358_LDO("ldo_vdram2", VDRAM2, vdram2_voltages, vdram2_idx,
+	MT6358_LDO("ldo_vdram2", VDRAM2, vdram2,
 		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0xf),
-	MT6358_LDO("ldo_vsim1", VSIM1, vsim_voltages, vsim_idx,
+	MT6358_LDO("ldo_vsim1", VSIM1, vsim,
 		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vibr", VIBR, vibr_voltages, vibr_idx,
+	MT6358_LDO("ldo_vibr", VIBR, vibr,
 		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vusb", VUSB, vusb_voltages, vusb_idx,
+	MT6358_LDO("ldo_vusb", VUSB, vusb,
 		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
-	MT6358_LDO("ldo_vcamd", VCAMD, vcamd_voltages, vcamd_idx,
+	MT6358_LDO("ldo_vcamd", VCAMD, vcamd,
 		   MT6358_LDO_VCAMD_CON0, 0, MT6358_VCAMD_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vefuse", VEFUSE, vefuse_voltages, vefuse_idx,
+	MT6358_LDO("ldo_vefuse", VEFUSE, vefuse,
 		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vmch", VMCH, vmch_vemc_voltages, vmch_vemc_idx,
+	MT6358_LDO("ldo_vmch", VMCH, vmch_vemc,
 		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
-	MT6358_LDO("ldo_vcama1", VCAMA1, vcama_voltages, vcama_idx,
+	MT6358_LDO("ldo_vcama1", VCAMA1, vcama,
 		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
+	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc,
 		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
-	MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
+	MT6358_LDO("ldo_vcn33", VCN33, vcn33,
 		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
-	MT6358_LDO("ldo_vcama2", VCAMA2, vcama_voltages, vcama_idx,
+	MT6358_LDO("ldo_vcama2", VCAMA2, vcama,
 		   MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
+	MT6358_LDO("ldo_vmc", VMC, vmc,
 		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
-	MT6358_LDO("ldo_vldo28", VLDO28, vldo28_voltages, vldo28_idx,
+	MT6358_LDO("ldo_vldo28", VLDO28, vldo28,
 		   MT6358_LDO_VLDO28_CON0_0, 0,
 		   MT6358_VLDO28_ANA_CON0, 0x300),
-	MT6358_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
+	MT6358_LDO("ldo_vsim2", VSIM2, vsim,
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
 	MT6358_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
@@ -622,25 +577,25 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 	MT6366_REG_FIXED("ldo_vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
 	MT6366_REG_FIXED("ldo_vaud28", VAUD28,
 			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
-	MT6366_LDO("ldo_vdram2", VDRAM2, vdram2_voltages, vdram2_idx,
+	MT6366_LDO("ldo_vdram2", VDRAM2, vdram2,
 		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0x10),
-	MT6366_LDO("ldo_vsim1", VSIM1, vsim_voltages, vsim_idx,
+	MT6366_LDO("ldo_vsim1", VSIM1, vsim,
 		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vibr", VIBR, vibr_voltages, vibr_idx,
+	MT6366_LDO("ldo_vibr", VIBR, vibr,
 		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vusb", VUSB, vusb_voltages, vusb_idx,
+	MT6366_LDO("ldo_vusb", VUSB, vusb,
 		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
-	MT6366_LDO("ldo_vefuse", VEFUSE, vefuse_voltages, vefuse_idx,
+	MT6366_LDO("ldo_vefuse", VEFUSE, vefuse,
 		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vmch", VMCH, vmch_vemc_voltages, vmch_vemc_idx,
+	MT6366_LDO("ldo_vmch", VMCH, vmch_vemc,
 		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
-	MT6366_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
+	MT6366_LDO("ldo_vemc", VEMC, vmch_vemc,
 		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
-	MT6366_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
+	MT6366_LDO("ldo_vcn33", VCN33, vcn33,
 		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
-	MT6366_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
+	MT6366_LDO("ldo_vmc", VMC, vmc,
 		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
+	MT6366_LDO("ldo_vsim2", VSIM2, vsim,
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
 	MT6366_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
-- 
2.42.0.515.g380fc7ccd1-goog

