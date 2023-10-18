Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2CE7CE5A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbjJRR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjJRR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:58:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC75193;
        Wed, 18 Oct 2023 10:58:03 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39IH9Anl014455;
        Wed, 18 Oct 2023 12:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=ENZnc8a6fyr5gZfSM6sz7BmGVu3ISk6orlXlbf6HEEs=; b=
        XSZa7++Yj/j/aIXVzXp1iThfaCgko1oZe3u16tQrYJCtnMh9j9vh6drY6u6M8Pu5
        8GJm0MSGVAao/NRlSI7rKz7neTxrYen8oleDS8wM302mq3ALRWsngtiVXjllmAvD
        +PBIIPWNaMpVzDtEVbxkBYgFtX6QlOU8C1EmvlTB82AXEe/EK7BmYJwSP9HpbmIV
        4EdGxAhYqXEdEFo/trQeRwToOEWqpf5yHM64+CtQgwEXPnXrpkLfmcOvhRdqeb0S
        TWqvgDZ8YSaoXuTirai1TIBY47K3dGLLC5Dedx/8SySfbtc7T3woYLTgU1ex3fT/
        uJMERKVaHEAsMh0f63quBw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tqqdh50tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 12:57:51 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 18 Oct
 2023 18:57:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 18 Oct 2023 18:57:49 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 024EA458;
        Wed, 18 Oct 2023 17:57:47 +0000 (UTC)
From:   James Ogletree <james.ogletree@opensource.cirrus.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Date:   Wed, 18 Oct 2023 17:57:24 +0000
Message-ID: <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kbUOxU6E4LFaJOa1Z_Xgs-_HyX8sZ39M
X-Proofpoint-ORIG-GUID: kbUOxU6E4LFaJOa1Z_Xgs-_HyX8sZ39M
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Ogletree <james.ogletree@cirrus.com>

Introduce support for Cirrus Logic Device CS40L50: a
haptic driver with waveform memory, integrated DSP,
and closed-loop algorithms.

The MFD component registers and initializes the device.

Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
---
 MAINTAINERS                 |   2 +
 drivers/mfd/Kconfig         |  30 +++
 drivers/mfd/Makefile        |   4 +
 drivers/mfd/cs40l50-core.c  | 443 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/cs40l50-i2c.c   |  69 ++++++
 drivers/mfd/cs40l50-spi.c   |  68 ++++++
 include/linux/mfd/cs40l50.h | 198 ++++++++++++++++
 7 files changed, 814 insertions(+)
 create mode 100644 drivers/mfd/cs40l50-core.c
 create mode 100644 drivers/mfd/cs40l50-i2c.c
 create mode 100644 drivers/mfd/cs40l50-spi.c
 create mode 100644 include/linux/mfd/cs40l50.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 57daf77bf550..08e1e9695d49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4971,7 +4971,9 @@ L:	patches@opensource.cirrus.com
 S:	Supported
 F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
 F:	drivers/input/misc/cirrus*
+F:	drivers/mfd/cs40l*
 F:	include/linux/input/cirrus*
+F:	include/linux/mfd/cs40l*
 
 CIRRUS LOGIC DSP FIRMWARE DRIVER
 M:	Simon Trimmer <simont@opensource.cirrus.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..a133d04a7859 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2187,6 +2187,36 @@ config MCP_UCB1200_TS
 
 endmenu
 
+config MFD_CS40L50_CORE
+	tristate
+	select MFD_CORE
+	select CS_DSP
+	select REGMAP_IRQ
+
+config MFD_CS40L50_I2C
+	tristate "Cirrus Logic CS40L50 (I2C)"
+	select REGMAP_I2C
+	select MFD_CS40L50_CORE
+	depends on I2C
+	help
+	  Select this to support the Cirrus Logic CS40L50 Haptic
+	  Driver over I2C.
+
+	  This driver can be built as a module. If built as a module it will be
+	  called "cs40l50-i2c".
+
+config MFD_CS40L50_SPI
+	tristate "Cirrus Logic CS40L50 (SPI)"
+	select REGMAP_SPI
+	select MFD_CS40L50_CORE
+	depends on SPI
+	help
+	  Select this to support the Cirrus Logic CS40L50 Haptic
+	  Driver over SPI.
+
+	  This driver can be built as a module. If built as a module it will be
+	  called "cs40l50-spi".
+
 config MFD_VEXPRESS_SYSREG
 	tristate "Versatile Express System Registers"
 	depends on VEXPRESS_CONFIG && GPIOLIB
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..3b1a43b3acaf 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -95,6 +95,10 @@ obj-$(CONFIG_MFD_MADERA)	+= madera.o
 obj-$(CONFIG_MFD_MADERA_I2C)	+= madera-i2c.o
 obj-$(CONFIG_MFD_MADERA_SPI)	+= madera-spi.o
 
+obj-$(CONFIG_MFD_CS40L50_CORE)	+= cs40l50-core.o
+obj-$(CONFIG_MFD_CS40L50_I2C)	+= cs40l50-i2c.o
+obj-$(CONFIG_MFD_CS40L50_SPI)	+= cs40l50-spi.o
+
 obj-$(CONFIG_TPS6105X)		+= tps6105x.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_TPS6507X)		+= tps6507x.o
diff --git a/drivers/mfd/cs40l50-core.c b/drivers/mfd/cs40l50-core.c
new file mode 100644
index 000000000000..f1eadd80203a
--- /dev/null
+++ b/drivers/mfd/cs40l50-core.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS40L50 Advanced Haptic Driver with waveform memory,
+ * integrated DSP, and closed-loop algorithms
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/cs40l50.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+static const struct mfd_cell cs40l50_devs[] = {
+	{
+		.name = "cs40l50-vibra",
+	},
+};
+
+const struct regmap_config cs40l50_regmap = {
+	.reg_bits =		32,
+	.reg_stride =		4,
+	.val_bits =		32,
+	.reg_format_endian =	REGMAP_ENDIAN_BIG,
+	.val_format_endian =	REGMAP_ENDIAN_BIG,
+};
+EXPORT_SYMBOL_GPL(cs40l50_regmap);
+
+static struct regulator_bulk_data cs40l50_supplies[] = {
+	{
+		.supply = "vp",
+	},
+	{
+		.supply = "vio",
+	},
+};
+
+static int cs40l50_handle_f0_est_done(struct cs40l50_private *cs40l50)
+{
+	u32 f_zero;
+	int error;
+
+	error = regmap_read(cs40l50->regmap, CS40L50_F0_ESTIMATION, &f_zero);
+	if (error)
+		return error;
+
+	return regmap_write(cs40l50->regmap, CS40L50_F0_STORED, f_zero);
+}
+
+static int cs40l50_handle_redc_est_done(struct cs40l50_private *cs40l50)
+{
+	int error, fractional, integer, stored;
+	u32 redc;
+
+	error = regmap_read(cs40l50->regmap, CS40L50_RE_EST_STATUS, &redc);
+	if (error)
+		return error;
+
+	error = regmap_write(cs40l50->regmap, CS40L50_REDC_ESTIMATION, redc);
+	if (error)
+		return error;
+
+	/* Convert from Q8.15 to (Q7.17 * 29/240) */
+	integer = ((redc >> 15) & 0xFF) << 17;
+	fractional = (redc & 0x7FFF) * 4;
+	stored = (integer | fractional) * 29 / 240;
+
+	return regmap_write(cs40l50->regmap, CS40L50_REDC_STORED, stored);
+}
+
+static int cs40l50_error_release(struct cs40l50_private *cs40l50)
+{
+	int error;
+
+	error = regmap_write(cs40l50->regmap, CS40L50_ERR_RLS,
+			     CS40L50_GLOBAL_ERR_RLS);
+	if (error)
+		return error;
+
+	return regmap_write(cs40l50->regmap, CS40L50_ERR_RLS, 0);
+}
+
+static int cs40l50_mailbox_read_next(struct cs40l50_private *cs40l50, u32 *val)
+{
+	u32 rd_ptr, wt_ptr;
+	int error;
+
+	error = regmap_read(cs40l50->regmap, CS40L50_MBOX_QUEUE_WT, &wt_ptr);
+	if (error)
+		return error;
+
+	error = regmap_read(cs40l50->regmap, CS40L50_MBOX_QUEUE_RD, &rd_ptr);
+	if (error)
+		return error;
+
+	if (wt_ptr == rd_ptr) {
+		*val = 0;
+		return 0;
+	}
+
+	error = regmap_read(cs40l50->regmap, rd_ptr, val);
+	if (error)
+		return error;
+
+	rd_ptr += sizeof(u32);
+	if (rd_ptr > CS40L50_MBOX_QUEUE_END)
+		rd_ptr = CS40L50_MBOX_QUEUE_BASE;
+
+	return regmap_write(cs40l50->regmap, CS40L50_MBOX_QUEUE_RD, rd_ptr);
+}
+
+static irqreturn_t cs40l50_process_mbox(int irq, void *data)
+{
+	struct cs40l50_private *cs40l50 = data;
+	int error = 0;
+	u32 val;
+
+	mutex_lock(&cs40l50->lock);
+
+	while (!cs40l50_mailbox_read_next(cs40l50, &val)) {
+		switch (val) {
+		case 0:
+			mutex_unlock(&cs40l50->lock);
+			dev_dbg(cs40l50->dev, "Reached end of queue\n");
+			return IRQ_HANDLED;
+		case CS40L50_MBOX_HAPTIC_TRIGGER_GPIO:
+			dev_dbg(cs40l50->dev, "Mailbox: TRIGGER_GPIO\n");
+			break;
+		case CS40L50_MBOX_HAPTIC_TRIGGER_MBOX:
+			dev_dbg(cs40l50->dev, "Mailbox: TRIGGER_MBOX\n");
+			break;
+		case CS40L50_MBOX_HAPTIC_TRIGGER_I2S:
+			dev_dbg(cs40l50->dev, "Mailbox: TRIGGER_I2S\n");
+			break;
+		case CS40L50_MBOX_HAPTIC_COMPLETE_MBOX:
+			dev_dbg(cs40l50->dev, "Mailbox: COMPLETE_MBOX\n");
+			break;
+		case CS40L50_MBOX_HAPTIC_COMPLETE_GPIO:
+			dev_dbg(cs40l50->dev, "Mailbox: COMPLETE_GPIO\n");
+			break;
+		case CS40L50_MBOX_HAPTIC_COMPLETE_I2S:
+			dev_dbg(cs40l50->dev, "Mailbox: COMPLETE_I2S\n");
+			break;
+		case CS40L50_MBOX_F0_EST_START:
+			dev_dbg(cs40l50->dev, "Mailbox: F0_EST_START\n");
+			break;
+		case CS40L50_MBOX_F0_EST_DONE:
+			dev_dbg(cs40l50->dev, "Mailbox: F0_EST_DONE\n");
+			error = cs40l50_handle_f0_est_done(cs40l50);
+			if (error)
+				goto out_mutex;
+			break;
+		case CS40L50_MBOX_REDC_EST_START:
+			dev_dbg(cs40l50->dev, "Mailbox: REDC_EST_START\n");
+			break;
+		case CS40L50_MBOX_REDC_EST_DONE:
+			dev_dbg(cs40l50->dev, "Mailbox: REDC_EST_DONE\n");
+			error = cs40l50_handle_redc_est_done(cs40l50);
+			if (error)
+				goto out_mutex;
+			break;
+		case CS40L50_MBOX_LE_EST_START:
+			dev_dbg(cs40l50->dev, "Mailbox: LE_EST_START\n");
+			break;
+		case CS40L50_MBOX_LE_EST_DONE:
+			dev_dbg(cs40l50->dev, "Mailbox: LE_EST_DONE\n");
+			break;
+		case CS40L50_MBOX_AWAKE:
+			dev_dbg(cs40l50->dev, "Mailbox: AWAKE\n");
+			break;
+		case CS40L50_MBOX_INIT:
+			dev_dbg(cs40l50->dev, "Mailbox: INIT\n");
+			break;
+		case CS40L50_MBOX_ACK:
+			dev_dbg(cs40l50->dev, "Mailbox: ACK\n");
+			break;
+		case CS40L50_MBOX_ERR_EVENT_UNMAPPED:
+			dev_err(cs40l50->dev, "Unmapped event\n");
+			break;
+		case CS40L50_MBOX_ERR_EVENT_MODIFY:
+			dev_err(cs40l50->dev, "Failed to modify event index\n");
+			break;
+		case CS40L50_MBOX_ERR_NULLPTR:
+			dev_err(cs40l50->dev, "Null pointer\n");
+			break;
+		case CS40L50_MBOX_ERR_BRAKING:
+			dev_err(cs40l50->dev, "Braking not in progress\n");
+			break;
+		case CS40L50_MBOX_ERR_INVAL_SRC:
+			dev_err(cs40l50->dev, "Suspend/resume invalid source\n");
+			break;
+		case CS40L50_MBOX_ERR_ENABLE_RANGE:
+			dev_err(cs40l50->dev, "GPIO enable out of range\n");
+			break;
+		case CS40L50_MBOX_ERR_GPIO_UNMAPPED:
+			dev_err(cs40l50->dev, "GPIO not mapped\n");
+			break;
+		case CS40L50_MBOX_ERR_ISR_RANGE:
+			dev_err(cs40l50->dev, "GPIO ISR out of range\n");
+			break;
+		case CS40L50_MBOX_PERMANENT_SHORT:
+			dev_crit(cs40l50->dev, "Permanent short detected\n");
+			break;
+		case CS40L50_MBOX_RUNTIME_SHORT:
+			dev_err(cs40l50->dev, "Runtime short detected\n");
+			error = cs40l50_error_release(cs40l50);
+			if (error)
+				goto out_mutex;
+			break;
+		default:
+			dev_err(cs40l50->dev, "Payload %#X not recognized\n", val);
+			error = -EINVAL;
+			goto out_mutex;
+		}
+	}
+
+	error = -EIO;
+
+out_mutex:
+	mutex_unlock(&cs40l50->lock);
+
+	return IRQ_RETVAL(!error);
+}
+
+static irqreturn_t cs40l50_error(int irq, void *data);
+
+static const struct cs40l50_irq cs40l50_irqs[] = {
+	CS40L50_IRQ(AMP_SHORT,		"Amp short",		error),
+	CS40L50_IRQ(VIRT2_MBOX,		"Mailbox",		process_mbox),
+	CS40L50_IRQ(TEMP_ERR,		"Overtemperature",	error),
+	CS40L50_IRQ(BST_UVP,		"Boost undervoltage",	error),
+	CS40L50_IRQ(BST_SHORT,		"Boost short",		error),
+	CS40L50_IRQ(BST_ILIMIT,		"Boost current limit",	error),
+	CS40L50_IRQ(UVLO_VDDBATT,	"Boost UVLO",		error),
+	CS40L50_IRQ(GLOBAL_ERROR,	"Global",		error),
+};
+
+static irqreturn_t cs40l50_error(int irq, void *data)
+{
+	struct cs40l50_private *cs40l50 = data;
+
+	dev_err(cs40l50->dev, "%s error\n", cs40l50_irqs[irq].name);
+
+	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
+}
+
+static const struct regmap_irq cs40l50_reg_irqs[] = {
+	CS40L50_REG_IRQ(IRQ1_INT_1,	AMP_SHORT),
+	CS40L50_REG_IRQ(IRQ1_INT_2,	VIRT2_MBOX),
+	CS40L50_REG_IRQ(IRQ1_INT_8,	TEMP_ERR),
+	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_UVP),
+	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_SHORT),
+	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_ILIMIT),
+	CS40L50_REG_IRQ(IRQ1_INT_10,	UVLO_VDDBATT),
+	CS40L50_REG_IRQ(IRQ1_INT_18,	GLOBAL_ERROR),
+};
+
+static struct regmap_irq_chip cs40l50_irq_chip = {
+	.name =			"CS40L50 IRQ Controller",
+
+	.status_base =		CS40L50_IRQ1_INT_1,
+	.mask_base =		CS40L50_IRQ1_MASK_1,
+	.ack_base =		CS40L50_IRQ1_INT_1,
+	.num_regs =		22,
+
+	.irqs =			cs40l50_reg_irqs,
+	.num_irqs =		ARRAY_SIZE(cs40l50_reg_irqs),
+
+	.runtime_pm =		true,
+};
+
+static int cs40l50_irq_init(struct cs40l50_private *cs40l50)
+{
+	struct device *dev = cs40l50->dev;
+	int error, i, irq;
+
+	error = devm_regmap_add_irq_chip(dev, cs40l50->regmap, cs40l50->irq,
+					 IRQF_ONESHOT | IRQF_SHARED, 0,
+					 &cs40l50_irq_chip, &cs40l50->irq_data);
+	if (error)
+		return error;
+
+	for (i = 0; i < ARRAY_SIZE(cs40l50_irqs); i++) {
+		irq = regmap_irq_get_virq(cs40l50->irq_data, cs40l50_irqs[i].irq);
+		if (irq < 0) {
+			dev_err(dev, "Failed getting %s\n", cs40l50_irqs[i].name);
+			return irq;
+		}
+
+		error = devm_request_threaded_irq(dev, irq, NULL,
+						  cs40l50_irqs[i].handler,
+						  IRQF_ONESHOT | IRQF_SHARED,
+						  cs40l50_irqs[i].name, cs40l50);
+		if (error) {
+			dev_err(dev, "Failed requesting %s\n", cs40l50_irqs[i].name);
+			return error;
+		}
+	}
+
+	return 0;
+}
+
+static int cs40l50_part_num_resolve(struct cs40l50_private *cs40l50)
+{
+	struct device *dev = cs40l50->dev;
+	int error;
+
+	error = regmap_read(cs40l50->regmap, CS40L50_DEVID, &cs40l50->devid);
+	if (error)
+		return error;
+
+	if (cs40l50->devid != CS40L50_DEVID_A) {
+		dev_err(dev, "Invalid device ID: %#010X\n", cs40l50->devid);
+		return -EINVAL;
+	}
+
+	error = regmap_read(cs40l50->regmap, CS40L50_REVID, &cs40l50->revid);
+	if (error)
+		return error;
+
+	if (cs40l50->revid != CS40L50_REVID_B0) {
+		dev_err(dev, "Invalid revision: %#04X\n", cs40l50->revid);
+		return -EINVAL;
+	}
+
+	dev_info(dev, "Cirrus Logic CS40L50 revision %02X\n", cs40l50->revid);
+
+	return 0;
+}
+
+int cs40l50_probe(struct cs40l50_private *cs40l50)
+{
+	struct device *dev = cs40l50->dev;
+	int error;
+
+	mutex_init(&cs40l50->lock);
+
+	cs40l50->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(cs40l50->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(cs40l50->reset_gpio),
+				     "Failed getting reset GPIO\n");
+
+	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(cs40l50_supplies),
+					cs40l50_supplies);
+	if (error)
+		goto err_reset;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(cs40l50_supplies),
+				      cs40l50_supplies);
+	if (error)
+		goto err_reset;
+
+	usleep_range(CS40L50_CP_READY_US, CS40L50_CP_READY_US + 100);
+
+	gpiod_set_value_cansleep(cs40l50->reset_gpio, 1);
+
+	usleep_range(CS40L50_CP_READY_US, CS40L50_CP_READY_US + 1000);
+
+	pm_runtime_set_autosuspend_delay(cs40l50->dev, CS40L50_AUTOSUSPEND_MS);
+	pm_runtime_use_autosuspend(cs40l50->dev);
+	pm_runtime_set_active(cs40l50->dev);
+	pm_runtime_get_noresume(cs40l50->dev);
+	devm_pm_runtime_enable(cs40l50->dev);
+
+	error = cs40l50_part_num_resolve(cs40l50);
+	if (error)
+		goto err_supplies;
+
+	error = cs40l50_irq_init(cs40l50);
+	if (error)
+		goto err_supplies;
+
+	error = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cs40l50_devs,
+				     ARRAY_SIZE(cs40l50_devs), NULL, 0, NULL);
+	if (error)
+		goto err_supplies;
+
+	pm_runtime_mark_last_busy(cs40l50->dev);
+	pm_runtime_put_autosuspend(cs40l50->dev);
+
+	return 0;
+
+err_supplies:
+	regulator_bulk_disable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
+err_reset:
+	gpiod_set_value_cansleep(cs40l50->reset_gpio, 0);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(cs40l50_probe);
+
+int cs40l50_remove(struct cs40l50_private *cs40l50)
+{
+	regulator_bulk_disable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
+	gpiod_set_value_cansleep(cs40l50->reset_gpio, 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs40l50_remove);
+
+static int cs40l50_runtime_suspend(struct device *dev)
+{
+	struct cs40l50_private *cs40l50 = dev_get_drvdata(dev);
+
+	return regmap_write(cs40l50->regmap, CS40L50_DSP_MBOX, CS40L50_ALLOW_HIBER);
+}
+
+static int cs40l50_runtime_resume(struct device *dev)
+{
+	struct cs40l50_private *cs40l50 = dev_get_drvdata(dev);
+	int error, i;
+	u32 val;
+
+	/* Device NAKs when exiting hibernation, so optionally retry here. */
+	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
+		error = regmap_write(cs40l50->regmap, CS40L50_DSP_MBOX,
+				     CS40L50_PREVENT_HIBER);
+		if (!error)
+			break;
+
+		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
+	}
+
+	for (; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
+		error = regmap_read(cs40l50->regmap, CS40L50_DSP_MBOX, &val);
+		if (!error && val == 0)
+			return 0;
+
+		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
+	}
+
+	return error ? error : -ETIMEDOUT;
+}
+
+EXPORT_GPL_DEV_PM_OPS(cs40l50_pm_ops) = {
+	RUNTIME_PM_OPS(cs40l50_runtime_suspend, cs40l50_runtime_resume, NULL)
+};
+
+MODULE_DESCRIPTION("CS40L50 Advanced Haptic Driver");
+MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/cs40l50-i2c.c b/drivers/mfd/cs40l50-i2c.c
new file mode 100644
index 000000000000..be1b130eb94b
--- /dev/null
+++ b/drivers/mfd/cs40l50-i2c.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS40L50 I2C Driver
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/mfd/cs40l50.h>
+
+static int cs40l50_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct cs40l50_private *cs40l50;
+
+	cs40l50 = devm_kzalloc(dev, sizeof(*cs40l50), GFP_KERNEL);
+	if (!cs40l50)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, cs40l50);
+
+	cs40l50->regmap = devm_regmap_init_i2c(client, &cs40l50_regmap);
+	if (IS_ERR(cs40l50->regmap))
+		return dev_err_probe(cs40l50->dev, PTR_ERR(cs40l50->regmap),
+				     "Failed to initialize register map\n");
+
+	cs40l50->dev = dev;
+	cs40l50->irq = client->irq;
+
+	return cs40l50_probe(cs40l50);
+}
+
+static void cs40l50_i2c_remove(struct i2c_client *client)
+{
+	struct cs40l50_private *cs40l50 = i2c_get_clientdata(client);
+
+	cs40l50_remove(cs40l50);
+}
+
+static const struct i2c_device_id cs40l50_id_i2c[] = {
+	{"cs40l50", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs40l50_id_i2c);
+
+static const struct of_device_id cs40l50_of_match[] = {
+	{ .compatible = "cirrus,cs40l50" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs40l50_of_match);
+
+static struct i2c_driver cs40l50_i2c_driver = {
+	.driver = {
+		.name = "cs40l50",
+		.of_match_table = cs40l50_of_match,
+		.pm = pm_ptr(&cs40l50_pm_ops),
+	},
+	.id_table = cs40l50_id_i2c,
+	.probe = cs40l50_i2c_probe,
+	.remove = cs40l50_i2c_remove,
+};
+
+module_i2c_driver(cs40l50_i2c_driver);
+
+MODULE_DESCRIPTION("CS40L50 I2C Driver");
+MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/cs40l50-spi.c b/drivers/mfd/cs40l50-spi.c
new file mode 100644
index 000000000000..8311d48efedf
--- /dev/null
+++ b/drivers/mfd/cs40l50-spi.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS40L50 SPI Driver
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ */
+
+#include <linux/input/cs40l50.h>
+#include <linux/mfd/spi.h>
+
+static int cs40l50_spi_probe(struct spi_device *spi)
+{
+	struct cs40l50_private *cs40l50;
+	struct device *dev = &spi->dev;
+
+	cs40l50 = devm_kzalloc(dev, sizeof(*cs40l50), GFP_KERNEL);
+	if (!cs40l50)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs40l50);
+
+	cs40l50->regmap = devm_regmap_init_spi(spi, &cs40l50_regmap);
+	if (IS_ERR(cs40l50->regmap))
+		return dev_err_probe(cs40l50->dev, PTR_ERR(cs40l50->regmap),
+				     "Failed to initialize register map\n");
+
+	cs40l50->dev = dev;
+	cs40l50->irq = spi->irq;
+
+	return cs40l50_probe(cs40l50);
+}
+
+static void cs40l50_spi_remove(struct spi_device *spi)
+{
+	struct cs40l50_private *cs40l50 = spi_get_drvdata(spi);
+
+	cs40l50_remove(cs40l50);
+}
+
+static const struct spi_device_id cs40l50_id_spi[] = {
+	{"cs40l50", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cs40l50_id_spi);
+
+static const struct of_device_id cs40l50_of_match[] = {
+	{ .compatible = "cirrus,cs40l50" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs40l50_of_match);
+
+static struct spi_driver cs40l50_spi_driver = {
+	.driver = {
+		.name = "cs40l50",
+		.of_match_table = cs40l50_of_match,
+		.pm = pm_ptr(&cs40l50_pm_ops),
+	},
+	.id_table = cs40l50_id_spi,
+	.probe = cs40l50_spi_probe,
+	.remove = cs40l50_spi_remove,
+};
+
+module_spi_driver(cs40l50_spi_driver);
+
+MODULE_DESCRIPTION("CS40L50 SPI Driver");
+MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/cs40l50.h b/include/linux/mfd/cs40l50.h
new file mode 100644
index 000000000000..c625a999a5ae
--- /dev/null
+++ b/include/linux/mfd/cs40l50.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * CS40L50 Advanced Haptic Driver with waveform memory,
+ * integrated DSP, and closed-loop algorithms
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ */
+
+#ifndef __CS40L50_H__
+#define __CS40L50_H__
+
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/input/cirrus_haptics.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+/* Power Supply Configuration */
+#define CS40L50_BLOCK_ENABLES2			0x201C
+#define CS40L50_ERR_RLS				0x2034
+#define CS40L50_PWRMGT_CTL			0x2900
+#define CS40L50_BST_LPMODE_SEL			0x3810
+#define CS40L50_DCM_LOW_POWER		0x1
+#define CS40L50_OVERTEMP_WARN		0x4000010
+
+/* Interrupts */
+#define CS40L50_IRQ1_INT_1			0xE010
+#define CS40L50_IRQ1_INT_2			0xE014
+#define CS40L50_IRQ1_INT_8			0xE02C
+#define CS40L50_IRQ1_INT_9			0xE030
+#define CS40L50_IRQ1_INT_10			0xE034
+#define CS40L50_IRQ1_INT_18			0xE054
+#define CS40L50_IRQ1_MASK_1			0xE090
+#define CS40L50_IRQ1_MASK_2			0xE094
+#define CS40L50_IRQ1_MASK_20			0xE0DC
+#define CS40L50_IRQ_MASK_2_OVERRIDE	0xFFDF7FFF
+#define CS40L50_IRQ_MASK_20_OVERRIDE	0x15C01000
+#define CS40L50_AMP_SHORT_MASK		BIT(31)
+#define CS40L50_VIRT2_MBOX_MASK		BIT(21)
+#define CS40L50_TEMP_ERR_MASK		BIT(31)
+#define CS40L50_BST_UVP_MASK		BIT(6)
+#define CS40L50_BST_SHORT_MASK		BIT(7)
+#define CS40L50_BST_ILIMIT_MASK		BIT(8)
+#define CS40L50_UVLO_VDDBATT_MASK	BIT(16)
+#define CS40L50_GLOBAL_ERROR_MASK	BIT(15)
+#define CS40L50_GLOBAL_ERR_RLS		BIT(11)
+#define CS40L50_IRQ(_irq, _name, _hand)		\
+	{					\
+		.irq = CS40L50_ ## _irq ## _IRQ,\
+		.name = _name,			\
+		.handler = cs40l50_ ## _hand,	\
+	}
+#define CS40L50_REG_IRQ(_reg, _irq)					\
+	[CS40L50_ ## _irq ## _IRQ] = {					\
+		.reg_offset = (CS40L50_ ## _reg) - CS40L50_IRQ1_INT_1,	\
+		.mask = CS40L50_ ## _irq ## _MASK			\
+	}
+
+/* Mailbox Inbound Commands */
+#define CS40L50_RAM_BANK_INDEX_START	0x1000000
+#define CS40L50_RTH_INDEX_START		0x1400000
+#define CS40L50_RTH_INDEX_END		0x1400001
+#define CS40L50_ROM_BANK_INDEX_START	0x1800000
+#define CS40L50_ROM_BANK_INDEX_END	0x180001A
+#define CS40L50_PREVENT_HIBER		0x2000003
+#define CS40L50_ALLOW_HIBER		0x2000004
+#define CS40L50_OWT_PUSH		0x3000008
+#define CS40L50_STOP_PLAYBACK		0x5000000
+#define CS40L50_OWT_DELETE		0xD000000
+
+/* Mailbox Outbound Commands */
+#define CS40L50_MBOX_QUEUE_BASE				0x11004
+#define CS40L50_MBOX_QUEUE_END				0x1101C
+#define CS40L50_DSP_MBOX				0x11020
+#define CS40L50_MBOX_QUEUE_WT				0x28042C8
+#define CS40L50_MBOX_QUEUE_RD				0x28042CC
+#define CS40L50_MBOX_HAPTIC_COMPLETE_MBOX	0x1000000
+#define CS40L50_MBOX_HAPTIC_COMPLETE_GPIO	0x1000001
+#define CS40L50_MBOX_HAPTIC_COMPLETE_I2S	0x1000002
+#define CS40L50_MBOX_HAPTIC_TRIGGER_MBOX	0x1000010
+#define CS40L50_MBOX_HAPTIC_TRIGGER_GPIO	0x1000011
+#define CS40L50_MBOX_HAPTIC_TRIGGER_I2S		0x1000012
+#define CS40L50_MBOX_INIT			0x2000000
+#define CS40L50_MBOX_AWAKE			0x2000002
+#define CS40L50_MBOX_F0_EST_START		0x7000011
+#define CS40L50_MBOX_F0_EST_DONE		0x7000021
+#define CS40L50_MBOX_REDC_EST_START		0x7000012
+#define CS40L50_MBOX_REDC_EST_DONE		0x7000022
+#define CS40L50_MBOX_LE_EST_START		0x7000014
+#define CS40L50_MBOX_LE_EST_DONE		0x7000024
+#define CS40L50_MBOX_ACK			0xA000000
+#define CS40L50_MBOX_PANIC			0xC000000
+#define CS40L50_MBOX_WATERMARK			0xD000000
+#define CS40L50_MBOX_ERR_EVENT_UNMAPPED		0xC0004B3
+#define CS40L50_MBOX_ERR_EVENT_MODIFY		0xC0004B4
+#define CS40L50_MBOX_ERR_NULLPTR		0xC0006A5
+#define CS40L50_MBOX_ERR_BRAKING		0xC0006A8
+#define CS40L50_MBOX_ERR_INVAL_SRC		0xC0006AC
+#define CS40L50_MBOX_ERR_ENABLE_RANGE		0xC000836
+#define CS40L50_MBOX_ERR_GPIO_UNMAPPED		0xC000837
+#define CS40L50_MBOX_ERR_ISR_RANGE		0xC000838
+#define CS40L50_MBOX_PERMANENT_SHORT		0xC000C1C
+#define CS40L50_MBOX_RUNTIME_SHORT		0xC000C1D
+
+/* DSP */
+#define CS40L50_DSP1_XMEM_PACKED_0		0x2000000
+#define CS40L50_DSP1_XMEM_UNPACKED32_0		0x2400000
+#define CS40L50_SYS_INFO_ID			0x25E0000
+#define CS40L50_DSP1_XMEM_UNPACKED24_0		0x2800000
+#define CS40L50_RAM_INIT			0x28021DC
+#define CS40L50_POWER_ON_SEQ			0x2804320
+#define CS40L50_OWT_BASE			0x2805C34
+#define CS40L50_NUM_OF_WAVES			0x280CB4C
+#define CS40L50_CORE_BASE			0x2B80000
+#define CS40L50_CCM_CORE_CONTROL		0x2BC1000
+#define CS40L50_DSP1_YMEM_PACKED_0		0x2C00000
+#define CS40L50_DSP1_YMEM_UNPACKED32_0		0x3000000
+#define CS40L50_DSP1_YMEM_UNPACKED24_0		0x3400000
+#define CS40L50_DSP1_PMEM_0			0x3800000
+#define CS40L50_DSP1_PMEM_5114			0x3804FE8
+#define CS40L50_MEM_RDY_HW		0x2
+#define CS40L50_RAM_INIT_FLAG		0x1
+#define CS40L50_CLOCK_DISABLE		0x80
+#define CS40L50_CLOCK_ENABLE		0x281
+#define CS40L50_DSP_POLL_US		1000
+#define CS40L50_DSP_TIMEOUT_COUNT	100
+#define CS40L50_CP_READY_US		2200
+#define CS40L50_PSEQ_SIZE		200
+#define CS40L50_AUTOSUSPEND_MS		2000
+
+/* Firmware */
+#define CS40L50_FW			"cs40l50.wmfw"
+#define CS40L50_WT			"cs40l50.bin"
+
+/* Calibration */
+#define CS40L50_REDC_ESTIMATION		0x2802F7C
+#define CS40L50_F0_ESTIMATION		0x2802F84
+#define CS40L50_F0_STORED		0x2805C00
+#define CS40L50_REDC_STORED		0x2805C04
+#define CS40L50_RE_EST_STATUS		0x3401B40
+
+/* Open wavetable */
+#define CS40L50_OWT_SIZE		0x2805C38
+#define CS40L50_OWT_NEXT		0x2805C3C
+#define CS40L50_NUM_OF_OWT_WAVES	0x2805C40
+
+/* GPIO */
+#define CS40L50_GPIO_BASE		0x2804140
+
+/* Device */
+#define CS40L50_DEVID			0x0
+#define CS40L50_REVID			0x4
+#define CS40L50_DEVID_A		0x40A50
+#define CS40L50_REVID_B0	0xB0
+
+enum cs40l50_irq_list {
+	CS40L50_GLOBAL_ERROR_IRQ,
+	CS40L50_UVLO_VDDBATT_IRQ,
+	CS40L50_BST_ILIMIT_IRQ,
+	CS40L50_BST_SHORT_IRQ,
+	CS40L50_BST_UVP_IRQ,
+	CS40L50_TEMP_ERR_IRQ,
+	CS40L50_VIRT2_MBOX_IRQ,
+	CS40L50_AMP_SHORT_IRQ,
+};
+
+struct cs40l50_irq {
+	const char *name;
+	int irq;
+	irqreturn_t (*handler)(int irq, void *data);
+};
+
+struct cs40l50_private {
+	struct device *dev;
+	struct regmap *regmap;
+	struct cs_dsp dsp;
+	struct mutex lock;
+	struct gpio_desc *reset_gpio;
+	struct regmap_irq_chip_data *irq_data;
+	struct input_dev *input;
+	const struct firmware *wmfw;
+	struct cs_hap haptics;
+	u32 devid;
+	u32 revid;
+	int irq;
+};
+
+int cs40l50_probe(struct cs40l50_private *cs40l50);
+int cs40l50_remove(struct cs40l50_private *cs40l50);
+
+extern const struct regmap_config cs40l50_regmap;
+extern const struct dev_pm_ops cs40l50_pm_ops;
+
+#endif /* __CS40L50_H__ */
-- 
2.25.1

