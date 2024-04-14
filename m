Return-Path: <linux-kernel+bounces-144092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824588A41B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD621F2161A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA0F3613E;
	Sun, 14 Apr 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeJT/GkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452823777;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089051; cv=none; b=tdWhS89FwY+E3qIqIbZ0lgJVcNXRkyDCPidbrK9lah1mat3G2UH0Q5aXIF9i5rerwgnXn9WZEJPiWklY0HfBw3SHqJ4Wm26oePjcymkoaiKdbHlFbEv99cLPQEQ7br36FnECV2JhbN3I9zhmEztbk539wvPr/bHFRH+OnUle21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089051; c=relaxed/simple;
	bh=AfrSKi8c0Ro/mYC7hepPMVGRgaWaNvzbFUbpZzEtzaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pH9du/vADy4ix/kaIOm2+GRW9HkP4e7iVAVzkrVtpf3oT1V1tOPPw1KKYGTmdYI7gFxM5YEqN2Ibev/uxeGB4u4GK5EtedqVY2aR1jxHcCPlNBsNVdyJ2aF24C2uVMJPEFUobs4GcVNE5wpnez+L4JXHqwJhldBpFAHA/2MNg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeJT/GkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCCB4C4AF08;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713089050;
	bh=AfrSKi8c0Ro/mYC7hepPMVGRgaWaNvzbFUbpZzEtzaI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SeJT/GkAtYkHSWo/qzRgOMDGI1oekyTrkV7W2riwSSFGyl5/4OhaIN2sXzt29AMrV
	 Cm78v0CIcGE8jBW4eY5Kx4v+9wVEIFR61Clkmyz1pBZO2ber4Blaynd7lHXPsDuHDL
	 Gq4UHXfWtwJVHGczmkVVyqhTSNrLl4qpQD0zwI7D8DVI69DIJIUaKlMJYJppYadCVT
	 ygY8sOplCT5tSlrGO01zIUtXfmhTqA2cRMMtRYsoZ48+ZiHK7f93pvJ4SM4anAeTTU
	 YLRP5caue90DcPaKpId23XZISMe180Hkq/0H6L9a+ZXs8BpbN9vW5Qo6eBrz1DGO6j
	 fUFOL6SCSjgOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D56C04FF8;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Sun, 14 Apr 2024 13:03:51 +0300
Subject: [PATCH v2 4/4] soc: Add SoC driver for Cirrus ep93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240408-ep93xx-clk-v2-4-9c5629dec2dd@maquefel.me>
References: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
In-Reply-To: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713089049; l=10093;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=vUfW9ABHjOjJ7t7ElDmTEYZlrPl2gIk3xRvTm9p+tiQ=;
 b=r9f7vgQwd51oVDP27fH9yH12Bc1DgR9uCfi7W4G+Abh5La/056/TCJXe1CD8pVbVx3h/FqmpSOFA
 IlUnB3D9ANss6aTsnC0zWn8Q+bM71hbOhn7nFSIuIcHaLf/Vef+I
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add an SoC driver for the ep93xx. Currently there is only one thing
not fitting into any other framework, and that is the swlock setting.

Used for clock settings, pinctrl and restart.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/Kconfig             |   1 +
 drivers/soc/Makefile            |   1 +
 drivers/soc/cirrus/Kconfig      |  17 +++
 drivers/soc/cirrus/Makefile     |   2 +
 drivers/soc/cirrus/soc-ep93xx.c | 252 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 273 insertions(+)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 5d924e946507..6a8daeb8c4b9 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -7,6 +7,7 @@ source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
+source "drivers/soc/cirrus/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/hisilicon/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index ba8f5b5460e1..5f88bd3aefe3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,6 +8,7 @@ obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
 obj-$(CONFIG_SOC_CANAAN)	+= canaan/
+obj-$(CONFIG_EP93XX_SOC)        += cirrus/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
new file mode 100644
index 000000000000..f2fd0e16a196
--- /dev/null
+++ b/drivers/soc/cirrus/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+if ARCH_EP93XX
+
+config EP93XX_SOC
+	bool "Cirrus EP93xx chips SoC"
+	select SOC_BUS
+	select AUXILIARY_BUS
+	default y if !EP93XX_SOC_COMMON
+	help
+	  Enable support SoC for Cirrus EP93xx chips.
+
+	  Cirrus EP93xx chips have several swlocked registers,
+	  this driver provides locked access for reset, pinctrl
+	  and clk devices implemented as auxiliary devices.
+
+endif
diff --git a/drivers/soc/cirrus/Makefile b/drivers/soc/cirrus/Makefile
new file mode 100644
index 000000000000..9e6608b67f76
--- /dev/null
+++ b/drivers/soc/cirrus/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y	+= soc-ep93xx.o
diff --git a/drivers/soc/cirrus/soc-ep93xx.c b/drivers/soc/cirrus/soc-ep93xx.c
new file mode 100644
index 000000000000..3e79b3b13aef
--- /dev/null
+++ b/drivers/soc/cirrus/soc-ep93xx.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SoC driver for Cirrus EP93xx chips.
+ * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/core.c
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
+ *
+ * Thanks go to Michael Burian and Ray Lehtiniemi for their key
+ * role in the ep93xx Linux community.
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/sys_soc.h>
+
+#include <linux/soc/cirrus/ep93xx.h>
+
+#define EP93XX_SYSCON_DEVCFG		0x80
+
+#define EP93XX_SWLOCK_MAGICK		0xaa
+#define EP93XX_SYSCON_SWLOCK		0xc0
+#define EP93XX_SYSCON_SYSCFG		0x9c
+#define EP93XX_SYSCON_SYSCFG_REV_MASK	GENMASK(31, 28)
+#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	28
+
+struct ep93xx_map_info {
+	spinlock_t lock;
+	void __iomem *base;
+	struct regmap *map;
+};
+
+/*
+ * EP93xx System Controller software locked register write
+ *
+ * Logic safeguards are included to condition the control signals for
+ * power connection to the matrix to prevent part damage. In addition, a
+ * software lock register is included that must be written with 0xAA
+ * before each register write to change the values of the four switch
+ * matrix control registers.
+ */
+static void ep93xx_regmap_write(struct regmap *map, spinlock_t *lock,
+				 unsigned int reg, unsigned int val)
+{
+	guard(spinlock_irqsave)(lock);
+
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	regmap_write(map, reg, val);
+}
+
+static void ep93xx_regmap_update_bits(struct regmap *map, spinlock_t *lock,
+				      unsigned int reg, unsigned int mask,
+				      unsigned int val)
+{
+	guard(spinlock_irqsave)(lock);
+
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	/* force write is required to clear swlock if no changes are made */
+	regmap_update_bits_base(map, reg, mask, val, NULL, false, true);
+}
+
+static void ep93xx_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void ep93xx_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct ep93xx_regmap_adev *rdev = to_ep93xx_regmap_adev(adev);
+
+	kfree(rdev);
+}
+
+static struct auxiliary_device __init *ep93xx_adev_alloc(struct device *parent,
+							 const char *name,
+							 struct ep93xx_map_info *info)
+{
+	struct ep93xx_regmap_adev *rdev __free(kfree) = NULL;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	rdev->map = info->map;
+	rdev->base = info->base;
+	rdev->lock = &info->lock;
+	rdev->write = ep93xx_regmap_write;
+	rdev->update_bits = ep93xx_regmap_update_bits;
+
+	adev = &rdev->adev;
+	adev->name = name;
+	adev->dev.parent = parent;
+	adev->dev.release = ep93xx_adev_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &no_free_ptr(rdev)->adev;
+}
+
+static int __init ep93xx_controller_register(struct device *parent, const char *name,
+					     struct ep93xx_map_info *info)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = ep93xx_adev_alloc(parent, name, info);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, ep93xx_unregister_adev, adev);
+}
+
+static unsigned int __init ep93xx_soc_revision(struct regmap *map)
+{
+	unsigned int val;
+
+	regmap_read(map, EP93XX_SYSCON_SYSCFG, &val);
+	val &= EP93XX_SYSCON_SYSCFG_REV_MASK;
+	val >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
+	return val;
+}
+
+static const char __init *ep93xx_get_soc_rev(unsigned int rev)
+{
+	switch (rev) {
+	case EP93XX_CHIP_REV_D0:
+		return "D0";
+	case EP93XX_CHIP_REV_D1:
+		return "D1";
+	case EP93XX_CHIP_REV_E0:
+		return "E0";
+	case EP93XX_CHIP_REV_E1:
+		return "E1";
+	case EP93XX_CHIP_REV_E2:
+		return "E2";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *pinctrl_names[] __initconst = {
+	"pinctrl-ep9301",	/* EP93XX_9301_SOC */
+	"pinctrl-ep9307",	/* EP93XX_9307_SOC */
+	"pinctrl-ep9312",	/* EP93XX_9312_SOC */
+};
+
+static int __init ep93xx_syscon_probe(struct platform_device *pdev)
+{
+	enum ep93xx_soc_model model;
+	struct ep93xx_map_info *map_info;
+	struct soc_device_attribute *attrs;
+	struct soc_device *soc_dev;
+	struct device *dev = &pdev->dev;
+	struct regmap *map;
+	void __iomem *base;
+	unsigned int rev;
+	int ret;
+
+	model = (enum ep93xx_soc_model)(uintptr_t)device_get_match_data(dev);
+
+	map = device_node_to_regmap(dev->of_node);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	attrs = devm_kzalloc(dev, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	rev = ep93xx_soc_revision(map);
+
+	attrs->machine = of_flat_dt_get_machine_name();
+	attrs->family = "Cirrus Logic EP93xx";
+	attrs->revision = ep93xx_get_soc_rev(rev);
+
+	soc_dev = soc_device_register(attrs);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	map_info = devm_kzalloc(dev, sizeof(*map_info), GFP_KERNEL);
+	if (!map_info)
+		return -ENOMEM;
+
+	spin_lock_init(&map_info->lock);
+	map_info->map = map;
+	map_info->base = base;
+
+	ret = ep93xx_controller_register(dev, pinctrl_names[model], map_info);
+	if (ret)
+		dev_err(dev, "registering pinctrl controller failed\n");
+
+	/*
+	 * EP93xx SSP clock rate was doubled in version E2. For more information
+	 * see section 6 "2x SSP (Synchronous Serial Port) Clock – Revision E2 only":
+	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
+	 */
+	if (rev == EP93XX_CHIP_REV_E2)
+		ret = ep93xx_controller_register(dev, "clk-ep93xx.e2", map_info);
+	else
+		ret = ep93xx_controller_register(dev, "clk-ep93xx", map_info);
+	if (ret)
+		dev_err(dev, "registering clock controller failed\n");
+
+	ret = ep93xx_controller_register(dev, "reset-ep93xx", map_info);
+	if (ret)
+		dev_err(dev, "registering reset controller failed\n");
+
+	return 0;
+}
+
+static const struct of_device_id ep9301_syscon_of_device_ids[] = {
+	{ .compatible	= "cirrus,ep9301-syscon", .data = (void *)EP93XX_9301_SOC },
+	{ .compatible	= "cirrus,ep9302-syscon", .data = (void *)EP93XX_9301_SOC },
+	{ .compatible	= "cirrus,ep9307-syscon", .data = (void *)EP93XX_9307_SOC },
+	{ .compatible	= "cirrus,ep9312-syscon", .data = (void *)EP93XX_9312_SOC },
+	{ .compatible	= "cirrus,ep9315-syscon", .data = (void *)EP93XX_9312_SOC },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ep9301_syscon_driver = {
+	.driver = {
+		.name = "ep9301-syscon",
+		.of_match_table = ep9301_syscon_of_device_ids,
+	},
+};
+builtin_platform_driver_probe(ep9301_syscon_driver, ep93xx_syscon_probe);

-- 
2.41.0



