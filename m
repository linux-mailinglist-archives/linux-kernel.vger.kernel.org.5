Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889227CD3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344464AbjJRFxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344446AbjJRFxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:53:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3398FEA;
        Tue, 17 Oct 2023 22:53:44 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39I5rYrjD1104735, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39I5rYrjD1104735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 13:53:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 18 Oct 2023 13:53:34 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Oct 2023 13:53:34 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 18 Oct 2023 13:53:34 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <jh80.chung@samsung.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benchuanggli@gmail.com>, <jyanchou@realtek.com>
Subject: [PATCH V2][3/4] mmc: Add dw mobile mmc cmdq rtk driver
Date:   Wed, 18 Oct 2023 13:53:23 +0800
Message-ID: <20231018055326.18256-4-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018055326.18256-1-jyanchou@realtek.com>
References: <20231018055326.18256-1-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

Add Realtek mmc driver to make good use Synopsys
DesignWare mmc cmdq host driver.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>

---
v0 -> v1:
1. Seperate different support into single patch.
2. Fix the compiler complains.
---
---
 drivers/mmc/host/Kconfig          |   9 +
 drivers/mmc/host/Makefile         |   1 +
 drivers/mmc/host/dw_mmc_cqe-rtk.c | 998 ++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc_cqe-rtk.h | 159 +++++
 4 files changed, 1167 insertions(+)
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 894b89a396bb..23544b226b8e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -775,6 +775,15 @@ config MMC_DW_CQE
 
 	 If unsure, say Y.
 
+config MMC_DW_CQE_RTK
+	tristate "Realtek Soc's specific extensions for Synopsys DW Memory Card Interface"
+	depends on MMC_DW_CQE
+	select REGULATOR_FIXED_VOLTAGE
+	help
+	 This selects support for Realtek SoC specific extensions to the
+	 Synopsys DesignWare Memory Card Interface driver. Select this option
+	 for platforms after RTD16xxb SoC's.
+
 config MMC_DW_BLUEFIELD
 	tristate "BlueField specific extensions for Synopsys DW Memory Card Interface"
 	depends on MMC_DW
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 23546b7b692e..fe4676202b95 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
 obj-$(CONFIG_MMC_DW_STARFIVE)	+= dw_mmc-starfive.o
 obj-$(CONFIG_MMC_DW_CQE)	+= dw_mmc_cqe.o
+obj-$(CONFIG_MMC_DW_CQE_RTK)    += dw_mmc_cqe-rtk.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_VUB300)	+= vub300.o
diff --git a/drivers/mmc/host/dw_mmc_cqe-rtk.c b/drivers/mmc/host/dw_mmc_cqe-rtk.c
new file mode 100644
index 000000000000..ff2f62ec2b6b
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe-rtk.c
@@ -0,0 +1,998 @@
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
+				if (dw_mci_rtk_send_tuning(mmc, MMC_READ_MULTIPLE_BLOCK,
+					0x100, 1024) != 0) {
+					j = 0;
+				} else {
+					j++;
+					bitmap |= BIT(i);
+				}
+			}
+
+			if (max == 0) {
+				if (fail == false) {
+					dev_err(mmc_dev(mmc), "DQS_RETRY:bitmap= 0x%x\n", bitmap);
+					fail = true;
+					dqs_retry = true;
+					dev_err(mmc_dev(mmc), "try pad driving 7\n");
+					pinctrl_select_state(priv->pinctrl, priv->pins_tune4);
+				} else {
+					ret = -EFAULT;
+					dev_err(mmc_dev(mmc),
+						"No proper dqs window, dqs bitmap=0x%x\n", bitmap);
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
+		(tx_window == HS200_WINDOW_ALL_PASS && mmc->ios.timing == MMC_TIMING_MMC_HS200))
+		&& loop_cnt < 60);
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
+		mmc_hw_reset(mmc->card);
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
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) &
+		~(SDMMC_L4_GATED_DIS | SDMMC_L4_GATED_DIS1));
+
+	mcq_writel(host, OTHER1, mcq_readl(host, OTHER1) &
+		(~(SDMMC_DQS_CTRL_GATE_DIS|SDMMC_DBUS_MAS_GATING_DIS)));
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
index 000000000000..e432f9e0375b
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe-rtk.h
@@ -0,0 +1,159 @@
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
+int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
+		     atomic_t *abort);
+void mmc_release_host(struct mmc_host *host);
+
+#endif
-- 
2.42.0

