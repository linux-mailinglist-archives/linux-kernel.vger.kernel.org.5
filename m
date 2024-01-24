Return-Path: <linux-kernel+bounces-36966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C783A997
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDAC285D60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EF3657AC;
	Wed, 24 Jan 2024 12:22:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040A63104
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098949; cv=none; b=WvPgReGoazWyTutxvim7smk99Acsp40L+tVJpPc0bzFOHN05FR9N3COq/jfDxdjSfboKeBl6Bd+2eBCwa+cgildokH+t8YhHmw/u6TUnmuWYvYqTscaqY4cCrlndYVnzWvr/rahWzz9zncfJ4IZSq9F27eLw5HaRLkuNSXubBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098949; c=relaxed/simple;
	bh=20N1VN4Z4ICpskuEnxLNHaytZDaOloomTZFu/N940iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwN5JCbzdd9d69HqCHeveUs+3cX5WhV7nuedvwf2yd91m2KVcDmGwfwuS7X+pcWM7Xh8gRHYp0g66GQCE9k7oP4acPD+sCdoaYZCHhNk2qIDQc28ThwjLjbOWcDwHKpGvAHR1ONYuG9V5KL/NostVFoC+8nsSymYN00MlztMcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGd-0007oA-1C; Wed, 24 Jan 2024 13:22:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-0023Zi-2q; Wed, 24 Jan 2024 13:22:06 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGb-00341i-3B;
	Wed, 24 Jan 2024 13:22:05 +0100
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
Subject: [PATCH v2 6/8] power: reset: add PSCR NVMEM Driver for Recording Power State Change Reasons
Date: Wed, 24 Jan 2024 13:22:02 +0100
Message-Id: <20240124122204.730370-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124122204.730370-1-o.rempel@pengutronix.de>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
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

This driver utilizes the Power State Change Reasons Recording (PSCRR)
framework to store specific power state change information, such as
shutdown or reboot reasons, into a designated non-volatile memory
(NVMEM) cell.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/power/reset/Kconfig       |  11 +++
 drivers/power/reset/Makefile      |   1 +
 drivers/power/reset/pscrr-nvmem.c | 121 ++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/power/reset/pscrr-nvmem.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c6ce7e647048..8e50e495ef98 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -324,3 +324,14 @@ menuconfig PSCRR
       timeouts.
 
       If unsure, say N.
+
+if PSCRR
+
+config PSCRR_NVMEM
+	tristate "Generic NVMEM-based Power State Change Reason Recorder"
+	depends on OF
+	help
+	  Enabling this option adds support for recording power state change
+	  reasons in a NVMEM cell.
+
+endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index e618c34a30f9..3860dbbacb23 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_PSCRR) += pscrr.o
+obj-$(CONFIG_PSCRR_NVMEM) += pscrr-nvmem.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/pscrr-nvmem.c b/drivers/power/reset/pscrr-nvmem.c
new file mode 100644
index 000000000000..fe9053b78b79
--- /dev/null
+++ b/drivers/power/reset/pscrr-nvmem.c
@@ -0,0 +1,121 @@
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
+#include <linux/pscrr.h>
+
+struct pscrr_nvmem {
+	struct pscrr_device pscrr_dev;
+	struct nvmem_cell *cell;
+	size_t max_magic_bytes;
+};
+
+static int pscrr_nvmem_write(struct pscrr_device *pscrr_dev, u32 magic)
+{
+	struct pscrr_nvmem *priv = container_of(pscrr_dev, struct pscrr_nvmem,
+						pscrr_dev);
+	size_t size = min(priv->max_magic_bytes, sizeof(magic));
+	int ret;
+
+	ret = nvmem_cell_write(priv->cell, &magic, size);
+	if (ret < 0) {
+		dev_err(pscrr_dev->dev, "update reason bits failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pscrr_nvmem_read(struct pscrr_device *pscrr_dev, u32 *magic)
+{
+	struct pscrr_nvmem *priv = container_of(pscrr_dev, struct pscrr_nvmem,
+						pscrr_dev);
+	size_t len;
+	void *buf;
+
+	buf = nvmem_cell_read(priv->cell, &len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	*magic = 0;
+	memcpy(magic, buf, min(len, sizeof(*magic)));
+	kfree(buf);
+
+	return 0;
+}
+
+static int pscrr_nvmem_probe(struct platform_device *pdev)
+{
+	size_t bytes, bits, magic_bits;
+	struct pscrr_nvmem *priv;
+	const char *pscr = "pscr";
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pscrr_dev.dev = &pdev->dev;
+	priv->pscrr_dev.write = pscrr_nvmem_write;
+	priv->pscrr_dev.read = pscrr_nvmem_read;
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
+	ret = devm_pscrr_register(&pdev->dev, &priv->pscrr_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register pscr driver\n");
+
+	magic_bits = fls(priv->pscrr_dev.max_magic_val);
+	priv->max_magic_bytes = DIV_ROUND_UP(magic_bits, 8);
+
+	if (!bits)
+		bits = bytes * 8;
+
+	if (magic_bits > bits)
+		return dev_err_probe(&pdev->dev, -EINVAL, "provided magic can't fit into nvmem %s. bytes: %zu, bits: %zu, magic_bits: %zu\n",
+				     pscr, bytes, bits, magic_bits);
+
+	return handle_last_pscr(&priv->pscrr_dev);
+}
+
+static const struct of_device_id pscrr_nvmem_of_match[] = {
+	{ .compatible = "pscrr-nvmem" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pscrr_nvmem_of_match);
+
+static struct platform_driver pscrr_nvmem_driver = {
+	.probe = pscrr_nvmem_probe,
+	.driver = {
+		.name = "pscrr-nvmem",
+		.of_match_table = pscrr_nvmem_of_match,
+	},
+};
+module_platform_driver(pscrr_nvmem_driver);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("NVMEM Driver for Power State Change Reason Recording");
+MODULE_LICENSE("GPL");
-- 
2.39.2


