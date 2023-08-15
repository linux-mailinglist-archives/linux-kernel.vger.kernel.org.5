Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA777C53D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjHOBmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjHOBlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:41:52 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7ACE7;
        Mon, 14 Aug 2023 18:41:48 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F1fTsu005269;
        Tue, 15 Aug 2023 09:41:29 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPv7s471Vz2P8CXW;
        Tue, 15 Aug 2023 09:39:21 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 09:41:26 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <chunyan.zhang@unisoc.com>, <yuelin.tang@unisoc.com>,
        Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V2 2/2] mmc: sdhci-sprd: Add SD HS mode online tuning
Date:   Tue, 15 Aug 2023 09:40:57 +0800
Message-ID: <20230815014057.13589-3-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815014057.13589-1-wenchao.chen@unisoc.com>
References: <20230815014057.13589-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F1fTsu005269
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, Unisoc's IC provides cmd delay and read delay to ensure
that the host can get the correct data. However, according to SD Spec,
there is no need to do tuning in high speed mode, but with the
development of chip processes, it is more and more difficult to find
a suitable delay to cover all the chips. Therefore, we need SD high
speed mode online tuning.

In addition, we added mmc_sd_switch() and mmc_send_status() to the
header file to allow it to be usable by the drive

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/core/sd_ops.c     |   1 +
 drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h      |   2 +
 3 files changed, 155 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index ef8d1dce5af1..a59cd592f06e 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -323,6 +323,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	return mmc_send_adtc_data(card, card->host, SD_SWITCH, cmd_args, resp,
 				  64);
 }
+EXPORT_SYMBOL_GPL(mmc_sd_switch);
 
 int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 {
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 7f4ee2e12735..96c59e010d4c 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -9,6 +9,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/iopoll.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -73,6 +75,11 @@
 #define SDHCI_SPRD_CLK_DEF_RATE		26000000
 #define SDHCI_SPRD_PHY_DLL_CLK		52000000
 
+#define SDHCI_SPRD_MAX_RANGE		0xff
+#define SDHCI_SPRD_CMD_DLY_MASK		GENMASK(15, 8)
+#define SDHCI_SPRD_POSRD_DLY_MASK	GENMASK(23, 16)
+#define SDHCI_SPRD_CPST_EN		GENMASK(27, 24)
+
 struct sdhci_sprd_host {
 	u32 version;
 	struct clk *clk_sdio;
@@ -86,6 +93,11 @@ struct sdhci_sprd_host {
 	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
 };
 
+enum sdhci_sprd_tuning_type {
+	SDHCI_SPRD_TUNING_SD_HS_CMD,
+	SDHCI_SPRD_TUNING_SD_HS_DATA,
+};
+
 struct sdhci_sprd_phy_cfg {
 	const char *property;
 	u8 timing;
@@ -533,6 +545,141 @@ static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
 		     SDHCI_SPRD_REG_32_DLL_DLY);
 }
 
+static int mmc_send_tuning_cmd(struct mmc_card *card)
+{
+	return mmc_send_status(card, NULL);
+}
+
+static int mmc_send_tuning_data(struct mmc_card *card)
+{
+	u8 *status;
+	int ret;
+
+	status = kmalloc(64, GFP_KERNEL);
+	if (!status)
+		return -ENOMEM;
+
+	ret = mmc_sd_switch(card, 0, 0, 0, status);
+
+	kfree(status);
+
+	return ret;
+}
+
+static int sdhci_sprd_get_best_clk_sample(struct mmc_host *mmc, u8 *value)
+{
+	int range_end = SDHCI_SPRD_MAX_RANGE;
+	int range_length = 0;
+	int middle_range = 0;
+	int count = 0;
+	int i;
+
+	for (i = 0; i <= SDHCI_SPRD_MAX_RANGE; i++) {
+		if (value[i]) {
+			pr_debug("%s: tuning ok: %d\n", mmc_hostname(mmc), i);
+			count++;
+		} else {
+			pr_debug("%s: tuning fail: %d\n", mmc_hostname(mmc), i);
+			if (range_length < count) {
+				range_length = count;
+				range_end = i - 1;
+				count = 0;
+			}
+		}
+	}
+
+	if (!count) {
+		middle_range = 0;
+		return -EIO;
+	}
+
+	if (count > range_length) {
+		range_length = count;
+		range_end = i - 1;
+	}
+
+	middle_range = range_end - (range_length - 1) / 2;
+
+	return middle_range;
+}
+
+
+static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
+			enum sdhci_sprd_tuning_type type)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	u32 *p = sprd_host->phy_delay;
+	u32 dll_cfg, dll_dly;
+	int best_clk_sample;
+	int err = 0;
+	u8 *value;
+	int i;
+
+	value = kmalloc(SDHCI_SPRD_MAX_RANGE + 1, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	dll_cfg = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	dll_cfg &= ~SDHCI_SPRD_CPST_EN;
+	sdhci_writel(host, dll_cfg, SDHCI_SPRD_REG_32_DLL_CFG);
+
+	dll_dly = p[mmc->ios.timing];
+
+	for (i = 0; i <= SDHCI_SPRD_MAX_RANGE; i++) {
+		if (type == SDHCI_SPRD_TUNING_SD_HS_CMD) {
+			dll_dly &= ~SDHCI_SPRD_CMD_DLY_MASK;
+			dll_dly |= ((i << 8) & SDHCI_SPRD_CMD_DLY_MASK);
+		} else {
+			dll_dly &= ~SDHCI_SPRD_POSRD_DLY_MASK;
+			dll_dly |= ((i << 16) & SDHCI_SPRD_POSRD_DLY_MASK);
+		}
+
+		sdhci_writel(host, dll_dly, SDHCI_SPRD_REG_32_DLL_DLY);
+
+		if (type == SDHCI_SPRD_TUNING_SD_HS_CMD)
+			value[i] = !mmc_send_tuning_cmd(card);
+		else
+			value[i] = !mmc_send_tuning_data(card);
+	}
+
+	best_clk_sample = sdhci_sprd_get_best_clk_sample(mmc, value);
+	if (best_clk_sample < 0) {
+		dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
+		goto out;
+	}
+
+	if (type == SDHCI_SPRD_TUNING_SD_HS_CMD) {
+		p[mmc->ios.timing] &= ~SDHCI_SPRD_CMD_DLY_MASK;
+		p[mmc->ios.timing] |= ((best_clk_sample << 8) & SDHCI_SPRD_CMD_DLY_MASK);
+	} else {
+		p[mmc->ios.timing] &= ~(SDHCI_SPRD_POSRD_DLY_MASK);
+		p[mmc->ios.timing] |= ((best_clk_sample << 16) & SDHCI_SPRD_POSRD_DLY_MASK);
+	}
+
+	pr_debug("%s: the best clk sample %d, delay value 0x%08x\n",
+			mmc_hostname(host->mmc), best_clk_sample, p[mmc->ios.timing]);
+
+out:
+	sdhci_writel(host, p[mmc->ios.timing], SDHCI_SPRD_REG_32_DLL_DLY);
+
+	kfree(value);
+
+	return err;
+}
+
+static int sdhci_sprd_prepare_hs_cmd_tuning(struct mmc_host *mmc, struct mmc_card *card)
+{
+	return sdhci_sprd_tuning(mmc, card, SDHCI_SPRD_TUNING_SD_HS_CMD);
+}
+
+static int sdhci_sprd_execute_hs_data_tuning(struct mmc_host *mmc, struct mmc_card *card)
+{
+	return sdhci_sprd_tuning(mmc, card, SDHCI_SPRD_TUNING_SD_HS_DATA);
+}
+
 static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 				       struct device_node *np)
 {
@@ -577,6 +724,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->mmc_host_ops.request = sdhci_sprd_request;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 		sdhci_sprd_hs400_enhanced_strobe;
+	host->mmc_host_ops.prepare_hs_tuning =
+		sdhci_sprd_prepare_hs_cmd_tuning;
+	host->mmc_host_ops.execute_hs_tuning =
+		sdhci_sprd_execute_hs_data_tuning;
+
 	/*
 	 * We can not use the standard ops to change and detect the voltage
 	 * signal for Spreadtrum SD host controller, since our voltage regulator
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 13cf894b9e3c..5d069510dc4b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -671,6 +671,8 @@ static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
 	host->err_stats[stat] += 1;
 }
 
+int mmc_sd_switch(struct mmc_card *card, int mode, int group, u8 value, u8 *resp);
+int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-- 
2.17.1

