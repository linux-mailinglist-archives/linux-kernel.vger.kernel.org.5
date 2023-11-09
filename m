Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97CD7E63FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjKIGh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIGh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:37:58 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1426AF;
        Wed,  8 Nov 2023 22:37:54 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3A96bTwj087373;
        Thu, 9 Nov 2023 14:37:29 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SQsZT1xLrz2MgXmR;
        Thu,  9 Nov 2023 14:32:33 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 9 Nov
 2023 14:37:27 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <zhang.lyra@gmail.com>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH] mmc: sprd: Fix vqmmc not shutting down after the card was pulled
Date:   Thu, 9 Nov 2023 14:37:18 +0800
Message-ID: <20231109063718.316-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 3A96bTwj087373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With cat regulator_summary, we found that vqmmc was not shutting
down after the card was pulled.

cat /sys/kernel/debug/regulator/regulator_summary
1.before fix
1)Insert SD card
 vddsdio		1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2)Pull out the SD card
 vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2.after fix
1)Insert SD cardt
 vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2)Pull out the SD card
 vddsdio		0    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  0                         0mA  3500mV  3600mV

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6b84ba27e6ab..b5f22e48e571 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -90,6 +90,7 @@ struct sdhci_sprd_host {
 	u32 base_rate;
 	int flags; /* backup of host attribute */
 	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
+	u8 power_mode;
 };
 
 enum sdhci_sprd_tuning_type {
@@ -416,12 +417,71 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sdhci_sprd_signal_voltage_switch(struct sdhci_host *host, bool enable)
+{
+	const char *name = mmc_hostname(host->mmc);
+	bool on;
+
+	if (IS_ERR(host->mmc->supply.vqmmc))
+		return;
+
+	on = regulator_is_enabled(host->mmc->supply.vqmmc);
+	if (!(on ^ enable))
+		return;
+
+	if (enable) {
+		if (regulator_enable(host->mmc->supply.vqmmc))
+			pr_err("%s: signal voltage enable fail!\n", name);
+		else if (regulator_is_enabled(host->mmc->supply.vqmmc))
+			pr_debug("%s: signal voltage enable success!\n", name);
+		else
+			pr_err("%s: signal voltage enable hw fail!\n", name);
+	} else {
+		if (regulator_disable(host->mmc->supply.vqmmc))
+			pr_err("%s: signal voltage disable fail\n", name);
+		else if (!regulator_is_enabled(host->mmc->supply.vqmmc))
+			pr_debug("%s: signal voltage disable success!\n", name);
+		else
+			pr_err("%s: signal voltage disable hw fail\n", name);
+	}
+}
+
+static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
+				 unsigned short vdd)
+{
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	struct mmc_host *mmc = host->mmc;
+
+	if (sprd_host->power_mode == mmc->ios.power_mode)
+		return;
+
+	switch (mode) {
+	case MMC_POWER_OFF:
+		sdhci_sprd_signal_voltage_switch(host, false);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+		break;
+	case MMC_POWER_ON:
+	case MMC_POWER_UP:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+
+		/* waiting for mmc->supply.vmmc to stabilize */
+		usleep_range(200, 250);
+		sdhci_sprd_signal_voltage_switch(host, true);
+		break;
+	}
+
+	sprd_host->power_mode = mmc->ios.power_mode;
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
+	.set_power = sdhci_sprd_set_power,
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -805,6 +865,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
 			       SDHCI_VENDOR_VER_SHIFT);
 
+	sprd_host->power_mode = MMC_POWER_OFF;
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.17.1

