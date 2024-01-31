Return-Path: <linux-kernel+bounces-47240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EEF844AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B87B22E46
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A33A1D3;
	Wed, 31 Jan 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hTi6l/P5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C039AFE;
	Wed, 31 Jan 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739608; cv=none; b=K/itngneC1WAiGo4Moww2LJN+0CMfvCDaUdghUaZjb55NfcJH4myAxfpb+OyQa2Q7GGKGrkVl05x+8uj7Y7R+ySLPa4UXlr3GyCIZiXrpTtOaA9MqESzrvt47W3QqiUxj72Oc2dq1acofdT98tw70OeDUWl4Ygsnw/HQr0Mlt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739608; c=relaxed/simple;
	bh=3XrBhJ7lFcCw9u4MVsQS//A6rOZ4Nmr3IhSO+twZxug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIrVcEEoSRcA77KNoyanwi3ys4weqnKXkBVKro4jYJ8YTsi9Dm2ibEAFzrz3qN2hPmL9Mti8SW7seoTUY2cubDK2nFMLYr3/Pjyqly/Vd5gPIKakxmYmv8DzEUI2l/b9p4f1SjhtLn7toWpdEjhOMPgENlDpPCPd9abzayg+rYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hTi6l/P5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK1tM060758;
	Wed, 31 Jan 2024 16:20:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739601;
	bh=1YUSJDF+znyudL9/WwRSORWM+cm2PVwYB2DPgs0ZaYU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hTi6l/P5C2NPqg6vQf12o1wOyHOl6v5Jxm7TN+Qd3oaoBR2tG/W2eX748unjJtzA1
	 ASJEJQE6KYw+bUVBWAuDZrtlUGyIkNTyxm42ICu6wIUQS/QNbhPhvjw0XJzev86EvO
	 BpwTFw9eA4n/ZhFBxvh12ho+mVqQDdp1aEMk68Bc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK1wi021515
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:01 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:20:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:20:00 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwx5102504;
	Wed, 31 Jan 2024 16:20:00 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 03/12] power: reset: Add TI-SCI reboot driver
Date: Wed, 31 Jan 2024 16:19:48 -0600
Message-ID: <20240131221957.213717-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131221957.213717-1-afd@ti.com>
References: <20240131221957.213717-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This reboot driver calls into firmware using TI-SCI to reboot the system.
We register the handler with low priority as we want PSCI to remain the
main way these devices are rebooted. This driver acts as a fallback if
PSCI is not able to reboot the system.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 MAINTAINERS                         |  1 +
 drivers/power/reset/Kconfig         |  7 ++++
 drivers/power/reset/Makefile        |  1 +
 drivers/power/reset/ti-sci-reboot.c | 63 +++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)
 create mode 100644 drivers/power/reset/ti-sci-reboot.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 45983bb174fe4..ee67ea497fc56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21758,6 +21758,7 @@ F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/firmware/ti_sci*
 F:	drivers/irqchip/irq-ti-sci-inta.c
 F:	drivers/irqchip/irq-ti-sci-intr.c
+F:	drivers/power/reset/ti-sci-reboot.c
 F:	drivers/reset/reset-ti-sci.c
 F:	drivers/soc/ti/ti_sci_inta_msi.c
 F:	drivers/pmdomain/ti/ti_sci_pm_domains.c
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fece990af4a75..d3e91e54cae24 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -205,6 +205,13 @@ config POWER_RESET_ST
 	help
 	  Reset support for STMicroelectronics boards.
 
+config POWER_RESET_TI_SCI
+	tristate "TI System Control Interface (TI-SCI) reboot driver"
+	depends on TI_SCI_PROTOCOL
+	help
+	  This enables the reboot driver support over TI System Control
+	  Interface available on some TI's SoCs.
+
 config POWER_RESET_TPS65086
 	bool "TPS65086 restart driver"
 	depends on MFD_TPS65086
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index a95d1bd275d18..881ca58a43b9c 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
+obj-$(CONFIG_POWER_RESET_TI_SCI) += ti-sci-reboot.o
 obj-$(CONFIG_POWER_RESET_TPS65086) += tps65086-restart.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
 obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
diff --git a/drivers/power/reset/ti-sci-reboot.c b/drivers/power/reset/ti-sci-reboot.c
new file mode 100644
index 0000000000000..400bd5d740f8b
--- /dev/null
+++ b/drivers/power/reset/ti-sci-reboot.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Texas Instrument's System Control Interface (TI-SCI) reboot driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *	Andrew Davis <afd@ti.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+#include <linux/soc/ti/ti_sci_protocol.h>
+
+static int ti_sci_reboot_handler(struct sys_off_data *data)
+{
+	const struct ti_sci_handle *sci = data->cb_data;
+	const struct ti_sci_core_ops *core_ops = &sci->ops.core_ops;
+
+	core_ops->reboot_device(sci);
+
+	return NOTIFY_DONE;
+}
+
+static int ti_sci_reboot_probe(struct platform_device *pdev)
+{
+	const struct ti_sci_handle *sci;
+	int err;
+
+	sci = devm_ti_sci_get_handle(&pdev->dev);
+	if (IS_ERR(sci))
+		return PTR_ERR(sci);
+
+	err = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_LOW,
+					    ti_sci_reboot_handler,
+					    (void *)sci);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Cannot register restart handler\n");
+
+	return 0;
+}
+
+static const struct of_device_id ti_sci_reboot_of_match[] = {
+	{ .compatible = "ti,sci-reboot", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ti_sci_reboot_of_match);
+
+static struct platform_driver ti_sci_reboot_driver = {
+	.probe = ti_sci_reboot_probe,
+	.driver = {
+		.name = "ti-sci-reboot",
+		.of_match_table = ti_sci_reboot_of_match,
+	},
+};
+module_platform_driver(ti_sci_reboot_driver);
+
+MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
+MODULE_DESCRIPTION("TI System Control Interface (TI SCI) Reboot driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2


