Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D17A184D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjIOINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjIOIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A61B272E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EF84C116B7;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765529;
        bh=V5cT8w/it6AYQY7TM8YSBEIif9lzHS3lBvQTxXfSyl8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=ij5yIb4q8Qg1Z0yQiMVdmlSbWp/MebKzLOE9ZsJb+7yTMOtl81wvsQmayHWotoQVh
         Pnf/KAsovkGfeV17NEtLTgmSZc7FXXP1csLMGfMZYWDks4prbYn/H2HsCONnbOljRt
         58LM6TIsPphAYONChPvulxrCiY6b5zhZihy87IlngjC6UgWoP7joFJAD64TZS1qtO4
         xC9iIksw7NKFnXzVZHPD6xklbJ18h0dtOH76AMkuaHT5NCFPUMcqZlqJAuhhKS2bV5
         uc1MNjwS1kDa39G+xCVMjhl3t8fyL7h35RzOOYIf6N5N6ifJ23vH7K7KEXEHmhpzNH
         zqf/q1RA8HcBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 8B932EE6437;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:11:08 +0300
Subject: [PATCH v4 26/42] mtd: nand: add support for ts72xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-26-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Jean Delvare <jdelvare@suse.de>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=6323;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=tSpBJ59+Iw32o4rXq2osMjNSaAJZ3FryqT93kJ87E8o=; =?utf-8?q?b=3DdUvTXogVTx6p?=
 =?utf-8?q?IFqteZboakCpFMv63iFCZOG5WICxfexogrwVUcH+AJMP2JaemOk46n03M9UhYHai?=
 09+A7iVACfG7DjfXu5bSu5t9rSYbppWZDfyQ5ZgfWPO0xULoY9SN
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Technologic Systems has it's own nand controller implementation in CPLD.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/mtd/nand/raw/Kconfig                       |   7 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/technologic-nand-controller.c | 166 +++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b523354dfb00..94788da1a169 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -456,6 +456,13 @@ config MTD_NAND_RENESAS
 	  Enables support for the NAND controller found on Renesas R-Car
 	  Gen3 and RZ/N1 SoC families.
 
+config MTD_NAND_TS72XX
+	bool "ts72xx NAND controller"
+	depends on ARCH_EP93XX && HAS_IOMEM
+	help
+	  Enables support for NAND controller on ts72xx SBCs.
+	  This is a legacy driver based on gen_nand.
+
 comment "Misc"
 
 config MTD_SM_COMMON
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index d93e861d8ba7..b85161c3296b 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -23,6 +23,7 @@ omap2_nand-objs := omap2.o
 obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_MARVELL)		+= marvell_nand.o
+obj-$(CONFIG_MTD_NAND_TS72XX)		+= technologic-nand-controller.o
 obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
 obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
diff --git a/drivers/mtd/nand/raw/technologic-nand-controller.c b/drivers/mtd/nand/raw/technologic-nand-controller.c
new file mode 100644
index 000000000000..02430ed1e896
--- /dev/null
+++ b/drivers/mtd/nand/raw/technologic-nand-controller.c
@@ -0,0 +1,166 @@
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
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/platnand.h>
+
+#define TS72XX_NAND_CONTROL_ADDR_LINE	22	/* 0xN0400000 */
+#define TS72XX_NAND_BUSY_ADDR_LINE	23	/* 0xN0800000 */
+
+struct ts72xx_nand_data {
+	struct nand_controller	controller;
+	struct nand_chip	chip;
+	void __iomem		*io_base;
+};
+
+static int ts72xx_nand_attach_chip(struct nand_chip *chip)
+{
+	switch (chip->ecc.engine_type) {
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+		if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
+			chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
+		break;
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		return -EINVAL;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct nand_controller_ops ts72xx_nand_ops = {
+	.attach_chip = ts72xx_nand_attach_chip,
+};
+
+static void ts72xx_nand_hwcontrol(struct nand_chip *chip,
+				  int cmd, unsigned int ctrl)
+{
+	if (ctrl & NAND_CTRL_CHANGE) {
+		void __iomem *addr = chip->legacy.IO_ADDR_R;
+		unsigned char bits;
+
+		addr += BIT(TS72XX_NAND_CONTROL_ADDR_LINE);
+
+		bits = readb(addr) & ~GENMASK(2, 0);
+		bits |= (ctrl & NAND_NCE) << 2;	/* bit 0 -> bit 2 */
+		bits |= (ctrl & NAND_CLE);	/* bit 1 -> bit 1 */
+		bits |= (ctrl & NAND_ALE) >> 2;	/* bit 2 -> bit 0 */
+
+		writeb(bits, addr);
+	}
+
+	if (cmd != NAND_CMD_NONE)
+		writeb(cmd, chip->legacy.IO_ADDR_W);
+}
+
+static int ts72xx_nand_device_ready(struct nand_chip *chip)
+{
+	void __iomem *addr = chip->legacy.IO_ADDR_R;
+
+	addr += BIT(TS72XX_NAND_BUSY_ADDR_LINE);
+
+	return !!(readb(addr) & BIT(5));
+}
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
+	data->controller.ops = &ts72xx_nand_ops;
+	nand_controller_init(&data->controller);
+	data->chip.controller = &data->controller;
+
+	data->io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->io_base))
+		return PTR_ERR(data->io_base);
+
+	child = fwnode_get_next_child_node(dev_fwnode(&pdev->dev), NULL);
+	if (!child)
+		return dev_err_probe(&pdev->dev, -ENXIO,
+				"ts72xx controller node should have exactly one child\n");
+
+	nand_set_flash_node(&data->chip, to_of_node(child));
+	mtd = nand_to_mtd(&data->chip);
+	mtd->dev.parent = &pdev->dev;
+
+	data->chip.legacy.IO_ADDR_R = data->io_base;
+	data->chip.legacy.IO_ADDR_W = data->io_base;
+	data->chip.legacy.cmd_ctrl = ts72xx_nand_hwcontrol;
+	data->chip.legacy.dev_ready = ts72xx_nand_device_ready;
+
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
+	struct nand_chip *chip = &data->chip;
+	int ret;
+
+	ret = mtd_device_unregister(nand_to_mtd(chip));
+	WARN_ON(ret);
+	nand_cleanup(chip);
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

-- 
2.39.2

