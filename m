Return-Path: <linux-kernel+bounces-11371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35D81E541
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82741F224FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A124C635;
	Tue, 26 Dec 2023 05:40:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4B4EB25;
	Tue, 26 Dec 2023 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 140FD8022;
	Tue, 26 Dec 2023 13:40:42 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:40:41 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:40:35 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<emil.renner.berthing@canonical.com>, <hal.feng@starfivetech.com>,
	<xingyu.wu@starfivetech.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>, Joshua Yeong
	<joshua.yeong@starfivetech.com>
Subject: [RFC 15/16] reset: starfive: Add StarFive JH8100 reset driver
Date: Tue, 26 Dec 2023 13:38:47 +0800
Message-ID: <20231226053848.25089-16-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
References: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
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

Add auxiliary reset driver to support StarFive JH8100 SoC.

Co-developed-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 MAINTAINERS                                   |   7 ++
 drivers/reset/starfive/Kconfig                |   8 ++
 drivers/reset/starfive/Makefile               |   2 +
 .../reset/starfive/reset-starfive-jh8100.c    | 108 ++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100644 drivers/reset/starfive/reset-starfive-jh8100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ea4a694ed31..96fbe3259356 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20692,6 +20692,13 @@ F:	Documentation/devicetree/bindings/clock/starf=
ive,jh81*.yaml
 F:	drivers/clk/starfive/clk-starfive-jh81*
 F:	include/dt-bindings/clock/starfive?jh81*.h
=20
+STARFIVE JH8100 RESET CONTROLLER DRIVERS
+M:	Sia Jee Heng <jeeheng.sia@starfivetech.com>
+M:	Ley Foon Tan <leyfoon.tan@starfivetech.com>
+S:	Maintained
+F:	drivers/reset/starfive/reset-starfive-jh81*
+F:	include/dt-bindings/reset/starfive?jh81*.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kcon=
fig
index 29fbcf1a7d83..88d050044d52 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -19,3 +19,11 @@ config RESET_STARFIVE_JH7110
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7110 SoC.
+
+config RESET_STARFIVE_JH8100
+	bool "StarFive JH8100 Reset Driver"
+	depends on AUXILIARY_BUS && CLK_STARFIVE_JH8100_SYS
+	select RESET_STARFIVE_COMMON
+	default ARCH_STARFIVE
+	help
+	  This enables the reset controller driver for the StarFive JH8100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Mak=
efile
index 582e4c160bd4..ede1fc1c9601 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_RESET_STARFIVE_COMMON)		+=3D reset-starfive-=
common.o
=20
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+=3D reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_STARFIVE_JH7110)		+=3D reset-starfive-jh7110.o
+
+obj-$(CONFIG_RESET_STARFIVE_JH8100)		+=3D reset-starfive-jh8100.o
diff --git a/drivers/reset/starfive/reset-starfive-jh8100.c b/drivers/res=
et/starfive/reset-starfive-jh8100.c
new file mode 100644
index 000000000000..a14418653608
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jh8100.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reset driver for the StarFive JH8100 SoC
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <dt-bindings/reset/starfive,jh8100-crg.h>
+#include <linux/auxiliary_bus.h>
+#include <soc/starfive/reset-starfive-common.h>
+
+#include "reset-starfive-common.h"
+
+#define JH8100_SYSRST_NUM_RESETS	(JH8100_SYSRST_HD_AUDIO + 1)
+#define JH8100_NWRST_NUM_RESETS		(JH8100_NWRST_MERAK1_TVSENSOR + 1)
+#define JH8100_NERST_NUM_RESETS		(JH8100_NERST_DUBHE_TVSENSOR + 1)
+#define JH8100_SWRST_NUM_RESETS		(JH8100_SWRST_DDR_TVSENSOR + 1)
+#define JH8100_AONRST_NUM_RESETS	(JH8100_AONRST_IRQ_CTRL + 1)
+
+struct jh8100_reset_info {
+	unsigned int nr_resets;
+	unsigned int assert_offset;
+	unsigned int status_offset;
+};
+
+static const struct jh8100_reset_info jh8100_sys_info =3D {
+	.nr_resets =3D JH8100_SYSRST_NUM_RESETS,
+	.assert_offset =3D 0x1B4,
+	.status_offset =3D 0x1B8,
+};
+
+static const struct jh8100_reset_info jh8100_sys_nw_info =3D {
+	.nr_resets =3D JH8100_NWRST_NUM_RESETS,
+	.assert_offset =3D 0xA4,
+	.status_offset =3D 0xA8,
+};
+
+static const struct jh8100_reset_info jh8100_sys_ne_info =3D {
+	.nr_resets =3D JH8100_NERST_NUM_RESETS,
+	.assert_offset =3D 0x2BC,
+	.status_offset =3D 0x2C4,
+};
+
+static const struct jh8100_reset_info jh8100_sys_sw_info =3D {
+	.nr_resets =3D JH8100_SWRST_NUM_RESETS,
+	.assert_offset =3D 0x28,
+	.status_offset =3D 0x2C,
+};
+
+static const struct jh8100_reset_info jh8100_aon_info =3D {
+	.nr_resets =3D JH8100_AONRST_NUM_RESETS,
+	.assert_offset =3D 0x104,
+	.status_offset =3D 0x108,
+};
+
+static int jh8100_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct jh8100_reset_info *info =3D (struct jh8100_reset_info *)
+					 (id->driver_data);
+	struct starfive_reset_adev *rdev =3D to_starfive_reset_adev(adev);
+	void __iomem *base =3D rdev->base;
+
+	if (!info || !base)
+		return -ENODEV;
+
+	return reset_starfive_register(&adev->dev,
+					      adev->dev.parent->of_node,
+					      base + info->assert_offset,
+					      base + info->status_offset, NULL,
+					      info->nr_resets, NULL);
+}
+
+static const struct auxiliary_device_id jh8100_reset_ids[] =3D {
+	{
+		.name =3D "clk_starfive_jh8100_sys.rst-sys",
+		.driver_data =3D (kernel_ulong_t)&jh8100_sys_info,
+	},
+	{
+		.name =3D "clk_starfive_jh8100_sys.rst-nw",
+		.driver_data =3D (kernel_ulong_t)&jh8100_sys_nw_info,
+	},
+	{
+		.name =3D "clk_starfive_jh8100_sys.rst-ne",
+		.driver_data =3D (kernel_ulong_t)&jh8100_sys_ne_info,
+	},
+	{
+		.name =3D "clk_starfive_jh8100_sys.rst-sw",
+		.driver_data =3D (kernel_ulong_t)&jh8100_sys_sw_info,
+	},
+	{
+		.name =3D "clk_starfive_jh8100_sys.rst-aon",
+		.driver_data =3D (kernel_ulong_t)&jh8100_aon_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, jh8100_reset_ids);
+
+static struct auxiliary_driver jh8100_reset_driver =3D {
+	.probe		=3D jh8100_reset_probe,
+	.id_table	=3D jh8100_reset_ids,
+};
+module_auxiliary_driver(jh8100_reset_driver);
+
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
+MODULE_AUTHOR("Sia Jee Heng <jeeheng.sia@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH8100 reset driver");
+MODULE_LICENSE("GPL");
--=20
2.34.1


