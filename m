Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492637A4354
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjIRHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbjIRHog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:44:36 -0400
X-Greylist: delayed 524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 00:41:55 PDT
Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com [101.71.155.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8E10CA;
        Mon, 18 Sep 2023 00:41:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=VfVhtCJ6AMXh+sdcXamQjEtKxE5Qp7yRbgivQ2lDOTlf4L7q6Fpzm23grpuMPRxaVxrzWzq45ZpKmM3LG2U4rr7fc6Sg6MO4+Bx/cRE/UlrRbK0vJnIjQiEaZIMIAa2xCsQuSbljGCJhw00p/jyle3BV+/l5JuHU9wVunDFlCKw=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=LBQLyeaa39bKbNLG+iqHtUs7X9lOr9xE9Ryz9c4C5c8=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 0DA7A68058C;
        Mon, 18 Sep 2023 15:31:54 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 2/8] clk: rockchip: drop use of rockchip_clk_protect_critical()
Date:   Mon, 18 Sep 2023 15:31:45 +0800
Message-Id: <20230918073151.7660-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918073151.7660-1-zhangqing@rock-chips.com>
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xJHlYdHhhMHkIZQk1MGh1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa733f3a52eb5kusn0da7a68058c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6CRw5GD1RGUo5SQhDSQM8
        DiIwCyJVSlVKTUJOS0lJSEpOSEhIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpPQ0tJSzcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip common clocks to support GKI,
Avoid __clk_lookup() calls,so needed to replace the
rockchip_clk_protect_critical, and use the flag
CLK_IS_CRITICAL.(but use flag CLK_IS_CRITICAL,
the enable count is always "0")

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-px30.c   |  71 +++------
 drivers/clk/rockchip/clk-rk3036.c |  37 ++---
 drivers/clk/rockchip/clk-rk3128.c |  54 +++----
 drivers/clk/rockchip/clk-rk3188.c |  37 ++---
 drivers/clk/rockchip/clk-rk3228.c | 142 +++++++----------
 drivers/clk/rockchip/clk-rk3288.c |  69 ++++----
 drivers/clk/rockchip/clk-rk3308.c |  41 ++---
 drivers/clk/rockchip/clk-rk3328.c | 178 ++++++++-------------
 drivers/clk/rockchip/clk-rk3368.c |  63 +++-----
 drivers/clk/rockchip/clk-rk3399.c | 257 +++++++++++++-----------------
 drivers/clk/rockchip/clk-rk3568.c |  97 ++++-------
 drivers/clk/rockchip/clk-rv1108.c |  60 +++----
 drivers/clk/rockchip/clk-rv1126.c |  69 +++-----
 drivers/clk/rockchip/clk.c        |  14 --
 drivers/clk/rockchip/clk.h        |   1 -
 15 files changed, 451 insertions(+), 739 deletions(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index b58619eb412b..02fdb6273f4a 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -192,7 +192,7 @@ static struct rockchip_pll_clock px30_pll_clks[] __initdata = {
 		     0, PX30_PLL_CON(16),
 		     PX30_MODE_CON, 2, 2, 0, px30_pll_rates),
 	[npll] = PLL(pll_rk3328, PLL_NPLL, "npll", mux_pll_p,
-		     0, PX30_PLL_CON(24),
+		     CLK_IS_CRITICAL, PX30_PLL_CON(24),
 		     PX30_MODE_CON, 6, 4, 0, px30_pll_rates),
 };
 
@@ -317,7 +317,7 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "aclk_gpu", "clk_gpu", CLK_IGNORE_UNUSED,
 			PX30_CLKSEL_CON(1), 13, 2, DFLAGS,
 			PX30_CLKGATE_CON(17), 10, GFLAGS),
-	GATE(0, "aclk_gpu_niu", "aclk_gpu", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_gpu_niu", "aclk_gpu", CLK_IS_CRITICAL,
 			PX30_CLKGATE_CON(0), 11, GFLAGS),
 	GATE(0, "aclk_gpu_prf", "aclk_gpu", CLK_IGNORE_UNUSED,
 			PX30_CLKGATE_CON(17), 8, GFLAGS),
@@ -453,13 +453,13 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 7
 	 */
 
-	COMPOSITE_NODIV(ACLK_PERI_SRC, "aclk_peri_src", mux_gpll_cpll_p, 0,
+	COMPOSITE_NODIV(ACLK_PERI_SRC, "aclk_peri_src", mux_gpll_cpll_p, CLK_IS_CRITICAL,
 			PX30_CLKSEL_CON(14), 15, 1, MFLAGS,
 			PX30_CLKGATE_CON(5), 7, GFLAGS),
-	COMPOSITE_NOMUX(ACLK_PERI_PRE, "aclk_peri_pre", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(ACLK_PERI_PRE, "aclk_peri_pre", "aclk_peri_src", CLK_IS_CRITICAL,
 			PX30_CLKSEL_CON(14), 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(5), 8, GFLAGS),
-	DIV(HCLK_PERI_PRE, "hclk_peri_pre", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	DIV(HCLK_PERI_PRE, "hclk_peri_pre", "aclk_peri_src", CLK_IS_CRITICAL,
 			PX30_CLKSEL_CON(14), 8, 5, DFLAGS),
 
 	/* PD_MMC_NAND */
@@ -536,7 +536,7 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 			PX30_CLKGATE_CON(6), 15, GFLAGS),
 
 	/* PD_USB */
-	GATE(HCLK_USB, "hclk_usb", "hclk_peri_pre", 0,
+	GATE(HCLK_USB, "hclk_usb", "hclk_peri_pre", CLK_IS_CRITICAL,
 			PX30_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(SCLK_OTG_ADP, "clk_otg_adp", "clk_rtc32k_pmu", 0,
 			PX30_CLKGATE_CON(7), 3, GFLAGS),
@@ -571,19 +571,19 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	 */
 
 	/* PD_BUS */
-	COMPOSITE_NODIV(ACLK_BUS_SRC, "aclk_bus_src", mux_gpll_cpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NODIV(ACLK_BUS_SRC, "aclk_bus_src", mux_gpll_cpll_p, CLK_IS_CRITICAL,
 			PX30_CLKSEL_CON(23), 15, 1, MFLAGS,
 			PX30_CLKGATE_CON(8), 6, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_BUS_PRE, "hclk_bus_pre", "aclk_bus_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_BUS_PRE, "hclk_bus_pre", "aclk_bus_src", CLK_IS_CRITICAL,
 			PX30_CLKSEL_CON(24), 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(8), 8, GFLAGS),
-	COMPOSITE_NOMUX(ACLK_BUS_PRE, "aclk_bus_pre", "aclk_bus_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(ACLK_BUS_PRE, "aclk_bus_pre", "aclk_bus_src", CLK_IS_CRITICAL,
 			PX30_CLKSEL_CON(23), 8, 5, DFLAGS,
 			PX30_CLKGATE_CON(8), 7, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_BUS_PRE, "pclk_bus_pre", "aclk_bus_pre", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_BUS_PRE, "pclk_bus_pre", "aclk_bus_pre", CLK_IS_CRITICAL,
 			PX30_CLKSEL_CON(24), 8, 2, DFLAGS,
 			PX30_CLKGATE_CON(8), 9, GFLAGS),
-	GATE(0, "pclk_top_pre", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_top_pre", "pclk_bus_pre", CLK_IS_CRITICAL,
 			PX30_CLKGATE_CON(8), 10, GFLAGS),
 
 	COMPOSITE(0, "clk_pdm_src", mux_gpll_xin24m_npll_p, 0,
@@ -681,7 +681,7 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 			PX30_CLKSEL_CON(39), 0,
 			PX30_CLKGATE_CON(11), 2, GFLAGS,
 			&px30_uart2_fracmux),
-	GATE(SCLK_UART2, "clk_uart2", "clk_uart2_mux", CLK_SET_RATE_PARENT,
+	GATE(SCLK_UART2, "clk_uart2", "clk_uart2_mux", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 			PX30_CLKGATE_CON(11), 3, GFLAGS),
 
 	COMPOSITE(0, "clk_uart3_src", mux_uart_src_p, 0,
@@ -800,29 +800,30 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	GATE(0, "pclk_ddrphy", "pclk_top_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(16), 3, GFLAGS),
 	GATE(PCLK_MIPIDSIPHY, "pclk_mipidsiphy", "pclk_top_pre", 0, PX30_CLKGATE_CON(16), 4, GFLAGS),
 	GATE(PCLK_MIPICSIPHY, "pclk_mipicsiphy", "pclk_top_pre", 0, PX30_CLKGATE_CON(16), 5, GFLAGS),
-	GATE(PCLK_USB_GRF, "pclk_usb_grf", "pclk_top_pre", 0, PX30_CLKGATE_CON(16), 6, GFLAGS),
+	GATE(PCLK_USB_GRF, "pclk_usb_grf", "pclk_top_pre", CLK_IS_CRITICAL,
+			PX30_CLKGATE_CON(16), 6, GFLAGS),
 	GATE(0, "pclk_cpu_hoost", "pclk_top_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(16), 7, GFLAGS),
 
 	/* PD_VI */
-	GATE(0, "aclk_vi_niu", "aclk_vi_pre", 0, PX30_CLKGATE_CON(4), 15, GFLAGS),
+	GATE(0, "aclk_vi_niu", "aclk_vi_pre", CLK_IS_CRITICAL, PX30_CLKGATE_CON(4), 15, GFLAGS),
 	GATE(ACLK_CIF, "aclk_cif", "aclk_vi_pre", 0, PX30_CLKGATE_CON(5), 1, GFLAGS),
 	GATE(ACLK_ISP, "aclk_isp", "aclk_vi_pre", 0, PX30_CLKGATE_CON(5), 3, GFLAGS),
-	GATE(0, "hclk_vi_niu", "hclk_vi_pre", 0, PX30_CLKGATE_CON(5), 0, GFLAGS),
+	GATE(0, "hclk_vi_niu", "hclk_vi_pre", CLK_IS_CRITICAL, PX30_CLKGATE_CON(5), 0, GFLAGS),
 	GATE(HCLK_CIF, "hclk_cif", "hclk_vi_pre", 0, PX30_CLKGATE_CON(5), 2, GFLAGS),
 	GATE(HCLK_ISP, "hclk_isp", "hclk_vi_pre", 0, PX30_CLKGATE_CON(5), 4, GFLAGS),
 
 	/* PD_VO */
-	GATE(0, "aclk_vo_niu", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 0, GFLAGS),
+	GATE(0, "aclk_vo_niu", "aclk_vo_pre", CLK_IS_CRITICAL, PX30_CLKGATE_CON(3), 0, GFLAGS),
 	GATE(ACLK_VOPB, "aclk_vopb", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 3, GFLAGS),
 	GATE(ACLK_RGA, "aclk_rga", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 7, GFLAGS),
 	GATE(ACLK_VOPL, "aclk_vopl", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 5, GFLAGS),
 
-	GATE(0, "hclk_vo_niu", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 1, GFLAGS),
+	GATE(0, "hclk_vo_niu", "hclk_vo_pre", CLK_IS_CRITICAL, PX30_CLKGATE_CON(3), 1, GFLAGS),
 	GATE(HCLK_VOPB, "hclk_vopb", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 4, GFLAGS),
 	GATE(HCLK_RGA, "hclk_rga", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 8, GFLAGS),
 	GATE(HCLK_VOPL, "hclk_vopl", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 6, GFLAGS),
 
-	GATE(0, "pclk_vo_niu", "pclk_vo_pre", 0, PX30_CLKGATE_CON(3), 2, GFLAGS),
+	GATE(0, "pclk_vo_niu", "pclk_vo_pre", CLK_IS_CRITICAL, PX30_CLKGATE_CON(3), 2, GFLAGS),
 	GATE(PCLK_MIPI_DSI, "pclk_mipi_dsi", "pclk_vo_pre", 0, PX30_CLKGATE_CON(3), 9, GFLAGS),
 
 	/* PD_BUS */
@@ -844,7 +845,8 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	GATE(0, "pclk_bus_niu", "pclk_bus_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(13), 10, GFLAGS),
 	GATE(PCLK_DCF, "pclk_dcf", "pclk_bus_pre", 0, PX30_CLKGATE_CON(14), 0, GFLAGS),
 	GATE(PCLK_UART1, "pclk_uart1", "pclk_bus_pre", 0, PX30_CLKGATE_CON(14), 5, GFLAGS),
-	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus_pre", 0, PX30_CLKGATE_CON(14), 6, GFLAGS),
+	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus_pre", CLK_IS_CRITICAL,
+			PX30_CLKGATE_CON(14), 6, GFLAGS),
 	GATE(PCLK_UART3, "pclk_uart3", "pclk_bus_pre", 0, PX30_CLKGATE_CON(14), 7, GFLAGS),
 	GATE(PCLK_UART4, "pclk_uart4", "pclk_bus_pre", 0, PX30_CLKGATE_CON(14), 8, GFLAGS),
 	GATE(PCLK_UART5, "pclk_uart5", "pclk_bus_pre", 0, PX30_CLKGATE_CON(14), 9, GFLAGS),
@@ -885,7 +887,7 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_sdmmc_pre", 0, PX30_CLKGATE_CON(7), 1, GFLAGS),
 
 	/* PD_PERI */
-	GATE(0, "aclk_peri_niu", "aclk_peri_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(5), 9, GFLAGS),
+	GATE(0, "aclk_peri_niu", "aclk_peri_pre", CLK_IS_CRITICAL, PX30_CLKGATE_CON(5), 9, GFLAGS),
 
 	/* PD_MMC_NAND */
 	GATE(HCLK_NANDC, "hclk_nandc", "hclk_mmc_nand", 0, PX30_CLKGATE_CON(5), 15, GFLAGS),
@@ -895,7 +897,7 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	GATE(HCLK_SFC, "hclk_sfc", "hclk_mmc_nand", 0, PX30_CLKGATE_CON(6), 11, GFLAGS),
 
 	/* PD_USB */
-	GATE(0, "hclk_usb_niu", "hclk_usb", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(7), 4, GFLAGS),
+	GATE(0, "hclk_usb_niu", "hclk_usb", CLK_IS_CRITICAL, PX30_CLKGATE_CON(7), 4, GFLAGS),
 	GATE(HCLK_OTG, "hclk_otg", "hclk_usb", 0, PX30_CLKGATE_CON(7), 5, GFLAGS),
 	GATE(HCLK_HOST, "hclk_host", "hclk_usb", 0, PX30_CLKGATE_CON(7), 6, GFLAGS),
 	GATE(HCLK_HOST_ARB, "hclk_host_arb", "hclk_usb", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(7), 8, GFLAGS),
@@ -948,7 +950,7 @@ static struct rockchip_clk_branch px30_clk_pmu_branches[] __initdata = {
 	GATE(SCLK_PVTM_PMU, "clk_pvtm_pmu", "xin24m", 0,
 			PX30_PMU_CLKGATE_CON(1), 4, GFLAGS),
 
-	COMPOSITE_NOMUX(PCLK_PMU_PRE, "pclk_pmu_pre", "gpll", 0,
+	COMPOSITE_NOMUX(PCLK_PMU_PRE, "pclk_pmu_pre", "gpll", CLK_IS_CRITICAL,
 			PX30_PMU_CLKSEL_CON(0), 0, 5, DFLAGS,
 			PX30_PMU_CLKGATE_CON(0), 0, GFLAGS),
 
@@ -977,28 +979,6 @@ static struct rockchip_clk_branch px30_clk_pmu_branches[] __initdata = {
 	GATE(0, "pclk_cru_pmu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, PX30_PMU_CLKGATE_CON(0), 8, GFLAGS),
 };
 
-static const char *const px30_cru_critical_clocks[] __initconst = {
-	"aclk_bus_pre",
-	"pclk_bus_pre",
-	"hclk_bus_pre",
-	"aclk_peri_pre",
-	"hclk_peri_pre",
-	"aclk_gpu_niu",
-	"pclk_top_pre",
-	"pclk_pmu_pre",
-	"hclk_usb_niu",
-	"pclk_vo_niu",
-	"aclk_vo_niu",
-	"hclk_vo_niu",
-	"aclk_vi_niu",
-	"hclk_vi_niu",
-	"pll_npll",
-	"usb480m",
-	"clk_uart2",
-	"pclk_uart2",
-	"pclk_usb_grf",
-};
-
 static void __init px30_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -1028,9 +1008,6 @@ static void __init px30_clk_init(struct device_node *np)
 				     &px30_cpuclk_data, px30_cpuclk_rates,
 				     ARRAY_SIZE(px30_cpuclk_rates));
 
-	rockchip_clk_protect_critical(px30_cru_critical_clocks,
-				      ARRAY_SIZE(px30_cru_critical_clocks));
-
 	rockchip_register_softrst(np, 12, reg_base + PX30_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index d644bc155ec6..7cba188d9b01 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -195,32 +195,32 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(1), 4, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK2928_CLKGATE_CON(0), 7, GFLAGS),
 
-	GATE(0, "dpll_cpu", "dpll", 0, RK2928_CLKGATE_CON(10), 8, GFLAGS),
-	GATE(0, "gpll_cpu", "gpll", 0, RK2928_CLKGATE_CON(0), 1, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_busclk_p, 0,
+	GATE(0, "dpll_cpu", "dpll", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(10), 8, GFLAGS),
+	GATE(0, "gpll_cpu", "gpll", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(0), 1, GFLAGS),
+	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_busclk_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(0), 14, 2, MFLAGS, 8, 5, DFLAGS),
-	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src",  CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(1), 12, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK2928_CLKGATE_CON(0), 5, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK2928_CLKGATE_CON(0), 4, GFLAGS),
 
-	COMPOSITE(0, "aclk_peri_src", mux_pll_src_3plls_p, 0,
+	COMPOSITE(0, "aclk_peri_src", mux_pll_src_3plls_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
 
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
-	DIV(0, "pclk_peri_src", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	DIV(0, "pclk_peri_src", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
-	GATE(PCLK_PERI, "pclk_peri", "pclk_peri_src", 0,
+	GATE(PCLK_PERI, "pclk_peri", "pclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
-	DIV(0, "hclk_peri_src", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	DIV(0, "hclk_peri_src", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
-	GATE(HCLK_PERI, "hclk_peri", "hclk_peri_src", 0,
+	GATE(HCLK_PERI, "hclk_peri", "hclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
 
 	COMPOSITE_NODIV(SCLK_TIMER0, "sclk_timer0", mux_timer_p, CLK_IGNORE_UNUSED,
@@ -371,7 +371,8 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 
 	/* pclk_cpu gates */
 	GATE(PCLK_GRF, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 4, GFLAGS),
-	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 7, GFLAGS),
+	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_cpu", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(5), 7, GFLAGS),
 	GATE(PCLK_ACODEC, "pclk_acodec", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
 	GATE(PCLK_HDMI, "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS),
 
@@ -425,14 +426,6 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
 };
 
-static const char *const rk3036_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_peri",
-	"pclk_ddrupctl",
-};
-
 static void __init rk3036_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -469,8 +462,6 @@ static void __init rk3036_clk_init(struct device_node *np)
 				   RK3036_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3036_clk_branches,
 				  ARRAY_SIZE(rk3036_clk_branches));
-	rockchip_clk_protect_critical(rk3036_critical_clocks,
-				      ARRAY_SIZE(rk3036_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index aa53797dbfc1..09931fc7dadc 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -232,15 +232,15 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_MISC_CON, 15, 1, MFLAGS),
 
 	/* PD_CPU */
-	COMPOSITE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, 0,
+	COMPOSITE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(0), 13, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(0), 1, GFLAGS),
-	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", 0,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", 0,
+	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS,
 			RK2928_CLKGATE_CON(0), 4, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_src", 0,
+	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(1), 12, 2, DFLAGS,
 			RK2928_CLKGATE_CON(0), 5, GFLAGS),
 	COMPOSITE_NOMUX(SCLK_CRYPTO, "clk_crypto", "aclk_cpu_src", 0,
@@ -264,34 +264,33 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(3), 10, GFLAGS),
 
 	/* PD_VIO */
-	COMPOSITE(ACLK_VIO0, "aclk_vio0", mux_pll_src_5plls_p, 0,
+	COMPOSITE(ACLK_VIO0, "aclk_vio0", mux_pll_src_5plls_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(31), 5, 3, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 0, GFLAGS),
 	COMPOSITE(ACLK_VIO1, "aclk_vio1", mux_pll_src_5plls_p, 0,
 			RK2928_CLKSEL_CON(31), 13, 3, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 4, GFLAGS),
-	COMPOSITE(HCLK_VIO, "hclk_vio", mux_pll_src_4plls_p, 0,
-			RK2928_CLKSEL_CON(30), 14, 2, MFLAGS, 8, 5, DFLAGS,
+	FACTOR_GATE(HCLK_VIO, "hclk_vio", "aclk_vio0", CLK_IS_CRITICAL, 1, 4,
 			RK2928_CLKGATE_CON(0), 11, GFLAGS),
 
 	/* PD_PERI */
-	GATE(0, "gpll_peri", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_peri", "gpll", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "cpll_peri", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_peri", "cpll", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_div2_peri", "gpll_div2", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_div2_peri", "gpll_div2", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_div3_peri", "gpll_div3", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_div3_peri", "gpll_div3", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_peri_src", mux_aclk_peri_src_p, 0,
+	COMPOSITE_NOGATE(0, "aclk_peri_src", mux_aclk_peri_src_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
 
 	GATE(SCLK_TIMER0, "sclk_timer0", "xin24m", 0,
@@ -304,7 +303,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(10), 6, GFLAGS),
 	GATE(SCLK_TIMER4, "sclk_timer4", "xin24m", 0,
 			RK2928_CLKGATE_CON(10), 7, GFLAGS),
-	GATE(SCLK_TIMER5, "sclk_timer5", "xin24m", 0,
+	GATE(SCLK_TIMER5, "sclk_timer5", "xin24m", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(10), 8, GFLAGS),
 
 	GATE(SCLK_PVTM_CORE, "clk_pvtm_core", "xin24m", 0,
@@ -452,7 +451,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(2), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(10), 15, GFLAGS),
 
-	COMPOSITE_NOMUX(PCLK_PMU_PRE, "pclk_pmu_pre", "cpll", 0,
+	COMPOSITE_NOMUX(PCLK_PMU_PRE, "pclk_pmu_pre", "cpll", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(29), 8, 6, DFLAGS,
 			RK2928_CLKGATE_CON(1), 0, GFLAGS),
 
@@ -474,7 +473,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(HCLK_RGA, "hclk_rga", "hclk_vio", 0, RK2928_CLKGATE_CON(6), 10, GFLAGS),
 	GATE(HCLK_LCDC0, "hclk_lcdc0", "hclk_vio", 0, RK2928_CLKGATE_CON(6), 1, GFLAGS),
 	GATE(HCLK_IEP, "hclk_iep", "hclk_vio", 0, RK2928_CLKGATE_CON(9), 7, GFLAGS),
-	GATE(0, "hclk_vio_niu", "hclk_vio", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(6), 12, GFLAGS),
+	GATE(0, "hclk_vio_niu", "hclk_vio", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(6), 12, GFLAGS),
 	GATE(HCLK_CIF, "hclk_cif", "hclk_vio", 0, RK2928_CLKGATE_CON(6), 4, GFLAGS),
 	GATE(HCLK_EBC, "hclk_ebc", "hclk_vio", 0, RK2928_CLKGATE_CON(9), 9, GFLAGS),
 
@@ -534,8 +533,8 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(0, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 4, GFLAGS),
 	GATE(0, "pclk_mipiphy", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 0, GFLAGS),
 
-	GATE(0, "pclk_pmu", "pclk_pmu_pre", 0, RK2928_CLKGATE_CON(9), 2, GFLAGS),
-	GATE(0, "pclk_pmu_niu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 3, GFLAGS),
+	GATE(0, "pclk_pmu", "pclk_pmu_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(9), 2, GFLAGS),
+	GATE(0, "pclk_pmu_niu", "pclk_pmu_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(9), 3, GFLAGS),
 
 	/* PD_MMC */
 	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RK3228_SDMMC_CON0, 1),
@@ -563,17 +562,6 @@ static struct rockchip_clk_branch rk3128_clk_branches[] __initdata = {
 	GATE(PCLK_HDMI, "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS),
 };
 
-static const char *const rk3128_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"hclk_cpu",
-	"pclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_peri",
-	"pclk_pmu",
-	"sclk_timer5",
-};
-
 static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -621,8 +609,6 @@ static void __init rk3126_clk_init(struct device_node *np)
 
 	rockchip_clk_register_branches(ctx, rk3126_clk_branches,
 				       ARRAY_SIZE(rk3126_clk_branches));
-	rockchip_clk_protect_critical(rk3128_critical_clocks,
-				      ARRAY_SIZE(rk3128_critical_clocks));
 
 	rockchip_clk_of_add_provider(np, ctx);
 }
@@ -639,8 +625,6 @@ static void __init rk3128_clk_init(struct device_node *np)
 
 	rockchip_clk_register_branches(ctx, rk3128_clk_branches,
 				       ARRAY_SIZE(rk3128_clk_branches));
-	rockchip_clk_protect_critical(rk3128_critical_clocks,
-				      ARRAY_SIZE(rk3128_critical_clocks));
 
 	rockchip_clk_of_add_provider(np, ctx);
 }
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 9c8af4d1dae0..455245815a11 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -301,14 +301,14 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(26), 8, 1, MFLAGS, 0, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(0), 2, GFLAGS),
 
-	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", 0,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
 
 	GATE(0, "atclk_cpu", "pclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 6, GFLAGS),
-	GATE(PCLK_CPU, "pclk_cpu", "pclk_cpu_pre", 0,
+	GATE(PCLK_CPU, "pclk_cpu", "pclk_cpu_pre", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 5, GFLAGS),
-	GATE(HCLK_CPU, "hclk_cpu", "hclk_cpu_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_CPU, "hclk_cpu", "hclk_cpu_pre", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 4, GFLAGS),
 
 	COMPOSITE(0, "aclk_lcdc0_pre", mux_pll_src_cpll_gpll_p, CLK_IGNORE_UNUSED,
@@ -318,12 +318,12 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(31), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 4, GFLAGS),
 
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_pre", 0,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_pre", 0,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_pre", 0,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
 
@@ -356,7 +356,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(2), 5, GFLAGS),
 	MUX(SCLK_MAC, "sclk_macref", mux_sclk_macref_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(21), 4, 1, MFLAGS),
-	GATE(0, "sclk_mac_lbtest", "sclk_macref", 0,
+	GATE(0, "sclk_mac_lbtest", "sclk_macref", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 12, GFLAGS),
 
 	COMPOSITE(0, "hsadc_src", mux_pll_src_gpll_cpll_p, 0,
@@ -452,9 +452,9 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	/* hclk_cpu gates */
 	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(5), 6, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
-	GATE(0, "hclk_cpubus", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 8, GFLAGS),
+	GATE(0, "hclk_cpubus", "hclk_cpu", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(4), 8, GFLAGS),
 	/* hclk_ahb2apb is part of a clk branch */
-	GATE(0, "hclk_vio_bus", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 12, GFLAGS),
+	GATE(0, "hclk_vio_bus", "hclk_cpu", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(6), 12, GFLAGS),
 	GATE(HCLK_LCDC0, "hclk_lcdc0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 1, GFLAGS),
 	GATE(HCLK_LCDC1, "hclk_lcdc1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 2, GFLAGS),
 	GATE(HCLK_CIF0, "hclk_cif0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 4, GFLAGS),
@@ -572,7 +572,7 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 	GATE(CORE_L2C, "core_l2c", "aclk_cpu", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(9), 4, GFLAGS),
 
-	COMPOSITE(0, "aclk_peri_pre", mux_pll_src_gpll_cpll_p, 0,
+	COMPOSITE(0, "aclk_peri_pre", mux_pll_src_gpll_cpll_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 15, 1, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
 
@@ -691,7 +691,7 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 	GATE(CORE_L2C, "core_l2c", "armclk", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(9), 4, GFLAGS),
 
-	COMPOSITE(0, "aclk_peri_pre", mux_pll_src_cpll_gpll_p, 0,
+	COMPOSITE(0, "aclk_peri_pre", mux_pll_src_cpll_gpll_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 15, 1, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
 
@@ -746,17 +746,6 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 	GATE(ACLK_GPS, "aclk_gps", "aclk_peri", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
 };
 
-static const char *const rk3188_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_cpu",
-	"pclk_peri",
-	"hclk_cpubus",
-	"hclk_vio_bus",
-	"sclk_mac_lbtest",
-};
-
 static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -803,8 +792,6 @@ static void __init rk3066a_clk_init(struct device_node *np)
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 			&rk3066_cpuclk_data, rk3066_cpuclk_rates,
 			ARRAY_SIZE(rk3066_cpuclk_rates));
-	rockchip_clk_protect_critical(rk3188_critical_clocks,
-				      ARRAY_SIZE(rk3188_critical_clocks));
 	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
@@ -847,8 +834,6 @@ static void __init rk3188a_clk_init(struct device_node *np)
 			__func__);
 	}
 
-	rockchip_clk_protect_critical(rk3188_critical_clocks,
-				      ARRAY_SIZE(rk3188_critical_clocks));
 	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3188a_cru, "rockchip,rk3188a-cru", rk3188a_clk_init);
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index a24a35553e13..bcbf8f901965 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -254,27 +254,27 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_MISC_CON, 15, 1, MFLAGS),
 
 	/* PD_BUS */
-	GATE(0, "hdmiphy_aclk_cpu", "hdmiphy", CLK_IGNORE_UNUSED,
+	GATE(0, "hdmiphy_aclk_cpu", "hdmiphy", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 1, GFLAGS),
-	GATE(0, "gpll_aclk_cpu", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_cpu", "gpll", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 1, GFLAGS),
-	GATE(0, "cpll_aclk_cpu", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_cpu", "cpll", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 1, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, 0,
+	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(0), 13, 2, MFLAGS, 8, 5, DFLAGS),
-	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", 0,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(6), 0, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", 0,
+	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS,
 			RK2928_CLKGATE_CON(6), 1, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_bus_src", "aclk_cpu_src", 0,
+	COMPOSITE_NOMUX(0, "pclk_bus_src", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(1), 12, 3, DFLAGS,
 			RK2928_CLKGATE_CON(6), 2, GFLAGS),
-	GATE(PCLK_CPU, "pclk_cpu", "pclk_bus_src", 0,
+	GATE(PCLK_CPU, "pclk_cpu", "pclk_bus_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(6), 3, GFLAGS),
-	GATE(0, "pclk_phy_pre", "pclk_bus_src", 0,
+	GATE(0, "pclk_phy_pre", "pclk_bus_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(6), 4, GFLAGS),
-	GATE(0, "pclk_ddr_pre", "pclk_bus_src", 0,
+	GATE(0, "pclk_ddr_pre", "pclk_bus_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(6), 13, GFLAGS),
 
 	/* PD_VIDEO */
@@ -309,9 +309,9 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(31), 13, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 4, GFLAGS),
 
-	MUX(0, "sclk_rga_src", mux_pll_src_4plls_p, 0,
+	MUX(0, "sclk_rga_src", mux_pll_src_4plls_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(33), 13, 2, MFLAGS),
-	COMPOSITE_NOMUX(ACLK_RGA_PRE, "aclk_rga_pre", "sclk_rga_src", 0,
+	COMPOSITE_NOMUX(ACLK_RGA_PRE, "aclk_rga_pre", "sclk_rga_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(33), 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 2, GFLAGS),
 	COMPOSITE(SCLK_RGA, "sclk_rga", mux_sclk_rga_p, 0,
@@ -334,21 +334,21 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(3), 8, GFLAGS),
 
 	/* PD_PERI */
-	GATE(0, "cpll_peri", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_peri", "cpll", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_peri", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_peri", "gpll", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "hdmiphy_peri", "hdmiphy", CLK_IGNORE_UNUSED,
+	GATE(0, "hdmiphy_peri", "hdmiphy", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_peri_src", mux_aclk_peri_src_p, 0,
+	COMPOSITE_NOGATE(0, "aclk_peri_src", mux_aclk_peri_src_p, CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 10, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 12, 3, DFLAGS,
 			RK2928_CLKGATE_CON(5), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS,
 			RK2928_CLKGATE_CON(5), 1, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(5), 0, GFLAGS),
 
 	GATE(SCLK_TIMER0, "sclk_timer0", "xin24m", 0,
@@ -530,22 +530,27 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 
 	/* PD_VOP */
 	GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0, RK2928_CLKGATE_CON(13), 0, GFLAGS),
-	GATE(0, "aclk_rga_noc", "aclk_rga_pre", 0, RK2928_CLKGATE_CON(13), 11, GFLAGS),
+	GATE(0, "aclk_rga_noc", "aclk_rga_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(13), 11, GFLAGS),
 	GATE(ACLK_IEP, "aclk_iep", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 2, GFLAGS),
-	GATE(0, "aclk_iep_noc", "aclk_iep_pre", 0, RK2928_CLKGATE_CON(13), 9, GFLAGS),
+	GATE(0, "aclk_iep_noc", "aclk_iep_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(13), 9, GFLAGS),
 
 	GATE(ACLK_VOP, "aclk_vop", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 5, GFLAGS),
-	GATE(0, "aclk_vop_noc", "aclk_vop_pre", 0, RK2928_CLKGATE_CON(13), 12, GFLAGS),
+	GATE(0, "aclk_vop_noc", "aclk_vop_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(13), 12, GFLAGS),
 
 	GATE(ACLK_HDCP, "aclk_hdcp", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(14), 10, GFLAGS),
-	GATE(0, "aclk_hdcp_noc", "aclk_hdcp_pre", 0, RK2928_CLKGATE_CON(13), 10, GFLAGS),
+	GATE(0, "aclk_hdcp_noc", "aclk_hdcp_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(13), 10, GFLAGS),
 
 	GATE(HCLK_RGA, "hclk_rga", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(HCLK_IEP, "hclk_iep", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 3, GFLAGS),
 	GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 6, GFLAGS),
-	GATE(0, "hclk_vio_ahb_arbi", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 7, GFLAGS),
-	GATE(0, "hclk_vio_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 8, GFLAGS),
-	GATE(0, "hclk_vop_noc", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(13), 13, GFLAGS),
+	GATE(0, "hclk_vio_ahb_arbi", "hclk_vio_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(13), 7, GFLAGS),
+	GATE(0, "hclk_vio_noc", "hclk_vio_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(13), 8, GFLAGS),
+	GATE(0, "hclk_vop_noc", "hclk_vio_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(13), 13, GFLAGS),
 	GATE(HCLK_VIO_H2P, "hclk_vio_h2p", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 7, GFLAGS),
 	GATE(HCLK_HDCP_MMU, "hclk_hdcp_mmu", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 12, GFLAGS),
 	GATE(PCLK_HDMI_CTRL, "pclk_hdmi_ctrl", "hclk_vio_pre", 0, RK2928_CLKGATE_CON(14), 6, GFLAGS),
@@ -561,29 +566,30 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 2, GFLAGS),
 	GATE(HCLK_NANDC, "hclk_nandc", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 3, GFLAGS),
 	GATE(HCLK_HOST0, "hclk_host0", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 6, GFLAGS),
-	GATE(0, "hclk_host0_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 7, GFLAGS),
+	GATE(0, "hclk_host0_arb", "hclk_peri", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(11), 7, GFLAGS),
 	GATE(HCLK_HOST1, "hclk_host1", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 8, GFLAGS),
-	GATE(0, "hclk_host1_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 9, GFLAGS),
+	GATE(0, "hclk_host1_arb", "hclk_peri", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(11), 9, GFLAGS),
 	GATE(HCLK_HOST2, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 10, GFLAGS),
 	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 12, GFLAGS),
-	GATE(0, "hclk_otg_pmu", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 13, GFLAGS),
-	GATE(0, "hclk_host2_arb", "hclk_peri", 0, RK2928_CLKGATE_CON(11), 14, GFLAGS),
+	GATE(0, "hclk_otg_pmu", "hclk_peri", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(11), 13, GFLAGS),
+	GATE(0, "hclk_host2_arb", "hclk_peri", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(11), 14, GFLAGS),
 	GATE(0, "hclk_peri_noc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 1, GFLAGS),
 
 	GATE(PCLK_GMAC, "pclk_gmac", "pclk_peri", 0, RK2928_CLKGATE_CON(11), 5, GFLAGS),
-	GATE(0, "pclk_peri_noc", "pclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(12), 2, GFLAGS),
+	GATE(0, "pclk_peri_noc", "pclk_peri", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(12), 2, GFLAGS),
 
 	/* PD_GPU */
 	GATE(ACLK_GPU, "aclk_gpu", "aclk_gpu_pre", 0, RK2928_CLKGATE_CON(7), 14, GFLAGS),
-	GATE(0, "aclk_gpu_noc", "aclk_gpu_pre", 0, RK2928_CLKGATE_CON(7), 15, GFLAGS),
+	GATE(0, "aclk_gpu_noc", "aclk_gpu_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(7), 15, GFLAGS),
 
 	/* PD_BUS */
-	GATE(0, "sclk_initmem_mbist", "aclk_cpu", 0, RK2928_CLKGATE_CON(8), 1, GFLAGS),
-	GATE(0, "aclk_initmem", "aclk_cpu", 0, RK2928_CLKGATE_CON(8), 0, GFLAGS),
+	GATE(0, "sclk_initmem_mbist", "aclk_cpu", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(8), 1, GFLAGS),
+	GATE(0, "aclk_initmem", "aclk_cpu", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(8), 0, GFLAGS),
 	GATE(ACLK_DMAC, "aclk_dmac_bus", "aclk_cpu", 0, RK2928_CLKGATE_CON(8), 2, GFLAGS),
 	GATE(0, "aclk_bus_noc", "aclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 1, GFLAGS),
 
-	GATE(0, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 3, GFLAGS),
+	GATE(0, "hclk_rom", "hclk_cpu", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(8), 3, GFLAGS),
 	GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 7, GFLAGS),
 	GATE(HCLK_I2S1_8CH, "hclk_i2s1_8ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 8, GFLAGS),
 	GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 9, GFLAGS),
@@ -592,9 +598,10 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	GATE(HCLK_M_CRYPTO, "hclk_crypto_mst", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
 	GATE(HCLK_S_CRYPTO, "hclk_crypto_slv", "hclk_cpu", 0, RK2928_CLKGATE_CON(8), 12, GFLAGS),
 
-	GATE(0, "pclk_ddrupctl", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(8), 4, GFLAGS),
-	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(8), 6, GFLAGS),
-	GATE(0, "pclk_msch_noc", "pclk_ddr_pre", 0, RK2928_CLKGATE_CON(10), 2, GFLAGS),
+	GATE(0, "pclk_ddrupctl", "pclk_ddr_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(8), 4, GFLAGS),
+	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(8), 6, GFLAGS),
+	GATE(0, "pclk_msch_noc", "pclk_ddr_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(10), 2, GFLAGS),
 
 	GATE(PCLK_EFUSE_1024, "pclk_efuse_1024", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
 	GATE(PCLK_EFUSE_256, "pclk_efuse_256", "pclk_cpu", 0, RK2928_CLKGATE_CON(8), 14, GFLAGS),
@@ -603,7 +610,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 1, GFLAGS),
 	GATE(PCLK_I2C3, "pclk_i2c3", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 2, GFLAGS),
 	GATE(PCLK_TIMER, "pclk_timer0", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 4, GFLAGS),
-	GATE(0, "pclk_stimer", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 5, GFLAGS),
+	GATE(0, "pclk_stimer", "pclk_cpu", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(9), 5, GFLAGS),
 	GATE(PCLK_SPI0, "pclk_spi0", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 6, GFLAGS),
 	GATE(PCLK_PWM, "pclk_rk_pwm", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 7, GFLAGS),
 	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 8, GFLAGS),
@@ -619,20 +626,24 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	GATE(0, "pclk_sgrf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 2, GFLAGS),
 	GATE(0, "pclk_sim", "pclk_cpu", 0, RK2928_CLKGATE_CON(10), 3, GFLAGS),
 
-	GATE(0, "pclk_ddrphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 3, GFLAGS),
-	GATE(0, "pclk_acodecphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 5, GFLAGS),
+	GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(10), 3, GFLAGS),
+	GATE(0, "pclk_acodecphy", "pclk_phy_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(10), 5, GFLAGS),
 	GATE(PCLK_HDMI_PHY, "pclk_hdmiphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 7, GFLAGS),
-	GATE(0, "pclk_vdacphy", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 8, GFLAGS),
-	GATE(0, "pclk_phy_noc", "pclk_phy_pre", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
+	GATE(0, "pclk_vdacphy", "pclk_phy_pre", CLK_IGNORE_UNUSED,
+			RK2928_CLKGATE_CON(10), 8, GFLAGS),
+	GATE(0, "pclk_phy_noc", "pclk_phy_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 
 	GATE(ACLK_VPU, "aclk_vpu", "aclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 0, GFLAGS),
-	GATE(0, "aclk_vpu_noc", "aclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 4, GFLAGS),
+	GATE(0, "aclk_vpu_noc", "aclk_vpu_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(15), 4, GFLAGS),
 	GATE(ACLK_RKVDEC, "aclk_rkvdec", "aclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 2, GFLAGS),
-	GATE(0, "aclk_rkvdec_noc", "aclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 6, GFLAGS),
+	GATE(0, "aclk_rkvdec_noc", "aclk_rkvdec_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(15), 6, GFLAGS),
 	GATE(HCLK_VPU, "hclk_vpu", "hclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 1, GFLAGS),
-	GATE(0, "hclk_vpu_noc", "hclk_vpu_pre", 0, RK2928_CLKGATE_CON(15), 5, GFLAGS),
+	GATE(0, "hclk_vpu_noc", "hclk_vpu_pre", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(15), 5, GFLAGS),
 	GATE(HCLK_RKVDEC, "hclk_rkvdec", "hclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 3, GFLAGS),
-	GATE(0, "hclk_rkvdec_noc", "hclk_rkvdec_pre", 0, RK2928_CLKGATE_CON(15), 7, GFLAGS),
+	GATE(0, "hclk_rkvdec_noc", "hclk_rkvdec_pre", CLK_IS_CRITICAL,
+			RK2928_CLKGATE_CON(15), 7, GFLAGS),
 
 	/* PD_MMC */
 	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RK3228_SDMMC_CON0, 1),
@@ -645,41 +656,6 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	MMC(SCLK_EMMC_SAMPLE,  "emmc_sample",  "sclk_emmc",  RK3228_EMMC_CON1,  0),
 };
 
-static const char *const rk3228_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"pclk_cpu",
-	"hclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_peri",
-	"aclk_rga_noc",
-	"aclk_iep_noc",
-	"aclk_vop_noc",
-	"aclk_hdcp_noc",
-	"hclk_vio_ahb_arbi",
-	"hclk_vio_noc",
-	"hclk_vop_noc",
-	"hclk_host0_arb",
-	"hclk_host1_arb",
-	"hclk_host2_arb",
-	"hclk_otg_pmu",
-	"aclk_gpu_noc",
-	"sclk_initmem_mbist",
-	"aclk_initmem",
-	"hclk_rom",
-	"pclk_ddrupctl",
-	"pclk_ddrmon",
-	"pclk_msch_noc",
-	"pclk_stimer",
-	"pclk_ddrphy",
-	"pclk_acodecphy",
-	"pclk_phy_noc",
-	"aclk_vpu_noc",
-	"aclk_rkvdec_noc",
-	"hclk_vpu_noc",
-	"hclk_rkvdec_noc",
-};
-
 static void __init rk3228_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -703,8 +679,6 @@ static void __init rk3228_clk_init(struct device_node *np)
 				   RK3228_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3228_clk_branches,
 				  ARRAY_SIZE(rk3228_clk_branches));
-	rockchip_clk_protect_critical(rk3228_critical_clocks,
-				      ARRAY_SIZE(rk3228_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index baa5aebd3277..89db93c46403 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -331,20 +331,20 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 			RK3288_CLKSEL_CON(26), 2, 1, MFLAGS, 0, 2,
 					DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
 
-	GATE(0, "gpll_aclk_cpu", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_cpu", "gpll", CLK_IS_CRITICAL,
 			RK3288_CLKGATE_CON(0), 10, GFLAGS),
-	GATE(0, "cpll_aclk_cpu", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_cpu", "cpll", CLK_IS_CRITICAL,
 			RK3288_CLKGATE_CON(0), 11, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(1), 15, 1, MFLAGS, 3, 5, DFLAGS),
 	DIV(0, "aclk_cpu_pre", "aclk_cpu_src", CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(1), 0, 3, DFLAGS),
-	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", CLK_IS_CRITICAL,
 			RK3288_CLKGATE_CON(0), 3, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_pre", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(1), 12, 3, DFLAGS,
 			RK3288_CLKGATE_CON(0), 5, GFLAGS),
-	COMPOSITE_NOMUX_DIVTBL(HCLK_CPU, "hclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX_DIVTBL(HCLK_CPU, "hclk_cpu", "aclk_cpu_pre", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(1), 8, 2, DFLAGS, div_hclk_cpu_t,
 			RK3288_CLKGATE_CON(0), 4, GFLAGS),
 	GATE(0, "c2c_host", "aclk_cpu_src", 0,
@@ -487,9 +487,9 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE_NOGATE(SCLK_VIP_OUT, "sclk_vip_out", mux_vip_out_p, 0,
 			RK3288_CLKSEL_CON(26), 15, 1, MFLAGS, 9, 5, DFLAGS),
 
-	DIV(0, "pclk_pd_alive", "gpll", 0,
+	DIV(0, "pclk_pd_alive", "gpll", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(33), 8, 5, DFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(33), 0, 5, DFLAGS,
 			RK3288_CLKGATE_CON(5), 8, GFLAGS),
 
@@ -497,16 +497,16 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 			RK3288_CLKSEL_CON(34), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3288_CLKGATE_CON(5), 7, GFLAGS),
 
-	COMPOSITE(0, "aclk_peri_src", mux_pll_src_cpll_gpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "aclk_peri_src", mux_pll_src_cpll_gpll_p, CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(10), 15, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3288_CLKGATE_CON(2), 0, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3288_CLKGATE_CON(2), 3, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3288_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3288_CLKGATE_CON(2), 1, GFLAGS),
 
 	/*
@@ -666,7 +666,8 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(0, "sclk_intmem0", "aclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(10), 5, GFLAGS),
 	GATE(0, "sclk_intmem1", "aclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(10), 6, GFLAGS),
 	GATE(0, "sclk_intmem2", "aclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(10), 7, GFLAGS),
-	GATE(ACLK_DMAC1, "aclk_dmac1", "aclk_cpu", 0, RK3288_CLKGATE_CON(10), 12, GFLAGS),
+	GATE(ACLK_DMAC1, "aclk_dmac1", "aclk_cpu", CLK_IS_CRITICAL,
+			RK3288_CLKGATE_CON(10), 12, GFLAGS),
 	GATE(0, "aclk_strc_sys", "aclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(10), 13, GFLAGS),
 	GATE(0, "aclk_intmem", "aclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(10), 4, GFLAGS),
 	GATE(ACLK_CRYPTO, "aclk_crypto", "aclk_cpu", 0, RK3288_CLKGATE_CON(11), 6, GFLAGS),
@@ -692,7 +693,8 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 3, GFLAGS),
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 9, GFLAGS),
 	GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 10, GFLAGS),
-	GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 11, GFLAGS),
+	GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IS_CRITICAL,
+			RK3288_CLKGATE_CON(11), 11, GFLAGS),
 
 	/* ddrctrl [DDR Controller PHY clock] gates */
 	GATE(0, "nclk_ddrupctl0", "ddrphy", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 4, GFLAGS),
@@ -728,7 +730,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(HCLK_SDIO1, "hclk_sdio1", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 5, GFLAGS),
 	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 6, GFLAGS),
 	GATE(HCLK_HSADC, "hclk_hsadc", "hclk_peri", 0, RK3288_CLKGATE_CON(8), 7, GFLAGS),
-	GATE(0, "pmu_hclk_otg0", "hclk_peri", 0, RK3288_CLKGATE_CON(7), 5, GFLAGS),
+	GATE(0, "pmu_hclk_otg0", "hclk_peri", CLK_IS_CRITICAL, RK3288_CLKGATE_CON(7), 5, GFLAGS),
 
 	/* pclk_peri gates */
 	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(6), 1, GFLAGS),
@@ -768,7 +770,8 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(PCLK_GPIO5, "pclk_gpio5", "pclk_pd_alive", 0, RK3288_CLKGATE_CON(14), 5, GFLAGS),
 	GATE(PCLK_GPIO6, "pclk_gpio6", "pclk_pd_alive", 0, RK3288_CLKGATE_CON(14), 6, GFLAGS),
 	GATE(PCLK_GRF, "pclk_grf", "pclk_pd_alive", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(14), 11, GFLAGS),
-	GATE(0, "pclk_alive_niu", "pclk_pd_alive", 0, RK3288_CLKGATE_CON(14), 12, GFLAGS),
+	GATE(0, "pclk_alive_niu", "pclk_pd_alive", CLK_IS_CRITICAL,
+			RK3288_CLKGATE_CON(14), 12, GFLAGS),
 
 	/* Watchdog pclk is controlled by RK3288_SGRF_SOC_CON0[1]. */
 	SGRF_GATE(PCLK_WDT, "pclk_wdt", "pclk_pd_alive"),
@@ -776,7 +779,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	/* pclk_pd_pmu gates */
 	GATE(PCLK_PMU, "pclk_pmu", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 0, GFLAGS),
 	GATE(0, "pclk_intmem1", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 1, GFLAGS),
-	GATE(0, "pclk_pmu_niu", "pclk_pd_pmu", 0, RK3288_CLKGATE_CON(17), 2, GFLAGS),
+	GATE(0, "pclk_pmu_niu", "pclk_pd_pmu", CLK_IS_CRITICAL, RK3288_CLKGATE_CON(17), 2, GFLAGS),
 	GATE(PCLK_SGRF, "pclk_sgrf", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 3, GFLAGS),
 	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_pd_pmu", 0, RK3288_CLKGATE_CON(17), 4, GFLAGS),
 
@@ -785,7 +788,8 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(HCLK_VOP0, "hclk_vop0", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 6, GFLAGS),
 	GATE(HCLK_VOP1, "hclk_vop1", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 8, GFLAGS),
 	GATE(HCLK_VIO_AHB_ARBI, "hclk_vio_ahb_arbi", "hclk_vio", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(15), 9, GFLAGS),
-	GATE(HCLK_VIO_NIU, "hclk_vio_niu", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 10, GFLAGS),
+	GATE(HCLK_VIO_NIU, "hclk_vio_niu", "hclk_vio", CLK_IS_CRITICAL,
+			RK3288_CLKGATE_CON(15), 10, GFLAGS),
 	GATE(HCLK_VIP, "hclk_vip", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 15, GFLAGS),
 	GATE(HCLK_IEP, "hclk_iep", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 3, GFLAGS),
 	GATE(HCLK_ISP, "hclk_isp", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 1, GFLAGS),
@@ -801,17 +805,20 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	/* aclk_vio0 gates */
 	GATE(ACLK_VOP0, "aclk_vop0", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 5, GFLAGS),
 	GATE(ACLK_IEP, "aclk_iep", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 2, GFLAGS),
-	GATE(ACLK_VIO0_NIU, "aclk_vio0_niu", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 11, GFLAGS),
+	GATE(ACLK_VIO0_NIU, "aclk_vio0_niu", "aclk_vio0", CLK_IS_CRITICAL,
+			RK3288_CLKGATE_CON(15), 11, GFLAGS),
 	GATE(ACLK_VIP, "aclk_vip", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 14, GFLAGS),
 
 	/* aclk_vio1 gates */
 	GATE(ACLK_VOP1, "aclk_vop1", "aclk_vio1", 0, RK3288_CLKGATE_CON(15), 7, GFLAGS),
 	GATE(ACLK_ISP, "aclk_isp", "aclk_vio1", 0, RK3288_CLKGATE_CON(16), 2, GFLAGS),
-	GATE(ACLK_VIO1_NIU, "aclk_vio1_niu", "aclk_vio1", 0, RK3288_CLKGATE_CON(15), 12, GFLAGS),
+	GATE(ACLK_VIO1_NIU, "aclk_vio1_niu", "aclk_vio1", CLK_IS_CRITICAL,
+			RK3288_CLKGATE_CON(15), 12, GFLAGS),
 
 	/* aclk_rga_pre gates */
 	GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0, RK3288_CLKGATE_CON(15), 0, GFLAGS),
-	GATE(ACLK_RGA_NIU, "aclk_rga_niu", "aclk_rga_pre", 0, RK3288_CLKGATE_CON(15), 13, GFLAGS),
+	GATE(ACLK_RGA_NIU, "aclk_rga_niu", "aclk_rga_pre", CLK_IS_CRITICAL,
+			RK3288_CLKGATE_CON(15), 13, GFLAGS),
 
 	/*
 	 * Other ungrouped clocks.
@@ -833,23 +840,6 @@ static struct rockchip_clk_branch rk3288_hclkvio_branch[] __initdata = {
 			RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
 };
 
-static const char *const rk3288_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"aclk_peri",
-	"aclk_peri_niu",
-	"aclk_vio0_niu",
-	"aclk_vio1_niu",
-	"aclk_rga_niu",
-	"hclk_peri",
-	"hclk_vio_niu",
-	"pclk_alive_niu",
-	"pclk_pd_pmu",
-	"pclk_pmu_niu",
-	"pmu_hclk_otg0",
-	/* pwm-regulators on some boards, so handoff-critical later */
-	"pclk_rkpwm",
-};
-
 static void __iomem *rk3288_cru_base;
 
 /*
@@ -959,9 +949,6 @@ static void __init rk3288_common_init(struct device_node *np,
 		rockchip_clk_register_branches(ctx, rk3288_hclkvio_branch,
 					       ARRAY_SIZE(rk3288_hclkvio_branch));
 
-	rockchip_clk_protect_critical(rk3288_critical_clocks,
-				      ARRAY_SIZE(rk3288_critical_clocks));
-
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 			&rk3288_cpuclk_data, rk3288_cpuclk_rates,
diff --git a/drivers/clk/rockchip/clk-rk3308.c b/drivers/clk/rockchip/clk-rk3308.c
index db3396c3e6e9..16a4dbd74146 100644
--- a/drivers/clk/rockchip/clk-rk3308.c
+++ b/drivers/clk/rockchip/clk-rk3308.c
@@ -312,18 +312,18 @@ static struct rockchip_clk_branch rk3308_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 3
 	 */
 
-	COMPOSITE_NODIV(ACLK_BUS_SRC, "clk_bus_src", mux_dpll_vpll0_vpll1_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NODIV(ACLK_BUS_SRC, "clk_bus_src", mux_dpll_vpll0_vpll1_p, CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(5), 6, 2, MFLAGS,
 			RK3308_CLKGATE_CON(1), 0, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_BUS, "pclk_bus", "clk_bus_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_BUS, "pclk_bus", "clk_bus_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(6), 8, 5, DFLAGS,
 			RK3308_CLKGATE_CON(1), 3, GFLAGS),
 	GATE(PCLK_DDR, "pclk_ddr", "pclk_bus", CLK_IGNORE_UNUSED,
 			RK3308_CLKGATE_CON(4), 15, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus", "clk_bus_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus", "clk_bus_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(6), 0, 5, DFLAGS,
 			RK3308_CLKGATE_CON(1), 2, GFLAGS),
-	COMPOSITE_NOMUX(ACLK_BUS, "aclk_bus", "clk_bus_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(ACLK_BUS, "aclk_bus", "clk_bus_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(5), 0, 5, DFLAGS,
 			RK3308_CLKGATE_CON(1), 1, GFLAGS),
 
@@ -461,16 +461,16 @@ static struct rockchip_clk_branch rk3308_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 4
 	 */
 
-	COMPOSITE_NODIV(ACLK_PERI_SRC, "clk_peri_src", mux_dpll_vpll0_vpll1_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NODIV(ACLK_PERI_SRC, "clk_peri_src", mux_dpll_vpll0_vpll1_p, CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(36), 6, 2, MFLAGS,
 			RK3308_CLKGATE_CON(8), 0, GFLAGS),
-	COMPOSITE_NOMUX(ACLK_PERI, "aclk_peri", "clk_peri_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(ACLK_PERI, "aclk_peri", "clk_peri_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(36), 0, 5, DFLAGS,
 			RK3308_CLKGATE_CON(8), 1, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "clk_peri_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "clk_peri_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(37), 0, 5, DFLAGS,
 			RK3308_CLKGATE_CON(8), 2, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "clk_peri_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "clk_peri_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(37), 8, 5, DFLAGS,
 			RK3308_CLKGATE_CON(8), 3, GFLAGS),
 
@@ -561,10 +561,10 @@ static struct rockchip_clk_branch rk3308_clk_branches[] __initdata = {
 	GATE(0, "clk_ddr_msch_peribus", "clk_ddrphy1x_out", CLK_IGNORE_UNUSED,
 			RK3308_CLKGATE_CON(4), 13, GFLAGS),
 
-	COMPOSITE(SCLK_DDRCLK, "clk_ddrphy4x_src", mux_dpll_vpll0_vpll1_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(SCLK_DDRCLK, "clk_ddrphy4x_src", mux_dpll_vpll0_vpll1_p, CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(1), 6, 2, MFLAGS, 0, 3, DFLAGS,
 			RK3308_CLKGATE_CON(0), 10, GFLAGS),
-	GATE(0, "clk_ddrphy4x", "clk_ddrphy4x_src", CLK_IGNORE_UNUSED,
+	GATE(0, "clk_ddrphy4x", "clk_ddrphy4x_src", CLK_IS_CRITICAL,
 			RK3308_CLKGATE_CON(0), 11, GFLAGS),
 	FACTOR_GATE(0, "clk_ddr_stdby_div4", "clk_ddrphy4x", CLK_IGNORE_UNUSED, 1, 4,
 			RK3308_CLKGATE_CON(0), 13, GFLAGS),
@@ -618,13 +618,13 @@ static struct rockchip_clk_branch rk3308_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 7
 	 */
 
-	COMPOSITE_NODIV(0, "clk_audio_src", mux_vpll0_vpll1_xin24m_p, 0,
+	COMPOSITE_NODIV(0, "clk_audio_src", mux_vpll0_vpll1_xin24m_p, CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(45), 6, 2, MFLAGS,
 			RK3308_CLKGATE_CON(10), 0, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_AUDIO, "hclk_audio", "clk_audio_src", 0,
+	COMPOSITE_NOMUX(HCLK_AUDIO, "hclk_audio", "clk_audio_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(45), 0, 5, DFLAGS,
 			RK3308_CLKGATE_CON(10), 1, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_AUDIO, "pclk_audio", "clk_audio_src", 0,
+	COMPOSITE_NOMUX(PCLK_AUDIO, "pclk_audio", "clk_audio_src", CLK_IS_CRITICAL,
 			RK3308_CLKSEL_CON(45), 8, 5, DFLAGS,
 			RK3308_CLKGATE_CON(10), 2, GFLAGS),
 
@@ -901,19 +901,6 @@ static struct rockchip_clk_branch rk3308_clk_branches[] __initdata = {
 	GATE(PCLK_OWIRE, "pclk_owire", "pclk_bus", CLK_IGNORE_UNUSED, RK3308_CLKGATE_CON(7), 15, GFLAGS),
 };
 
-static const char *const rk3308_critical_clocks[] __initconst = {
-	"aclk_bus",
-	"hclk_bus",
-	"pclk_bus",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_peri",
-	"hclk_audio",
-	"pclk_audio",
-	"sclk_ddrc",
-	"clk_ddrphy4x",
-};
-
 static void __init rk3308_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -937,8 +924,6 @@ static void __init rk3308_clk_init(struct device_node *np)
 				   RK3308_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3308_clk_branches,
 				       ARRAY_SIZE(rk3308_clk_branches));
-	rockchip_clk_protect_critical(rk3308_critical_clocks,
-				      ARRAY_SIZE(rk3308_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 267ab54937d3..a8686db20f0a 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -291,18 +291,18 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKGATE_CON(0), 1, GFLAGS),
 	GATE(0, "npll_core", "npll", CLK_IGNORE_UNUSED,
 			RK3328_CLKGATE_CON(0), 12, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_dbg", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_dbg", "armclk", CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(1), 0, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3328_CLKGATE_CON(7), 0, GFLAGS),
-	COMPOSITE_NOMUX(0, "aclk_core", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "aclk_core", "armclk", CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(1), 4, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3328_CLKGATE_CON(7), 1, GFLAGS),
-	GATE(0, "aclk_core_niu", "aclk_core", 0,
+	GATE(0, "aclk_core_niu", "aclk_core", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(13), 0, GFLAGS),
-	GATE(0, "aclk_gic400", "aclk_core", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_gic400", "aclk_core", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(13), 1, GFLAGS),
 
-	GATE(0, "clk_jtag", "jtag_clkin", CLK_IGNORE_UNUSED,
+	GATE(0, "clk_jtag", "jtag_clkin", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(7), 2, GFLAGS),
 
 	/* PD_GPU */
@@ -311,34 +311,34 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKGATE_CON(6), 6, GFLAGS),
 	GATE(ACLK_GPU, "aclk_gpu", "aclk_gpu_pre", CLK_SET_RATE_PARENT,
 			RK3328_CLKGATE_CON(14), 0, GFLAGS),
-	GATE(0, "aclk_gpu_niu", "aclk_gpu_pre", 0,
+	GATE(0, "aclk_gpu_niu", "aclk_gpu_pre", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(14), 1, GFLAGS),
 
 	/* PD_DDR */
-	COMPOSITE(0, "clk_ddr", mux_ddrphy_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "clk_ddr", mux_ddrphy_p, CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(3), 8, 2, MFLAGS, 0, 3, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3328_CLKGATE_CON(0), 4, GFLAGS),
-	GATE(0, "clk_ddrmsch", "clk_ddr", CLK_IGNORE_UNUSED,
+	GATE(0, "clk_ddrmsch", "clk_ddr", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(18), 6, GFLAGS),
-	GATE(0, "clk_ddrupctl", "clk_ddr", CLK_IGNORE_UNUSED,
+	GATE(0, "clk_ddrupctl", "clk_ddr", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(18), 5, GFLAGS),
 	GATE(0, "aclk_ddrupctl", "clk_ddr", CLK_IGNORE_UNUSED,
 			RK3328_CLKGATE_CON(18), 4, GFLAGS),
 	GATE(0, "clk_ddrmon", "xin24m", CLK_IGNORE_UNUSED,
 			RK3328_CLKGATE_CON(0), 6, GFLAGS),
 
-	COMPOSITE(PCLK_DDR, "pclk_ddr", mux_2plls_hdmiphy_p, 0,
+	COMPOSITE(PCLK_DDR, "pclk_ddr", mux_2plls_hdmiphy_p, CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(4), 13, 2, MFLAGS, 8, 3, DFLAGS,
 			RK3328_CLKGATE_CON(7), 4, GFLAGS),
-	GATE(0, "pclk_ddrupctl", "pclk_ddr", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddrupctl", "pclk_ddr", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(18), 1, GFLAGS),
-	GATE(0, "pclk_ddr_msch", "pclk_ddr", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddr_msch", "pclk_ddr", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(18), 2, GFLAGS),
-	GATE(0, "pclk_ddr_mon", "pclk_ddr", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddr_mon", "pclk_ddr", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(18), 3, GFLAGS),
 	GATE(0, "pclk_ddrstdby", "pclk_ddr", CLK_IGNORE_UNUSED,
 			RK3328_CLKGATE_CON(18), 7, GFLAGS),
-	GATE(0, "pclk_ddr_grf", "pclk_ddr", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddr_grf", "pclk_ddr", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(18), 9, GFLAGS),
 
 	/*
@@ -346,18 +346,18 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	 */
 
 	/* PD_BUS */
-	COMPOSITE(ACLK_BUS_PRE, "aclk_bus_pre", mux_2plls_hdmiphy_p, 0,
+	COMPOSITE(ACLK_BUS_PRE, "aclk_bus_pre", mux_2plls_hdmiphy_p, CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(0), 13, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3328_CLKGATE_CON(8), 0, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_BUS_PRE, "hclk_bus_pre", "aclk_bus_pre", 0,
+	COMPOSITE_NOMUX(HCLK_BUS_PRE, "hclk_bus_pre", "aclk_bus_pre", CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(1), 8, 2, DFLAGS,
 			RK3328_CLKGATE_CON(8), 1, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_BUS_PRE, "pclk_bus_pre", "aclk_bus_pre", 0,
+	COMPOSITE_NOMUX(PCLK_BUS_PRE, "pclk_bus_pre", "aclk_bus_pre", CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(1), 12, 3, DFLAGS,
 			RK3328_CLKGATE_CON(8), 2, GFLAGS),
-	GATE(0, "pclk_bus", "pclk_bus_pre", 0,
+	GATE(0, "pclk_bus", "pclk_bus_pre", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(8), 3, GFLAGS),
-	GATE(0, "pclk_phy_pre", "pclk_bus_pre", 0,
+	GATE(0, "pclk_phy_pre", "pclk_bus_pre", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(8), 4, GFLAGS),
 
 	COMPOSITE(SCLK_TSP, "clk_tsp", mux_2plls_p, 0,
@@ -506,9 +506,9 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKGATE_CON(24), 0, GFLAGS),
 	GATE(HCLK_RKVDEC, "hclk_rkvdec", "hclk_rkvdec_pre", CLK_SET_RATE_PARENT,
 			RK3328_CLKGATE_CON(24), 1, GFLAGS),
-	GATE(0, "aclk_rkvdec_niu", "aclk_rkvdec_pre", 0,
+	GATE(0, "aclk_rkvdec_niu", "aclk_rkvdec_pre", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(24), 2, GFLAGS),
-	GATE(0, "hclk_rkvdec_niu", "hclk_rkvdec_pre", 0,
+	GATE(0, "hclk_rkvdec_niu", "hclk_rkvdec_pre", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(24), 3, GFLAGS),
 
 	COMPOSITE(SCLK_VDEC_CABAC, "sclk_vdec_cabac", mux_4plls_p, 0,
@@ -528,9 +528,9 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKGATE_CON(23), 0, GFLAGS),
 	GATE(HCLK_VPU, "hclk_vpu", "hclk_vpu_pre", CLK_SET_RATE_PARENT,
 			RK3328_CLKGATE_CON(23), 1, GFLAGS),
-	GATE(0, "aclk_vpu_niu", "aclk_vpu_pre", 0,
+	GATE(0, "aclk_vpu_niu", "aclk_vpu_pre", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(23), 2, GFLAGS),
-	GATE(0, "hclk_vpu_niu", "hclk_vpu_pre", 0,
+	GATE(0, "hclk_vpu_niu", "hclk_vpu_pre", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(23), 3, GFLAGS),
 
 	COMPOSITE(ACLK_RKVENC, "aclk_rkvenc", mux_4plls_p, 0,
@@ -538,9 +538,10 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKGATE_CON(6), 3, GFLAGS),
 	FACTOR_GATE(HCLK_RKVENC, "hclk_rkvenc", "aclk_rkvenc", 0, 1, 4,
 			RK3328_CLKGATE_CON(11), 4, GFLAGS),
-	GATE(0, "aclk_rkvenc_niu", "aclk_rkvenc", 0,
+
+	GATE(0, "aclk_rkvenc_niu", "sclk_venc_core", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(25), 0, GFLAGS),
-	GATE(0, "hclk_rkvenc_niu", "hclk_rkvenc", 0,
+	GATE(0, "hclk_rkvenc_niu", "hclk_venc", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(25), 1, GFLAGS),
 	GATE(ACLK_H265, "aclk_h265", "aclk_rkvenc", 0,
 			RK3328_CLKGATE_CON(25), 2, GFLAGS),
@@ -603,21 +604,21 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	 */
 
 	/* PD_PERI */
-	GATE(0, "gpll_peri", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_peri", "gpll", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(4), 0, GFLAGS),
-	GATE(0, "cpll_peri", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_peri", "cpll", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(4), 1, GFLAGS),
-	GATE(0, "hdmiphy_peri", "hdmiphy", CLK_IGNORE_UNUSED,
+	GATE(0, "hdmiphy_peri", "hdmiphy", CLK_IS_CRITICAL,
 			RK3328_CLKGATE_CON(4), 2, GFLAGS),
-	COMPOSITE_NOGATE(ACLK_PERI_PRE, "aclk_peri_pre", mux_aclk_peri_pre_p, 0,
+	COMPOSITE_NOGATE(ACLK_PERI_PRE, "aclk_peri_pre", mux_aclk_peri_pre_p, CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(28), 6, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_pre", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(29), 0, 2, DFLAGS,
 			RK3328_CLKGATE_CON(10), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_pre", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK3328_CLKSEL_CON(29), 4, 3, DFLAGS,
 			RK3328_CLKGATE_CON(10), 1, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_pre", CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
 			RK3328_CLKGATE_CON(10), 0, GFLAGS),
 
 	COMPOSITE(SCLK_SDMMC, "clk_sdmmc", mux_2plls_24m_u480m_p, 0,
@@ -702,30 +703,33 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 
 	/* PD_VOP */
 	GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0, RK3328_CLKGATE_CON(21), 10, GFLAGS),
-	GATE(0, "aclk_rga_niu", "aclk_rga_pre", 0, RK3328_CLKGATE_CON(22), 3, GFLAGS),
+	GATE(0, "aclk_rga_niu", "aclk_rga_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(22), 3, GFLAGS),
 	GATE(ACLK_VOP, "aclk_vop", "aclk_vop_pre", 0, RK3328_CLKGATE_CON(21), 2, GFLAGS),
-	GATE(0, "aclk_vop_niu", "aclk_vop_pre", 0, RK3328_CLKGATE_CON(21), 4, GFLAGS),
+	GATE(0, "aclk_vop_niu", "aclk_vop_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(21), 4, GFLAGS),
 
 	GATE(ACLK_IEP, "aclk_iep", "aclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 6, GFLAGS),
 	GATE(ACLK_CIF, "aclk_cif", "aclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 8, GFLAGS),
 	GATE(ACLK_HDCP, "aclk_hdcp", "aclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 15, GFLAGS),
-	GATE(0, "aclk_vio_niu", "aclk_vio_pre", 0, RK3328_CLKGATE_CON(22), 2, GFLAGS),
+	GATE(0, "aclk_vio_niu", "aclk_vio_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(22), 2, GFLAGS),
 
 	GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 3, GFLAGS),
-	GATE(0, "hclk_vop_niu", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 5, GFLAGS),
+	GATE(0, "hclk_vop_niu", "hclk_vio_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(21), 5, GFLAGS),
 	GATE(HCLK_IEP, "hclk_iep", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 7, GFLAGS),
 	GATE(HCLK_CIF, "hclk_cif", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 9, GFLAGS),
 	GATE(HCLK_RGA, "hclk_rga", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 11, GFLAGS),
-	GATE(0, "hclk_ahb1tom", "hclk_vio_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(21), 12, GFLAGS),
-	GATE(0, "pclk_vio_h2p", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 13, GFLAGS),
-	GATE(0, "hclk_vio_h2p", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21), 14, GFLAGS),
+	GATE(0, "hclk_ahb1tom", "hclk_vio_pre", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(21), 12, GFLAGS),
+	GATE(0, "pclk_vio_h2p", "hclk_vio_pre", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(21), 13, GFLAGS),
+	GATE(0, "hclk_vio_h2p", "hclk_vio_pre", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(21), 14, GFLAGS),
 	GATE(HCLK_HDCP, "hclk_hdcp", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(22), 0, GFLAGS),
-	GATE(0, "hclk_vio_niu", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(22), 1, GFLAGS),
+	GATE(0, "hclk_vio_niu", "hclk_vio_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(22), 1, GFLAGS),
 	GATE(PCLK_HDMI, "pclk_hdmi", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(22), 4, GFLAGS),
 	GATE(PCLK_HDCP, "pclk_hdcp", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(22), 5, GFLAGS),
 
 	/* PD_PERI */
-	GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(19), 11, GFLAGS),
+	GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(19), 11, GFLAGS),
 	GATE(ACLK_USB3OTG, "aclk_usb3otg", "aclk_peri", 0, RK3328_CLKGATE_CON(19), 14, GFLAGS),
 
 	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 0, GFLAGS),
@@ -735,26 +739,28 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(HCLK_HOST0, "hclk_host0", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 6, GFLAGS),
 	GATE(HCLK_HOST0_ARB, "hclk_host0_arb", "hclk_peri", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(19), 7, GFLAGS),
 	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 8, GFLAGS),
-	GATE(HCLK_OTG_PMU, "hclk_otg_pmu", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 9, GFLAGS),
-	GATE(0, "hclk_peri_niu", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 12, GFLAGS),
-	GATE(0, "pclk_peri_niu", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 13, GFLAGS),
+	GATE(HCLK_OTG_PMU, "hclk_otg_pmu", "hclk_peri", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(19), 9, GFLAGS),
+	GATE(0, "hclk_peri_niu", "hclk_peri", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(19), 12, GFLAGS),
+	GATE(0, "pclk_peri_niu", "hclk_peri", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(19), 13, GFLAGS),
 
 	/* PD_GMAC */
 	GATE(ACLK_MAC2PHY, "aclk_mac2phy", "aclk_gmac", 0, RK3328_CLKGATE_CON(26), 0, GFLAGS),
 	GATE(ACLK_MAC2IO, "aclk_mac2io", "aclk_gmac", 0, RK3328_CLKGATE_CON(26), 2, GFLAGS),
-	GATE(0, "aclk_gmac_niu", "aclk_gmac", 0, RK3328_CLKGATE_CON(26), 4, GFLAGS),
+	GATE(0, "aclk_gmac_niu", "aclk_gmac", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(26), 4, GFLAGS),
 	GATE(PCLK_MAC2PHY, "pclk_mac2phy", "pclk_gmac", 0, RK3328_CLKGATE_CON(26), 1, GFLAGS),
 	GATE(PCLK_MAC2IO, "pclk_mac2io", "pclk_gmac", 0, RK3328_CLKGATE_CON(26), 3, GFLAGS),
-	GATE(0, "pclk_gmac_niu", "pclk_gmac", 0, RK3328_CLKGATE_CON(26), 5, GFLAGS),
+	GATE(0, "pclk_gmac_niu", "pclk_gmac", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(26), 5, GFLAGS),
 
 	/* PD_BUS */
-	GATE(0, "aclk_bus_niu", "aclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 12, GFLAGS),
+	GATE(0, "aclk_bus_niu", "aclk_bus_pre", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(15), 12, GFLAGS),
 	GATE(ACLK_DCF, "aclk_dcf", "aclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 11, GFLAGS),
 	GATE(ACLK_TSP, "aclk_tsp", "aclk_bus_pre", 0, RK3328_CLKGATE_CON(17), 12, GFLAGS),
-	GATE(0, "aclk_intmem", "aclk_bus_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(15), 0, GFLAGS),
+	GATE(0, "aclk_intmem", "aclk_bus_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(15), 0, GFLAGS),
 	GATE(ACLK_DMAC, "aclk_dmac_bus", "aclk_bus_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(15), 1, GFLAGS),
 
-	GATE(0, "hclk_rom", "hclk_bus_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(15), 2, GFLAGS),
+	GATE(0, "hclk_rom", "hclk_bus_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(15), 2, GFLAGS),
 	GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 3, GFLAGS),
 	GATE(HCLK_I2S1_8CH, "hclk_i2s1_8ch", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 4, GFLAGS),
 	GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 5, GFLAGS),
@@ -762,17 +768,19 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(HCLK_TSP, "hclk_tsp", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(17), 11, GFLAGS),
 	GATE(HCLK_CRYPTO_MST, "hclk_crypto_mst", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 7, GFLAGS),
 	GATE(HCLK_CRYPTO_SLV, "hclk_crypto_slv", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 8, GFLAGS),
-	GATE(0, "hclk_bus_niu", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(15), 13, GFLAGS),
+	GATE(0, "hclk_bus_niu", "hclk_bus_pre", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(15), 13, GFLAGS),
 	GATE(HCLK_PDM, "hclk_pdm", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(28), 0, GFLAGS),
 
-	GATE(0, "pclk_bus_niu", "pclk_bus", 0, RK3328_CLKGATE_CON(15), 14, GFLAGS),
+	GATE(0, "pclk_bus_niu", "pclk_bus", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(15), 14, GFLAGS),
 	GATE(0, "pclk_efuse", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(15), 9, GFLAGS),
 	GATE(0, "pclk_otp", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(28), 4, GFLAGS),
 	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_bus", 0, RK3328_CLKGATE_CON(15), 10, GFLAGS),
 	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 0, GFLAGS),
 	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 1, GFLAGS),
 	GATE(PCLK_I2C3, "pclk_i2c3", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 2, GFLAGS),
-	GATE(PCLK_TIMER, "pclk_timer0", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 3, GFLAGS),
+	GATE(PCLK_TIMER, "pclk_timer0", "pclk_bus", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(16), 3, GFLAGS),
 	GATE(0, "pclk_stimer", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 4, GFLAGS),
 	GATE(PCLK_SPI, "pclk_spi", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 5, GFLAGS),
 	GATE(PCLK_PWM, "pclk_rk_pwm", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 6, GFLAGS),
@@ -785,12 +793,12 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 13, GFLAGS),
 	GATE(PCLK_TSADC, "pclk_tsadc", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 14, GFLAGS),
 	GATE(PCLK_DCF, "pclk_dcf", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 15, GFLAGS),
-	GATE(PCLK_GRF, "pclk_grf", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 0, GFLAGS),
-	GATE(0, "pclk_cru", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 4, GFLAGS),
-	GATE(0, "pclk_sgrf", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 6, GFLAGS),
+	GATE(PCLK_GRF, "pclk_grf", "pclk_bus", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(17), 0, GFLAGS),
+	GATE(0, "pclk_cru", "pclk_bus", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(17), 4, GFLAGS),
+	GATE(0, "pclk_sgrf", "pclk_bus", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(17), 6, GFLAGS),
 	GATE(0, "pclk_sim", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 10, GFLAGS),
 	GATE(PCLK_SARADC, "pclk_saradc", "pclk_bus", 0, RK3328_CLKGATE_CON(17), 15, GFLAGS),
-	GATE(0, "pclk_pmu", "pclk_bus", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(28), 3, GFLAGS),
+	GATE(0, "pclk_pmu", "pclk_bus", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(28), 3, GFLAGS),
 
 	/* Watchdog pclk is controlled from the secure GRF */
 	SGRF_GATE(PCLK_WDT, "pclk_wdt", "pclk_bus"),
@@ -799,11 +807,12 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(PCLK_USB3PHY_PIPE, "pclk_usb3phy_pipe", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(28), 2, GFLAGS),
 	GATE(PCLK_USB3_GRF, "pclk_usb3_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 2, GFLAGS),
 	GATE(PCLK_USB2_GRF, "pclk_usb2_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 14, GFLAGS),
-	GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 13, GFLAGS),
+	GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IS_CRITICAL, RK3328_CLKGATE_CON(17), 13, GFLAGS),
 	GATE(PCLK_ACODECPHY, "pclk_acodecphy", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(17), 5, GFLAGS),
 	GATE(PCLK_HDMIPHY, "pclk_hdmiphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 7, GFLAGS),
 	GATE(0, "pclk_vdacphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 8, GFLAGS),
-	GATE(0, "pclk_phy_niu", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(15), 15, GFLAGS),
+	GATE(0, "pclk_phy_niu", "pclk_phy_pre", CLK_IS_CRITICAL,
+			RK3328_CLKGATE_CON(15), 15, GFLAGS),
 
 	/* PD_MMC */
 	MMC(SCLK_SDMMC_DRV, "sdmmc_drv", "clk_sdmmc",
@@ -827,57 +836,6 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	    RK3328_SDMMC_EXT_CON1, 1),
 };
 
-static const char *const rk3328_critical_clocks[] __initconst = {
-	"aclk_bus",
-	"aclk_bus_niu",
-	"pclk_bus",
-	"pclk_bus_niu",
-	"hclk_bus",
-	"hclk_bus_niu",
-	"aclk_peri",
-	"hclk_peri",
-	"hclk_peri_niu",
-	"pclk_peri",
-	"pclk_peri_niu",
-	"pclk_dbg",
-	"aclk_core_niu",
-	"aclk_gic400",
-	"aclk_intmem",
-	"hclk_rom",
-	"pclk_grf",
-	"pclk_cru",
-	"pclk_sgrf",
-	"pclk_timer0",
-	"clk_timer0",
-	"pclk_ddr_msch",
-	"pclk_ddr_mon",
-	"pclk_ddr_grf",
-	"clk_ddrupctl",
-	"clk_ddrmsch",
-	"hclk_ahb1tom",
-	"clk_jtag",
-	"pclk_ddrphy",
-	"pclk_pmu",
-	"hclk_otg_pmu",
-	"aclk_rga_niu",
-	"pclk_vio_h2p",
-	"hclk_vio_h2p",
-	"aclk_vio_niu",
-	"hclk_vio_niu",
-	"aclk_vop_niu",
-	"hclk_vop_niu",
-	"aclk_gpu_niu",
-	"aclk_rkvdec_niu",
-	"hclk_rkvdec_niu",
-	"aclk_vpu_niu",
-	"hclk_vpu_niu",
-	"aclk_rkvenc_niu",
-	"hclk_rkvenc_niu",
-	"aclk_gmac_niu",
-	"pclk_gmac_niu",
-	"pclk_phy_niu",
-};
-
 static void __init rk3328_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -901,8 +859,6 @@ static void __init rk3328_clk_init(struct device_node *np)
 				   RK3328_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3328_clk_branches,
 				       ARRAY_SIZE(rk3328_clk_branches));
-	rockchip_clk_protect_critical(rk3328_critical_clocks,
-				      ARRAY_SIZE(rk3328_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 				     mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 2c50cc2cc6db..3594454e3f45 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -334,19 +334,19 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(0, "sclk_ddr4x", "ddrphy_src", CLK_IGNORE_UNUSED,
 			RK3368_CLKGATE_CON(6), 15, GFLAGS),
 
-	GATE(0, "gpll_aclk_bus", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_bus", "gpll", CLK_IS_CRITICAL,
 			RK3368_CLKGATE_CON(1), 10, GFLAGS),
-	GATE(0, "cpll_aclk_bus", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_bus", "cpll", CLK_IS_CRITICAL,
 			RK3368_CLKGATE_CON(1), 11, GFLAGS),
-	COMPOSITE_NOGATE(0, "aclk_bus_src", mux_aclk_bus_src_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(0, "aclk_bus_src", mux_aclk_bus_src_p, CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(8), 7, 1, MFLAGS, 0, 5, DFLAGS),
 
-	GATE(ACLK_BUS, "aclk_bus", "aclk_bus_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_BUS, "aclk_bus", "aclk_bus_src", CLK_IS_CRITICAL,
 			RK3368_CLKGATE_CON(1), 0, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_BUS, "pclk_bus", "aclk_bus_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_BUS, "pclk_bus", "aclk_bus_src", CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(8), 12, 3, DFLAGS,
 			RK3368_CLKGATE_CON(1), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus", "aclk_bus_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus", "aclk_bus_src", CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(8), 8, 2, DFLAGS,
 			RK3368_CLKGATE_CON(1), 1, GFLAGS),
 	COMPOSITE_NOMUX(0, "sclk_crypto", "aclk_bus_src", 0,
@@ -490,12 +490,12 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 			RK3368_CLKSEL_CON(55), 6, 2, MFLAGS, 0, 6, DFLAGS,
 			RK3368_CLKGATE_CON(5), 5, GFLAGS),
 
-	DIV(0, "pclk_pd_alive", "gpll", 0,
+	DIV(0, "pclk_pd_alive", "gpll", CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(10), 8, 5, DFLAGS),
 
 	/* sclk_timer has a gate in the sgrf */
 
-	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(10), 0, 5, DFLAGS,
 			RK3368_CLKGATE_CON(7), 9, GFLAGS),
 	GATE(SCLK_PVTM_PMU, "sclk_pvtm_pmu", "xin24m", 0,
@@ -514,16 +514,16 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(SCLK_PVTM_GPU, "sclk_pvtm_gpu", "xin24m", 0,
 			RK3368_CLKGATE_CON(7), 11, GFLAGS),
 
-	COMPOSITE(0, "aclk_peri_src", mux_pll_src_cpll_gpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "aclk_peri_src", mux_pll_src_cpll_gpll_p, CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(9), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3368_CLKGATE_CON(3), 0, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(9), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3368_CLKGATE_CON(3), 3, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(9), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3368_CLKGATE_CON(3), 2, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3368_CLKGATE_CON(3), 1, GFLAGS),
 
 	GATE(0, "sclk_mipidsi_24m", "xin24m", 0, RK3368_CLKGATE_CON(4), 14, GFLAGS),
@@ -670,7 +670,8 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 
 	/* aclk_bus gates */
 	GATE(0, "aclk_strc_sys", "aclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 12, GFLAGS),
-	GATE(ACLK_DMAC_BUS, "aclk_dmac_bus", "aclk_bus", 0, RK3368_CLKGATE_CON(12), 11, GFLAGS),
+	GATE(ACLK_DMAC_BUS, "aclk_dmac_bus", "aclk_bus", CLK_IS_CRITICAL,
+			RK3368_CLKGATE_CON(12), 11, GFLAGS),
 	GATE(0, "sclk_intmem1", "aclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 6, GFLAGS),
 	GATE(0, "sclk_intmem0", "aclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 5, GFLAGS),
 	GATE(0, "aclk_intmem", "aclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 4, GFLAGS),
@@ -696,14 +697,17 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(MCLK_CRYPTO, "mclk_crypto", "hclk_bus", 0, RK3368_CLKGATE_CON(13), 3, GFLAGS),
 
 	/* pclk_cpu gates */
-	GATE(PCLK_DDRPHY, "pclk_ddrphy", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 14, GFLAGS),
-	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 13, GFLAGS),
+	GATE(PCLK_DDRPHY, "pclk_ddrphy", "pclk_bus", CLK_IS_CRITICAL,
+			RK3368_CLKGATE_CON(12), 14, GFLAGS),
+	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_bus", CLK_IS_CRITICAL,
+			RK3368_CLKGATE_CON(12), 13, GFLAGS),
 	GATE(PCLK_I2C1, "pclk_i2c1", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 3, GFLAGS),
 	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 2, GFLAGS),
 	GATE(PCLK_MAILBOX, "pclk_mailbox", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 1, GFLAGS),
 	GATE(PCLK_PWM0, "pclk_pwm0", "pclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 0, GFLAGS),
 	GATE(PCLK_SIM, "pclk_sim", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 8, GFLAGS),
-	GATE(PCLK_PWM1, "pclk_pwm1", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 6, GFLAGS),
+	GATE(PCLK_PWM1, "pclk_pwm1", "pclk_bus", CLK_IS_CRITICAL,
+			RK3368_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 5, GFLAGS),
 	GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(0, "pclk_efuse_1024", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 0, GFLAGS),
@@ -780,7 +784,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(HCLK_HSIC, "hclk_hsic", "hclk_peri", 0, RK3368_CLKGATE_CON(20), 5, GFLAGS),
 	GATE(HCLK_HOST1, "hclk_host1", "hclk_peri", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(20), 4, GFLAGS),
 	GATE(HCLK_HOST0, "hclk_host0", "hclk_peri", 0, RK3368_CLKGATE_CON(20), 3, GFLAGS),
-	GATE(0, "pmu_hclk_otg0", "hclk_peri", 0, RK3368_CLKGATE_CON(20), 2, GFLAGS),
+	GATE(0, "pmu_hclk_otg0", "hclk_peri", CLK_IS_CRITICAL, RK3368_CLKGATE_CON(20), 2, GFLAGS),
 	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(20), 1, GFLAGS),
 	GATE(HCLK_HSADC, "hclk_hsadc", "hclk_peri", 0, RK3368_CLKGATE_CON(21), 3, GFLAGS),
 	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK3368_CLKGATE_CON(21), 2, GFLAGS),
@@ -807,8 +811,10 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	/* pclk_pd_alive gates */
 	GATE(PCLK_TIMER1, "pclk_timer1", "pclk_pd_alive", 0, RK3368_CLKGATE_CON(22), 13, GFLAGS),
 	GATE(PCLK_TIMER0, "pclk_timer0", "pclk_pd_alive", 0, RK3368_CLKGATE_CON(22), 12, GFLAGS),
-	GATE(0, "pclk_alive_niu", "pclk_pd_alive", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(22), 9, GFLAGS),
-	GATE(PCLK_GRF, "pclk_grf", "pclk_pd_alive", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(22), 8, GFLAGS),
+	GATE(0, "pclk_alive_niu", "pclk_pd_alive", CLK_IS_CRITICAL,
+			RK3368_CLKGATE_CON(22), 9, GFLAGS),
+	GATE(PCLK_GRF, "pclk_grf", "pclk_pd_alive", CLK_IS_CRITICAL,
+			RK3368_CLKGATE_CON(22), 8, GFLAGS),
 	GATE(PCLK_GPIO3, "pclk_gpio3", "pclk_pd_alive", 0, RK3368_CLKGATE_CON(22), 3, GFLAGS),
 	GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_pd_alive", 0, RK3368_CLKGATE_CON(22), 2, GFLAGS),
 	GATE(PCLK_GPIO1, "pclk_gpio1", "pclk_pd_alive", 0, RK3368_CLKGATE_CON(22), 1, GFLAGS),
@@ -846,23 +852,6 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(SCLK_TIMER00, "sclk_timer00", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 0, GFLAGS),
 };
 
-static const char *const rk3368_critical_clocks[] __initconst = {
-	"aclk_bus",
-	"aclk_peri",
-	/*
-	 * pwm1 supplies vdd_logic on a lot of boards, is currently unhandled
-	 * but needs to stay enabled there (including its parents) at all times.
-	 */
-	"pclk_pwm1",
-	"pclk_pd_pmu",
-	"pclk_pd_alive",
-	"pclk_peri",
-	"hclk_peri",
-	"pclk_ddrphy",
-	"pclk_ddrupctl",
-	"pmu_hclk_otg0",
-};
-
 static void __init rk3368_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -886,8 +875,6 @@ static void __init rk3368_clk_init(struct device_node *np)
 				   RK3368_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3368_clk_branches,
 				  ARRAY_SIZE(rk3368_clk_branches));
-	rockchip_clk_protect_critical(rk3368_critical_clocks,
-				      ARRAY_SIZE(rk3368_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLKB, "armclkb",
 			mux_armclkb_p, ARRAY_SIZE(mux_armclkb_p),
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 9ebd6c451b3d..619950265e8d 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -233,7 +233,8 @@ static struct rockchip_pll_clock rk3399_pll_clks[] __initdata = {
 };
 
 static struct rockchip_pll_clock rk3399_pmu_pll_clks[] __initdata = {
-	[ppll] = PLL(pll_rk3399, PLL_PPLL, "ppll",  mux_pll_p, 0, RK3399_PMU_PLL_CON(0),
+	[ppll] = PLL(pll_rk3399, PLL_PPLL, "ppll",  mux_pll_p,
+		     CLK_IS_CRITICAL, RK3399_PMU_PLL_CON(0),
 		     RK3399_PMU_PLL_CON(3), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
 };
 
@@ -425,7 +426,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE(ACLK_USB3, "aclk_usb3", mux_pll_src_cpll_gpll_npll_p, 0,
 			RK3399_CLKSEL_CON(39), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 0, GFLAGS),
-	GATE(ACLK_USB3_NOC, "aclk_usb3_noc", "aclk_usb3", CLK_IGNORE_UNUSED,
+	GATE(ACLK_USB3_NOC, "aclk_usb3_noc", "aclk_usb3", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(30), 0, GFLAGS),
 	GATE(ACLK_USB3OTG0, "aclk_usb3otg0", "aclk_usb3", 0,
 			RK3399_CLKGATE_CON(30), 1, GFLAGS),
@@ -551,7 +552,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 
 	GATE(ACLK_GMAC, "aclk_gmac", "aclk_gmac_pre", 0,
 			RK3399_CLKGATE_CON(32), 0, GFLAGS),
-	GATE(ACLK_GMAC_NOC, "aclk_gmac_noc", "aclk_gmac_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_GMAC_NOC, "aclk_gmac_noc", "aclk_gmac_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(32), 1, GFLAGS),
 	GATE(ACLK_PERF_GMAC, "aclk_perf_gmac", "aclk_gmac_pre", 0,
 			RK3399_CLKGATE_CON(32), 4, GFLAGS),
@@ -561,7 +562,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(6), 11, GFLAGS),
 	GATE(PCLK_GMAC, "pclk_gmac", "pclk_gmac_pre", 0,
 			RK3399_CLKGATE_CON(32), 2, GFLAGS),
-	GATE(PCLK_GMAC_NOC, "pclk_gmac_noc", "pclk_gmac_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_GMAC_NOC, "pclk_gmac_noc", "pclk_gmac_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(32), 3, GFLAGS),
 
 	COMPOSITE(SCLK_MAC, "clk_gmac", mux_pll_src_cpll_gpll_npll_p, 0,
@@ -667,11 +668,11 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(9), 7, GFLAGS,
 			&rk3399_uart3_fracmux),
 
-	COMPOSITE(PCLK_DDR, "pclk_ddr", mux_pll_src_cpll_gpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(PCLK_DDR, "pclk_ddr", mux_pll_src_cpll_gpll_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(6), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(3), 4, GFLAGS),
 
-	GATE(PCLK_CENTER_MAIN_NOC, "pclk_center_main_noc", "pclk_ddr", CLK_IGNORE_UNUSED,
+	GATE(PCLK_CENTER_MAIN_NOC, "pclk_center_main_noc", "pclk_ddr", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(18), 10, GFLAGS),
 	GATE(PCLK_DDR_MON, "pclk_ddr_mon", "pclk_ddr", 0,
 			RK3399_CLKGATE_CON(18), 12, GFLAGS),
@@ -688,30 +689,30 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(3), 6, GFLAGS),
 
 	/* cci */
-	GATE(0, "cpll_aclk_cci_src", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_cci_src", "cpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(0, "gpll_aclk_cci_src", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_cci_src", "gpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(2), 1, GFLAGS),
-	GATE(0, "npll_aclk_cci_src", "npll", CLK_IGNORE_UNUSED,
+	GATE(0, "npll_aclk_cci_src", "npll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(0, "vpll_aclk_cci_src", "vpll", CLK_IGNORE_UNUSED,
+	GATE(0, "vpll_aclk_cci_src", "vpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(2), 3, GFLAGS),
 
-	COMPOSITE(0, "aclk_cci_pre", mux_aclk_cci_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "aclk_cci_pre", mux_aclk_cci_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(5), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(2), 4, GFLAGS),
 
-	GATE(ACLK_ADB400M_PD_CORE_L, "aclk_adb400m_pd_core_l", "aclk_cci_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_ADB400M_PD_CORE_L, "aclk_adb400m_pd_core_l", "aclk_cci_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(15), 0, GFLAGS),
-	GATE(ACLK_ADB400M_PD_CORE_B, "aclk_adb400m_pd_core_b", "aclk_cci_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_ADB400M_PD_CORE_B, "aclk_adb400m_pd_core_b", "aclk_cci_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(15), 1, GFLAGS),
-	GATE(ACLK_CCI, "aclk_cci", "aclk_cci_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CCI, "aclk_cci", "aclk_cci_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(15), 2, GFLAGS),
-	GATE(ACLK_CCI_NOC0, "aclk_cci_noc0", "aclk_cci_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CCI_NOC0, "aclk_cci_noc0", "aclk_cci_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(15), 3, GFLAGS),
-	GATE(ACLK_CCI_NOC1, "aclk_cci_noc1", "aclk_cci_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CCI_NOC1, "aclk_cci_noc1", "aclk_cci_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(15), 4, GFLAGS),
-	GATE(ACLK_CCI_GRF, "aclk_cci_grf", "aclk_cci_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CCI_GRF, "aclk_cci_grf", "aclk_cci_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(15), 7, GFLAGS),
 
 	GATE(0, "cpll_cci_trace", "cpll", CLK_IGNORE_UNUSED,
@@ -722,17 +723,17 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(5), 15, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(2), 7, GFLAGS),
 
-	GATE(0, "cpll_cs", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_cs", "cpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(2), 8, GFLAGS),
-	GATE(0, "gpll_cs", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_cs", "gpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(2), 9, GFLAGS),
-	GATE(0, "npll_cs", "npll", CLK_IGNORE_UNUSED,
+	GATE(0, "npll_cs", "npll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(2), 10, GFLAGS),
-	COMPOSITE_NOGATE(0, "clk_cs", mux_cs_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(SCLK_CS, "clk_cs", mux_cs_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(4), 6, 2, MFLAGS, 0, 5, DFLAGS),
 	GATE(0, "clk_dbg_cxcs", "clk_cs", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(15), 5, GFLAGS),
-	GATE(0, "clk_dbg_noc", "clk_cs", CLK_IGNORE_UNUSED,
+	GATE(0, "clk_dbg_noc", "clk_cs", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(15), 6, GFLAGS),
 
 	/* vcodec */
@@ -744,12 +745,12 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(4), 1, GFLAGS),
 	GATE(HCLK_VCODEC, "hclk_vcodec", "hclk_vcodec_pre", 0,
 			RK3399_CLKGATE_CON(17), 2, GFLAGS),
-	GATE(0, "hclk_vcodec_noc", "hclk_vcodec_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "hclk_vcodec_noc", "hclk_vcodec_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(17), 3, GFLAGS),
 
 	GATE(ACLK_VCODEC, "aclk_vcodec", "aclk_vcodec_pre", 0,
 			RK3399_CLKGATE_CON(17), 0, GFLAGS),
-	GATE(0, "aclk_vcodec_noc", "aclk_vcodec_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_vcodec_noc", "aclk_vcodec_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(17), 1, GFLAGS),
 
 	/* vdu */
@@ -768,12 +769,12 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(4), 3, GFLAGS),
 	GATE(HCLK_VDU, "hclk_vdu", "hclk_vdu_pre", 0,
 			RK3399_CLKGATE_CON(17), 10, GFLAGS),
-	GATE(HCLK_VDU_NOC, "hclk_vdu_noc", "hclk_vdu_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_VDU_NOC, "hclk_vdu_noc", "hclk_vdu_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(17), 11, GFLAGS),
 
 	GATE(ACLK_VDU, "aclk_vdu", "aclk_vdu_pre", 0,
 			RK3399_CLKGATE_CON(17), 8, GFLAGS),
-	GATE(ACLK_VDU_NOC, "aclk_vdu_noc", "aclk_vdu_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_VDU_NOC, "aclk_vdu_noc", "aclk_vdu_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(17), 9, GFLAGS),
 
 	/* iep */
@@ -785,12 +786,12 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(4), 7, GFLAGS),
 	GATE(HCLK_IEP, "hclk_iep", "hclk_iep_pre", 0,
 			RK3399_CLKGATE_CON(16), 2, GFLAGS),
-	GATE(HCLK_IEP_NOC, "hclk_iep_noc", "hclk_iep_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_IEP_NOC, "hclk_iep_noc", "hclk_iep_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(16), 3, GFLAGS),
 
 	GATE(ACLK_IEP, "aclk_iep", "aclk_iep_pre", 0,
 			RK3399_CLKGATE_CON(16), 0, GFLAGS),
-	GATE(ACLK_IEP_NOC, "aclk_iep_noc", "aclk_iep_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_IEP_NOC, "aclk_iep_noc", "aclk_iep_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(16), 1, GFLAGS),
 
 	/* rga */
@@ -806,21 +807,21 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(4), 9, GFLAGS),
 	GATE(HCLK_RGA, "hclk_rga", "hclk_rga_pre", 0,
 			RK3399_CLKGATE_CON(16), 10, GFLAGS),
-	GATE(HCLK_RGA_NOC, "hclk_rga_noc", "hclk_rga_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_RGA_NOC, "hclk_rga_noc", "hclk_rga_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(16), 11, GFLAGS),
 
 	GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0,
 			RK3399_CLKGATE_CON(16), 8, GFLAGS),
-	GATE(ACLK_RGA_NOC, "aclk_rga_noc", "aclk_rga_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_RGA_NOC, "aclk_rga_noc", "aclk_rga_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(16), 9, GFLAGS),
 
 	/* center */
-	COMPOSITE(0, "aclk_center", mux_pll_src_cpll_gpll_npll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_CENTER, "aclk_center", mux_pll_src_cpll_gpll_npll_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(12), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(3), 7, GFLAGS),
-	GATE(ACLK_CENTER_MAIN_NOC, "aclk_center_main_noc", "aclk_center", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CENTER_MAIN_NOC, "aclk_center_main_noc", "aclk_center", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(19), 0, GFLAGS),
-	GATE(ACLK_CENTER_PERI_NOC, "aclk_center_peri_noc", "aclk_center", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CENTER_PERI_NOC, "aclk_center_peri_noc", "aclk_center", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(19), 1, GFLAGS),
 
 	/* gpu */
@@ -837,25 +838,25 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(13), 1, GFLAGS),
 
 	/* perihp */
-	GATE(0, "cpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_perihp_src", "cpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(5), 1, GFLAGS),
-	GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(5), 0, GFLAGS),
-	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(14), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(5), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERIHP, "hclk_perihp", "aclk_perihp", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERIHP, "hclk_perihp", "aclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(14), 8, 2, DFLAGS,
 			RK3399_CLKGATE_CON(5), 3, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERIHP, "pclk_perihp", "aclk_perihp", CLK_IGNORE_UNUSED,
-			RK3399_CLKSEL_CON(14), 12, 2, DFLAGS,
+	COMPOSITE_NOMUX(PCLK_PERIHP, "pclk_perihp", "aclk_perihp", CLK_IS_CRITICAL,
+			RK3399_CLKSEL_CON(14), 12, 3, DFLAGS,
 			RK3399_CLKGATE_CON(5), 4, GFLAGS),
 
 	GATE(ACLK_PERF_PCIE, "aclk_perf_pcie", "aclk_perihp", 0,
 			RK3399_CLKGATE_CON(20), 2, GFLAGS),
 	GATE(ACLK_PCIE, "aclk_pcie", "aclk_perihp", 0,
 			RK3399_CLKGATE_CON(20), 10, GFLAGS),
-	GATE(0, "aclk_perihp_noc", "aclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_perihp_noc", "aclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(20), 12, GFLAGS),
 
 	GATE(HCLK_HOST0, "hclk_host0", "hclk_perihp", 0,
@@ -868,16 +869,16 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(20), 8, GFLAGS),
 	GATE(HCLK_HSIC, "hclk_hsic", "hclk_perihp", 0,
 			RK3399_CLKGATE_CON(20), 9, GFLAGS),
-	GATE(0, "hclk_perihp_noc", "hclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(0, "hclk_perihp_noc", "hclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(20), 13, GFLAGS),
 	GATE(0, "hclk_ahb1tom", "hclk_perihp", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(20), 15, GFLAGS),
 
-	GATE(PCLK_PERIHP_GRF, "pclk_perihp_grf", "pclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PERIHP_GRF, "pclk_perihp_grf", "pclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(20), 4, GFLAGS),
 	GATE(PCLK_PCIE, "pclk_pcie", "pclk_perihp", 0,
 			RK3399_CLKGATE_CON(20), 11, GFLAGS),
-	GATE(0, "pclk_perihp_noc", "pclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_perihp_noc", "pclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(20), 14, GFLAGS),
 	GATE(PCLK_HSICPHY, "pclk_hsicphy", "pclk_perihp", 0,
 			RK3399_CLKGATE_CON(31), 8, GFLAGS),
@@ -888,7 +889,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(12), 13, GFLAGS),
 	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_sd", 0,
 			RK3399_CLKGATE_CON(33), 8, GFLAGS),
-	GATE(0, "hclk_sdmmc_noc", "hclk_sd", CLK_IGNORE_UNUSED,
+	GATE(0, "hclk_sdmmc_noc", "hclk_sd", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(33), 9, GFLAGS),
 
 	COMPOSITE(SCLK_SDIO, "clk_sdio", mux_pll_src_cpll_gpll_npll_ppll_upll_24m_p, 0,
@@ -935,23 +936,23 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(21), 7, 1, MFLAGS, 0, 5, DFLAGS),
 	GATE(ACLK_EMMC_CORE, "aclk_emmccore", "aclk_emmc", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(32), 8, GFLAGS),
-	GATE(ACLK_EMMC_NOC, "aclk_emmc_noc", "aclk_emmc", CLK_IGNORE_UNUSED,
+	GATE(ACLK_EMMC_NOC, "aclk_emmc_noc", "aclk_emmc", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(32), 9, GFLAGS),
 	GATE(ACLK_EMMC_GRF, "aclk_emmcgrf", "aclk_emmc", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(32), 10, GFLAGS),
 
 	/* perilp0 */
-	GATE(0, "cpll_aclk_perilp0_src", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_perilp0_src", "cpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(7), 1, GFLAGS),
-	GATE(0, "gpll_aclk_perilp0_src", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_perilp0_src", "gpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(7), 0, GFLAGS),
-	COMPOSITE(ACLK_PERILP0, "aclk_perilp0", mux_aclk_perilp0_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_PERILP0, "aclk_perilp0", mux_aclk_perilp0_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(23), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(7), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERILP0, "hclk_perilp0", "aclk_perilp0", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERILP0, "hclk_perilp0", "aclk_perilp0", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(23), 8, 2, DFLAGS,
 			RK3399_CLKGATE_CON(7), 3, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERILP0, "pclk_perilp0", "aclk_perilp0", 0,
+	COMPOSITE_NOMUX(PCLK_PERILP0, "pclk_perilp0", "aclk_perilp0", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(23), 12, 3, DFLAGS,
 			RK3399_CLKGATE_CON(7), 4, GFLAGS),
 
@@ -966,8 +967,10 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(SCLK_INTMEM5, "clk_intmem5", "aclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(23), 7, GFLAGS),
 	GATE(ACLK_DCF, "aclk_dcf", "aclk_perilp0", 0, RK3399_CLKGATE_CON(23), 8, GFLAGS),
 	GATE(ACLK_DMAC0_PERILP, "aclk_dmac0_perilp", "aclk_perilp0", 0, RK3399_CLKGATE_CON(25), 5, GFLAGS),
-	GATE(ACLK_DMAC1_PERILP, "aclk_dmac1_perilp", "aclk_perilp0", 0, RK3399_CLKGATE_CON(25), 6, GFLAGS),
-	GATE(ACLK_PERILP0_NOC, "aclk_perilp0_noc", "aclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 7, GFLAGS),
+	GATE(ACLK_DMAC1_PERILP, "aclk_dmac1_perilp", "aclk_perilp0", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(25), 6, GFLAGS),
+	GATE(ACLK_PERILP0_NOC, "aclk_perilp0_noc", "aclk_perilp0", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(25), 7, GFLAGS),
 
 	/* hclk_perilp0 gates */
 	GATE(HCLK_ROM, "hclk_rom", "hclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(24), 4, GFLAGS),
@@ -975,7 +978,8 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(HCLK_S_CRYPTO0, "hclk_s_crypto0", "hclk_perilp0", 0, RK3399_CLKGATE_CON(24), 6, GFLAGS),
 	GATE(HCLK_M_CRYPTO1, "hclk_m_crypto1", "hclk_perilp0", 0, RK3399_CLKGATE_CON(24), 14, GFLAGS),
 	GATE(HCLK_S_CRYPTO1, "hclk_s_crypto1", "hclk_perilp0", 0, RK3399_CLKGATE_CON(24), 15, GFLAGS),
-	GATE(HCLK_PERILP0_NOC, "hclk_perilp0_noc", "hclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 8, GFLAGS),
+	GATE(HCLK_PERILP0_NOC, "hclk_perilp0_noc", "hclk_perilp0", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(25), 8, GFLAGS),
 
 	/* pclk_perilp0 gates */
 	GATE(PCLK_DCF, "pclk_dcf", "pclk_perilp0", 0, RK3399_CLKGATE_CON(23), 9, GFLAGS),
@@ -1003,29 +1007,33 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(HCLK_M0_PERILP, "hclk_m0_perilp", "fclk_cm0s", 0, RK3399_CLKGATE_CON(24), 9, GFLAGS),
 	GATE(DCLK_M0_PERILP, "dclk_m0_perilp", "fclk_cm0s", 0, RK3399_CLKGATE_CON(24), 10, GFLAGS),
 	GATE(SCLK_M0_PERILP_DEC, "clk_m0_perilp_dec", "fclk_cm0s", 0, RK3399_CLKGATE_CON(24), 11, GFLAGS),
-	GATE(HCLK_M0_PERILP_NOC, "hclk_m0_perilp_noc", "fclk_cm0s", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 11, GFLAGS),
+	GATE(HCLK_M0_PERILP_NOC, "hclk_m0_perilp_noc", "fclk_cm0s", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(25), 11, GFLAGS),
 
 	/* perilp1 */
-	GATE(0, "cpll_hclk_perilp1_src", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_hclk_perilp1_src", "cpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(8), 1, GFLAGS),
-	GATE(0, "gpll_hclk_perilp1_src", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_hclk_perilp1_src", "gpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(8), 0, GFLAGS),
-	COMPOSITE_NOGATE(HCLK_PERILP1, "hclk_perilp1", mux_hclk_perilp1_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(HCLK_PERILP1, "hclk_perilp1", mux_hclk_perilp1_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(25), 7, 1, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERILP1, "pclk_perilp1", "hclk_perilp1", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_PERILP1, "pclk_perilp1", "hclk_perilp1", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(25), 8, 3, DFLAGS,
 			RK3399_CLKGATE_CON(8), 2, GFLAGS),
 
 	/* hclk_perilp1 gates */
-	GATE(0, "hclk_perilp1_noc", "hclk_perilp1", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 9, GFLAGS),
-	GATE(0, "hclk_sdio_noc", "hclk_perilp1", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 12, GFLAGS),
+	GATE(0, "hclk_perilp1_noc", "hclk_perilp1", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(25), 9, GFLAGS),
+	GATE(0, "hclk_sdio_noc", "hclk_perilp1", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(25), 12, GFLAGS),
 	GATE(HCLK_I2S0_8CH, "hclk_i2s0", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 0, GFLAGS),
 	GATE(HCLK_I2S1_8CH, "hclk_i2s1", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 1, GFLAGS),
 	GATE(HCLK_I2S2_8CH, "hclk_i2s2", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 2, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 3, GFLAGS),
 	GATE(HCLK_SDIO, "hclk_sdio", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 4, GFLAGS),
 	GATE(PCLK_SPI5, "pclk_spi5", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 5, GFLAGS),
-	GATE(0, "hclk_sdioaudio_noc", "hclk_perilp1", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(34), 6, GFLAGS),
+	GATE(0, "hclk_sdioaudio_noc", "hclk_perilp1", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(34), 6, GFLAGS),
 
 	/* pclk_perilp1 gates */
 	GATE(PCLK_UART0, "pclk_uart0", "pclk_perilp1", 0, RK3399_CLKGATE_CON(22), 0, GFLAGS),
@@ -1048,7 +1056,8 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(PCLK_SPI2, "pclk_spi2", "pclk_perilp1", 0, RK3399_CLKGATE_CON(23), 12, GFLAGS),
 	GATE(PCLK_SPI4, "pclk_spi4", "pclk_perilp1", 0, RK3399_CLKGATE_CON(23), 13, GFLAGS),
 	GATE(PCLK_PERIHP_GRF, "pclk_perilp_sgrf", "pclk_perilp1", 0, RK3399_CLKGATE_CON(24), 13, GFLAGS),
-	GATE(0, "pclk_perilp1_noc", "pclk_perilp1", 0, RK3399_CLKGATE_CON(25), 10, GFLAGS),
+	GATE(0, "pclk_perilp1_noc", "pclk_perilp1", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(25), 10, GFLAGS),
 
 	/* saradc */
 	COMPOSITE_NOMUX(SCLK_SARADC, "clk_saradc", "xin24m", 0,
@@ -1077,18 +1086,18 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE(ACLK_VIO, "aclk_vio", mux_pll_src_cpll_gpll_ppll_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(42), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(11), 0, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_VIO, "pclk_vio", "aclk_vio", 0,
+	COMPOSITE_NOMUX(PCLK_VIO, "pclk_vio", "aclk_vio", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(43), 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(11), 1, GFLAGS),
 
-	GATE(ACLK_VIO_NOC, "aclk_vio_noc", "aclk_vio", CLK_IGNORE_UNUSED,
+	GATE(ACLK_VIO_NOC, "aclk_vio_noc", "aclk_vio", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(29), 0, GFLAGS),
 
 	GATE(PCLK_MIPI_DSI0, "pclk_mipi_dsi0", "pclk_vio", 0,
 			RK3399_CLKGATE_CON(29), 1, GFLAGS),
 	GATE(PCLK_MIPI_DSI1, "pclk_mipi_dsi1", "pclk_vio", 0,
 			RK3399_CLKGATE_CON(29), 2, GFLAGS),
-	GATE(PCLK_VIO_GRF, "pclk_vio_grf", "pclk_vio", CLK_IGNORE_UNUSED,
+	GATE(PCLK_VIO_GRF, "pclk_vio_grf", "pclk_vio", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(29), 12, GFLAGS),
 
 	/* hdcp */
@@ -1102,17 +1111,17 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(43), 10, 5, DFLAGS,
 			RK3399_CLKGATE_CON(11), 10, GFLAGS),
 
-	GATE(ACLK_HDCP_NOC, "aclk_hdcp_noc", "aclk_hdcp", CLK_IGNORE_UNUSED,
+	GATE(ACLK_HDCP_NOC, "aclk_hdcp_noc", "aclk_hdcp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(29), 4, GFLAGS),
 	GATE(ACLK_HDCP22, "aclk_hdcp22", "aclk_hdcp", 0,
 			RK3399_CLKGATE_CON(29), 10, GFLAGS),
 
-	GATE(HCLK_HDCP_NOC, "hclk_hdcp_noc", "hclk_hdcp", CLK_IGNORE_UNUSED,
+	GATE(HCLK_HDCP_NOC, "hclk_hdcp_noc", "hclk_hdcp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(29), 5, GFLAGS),
 	GATE(HCLK_HDCP22, "hclk_hdcp22", "hclk_hdcp", 0,
 			RK3399_CLKGATE_CON(29), 9, GFLAGS),
 
-	GATE(PCLK_HDCP_NOC, "pclk_hdcp_noc", "pclk_hdcp", CLK_IGNORE_UNUSED,
+	GATE(PCLK_HDCP_NOC, "pclk_hdcp_noc", "pclk_hdcp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(29), 3, GFLAGS),
 	GATE(PCLK_HDMI_CTRL, "pclk_hdmi_ctrl", "pclk_hdcp", 0,
 			RK3399_CLKGATE_CON(29), 6, GFLAGS),
@@ -1131,7 +1140,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE(PCLK_EDP, "pclk_edp", mux_pll_src_cpll_gpll_p, 0,
 			RK3399_CLKSEL_CON(44), 15, 1, MFLAGS, 8, 6, DFLAGS,
 			RK3399_CLKGATE_CON(11), 11, GFLAGS),
-	GATE(PCLK_EDP_NOC, "pclk_edp_noc", "pclk_edp", CLK_IGNORE_UNUSED,
+	GATE(PCLK_EDP_NOC, "pclk_edp_noc", "pclk_edp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(32), 12, GFLAGS),
 	GATE(PCLK_EDP_CTRL, "pclk_edp_ctrl", "pclk_edp", 0,
 			RK3399_CLKGATE_CON(32), 13, GFLAGS),
@@ -1154,12 +1163,12 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 
 	GATE(ACLK_VOP0, "aclk_vop0", "aclk_vop0_pre", 0,
 			RK3399_CLKGATE_CON(28), 3, GFLAGS),
-	GATE(ACLK_VOP0_NOC, "aclk_vop0_noc", "aclk_vop0_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_VOP0_NOC, "aclk_vop0_noc", "aclk_vop0_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(28), 1, GFLAGS),
 
 	GATE(HCLK_VOP0, "hclk_vop0", "hclk_vop0_pre", 0,
 			RK3399_CLKGATE_CON(28), 2, GFLAGS),
-	GATE(HCLK_VOP0_NOC, "hclk_vop0_noc", "hclk_vop0_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_VOP0_NOC, "hclk_vop0_noc", "hclk_vop0_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(28), 0, GFLAGS),
 
 	COMPOSITE(DCLK_VOP0_DIV, "dclk_vop0_div", mux_pll_src_vpll_cpll_gpll_p, 0,
@@ -1184,12 +1193,12 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 
 	GATE(ACLK_VOP1, "aclk_vop1", "aclk_vop1_pre", 0,
 			RK3399_CLKGATE_CON(28), 7, GFLAGS),
-	GATE(ACLK_VOP1_NOC, "aclk_vop1_noc", "aclk_vop1_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_VOP1_NOC, "aclk_vop1_noc", "aclk_vop1_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(28), 5, GFLAGS),
 
 	GATE(HCLK_VOP1, "hclk_vop1", "hclk_vop1_pre", 0,
 			RK3399_CLKGATE_CON(28), 6, GFLAGS),
-	GATE(HCLK_VOP1_NOC, "hclk_vop1_noc", "hclk_vop1_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_VOP1_NOC, "hclk_vop1_noc", "hclk_vop1_pre", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(28), 4, GFLAGS),
 
 	COMPOSITE(DCLK_VOP1_DIV, "dclk_vop1_div", mux_pll_src_vpll_cpll_gpll_p, 0,
@@ -1212,14 +1221,14 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(53), 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 9, GFLAGS),
 
-	GATE(ACLK_ISP0_NOC, "aclk_isp0_noc", "aclk_isp0", CLK_IGNORE_UNUSED,
+	GATE(ACLK_ISP0_NOC, "aclk_isp0_noc", "aclk_isp0", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(27), 1, GFLAGS),
 	GATE(ACLK_ISP0_WRAPPER, "aclk_isp0_wrapper", "aclk_isp0", 0,
 			RK3399_CLKGATE_CON(27), 5, GFLAGS),
 	GATE(HCLK_ISP1_WRAPPER, "hclk_isp1_wrapper", "aclk_isp0", 0,
 			RK3399_CLKGATE_CON(27), 7, GFLAGS),
 
-	GATE(HCLK_ISP0_NOC, "hclk_isp0_noc", "hclk_isp0", CLK_IGNORE_UNUSED,
+	GATE(HCLK_ISP0_NOC, "hclk_isp0_noc", "hclk_isp0", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(27), 0, GFLAGS),
 	GATE(HCLK_ISP0_WRAPPER, "hclk_isp0_wrapper", "hclk_isp0", 0,
 			RK3399_CLKGATE_CON(27), 4, GFLAGS),
@@ -1235,10 +1244,10 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(54), 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 11, GFLAGS),
 
-	GATE(ACLK_ISP1_NOC, "aclk_isp1_noc", "aclk_isp1", CLK_IGNORE_UNUSED,
+	GATE(ACLK_ISP1_NOC, "aclk_isp1_noc", "aclk_isp1", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(27), 3, GFLAGS),
 
-	GATE(HCLK_ISP1_NOC, "hclk_isp1_noc", "hclk_isp1", CLK_IGNORE_UNUSED,
+	GATE(HCLK_ISP1_NOC, "hclk_isp1_noc", "hclk_isp1", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(27), 2, GFLAGS),
 	GATE(ACLK_ISP1_WRAPPER, "aclk_isp1_wrapper", "hclk_isp1", 0,
 			RK3399_CLKGATE_CON(27), 8, GFLAGS),
@@ -1267,12 +1276,14 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */
-	COMPOSITE(ACLK_GIC_PRE, "aclk_gic_pre", mux_pll_src_cpll_gpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_GIC_PRE, "aclk_gic_pre", mux_pll_src_cpll_gpll_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(56), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(12), 12, GFLAGS),
 
-	GATE(ACLK_GIC, "aclk_gic", "aclk_gic_pre", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(33), 0, GFLAGS),
-	GATE(ACLK_GIC_NOC, "aclk_gic_noc", "aclk_gic_pre", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(33), 1, GFLAGS),
+	GATE(ACLK_GIC, "aclk_gic", "aclk_gic_pre", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(33), 0, GFLAGS),
+	GATE(ACLK_GIC_NOC, "aclk_gic_noc", "aclk_gic_pre", CLK_IS_CRITICAL,
+			RK3399_CLKGATE_CON(33), 1, GFLAGS),
 	GATE(ACLK_GIC_ADB400_CORE_L_2_GIC, "aclk_gic_adb400_core_l_2_gic", "aclk_gic_pre", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(33), 2, GFLAGS),
 	GATE(ACLK_GIC_ADB400_CORE_B_2_GIC, "aclk_gic_adb400_core_b_2_gic", "aclk_gic_pre", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(33), 3, GFLAGS),
 	GATE(ACLK_GIC_ADB400_GIC_2_CORE_L, "aclk_gic_adb400_gic_2_core_l", "aclk_gic_pre", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(33), 4, GFLAGS),
@@ -1387,13 +1398,13 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(13), 11, GFLAGS),
 
 	/* ddrc */
-	GATE(0, "clk_ddrc_lpll_src", "lpll", 0, RK3399_CLKGATE_CON(3),
+	GATE(0, "clk_ddrc_lpll_src", "lpll", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(3),
 	     0, GFLAGS),
-	GATE(0, "clk_ddrc_bpll_src", "bpll", 0, RK3399_CLKGATE_CON(3),
+	GATE(0, "clk_ddrc_bpll_src", "bpll", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(3),
 	     1, GFLAGS),
-	GATE(0, "clk_ddrc_dpll_src", "dpll", 0, RK3399_CLKGATE_CON(3),
+	GATE(0, "clk_ddrc_dpll_src", "dpll", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(3),
 	     2, GFLAGS),
-	GATE(0, "clk_ddrc_gpll_src", "gpll", 0, RK3399_CLKGATE_CON(3),
+	GATE(0, "clk_ddrc_gpll_src", "gpll", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(3),
 	     3, GFLAGS),
 	COMPOSITE_DDRCLK(SCLK_DDRC, "sclk_ddrc", mux_ddrclk_p, 0,
 		       RK3399_CLKSEL_CON(6), 4, 2, 0, 0, ROCKCHIP_DDRCLK_SIP),
@@ -1404,10 +1415,11 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 	 * PMU CRU Clock-Architecture
 	 */
 
-	GATE(0, "fclk_cm0s_pmu_ppll_src", "ppll", 0,
+	GATE(0, "fclk_cm0s_pmu_ppll_src", "ppll", CLK_IS_CRITICAL,
 			RK3399_PMU_CLKGATE_CON(0), 1, GFLAGS),
 
-	COMPOSITE_NOGATE(FCLK_CM0S_SRC_PMU, "fclk_cm0s_src_pmu", mux_fclk_cm0s_pmu_ppll_p, 0,
+	COMPOSITE_NOGATE(FCLK_CM0S_SRC_PMU, "fclk_cm0s_src_pmu", mux_fclk_cm0s_pmu_ppll_p,
+			CLK_IS_CRITICAL,
 			RK3399_PMU_CLKSEL_CON(0), 15, 1, MFLAGS, 8, 5, DFLAGS),
 
 	COMPOSITE(SCLK_SPI3_PMU, "clk_spi3_pmu", mux_24m_ppll_p, 0,
@@ -1451,7 +1463,7 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 			RK3399_PMU_CLKGATE_CON(0), 6, GFLAGS,
 			&rk3399_uart4_pmu_fracmux),
 
-	DIV(PCLK_SRC_PMU, "pclk_pmu_src", "ppll", CLK_IGNORE_UNUSED,
+	DIV(PCLK_SRC_PMU, "pclk_pmu_src", "ppll", CLK_IS_CRITICAL,
 			RK3399_PMU_CLKSEL_CON(0), 0, 5, DFLAGS),
 
 	/* pmu clock gates */
@@ -1466,66 +1478,29 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 	GATE(PCLK_GPIO0_PMU, "pclk_gpio0_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 3, GFLAGS),
 	GATE(PCLK_GPIO1_PMU, "pclk_gpio1_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 4, GFLAGS),
 	GATE(PCLK_SGRF_PMU, "pclk_sgrf_pmu", "pclk_pmu_src", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(1), 5, GFLAGS),
-	GATE(PCLK_NOC_PMU, "pclk_noc_pmu", "pclk_pmu_src", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(1), 6, GFLAGS),
+	GATE(PCLK_NOC_PMU, "pclk_noc_pmu", "pclk_pmu_src", CLK_IS_CRITICAL,
+			RK3399_PMU_CLKGATE_CON(1), 6, GFLAGS),
 	GATE(PCLK_I2C0_PMU, "pclk_i2c0_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 7, GFLAGS),
 	GATE(PCLK_I2C4_PMU, "pclk_i2c4_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 8, GFLAGS),
 	GATE(PCLK_I2C8_PMU, "pclk_i2c8_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 9, GFLAGS),
-	GATE(PCLK_RKPWM_PMU, "pclk_rkpwm_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 10, GFLAGS),
+	GATE(PCLK_RKPWM_PMU, "pclk_rkpwm_pmu", "pclk_pmu_src", CLK_IS_CRITICAL,
+			RK3399_PMU_CLKGATE_CON(1), 10, GFLAGS),
 	GATE(PCLK_SPI3_PMU, "pclk_spi3_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 11, GFLAGS),
 	GATE(PCLK_TIMER_PMU, "pclk_timer_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 12, GFLAGS),
 	GATE(PCLK_MAILBOX_PMU, "pclk_mailbox_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 13, GFLAGS),
 	GATE(PCLK_UART4_PMU, "pclk_uart4_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 14, GFLAGS),
 	GATE(PCLK_WDT_M0_PMU, "pclk_wdt_m0_pmu", "pclk_pmu_src", 0, RK3399_PMU_CLKGATE_CON(1), 15, GFLAGS),
 
-	GATE(FCLK_CM0S_PMU, "fclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(SCLK_CM0S_PMU, "sclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 1, GFLAGS),
-	GATE(HCLK_CM0S_PMU, "hclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(DCLK_CM0S_PMU, "dclk_cm0s_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 3, GFLAGS),
-	GATE(HCLK_NOC_PMU, "hclk_noc_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 5, GFLAGS),
-};
-
-static const char *const rk3399_cru_critical_clocks[] __initconst = {
-	"aclk_cci_pre",
-	"aclk_gic",
-	"aclk_gic_noc",
-	"aclk_hdcp_noc",
-	"hclk_hdcp_noc",
-	"pclk_hdcp_noc",
-	"pclk_perilp0",
-	"pclk_perilp0",
-	"hclk_perilp0",
-	"hclk_perilp0_noc",
-	"pclk_perilp1",
-	"pclk_perilp1_noc",
-	"pclk_perihp",
-	"pclk_perihp_noc",
-	"hclk_perihp",
-	"aclk_perihp",
-	"aclk_perihp_noc",
-	"aclk_perilp0",
-	"aclk_perilp0_noc",
-	"hclk_perilp1",
-	"hclk_perilp1_noc",
-	"aclk_dmac0_perilp",
-	"aclk_emmc_noc",
-	"gpll_hclk_perilp1_src",
-	"gpll_aclk_perilp0_src",
-	"gpll_aclk_perihp_src",
-	"aclk_vio_noc",
-
-	/* ddrc */
-	"sclk_ddrc",
-
-	"armclkl",
-	"armclkb",
-};
-
-static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
-	"ppll",
-	"pclk_pmu_src",
-	"fclk_cm0s_src_pmu",
-	"clk_timer_src_pmu",
-	"pclk_rkpwm_pmu",
+	GATE(FCLK_CM0S_PMU, "fclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0,
+			RK3399_PMU_CLKGATE_CON(2), 0, GFLAGS),
+	GATE(SCLK_CM0S_PMU, "sclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0,
+			RK3399_PMU_CLKGATE_CON(2), 1, GFLAGS),
+	GATE(HCLK_CM0S_PMU, "hclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0,
+			RK3399_PMU_CLKGATE_CON(2), 2, GFLAGS),
+	GATE(DCLK_CM0S_PMU, "dclk_cm0s_pmu", "fclk_cm0s_src_pmu", 0,
+			RK3399_PMU_CLKGATE_CON(2), 3, GFLAGS),
+	GATE(HCLK_NOC_PMU, "hclk_noc_pmu", "fclk_cm0s_src_pmu", CLK_IS_CRITICAL,
+			RK3399_PMU_CLKGATE_CON(2), 5, GFLAGS),
 };
 
 static void __init rk3399_clk_init(struct device_node *np)
@@ -1562,9 +1537,6 @@ static void __init rk3399_clk_init(struct device_node *np)
 			&rk3399_cpuclkb_data, rk3399_cpuclkb_rates,
 			ARRAY_SIZE(rk3399_cpuclkb_rates));
 
-	rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
-				      ARRAY_SIZE(rk3399_cru_critical_clocks));
-
 	rockchip_register_softrst(np, 21, reg_base + RK3399_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
@@ -1598,9 +1570,6 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, rk3399_clk_pmu_branches,
 				  ARRAY_SIZE(rk3399_clk_pmu_branches));
 
-	rockchip_clk_protect_critical(rk3399_pmucru_critical_clocks,
-				  ARRAY_SIZE(rk3399_pmucru_critical_clocks));
-
 	rockchip_register_softrst(np, 2, reg_base + RK3399_PMU_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 16dabe2b9c47..b1d173ef7da3 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -332,7 +332,7 @@ static struct rockchip_pll_clock rk3568_pll_clks[] __initdata = {
 		     0, RK3568_PLL_CON(16),
 		     RK3568_MODE_CON0, 6, 3, 0, rk3568_pll_rates),
 	[npll] = PLL(pll_rk3328, PLL_NPLL, "npll", mux_pll_p,
-		     0, RK3568_PLL_CON(32),
+		     CLK_IS_CRITICAL, RK3568_PLL_CON(32),
 		     RK3568_MODE_CON0, 10, 5, 0, rk3568_pll_rates),
 	[vpll] = PLL(pll_rk3328, PLL_VPLL, "vpll", mux_pll_p,
 		     0, RK3568_PLL_CON(40),
@@ -482,36 +482,37 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 			RK3568_MODE_CON0, 14, 2, MFLAGS),
 
 	/* PD_CORE */
-	COMPOSITE(0, "sclk_core_src", apll_gpll_npll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "sclk_core_src", apll_gpll_npll_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(0), 5, GFLAGS),
-	COMPOSITE_NODIV(0, "sclk_core", sclk_core_pre_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NODIV(0, "sclk_core", sclk_core_pre_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(2), 15, 1, MFLAGS,
 			RK3568_CLKGATE_CON(0), 7, GFLAGS),
 
-	COMPOSITE_NOMUX(0, "atclk_core", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "atclk_core", "armclk", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(3), 0, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(0), 8, GFLAGS),
-	COMPOSITE_NOMUX(0, "gicclk_core", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "gicclk_core", "armclk", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(3), 8, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(0), 9, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_core_pre", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_core_pre", "armclk", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(4), 0, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(0), 10, GFLAGS),
-	COMPOSITE_NOMUX(0, "periphclk_core_pre", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "periphclk_core_pre", "armclk", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(4), 8, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(0), 11, GFLAGS),
-	COMPOSITE_NOMUX(0, "tsclk_core", "periphclk_core_pre", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "tsclk_core", "periphclk_core_pre", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(5), 0, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(0), 14, GFLAGS),
-	COMPOSITE_NOMUX(0, "cntclk_core", "periphclk_core_pre", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "cntclk_core", "periphclk_core_pre", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(5), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(0), 15, GFLAGS),
-	COMPOSITE_NOMUX(0, "aclk_core", "sclk_core", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "aclk_core", "sclk_core", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(5), 8, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RK3568_CLKGATE_CON(1), 0, GFLAGS),
 
-	COMPOSITE_NODIV(ACLK_CORE_NIU2BUS, "aclk_core_niu2bus", gpll150_gpll100_gpll75_xin24m_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NODIV(ACLK_CORE_NIU2BUS, "aclk_core_niu2bus", gpll150_gpll100_gpll75_xin24m_p,
+			CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(5), 14, 2, MFLAGS,
 			RK3568_CLKGATE_CON(1), 2, GFLAGS),
 
@@ -744,10 +745,12 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 			RK3568_CLKGATE_CON(8), 6, GFLAGS),
 
 	/* PD_SECURE_FLASH */
-	COMPOSITE_NODIV(ACLK_SECURE_FLASH, "aclk_secure_flash", gpll200_gpll150_gpll100_xin24m_p, 0,
+	COMPOSITE_NODIV(ACLK_SECURE_FLASH, "aclk_secure_flash", gpll200_gpll150_gpll100_xin24m_p,
+			CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(27), 0, 2, MFLAGS,
 			RK3568_CLKGATE_CON(8), 7, GFLAGS),
-	COMPOSITE_NODIV(HCLK_SECURE_FLASH, "hclk_secure_flash", gpll150_gpll100_gpll75_xin24m_p, 0,
+	COMPOSITE_NODIV(HCLK_SECURE_FLASH, "hclk_secure_flash", gpll150_gpll100_gpll75_xin24m_p,
+			CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(27), 2, 2, MFLAGS,
 			RK3568_CLKGATE_CON(8), 8, GFLAGS),
 	GATE(ACLK_CRYPTO_NS, "aclk_crypto_ns", "aclk_secure_flash", 0,
@@ -878,10 +881,10 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 	COMPOSITE_NODIV(ACLK_PHP, "aclk_php", gpll300_gpll200_gpll100_xin24m_p, 0,
 			RK3568_CLKSEL_CON(30), 0, 2, MFLAGS,
 			RK3568_CLKGATE_CON(14), 8, GFLAGS),
-	COMPOSITE_NODIV(HCLK_PHP, "hclk_php", gpll150_gpll100_gpll75_xin24m_p, 0,
+	COMPOSITE_NODIV(HCLK_PHP, "hclk_php", gpll150_gpll100_gpll75_xin24m_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(30), 2, 2, MFLAGS,
 			RK3568_CLKGATE_CON(14), 9, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PHP, "pclk_php", "aclk_php", 0,
+	COMPOSITE_NOMUX(PCLK_PHP, "pclk_php", "aclk_php", CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(30), 4, 4, DFLAGS,
 			RK3568_CLKGATE_CON(14), 10, GFLAGS),
 	GATE(HCLK_SDMMC0, "hclk_sdmmc0", "hclk_php", 0,
@@ -932,7 +935,7 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 	COMPOSITE_NODIV(ACLK_USB, "aclk_usb", gpll300_gpll200_gpll100_xin24m_p, 0,
 			RK3568_CLKSEL_CON(32), 0, 2, MFLAGS,
 			RK3568_CLKGATE_CON(16), 0, GFLAGS),
-	COMPOSITE_NODIV(HCLK_USB, "hclk_usb", gpll150_gpll100_gpll75_xin24m_p, 0,
+	COMPOSITE_NODIV(HCLK_USB, "hclk_usb", gpll150_gpll100_gpll75_xin24m_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(32), 2, 2, MFLAGS,
 			RK3568_CLKGATE_CON(16), 1, GFLAGS),
 	COMPOSITE_NOMUX(PCLK_USB, "pclk_usb", "aclk_usb", 0,
@@ -983,10 +986,12 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 			RK3568_CLKSEL_CON(33), 0, 2, MFLAGS),
 
 	/* PD_PERI */
-	COMPOSITE_NODIV(ACLK_PERIMID, "aclk_perimid", gpll300_gpll200_gpll100_xin24m_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NODIV(ACLK_PERIMID, "aclk_perimid", gpll300_gpll200_gpll100_xin24m_p,
+			CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(10), 4, 2, MFLAGS,
 			RK3568_CLKGATE_CON(14), 0, GFLAGS),
-	COMPOSITE_NODIV(HCLK_PERIMID, "hclk_perimid", gpll150_gpll100_gpll75_xin24m_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NODIV(HCLK_PERIMID, "hclk_perimid", gpll150_gpll100_gpll75_xin24m_p,
+			CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(10), 6, 2, MFLAGS,
 			RK3568_CLKGATE_CON(14), 1, GFLAGS),
 
@@ -1166,10 +1171,10 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 			RK3568_CLKGATE_CON(25), 8, GFLAGS),
 
 	/* PD_BUS */
-	COMPOSITE_NODIV(ACLK_BUS, "aclk_bus", gpll200_gpll150_gpll100_xin24m_p, 0,
+	COMPOSITE_NODIV(ACLK_BUS, "aclk_bus", gpll200_gpll150_gpll100_xin24m_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(50), 0, 2, MFLAGS,
 			RK3568_CLKGATE_CON(26), 0, GFLAGS),
-	COMPOSITE_NODIV(PCLK_BUS, "pclk_bus", gpll100_gpll75_cpll50_xin24m_p, 0,
+	COMPOSITE_NODIV(PCLK_BUS, "pclk_bus", gpll100_gpll75_cpll50_xin24m_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(50), 4, 2, MFLAGS,
 			RK3568_CLKGATE_CON(26), 1, GFLAGS),
 	GATE(PCLK_TSADC, "pclk_tsadc", "pclk_bus", 0,
@@ -1417,21 +1422,23 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 			RK3568_CLKGATE_CON(32), 9, GFLAGS),
 
 	/* PD_TOP */
-	COMPOSITE_NODIV(ACLK_TOP_HIGH, "aclk_top_high", cpll500_gpll400_gpll300_xin24m_p, 0,
+	COMPOSITE_NODIV(ACLK_TOP_HIGH, "aclk_top_high", cpll500_gpll400_gpll300_xin24m_p,
+			CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(73), 0, 2, MFLAGS,
 			RK3568_CLKGATE_CON(33), 0, GFLAGS),
-	COMPOSITE_NODIV(ACLK_TOP_LOW, "aclk_top_low", gpll400_gpll300_gpll200_xin24m_p, 0,
+	COMPOSITE_NODIV(ACLK_TOP_LOW, "aclk_top_low", gpll400_gpll300_gpll200_xin24m_p,
+			CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(73), 4, 2, MFLAGS,
 			RK3568_CLKGATE_CON(33), 1, GFLAGS),
-	COMPOSITE_NODIV(HCLK_TOP, "hclk_top", gpll150_gpll100_gpll75_xin24m_p, 0,
+	COMPOSITE_NODIV(HCLK_TOP, "hclk_top", gpll150_gpll100_gpll75_xin24m_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(73), 8, 2, MFLAGS,
 			RK3568_CLKGATE_CON(33), 2, GFLAGS),
-	COMPOSITE_NODIV(PCLK_TOP, "pclk_top", gpll100_gpll75_cpll50_xin24m_p, 0,
+	COMPOSITE_NODIV(PCLK_TOP, "pclk_top", gpll100_gpll75_cpll50_xin24m_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(73), 12, 2, MFLAGS,
 			RK3568_CLKGATE_CON(33), 3, GFLAGS),
 	GATE(PCLK_PCIE30PHY, "pclk_pcie30phy", "pclk_top", 0,
 			RK3568_CLKGATE_CON(33), 8, GFLAGS),
-	COMPOSITE_NODIV(CLK_OPTC_ARB, "clk_optc_arb", xin24m_cpll100_p, 0,
+	COMPOSITE_NODIV(CLK_OPTC_ARB, "clk_optc_arb", xin24m_cpll100_p, CLK_IS_CRITICAL,
 			RK3568_CLKSEL_CON(73), 15, 1, MFLAGS,
 			RK3568_CLKGATE_CON(33), 9, GFLAGS),
 	GATE(PCLK_MIPICSIPHY, "pclk_mipicsiphy", "pclk_top", 0,
@@ -1464,12 +1471,12 @@ static struct rockchip_clk_branch rk3568_clk_pmu_branches[] __initdata = {
 
 	MUX(CLK_PDPMU, "clk_pdpmu", clk_pdpmu_p, 0,
 			RK3568_PMU_CLKSEL_CON(2), 15, 1, MFLAGS),
-	COMPOSITE_NOMUX(PCLK_PDPMU, "pclk_pdpmu", "clk_pdpmu", 0,
+	COMPOSITE_NOMUX(PCLK_PDPMU, "pclk_pdpmu", "clk_pdpmu", CLK_IS_CRITICAL,
 			RK3568_PMU_CLKSEL_CON(2), 0, 5, DFLAGS,
 			RK3568_PMU_CLKGATE_CON(0), 2, GFLAGS),
-	GATE(PCLK_PMU, "pclk_pmu", "pclk_pdpmu", 0,
+	GATE(PCLK_PMU, "pclk_pmu", "pclk_pdpmu", CLK_IS_CRITICAL,
 			RK3568_PMU_CLKGATE_CON(0), 6, GFLAGS),
-	GATE(CLK_PMU, "clk_pmu", "xin24m", 0,
+	GATE(CLK_PMU, "clk_pmu", "xin24m", CLK_IS_CRITICAL,
 			RK3568_PMU_CLKGATE_CON(0), 7, GFLAGS),
 	GATE(PCLK_I2C0, "pclk_i2c0", "pclk_pdpmu", 0,
 			RK3568_PMU_CLKGATE_CON(1), 0, GFLAGS),
@@ -1573,34 +1580,6 @@ static struct rockchip_clk_branch rk3568_clk_pmu_branches[] __initdata = {
 			RK3568_PMU_CLKSEL_CON(8), 7, 1, MFLAGS),
 };
 
-static const char *const rk3568_cru_critical_clocks[] __initconst = {
-	"armclk",
-	"pclk_core_pre",
-	"aclk_bus",
-	"pclk_bus",
-	"aclk_top_high",
-	"aclk_top_low",
-	"hclk_top",
-	"pclk_top",
-	"aclk_perimid",
-	"hclk_perimid",
-	"aclk_secure_flash",
-	"hclk_secure_flash",
-	"aclk_core_niu2bus",
-	"npll",
-	"clk_optc_arb",
-	"hclk_php",
-	"pclk_php",
-	"hclk_usb",
-	"hclk_vo",
-};
-
-static const char *const rk3568_pmucru_critical_clocks[] __initconst = {
-	"pclk_pdpmu",
-	"pclk_pmu",
-	"clk_pmu",
-};
-
 static void __init rk3568_pmu_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -1628,9 +1607,6 @@ static void __init rk3568_pmu_clk_init(struct device_node *np)
 	rockchip_register_softrst(np, 1, reg_base + RK3568_PMU_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-	rockchip_clk_protect_critical(rk3568_pmucru_critical_clocks,
-				      ARRAY_SIZE(rk3568_pmucru_critical_clocks));
-
 	rockchip_clk_of_add_provider(np, ctx);
 }
 
@@ -1671,9 +1647,6 @@ static void __init rk3568_clk_init(struct device_node *np)
 
 	rockchip_register_restart_notifier(ctx, RK3568_GLB_SRST_FST, NULL);
 
-	rockchip_clk_protect_critical(rk3568_cru_critical_clocks,
-				      ARRAY_SIZE(rk3568_cru_critical_clocks));
-
 	rockchip_clk_of_add_provider(np, ctx);
 }
 
diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 5f49af3c970a..d290a4cf68b5 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -210,7 +210,7 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(ACLK_ENMCORE, "aclkenm_core", "armclk", CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(1), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RV1108_CLKGATE_CON(0), 4, GFLAGS),
-	GATE(ACLK_CORE, "aclk_core", "aclkenm_core", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CORE, "aclk_core", "aclkenm_core", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(11), 0, GFLAGS),
 	GATE(0, "pclk_dbg", "pclken_dbg", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(11), 1, GFLAGS),
@@ -265,10 +265,10 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKGATE_CON(19), 6, GFLAGS),
 
 	/* PD_PMU_wrapper */
-	COMPOSITE_NOMUX(0, "pmu_24m_ena", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pmu_24m_ena", "gpll", CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(38), 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(8), 12, GFLAGS),
-	GATE(0, "pclk_pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_pmu", "pmu_24m_ena", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(10), 0, GFLAGS),
 	GATE(0, "pclk_intmem1", "pmu_24m_ena", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(10), 1, GFLAGS),
@@ -306,7 +306,7 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKSEL_CON(41), 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(9), 12, GFLAGS),
 
-	GATE(0, "pclk_acodecphy", "pclk_top_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_acodecphy", "pclk_top_pre", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(14), 6, GFLAGS),
 	GATE(0, "pclk_usbgrf", "pclk_top_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(14), 14, GFLAGS),
@@ -532,23 +532,23 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKGATE_CON(2), 10, GFLAGS),
 
 	/* PD_BUS */
-	GATE(0, "aclk_bus_src_gpll", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_bus_src_gpll", "gpll", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(1), 0, GFLAGS),
-	GATE(0, "aclk_bus_src_apll", "apll", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_bus_src_apll", "apll", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(1), 1, GFLAGS),
-	GATE(0, "aclk_bus_src_dpll", "dpll", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_bus_src_dpll", "dpll", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(1), 2, GFLAGS),
-	COMPOSITE_NOGATE(ACLK_PRE, "aclk_bus_pre", mux_aclk_bus_src_p, 0,
+	COMPOSITE_NOGATE(ACLK_PRE, "aclk_bus_pre", mux_aclk_bus_src_p, CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus_pre", "aclk_bus_pre", 0,
+	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus_pre", "aclk_bus_pre", CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(3), 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(1), 4, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_bus_pre", "aclk_bus_pre", 0,
+	COMPOSITE_NOMUX(0, "pclk_bus_pre", "aclk_bus_pre", CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(3), 8, 5, DFLAGS,
 			RV1108_CLKGATE_CON(1), 5, GFLAGS),
-	GATE(PCLK_BUS, "pclk_bus", "pclk_bus_pre", 0,
+	GATE(PCLK_BUS, "pclk_bus", "pclk_bus_pre", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(1), 6, GFLAGS),
-	GATE(0, "pclk_top_pre", "pclk_bus_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_top_pre", "pclk_bus_pre", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(1), 7, GFLAGS),
 	GATE(0, "pclk_ddr_pre", "pclk_bus_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(1), 8, GFLAGS),
@@ -669,7 +669,7 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKGATE_CON(0), 9, GFLAGS),
 	GATE(0, "gpll_ddr", "gpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(0), 10, GFLAGS),
-	COMPOSITE_NOGATE(0, "clk_ddrphy_src", mux_ddrphy_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(0, "clk_ddrphy_src", mux_ddrphy_p, CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(4), 8, 2, MFLAGS, 0, 3,
 			DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
 	FACTOR(0, "clk_ddr", "clk_ddrphy_src", 0, 1, 2),
@@ -677,9 +677,9 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 			RV1108_CLKGATE_CON(10), 9, GFLAGS),
 	GATE(0, "pclk_ddrupctl", "pclk_ddr_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(12), 4, GFLAGS),
-	GATE(0, "nclk_ddrupctl", "clk_ddr", CLK_IGNORE_UNUSED,
+	GATE(0, "nclk_ddrupctl", "clk_ddr", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(12), 5, GFLAGS),
-	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_ddrmon", "pclk_ddr_pre", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(12), 6, GFLAGS),
 	GATE(0, "timer_clk", "xin24m", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(0), 11, GFLAGS),
@@ -693,22 +693,22 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 	 */
 
 	/* PD_PERI */
-	COMPOSITE_NOMUX(0, "pclk_periph_pre", "gpll", 0,
+	COMPOSITE_NOMUX(0, "pclk_periph_pre", "gpll", CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(23), 10, 5, DFLAGS,
 			RV1108_CLKGATE_CON(4), 5, GFLAGS),
-	GATE(PCLK_PERI, "pclk_periph", "pclk_periph_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PERI, "pclk_periph", "pclk_periph_pre", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(15), 13, GFLAGS),
-	COMPOSITE_NOMUX(0, "hclk_periph_pre", "gpll", 0,
+	COMPOSITE_NOMUX(0, "hclk_periph_pre", "gpll", CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(23), 5, 5, DFLAGS,
 			RV1108_CLKGATE_CON(4), 4, GFLAGS),
-	GATE(HCLK_PERI, "hclk_periph", "hclk_periph_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_PERI, "hclk_periph", "hclk_periph_pre", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(15), 12, GFLAGS),
 
-	GATE(0, "aclk_peri_src_dpll", "dpll", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_peri_src_dpll", "dpll", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(4), 1, GFLAGS),
-	GATE(0, "aclk_peri_src_gpll", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_peri_src_gpll", "gpll", CLK_IS_CRITICAL,
 			RV1108_CLKGATE_CON(4), 2, GFLAGS),
-	COMPOSITE(ACLK_PERI, "aclk_periph", mux_aclk_peri_src_p, 0,
+	COMPOSITE(ACLK_PERI, "aclk_periph", mux_aclk_peri_src_p, CLK_IS_CRITICAL,
 			RV1108_CLKSEL_CON(23), 15, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(15), 11, GFLAGS),
 
@@ -768,20 +768,6 @@ static struct rockchip_clk_branch rv1108_clk_branches[] __initdata = {
 	MMC(SCLK_EMMC_SAMPLE,  "emmc_sample",  "sclk_emmc",  RV1108_EMMC_CON1,  1),
 };
 
-static const char *const rv1108_critical_clocks[] __initconst = {
-	"aclk_core",
-	"aclk_bus",
-	"hclk_bus",
-	"pclk_bus",
-	"aclk_periph",
-	"hclk_periph",
-	"pclk_periph",
-	"nclk_ddrupctl",
-	"pclk_ddrmon",
-	"pclk_acodecphy",
-	"pclk_pmu",
-};
-
 static void __init rv1108_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -805,8 +791,6 @@ static void __init rv1108_clk_init(struct device_node *np)
 				   RV1108_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rv1108_clk_branches,
 				  ARRAY_SIZE(rv1108_clk_branches));
-	rockchip_clk_protect_critical(rv1108_critical_clocks,
-				      ARRAY_SIZE(rv1108_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rv1126.c b/drivers/clk/rockchip/clk-rv1126.c
index fc19c5522490..8eb0e2dfcb28 100644
--- a/drivers/clk/rockchip/clk-rv1126.c
+++ b/drivers/clk/rockchip/clk-rv1126.c
@@ -189,7 +189,7 @@ static u32 rgmii_mux_idx[]		= { 2, 3, 0, 1 };
 
 static struct rockchip_pll_clock rv1126_pmu_pll_clks[] __initdata = {
 	[gpll] = PLL(pll_rk3328, PLL_GPLL, "gpll",  mux_pll_p,
-		     0, RV1126_PMU_PLL_CON(0),
+		     CLK_IS_CRITICAL, RV1126_PMU_PLL_CON(0),
 		     RV1126_PMU_MODE, 0, 3, 0, rv1126_pll_rates),
 };
 
@@ -201,10 +201,10 @@ static struct rockchip_pll_clock rv1126_pll_clks[] __initdata = {
 		     0, RV1126_PLL_CON(8),
 		     RV1126_MODE_CON, 2, 1, 0, NULL),
 	[cpll] = PLL(pll_rk3328, PLL_CPLL, "cpll", mux_pll_p,
-		     0, RV1126_PLL_CON(16),
+		     CLK_IS_CRITICAL, RV1126_PLL_CON(16),
 		     RV1126_MODE_CON, 4, 2, 0, rv1126_pll_rates),
 	[hpll] = PLL(pll_rk3328, PLL_HPLL, "hpll", mux_pll_p,
-		     0, RV1126_PLL_CON(24),
+		     CLK_IS_CRITICAL, RV1126_PLL_CON(24),
 		     RV1126_MODE_CON, 6, 4, 0, rv1126_pll_rates),
 };
 
@@ -269,7 +269,7 @@ static struct rockchip_clk_branch rv1126_clk_pmu_branches[] __initdata = {
 	 * Clock-Architecture Diagram 2
 	 */
 	/* PD_PMU */
-	COMPOSITE_NOMUX(PCLK_PDPMU, "pclk_pdpmu", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_PDPMU, "pclk_pdpmu", "gpll", CLK_IS_CRITICAL,
 			RV1126_PMU_CLKSEL_CON(1), 0, 5, DFLAGS,
 			RV1126_PMU_CLKGATE_CON(0), 0, GFLAGS),
 
@@ -399,7 +399,7 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 3
 	 */
 	/* PD_CORE */
-	COMPOSITE_NOMUX(0, "pclk_dbg", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_dbg", "armclk", CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(1), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RV1126_CLKGATE_CON(0), 6, GFLAGS),
 	GATE(CLK_CORE_CPUPVTM, "clk_core_cpupvtm", "armclk", 0,
@@ -416,20 +416,20 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 4
 	 */
 	/* PD_BUS */
-	COMPOSITE(0, "aclk_pdbus_pre", mux_gpll_cpll_dpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "aclk_pdbus_pre", mux_gpll_cpll_dpll_p, CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(2), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RV1126_CLKGATE_CON(2), 0, GFLAGS),
-	GATE(ACLK_PDBUS, "aclk_pdbus", "aclk_pdbus_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_PDBUS, "aclk_pdbus", "aclk_pdbus_pre", CLK_IS_CRITICAL,
 			RV1126_CLKGATE_CON(2), 11, GFLAGS),
-	COMPOSITE(0, "hclk_pdbus_pre", mux_hclk_pclk_pdbus_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "hclk_pdbus_pre", mux_hclk_pclk_pdbus_p, CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(2), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RV1126_CLKGATE_CON(2), 1, GFLAGS),
-	GATE(HCLK_PDBUS, "hclk_pdbus", "hclk_pdbus_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_PDBUS, "hclk_pdbus", "hclk_pdbus_pre", CLK_IS_CRITICAL,
 			RV1126_CLKGATE_CON(2), 12, GFLAGS),
-	COMPOSITE(0, "pclk_pdbus_pre", mux_hclk_pclk_pdbus_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "pclk_pdbus_pre", mux_hclk_pclk_pdbus_p, CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(3), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1126_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(PCLK_PDBUS, "pclk_pdbus", "pclk_pdbus_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PDBUS, "pclk_pdbus", "pclk_pdbus_pre", CLK_IS_CRITICAL,
 			RV1126_CLKGATE_CON(2), 13, GFLAGS),
 	/* aclk_dmac is controlled by sgrf_clkgat_con. */
 	SGRF_GATE(ACLK_DMAC, "aclk_dmac", "hclk_pdbus"),
@@ -766,10 +766,10 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 12
 	 */
 	/* PD_PHP */
-	COMPOSITE(ACLK_PDPHP, "aclk_pdphp", mux_gpll_cpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_PDPHP, "aclk_pdphp", mux_gpll_cpll_p, CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(53), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1126_CLKGATE_CON(17), 0, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PDPHP, "hclk_pdphp", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PDPHP, "hclk_pdphp", "gpll", CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(53), 8, 5, DFLAGS,
 			RV1126_CLKGATE_CON(17), 1, GFLAGS),
 	/* PD_SDCARD */
@@ -826,7 +826,8 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 			RV1126_CLKGATE_CON(19), 4, GFLAGS),
 	GATE(HCLK_USBHOST_ARB, "hclk_usbhost_arb", "hclk_pdusb", 0,
 			RV1126_CLKGATE_CON(19), 5, GFLAGS),
-	COMPOSITE(CLK_USBHOST_UTMI_OHCI, "clk_usbhost_utmi_ohci", mux_usb480m_gpll_p, 0,
+	COMPOSITE(CLK_USBHOST_UTMI_OHCI, "clk_usbhost_utmi_ohci", mux_usb480m_gpll_p,
+			CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(61), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RV1126_CLKGATE_CON(19), 6, GFLAGS),
 	GATE(ACLK_USBOTG, "aclk_usbotg", "aclk_pdusb", 0,
@@ -887,7 +888,7 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 	/*
 	 * Clock-Architecture Diagram 15
 	 */
-	GATE(PCLK_PDTOP, "pclk_pdtop", "pclk_pdbus", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PDTOP, "pclk_pdtop", "pclk_pdbus", CLK_IS_CRITICAL,
 			RV1126_CLKGATE_CON(23), 8, GFLAGS),
 	GATE(PCLK_DSIPHY, "pclk_dsiphy", "pclk_pdtop", 0,
 			RV1126_CLKGATE_CON(23), 4, GFLAGS),
@@ -904,7 +905,7 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 3
 	 */
 	/* PD_CORE */
-	COMPOSITE_NOMUX(0, "aclk_core", "armclk", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "aclk_core", "armclk", CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(1), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			RV1126_CLKGATE_CON(0), 2, GFLAGS),
 	GATE(0, "pclk_dbg_daplite", "pclk_dbg", CLK_IGNORE_UNUSED,
@@ -1005,17 +1006,16 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 13
 	 */
 	/* PD_DDR */
-	COMPOSITE_NOMUX(0, "pclk_pdddr_pre", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_pdddr_pre", "gpll", CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(64), 0, 5, DFLAGS,
 			RV1126_CLKGATE_CON(21), 0, GFLAGS),
-	GATE(PCLK_PDDDR, "pclk_pdddr", "pclk_pdddr_pre", CLK_IGNORE_UNUSED,
+	GATE(PCLK_PDDDR, "pclk_pdddr", "pclk_pdddr_pre", CLK_IS_CRITICAL,
 			RV1126_CLKGATE_CON(21), 15, GFLAGS),
 	GATE(0, "pclk_ddr_msch", "pclk_pdddr", CLK_IGNORE_UNUSED,
 			RV1126_CLKGATE_CON(21), 6, GFLAGS),
-	COMPOSITE_NOGATE(SCLK_DDRCLK, "sclk_ddrc", mux_dpll_gpll_p, CLK_IGNORE_UNUSED,
-			 RV1126_CLKSEL_CON(64), 15, 1, MFLAGS, 8, 5, DFLAGS |
-			 CLK_DIVIDER_POWER_OF_TWO),
-	COMPOSITE(CLK_DDRPHY, "clk_ddrphy", mux_dpll_gpll_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(SCLK_DDRCLK, "sclk_ddrc", mux_dpll_gpll_p, CLK_IS_CRITICAL,
+			RV1126_CLKSEL_CON(64), 15, 1, MFLAGS, 8, 5, DFLAGS),
+	COMPOSITE(CLK_DDRPHY, "clk_ddrphy", mux_dpll_gpll_p, CLK_IS_CRITICAL,
 			RV1126_CLKSEL_CON(64), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RV1126_CLKGATE_CON(21), 8, GFLAGS),
 	GATE(0, "clk1x_phy", "clk_ddrphy", CLK_IGNORE_UNUSED,
@@ -1056,28 +1056,6 @@ static struct rockchip_clk_branch rv1126_clk_branches[] __initdata = {
 			RV1126_CLKGATE_CON(23), 0, GFLAGS),
 };
 
-static const char *const rv1126_cru_critical_clocks[] __initconst = {
-	"gpll",
-	"cpll",
-	"hpll",
-	"armclk",
-	"pclk_dbg",
-	"pclk_pdpmu",
-	"aclk_pdbus",
-	"hclk_pdbus",
-	"pclk_pdbus",
-	"aclk_pdphp",
-	"hclk_pdphp",
-	"clk_ddrphy",
-	"pclk_pdddr",
-	"pclk_pdtop",
-	"clk_usbhost_utmi_ohci",
-	"aclk_pdjpeg_niu",
-	"hclk_pdjpeg_niu",
-	"aclk_pdvdec_niu",
-	"hclk_pdvdec_niu",
-};
-
 static void __init rv1126_pmu_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -1143,9 +1121,6 @@ static void __init rv1126_clk_init(struct device_node *np)
 
 	rockchip_register_restart_notifier(ctx, RV1126_GLB_SRST_FST, NULL);
 
-	rockchip_clk_protect_critical(rv1126_cru_critical_clocks,
-				      ARRAY_SIZE(rv1126_cru_critical_clocks));
-
 	rockchip_clk_of_add_provider(np, ctx);
 }
 
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 4059d9365ae6..9f23bd5ee22d 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -596,20 +596,6 @@ void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 }
 EXPORT_SYMBOL_GPL(rockchip_clk_register_armclk);
 
-void rockchip_clk_protect_critical(const char *const clocks[],
-				   int nclocks)
-{
-	int i;
-
-	/* Protect the clocks that needs to stay on */
-	for (i = 0; i < nclocks; i++) {
-		struct clk *clk = __clk_lookup(clocks[i]);
-
-		clk_prepare_enable(clk);
-	}
-}
-EXPORT_SYMBOL_GPL(rockchip_clk_protect_critical);
-
 static void __iomem *rst_base;
 static unsigned int reg_restart;
 static void (*cb_restart)(void);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 758ebaf2236b..4fd3036817f4 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -985,7 +985,6 @@ void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
 			const struct rockchip_cpuclk_reg_data *reg_data,
 			const struct rockchip_cpuclk_rate_table *rates,
 			int nrates);
-void rockchip_clk_protect_critical(const char *const clocks[], int nclocks);
 void rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
 					unsigned int reg, void (*cb)(void));
 
-- 
2.17.1

