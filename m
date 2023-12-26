Return-Path: <linux-kernel+bounces-11368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E7C81E537
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E67282DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC74E1D1;
	Tue, 26 Dec 2023 05:40:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C94E1D3;
	Tue, 26 Dec 2023 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 51BC48043;
	Tue, 26 Dec 2023 13:40:22 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:40:22 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:40:16 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<emil.renner.berthing@canonical.com>, <hal.feng@starfivetech.com>,
	<xingyu.wu@starfivetech.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [RFC 12/16] clk: starfive: Add JH8100 South-West clock generator driver
Date: Tue, 26 Dec 2023 13:38:44 +0800
Message-ID: <20231226053848.25089-13-jeeheng.sia@starfivetech.com>
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

Add support for JH8100 South-West (SWCRG) clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   7 +
 drivers/clk/starfive/Makefile                 |   1 +
 drivers/clk/starfive/clk-starfive-jh8100-sw.c | 134 ++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sw.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 23968e97969b..23ae894fedb9 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -95,3 +95,10 @@ config CLK_STARFIVE_JH8100_NE
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the North-East clock controller on the StarFi=
ve JH8100 SoC.
+
+config CLK_STARFIVE_JH8100_SW
+	bool "StarFive JH8100 South-West clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the South-West clock controller on the StarFi=
ve JH8100 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefil=
e
index cecce3655600..242e2e75dadb 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+=3D clk-starfiv=
e-jh7110-vout.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+=3D clk-starfive-jh8100-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_NW)	+=3D clk-starfive-jh8100-nw.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_NE)	+=3D clk-starfive-jh8100-ne.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SW)	+=3D clk-starfive-jh8100-sw.o
diff --git a/drivers/clk/starfive/clk-starfive-jh8100-sw.c b/drivers/clk/=
starfive/clk-starfive-jh8100-sw.c
new file mode 100644
index 000000000000..f583f7d984ed
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh8100-sw.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 South-West Clock Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+#include "clk-starfive-jh8100.h"
+
+#define JH8100_SWCLK_NUM_CLKS		(JH8100_SWCLK_VDEC_ICG_EN + 1)
+
+/* external clocks */
+#define JH8100_SWCLK_APB_BUS		(JH8100_SWCLK_NUM_CLKS + 0)
+#define JH8100_SWCLK_VDEC_ROOT		(JH8100_SWCLK_NUM_CLKS + 1)
+#define JH8100_SWCLK_FLEXNOC1		(JH8100_SWCLK_NUM_CLKS + 2)
+
+static const struct starfive_clk_data jh8100_swcrg_clk_data[] =3D {
+	/* jpeg */
+	STARFIVE__DIV(JH8100_SWCLK_JPEG_AXI, "jpeg_axi", 20, JH8100_SWCLK_VDEC_=
ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000DJ_AXI, "vc9000dj_axi", CLK_IGNORE_UNU=
SED,
+		      JH8100_SWCLK_JPEG_AXI),
+	STARFIVE_GDIV(JH8100_SWCLK_VC9000DJ_VDEC, "vc9000dj_vdec", CLK_IGNORE_U=
NUSED, 40,
+		      JH8100_SWCLK_VDEC_ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000DJ_APB, "vc9000dj_apb", CLK_IGNORE_UNU=
SED,
+		      JH8100_SWCLK_APB_BUS),
+	/* video dec */
+	STARFIVE__DIV(JH8100_SWCLK_VDEC_AXI, "vdec_axi", 20, JH8100_SWCLK_VDEC_=
ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000D_AXI, "vc9000d_axi", CLK_IGNORE_UNUSE=
D,
+		      JH8100_SWCLK_VDEC_AXI),
+	STARFIVE_GDIV(JH8100_SWCLK_VC9000D_VDEC, "vc9000d_vdec", CLK_IGNORE_UNU=
SED, 40,
+		      JH8100_SWCLK_FLEXNOC1),
+	STARFIVE_GATE(JH8100_SWCLK_VC9000D_APB, "vc9000d_apb", CLK_IGNORE_UNUSE=
D,
+		      JH8100_SWCLK_APB_BUS),
+	/* icg_en */
+	STARFIVE_GATE(JH8100_SWCLK_JPEG_ICG_EN, "jpeg_en", 0, JH8100_SWCLK_VDEC=
_ROOT),
+	STARFIVE_GATE(JH8100_SWCLK_VDEC_ICG_EN, "vdec_en", 0, JH8100_SWCLK_VDEC=
_AXI),
+};
+
+static struct clk_hw *jh8100_swcrg_clk_get(struct of_phandle_args *clksp=
ec, void *data)
+{
+	struct starfive_clk_priv *priv =3D data;
+	unsigned int idx =3D clkspec->args[0];
+
+	if (idx < JH8100_SWCLK_NUM_CLKS)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_swcrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv =3D devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH8100_SWCLK_NUM_CLKS),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev =3D &pdev->dev;
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx =3D 0; idx < JH8100_SWCLK_NUM_CLKS; idx++) {
+		u32 max =3D jh8100_swcrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] =3D {};
+		struct clk_init_data init =3D {
+			.name =3D jh8100_swcrg_clk_data[idx].name,
+			.ops =3D starfive_clk_ops(max),
+			.parent_data =3D parents,
+			.num_parents =3D
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags =3D jh8100_swcrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk =3D &priv->reg[idx];
+		unsigned int i;
+
+		for (i =3D 0; i < init.num_parents; i++) {
+			unsigned int pidx =3D jh8100_swcrg_clk_data[idx].parents[i];
+
+			if (pidx < JH8100_SWCLK_NUM_CLKS)
+				parents[i].hw =3D &priv->reg[pidx].hw;
+			else if (pidx =3D=3D JH8100_SWCLK_APB_BUS)
+				parents[i].fw_name =3D "apb_bus";
+			else if (pidx =3D=3D JH8100_SWCLK_VDEC_ROOT)
+				parents[i].fw_name =3D "vdec_root";
+			else if (pidx =3D=3D JH8100_SWCLK_FLEXNOC1)
+				parents[i].fw_name =3D "flexnoc1";
+		}
+
+		clk->hw.init =3D &init;
+		clk->idx =3D idx;
+		clk->max_div =3D max & STARFIVE_CLK_DIV_MASK;
+
+		ret =3D devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh8100_swcrg_clk_get, p=
riv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sw", 3);
+}
+
+static const struct of_device_id jh8100_swcrg_match[] =3D {
+	{ .compatible =3D "starfive,jh8100-swcrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_swcrg_driver =3D {
+	.driver =3D {
+		.name =3D "clk-starfive-jh8100-sw",
+		.of_match_table =3D jh8100_swcrg_match,
+		.suppress_bind_attrs =3D true,
+	},
+};
+builtin_platform_driver_probe(jh8100_swcrg_driver, jh8100_swcrg_probe);
--=20
2.34.1


