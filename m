Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA917D83AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbjJZNfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345077AbjJZNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:35:22 -0400
Received: from esa1.ltts.com (unknown [118.185.121.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB5187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:35:18 -0700 (PDT)
IronPort-SDR: 8SJlcqG/WhpyVhqK/cnMZpNSLkskJC72hAEHjwscBdadI7+pf6z/p6novecvRq8ekwGcnHDzIe
 Z4VluSXqeMcg==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa1.ltts.com with ESMTP; 26 Oct 2023 19:04:04 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     linux-kernel@vger.kernel.org
Cc:     lee@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Subject: [PATCH v1 3/3] drivers: misc: Add support for TPS65224 pfsm driver
Date:   Thu, 26 Oct 2023 19:02:26 +0530
Message-Id: <20231026133226.290040-4-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
References: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

Added support for pmic nvm set FSM_I2C_TRIGGER functions driver,
state control driver, Makefile and Kconfig

Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
---
 drivers/misc/Kconfig               |  12 ++
 drivers/misc/Makefile              |   1 +
 drivers/misc/tps65224-pfsm.c       | 290 +++++++++++++++++++++++++++++
 include/uapi/linux/tps65224_pfsm.h |  36 ++++
 4 files changed, 339 insertions(+)
 create mode 100644 drivers/misc/tps65224-pfsm.c
 create mode 100644 include/uapi/linux/tps65224_pfsm.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index cadd4a820c03..6d12404b0fa6 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -562,6 +562,18 @@ config TPS6594_PFSM
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps6594-pfsm.
 
+config TPS65224_PFSM
+		tristate "TI TPS65224 Pre-configurable Finite State Machine support"
+		depends on MFD_TPS65224
+		default MFD_TPS65224
+		help
+		  Support PFSM (Pre-configurable Finite State Machine) on TPS65224 PMIC devices.
+		  These devices integrate a finite state machine engine, which manages the state
+		  of the device during operating state transition.
+
+		  This driver can also be built as a module.  If so, the module
+		  will be called tps65224-pfsm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f2a4d1ff65d4..49dcacc19529 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
 obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
+obj-$(CONFIG_TPS65224_PFSM)     += tps65224-pfsm.o
diff --git a/drivers/misc/tps65224-pfsm.c b/drivers/misc/tps65224-pfsm.c
new file mode 100644
index 000000000000..734cfa8c8393
--- /dev/null
+++ b/drivers/misc/tps65224-pfsm.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PFSM (Pre-configurable Finite State Machine) driver for TI TPS65224 PMIC
+ *
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Based on the TPS6594 Pre-configurable Finite State Machine Driver by
+ * Julien Panis <jpanis@baylibre.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/tps65224.h>
+
+#include <linux/tps65224_pfsm.h>
+
+#define TPS65224_STARTUP_DEST_MCU_ONLY_VAL 2
+#define TPS65224_STARTUP_DEST_ACTIVE_VAL   3
+#define TPS65224_STARTUP_DEST_SHIFT	  5
+#define TPS65224_STARTUP_DEST_MCU_ONLY	  (TPS65224_STARTUP_DEST_MCU_ONLY_VAL \
+					   << TPS65224_STARTUP_DEST_SHIFT)
+#define TPS65224_STARTUP_DEST_ACTIVE	  (TPS65224_STARTUP_DEST_ACTIVE_VAL \
+					   << TPS65224_STARTUP_DEST_SHIFT)
+
+/*
+ * To update the PMIC firmware, the user must be able to access
+ * page 0 (user registers) and page 1 (NVM control and configuration).
+ */
+#define TPS65224_PMIC_MAX_POS 0x200
+
+#define TPS65224_FILE_TO_PFSM(f) container_of((f)->private_data, struct tps65224_pfsm, miscdev)
+
+/**
+ * struct tps65224_pfsm - device private data structure
+ *
+ * @miscdev: misc device infos
+ * @regmap:  regmap for accessing the device registers
+ */
+struct tps65224_pfsm {
+	struct miscdevice miscdev;
+	struct regmap *regmap;
+};
+
+static ssize_t tps65224_pfsm_read(struct file *f, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct tps65224_pfsm *pfsm = TPS65224_FILE_TO_PFSM(f);
+	loff_t pos = *ppos;
+	unsigned int val;
+	int ret;
+	int i;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= TPS65224_PMIC_MAX_POS)
+		return 0;
+	if (count > TPS65224_PMIC_MAX_POS - pos)
+		count = TPS65224_PMIC_MAX_POS - pos;
+
+	for (i = 0 ; i < count ; i++) {
+		ret = regmap_read(pfsm->regmap, pos + i, &val);
+		if (ret)
+			return ret;
+
+		if (put_user(val, buf + i))
+			return -EFAULT;
+	}
+
+	*ppos = pos + count;
+
+	return count;
+}
+
+static ssize_t tps65224_pfsm_write(struct file *f, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct tps65224_pfsm *pfsm = TPS65224_FILE_TO_PFSM(f);
+	loff_t pos = *ppos;
+	char val;
+	int ret;
+	int i;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= TPS65224_PMIC_MAX_POS || !count)
+		return 0;
+	if (count > TPS65224_PMIC_MAX_POS - pos)
+		count = TPS65224_PMIC_MAX_POS - pos;
+
+	for (i = 0 ; i < count ; i++) {
+		if (get_user(val, buf + i))
+			return -EFAULT;
+
+		ret = regmap_write(pfsm->regmap, pos + i, val);
+		if (ret)
+			return ret;
+	}
+
+	*ppos = pos + count;
+
+	return count;
+}
+
+static int tps65224_pfsm_configure_ret_trig(struct regmap *regmap, u8 gpio_ret, u8 ddr_ret)
+{
+	int ret;
+
+	if (gpio_ret)
+		ret = regmap_set_bits(regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
+					TPS65224_BIT_TRIGGER_I2C(5) | TPS65224_BIT_TRIGGER_I2C(6));
+	else
+		ret = regmap_clear_bits(regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
+					TPS65224_BIT_TRIGGER_I2C(5) | TPS65224_BIT_TRIGGER_I2C(6));
+	if (ret)
+		return ret;
+
+	if (ddr_ret)
+		ret = regmap_set_bits(regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
+					  TPS65224_BIT_TRIGGER_I2C(7));
+	else
+		ret = regmap_clear_bits(regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
+					TPS65224_BIT_TRIGGER_I2C(7));
+
+	return ret;
+}
+
+static long tps65224_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct tps65224_pfsm *pfsm = TPS65224_FILE_TO_PFSM(f);
+	struct pmic_state_opt state_opt;
+	void __user *argp = (void __user *)arg;
+	int ret = -ENOIOCTLCMD;
+
+	switch (cmd) {
+	case PMIC_GOTO_STANDBY:
+		/* Force trigger */
+		ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
+					TPS65224_BIT_TRIGGER_I2C(0), TPS65224_BIT_TRIGGER_I2C(0));
+		break;
+	case PMIC_UPDATE_PGM:
+		/* Force trigger */
+		ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_FSM_I2C_TRIGGERS,
+					TPS65224_BIT_TRIGGER_I2C(3), TPS65224_BIT_TRIGGER_I2C(3));
+		break;
+	case PMIC_SET_ACTIVE_STATE:
+		/* Modify NSLEEP1-2 bits */
+		ret = regmap_set_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
+					  TPS65224_BIT_NSLEEP1B | TPS65224_BIT_NSLEEP2B);
+		break;
+	case PMIC_SET_MCU_ONLY_STATE:
+		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
+			return -EFAULT;
+
+		/* Configure retention triggers */
+		ret = tps65224_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
+							  state_opt.ddr_retention);
+		if (ret)
+			return ret;
+
+		/* Modify NSLEEP1-2 bits */
+		ret = regmap_clear_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
+					TPS65224_BIT_NSLEEP1B);
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
+					  TPS65224_BIT_NSLEEP2B);
+		break;
+	case PMIC_SET_RETENTION_STATE:
+		if (copy_from_user(&state_opt, argp, sizeof(state_opt)))
+			return -EFAULT;
+
+		/* Configure wake-up destination */
+		if (state_opt.mcu_only_startup_dest)
+			ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_CONFIG_2,
+						TPS65224_BIT_STARTUP_INT,
+						TPS65224_STARTUP_DEST_MCU_ONLY);
+		else
+			ret = regmap_write_bits(pfsm->regmap, TPS65224_REG_CONFIG_2,
+						TPS65224_BIT_STARTUP_INT,
+						TPS65224_STARTUP_DEST_ACTIVE);
+		if (ret)
+			return ret;
+
+		/* Configure retention triggers */
+		ret = tps65224_pfsm_configure_ret_trig(pfsm->regmap, state_opt.gpio_retention,
+							  state_opt.ddr_retention);
+		if (ret)
+			return ret;
+
+		/* Modify NSLEEP1-2 bits */
+		ret = regmap_clear_bits(pfsm->regmap, TPS65224_REG_FSM_NSLEEP_TRIGGERS,
+					TPS65224_BIT_NSLEEP2B);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations tps65224_pfsm_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= generic_file_llseek,
+	.read		= tps65224_pfsm_read,
+	.write		= tps65224_pfsm_write,
+	.unlocked_ioctl	= tps65224_pfsm_ioctl,
+	.compat_ioctl   = compat_ptr_ioctl,
+};
+
+static irqreturn_t tps65224_pfsm_isr(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	int i;
+
+	for (i = 0 ; i < pdev->num_resources ; i++) {
+		if (irq == platform_get_irq_byname(pdev, pdev->resource[i].name)) {
+			dev_info(pdev->dev.parent, "%s event detected\n", pdev->resource[i].name);
+			return IRQ_HANDLED;
+		}
+	}
+
+	return IRQ_NONE;
+}
+
+static int tps65224_pfsm_probe(struct platform_device *pdev)
+{
+	struct tps65224_pfsm *pfsm;
+	struct tps65224 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	int irq;
+	int ret;
+	int i;
+
+	pfsm = devm_kzalloc(dev, sizeof(struct tps65224_pfsm), GFP_KERNEL);
+	if (!pfsm)
+		return -ENOMEM;
+
+	pfsm->regmap = tps->regmap;
+
+	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
+	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
+						tps->chip_id, tps->reg);
+	pfsm->miscdev.fops = &tps65224_pfsm_fops;
+	pfsm->miscdev.parent = dev->parent;
+
+	for (i = 0 ; i < pdev->num_resources ; i++) {
+		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
+		if (irq < 0)
+			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
+						 pdev->resource[i].name);
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						tps65224_pfsm_isr, IRQF_ONESHOT,
+						pdev->resource[i].name, pdev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request irq\n");
+	}
+
+	platform_set_drvdata(pdev, pfsm);
+
+	return misc_register(&pfsm->miscdev);
+}
+
+static void tps65224_pfsm_remove(struct platform_device *pdev)
+{
+	struct tps65224_pfsm *pfsm = platform_get_drvdata(pdev);
+
+	misc_deregister(&pfsm->miscdev);
+}
+
+static struct platform_driver tps65224_pfsm_driver = {
+	.driver	= {
+		.name = "tps65224-pfsm",
+	},
+	.probe = tps65224_pfsm_probe,
+	.remove_new = tps65224_pfsm_remove,
+};
+
+module_platform_driver(tps65224_pfsm_driver);
+
+MODULE_ALIAS("platform:tps65224-pfsm");
+MODULE_AUTHOR("Gairuboina Sirisha <sirisha.gairuboina@ltts.com>");
+MODULE_DESCRIPTION("TPS65224 Pre-configurable Finite State Machine Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/tps65224_pfsm.h b/include/uapi/linux/tps65224_pfsm.h
new file mode 100644
index 000000000000..c0a135903b5d
--- /dev/null
+++ b/include/uapi/linux/tps65224_pfsm.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace ABI for TPS65224 PMIC Pre-configurable Finite State Machine
+ *
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __TPS65224_PFSM_H
+#define __TPS65224_PFSM_H
+
+#include <linux/const.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct pmic_state_opt - PMIC state options
+ * @gpio_retention: if enabled, power rails associated with GPIO retention remain active
+ * @ddr_retention: if enabled, power rails associated with DDR retention remain active
+ * @mcu_only_startup_dest: if enabled, startup destination state is MCU_ONLY
+ */
+struct pmic_state_opt {
+	__u8 gpio_retention;
+	__u8 ddr_retention;
+	__u8 mcu_only_startup_dest;
+};
+
+/* Commands */
+#define PMIC_BASE			'P'
+
+#define PMIC_GOTO_STANDBY		_IO(PMIC_BASE, 0)
+#define PMIC_UPDATE_PGM			_IO(PMIC_BASE, 1)
+#define PMIC_SET_ACTIVE_STATE		_IO(PMIC_BASE, 2)
+#define PMIC_SET_MCU_ONLY_STATE		_IOW(PMIC_BASE, 3, struct pmic_state_opt)
+#define PMIC_SET_RETENTION_STATE	_IOW(PMIC_BASE, 4, struct pmic_state_opt)
+
+#endif /*  __TPS65224_PFSM_H */
-- 
2.34.1

