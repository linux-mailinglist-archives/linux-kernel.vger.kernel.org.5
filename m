Return-Path: <linux-kernel+bounces-29858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B124831499
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807811C22624
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C6A1BF21;
	Thu, 18 Jan 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQtLp/11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F21125B1;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566179; cv=none; b=OzVcgvtpyzZb3YpQ59RFhXA3rMYOO+SjSEWKHidZZpoR8z+fJrj34c0f/YyBRYxJAJTnUCpsCJTMSg9OatkNBet5zkmCUwEUdZ6qwCM2vIMmazXXatdL3F6+9xbxySx4qP+jkcNbrsuGRO5/l8hV5rWdEeptbw8gz6kbO9fFu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566179; c=relaxed/simple;
	bh=TYixwRJ/HLIf39is6KOuK1f7P0/ZpeuMCtRoeFDjtsw=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=rpQotcwiQoWXvXN03qPtX0IWwbgh0cL/s2m2L2XBm1h66nHkIgfVF1EAQRZ/qlcxsIGUuBeK4IJSGr+9+6MnzOEbdKGP5TX+szjgf6/X46ScMQHqRQsMKpKzvglBmKgvwqX10wr2d663rW77zx2CqZgKbpq8iCkd6U1HgkpRaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQtLp/11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9468C43142;
	Thu, 18 Jan 2024 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=TYixwRJ/HLIf39is6KOuK1f7P0/ZpeuMCtRoeFDjtsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OQtLp/11ggjE1tGUG7tLhl0bqUIzxanugjXsK4Ckk2RJSL+n9ffbhNaXJN2IWJ/2m
	 DVWygIz7MgqU93zDg92jIMvPSKd14mDC33tVfHSf8Pdrnc0tSSnD6QYt/4GNY9qCkO
	 t7MSreqEmA/BmDkcpLen2aCtegl1wQndxb4rWc5wqQykAXmPAptc+73ivH5L/3cMYu
	 PoZgbX6gtGi5s01JE9Awh+h2V7XExyJGZJvsbm40D6qmgAxSMxSanlds+VX9Rfvkqg
	 MKIpMn9hB6qA1kapB/d0voTuUzuP8CRnZ8omXNiEoIEpbzjNJDf93QCvh604cK+ML/
	 NihqPgHlmFNlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD60C47DBA;
	Thu, 18 Jan 2024 08:22:58 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:49 +0300
Subject: [PATCH v7 06/39] power: reset: Add a driver for the ep93xx reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-6-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=4433;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=KjqqsnfXxGMwFFM/StkMK0mGDkJJNduKtVKAsKoiuVY=; =?utf-8?q?b=3DR+zR+jDzp5ds?=
 =?utf-8?q?KcYdnxZSoxHcz7EqnXKeHmj34X3z8k4BM2SdU5VT/sQujPExLqOjX1z4H0fEwcsS?=
 9pJnur3cAjTrKQA34QfHKN8LfjK2A9qNf710t6pkI6+DMy37K8XL
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Implement the reset behaviour of the various EP93xx SoCS
in drivers/power/reset.

It used to be located in arch/arm/mach-ep93xx.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/reset/Kconfig          | 10 +++++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/ep93xx-restart.c | 84 ++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fece990af4a7..389d5a193e5d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -75,6 +75,16 @@ config POWER_RESET_BRCMSTB
 	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
+config POWER_RESET_EP93XX
+	bool "Cirrus EP93XX reset driver" if COMPILE_TEST
+	depends on MFD_SYSCON
+	default ARCH_EP93XX
+	help
+	  This driver provides restart support for Cirrus EP93XX SoC.
+
+	  Say Y here if you have a Cirrus EP93XX SoC and you wish
+	  to have restart support.
+
 config POWER_RESET_GEMINI_POWEROFF
 	bool "Cortina Gemini power-off driver"
 	depends on ARCH_GEMINI || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index a95d1bd275d1..10782d32e1da 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_POWER_RESET_ATC260X) += atc260x-poweroff.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
+obj-$(CONFIG_POWER_RESET_EP93XX) += ep93xx-restart.o
 obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
diff --git a/drivers/power/reset/ep93xx-restart.c b/drivers/power/reset/ep93xx-restart.c
new file mode 100644
index 000000000000..57cfb8620faf
--- /dev/null
+++ b/drivers/power/reset/ep93xx-restart.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Cirrus EP93xx SoC reset driver
+ *
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ */
+
+#include <linux/bits.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+
+#include <linux/soc/cirrus/ep93xx.h>
+
+#define EP93XX_SYSCON_DEVCFG		0x80
+#define EP93XX_SYSCON_DEVCFG_SWRST	BIT(31)
+
+struct ep93xx_restart {
+	struct ep93xx_regmap_adev *aux_dev;
+	struct notifier_block restart_handler;
+};
+
+static int ep93xx_restart_handle(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	struct ep93xx_restart *priv =
+		container_of(this, struct ep93xx_restart, restart_handler);
+	struct ep93xx_regmap_adev *aux = priv->aux_dev;
+
+	/* Issue the reboot */
+	aux->update_bits(aux->map, aux->lock, EP93XX_SYSCON_DEVCFG,
+			 EP93XX_SYSCON_DEVCFG_SWRST, EP93XX_SYSCON_DEVCFG_SWRST);
+	aux->update_bits(aux->map, aux->lock, EP93XX_SYSCON_DEVCFG,
+			 EP93XX_SYSCON_DEVCFG_SWRST, 0);
+
+	return NOTIFY_DONE;
+}
+
+static int ep93xx_reboot_probe(struct auxiliary_device *adev,
+			       const struct auxiliary_device_id *id)
+{
+	struct ep93xx_regmap_adev *rdev = to_ep93xx_regmap_adev(adev);
+	struct device *dev = &adev->dev;
+	struct ep93xx_restart *priv;
+	int err;
+
+	if (!rdev->update_bits)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->aux_dev = rdev;
+
+	priv->restart_handler.notifier_call = ep93xx_restart_handle;
+	priv->restart_handler.priority = 128;
+
+	err = register_restart_handler(&priv->restart_handler);
+	if (err)
+		return dev_err_probe(dev, err, "can't register restart notifier\n");
+
+	return 0;
+}
+
+static const struct auxiliary_device_id ep93xx_reboot_ids[] = {
+	{
+		.name = "soc_ep93xx.reset-ep93xx",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, ep93xx_reboot_ids);
+
+static struct auxiliary_driver ep93xx_reboot_driver = {
+	.probe		= ep93xx_reboot_probe,
+	.id_table	= ep93xx_reboot_ids,
+};
+module_auxiliary_driver(ep93xx_reboot_driver);

-- 
2.41.0


