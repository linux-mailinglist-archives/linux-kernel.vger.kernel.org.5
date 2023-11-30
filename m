Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4913F7FF6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbjK3Quc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjK3Qua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:50:30 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276410DB;
        Thu, 30 Nov 2023 08:50:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C76ED1BF206;
        Thu, 30 Nov 2023 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701363034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jMLITpTzeh8DNALLYB3xaXz0o3Zgf4CFfgP7CSSCYRg=;
        b=g33WAfc7EIx8vMc/7Ld2/3ipneCfG0NkAkdKQKPk9IGkTzfjI9CR5T6hkPuFQcLOEVEAK3
        7bmgCa2cTKSUcpcRASfUEgbdioYFBJmxCiDduRTjaQoJKY0RLpD0YbfdsNlyQVA2RGEXqw
        /6o+A0P2fPoFMO9YRHqRDMWdczLYi1Pv133HmcQIflqIc+McZpBxiPQ5MbNuPxEGkFHX1o
        si3if3oO2zH0u/g5xxPOvt+lshhCEOV3kUI1wPHBOWZqSlSvEb0D3WoXT0+fgJtHVhSZ8n
        09RDB8xZGoMH56StEa4+3DlezjN56T9kUQ0DznK7DM4nInKWY1s8QitCvaIVqw==
From:   Thomas Richard <thomas.richard@bootlin.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
        u-kumar1@ti.com, Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH v2] thermal: k3_j72xx_bandgap: implement suspend/resume support
Date:   Thu, 30 Nov 2023 17:49:53 +0100
Message-Id: <20231130164953.2043305-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Théo Lebrun <theo.lebrun@bootlin.com>

This add suspend-to-ram support.

The derived_table is kept-as is, so the resume is only about
pm_runtime_* calls and restoring the same registers as the probe.

Extract the hardware initialization procedure to a function called at
both probe-time & resume-time.

The probe-time loop is split in two to ensure doing the hardware
initialization before registering thermal zones. That ensures our
callbacks cannot be called while in bad state.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---

v2:
- Fix warnings/errors reported by kernel test robot

 drivers/thermal/k3_j72xx_bandgap.c | 112 ++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index c74094a86982..4ad23c8bf73b 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -178,6 +178,7 @@ struct k3_j72xx_bandgap {
 	void __iomem *base;
 	void __iomem *cfg2_base;
 	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
+	int cnt;
 };
 
 /* common data structures */
@@ -338,24 +339,53 @@ static void print_look_up_table(struct device *dev, int *ref_table)
 		dev_dbg(dev, "%d       %d %d\n", i, derived_table[i], ref_table[i]);
 }
 
+static void k3_j72xx_bandgap_init_hw(struct k3_j72xx_bandgap *bgp)
+{
+	struct k3_thermal_data *data;
+	int id, high_max, low_temp;
+	u32 val;
+
+	for (id = 0; id < bgp->cnt; id++) {
+		data = bgp->ts_data[id];
+		val = readl(bgp->cfg2_base + data->ctrl_offset);
+		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
+			K3_VTM_TMPSENS_CTRL_SOC |
+			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
+		writel(val, bgp->cfg2_base + data->ctrl_offset);
+	}
+
+	/*
+	 * Program TSHUT thresholds
+	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
+	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
+	 *         This is already taken care as per of init
+	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
+	 */
+	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
+	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
+
+	writel((low_temp << 16) | high_max, bgp->cfg2_base + K3_VTM_MISC_CTRL2_OFFSET);
+	mdelay(100);
+	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, bgp->cfg2_base + K3_VTM_MISC_CTRL_OFFSET);
+}
+
 struct k3_j72xx_bandgap_data {
 	const bool has_errata_i2128;
 };
 
 static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 {
-	int ret = 0, cnt, val, id;
-	int high_max, low_temp;
-	struct resource *res;
+	const struct k3_j72xx_bandgap_data *driver_data;
+	struct thermal_zone_device *ti_thermal;
 	struct device *dev = &pdev->dev;
+	bool workaround_needed = false;
 	struct k3_j72xx_bandgap *bgp;
 	struct k3_thermal_data *data;
-	bool workaround_needed = false;
-	const struct k3_j72xx_bandgap_data *driver_data;
-	struct thermal_zone_device *ti_thermal;
-	int *ref_table;
 	struct err_values err_vals;
 	void __iomem *fuse_base;
+	int ret = 0, val, id;
+	struct resource *res;
+	int *ref_table;
 
 	const s64 golden_factors[] = {
 		-490019999999999936,
@@ -422,10 +452,10 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 
 	/* Get the sensor count in the VTM */
 	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
-	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
-	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
+	bgp->cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
+	bgp->cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
 
-	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
+	data = devm_kcalloc(bgp->dev, bgp->cnt, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
 		goto err_alloc;
@@ -449,8 +479,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	else
 		init_table(3, ref_table, pvt_wa_factors);
 
-	/* Register the thermal sensors */
-	for (id = 0; id < cnt; id++) {
+	/* Precompute the derived table & fill each thermal sensor struct */
+	for (id = 0; id < bgp->cnt; id++) {
 		data[id].bgp = bgp;
 		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
 		data[id].stat_offset = data[id].ctrl_offset +
@@ -470,13 +500,13 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		else if (id == 0 && !workaround_needed)
 			memcpy(derived_table, ref_table, TABLE_SIZE * 4);
 
-		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
-		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
-			K3_VTM_TMPSENS_CTRL_SOC |
-			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
-		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
-
 		bgp->ts_data[id] = &data[id];
+	}
+
+	k3_j72xx_bandgap_init_hw(bgp);
+
+	/* Register the thermal sensors */
+	for (id = 0; id < bgp->cnt; id++) {
 		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
 							   &k3_of_thermal_ops);
 		if (IS_ERR(ti_thermal)) {
@@ -486,21 +516,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		}
 	}
 
-	/*
-	 * Program TSHUT thresholds
-	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
-	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
-	 *         This is already taken care as per of init
-	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
-	 */
-	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
-	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
-
-	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
-	       K3_VTM_MISC_CTRL2_OFFSET);
-	mdelay(100);
-	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
-	       K3_VTM_MISC_CTRL_OFFSET);
+	platform_set_drvdata(pdev, bgp);
 
 	print_look_up_table(dev, ref_table);
 	/*
@@ -527,6 +543,35 @@ static void k3_j72xx_bandgap_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static int __maybe_unused k3_j72xx_bandgap_suspend(struct device *dev)
+{
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return 0;
+}
+
+static int __maybe_unused k3_j72xx_bandgap_resume(struct device *dev)
+{
+	struct k3_j72xx_bandgap *bgp = dev_get_drvdata(dev);
+	int ret;
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
+	k3_j72xx_bandgap_init_hw(bgp);
+
+	return 0;
+}
+
+static const struct dev_pm_ops k3_j72xx_bandgap_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(k3_j72xx_bandgap_suspend, k3_j72xx_bandgap_resume)
+};
+
 static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
 	.has_errata_i2128 = true,
 };
@@ -554,6 +599,7 @@ static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
 	.driver = {
 		.name = "k3-j72xx-soc-thermal",
 		.of_match_table	= of_k3_j72xx_bandgap_match,
+		.pm = &k3_j72xx_bandgap_pm_ops,
 	},
 };
 
-- 
2.39.2

