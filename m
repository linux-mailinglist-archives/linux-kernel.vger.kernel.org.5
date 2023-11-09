Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB97E652E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjKIIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjKIIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:22:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12CA2D5E;
        Thu,  9 Nov 2023 00:22:42 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A98KmMaA1426846, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A98KmMaA1426846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 16:20:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 9 Nov 2023 16:20:48 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Nov 2023 16:20:47 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Thu, 9 Nov 2023 16:20:47 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <jh80.chung@samsung.com>, <riteshh@codeaurora.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <conor+dt@kernel.org>, <asutoshd@codeaurora.org>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <briannorris@chromium.org>, <doug@schmorgal.com>,
        <tonyhuang.sunplus@gmail.com>, <abel.vesa@linaro.org>,
        <william.qiu@starfivetech.com>, <jyanchou@realtek.com>
Subject: [PATCH V6][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Date:   Thu, 9 Nov 2023 16:20:41 +0800
Message-ID: <20231109082043.27147-3-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109082043.27147-1-jyanchou@realtek.com>
References: <20231109082043.27147-1-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-KSE-ServerInfo: RTEXMBS06.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We implemented cmdq feature on Synopsys DesignWare mmc driver.
The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
register definitions, mmc user flow and the addition of cmdq.

New version of User Guide had modify mmc driver's usage flow,
we may need to renew code to precisely follow user guide.

More over, We added a wait status function to satisfy synopsys
user guide's description, since this flow might be specific in
synopsys host driver only.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>

—--
v5 -> v6:
- Fix linux coding style issues.
- Drop useless code that is not described in the bindings.
- Replace devm_clk_get and clk_prepare_enable with devm_clk_get_enabled.
- Replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL.

v4 -> v5:
- Fix linux coding style issues.
- Fix test robot build errors to make good use of setup_tran_desc
  call back function.
- Remove useless function.

v3 -> v4:
- Modify dma mode selection and dma addressing bit to statisfy
  linux coding style.

v1 -> v2:
- Remove dw_mci_cqe_set_tran_desc due to the duplicated function.
- Add ->pre_enable() / ->post_disable()

v0 -> v1:
- Seperate different support into single patch.
- Fix the compiler complains.
---
 drivers/mmc/host/Kconfig      |   13 +
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/dw_mmc_cqe.c | 1467 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc_cqe.h |  456 ++++++++++
 4 files changed, 1937 insertions(+)
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
 create mode 100644 drivers/mmc/host/dw_mmc_cqe.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 58bd5fe4cd25..06bb4de28cc4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -837,6 +837,19 @@ config MMC_DW_STARFIVE
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on StarFive JH7110 SoC.
 
+config MMC_DW_CQE
+	tristate "Synopsys DesignWare Memory Card with CQE Interface"
+	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
+	select MMC_CQHCI
+	help
+	 This selects support for the Synopsys DesignWare Mobile Storage IP
+	 block after JEDEC Standard version 5.1. Select this option for SD and
+	 MMC interfaces that use command queue.
+
+	 If you have a controller with this interface, say Y or M here.
+
+	 If unsure, say Y.
+
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index d0be4465f3ec..464fe58f8541 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
 obj-$(CONFIG_MMC_DW_STARFIVE)	+= dw_mmc-starfive.o
+obj-$(CONFIG_MMC_DW_CQE)	+= dw_mmc_cqe.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_VUB300)	+= vub300.o
diff --git a/drivers/mmc/host/dw_mmc_cqe.c b/drivers/mmc/host/dw_mmc_cqe.c
new file mode 100644
index 000000000000..7476b1215077
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe.c
@@ -0,0 +1,1467 @@
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
+static int dw_mci_cqe_regs_show(struct dw_mci *host,
+				struct mmc_command *cmd, u32 cmd_flags)
+{
+	dev_info(host->dev, "opcode = %d, arg = 0x%x, cmdflags = 0x%x\n",
+		cmd->opcode, cmd->arg, cmd_flags);
+	dev_info(host->dev, "status_int = 0x%x\n", host->normal_interrupt);
+	dev_info(host->dev, "error_int = 0x%x\n", host->error_interrupt);
+	dev_info(host->dev, "auto_error_int = 0x%x\n", host->auto_error_interrupt);
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
+static void dw_mci_cqe_setup_tran_desc(struct mmc_data *data,
+				       struct cqhci_host *cq_host,
+					u8 *desc,
+					int sg_count)
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
+			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
+				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
+			else
+				cur_blk_cnt = remain_blk_cnt;
+
+			begin = addr / SZ_128M;
+			end = (addr + cur_blk_cnt * SZ_512) / SZ_128M;
+
+			if (begin != end)
+				cur_blk_cnt = (end * SZ_128M - addr) / SZ_512;
+
+			if ((i + 1) == sg_count && remain_blk_cnt == cur_blk_cnt)
+				last = true;
+
+			cqhci_set_tran_desc(desc, addr,
+					    (cur_blk_cnt << 9), last, dma64);
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
+	mcq_writeb(host, SW_RST_R, SDMMC_RST_DAT);
+	mcq_writew(host, XFER_MODE_R,
+		   ((1 << SDMMC_MULTI_BLK_SEL) | SDMMC_BLOCK_COUNT_ENABLE
+			| SDMMC_DMA_ENABLE));
+
+	mcq_writeb(host, HOST_CTRL1_R,
+		   (mcq_readb(host, HOST_CTRL1_R) & 0xe7) |
+			(SDMMC_ADMA2_32 << SDMMC_DMA_SEL));
+	mcq_writew(host, BLOCKSIZE_R, 0x200);
+	mcq_writew(host, BLOCKCOUNT_R, 0);
+
+	mcq_writel(host, SDMASA_R, 0);
+
+	cqhci_writel(host->cqe, 0x10, CQHCI_SSC1);
+	cqhci_writel(host->cqe, 0, CQHCI_CTL);
+
+	if (cqhci_readl(host->cqe, CQHCI_CTL) && CQHCI_HALT) {
+		dev_err(host->dev, "%s: cqhci: CQE failed to exit halt state\n",
+			mmc_hostname(mmc));
+	}
+
+	dw_mci_clr_signal_int(host);
+	dw_mci_en_cqe_int(host);
+}
+
+static void dw_mci_cqe_pre_enable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 reg;
+
+	reg = cqhci_readl(cq_host, CQHCI_CFG);
+	reg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, reg, CQHCI_CFG);
+}
+
+static void dw_mci_cqe_post_disable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 reg;
+
+	reg = cqhci_readl(cq_host, CQHCI_CFG);
+	reg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, reg, CQHCI_CFG);
+}
+
+static const struct cqhci_host_ops dw_mci_cqhci_host_ops = {
+	.enable = dw_mci_cqe_enable,
+	.dumpregs = dw_mci_cqe_dumpregs,
+	.pre_enable = dw_mci_cqe_pre_enable,
+	.post_disable = dw_mci_cqe_post_disable,
+	.setup_tran_desc = dw_mci_cqe_setup_tran_desc,
+};
+
+static void dw_mci_cqe_reset(struct dw_mci *host)
+{
+	int ret;
+	u32 status;
+
+	if (mcq_readw(host, ERROR_INT_STAT_R) & SDMMC_CMD_ERR) {
+		mcq_writeb(host, SW_RST_R, SDMMC_RST_CMD);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+					 (status & SW_RST_CMD_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+		if (ret)
+			dev_err(host->dev, "Timeout resetting CMD line\n");
+	}
+
+	if (mcq_readw(host, ERROR_INT_STAT_R) & SDMMC_DATA_ERR) {
+		mcq_writeb(host, SW_RST_R, SDMMC_RST_DAT);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+					 (status & SW_RST_DATA_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+		if (ret)
+			dev_err(host->dev, "Timeout resetting DATA line\n");
+	}
+}
+
+static void dw_mci_cqe_read_rsp(struct dw_mci *host, struct mmc_command *cmd, u32 *rsp)
+{
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136) {
+			u32 rsp_tmp[4];
+
+			rsp_tmp[3] = mcq_readl(host, RESP01_R);
+			rsp_tmp[2] = mcq_readl(host, RESP23_R);
+			rsp_tmp[1] = mcq_readl(host, RESP45_R);
+			rsp_tmp[0] = mcq_readl(host, RESP67_R);
+
+			/* dw_mmc_databook shift Response field to 08 - 139 bits */
+			rsp[3] = (rsp_tmp[3] & 0x00ffffff) << 8;
+			rsp[2] = ((rsp_tmp[2] & 0x00ffffff) << 8)
+					| ((rsp_tmp[3] & 0xff000000) >> 24);
+			rsp[1] = ((rsp_tmp[1] & 0x00ffffff) << 8)
+					| ((rsp_tmp[2] & 0xff000000) >> 24);
+			rsp[0] = ((rsp_tmp[0] & 0x00ffffff) << 8)
+					| ((rsp_tmp[1] & 0xff000000) >> 24);
+		} else {
+			rsp[0] = mcq_readl(host, RESP01_R);
+			rsp[1] = 0;
+			rsp[2] = 0;
+			rsp[3] = 0;
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
+		if (cmd->flags & MMC_RSP_136) {
+			cmdr |= SDMMC_RESP_LEN_136;
+		} else {
+			if (cmd->flags & MMC_RSP_BUSY)
+				cmdr |= SDMMC_RESP_LEN_48B;
+			else
+				cmdr |= SDMMC_RESP_LEN_48;
+		}
+	}
+
+	cmdr |= SDMMC_CMD_CHK_RESP_CRC;
+	if (cmd->opcode == MMC_GO_IDLE_STATE ||
+	    cmd->opcode == MMC_SEND_OP_COND ||
+	   (cmd->opcode == MMC_SELECT_CARD && cmd->flags == (MMC_RSP_NONE | MMC_CMD_AC)))
+		cmdr &= ~SDMMC_CMD_CHK_RESP_CRC;
+
+	cmdr |= SDMMC_CMD_IDX_CHK_ENABLE;
+	if (cmd->opcode == MMC_GO_IDLE_STATE ||
+	    cmd->opcode == MMC_SEND_OP_COND ||
+		cmd->opcode == MMC_SEND_CSD ||
+		cmd->opcode == MMC_SEND_CID ||
+		cmd->opcode == MMC_ALL_SEND_CID ||
+		(cmd->opcode == MMC_SELECT_CARD && cmd->flags == (MMC_RSP_NONE | MMC_CMD_AC)))
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
+				    struct mmc_command *cmd, u32 cmd_flags)
+{
+	unsigned long end = 0;
+	unsigned long flags;
+	bool xfer_flag = false;
+	int ret;
+	int err = 0;
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
+		if (xfer_flag)
+			dw_mci_en_xfer_int(host);
+		else
+			dw_mci_en_cd_int(host);
+
+		if (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+		    cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
+			if (host->is_sbc) {
+				mcq_writew(host, XFER_MODE_R,
+					   mcq_readw(host, XFER_MODE_R) &
+						~BIT(SDMMC_AUTO_CMD_ENABLE));
+					   host->is_sbc = 0;
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
+		if (xfer_flag) {
+			ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, status,
+						 (status & SDMMC_XFER_COMPLETE) ==
+						 SDMMC_XFER_COMPLETE, 10, DW_MCI_TIMEOUT);
+			if (ret) {
+				if ((mcq_readw(host, NORMAL_INT_STAT_R) & SDMMC_ERR_INTERRUPT) &&
+				    host->tuning)
+					dev_dbg(host->dev, "Tuning error ... keep tuning\n");
+				else
+					dev_err(host->dev, "Timeout waiting xfer complete, status = 0x%x\n",
+						(status & 0xffff));
+			}
+		} else {
+			ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, status,
+						 (status & SDMMC_CMD_COMPLETE) ==
+						SDMMC_CMD_COMPLETE, 10, DW_MCI_TIMEOUT);
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
+	return err;
+}
+
+static void dw_mci_cqe_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
+{
+	struct mmc_command stop;
+	u32 cmdr;
+
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
+	/*
+	 * According to Synopsys userguide, we need to send wait command after
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
+				      struct scatterlist *sg)
+{
+	dev_info(host->dev, "Currently, the 64bit DMA mode is not implemented.\n");
+}
+
+static void dw_mci_cqe_prepare_desc32(struct dw_mci *host, struct mmc_data *data,
+				      struct scatterlist *sg)
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
+		if (dma_len < SZ_512)
+			blk_cnt = 1;
+		else
+			blk_cnt  = dma_len >> 9;
+
+		remain_blk_cnt  = blk_cnt;
+		dma_addr = sg_dma_address(sg);
+
+		while (remain_blk_cnt) {
+			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
+				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
+			else
+				cur_blk_cnt = remain_blk_cnt;
+
+			begin = dma_addr / SZ_128M;
+			end = (dma_addr + cur_blk_cnt * SZ_512) / SZ_128M;
+
+			if (begin != end)
+				cur_blk_cnt = (end * SZ_128M - dma_addr) / SZ_512;
+
+			if (dma_len < SZ_512)
+				tmp_val = ((dma_len) << 16) | VALID(0x1) | ACT(0x4);
+			else
+				tmp_val = ((cur_blk_cnt & 0x7f) << 25) | VALID(0x1) | ACT(0x4);
+
+			if (i == host->dma_nents - 1 && remain_blk_cnt == cur_blk_cnt)
+				tmp_val |= END(0x1);
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
+	if (((mmc->caps & MMC_CAP_NEEDS_POLL) || !mmc_card_is_removable(mmc))) {
+		present = 1;
+
+		if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
+			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
+				dev_info(&mmc->class_dev,
+					 "card is polling.\n");
+			} else {
+				dev_info(&mmc->class_dev,
+					 "card is non-removable.\n");
+			}
+			set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+		}
+
+		return present;
+	} else if (gpio_cd >= 0) {
+		present = gpio_cd;
+	} else {
+		dev_err(&mmc->class_dev, "SD card detect using IP regs is ToDo.\n");
+	}
+
+	spin_lock_bh(&host->lock);
+
+	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+		dev_dbg(&mmc->class_dev, "card is present\n");
+	else if (!present && !test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+		dev_dbg(&mmc->class_dev, "card is not present\n");
+
+	spin_unlock_bh(&host->lock);
+
+	return present;
+}
+
+static void dw_mci_cqe_submit_data_dma(struct dw_mci *host)
+{
+	if (host->dma_64bit_address)
+		dw_mci_cqe_prepare_desc64(host, host->data, host->sg);
+	else
+		dw_mci_cqe_prepare_desc32(host, host->data, host->sg);
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
+				     data->sg, data->sg_len, dir);
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
+			dev_info(&slot->mmc->class_dev,
+				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
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
+			   mcq_readw(host, ERROR_INT_STAT_R) & 0xffff);
+		mcq_writeb(host, BGAP_CTRL_R, SDMMC_STOP_BG_REQ);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, status,
+					 (status & SDMMC_XFER_COMPLETE) == SDMMC_XFER_COMPLETE, 10,
+					DW_MCI_TIMEOUT);
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
+					if (err == -DW_MCI_NOT_READY) {
+						dev_err(host->dev, "status check failed, err = %d, status = 0x%x\n",
+							err, status);
+						break;
+					}
+				}
+		} else {
+			break;
+		}
+
+		mcq_writeb(host, SW_RST_R, SDMMC_RST_CMD | SDMMC_RST_DAT);
+
+		ret = readl_poll_timeout(host->regs + SDMMC_CLK_CTRL_R, status,
+					 (status & SW_RST_BOTH_DONE) == 0x0, 10, DW_MCI_TIMEOUT);
+		ret = readl_poll_timeout(host->regs + SDMMC_PSTATE_REG, status,
+					 (status & 0x3) == 0x0, 10, DW_MCI_TIMEOUT);
+		if (ret)
+			dev_err(host->dev, "Waiting error handling done timeout\n");
+
+		usleep_range(10, 50);
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
+				       struct dw_mci_slot *slot, struct mmc_command *cmd)
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
+	    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+	    cmd->opcode == MMC_LOCK_UNLOCK ||
+	    (cmd->opcode == MMC_GEN_CMD && cmd->arg == 0))
+		read_flag = 0;
+
+	if (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+	    cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
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
+				       int *cmd_error)
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
+				    int *data_error)
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
+				       struct dw_mci_slot *slot,
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
+			dev_dbg(host->dev, "pio mode is not supported currently\n");
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
+		else
+			dev_dbg(host->dev, "pio mode is not supported currently\n");
+	}
+
+	if (ret != 0)
+		dw_mci_cqe_send_stop_abort(host, slot, cmd);
+}
+
+static void dw_mci_cqe_start_request(struct dw_mci *host,
+				     struct dw_mci_slot *slot)
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
+	if (!dw_mci_cqe_get_cd(mmc)) {
+		mrq->cmd->error = -ENOMEDIUM;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
+	down_write(&host->cr_rw_sem);
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
+			   (mcq_readw(host, HOST_CTRL2_R)
+				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_HS400);
+		break;
+	case MMC_TIMING_MMC_HS200:
+		mcq_writew(host, HOST_CTRL2_R,
+			   (mcq_readw(host, HOST_CTRL2_R)
+				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_HS200);
+		break;
+	case MMC_TIMING_MMC_HS:
+		mcq_writew(host, HOST_CTRL2_R,
+			   (mcq_readw(host, HOST_CTRL2_R)
+				& SDMMC_UHS_MODE_SEL_MASK) | SDMMC_SDR);
+		break;
+	default:
+		mcq_writew(host, HOST_CTRL2_R,
+			   (mcq_readw(host, HOST_CTRL2_R)
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
+			   (mcq_readb(host, HOST_CTRL1_R) &
+			   (SDMMC_EXT_DAT_XFER_MASK & SDMMC_DAT_XFER_WIDTH_MASK))
+				| SDMMC_BUS_WIDTH_4);
+		break;
+	case MMC_BUS_WIDTH_8:
+		mcq_writeb(host, HOST_CTRL1_R,
+			   (mcq_readb(host, HOST_CTRL1_R) &
+				SDMMC_EXT_DAT_XFER_MASK) | SDMMC_BUS_WIDTH_8);
+		break;
+	default:
+		mcq_writeb(host, HOST_CTRL1_R,
+			   (mcq_readb(host, HOST_CTRL1_R) &
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
+	if (gpio_ro >= 0)
+		read_only = gpio_ro;
+	else
+		dev_dbg(&mmc->class_dev, "IP get_ro feature is not implemented.\n");
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
+}
+
+static int dw_mci_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	int err = -EINVAL;
+
+	if (drv_data && drv_data->execute_hs400_tuning)
+		err = drv_data->execute_hs400_tuning(host, card);
+	return err;
+}
+
+static int dw_mci_cqe_prepare_hs400_tuning(struct mmc_host *mmc,
+					   struct mmc_ios *ios)
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
+	.execute_hs400_tuning	= dw_mci_execute_hs400_tuning,
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
+		if (!mmc->cqe_on && !cq_host->activated)
+			dw_mci_clr_signal_int(host);
+	} else {
+		dw_mci_clr_signal_int(host);
+	}
+
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE) &&
+	    mmc->cqe_on && cq_host->activated) {
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
+}
+
+static void dw_mci_cqe_setup(struct dw_mci *host)
+{
+	mcq_writeb(host, SW_RST_R, (SDMMC_RST_ALL | SDMMC_RST_CMD | SDMMC_RST_DAT));
+	mcq_writeb(host, TOUT_CTRL_R, 0xe);
+	mcq_writew(host, HOST_CTRL2_R, SDMMC_HOST_VER4_ENABLE | SDMMC_SIGNALING_EN);
+	mcq_writew(host, NORMAL_INT_STAT_EN_R, 0xffff);
+	mcq_writew(host, ERROR_INT_STAT_EN_R, SDMMC_ALL_ERR_STAT_EN);
+	mcq_writew(host, NORMAL_INT_SIGNAL_EN_R, (~(SDMMC_CARD_INSERTION_SIGNAL_EN |
+		SDMMC_CARD_REMOVAL_SIGNAL_EN | SDMMC_CARD_INTERRUPT_SIGNAL_EN) & 0xffff));
+	mcq_writew(host, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN);
+	mcq_writeb(host, CTRL_R, SDMMC_RST_N_OE | SDMMC_RST_N | SDMMC_CARD_IS_EMMC);
+	mcq_writeb(host, HOST_CTRL1_R,
+		   (mcq_readb(host, HOST_CTRL1_R) & 0xe7) | (SDMMC_ADMA2_32 << SDMMC_DMA_SEL));
+	mcq_writeb(host, MSHC_CTRL_R, mcq_readb(host, MSHC_CTRL_R) & (~SDMMC_CMD_CONFLICT_CHECK));
+	mcq_writew(host, CLK_CTRL_R, mcq_readw(host, CLK_CTRL_R) | SDMMC_INTERNAL_CLK_EN);
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
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret)
+		goto err_host_allocated;
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto err_host_allocated;
+
+	ret = dw_mci_cqe_init_slot_caps(slot);
+	if (ret)
+		goto err_host_allocated;
+
+	if (host->use_dma == TRANS_MODE_DMA) {
+		mmc->max_segs = 256;
+		mmc->max_blk_size = 512;
+		mmc->max_seg_size = 0x1000;
+		mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
+		mmc->max_blk_count = mmc->max_req_size / 512;
+	} else {
+		dev_dbg(host->dev, "dw-mmc-cqe pio mode is ToDo.\n");
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
+	mmc_remove_host(slot->mmc);
+	slot->host->slot = NULL;
+	mmc_free_host(slot->mmc);
+}
+
+static void dw_mci_cqe_init_dma(struct dw_mci *host)
+{
+	int dma_select, addr_config;
+
+	dma_select = mcq_readb(host, HOST_CTRL1_R);
+
+	if (TRANS_MODE_SELECT(dma_select))
+		host->use_dma = TRANS_MODE_DMA;
+
+	if (host->use_dma == TRANS_MODE_DMA) {
+		addr_config = mcq_readw(host, HOST_CTRL2_R);
+		if (GET_ADDR_BIT_CONFIG(addr_config))
+			host->dma_64bit_address = 1;
+		else
+			host->dma_64bit_address = 0;
+	}
+
+	host->sg_cpu = dma_alloc_coherent(host->dev,
+					  DW_MCI_DESC_LEN, &host->sg_dma, GFP_KERNEL);
+	if (!host->sg_cpu)
+		goto no_dma;
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
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
+	if (IS_ERR(pdata->rstc)) {
+		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
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
+			host->opcode, host->arg,
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
+		    PTR_ERR(host->cqe) == -ENOMEM ||
+		    PTR_ERR(host->cqe) == -EBUSY) {
+			dev_err(host->dev, "Unable to get the cmdq related attribute,err = %ld\n",
+				PTR_ERR(host->cqe));
+			host->cqe = 0;
+			host->pdata->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
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
+	host->biu_clk = devm_clk_get_enabled(host->dev, "biu");
+	if (IS_ERR(host->biu_clk)) {
+		dev_err(host->dev, "failed to enable biu clock\n");
+		return ret;
+	}
+
+	host->ciu_clk = devm_clk_get_enabled(host->dev, "ciu");
+	if (IS_ERR(host->ciu_clk)) {
+		dev_err(host->dev, "failed to enable ciu clock\n");
+		goto err_clk_biu;
+	} else {
+		if (host->pdata->bus_hz) {
+			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
+			if (ret)
+				dev_warn(host->dev,
+					 "Unable to set bus rate to %uHz\n",
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
+	dw_mci_cqe_setup(host);
+
+	dw_mci_cqe_init_dma(host);
+
+	host->tuning = 0;
+	host->current_speed = 0;
+
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
+			       host->irq_flags, "dw-mci-cqe", host);
+	if (ret)
+		goto err_dmaunmap;
+
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
+EXPORT_SYMBOL_GPL(dw_mci_cqe_probe);
+
+void dw_mci_cqe_remove(struct dw_mci *host)
+{
+	if (host->slot)
+		dw_mci_cqe_cleanup_slot(host->slot);
+
+	if (!IS_ERR(host->pdata->rstc))
+		reset_control_assert(host->pdata->rstc);
+
+	clk_disable_unprepare(host->ciu_clk);
+	clk_disable_unprepare(host->biu_clk);
+}
+EXPORT_SYMBOL_GPL(dw_mci_cqe_remove);
+
+#ifdef CONFIG_PM
+int dw_mci_cqe_runtime_suspend(struct device *dev)
+{
+	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
+		if (host->slot) {
+			ret = cqhci_suspend(host->slot->mmc);
+			if (ret)
+				return ret;
+		}
+	}
+
+	clk_disable_unprepare(host->ciu_clk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_mci_cqe_runtime_suspend);
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
+			return ret;
+	}
+
+	init_completion(host->int_waiting);
+
+	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
+		if (host->slot) {
+			ret = cqhci_resume(host->slot->mmc);
+			if (ret)
+				return ret;
+		}
+	}
+
+	dw_mci_cqe_setup_bus(host->slot, true);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_mci_cqe_runtime_resume);
+#endif /* CONFIG_PM */
+
+MODULE_DESCRIPTION("DW Multimedia Card CMDQ Interface driver");
+MODULE_AUTHOR("<jyanchou@realtek.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/dw_mmc_cqe.h b/drivers/mmc/host/dw_mmc_cqe.h
new file mode 100644
index 000000000000..234777f4fd0d
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc_cqe.h
@@ -0,0 +1,456 @@
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
+	/* lock: Spinlock protecting the queue and associated data. */
+	spinlock_t              lock;
+	/* irq_lock: Spinlock protecting the INTMASK setting. */
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
+	/*
+	 * @tuning: This flag will be set 1 when doing tuning. One could use
+	 * this flag to recognize if the system is under tuning stage.
+	 */
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
+
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
+#define CMD_IDX_MASK(x)				(((x) >> 8) & 0x3f)
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
+#define SDMMC_UHS_MODE_SEL_MASK			((~(BIT(0) | BIT(1) | BIT(2))) & 0xffff)
+#define SDMMC_DAT_XFER_WIDTH			BIT(1)
+#define SDMMC_DAT_XFER_WIDTH_MASK		(~SDMMC_DAT_XFER_WIDTH & 0xff)
+#define SDMMC_BUS_WIDTH_8			SDMMC_EXT_DAT_XFER
+#define SDMMC_BUS_WIDTH_4			SDMMC_DAT_XFER_WIDTH
+#define SDMMC_BUS_WIDTH_1			0
+#define SDMMC_DMA_SEL_CLR			(0xff & (~(0x3 << SDMMC_DMA_SEL)))
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
+#define SDMMC_CMD_ERR                           (SDMMC_AUTO_CMD_ERR | SDMMC_CMD_IDX_ERR | \
+						SDMMC_CMD_END_BIT_ERR | SDMMC_CMD_CRC_ERR | \
+						SDMMC_CMD_TOUT_ERR)
+#define SDMMC_DATA_ERR				(SDMMC_ADMA_ERR | SDMMC_DATA_END_BIT_ERR | \
+						SDMMC_DATA_CRC_ERR | SDMMC_DATA_TOUT_ERR)
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
+#define SDMMC_NORMAL_INT_SIGNAL_CQE_EN_R	(~(BIT(6) | BIT(7) | BIT(8) | BIT(1) \
+						| BIT(0)) & 0xffff)
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
+#define SDMMC_ADDRESSING			BIT(13)
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
+#define VALID(x)			(((x) & 1) << 0)
+#define END(x)				(((x) & 1) << 1)
+#define INT(x)				(((x) & 1) << 2)
+#define ACT(x)				(((x) & 0x7) << 3)
+#define DAT_LENGTH(x)			(((x) & 0xFFFF) << 16)
+
+#define SW_RST_CMD_DONE				0x2000000
+#define SW_RST_DATA_DONE			0x4000000
+#define SW_RST_BOTH_DONE                        0x6000000
+
+#define TRANS_MODE_SELECT(x)           (((x) >> 3) & 0x2)
+#define GET_ADDR_BIT_CONFIG(x)         (((x) >> 13) & 0x1)
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
+#define dw_mci_clr_int(dev)                                             \
+	do {                                                            \
+		mcq_writew(dev, ERROR_INT_STAT_R, mcq_readw(dev, ERROR_INT_STAT_R) & 0xffff); \
+		mcq_writew(dev, NORMAL_INT_STAT_R, mcq_readw(dev, NORMAL_INT_STAT_R) & 0xffff); \
+	} while (0)
+
+/*mask all emmc interrupts*/
+#define dw_mci_clr_signal_int(dev)    \
+	do {      \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R) \
+			& (BIT(6) | BIT(7))); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, 0); \
+	} while (0)
+
+/*for cmdq, we do not need cmd and xfer done, only cqe event*/
+#define dw_mci_en_cqe_int(dev)  \
+	do { \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
+				mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R) | \
+				SDMMC_NORMAL_INT_SIGNAL_CQE_EN_R); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
+	} while (0)
+
+/*used for data, r1b case, we mask cmd done interrupt*/
+#define dw_mci_en_xfer_int(dev)  \
+	do {  \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
+			mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R) | \
+				SDMMC_NORMAL_INT_SIGNAL_DAT_EN_R); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
+	} while (0)
+
+/*used for none-stream case (cmd w/wo/ resp)*/
+#define dw_mci_en_cd_int(dev)  \
+	do {    \
+		mcq_writew(dev, NORMAL_INT_SIGNAL_EN_R, \
+			mcq_readw(dev, NORMAL_INT_SIGNAL_EN_R) | \
+					SDMMC_NORMAL_INT_SIGNAL_CMD_EN_R); \
+		mcq_writew(dev, ERROR_INT_SIGNAL_EN_R, SDMMC_ALL_ERR_SIGNAL_EN); \
+	} while (0)
+
+int dw_mci_cqe_probe(struct dw_mci *host);
+void dw_mci_cqe_remove(struct dw_mci *host);
+int dw_mci_cqe_runtime_suspend(struct device *device);
+int dw_mci_cqe_runtime_resume(struct device *device);
+irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error, int data_error);
+void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
+void dw_mci_cqe_wait_done(struct dw_mci *host, u32 *addr, u32 mask, u32 value);
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
+	int		(*execute_hs400_tuning)(struct dw_mci *host, struct mmc_card *card);
+	int             (*prepare_hs400_tuning)(struct dw_mci *host,
+						struct mmc_ios *ios);
+	int             (*switch_voltage)(struct mmc_host *mmc,
+					  struct mmc_ios *ios);
+	void            (*hs400_complete)(struct mmc_host *mmc);
+	void		(*init_card)(struct mmc_host *host,
+				     struct mmc_card *card);
+	void            (*shift_rsp)(struct dw_mci *host, struct mmc_command *cmd, u32 *rsp);
+};
+
+#endif
-- 
2.42.0

