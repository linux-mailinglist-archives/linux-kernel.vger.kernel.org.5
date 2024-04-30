Return-Path: <linux-kernel+bounces-163829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378848B72C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9B0B22DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DA12DDB8;
	Tue, 30 Apr 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THiciaHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A512D214;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475494; cv=none; b=bHe1GJA9DflkgfGDLQNg4NOVZzAQF3/Xb78OUmXf8sR6hpLfrI95VOCUDz+wHY3DF4xi0i1eN51uvXTa6D8eIzgXp/7Tukppw0WdxIrMoNtb6VKpfr4PLQdC9hni0UxkreyJ+dZ8r/G6tTg+cEUJsvWYBZvtOZ+i3hHjvbnLUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475494; c=relaxed/simple;
	bh=9+gjLfc6jrbyBzXiBpA5wn8w6zOzuDxImbrVhw7lHjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IknGpuA2WSt6ngfSLiwn8AWjcK3MXDDE7v/3kgwFlPwVxArJpdpaIyNu05Fsxl9iAAyWka9bOaIgHaNZ7VY6rXGXwtOapo81cFcgBprA1P3cmXUW2dEJuJhByijKmn8NAn4KgQ5S1umclxNEhEtKJNQYf7TI/uUMg3LCzVG4RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THiciaHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2B8AC4AF1C;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714475493;
	bh=9+gjLfc6jrbyBzXiBpA5wn8w6zOzuDxImbrVhw7lHjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=THiciaHfA1N05BHhjK0RSd8180Y3pbFLIqTXAe63/h4povlVKxeVwLQHu2BhKg7Ua
	 Q7U71JpQBRbOkqKKNWKrjR8wzrzpfotKpzncZQ60IfDP+V5oFVkalD3iiAxOswxcRw
	 BWoDii5v2jsX2RC5B9pHqzIlxzBXgs635HvCkrRxm3XA2jmVrH+UcXMDKGrtBcE+1k
	 gaaAoN2GeTzwndexm+1APKt5RlDfM+sHT/K2l1TsJVAo8VxPNNKSMxvfin6zOZxYz1
	 jNTu0EAaQzDDB9VGAWL/wr5wepGsAE5h/EkU3zYwr8E/mX1dPaOYsEhGWHmGhyexFN
	 ukwYXykFO3xvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47D4C25B5C;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Tue, 30 Apr 2024 19:11:12 +0800
Subject: [PATCH v7 3/3] mtd: rawnand: Add Loongson-1 NAND Controller driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-loongson1-nand-v7-3-60787c314fa4@gmail.com>
References: <20240430-loongson1-nand-v7-0-60787c314fa4@gmail.com>
In-Reply-To: <20240430-loongson1-nand-v7-0-60787c314fa4@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714475491; l=23506;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=Pj2lE4qTrYmpHR+aTnNrgi1a+WH7HfnG2Gsddi4X528=;
 b=2hkCMX2U/FEEx4eXV3SQN+JUNVlFRVSdqhtTYrzTV5xBxQtHzr/bPzEFANaomqKlR0Pbz61qO
 yopO4AaiuiBAaaFZk7nLj2QT1c2qDi0ia9sQyrZaFTEbuN6RWvx7/x+
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

This patch adds NAND Controller driver for Loongson-1 SoCs.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v7:
- Rename the dependency to LOONGSON1_APB_DMA

Changes in v6:
- Amend Kconfig
- Add DT support
- Use DT data instead of platform data
- Remove MAX_ID_SIZE
- Remove case NAND_OP_CMD_INSTR in ls1x_nand_set_controller()
- Move ECC configuration to ls1x_nand_attach_chip()
- Rename variable "nand" to "ls1x"
- Rename variable "nc" to "nfc"
- Some minor fixes
- Link to v5: https://lore.kernel.org/all/20210520224213.7907-1-keguang.zhang@gmail.com

Changes in v5:
- Update the driver to fit the raw NAND framework.
- Implement exec_op() instead of legacy cmdfunc().
- Use dma_request_chan() instead of dma_request_channel().
- Some minor fixes and cleanups.

Changes in v4:
- Retrieve the controller from nand_hw_control.

Changes in v3:
- Replace __raw_readl/__raw_writel with readl/writel.
- Split ls1x_nand into two structures:
ls1x_nand_chip and ls1x_nand_controller.

Changes in v2:
- Modify the dependency in Kconfig due to the changes of DMA module.
---
 drivers/mtd/nand/raw/Kconfig          |   7 +
 drivers/mtd/nand/raw/Makefile         |   1 +
 drivers/mtd/nand/raw/loongson1_nand.c | 748 ++++++++++++++++++++++++++++++++++
 3 files changed, 756 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index cbf8ae85e1ae..822bb7a2cea9 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -449,6 +449,13 @@ config MTD_NAND_RENESAS
 	  Enables support for the NAND controller found on Renesas R-Car
 	  Gen3 and RZ/N1 SoC families.
 
+config MTD_NAND_LOONGSON1
+	tristate "Loongson1 NAND controller"
+	depends on LOONGSON1_APB_DMA || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  Enables support for NAND controller on Loongson1 SoCs.
+
 comment "Misc"
 
 config MTD_SM_COMMON
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 25120a4afada..b3c65cab819c 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_INTEL_LGM)	+= intel-nand-controller.o
 obj-$(CONFIG_MTD_NAND_ROCKCHIP)		+= rockchip-nand-controller.o
 obj-$(CONFIG_MTD_NAND_PL35X)		+= pl35x-nand-controller.o
 obj-$(CONFIG_MTD_NAND_RENESAS)		+= renesas-nand-controller.o
+obj-$(CONFIG_MTD_NAND_LOONGSON1)	+= loongson1_nand.o
 
 nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_onfi.o
diff --git a/drivers/mtd/nand/raw/loongson1_nand.c b/drivers/mtd/nand/raw/loongson1_nand.c
new file mode 100644
index 000000000000..d0f66a81ba0b
--- /dev/null
+++ b/drivers/mtd/nand/raw/loongson1_nand.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NAND Controller Driver for Loongson-1 SoC
+ *
+ * Copyright (C) 2015-2024 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sizes.h>
+
+/* Loongson-1 NAND Controller Registers */
+#define NAND_CMD		0x0
+#define NAND_ADDR1		0x4
+#define NAND_ADDR2		0x8
+#define NAND_TIMING		0xc
+#define NAND_IDL		0x10
+#define NAND_IDH_STATUS		0x14
+#define NAND_PARAM		0x18
+#define NAND_OP_NUM		0x1c
+#define MAX_DUMP_REGS		0x20
+
+#define NAND_DMA_ADDR		0x40
+
+/* NAND Command Register Bits */
+#define OP_DONE			BIT(10)
+#define OP_SPARE		BIT(9)
+#define OP_MAIN			BIT(8)
+#define CMD_STATUS		BIT(7)
+#define CMD_RESET		BIT(6)
+#define CMD_READID		BIT(5)
+#define BLOCKS_ERASE		BIT(4)
+#define CMD_ERASE		BIT(3)
+#define CMD_WRITE		BIT(2)
+#define CMD_READ		BIT(1)
+#define CMD_VALID		BIT(0)
+
+#define MAX_ADDR_CYC		5U
+
+#define WAIT_CYCLE_MASK		GENMASK(7, 0)
+#define HOLD_CYCLE_MASK		GENMASK(15, 8)
+#define CELL_SIZE_MASK		GENMASK(11, 8)
+
+#define BITS_PER_WORD		(4 * BITS_PER_BYTE)
+
+/* macros for registers read/write */
+#define nand_readl(nfc, off)		\
+	readl((nfc)->reg_base + (off))
+
+#define nand_writel(nfc, off, val)	\
+	writel((val), (nfc)->reg_base + (off))
+
+struct ls1x_nfc_data {
+	unsigned int status_field;
+	unsigned int op_scope_field;
+	unsigned int hold_cycle;
+	unsigned int wait_cycle;
+	void (*parse_address)(struct nand_chip *chip, const u8 *addrs,
+			      unsigned int naddrs, int cmd);
+};
+
+struct ls1x_nfc {
+	void __iomem *reg_base;
+	struct regmap *regmap;
+	const struct ls1x_nfc_data *data;
+	__le32 addr1_reg;
+	__le32 addr2_reg;
+
+	char *buf;
+	unsigned int len;
+	unsigned int rdy_timeout;
+
+	/* DMA Engine stuff */
+	struct dma_chan *dma_chan;
+	dma_cookie_t dma_cookie;
+	struct completion dma_complete;
+};
+
+struct ls1x_nand {
+	struct device *dev;
+	struct nand_chip chip;
+	struct nand_controller controller;
+	struct ls1x_nfc nfc;
+};
+
+static const struct regmap_config ls1x_nand_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static inline void ls1b_nand_parse_address(struct nand_chip *chip,
+					   const u8 *addrs,
+					   unsigned int naddrs, int cmd)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	unsigned int page_shift = chip->page_shift + 1;
+	int i;
+
+	nfc->addr1_reg = 0;
+	nfc->addr2_reg = 0;
+
+	if (cmd == CMD_ERASE) {
+		page_shift = chip->page_shift;
+
+		for (i = 0; i < min(MAX_ADDR_CYC - 2, naddrs); i++)
+			nfc->addr1_reg |=
+			    (u32)addrs[i] << (page_shift + BITS_PER_BYTE * i);
+		if (i == MAX_ADDR_CYC - 2)
+			nfc->addr2_reg |=
+			    (u32)addrs[i] >> (BITS_PER_WORD - page_shift -
+					      BITS_PER_BYTE * (i - 1));
+
+		return;
+	}
+
+	for (i = 0; i < min(2U, naddrs); i++)
+		nfc->addr1_reg |= (u32)addrs[i] << BITS_PER_BYTE * i;
+	for (i = 2; i < min(MAX_ADDR_CYC, naddrs); i++)
+		nfc->addr1_reg |=
+		    (u32)addrs[i] << (page_shift + BITS_PER_BYTE * (i - 2));
+	if (i == MAX_ADDR_CYC)
+		nfc->addr2_reg |=
+		    (u32)addrs[i] >> (BITS_PER_WORD - page_shift -
+				      BITS_PER_BYTE * (i - 1));
+}
+
+static inline void ls1c_nand_parse_address(struct nand_chip *chip,
+					   const u8 *addrs,
+					   unsigned int naddrs, int cmd)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	int i;
+
+	nfc->addr1_reg = 0;
+	nfc->addr2_reg = 0;
+
+	if (cmd == CMD_ERASE) {
+		for (i = 0; i < min(MAX_ADDR_CYC, naddrs); i++)
+			nfc->addr2_reg |= (u32)addrs[i] << BITS_PER_BYTE * i;
+
+		return;
+	}
+
+	for (i = 0; i < min(MAX_ADDR_CYC, naddrs); i++) {
+		if (i < 2)
+			nfc->addr1_reg |= (u32)addrs[i] << BITS_PER_BYTE * i;
+		else
+			nfc->addr2_reg |=
+			    (u32)addrs[i] << BITS_PER_BYTE * (i - 2);
+	}
+}
+
+static int ls1x_nand_set_controller(struct nand_chip *chip,
+				    const struct nand_subop *subop, int cmd)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	unsigned int op_id;
+
+	nfc->buf = NULL;
+	nfc->len = 0;
+	nfc->rdy_timeout = 0;
+
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		const struct nand_op_instr *instr = &subop->instrs[op_id];
+		unsigned int offset, naddrs;
+		const u8 *addrs;
+
+		switch (instr->type) {
+		case NAND_OP_ADDR_INSTR:
+			offset = nand_subop_get_addr_start_off(subop, op_id);
+			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+			addrs = &instr->ctx.addr.addrs[offset];
+
+			nfc->data->parse_address(chip, addrs, naddrs, cmd);
+			/* set NAND address */
+			nand_writel(nfc, NAND_ADDR1, nfc->addr1_reg);
+			nand_writel(nfc, NAND_ADDR2, nfc->addr2_reg);
+			break;
+		case NAND_OP_DATA_IN_INSTR:
+		case NAND_OP_DATA_OUT_INSTR:
+			offset = nand_subop_get_data_start_off(subop, op_id);
+			nfc->len = nand_subop_get_data_len(subop, op_id);
+			if (instr->type == NAND_OP_DATA_IN_INSTR)
+				nfc->buf =
+				    (void *)instr->ctx.data.buf.in + offset;
+			else if (instr->type == NAND_OP_DATA_OUT_INSTR)
+				nfc->buf =
+				    (void *)instr->ctx.data.buf.out + offset;
+
+			if (cmd & (CMD_READID | CMD_STATUS))
+				break;
+
+			if (!IS_ALIGNED((u32)nfc->buf, chip->buf_align)) {
+				dev_err(ls1x->dev,
+					"nfc->buf %px is not aligned!\n",
+					nfc->buf);
+				return -EOPNOTSUPP;
+			} else if (!IS_ALIGNED(nfc->len, chip->buf_align)) {
+				dev_err(ls1x->dev,
+					"nfc->len %u is not aligned!\n",
+					nfc->len);
+				return -EOPNOTSUPP;
+			}
+
+			/* set NAND data length */
+			nand_writel(nfc, NAND_OP_NUM, nfc->len);
+
+			if (nfc->data->op_scope_field) {
+				int op_scope = nfc->len << ffs(nfc->data->op_scope_field);
+
+				regmap_update_bits(nfc->regmap, NAND_PARAM,
+						   nfc->data->op_scope_field,
+						   op_scope);
+			}
+
+			break;
+		case NAND_OP_WAITRDY_INSTR:
+			nfc->rdy_timeout = instr->ctx.waitrdy.timeout_ms;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* set NAND erase block count */
+	if (cmd & CMD_ERASE)
+		nand_writel(nfc, NAND_OP_NUM, 1);
+	/* set NAND operation region */
+	if (nfc->buf && nfc->len)
+		cmd |= OP_SPARE | OP_MAIN;
+
+	/* set NAND command */
+	nand_writel(nfc, NAND_CMD, cmd);
+	/* Trigger operation */
+	regmap_write_bits(nfc->regmap, NAND_CMD, CMD_VALID, CMD_VALID);
+
+	return 0;
+}
+
+static void ls1x_nand_dma_callback(void *data)
+{
+	struct ls1x_nand *ls1x = (struct ls1x_nand *)data;
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(nfc->dma_chan, nfc->dma_cookie, NULL);
+	if (likely(status == DMA_COMPLETE))
+		dev_dbg(ls1x->dev, "DMA complete with cookie=%d\n",
+			nfc->dma_cookie);
+	else
+		dev_err(ls1x->dev, "DMA error with cookie=%d\n",
+			nfc->dma_cookie);
+
+	complete(&nfc->dma_complete);
+}
+
+static int ls1x_nand_dma_transfer(struct ls1x_nand *ls1x, bool is_write)
+{
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	struct dma_chan *chan = nfc->dma_chan;
+	struct dma_async_tx_descriptor *desc;
+	enum dma_data_direction data_dir =
+	    is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	enum dma_transfer_direction xfer_dir =
+	    is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	dma_addr_t dma_addr;
+	int ret;
+
+	dma_addr = dma_map_single(chan->device->dev, nfc->buf, nfc->len,
+				  data_dir);
+	if (dma_mapping_error(chan->device->dev, dma_addr)) {
+		dev_err(ls1x->dev, "failed to map DMA buffer!\n");
+		return -ENXIO;
+	}
+
+	desc = dmaengine_prep_slave_single(chan, dma_addr, nfc->len, xfer_dir,
+					   DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(ls1x->dev, "failed to prepare DMA descriptor!\n");
+		ret = PTR_ERR(desc);
+		goto err;
+	}
+	desc->callback = ls1x_nand_dma_callback;
+	desc->callback_param = ls1x;
+
+	nfc->dma_cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(nfc->dma_cookie);
+	if (ret) {
+		dev_err(ls1x->dev, "failed to submit DMA descriptor!\n");
+		goto err;
+	}
+
+	dev_dbg(ls1x->dev, "issue DMA with cookie=%d\n", nfc->dma_cookie);
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_timeout(&nfc->dma_complete,
+					  msecs_to_jiffies(nfc->rdy_timeout));
+	if (ret <= 0) {
+		dev_err(ls1x->dev, "DMA timeout!%u\n", nfc->rdy_timeout);
+		dmaengine_terminate_all(chan);
+		ret = -EIO;
+	}
+	ret = 0;
+err:
+	dma_unmap_single(chan->device->dev, dma_addr, nfc->len, data_dir);
+
+	return ret;
+}
+
+static inline int ls1x_nand_wait_for_op_done(struct ls1x_nfc *nfc)
+{
+	unsigned int val;
+	int ret = 0;
+
+	/* Wait for operation done */
+	if (nfc->rdy_timeout)
+		ret = regmap_read_poll_timeout(nfc->regmap, NAND_CMD, val,
+					       val & OP_DONE, 0,
+					       nfc->rdy_timeout * 1000);
+
+	return ret;
+}
+
+static int ls1x_nand_reset_exec(struct nand_chip *chip,
+				const struct nand_subop *subop)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	int ret;
+
+	ls1x_nand_set_controller(chip, subop, CMD_RESET);
+
+	ret = ls1x_nand_wait_for_op_done(nfc);
+	if (ret)
+		dev_err(ls1x->dev, "CMD_RESET failed! %d\n", ret);
+
+	return ret;
+}
+
+static int ls1x_nand_read_id_exec(struct nand_chip *chip,
+				  const struct nand_subop *subop)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	long long idl = 0;
+	int i, ret;
+
+	ls1x_nand_set_controller(chip, subop, CMD_READID);
+
+	ret = ls1x_nand_wait_for_op_done(nfc);
+	if (ret) {
+		dev_err(ls1x->dev, "CMD_READID failed! %d\n", ret);
+		print_hex_dump_debug("REG: ", DUMP_PREFIX_OFFSET, 16, 4,
+				     nfc->reg_base, MAX_DUMP_REGS, false);
+		return ret;
+	}
+
+	idl = __be32_to_cpu(nand_readl(nfc, NAND_IDL));
+	memset(nfc->buf, 0x0, nfc->len);
+
+	for (i = 0; i < nfc->len; i++) {
+		if (i > 0)
+			nfc->buf[i] = (char)(idl >> (i - 1) * BITS_PER_BYTE);
+		else
+			nfc->buf[i] = (char)nand_readl(nfc, NAND_IDH_STATUS);
+	}
+
+	return ret;
+}
+
+static int ls1x_nand_erase_exec(struct nand_chip *chip,
+				const struct nand_subop *subop)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	int ret;
+
+	ls1x_nand_set_controller(chip, subop, CMD_ERASE);
+
+	ret = ls1x_nand_wait_for_op_done(nfc);
+	if (ret) {
+		dev_err(ls1x->dev, "CMD_ERASE failed! %d\n", ret);
+		print_hex_dump_debug("REG: ", DUMP_PREFIX_OFFSET, 16, 4,
+				     nfc->reg_base, MAX_DUMP_REGS, false);
+	}
+
+	return ret;
+}
+
+static int ls1x_nand_read_exec(struct nand_chip *chip,
+			       const struct nand_subop *subop)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	bool is_write = false;
+	int ret;
+
+	ls1x_nand_set_controller(chip, subop, CMD_READ);
+
+	ret = ls1x_nand_dma_transfer(ls1x, is_write);
+	if (ret)
+		return ret;
+
+	ret = ls1x_nand_wait_for_op_done(nfc);
+	if (ret) {
+		dev_err(ls1x->dev, "CMD_READ failed! %d\n", ret);
+		print_hex_dump_debug("REG: ", DUMP_PREFIX_OFFSET, 16, 4,
+				     nfc->reg_base, MAX_DUMP_REGS, false);
+	}
+
+	return ret;
+}
+
+static int ls1x_nand_write_exec(struct nand_chip *chip,
+				const struct nand_subop *subop)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	bool is_write = true;
+	int ret;
+
+	ls1x_nand_set_controller(chip, subop, CMD_WRITE);
+
+	ret = ls1x_nand_dma_transfer(ls1x, is_write);
+	if (ret)
+		return ret;
+
+	ret = ls1x_nand_wait_for_op_done(nfc);
+	if (ret) {
+		dev_err(ls1x->dev, "CMD_WRITE failed! %d\n", ret);
+		print_hex_dump_debug("REG: ", DUMP_PREFIX_OFFSET, 16, 4,
+				     nfc->reg_base, MAX_DUMP_REGS, false);
+	}
+
+	return ret;
+}
+
+static int ls1x_nand_read_status_exec(struct nand_chip *chip,
+				      const struct nand_subop *subop)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	int val, ret;
+
+	ls1x_nand_set_controller(chip, subop, CMD_STATUS);
+
+	ret = ls1x_nand_wait_for_op_done(nfc);
+	if (ret) {
+		dev_err(ls1x->dev, "CMD_STATUS failed! %d\n", ret);
+		return ret;
+	}
+
+	val = nand_readl(nfc, NAND_IDH_STATUS) & ~nfc->data->status_field;
+	nfc->buf[0] = val << ffs(nfc->data->status_field);
+
+	return ret;
+}
+
+static const struct nand_op_parser ls1x_nand_op_parser = NAND_OP_PARSER(
+	NAND_OP_PARSER_PATTERN(
+		ls1x_nand_reset_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN(
+		ls1x_nand_read_id_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
+	NAND_OP_PARSER_PATTERN(
+		ls1x_nand_erase_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN(
+		ls1x_nand_read_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 0)),
+	NAND_OP_PARSER_PATTERN(
+		ls1x_nand_write_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 0),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN(
+		ls1x_nand_read_status_exec,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
+	);
+
+static int ls1x_nand_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op, bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &ls1x_nand_op_parser, op,
+				      check_only);
+}
+
+static int ls1x_nand_attach_chip(struct nand_chip *chip)
+{
+	struct ls1x_nand *ls1x = nand_get_controller_data(chip);
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	u64 chipsize = nanddev_target_size(&chip->base);
+	int cell_size = 0;
+
+	switch (chipsize) {
+	case SZ_128M:
+		cell_size = 0x0;
+		break;
+	case SZ_256M:
+		cell_size = 0x1;
+		break;
+	case SZ_512M:
+		cell_size = 0x2;
+		break;
+	case SZ_1G:
+		cell_size = 0x3;
+		break;
+	case SZ_2G:
+		cell_size = 0x4;
+		break;
+	case SZ_4G:
+		cell_size = 0x5;
+		break;
+	case (SZ_2G * SZ_4G):	/* 8G */
+		cell_size = 0x6;
+		break;
+	case (SZ_4G * SZ_4G):	/* 16G */
+		cell_size = 0x7;
+		break;
+	default:
+		dev_err(ls1x->dev, "unsupported chip size: %llu MB\n",
+			chipsize);
+		break;
+	}
+
+	/* Set cell size */
+	regmap_update_bits(nfc->regmap, NAND_PARAM, CELL_SIZE_MASK,
+			   FIELD_PREP(CELL_SIZE_MASK, cell_size));
+
+	regmap_update_bits(nfc->regmap, NAND_TIMING, HOLD_CYCLE_MASK,
+			   FIELD_PREP(HOLD_CYCLE_MASK, nfc->data->hold_cycle));
+	regmap_update_bits(nfc->regmap, NAND_TIMING, WAIT_CYCLE_MASK,
+			   FIELD_PREP(WAIT_CYCLE_MASK, nfc->data->wait_cycle));
+
+	chip->ecc.read_page_raw = nand_monolithic_read_page_raw;
+	chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
+	chip->options |= NAND_MONOLITHIC_READ;
+
+	return 0;
+}
+
+static const struct nand_controller_ops ls1x_nfc_ops = {
+	.exec_op = ls1x_nand_exec_op,
+	.attach_chip = ls1x_nand_attach_chip,
+};
+
+static void ls1x_nand_controller_cleanup(struct ls1x_nand *ls1x)
+{
+	if (ls1x->nfc.dma_chan)
+		dma_release_channel(ls1x->nfc.dma_chan);
+}
+
+static int ls1x_nand_controller_init(struct ls1x_nand *ls1x,
+				     struct platform_device *pdev)
+{
+	struct ls1x_nfc *nfc = &ls1x->nfc;
+	struct dma_slave_config cfg;
+	int ret;
+
+	nfc->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(nfc->reg_base))
+		return PTR_ERR(nfc->reg_base);
+
+	nfc->regmap = devm_regmap_init_mmio(ls1x->dev, nfc->reg_base,
+					    &ls1x_nand_regmap_config);
+	if (IS_ERR(nfc->regmap))
+		return dev_err_probe(ls1x->dev, PTR_ERR(nfc->regmap),
+				     "failed to init regmap\n");
+
+	nfc->dma_chan = dma_request_chan(ls1x->dev, "rxtx");
+	if (IS_ERR(nfc->dma_chan))
+		return dev_err_probe(ls1x->dev, PTR_ERR(nfc->dma_chan),
+				     "failed to request DMA channel\n");
+	dev_info(ls1x->dev, "got %s for %s access\n",
+		 dma_chan_name(nfc->dma_chan), dev_name(ls1x->dev));
+
+	cfg.src_addr = CPHYSADDR(nfc->reg_base + NAND_DMA_ADDR);
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr = CPHYSADDR(nfc->reg_base + NAND_DMA_ADDR);
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret = dmaengine_slave_config(nfc->dma_chan, &cfg);
+	if (ret) {
+		dev_err(ls1x->dev, "failed to config DMA channel\n");
+		dma_release_channel(nfc->dma_chan);
+		return ret;
+	}
+
+	init_completion(&nfc->dma_complete);
+
+	return 0;
+}
+
+static int ls1x_nand_chip_init(struct ls1x_nand *ls1x)
+{
+	int nchips = of_get_child_count(ls1x->dev->of_node);
+	struct device_node *chip_np;
+	struct nand_chip *chip = &ls1x->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int ret = 0;
+
+	if (nchips != 1)
+		return dev_err_probe(ls1x->dev, -EINVAL,
+				     "Currently one NAND chip supported\n");
+
+	chip_np = of_get_next_child(ls1x->dev->of_node, NULL);
+	if (!chip_np)
+		return dev_err_probe(ls1x->dev, -ENODEV,
+				     "failed to get child node for NAND chip\n");
+
+	chip->controller = &ls1x->controller;
+	chip->options = NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA | NAND_BROKEN_XD;
+	chip->buf_align = 4;
+	nand_set_controller_data(chip, ls1x);
+	nand_set_flash_node(chip, chip_np);
+
+	mtd->dev.parent = ls1x->dev;
+	mtd->name = "ls1x-nand";
+	mtd->owner = THIS_MODULE;
+
+	ret = nand_scan(chip, 1);
+	if (ret) {
+		of_node_put(chip_np);
+		return ret;
+	}
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret) {
+		dev_err(ls1x->dev, "failed to register MTD device! %d\n", ret);
+		nand_cleanup(chip);
+		of_node_put(chip_np);
+	}
+
+	return ret;
+}
+
+static int ls1x_nand_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct ls1x_nfc_data *data;
+	struct ls1x_nand *ls1x;
+	int ret;
+
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -ENODEV;
+
+	ls1x = devm_kzalloc(dev, sizeof(*ls1x), GFP_KERNEL);
+	if (!ls1x)
+		return -ENOMEM;
+
+	ls1x->nfc.data = data;
+	ls1x->dev = dev;
+	ls1x->controller.ops = &ls1x_nfc_ops;
+	nand_controller_init(&ls1x->controller);
+
+	ret = ls1x_nand_controller_init(ls1x, pdev);
+	if (ret)
+		return ret;
+
+	ret = ls1x_nand_chip_init(ls1x);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(pdev, ls1x);
+
+	return 0;
+err:
+	ls1x_nand_controller_cleanup(ls1x);
+	return ret;
+}
+
+static int ls1x_nand_remove(struct platform_device *pdev)
+{
+	struct ls1x_nand *ls1x = platform_get_drvdata(pdev);
+	struct nand_chip *chip = &ls1x->chip;
+	int ret;
+
+	ret = mtd_device_unregister(nand_to_mtd(chip));
+	WARN_ON(ret);
+	nand_cleanup(chip);
+	ls1x_nand_controller_cleanup(ls1x);
+
+	return 0;
+}
+
+static const struct ls1x_nfc_data ls1b_nfc_data = {
+	.status_field = GENMASK(15, 8),
+	.hold_cycle = 0x2,
+	.wait_cycle = 0xc,
+	.parse_address = ls1b_nand_parse_address,
+};
+
+static const struct ls1x_nfc_data ls1c_nfc_data = {
+	.status_field = GENMASK(23, 16),
+	.op_scope_field = GENMASK(29, 16),
+	.hold_cycle = 0x2,
+	.wait_cycle = 0xc,
+	.parse_address = ls1c_nand_parse_address,
+};
+
+static const struct of_device_id ls1x_nfc_match[] = {
+	{ .compatible = "loongson,ls1b-nfc", .data = &ls1b_nfc_data },
+	{ .compatible = "loongson,ls1c-nfc", .data = &ls1c_nfc_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_nfc_match);
+
+static struct platform_driver ls1x_nand_driver = {
+	.probe	= ls1x_nand_probe,
+	.remove	= ls1x_nand_remove,
+	.driver	= {
+		.name	= KBUILD_MODNAME,
+		.of_match_table = ls1x_nfc_match,
+	},
+};
+
+module_platform_driver(ls1x_nand_driver);
+
+MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson-1 NAND Controller driver");
+MODULE_LICENSE("GPL");

-- 
2.40.1



