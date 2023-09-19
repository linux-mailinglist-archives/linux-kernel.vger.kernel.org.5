Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48997A572E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjISCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISCAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:00:02 -0400
Received: from mail-m12787.qiye.163.com (mail-m12787.qiye.163.com [115.236.127.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4ED94;
        Mon, 18 Sep 2023 18:59:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=Q/KKJ1MZ8n+mkbzTNHrb59mhwrOpvs5C23aw/4IAGeN/hRMSCeyAXR9UTlyXukheryFUnXBJq0f7m+OYNbnUNJSxFPcP2emRN9BVVv/bgr18P3SvSrMXnIJ1gm1Ct07vp7qhd7GIB3xpdBtVFoU0pHtwi8wKhne7PSB4j3oweUM=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=QkDfZL01O7H0QQfrhzzW/ax3H2aJpjVAmeoQaPkQMFw=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id AA3F96802FA;
        Tue, 19 Sep 2023 09:59:15 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [RESEND PATCH v1 4/8] clk: rockchip: Avoid __clk_lookup() calls
Date:   Tue, 19 Sep 2023 09:59:12 +0800
Message-Id: <20230919015912.15262-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhKGFYfGkpDSkhOGU1DGUhVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aab29c5732eb5kusnaa3f96802fa
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Chw6IT1OQkgRPSk5TQlP
        PTMKChlVSlVKTUJOS0NDTE5NQkxKVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhIS0hPNwY+
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change:
Fix up the build warnings.

can be used later instead of a __clk_lookup() call.

clk provider clk_data.clks[] and we can reference
the clk pointers directly rather than using __clk_lookup()
with global names.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-cpu.c    | 18 +++++++++++++-----
 drivers/clk/rockchip/clk-px30.c   | 17 +++++++++++------
 drivers/clk/rockchip/clk-rk3036.c |  5 +++--
 drivers/clk/rockchip/clk-rk3128.c |  5 +++--
 drivers/clk/rockchip/clk-rk3188.c | 22 +++++++++++-----------
 drivers/clk/rockchip/clk-rk3228.c |  5 +++--
 drivers/clk/rockchip/clk-rk3288.c |  5 +++--
 drivers/clk/rockchip/clk-rk3308.c |  5 +++--
 drivers/clk/rockchip/clk-rk3328.c |  8 +++-----
 drivers/clk/rockchip/clk-rk3368.c |  8 ++++----
 drivers/clk/rockchip/clk-rk3399.c | 14 ++++----------
 drivers/clk/rockchip/clk-rk3568.c |  5 +++--
 drivers/clk/rockchip/clk-rk3588.c | 11 +++++------
 drivers/clk/rockchip/clk-rv1108.c |  5 +++--
 drivers/clk/rockchip/clk-rv1126.c |  9 +++++++--
 drivers/clk/rockchip/clk.c        |  6 ++++--
 drivers/clk/rockchip/clk.h        | 17 ++++++++++-------
 17 files changed, 93 insertions(+), 72 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 6ea7fba9f9e5..9429d4f1fe41 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -298,7 +298,8 @@ static int rockchip_cpuclk_notifier_cb(struct notifier_block *nb,
 }
 
 struct clk *rockchip_clk_register_cpuclk(const char *name,
-			const char *const *parent_names, u8 num_parents,
+			u8 num_parents,
+			struct clk *parent, struct clk *alt_parent,
 			const struct rockchip_cpuclk_reg_data *reg_data,
 			const struct rockchip_cpuclk_rate_table *rates,
 			int nrates, void __iomem *reg_base, spinlock_t *lock)
@@ -306,6 +307,7 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 	struct rockchip_cpuclk *cpuclk;
 	struct clk_init_data init;
 	struct clk *clk, *cclk;
+	const char *parent_name;
 	int ret;
 
 	if (num_parents < 2) {
@@ -313,12 +315,18 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (IS_ERR(parent) || IS_ERR(alt_parent)) {
+		pr_err("%s: invalid parent clock(s)\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
 	cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
 	if (!cpuclk)
 		return ERR_PTR(-ENOMEM);
 
+	parent_name = clk_hw_get_name(__clk_get_hw(parent));
 	init.name = name;
-	init.parent_names = &parent_names[reg_data->mux_core_main];
+	init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.ops = &rockchip_cpuclk_ops;
 
@@ -336,7 +344,7 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 	cpuclk->clk_nb.notifier_call = rockchip_cpuclk_notifier_cb;
 	cpuclk->hw.init = &init;
 
-	cpuclk->alt_parent = __clk_lookup(parent_names[reg_data->mux_core_alt]);
+	cpuclk->alt_parent = alt_parent;
 	if (!cpuclk->alt_parent) {
 		pr_err("%s: could not lookup alternate parent: (%d)\n",
 		       __func__, reg_data->mux_core_alt);
@@ -351,11 +359,11 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 		goto free_cpuclk;
 	}
 
-	clk = __clk_lookup(parent_names[reg_data->mux_core_main]);
+	clk = parent;
 	if (!clk) {
 		pr_err("%s: could not lookup parent clock: (%d) %s\n",
 		       __func__, reg_data->mux_core_main,
-		       parent_names[reg_data->mux_core_main]);
+		       parent_name);
 		ret = -EINVAL;
 		goto free_alt_parent;
 	}
diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index 02fdb6273f4a..011b8bd89253 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -136,7 +136,6 @@ static const struct rockchip_cpuclk_reg_data px30_cpuclk_data = {
 
 PNAME(mux_pll_p)		= { "xin24m"};
 PNAME(mux_usb480m_p)		= { "xin24m", "usb480m_phy", "clk_rtc32k_pmu" };
-PNAME(mux_armclk_p)		= { "apll_core", "gpll_core" };
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr" };
 PNAME(mux_ddrstdby_p)		= { "clk_ddrphy1x", "clk_stdby_2wrap" };
 PNAME(mux_4plls_p)		= { "gpll", "dummy_cpll", "usb480m", "npll" };
@@ -979,6 +978,7 @@ static struct rockchip_clk_branch px30_clk_pmu_branches[] __initdata = {
 	GATE(0, "pclk_cru_pmu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, PX30_PMU_CLKGATE_CON(0), 8, GFLAGS),
 };
 
+static struct rockchip_clk_provider *cru_ctx;
 static void __init px30_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -1003,17 +1003,14 @@ static void __init px30_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, px30_clk_branches,
 				       ARRAY_SIZE(px30_clk_branches));
 
-	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
-				     &px30_cpuclk_data, px30_cpuclk_rates,
-				     ARRAY_SIZE(px30_cpuclk_rates));
-
 	rockchip_register_softrst(np, 12, reg_base + PX30_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
 	rockchip_register_restart_notifier(ctx, PX30_GLB_SRST_FST, NULL);
 
 	rockchip_clk_of_add_provider(np, ctx);
+
+	cru_ctx = ctx;
 }
 CLK_OF_DECLARE(px30_cru, "rockchip,px30-cru", px30_clk_init);
 
@@ -1021,6 +1018,7 @@ static void __init px30_pmu_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **pmucru_clks, **cru_clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -1033,10 +1031,17 @@ static void __init px30_pmu_clk_init(struct device_node *np)
 		pr_err("%s: rockchip pmu clk init failed\n", __func__);
 		return;
 	}
+	pmucru_clks = ctx->clk_data.clks;
+	cru_clks = cru_ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, px30_pmu_pll_clks,
 				   ARRAY_SIZE(px30_pmu_pll_clks), PX30_GRF_SOC_STATUS0);
 
+	rockchip_clk_register_armclk(cru_ctx, ARMCLK, "armclk",
+				     2, cru_clks[PLL_APLL], pmucru_clks[PLL_GPLL],
+				     &px30_cpuclk_data, px30_cpuclk_rates,
+				     ARRAY_SIZE(px30_cpuclk_rates));
+
 	rockchip_clk_register_branches(ctx, px30_clk_pmu_branches,
 				       ARRAY_SIZE(px30_clk_pmu_branches));
 
diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 7cba188d9b01..a0089c89f143 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -114,7 +114,6 @@ static const struct rockchip_cpuclk_reg_data rk3036_cpuclk_data = {
 
 PNAME(mux_pll_p)		= { "xin24m", "xin24m" };
 
-PNAME(mux_armclk_p)		= { "apll", "gpll_armclk" };
 PNAME(mux_busclk_p)		= { "apll", "dpll_cpu", "gpll_cpu" };
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr" };
 PNAME(mux_pll_src_3plls_p)	= { "apll", "dpll", "gpll" };
@@ -431,6 +430,7 @@ static void __init rk3036_clk_init(struct device_node *np)
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
 	struct clk *clk;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -451,6 +451,7 @@ static void __init rk3036_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	clk = clk_register_fixed_factor(NULL, "usb480m", "xin24m", 0, 20, 1);
 	if (IS_ERR(clk))
@@ -464,7 +465,7 @@ static void __init rk3036_clk_init(struct device_node *np)
 				  ARRAY_SIZE(rk3036_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			2, clks[PLL_APLL], clks[PLL_GPLL],
 			&rk3036_cpuclk_data, rk3036_cpuclk_rates,
 			ARRAY_SIZE(rk3036_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 09931fc7dadc..f9c78b26f973 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -130,7 +130,6 @@ static const struct rockchip_cpuclk_reg_data rk3128_cpuclk_data = {
 PNAME(mux_pll_p)		= { "clk_24m", "xin24m" };
 
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_div2_ddr" };
-PNAME(mux_armclk_p)		= { "apll_core", "gpll_div2_core" };
 PNAME(mux_usb480m_p)		= { "usb480m_phy", "xin24m" };
 PNAME(mux_aclk_cpu_src_p)	= { "cpll", "gpll", "gpll_div2", "gpll_div3" };
 
@@ -566,6 +565,7 @@ static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -579,6 +579,7 @@ static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device
 		iounmap(reg_base);
 		return ERR_PTR(-ENOMEM);
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3128_pll_clks,
 				   ARRAY_SIZE(rk3128_pll_clks),
@@ -587,7 +588,7 @@ static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device
 				  ARRAY_SIZE(common_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			2, clks[PLL_APLL], clks[PLL_GPLL_DIV2],
 			&rk3128_cpuclk_data, rk3128_cpuclk_rates,
 			ARRAY_SIZE(rk3128_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 455245815a11..d905299e5f4b 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -196,7 +196,6 @@ static const struct rockchip_cpuclk_reg_data rk3188_cpuclk_data = {
 };
 
 PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
-PNAME(mux_armclk_p)		= { "apll", "gpll_armclk" };
 PNAME(mux_ddrphy_p)		= { "dpll", "gpll_ddr" };
 PNAME(mux_pll_src_gpll_cpll_p)	= { "gpll", "cpll" };
 PNAME(mux_pll_src_cpll_gpll_p)	= { "cpll", "gpll" };
@@ -678,7 +677,7 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 			div_rk3188_aclk_core_t, RK2928_CLKGATE_CON(0), 7, GFLAGS),
 
 	/* do not source aclk_cpu_pre from the apll, to keep complexity down */
-	COMPOSITE_NOGATE(0, "aclk_cpu_pre", mux_aclk_cpu_p, CLK_SET_RATE_NO_REPARENT,
+	COMPOSITE_NOGATE(ACLK_CPU_PRE, "aclk_cpu_pre", mux_aclk_cpu_p, CLK_SET_RATE_NO_REPARENT,
 			RK2928_CLKSEL_CON(0), 5, 1, MFLAGS, 0, 5, DFLAGS),
 	DIV(0, "pclk_cpu_pre", "aclk_cpu_pre", 0,
 			RK2928_CLKSEL_CON(1), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
@@ -778,10 +777,12 @@ static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device
 static void __init rk3066a_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	struct clk **clks;
 
 	ctx = rk3188_common_clk_init(np);
 	if (IS_ERR(ctx))
 		return;
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3066_pll_clks,
 				   ARRAY_SIZE(rk3066_pll_clks),
@@ -789,7 +790,7 @@ static void __init rk3066a_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, rk3066a_clk_branches,
 				  ARRAY_SIZE(rk3066a_clk_branches));
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			2, clks[PLL_APLL], clks[PLL_GPLL],
 			&rk3066_cpuclk_data, rk3066_cpuclk_rates,
 			ARRAY_SIZE(rk3066_cpuclk_rates));
 	rockchip_clk_of_add_provider(np, ctx);
@@ -799,13 +800,14 @@ CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
 static void __init rk3188a_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
-	struct clk *clk1, *clk2;
+	struct clk **clks;
 	unsigned long rate;
 	int ret;
 
 	ctx = rk3188_common_clk_init(np);
 	if (IS_ERR(ctx))
 		return;
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3188_pll_clks,
 				   ARRAY_SIZE(rk3188_pll_clks),
@@ -813,22 +815,20 @@ static void __init rk3188a_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, rk3188_clk_branches,
 				  ARRAY_SIZE(rk3188_clk_branches));
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-				  mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+				  2, clks[PLL_APLL], clks[PLL_GPLL],
 				  &rk3188_cpuclk_data, rk3188_cpuclk_rates,
 				  ARRAY_SIZE(rk3188_cpuclk_rates));
 
 	/* reparent aclk_cpu_pre from apll */
-	clk1 = __clk_lookup("aclk_cpu_pre");
-	clk2 = __clk_lookup("gpll");
-	if (clk1 && clk2) {
-		rate = clk_get_rate(clk1);
+	if (clks[ACLK_CPU_PRE] && clks[PLL_GPLL]) {
+		rate = clk_get_rate(clks[ACLK_CPU_PRE]);
 
-		ret = clk_set_parent(clk1, clk2);
+		ret = clk_set_parent(clks[ACLK_CPU_PRE], clks[PLL_GPLL]);
 		if (ret < 0)
 			pr_warn("%s: could not reparent aclk_cpu_pre to gpll\n",
 				__func__);
 
-		clk_set_rate(clk1, rate);
+		clk_set_rate(clks[ACLK_CPU_PRE], rate);
 	} else {
 		pr_warn("%s: missing clocks to reparent aclk_cpu_pre to gpll\n",
 			__func__);
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index bcbf8f901965..6f185d65123a 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -132,7 +132,6 @@ static const struct rockchip_cpuclk_reg_data rk3228_cpuclk_data = {
 PNAME(mux_pll_p)		= { "clk_24m", "xin24m" };
 
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr", "apll_ddr" };
-PNAME(mux_armclk_p)		= { "apll_core", "gpll_core", "dpll_core" };
 PNAME(mux_usb480m_phy_p)	= { "usb480m_phy0", "usb480m_phy1" };
 PNAME(mux_usb480m_p)		= { "usb480m_phy", "xin24m" };
 PNAME(mux_hdmiphy_p)		= { "hdmiphy_phy", "xin24m" };
@@ -660,6 +659,7 @@ static void __init rk3228_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -673,6 +673,7 @@ static void __init rk3228_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3228_pll_clks,
 				   ARRAY_SIZE(rk3228_pll_clks),
@@ -681,7 +682,7 @@ static void __init rk3228_clk_init(struct device_node *np)
 				  ARRAY_SIZE(rk3228_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			3, clks[PLL_APLL], clks[PLL_GPLL],
 			&rk3228_cpuclk_data, rk3228_cpuclk_rates,
 			ARRAY_SIZE(rk3228_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 89db93c46403..81ab67716906 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -190,7 +190,6 @@ static const struct rockchip_cpuclk_reg_data rk3288_cpuclk_data = {
 };
 
 PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
-PNAME(mux_armclk_p)		= { "apll_core", "gpll_core" };
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr" };
 PNAME(mux_aclk_cpu_src_p)	= { "cpll_aclk_cpu", "gpll_aclk_cpu" };
 
@@ -922,6 +921,7 @@ static void __init rk3288_common_init(struct device_node *np,
 				      enum rk3288_variant soc)
 {
 	struct rockchip_clk_provider *ctx;
+	struct clk **clks;
 
 	rk3288_cru_base = of_iomap(np, 0);
 	if (!rk3288_cru_base) {
@@ -935,6 +935,7 @@ static void __init rk3288_common_init(struct device_node *np,
 		iounmap(rk3288_cru_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3288_pll_clks,
 				   ARRAY_SIZE(rk3288_pll_clks),
@@ -950,7 +951,7 @@ static void __init rk3288_common_init(struct device_node *np,
 					       ARRAY_SIZE(rk3288_hclkvio_branch));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			2, clks[PLL_APLL], clks[PLL_GPLL],
 			&rk3288_cpuclk_data, rk3288_cpuclk_rates,
 			ARRAY_SIZE(rk3288_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3308.c b/drivers/clk/rockchip/clk-rk3308.c
index 16a4dbd74146..b02154767a4e 100644
--- a/drivers/clk/rockchip/clk-rk3308.c
+++ b/drivers/clk/rockchip/clk-rk3308.c
@@ -121,7 +121,6 @@ static const struct rockchip_cpuclk_reg_data rk3308_cpuclk_data = {
 
 PNAME(mux_pll_p)		= { "xin24m" };
 PNAME(mux_usb480m_p)		= { "xin24m", "usb480m_phy", "clk_rtc32k" };
-PNAME(mux_armclk_p)		= { "apll_core", "vpll0_core", "vpll1_core" };
 PNAME(mux_dpll_vpll0_p)		= { "dpll", "vpll0" };
 PNAME(mux_dpll_vpll0_xin24m_p)	= { "dpll", "vpll0", "xin24m" };
 PNAME(mux_dpll_vpll0_vpll1_p)	= { "dpll", "vpll0", "vpll1" };
@@ -905,6 +904,7 @@ static void __init rk3308_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -918,6 +918,7 @@ static void __init rk3308_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3308_pll_clks,
 				   ARRAY_SIZE(rk3308_pll_clks),
@@ -926,7 +927,7 @@ static void __init rk3308_clk_init(struct device_node *np)
 				       ARRAY_SIZE(rk3308_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+				     3, clks[PLL_APLL], clks[PLL_VPLL0],
 				     &rk3308_cpuclk_data, rk3308_cpuclk_rates,
 				     ARRAY_SIZE(rk3308_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index a8686db20f0a..a1b31666044d 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -157,10 +157,6 @@ PNAME(mux_2plls_24m_u480m_p)	= { "cpll", "gpll",
 				     "xin24m", "usb480m" };
 
 PNAME(mux_ddrphy_p)		= { "dpll", "apll", "cpll" };
-PNAME(mux_armclk_p)		= { "apll_core",
-				    "gpll_core",
-				    "dpll_core",
-				    "npll_core"};
 PNAME(mux_hdmiphy_p)		= { "hdmi_phy", "xin24m" };
 PNAME(mux_usb480m_p)		= { "usb480m_phy",
 				    "xin24m" };
@@ -840,6 +836,7 @@ static void __init rk3328_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -853,6 +850,7 @@ static void __init rk3328_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3328_pll_clks,
 				   ARRAY_SIZE(rk3328_pll_clks),
@@ -861,7 +859,7 @@ static void __init rk3328_clk_init(struct device_node *np)
 				       ARRAY_SIZE(rk3328_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+				     4, clks[PLL_APLL], clks[PLL_GPLL],
 				     &rk3328_cpuclk_data, rk3328_cpuclk_rates,
 				     ARRAY_SIZE(rk3328_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 3594454e3f45..17df0933c8cb 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -88,8 +88,6 @@ static struct rockchip_pll_rate_table rk3368_pll_rates[] = {
 };
 
 PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
-PNAME(mux_armclkb_p)		= { "apllb_core", "gpllb_core" };
-PNAME(mux_armclkl_p)		= { "aplll_core", "gplll_core" };
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr" };
 PNAME(mux_cs_src_p)		= { "apllb_cs", "aplll_cs", "gpll_cs"};
 PNAME(mux_aclk_bus_src_p)	= { "cpll_aclk_bus", "gpll_aclk_bus" };
@@ -856,6 +854,7 @@ static void __init rk3368_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -869,6 +868,7 @@ static void __init rk3368_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3368_pll_clks,
 				   ARRAY_SIZE(rk3368_pll_clks),
@@ -877,12 +877,12 @@ static void __init rk3368_clk_init(struct device_node *np)
 				  ARRAY_SIZE(rk3368_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLKB, "armclkb",
-			mux_armclkb_p, ARRAY_SIZE(mux_armclkb_p),
+			2, clks[PLL_APLLB], clks[PLL_GPLL],
 			&rk3368_cpuclkb_data, rk3368_cpuclkb_rates,
 			ARRAY_SIZE(rk3368_cpuclkb_rates));
 
 	rockchip_clk_register_armclk(ctx, ARMCLKL, "armclkl",
-			mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
+			2, clks[PLL_APLLL], clks[PLL_GPLL],
 			&rk3368_cpuclkl_data, rk3368_cpuclkl_rates,
 			ARRAY_SIZE(rk3368_cpuclkl_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 619950265e8d..ee3bda968574 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -108,14 +108,6 @@ static struct rockchip_pll_rate_table rk3399_pll_rates[] = {
 /* CRU parents */
 PNAME(mux_pll_p)				= { "xin24m", "xin32k" };
 
-PNAME(mux_armclkl_p)				= { "clk_core_l_lpll_src",
-						    "clk_core_l_bpll_src",
-						    "clk_core_l_dpll_src",
-						    "clk_core_l_gpll_src" };
-PNAME(mux_armclkb_p)				= { "clk_core_b_lpll_src",
-						    "clk_core_b_bpll_src",
-						    "clk_core_b_dpll_src",
-						    "clk_core_b_gpll_src" };
 PNAME(mux_ddrclk_p)				= { "clk_ddrc_lpll_src",
 						    "clk_ddrc_bpll_src",
 						    "clk_ddrc_dpll_src",
@@ -1507,6 +1499,7 @@ static void __init rk3399_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -1520,6 +1513,7 @@ static void __init rk3399_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3399_pll_clks,
 				   ARRAY_SIZE(rk3399_pll_clks), -1);
@@ -1528,12 +1522,12 @@ static void __init rk3399_clk_init(struct device_node *np)
 				  ARRAY_SIZE(rk3399_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLKL, "armclkl",
-			mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
+			4, clks[PLL_APLLL], clks[PLL_GPLL],
 			&rk3399_cpuclkl_data, rk3399_cpuclkl_rates,
 			ARRAY_SIZE(rk3399_cpuclkl_rates));
 
 	rockchip_clk_register_armclk(ctx, ARMCLKB, "armclkb",
-			mux_armclkb_p, ARRAY_SIZE(mux_armclkb_p),
+			4, clks[PLL_APLLB], clks[PLL_GPLL],
 			&rk3399_cpuclkb_data, rk3399_cpuclkb_rates,
 			ARRAY_SIZE(rk3399_cpuclkb_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index b1d173ef7da3..64d2278825ab 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -211,7 +211,6 @@ static const struct rockchip_cpuclk_reg_data rk3568_cpuclk_data = {
 
 PNAME(mux_pll_p)			= { "xin24m" };
 PNAME(mux_usb480m_p)			= { "xin24m", "usb480m_phy", "clk_rtc_32k" };
-PNAME(mux_armclk_p)			= { "apll", "gpll" };
 PNAME(clk_i2s0_8ch_tx_p)		= { "clk_i2s0_8ch_tx_src", "clk_i2s0_8ch_tx_frac", "i2s0_mclkin", "xin_osc0_half" };
 PNAME(clk_i2s0_8ch_rx_p)		= { "clk_i2s0_8ch_rx_src", "clk_i2s0_8ch_rx_frac", "i2s0_mclkin", "xin_osc0_half" };
 PNAME(clk_i2s1_8ch_tx_p)		= { "clk_i2s1_8ch_tx_src", "clk_i2s1_8ch_tx_frac", "i2s1_mclkin", "xin_osc0_half" };
@@ -1616,6 +1615,7 @@ static void __init rk3568_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -1629,13 +1629,14 @@ static void __init rk3568_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3568_pll_clks,
 				   ARRAY_SIZE(rk3568_pll_clks),
 				   RK3568_GRF_SOC_STATUS0);
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+				     2, clks[PLL_APLL], clks[PLL_GPLL],
 				     &rk3568_cpuclk_data, rk3568_cpuclk_rates,
 				     ARRAY_SIZE(rk3568_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index 6994165e0395..477aa69d75e2 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -442,9 +442,6 @@ static const struct rockchip_cpuclk_reg_data rk3588_cpulclk_data = {
 };
 
 PNAME(mux_pll_p)			= { "xin24m", "xin32k" };
-PNAME(mux_armclkl_p)			= { "xin24m", "gpll", "lpll" };
-PNAME(mux_armclkb01_p)			= { "xin24m", "gpll", "b0pll",};
-PNAME(mux_armclkb23_p)			= { "xin24m", "gpll", "b1pll",};
 PNAME(b0pll_b1pll_lpll_gpll_p)		= { "b0pll", "b1pll", "lpll", "gpll" };
 PNAME(gpll_24m_p)			= { "gpll", "xin24m" };
 PNAME(gpll_aupll_p)			= { "gpll", "aupll" };
@@ -2459,6 +2456,7 @@ static void __init rk3588_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -2472,21 +2470,22 @@ static void __init rk3588_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rk3588_pll_clks,
 				   ARRAY_SIZE(rk3588_pll_clks),
 				   RK3588_GRF_SOC_STATUS0);
 
 	rockchip_clk_register_armclk(ctx, ARMCLK_L, "armclk_l",
-			mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
+			3, clks[PLL_LPLL], clks[PLL_GPLL],
 			&rk3588_cpulclk_data, rk3588_cpulclk_rates,
 			ARRAY_SIZE(rk3588_cpulclk_rates));
 	rockchip_clk_register_armclk(ctx, ARMCLK_B01, "armclk_b01",
-			mux_armclkb01_p, ARRAY_SIZE(mux_armclkb01_p),
+			3, clks[PLL_B0PLL], clks[PLL_GPLL],
 			&rk3588_cpub0clk_data, rk3588_cpub0clk_rates,
 			ARRAY_SIZE(rk3588_cpub0clk_rates));
 	rockchip_clk_register_armclk(ctx, ARMCLK_B23, "armclk_b23",
-			mux_armclkb23_p, ARRAY_SIZE(mux_armclkb23_p),
+			3, clks[PLL_B1PLL], clks[PLL_GPLL],
 			&rk3588_cpub1clk_data, rk3588_cpub1clk_rates,
 			ARRAY_SIZE(rk3588_cpub1clk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index d290a4cf68b5..394eaf0198bb 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -118,7 +118,6 @@ static const struct rockchip_cpuclk_reg_data rv1108_cpuclk_data = {
 
 PNAME(mux_pll_p)		= { "xin24m", "xin24m"};
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr", "apll_ddr" };
-PNAME(mux_armclk_p)		= { "apll_core", "gpll_core", "dpll_core" };
 PNAME(mux_usb480m_pre_p)	= { "usbphy", "xin24m" };
 PNAME(mux_hdmiphy_phy_p)	= { "hdmiphy", "xin24m" };
 PNAME(mux_dclk_hdmiphy_pre_p)	= { "dclk_hdmiphy_src_gpll", "dclk_hdmiphy_src_dpll" };
@@ -772,6 +771,7 @@ static void __init rv1108_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -785,6 +785,7 @@ static void __init rv1108_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	clks = ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rv1108_pll_clks,
 				   ARRAY_SIZE(rv1108_pll_clks),
@@ -793,7 +794,7 @@ static void __init rv1108_clk_init(struct device_node *np)
 				  ARRAY_SIZE(rv1108_clk_branches));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			3, clks[PLL_APLL], clks[PLL_GPLL],
 			&rv1108_cpuclk_data, rv1108_cpuclk_rates,
 			ARRAY_SIZE(rv1108_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk-rv1126.c b/drivers/clk/rockchip/clk-rv1126.c
index 8eb0e2dfcb28..ae91496c5004 100644
--- a/drivers/clk/rockchip/clk-rv1126.c
+++ b/drivers/clk/rockchip/clk-rv1126.c
@@ -154,7 +154,6 @@ PNAME(mux_usbphy_otg_ref_p)		= { "clk_ref12m", "xin_osc0_div2_usbphyref_otg" };
 PNAME(mux_usbphy_host_ref_p)		= { "clk_ref12m", "xin_osc0_div2_usbphyref_host" };
 PNAME(mux_mipidsiphy_ref_p)		= { "clk_ref24m", "xin_osc0_mipiphyref" };
 PNAME(mux_usb480m_p)			= { "xin24m", "usb480m_phy", "clk_rtc32k" };
-PNAME(mux_armclk_p)			= { "gpll", "cpll", "apll" };
 PNAME(mux_gpll_cpll_dpll_p)		= { "gpll", "cpll", "dummy_dpll" };
 PNAME(mux_gpll_cpll_p)			= { "gpll", "cpll" };
 PNAME(mux_hclk_pclk_pdbus_p)		= { "gpll", "dummy_cpll" };
@@ -1056,6 +1055,7 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 			RV1126_CLKGATE_CON(23), 0, GFLAGS),
 };
 
+static struct rockchip_clk_provider *pmucru_ctx;
 static void __init rv1126_pmu_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -1084,12 +1084,15 @@ static void __init rv1126_pmu_clk_init(struct device_node *np)
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
 	rockchip_clk_of_add_provider(np, ctx);
+
+	pmucru_ctx = ctx;
 }
 
 static void __init rv1126_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk **cru_clks, **pmucru_clks;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -1103,13 +1106,15 @@ static void __init rv1126_clk_init(struct device_node *np)
 		iounmap(reg_base);
 		return;
 	}
+	cru_clks = ctx->clk_data.clks;
+	pmucru_clks = pmucru_ctx->clk_data.clks;
 
 	rockchip_clk_register_plls(ctx, rv1126_pll_clks,
 				   ARRAY_SIZE(rv1126_pll_clks),
 				   RV1126_GRF_SOC_STATUS0);
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
-				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+				     3, cru_clks[PLL_APLL], pmucru_clks[PLL_GPLL],
 				     &rv1126_cpuclk_data, rv1126_cpuclk_rates,
 				     ARRAY_SIZE(rv1126_cpuclk_rates));
 
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 9f23bd5ee22d..73b89dd3ca7d 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -575,15 +575,17 @@ EXPORT_SYMBOL_GPL(rockchip_clk_register_branches);
 
 void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 				  unsigned int lookup_id,
-				  const char *name, const char *const *parent_names,
+				  const char *name,
 				  u8 num_parents,
+				  struct clk *parent, struct clk *alt_parent,
 				  const struct rockchip_cpuclk_reg_data *reg_data,
 				  const struct rockchip_cpuclk_rate_table *rates,
 				  int nrates)
 {
 	struct clk *clk;
 
-	clk = rockchip_clk_register_cpuclk(name, parent_names, num_parents,
+	clk = rockchip_clk_register_cpuclk(name, num_parents,
+		parent, alt_parent,
 					   reg_data, rates, nrates,
 					   ctx->reg_base, &ctx->lock);
 	if (IS_ERR(clk)) {
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 4fd3036817f4..a9937fc5804a 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -473,7 +473,8 @@ struct rockchip_cpuclk_reg_data {
 };
 
 struct clk *rockchip_clk_register_cpuclk(const char *name,
-			const char *const *parent_names, u8 num_parents,
+			u8 num_parents,
+			struct clk *parent, struct clk *alt_parent,
 			const struct rockchip_cpuclk_reg_data *reg_data,
 			const struct rockchip_cpuclk_rate_table *rates,
 			int nrates, void __iomem *reg_base, spinlock_t *lock);
@@ -979,12 +980,14 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 void rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
 				struct rockchip_pll_clock *pll_list,
 				unsigned int nr_pll, int grf_lock_offset);
-void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
-			unsigned int lookup_id, const char *name,
-			const char *const *parent_names, u8 num_parents,
-			const struct rockchip_cpuclk_reg_data *reg_data,
-			const struct rockchip_cpuclk_rate_table *rates,
-			int nrates);
+void __init rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
+					 unsigned int lookup_id,
+					 const char *name,
+					 u8 num_parents,
+					 struct clk *parent, struct clk *alt_parent,
+					 const struct rockchip_cpuclk_reg_data *reg_data,
+					 const struct rockchip_cpuclk_rate_table *rates,
+					 int nrates);
 void rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
 					unsigned int reg, void (*cb)(void));
 
-- 
2.17.1

