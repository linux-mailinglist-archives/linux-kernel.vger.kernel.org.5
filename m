Return-Path: <linux-kernel+bounces-31198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EBE832A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E81428508F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7A54FAC;
	Fri, 19 Jan 2024 13:25:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707905465E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670744; cv=none; b=o0sMMjeuVHfaxXnIbUw5mT6e2SjnooNmYv/k+s2KdkHybiNI+pxzv/oUswUHDug9mGZl3IQNFrW0NdIZRcvhXxZWAx5PHkWuX55rl4dgqrMIbZs2iPGTYXFfKTrCdQcKZlxk0OxcX3uT/rCkNH46E1jh6UCgwvJjp12xDqWErWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670744; c=relaxed/simple;
	bh=3Glzu+0PbXiGnMMmOn9Xn/tWC6n+7I7VVFwZl4dJEDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t978xhXKTDgJorDjF+KvVnlGJVmtAkJeEHcMoUYqekE7xwEt/+CY9Zgk065b5Q5RHF7CIqcyxY3KHrqn71vslTSCD8iwFe+cFgURKh+wPJUibC43xvHQ1IE1lGiMV002dOUZC85x9yHV7Ot4zShD7M5Ci+3t4Erg97vXaXHg3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos7-00074G-C1; Fri, 19 Jan 2024 14:25:23 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-000viH-60; Fri, 19 Jan 2024 14:25:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-00F97r-0M;
	Fri, 19 Jan 2024 14:25:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [RFC PATCH v1 2/7] power: reset: Introduce PSCR Tracking Framework for Non-Volatile Storage
Date: Fri, 19 Jan 2024 14:25:16 +0100
Message-Id: <20240119132521.3609945-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119132521.3609945-1-o.rempel@pengutronix.de>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This commit introduces the Power State Change Reasons (PSCR) tracking
framework into the kernel. The framework is vital for systems where
PMICs or watchdogs cannot provide information on power state changes. It
stores reasons for system shutdowns and reboots, like under-voltage or
software-triggered events, in non-volatile hardware storage. This
approach is essential for postmortem analysis in scenarios where
traditional storage methods (block devices, RAM) are not feasible. The
framework aids bootloaders and early-stage system components in recovery
decision-making, although it does not cover resets caused by hardware
issues like system freezes or watchdog timeouts.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/power/reset/Kconfig  |  19 +++
 drivers/power/reset/Makefile |   1 +
 drivers/power/reset/pscr.c   | 259 +++++++++++++++++++++++++++++++++++
 include/linux/pscr.h         |  40 ++++++
 4 files changed, 319 insertions(+)
 create mode 100644 drivers/power/reset/pscr.c
 create mode 100644 include/linux/pscr.h

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fece990af4a7..da76e84302b9 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -305,3 +305,22 @@ config POWER_MLXBF
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
 endif
+
+menuconfig PSCR
+    bool "Power State Change Reasons (PSCR) Tracking Framework"
+    help
+      Enables the Power State Change Reasons (PSCR) tracking framework.
+
+      This framework is designed to store reasons for system shutdowns or
+      reboots,  like under voltage or software-triggered events, in non-volatile
+      hardware storage. It is particularly useful for postmortem analysis, where
+      traditional storage methods (like block devices or RAM) are not feasible
+      due to immediate power-down requirements or insufficient power to retain
+      data.
+
+      This is useful for bootloaders or other early-stage system components to
+      make recovery decisions based on the last known system state. Note that it
+      does not cover hardware-induced resets like system freezes or watchdog
+      timeouts.
+
+      If unsure, say N.
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index a95d1bd275d1..d9d744302c68 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
+obj-$(CONFIG_PSCR) += pscr.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/pscr.c b/drivers/power/reset/pscr.c
new file mode 100644
index 000000000000..7506ecbe1aad
--- /dev/null
+++ b/drivers/power/reset/pscr.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2016, Fuzhou Rockchip Electronics Co., Ltd
+// Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+/*
+ * Based on drivers/power/reset/reboot-mode.c
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/reboot.h>
+#include <linux/pscr.h>
+
+#define PREFIX "pscr-"
+
+struct reason_info {
+	enum power_state_change_reason pscr;
+	u32 magic;
+	struct list_head list;
+};
+
+enum power_state_change_reason system_pscr;
+
+struct pscr_map {
+	const char *reason;
+	enum power_state_change_reason pscr;
+};
+
+struct pscr_map pscr_map_table[] = {
+	{ "unknown", PSCR_UNKNOWN },
+	{ "under-voltage", PSCR_UNDER_VOLTAGE },
+	{ "over-current", PSCR_OVER_CURRENT },
+	{ "regulator-failure", PSCR_REGULATOR_FAILURE },
+	{ "over-temperature", PSCR_OVERTEMPERATURE },
+};
+
+static int find_reason_by_string(const char *reason)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pscr_map_table); i++) {
+		if (!strcmp(reason, pscr_map_table[i].reason))
+			return pscr_map_table[i].pscr;
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * set_power_state_change_reason() - Set the system's power state change reason
+ * @reason: The enum value representing the power state change reason
+ *
+ * This function sets the system's power state change reason based on the
+ * provided enum value.
+ */
+void set_power_state_change_reason(enum power_state_change_reason reason)
+{
+	system_pscr = reason;
+}
+EXPORT_SYMBOL_GPL(set_power_state_change_reason);
+
+static unsigned int get_pscr_magic(struct pscr_driver *pscr_drv,
+					  const char *cmd)
+{
+	struct reason_info *info;
+
+	list_for_each_entry(info, &pscr_drv->head, list) {
+		if (info->pscr == system_pscr)
+			return info->magic;
+	}
+
+	return 0;
+}
+
+static int pscr_notify(struct notifier_block *this,
+			      unsigned long reason, void *cmd)
+{
+	struct pscr_driver *pscr_drv = container_of(this, struct pscr_driver,
+						    reboot_notifier);
+	unsigned int magic;
+
+	magic = get_pscr_magic(pscr_drv, cmd);
+	if (magic)
+		pscr_drv->write(pscr_drv, magic);
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * pscr_process_property() - Process a power state change reason property
+ * @pscr_drv: Pointer to the pscr_driver structure
+ * @prop: Pointer to the property structure to be processed
+ *
+ * This function processes a device tree property representing a power state
+ * change reason and initializes the relevant data structures.
+ *
+ * Returns: 0 on success, -ENOMEM on memory allocation failure.
+ */
+static int pscr_process_property(struct pscr_driver *pscr_drv,
+				 struct property *prop)
+{
+	struct device *dev = pscr_drv->dev;
+	size_t len = strlen(PREFIX);
+	struct reason_info *info;
+	int ret;
+
+	if (strncmp(prop->name, PREFIX, len))
+		return 0;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dev->of_node, prop->name, &info->magic);
+	if (ret) {
+		dev_err(dev, "Can't read magic number for %s: %pe\n",
+			prop->name, ERR_PTR(ret));
+		devm_kfree(dev, info);
+		return 0;
+	}
+
+	if (!info->magic) {
+		dev_err(dev, "%s with magic number == 0\n", prop->name);
+		devm_kfree(dev, info);
+		return 0;
+	}
+
+	info->pscr = find_reason_by_string(prop->name + len);
+	if (info->pscr < 0) {
+		dev_err(dev, "unsupported reason name(%s): %pe\n",
+				prop->name, ERR_PTR(info->pscr));
+		devm_kfree(dev, info);
+		return 0;
+	}
+
+	if (info->magic > pscr_drv->max_magic)
+		pscr_drv->max_magic = info->magic;
+
+	dev_dbg(dev, "registering reason = %s, magic = %d, pscr = %d\n",
+		prop->name, info->magic, info->pscr);
+	list_add_tail(&info->list, &pscr_drv->head);
+
+	return 0;
+}
+
+/*
+ * pscr_register() - Register the pscr driver and initialize power state change
+ *                   reasons
+ * @pscr_drv: Pointer to the pscr_driver structure
+ *
+ * This function registers the pscr driver and initializes power state change
+ * reasons based on device tree properties.
+ *
+ * Returns: 0 on success, -ENOMEM on memory allocation failure
+ */
+int pscr_register(struct pscr_driver *pscr_drv)
+{
+	struct device_node *np = pscr_drv->dev->of_node;
+	struct property *prop;
+
+	INIT_LIST_HEAD(&pscr_drv->head);
+
+	for_each_property_of_node(np, prop) {
+		int ret = pscr_process_property(pscr_drv, prop);
+		if (ret)
+			return ret;
+	}
+
+	pscr_drv->reboot_notifier.notifier_call = pscr_notify;
+	register_reboot_notifier(&pscr_drv->reboot_notifier);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pscr_register);
+
+/*
+ * pscr_unregister() - Unregister the pscr driver's reboot notifier
+ * @pscr_drv: Pointer to the pscr_driver structure
+ *
+ * This function unregisters the reboot notifier for the pscr driver.
+ */
+void pscr_unregister(struct pscr_driver *pscr_drv)
+{
+	unregister_reboot_notifier(&pscr_drv->reboot_notifier);
+}
+EXPORT_SYMBOL_GPL(pscr_unregister);
+
+static void devm_pscr_release(struct device *dev, void *res)
+{
+	pscr_unregister(*(struct pscr_driver **)res);
+}
+
+/**
+ * devm_pscr_register - Register a device-managed PSCR driver
+ * @dev: Device to associate the PSCR driver with
+ * @pscr_drv: Pointer to the PSCR driver to be registered
+ *
+ * Registers a Power State Change Reason (PSCR) driver as a device-managed
+ * resource.
+ *
+ * Returns: 0 on successful registration or a negative error code on failure.
+ */
+int devm_pscr_register(struct device *dev,
+			      struct pscr_driver *pscr_drv)
+{
+	struct pscr_driver **dr;
+	int rc;
+
+	dr = devres_alloc(devm_pscr_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = pscr_register(pscr_drv);
+	if (rc) {
+		devres_free(dr);
+		return rc;
+	}
+
+	*dr = pscr_drv;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_pscr_register);
+
+static int devm_pscr_match(struct device *dev, void *res, void *data)
+{
+	struct pscr_driver **p = res;
+
+	if (WARN_ON(!p || !*p))
+		return 0;
+
+	return *p == data;
+}
+
+/**
+ * devm_pscr_unregister - Unregister a managed PSCR driver
+ * @dev: Device associated with the PSCR driver
+ * @pscr_drv: Pointer to the PSCR driver to unregister
+ *
+ * Unregisters a device-managed Power State Change Reason (PSCR) driver.
+ * It handles the cleanup and release of resources associated with the PSCR
+ * driver which was previously registered.
+ */
+void devm_pscr_unregister(struct device *dev,
+				 struct pscr_driver *pscr_drv)
+{
+	WARN_ON(devres_release(dev,
+			       devm_pscr_release,
+			       devm_pscr_match, pscr_drv));
+}
+EXPORT_SYMBOL_GPL(devm_pscr_unregister);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("Power State Change Reason (PSCR) tracking framework");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/pscr.h b/include/linux/pscr.h
new file mode 100644
index 000000000000..bf66dd69d96d
--- /dev/null
+++ b/include/linux/pscr.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PSCR_H__
+#define __PSCR_H__
+
+enum power_state_change_reason {
+	PSCR_UNKNOWN,
+	PSCR_UNDER_VOLTAGE,
+	PSCR_OVER_CURRENT,
+	PSCR_REGULATOR_FAILURE,
+	PSCR_OVERTEMPERATURE,
+};
+
+struct pscr_driver {
+	struct device *dev;
+	struct list_head head;
+	int (*write)(struct pscr_driver *pscr_drv, u32 magic);
+	struct notifier_block reboot_notifier;
+	u32 max_magic;
+};
+
+int pscr_register(struct pscr_driver *pscr_drv);
+void pscr_unregister(struct pscr_driver *pscr_drv);
+int devm_pscr_register(struct device *dev,
+		       struct pscr_driver *pscr_drv);
+void devm_pscr_unregister(struct device *dev,
+			  struct pscr_driver *pscr_drv);
+
+
+#if IS_ENABLED(CONFIG_PSCR)
+
+void set_power_state_change_reason(enum power_state_change_reason reason);
+
+#else
+
+static inline void set_power_state_change_reason(enum power_state_change_reason reason)
+{
+}
+#endif
+
+#endif
-- 
2.39.2


