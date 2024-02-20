Return-Path: <linux-kernel+bounces-73386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6985C1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4901F246F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF66F77635;
	Tue, 20 Feb 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="USMdI9cs"
Received: from smtp54.i.mail.ru (smtp54.i.mail.ru [95.163.41.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639B76C8A;
	Tue, 20 Feb 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447987; cv=none; b=RJngsmKWZWPxkDQ7Z034ZUANc/5ub27LBpStBh4YSTiE60HCDyzHIGV9BQP7BoF0r8syM1BZOniB9SohOdVfYGPQG44pw5geZGLd8NLP0YhPPb+lnjLxKvaofJ2FZ5MZlw5eCfDyWUfE3KbDx5R1hOEJLV3Jk28jiOu3Z+7BABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447987; c=relaxed/simple;
	bh=or25zYwIYS9t5rN74G8LpFRcbC8v6JNa0ex6o6CzgcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaCdXScWIWe6+fBPvx32xLI/0v3OnhtbgLMepBjw2Uf8XokdaIT9I9DPBxsIN1Q+u/oeyLrWY9HTzWhAMwRB7+kFXMuV1JNkeatsqCXcLkZearT6c7LLD8GGvqU50Y8uT+QIQwgyk/pl6Qw3eTKpQ5Mqg+7zIdQh96k3JToAgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=USMdI9cs; arc=none smtp.client-ip=95.163.41.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Y55L7/CceG6NOhy3GLSG8p+tRezhzHyHzb8eKE0oz0k=; t=1708447985; x=1708537985; 
	b=USMdI9csztYy+xuCRBtKYYGF5h2k9+jMo97p+htXDBnolKPTARCKy8Y2qWgNaeHsthRH69Frr08
	CeS+2erG/Gzqc9F81PVHXMMGd6u3lFyqCeMp6a23kzcyovHd20ScFPbUqmJ2UmHOtMQCLZcdwYk6G
	Cl3JRh3ODm6CiJJ8414=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcTMb-0000000GhgU-3kho; Tue, 20 Feb 2024 19:53:02 +0300
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
Subject: [PATCH 8/8] clk: qcom: Add Video Clock Controller driver for SM7150
Date: Tue, 20 Feb 2024 19:52:40 +0300
Message-ID: <20240220165240.154716-9-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220165240.154716-1-danila@jiaxyga.com>
References: <20240220165240.154716-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD202146A00A96AE86747FAE6A3A4F8674344300894C459B0CD1B96ECC3A6D041DFEC540A02D48E7B53F4ACAC1F3E3F711EC75EAC3EACB7F7CF7DD35AA1534FA60CA86
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B2F9831BF6DC7018EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371C57DA68CF6C21388638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B2A7C9DC94970997CF466CB8E830073E4329F3CCF124EC3CCC7F00164DA146DAFE8445B8C89999728AA50765F7900637BA939FD1B3BAB99B389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A9FF340AA05FB58CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CB28C6475D0D32330AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C39387BBEF4507608DBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3D13DC059A893E58D35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5F7D0708D3D9B6A8C5002B1117B3ED69658EF9E009C0FA2EF9E040399BDE4761E823CB91A9FED034534781492E4B8EEADABF80F987DAEDACBC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFF6BDAEE43A9AAFA7D0234DC7247BC30C6C56063F0A23DF474C595B01A74D0A296141934554CE5B5FF1AD97FD9824DBCDD4832156CEEA9671C96C255941595840AECC1E516C1128A6146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCmmdTQzr5/8lg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132FA18D1217A7BFE97B151A33FA7A9F8E7027296B4B9225BC9310986B60D587F2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Add support for the video clock controller found on SM7150.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/clk/qcom/Kconfig          |  10 +
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/videocc-sm7150.c | 350 ++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 drivers/clk/qcom/videocc-sm7150.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 62bcd735d1d1..9369f09eb55d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1135,6 +1135,16 @@ config SM_TCSRCC_8650
 	  Support for the TCSR clock controller on SM8650 devices.
 	  Say Y if you want to use peripheral devices such as SD/UFS.
 
+config SM_VIDEOCC_7150
+	tristate "SM7150 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select SM_GCC_7150
+	select QCOM_GDSC
+	help
+	  Support for the video clock controller on SM7150 devices.
+	  Say Y if you want to support video devices and functionality such as
+	  video encode and decode.
+
 config SM_VIDEOCC_8150
 	tristate "SM8150 Video Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 9c83abef9cac..b7de8600dc3d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -143,6 +143,7 @@ obj-$(CONFIG_SM_GPUCC_8550) += gpucc-sm8550.o
 obj-$(CONFIG_SM_GPUCC_8650) += gpucc-sm8650.o
 obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
 obj-$(CONFIG_SM_TCSRCC_8650) += tcsrcc-sm8650.o
+obj-$(CONFIG_SM_VIDEOCC_7150) += videocc-sm7150.o
 obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
 obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
 obj-$(CONFIG_SM_VIDEOCC_8350) += videocc-sm8350.o
diff --git a/drivers/clk/qcom/videocc-sm7150.c b/drivers/clk/qcom/videocc-sm7150.c
new file mode 100644
index 000000000000..88093eafec55
--- /dev/null
+++ b/drivers/clk/qcom/videocc-sm7150.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm7150-videocc.h>
+
+#include "common.h"
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-pll.h"
+#include "gdsc.h"
+
+enum {
+	DT_BI_TCXO,
+	DT_BI_TCXO_AO,
+};
+
+enum {
+	P_BI_TCXO,
+	P_VIDEO_PLL0_OUT_EVEN,
+	P_VIDEO_PLL0_OUT_MAIN,
+	P_VIDEO_PLL0_OUT_ODD,
+};
+
+static const struct pll_vco fabia_vco[] = {
+	{ 249600000, 2000000000, 0 },
+	{ 125000000, 1000000000, 1 },
+};
+
+static struct alpha_pll_config video_pll0_config = {
+	.l = 0x19,
+	.alpha = 0x0,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002067,
+	.user_ctl_val = 0x00000001,
+	.user_ctl_hi_val = 0x00004805,
+	.test_ctl_hi_val = 0x40000000,
+};
+
+static struct clk_alpha_pll video_pll0 = {
+	.offset = 0x42c,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_pll0",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static const struct parent_map video_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_VIDEO_PLL0_OUT_MAIN, 1 },
+	{ P_VIDEO_PLL0_OUT_EVEN, 2 },
+	{ P_VIDEO_PLL0_OUT_ODD, 3 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &video_pll0.clkr.hw },
+	{ .hw = &video_pll0.clkr.hw },
+	{ .hw = &video_pll0.clkr.hw },
+};
+
+static const struct parent_map video_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO_AO },
+};
+
+static const struct freq_tbl ftbl_video_cc_iris_clk_src[] = {
+	F(240000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
+	F(338000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
+	F(365000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
+	F(444000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
+	F(533000000, P_VIDEO_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_iris_clk_src = {
+	.cmd_rcgr = 0x7f0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_0,
+	.freq_tbl = ftbl_video_cc_iris_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_iris_clk_src",
+		.parent_data = video_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_video_cc_xo_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_xo_clk_src = {
+	.cmd_rcgr = 0xa98,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_1,
+	.freq_tbl = ftbl_video_cc_xo_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_xo_clk_src",
+		.parent_data = video_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch video_cc_iris_ahb_clk = {
+	.halt_reg = 0x8f4,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x8f4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_iris_ahb_clk",
+			.parent_data = &(const struct clk_parent_data) {
+				.hw = &video_cc_iris_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs0_axi_clk = {
+	.halt_reg = 0x9ec,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9ec,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs0_core_clk = {
+	.halt_reg = 0x890,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x890,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0_core_clk",
+			.parent_data = &(const struct clk_parent_data) {
+				.hw = &video_cc_iris_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs1_axi_clk = {
+	.halt_reg = 0xa0c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa0c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs1_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs1_core_clk = {
+	.halt_reg = 0x8d0,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x8d0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs1_core_clk",
+			.parent_data = &(const struct clk_parent_data) {
+				.hw = &video_cc_iris_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvsc_core_clk = {
+	.halt_reg = 0x850,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x850,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvsc_core_clk",
+			.parent_data = &(const struct clk_parent_data) {
+				.hw = &video_cc_iris_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvsc_ctl_axi_clk = {
+	.halt_reg = 0x9cc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9cc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvsc_ctl_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_venus_ahb_clk = {
+	.halt_reg = 0xa6c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xa6c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_venus_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc venus_gdsc = {
+	.gdscr = 0x814,
+	.pd = {
+		.name = "venus_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc vcodec0_gdsc = {
+	.gdscr = 0x874,
+	.pd = {
+		.name = "vcodec0_gdsc",
+	},
+	.flags = HW_CTRL,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc vcodec1_gdsc = {
+	.gdscr = 0x8b4,
+	.pd = {
+		.name = "vcodec1_gdsc",
+	},
+	.flags = HW_CTRL,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct clk_regmap *video_cc_sm7150_clocks[] = {
+	[VIDEO_PLL0] = &video_pll0.clkr,
+	[VIDEO_CC_IRIS_AHB_CLK] = &video_cc_iris_ahb_clk.clkr,
+	[VIDEO_CC_IRIS_CLK_SRC] = &video_cc_iris_clk_src.clkr,
+	[VIDEO_CC_MVS0_AXI_CLK] = &video_cc_mvs0_axi_clk.clkr,
+	[VIDEO_CC_MVS0_CORE_CLK] = &video_cc_mvs0_core_clk.clkr,
+	[VIDEO_CC_MVS1_AXI_CLK] = &video_cc_mvs1_axi_clk.clkr,
+	[VIDEO_CC_MVS1_CORE_CLK] = &video_cc_mvs1_core_clk.clkr,
+	[VIDEO_CC_MVSC_CORE_CLK] = &video_cc_mvsc_core_clk.clkr,
+	[VIDEO_CC_MVSC_CTL_AXI_CLK] = &video_cc_mvsc_ctl_axi_clk.clkr,
+	[VIDEO_CC_VENUS_AHB_CLK] = &video_cc_venus_ahb_clk.clkr,
+	[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr,
+};
+
+static struct gdsc *video_cc_sm7150_gdscs[] = {
+	[VENUS_GDSC] = &venus_gdsc,
+	[VCODEC0_GDSC] = &vcodec0_gdsc,
+	[VCODEC1_GDSC] = &vcodec1_gdsc,
+};
+
+static const struct regmap_config video_cc_sm7150_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0xb94,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc video_cc_sm7150_desc = {
+	.config = &video_cc_sm7150_regmap_config,
+	.clks = video_cc_sm7150_clocks,
+	.num_clks = ARRAY_SIZE(video_cc_sm7150_clocks),
+	.gdscs = video_cc_sm7150_gdscs,
+	.num_gdscs = ARRAY_SIZE(video_cc_sm7150_gdscs),
+};
+
+static const struct of_device_id video_cc_sm7150_match_table[] = {
+	{ .compatible = "qcom,sm7150-videocc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, video_cc_sm7150_match_table);
+
+static int video_cc_sm7150_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &video_cc_sm7150_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_fabia_pll_configure(&video_pll0, regmap, &video_pll0_config);
+
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x984); /* VIDEO_CC_XO_CLK */
+
+	return qcom_cc_really_probe(pdev, &video_cc_sm7150_desc, regmap);
+}
+
+static struct platform_driver video_cc_sm7150_driver = {
+	.probe = video_cc_sm7150_probe,
+	.driver = {
+		.name = "video_cc-sm7150",
+		.of_match_table = video_cc_sm7150_match_table,
+	},
+};
+module_platform_driver(video_cc_sm7150_driver);
+
+MODULE_DESCRIPTION("Qualcomm SM7150 Video Clock Controller");
+MODULE_LICENSE("GPL");
-- 
2.43.2


