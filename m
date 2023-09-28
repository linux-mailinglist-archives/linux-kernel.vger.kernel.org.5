Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B457B132C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjI1GgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1GgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:36:18 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47FDCC7;
        Wed, 27 Sep 2023 23:35:25 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 28 Sep 2023
 14:35:01 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH 3/4] clk: meson: C3: add support for the C3 SoC PLL clock
Date:   Thu, 28 Sep 2023 14:34:47 +0800
Message-ID: <20230928063448.3544464-4-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230928063448.3544464-1-xianwei.zhao@amlogic.com>
References: <20230928063448.3544464-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/clk/meson/Kconfig  |  12 +
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/c3-pll.c | 510 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/c3-pll.h |  35 +++
 4 files changed, 558 insertions(+)
 create mode 100644 drivers/clk/meson/c3-pll.c
 create mode 100644 drivers/clk/meson/c3-pll.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index c5303e4c1604..76be4bbd2afb 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -128,6 +128,18 @@ config COMMON_CLK_A1_PERIPHERALS
 	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
 	  controller to work.
 
+config COMMON_CLK_C3_PLL
+	tristate "Amlogic C3 PLL clock controller"
+	default y
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_CLKC_UTILS
+	help
+	  Support for the PLL clock controller on Amlogic C302X and C308L devices,
+	  AKA c3. Amlogic C302X and C308L devices include AW402, AW409 and AW419.
+	  Say Y if you want the board to work, because PLLs are the parent of most
+	  peripherals.
+
 config COMMON_CLK_G12A
 	tristate "G12 and SM1 SoC clock controllers support"
 	depends on ARM64
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 9ee4b954c896..4420af628b31 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
 obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
 obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
+obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
new file mode 100644
index 000000000000..5244dc19ab6e
--- /dev/null
+++ b/drivers/clk/meson/c3-pll.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Amlogic C3 PLL Controller Driver
+ *
+ * Copyright (c) 2023 Amlogic, inc.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include "clk-regmap.h"
+#include "clk-pll.h"
+#include "c3-pll.h"
+#include "meson-clkc-utils.h"
+#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
+
+#define MEMBER_REG_PARM(_member_name, _reg, _shift, _width)		\
+	._member_name = {						\
+		.reg_off = _reg,					\
+		.shift   = _shift,					\
+		.width   = _width,					\
+}
+
+#define __AML_CLK_PLL(_name, _en_reg, _en_shift, _en_width,		\
+			_m_reg, _m_shift, _m_width,			\
+			_f_reg, _f_shift, _f_width,			\
+			_n_reg, _n_shift, _n_width,			\
+			_l_reg, _l_shift, _l_width,			\
+			_r_reg, _r_shift, _r_width,			\
+			_init_reg, _init_reg_cnt, _range, _table,	\
+			_dflags, _ops, _pname, _pdata, _phw, _iflags)	\
+static struct clk_regmap _name = {					\
+	.data = &(struct meson_clk_pll_data){				\
+		MEMBER_REG_PARM(en,					\
+			_en_reg, _en_shift, _en_width),			\
+		MEMBER_REG_PARM(m,					\
+			_m_reg, _m_shift, _m_width),			\
+		MEMBER_REG_PARM(frac,					\
+			_f_reg, _f_shift, _f_width),			\
+		MEMBER_REG_PARM(n,					\
+			_n_reg, _n_shift, _n_width),			\
+		MEMBER_REG_PARM(l,					\
+			_l_reg, _l_shift, _l_width),			\
+		MEMBER_REG_PARM(rst,					\
+			_r_reg, _r_shift, _r_width),			\
+		.range = _range,					\
+		.table = _table,					\
+		.init_regs = _init_reg,					\
+		.init_count = _init_reg_cnt,				\
+		.flags = _dflags,					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = #_name,						\
+		.ops = _ops,						\
+		.parent_names = _pname,					\
+		.parent_data = _pdata,					\
+		.parent_hws = (const struct clk_hw *[]) {_phw},		\
+		.num_parents = 1,					\
+		.flags = _iflags,					\
+	},								\
+}
+
+#define __AML_CLK_MUX(_name, _reg, _mask, _shift, _table, _dflags,	\
+			_ops, _pname, _pdata, _phw, _pnub, _iflags)	\
+static struct clk_regmap _name = {					\
+	.data = &(struct clk_regmap_mux_data){				\
+		.offset = _reg,						\
+		.mask = _mask,						\
+		.shift = _shift,					\
+		.table = _table,					\
+		.flags = _dflags,					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = #_name,						\
+		.ops = _ops,						\
+		.parent_names = _pname,					\
+		.parent_data = _pdata,					\
+		.parent_hws = (const struct clk_hw *[]) { _phw },	\
+		.num_parents = _pnub,					\
+		.flags = _iflags,					\
+	},								\
+}
+
+#define __AML_CLK_DIV(_name, _reg, _shift, _width, _table, _dflags,	\
+			_ops, _pname, _pdata, _phw, _iflags)		\
+static struct clk_regmap _name = {					\
+	.data = &(struct clk_regmap_div_data){				\
+		.offset = _reg,						\
+		.shift = _shift,					\
+		.width = _width,					\
+		.table = _table,					\
+		.flags = _dflags,					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = #_name,						\
+		.ops = _ops,						\
+		.parent_names = _pname,					\
+		.parent_data = _pdata,					\
+		.parent_hws = (const struct clk_hw *[]) { _phw },	\
+		.num_parents = 1,					\
+		.flags = _iflags,					\
+	},								\
+}
+
+#define __AML_CLK_GATE(_name, _reg, _bit, _gflags,			\
+			 _ops, _pname, _pdata, _phw, _iflags)		\
+static struct clk_regmap _name = {					\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = _reg,						\
+		.bit_idx = _bit,					\
+		.flags = _gflags,					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = _ops,						\
+		.parent_names = _pname,					\
+		.parent_data = _pdata,					\
+		.parent_hws = (const struct clk_hw *[]) { _phw },	\
+		.num_parents = 1,					\
+		.flags = _iflags,					\
+	},								\
+}
+
+#define __AML_CLK_FIXED_FACTOR(_name, _mult, _div, _ops,		\
+				 _pname, _pdata, _phw, _iflags)		\
+	static struct clk_fixed_factor _name = {			\
+		.mult = _mult,						\
+		.div = _div,						\
+		.hw.init = &(struct clk_init_data){			\
+		.name = #_name,						\
+		.ops = _ops,						\
+		.parent_names = _pname,					\
+		.parent_data = _pdata,					\
+		.parent_hws = (const struct clk_hw *[]) { _phw },	\
+		.num_parents = 1,					\
+		.flags = _iflags,					\
+	},								\
+}
+
+#define AML_CLK_PLL_RW(_name, _en_reg, _en_shift, _en_width,		\
+		      _m_reg, _m_shift, _m_width,			\
+		      _f_reg, _f_shift, _f_width,			\
+		      _n_reg, _n_shift, _n_width,			\
+		      _l_reg, _l_shift, _l_width,			\
+		      _r_reg, _r_shift, _r_width,			\
+		      _init_reg, _init_reg_cnt, _range, _table, _dflags,\
+		      _pdata, _iflags)					\
+	__AML_CLK_PLL(_name, _en_reg, _en_shift, _en_width,		\
+			_m_reg, _m_shift, _m_width,			\
+			_f_reg, _f_shift, _f_width,			\
+			_n_reg, _n_shift, _n_width,			\
+			_l_reg, _l_shift, _l_width,			\
+			_r_reg, _r_shift, _r_width,			\
+			_init_reg, _init_reg_cnt, _range, _table,	\
+			_dflags, &meson_clk_pll_ops,			\
+			NULL, _pdata, NULL, _iflags)
+
+#define AML_CLK_PLL_RO(_name, _en_reg, _en_shift, _en_width,		\
+			 _m_reg, _m_shift, _m_width,			\
+			 _f_reg, _f_shift, _f_width,			\
+			 _n_reg, _n_shift, _n_width,			\
+			 _l_reg, _l_shift, _l_width,			\
+			 _r_reg, _r_shift, _r_width,			\
+			 _init_reg, _init_reg_cnt, _range, _table,	\
+			 _dflags, _pdata, _iflags)			\
+	__AML_CLK_PLL(_name, _en_reg, _en_shift, _en_width,		\
+			_m_reg, _m_shift, _m_width,			\
+			_f_reg, _f_shift, _f_width,			\
+			_n_reg, _n_shift, _n_width,			\
+			_l_reg, _l_shift, _l_width,			\
+			_r_reg, _r_shift, _r_width,			\
+			_init_reg, _init_reg_cnt, _range, _table,	\
+			_dflags, &meson_clk_pll_ro_ops,			\
+			NULL, _pdata, NULL, _iflags)
+
+#define AML_CLK_MUX_RW(_name, _reg, _mask, _shift, _table, _dflags,	\
+			 _pdata, _iflags)				\
+	__AML_CLK_MUX(_name, _reg, _mask, _shift, _table, _dflags,	\
+			&clk_regmap_mux_ops, NULL, _pdata, NULL,	\
+			ARRAY_SIZE(_pdata), _iflags)
+
+#define AML_CLK_DIV_RW(_name, _reg, _shift, _width, _table, _dflags,	\
+			 _phw, _iflags)					\
+	__AML_CLK_DIV(_name, _reg, _shift, _width, _table, _dflags,	\
+			&clk_regmap_divider_ops, NULL, NULL,		\
+			       _phw, _iflags)
+
+#define AML_CLK_DIV_RO(_name, _reg, _shift, _width, _table, _dflags,	\
+			 _phw, _iflags)					\
+	__AML_CLK_DIV(_name, _reg, _shift, _width, _table, _dflags,	\
+			&clk_regmap_divider_ro_ops, NULL, NULL,		\
+			_phw, _iflags)
+
+#define AML_CLK_GATE_RW(_name, _reg, _bit, _dflags, _phw, _iflags)	\
+	__AML_CLK_GATE(_name, _reg, _bit, _dflags,			\
+			 &clk_regmap_gate_ops, NULL, NULL, _phw,	\
+			 _iflags)
+
+#define AML_CLK_GATE_RO(_name, _reg, _bit, _dflags, _phw, _iflags)	\
+	__AML_CLK_GATE(_name, _reg, _bit, _dflags,			\
+			 &clk_regmap_gate_ro_ops, NULL, NULL, _phw,	\
+			 _iflags)
+
+#define AML_CLK_FIXED_FACTOR(_name, _mult, _div, _phw, _iflags)	\
+	__AML_CLK_FIXED_FACTOR(_name, _mult, _div,			\
+				 &clk_fixed_factor_ops, NULL, NULL,	\
+				 _phw, _iflags)
+
+static const struct clk_parent_data pll_dco_parent = {
+	.fw_name = "pll_in",
+};
+
+static const struct clk_parent_data mclk_pll_dco_parent = {
+	.fw_name = "mclk_pll_in",
+};
+
+AML_CLK_PLL_RO(fixed_pll_dco, ANACTRL_FIXPLL_CTRL0, 28, 1,  /* en */
+		ANACTRL_FIXPLL_CTRL0, 0,  8,  /* m */
+		0, 0,  0,  /* frac */
+		ANACTRL_FIXPLL_CTRL0, 16, 5,  /* n */
+		ANACTRL_FIXPLL_CTRL0, 31, 1,  /* lock */
+		ANACTRL_FIXPLL_CTRL0, 29, 1,  /* rst */
+		NULL, 0, NULL, NULL, 0, &pll_dco_parent, 0);
+AML_CLK_DIV_RO(fixed_pll, ANACTRL_FIXPLL_CTRL0, 12, 3, NULL,
+		 CLK_DIVIDER_POWER_OF_TWO, &fixed_pll_dco.hw, 0);
+AML_CLK_FIXED_FACTOR(fclk_div40_div, 1, 40, &fixed_pll.hw, 0);
+AML_CLK_GATE_RO(fclk_div40, ANACTRL_FIXPLL_CTRL4, 0, 0, &fclk_div40_div.hw, 0);
+AML_CLK_FIXED_FACTOR(fclk_div2_div, 1, 2, &fixed_pll.hw, 0);
+AML_CLK_GATE_RO(fclk_div2, ANACTRL_FIXPLL_CTRL4, 24, 0, &fclk_div2_div.hw, 0);
+AML_CLK_FIXED_FACTOR(fclk_div2p5_div, 2, 5, &fixed_pll.hw, 0);
+AML_CLK_GATE_RO(fclk_div2p5, ANACTRL_FIXPLL_CTRL4, 4, 0, &fclk_div2p5_div.hw, 0);
+AML_CLK_FIXED_FACTOR(fclk_div3_div, 1, 3, &fixed_pll.hw, 0);
+AML_CLK_GATE_RO(fclk_div3, ANACTRL_FIXPLL_CTRL4, 20, 0, &fclk_div3_div.hw, 0);
+AML_CLK_FIXED_FACTOR(fclk_div4_div, 1, 4, &fixed_pll.hw, 0);
+AML_CLK_GATE_RO(fclk_div4, ANACTRL_FIXPLL_CTRL4, 21, 0, &fclk_div4_div.hw, 0);
+AML_CLK_FIXED_FACTOR(fclk_div5_div, 1, 5, &fixed_pll.hw, 0);
+AML_CLK_GATE_RO(fclk_div5, ANACTRL_FIXPLL_CTRL4, 22, 0, &fclk_div5_div.hw, 0);
+AML_CLK_FIXED_FACTOR(fclk_div7_div, 1, 7, &fixed_pll.hw, 0);
+AML_CLK_GATE_RO(fclk_div7, ANACTRL_FIXPLL_CTRL4, 23, 0, &fclk_div7_div.hw, 0);
+
+static const struct reg_sequence c3_gp0_init_regs[] = {
+	{ .reg = ANACTRL_GP0PLL_CTRL1,	.def = 0x0 },
+	{ .reg = ANACTRL_GP0PLL_CTRL2,	.def = 0x0 },
+	{ .reg = ANACTRL_GP0PLL_CTRL3,	.def = 0x48681c00 },
+	{ .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
+	{ .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
+	{ .reg = ANACTRL_GP0PLL_CTRL6,	.def = 0x56540000, .delay_us = 10 },
+	{ .reg = ANACTRL_GP0PLL_CTRL0,	.def = 0x080304fa },
+	{ .reg = ANACTRL_GP0PLL_CTRL0,	.def = 0x380304fa, .delay_us = 10 },
+	{ .reg = ANACTRL_GP0PLL_CTRL0,	.def = 0X180304fa }
+};
+
+static const struct pll_params_table c3_gp0_pll_params_table[] = {
+	PLL_PARAMS(150, 1), /* DCO = 3600M */
+	PLL_PARAMS(130, 1), /* DCO = 3120M */
+	PLL_PARAMS(192, 1), /* DCO = 4608M */
+	PLL_PARAMS(125, 1), /* DCO = 3000M */
+	{ /* sentinel */  }
+};
+
+/* The maximum frequency divider supports is 32, not 128(2^7) */
+static const struct clk_div_table c3_gp0_pll_od_table[] = {
+	{ 0,  1 },
+	{ 1,  2 },
+	{ 2,  4 },
+	{ 3,  8 },
+	{ 4, 16 },
+	{ 5, 32 },
+	{ /* sentinel */ }
+};
+
+AML_CLK_PLL_RW(gp0_pll_dco, ANACTRL_GP0PLL_CTRL0, 28, 1,  /* en */
+		ANACTRL_GP0PLL_CTRL0, 0,  9,  /* m */
+		ANACTRL_GP0PLL_CTRL1, 0, 19,  /* frac */
+		ANACTRL_GP0PLL_CTRL0, 10, 5,  /* n */
+		ANACTRL_GP0PLL_CTRL0, 31, 1,  /* lock */
+		ANACTRL_GP0PLL_CTRL0, 29, 1,  /* rst */
+		c3_gp0_init_regs, ARRAY_SIZE(c3_gp0_init_regs),
+		NULL, c3_gp0_pll_params_table, 0,
+		&pll_dco_parent, 0);
+AML_CLK_DIV_RW(gp0_pll, ANACTRL_GP0PLL_CTRL0, 16, 3,
+		c3_gp0_pll_od_table, 0,
+		&gp0_pll_dco.hw, CLK_SET_RATE_PARENT);
+
+static const struct reg_sequence c3_hifi_init_regs[] = {
+	{ .reg = ANACTRL_HIFIPLL_CTRL0,	.def = 0x08010496 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL0,	.def = 0x38010496 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL1,	.def = 0x0000ce40 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x00000000 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
+	{ .reg = ANACTRL_HIFIPLL_CTRL6,	.def = 0x56540000, .delay_us = 50 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL0,	.def = 0x18010496, .delay_us = 20 },
+};
+
+static const struct pll_params_table c3_hifi_pll_params_table[] = {
+	PLL_PARAMS(150, 1), /* DCO = 3600M */
+	PLL_PARAMS(130, 1), /* DCO = 3120M */
+	PLL_PARAMS(192, 1), /* DCO = 4608M */
+	PLL_PARAMS(125, 1), /* DCO = 3000M */
+	{ /* sentinel */  }
+};
+
+AML_CLK_PLL_RW(hifi_pll_dco, ANACTRL_HIFIPLL_CTRL0, 28, 1,  /* en */
+		ANACTRL_HIFIPLL_CTRL0, 0,  8,  /* m */
+		ANACTRL_HIFIPLL_CTRL1, 0, 19,  /* frac */
+		ANACTRL_HIFIPLL_CTRL0, 10, 5,  /* n */
+		ANACTRL_HIFIPLL_CTRL0, 31, 1,  /* lock */
+		ANACTRL_HIFIPLL_CTRL0, 29, 1,  /* rst */
+		c3_hifi_init_regs, ARRAY_SIZE(c3_hifi_init_regs),
+		NULL, c3_hifi_pll_params_table, 0,
+		&pll_dco_parent, 0);
+AML_CLK_DIV_RW(hifi_pll, ANACTRL_HIFIPLL_CTRL0, 16, 2,
+		NULL, CLK_DIVIDER_POWER_OF_TWO,
+		&hifi_pll_dco.hw, CLK_SET_RATE_PARENT);
+
+static const struct reg_sequence c3_mclk_init_regs[] = {
+	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x20011063 },
+	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x30011063 },
+	{ .reg = ANACTRL_MPLL_CTRL1,	.def = 0x1420500f },
+	{ .reg = ANACTRL_MPLL_CTRL2,	.def = 0x00023041 },
+	{ .reg = ANACTRL_MPLL_CTRL3,	.def = 0x18180000 },
+	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x10011063 },
+	{ .reg = ANACTRL_MPLL_CTRL2,	.def = 0x00023001 }
+};
+
+static const struct pll_params_table c3_mclk_pll_params_table[] = {
+	PLL_PARAMS(99, 1), /* VCO = 2376M */
+	{ /* sentinel */  }
+};
+
+static const struct clk_div_table c3_mpll_od_table[] = {
+	{ 0,  1 },
+	{ 1,  2 },
+	{ 2,  4 },
+	{ 3,  8 },
+	{ 4, 16 },
+	{ /* sentinel */ }
+};
+
+AML_CLK_PLL_RW(mclk_pll_dco, ANACTRL_MPLL_CTRL0, 28, 1,  /* en */
+		ANACTRL_MPLL_CTRL0, 0,  8,  /* m */
+		0, 0, 0,  /* frac */
+		ANACTRL_MPLL_CTRL0, 16, 5,  /* n */
+		ANACTRL_MPLL_CTRL0, 31, 1,  /* lock */
+		ANACTRL_MPLL_CTRL0, 29, 1,  /* rst */
+		c3_mclk_init_regs, ARRAY_SIZE(c3_mclk_init_regs),
+		NULL, c3_mclk_pll_params_table, 0,
+		&mclk_pll_dco_parent, 0);
+AML_CLK_DIV_RW(mclk_pll, ANACTRL_MPLL_CTRL0, 12, 3,
+		c3_mpll_od_table, 0,
+		&mclk_pll_dco.hw, CLK_SET_RATE_PARENT);
+AML_CLK_DIV_RW(mclk_pll_clk, ANACTRL_MPLL_CTRL4, 16, 5, NULL,
+		CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
+		&mclk_pll.hw, CLK_SET_RATE_PARENT);
+
+static const struct clk_parent_data mclk_parent[] = {
+	{ .hw = &mclk_pll_clk.hw },
+	{ .fw_name = "mclk_pll_in" },
+	{ .hw = &fclk_div40.hw }
+};
+
+AML_CLK_MUX_RW(mclk0_sel, ANACTRL_MPLL_CTRL4, 0x3, 4, NULL, 0,
+		mclk_parent, 0);
+AML_CLK_GATE_RW(mclk0_sel_out, ANACTRL_MPLL_CTRL4, 1, 0,
+		&mclk0_sel.hw, CLK_SET_RATE_PARENT);
+AML_CLK_DIV_RW(mclk0_div, ANACTRL_MPLL_CTRL4, 2, 1, NULL, 0,
+		&mclk0_sel_out.hw, CLK_SET_RATE_PARENT);
+AML_CLK_GATE_RW(mclk0, ANACTRL_MPLL_CTRL4, 0, 0,
+		&mclk0_div.hw, CLK_SET_RATE_PARENT);
+
+AML_CLK_MUX_RW(mclk1_sel, ANACTRL_MPLL_CTRL4, 0x3, 12, NULL, 0,
+		mclk_parent, 0);
+AML_CLK_GATE_RW(mclk1_sel_out, ANACTRL_MPLL_CTRL4, 9, 0,
+		&mclk1_sel.hw, CLK_SET_RATE_PARENT);
+AML_CLK_DIV_RW(mclk1_div, ANACTRL_MPLL_CTRL4, 10, 1, NULL, 0,
+		&mclk1_sel_out.hw, CLK_SET_RATE_PARENT);
+AML_CLK_GATE_RW(mclk1, ANACTRL_MPLL_CTRL4, 8, 0,
+		&mclk1_div.hw, CLK_SET_RATE_PARENT);
+
+static struct clk_hw *c3_pll_hw_clks[] = {
+	[CLKID_FIXED_PLL_DCO]	= &fixed_pll_dco.hw,
+	[CLKID_FIXED_PLL]	= &fixed_pll.hw,
+	[CLKID_FCLK_DIV40_DIV]	= &fclk_div40_div.hw,
+	[CLKID_FCLK_DIV40]	= &fclk_div40.hw,
+	[CLKID_FCLK_DIV2_DIV]	= &fclk_div2_div.hw,
+	[CLKID_FCLK_DIV2]	= &fclk_div2.hw,
+	[CLKID_FCLK_DIV2P5_DIV]	= &fclk_div2p5_div.hw,
+	[CLKID_FCLK_DIV2P5]	= &fclk_div2p5.hw,
+	[CLKID_FCLK_DIV3_DIV]	= &fclk_div3_div.hw,
+	[CLKID_FCLK_DIV3]	= &fclk_div3.hw,
+	[CLKID_FCLK_DIV4_DIV]	= &fclk_div4_div.hw,
+	[CLKID_FCLK_DIV4]	= &fclk_div4.hw,
+	[CLKID_FCLK_DIV5_DIV]	= &fclk_div5_div.hw,
+	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
+	[CLKID_FCLK_DIV7_DIV]	= &fclk_div7_div.hw,
+	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
+	[CLKID_GP0_PLL_DCO]	= &gp0_pll_dco.hw,
+	[CLKID_GP0_PLL]		= &gp0_pll.hw,
+	[CLKID_HIFI_PLL_DCO]	= &hifi_pll_dco.hw,
+	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
+	[CLKID_MCLK_PLL_DCO]	= &mclk_pll_dco.hw,
+	[CLKID_MCLK_PLL]	= &mclk_pll.hw,
+	[CLKID_MCLK_PLL_CLK]	= &mclk_pll_clk.hw,
+	[CLKID_MCLK0_SEL]	= &mclk0_sel.hw,
+	[CLKID_MCLK0_SEL_OUT]	= &mclk0_sel_out.hw,
+	[CLKID_MCLK0_DIV]	= &mclk0_div.hw,
+	[CLKID_MCLK0]		= &mclk0.hw,
+	[CLKID_MCLK1_SEL]	= &mclk1_sel.hw,
+	[CLKID_MCLK1_SEL_OUT]	= &mclk1_sel_out.hw,
+	[CLKID_MCLK1_DIV]	= &mclk1_div.hw,
+	[CLKID_MCLK1]		= &mclk1.hw
+};
+
+/* Convenience table to populate regmap in .probe */
+static struct clk_regmap *const c3_pll_clk_regmaps[] = {
+	&fixed_pll_dco,
+	&fixed_pll,
+	&fclk_div40,
+	&fclk_div2,
+	&fclk_div2p5,
+	&fclk_div3,
+	&fclk_div4,
+	&fclk_div5,
+	&fclk_div7,
+	&gp0_pll_dco,
+	&gp0_pll,
+	&hifi_pll_dco,
+	&hifi_pll,
+	&mclk_pll_dco,
+	&mclk_pll,
+	&mclk_pll_clk,
+	&mclk0_sel,
+	&mclk0_sel_out,
+	&mclk0_div,
+	&mclk0,
+	&mclk1_sel,
+	&mclk1_sel_out,
+	&mclk1_div,
+	&mclk1,
+};
+
+static struct regmap_config clkc_regmap_config = {
+	.reg_bits       = 32,
+	.val_bits       = 32,
+	.reg_stride     = 4,
+};
+
+static struct meson_clk_hw_data c3_pll_clks = {
+	.hws = c3_pll_hw_clks,
+	.num = ARRAY_SIZE(c3_pll_hw_clks),
+};
+
+static int aml_c3_pll_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	void __iomem *base;
+	int clkid, ret, i;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
+		c3_pll_clk_regmaps[i]->map = regmap;
+
+	for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
+		/* array might be sparse */
+		if (!c3_pll_clks.hws[clkid])
+			continue;
+
+		ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
+			return ret;
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
+					   &c3_pll_clks);
+}
+
+static const struct of_device_id c3_pll_clkc_match_table[] = {
+	{
+		.compatible = "amlogic,c3-pll-clkc",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
+
+static struct platform_driver c3_pll_driver = {
+	.probe		= aml_c3_pll_probe,
+	.driver		= {
+		.name	= "c3-pll-clkc",
+		.of_match_table = c3_pll_clkc_match_table,
+	},
+};
+
+module_platform_driver(c3_pll_driver);
+MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/c3-pll.h b/drivers/clk/meson/c3-pll.h
new file mode 100644
index 000000000000..92a08196a46f
--- /dev/null
+++ b/drivers/clk/meson/c3-pll.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, inc.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef __AML_C3_PLL_H__
+#define __AML_C3_PLL_H__
+
+#define ANACTRL_FIXPLL_CTRL0			0x0040
+#define ANACTRL_FIXPLL_CTRL4			0x0050
+#define ANACTRL_GP0PLL_CTRL0			0x0080
+#define ANACTRL_GP0PLL_CTRL1			0x0084
+#define ANACTRL_GP0PLL_CTRL2			0x0088
+#define ANACTRL_GP0PLL_CTRL3			0x008c
+#define ANACTRL_GP0PLL_CTRL4			0x0090
+#define ANACTRL_GP0PLL_CTRL5			0x0094
+#define ANACTRL_GP0PLL_CTRL6			0x0098
+#define ANACTRL_GP0PLL_STS			0x009c
+#define ANACTRL_HIFIPLL_CTRL0			0x0100
+#define ANACTRL_HIFIPLL_CTRL1			0x0104
+#define ANACTRL_HIFIPLL_CTRL2			0x0108
+#define ANACTRL_HIFIPLL_CTRL3			0x010c
+#define ANACTRL_HIFIPLL_CTRL4			0x0110
+#define ANACTRL_HIFIPLL_CTRL5			0x0114
+#define ANACTRL_HIFIPLL_CTRL6			0x0118
+#define ANACTRL_HIFIPLL_STS			0x011c
+#define ANACTRL_MPLL_CTRL0			0x0180
+#define ANACTRL_MPLL_CTRL1			0x0184
+#define ANACTRL_MPLL_CTRL2			0x0188
+#define ANACTRL_MPLL_CTRL3			0x018c
+#define ANACTRL_MPLL_CTRL4			0x0190
+#define ANACTRL_MPLL_STS			0x01a4
+
+#endif  /* __AML_C3_PLL_H__ */
-- 
2.37.1

