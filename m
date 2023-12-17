Return-Path: <linux-kernel+bounces-2604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DD815F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3947B21473
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA844399;
	Sun, 17 Dec 2023 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="l3irfuFF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29644C7C;
	Sun, 17 Dec 2023 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 00EB128C344;
	Sun, 17 Dec 2023 14:20:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1702819241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yoAgGvzxp2LXZX3HWE9kIBevrSNqm5WiSJMYva5oJ4=;
	b=l3irfuFFU8NH1Ngln2H8soa+NMwk0zv080srBnjsivIoPYPuw4n9UGNMLScevJaU0WGJzk
	D5iGRTWX6vKf9rTL2zIQ/BEozjfdZYbJtl5L3k9A+s7CsASe8S+vfjNKgjSbn0JiIorek6
	vwQco2ohz0CaL8JgVQA3j2wUBD2TGOM=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id D37C544AF99;
	Sun, 17 Dec 2023 14:20:40 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 4/5] input: add onkey driver for Marvell 88PM88X PMICs
Date: Sun, 17 Dec 2023 14:17:02 +0100
Message-ID: <20231217131838.7569-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

The Marvell 88PM88X PMICs provide onkey among other things. Add client
driver to handle it. The driver currently only provides a basic support
omitting additional functions found in the vendor version, such as long
onkey and GPIO integration.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/input/misc/88pm88x-onkey.c | 103 +++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig         |  10 +++
 drivers/input/misc/Makefile        |   1 +
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/input/misc/88pm88x-onkey.c

diff --git a/drivers/input/misc/88pm88x-onkey.c b/drivers/input/misc/88pm88x-onkey.c
new file mode 100644
index 000000000000..0d6056a3cab2
--- /dev/null
+++ b/drivers/input/misc/88pm88x-onkey.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/regmap.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#include <linux/mfd/88pm88x.h>
+
+struct pm88x_onkey {
+	struct input_dev *idev;
+	struct pm88x_chip *chip;
+	int irq;
+};
+
+static irqreturn_t pm88x_onkey_irq_handler(int irq, void *data)
+{
+	struct pm88x_onkey *onkey = data;
+	unsigned int val;
+	int ret = 0;
+
+	ret = regmap_read(onkey->chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_STATUS1, &val);
+	if (ret) {
+		dev_err(onkey->idev->dev.parent, "Failed to read status: %d\n", ret);
+		return IRQ_NONE;
+	}
+	val &= PM88X_ONKEY_STS1;
+
+	input_report_key(onkey->idev, KEY_POWER, val);
+	input_sync(onkey->idev);
+
+	return IRQ_HANDLED;
+}
+
+static int pm88x_onkey_probe(struct platform_device *pdev)
+{
+	struct pm88x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm88x_onkey *onkey;
+	int err;
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	onkey->chip = chip;
+
+	onkey->irq = platform_get_irq(pdev, 0);
+	if (onkey->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ\n");
+		return -EINVAL;
+	}
+
+	onkey->idev = devm_input_allocate_device(&pdev->dev);
+	if (!onkey->idev) {
+		dev_err(&pdev->dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	onkey->idev->name = "88pm88x-onkey";
+	onkey->idev->phys = "88pm88x-onkey/input0";
+	onkey->idev->id.bustype = BUS_I2C;
+	onkey->idev->dev.parent = &pdev->dev;
+	onkey->idev->evbit[0] = BIT_MASK(EV_KEY);
+	onkey->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
+
+	err = devm_request_threaded_irq(&pdev->dev, onkey->irq, NULL, pm88x_onkey_irq_handler,
+			IRQF_ONESHOT | IRQF_NO_SUSPEND, "onkey", onkey);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to request IRQ: %d\n", err);
+		return err;
+	}
+
+	err = input_register_device(onkey->idev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register input device: %d\n", err);
+		return err;
+	}
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	return 0;
+}
+
+static const struct of_device_id pm88x_onkey_of_match[] = {
+	{ .compatible = "marvell,88pm88x-onkey", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pm88x_onkey_of_match);
+
+static struct platform_driver pm88x_onkey_driver = {
+	.driver = {
+		.name = "88pm88x-onkey",
+		.of_match_table = of_match_ptr(pm88x_onkey_of_match),
+	},
+	.probe = pm88x_onkey_probe,
+};
+module_platform_driver(pm88x_onkey_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM88X onkey driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6ba984d7f0b1..fdfa3e23c3cf 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -33,6 +33,16 @@ config INPUT_88PM80X_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called 88pm80x_onkey.
 
+config INPUT_88PM88X_ONKEY
+	tristate "Marvell 88PM88X onkey support"
+	depends on MFD_88PM88X
+	help
+	  Support the onkey of Marvell 88PM88X PMICs as an input device
+	  reporting power button status.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 88pm88x-onkey.
+
 config INPUT_AB8500_PONKEY
 	tristate "AB8500 Pon (PowerOn) Key"
 	depends on AB8500_CORE
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 04296a4abe8e..eab7a364188c 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -7,6 +7,7 @@
 
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
 obj-$(CONFIG_INPUT_88PM80X_ONKEY)	+= 88pm80x_onkey.o
+obj-$(CONFIG_INPUT_88PM88X_ONKEY)	+= 88pm88x-onkey.o
 obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
 obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
 obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
-- 
2.43.0


