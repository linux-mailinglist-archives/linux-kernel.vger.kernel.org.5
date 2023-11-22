Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258337F40E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjKVJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjKVJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0C29E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 959CCC433CD;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643674;
        bh=kROALI7H7XlG/WWOBl5FDyzSKHXAe+i+E4cXdab3Czk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=e0tHitLS4h5IHETWAfwspRr3KI7FOmv+dwAwdB0BrSmcVoYGYJYCo97kutZngwXJp
         59CHz83ILVC85uwgxaDiBmkCsiElCv6lXpM+RG9JoplJ7Y/DxMvyMa98exXkMMn7LJ
         Sf1fWCPAYQzj7nlK2QzEQznotJ5rf6rl58gs/0pSzgiT3o/+LS+j4DUvMpSEiy6IJG
         JgrkEC7obCLgv8kykRXWrjxEjWN8eyz0CtrnGtWvggwpqLCwXKlXntokFvdB5H9Trw
         0KtYET0EPJrnMikS+lmmEiAFGZaU8wTZo8vi/DIh1zT130y516cPTaakSMUTX+TKx7
         OFDMUONQBo+lA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 82F40C072A2;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 11:59:43 +0300
Subject: [PATCH v5 05/39] power: reset: Add a driver for the ep93xx reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-5-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=4341;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2dRIKOLWszPxi+9b0FTS7OAA+oaoyJlFBwr1qUznIKk=; =?utf-8?q?b=3D9RJkRy13Dv8E?=
 =?utf-8?q?S+jAii5tOGyQheT+HkcqYmmkQB8FrdGlAmN94PD1tifflc69nnoevJImZ+Pbp3Ev?=
 Ubzf72orAeEIpbg6sptDITMSI1Z1XeMrQuGpZndlqZe3fjJjG/dJ
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Implement the reset behaviour of the various EP93xx SoCS in drivers/power/reset.

It used to be located in arch/arm/mach-ep93xx.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/reset/Kconfig          | 10 +++++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/ep93xx-restart.c | 81 ++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

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
index 000000000000..838dbedc1dc4
--- /dev/null
+++ b/drivers/power/reset/ep93xx-restart.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Cirrus EP93xx SoC reset driver
+ *
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
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

