Return-Path: <linux-kernel+bounces-88747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D240586E610
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9C8B24E57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F038DCD;
	Fri,  1 Mar 2024 16:43:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2222C376E4;
	Fri,  1 Mar 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311385; cv=none; b=d/ws4fanlUbwlqZgDeJlY0pXs8p8PM2jPjhpfSuYRLR81y/DQT7fKfOL588xPfbuDGiW3r0LbooccAa22+JGqSFZ5DohYurTy8R4+OC3DzPuJGf9JhX9O9PZ06l82448YS4FTai5MhxaadV7tHKezVj3fCk1UzThlWgYdUMNWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311385; c=relaxed/simple;
	bh=thw84MHaik8Hl5C7aT8Qcyvhfi+ClY4Bbn8jLjcaZIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGjEr2E3eNUFkPKUID9oKjOfyfLaE5Lz8Ea9YwNosHSMcMSo6yesOvj1zkF34O6WyanV65jdOHzK8jAztB3FfhNfGrsQpcXmf4IXlx96Kl2AFkQFjVE7qztbYyqjloIXlg81ZRWhFK2SpMVuLXMjMb+frb51qmYPGip0bnw+heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7D5A11FB;
	Fri,  1 Mar 2024 08:43:40 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.69.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33FCE3F73F;
	Fri,  1 Mar 2024 08:42:59 -0800 (PST)
From: abdellatif.elkhlifi@arm.com
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew.Reed@arm.com,
	Adam.Johnston@arm.com,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Date: Fri,  1 Mar 2024 16:42:25 +0000
Message-Id: <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

introduce remoteproc support for Arm remote processors

The supported remote processors are those that come with a reset
control register and a reset status register. The driver allows to
switch on or off the remote processor.

The current use case is Corstone-1000 External System (Cortex-M3).

The driver can be extended to support other remote processors
controlled with a reset control and a reset status registers.

The driver also supports control of multiple remote processors at the
same time.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
---
 MAINTAINERS                    |   6 +
 drivers/remoteproc/Kconfig     |  18 ++
 drivers/remoteproc/Makefile    |   1 +
 drivers/remoteproc/arm_rproc.c | 395 +++++++++++++++++++++++++++++++++
 4 files changed, 420 insertions(+)
 create mode 100644 drivers/remoteproc/arm_rproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..54d6a40feea5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1764,6 +1764,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 F:	drivers/irqchip/irq-vic.c
 
+ARM REMOTEPROC DRIVER
+M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+L:	linux-remoteproc@vger.kernel.org
+S:	Maintained
+F:	drivers/remoteproc/arm_rproc.c
+
 ARM SMC WATCHDOG DRIVER
 M:	Julius Werner <jwerner@chromium.org>
 R:	Evan Benn <evanbenn@chromium.org>
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..57fbac454a5d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -365,6 +365,24 @@ config XLNX_R5_REMOTEPROC
 
 	  It's safe to say N if not interested in using RPU r5f cores.
 
+config ARM_REMOTEPROC
+	tristate "Arm remoteproc support"
+	depends on HAS_IOMEM && ARM64
+	default n
+	help
+	  Say y here to support Arm remote processors via the remote
+	  processor framework.
+
+	  The supported processors are those that come with a reset control register
+	  and a reset status register. The design can be extended to support different
+	  processors meeting these requirements.
+	  The driver also supports control of multiple remote cores at the same time.
+
+	  Supported remote cores:
+	      Corstone-1000 External System (Cortex-M3)
+
+	  It's safe to say N here.
+
 endif # REMOTEPROC
 
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 91314a9b43ce..73126310835b 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
 obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
 obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
 obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
+obj-$(CONFIG_ARM_REMOTEPROC)		+= arm_rproc.o
diff --git a/drivers/remoteproc/arm_rproc.c b/drivers/remoteproc/arm_rproc.c
new file mode 100644
index 000000000000..6afa78ae7ad3
--- /dev/null
+++ b/drivers/remoteproc/arm_rproc.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+
+#include "remoteproc_internal.h"
+
+/**
+ * struct arm_rproc_reset_cfg - remote processor reset configuration
+ * @ctrl_reg: address of the control register
+ * @state_reg: address of the reset status register
+ */
+struct arm_rproc_reset_cfg {
+	void __iomem *ctrl_reg;
+	void __iomem *state_reg;
+};
+
+struct arm_rproc;
+
+/**
+ * struct arm_rproc_dcfg - Arm remote processor configuration
+ * @stop: stop callback function
+ * @start: start callback function
+ */
+struct arm_rproc_dcfg {
+	int (*stop)(struct rproc *rproc);
+	int (*start)(struct rproc *rproc);
+};
+
+/**
+ * struct arm_rproc - Arm remote processor instance
+ * @rproc: rproc handler
+ * @core_dcfg: device configuration pointer
+ * @reset_cfg: reset configuration registers
+ */
+struct arm_rproc {
+	struct rproc				*rproc;
+	const struct arm_rproc_dcfg		*core_dcfg;
+	struct arm_rproc_reset_cfg		reset_cfg;
+};
+
+/* Definitions for Arm Corstone-1000 External System */
+
+#define EXTSYS_RST_CTRL_CPUWAIT			BIT(0)
+#define EXTSYS_RST_CTRL_RST_REQ			BIT(1)
+
+#define EXTSYS_RST_ACK_MASK				GENMASK(2, 1)
+#define EXTSYS_RST_ST_RST_ACK(x)			\
+				((u8)(FIELD_GET(EXTSYS_RST_ACK_MASK, (x))))
+
+#define EXTSYS_RST_ACK_NO_RESET_REQ			(0x0)
+#define EXTSYS_RST_ACK_NOT_COMPLETE			(0x1)
+#define EXTSYS_RST_ACK_COMPLETE			(0x2)
+#define EXTSYS_RST_ACK_RESERVED			(0x3)
+
+#define EXTSYS_RST_ACK_POLL_TRIES			(3)
+#define EXTSYS_RST_ACK_POLL_TIMEOUT			(1000)
+
+/**
+ * arm_rproc_start_cs1000_extsys() - custom start function
+ * @rproc: pointer to the remote processor object
+ *
+ * Start function for Corstone-1000 External System.
+ * Allow the External System core start execute instructions.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int arm_rproc_start_cs1000_extsys(struct rproc *rproc)
+{
+	struct arm_rproc *priv = rproc->priv;
+	u32 ctrl_reg;
+
+	/* CPUWAIT signal of the External System is de-asserted */
+	ctrl_reg = readl(priv->reset_cfg.ctrl_reg);
+	ctrl_reg &= ~EXTSYS_RST_CTRL_CPUWAIT;
+	writel(ctrl_reg, priv->reset_cfg.ctrl_reg);
+
+	return 0;
+}
+
+/**
+ * arm_rproc_cs1000_extsys_poll_rst_ack() - poll RST_ACK bits
+ * @rproc: pointer to the remote processor object
+ * @exp_ack: expected bits value
+ * @rst_ack: bits value read
+ *
+ * Tries to read RST_ACK bits until the timeout expires.
+ * EXTSYS_RST_ACK_POLL_TRIES tries are made,
+ * every EXTSYS_RST_ACK_POLL_TIMEOUT milliseconds.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int arm_rproc_cs1000_extsys_poll_rst_ack(struct rproc *rproc,
+						u8 exp_ack, u8 *rst_ack)
+{
+	struct arm_rproc *priv = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	u32 state_reg;
+	int tries = EXTSYS_RST_ACK_POLL_TRIES;
+	unsigned long timeout;
+
+	do {
+		state_reg = readl(priv->reset_cfg.state_reg);
+		*rst_ack = EXTSYS_RST_ST_RST_ACK(state_reg);
+
+		if (*rst_ack == EXTSYS_RST_ACK_RESERVED) {
+			dev_err(dev, "unexpected RST_ACK value: 0x%x\n",
+				*rst_ack);
+			return -EINVAL;
+		}
+
+		/* expected ACK value read */
+		if ((*rst_ack & exp_ack) || (*rst_ack == exp_ack))
+			return 0;
+
+		timeout = msleep_interruptible(EXTSYS_RST_ACK_POLL_TIMEOUT);
+
+		if (timeout) {
+			dev_err(dev, "polling RST_ACK  aborted\n");
+			return -ECONNABORTED;
+		}
+	} while (--tries);
+
+	dev_err(dev, "polling RST_ACK timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * arm_rproc_stop_cs1000_extsys() - custom stop function
+ * @rproc: pointer to the remote processor object
+ *
+ * Reset all logic within the External System, the core will be in a halt state.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int arm_rproc_stop_cs1000_extsys(struct rproc *rproc)
+{
+	struct arm_rproc *priv = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	u32 ctrl_reg;
+	u8 rst_ack, req_status;
+	int ret;
+
+	ctrl_reg = readl(priv->reset_cfg.ctrl_reg);
+	ctrl_reg |= EXTSYS_RST_CTRL_RST_REQ;
+	writel(ctrl_reg, priv->reset_cfg.ctrl_reg);
+
+	ret = arm_rproc_cs1000_extsys_poll_rst_ack(rproc,
+						   EXTSYS_RST_ACK_COMPLETE |
+						   EXTSYS_RST_ACK_NOT_COMPLETE,
+						   &rst_ack);
+	if (ret)
+		return ret;
+
+	req_status = rst_ack;
+
+	ctrl_reg = readl(priv->reset_cfg.ctrl_reg);
+	ctrl_reg &= ~EXTSYS_RST_CTRL_RST_REQ;
+	writel(ctrl_reg, priv->reset_cfg.ctrl_reg);
+
+	ret = arm_rproc_cs1000_extsys_poll_rst_ack(rproc, 0, &rst_ack);
+	if (ret)
+		return ret;
+
+	if (req_status == EXTSYS_RST_ACK_COMPLETE) {
+		dev_dbg(dev, "the requested reset has been accepted\n");
+		return 0;
+	}
+
+	dev_err(dev, "the requested reset has been denied\n");
+	return -EACCES;
+}
+
+static const struct arm_rproc_dcfg arm_rproc_cfg_corstone1000_extsys = {
+	.stop          = arm_rproc_stop_cs1000_extsys,
+	.start         = arm_rproc_start_cs1000_extsys,
+};
+
+/**
+ * arm_rproc_stop() - Stop function for rproc_ops
+ * @rproc: pointer to the remote processor object
+ *
+ * Calls the stop() callback of the remote core
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int arm_rproc_stop(struct rproc *rproc)
+{
+	struct arm_rproc *priv = rproc->priv;
+
+	return priv->core_dcfg->stop(rproc);
+}
+
+/**
+ * arm_rproc_start() - Start function for rproc_ops
+ * @rproc: pointer to the remote processor object
+ *
+ * Calls the start() callback of the remote core
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int arm_rproc_start(struct rproc *rproc)
+{
+	struct arm_rproc *priv = rproc->priv;
+
+	return priv->core_dcfg->start(rproc);
+}
+
+/**
+ * arm_rproc_parse_fw() - Parse firmware function for rproc_ops
+ * @rproc: pointer to the remote processor object
+ * @fw: pointer to the firmware
+ *
+ * Does nothing currently.
+ *
+ * Return:
+ *
+ * 0 for success.
+ */
+static int arm_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	return 0;
+}
+
+/**
+ * arm_rproc_load() - Load firmware to memory function for rproc_ops
+ * @rproc: pointer to the remote processor object
+ * @fw: pointer to the firmware
+ *
+ * Does nothing currently.
+ *
+ * Return:
+ *
+ * 0 for success.
+ */
+static int arm_rproc_load(struct rproc *rproc, const struct firmware *fw)
+{
+	return 0;
+}
+
+static const struct rproc_ops arm_rproc_ops = {
+	.start		= arm_rproc_start,
+	.stop		= arm_rproc_stop,
+	.load		= arm_rproc_load,
+	.parse_fw	= arm_rproc_parse_fw,
+};
+
+/**
+ * arm_rproc_probe() - the platform device probe
+ * @pdev: the platform device
+ *
+ * Read from the device tree the properties needed to setup
+ * the reset and comms for the remote processor.
+ * Also, allocate a rproc device and register it with the remoteproc subsystem.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int arm_rproc_probe(struct platform_device *pdev)
+{
+	const struct arm_rproc_dcfg *core_dcfg;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct arm_rproc *priv;
+	struct rproc *rproc;
+	const char *fw_name;
+	int ret;
+	struct resource *res;
+
+	core_dcfg = of_device_get_match_data(dev);
+	if (!core_dcfg)
+		return -ENODEV;
+
+	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
+	if (ret) {
+		dev_err(dev,
+			"can't parse firmware-name from device tree (%pe)\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	dev_dbg(dev, "firmware-name: %s\n", fw_name);
+
+	rproc = rproc_alloc(dev, np->name, &arm_rproc_ops, fw_name,
+			    sizeof(*priv));
+	if (!rproc)
+		return -ENOMEM;
+
+	priv = rproc->priv;
+	priv->rproc = rproc;
+	priv->core_dcfg = core_dcfg;
+
+	res = platform_get_resource_byname(pdev,
+					   IORESOURCE_MEM, "reset-control");
+	priv->reset_cfg.ctrl_reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->reset_cfg.ctrl_reg)) {
+		ret = PTR_ERR(priv->reset_cfg.ctrl_reg);
+		dev_err(dev,
+			"can't map the reset-control register (%pe)\n",
+			ERR_PTR((unsigned long)priv->reset_cfg.ctrl_reg));
+		goto err_free_rproc;
+	} else {
+		dev_dbg(dev, "reset-control: %p\n", priv->reset_cfg.ctrl_reg);
+	}
+
+	res = platform_get_resource_byname(pdev,
+					   IORESOURCE_MEM, "reset-status");
+	priv->reset_cfg.state_reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->reset_cfg.state_reg)) {
+		ret = PTR_ERR(priv->reset_cfg.state_reg);
+		dev_err(dev,
+			"can't map the reset-status register (%pe)\n",
+			ERR_PTR((unsigned long)priv->reset_cfg.state_reg));
+		goto err_free_rproc;
+	} else {
+		dev_dbg(dev, "reset-status: %p\n",
+			priv->reset_cfg.state_reg);
+	}
+
+	platform_set_drvdata(pdev, rproc);
+
+	ret = rproc_add(rproc);
+	if (ret) {
+		dev_err(dev, "can't add remote processor (%pe)\n",
+			ERR_PTR(ret));
+		goto err_free_rproc;
+	} else {
+		dev_dbg(dev, "remote processor added\n");
+	}
+
+	return 0;
+
+err_free_rproc:
+	rproc_free(rproc);
+
+	return ret;
+}
+
+/**
+ * arm_rproc_remove() - the platform device remove
+ * @pdev: the platform device
+ *
+ * Delete and free the resources used.
+ */
+static void arm_rproc_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+
+	rproc_del(rproc);
+	rproc_free(rproc);
+}
+
+static const struct of_device_id arm_rproc_of_match[] = {
+	{ .compatible = "arm,corstone1000-extsys", .data = &arm_rproc_cfg_corstone1000_extsys },
+	{},
+};
+MODULE_DEVICE_TABLE(of, arm_rproc_of_match);
+
+static struct platform_driver arm_rproc_driver = {
+	.probe = arm_rproc_probe,
+	.remove_new = arm_rproc_remove,
+	.driver = {
+		.name = "arm-rproc",
+		.of_match_table = arm_rproc_of_match,
+	},
+};
+module_platform_driver(arm_rproc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Arm Remote Processor Control Driver");
+MODULE_AUTHOR("Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>");
-- 
2.25.1


