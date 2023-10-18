Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7B7CD4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjJRHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjJRHCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:02:37 -0400
Received: from mail-m12777.qiye.163.com (mail-m12777.qiye.163.com [115.236.127.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2322EA;
        Wed, 18 Oct 2023 00:02:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=FFn//DdqXY6SCt3H7lpmdNqDA94VR6B1sOx+d5ZlzptwarV3XyY5JF+SI7vdRduIVy5m0xiuNlH6lPWGqBnIykJ6HP6DwH0c1dF7m6NGTut8GvBo7pdDtkzuqlkGkFCrvwnjrkTXEzZo4DOBHftrPWtokUDch1Q7z6lLzU5Zd6o=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=BMhNAqzbDmq8eNBUY2e5UgeE+146u/GGAugoGpYPgqc=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 80BF64002B7;
        Wed, 18 Oct 2023 15:01:52 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
Subject: [PATCH v4 2/4] clk: rockchip: add support for gate link
Date:   Wed, 18 Oct 2023 15:01:42 +0800
Message-Id: <20231018070144.8512-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018070144.8512-1-zhangqing@rock-chips.com>
References: <20231018070144.8512-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxJS1ZPSxhCT0lNShodGR1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8b41973e5e2eb3kusn80bf64002b7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46FRw4ATwyTUsrCCoTGkoW
        SQgwCjZVSlVKTUJMTUpJTkpIT01JVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNIQ0o3Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Rockchip SoCs have a new hardware block called Native Interface
Unit (NIU), which gates clocks to devices behind them. These effectively
need two parent clocks.
Use GATE_LINK to handle this.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/Makefile        |   1 +
 drivers/clk/rockchip/clk-gate-link.c | 120 +++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c           |   7 ++
 drivers/clk/rockchip/clk.h           |  22 +++++
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-gate-link.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 36894f6a7022..87cc39d54f72 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -13,6 +13,7 @@ clk-rockchip-y += clk-inverter.o
 clk-rockchip-y += clk-mmc-phase.o
 clk-rockchip-y += clk-muxgrf.o
 clk-rockchip-y += clk-ddr.o
+clk-rockchip-y += clk-gate-link.o
 clk-rockchip-$(CONFIG_RESET_CONTROLLER) += softrst.o
 
 obj-$(CONFIG_CLK_PX30)          += clk-px30.o
diff --git a/drivers/clk/rockchip/clk-gate-link.c b/drivers/clk/rockchip/clk-gate-link.c
new file mode 100644
index 000000000000..d4bbef4a067b
--- /dev/null
+++ b/drivers/clk/rockchip/clk-gate-link.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Fuzhou Rockchip Electronics Co., Ltd
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include "clk.h"
+
+/**
+ * struct clk_gate_link - gating link clock
+ *
+ * @gate: handle clk gate
+ * @link: links clk
+ */
+struct clk_gate_link {
+	struct clk_gate gate;
+	struct clk	*link;
+};
+
+#define to_clk_gate_link(_gate) container_of(_gate, struct clk_gate_link, gate)
+
+static int clk_gate_link_enable(struct clk_hw *hw)
+{
+	struct clk_gate_link *gate = to_clk_gate_link(to_clk_gate(hw));
+
+	clk_gate_endisable(hw, 1);
+	clk_enable(gate->link);
+
+	return 0;
+}
+
+static void clk_gate_link_disable(struct clk_hw *hw)
+{
+	struct clk_gate_link *gate = to_clk_gate_link(to_clk_gate(hw));
+
+	clk_gate_endisable(hw, 0);
+	clk_disable(gate->link);
+}
+
+static int clk_gate_link_is_enabled(struct clk_hw *hw)
+{
+	return clk_gate_is_enabled(hw);
+}
+
+static int clk_gate_link_prepare(struct clk_hw *hw)
+{
+	struct clk_gate_link *gate = to_clk_gate_link(to_clk_gate(hw));
+
+	return clk_prepare(gate->link);
+}
+
+static void clk_gate_link_unprepare(struct clk_hw *hw)
+{
+	struct clk_gate_link *gate = to_clk_gate_link(to_clk_gate(hw));
+
+	clk_unprepare(gate->link);
+}
+
+const struct clk_ops clk_gate_link_ops = {
+	.prepare = clk_gate_link_prepare,
+	.unprepare = clk_gate_link_unprepare,
+	.enable = clk_gate_link_enable,
+	.disable = clk_gate_link_disable,
+	.is_enabled = clk_gate_link_is_enabled,
+};
+
+struct clk *rockchip_clk_register_gate_link(struct rockchip_clk_provider *ctx,
+					    const char *name, const char *parent_name,
+					    unsigned int link_id, u8 flags,
+					    void __iomem *gate_offset, u8 gate_shift,
+					    u8 gate_flags, spinlock_t *lock)
+{
+	struct clk_gate_link *gate_link;
+	struct clk_init_data init = {};
+	struct clk **clks;
+	struct clk *clk_link;
+
+	if (gate_flags & CLK_GATE_HIWORD_MASK) {
+		if (gate_shift > 15) {
+			pr_err("gate bit exceeds LOWORD field\n");
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	/* allocate the gate */
+	gate_link = kzalloc(sizeof(*gate_link), GFP_KERNEL);
+	if (!gate_link)
+		return ERR_PTR(-ENOMEM);
+
+	clks = ctx->clk_data.clks;
+	gate_link->link = clks[link_id];
+
+	init.name = name;
+	init.ops = &clk_gate_link_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = 1;
+
+	/* struct clk_gate assignments */
+	gate_link->gate.reg = gate_offset;
+	gate_link->gate.bit_idx = gate_shift;
+	gate_link->gate.flags = gate_flags;
+	gate_link->gate.lock = lock;
+	gate_link->gate.hw.init = &init;
+
+	clk_link = clk_register(NULL, &gate_link->gate.hw);
+	if (IS_ERR(clk_link)) {
+		kfree(gate_link);
+		pr_err("%s clk_register field\n", name);
+		return ERR_CAST(clk_link);
+	}
+
+	return clk_link;
+}
+EXPORT_SYMBOL_GPL(rockchip_clk_register_gate_link);
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 4059d9365ae6..d981ef6c5487 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -509,6 +509,13 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 				ctx->reg_base + list->gate_offset,
 				list->gate_shift, list->gate_flags, &ctx->lock);
 			break;
+
+		case branch_gate_link:
+			clk = rockchip_clk_register_gate_link(ctx, list->name,
+				list->parent_names[0], list->link_id, flags,
+				ctx->reg_base + list->gate_offset,
+				list->gate_shift, list->gate_flags, &ctx->lock);
+			break;
 		case branch_composite:
 			clk = rockchip_clk_register_branch(list->name,
 				list->parent_names, list->num_parents,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 758ebaf2236b..b49e3cede33a 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -517,6 +517,7 @@ enum rockchip_clk_branch_type {
 	branch_divider,
 	branch_fraction_divider,
 	branch_gate,
+	branch_gate_link,
 	branch_mmc,
 	branch_inverter,
 	branch_factor,
@@ -529,6 +530,7 @@ struct rockchip_clk_branch {
 	enum rockchip_clk_branch_type	branch_type;
 	const char			*name;
 	const char			*const *parent_names;
+	unsigned int			link_id;
 	u8				num_parents;
 	unsigned long			flags;
 	int				muxdiv_offset;
@@ -842,6 +844,20 @@ struct rockchip_clk_branch {
 		.gate_flags	= gf,				\
 	}
 
+#define GATE_LINK(_id, cname, pname, _linkid, f, o, b, gf) \
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_gate_link,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.link_id	= _linkid,			\
+		.flags		= f,				\
+		.gate_offset	= o,				\
+		.gate_shift	= b,				\
+		.gate_flags	= gf,				\
+	}
+
 #define MMC(_id, cname, pname, offset, shift)			\
 	{							\
 		.id		= _id,				\
@@ -1002,6 +1018,12 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
 					  unsigned long flags,
 					  spinlock_t *lock);
 
+struct clk *rockchip_clk_register_gate_link(struct rockchip_clk_provider *ctx,
+					    const char *name, const char *parent_name,
+					    unsigned int link_id, u8 flags,
+					    void __iomem *gate_offset, u8 gate_shift,
+					    u8 gate_flags, spinlock_t *lock);
+
 #ifdef CONFIG_RESET_CONTROLLER
 void rockchip_register_softrst_lut(struct device_node *np,
 				   const int *lookup_table,
-- 
2.17.1

