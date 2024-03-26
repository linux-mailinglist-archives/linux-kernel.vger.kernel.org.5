Return-Path: <linux-kernel+bounces-118654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1388BDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFA62E6DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4690129E68;
	Tue, 26 Mar 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWnGmt32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC646D1A9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=YwXHodYNOU0j5ANu2vEaJc9Ena6LkWRA8gkTWOEpAvM+eLlLvNgKZc7vzw61BW5EwjuRyh1iXqqbE4KPY+TueF6MGDOkEUmk27Bie+KEN10mjj9hZHtK5ZOlrRykVfUlZjznUlirtNs1Ul2Enduy9lKCQf/OOyC88eaSAJQzv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=xLXssePJaiQf3nWd7+yYKdHgW8yDiYvcVqY/wx22wok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fd5GMWDE5B7UC1/W1L9G83niRb+Xwf/qKX7Xih8sRTqKG13awlVfbz9iyQB7AJ7RpJF8B3/VfLIotwcodG97g0tsWd7xC7NghjzetG8t2Mn0G76wu0uYpcAueJJi8im0xnmEIvR0etA7FAQJoSv3RvYswhgZMv5aoAldzsRjjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWnGmt32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E99C433C7;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444842;
	bh=xLXssePJaiQf3nWd7+yYKdHgW8yDiYvcVqY/wx22wok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dWnGmt32YLmdeNgmERFOALcPIxNbB65iKm6mixEpZYhEFppbzNNHfLpinNpUTWe5Y
	 EIFgGV0OuA79yZr2eKHn2RfrIIrkcgdmrtAbGi55m9aEz7LQHnKQjZ7X59DsYSICI6
	 i2DPXRppggdOczFpBIPLWbPoSnCuDaPTm6P2JdJtNqDmU9UzD0d5GY20EVStWef8Af
	 bPED71/uVGxJDIU4h3ZBCU55oe1hZxTVg5pWWRmxHJ0I9hxl8PTdLnxfOIR4nw4ioJ
	 KbGSE+MDBhcTN5Y1K42yq9WnWM/3Gn97sia0IZJFDqLsOwIXKmMRp/lEq8Aq2NNE4R
	 A+ZovcA8SAfWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FECD1283;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:18:46 +0300
Subject: [PATCH v9 19/38] mtd: rawnand: add support for ts72xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-19-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Christophe Kerello <christophe.kerello@foss.st.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Johan Jonker <jbx6244@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=8042;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=HVE3SdBS2+n0q9LVXiySqSz0+0Be2JSY+pWAYbvzc1g=;
 b=gUsrLjKFHn3EhvKvW2WwQmhf3LMkkLAOjgNEhvevz8NUKCLAQxFD4WBu9Xa8o/zfzCKBnSiTQnKn
 xWtDsKZ9C1msCPBIS+atQQJTkWf6eAq0Sa/2321ZE7r8Z6Sp89KT
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Technologic Systems has it's own nand controller implementation in CPLD.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/mtd/nand/raw/Kconfig                       |   6 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/technologic-nand-controller.c | 222 +++++++++++++++++++++
 3 files changed, 229 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index cbf8ae85e1ae..5a51b835f6b6 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -449,6 +449,12 @@ config MTD_NAND_RENESAS
 	  Enables support for the NAND controller found on Renesas R-Car
 	  Gen3 and RZ/N1 SoC families.
 
+config MTD_NAND_TS72XX
+	tristate "ts72xx NAND controller"
+	depends on ARCH_EP93XX && HAS_IOMEM
+	help
+	  Enables support for NAND controller on ts72xx SBCs.
+
 comment "Misc"
 
 config MTD_SM_COMMON
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 25120a4afada..d0b0e6b83568 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MTD_NAND_MLC_LPC32XX)      += lpc32xx_mlc.o
 obj-$(CONFIG_MTD_NAND_SH_FLCTL)		+= sh_flctl.o
 obj-$(CONFIG_MTD_NAND_MXC)		+= mxc_nand.o
 obj-$(CONFIG_MTD_NAND_SOCRATES)		+= socrates_nand.o
+obj-$(CONFIG_MTD_NAND_TS72XX)           += technologic-nand-controller.o
 obj-$(CONFIG_MTD_NAND_TXX9NDFMC)	+= txx9ndfmc.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
 obj-$(CONFIG_MTD_NAND_VF610_NFC)	+= vf610_nfc.o
diff --git a/drivers/mtd/nand/raw/technologic-nand-controller.c b/drivers/mtd/nand/raw/technologic-nand-controller.c
new file mode 100644
index 000000000000..0e45a6fd91dd
--- /dev/null
+++ b/drivers/mtd/nand/raw/technologic-nand-controller.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Technologic Systems TS72xx NAND controller driver
+ *
+ * Copyright (C) 2023 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Derived from: plat_nand.c
+ *  Author: Vitaly Wool <vitalywool@gmail.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/platnand.h>
+
+#define TS72XX_NAND_CONTROL_ADDR_LINE	BIT(22)	/* 0xN0400000 */
+#define TS72XX_NAND_BUSY_ADDR_LINE	BIT(23)	/* 0xN0800000 */
+
+#define TS72XX_NAND_ALE			BIT(0)
+#define TS72XX_NAND_CLE			BIT(1)
+#define TS72XX_NAND_NCE			BIT(2)
+
+#define TS72XX_NAND_CTRL_CLE		(TS72XX_NAND_NCE | TS72XX_NAND_CLE)
+#define TS72XX_NAND_CTRL_ALE		(TS72XX_NAND_NCE | TS72XX_NAND_ALE)
+
+struct ts72xx_nand_data {
+	struct nand_controller	controller;
+	struct nand_chip	chip;
+	void __iomem		*base;
+	void __iomem		*ctrl;
+	void __iomem		*busy;
+};
+
+static inline struct ts72xx_nand_data *chip_to_ts72xx(struct nand_chip *chip)
+{
+	return container_of(chip, struct ts72xx_nand_data, chip);
+}
+
+static int ts72xx_nand_attach_chip(struct nand_chip *chip)
+{
+	switch (chip->ecc.engine_type) {
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		return -EINVAL;
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+		if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
+			chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
+		chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
+		fallthrough;
+	default:
+		return 0;
+	}
+}
+
+static void ts72xx_nand_ctrl(struct nand_chip *chip, u8 value)
+{
+	struct ts72xx_nand_data *data = chip_to_ts72xx(chip);
+	unsigned char bits = ioread8(data->ctrl) & ~GENMASK(2, 0);
+
+	iowrite8(bits | value, data->ctrl);
+}
+
+static int ts72xx_nand_exec_instr(struct nand_chip *chip,
+				const struct nand_op_instr *instr)
+{
+	struct ts72xx_nand_data *data = chip_to_ts72xx(chip);
+	unsigned int timeout_us;
+	u32 status;
+	int ret;
+
+	switch (instr->type) {
+	case NAND_OP_CMD_INSTR:
+		ts72xx_nand_ctrl(chip, TS72XX_NAND_CTRL_CLE);
+		iowrite8(instr->ctx.cmd.opcode, data->base);
+		ts72xx_nand_ctrl(chip, TS72XX_NAND_NCE);
+		break;
+
+	case NAND_OP_ADDR_INSTR:
+		ts72xx_nand_ctrl(chip, TS72XX_NAND_CTRL_ALE);
+		iowrite8_rep(data->base, instr->ctx.addr.addrs, instr->ctx.addr.naddrs);
+		ts72xx_nand_ctrl(chip, TS72XX_NAND_NCE);
+		break;
+
+	case NAND_OP_DATA_IN_INSTR:
+		ioread8_rep(data->base, instr->ctx.data.buf.in, instr->ctx.data.len);
+		break;
+
+	case NAND_OP_DATA_OUT_INSTR:
+		iowrite8_rep(data->base, instr->ctx.data.buf.in, instr->ctx.data.len);
+		break;
+
+	case NAND_OP_WAITRDY_INSTR:
+		timeout_us = instr->ctx.waitrdy.timeout_ms * 1000;
+		ret = readb_poll_timeout(data->busy, status, status & BIT(5), 0, timeout_us);
+		if (ret)
+			return ret;
+
+		break;
+	}
+
+	if (instr->delay_ns)
+		ndelay(instr->delay_ns);
+
+	return 0;
+}
+
+static int ts72xx_nand_exec_op(struct nand_chip *chip,
+			       const struct nand_operation *op, bool check_only)
+{
+	unsigned int i;
+	int ret;
+
+	if (check_only)
+		return 0;
+
+	for (i = 0; i < op->ninstrs; i++) {
+		ret = ts72xx_nand_exec_instr(chip, &op->instrs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct nand_controller_ops ts72xx_nand_ops = {
+	.attach_chip = ts72xx_nand_attach_chip,
+	.exec_op = ts72xx_nand_exec_op,
+};
+
+static int ts72xx_nand_probe(struct platform_device *pdev)
+{
+	struct ts72xx_nand_data *data;
+	struct fwnode_handle *child;
+	struct mtd_info *mtd;
+	int err;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	nand_controller_init(&data->controller);
+	data->controller.ops = &ts72xx_nand_ops;
+	data->chip.controller = &data->controller;
+
+	data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+	data->ctrl = data->base + TS72XX_NAND_CONTROL_ADDR_LINE;
+	data->busy = data->base + TS72XX_NAND_BUSY_ADDR_LINE;
+
+	child = fwnode_get_next_child_node(dev_fwnode(&pdev->dev), NULL);
+	if (!child)
+		return dev_err_probe(&pdev->dev, -ENXIO,
+				"ts72xx controller node should have exactly one child\n");
+
+	nand_set_flash_node(&data->chip, to_of_node(child));
+	mtd = nand_to_mtd(&data->chip);
+	mtd->dev.parent = &pdev->dev;
+	platform_set_drvdata(pdev, data);
+
+	/*
+	 * This driver assumes that the default ECC engine should be TYPE_SOFT.
+	 * Set ->engine_type before registering the NAND devices in order to
+	 * provide a driver specific default value.
+	 */
+	data->chip.ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
+
+	/* Scan to find existence of the device */
+	err = nand_scan(&data->chip, 1);
+	if (err)
+		goto err_handle_put;
+
+	err = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
+	if (err)
+		goto err_clean_nand;
+
+	return 0;
+
+err_clean_nand:
+	nand_cleanup(&data->chip);
+err_handle_put:
+	fwnode_handle_put(child);
+	return err;
+}
+
+static void ts72xx_nand_remove(struct platform_device *pdev)
+{
+	struct ts72xx_nand_data *data = platform_get_drvdata(pdev);
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
+	struct nand_chip *chip = &data->chip;
+	int ret;
+
+	ret = mtd_device_unregister(nand_to_mtd(chip));
+	WARN_ON(ret);
+	nand_cleanup(chip);
+	fwnode_handle_put(fwnode);
+}
+
+static const struct of_device_id ts72xx_id_table[] = {
+	{ .compatible = "technologic,ts7200-nand" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ts72xx_id_table);
+
+static struct platform_driver ts72xx_nand_driver = {
+	.driver = {
+		.name = "ts72xx-nand",
+		.of_match_table = ts72xx_id_table,
+	},
+	.probe = ts72xx_nand_probe,
+	.remove_new = ts72xx_nand_remove,
+};
+module_platform_driver(ts72xx_nand_driver);
+
+MODULE_AUTHOR("Nikita Shubin <nikita.shubin@maquefel.me>");
+MODULE_DESCRIPTION("Technologic Systems TS72xx NAND controller driver");
+MODULE_LICENSE("GPL");

-- 
2.41.0



