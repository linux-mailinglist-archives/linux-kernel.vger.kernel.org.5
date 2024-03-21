Return-Path: <linux-kernel+bounces-110642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C368861AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DE91F22E85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A91135418;
	Thu, 21 Mar 2024 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="iXJU0qBq"
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [95.163.41.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A60134CC6;
	Thu, 21 Mar 2024 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052954; cv=none; b=L/2HuCXgvWhRj7SdK4LnV/HyQZOMX3v2mWnANtCKTTDmAb4/84PFAgoKutIbZiedjbXqOwS9zqsWyB1uJ5JlBlcUU+RBbelMjuQ7y86aqp4MPoccratYr06au1YqoXdFgMSGSem8rqcTobuxu+oLPbm80oDrQdyULpSrVjTS4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052954; c=relaxed/simple;
	bh=EGmKssAxNwd+P4LbgQAjiNQ5cASSTRIItbi9U9Fp9y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJkIwMh+QHIRaF+96Zgt/Jiyvyph9xDFiowE002kP0hMZLOu/gOklWnx34q3kjdAZfCDmicJXDiqctq5YJ/K0ZFNFdT69ABms6eRR687mEikv0rlZmjzZMVAG8CkRMF8cafmGuLPYwlOZ2xQnnzhmvDBPtQryRmJ1qXogENlM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=iXJU0qBq; arc=none smtp.client-ip=95.163.41.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=gINxiJcUFeLe6Z2vVqPDCPAf1OWEZL1AfnsFicNmbOc=; t=1711052949; x=1711142949; 
	b=iXJU0qBqttmP/dqYfWdCUdqMCqOqcAVw5iNMu5qa1+qsrCx0BKgyK/nXEuFtAro42PcYyEcglkG
	72mUqHX3MnJvFldKoPnGSEROEAWrxhI4Z/0qRc6qapfbn6nuuQ41/EmDmJNx1zoVAicDOiSqdXG0q
	JVBVGtxjJycAXdubDiA=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rnP2A-00000005qz4-08Db; Thu, 21 Mar 2024 23:29:06 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	david@mainlining.org,
	adrian@travitia.xyz
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 5/7] clk: qcom: Add Camera Clock Controller driver for SM7150
Date: Thu, 21 Mar 2024 23:28:12 +0300
Message-ID: <20240321202814.59835-6-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321202814.59835-1-danila@jiaxyga.com>
References: <20240321202814.59835-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp29.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92CB91DAA594FB6BF5D42B8B457FE10AC08FDFA69BF118220182A05F53808504068205449F9B92CB4D27678DDAA806314401864EB2D4AC20CDF7EF9FDA0AB3C10D1B92C80ADEE25BB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7176D509958FF914FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063727016AA9DD68C3F58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E6632404E864373AB82A659056168E437866D7BD4BBF54D6CC7F00164DA146DAFE8445B8C89999728AA50765F7900637BA939FD1B3BAB99B389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A9FF340AA05FB58CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CC6602A96AF88C695AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3412F1C52C07EA12DBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C300D476B8B50F5EBD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A51142F6BD268922765002B1117B3ED6969249C6780B00FE83361FAC1196A180DE823CB91A9FED034534781492E4B8EEADA648246C2BBEBB8FC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB421ACC0882F2ADEB05AEA203743B07DA86CCF3A6CFE28E2C8D139613C49DB1E08FC8DA71D385488A5E652D4FCD6795AB7C41254F29764A807F407391B6C10D8464852623EC89511146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes26OGmEJhMS5ww==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498123F80C9C64FBB36E72C88FB39F7EDAED577F7E53379AA16B568E70397FA876F92C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add support for the camera clock controller found on SM7150.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/clk/qcom/Kconfig        |    8 +
 drivers/clk/qcom/Makefile       |    1 +
 drivers/clk/qcom/camcc-sm7150.c | 2061 +++++++++++++++++++++++++++++++
 3 files changed, 2070 insertions(+)
 create mode 100644 drivers/clk/qcom/camcc-sm7150.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 384c50cbdcd0..62bcd735d1d1 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -802,6 +802,14 @@ config SM_CAMCC_6350
 	  Support for the camera clock controller on SM6350 devices.
 	  Say Y if you want to support camera devices and camera functionality.
 
+config SM_CAMCC_7150
+	tristate "SM7150 Camera Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select SM_GCC_7150
+	help
+	  Support for the camera clock controller on SM7150 devices.
+	  Say Y if you want to support camera devices and camera functionality.
+
 config SM_CAMCC_8250
 	tristate "SM8250 Camera Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index cdec5ce2bb94..9c83abef9cac 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_SDX_GCC_55) += gcc-sdx55.o
 obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
 obj-$(CONFIG_SDX_GCC_75) += gcc-sdx75.o
 obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
+obj-$(CONFIG_SM_CAMCC_7150) += camcc-sm7150.o
 obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
 obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
 obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
diff --git a/drivers/clk/qcom/camcc-sm7150.c b/drivers/clk/qcom/camcc-sm7150.c
new file mode 100644
index 000000000000..a81ce6ab8cd5
--- /dev/null
+++ b/drivers/clk/qcom/camcc-sm7150.c
@@ -0,0 +1,2061 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2018, 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm7150-camcc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "common.h"
+#include "gdsc.h"
+
+enum {
+	DT_BI_TCXO,
+	DT_BI_TCXO_AO,
+	DT_CHIP_SLEEP_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_BI_TCXO_MX,
+	P_CAMCC_PLL0_OUT_EVEN,
+	P_CAMCC_PLL0_OUT_MAIN,
+	P_CAMCC_PLL0_OUT_ODD,
+	P_CAMCC_PLL1_OUT_EVEN,
+	P_CAMCC_PLL2_OUT_AUX,
+	P_CAMCC_PLL2_OUT_EARLY,
+	P_CAMCC_PLL2_OUT_MAIN,
+	P_CAMCC_PLL3_OUT_EVEN,
+	P_CAMCC_PLL4_OUT_EVEN,
+	P_CHIP_SLEEP_CLK,
+};
+
+static const struct pll_vco fabia_vco[] = {
+	{ 249600000, 2000000000, 0 },
+};
+
+/* 1200MHz configuration */
+static const struct alpha_pll_config camcc_pll0_config = {
+	.l = 0x3e,
+	.alpha = 0x8000,
+	.post_div_mask = 0xff << 8,
+	.post_div_val = 0x31 << 8,
+	.test_ctl_val = 0x40000000,
+};
+
+static struct clk_alpha_pll camcc_pll0 = {
+	.offset = 0x0,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_pll0",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor camcc_pll0_out_even = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll0_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static struct clk_fixed_factor camcc_pll0_out_odd = {
+	.mult = 1,
+	.div = 3,
+	.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll0_out_odd",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+/* 680MHz configuration */
+static const struct alpha_pll_config camcc_pll1_config = {
+	.l = 0x23,
+	.alpha = 0x6aaa,
+	.post_div_mask = 0xf << 8,
+	.post_div_val = 0x1 << 8,
+	.test_ctl_val = 0x40000000,
+};
+
+static struct clk_alpha_pll camcc_pll1 = {
+	.offset = 0x1000,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_pll1",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor camcc_pll1_out_even = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll1_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll1.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+/* 1920MHz configuration */
+static const struct alpha_pll_config camcc_pll2_config = {
+	.l = 0x64,
+	.post_div_val = 0x3 << 8,
+	.post_div_mask = 0x3 << 8,
+	.early_output_mask = BIT(3),
+	.aux_output_mask = BIT(1),
+	.main_output_mask = BIT(0),
+	.config_ctl_hi_val = 0x400003d6,
+	.config_ctl_val = 0x20000954,
+};
+
+static struct clk_alpha_pll camcc_pll2 = {
+	.offset = 0x2000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_pll2",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_agera_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor camcc_pll2_out_early = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll2_out_early",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv camcc_pll2_out_aux = {
+	.offset = 0x2000,
+	.post_div_shift = 8,
+	.width = 2,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll2_out_aux",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv camcc_pll2_out_main = {
+	.offset = 0x2000,
+	.post_div_shift = 8,
+	.width = 2,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll2_out_main",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll2.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+/* 760MHz configuration */
+static const struct alpha_pll_config camcc_pll3_config = {
+	.l = 0x27,
+	.alpha = 0x9555,
+	.post_div_mask = 0xf << 8,
+	.post_div_val = 0x1 << 8,
+	.test_ctl_val = 0x40000000,
+};
+
+static struct clk_alpha_pll camcc_pll3 = {
+	.offset = 0x3000,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_pll3",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor camcc_pll3_out_even = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll3_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll3.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static struct clk_alpha_pll camcc_pll4 = {
+	.offset = 0x4000,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_pll4",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor camcc_pll4_out_even = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_pll4_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
+			&camcc_pll4.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static const struct parent_map camcc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL0_OUT_EVEN, 2 },
+	{ P_CAMCC_PLL0_OUT_ODD, 3 },
+	{ P_CAMCC_PLL2_OUT_MAIN, 5 },
+};
+
+static const struct clk_parent_data camcc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll0_out_even.hw },
+	{ .hw = &camcc_pll0_out_odd.hw },
+	{ .hw = &camcc_pll2_out_main.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL0_OUT_EVEN, 2 },
+	{ P_CAMCC_PLL0_OUT_ODD, 3 },
+	{ P_CAMCC_PLL1_OUT_EVEN, 4 },
+	{ P_CAMCC_PLL2_OUT_EARLY, 5 },
+};
+
+static const struct clk_parent_data camcc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll0_out_even.hw },
+	{ .hw = &camcc_pll0_out_odd.hw },
+	{ .hw = &camcc_pll1_out_even.hw },
+	{ .hw = &camcc_pll2_out_early.hw },
+};
+
+static const struct parent_map camcc_parent_map_2[] = {
+	{ P_BI_TCXO_MX, 0 },
+	{ P_CAMCC_PLL2_OUT_AUX, 5 },
+};
+
+static const struct clk_parent_data camcc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll2_out_aux.clkr.hw },
+};
+
+static const struct parent_map camcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_MAIN, 1 },
+	{ P_CAMCC_PLL0_OUT_EVEN, 2 },
+	{ P_CAMCC_PLL0_OUT_ODD, 3 },
+	{ P_CAMCC_PLL2_OUT_EARLY, 5 },
+	{ P_CAMCC_PLL4_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data camcc_parent_data_3[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll0.clkr.hw },
+	{ .hw = &camcc_pll0_out_even.hw },
+	{ .hw = &camcc_pll0_out_odd.hw },
+	{ .hw = &camcc_pll2_out_early.hw },
+	{ .hw = &camcc_pll4_out_even.hw },
+};
+
+static const struct parent_map camcc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL3_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data camcc_parent_data_4[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll3_out_even.hw },
+};
+
+static const struct parent_map camcc_parent_map_5[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL4_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data camcc_parent_data_5[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll4_out_even.hw },
+};
+
+static const struct parent_map camcc_parent_map_6[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL1_OUT_EVEN, 4 },
+};
+
+static const struct clk_parent_data camcc_parent_data_6[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll1_out_even.hw },
+};
+
+static const struct parent_map camcc_parent_map_7[] = {
+	{ P_CHIP_SLEEP_CLK, 0 },
+};
+
+static const struct clk_parent_data camcc_parent_data_7[] = {
+	{ .index = DT_CHIP_SLEEP_CLK },
+};
+
+static const struct parent_map camcc_parent_map_8[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CAMCC_PLL0_OUT_ODD, 3 },
+};
+
+static const struct clk_parent_data camcc_parent_data_8[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &camcc_pll0_out_odd.hw },
+};
+
+static const struct parent_map camcc_parent_map_9[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data camcc_parent_data_9[] = {
+	{ .index = DT_BI_TCXO_AO },
+};
+
+static const struct freq_tbl ftbl_camcc_bps_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(100000000, P_CAMCC_PLL0_OUT_EVEN, 6, 0, 0),
+	F(200000000, P_CAMCC_PLL0_OUT_ODD, 2, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_MAIN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_bps_clk_src = {
+	.cmd_rcgr = 0x7010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_bps_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_bps_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_camnoc_axi_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(150000000, P_CAMCC_PLL0_OUT_EVEN, 4, 0, 0),
+	F(240000000, P_CAMCC_PLL2_OUT_MAIN, 2, 0, 0),
+	F(320000000, P_CAMCC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_camnoc_axi_clk_src = {
+	.cmd_rcgr = 0xc12c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_camnoc_axi_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_camnoc_axi_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_cci_0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(37500000, P_CAMCC_PLL0_OUT_EVEN, 16, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_cci_0_clk_src = {
+	.cmd_rcgr = 0xc0c4,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_cci_0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_cci_0_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_cci_1_clk_src = {
+	.cmd_rcgr = 0xc0e0,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_cci_0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_cci_1_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_cphy_rx_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(300000000, P_CAMCC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(384000000, P_CAMCC_PLL2_OUT_EARLY, 2.5, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_cphy_rx_clk_src = {
+	.cmd_rcgr = 0xa064,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_cphy_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_cphy_rx_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_csi0phytimer_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(300000000, P_CAMCC_PLL0_OUT_EVEN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_csi0phytimer_clk_src = {
+	.cmd_rcgr = 0x6004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_csi0phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_csi1phytimer_clk_src = {
+	.cmd_rcgr = 0x6028,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_csi1phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_csi2phytimer_clk_src = {
+	.cmd_rcgr = 0x604c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_csi2phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_csi3phytimer_clk_src = {
+	.cmd_rcgr = 0x6070,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_csi0phytimer_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_csi3phytimer_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_fast_ahb_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(50000000, P_CAMCC_PLL0_OUT_EVEN, 12, 0, 0),
+	F(100000000, P_CAMCC_PLL0_OUT_EVEN, 6, 0, 0),
+	F(200000000, P_CAMCC_PLL0_OUT_EVEN, 3, 0, 0),
+	F(300000000, P_CAMCC_PLL0_OUT_MAIN, 4, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_fast_ahb_clk_src = {
+	.cmd_rcgr = 0x703c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_fast_ahb_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_fast_ahb_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_fd_core_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(380000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
+	F(384000000, P_CAMCC_PLL2_OUT_EARLY, 2.5, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_EARLY, 2, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_fd_core_clk_src = {
+	.cmd_rcgr = 0xc09c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_3,
+	.freq_tbl = ftbl_camcc_fd_core_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_fd_core_clk_src",
+		.parent_data = camcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_icp_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_icp_clk_src = {
+	.cmd_rcgr = 0xc074,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_icp_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_icp_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ife_0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(380000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
+	F(510000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
+	F(637000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
+	F(760000000, P_CAMCC_PLL3_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ife_0_clk_src = {
+	.cmd_rcgr = 0xa010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_4,
+	.freq_tbl = ftbl_camcc_ife_0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_ife_0_clk_src",
+		.parent_data = camcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_4),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ife_0_csid_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(75000000, P_CAMCC_PLL0_OUT_EVEN, 8, 0, 0),
+	F(300000000, P_CAMCC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(384000000, P_CAMCC_PLL2_OUT_EARLY, 2.5, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ife_0_csid_clk_src = {
+	.cmd_rcgr = 0xa03c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_ife_0_csid_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_ife_0_csid_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ife_1_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(380000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
+	F(510000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
+	F(637000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
+	F(760000000, P_CAMCC_PLL4_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ife_1_clk_src = {
+	.cmd_rcgr = 0xb010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_5,
+	.freq_tbl = ftbl_camcc_ife_1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_ife_1_clk_src",
+		.parent_data = camcc_parent_data_5,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_5),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_1_csid_clk_src = {
+	.cmd_rcgr = 0xb034,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_ife_0_csid_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_ife_1_csid_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ife_lite_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(320000000, P_CAMCC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_ODD, 1, 0, 0),
+	F(480000000, P_CAMCC_PLL2_OUT_MAIN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ife_lite_clk_src = {
+	.cmd_rcgr = 0xc004,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_ife_lite_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_ife_lite_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_ife_lite_csid_clk_src = {
+	.cmd_rcgr = 0xc020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_1,
+	.freq_tbl = ftbl_camcc_cphy_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_ife_lite_csid_clk_src",
+		.parent_data = camcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_ipe_0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(340000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(430000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(520000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	F(600000000, P_CAMCC_PLL1_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_ipe_0_clk_src = {
+	.cmd_rcgr = 0x8010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_6,
+	.freq_tbl = ftbl_camcc_ipe_0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_ipe_0_clk_src",
+		.parent_data = camcc_parent_data_6,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_6),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_jpeg_clk_src = {
+	.cmd_rcgr = 0xc048,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_bps_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_jpeg_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_lrme_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(100000000, P_CAMCC_PLL0_OUT_EVEN, 6, 0, 0),
+	F(240000000, P_CAMCC_PLL2_OUT_MAIN, 2, 0, 0),
+	F(300000000, P_CAMCC_PLL0_OUT_EVEN, 2, 0, 0),
+	F(320000000, P_CAMCC_PLL2_OUT_MAIN, 1.5, 0, 0),
+	F(400000000, P_CAMCC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_lrme_clk_src = {
+	.cmd_rcgr = 0xc100,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_0,
+	.freq_tbl = ftbl_camcc_lrme_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_lrme_clk_src",
+		.parent_data = camcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_mclk0_clk_src[] = {
+	F(19200000, P_BI_TCXO_MX, 1, 0, 0),
+	F(24000000, P_CAMCC_PLL2_OUT_AUX, 1, 1, 20),
+	F(34285714, P_CAMCC_PLL2_OUT_AUX, 14, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_mclk0_clk_src = {
+	.cmd_rcgr = 0x5004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_mclk0_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_mclk1_clk_src = {
+	.cmd_rcgr = 0x5024,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_mclk1_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_mclk2_clk_src = {
+	.cmd_rcgr = 0x5044,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_mclk2_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camcc_mclk3_clk_src = {
+	.cmd_rcgr = 0x5064,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_2,
+	.freq_tbl = ftbl_camcc_mclk0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_mclk3_clk_src",
+		.parent_data = camcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_2),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_sleep_clk_src[] = {
+	F(32000, P_CHIP_SLEEP_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_sleep_clk_src = {
+	.cmd_rcgr = 0xc1a4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_7,
+	.freq_tbl = ftbl_camcc_sleep_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_sleep_clk_src",
+		.parent_data = camcc_parent_data_7,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_7),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_slow_ahb_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(80000000, P_CAMCC_PLL0_OUT_ODD, 5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_slow_ahb_clk_src = {
+	.cmd_rcgr = 0x7058,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_8,
+	.freq_tbl = ftbl_camcc_slow_ahb_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_slow_ahb_clk_src",
+		.parent_data = camcc_parent_data_8,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_8),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_camcc_xo_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camcc_xo_clk_src = {
+	.cmd_rcgr = 0xc188,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = camcc_parent_map_9,
+	.freq_tbl = ftbl_camcc_xo_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "camcc_xo_clk_src",
+		.parent_data = camcc_parent_data_9,
+		.num_parents = ARRAY_SIZE(camcc_parent_data_9),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch camcc_bps_ahb_clk = {
+	.halt_reg = 0x7070,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7070,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_bps_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_slow_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_bps_areg_clk = {
+	.halt_reg = 0x7054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7054,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_bps_areg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_fast_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_bps_axi_clk = {
+	.halt_reg = 0x7038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7038,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_bps_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_camnoc_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_bps_clk = {
+	.halt_reg = 0x7028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_bps_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_bps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_camnoc_axi_clk = {
+	.halt_reg = 0xc148,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc148,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_camnoc_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_camnoc_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_camnoc_dcd_xo_clk = {
+	.halt_reg = 0xc150,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc150,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_camnoc_dcd_xo_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_xo_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_cci_0_clk = {
+	.halt_reg = 0xc0dc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0dc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_cci_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cci_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_cci_1_clk = {
+	.halt_reg = 0xc0f8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0f8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_cci_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cci_1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_core_ahb_clk = {
+	.halt_reg = 0xc184,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0xc184,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_core_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_slow_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_cpas_ahb_clk = {
+	.halt_reg = 0xc124,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc124,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_cpas_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_slow_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi0phytimer_clk = {
+	.halt_reg = 0x601c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x601c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csi0phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_csi0phytimer_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi1phytimer_clk = {
+	.halt_reg = 0x6040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6040,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csi1phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_csi1phytimer_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi2phytimer_clk = {
+	.halt_reg = 0x6064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6064,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csi2phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_csi2phytimer_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csi3phytimer_clk = {
+	.halt_reg = 0x6088,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6088,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csi3phytimer_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_csi3phytimer_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy0_clk = {
+	.halt_reg = 0x6020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6020,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csiphy0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cphy_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy1_clk = {
+	.halt_reg = 0x6044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csiphy1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cphy_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy2_clk = {
+	.halt_reg = 0x6068,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6068,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csiphy2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cphy_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_csiphy3_clk = {
+	.halt_reg = 0x608c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x608c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_csiphy3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cphy_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_fd_core_clk = {
+	.halt_reg = 0xc0b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_fd_core_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_fd_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_fd_core_uar_clk = {
+	.halt_reg = 0xc0bc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc0bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_fd_core_uar_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_fd_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_icp_ahb_clk = {
+	.halt_reg = 0xc094,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc094,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_icp_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_slow_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_icp_clk = {
+	.halt_reg = 0xc08c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc08c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_icp_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_icp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_axi_clk = {
+	.halt_reg = 0xa080,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa080,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_0_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_camnoc_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_clk = {
+	.halt_reg = 0xa028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_cphy_rx_clk = {
+	.halt_reg = 0xa07c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa07c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_0_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cphy_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_csid_clk = {
+	.halt_reg = 0xa054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa054,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_0_csid_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_0_csid_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_0_dsp_clk = {
+	.halt_reg = 0xa038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa038,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_0_dsp_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_axi_clk = {
+	.halt_reg = 0xb058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb058,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_1_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_camnoc_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_clk = {
+	.halt_reg = 0xb028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_cphy_rx_clk = {
+	.halt_reg = 0xb054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb054,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_1_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cphy_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_csid_clk = {
+	.halt_reg = 0xb04c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb04c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_1_csid_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_1_csid_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_1_dsp_clk = {
+	.halt_reg = 0xb030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb030,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_1_dsp_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_lite_clk = {
+	.halt_reg = 0xc01c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc01c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_lite_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_lite_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_lite_cphy_rx_clk = {
+	.halt_reg = 0xc040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc040,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_lite_cphy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_cphy_rx_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ife_lite_csid_clk = {
+	.halt_reg = 0xc038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc038,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ife_lite_csid_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ife_lite_csid_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_ahb_clk = {
+	.halt_reg = 0x8040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8040,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_0_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_slow_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_areg_clk = {
+	.halt_reg = 0x803c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x803c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_0_areg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_fast_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_axi_clk = {
+	.halt_reg = 0x8038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8038,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_0_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_camnoc_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_0_clk = {
+	.halt_reg = 0x8028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ipe_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_1_ahb_clk = {
+	.halt_reg = 0x9028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_1_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_slow_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_1_areg_clk = {
+	.halt_reg = 0x9024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_1_areg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_fast_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_1_axi_clk = {
+	.halt_reg = 0x9020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9020,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_1_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_camnoc_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_ipe_1_clk = {
+	.halt_reg = 0x9010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_ipe_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_ipe_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_jpeg_clk = {
+	.halt_reg = 0xc060,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc060,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_jpeg_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_jpeg_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_lrme_clk = {
+	.halt_reg = 0xc118,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc118,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_lrme_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_lrme_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk0_clk = {
+	.halt_reg = 0x501c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x501c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_mclk0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_mclk0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk1_clk = {
+	.halt_reg = 0x503c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x503c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_mclk1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_mclk1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk2_clk = {
+	.halt_reg = 0x505c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x505c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_mclk2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_mclk2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_mclk3_clk = {
+	.halt_reg = 0x507c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x507c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_mclk3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_mclk3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camcc_sleep_clk = {
+	.halt_reg = 0xc1bc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xc1bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "camcc_sleep_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&camcc_sleep_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc camcc_titan_top_gdsc;
+
+static struct gdsc camcc_bps_gdsc = {
+	.gdscr = 0x7004,
+	.pd = {
+		.name = "camcc_bps_gdsc",
+	},
+	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camcc_ife_0_gdsc = {
+	.gdscr = 0xa004,
+	.pd = {
+		.name = "camcc_ife_0_gdsc",
+	},
+	.flags = POLL_CFG_GDSCR,
+	.parent = &camcc_titan_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camcc_ife_1_gdsc = {
+	.gdscr = 0xb004,
+	.pd = {
+		.name = "camcc_ife_1_gdsc",
+	},
+	.flags = POLL_CFG_GDSCR,
+	.parent = &camcc_titan_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camcc_ipe_0_gdsc = {
+	.gdscr = 0x8004,
+	.pd = {
+		.name = "camcc_ipe_0_gdsc",
+	},
+	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camcc_ipe_1_gdsc = {
+	.gdscr = 0x9004,
+	.pd = {
+		.name = "camcc_ipe_1_gdsc",
+	},
+	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camcc_titan_top_gdsc = {
+	.gdscr = 0xc1c4,
+	.pd = {
+		.name = "camcc_titan_top_gdsc",
+	},
+	.flags = POLL_CFG_GDSCR,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+struct clk_hw *camcc_sm7150_hws[] = {
+	[CAMCC_PLL0_OUT_EVEN] = &camcc_pll0_out_even.hw,
+	[CAMCC_PLL0_OUT_ODD] = &camcc_pll0_out_odd.hw,
+	[CAMCC_PLL1_OUT_EVEN] = &camcc_pll1_out_even.hw,
+	[CAMCC_PLL2_OUT_EARLY] = &camcc_pll2_out_early.hw,
+	[CAMCC_PLL3_OUT_EVEN] = &camcc_pll3_out_even.hw,
+	[CAMCC_PLL4_OUT_EVEN] = &camcc_pll4_out_even.hw,
+};
+
+static struct clk_regmap *camcc_sm7150_clocks[] = {
+	[CAMCC_BPS_AHB_CLK] = &camcc_bps_ahb_clk.clkr,
+	[CAMCC_BPS_AREG_CLK] = &camcc_bps_areg_clk.clkr,
+	[CAMCC_BPS_AXI_CLK] = &camcc_bps_axi_clk.clkr,
+	[CAMCC_BPS_CLK] = &camcc_bps_clk.clkr,
+	[CAMCC_BPS_CLK_SRC] = &camcc_bps_clk_src.clkr,
+	[CAMCC_CAMNOC_AXI_CLK] = &camcc_camnoc_axi_clk.clkr,
+	[CAMCC_CAMNOC_AXI_CLK_SRC] = &camcc_camnoc_axi_clk_src.clkr,
+	[CAMCC_CAMNOC_DCD_XO_CLK] = &camcc_camnoc_dcd_xo_clk.clkr,
+	[CAMCC_CCI_0_CLK] = &camcc_cci_0_clk.clkr,
+	[CAMCC_CCI_0_CLK_SRC] = &camcc_cci_0_clk_src.clkr,
+	[CAMCC_CCI_1_CLK] = &camcc_cci_1_clk.clkr,
+	[CAMCC_CCI_1_CLK_SRC] = &camcc_cci_1_clk_src.clkr,
+	[CAMCC_CORE_AHB_CLK] = &camcc_core_ahb_clk.clkr,
+	[CAMCC_CPAS_AHB_CLK] = &camcc_cpas_ahb_clk.clkr,
+	[CAMCC_CPHY_RX_CLK_SRC] = &camcc_cphy_rx_clk_src.clkr,
+	[CAMCC_CSI0PHYTIMER_CLK] = &camcc_csi0phytimer_clk.clkr,
+	[CAMCC_CSI0PHYTIMER_CLK_SRC] = &camcc_csi0phytimer_clk_src.clkr,
+	[CAMCC_CSI1PHYTIMER_CLK] = &camcc_csi1phytimer_clk.clkr,
+	[CAMCC_CSI1PHYTIMER_CLK_SRC] = &camcc_csi1phytimer_clk_src.clkr,
+	[CAMCC_CSI2PHYTIMER_CLK] = &camcc_csi2phytimer_clk.clkr,
+	[CAMCC_CSI2PHYTIMER_CLK_SRC] = &camcc_csi2phytimer_clk_src.clkr,
+	[CAMCC_CSI3PHYTIMER_CLK] = &camcc_csi3phytimer_clk.clkr,
+	[CAMCC_CSI3PHYTIMER_CLK_SRC] = &camcc_csi3phytimer_clk_src.clkr,
+	[CAMCC_CSIPHY0_CLK] = &camcc_csiphy0_clk.clkr,
+	[CAMCC_CSIPHY1_CLK] = &camcc_csiphy1_clk.clkr,
+	[CAMCC_CSIPHY2_CLK] = &camcc_csiphy2_clk.clkr,
+	[CAMCC_CSIPHY3_CLK] = &camcc_csiphy3_clk.clkr,
+	[CAMCC_FAST_AHB_CLK_SRC] = &camcc_fast_ahb_clk_src.clkr,
+	[CAMCC_FD_CORE_CLK] = &camcc_fd_core_clk.clkr,
+	[CAMCC_FD_CORE_CLK_SRC] = &camcc_fd_core_clk_src.clkr,
+	[CAMCC_FD_CORE_UAR_CLK] = &camcc_fd_core_uar_clk.clkr,
+	[CAMCC_ICP_AHB_CLK] = &camcc_icp_ahb_clk.clkr,
+	[CAMCC_ICP_CLK] = &camcc_icp_clk.clkr,
+	[CAMCC_ICP_CLK_SRC] = &camcc_icp_clk_src.clkr,
+	[CAMCC_IFE_0_AXI_CLK] = &camcc_ife_0_axi_clk.clkr,
+	[CAMCC_IFE_0_CLK] = &camcc_ife_0_clk.clkr,
+	[CAMCC_IFE_0_CLK_SRC] = &camcc_ife_0_clk_src.clkr,
+	[CAMCC_IFE_0_CPHY_RX_CLK] = &camcc_ife_0_cphy_rx_clk.clkr,
+	[CAMCC_IFE_0_CSID_CLK] = &camcc_ife_0_csid_clk.clkr,
+	[CAMCC_IFE_0_CSID_CLK_SRC] = &camcc_ife_0_csid_clk_src.clkr,
+	[CAMCC_IFE_0_DSP_CLK] = &camcc_ife_0_dsp_clk.clkr,
+	[CAMCC_IFE_1_AXI_CLK] = &camcc_ife_1_axi_clk.clkr,
+	[CAMCC_IFE_1_CLK] = &camcc_ife_1_clk.clkr,
+	[CAMCC_IFE_1_CLK_SRC] = &camcc_ife_1_clk_src.clkr,
+	[CAMCC_IFE_1_CPHY_RX_CLK] = &camcc_ife_1_cphy_rx_clk.clkr,
+	[CAMCC_IFE_1_CSID_CLK] = &camcc_ife_1_csid_clk.clkr,
+	[CAMCC_IFE_1_CSID_CLK_SRC] = &camcc_ife_1_csid_clk_src.clkr,
+	[CAMCC_IFE_1_DSP_CLK] = &camcc_ife_1_dsp_clk.clkr,
+	[CAMCC_IFE_LITE_CLK] = &camcc_ife_lite_clk.clkr,
+	[CAMCC_IFE_LITE_CLK_SRC] = &camcc_ife_lite_clk_src.clkr,
+	[CAMCC_IFE_LITE_CPHY_RX_CLK] = &camcc_ife_lite_cphy_rx_clk.clkr,
+	[CAMCC_IFE_LITE_CSID_CLK] = &camcc_ife_lite_csid_clk.clkr,
+	[CAMCC_IFE_LITE_CSID_CLK_SRC] = &camcc_ife_lite_csid_clk_src.clkr,
+	[CAMCC_IPE_0_AHB_CLK] = &camcc_ipe_0_ahb_clk.clkr,
+	[CAMCC_IPE_0_AREG_CLK] = &camcc_ipe_0_areg_clk.clkr,
+	[CAMCC_IPE_0_AXI_CLK] = &camcc_ipe_0_axi_clk.clkr,
+	[CAMCC_IPE_0_CLK] = &camcc_ipe_0_clk.clkr,
+	[CAMCC_IPE_0_CLK_SRC] = &camcc_ipe_0_clk_src.clkr,
+	[CAMCC_IPE_1_AHB_CLK] = &camcc_ipe_1_ahb_clk.clkr,
+	[CAMCC_IPE_1_AREG_CLK] = &camcc_ipe_1_areg_clk.clkr,
+	[CAMCC_IPE_1_AXI_CLK] = &camcc_ipe_1_axi_clk.clkr,
+	[CAMCC_IPE_1_CLK] = &camcc_ipe_1_clk.clkr,
+	[CAMCC_JPEG_CLK] = &camcc_jpeg_clk.clkr,
+	[CAMCC_JPEG_CLK_SRC] = &camcc_jpeg_clk_src.clkr,
+	[CAMCC_LRME_CLK] = &camcc_lrme_clk.clkr,
+	[CAMCC_LRME_CLK_SRC] = &camcc_lrme_clk_src.clkr,
+	[CAMCC_MCLK0_CLK] = &camcc_mclk0_clk.clkr,
+	[CAMCC_MCLK0_CLK_SRC] = &camcc_mclk0_clk_src.clkr,
+	[CAMCC_MCLK1_CLK] = &camcc_mclk1_clk.clkr,
+	[CAMCC_MCLK1_CLK_SRC] = &camcc_mclk1_clk_src.clkr,
+	[CAMCC_MCLK2_CLK] = &camcc_mclk2_clk.clkr,
+	[CAMCC_MCLK2_CLK_SRC] = &camcc_mclk2_clk_src.clkr,
+	[CAMCC_MCLK3_CLK] = &camcc_mclk3_clk.clkr,
+	[CAMCC_MCLK3_CLK_SRC] = &camcc_mclk3_clk_src.clkr,
+	[CAMCC_PLL0] = &camcc_pll0.clkr,
+	[CAMCC_PLL1] = &camcc_pll1.clkr,
+	[CAMCC_PLL2] = &camcc_pll2.clkr,
+	[CAMCC_PLL2_OUT_AUX] = &camcc_pll2_out_aux.clkr,
+	[CAMCC_PLL2_OUT_MAIN] = &camcc_pll2_out_main.clkr,
+	[CAMCC_PLL3] = &camcc_pll3.clkr,
+	[CAMCC_PLL4] = &camcc_pll4.clkr,
+	[CAMCC_SLEEP_CLK] = &camcc_sleep_clk.clkr,
+	[CAMCC_SLEEP_CLK_SRC] = &camcc_sleep_clk_src.clkr,
+	[CAMCC_SLOW_AHB_CLK_SRC] = &camcc_slow_ahb_clk_src.clkr,
+	[CAMCC_XO_CLK_SRC] = &camcc_xo_clk_src.clkr,
+};
+
+static struct gdsc *camcc_sm7150_gdscs[] = {
+	[BPS_GDSC] = &camcc_bps_gdsc,
+	[IFE_0_GDSC] = &camcc_ife_0_gdsc,
+	[IFE_1_GDSC] = &camcc_ife_1_gdsc,
+	[IPE_0_GDSC] = &camcc_ipe_0_gdsc,
+	[IPE_1_GDSC] = &camcc_ipe_1_gdsc,
+	[TITAN_TOP_GDSC] = &camcc_titan_top_gdsc,
+};
+
+static const struct regmap_config camcc_sm7150_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0xd024,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc camcc_sm7150_desc = {
+	.config = &camcc_sm7150_regmap_config,
+	.clk_hws = camcc_sm7150_hws,
+	.num_clk_hws = ARRAY_SIZE(camcc_sm7150_hws),
+	.clks = camcc_sm7150_clocks,
+	.num_clks = ARRAY_SIZE(camcc_sm7150_clocks),
+	.gdscs = camcc_sm7150_gdscs,
+	.num_gdscs = ARRAY_SIZE(camcc_sm7150_gdscs),
+};
+
+static const struct of_device_id camcc_sm7150_match_table[] = {
+	{ .compatible = "qcom,sm7150-camcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, camcc_sm7150_match_table);
+
+static int camcc_sm7150_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &camcc_sm7150_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_fabia_pll_configure(&camcc_pll0, regmap, &camcc_pll0_config);
+	clk_fabia_pll_configure(&camcc_pll1, regmap, &camcc_pll1_config);
+	clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config);
+	clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config);
+	clk_fabia_pll_configure(&camcc_pll4, regmap, &camcc_pll3_config);
+
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xc1a0); /* CAMCC_GDSC_CLK */
+
+	return qcom_cc_really_probe(pdev, &camcc_sm7150_desc, regmap);
+}
+
+static struct platform_driver camcc_sm7150_driver = {
+	.probe = camcc_sm7150_probe,
+	.driver = {
+		.name = "camcc-sm7150",
+		.of_match_table = camcc_sm7150_match_table,
+	},
+};
+
+module_platform_driver(camcc_sm7150_driver);
+
+MODULE_DESCRIPTION("Qualcomm SM7150 Camera Clock Controller");
+MODULE_LICENSE("GPL");
-- 
2.44.0


