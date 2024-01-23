Return-Path: <linux-kernel+bounces-34664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29028385D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368E11F22525
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67A468C;
	Tue, 23 Jan 2024 02:57:06 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C644ED0;
	Tue, 23 Jan 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978625; cv=none; b=bs60Wnmh0JDCKn0AuvD/PLRP647JG63MbxW0Vv9SF9zjFMpZiLlZkT2m9UJz5g3ZC9q2gzno1CKB7eKSd7fMilr7Jnvynsy1QHAnhnlpWn+HLzRsvHgbxRk5nl4EL0m/DYSHqk2aB1xP94maYI151A5SBAtX6Lr33Z8KdPCdRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978625; c=relaxed/simple;
	bh=o++Ft/GLjaKJFH0igzw5QFIgIglblIDoWaoRsd+lqEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHScKbi/o1XmvcI79Et3Jxq7WM/Fwq/ZC+YnVzpH0Nweyuy0A5vbgCFSmTBAryQipkGL6Ct5miWE0uPdWk0EjKKxkKBv1RLdfOnq1WDsYCidw3fNL4qbC699RQE+N39cyj/bZv/6q90Xs73ViHbOKSI9mq5wSIUyAPTDVPxLdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40N2uJJU022783;
	Tue, 23 Jan 2024 10:56:19 +0800 (+08)
	(envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJs3t0L8Xz2S7xxn;
	Tue, 23 Jan 2024 10:48:58 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 23 Jan
 2024 10:56:17 +0800
From: Zhifeng Tang <zhifeng.tang@unisoc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH V4 2/3] clk: sprd: Add reset controller driver for ums512
Date: Tue, 23 Jan 2024 10:56:12 +0800
Message-ID: <20240123025613.3976-3-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240123025613.3976-1-zhifeng.tang@unisoc.com>
References: <20240123025613.3976-1-zhifeng.tang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL:SHSQR01.spreadtrum.com 40N2uJJU022783

From: "zhifeng.tang" <zhifeng.tang@unisoc.com>

In most of Sprd SOCs,The clock controller register block also
contains reset bits for some of these peripherals,so reset
controller and clock provider are combined together as a block,
and put it under the driver/clk/.

Signed-off-by: zhifeng.tang <zhifeng.tang@unisoc.com>
---
 drivers/clk/sprd/Makefile     |   1 +
 drivers/clk/sprd/common.c     |   1 +
 drivers/clk/sprd/common.h     |   2 +
 drivers/clk/sprd/reset.c      |  78 +++++++++++
 drivers/clk/sprd/reset.h      |  30 +++++
 drivers/clk/sprd/ums512-clk.c | 240 ++++++++++++++++++++++++++++++++++
 6 files changed, 352 insertions(+)
 create mode 100644 drivers/clk/sprd/reset.c
 create mode 100644 drivers/clk/sprd/reset.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index f25b2c3904fb..72f6ecf8291e 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -7,6 +7,7 @@ clk-sprd-y	+= mux.o
 clk-sprd-y	+= div.o
 clk-sprd-y	+= composite.o
 clk-sprd-y	+= pll.o
+clk-sprd-y	+= reset.o
 
 ## SoC support
 obj-$(CONFIG_SPRD_SC9860_CLK)	+= sc9860-clk.o
diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 762f0961f17f..4ddec6348447 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -75,6 +75,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 	}
 
 	sprd_clk_set_regmap(desc, regmap);
+	platform_set_drvdata(pdev, regmap);
 
 	return 0;
 }
diff --git a/drivers/clk/sprd/common.h b/drivers/clk/sprd/common.h
index 1d077b39cef6..1ac39af68497 100644
--- a/drivers/clk/sprd/common.h
+++ b/drivers/clk/sprd/common.h
@@ -24,6 +24,8 @@ struct sprd_clk_desc {
 	struct sprd_clk_common		**clk_clks;
 	unsigned long			num_clk_clks;
 	struct clk_hw_onecell_data      *hw_clks;
+	struct sprd_reset_map		*resets;
+	unsigned long			num_resets;
 };
 
 static inline struct sprd_clk_common *
diff --git a/drivers/clk/sprd/reset.c b/drivers/clk/sprd/reset.c
new file mode 100644
index 000000000000..92d19465b531
--- /dev/null
+++ b/drivers/clk/sprd/reset.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Spreadtrum reset clock driver
+//
+// Copyright (C) 2022 Spreadtrum, Inc.
+// Author: Zhifeng Tang <zhifeng.tang@unisoc.com>
+
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include "reset.h"
+
+static inline struct sprd_reset *to_sprd_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct sprd_reset, rcdev);
+}
+
+static int sprd_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct sprd_reset *reset = to_sprd_reset(rcdev);
+	const struct sprd_reset_map *map = &reset->reset_map[id];
+	unsigned int offset = map->sc_offset;
+	unsigned long flags;
+	unsigned int val;
+
+	if (map->sc) {
+		regmap_write(reset->regmap, map->reg + offset, map->mask);
+	} else {
+		spin_lock_irqsave(&reset->lock, flags);
+		regmap_read(reset->regmap, map->reg, &val);
+		val |= map->mask;
+		regmap_write(reset->regmap, map->reg, val);
+		spin_unlock_irqrestore(&reset->lock, flags);
+	}
+
+	return 0;
+}
+
+static int sprd_reset_deassert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct sprd_reset *reset = to_sprd_reset(rcdev);
+	const struct sprd_reset_map *map = &reset->reset_map[id];
+	unsigned int offset = map->sc_offset * 2;
+	unsigned long flags;
+	unsigned int val;
+
+	if (map->sc) {
+		regmap_write(reset->regmap, map->reg + offset, map->mask);
+	} else {
+		spin_lock_irqsave(&reset->lock, flags);
+		regmap_read(reset->regmap, map->reg, &val);
+		val &= ~map->mask;
+		regmap_write(reset->regmap, map->reg, val);
+		spin_unlock_irqrestore(&reset->lock, flags);
+	}
+
+	return 0;
+}
+
+static int sprd_reset_reset(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	sprd_reset_assert(rcdev, id);
+	udelay(1);
+	sprd_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
+const struct reset_control_ops sprd_reset_ops = {
+	.assert		= sprd_reset_assert,
+	.deassert	= sprd_reset_deassert,
+	.reset		= sprd_reset_reset,
+};
+EXPORT_SYMBOL_GPL(sprd_reset_ops);
diff --git a/drivers/clk/sprd/reset.h b/drivers/clk/sprd/reset.h
new file mode 100644
index 000000000000..155330b42775
--- /dev/null
+++ b/drivers/clk/sprd/reset.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+//
+// Spreadtrum reset clock driver
+//
+// Copyright (C) 2022 Spreadtrum, Inc.
+// Author: Zhifeng Tang <zhifeng.tang@unisoc.com>
+
+#ifndef _SPRD_RESET_H_
+#define _SPRD_RESET_H_
+
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+struct sprd_reset_map {
+	u32	reg;
+	u32	mask;
+	bool	sc;
+	u32	sc_offset;
+};
+
+struct sprd_reset {
+	struct reset_controller_dev	rcdev;
+	const struct sprd_reset_map	*reset_map;
+	struct regmap			*regmap;
+	spinlock_t			lock;
+};
+
+extern const struct reset_control_ops sprd_reset_ops;
+
+#endif /* _SPRD_RESET_H_ */
diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
index 9384ecc6c741..cebc83608f0a 100644
--- a/drivers/clk/sprd/ums512-clk.c
+++ b/drivers/clk/sprd/ums512-clk.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include <dt-bindings/clock/sprd,ums512-clk.h>
+#include <dt-bindings/reset/sprd,ums512-reset.h>
 
 #include "common.h"
 #include "composite.h"
@@ -22,6 +23,7 @@
 #include "gate.h"
 #include "mux.h"
 #include "pll.h"
+#include "reset.h"
 
 #define UMS512_MUX_FLAG	\
 	(CLK_GET_RATE_NOCACHE | CLK_SET_RATE_NO_REPARENT)
@@ -105,10 +107,42 @@ static struct clk_hw_onecell_data ums512_pmu_gate_hws = {
 	.num = CLK_PMU_GATE_NUM,
 };
 
+static struct sprd_reset_map ums512_pmu_apb_resets[] = {
+	[RESET_PMU_APB_WTLCP_SOFT_RST]			= { 0x00b0, BIT(0), true, 0x1000 },
+	[RESET_PMU_APB_PUBCP_SOFT_RST]			= { 0x00b0, BIT(1), true, 0x1000 },
+	[RESET_PMU_APB_WTLCP_DSP_SOFT_RST]		= { 0x00b0, BIT(2), true, 0x1000 },
+	[RESET_PMU_APB_MM_SOFT_RST]			= { 0x00b0, BIT(3), true, 0x1000 },
+	[RESET_PMU_APB_GPU_SOFT_RST]			= { 0x00b0, BIT(4), true, 0x1000 },
+	[RESET_PMU_APB_AP_SOFT_RST]			= { 0x00b0, BIT(5), true, 0x1000 },
+	[RESET_PMU_APB_PUB_SOFT_RST]			= { 0x00b0, BIT(6), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_SOFT_RST]			= { 0x00b0, BIT(7), true, 0x1000 },
+	[RESET_PMU_APB_SP_SYS_SOFT_RST]			= { 0x00b0, BIT(8), true, 0x1000 },
+	[RESET_PMU_APB_AUDCP_SYS_SOFT_RST]		= { 0x00b0, BIT(9), true, 0x1000 },
+	[RESET_PMU_APB_AUDCP_AUDDSP_SOFT_RST]		= { 0x00b0, BIT(10), true, 0x1000 },
+	[RESET_PMU_APB_CDMA_SOFT_RST]			= { 0x00b0, BIT(11), true, 0x1000 },
+	[RESET_PMU_APB_WTLCP_AON_SOFT_RST]		= { 0x00b0, BIT(12), true, 0x1000 },
+	[RESET_PMU_APB_WCDMA_AON_SOFT_RST]		= { 0x00b0, BIT(13), true, 0x1000 },
+	[RESET_PMU_APB_WTLCP_LDSP_SOFT_RST]		= { 0x00b0, BIT(14), true, 0x1000 },
+	[RESET_PMU_APB_WTLCP_TGDSP_SOFT_RST]		= { 0x00b0, BIT(15), true, 0x1000 },
+	[RESET_PMU_APB_AP_VSP_SOFT_RST]			= { 0x00b0, BIT(16), true, 0x1000 },
+	[RESET_PMU_APB_AP_VDSP_SOFT_RST]		= { 0x00b0, BIT(17), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE0_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(18), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE1_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(19), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE2_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(20), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE3_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(21), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE4_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(22), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE5_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(23), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE6_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(24), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CORE7_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(25), true, 0x1000 },
+	[RESET_PMU_APB_APCPU_CLUSTER_MODE_ST_SOFT_RST]	= { 0x00b0, BIT(26), true, 0x1000 },
+};
+
 static struct sprd_clk_desc ums512_pmu_gate_desc = {
 	.clk_clks	= ums512_pmu_gate_clks,
 	.num_clk_clks	= ARRAY_SIZE(ums512_pmu_gate_clks),
 	.hw_clks        = &ums512_pmu_gate_hws,
+	.resets		= ums512_pmu_apb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_pmu_apb_resets),
 };
 
 /* pll clock at g0 */
@@ -450,10 +484,30 @@ static struct clk_hw_onecell_data ums512_apahb_gate_hws = {
 	.num	= CLK_AP_AHB_GATE_NUM,
 };
 
+static struct sprd_reset_map ums512_ap_ahb_resets[] = {
+	[RESET_AP_AHB_DSI_SOFT_RST]		= { 0x0004, BIT(0), true, 0x1000 },
+	[RESET_AP_AHB_DISPC_SOFT_RST]		= { 0x0004, BIT(1), true, 0x1000 },
+	[RESET_AP_AHB_VDSP_IDMA_VAU_SOFT_RST]	= { 0x0004, BIT(2), true, 0x1000 },
+	[RESET_AP_AHB_VDSP_MSTD_VAU_SOFT_RST]	= { 0x0004, BIT(3), true, 0x1000 },
+	[RESET_AP_AHB_VDSP_MSTI_VAU_SOFT_RST]	= { 0x0004, BIT(4), true, 0x1000 },
+	[RESET_AP_AHB_VDMA_VAU_SOFT_RST]	= { 0x0004, BIT(5), true, 0x1000 },
+	[RESET_AP_AHB_IPI_SOFT_RST]		= { 0x0004, BIT(6), true, 0x1000 },
+	[RESET_AP_AHB_VDMA_SOFT_RST]		= { 0x0004, BIT(7), true, 0x1000 },
+	[RESET_AP_AHB_DMA_SOFT_RST]		= { 0x0004, BIT(8), true, 0x1000 },
+	[RESET_AP_AHB_VDSP_SOFT_RST]		= { 0x0004, BIT(9), true, 0x1000 },
+	[RESET_AP_AHB_VDSP_DEBUG_SOFT_RST]	= { 0x0004, BIT(10), true, 0x1000 },
+	[RESET_AP_AHB_VSP_GLOBAL_SOFT_RST]	= { 0x0004, BIT(11), true, 0x1000 },
+	[RESET_AP_AHB_VPP_SOFT_RST]		= { 0x0004, BIT(12), true, 0x1000 },
+	[RESET_AP_AHB_VSP_SOFT_RST]		= { 0x0004, BIT(13), true, 0x1000 },
+	[RESET_AP_AHB_DISPC_VAU_SOFT_RST]	= { 0x0004, BIT(14), true, 0x1000 },
+};
+
 static struct sprd_clk_desc ums512_apahb_gate_desc = {
 	.clk_clks	= ums512_apahb_gate,
 	.num_clk_clks	= ARRAY_SIZE(ums512_apahb_gate),
 	.hw_clks	= &ums512_apahb_gate_hws,
+	.resets		= ums512_ap_ahb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_ap_ahb_resets),
 };
 
 /* ap clks */
@@ -1542,10 +1596,82 @@ static struct clk_hw_onecell_data ums512_aon_gate_hws = {
 	.num	= CLK_AON_APB_GATE_NUM,
 };
 
+static struct sprd_reset_map ums512_aon_ahb_resets[] = {
+	[RESET_AON_APB_RC100M_CAL_SOFT_RST]		= { 0x000c, BIT(0), true, 0x1000 },
+	[RESET_AON_APB_RFTI_SOFT_RST]			= { 0x000c, BIT(1), true, 0x1000 },
+	[RESET_AON_APB_DCXO_LC_SOFT_RST]		= { 0x000c, BIT(2), true, 0x1000 },
+	[RESET_AON_APB_BB_CAL_SOFT_RST]			= { 0x000c, BIT(3), true, 0x1000 },
+	[RESET_AON_APB_MSPI0_SOFT_RST]			= { 0x000c, BIT(4), true, 0x1000 },
+	[RESET_AON_APB_MSPI1_SOFT_RST]			= { 0x000c, BIT(5), true, 0x1000 },
+	[RESET_AON_APB_DAP_MTX_SOFT_RST]		= { 0x000c, BIT(6), true, 0x1000 },
+	[RESET_AON_APB_LVDSDIS_SOFT_RST]		= { 0x000c, BIT(7), true, 0x1000 },
+	[RESET_AON_APB_SERDES_DPHY_SOFT_RST]		= { 0x000c, BIT(8), true, 0x1000 },
+	[RESET_AON_APB_SERDES_DPHY_APB_SOFT_RST]	= { 0x000c, BIT(9), true, 0x1000 },
+	[RESET_AON_APB_AP_EMMC_SOFT_RST]		= { 0x000c, BIT(10), true, 0x1000 },
+	[RESET_AON_APB_AP_SDIO0_SOFT_RST]		= { 0x000c, BIT(11), true, 0x1000 },
+	[RESET_AON_APB_AP_SDIO1_SOFT_RST]		= { 0x000c, BIT(12), true, 0x1000 },
+	[RESET_AON_APB_AP_SDIO2_SOFT_RST]		= { 0x000c, BIT(13), true, 0x1000 },
+	[RESET_AON_APB_PUBCP_SDIO0_SOFT_RST]		= { 0x000c, BIT(14), true, 0x1000 },
+	[RESET_AON_APB_EFUSE_SOFT_RST]			= { 0x0010, BIT(0), true, 0x1000 },
+	[RESET_AON_APB_GPIO_SOFT_RST]			= { 0x0010, BIT(1), true, 0x1000 },
+	[RESET_AON_APB_MBOX_SOFT_RST]			= { 0x0010, BIT(2), true, 0x1000 },
+	[RESET_AON_APB_KPD_SOFT_RST]			= { 0x0010, BIT(3), true, 0x1000 },
+	[RESET_AON_APB_AON_SYST_SOFT_RST]		= { 0x0010, BIT(4), true, 0x1000 },
+	[RESET_AON_APB_AP_SYST_SOFT_RST]		= { 0x0010, BIT(5), true, 0x1000 },
+	[RESET_AON_APB_AON_TMR_SOFT_RST]		= { 0x0010, BIT(6), true, 0x1000 },
+	[RESET_AON_APB_DVFS_TOP_SOFT_RST]		= { 0x0010, BIT(7), true, 0x1000 },
+	[RESET_AON_APB_OTG_UTMI_SOFT_RST]		= { 0x0010, BIT(8), true, 0x1000 },
+	[RESET_AON_APB_OTG_PHY_SOFT_RST]		= { 0x0010, BIT(9), true, 0x1000 },
+	[RESET_AON_APB_SPLK_SOFT_RST]			= { 0x0010, BIT(10), true, 0x1000 },
+	[RESET_AON_APB_PIN_SOFT_RST]			= { 0x0010, BIT(11), true, 0x1000 },
+	[RESET_AON_APB_ANA_SOFT_RST]			= { 0x0010, BIT(12), true, 0x1000 },
+	[RESET_AON_APB_CKG_SOFT_RST]			= { 0x0010, BIT(13), true, 0x1000 },
+	[RESET_AON_APB_ETC_SOFT_RST]			= { 0x0010, BIT(14), true, 0x1000 },
+	[RESET_AON_APB_APCPU_TS0_SOFT_RST]		= { 0x0010, BIT(17), true, 0x1000 },
+	[RESET_AON_APB_APB_BUSMON_SOFT_RST]		= { 0x0010, BIT(18), true, 0x1000 },
+	[RESET_AON_APB_AON_IIS_SOFT_RST]		= { 0x0010, BIT(19), true, 0x1000 },
+	[RESET_AON_APB_SCC_SOFT_RST]			= { 0x0010, BIT(20), true, 0x1000 },
+	[RESET_AON_APB_THM0_SOFT_RST]			= { 0x0014, BIT(0), true, 0x1000 },
+	[RESET_AON_APB_THM1_SOFT_RST]			= { 0x0014, BIT(1), true, 0x1000 },
+	[RESET_AON_APB_THM2_SOFT_RST]			= { 0x0014, BIT(2), true, 0x1000 },
+	[RESET_AON_APB_AP_SIM_AON_TOP_SOFT_RST]		= { 0x0014, BIT(3), true, 0x1000 },
+	[RESET_AON_APB_PUBCP_SIM0_AON_TOP_SOFT_RST]	= { 0x0014, BIT(4), true, 0x1000 },
+	[RESET_AON_APB_PUBCP_SIM1_AON_TOP_SOFT_RST]	= { 0x0014, BIT(5), true, 0x1000 },
+	[RESET_AON_APB_PUBCP_SIM2_AON_TOP_SOFT_RST]	= { 0x0014, BIT(6), true, 0x1000 },
+	[RESET_AON_APB_I2C_SOFT_RST]			= { 0x0014, BIT(7), true, 0x1000 },
+	[RESET_AON_APB_PMU_SOFT_RST]			= { 0x0014, BIT(8), true, 0x1000 },
+	[RESET_AON_APB_ADI_SOFT_RST]			= { 0x0014, BIT(9), true, 0x1000 },
+	[RESET_AON_APB_EIC_SOFT_RST]			= { 0x0014, BIT(10), true, 0x1000 },
+	[RESET_AON_APB_AP_INTC0_SOFT_RST]		= { 0x0014, BIT(11), true, 0x1000 },
+	[RESET_AON_APB_AP_INTC1_SOFT_RST]		= { 0x0014, BIT(12), true, 0x1000 },
+	[RESET_AON_APB_AP_INTC2_SOFT_RST]		= { 0x0014, BIT(13), true, 0x1000 },
+	[RESET_AON_APB_AP_INTC3_SOFT_RST]		= { 0x0014, BIT(14), true, 0x1000 },
+	[RESET_AON_APB_AP_INTC4_SOFT_RST]		= { 0x0014, BIT(15), true, 0x1000 },
+	[RESET_AON_APB_AP_INTC5_SOFT_RST]		= { 0x0014, BIT(16), true, 0x1000 },
+	[RESET_AON_APB_AUDCP_INTC_SOFT_RST]		= { 0x0014, BIT(17), true, 0x1000 },
+	[RESET_AON_APB_PUBCP_INTC_SOFT_RST]		= { 0x0014, BIT(18), true, 0x1000 },
+	[RESET_AON_APB_WTLCP_TGDSP_INTC_SOFT_RST]	= { 0x0014, BIT(19), true, 0x1000 },
+	[RESET_AON_APB_WTLCP_LDSP_INTC_SOFT_RST]	= { 0x0014, BIT(20), true, 0x1000 },
+	[RESET_AON_APB_WTLCP_INTC_SOFT_RST]		= { 0x0014, BIT(21), true, 0x1000 },
+	[RESET_AON_APB_AP_TMR0_SOFT_RST]		= { 0x0014, BIT(22), true, 0x1000 },
+	[RESET_AON_APB_AP_TMR1_SOFT_RST]		= { 0x0014, BIT(23), true, 0x1000 },
+	[RESET_AON_APB_AP_TMR2_SOFT_RST]		= { 0x0014, BIT(24), true, 0x1000 },
+	[RESET_AON_APB_PWM0_SOFT_RST]			= { 0x0014, BIT(25), true, 0x1000 },
+	[RESET_AON_APB_PWM1_SOFT_RST]			= { 0x0014, BIT(26), true, 0x1000 },
+	[RESET_AON_APB_PWM2_SOFT_RST]			= { 0x0014, BIT(27), true, 0x1000 },
+	[RESET_AON_APB_PWM3_SOFT_RST]			= { 0x0014, BIT(28), true, 0x1000 },
+	[RESET_AON_APB_AP_WDG_SOFT_RST]			= { 0x0014, BIT(29), true, 0x1000 },
+	[RESET_AON_APB_APCPU_WDG_SOFT_RST]		= { 0x0014, BIT(30), true, 0x1000 },
+	[RESET_AON_APB_SERDES_SOFT_RST]			= { 0x0014, BIT(31), true, 0x1000 },
+	[RESET_AON_APB_DJTAG_SOFT_RST]			= { 0x0130, BIT(10), true, 0x1000 },
+};
+
 static struct sprd_clk_desc ums512_aon_gate_desc = {
 	.clk_clks	= ums512_aon_gate,
 	.num_clk_clks	= ARRAY_SIZE(ums512_aon_gate),
 	.hw_clks	= &ums512_aon_gate_hws,
+	.resets		= ums512_aon_ahb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_aon_ahb_resets),
 };
 
 /* audcp apb gates */
@@ -1584,10 +1710,18 @@ static struct clk_hw_onecell_data ums512_audcpapb_gate_hws = {
 	.num	= CLK_AUDCP_APB_GATE_NUM,
 };
 
+static struct sprd_reset_map ums512_audcp_apb_resets[] = {
+	[RESET_AUDCP_APB_WDG_SOFT_RST]	= { 0x0004, BIT(1), true, 0x100 },
+	[RESET_AUDCP_APB_TMR0_SOFT_RST]	= { 0x0004, BIT(2), true, 0x100 },
+	[RESET_AUDCP_APB_TMR1_SOFT_RST]	= { 0x0004, BIT(3), true, 0x100 },
+};
+
 static const struct sprd_clk_desc ums512_audcpapb_gate_desc = {
 	.clk_clks	= ums512_audcpapb_gate,
 	.num_clk_clks	= ARRAY_SIZE(ums512_audcpapb_gate),
 	.hw_clks	= &ums512_audcpapb_gate_hws,
+	.resets		= ums512_audcp_apb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_audcp_apb_resets),
 };
 
 /* audcp ahb gates */
@@ -1696,10 +1830,29 @@ static struct clk_hw_onecell_data ums512_audcpahb_gate_hws = {
 	.num	= CLK_AUDCP_AHB_GATE_NUM,
 };
 
+static struct sprd_reset_map ums512_audcp_ahb_resets[] = {
+	[RESET_AUDCP_AHB_VBC_24M_SOFT_RST]	= { 0x0008, BIT(0), true, 0x100 },
+	[RESET_AUDCP_AHB_DMA_AP_SOFT_RST]	= { 0x0008, BIT(1), true, 0x100 },
+	[RESET_AUDCP_AHB_SRC48K_SOFT_RST]	= { 0x0008, BIT(5), true, 0x100 },
+	[RESET_AUDCP_AHB_MCDT_SOFT_RST]		= { 0x0008, BIT(7), true, 0x100 },
+	[RESET_AUDCP_AHB_VBCIFD_SOFT_RST]	= { 0x0008, BIT(8), true, 0x100 },
+	[RESET_AUDCP_AHB_VBC_SOFT_RST]		= { 0x0008, BIT(9), true, 0x100 },
+	[RESET_AUDCP_AHB_SPINLOCK_SOFT_RST]	= { 0x0008, BIT(10), true, 0x100 },
+	[RESET_AUDCP_AHB_DMA_CP_SOFT_RST]	= { 0x0008, BIT(11), true, 0x100 },
+	[RESET_AUDCP_AHB_IIS0_SOFT_RST]		= { 0x0008, BIT(12), true, 0x100 },
+	[RESET_AUDCP_AHB_IIS1_SOFT_RST]		= { 0x0008, BIT(13), true, 0x100 },
+	[RESET_AUDCP_AHB_IIS2_SOFT_RST]		= { 0x0008, BIT(14), true, 0x100 },
+	[RESET_AUDCP_AHB_UART_SOFT_RST]		= { 0x0008, BIT(16), true, 0x100 },
+	[RESET_AUDCP_AHB_AUD_SOFT_RST]		= { 0x0008, BIT(25), true, 0x100 },
+	[RESET_AUDCP_AHB_DVFS_SOFT_RST]		= { 0x0008, BIT(26), true, 0x100 },
+};
+
 static const struct sprd_clk_desc ums512_audcpahb_gate_desc = {
 	.clk_clks	= ums512_audcpahb_gate,
 	.num_clk_clks	= ARRAY_SIZE(ums512_audcpahb_gate),
 	.hw_clks	= &ums512_audcpahb_gate_hws,
+	.resets		= ums512_audcp_ahb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_audcp_ahb_resets),
 };
 
 /* gpu clocks */
@@ -1752,10 +1905,17 @@ static struct clk_hw_onecell_data ums512_gpu_clk_hws = {
 	.num	= CLK_GPU_CLK_NUM,
 };
 
+static struct sprd_reset_map ums512_gpu_apb_resets[] = {
+	[RESET_GPU_APB_GPU_CORE_SOFT_RST]	= { 0x0000, BIT(0), true, 0x1000 },
+	[RESET_GPU_APB_SYS_SOFT_RST_REQ_CORE]	= { 0x0000, BIT(1), true, 0x1000 },
+};
+
 static struct sprd_clk_desc ums512_gpu_clk_desc = {
 	.clk_clks	= ums512_gpu_clk,
 	.num_clk_clks	= ARRAY_SIZE(ums512_gpu_clk),
 	.hw_clks	= &ums512_gpu_clk_hws,
+	.resets		= ums512_gpu_apb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_gpu_apb_resets),
 };
 
 /* mm clocks */
@@ -1994,10 +2154,42 @@ static struct clk_hw_onecell_data ums512_mm_gate_clk_hws = {
 	.num	= CLK_MM_GATE_CLK_NUM,
 };
 
+static struct sprd_reset_map ums512_mm_ahb_resets[] = {
+	[RESET_MM_AHB_CKG_SOFT_RST]		= { 0x0004, BIT(0), true, 0x1000 },
+	[RESET_MM_AHB_JPG_SOFT_RST]		= { 0x0004, BIT(1), true, 0x1000 },
+	[RESET_MM_AHB_DCAM_AXI_SOFT_RST]	= { 0x0004, BIT(2), true, 0x1000 },
+	[RESET_MM_AHB_DCAM2_SOFT_RST]		= { 0x0004, BIT(3), true, 0x1000 },
+	[RESET_MM_AHB_DCAM1_SOFT_RST]		= { 0x0004, BIT(4), true, 0x1000 },
+	[RESET_MM_AHB_DCAM0_SOFT_RST]		= { 0x0004, BIT(5), true, 0x1000 },
+	[RESET_MM_AHB_DCAM_VAU_SOFT_RST]	= { 0x0004, BIT(6), true, 0x1000 },
+	[RESET_MM_AHB_MIPI_CSI2_SOFT_RST]	= { 0x0004, BIT(7), true, 0x1000 },
+	[RESET_MM_AHB_MIPI_CSI1_SOFT_RST]	= { 0x0004, BIT(8), true, 0x1000 },
+	[RESET_MM_AHB_MIPI_CSI0_SOFT_RST]	= { 0x0004, BIT(9), true, 0x1000 },
+	[RESET_MM_AHB_ISP_SOFT_RST]		= { 0x0004, BIT(10), true, 0x1000 },
+	[RESET_MM_AHB_ISP_VAU_SOFT_RST]		= { 0x0004, BIT(11), true, 0x1000 },
+	[RESET_MM_AHB_ISP_AHB_SOFT_RST]		= { 0x0004, BIT(12), true, 0x1000 },
+	[RESET_MM_AHB_CPP_DMA_SOFT_RST]		= { 0x0004, BIT(13), true, 0x1000 },
+	[RESET_MM_AHB_CPP_PATH1_SOFT_RST]	= { 0x0004, BIT(14), true, 0x1000 },
+	[RESET_MM_AHB_CPP_PATH0_SOFT_RST]	= { 0x0004, BIT(15), true, 0x1000 },
+	[RESET_MM_AHB_CPP_SOFT_RST]		= { 0x0004, BIT(16), true, 0x1000 },
+	[RESET_MM_AHB_MM_MAIN_SOFT_RST]		= { 0x0004, BIT(17), true, 0x1000 },
+	[RESET_MM_AHB_CPP_SOFT_RST_MASK]	= { 0x0004, BIT(18), true, 0x1000 },
+	[RESET_MM_AHB_JPG_SOFT_RST_MASK]	= { 0x0004, BIT(19), true, 0x1000 },
+	[RESET_MM_AHB_JPG_VAU_SOFT_RST]		= { 0x0004, BIT(20), true, 0x1000 },
+	[RESET_MM_AHB_CPP_VAU_SOFT_RST]		= { 0x0004, BIT(21), true, 0x1000 },
+	[RESET_MM_AHB_FD_VAU_SOFT_RST]		= { 0x0004, BIT(22), true, 0x1000 },
+	[RESET_MM_AHB_DCAM_ALL_SOFT_RST]	= { 0x0004, BIT(23), true, 0x1000 },
+	[RESET_MM_AHB_DVFS_SOFT_RST]		= { 0x0004, BIT(24), true, 0x1000 },
+	[RESET_MM_AHB_FD_SOFT_RST]		= { 0x0004, BIT(26), true, 0x1000 },
+	[RESET_MM_AHB_FD_SOFT_RST_MASK]		= { 0x0004, BIT(27), true, 0x1000 },
+};
+
 static struct sprd_clk_desc ums512_mm_gate_clk_desc = {
 	.clk_clks	= ums512_mm_gate_clk,
 	.num_clk_clks	= ARRAY_SIZE(ums512_mm_gate_clk),
 	.hw_clks	= &ums512_mm_gate_clk_hws,
+	.resets		= ums512_mm_ahb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_mm_ahb_resets),
 };
 
 /* ap apb gates */
@@ -2132,10 +2324,38 @@ static struct clk_hw_onecell_data ums512_apapb_gate_hws = {
 	.num	= CLK_AP_APB_GATE_NUM,
 };
 
+static struct sprd_reset_map ums512_ap_apb_resets[] = {
+	[RESET_AP_APB_SIM0_SOFT_RST]		= { 0x0004, BIT(0), true, 0x1000 },
+	[RESET_AP_APB_IIS0_SOFT_RST]		= { 0x0004, BIT(1), true, 0x1000 },
+	[RESET_AP_APB_IIS1_SOFT_RST]		= { 0x0004, BIT(2), true, 0x1000 },
+	[RESET_AP_APB_IIS2_SOFT_RST]		= { 0x0004, BIT(3), true, 0x1000 },
+	[RESET_AP_APB_SPI0_SOFT_RST]		= { 0x0004, BIT(4), true, 0x1000 },
+	[RESET_AP_APB_SPI1_SOFT_RST]		= { 0x0004, BIT(5), true, 0x1000 },
+	[RESET_AP_APB_SPI2_SOFT_RST]		= { 0x0004, BIT(6), true, 0x1000 },
+	[RESET_AP_APB_SPI3_SOFT_RST]		= { 0x0004, BIT(7), true, 0x1000 },
+	[RESET_AP_APB_I2C0_SOFT_RST]		= { 0x0004, BIT(8), true, 0x1000 },
+	[RESET_AP_APB_I2C1_SOFT_RST]		= { 0x0004, BIT(9), true, 0x1000 },
+	[RESET_AP_APB_I2C2_SOFT_RST]		= { 0x0004, BIT(10), true, 0x1000 },
+	[RESET_AP_APB_I2C3_SOFT_RST]		= { 0x0004, BIT(11), true, 0x1000 },
+	[RESET_AP_APB_I2C4_SOFT_RST]		= { 0x0004, BIT(12), true, 0x1000 },
+	[RESET_AP_APB_UART0_SOFT_RST]		= { 0x0004, BIT(13), true, 0x1000 },
+	[RESET_AP_APB_UART1_SOFT_RST]		= { 0x0004, BIT(14), true, 0x1000 },
+	[RESET_AP_APB_UART2_SOFT_RST]		= { 0x0004, BIT(15), true, 0x1000 },
+	[RESET_AP_APB_SDIO0_SOFT_RST]		= { 0x0004, BIT(16), true, 0x1000 },
+	[RESET_AP_APB_SDIO1_SOFT_RST]		= { 0x0004, BIT(17), true, 0x1000 },
+	[RESET_AP_APB_SDIO2_SOFT_RST]		= { 0x0004, BIT(18), true, 0x1000 },
+	[RESET_AP_APB_EMMC_SOFT_RST]		= { 0x0004, BIT(19), true, 0x1000 },
+	[RESET_AP_APB_CE_SEC_SOFT_RST]		= { 0x0004, BIT(20), true, 0x1000 },
+	[RESET_AP_APB_CE_PUB_SOFT_RST]		= { 0x0004, BIT(21), true, 0x1000 },
+	[RESET_AP_APB_AP_DVFS_SOFT_RST]		= { 0x0004, BIT(22), true, 0x1000 },
+};
+
 static struct sprd_clk_desc ums512_apapb_gate_desc = {
 	.clk_clks	= ums512_apapb_gate,
 	.num_clk_clks	= ARRAY_SIZE(ums512_apapb_gate),
 	.hw_clks	= &ums512_apapb_gate_hws,
+	.resets		= ums512_ap_apb_resets,
+	.num_resets	= ARRAY_SIZE(ums512_ap_apb_resets),
 };
 
 static const struct of_device_id sprd_ums512_clk_ids[] = {
@@ -2176,6 +2396,7 @@ MODULE_DEVICE_TABLE(of, sprd_ums512_clk_ids);
 static int ums512_clk_probe(struct platform_device *pdev)
 {
 	const struct sprd_clk_desc *desc;
+	struct sprd_reset *reset;
 	int ret;
 
 	desc = device_get_match_data(&pdev->dev);
@@ -2186,6 +2407,25 @@ static int ums512_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (desc->num_resets > 0) {
+		reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+		if (!reset)
+			return -ENOMEM;
+
+		spin_lock_init(&reset->lock);
+		reset->rcdev.of_node = pdev->dev.of_node;
+		reset->rcdev.ops = &sprd_reset_ops;
+		reset->rcdev.nr_resets = desc->num_resets;
+		reset->reset_map = desc->resets;
+		reset->regmap = platform_get_drvdata(pdev);
+
+		ret = devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register reset controller\n");
+			return ret;
+		}
+	}
+
 	return sprd_clk_probe(&pdev->dev, desc->hw_clks);
 }
 
-- 
2.17.1


