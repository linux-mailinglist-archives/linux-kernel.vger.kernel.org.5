Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A748B775237
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHIFaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHIFaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:30:20 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C232B19BC;
        Tue,  8 Aug 2023 22:30:18 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3795U12R023810;
        Wed, 9 Aug 2023 13:30:01 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RLJVY3vShz2PD4gy;
        Wed,  9 Aug 2023 13:28:05 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 9 Aug 2023
 13:30:00 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <chunyan.zhang@unisoc.com>, <yuelin.tang@unisoc.com>,
        Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH] mmc: core: Add host specific tuning support for SD HS mode
Date:   Wed, 9 Aug 2023 13:29:52 +0800
Message-ID: <20230809052952.323-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 3795U12R023810
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added .prepare_hs_tuning and .execute_hs_tuning host
callbacks to support host-specific tuning for SD high
speed mode.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/core/sd.c         |  12 ++++
 drivers/mmc/host/sdhci-sprd.c | 124 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h      |   6 ++
 3 files changed, 142 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 246ce027ae0a..ac2da8f2fbce 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1518,6 +1518,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		 */
 		mmc_set_clock(host, mmc_sd_get_max_clock(card));
 
+		if (host->ops->prepare_hs_tuning) {
+			err = host->ops->prepare_hs_tuning(host, card);
+			if (err)
+				goto free_card;
+		}
+
 		/*
 		 * Switch to wider bus (if supported).
 		 */
@@ -1529,6 +1535,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 
 			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
 		}
+
+		if (host->ops->execute_hs_tuning) {
+			err = host->ops->execute_hs_tuning(host, card);
+			if (err)
+				goto free_card;
+		}
 	}
 cont:
 	if (!oldcard) {
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 7f4ee2e12735..5f365dcbb9c7 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/iopoll.h>
+#include <linux/mmc/mmc.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -22,6 +23,9 @@
 #include "sdhci-pltfm.h"
 #include "mmc_hsq.h"
 
+#include "../core/mmc_ops.h"
+#include "../core/sd_ops.h"
+
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
 
@@ -73,6 +77,11 @@
 #define SDHCI_SPRD_CLK_DEF_RATE		26000000
 #define SDHCI_SPRD_PHY_DLL_CLK		52000000
 
+#define SDHCI_SPRD_MAX_PHASE		0xff
+#define SDHCI_SPRD_CMD_DLY_MASK		GENMASK(15, 8)
+#define SDHCI_SPRD_POSRD_DLY_MASK	GENMASK(23, 16)
+#define SDHCI_SPRD_CPST_EN		GENMASK(27, 24)
+
 struct sdhci_sprd_host {
 	u32 version;
 	struct clk *clk_sdio;
@@ -86,6 +95,11 @@ struct sdhci_sprd_host {
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
@@ -533,6 +547,111 @@ static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
 		     SDHCI_SPRD_REG_32_DLL_DLY);
 }
 
+static int mmc_send_tuning_cmd(struct mmc_card *card)
+{
+	return mmc_send_status(card, NULL);
+}
+
+static int mmc_send_tuning_data(struct mmc_card *card)
+{
+	u8 status[64];
+
+	return mmc_sd_switch(card, 0, 0, 0, status);
+}
+
+static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
+			enum sdhci_sprd_tuning_type type)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	u32 *p = sprd_host->phy_delay;
+	int err = 0;
+	int i;
+	bool value;
+	int final_phase;
+	u32 dll_cfg, dll_dly;
+	int range_end = SDHCI_SPRD_MAX_PHASE;
+	int len = 0;
+	int count = 0;
+
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	dll_cfg = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	dll_cfg &= ~SDHCI_SPRD_CPST_EN;
+	sdhci_writel(host, dll_cfg, SDHCI_SPRD_REG_32_DLL_CFG);
+
+	dll_dly = p[mmc->ios.timing];
+
+	for (i = 0; i <= SDHCI_SPRD_MAX_PHASE; i++) {
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
+			value = !mmc_send_tuning_cmd(card);
+		else
+			value = !mmc_send_tuning_data(card);
+
+		if (value) {
+			dev_dbg(mmc_dev(host->mmc), "tuning ok: %d\n", i);
+			count++;
+		} else {
+			dev_dbg(mmc_dev(host->mmc), "tuning fail: %d\n", i);
+			if (len < count) {
+				len = count;
+				range_end = i - 1;
+				count = 0;
+			}
+		}
+	}
+
+	if (!count) {
+		final_phase = 0;
+		dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
+		err = -EIO;
+		goto out;
+	}
+
+	if (count > len) {
+		len = count;
+		range_end = i - 1;
+	}
+
+	final_phase = range_end - (len - 1) / 2;
+
+	if (type == SDHCI_SPRD_TUNING_SD_HS_CMD) {
+		p[mmc->ios.timing] &= ~SDHCI_SPRD_CMD_DLY_MASK;
+		p[mmc->ios.timing] |= ((final_phase << 8) & SDHCI_SPRD_CMD_DLY_MASK);
+	} else {
+		p[mmc->ios.timing] &= ~(SDHCI_SPRD_POSRD_DLY_MASK);
+		p[mmc->ios.timing] |= ((final_phase << 16) & SDHCI_SPRD_POSRD_DLY_MASK);
+	}
+
+	dev_info(mmc_dev(host->mmc), "the best step %d, phase 0x%02x, delay value 0x%08x\n",
+			final_phase, final_phase, p[mmc->ios.timing]);
+
+out:
+	sdhci_writel(host, p[mmc->ios.timing], SDHCI_SPRD_REG_32_DLL_DLY);
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
@@ -577,6 +696,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
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
index 461d1543893b..13cf894b9e3c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -184,6 +184,12 @@ struct mmc_host_ops {
 	/* Execute HS400 tuning depending host driver */
 	int	(*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
 
+	/* Prepare HS tuning depending host driver */
+	int	(*prepare_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
+
+	/* Execute HS tuning depending host driver */
+	int	(*execute_hs_tuning)(struct mmc_host *host, struct mmc_card *card);
+
 	/* Prepare switch to DDR during the HS400 init sequence */
 	int	(*hs400_prepare_ddr)(struct mmc_host *host);
 
-- 
2.17.1

