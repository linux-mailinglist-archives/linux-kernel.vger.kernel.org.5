Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8849578D253
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbjH3DFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjH3DFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:05:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BABA1BD;
        Tue, 29 Aug 2023 20:05:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37U34fuV6019716, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37U34fuV6019716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 11:04:41 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 30 Aug 2023 11:05:06 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 30 Aug 2023 11:05:05 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Wed, 30 Aug 2023 11:05:05 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <jh80.chung@samsung.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <james.tai@realtek.com>, <jyanchou@realtek.com>
Subject: [PATCH] mmc: Add Synopsys DesignWare mmc cmdq host driver
Date:   Wed, 30 Aug 2023 11:05:03 +0800
Message-ID: <20230830030503.13349-1-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS06.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We implemented cmdq feature on Synopsys DesignWare mmc driver,
and found out the difference between distint version of synopsys'
data book and user guide. Also, we add our Realtek mmc driver
that make good use of it.

Due to synopsys data book's description, it had a limitation
while using DMA that buffer size and start address must not
exceed 128 MB. We modified cqhci-core.c to add an option
flexibley use to set up tran_desc.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>
---
 drivers/mmc/host/Kconfig          |   22 +
 drivers/mmc/host/cqhci-core.c     |    5 +
 drivers/mmc/host/cqhci.h          |    2 +
 drivers/mmc/host/dw_mmc_cqe-rtk.c |  999 ++++++++++++++++++
 drivers/mmc/host/dw_mmc_cqe-rtk.h |  160 +++
 drivers/mmc/host/dw_mmc_cqe.c     | 1633 +++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc_cqe.h     |  442 ++++++++
 7 files changed, 3263 insertions(+)
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.h
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 159a3e9490ae..505f1536a347 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -762,6 +762,19 @@ config MMC_DW_PLTFM
 
 	  If unsure, say Y.
 
+config MMC_DW_CQE
+	tristate "Synopsys DesignWare Memory Card with CQE Interface"
+	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
+	select MMC_CQHCI
+	help
+	  This selects support for the Synopsys DesignWare Mobile Storage IP
+	  block after JEDEC Standard version 5.1. Select this option for SD and
+	  MMC interfaces that use command queue.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say Y.
+
 config MMC_DW_BLUEFIELD
 	tristate "BlueField specific extensions for Synopsys DW Memory Card Interface"
 	depends on MMC_DW
@@ -828,6 +841,15 @@ config MMC_DW_STARFIVE
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on StarFive JH7110 SoC.
 
+config MMC_DW_CQE_RTK
+	tristate "Realtek Soc's specific extensions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW_CQE
+	select REGULATOR_FIXED_VOLTAGE
+	help
+          This selects support for Realtek SoC specific extensions to the
+          Synopsys DesignWare Memory Card Interface driver. Select this option
+          for platforms after RTD16xxb SoC's.
+
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..4d6fb228a21e 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -516,6 +516,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
 	desc = get_trans_desc(cq_host, tag);
 
+	if (cq_host->ops->setup_tran_desc) {
+		cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
+		return 0;
+	}
+
 	for_each_sg(data->sg, sg, sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 1a12e40a02e6..cb3dfb161c54 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -289,6 +289,8 @@ struct cqhci_host_ops {
 				 u64 *data);
 	void (*pre_enable)(struct mmc_host *mmc);
 	void (*post_disable)(struct mmc_host *mmc);
+	void (*setup_tran_desc)(struct mmc_data *data,
+		struct cqhci_host *cq_host, u8 *desc, int sg_count);
 #ifdef CONFIG_MMC_CRYPTO
 	int (*program_key)(struct cqhci_host *cq_host,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
diff --git a/drivers/mmc/host/dw_mmc_cqe-rtk.c b/drivers/mmc/host/dw_mmc_cqe-rtk.c
new file mode 100644
index 000000000000..b2a40daef1a2
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe-rtk.c
@@ -0,0 +1,999 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Realtek Semiconductor Corp.
+ *
+ */
+
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_address.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "dw_mmc_cqe.h"
+#include "dw_mmc_cqe-rtk.h"
+
+#define DW_MCI_TIMEOUT          200000
+#define HS400_WINDOW_ALL_PASS	0xffff
+#define HS200_WINDOW_ALL_PASS	0xffffffff
+#define hs400_dqs_delay_val	0x88
+
+static void dw_mci_rtk_hs400_complete(struct mmc_host *mmc);
+static int dw_mci_rtk_execute_tuning(struct dw_mci_slot *slot, u32 opcode);
+
+static void reset_fifo(struct dw_mci *host)
+{
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) & (~SDMMC_TOP_RST_N_FIFO));
+	udelay(1);
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) | SDMMC_TOP_RST_N_FIFO);
+}
+
+static int dw_mci_rtk_set_pinstates(struct dw_mci_rtkemmc_host *priv,
+					unsigned char timing)
+{
+	switch (timing) {
+	case MMC_TIMING_UHS_SDR50:
+		return pinctrl_select_state(priv->pinctrl,
+					    priv->pins_sdr50);
+
+	case MMC_TIMING_UHS_DDR50:
+		return pinctrl_select_state(priv->pinctrl,
+					    priv->pins_ddr50);
+	case MMC_TIMING_MMC_HS200:
+		return pinctrl_select_state(priv->pinctrl,
+					    priv->pins_hs200);
+
+	case MMC_TIMING_MMC_HS400:
+		return pinctrl_select_state(priv->pinctrl,
+					    priv->pins_hs400);
+	default:
+		return pinctrl_select_state(priv->pinctrl,
+					    priv->pins_default);
+	}
+}
+
+static void dqs_delay_tap_setting(struct dw_mci *host,
+				  u32 dqs_dly)
+{
+	u32 regs;
+
+	regs = mcq_readl(host, DQS_CTRL1) & ~SDMMC_FW_EN;
+	mcq_writel(host, DQS_CTRL1, regs);
+	mcq_writel(host, DQS_CTRL1, dqs_dly);
+
+	regs = dqs_dly | SDMMC_FW_EN;
+	mcq_writel(host, DQS_CTRL1, regs);
+}
+
+static void cmd_delay_tap_setting(struct dw_mci *host,
+				  u32 cmd_dly_tape)
+{
+	u32 regs;
+
+	regs = mcq_readl(host, WCMD_CTRL) & ~SDMMC_FW_SET_EN;
+	mcq_writel(host, WCMD_CTRL, regs);
+
+	if (cmd_dly_tape == 0)
+		return;
+
+	mcq_writel(host, WCMD_CTRL, cmd_dly_tape);
+
+	regs = cmd_dly_tape | SDMMC_FW_SET_EN;
+	mcq_writel(host, WCMD_CTRL, regs);
+}
+
+static void data_delay_tap_setting(struct dw_mci *host)
+{
+	u32 regs;
+	struct dw_mci_rtkemmc_host *priv = host->priv;
+
+	regs = mcq_readl(host, RDQ_CTRL0) & (~SDMMC_FW_SET);
+	mcq_writel(host, RDQ_CTRL0, regs);
+
+	if (priv->rdq_ctrl == 0)
+		return;
+
+	mcq_writel(host, RDQ_CTRL0, priv->rdq_ctrl);
+	mcq_writel(host, RDQ_CTRL1, priv->rdq_ctrl);
+	mcq_writel(host, RDQ_CTRL2, priv->rdq_ctrl);
+	mcq_writel(host, RDQ_CTRL3, priv->rdq_ctrl);
+	mcq_writel(host, RDQ_CTRL4, priv->rdq_ctrl);
+	mcq_writel(host, RDQ_CTRL5, priv->rdq_ctrl);
+	mcq_writel(host, RDQ_CTRL6, priv->rdq_ctrl);
+	mcq_writel(host, RDQ_CTRL7, priv->rdq_ctrl);
+
+	regs = mcq_readl(host, RDQ_CTRL0) | SDMMC_FW_SET;
+	mcq_writel(host, RDQ_CTRL0, regs);
+}
+
+static void setup_clk_div(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	unsigned int clock = slot->clock;
+	u32 div = 0;
+
+	slot->mmc->actual_clock = 0;
+
+	if (clock != host->current_speed) {
+		div = host->bus_hz / clock;
+		if (host->bus_hz % clock)
+			div += 1;
+
+		if (clock != slot->__clk_old) {
+			/* Silent the verbose log if calling from PM context */
+			dev_info(&slot->mmc->class_dev, "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+				slot->id, host->bus_hz, clock,
+				host->bus_hz / div, div);
+		}
+
+		slot->__clk_old = clock;
+		slot->mmc->actual_clock = host->bus_hz / div;
+
+		/*In RealTek Stark platform, they only support div 1,4, and 512*/
+		if (div > 4)
+			div =  512;
+
+		switch (div) {
+		case SDMMC_CLK_DIV1:
+			mcq_writel(host, CKGEN_CTL,
+				mcq_readl(host, CKGEN_CTL) & (~SDMMC_CRC_CLK_DIV_EN));
+			break;
+		case SDMMC_CLK_DIV4:
+			mcq_writel(host, CKGEN_CTL,
+				mcq_readl(host, CKGEN_CTL) | SDMMC_CLK_INV_DIV_SEL);
+			mcq_writel(host, CKGEN_CTL,
+				mcq_readl(host, CKGEN_CTL) | SDMMC_CRC_CLK_DIV_EN);
+			break;
+		case SDMMC_CLK_DIV512:
+			mcq_writel(host, CKGEN_CTL,
+				mcq_readl(host, CKGEN_CTL) & (~SDMMC_CLK_INV_DIV_SEL));
+			mcq_writel(host, CKGEN_CTL,
+				mcq_readl(host, CKGEN_CTL) | SDMMC_CRC_CLK_DIV_EN);
+			break;
+		default:
+			dev_info(&slot->mmc->class_dev, "default case div = %d\n", div);
+			if (div != 0)
+				mcq_writel(host, CKGEN_CTL,
+					mcq_readl(host, CKGEN_CTL) & (~SDMMC_CRC_CLK_DIV_EN));
+			break;
+		}
+	}
+
+	host->current_speed = clock;
+}
+
+static void dw_mci_rtk_phase_tuning(struct dw_mci *host,
+					u32 tx_phase, u32 rx_phase)
+{
+	struct dw_mci_rtkemmc_host *priv = host->priv;
+	u32 t1 = 10;
+	u32 t2 = 3;
+	int ret;
+	u32 status;
+
+	clk_disable(host->ciu_clk);
+	udelay(t1);
+
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) | SDMMC_CLK_DIV_RST);
+
+	if (!IS_ERR(priv->vp0) && !IS_ERR(priv->vp1)) {
+		if (tx_phase != 0xff)
+			clk_set_phase(priv->vp0,  (tx_phase*360)/32);
+		if (rx_phase != 0xff)
+			clk_set_phase(priv->vp1, (rx_phase*360)/32);
+	}
+
+	udelay(t2);
+
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) & ~SDMMC_CLK_DIV_RST);
+
+	clk_enable(host->ciu_clk);
+
+	ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+		(status & SDMMC_INTERNAL_CLK_MSK) == 0x3, 10, DW_MCI_TIMEOUT);
+	if (ret)
+		dev_err(host->dev, "Timeout waiting emmc phase tuning.\n");
+
+	mcq_writeb(host, SW_RST_R, SDMMC_RST_CMD | SDMMC_RST_DAT);
+
+	ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+		(status & SW_RST_BOTH_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+	if (ret)
+		dev_err(host->dev, "Timeout waiting phase tuning sw rest\n");
+
+	reset_fifo(host);
+}
+
+static void adjust_window(struct dw_mci_rtkemmc_host *priv,
+				const char *w_type,
+				unsigned int loop_cnt,
+				unsigned int window)
+{
+	switch (loop_cnt) {
+	case 10:
+		pr_err("try pad driving 3: %s = 0x%08x\n", w_type, window);
+		pinctrl_select_state(priv->pinctrl, priv->pins_tune3);
+		break;
+	case 20:
+		pr_err("try pad driving 2: %s = 0x%08x\n", w_type, window);
+		pinctrl_select_state(priv->pinctrl, priv->pins_tune2);
+		break;
+	case 30:
+		pr_err("try pad driving 1: %s = 0x%08x\n", w_type, window);
+		pinctrl_select_state(priv->pinctrl, priv->pins_tune1);
+		break;
+	case 40:
+		pr_err("try pad driving 0: %s = 0x%08x\n", w_type, window);
+		pinctrl_select_state(priv->pinctrl, priv->pins_tune0);
+		break;
+	case 60:
+		pr_err("loop cnt %d: %s = 0x%08x, cannot find a proper phase\n",
+			loop_cnt, w_type, window);
+	default:
+		break;
+	}
+}
+
+static int search_best(u32 window, u32 range)
+{
+	int i = 0, j = 1, k = 0, max = 0;
+	int window_temp[32];
+	int window_start[32];
+	int window_end[32];
+	int window_max = 0;
+	int window_best = 0;
+	int parse_end = 1;
+
+	for (i = 0; i < 0x20; i++) {
+		window_temp[i] = 0;
+		window_start[i] = 0;
+		window_end[i] = -1;
+	}
+
+	i = 0;
+
+	while ((i < (range - 1)) && (k < (range - 1))) {
+		parse_end = 0;
+		for (i = window_end[j - 1] + 1; i < range; i++) {
+			if (((window >> i) & 1) == 1) {
+				window_start[j] = i;
+				break;
+			}
+		}
+		if (i == range)
+			break;
+
+		for (k = window_start[j] + 1; k < range; k++) {
+			if (((window >> k) & 1) == 0) {
+				window_end[j] = k-1;
+				parse_end = 1;
+				break;
+			}
+		}
+
+		if (parse_end == 0)
+			window_end[j] = range - 1;
+		j++;
+	}
+
+	for (i = 1; i < j; i++)
+		window_temp[i] = window_end[i] - window_start[i] + 1;
+
+	if ((((window) & 1) == 1) && (((window >> (range - 1)) & 1) == 1)) {
+		window_temp[1] = window_temp[1] + window_temp[j - 1];
+		window_start[1] = window_start[j - 1];
+	}
+
+	for (i = 1; i < j; i++) {
+		if (window_temp[i] > window_max) {
+			window_max = window_temp[i];
+			max = i;
+		}
+	}
+
+	if (window == ~0UL)
+		window_best = 0x10;
+	else if ((window == HS400_WINDOW_ALL_PASS) && (range == 0x10))
+		window_best = 0x8;
+	else if ((((window & 1) == 1) && (((window >> (range - 1)) & 1) == 1)) && (max == 1))
+		window_best = (((window_start[max] + window_end[max] +
+				range) / 2) & (range - 1));
+	else
+		window_best = ((window_start[max] + window_end[max]) / 2) & 0x1f;
+
+	/*We set a criteria for 6 continuous points*/
+	if (window_max > 6)
+		return window_best;
+	else
+		return 0xff;
+}
+
+static int dw_mci_rtk_send_tuning(struct mmc_host *mmc, u32 opcode, u32 arg, int size)
+{
+	struct mmc_request mrq = {};
+	struct mmc_command cmd = {};
+	struct mmc_data data = {};
+	struct scatterlist sg;
+	int i, err = 0;
+	u8 *data_buf = NULL;
+
+	cmd.opcode = opcode;
+	cmd.arg = arg;
+
+	if (opcode == MMC_SEND_STATUS)
+		cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+	else
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	mrq.cmd = &cmd;
+	mrq.data = NULL;
+
+	if (opcode == MMC_WRITE_MULTIPLE_BLOCK || opcode == MMC_READ_MULTIPLE_BLOCK) {
+		data_buf = kzalloc(size, GFP_KERNEL);
+		if (!data_buf)
+			return -ENOMEM;
+
+		mrq.data = &data;
+
+		if (opcode == MMC_WRITE_MULTIPLE_BLOCK) {
+			for (i = 0; i < size/4; i++)
+				*(u32 *)(data_buf + i*4) = i;
+			data.flags = MMC_DATA_WRITE;
+		} else {
+			data.flags = MMC_DATA_READ;
+		}
+
+		data.blksz = 512;
+		data.blocks = size / data.blksz;
+
+		data.timeout_ns = 150 * NSEC_PER_MSEC;
+
+		data.sg = &sg;
+		data.sg_len = 1;
+		sg_init_one(&sg, data_buf, size);
+	}
+
+	mmc_wait_for_req(mmc, &mrq);
+
+	if (cmd.error) {
+		err = cmd.error;
+		goto out;
+	}
+
+	if (data.error) {
+		err = data.error;
+		goto out;
+	}
+
+out:
+	return err;
+}
+
+static int dw_mci_rtk_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+{
+	struct dw_mci *host = slot->host;
+	struct dw_mci_rtkemmc_host *priv = host->priv;
+	struct mmc_host *mmc = slot->mmc;
+	u32 tx_window = 0, rx_window = 0;
+	u32 tx_best = 0, rx_best = 0;
+	u32 tx_range, rx_range = 0x20;
+	unsigned int bitmap = 0;
+	unsigned int max = 0;
+	unsigned int loop_cnt = 0;
+	unsigned int reg;
+	int i, j, ret = 0, rsp = 0;
+	bool fail = false;
+	bool dqs_retry = false;
+
+	if (mmc->doing_retune == 1) {
+		dev_err(mmc_dev(mmc), "Retune case !!!\n");
+		goto out;
+	}
+
+	ret = dw_mci_rtk_set_pinstates(priv, mmc->ios.timing);
+	if (ret) {
+		dev_err(mmc_dev(mmc),
+			"Failed to set pinstate err=%d\n", ret);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	host->tuning = 1;
+
+	do {
+		if (mmc->ios.timing == MMC_TIMING_MMC_HS400)
+			loop_cnt = 0;
+		else if (mmc->ios.timing == MMC_TIMING_MMC_HS200)
+			loop_cnt = 20;
+		else
+			loop_cnt = 30;
+
+		/* rx tuning */
+		do {
+			for (i = 0; i < rx_range; i++) {
+				dw_mci_rtk_phase_tuning(host, 0xff, i);
+
+				if (mmc->ios.timing == MMC_TIMING_MMC_HS200)
+					rsp = mmc_send_tuning(mmc,
+						MMC_SEND_TUNING_BLOCK_HS200, NULL);
+				else
+					rsp = dw_mci_rtk_send_tuning(mmc,
+						MMC_SEND_STATUS, 0x10000, 0);
+				if (rsp)
+					rx_window = rx_window & ~BIT(i);
+				else
+					rx_window = rx_window | BIT(i);
+			}
+
+			if (rx_window == 0) {
+				dev_err(mmc_dev(mmc), "rx_window = 0, cannot find a proper rx phase\n");
+				ret = -EFAULT;
+				goto out;
+			} else if (rx_window == HS200_WINDOW_ALL_PASS) {
+				loop_cnt++;
+				adjust_window(priv, "rx_window", loop_cnt, rx_window);
+			}
+		} while (rx_window == HS400_WINDOW_ALL_PASS && loop_cnt < 60);
+
+		rx_best = search_best(rx_window, rx_range);
+		if (rx_best == 0xff) {
+			dev_err(mmc_dev(mmc), "no 6 continuous points for rx phase\n");
+			ret = -EFAULT;
+			goto out;
+		}
+
+		dw_mci_rtk_phase_tuning(host, 0xff, rx_best);
+		dev_info(mmc_dev(mmc), "rx_window = 0x%x, rx_best = 0x%x\n", rx_window, rx_best);
+
+		/*dqs tuning in HS400 mode*/
+		if (mmc->ios.timing == MMC_TIMING_MMC_HS400) {
+			if (fail == true)
+				pinctrl_select_state(priv->pinctrl, priv->pins_tune4);
+			else
+				pinctrl_select_state(priv->pinctrl, priv->pins_hs400);
+
+			/*reset the bitmap, max, and j for each wcmd_rty*/
+			bitmap = 0;
+			max = 0;
+			j = 0;
+
+			for (i = 0; i < 0x20; i++) {
+				/*criteria is more than 5 continuous tap sample point*/
+				if (j >= 5)
+					max = j;
+				/*find the max tap length*/
+				if (j == 0 && max != 0)
+					break;
+
+				dqs_delay_tap_setting(host, (i << 1));
+
+				if (dw_mci_rtk_send_tuning(mmc,
+					MMC_READ_MULTIPLE_BLOCK, 0x100, 1024) != 0) {
+					j = 0;
+				} else {
+					j++;
+					bitmap |= BIT(i);
+				}
+			}
+
+			if (max == 0) {
+				if (fail == false) {
+					dev_err(mmc_dev(mmc),
+						"DQS_RETRY: dqs tap bitmap= 0x%x\n", bitmap);
+					fail = true;
+					dqs_retry = true;
+					dev_err(mmc_dev(mmc), "try pad driving 7\n");
+					pinctrl_select_state(priv->pinctrl, priv->pins_tune4);
+				} else {
+					ret = -EFAULT;
+					dev_err(mmc_dev(mmc),
+						"No proper window,dqs tap bitmap=0x%x !\n", bitmap);
+					goto out;
+				}
+			} else {
+				reg = mcq_readl(host, DQS_CTRL1) - 2 - ((max / 2) * 2);
+				/*set the dqs dly tape*/
+				dqs_delay_tap_setting(host, reg);
+				dqs_retry = false;
+				dev_info(mmc_dev(mmc), "max sample point = %d, bitmap = 0x%x, DQS = 0x%x\n",
+					max, bitmap, mcq_readl(host, DQS_CTRL1));
+			}
+		}
+	} while (dqs_retry == true);
+
+	/*tx tuning */
+	if (mmc->ios.timing == MMC_TIMING_MMC_HS400) {
+		tx_range = 0x10;
+		loop_cnt = 0;
+		if (fail == true)
+			pinctrl_select_state(priv->pinctrl, priv->pins_tune4);
+		else
+			pinctrl_select_state(priv->pinctrl, priv->pins_hs400);
+	} else if (mmc->ios.timing == MMC_TIMING_MMC_HS200) {
+		tx_range = 0x20;
+		loop_cnt = 20;
+		if (fail == true)
+			pinctrl_select_state(priv->pinctrl, priv->pins_tune4);
+		else
+			pinctrl_select_state(priv->pinctrl, priv->pins_hs200);
+	} else {
+		tx_range = 0x10;
+		loop_cnt = 30;
+	}
+
+	do {
+		for (i = 0; i < tx_range; i++) {
+			dw_mci_rtk_phase_tuning(host, i, 0xff);
+			if (dw_mci_rtk_send_tuning(mmc, MMC_WRITE_MULTIPLE_BLOCK, 0xfe, 1024))
+				tx_window = tx_window & ~BIT(i);
+			else
+				tx_window = tx_window | BIT(i);
+		}
+
+		if (tx_window == 0) {
+			dev_err(mmc_dev(mmc), "tx_window = 0, cannot find a proper tx phase\n");
+			ret = -EFAULT;
+			goto out;
+		} else if ((tx_window == HS400_WINDOW_ALL_PASS &&
+				mmc->ios.timing == MMC_TIMING_MMC_HS400) ||
+				(tx_window == HS200_WINDOW_ALL_PASS &&
+				mmc->ios.timing == MMC_TIMING_MMC_HS200)) {
+			loop_cnt++;
+			adjust_window(priv, "tx_window", loop_cnt, tx_window);
+		}
+	} while (((tx_window == HS400_WINDOW_ALL_PASS && mmc->ios.timing == MMC_TIMING_MMC_HS400) ||
+		(tx_window == HS200_WINDOW_ALL_PASS &&
+			mmc->ios.timing == MMC_TIMING_MMC_HS200)) && loop_cnt < 60);
+
+	if (fail == true)
+		pinctrl_select_state(priv->pinctrl, priv->pins_tune4);
+	else if (mmc->ios.timing == MMC_TIMING_MMC_HS400)
+		pinctrl_select_state(priv->pinctrl, priv->pins_hs400);
+	else if (mmc->ios.timing == MMC_TIMING_MMC_HS200)
+		pinctrl_select_state(priv->pinctrl, priv->pins_hs200);
+
+	tx_best = search_best(tx_window, tx_range);
+	if (tx_best == 0xff) {
+		dev_err(mmc_dev(mmc), "no 6 continuous points for tx phase\n");
+		ret = -EFAULT;
+		goto out;
+	}
+
+	dw_mci_rtk_phase_tuning(host, tx_best, 0xff);
+	dev_info(mmc_dev(mmc), "tx_window = 0x%x, tx_best = 0x%x\n", tx_window, tx_best);
+
+out:
+	/* We send cmd 13 again because the eMMC handling might send command 12 more than twice.
+	 * After kernel 5.4, system might send cmd13 first before issuing any command,
+	 * user will see the illegal command status because the emmc tuning error handling
+	 */
+
+	dw_mci_rtk_send_tuning(mmc, MMC_SEND_STATUS, 0x10000, 0);
+	host->tuning = 0;
+
+	return ret;
+}
+
+static void dw_mci_rtk_set_ios(struct dw_mci_slot *slot, struct mmc_ios *ios)
+{
+	struct dw_mci *host = slot->host;
+	int ret;
+	u32 status;
+
+	clk_disable(host->ciu_clk);
+	udelay(10);
+
+	ret = clk_set_rate(host->ciu_clk, ios->clock);
+
+	if (ret)
+		dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
+
+	host->bus_hz = clk_get_rate(host->ciu_clk);
+
+	udelay(10);
+	clk_enable(host->ciu_clk);
+
+	ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+			(status & SDMMC_INTERNAL_CLK_MSK) == 0x3, 10, DW_MCI_TIMEOUT);
+	if (ret)
+		dev_err(host->dev, "Waiting emmc set_ios timeout\n");
+
+	mcq_writeb(host, SW_RST_R, SDMMC_RST_CMD|SDMMC_RST_DAT);
+
+	ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+		(status & SW_RST_BOTH_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+	if (ret)
+		dev_err(host->dev, "Waiting sw reset timeout\n");
+
+	clk_disable(host->ciu_clk);
+	udelay(6);
+
+	setup_clk_div(slot);
+
+	mcq_writel(host, CKGEN_CTL, mcq_readl(host, CKGEN_CTL) & ~SDMMC_CLK_DIV_SEL);
+	udelay(6);
+
+	clk_enable(host->ciu_clk);
+	udelay(6);
+
+	ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+		(status & SDMMC_INTERNAL_CLK_MSK) == 0x3, 10, DW_MCI_TIMEOUT);
+	if (ret)
+		dev_err(host->dev, "Waiting emmc set_ios timeout\n");
+
+	mcq_writeb(host, SW_RST_R, SDMMC_RST_CMD | SDMMC_RST_DAT);
+
+	ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+		(status & SW_RST_BOTH_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+	if (ret)
+		dev_err(host->dev, "Waiting sw reset timeout\n");
+
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) & (~SDMMC_TOP_RST_N_FIFO));
+	udelay(10);
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) | SDMMC_TOP_RST_N_FIFO);
+	udelay(10);
+}
+
+static int dw_mci_rtk_prepare_hs400_tuning(struct dw_mci *host, struct mmc_ios *ios)
+{
+	dqs_delay_tap_setting(host, hs400_dqs_delay_val);
+
+	data_delay_tap_setting(host);
+
+	cmd_delay_tap_setting(host, 0);
+
+	return 0;
+}
+
+static void dw_mci_rtk_hs400_complete(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	struct dw_mci_rtkemmc_host *priv = host->priv;
+	int err = -EINVAL;
+
+	if (drv_data && drv_data->execute_tuning)
+		err = drv_data->execute_tuning(slot,
+			MMC_SEND_TUNING_BLOCK_HS200);
+
+	if (err != 0) {
+		dev_err(mmc_dev(mmc), "HS400 tuning failed and down speed to hs200, err=%d\n", err);
+		host->pdata->caps &= ~MMC_CAP_1_8V_DDR;
+		host->pdata->caps2 &= ~MMC_CAP2_HS400_1_8V;
+		mmc->card->mmc_avail_type &= ~EXT_CSD_CARD_TYPE_HS400_1_8V;
+		priv->emmc_mode = 2;
+		mmc_hw_reset(mmc);
+	}
+}
+
+static void dw_mci_rtk_init_card(struct mmc_host *host, struct mmc_card *card)
+{
+	/* In Realtek Platform, we need to attach eMMC card onto mmc host
+	 * during eMMC initialization because of the following reason:
+	 * When system cannot run the hs400, we need to down speed to hs200
+	 * and call mmc_hw_reset and modify the mmc card attribute through mmc host.
+	 * At this moment, system will show errors if host->card = NULL.
+	 */
+	host->card = card;
+}
+
+static int dw_mci_rtk_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_rtkemmc_host *priv;
+	const u32 *prop;
+	int size;
+
+	priv = devm_kzalloc(host->dev, sizeof(struct dw_mci_rtkemmc_host), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pinctrl = devm_pinctrl_get(host->dev);
+	if (IS_ERR(priv->pinctrl))
+		dev_dbg(host->dev, "no pinctrl\n");
+
+	priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
+					PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(priv->pins_default))
+		dev_warn(host->dev, "could not get default state\n");
+
+	priv->pins_sdr50 = pinctrl_lookup_state(priv->pinctrl,
+						"sdr50");
+	if (IS_ERR(priv->pins_sdr50))
+		dev_warn(host->dev, "could not get sdr50 state\n");
+
+	priv->pins_hs200 = pinctrl_lookup_state(priv->pinctrl,
+						"hs200");
+	if (IS_ERR(priv->pins_hs200))
+		dev_warn(host->dev, "could not get hs200 state\n");
+
+	priv->pins_hs400 = pinctrl_lookup_state(priv->pinctrl,
+						"hs400");
+	if (IS_ERR(priv->pins_hs400))
+		dev_warn(host->dev, "could not get hs400 state\n");
+
+	priv->pins_tune0 = pinctrl_lookup_state(priv->pinctrl,
+						"tune0");
+	if (IS_ERR(priv->pins_tune0))
+		dev_warn(host->dev, "could not get tune0 state\n");
+
+	priv->pins_tune1 = pinctrl_lookup_state(priv->pinctrl,
+						"tune1");
+	if (IS_ERR(priv->pins_tune1))
+		dev_warn(host->dev, "could not get tune1 state\n");
+
+	priv->pins_tune2 = pinctrl_lookup_state(priv->pinctrl,
+						"tune2");
+	if (IS_ERR(priv->pins_tune2))
+		dev_warn(host->dev, "could not get tune2 state\n");
+
+	priv->pins_tune3 = pinctrl_lookup_state(priv->pinctrl,
+						"tune3");
+	if (IS_ERR(priv->pins_tune3))
+		dev_warn(host->dev, "could not get tune3 state\n");
+
+	priv->pins_tune4 = pinctrl_lookup_state(priv->pinctrl,
+						"tune4");
+
+	if (IS_ERR(priv->pins_tune4))
+		dev_warn(host->dev, "could not get tune4 state\n");
+
+	priv->vp0 = devm_clk_get(host->dev, "vp0");
+	if (IS_ERR(priv->vp0))
+		dev_err(host->dev, "could not get vp0 clk\n");
+
+	priv->vp1 = devm_clk_get(host->dev, "vp1");
+	if (IS_ERR(priv->vp1))
+		dev_err(host->dev, "could not get vp1 clk\n");
+
+	priv->emmc_mode = 0;
+	prop = of_get_property(host->dev->of_node, "speed-step", &size);
+	if (prop) {
+		priv->emmc_mode = of_read_number(prop, 1);
+		dev_info(host->dev, "emmc mode : %d\n", priv->emmc_mode);
+	} else {
+		dev_info(host->dev, "use default emmc sdr50 mode !\n");
+	}
+
+
+	priv->is_cqe = 0;
+	prop = of_get_property(host->dev->of_node, "cqe", &size);
+	if (prop) {
+		priv->is_cqe = of_read_number(prop, 1);
+		dev_info(host->dev, "cmdq mode : %d\n", priv->is_cqe);
+	} else {
+		dev_info(host->dev, "use default eMMC legacy mode !\n");
+	}
+
+	prop = of_get_property(host->dev->of_node, "rdq-ctrl", &size);
+	if (prop) {
+		priv->rdq_ctrl = of_read_number(prop, 1);
+		dev_info(host->dev, "get rdq-ctrl : %u\n", priv->rdq_ctrl);
+	} else {
+		priv->rdq_ctrl = 0;
+		dev_info(host->dev, "no dqs_dly_tape switch node, use default 0x0 !!\n");
+	}
+
+	priv->m2tmx = syscon_regmap_lookup_by_phandle(host->dev->of_node, "realtek,m2tmx");
+	if (IS_ERR_OR_NULL(priv->m2tmx))
+		dev_err(host->dev, "can not get m2mtx node.\n");
+
+	host->priv = priv;
+
+	return 0;
+}
+
+static int dw_mci_rtk_init(struct dw_mci *host)
+{
+	struct dw_mci_rtkemmc_host *priv = host->priv;
+
+	host->pdata->caps2 = MMC_CAP2_NO_SDIO | MMC_CAP2_NO_SD;
+
+	if (priv->emmc_mode >= 2)
+		host->pdata->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
+	if (priv->emmc_mode >= 3) {
+		host->pdata->caps |= MMC_CAP_1_8V_DDR;
+		host->pdata->caps2 |= MMC_CAP2_HS400_1_8V;
+	}
+
+	if (priv->is_cqe > 0)
+		host->pdata->caps2 |= (MMC_CAP2_CQE|MMC_CAP2_CQE_DCMD);
+
+
+	/*In Realtek Platform, only using 32bit DMA*/
+	host->dma_64bit_address = 0;
+
+	/*In Realtek Platform, do not use PIO mode by default*/
+	host->use_dma = TRANS_MODE_DMA;
+
+	host->irq_flags = IRQF_SHARED;
+
+	mcq_writel(host, CP, 0x0);
+
+	/*Enable L4 gated*/
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1)
+		& ~(SDMMC_L4_GATED_DIS | SDMMC_L4_GATED_DIS1));
+
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1)
+		& (~(SDMMC_DQS_CTRL_GATE_DIS|SDMMC_DBUS_MAS_GATING_DIS)));
+
+	/*Set the eMMC wrapper little Endian*/
+	mcq_writel(host, AHB, mcq_readl(host, AHB)|SDMMC_AHB_BIG);
+
+	mcq_writel(host, OTHER1,
+		mcq_readl(host, OTHER1) | SDMMC_STARK_CARD_STOP_ENABLE);
+
+	/*set eMMC instead of nand*/
+	regmap_update_bits_base(priv->m2tmx, SDMMC_NAND_DMA_SEL,
+				SDMMC_SRAM_DMA_SEL, SDMMC_SRAM_DMA_SEL, NULL, false, true);
+
+	/*Set the clk initial phase*/
+	dw_mci_rtk_phase_tuning(host, 0, 0);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int dw_mci_rtk_suspend(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = dw_mci_cqe_runtime_suspend(dev);
+
+	mcq_writel(host, AHB, 0);
+	dev_info(dev, "AHB=0x%x, dw_mci_cqe_suspend ret=%d\n",
+		mcq_readl(host, AHB), ret);
+
+	return ret;
+}
+
+static int dw_mci_rtk_resume(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret = 0;
+
+	mcq_writel(host, AHB, mcq_readl(host, AHB)|SDMMC_AHB_BIG);
+
+	ret = dw_mci_cqe_runtime_resume(dev);
+
+	dev_info(dev, "AHB=0x%x, dw_mci_cqe_resume ret=%d\n",
+		mcq_readl(host, AHB), ret);
+
+	return ret;
+}
+#else
+static int dw_mci_rtk_suspend(struct device *dev)
+{
+	dev_err(dev, "User should enable CONFIG_PM kernel config\n");
+
+	return 0;
+}
+static int dw_mci_rtk_resume(struct device *dev)
+{
+	dev_err(dev, "User should enable CONFIG_PM kernel config\n");
+
+	return 0;
+}
+#endif /*CONFIG_PM*/
+static const struct dev_pm_ops rtk_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_rtk_suspend,
+				dw_mci_rtk_resume)
+	SET_RUNTIME_PM_OPS(dw_mci_cqe_runtime_suspend,
+			   dw_mci_cqe_runtime_resume,
+			   NULL)
+};
+
+static void dw_mci_rtk_shutdown(struct platform_device *pdev)
+{
+	dev_info(&pdev->dev, "[eMMC] Shutdown\n");
+	dw_mci_cqe_runtime_resume(&pdev->dev);
+}
+
+static unsigned long dw_mci_rtk_dwmmc_caps[1] = {
+	MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
+	MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
+	MMC_CAP_NONREMOVABLE | MMC_CAP_CMD23,
+};
+
+
+static const struct dw_mci_drv_data rtk_drv_data = {
+	.caps                   = dw_mci_rtk_dwmmc_caps,
+	.num_caps               = ARRAY_SIZE(dw_mci_rtk_dwmmc_caps),
+	.set_ios                = dw_mci_rtk_set_ios,
+	.execute_tuning         = dw_mci_rtk_execute_tuning,
+	.parse_dt               = dw_mci_rtk_parse_dt,
+	.init                   = dw_mci_rtk_init,
+	.prepare_hs400_tuning	= dw_mci_rtk_prepare_hs400_tuning,
+	.hs400_complete         = dw_mci_rtk_hs400_complete,
+	.init_card		= dw_mci_rtk_init_card,
+};
+
+static const struct of_device_id dw_mci_rtk_match[] = {
+	{ .compatible = "realtek,rtd-dw-cqe-emmc",
+		.data = &rtk_drv_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_rtk_match);
+
+int dw_mci_cqe_pltfm_register(struct platform_device *pdev,
+			  const struct dw_mci_drv_data *drv_data)
+{
+	struct dw_mci *host;
+	struct resource	*regs;
+
+	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq < 0)
+		return host->irq;
+
+	host->drv_data = drv_data;
+	host->pdev = pdev;
+	host->dev = &pdev->dev;
+	host->irq_flags = 0;
+	host->pdata = pdev->dev.platform_data;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(host->regs))
+		return PTR_ERR(host->regs);
+
+	/* Get registers' physical base address */
+	host->phy_regs = regs->start;
+
+	platform_set_drvdata(pdev, host);
+
+	return dw_mci_cqe_probe(host);
+}
+
+static int dw_mci_rtk_probe(struct platform_device *pdev)
+{
+	const struct dw_mci_drv_data *drv_data;
+	const struct of_device_id *match;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	match = of_match_node(dw_mci_rtk_match, pdev->dev.of_node);
+	drv_data = match->data;
+
+	return dw_mci_cqe_pltfm_register(pdev, drv_data);
+}
+
+int dw_mci_rtk_remove(struct platform_device *pdev)
+{
+	struct dw_mci *host = platform_get_drvdata(pdev);
+
+	dw_mci_cqe_remove(host);
+	return 0;
+}
+
+static struct platform_driver dw_mci_rtk_pltfm_driver = {
+	.probe          = dw_mci_rtk_probe,
+	.remove         = dw_mci_rtk_remove,
+	.driver         = {
+		.name           = "dwmmc_cqe_rtk",
+		.of_match_table = dw_mci_rtk_match,
+		.pm             = &rtk_dev_pm_ops,
+	},
+	.shutdown   = dw_mci_rtk_shutdown,
+};
+
+module_platform_driver(dw_mci_rtk_pltfm_driver);
+
+MODULE_AUTHOR("<jyanchou@realtek.com>");
+MODULE_DESCRIPTION(" Specific Driver Extension");
+MODULE_ALIAS("platform:dwmmc_cqe_rtk");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/dw_mmc_cqe-rtk.h b/drivers/mmc/host/dw_mmc_cqe-rtk.h
new file mode 100644
index 000000000000..f7430b597f54
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe-rtk.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (C) 2013 Realtek Semiconductors, All Rights Reserved.
+ *
+ */
+
+#ifndef __DW_RTK_MMC_CQE_H
+#define __DW_RTK_MMC_CQE_H
+
+#define SDMMC_CP                         0x41c
+#define SDMMC_OTHER1                     0x420
+#define SDMMC_DUMMY_SYS                  0x42c
+#define SDMMC_AHB                        0x430
+#define SDMMC_CKGEN_CTL                  0x478
+#define SDMMC_DQS_CTRL1                  0x498
+#define SDMMC_IP_DESC0                   0x4a0
+#define SDMMC_IP_DESC1                   0x4a4
+#define SDMMC_IP_DESC2                   0x4a8
+#define SDMMC_IP_DESC3                   0x4ac
+#define SDMMC_DQ_CTRL_SET                0x50c
+#define SDMMC_WDQ_CTRL0                  0x510
+#define SDMMC_WDQ_CTRL1                  0x514
+#define SDMMC_WDQ_CTRL2                  0x518
+#define SDMMC_WDQ_CTRL3                  0x51c
+#define SDMMC_WDQ_CTRL4                  0x520
+#define SDMMC_WDQ_CTRL5                  0x524
+#define SDMMC_WDQ_CTRL6                  0x528
+#define SDMMC_WDQ_CTRL7                  0x52c
+#define SDMMC_RDQ_CTRL0                  0x530
+#define SDMMC_RDQ_CTRL1                  0x534
+#define SDMMC_RDQ_CTRL2                  0x538
+#define SDMMC_RDQ_CTRL3                  0x53c
+#define SDMMC_RDQ_CTRL4                  0x540
+#define SDMMC_RDQ_CTRL5                  0x544
+#define SDMMC_RDQ_CTRL6                  0x548
+#define SDMMC_RDQ_CTRL7                  0x54c
+#define SDMMC_CMD_CTRL_SET               0x550
+#define SDMMC_WCMD_CTRL                  0x554
+#define SDMMC_RCMD_CTRL                  0x558
+#define SDMMC_PLL_STATUS                 0x55c
+
+#define SDMMC_NAND_DMA_SEL               0x54
+#define SDMMC_SRAM_DMA_SEL               BIT(0)
+
+#define SDMMC_CLK_O_ICG_EN               BIT(3)
+#define SDMMC_CARD_STOP_ENABLE           BIT(23)
+#define SDMMC_STARK_CARD_STOP_ENABLE     BIT(11)
+#define SDMMC_TOP_RST_N_FIFO             BIT(3)
+
+#define SDMMC_FW_SET                     BIT(7)
+#define SDMMC_FW_SET_CMD_W               BIT(0)
+
+#define SDMMC_CLK4M                      ((BIT(0)|BIT(1)|BIT(2))<<EMMC_CRC_CLK_CHANGE_SHIFT)
+#define SDMMC_CRC_CLK_DIV                (BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7))
+#define SDMMC_CRC_CLK_DIV_MASK           (~SDMMC_CRC_CLK_DIV)
+#define SDMMC_CRC_CLK_DIV_EN             BIT(8)
+#define SDMMC_CLK_INV_DIV_SEL            BIT(9)
+#define SDMMC_SSC_CLK_DIV_SEL            (BIT(19)|BIT(20))
+
+#define SDMMC_CLK_DIV512		(0x200)
+#define SDMMC_CLK_DIV4			(0x4)
+#define SDMMC_CLK_DIV1			(0x1)
+#define SDMMC_INTERNAL_CLK_MSK		(0x3)
+
+/*0x2C CLK_CTRL_R*/
+#define SDMMC_INTERNAL_CLK_STABLE	BIT(1)
+#define SDMMC_INTERNAL_CLK_EN		BIT(0)
+
+/*0x2f SW_RST_R*/
+#define SDMMC_RST_DAT			BIT(2)
+#define SDMMC_RST_CMD			BIT(1)
+
+/*0x420 OTHER1*/
+#define SDMMC_DBUS_MAS_GATING_DIS	BIT(13)
+#define SDMMC_DQS_CTRL_GATE_DIS		BIT(12)
+#define SDMMC_CLK_DIV_RST		BIT(10)
+#define SDMMC_L4_GATED_DIS1		BIT(2)
+#define SDMMC_L4_GATED_DIS		BIT(0)
+
+/*0x430 */
+#define SDMMC_AHB_BIG			BIT(2)
+
+/*0x478 */
+#define SDMMC_CLK_DIV_SEL		BIT(20)
+
+/*0x498 */
+#define SDMMC_FW_EN			BIT(8)
+
+/*0x554 */
+#define SDMMC_FW_SET_EN			BIT(7)
+
+struct backupRegs {
+	u32			sdmasa_r;		/*0x000*/
+	u16			blocksize_r;		/*0x004*/
+	u16			blockcount_r;		/*0x006*/
+	u16			xfer_mode_r;		/*0x00c*/
+	u8			host_ctrl1_r;		/*0x028*/
+	u8			pwr_ctrl_r;		/*0x029*/
+	u8			bgap_ctrl_r;		/*0x02a*/
+	u16			clk_ctrl_r;		/*0x02c*/
+	u8			tout_ctrl_r;		/*0x02e*/
+
+	u16                     normal_int_stat_en_r;	/*0x034*/
+	u16                     error_int_stat_en_r;	/*0x036*/
+	u16                     normal_int_signal_en_r; /*0x038*/
+	u16                     error_int_signal_en_r;  /*0x03a*/
+	u16                     auto_cmd_stat_r;        /*0x03c*/
+	u16                     host_ctrl2_r;           /*0x03e*/
+	u32                     adma_sa_low_r;          /*0x058*/
+	u8                      mshc_ctrl_r;            /*0x208*/
+	u8                      ctrl_r;                 /*0x22c*/
+	u32                     other1;                 /*0x420*/
+	u32                     dummy_sys;              /*0x42c*/
+	u32                     dqs_ctrl1;              /*0x498*/
+	u32                     wcmd_ctrl;              /*0x554*/
+
+	u32                     rdq_ctrl0;              /*0x530*/
+	u32                     rdq_ctrl1;              /*0x534*/
+	u32                     rdq_ctrl2;              /*0x538*/
+	u32                     rdq_ctrl3;              /*0x53c*/
+	u32                     rdq_ctrl4;              /*0x540*/
+	u32                     rdq_ctrl5;              /*0x544*/
+	u32                     rdq_ctrl6;              /*0x548*/
+	u32                     rdq_ctrl7;              /*0x54c*/
+	u32                     dq_ctrl_set;            /*0x50c*/
+	u32                     ahb;
+	u32                     ckgen_ctl;
+};
+
+struct dw_mci_rtkemmc_host {
+	struct pinctrl          *pinctrl;
+	struct pinctrl_state    *pins_default;
+	struct pinctrl_state    *pins_sdr50;
+	struct pinctrl_state    *pins_ddr50;
+	struct pinctrl_state    *pins_hs200;
+	struct pinctrl_state    *pins_hs400;
+	struct pinctrl_state    *pins_tune0;
+	struct pinctrl_state    *pins_tune1;
+	struct pinctrl_state    *pins_tune2;
+	struct pinctrl_state    *pins_tune3;
+	struct pinctrl_state    *pins_tune4;
+	struct regmap		*m2tmx;
+	struct clk              *vp0;
+	struct clk              *vp1;
+	struct backupRegs       gRegTbl;
+	int                     emmc_mode;
+	unsigned int		rdq_ctrl;
+	unsigned int		is_cqe;
+};
+
+int mmc_cmdq_enable(struct mmc_card *card);
+int mmc_cmdq_disable(struct mmc_card *card);
+int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
+		unsigned int timeout_ms);
+int mmc_hw_reset(struct mmc_host *host);
+int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
+		     atomic_t *abort);
+void mmc_release_host(struct mmc_host *host);
+
+#endif
diff --git a/drivers/mmc/host/dw_mmc_cqe.c b/drivers/mmc/host/dw_mmc_cqe.c
new file mode 100644
index 000000000000..d25942571499
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe.c
@@ -0,0 +1,1633 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Synopsys DesignWare Multimedia Card Interface driver with CMDQ support
+ *  (Based on Synopsys DesignWare Multimedia Card Interface driver)
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corp
+ */
+
+#include <linux/bitops.h>
+#include <linux/blkdev.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/seq_file.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+
+#include "dw_mmc_cqe.h"
+#include "cqhci.h"
+
+#define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
+#define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
+#define DW_MCI_CMDQ_DISABLED	0x30f0001
+#define DW_MCI_CMDQ_ENABLED	0x30f0101
+#define DW_MCI_POWEROFF		0x3220301
+#define DW_MCI_DESC_LEN		0x100000
+#define DW_MCI_MAX_SCRIPT_BLK	128
+#define DW_MCI_TIMEOUT_Ms	200
+#define DW_MCI_TIMEOUT		200000
+#define TUNING_ERR		531
+#define DW_MCI_NOT_READY	9999
+
+DECLARE_COMPLETION(dw_mci_wait);
+
+#if defined(CONFIG_DEBUG_FS)
+static int dw_mci_cqe_req_show(struct seq_file *s, void *v)
+{
+	struct dw_mci_slot *slot = s->private;
+	struct mmc_request *mrq;
+	struct mmc_command *cmd;
+	struct mmc_command *stop;
+	struct mmc_data	*data;
+
+	/* Make sure we get a consistent snapshot */
+	spin_lock_bh(&slot->host->lock);
+	mrq = slot->mrq;
+
+	if (mrq) {
+		cmd = mrq->cmd;
+		data = mrq->data;
+		stop = mrq->stop;
+
+		if (cmd)
+			seq_printf(s,
+				   "CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
+				   cmd->opcode, cmd->arg, cmd->flags,
+				   cmd->resp[0], cmd->resp[1], cmd->resp[2],
+				   cmd->resp[2], cmd->error);
+		if (data)
+			seq_printf(s, "DATA %u / %u * %u flg %x err %d\n",
+				   data->bytes_xfered, data->blocks,
+				   data->blksz, data->flags, data->error);
+		if (stop)
+			seq_printf(s,
+				   "CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
+				   stop->opcode, stop->arg, stop->flags,
+				   stop->resp[0], stop->resp[1], stop->resp[2],
+				   stop->resp[2], stop->error);
+	}
+
+	spin_unlock_bh(&slot->host->lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(dw_mci_cqe_req);
+#endif /* defined(CONFIG_DEBUG_FS) */
+
+static int dw_mci_cqe_regs_show(struct dw_mci *host,
+				struct mmc_command *cmd, u32 cmd_flags)
+{
+	dev_err(host->dev, "opcode = %d, arg = 0x%x, cmdflags = 0x%x\n",
+				cmd->opcode, cmd->arg, cmd_flags);
+	dev_err(host->dev, "status_int = 0x%x\n", host->normal_interrupt);
+	dev_err(host->dev, "error_int = 0x%x\n", host->error_interrupt);
+	dev_err(host->dev, "auto_error_int = 0x%x\n", host->auto_error_interrupt);
+
+	return 0;
+}
+
+static void dw_mci_cqe_dumpregs(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+
+	dev_info(host->dev, "%s: cmd idx 0x%08x\n", __func__, mcq_readw(host, CMD_R));
+}
+
+static void dw_mci_cqe_set_tran_desc(u8 *desc,
+					dma_addr_t addr,
+					int len,
+					bool end,
+					bool dma64)
+{
+	__le32 *attr = (__le32 __force *)desc;
+
+	*attr = (CQHCI_VALID(1) |
+		 CQHCI_END(end ? 1 : 0) |
+		 CQHCI_INT(0) |
+		 CQHCI_ACT(0x4) |
+		 CQHCI_DAT_LENGTH(len));
+
+	if (dma64) {
+		__le64 *dataddr = (__le64 __force *)(desc + 4);
+
+		dataddr[0] = cpu_to_le64(addr);
+	} else {
+		__le32 *dataddr = (__le32 __force *)(desc + 4);
+
+		dataddr[0] = cpu_to_le32(addr);
+	}
+}
+
+static void dw_mci_cqe_setup_tran_desc(struct mmc_data *data,
+				      struct cqhci_host *cq_host,
+				      u8 *desc,
+				      int sg_count)
+{
+	struct scatterlist *sg;
+	u32 cur_blk_cnt, remain_blk_cnt;
+	unsigned int begin, end;
+	int i, len;
+	bool last = false;
+	bool dma64 = cq_host->dma64;
+	dma_addr_t addr;
+
+	for_each_sg(data->sg, sg, sg_count, i) {
+		addr = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+		remain_blk_cnt  = len >> 9;
+
+		while (remain_blk_cnt) {
+			/*DW_MCI_MAX_SCRIPT_BLK is tha max for each descriptor record*/
+			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
+				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
+			else
+				cur_blk_cnt = remain_blk_cnt;
+
+			/* In Synopsys DesignWare Databook Page 84,
+			 * They mentioned the DMA 128MB restriction
+			 */
+			begin = addr / SZ_128M;
+			end = (addr + cur_blk_cnt * SZ_512) / SZ_128M;
+
+			if (begin != end)
+				cur_blk_cnt = (end * SZ_128M - addr) / SZ_512;
+
+			if ((i+1) == sg_count && (remain_blk_cnt == cur_blk_cnt))
+				last = true;
+
+			dw_mci_cqe_set_tran_desc(desc, addr,
+					(cur_blk_cnt << 9), last, dma64);
+
+			addr = addr + (cur_blk_cnt << 9);
+			remain_blk_cnt -= cur_blk_cnt;
+			desc += cq_host->trans_desc_len;
+		}
+	}
+}
+
+static void dw_mci_cqe_enable(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+
+	/*clear data path SW_RST_R.SW_RST_DAT = 1*/
+	mcq_writeb(host, SW_RST_R, SDMMC_RST_DAT);
+	/*0x9801200c*/
+	mcq_writew(host, XFER_MODE_R,
+		((1 << SDMMC_MULTI_BLK_SEL) | SDMMC_BLOCK_COUNT_ENABLE | SDMMC_DMA_ENABLE));
+
+	/*Set DMA_SEL to ADMA2 only mode in the HOST_CTRL1_R*/
+	mcq_writeb(host, HOST_CTRL1_R,
+		(mcq_readb(host, HOST_CTRL1_R) & 0xe7) | (SDMMC_ADMA2_32 << SDMMC_DMA_SEL));
+	mcq_writew(host, BLOCKSIZE_R, 0x200);
+	mcq_writew(host, BLOCKCOUNT_R, 0);
+
+	/*Set SDMASA_R (while using 32 bits) to 0*/
+	mcq_writel(host, SDMASA_R, 0);
+	/*we set this register additionally to enhance the IO perofrmance*/
+
+	cqhci_writel(host->cqe, 0x10, CQHCI_SSC1);
+	cqhci_writel(host->cqe, 0, CQHCI_CTL);
+
+	if (cqhci_readl(host->cqe, CQHCI_CTL) && CQHCI_HALT) {
+		dev_err(host->dev, "%s: cqhci: CQE failed to exit halt state\n",
+			mmc_hostname(mmc));
+	}
+
+	/*cmdq interrupt mode*/
+	dw_mci_clr_signal_int(host);
+	dw_mci_en_cqe_int(host);
+}
+
+static const struct cqhci_host_ops dw_mci_cqhci_host_ops = {
+	.enable = dw_mci_cqe_enable,
+	.dumpregs = dw_mci_cqe_dumpregs,
+	.setup_tran_desc = dw_mci_cqe_setup_tran_desc,
+};
+
+static void dw_mci_cqe_reset(struct dw_mci *host)
+{
+	int ret;
+	u32 status;
+	/*check the cmd line*/
+	if (mcq_readw(host, ERROR_INT_STAT_R) & SDMMC_CMD_ERR) {
+		/*Perform a software reset*/
+		mcq_writeb(host, SW_RST_R, SDMMC_RST_CMD);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+			(status & SW_RST_CMD_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+		if (ret)
+			dev_err(host->dev, "Timeout resetting CMD line\n");
+	}
+	/*check data line*/
+	if (mcq_readw(host, ERROR_INT_STAT_R) & SDMMC_DATA_ERR) {
+		mcq_writeb(host, SW_RST_R, SDMMC_RST_DAT);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+			(status & SW_RST_DATA_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+		if (ret)
+			dev_err(host->dev, "Timeout resetting DATA line\n");
+	}
+}
+
+static void dw_mci_cqe_read_rsp(struct dw_mci *host, struct mmc_command *cmd, u32 *rsp)
+{
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136) {
+			/*R2 long response*/
+			u32 rsp_tmp[4];
+
+			rsp_tmp[3] = mcq_readl(host, RESP01_R);
+			rsp_tmp[2] = mcq_readl(host, RESP23_R);
+			rsp_tmp[1] = mcq_readl(host, RESP45_R);
+			rsp_tmp[0] = mcq_readl(host, RESP67_R);
+
+			/* dw_mmc_databook shift Response field to 08 - 139 bits*/
+			rsp[3] = (rsp_tmp[3] & 0x00ffffff) << 8;
+			rsp[2] = ((rsp_tmp[2] & 0x00ffffff) << 8) |
+				((rsp_tmp[3] & 0xff000000) >> 24);
+			rsp[1] = ((rsp_tmp[1] & 0x00ffffff) << 8) |
+				((rsp_tmp[2] & 0xff000000) >> 24);
+			rsp[0] = ((rsp_tmp[0] & 0x00ffffff) << 8) |
+				((rsp_tmp[1] & 0xff000000) >> 24);
+		} else {
+			/*Short response*/
+			rsp[0] = rsp[1] = rsp[2] = rsp[3] = 0;
+			rsp[0] = mcq_readl(host, RESP01_R);
+		}
+	}
+}
+
+static u32 dw_mci_cqe_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
+{
+	u32 cmdr;
+
+	cmd->error = -EINPROGRESS;
+	cmdr = (cmd->opcode << 8);
+
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136)
+			cmdr |= SDMMC_RESP_LEN_136;
+		else {
+			if (cmd->flags & MMC_RSP_BUSY)
+				cmdr |= SDMMC_RESP_LEN_48B;
+			else
+				cmdr |= SDMMC_RESP_LEN_48;
+		}
+	}
+
+	cmdr |= SDMMC_CMD_CHK_RESP_CRC;
+	if (cmd->opcode == MMC_GO_IDLE_STATE ||
+	   cmd->opcode == MMC_SEND_OP_COND ||
+	   (cmd->opcode == MMC_SELECT_CARD && cmd->flags == (MMC_RSP_NONE | MMC_CMD_AC)))
+		cmdr &= ~SDMMC_CMD_CHK_RESP_CRC;
+
+	cmdr |= SDMMC_CMD_IDX_CHK_ENABLE;
+	if (cmd->opcode == MMC_GO_IDLE_STATE ||
+	   cmd->opcode == MMC_SEND_OP_COND ||
+	   cmd->opcode == MMC_SEND_CSD ||
+	   cmd->opcode == MMC_SEND_CID ||
+	   cmd->opcode == MMC_ALL_SEND_CID ||
+	   (cmd->opcode == MMC_SELECT_CARD && cmd->flags == (MMC_RSP_NONE | MMC_CMD_AC)))
+		cmdr &= ~SDMMC_CMD_IDX_CHK_ENABLE;
+
+	if (cmd->data)
+		cmdr |= SDMMC_DATA;
+
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmdr |= (SDMMC_ABORT_CMD << 6);
+
+	return cmdr;
+}
+
+static int dw_mci_cqe_start_command(struct dw_mci *host,
+				 struct mmc_command *cmd, u32 cmd_flags)
+{
+	int err = 0;
+	unsigned long end = 0;
+	unsigned long flags;
+	bool xfer_flag = false;
+	int ret;
+	u32 status;
+
+	host->cmd = cmd;
+
+	switch (cmd->opcode) {
+	case MMC_READ_SINGLE_BLOCK:
+	case MMC_READ_MULTIPLE_BLOCK:
+	case MMC_WRITE_BLOCK:
+	case MMC_WRITE_MULTIPLE_BLOCK:
+	case MMC_SEND_EXT_CSD:
+	case MMC_GEN_CMD:
+	case MMC_SLEEP_AWAKE:
+	case MMC_SWITCH:
+	case MMC_SET_WRITE_PROT:
+	case MMC_CLR_WRITE_PROT:
+	case MMC_SEND_WRITE_PROT:
+	case MMC_ERASE:
+	case MMC_SEND_TUNING_BLOCK_HS200:
+		xfer_flag = true;
+		break;
+	default:
+		xfer_flag = false;
+	}
+
+	host->int_waiting = &dw_mci_wait;
+	end = jiffies + msecs_to_jiffies(DW_MCI_TIMEOUT_Ms);
+	mod_timer(&host->timer, end);
+
+	if (host->int_waiting) {
+		dw_mci_clr_signal_int(host);
+		dw_mci_clr_int(host);
+
+		/*command with data, r1b case*/
+		if (xfer_flag == 1)
+			dw_mci_en_xfer_int(host);
+		else
+			dw_mci_en_cd_int(host);
+
+		/*If we use cmd23, we cannot send auto stop command*/
+		if (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+		    cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
+			if (host->is_sbc) {
+				mcq_writew(host, XFER_MODE_R,
+					mcq_readw(host, XFER_MODE_R) & ~BIT(SDMMC_AUTO_CMD_ENABLE));
+					host->is_sbc = 0;
+			}
+		}
+
+		host->opcode = cmd->opcode;
+		host->arg = cmd->arg;
+
+		spin_lock_irqsave(&host->irq_lock, flags);
+		mcq_writew(host, CMD_R, cmd_flags);
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+
+		wait_for_completion(host->int_waiting);
+
+		if (xfer_flag == 1) {
+			ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, status,
+				(status & SDMMC_XFER_COMPLETE) == SDMMC_XFER_COMPLETE,
+					10, DW_MCI_TIMEOUT);
+			if (ret) {
+				/*error interrupt detected*/
+				if ((mcq_readw(host, NORMAL_INT_STAT_R) & SDMMC_ERR_INTERRUPT)
+					&& (host->tuning == 1))
+					dev_info(host->dev, "Tuning error ... keep tuning\n");
+				else
+					dev_err(host->dev, "Timeout waiting xfer complete,status = 0x%x\n",
+						(status & 0xffff));
+			}
+		} else {
+			ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, status,
+				(status & SDMMC_CMD_COMPLETE) == SDMMC_CMD_COMPLETE,
+					10, DW_MCI_TIMEOUT);
+			if (ret)
+				dev_err(host->dev, "Timeout waiting cmd request complete\n");
+		}
+
+		if (host->normal_interrupt & SDMMC_ERR_INTERRUPT) {
+			if (host->tuning != 1)
+				dw_mci_cqe_regs_show(host, cmd, cmd_flags);
+			err = -1;
+		}
+	}
+
+	return err;
+}
+
+static void dw_mci_cqe_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
+{
+
+	struct mmc_command stop;
+	u32 cmdr;
+	/*Stop command only use after data command*/
+	if (!cmd->data)
+		return;
+
+	memset(&stop, 0, sizeof(struct mmc_command));
+
+	if (cmd->opcode == MMC_READ_SINGLE_BLOCK ||
+	    cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+	    cmd->opcode == MMC_WRITE_BLOCK ||
+	    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200) {
+		stop.opcode = MMC_STOP_TRANSMISSION;
+		stop.arg = 0;
+		stop.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	} else if (cmd->opcode == SD_IO_RW_EXTENDED) {
+		stop.opcode = SD_IO_RW_DIRECT;
+		stop.arg |= (1 << 31) | (0 << 28) | (SDIO_CCCR_ABORT << 9) |
+			    ((cmd->arg >> 28) & 0x7);
+		stop.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
+	} else {
+		return;
+	}
+
+	cmdr = (stop.opcode << 8) | SDMMC_RESP_LEN_48 |
+		SDMMC_CMD_CHK_RESP_CRC | SDMMC_CMD_IDX_CHK_ENABLE;
+	cmdr |= (SDMMC_ABORT_CMD << 6);
+	mcq_writew(host, XFER_MODE_R, 0);
+	mcq_writel(host, ARGUMENT_R, stop.arg);
+	dw_mci_cqe_start_command(host, &stop, cmdr);
+}
+
+static int dw_mci_cqe_wait_status(struct dw_mci *host, struct mmc_command *cmd, u32 *status)
+{
+	struct mmc_command wait;
+	u32 cmdr;
+	u32 cur_state;
+	unsigned long timeend;
+	int err = 0;
+
+	/* According to Synopsys userguide, we need to send wait command after
+	 * stop cmd to check current status
+	 */
+
+	wait = host->stat_ready;
+	memset(&wait, 0, sizeof(struct mmc_command));
+
+	timeend = jiffies + msecs_to_jiffies(500);
+	do {
+		wait.opcode = MMC_SEND_STATUS;
+		wait.arg = 1 << 16;
+		wait.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+		wait.data = NULL;
+		cmdr = (wait.opcode << 8) | SDMMC_RESP_LEN_48 |
+			SDMMC_CMD_CHK_RESP_CRC | SDMMC_CMD_IDX_CHK_ENABLE;
+
+		mcq_writew(host, XFER_MODE_R, 0);
+		mcq_writel(host, ARGUMENT_R, wait.arg);
+		err = dw_mci_cqe_start_command(host, &wait, cmdr);
+		if (err) {
+			dw_mci_cqe_reset(host);
+			break;
+		}
+
+		dw_mci_cqe_read_rsp(host, &wait, wait.resp);
+		*status = wait.resp[0];
+		cur_state = R1_CURRENT_STATE(wait.resp[0]);
+		err = -DW_MCI_NOT_READY;
+		if (cur_state == R1_STATE_TRAN) {
+			if (wait.resp[0] & R1_READY_FOR_DATA) {
+				err = 0;
+				break;
+			}
+		}
+	} while (time_before(jiffies, timeend));
+
+	return err;
+}
+
+static void dw_mci_cqe_stop_dma(struct dw_mci *host, struct mmc_data *data)
+{
+	u32 dir = 0;
+
+	if (data->flags & MMC_DATA_READ)
+		dir = DMA_FROM_DEVICE;
+	else
+		dir = DMA_TO_DEVICE;
+
+	dma_unmap_sg(mmc_dev(host->slot->mmc), data->sg, data->sg_len, dir);
+	host->sg = NULL;
+}
+
+static void dw_mci_cqe_prepare_desc64(struct dw_mci *host, struct mmc_data *data,
+					struct scatterlist *sg)
+{
+	dev_info(host->dev, "Currently, the 64bit DMA mode is not implemented yet.\n");
+}
+
+
+static void dw_mci_cqe_prepare_desc32(struct dw_mci *host, struct mmc_data *data,
+					struct scatterlist *sg)
+{
+	u32  blk_cnt, cur_blk_cnt, remain_blk_cnt;
+	u32  tmp_val;
+	u32 *desc_base = host->sg_cpu;
+	u32  dma_len = 0;
+	u32  dma_addr;
+	u32  i;
+	unsigned int begin, end;
+
+	for (i = 0; i < host->dma_nents; i++, sg++) {
+		dma_len = sg_dma_len(sg);
+
+		/*blk_cnt must be the multiple of 512(0x200)*/
+		if (dma_len < SZ_512)
+			blk_cnt = 1;
+		else
+			blk_cnt  = dma_len >> 9;
+
+		remain_blk_cnt  = blk_cnt;
+		dma_addr = sg_dma_address(sg);
+
+		while (remain_blk_cnt) {
+			/*DW_MCI_MAX_SCRIPT_BLK is the max
+			 * for each descriptor record
+			 */
+			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
+				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
+			else
+				cur_blk_cnt = remain_blk_cnt;
+
+			/* In Synopsys DesignWare Databook Page 84,
+			 * They mentioned the DMA 128MB restriction
+			 */
+			begin = dma_addr / SZ_128M;
+			end = (dma_addr + cur_blk_cnt * SZ_512) / SZ_128M;
+
+			/*If begin and end in the different 128MB memory zone*/
+			if (begin != end)
+				cur_blk_cnt = (end * SZ_128M - dma_addr) / SZ_512;
+
+			if (dma_len < SZ_512)
+				tmp_val = ((dma_len) << 16) | VALID(0x1) | ACT(0x4);
+			else
+				tmp_val = ((cur_blk_cnt & 0x7f) << 25) | VALID(0x1) | ACT(0x4);
+
+			/*Last descriptor*/
+			if (i == host->dma_nents - 1 && remain_blk_cnt == cur_blk_cnt)
+				tmp_val |= THE_END(0x1);
+
+			desc_base[0] =  tmp_val;
+			desc_base[1] =  dma_addr;
+
+			dma_addr = dma_addr + (cur_blk_cnt << 9);
+			remain_blk_cnt -= cur_blk_cnt;
+			desc_base += 2;
+		}
+	}
+}
+
+static int dw_mci_cqe_get_cd(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	int gpio_cd = mmc_gpio_get_cd(mmc);
+	int present = -1;
+
+	/* Use platform get_cd function, else try onboard card detect */
+	if (((mmc->caps & MMC_CAP_NEEDS_POLL)
+		|| !mmc_card_is_removable(mmc))) {
+		present = 1;
+
+		if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
+			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
+				dev_info(&mmc->class_dev,
+					"card is polling.\n");
+			} else {
+				dev_info(&mmc->class_dev,
+					"card is non-removable.\n");
+			}
+			set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+		}
+
+		return present;
+	} else if (gpio_cd >= 0) {
+		present = gpio_cd;
+	} else {
+		/*SD card detect using IP regs is todo*/
+		dev_err(&mmc->class_dev, "SD card detect using IP regs is ToDo.\n");
+	}
+
+	spin_lock_bh(&host->lock);
+
+	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+		dev_dbg(&mmc->class_dev, "card is present\n");
+	else if (!present &&
+		!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+		dev_dbg(&mmc->class_dev, "card is not present\n");
+
+	spin_unlock_bh(&host->lock);
+
+	return present;
+}
+
+static void dw_mci_cqe_submit_data_dma(struct dw_mci *host)
+{
+	if (host->dma_64bit_address == 1)
+		dw_mci_cqe_prepare_desc64(host, host->data, host->sg);
+	else
+		dw_mci_cqe_prepare_desc32(host, host->data, host->sg);
+
+}
+
+static void dw_mci_cqe_submit_data(struct dw_mci *host, struct mmc_data *data)
+{
+	u32 dir = 0;
+
+	host->sg = NULL;
+	host->data = data;
+
+	if (data->flags & MMC_DATA_READ)
+		dir = DMA_FROM_DEVICE;
+	else
+		dir = DMA_TO_DEVICE;
+
+	host->dma_nents = dma_map_sg(mmc_dev(host->slot->mmc),
+					data->sg, data->sg_len, dir);
+	host->sg = data->sg;
+
+	host->using_dma = 1;
+
+	dw_mci_cqe_submit_data_dma(host);
+}
+
+static void dw_mci_cqe_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
+{
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	unsigned int clock = slot->clock;
+	u32 div = 0;
+
+	slot->mmc->actual_clock = 0;
+
+	if (clock != host->current_speed || force_clkinit) {
+		div = host->bus_hz / clock;
+		if (host->bus_hz % clock)
+			div += 1;
+
+		if (clock != slot->__clk_old) {
+			/* Silent the verbose log if calling from PM context */
+			dev_info(&slot->mmc->class_dev,
+				"Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+				slot->id, host->bus_hz, clock, host->bus_hz / div, div);
+		}
+
+		slot->__clk_old = clock;
+		slot->mmc->actual_clock = host->bus_hz / div;
+
+		if (drv_data && drv_data->set_ios)
+			drv_data->set_ios(slot, &slot->mmc->ios);
+	}
+}
+
+
+static void dw_mci_cqe_err_handle(struct dw_mci *host, struct mmc_command *cmd)
+{
+	u32 status = 0;
+	int pstat_rty = 0;
+	int ret;
+	int err = 0;
+	int rty_cnt = 0;
+
+	do {
+		mcq_writew(host, ERROR_INT_STAT_R,
+			mcq_readw(host, ERROR_INT_STAT_R) & 0xffff);
+		/*synchronous abort: stop host dma*/
+		mcq_writeb(host, BGAP_CTRL_R, SDMMC_STOP_BG_REQ);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, status,
+			(status & SDMMC_XFER_COMPLETE) == SDMMC_XFER_COMPLETE, 10, DW_MCI_TIMEOUT);
+		if (ret) {
+			if ((mcq_readw(host, NORMAL_INT_STAT_R) & SDMMC_ERR_INTERRUPT) != 0)
+				dev_info(host->dev, "status = 0x%x\n", (status & 0xffff));
+			else
+				dev_err(host->dev, "Timeout waiting err_handle xfer complete\n");
+		}
+
+		mcq_writew(host, NORMAL_INT_STAT_R, SDMMC_XFER_COMPLETE);
+
+		if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
+			dw_mci_cqe_prep_stop_abort(host, cmd);
+			mdelay(1);
+
+			err = dw_mci_cqe_wait_status(host, cmd, &status);
+				rty_cnt++;
+				if (rty_cnt > 100) {
+					if (err == -DW_MCI_NOT_READY)
+						dev_err(host->dev, "status check failed, err = %d, status = 0x%x\n",
+							err, status);
+						break;
+				}
+		} else {
+			break;
+		}
+
+		mcq_writeb(host, SW_RST_R, SDMMC_RST_CMD | SDMMC_RST_DAT);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+				(status & SW_RST_BOTH_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+		ret = readl_poll_timeout(host->regs + SDMMC_PSTATE_REG, status,
+				(status & 0x3) == 0x0, 10, DW_MCI_TIMEOUT);
+		if (ret)
+			dev_err(host->dev, "Waiting error handling done timeout\n");
+
+		udelay(40);
+
+		pstat_rty++;
+		if (pstat_rty > 5000) {
+			dev_err(host->dev, "wait pstate register data line ready timeout\n");
+			break;
+		}
+	} while ((mcq_readl(host, PSTATE_REG) & 0xf00000) != 0xf00000 ||
+		(mcq_readl(host, PSTATE_REG) & 0xf0) != 0xf0);
+}
+
+static void dw_mci_cqe_send_stop_abort(struct dw_mci *host,
+			      struct dw_mci_slot *slot,
+			      struct mmc_command *cmd)
+{
+	dw_mci_cqe_reset(host);
+
+	if (cmd->data)
+		dw_mci_cqe_err_handle(host, cmd);
+	else
+		return;
+}
+
+static u32 dw_mci_cqe_prepare_data_flags(struct mmc_command *cmd)
+{
+	u32 dataflags;
+	int read_flag = 1;
+	int mul_blk_flag = 0;
+	int auto_stop_flag = 0;
+
+	if (cmd->opcode == MMC_WRITE_BLOCK ||
+	   cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+	   cmd->opcode == MMC_LOCK_UNLOCK ||
+	   (cmd->opcode == MMC_GEN_CMD && cmd->arg == 0))
+		read_flag = 0;
+
+	if (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+	   cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
+		mul_blk_flag = 1;
+		auto_stop_flag = 1;
+	}
+
+	dataflags = (mul_blk_flag << SDMMC_MULTI_BLK_SEL) |
+		    (read_flag << SDMMC_DATA_XFER_DIR) |
+		    (auto_stop_flag << SDMMC_AUTO_CMD_ENABLE) |
+		    (SDMMC_BLOCK_COUNT_ENABLE) |
+		    (SDMMC_DMA_ENABLE);
+
+	return dataflags;
+}
+
+static int dw_mci_cqe_command_complete(struct dw_mci *host, u16 interrupt,
+					int *cmd_error)
+{
+	if (interrupt & (SDMMC_CMD_IDX_ERR | SDMMC_CMD_END_BIT_ERR
+		| SDMMC_CMD_CRC_ERR)) {
+		if (host->tuning)
+			*cmd_error = -TUNING_ERR;
+		else
+			*cmd_error = -EILSEQ;
+	} else if (interrupt & SDMMC_CMD_TOUT_ERR) {
+		if (host->tuning)
+			*cmd_error = -TUNING_ERR;
+		else
+			*cmd_error = -ETIMEDOUT;
+	} else {
+		*cmd_error = 0;
+	}
+
+	return *cmd_error;
+}
+
+static int dw_mci_cqe_data_complete(struct dw_mci *host, u16 interrupt,
+					int *data_error)
+{
+	if (interrupt & (SDMMC_DATA_END_BIT_ERR | SDMMC_DATA_CRC_ERR)) {
+		if (host->tuning)
+			*data_error = -TUNING_ERR;
+		else
+			*data_error = -EILSEQ;
+	} else if (interrupt & SDMMC_DATA_TOUT_ERR) {
+		if (host->tuning)
+			*data_error = -TUNING_ERR;
+		else
+			*data_error = -ETIMEDOUT;
+	} else if (interrupt & SDMMC_ADMA_ERR) {
+		*data_error = -EIO;
+	} else {
+		*data_error = 0;
+	}
+
+	return *data_error;
+}
+
+static void __dw_mci_cqe_start_request(struct dw_mci *host,
+				   struct dw_mci_slot *slot,
+				   struct mmc_command *cmd)
+{
+	struct mmc_data *data;
+	u32 cmdflags;
+	u32 dataflags;
+	int ret = 0;
+
+	data = cmd->data;
+
+	if (data) {
+		mcq_writew(host, BLOCKCOUNT_R, data->blocks);
+		mcq_writel(host, BLOCKSIZE_R, data->blksz);
+		mcq_writel(host, ADMA_SA_LOW_R, host->sg_dma);
+
+		dataflags = dw_mci_cqe_prepare_data_flags(cmd);
+
+		mcq_writew(host, XFER_MODE_R, dataflags);
+	} else {
+		if (cmd->opcode == MMC_SET_BLOCK_COUNT)
+			host->is_sbc = 1;
+		else
+			host->is_sbc = 0;
+
+		mcq_writew(host, XFER_MODE_R, 0);
+	}
+
+	mcq_writel(host, ARGUMENT_R, cmd->arg);
+
+	cmdflags = dw_mci_cqe_prepare_command(slot->mmc, cmd);
+
+	if (data) {
+		data->bytes_xfered = 0;
+		if (host->use_dma == TRANS_MODE_DMA) {
+			dw_mci_cqe_submit_data(host, data);
+			wmb(); /* drain writebuffer */
+		} else {
+			/*Using PIO mode*/
+			dev_err(host->dev, "pio mode is not supported currently\n");
+		}
+	}
+
+	ret = dw_mci_cqe_start_command(host, cmd, cmdflags);
+
+	if (ret == 0) {
+		dw_mci_cqe_read_rsp(host, cmd, cmd->resp);
+
+		if (data)
+			data->bytes_xfered += (data->blocks * data->blksz);
+	}
+
+	dw_mci_cqe_command_complete(host, host->error_interrupt, &cmd->error);
+	if (data) {
+		dw_mci_cqe_data_complete(host, host->error_interrupt, &data->error);
+		if (host->use_dma == TRANS_MODE_DMA)
+			dw_mci_cqe_stop_dma(host, data);
+		else {
+			/*Using PIO mode*/
+			dev_err(host->dev, "pio mode is not supported currently\n");
+		}
+	}
+
+	if (ret != 0)
+		dw_mci_cqe_send_stop_abort(host, slot, cmd);
+
+	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
+		/*
+		 * If cmd11 needs to be dealt with specially, put in here.
+		 */
+	}
+}
+
+static void dw_mci_cqe_start_request(struct dw_mci *host,
+				 struct dw_mci_slot *slot)
+{
+	struct mmc_request *mrq = slot->mrq;
+
+	if (mrq->sbc)
+		__dw_mci_cqe_start_request(host, slot, mrq->sbc);
+
+	if (mrq->cmd)
+		__dw_mci_cqe_start_request(host, slot, mrq->cmd);
+}
+
+static void dw_mci_cqe_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+
+	WARN_ON(slot->mrq);
+
+	/*
+	 * The check for card presence and queueing of the request must be
+	 * atomic, otherwise the card could be removed in between and the
+	 * request wouldn't fail until another card was inserted.
+	 */
+
+	if (!dw_mci_cqe_get_cd(mmc)) {
+		mrq->cmd->error = -ENOMEDIUM;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
+	down_write(&host->cr_rw_sem);
+
+	/*cmdq case needs extra check*/
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
+		if ((host->cqe) == NULL) {
+			dev_err(host->dev, "dw_mci_request_cqe not done yet\n");
+			mdelay(2);
+		}
+
+		if (mmc->cqe_on == false && host->cqe->activated == true)
+			cqhci_deactivate(mmc);
+
+	}
+
+	slot->mrq = mrq;
+	host->mrq = mrq;
+
+	dw_mci_cqe_start_request(host, slot);
+
+	tasklet_schedule(&host->tasklet);
+
+	up_write(&host->cr_rw_sem);
+}
+
+static void dw_mci_cqe_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
+
+	switch (ios->timing) {
+	case MMC_TIMING_MMC_HS400:
+		mcq_writew(host, HOST_CTRL2_R,
+			(mcq_readw(host, HOST_CTRL2_R)
+				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_HS400);
+		break;
+	case MMC_TIMING_MMC_HS200:
+		mcq_writew(host, HOST_CTRL2_R,
+			(mcq_readw(host, HOST_CTRL2_R)
+				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_HS200);
+		break;
+	case MMC_TIMING_MMC_HS:
+		mcq_writew(host, HOST_CTRL2_R,
+			(mcq_readw(host, HOST_CTRL2_R)
+				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_SDR);
+		break;
+	default:
+		/*MMC_TIMING_LEGACY case*/
+		mcq_writew(host, HOST_CTRL2_R,
+			(mcq_readw(host, HOST_CTRL2_R)
+				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_LEGACY);
+	}
+
+	slot->clock = ios->clock;
+
+	if (drv_data && drv_data->set_ios)
+		drv_data->set_ios(slot, ios);
+
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_4:
+		mcq_writeb(host, HOST_CTRL1_R,
+			(mcq_readb(host, HOST_CTRL1_R) &
+			(SDMMC_EXT_DAT_XFER_MASK & SDMMC_DAT_XFER_WIDTH_MASK))
+				|SDMMC_BUS_WIDTH_4);
+		break;
+	case MMC_BUS_WIDTH_8:
+		mcq_writeb(host, HOST_CTRL1_R,
+			(mcq_readb(host, HOST_CTRL1_R) &
+				SDMMC_EXT_DAT_XFER_MASK) | SDMMC_BUS_WIDTH_8);
+		break;
+	default:
+		/* set default 1 bit mode */
+		mcq_writeb(host, HOST_CTRL1_R,
+			(mcq_readb(host, HOST_CTRL1_R) &
+				(SDMMC_EXT_DAT_XFER_MASK &
+				SDMMC_DAT_XFER_WIDTH_MASK)) | SDMMC_BUS_WIDTH_1);
+	}
+}
+
+static int dw_mci_cqe_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+
+	if (drv_data && drv_data->switch_voltage)
+		return drv_data->switch_voltage(mmc, ios);
+
+	return 0;
+}
+
+static int dw_mci_cqe_get_ro(struct mmc_host *mmc)
+{
+	int read_only = 0;
+	int gpio_ro;
+
+	gpio_ro = mmc_gpio_get_ro(mmc);
+
+	/* Use platform get_ro function, else try on board write protect */
+	if (gpio_ro >= 0)
+		read_only = gpio_ro;
+	else
+		/*Need to read the IP register to judge if ro*/
+		dev_err(&mmc->class_dev, "IP get_ro feature is not implemented currently.\n");
+
+	dev_dbg(&mmc->class_dev, "card is %s\n",
+		read_only ? "read-only" : "read-write");
+
+	return read_only;
+}
+
+static int dw_mci_cqe_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	int err = -EINVAL;
+
+	if (drv_data && drv_data->execute_tuning)
+		err = drv_data->execute_tuning(slot, opcode);
+	return err;
+
+}
+
+static int dw_mci_cqe_prepare_hs400_tuning(struct mmc_host *mmc,
+				       struct mmc_ios *ios)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+
+	if (drv_data && drv_data->prepare_hs400_tuning)
+		return drv_data->prepare_hs400_tuning(host, ios);
+
+	return 0;
+}
+
+static void dw_mci_cqe_hs400_complete(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+
+	if (drv_data && drv_data->hs400_complete)
+		drv_data->hs400_complete(mmc);
+}
+
+static void dw_mci_cqe_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+
+	/*
+	 * Add any quirks for this synopsys IP here or
+	 * deal with something special for some specific
+	 * vendors' SOC platform by calling drv_data->init_card().
+	 */
+	if (drv_data && drv_data->init_card)
+		drv_data->init_card(mmc, card);
+}
+
+static const struct mmc_host_ops dw_mci_ops = {
+	.request		= dw_mci_cqe_request,
+	.set_ios		= dw_mci_cqe_set_ios,
+	.get_ro			= dw_mci_cqe_get_ro,
+	.get_cd			= dw_mci_cqe_get_cd,
+	.execute_tuning		= dw_mci_cqe_execute_tuning,
+	.start_signal_voltage_switch = dw_mci_cqe_switch_voltage,
+	.init_card		= dw_mci_cqe_init_card,
+	.prepare_hs400_tuning	= dw_mci_cqe_prepare_hs400_tuning,
+	.hs400_complete         = dw_mci_cqe_hs400_complete,
+};
+
+static void dw_mci_cqe_tasklet_func(unsigned long priv)
+{
+	struct dw_mci *host = (struct dw_mci *)priv;
+	struct mmc_host *prev_mmc = host->slot->mmc;
+	struct mmc_request *mrq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	host->cmd = NULL;
+	host->data = NULL;
+	mrq = host->mrq;
+	host->slot->mrq = NULL;
+	host->mrq = NULL;
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+
+	mmc_request_done(prev_mmc, mrq);
+}
+
+static irqreturn_t dw_mci_cqe_interrupt(int irq, void *dev_id)
+{
+	struct dw_mci *host = dev_id;
+	struct mmc_host *mmc = host->slot->mmc;
+	struct cqhci_host *cq_host = NULL;
+	int cmd_error = 0, data_error = 0;
+
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE))
+		cq_host = mmc->cqe_private;
+
+	dw_mci_get_int(host);
+
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
+		if (mmc->cqe_on == false && cq_host->activated == false)
+			dw_mci_clr_signal_int(host);
+	} else {
+		dw_mci_clr_signal_int(host);
+	}
+	/*if run the cmdq mode*/
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE) &&
+		mmc->cqe_on == true && cq_host->activated == true) {
+		if (host->normal_interrupt & SDMMC_ERR_INTERRUPT) {
+			dev_err(host->dev, "cmdq error: interrupt status=%08x, error interrupt=0x%08x, CQIS=0x%x, CQTCN=0x%x\n",
+				host->normal_interrupt, host->error_interrupt,
+				readl(host->cqe->mmio + CQHCI_IS),
+				readl(host->cqe->mmio + CQHCI_TCN));
+
+			dw_mci_cqe_command_complete(host, host->error_interrupt, &cmd_error);
+			dw_mci_cqe_data_complete(host, host->error_interrupt, &data_error);
+		}
+		cqhci_irq(mmc, (u32)(host->normal_interrupt), cmd_error, data_error);
+		dw_mci_clr_int(host);
+
+		return IRQ_HANDLED;
+	}
+
+	if (host->int_waiting) {
+		del_timer(&host->timer);
+		complete(host->int_waiting);
+	}
+
+	return IRQ_HANDLED;
+
+}
+
+static void dw_mci_cqe_setup(struct dw_mci *host)
+{
+	mcq_writeb(host, SW_RST_R, (SDMMC_RST_ALL|SDMMC_RST_CMD|SDMMC_RST_DAT));
+	mcq_writeb(host, TOUT_CTRL_R, 0xe);
+	mcq_writew(host, HOST_CTRL2_R, SDMMC_HOST_VER4_ENABLE|SDMMC_SIGNALING_EN);
+	mcq_writew(host, NORMAL_INT_STAT_EN_R, 0xffff);
+	mcq_writew(host, ERROR_INT_STAT_EN_R, SDMMC_ALL_ERR_STAT_EN);
+	/*Card detect will be enabled in the last*/
+	mcq_writew(host, NORMAL_INT_SIGNAL_EN_R, (~(SDMMC_CARD_INSERTION_SIGNAL_EN |
+		SDMMC_CARD_REMOVAL_SIGNAL_EN | SDMMC_CARD_INTERRUPT_SIGNAL_EN) & 0xffff));
+	mcq_writew(host, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN);
+	mcq_writeb(host, CTRL_R, SDMMC_RST_N_OE|SDMMC_RST_N|SDMMC_CARD_IS_EMMC);
+	mcq_writeb(host, HOST_CTRL1_R,
+		(mcq_readb(host, HOST_CTRL1_R)&0xe7) | (SDMMC_ADMA2_32 << SDMMC_DMA_SEL));
+	mcq_writeb(host, MSHC_CTRL_R, mcq_readb(host, MSHC_CTRL_R) & (~SDMMC_CMD_CONFLICT_CHECK));
+	mcq_writew(host, CLK_CTRL_R, mcq_readw(host, CLK_CTRL_R)|SDMMC_INTERNAL_CLK_EN);
+}
+
+static int dw_mci_cqe_init_slot_caps(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	struct mmc_host *mmc = slot->mmc;
+	int ctrl_id;
+
+	if (host->pdata->caps)
+		mmc->caps = host->pdata->caps;
+
+	if (host->pdata->pm_caps)
+		mmc->pm_caps = host->pdata->pm_caps;
+
+	if (host->dev->of_node) {
+		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
+		if (ctrl_id < 0)
+			ctrl_id = 0;
+	} else {
+		ctrl_id = to_platform_device(host->dev)->id;
+	}
+
+	if (drv_data && drv_data->caps) {
+		if (ctrl_id >= drv_data->num_caps) {
+			dev_err(host->dev, "invalid controller id %d\n",
+				ctrl_id);
+			return -EINVAL;
+		}
+		mmc->caps |= drv_data->caps[ctrl_id];
+	}
+
+	if (host->pdata->caps2)
+		mmc->caps2 = host->pdata->caps2;
+
+	mmc->f_min = DW_MCI_FREQ_MIN;
+	if (!mmc->f_max)
+		mmc->f_max = DW_MCI_FREQ_MAX;
+
+	/* Process SDIO IRQs through the sdio_irq_work. */
+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
+	return 0;
+}
+
+static int dw_mci_cqe_init_slot(struct dw_mci *host)
+{
+	struct mmc_host *mmc;
+	struct dw_mci_slot *slot;
+	int ret;
+
+	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
+	if (!mmc)
+		return -ENOMEM;
+
+	slot = mmc_priv(mmc);
+	slot->id = 0;
+	slot->sdio_id = host->sdio_id0 + slot->id;
+	slot->mmc = mmc;
+	slot->host = host;
+	host->slot = slot;
+
+	mmc->ops = &dw_mci_ops;
+
+	/*if there are external regulators, get them*/
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret)
+		goto err_host_allocated;
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+
+	dev_info(host->dev, "regulator support volage ocr_avail=0x%x\n",
+			mmc->ocr_avail);
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto err_host_allocated;
+
+	ret = dw_mci_cqe_init_slot_caps(slot);
+	if (ret)
+		goto err_host_allocated;
+
+	/* Useful defaults if platform data is unset. */
+	if (host->use_dma == TRANS_MODE_DMA) {
+		mmc->max_segs = 256;
+		mmc->max_blk_size = 512;
+		mmc->max_seg_size = 0x1000;
+		mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
+		mmc->max_blk_count = mmc->max_req_size / 512;
+	} else {
+		dev_info(host->dev, "dw-mmc-cqe pio mode is ToDo.\n");
+		/* To DO, TRANS_MODE_PIO */
+	}
+
+	dw_mci_cqe_get_cd(mmc);
+
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto err_host_allocated;
+
+	return 0;
+
+err_host_allocated:
+	mmc_free_host(mmc);
+	return ret;
+}
+
+static void dw_mci_cqe_cleanup_slot(struct dw_mci_slot *slot)
+{
+	/* Debugfs stuff is cleaned up by mmc core */
+	mmc_remove_host(slot->mmc);
+	slot->host->slot = NULL;
+	mmc_free_host(slot->mmc);
+}
+
+static void dw_mci_cqe_init_dma(struct dw_mci *host)
+{
+	host->use_dma = TRANS_MODE_DMA;
+
+	/* Determine which DMA interface to use */
+	/* using 32bit DMA by default,
+	 * user can modify this setting by drv_data->init()
+	 */
+	if (host->use_dma == TRANS_MODE_DMA) {
+		host->dma_64bit_address = 0;
+		dev_info(host->dev, "IDMAC supports 32-bit address mode.\n");
+	}
+
+	/* Alloc memory for sg translation */
+	host->sg_cpu = dma_alloc_coherent(host->dev,
+						DW_MCI_DESC_LEN,
+						&host->sg_dma, GFP_KERNEL);
+	if (!host->sg_cpu) {
+		dev_err(host->dev,
+			"%s: could not alloc DMA memory\n",
+			__func__);
+		goto no_dma;
+	}
+
+	return;
+
+no_dma:
+	dev_info(host->dev, "Using PIO mode.\n");
+	host->use_dma = TRANS_MODE_PIO;
+}
+
+#ifdef CONFIG_OF
+static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_board *pdata;
+	struct device *dev = host->dev;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	int ret;
+	u32 clock_frequency;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	/* find reset controller when exist */
+	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
+	if (IS_ERR(pdata->rstc)) {
+		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	device_property_read_u32(dev, "card-detect-delay",
+		&pdata->detect_delay_ms);
+
+	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
+		pdata->bus_hz = clock_frequency;
+
+	if (drv_data && drv_data->parse_dt) {
+		ret = drv_data->parse_dt(host);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	return pdata;
+}
+
+#else /* CONFIG_OF */
+static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif /* CONFIG_OF */
+
+static void dw_mci_cqe_cto_timer(struct timer_list *t)
+{
+	struct dw_mci *host = from_timer(host, t, timer);
+
+	if (host->int_waiting) {
+		dev_err(host->dev, "fired, opcode=%d, arg=0x%x, irq status=0x%x, err irq=0x%x, auto err irq=0x%x\n",
+				host->opcode, host->arg,
+			host->normal_interrupt, host->error_interrupt,
+			host->auto_error_interrupt);
+
+		dw_mci_clr_signal_int(host);
+		dw_mci_get_int(host);
+
+		complete(host->int_waiting);
+	}
+}
+
+static void dw_mci_cqhci_init(struct dw_mci *host)
+{
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
+		host->cqe = cqhci_pltfm_init(host->pdev);
+		if (PTR_ERR(host->cqe) == -EINVAL ||
+		   PTR_ERR(host->cqe) == -ENOMEM ||
+		   PTR_ERR(host->cqe) == -EBUSY) {
+			dev_err(host->dev, "Unable to get the cmdq related attribute,err = %ld\n",
+				PTR_ERR(host->cqe));
+			host->cqe = 0;
+			host->pdata->caps2 &= ~(MMC_CAP2_CQE|MMC_CAP2_CQE_DCMD);
+		} else {
+			host->cqe->ops = &dw_mci_cqhci_host_ops;
+			cqhci_init(host->cqe, host->slot->mmc, 0);
+		}
+	}
+}
+
+int dw_mci_cqe_probe(struct dw_mci *host)
+{
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	int ret = 0;
+
+	if (!host->pdata) {
+		host->pdata = dw_mci_cqe_parse_dt(host);
+		if (PTR_ERR(host->pdata) == -EPROBE_DEFER) {
+			return -EPROBE_DEFER;
+		} else if (IS_ERR(host->pdata)) {
+			dev_err(host->dev, "platform data not available\n");
+			return -EINVAL;
+		}
+	}
+
+	host->biu_clk = devm_clk_get(host->dev, "biu");
+	if (IS_ERR(host->biu_clk)) {
+		dev_dbg(host->dev, "biu clock not available\n");
+	} else {
+		ret = clk_prepare_enable(host->biu_clk);
+		if (ret) {
+			dev_err(host->dev, "failed to enable biu clock\n");
+			return ret;
+		}
+	}
+
+	host->ciu_clk = devm_clk_get(host->dev, "ciu");
+	if (IS_ERR(host->ciu_clk)) {
+		dev_dbg(host->dev, "ciu clock not available\n");
+		host->bus_hz = host->pdata->bus_hz;
+	} else {
+		ret = clk_prepare_enable(host->ciu_clk);
+		if (ret) {
+			dev_err(host->dev, "failed to enable ciu clock\n");
+			goto err_clk_biu;
+		}
+
+		if (host->pdata->bus_hz) {
+			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
+			if (ret)
+				dev_warn(host->dev,
+					"Unable to set bus rate to %uHz\n",
+					 host->pdata->bus_hz);
+		}
+		host->bus_hz = clk_get_rate(host->ciu_clk);
+	}
+
+	if (!host->bus_hz) {
+		dev_err(host->dev,
+			"Platform data must supply bus speed\n");
+		ret = -ENODEV;
+		goto err_clk_ciu;
+	}
+
+	if (!IS_ERR(host->pdata->rstc)) {
+		reset_control_assert(host->pdata->rstc);
+		usleep_range(10, 50);
+		reset_control_deassert(host->pdata->rstc);
+	}
+
+	timer_setup(&host->timer, dw_mci_cqe_cto_timer, 0);
+
+	spin_lock_init(&host->lock);
+	spin_lock_init(&host->irq_lock);
+	init_rwsem(&host->cr_rw_sem);
+	tasklet_init(&host->tasklet, dw_mci_cqe_tasklet_func, (unsigned long)host);
+
+	/*pio mode's parameters should be initialized here*/
+
+	/*Initialize the eMMC IP related attribute*/
+	dw_mci_cqe_setup(host);
+
+	dw_mci_cqe_init_dma(host);
+
+	/* This flag will be set 1 when doing tuning,
+	 * we add this flag because
+	 * some vendors might use other cmd instead of 21
+	 * to tune phase under high speed interface.
+	 * we use this flag to recognize if the system is under tuning stage.
+	 */
+	host->tuning = 0;
+
+	/*Timing_setting is to avoid sending command
+	 *before setting phase in hs200, hs400
+	 */
+	host->current_speed = 0;
+
+	/*Do the rest of init for specific*/
+	if (drv_data && drv_data->init) {
+		ret = drv_data->init(host);
+		if (ret) {
+			dev_err(host->dev,
+				"implementation specific init failed\n");
+			goto err_dmaunmap;
+		}
+	}
+
+	ret = dw_mci_cqe_init_slot(host);
+	if (ret) {
+		dev_err(host->dev, "slot 0 init failed\n");
+		goto err_dmaunmap;
+	}
+
+	ret = devm_request_irq(host->dev, host->irq, dw_mci_cqe_interrupt,
+				host->irq_flags, "dw-mci-cqe", host);
+	if (ret)
+		goto err_dmaunmap;
+
+	/*After the slot initialization,
+	 *now we have mmc data and can initialize cmdq if user enabled
+	 */
+	dw_mci_cqhci_init(host);
+
+	return 0;
+
+err_dmaunmap:
+	if (!IS_ERR(host->pdata->rstc))
+		reset_control_assert(host->pdata->rstc);
+err_clk_ciu:
+	clk_disable_unprepare(host->ciu_clk);
+
+err_clk_biu:
+	clk_disable_unprepare(host->biu_clk);
+
+	return ret;
+}
+EXPORT_SYMBOL(dw_mci_cqe_probe);
+
+void dw_mci_cqe_remove(struct dw_mci *host)
+{
+	dev_dbg(host->dev, "remove slot\n");
+	if (host->slot)
+		dw_mci_cqe_cleanup_slot(host->slot);
+
+	if (!IS_ERR(host->pdata->rstc))
+		reset_control_assert(host->pdata->rstc);
+
+	clk_disable_unprepare(host->ciu_clk);
+	clk_disable_unprepare(host->biu_clk);
+
+}
+EXPORT_SYMBOL(dw_mci_cqe_remove);
+
+#ifdef CONFIG_PM
+int dw_mci_cqe_runtime_suspend(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
+		if (host->slot) {
+			dev_info(host->dev, "cqe suspend\n");
+			ret = cqhci_suspend(host->slot->mmc);
+			if (ret) {
+				dev_err(host->dev, "cqe suspend failed\n");
+				return ret;
+			}
+		}
+	}
+
+	clk_disable_unprepare(host->ciu_clk);
+
+	return ret;
+}
+EXPORT_SYMBOL(dw_mci_cqe_runtime_suspend);
+
+int dw_mci_cqe_runtime_resume(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	int ret = 0;
+
+	clk_prepare_enable(host->ciu_clk);
+
+	dw_mci_cqe_setup(host);
+	if (drv_data && drv_data->init) {
+		ret = drv_data->init(host);
+		if (ret)
+			dev_err(host->dev, "implementation specific init failed\n");
+	}
+
+	init_completion(host->int_waiting);
+
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
+		if (host->slot) {
+			dev_info(host->dev, "cqe resume\n");
+			ret = cqhci_resume(host->slot->mmc);
+			if (ret)
+				dev_err(host->dev, "cqe resume failed\n");
+		}
+	}
+
+	dw_mci_cqe_setup_bus(host->slot, true);
+
+	return ret;
+}
+EXPORT_SYMBOL(dw_mci_cqe_runtime_resume);
+#endif /* CONFIG_PM */
+
+static int __init dw_mci_cqe_init(void)
+{
+	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
+	return 0;
+}
+
+static void __exit dw_mci_cqe_exit(void)
+{
+}
+
+module_init(dw_mci_cqe_init);
+module_exit(dw_mci_cqe_exit);
+
+MODULE_DESCRIPTION("DW Multimedia Card CMDQ Interface driver");
+MODULE_AUTHOR("<jyanchou@realtek.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/dw_mmc_cqe.h b/drivers/mmc/host/dw_mmc_cqe.h
new file mode 100644
index 000000000000..1c84f4533701
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe.h
@@ -0,0 +1,442 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (C) 2023 Realtek Semiconductors, All Rights Reserved.
+ *
+ */
+
+#ifndef __DW_MMC_CQE_H
+#define __DW_MMC_CQE_H
+
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/mmc/core.h>
+#include <linux/reset.h>
+#include <linux/scatterlist.h>
+
+struct dw_mci {
+	spinlock_t              lock;
+	spinlock_t              irq_lock;
+	struct tasklet_struct   tasklet;
+	struct rw_semaphore     cr_rw_sem;
+
+	void __iomem            *regs;
+	resource_size_t         phy_regs;
+
+	struct mmc_request      *mrq;
+	struct mmc_command      *cmd;
+	struct mmc_command	stop_abort;
+	struct mmc_command	stat_ready;
+	struct mmc_data         *data;
+
+	struct clk              *biu_clk;
+	struct clk              *ciu_clk;
+	struct dw_mci_slot      *slot;
+	struct timer_list       timer;
+	struct completion	*int_waiting;
+
+	unsigned int		*desc_vaddr;
+	unsigned int            *sg_cpu;
+	dma_addr_t              sg_dma;
+	int                     use_dma;
+
+	struct platform_device  *pdev;
+	struct device           *dev;
+	struct dw_mci_board     *pdata;
+	const struct dw_mci_drv_data    *drv_data;
+	void                    *priv;
+
+	u32			opcode;
+	u32			arg;
+	u16                     normal_interrupt;
+	u16                     error_interrupt;
+	u16                     auto_error_interrupt;
+
+	u32                     bus_hz;
+	u32			current_speed;
+	u32			stop_cmdr;
+	bool			is_sbc;
+	int			dma_64bit_address;
+	int			using_dma;
+
+	unsigned long           irq_flags; /* IRQ flags */
+	int                     irq;
+	int                     sdio_id0;
+
+	struct scatterlist	*sg;
+	u32			dma_nents;
+
+	u8			tuning;
+	struct cqhci_host       *cqe;
+};
+
+enum {
+	TRANS_MODE_PIO = 0,
+	TRANS_MODE_DMA,
+};
+
+enum dw_mci_cookie {
+	COOKIE_UNMAPPED,
+	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of dwmmc */
+	COOKIE_MAPPED,		/* mapped by prepare_data() of dwmmc */
+};
+/* eMMC control register definition */
+#define SDMMC_SDMASA_R				0x000
+#define SDMMC_BLOCKSIZE_R			0x004
+#define SDMMC_BLOCKCOUNT_R			0x006
+#define SDMMC_ARGUMENT_R			0x008
+#define SDMMC_XFER_MODE_R			0x00c
+#define SDMMC_CMD_R				0x00e
+#define SDMMC_RESP01_R				0x010
+#define SDMMC_RESP23_R				0x014
+#define SDMMC_RESP45_R				0x018
+#define SDMMC_RESP67_R				0x01c
+#define SDMMC_BUF_DATA_R			0x020
+#define SDMMC_PSTATE_REG			0x024
+#define SDMMC_HOST_CTRL1_R			0x028
+#define SDMMC_PWR_CTRL_R			0x029
+#define SDMMC_BGAP_CTRL_R			0x02a
+#define SDMMC_CLK_CTRL_R			0x02c
+#define SDMMC_TOUT_CTRL_R			0x02e
+#define SDMMC_SW_RST_R				0x02f
+#define SDMMC_NORMAL_INT_STAT_R			0x030
+#define SDMMC_ERROR_INT_STAT_R			0x032
+#define SDMMC_NORMAL_INT_STAT_EN_R		0x034
+#define SDMMC_ERROR_INT_STAT_EN_R		0x036
+#define SDMMC_NORMAL_INT_SIGNAL_EN_R		0x038
+#define SDMMC_ERROR_INT_SIGNAL_EN_R		0x03a
+#define SDMMC_AUTO_CMD_STAT_R			0x03c
+#define SDMMC_HOST_CTRL2_R			0x03e
+#define SDMMC_ADMA_ERR_STAT_R			0x054
+#define SDMMC_ADMA_SA_LOW_R			0x058
+
+#define SDMMC_MSHC_CTRL_R			0x208
+#define SDMMC_CTRL_R				0x22c
+
+#define SDMMC_CMD_CONFLICT_CHECK		BIT(0)
+#define CMD_IDX_MASK(x)				((x >> 8)&0x3f)
+
+/*0xc*/
+#define SDMMC_MULTI_BLK_SEL			5
+#define SDMMC_DATA_XFER_DIR			4
+#define SDMMC_BLOCK_COUNT_ENABLE		BIT(1)
+#define SDMMC_DMA_ENABLE			BIT(0)
+#define SDMMC_AUTO_CMD_ENABLE			2
+#define SDMMC_AUTO_CMD_DISABLED			0x0
+#define SDMMC_AUTO_CMD12_ENABLED		0x1
+#define SDMMC_AUTO_CMD23_ENABLED		0x2
+#define SDMMC_AUTO_CMD_SEL			0x3
+
+/*0xe*/
+#define SDMMC_RESP_TYPE_SELECT			0
+#define SDMMC_CMD_TYPE				6
+#define SDMMC_NO_RESP				0x0
+#define SDMMC_RESP_LEN_136			0x1
+#define SDMMC_RESP_LEN_48			0x2
+#define SDMMC_RESP_LEN_48B			0x3
+#define SDMMC_CMD_CHK_RESP_CRC			BIT(3)
+#define SDMMC_CMD_IDX_CHK_ENABLE		BIT(4)
+#define SDMMC_DATA				BIT(5)
+#define SDMMC_ABORT_CMD				0x3
+#define SDMMC_RESUME_CMD			0x2
+#define SDMMC_SUSPEND_CMD			0x1
+#define SDMMC_NORMAL_CMD			0x0
+
+/*0x24 PSTATE*/
+#define SDMMC_CMD_INHIBIT			BIT(0)
+#define SDMMC_CMD_INHIBIT_DAT			BIT(1)
+#define SDMMC_DAT_3_0				(0xf << 20)
+#define SDMMC_DAT_7_4				(0xf << 4)
+
+/*0x28*/
+#define SDMMC_DMA_SEL				3
+#define SDMMC_SDMA				(0x0)
+#define SDMMC_ADMA2_32				(0x2)
+#define SDMMC_ADMA2_64				(0x3)
+#define SDMMC_EXT_DAT_XFER			BIT(5)
+#define SDMMC_EXT_DAT_XFER_MASK			(~SDMMC_EXT_DAT_XFER & 0xff)
+#define SDMMC_HIGH_SPEED_EN			BIT(2)
+#define SDMMC_HIGH_SPEED_MASK			((~BIT(2)) & 0xff)
+#define SDMMC_UHS_MODE_SEL_MASK			((~(BIT(0)|BIT(1)|BIT(2))) & 0xffff)
+#define SDMMC_DAT_XFER_WIDTH			BIT(1)
+#define SDMMC_DAT_XFER_WIDTH_MASK		(~SDMMC_DAT_XFER_WIDTH & 0xff)
+#define SDMMC_BUS_WIDTH_8			SDMMC_EXT_DAT_XFER
+#define SDMMC_BUS_WIDTH_4			SDMMC_DAT_XFER_WIDTH
+#define SDMMC_BUS_WIDTH_1			0
+#define SDMMC_DMA_SEL_CLR			(0xff & (~(0x3<<SDMMC_DMA_SEL)))
+#define SDMMC_DATA_XFER_CLR			((0xff & (~SDMMC_EXT_DAT_XFER)) \
+							& (~SDMMC_DAT_XFER_WIDTH))
+
+/*0x2a*/
+#define SDMMC_STOP_BG_REQ			BIT(0)
+
+/*0x2f SW_RST_R*/
+#define SDMMC_RST_DAT			BIT(2)
+#define SDMMC_RST_CMD			BIT(1)
+#define SDMMC_RST_ALL			BIT(0)
+
+/*0x30 status bitmap*/
+#define SDMMC_STATUS_ALL			0xffff
+#define SDMMC_ERR_INTERRUPT			BIT(15)
+#define SDMMC_CQE_EVENT				BIT(14)
+#define SDMMC_FX_EVENT				BIT(13)
+#define SDMMC_RE_TUNE_EVENT			BIT(12)
+#define SDMMC_INT_C				BIT(11)
+#define SDMMC_INT_B				BIT(10)
+#define SDMMC_INT_A				BIT(9)
+#define SDMMC_CARD_INTERRUPT			BIT(8)
+#define SDMMC_CARD_REMOVAL			BIT(7)
+#define SDMMC_CARD_INSERTION			BIT(6)
+#define SDMMC_BUF_RD_READY			BIT(5)
+#define SDMMC_BUF_WR_READY			BIT(4)
+#define SDMMC_DMA_INTERRPT			BIT(3)
+#define SDMMC_BGAP_EVENT			BIT(2)
+#define SDMMC_XFER_COMPLETE			BIT(1)
+#define SDMMC_CMD_COMPLETE			BIT(0)
+
+/*0x32 error bitmap*/
+#define SDMMC_VENDOR_ERR3			BIT(15)
+#define SDMMC_VENDOR_ERR2			BIT(14)
+#define SDMMC_VENDOR_ERR1			BIT(13)
+#define SDMMC_BOOT_ACK_ERR			BIT(12)
+#define SDMMC_RESP_ERR				BIT(11)
+#define SDMMC_TUNING_ERR			BIT(10)
+#define SDMMC_ADMA_ERR				BIT(9)
+#define SDMMC_AUTO_CMD_ERR			BIT(8)
+#define SDMMC_CUR_LMT_ERR			BIT(7)
+#define SDMMC_DATA_END_BIT_ERR			BIT(6)
+#define SDMMC_DATA_CRC_ERR			BIT(5)
+#define SDMMC_DATA_TOUT_ERR			BIT(4)
+#define SDMMC_CMD_IDX_ERR			BIT(3)
+#define SDMMC_CMD_END_BIT_ERR			BIT(2)
+#define SDMMC_CMD_CRC_ERR			BIT(1)
+#define SDMMC_CMD_TOUT_ERR			BIT(0)
+#define SDMMC_CMD_ERR                           (SDMMC_AUTO_CMD_ERR|SDMMC_CMD_IDX_ERR| \
+						SDMMC_CMD_END_BIT_ERR|SDMMC_CMD_CRC_ERR| \
+						SDMMC_CMD_TOUT_ERR)
+#define SDMMC_DATA_ERR				(SDMMC_ADMA_ERR|SDMMC_DATA_END_BIT_ERR| \
+						SDMMC_DATA_CRC_ERR|SDMMC_DATA_TOUT_ERR)
+
+/*0x34 status enable bitmap*/
+#define SDMMC_CQE_EVENT_STAT_EN			BIT(14)
+#define SDMMC_FX_EVENT_STAT_EN			BIT(13)
+#define SDMMC_RE_TUNE_EVENT_STAT_EN		BIT(12)
+#define SDMMC_INT_C_STAT_EN			BIT(11)
+#define SDMMC_INT_B_STAT_EN			BIT(10)
+#define SDMMC_INT_A_STAT_EN			BIT(9)
+#define SDMMC_CARD_INTERRUPT_STAT_EN		BIT(8)
+#define SDMMC_CARD_REMOVAL_STAT_EN		BIT(7)
+#define SDMMC_CARD_INSERTION_STAT_EN		BIT(6)
+#define SDMMC_BUF_RD_READY_STAT_EN		BIT(5)
+#define SDMMC_BUF_WR_READY_STAT_EN		BIT(4)
+#define SDMMC_DMA_INTERRPT_STAT_EN		BIT(3)
+#define SDMMC_BGAP_EVENT_STAT_EN		BIT(2)
+#define SDMMC_XFER_COMPLETE_STAT_EN		BIT(1)
+#define SDMMC_CMD_COMPLETE_STAT_EN		BIT(0)
+
+/*0x36 error status enable bitmap*/
+#define SDMMC_VENDOR_ERR_STAT_EN3		BIT(15)
+#define SDMMC_VENDOR_ERR_STAT_EN2		BIT(14)
+#define SDMMC_VENDOR_ERR_STAT_EN1		BIT(13)
+#define SDMMC_BOOT_ACK_ERR_STAT_EN		BIT(12)
+#define SDMMC_RESP_ERR_STAT_EN			BIT(11)
+#define SDMMC_TUNING_ERR_STAT_EN		BIT(10)
+#define SDMMC_ADMA_ERR_STAT_EN			BIT(9)
+#define SDMMC_AUTO_CMD_ERR_STAT_EN		BIT(8)
+#define SDMMC_CUR_LMT_ERR_STAT_EN		BIT(7)
+#define SDMMC_DATA_END_BIT_ERR_STAT_EN		BIT(6)
+#define SDMMC_DATA_CRC_ERR_STAT_EN		BIT(5)
+#define SDMMC_DATA_TOUT_ERR_STAT_EN		BIT(4)
+#define SDMMC_CMD_IDX_ERR_STAT_EN		BIT(3)
+#define SDMMC_CMD_END_BIT_ERR_STAT_EN		BIT(2)
+#define SDMMC_CMD_CRC_ERR_STAT_EN		BIT(1)
+#define SDMMC_CMD_TOUT_ERR_STAT_EN		BIT(0)
+
+/*0x38 signal interrupt enable*/
+#define SDMMC_CQE_EVENT_SIGNAL_EN		BIT(14)
+#define SDMMC_FX_EVENT_SIGNAL_EN		BIT(13)
+#define SDMMC_RE_TUNE_EVENT_SIGNAL_EN		BIT(12)
+#define SDMMC_INT_C_SIGNAL_EN			BIT(11)
+#define SDMMC_INT_B_SIGNAL_EN			BIT(10)
+#define SDMMC_INT_A_SIGNAL_EN			BIT(9)
+#define SDMMC_CARD_INTERRUPT_SIGNAL_EN		BIT(8)
+#define SDMMC_CARD_REMOVAL_SIGNAL_EN		BIT(7)
+#define SDMMC_CARD_INSERTION_SIGNAL_EN		BIT(6)
+#define SDMMC_BUF_RD_READY_SIGNAL_EN		BIT(5)
+#define SDMMC_BUF_WR_READY_SIGNAL_EN		BIT(4)
+#define SDMMC_DMA_INTERRPT_SIGNAL_EN		BIT(3)
+#define SDMMC_BGAP_EVENT_SIGNAL_EN		BIT(2)
+#define SDMMC_XFER_COMPLETE_SIGNAL_EN		BIT(1)
+#define SDMMC_CMD_COMPLETE_SIGNAL_EN		BIT(0)
+#define SDMMC_NORMAL_INT_SIGNAL_CMD_EN_R	(~(BIT(6) | BIT(7) | BIT(8) | BIT(1)) & 0xffff)
+#define SDMMC_NORMAL_INT_SIGNAL_DAT_EN_R	(~(BIT(6) | BIT(7) | BIT(8) | BIT(0)) & 0xffff)
+#define SDMMC_NORMAL_INT_SIGNAL_CQE_EN_R	(~(BIT(6) | BIT(7) | BIT(8) | BIT(1) | BIT(0)) \
+						& 0xffff)
+
+/*0x3a error ssignal enable bitmap*/
+#define SDMMC_VENDOR_ERR_SIGNAL_EN3		BIT(15)
+#define SDMMC_VENDOR_ERR_SIGNAL_EN2		BIT(14)
+#define SDMMC_VENDOR_ERR_SIGNAL_EN1		BIT(13)
+#define SDMMC_BOOT_ACK_ERR_SIGNAL_EN		BIT(12)
+#define SDMMC_RESP_ERR_SIGNAL_EN		BIT(11)
+#define SDMMC_TUNING_ERR_SIGNAL_EN		BIT(10)
+#define SDMMC_ADMA_ERR_SIGNAL_EN		BIT(9)
+#define SDMMC_AUTO_CMD_ERR_SIGNAL_EN		BIT(8)
+#define SDMMC_CUR_LMT_ERR_SIGNAL_EN		BIT(7)
+#define SDMMC_DATA_END_BIT_ERR_SIGNAL_EN	BIT(6)
+#define SDMMC_DATA_CRC_ERR_SIGNAL_EN		BIT(5)
+#define SDMMC_DATA_TOUT_ERR_SIGNAL_EN		BIT(4)
+#define SDMMC_CMD_IDX_ERR_SIGNAL_EN		BIT(3)
+#define SDMMC_CMD_END_BIT_ERR_SIGNAL_EN		BIT(2)
+#define SDMMC_CMD_CRC_ERR_SIGNAL_EN		BIT(1)
+#define SDMMC_CMD_TOUT_ERR_STAT_EN		BIT(0)
+
+#define SDMMC_ALL_NORMAL_STAT_EN		(0xfeff)
+#define SDMMC_ALL_ERR_STAT_EN			(0xffff)
+#define SDMMC_ALL_SIGNAL_STAT_EN                (0xfeff)
+#define SDMMC_ALL_ERR_SIGNAL_EN			(0xffff)
+
+/*0x3e*/
+#define SDMMC_LEGACY				0x0
+#define SDMMC_SDR				0x1
+#define SDMMC_HS200				0x3
+#define SDMMC_DDR				0x4
+#define SDMMC_HS400				0x7
+#define SDMMC_HOST_VER4_ENABLE			BIT(12)
+#define SDMMC_SIGNALING_EN			BIT(3)
+
+/*0x22c*/
+#define SDMMC_RST_N_OE				BIT(3)
+#define SDMMC_RST_N				BIT(2)
+#define SDMMC_CARD_IS_EMMC			BIT(0)
+
+#define SDMMC_INTERNAL_CLK_EN			BIT(0)
+#define SDMMC_PLL_USABLE			BIT(0)
+
+#define VALID(x)			((x & 1) << 0)
+#define THE_END(x)			((x & 1) << 1)
+#define INT(x)				((x & 1) << 2)
+#define ACT(x)				((x & 0x7) << 3)
+#define DAT_LENGTH(x)			((x & 0xFFFF) << 16)
+
+#define SW_RST_CMD_DONE				0x2000000
+#define SW_RST_DATA_DONE			0x4000000
+#define SW_RST_BOTH_DONE                        0x6000000
+
+/* Register access macros */
+#define mcq_readl(dev, reg)                     \
+	readl_relaxed((dev)->regs + SDMMC_##reg)
+#define mcq_writel(dev, reg, value)                     \
+	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
+
+#define mcq_readw(dev, reg)                     \
+	readw_relaxed((dev)->regs + SDMMC_##reg)
+#define mcq_writew(dev, reg, value)                     \
+	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
+
+#define mcq_readb(dev, reg)                     \
+	readb_relaxed((dev)->regs + SDMMC_##reg)
+#define mcq_writeb(dev, reg, value)                     \
+	writeb_relaxed((value), (dev)->regs + SDMMC_##reg)
+
+#define dw_mci_get_int(dev)    \
+	do {    \
+		dev->normal_interrupt = mcq_readw(dev, NORMAL_INT_STAT_R);   \
+		dev->error_interrupt = mcq_readw(dev, ERROR_INT_STAT_R);   \
+		dev->auto_error_interrupt = mcq_readw(dev, AUTO_CMD_STAT_R);     \
+	} while (0)
+
+/*clear status register, we always keep the card interrupt*/
+#define dw_mci_clr_int(dev)                                                     \
+	do {                                                                    \
+		mcq_writew(dev, ERROR_INT_STAT_R, mcq_readw(dev, ERROR_INT_STAT_R) & 0xffff); \
+		mcq_writew(dev, NORMAL_INT_STAT_R, mcq_readw(dev, NORMAL_INT_STAT_R) & 0xffff); \
+	} while (0)
+
+/*mask all emmc interrupts*/
+#define dw_mci_clr_signal_int(dev)    \
+	do {      \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R) \
+			& (BIT(6)|BIT(7))); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, 0); \
+	} while (0)
+
+/*for cmdq, we do not need cmd and xfer done, only cqe event*/
+#define dw_mci_en_cqe_int(dev)  \
+	do { \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R)| \
+			SDMMC_NORMAL_INT_SIGNAL_CQE_EN_R); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
+	} while (0)
+
+/*used for data, r1b case, we mask cmd done interrupt*/
+#define dw_mci_en_xfer_int(dev)  \
+	do {  \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
+			mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R)|SDMMC_NORMAL_INT_SIGNAL_DAT_EN_R); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
+	} while (0)
+
+/*used for none-stream case (cmd w/wo/ resp)*/
+#define dw_mci_en_cd_int(dev)  \
+	do {    \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
+			mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R)|SDMMC_NORMAL_INT_SIGNAL_CMD_EN_R); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
+	} while (0)
+
+extern int dw_mci_cqe_probe(struct dw_mci *host);
+extern void dw_mci_cqe_remove(struct dw_mci *host);
+#ifdef CONFIG_PM
+extern int dw_mci_cqe_runtime_suspend(struct device *device);
+extern int dw_mci_cqe_runtime_resume(struct device *device);
+#endif
+irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error, int data_error);
+
+/* Board platform data */
+struct dw_mci_board {
+	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
+	u32 caps;       /* Capabilities */
+	u32 caps2;      /* More capabilities */
+	u32 pm_caps;    /* PM capabilities */
+
+	/* delay in mS before detecting cards after interrupt */
+	u32 detect_delay_ms;
+
+	struct reset_control *rstc;
+};
+
+struct dw_mci_slot {
+	struct mmc_host         *mmc;
+	struct dw_mci           *host;
+
+	struct mmc_request      *mrq;
+
+	unsigned int            clock;
+	unsigned int            __clk_old;
+
+	unsigned long           flags;
+#define DW_MMC_CARD_PRESENT     1
+	int                     id;
+	int                     sdio_id;
+	u8                      switch_partition;
+};
+
+struct dw_mci_drv_data {
+	unsigned long   *caps;
+	u32             num_caps;
+	int             (*init)(struct dw_mci *host);
+	void            (*set_ios)(struct dw_mci_slot *slot, struct mmc_ios *ios);
+	int             (*parse_dt)(struct dw_mci *host);
+	int             (*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
+	int             (*prepare_hs400_tuning)(struct dw_mci *host,
+					struct mmc_ios *ios);
+	int             (*switch_voltage)(struct mmc_host *mmc,
+					struct mmc_ios *ios);
+	void            (*hs400_complete)(struct mmc_host *mmc);
+	void		(*init_card)(struct mmc_host *host,
+					struct mmc_card *card);
+	void            (*shift_rsp)(struct dw_mci *host, struct mmc_command *cmd, u32 *rsp);
+};
+
+void dw_mci_cqe_wait_done(struct dw_mci *host, u32 *addr, u32 mask, u32 value);
+#endif
-- 
2.42.0

