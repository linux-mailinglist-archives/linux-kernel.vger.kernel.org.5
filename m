Return-Path: <linux-kernel+bounces-8002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1281B072
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6FB285949
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D16200BD;
	Thu, 21 Dec 2023 08:37:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF6208B9;
	Thu, 21 Dec 2023 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id D96D024E2A8;
	Thu, 21 Dec 2023 16:36:57 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:57 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:51 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, "Ley
 Foon Tan" <leyfoon.tan@starfivetech.com>, Jianlong Huang
	<jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Drew Fustini" <drew@beagleboard.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH 4/6] pinctrl: starfive: jh8100: add pinctrl driver for sys_gmac domain
Date: Thu, 21 Dec 2023 16:36:20 +0800
Message-ID: <20231221083622.3445726-5-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add pinctrl driver for sys_gmac domain.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              |  12 ++
 drivers/pinctrl/starfive/Makefile             |   1 +
 .../pinctrl-starfive-jh8100-sys-gmac.c        | 164 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   2 +
 4 files changed, 179 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-=
gmac.c

diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/=
Kconfig
index d78f161a636c..bb1fb3788d5b 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -82,3 +82,15 @@ config PINCTRL_STARFIVE_JH8100_SYS_WEST
 	  This also provides an interface to the GPIO pins not used by other
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
+
+config PINCTRL_STARFIVE_JH8100_SYS_GMAC
+	tristate "StarFive JH8100 SoC System IOMUX-GMAC pinctrl and GPIO driver=
"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support system iomux-gmac pin control on the StarFive=
 JH8100 SoC.
+	  This also provides a syscon interface to configure the GMAC1 voltage =
level for RGMII(1.8V
+	  2.5V), GMII(2.5V/3.3V), to configure the SDIO1 voltage level to suppo=
rt the 3.3/1.8V voltage
+	  switching in high-speed mode, and configure the GMAC1 network interfa=
ce and timing (slew rate).
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive=
/Makefile
index 784465157ae2..236a693a8aef 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_AON)	+=3D pinctrl-st=
arfive-jh7110-aon.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+=3D pinctrl-starfive-jh8100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+=3D pinctrl-starfive-jh8=
100-sys-east.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_WEST)	+=3D pinctrl-starfive-jh8=
100-sys-west.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_GMAC)	+=3D pinctrl-starfive-jh8=
100-sys-gmac.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c =
b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c
new file mode 100644
index 000000000000..dbbac86dd265
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-gmac.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC sys gmac controller
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "../core.h"
+#include "../pinctrl-utils.h"
+#include "../pinmux.h"
+#include "../pinconf.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_SYS_G_NGPIO			0
+#define JH8100_SYS_G_GC_BASE			64
+
+static const struct pinctrl_pin_desc jh8100_sys_gmac_pins[] =3D {
+	PINCTRL_PIN(PAD_GMAC1_MDC,	"SYS_G_GMAC1_MDC"),
+	PINCTRL_PIN(PAD_GMAC1_MDIO,	"SYS_G_GMAC1_MDIO"),
+	PINCTRL_PIN(PAD_GMAC1_RXD0,	"SYS_G_GMAC1_RXD0"),
+	PINCTRL_PIN(PAD_GMAC1_RXD1,	"SYS_G_GMAC1_RXD1"),
+	PINCTRL_PIN(PAD_GMAC1_RXD2,	"SYS_G_GMAC1_RXD2"),
+	PINCTRL_PIN(PAD_GMAC1_RXD3,	"SYS_G_GMAC1_RXD3"),
+	PINCTRL_PIN(PAD_GMAC1_RXDV,	"SYS_G_GMAC1_RXDV"),
+	PINCTRL_PIN(PAD_GMAC1_RXC,	"SYS_G_GMAC1_RXC"),
+	PINCTRL_PIN(PAD_GMAC1_TXD0,	"SYS_G_GMAC1_TXD0"),
+	PINCTRL_PIN(PAD_GMAC1_TXD1,	"SYS_G_GMAC1_TXD1"),
+	PINCTRL_PIN(PAD_GMAC1_TXD2,	"SYS_G_GMAC1_TXD2"),
+	PINCTRL_PIN(PAD_GMAC1_TXD3,	"SYS_G_GMAC1_TXD3"),
+	PINCTRL_PIN(PAD_GMAC1_TXEN,	"SYS_G_GMAC1_TXEN"),
+	PINCTRL_PIN(PAD_GMAC1_TXC,	"SYS_G_GMAC1_TXC")
+};
+
+struct jh8100_sys_gmac_func_sel {
+	u16 offset;
+	u8 shift;
+	u8 max;
+};
+
+static const struct jh8100_sys_gmac_func_sel
+	jh8100_sys_gmac_func_sel[ARRAY_SIZE(jh8100_sys_gmac_pins)] =3D {
+	[PAD_GMAC1_RXC]    =3D { 0x048, 0, 2 },
+};
+
+static void jh8100_sys_gmac_set_function(struct jh8100_pinctrl *sfp,
+					 unsigned int pin, u32 func)
+{
+	const struct jh8100_sys_gmac_func_sel *fs =3D &jh8100_sys_gmac_func_sel=
[pin];
+	unsigned long flags;
+	void __iomem *reg;
+	u32 mask;
+
+	if (!fs->offset)
+		return;
+
+	if (func > fs->max)
+		return;
+
+	reg =3D sfp->base + fs->offset;
+	func =3D func << fs->shift;
+	mask =3D 0x3U << fs->shift;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	func |=3D readl_relaxed(reg) & ~mask;
+	writel_relaxed(func, reg);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_sys_gmac_set_one_pin_mux(struct jh8100_pinctrl *sfp,
+					   unsigned int pin,
+					   unsigned int din, u32 dout,
+					   u32 doen, u32 func)
+{
+	jh8100_sys_gmac_set_function(sfp, pin, func);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_sys_gmac_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i =3D 0; i < JH8100_SYS_GMAC_REG_NUM; i++)
+		sfp->jh8100_sys_gmac_regs[i] =3D readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_sys_gmac_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i =3D 0; i < JH8100_SYS_GMAC_REG_NUM; i++)
+		writel_relaxed(sfp->jh8100_sys_gmac_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_sys_gmac_pinctrl_dev_pm_ops,
+			 jh8100_sys_gmac_pinctrl_suspend,
+			 jh8100_sys_gmac_pinctrl_resume);
+
+static const struct jh8100_pinctrl_soc_info jh8100_sys_gmac_pinctrl_info=
 =3D {
+	.pins		=3D jh8100_sys_gmac_pins,
+	.npins		=3D ARRAY_SIZE(jh8100_sys_gmac_pins),
+	.ngpios		=3D JH8100_SYS_G_NGPIO,
+	.gc_base	=3D JH8100_SYS_G_GC_BASE,
+	.jh8100_set_one_pin_mux  =3D jh8100_sys_gmac_set_one_pin_mux,
+};
+
+static const struct of_device_id jh8100_sys_gmac_pinctrl_of_match[] =3D =
{
+	{
+		.compatible =3D "starfive,jh8100-sys-pinctrl-gmac",
+		.data =3D &jh8100_sys_gmac_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_sys_gmac_pinctrl_of_match);
+
+static struct platform_driver jh8100_sys_gmac_pinctrl_driver =3D {
+	.probe =3D jh8100_pinctrl_probe,
+	.driver =3D {
+		.name =3D "starfive-jh8100-sys-pinctrl-gmac",
+#ifdef CONFIG_PM_SLEEP
+		.pm =3D &jh8100_sys_gmac_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table =3D jh8100_sys_gmac_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_sys_gmac_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH8100 SoC sys gmac =
controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers=
/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 6264931ddb82..43b62609fa3e 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -15,6 +15,7 @@
=20
 #define JH8100_SYS_WEST_REG_NUM		44
 #define JH8100_SYS_EAST_REG_NUM		116
+#define JH8100_SYS_GMAC_REG_NUM		19
=20
 struct jh8100_pinctrl {
 	struct device *dev;
@@ -28,6 +29,7 @@ struct jh8100_pinctrl {
 	const struct jh8100_pinctrl_soc_info *info;
 	unsigned int jh8100_sys_west_regs[JH8100_SYS_WEST_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_EAST_REG_NUM];
+	unsigned int jh8100_sys_gmac_regs[JH8100_SYS_GMAC_REG_NUM];
 	/* wakeup */
 	int wakeup_gpio;
 	int wakeup_irq;
--=20
2.25.1


