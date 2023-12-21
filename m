Return-Path: <linux-kernel+bounces-8001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 182CB81B06F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E1D1F23670
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D311A712;
	Thu, 21 Dec 2023 08:36:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267F199B7;
	Thu, 21 Dec 2023 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 625798068;
	Thu, 21 Dec 2023 16:36:51 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:51 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:44 +0800
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
Subject: [RFC PATCH 3/6] pinctrl: starfive: jh8100: add pinctrl driver for sys_west domain
Date: Thu, 21 Dec 2023 16:36:19 +0800
Message-ID: <20231221083622.3445726-4-yuklin.soo@starfivetech.com>
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

Add pinctrl driver for sys_west domain.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              |  12 +
 drivers/pinctrl/starfive/Makefile             |   1 +
 .../pinctrl-starfive-jh8100-sys-west.c        | 264 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   2 +
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-=
west.c

diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/=
Kconfig
index afcbf9d4dc8d..d78f161a636c 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -70,3 +70,15 @@ config PINCTRL_STARFIVE_JH8100_SYS_EAST
 	  This also provides an interface to the GPIO pins not used by other
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
+
+config PINCTRL_STARFIVE_JH8100_SYS_WEST
+	tristate "StarFive JH8100 SoC System IOMUX-West pinctrl and GPIO driver=
"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support system iomux-west pin control on the StarFive=
 JH8100 SoC.
+	  This also provides an interface to the GPIO pins not used by other
+	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
+	  and interrupts on input changes.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive=
/Makefile
index 45698c502b48..784465157ae2 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_AON)	+=3D pinctrl-st=
arfive-jh7110-aon.o
=20
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+=3D pinctrl-starfive-jh8100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+=3D pinctrl-starfive-jh8=
100-sys-east.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_WEST)	+=3D pinctrl-starfive-jh8=
100-sys-west.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c =
b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c
new file mode 100644
index 000000000000..398821fc1f78
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-west.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC sys west controller
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
+#include <linux/mutex.h>
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
+#define JH8100_SYS_W_NGPIO			16
+#define JH8100_SYS_W_GC_BASE			0
+
+/* registers */
+#define JH8100_SYS_W_DOEN			0x000
+#define JH8100_SYS_W_DOUT			0x010
+#define JH8100_SYS_W_GPI			0x020
+#define JH8100_SYS_W_GPIOIN			0x068
+
+#define JH8100_SYS_W_GPIOEN			0x048
+#define JH8100_SYS_W_GPIOIS0			0x04c
+#define JH8100_SYS_W_GPIOIC0			0x050
+#define JH8100_SYS_W_GPIOIBE0			0x054
+#define JH8100_SYS_W_GPIOIEV0			0x058
+#define JH8100_SYS_W_GPIOIE0			0x05c
+#define JH8100_SYS_W_GPIORIS0			0x060
+#define JH8100_SYS_W_GPIOMIS0			0x064
+
+#define JH8100_SYS_W_GPO_PDA_00_15_CFG		0x074
+
+static const struct pinctrl_pin_desc jh8100_sys_w_pins[] =3D {
+	PINCTRL_PIN(PAD_GPIO0_W,	"SYS_W_GPIO0"),
+	PINCTRL_PIN(PAD_GPIO1_W,	"SYS_W_GPIO1"),
+	PINCTRL_PIN(PAD_GPIO2_W,	"SYS_W_GPIO2"),
+	PINCTRL_PIN(PAD_GPIO3_W,	"SYS_W_GPIO3"),
+	PINCTRL_PIN(PAD_GPIO4_W,	"SYS_W_GPIO4"),
+	PINCTRL_PIN(PAD_GPIO5_W,	"SYS_W_GPIO5"),
+	PINCTRL_PIN(PAD_GPIO6_W,	"SYS_W_GPIO6"),
+	PINCTRL_PIN(PAD_GPIO7_W,	"SYS_W_GPIO7"),
+	PINCTRL_PIN(PAD_GPIO8_W,	"SYS_W_GPIO8"),
+	PINCTRL_PIN(PAD_GPIO9_W,	"SYS_W_GPIO9"),
+	PINCTRL_PIN(PAD_GPIO10_W,	"SYS_W_GPIO10"),
+	PINCTRL_PIN(PAD_GPIO11_W,	"SYS_W_GPIO11"),
+	PINCTRL_PIN(PAD_GPIO12_W,	"SYS_W_GPIO12"),
+	PINCTRL_PIN(PAD_GPIO13_W,	"SYS_W_GPIO13"),
+	PINCTRL_PIN(PAD_GPIO14_W,	"SYS_W_GPIO14"),
+	PINCTRL_PIN(PAD_GPIO15_W,	"SYS_W_GPIO15"),
+};
+
+struct jh8100_sys_w_func_sel {
+	u16 offset;
+	u8 shift;
+	u8 max;
+};
+
+static const struct jh8100_sys_w_func_sel
+	jh8100_sys_w_func_sel[ARRAY_SIZE(jh8100_sys_w_pins)] =3D {
+	[PAD_GPIO0_W]    =3D { 0xb4,  0, 2 },
+	[PAD_GPIO1_W]    =3D { 0xb4, 12, 2 },
+	[PAD_GPIO2_W]    =3D { 0xb4, 14, 2 },
+	[PAD_GPIO3_W]    =3D { 0xb4, 16, 2 },
+	[PAD_GPIO4_W]    =3D { 0xb4, 18, 2 },
+	[PAD_GPIO5_W]    =3D { 0xb4, 20, 2 },
+	[PAD_GPIO6_W]    =3D { 0xb4, 22, 2 },
+	[PAD_GPIO7_W]    =3D { 0xb4, 24, 2 },
+	[PAD_GPIO8_W]    =3D { 0xb4, 26, 2 },
+	[PAD_GPIO9_W]    =3D { 0xb4, 28, 2 },
+	[PAD_GPIO10_W]   =3D { 0xb4,  2, 2 },
+	[PAD_GPIO11_W]   =3D { 0xb4,  4, 2 },
+	[PAD_GPIO12_W]   =3D { 0xb4,  6, 2 },
+	[PAD_GPIO13_W]   =3D { 0xb4,  8, 2 },
+	[PAD_GPIO14_W]   =3D { 0xb4, 10, 2 },
+};
+
+static void jh8100_sys_w_set_function(struct jh8100_pinctrl *sfp,
+				      unsigned int pin, u32 func)
+{
+	const struct jh8100_sys_w_func_sel *fs =3D &jh8100_sys_w_func_sel[pin];
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
+static int jh8100_sys_w_set_one_pin_mux(struct jh8100_pinctrl *sfp,
+					unsigned int pin,
+					unsigned int din, u32 dout,
+					u32 doen, u32 func)
+{
+	if (pin < sfp->gc.ngpio - 1 && func =3D=3D 0)
+		jh8100_set_gpiomux(sfp, pin, din, dout, doen);
+
+	if (pin < sfp->gc.ngpio - 1 && func =3D=3D 2)
+		jh8100_sys_w_set_function(sfp, pin, func);
+
+	return 0;
+}
+
+static int jh8100_sys_w_get_padcfg_base(struct jh8100_pinctrl *sfp,
+					unsigned int pin)
+{
+	if (pin <=3D PAD_GPIO15_W)
+		return JH8100_SYS_W_GPO_PDA_00_15_CFG;
+	else
+		return -1;
+}
+
+static void jh8100_sys_w_irq_handler(struct irq_desc *desc)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_desc(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned long mis;
+	unsigned int pin;
+
+	chained_irq_enter(chip, desc);
+
+	mis =3D readl_relaxed(sfp->base + JH8100_SYS_W_GPIOMIS0);
+	for_each_set_bit(pin, &mis, 16)
+		generic_handle_domain_irq(sfp->gc.irq.domain, pin);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int jh8100_sys_w_init_hw(struct gpio_chip *gc)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+
+	/* mask all GPIO interrupts */
+	writel(0U, sfp->base + JH8100_SYS_W_GPIOIE0);
+	/* clear edge interrupt flags */
+	writel(0U, sfp->base + JH8100_SYS_W_GPIOIC0);
+	writel(~0U, sfp->base + JH8100_SYS_W_GPIOIC0);
+	/* enable GPIO interrupts */
+	writel(1U, sfp->base + JH8100_SYS_W_GPIOEN);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_sys_w_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i =3D 0; i < JH8100_SYS_WEST_REG_NUM; i++)
+		sfp->jh8100_sys_west_regs[i] =3D readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_sys_w_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i =3D 0; i < JH8100_SYS_WEST_REG_NUM; i++)
+		writel_relaxed(sfp->jh8100_sys_west_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_sys_w_pinctrl_dev_pm_ops,
+			 jh8100_sys_w_pinctrl_suspend,
+			 jh8100_sys_w_pinctrl_resume);
+
+static const struct jh8100_gpio_irq_reg jh8100_sys_w_irq_reg =3D {
+	.is_reg_base	=3D JH8100_SYS_W_GPIOIS0,
+	.ic_reg_base	=3D JH8100_SYS_W_GPIOIC0,
+	.ibe_reg_base	=3D JH8100_SYS_W_GPIOIBE0,
+	.iev_reg_base	=3D JH8100_SYS_W_GPIOIEV0,
+	.ie_reg_base	=3D JH8100_SYS_W_GPIOIE0,
+	.ris_reg_base	=3D JH8100_SYS_W_GPIORIS0,
+	.mis_reg_base	=3D JH8100_SYS_W_GPIOMIS0,
+};
+
+static const struct jh8100_pinctrl_soc_info jh8100_sys_w_pinctrl_info =3D=
 {
+	.pins				=3D jh8100_sys_w_pins,
+	.npins				=3D ARRAY_SIZE(jh8100_sys_w_pins),
+	.ngpios				=3D JH8100_SYS_W_NGPIO,
+	.gc_base			=3D JH8100_SYS_W_GC_BASE,
+	.dout_reg_base			=3D JH8100_SYS_W_DOUT,
+	.dout_mask			=3D GENMASK(5, 0),
+	.doen_reg_base			=3D JH8100_SYS_W_DOEN,
+	.doen_mask			=3D GENMASK(4, 0),
+	.gpi_reg_base			=3D JH8100_SYS_W_GPI,
+	.gpi_mask			=3D GENMASK(4, 0),
+	.gpioin_reg_base		=3D JH8100_SYS_W_GPIOIN,
+	.irq_reg			=3D &jh8100_sys_w_irq_reg,
+	.jh8100_set_one_pin_mux		=3D jh8100_sys_w_set_one_pin_mux,
+	.jh8100_get_padcfg_base		=3D jh8100_sys_w_get_padcfg_base,
+	.jh8100_gpio_irq_handler	=3D jh8100_sys_w_irq_handler,
+	.jh8100_gpio_init_hw		=3D jh8100_sys_w_init_hw,
+};
+
+static const struct of_device_id jh8100_sys_w_pinctrl_of_match[] =3D {
+	{
+		.compatible =3D "starfive,jh8100-sys-pinctrl-west",
+		.data =3D &jh8100_sys_w_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_sys_w_pinctrl_of_match);
+
+static struct platform_driver jh8100_sys_w_pinctrl_driver =3D {
+	.probe =3D jh8100_pinctrl_probe,
+	.driver =3D {
+		.name =3D "starfive-jh8100-sys-pinctrl-west",
+#ifdef CONFIG_PM_SLEEP
+		.pm =3D &jh8100_sys_w_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table =3D jh8100_sys_w_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_sys_w_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH8100 SoC sys west =
controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers=
/pinctrl/starfive/pinctrl-starfive-jh8100.h
index d84b88c0568d..6264931ddb82 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -13,6 +13,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
=20
+#define JH8100_SYS_WEST_REG_NUM		44
 #define JH8100_SYS_EAST_REG_NUM		116
=20
 struct jh8100_pinctrl {
@@ -25,6 +26,7 @@ struct jh8100_pinctrl {
 	/* register read/write mutex */
 	struct mutex mutex;
 	const struct jh8100_pinctrl_soc_info *info;
+	unsigned int jh8100_sys_west_regs[JH8100_SYS_WEST_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_EAST_REG_NUM];
 	/* wakeup */
 	int wakeup_gpio;
--=20
2.25.1


