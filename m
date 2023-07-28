Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133AA7661A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjG1CIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjG1CIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:08:18 -0400
Received: from mail-m12739.qiye.163.com (mail-m12739.qiye.163.com [115.236.127.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DFB1FFF;
        Thu, 27 Jul 2023 19:08:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m12739.qiye.163.com (Hmail) with ESMTPA id 70C244A0145;
        Fri, 28 Jul 2023 10:08:13 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
Subject: [PATCH v2 1/3] clk: rockchip: add support for gate link
Date:   Fri, 28 Jul 2023 10:08:08 +0800
Message-Id: <20230728020810.29732-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230728020810.29732-1-zhangqing@rock-chips.com>
References: <20230728020810.29732-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMZH1YYHh9CSksdSk1DTh1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a899a40ed34b212kuuu70c244a0145
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgw6NSo5GT0BLDgPSjIXCU4R
        AQgaCxFVSlVKTUJLTkpLS0JPSE1NVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUJPQ0s3Bg++
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/clk/rockchip/clk-gate-link.c | 189 +++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c           |   7 +
 drivers/clk/rockchip/clk.h           |  22 ++++
 4 files changed, 219 insertions(+)
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
index 000000000000..06d25f00ec0c
--- /dev/null
+++ b/drivers/clk/rockchip/clk-gate-link.c
@@ -0,0 +1,189 @@
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
+ * @hw:		handle between common and hardware-specific interfaces
+ * @reg:	register controlling gate
+ * @bit_idx:	single bit controlling gate
+ * @flags:	hardware-specific flags
+ * @lock:	register lock
+ * @link:	links clk
+ */
+struct clk_gate_link {
+	struct clk_hw hw;
+	void __iomem	*reg;
+	u8		bit_idx;
+	u8		flags;
+	spinlock_t	*lock;
+	struct clk	*link;
+};
+
+#define to_clk_gate_link(_hw) container_of(_hw, struct clk_gate_link, hw)
+
+static inline u32 clk_gate_readl(struct clk_gate_link *gate)
+{
+	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+		return ioread32be(gate->reg);
+
+	return readl(gate->reg);
+}
+
+static inline void clk_gate_writel(struct clk_gate_link *gate, u32 val)
+{
+	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+		iowrite32be(val, gate->reg);
+	else
+		writel(val, gate->reg);
+}
+
+/*
+ * It works on following logic:
+ *
+ * For enabling clock, enable = 1
+ *	set2dis = 1	-> clear bit	-> set = 0
+ *	set2dis = 0	-> set bit	-> set = 1
+ *
+ * For disabling clock, enable = 0
+ *	set2dis = 1	-> set bit	-> set = 1
+ *	set2dis = 0	-> clear bit	-> set = 0
+ *
+ * So, result is always: enable xor set2dis.
+ */
+static void clk_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_gate_link *gate = to_clk_gate_link(hw);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	unsigned long flags;
+	u32 reg;
+
+	set ^= enable;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+	else
+		__acquire(gate->lock);
+
+	if (gate->flags & CLK_GATE_HIWORD_MASK) {
+		reg = BIT(gate->bit_idx + 16);
+		if (set)
+			reg |= BIT(gate->bit_idx);
+	} else {
+		reg = clk_gate_readl(gate);
+
+		if (set)
+			reg |= BIT(gate->bit_idx);
+		else
+			reg &= ~BIT(gate->bit_idx);
+	}
+
+	clk_gate_writel(gate, reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+	else
+		__release(gate->lock);
+}
+
+static int clk_gate_link_enable(struct clk_hw *hw)
+{
+	struct clk_gate_link *gate = to_clk_gate_link(hw);
+
+	clk_gate_endisable(hw, 1);
+	clk_enable(gate->link);
+
+	return 0;
+}
+
+static void clk_gate_link_disable(struct clk_hw *hw)
+{
+	struct clk_gate_link *gate = to_clk_gate_link(hw);
+
+	clk_gate_endisable(hw, 0);
+	clk_disable(gate->link);
+}
+
+static int clk_gate_link_is_enabled(struct clk_hw *hw)
+{
+	u32 reg;
+	struct clk_gate_link *gate = to_clk_gate_link(hw);
+
+	reg = clk_gate_readl(gate);
+
+	/* if a set bit disables this clk, flip it before masking */
+	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= BIT(gate->bit_idx);
+
+	reg &= BIT(gate->bit_idx);
+
+	return reg ? 1 : 0;
+}
+
+const struct clk_ops clk_gate_link_ops = {
+	.enable = clk_gate_link_enable,
+	.disable = clk_gate_link_disable,
+	.is_enabled = clk_gate_link_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_gate_link_ops);
+
+struct clk *rockchip_clk_register_gate_link(struct rockchip_clk_provider *ctx,
+					    const char *name, const char *parent_name,
+					    unsigned int link_id, u8 flags,
+					    void __iomem *gate_offset, u8 gate_shift,
+					    u8 gate_flags, spinlock_t *lock)
+{
+	struct clk_gate_link *gate;
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
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	clks = ctx->clk_data.clks;
+	gate->link = clks[link_id];
+
+	init.name = name;
+	init.ops = &clk_gate_link_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = 1;
+
+	/* struct clk_gate assignments */
+	gate->reg = gate_offset;
+	gate->bit_idx = gate_shift;
+	gate->flags = gate_flags;
+	gate->lock = lock;
+	gate->hw.init = &init;
+
+	clk_link = clk_register(NULL, &gate->hw);
+	if (IS_ERR(clk_link)) {
+		kfree(gate);
+		pr_err("%s clk_register field\n", name);
+		return ERR_CAST(clk_link);
+	}
+	clk_prepare(gate->link);
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

