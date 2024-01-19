Return-Path: <linux-kernel+bounces-31190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAEF832A51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AA41C233E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5A52F81;
	Fri, 19 Jan 2024 13:25:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664831E48F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670739; cv=none; b=YwBARdLhWucBHpeYZvSISkmvtLEUCIZpVLj/sFczdsWNlCtVIiIsgRbYlJclb2/uTINhQt0ryn4rGMDhe5FUWfE7UpiRHCpu5f0p5hBR4P9sZxCULZTjil1z3lalSL7PYkh61qPhHR3RmE7mutnM3gHKRVUQ1Rco7xQ3odfu/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670739; c=relaxed/simple;
	bh=C3KOqcCPboHE8CVljWUDfdheWimD/KSO18sHrtBids4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzZkw+WXm4Bnb4+pPKmELXXZy1ud0MPAaXlgv7jvjsPXDc16MIvXhaAkqoHrhw/z37C4q0/aHZzPz+pYstTZ6M/dhmYWoQScd64VL79bsV1P4kUt8jzOJQ2tflEc1xmgx8i835Vkv4Oa/dB+k3sinm82NUS15UhaFiLL6NECExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos7-00074J-C2; Fri, 19 Jan 2024 14:25:23 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-000viN-8m; Fri, 19 Jan 2024 14:25:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-00F98M-0b;
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
Subject: [RFC PATCH v1 5/7] power: reset: add PSCR NVMEM Driver for Storing Power State Change Reasons
Date: Fri, 19 Jan 2024 14:25:19 +0100
Message-Id: <20240119132521.3609945-6-o.rempel@pengutronix.de>
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

This driver utilizes the Power State Change Reasons (PSCR) framework to
store specific power state change information, such as shutdown or
reboot reasons, into a designated non-volatile memory (NVMEM) cell.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/power/reset/Kconfig      |  11 ++++
 drivers/power/reset/Makefile     |   1 +
 drivers/power/reset/pscr-nvmem.c | 100 +++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/power/reset/pscr-nvmem.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index da76e84302b9..a110dff599af 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -324,3 +324,14 @@ menuconfig PSCR
       timeouts.
 
       If unsure, say N.
+
+if PSCR
+
+config PSCR_NVMEM
+	tristate "Generic NVMEM-based Power State Change Reason Tracking"
+	depends on OF
+	help
+	  Enabling this option adds support for storing power state change
+	  reasons in a NVMEM cell.
+
+endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index d9d744302c68..e7985d81ac8a 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_PSCR) += pscr.o
+obj-$(CONFIG_PSCR_NVMEM) += pscr-nvmem.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/pscr-nvmem.c b/drivers/power/reset/pscr-nvmem.c
new file mode 100644
index 000000000000..74048341b7d7
--- /dev/null
+++ b/drivers/power/reset/pscr-nvmem.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Vaisala Oyj. All rights reserved.
+// Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+/*
+ * Based on drivers/power/reset/nvmem-reboot-mode.c
+ * Copyright (c) Vaisala Oyj. All rights reserved.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pscr.h>
+
+struct pscr_nvmem {
+	struct pscr_driver pscr_drv;
+	struct nvmem_cell *cell;
+	size_t max_magic_bytes;
+};
+
+static int pscr_nvmem_write(struct pscr_driver *pscr_drv, u32 magic)
+{
+	struct pscr_nvmem *priv = container_of(pscr_drv, struct pscr_nvmem,
+					       pscr_drv);
+	size_t size = min(priv->max_magic_bytes, sizeof(magic));
+	int ret;
+
+	ret = nvmem_cell_write(priv->cell, &magic, size);
+	if (ret < 0)
+		dev_err(pscr_drv->dev, "update reason bits failed: %pe\n",
+			ERR_PTR(ret));
+
+	return ret;
+}
+
+static int pscr_nvmem_probe(struct platform_device *pdev)
+{
+	const char *pscr = "pscr";
+	struct pscr_nvmem *priv;
+	size_t bytes, bits, magic_bits;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pscr_drv.dev = &pdev->dev;
+	priv->pscr_drv.write = pscr_nvmem_write;
+
+	priv->cell = devm_nvmem_cell_get(&pdev->dev, pscr);
+	if (IS_ERR(priv->cell))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->cell),
+				     "failed to get the nvmem %s cell\n", pscr);
+
+	ret = nvmem_cell_get_size(priv->cell, &bytes, &bits);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to get the nvmem %s size\n",
+				     pscr);
+
+	if (!bytes || bytes > sizeof(u32) || bits > 32)
+		return dev_err_probe(&pdev->dev, -EINVAL, "invalid nvmem %s size. bytes: %zu, bits: %zu\n",
+				     pscr, bytes, bits);
+
+	ret = devm_pscr_register(&pdev->dev, &priv->pscr_drv);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register pscr driver\n");
+
+	magic_bits = fls(priv->pscr_drv.max_magic);
+	priv->max_magic_bytes = DIV_ROUND_UP(magic_bits, 8);
+
+	if (!bits)
+		bits = bytes * 8;
+
+	if (magic_bits > bits)
+		return dev_err_probe(&pdev->dev, -EINVAL, "provided magic can't fit into nvmem %s. bytes: %zu, bits: %zu, magic_bits: %zu\n",
+				     pscr, bytes, bits, magic_bits); 
+
+	return ret;
+}
+
+static const struct of_device_id pscr_nvmem_of_match[] = {
+	{ .compatible = "pscr-nvmem" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pscr_nvmem_of_match);
+
+static struct platform_driver pscr_nvmem_driver = {
+	.probe = pscr_nvmem_probe,
+	.driver = {
+		.name = "pscr-nvmem",
+		.of_match_table = pscr_nvmem_of_match,
+	},
+};
+module_platform_driver(pscr_nvmem_driver);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("NVMEM Driver for Power State Change Reason Tracking");
+MODULE_LICENSE("GPL v2");
-- 
2.39.2


