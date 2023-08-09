Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2150477668B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjHIRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHIRj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:39:26 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF210D8;
        Wed,  9 Aug 2023 10:39:26 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379HdGjt115763;
        Wed, 9 Aug 2023 12:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691602756;
        bh=CdF+/PF0GuX8AeEA9MTivaI6srcXKpUQaw6iQUoPB6k=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=gBoZwkl2fqyLfcCZrTTfTTbh0FkFUWfFsY0akeAjjF0NU/CKtJhZdrSXwD+0WgZml
         DXd5J1U1o7OuFNqSE+rPlsu1W/gjOFPu69F+fwayP+chDgEPbxsMWiNnlbVtdwrRz0
         btfTc6LXywCdO1uyA9reVfoA1oAufRQ8r1rtp2Nk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379HdG9N097137
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:39:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:39:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:39:15 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Hd6gb077353;
        Wed, 9 Aug 2023 12:39:11 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Keerthy J <j-keerthy@ti.com>
Subject: [PATCH 1/3] thermal: k3_j72xx_bandgap: Add cooling device support
Date:   Wed, 9 Aug 2023 23:09:03 +0530
Message-ID: <20230809173905.1844132-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809173905.1844132-1-a-nandan@ti.com>
References: <20230809173905.1844132-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Add cpufreq as a cooling device, based on the inputs from the thermal
sensors.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 121 +++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index a5a0fc9b9356..c844cb527761 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -19,6 +19,9 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
 
 #define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
 #define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
@@ -183,10 +186,28 @@ struct k3_j72xx_bandgap {
 /* common data structures */
 struct k3_thermal_data {
 	struct k3_j72xx_bandgap *bgp;
+	struct cpufreq_policy *policy;
+	struct thermal_zone_device *ti_thermal;
+	struct thermal_cooling_device *cool_dev;
+	struct work_struct thermal_wq;
 	u32 ctrl_offset;
 	u32 stat_offset;
+	enum thermal_device_mode mode;
+	int prev_temp;
+	int sensor_id;
 };
 
+static void k3_thermal_work(struct work_struct *work)
+{
+	struct k3_thermal_data *data = container_of(work,
+					struct k3_thermal_data, thermal_wq);
+
+	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
+
+	dev_info(&data->ti_thermal->device, "updated thermal zone %s\n",
+		 data->ti_thermal->type);
+}
+
 static int two_cmp(int tmp, int mask)
 {
 	tmp = ~(tmp);
@@ -251,8 +272,40 @@ static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	return k3_bgp_read_temp(thermal_zone_device_priv(tz), temp);
 }
 
+static int k3_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
+{
+	struct k3_thermal_data *data = tz->devdata;
+	struct k3_j72xx_bandgap *bgp;
+	u32 temp1, temp2;
+	int tr, ret = 0;
+
+	bgp = data->bgp;
+
+	ret = k3_thermal_get_temp(tz, &temp1);
+	if (ret)
+		return ret;
+	temp2 = data->prev_temp;
+
+	tr = temp1 - temp2;
+
+	data->prev_temp = temp1;
+
+	if (tr > 0)
+		*trend = THERMAL_TREND_RAISING;
+	else if (tr < 0)
+		*trend = THERMAL_TREND_DROPPING;
+	else
+		*trend = THERMAL_TREND_STABLE;
+
+	dev_dbg(bgp->dev, "The temperatures are t1 = %d and t2 = %d and trend =%d\n",
+		temp1, temp2, *trend);
+
+	return ret;
+}
+
 static const struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
+	.get_trend = k3_thermal_get_trend,
 };
 
 static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
@@ -342,6 +395,63 @@ struct k3_j72xx_bandgap_data {
 	const bool has_errata_i2128;
 };
 
+static int k3_thermal_register_cpu_cooling(struct k3_j72xx_bandgap *bgp, int id)
+{
+	struct k3_thermal_data *data;
+	struct device_node *np = bgp->dev->of_node;
+
+	/*
+	 * We are assuming here that if one deploys the zone
+	 * using DT, then it must be aware that the cooling device
+	 * loading has to happen via cpufreq driver.
+	 */
+	if (of_find_property(np, "#thermal-sensor-cells", NULL))
+		return 0;
+
+	data = bgp->ts_data[id];
+	if (!data)
+		return -EINVAL;
+
+	data->policy = cpufreq_cpu_get(0);
+	if (!data->policy) {
+		pr_debug("%s: CPUFreq policy not found\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	/* Register cooling device */
+	data->cool_dev = cpufreq_cooling_register(data->policy);
+	if (IS_ERR(data->cool_dev)) {
+		int ret = PTR_ERR(data->cool_dev);
+
+		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
+			ret);
+		cpufreq_cpu_put(data->policy);
+
+		return ret;
+	}
+
+	data->mode = THERMAL_DEVICE_ENABLED;
+
+	INIT_WORK(&data->thermal_wq, k3_thermal_work);
+
+	return 0;
+}
+
+static int k3_thermal_unregister_cpu_cooling(struct k3_j72xx_bandgap *bgp, int id)
+{
+	struct k3_thermal_data *data;
+
+	data = bgp->ts_data[id];
+
+	if (!IS_ERR_OR_NULL(data)) {
+		cpufreq_cooling_unregister(data->cool_dev);
+		if (data->policy)
+			cpufreq_cpu_put(data->policy);
+	}
+
+	return 0;
+}
+
 static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 {
 	int ret = 0, cnt, val, id;
@@ -452,6 +562,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	/* Register the thermal sensors */
 	for (id = 0; id < cnt; id++) {
 		data[id].bgp = bgp;
+		data[id].sensor_id = id;
 		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
 		data[id].stat_offset = data[id].ctrl_offset +
 					K3_VTM_TMPSENS_STAT_OFFSET;
@@ -477,6 +588,12 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
 
 		bgp->ts_data[id] = &data[id];
+
+		if (id == 1)
+			ret = k3_thermal_register_cpu_cooling(bgp, 1);
+		if (ret)
+			goto err_alloc;
+
 		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
 							   &k3_of_thermal_ops);
 		if (IS_ERR(ti_thermal)) {
@@ -514,6 +631,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_ref_table:
+	k3_thermal_unregister_cpu_cooling(bgp, 1);
 	kfree(ref_table);
 
 err_alloc:
@@ -525,6 +643,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 
 static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
 {
+	struct k3_j72xx_bandgap *bgp = platform_get_drvdata(pdev);
+
+	k3_thermal_unregister_cpu_cooling(bgp, 1);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.34.1

