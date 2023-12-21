Return-Path: <linux-kernel+bounces-8003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A4F81B075
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7F4285891
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E51A5BE;
	Thu, 21 Dec 2023 08:37:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E1219E4;
	Thu, 21 Dec 2023 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id E1B5C7FEF;
	Thu, 21 Dec 2023 16:37:03 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:37:03 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:57 +0800
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
Subject: [RFC PATCH 5/6] pinctrl: starfive: jh8100: add pinctrl driver for AON domain
Date: Thu, 21 Dec 2023 16:36:21 +0800
Message-ID: <20231221083622.3445726-6-yuklin.soo@starfivetech.com>
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

Add pinctrl driver for AON domain.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                   |   7 +
 drivers/pinctrl/starfive/Kconfig              |  12 +
 drivers/pinctrl/starfive/Makefile             |   1 +
 .../starfive/pinctrl-starfive-jh8100-aon.c    | 241 ++++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   2 +
 5 files changed, 263 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.=
c

diff --git a/MAINTAINERS b/MAINTAINERS
index 53084079f5f5..451ee21086a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20776,6 +20776,13 @@ S:	Maintained
 F:	drivers/reset/starfive/reset-starfive-jh81*
 F:	include/dt-bindings/reset/starfive?jh81*.h
=20
+STARFIVE JH8100 PINCTRL DRIVERS
+M:	Alex Soo <yuklin.soo@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pinctrl/starfive,jh81*.yaml
+F:	drivers/pinctrl/starfive/pinctrl-starfive-jh81*
+F:	include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/=
Kconfig
index bb1fb3788d5b..4d62d7199f5d 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -94,3 +94,15 @@ config PINCTRL_STARFIVE_JH8100_SYS_GMAC
 	  This also provides a syscon interface to configure the GMAC1 voltage =
level for RGMII(1.8V
 	  2.5V), GMII(2.5V/3.3V), to configure the SDIO1 voltage level to suppo=
rt the 3.3/1.8V voltage
 	  switching in high-speed mode, and configure the GMAC1 network interfa=
ce and timing (slew rate).
+
+config PINCTRL_STARFIVE_JH8100_AON
+	tristate "Always-on pinctrl and GPIO driver for the StarFive JH8100 SoC=
"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support always-on pin control on the StarFive JH8100 =
SoC.
+	  This also provides a syscon interface to configure the GMAC0 voltage =
level for RGMII(1.8V
+	  2.5V), GMII(2.5V/3.3V), to configure the SDIO0 voltage level to suppo=
rt the 3.3/1.8V voltage
+	  switching in high-speed mode, and configure the GMAC0 network interfa=
ce and timing (slew rate).
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive=
/Makefile
index 236a693a8aef..46b1ab97779b 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+=3D pinctrl-sta=
rfive-jh8100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+=3D pinctrl-starfive-jh8=
100-sys-east.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_WEST)	+=3D pinctrl-starfive-jh8=
100-sys-west.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_GMAC)	+=3D pinctrl-starfive-jh8=
100-sys-gmac.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_AON)	+=3D pinctrl-starfive-jh8100-a=
on.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c b/dri=
vers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c
new file mode 100644
index 000000000000..fc478bc0e0b2
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-aon.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC aon controller
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinmux.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_AON_NGPIO		16
+#define JH8100_AON_GC_BASE		64
+
+/* registers */
+#define JH8100_AON_DOEN			0x00
+#define JH8100_AON_DOUT			0x10
+#define JH8100_AON_GPI			0x20
+#define JH8100_AON_GPIOIN		0x54
+
+#define JH8100_AON_GPIOEN		0x34
+#define JH8100_AON_GPIOIS		0x38
+#define JH8100_AON_GPIOIC		0x3c
+#define JH8100_AON_GPIOIBE		0x40
+#define JH8100_AON_GPIOIEV		0x44
+#define JH8100_AON_GPIOIE		0x48
+#define JH8100_AON_GPIORIS		0x4c
+#define JH8100_AON_GPIOMIS		0x50
+
+#define JH8100_AON_GPO_PDA_0_14_CFG	0x90
+
+static const struct pinctrl_pin_desc jh8100_aon_pins[] =3D {
+	PINCTRL_PIN(PAD_RGPIO0,		"AON_RGPIO0"),
+	PINCTRL_PIN(PAD_RGPIO1,		"AON_RGPIO1"),
+	PINCTRL_PIN(PAD_RGPIO2,		"AON_RGPIO2"),
+	PINCTRL_PIN(PAD_RGPIO3,		"AON_RGPIO3"),
+	PINCTRL_PIN(PAD_RGPIO4,		"AON_RGPIO4"),
+	PINCTRL_PIN(PAD_RGPIO5,		"AON_RGPIO5"),
+	PINCTRL_PIN(PAD_RGPIO6,		"AON_RGPIO6"),
+	PINCTRL_PIN(PAD_RGPIO7,		"AON_RGPIO7"),
+	PINCTRL_PIN(PAD_RGPIO8,		"AON_RGPIO8"),
+	PINCTRL_PIN(PAD_RGPIO9,		"AON_RGPIO9"),
+	PINCTRL_PIN(PAD_RGPIO10,	"AON_RGPIO10"),
+	PINCTRL_PIN(PAD_RGPIO11,	"AON_RGPIO11"),
+	PINCTRL_PIN(PAD_RGPIO12,	"AON_RGPIO12"),
+	PINCTRL_PIN(PAD_RGPIO13,	"AON_RGPIO13"),
+	PINCTRL_PIN(PAD_RGPIO14,	"AON_RGPIO14"),
+	PINCTRL_PIN(PAD_RGPIO15,	"AON_RGPIO15"),
+	PINCTRL_PIN(PAD_TESTEN,		"AON_TESTEN"),
+	PINCTRL_PIN(PAD_RSTN,		"AON_RSTN"),
+	PINCTRL_PIN(PAD_OSCK_XIN,	"AON_OSCK_XIN"),
+	PINCTRL_PIN(PAD_OSCK_XOUT,	"AON_OSCK_XOUT"),
+	PINCTRL_PIN(PAD_OSCM_XIN,	"AON_OSCM_XIN"),
+	PINCTRL_PIN(PAD_OSCM_XOUT,	"AON_OSCM_XOUT"),
+	PINCTRL_PIN(PAD_GMAC0_MDC,	"AON_GMAC0_MDC"),
+	PINCTRL_PIN(PAD_GMAC0_MDIO,	"AON_GMAC0_MDIO"),
+	PINCTRL_PIN(PAD_GMAC0_RXD0,	"AON_GMAC0_RXD0"),
+	PINCTRL_PIN(PAD_GMAC0_RXD1,	"AON_GMAC0_RXD1"),
+	PINCTRL_PIN(PAD_GMAC0_RXD2,	"AON_GMAC0_RXD2"),
+	PINCTRL_PIN(PAD_GMAC0_RXD3,	"AON_GMAC0_RXD3"),
+	PINCTRL_PIN(PAD_GMAC0_RXDV,	"AON_GMAC0_RXDV"),
+	PINCTRL_PIN(PAD_GMAC0_RXC,	"AON_GMAC0_RXC"),
+	PINCTRL_PIN(PAD_GMAC0_TXD0,	"AON_GMAC0_TXD0"),
+	PINCTRL_PIN(PAD_GMAC0_TXD1,	"AON_GMAC0_TXD1"),
+	PINCTRL_PIN(PAD_GMAC0_TXD2,	"AON_GMAC0_TXD2"),
+	PINCTRL_PIN(PAD_GMAC0_TXD3,	"AON_GMAC0_TXD3"),
+	PINCTRL_PIN(PAD_GMAC0_TXEN,	"AON_GMAC0_TXEN"),
+	PINCTRL_PIN(PAD_GMAC0_TXC,	"AON_GMAC0_TXC"),
+};
+
+static int jh8100_aon_set_one_pin_mux(struct jh8100_pinctrl *sfp,
+				      unsigned int pin,
+				      unsigned int din, u32 dout,
+				      u32 doen, u32 func)
+{
+	if (pin < sfp->gc.ngpio && func =3D=3D 0)
+		jh8100_set_gpiomux(sfp, pin, din, dout, doen);
+
+	return 0;
+}
+
+static int jh8100_aon_get_padcfg_base(struct jh8100_pinctrl *sfp,
+				      unsigned int pin)
+{
+	if (pin < PAD_GMAC0_MDC)
+		return JH8100_AON_GPO_PDA_0_14_CFG;
+
+	return -1;
+}
+
+static void jh8100_aon_irq_handler(struct irq_desc *desc)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_desc(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned long mis;
+	unsigned int pin;
+
+	chained_irq_enter(chip, desc);
+
+	mis =3D readl_relaxed(sfp->base + JH8100_AON_GPIOMIS);
+	for_each_set_bit(pin, &mis, JH8100_AON_NGPIO)
+		generic_handle_domain_irq(sfp->gc.irq.domain, pin);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int jh8100_aon_init_hw(struct gpio_chip *gc)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+
+	/* mask all GPIO interrupts */
+	writel_relaxed(0, sfp->base + JH8100_AON_GPIOIE);
+	/* clear edge interrupt flags */
+	writel_relaxed(0, sfp->base + JH8100_AON_GPIOIC);
+	writel_relaxed(0x0fff, sfp->base + JH8100_AON_GPIOIC);
+	/* enable GPIO interrupts */
+	writel_relaxed(1, sfp->base + JH8100_AON_GPIOEN);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_aon_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(sfp->wakeup_irq);
+
+	for (i =3D 0; i < JH8100_AON_REG_NUM; i++)
+		sfp->jh8100_aon_regs[i] =3D readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_aon_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(sfp->wakeup_irq);
+
+	for (i =3D 0; i < JH8100_AON_REG_NUM; i++)
+		writel_relaxed(sfp->jh8100_aon_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_aon_pinctrl_dev_pm_ops,
+			 jh8100_aon_pinctrl_suspend,
+			 jh8100_aon_pinctrl_resume);
+
+static const struct jh8100_gpio_irq_reg jh8100_aon_irq_reg =3D {
+	.is_reg_base	=3D JH8100_AON_GPIOIS,
+	.ic_reg_base	=3D JH8100_AON_GPIOIC,
+	.ibe_reg_base	=3D JH8100_AON_GPIOIBE,
+	.iev_reg_base	=3D JH8100_AON_GPIOIEV,
+	.ie_reg_base	=3D JH8100_AON_GPIOIE,
+	.ris_reg_base	=3D JH8100_AON_GPIORIS,
+	.mis_reg_base	=3D JH8100_AON_GPIOMIS,
+};
+
+static const struct jh8100_pinctrl_soc_info jh8100_aon_pinctrl_info =3D =
{
+	.pins				=3D jh8100_aon_pins,
+	.npins				=3D ARRAY_SIZE(jh8100_aon_pins),
+	.ngpios				=3D JH8100_AON_NGPIO,
+	.gc_base			=3D JH8100_AON_GC_BASE,
+	.dout_reg_base			=3D JH8100_AON_DOUT,
+	.dout_mask			=3D GENMASK(4, 0),
+	.doen_reg_base			=3D JH8100_AON_DOEN,
+	.doen_mask			=3D GENMASK(2, 0),
+	.gpi_reg_base			=3D JH8100_AON_GPI,
+	.gpi_mask			=3D GENMASK(4, 0),
+	.gpioin_reg_base		=3D JH8100_AON_GPIOIN,
+	.irq_reg			=3D &jh8100_aon_irq_reg,
+	.jh8100_set_one_pin_mux		=3D jh8100_aon_set_one_pin_mux,
+	.jh8100_get_padcfg_base		=3D jh8100_aon_get_padcfg_base,
+	.jh8100_gpio_irq_handler	=3D jh8100_aon_irq_handler,
+	.jh8100_gpio_init_hw		=3D jh8100_aon_init_hw,
+};
+
+static const struct of_device_id jh8100_aon_pinctrl_of_match[] =3D {
+	{
+		.compatible =3D "starfive,jh8100-aon-pinctrl",
+		.data =3D &jh8100_aon_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_aon_pinctrl_of_match);
+
+static struct platform_driver jh8100_aon_pinctrl_driver =3D {
+	.probe =3D jh8100_pinctrl_probe,
+	.driver =3D {
+		.name =3D "starfive-jh8100-aon-pinctrl",
+#ifdef CONFIG_PM_SLEEP
+		.pm =3D &jh8100_aon_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table =3D jh8100_aon_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_aon_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH8100 SoC aon contr=
oller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers=
/pinctrl/starfive/pinctrl-starfive-jh8100.h
index 43b62609fa3e..8347fa83e8dd 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -16,6 +16,7 @@
 #define JH8100_SYS_WEST_REG_NUM		44
 #define JH8100_SYS_EAST_REG_NUM		116
 #define JH8100_SYS_GMAC_REG_NUM		19
+#define JH8100_AON_REG_NUM		65
=20
 struct jh8100_pinctrl {
 	struct device *dev;
@@ -30,6 +31,7 @@ struct jh8100_pinctrl {
 	unsigned int jh8100_sys_west_regs[JH8100_SYS_WEST_REG_NUM];
 	unsigned int jh8100_sys_east_regs[JH8100_SYS_EAST_REG_NUM];
 	unsigned int jh8100_sys_gmac_regs[JH8100_SYS_GMAC_REG_NUM];
+	unsigned int jh8100_aon_regs[JH8100_AON_REG_NUM];
 	/* wakeup */
 	int wakeup_gpio;
 	int wakeup_irq;
--=20
2.25.1


