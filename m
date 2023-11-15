Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEEE7E946B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjKMCTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMCTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:19:35 -0500
Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com [45.254.49.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4AC11C;
        Sun, 12 Nov 2023 18:19:30 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=DHfRWVuR0Cq6Hu1ukKvbQ1GchqZmqXY2eg2C5LrlnkWsvqGJCkKK3Pi3c7XVOcZzLtGoJ3PKVRXQoc/pfkmQII4DZ5MuA0v5/4jhG/IXBFX7jwT/W8KPysgAu+yjp7sVMtDFrPF2oYkJlmAUt9gz16RSB2oje3v2HUe2TPKO6Es=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=zeqK7RujAsF1hCVIaYLMrcGRVPGjwMvNu7AJFXRZxaI=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id B37C94001CA;
        Mon, 13 Nov 2023 10:18:50 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
Subject: [RESEND PATCH v6 3/3] clk: rockchip: rk3588: Adjust the GATE_LINK parameter
Date:   Mon, 13 Nov 2023 10:18:47 +0800
Message-Id: <20231113021847.28162-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8fTFYdGhkZHhpJGUNKGR9VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
        kG
X-HM-Tid: 0a8bc67977172eb3kusnb37c94001ca
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6GRw6LTw0H1Y*FhADTg0u
        KUswCQhVSlVKTUJCQ09KQkhKTElDVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpITUhNNwY+
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using Id instead of name, if use name needs to use __clk_lookup().
But __clk_lookup() is not exported and is not friendly for GKI.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3588.c | 114 ++++++++++++++++--------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index 6994165e0395..ff71c48f07ab 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -12,28 +12,6 @@
 #include <dt-bindings/clock/rockchip,rk3588-cru.h>
 #include "clk.h"
 
-/*
- * Recent Rockchip SoCs have a new hardware block called Native Interface
- * Unit (NIU), which gates clocks to devices behind them. These effectively
- * need two parent clocks.
- *
- * Downstream enables the linked clock via runtime PM whenever the gate is
- * enabled. This implementation uses separate clock nodes for each of the
- * linked gate clocks, which leaks parts of the clock tree into DT.
- *
- * The GATE_LINK macro instead takes the second parent via 'linkname', but
- * ignores the information. Once the clock framework is ready to handle it, the
- * information should be passed on here. But since these clocks are required to
- * access multiple relevant IP blocks, such as PCIe or USB, we mark all linked
- * clocks critical until a better solution is available. This will waste some
- * power, but avoids leaking implementation details into DT or hanging the
- * system.
- */
-#define GATE_LINK(_id, cname, pname, linkname, f, o, b, gf) \
-	GATE(_id, cname, pname, f, o, b, gf)
-#define RK3588_LINKED_CLK		CLK_IS_CRITICAL
-
-
 #define RK3588_GRF_SOC_STATUS0		0x600
 #define RK3588_PHYREF_ALT_GATE		0xc38
 
@@ -1456,7 +1434,7 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 	COMPOSITE_NODIV(HCLK_NVM_ROOT,  "hclk_nvm_root", mux_200m_100m_50m_24m_p, 0,
 			RK3588_CLKSEL_CON(77), 0, 2, MFLAGS,
 			RK3588_CLKGATE_CON(31), 0, GFLAGS),
-	COMPOSITE(ACLK_NVM_ROOT, "aclk_nvm_root", gpll_cpll_p, RK3588_LINKED_CLK,
+	COMPOSITE(ACLK_NVM_ROOT, "aclk_nvm_root", gpll_cpll_p, 0,
 			RK3588_CLKSEL_CON(77), 7, 1, MFLAGS, 2, 5, DFLAGS,
 			RK3588_CLKGATE_CON(31), 1, GFLAGS),
 	GATE(ACLK_EMMC, "aclk_emmc", "aclk_nvm_root", 0,
@@ -1685,13 +1663,13 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 			RK3588_CLKGATE_CON(42), 9, GFLAGS),
 
 	/* vdpu */
-	COMPOSITE(ACLK_VDPU_ROOT, "aclk_vdpu_root", gpll_cpll_aupll_p, RK3588_LINKED_CLK,
+	COMPOSITE(ACLK_VDPU_ROOT, "aclk_vdpu_root", gpll_cpll_aupll_p, 0,
 			RK3588_CLKSEL_CON(98), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3588_CLKGATE_CON(44), 0, GFLAGS),
 	COMPOSITE_NODIV(ACLK_VDPU_LOW_ROOT, "aclk_vdpu_low_root", mux_400m_200m_100m_24m_p, 0,
 			RK3588_CLKSEL_CON(98), 7, 2, MFLAGS,
 			RK3588_CLKGATE_CON(44), 1, GFLAGS),
-	COMPOSITE_NODIV(HCLK_VDPU_ROOT, "hclk_vdpu_root", mux_200m_100m_50m_24m_p, RK3588_LINKED_CLK,
+	COMPOSITE_NODIV(HCLK_VDPU_ROOT, "hclk_vdpu_root", mux_200m_100m_50m_24m_p, 0,
 			RK3588_CLKSEL_CON(98), 9, 2, MFLAGS,
 			RK3588_CLKGATE_CON(44), 2, GFLAGS),
 	COMPOSITE(ACLK_JPEG_DECODER_ROOT, "aclk_jpeg_decoder_root", gpll_cpll_aupll_spll_p, 0,
@@ -1742,9 +1720,9 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 	COMPOSITE(ACLK_RKVENC0_ROOT, "aclk_rkvenc0_root", gpll_cpll_npll_p, 0,
 			RK3588_CLKSEL_CON(102), 7, 2, MFLAGS, 2, 5, DFLAGS,
 			RK3588_CLKGATE_CON(47), 1, GFLAGS),
-	GATE(HCLK_RKVENC0, "hclk_rkvenc0", "hclk_rkvenc0_root", RK3588_LINKED_CLK,
+	GATE(HCLK_RKVENC0, "hclk_rkvenc0", "hclk_rkvenc0_root", 0,
 			RK3588_CLKGATE_CON(47), 4, GFLAGS),
-	GATE(ACLK_RKVENC0, "aclk_rkvenc0", "aclk_rkvenc0_root", RK3588_LINKED_CLK,
+	GATE(ACLK_RKVENC0, "aclk_rkvenc0", "aclk_rkvenc0_root", 0,
 			RK3588_CLKGATE_CON(47), 5, GFLAGS),
 	COMPOSITE(CLK_RKVENC0_CORE, "clk_rkvenc0_core", gpll_cpll_aupll_npll_p, 0,
 			RK3588_CLKSEL_CON(102), 14, 2, MFLAGS, 9, 5, DFLAGS,
@@ -1754,10 +1732,10 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 			RK3588_CLKGATE_CON(48), 6, GFLAGS),
 
 	/* vi */
-	COMPOSITE(ACLK_VI_ROOT, "aclk_vi_root", gpll_cpll_npll_aupll_spll_p, RK3588_LINKED_CLK,
+	COMPOSITE(ACLK_VI_ROOT, "aclk_vi_root", gpll_cpll_npll_aupll_spll_p, 0,
 			RK3588_CLKSEL_CON(106), 5, 3, MFLAGS, 0, 5, DFLAGS,
 			RK3588_CLKGATE_CON(49), 0, GFLAGS),
-	COMPOSITE_NODIV(HCLK_VI_ROOT, "hclk_vi_root", mux_200m_100m_50m_24m_p, RK3588_LINKED_CLK,
+	COMPOSITE_NODIV(HCLK_VI_ROOT, "hclk_vi_root", mux_200m_100m_50m_24m_p, 0,
 			RK3588_CLKSEL_CON(106), 8, 2, MFLAGS,
 			RK3588_CLKGATE_CON(49), 1, GFLAGS),
 	COMPOSITE_NODIV(PCLK_VI_ROOT, "pclk_vi_root", mux_100m_50m_24m_p, 0,
@@ -1851,8 +1829,6 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 			RK3588_CLKGATE_CON(56), 0, GFLAGS),
 	GATE(PCLK_TRNG0, "pclk_trng0", "pclk_vo0_root", 0,
 			RK3588_CLKGATE_CON(56), 1, GFLAGS),
-	GATE(PCLK_VO0GRF, "pclk_vo0grf", "pclk_vo0_root", CLK_IGNORE_UNUSED,
-			RK3588_CLKGATE_CON(55), 10, GFLAGS),
 	COMPOSITE(CLK_I2S4_8CH_TX_SRC, "clk_i2s4_8ch_tx_src", gpll_aupll_p, 0,
 			RK3588_CLKSEL_CON(118), 5, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3588_CLKGATE_CON(56), 11, GFLAGS),
@@ -1929,10 +1905,10 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 	COMPOSITE(ACLK_VOP_ROOT, "aclk_vop_root", gpll_cpll_dmyaupll_npll_spll_p, 0,
 			RK3588_CLKSEL_CON(110), 5, 3, MFLAGS, 0, 5, DFLAGS,
 			RK3588_CLKGATE_CON(52), 0, GFLAGS),
-	COMPOSITE_NODIV(ACLK_VOP_LOW_ROOT, "aclk_vop_low_root", mux_400m_200m_100m_24m_p, RK3588_LINKED_CLK,
+	COMPOSITE_NODIV(ACLK_VOP_LOW_ROOT, "aclk_vop_low_root", mux_400m_200m_100m_24m_p, 0,
 			RK3588_CLKSEL_CON(110), 8, 2, MFLAGS,
 			RK3588_CLKGATE_CON(52), 1, GFLAGS),
-	COMPOSITE_NODIV(HCLK_VOP_ROOT, "hclk_vop_root", mux_200m_100m_50m_24m_p, RK3588_LINKED_CLK,
+	COMPOSITE_NODIV(HCLK_VOP_ROOT, "hclk_vop_root", mux_200m_100m_50m_24m_p, 0,
 			RK3588_CLKSEL_CON(110), 10, 2, MFLAGS,
 			RK3588_CLKGATE_CON(52), 2, GFLAGS),
 	COMPOSITE_NODIV(PCLK_VOP_ROOT, "pclk_vop_root", mux_100m_50m_24m_p, 0,
@@ -1998,8 +1974,6 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 			RK3588_CLKGATE_CON(60), 9, GFLAGS),
 	GATE(PCLK_TRNG1, "pclk_trng1", "pclk_vo1_root", 0,
 			RK3588_CLKGATE_CON(60), 10, GFLAGS),
-	GATE(0, "pclk_vo1grf", "pclk_vo1_root", CLK_IGNORE_UNUSED,
-			RK3588_CLKGATE_CON(59), 12, GFLAGS),
 	GATE(PCLK_S_EDP0, "pclk_s_edp0", "pclk_vo1_s_root", 0,
 			RK3588_CLKGATE_CON(59), 14, GFLAGS),
 	GATE(PCLK_S_EDP1, "pclk_s_edp1", "pclk_vo1_s_root", 0,
@@ -2433,26 +2407,56 @@ static struct rockchip_clk_branch rk3588_clk_branches[] __initdata = {
 	GATE(ACLK_AV1, "aclk_av1", "aclk_av1_pre", 0,
 			RK3588_CLKGATE_CON(68), 2, GFLAGS),
 
-	GATE_LINK(ACLK_ISP1_PRE, "aclk_isp1_pre", "aclk_isp1_root", "aclk_vi_root", 0, RK3588_CLKGATE_CON(26), 6, GFLAGS),
-	GATE_LINK(HCLK_ISP1_PRE, "hclk_isp1_pre", "hclk_isp1_root", "hclk_vi_root", 0, RK3588_CLKGATE_CON(26), 8, GFLAGS),
-	GATE_LINK(HCLK_NVM, "hclk_nvm", "hclk_nvm_root", "aclk_nvm_root", RK3588_LINKED_CLK, RK3588_CLKGATE_CON(31), 2, GFLAGS),
-	GATE_LINK(ACLK_USB, "aclk_usb", "aclk_usb_root", "aclk_vo1usb_top_root", 0, RK3588_CLKGATE_CON(42), 2, GFLAGS),
-	GATE_LINK(HCLK_USB, "hclk_usb", "hclk_usb_root", "hclk_vo1usb_top_root", 0, RK3588_CLKGATE_CON(42), 3, GFLAGS),
-	GATE_LINK(ACLK_JPEG_DECODER_PRE, "aclk_jpeg_decoder_pre", "aclk_jpeg_decoder_root", "aclk_vdpu_root", 0, RK3588_CLKGATE_CON(44), 7, GFLAGS),
-	GATE_LINK(ACLK_VDPU_LOW_PRE, "aclk_vdpu_low_pre", "aclk_vdpu_low_root", "aclk_vdpu_root", 0, RK3588_CLKGATE_CON(44), 5, GFLAGS),
-	GATE_LINK(ACLK_RKVENC1_PRE, "aclk_rkvenc1_pre", "aclk_rkvenc1_root", "aclk_rkvenc0", 0, RK3588_CLKGATE_CON(48), 3, GFLAGS),
-	GATE_LINK(HCLK_RKVENC1_PRE, "hclk_rkvenc1_pre", "hclk_rkvenc1_root", "hclk_rkvenc0", 0, RK3588_CLKGATE_CON(48), 2, GFLAGS),
-	GATE_LINK(HCLK_RKVDEC0_PRE, "hclk_rkvdec0_pre", "hclk_rkvdec0_root", "hclk_vdpu_root", 0, RK3588_CLKGATE_CON(40), 5, GFLAGS),
-	GATE_LINK(ACLK_RKVDEC0_PRE, "aclk_rkvdec0_pre", "aclk_rkvdec0_root", "aclk_vdpu_root", 0, RK3588_CLKGATE_CON(40), 6, GFLAGS),
-	GATE_LINK(HCLK_RKVDEC1_PRE, "hclk_rkvdec1_pre", "hclk_rkvdec1_root", "hclk_vdpu_root", 0, RK3588_CLKGATE_CON(41), 4, GFLAGS),
-	GATE_LINK(ACLK_RKVDEC1_PRE, "aclk_rkvdec1_pre", "aclk_rkvdec1_root", "aclk_vdpu_root", 0, RK3588_CLKGATE_CON(41), 5, GFLAGS),
-	GATE_LINK(ACLK_HDCP0_PRE, "aclk_hdcp0_pre", "aclk_vo0_root", "aclk_vop_low_root", 0, RK3588_CLKGATE_CON(55), 9, GFLAGS),
-	GATE_LINK(HCLK_VO0, "hclk_vo0", "hclk_vo0_root", "hclk_vop_root", 0, RK3588_CLKGATE_CON(55), 5, GFLAGS),
-	GATE_LINK(ACLK_HDCP1_PRE, "aclk_hdcp1_pre", "aclk_hdcp1_root", "aclk_vo1usb_top_root", 0, RK3588_CLKGATE_CON(59), 6, GFLAGS),
-	GATE_LINK(HCLK_VO1, "hclk_vo1", "hclk_vo1_root", "hclk_vo1usb_top_root", 0, RK3588_CLKGATE_CON(59), 9, GFLAGS),
-	GATE_LINK(ACLK_AV1_PRE, "aclk_av1_pre", "aclk_av1_root", "aclk_vdpu_root", 0, RK3588_CLKGATE_CON(68), 1, GFLAGS),
-	GATE_LINK(PCLK_AV1_PRE, "pclk_av1_pre", "pclk_av1_root", "hclk_vdpu_root", 0, RK3588_CLKGATE_CON(68), 4, GFLAGS),
-	GATE_LINK(HCLK_SDIO_PRE, "hclk_sdio_pre", "hclk_sdio_root", "hclk_nvm", 0, RK3588_CLKGATE_CON(75), 1, GFLAGS),
+	/*
+	 * Recent Rockchip SoCs have a new hardware block called Native Interface
+	 * Unit (NIU), which gates clocks to devices behind them. These effectively
+	 * need two parent clocks.
+	 */
+	GATE_LINK(ACLK_ISP1_PRE, "aclk_isp1_pre", "aclk_isp1_root", ACLK_VI_ROOT, 0,
+			RK3588_CLKGATE_CON(26), 6, GFLAGS),
+	GATE_LINK(HCLK_ISP1_PRE, "hclk_isp1_pre", "hclk_isp1_root", HCLK_VI_ROOT, 0,
+			RK3588_CLKGATE_CON(26), 8, GFLAGS),
+	GATE_LINK(HCLK_NVM, "hclk_nvm", "hclk_nvm_root", ACLK_NVM_ROOT, 0,
+			RK3588_CLKGATE_CON(31), 2, GFLAGS),
+	GATE_LINK(ACLK_USB, "aclk_usb", "aclk_usb_root", ACLK_VO1USB_TOP_ROOT, 0,
+			RK3588_CLKGATE_CON(42), 2, GFLAGS),
+	GATE_LINK(HCLK_USB, "hclk_usb", "hclk_usb_root", HCLK_VO1USB_TOP_ROOT, 0,
+			RK3588_CLKGATE_CON(42), 3, GFLAGS),
+	GATE_LINK(ACLK_JPEG_DECODER_PRE, "aclk_jpeg_decoder_pre", "aclk_jpeg_decoder_root",
+			ACLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(44), 7, GFLAGS),
+	GATE_LINK(ACLK_VDPU_LOW_PRE, "aclk_vdpu_low_pre", "aclk_vdpu_low_root", ACLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(44), 5, GFLAGS),
+	GATE_LINK(ACLK_RKVENC1_PRE, "aclk_rkvenc1_pre", "aclk_rkvenc1_root", ACLK_RKVENC0, 0,
+			RK3588_CLKGATE_CON(48), 3, GFLAGS),
+	GATE_LINK(HCLK_RKVENC1_PRE, "hclk_rkvenc1_pre", "hclk_rkvenc1_root", HCLK_RKVENC0, 0,
+			RK3588_CLKGATE_CON(48), 2, GFLAGS),
+	GATE_LINK(HCLK_RKVDEC0_PRE, "hclk_rkvdec0_pre", "hclk_rkvdec0_root", HCLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(40), 5, GFLAGS),
+	GATE_LINK(ACLK_RKVDEC0_PRE, "aclk_rkvdec0_pre", "aclk_rkvdec0_root", ACLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(40), 6, GFLAGS),
+	GATE_LINK(HCLK_RKVDEC1_PRE, "hclk_rkvdec1_pre", "hclk_rkvdec1_root", HCLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(41), 4, GFLAGS),
+	GATE_LINK(ACLK_RKVDEC1_PRE, "aclk_rkvdec1_pre", "aclk_rkvdec1_root", ACLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(41), 5, GFLAGS),
+	GATE_LINK(ACLK_HDCP0_PRE, "aclk_hdcp0_pre", "aclk_vo0_root", ACLK_VOP_LOW_ROOT, 0,
+			RK3588_CLKGATE_CON(55), 9, GFLAGS),
+	GATE_LINK(HCLK_VO0, "hclk_vo0", "hclk_vo0_root", HCLK_VOP_ROOT, 0,
+			RK3588_CLKGATE_CON(55), 5, GFLAGS),
+	GATE_LINK(ACLK_HDCP1_PRE, "aclk_hdcp1_pre", "aclk_hdcp1_root", ACLK_VO1USB_TOP_ROOT, 0,
+			RK3588_CLKGATE_CON(59), 6, GFLAGS),
+	GATE_LINK(HCLK_VO1, "hclk_vo1", "hclk_vo1_root", HCLK_VO1USB_TOP_ROOT, 0,
+			RK3588_CLKGATE_CON(59), 9, GFLAGS),
+	GATE_LINK(ACLK_AV1_PRE, "aclk_av1_pre", "aclk_av1_root", ACLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(68), 1, GFLAGS),
+	GATE_LINK(PCLK_AV1_PRE, "pclk_av1_pre", "pclk_av1_root", HCLK_VDPU_ROOT, 0,
+			RK3588_CLKGATE_CON(68), 4, GFLAGS),
+	GATE_LINK(HCLK_SDIO_PRE, "hclk_sdio_pre", "hclk_sdio_root", HCLK_NVM, 0,
+			RK3588_CLKGATE_CON(75), 1, GFLAGS),
+	GATE_LINK(PCLK_VO0GRF, "pclk_vo0grf", "pclk_vo0_root", HCLK_VO0, 0,
+			RK3588_CLKGATE_CON(55), 10, GFLAGS),
+	GATE_LINK(0, "pclk_vo1grf", "pclk_vo1_root", HCLK_VO1, CLK_IS_CRITICAL,
+			RK3588_CLKGATE_CON(59), 12, GFLAGS),
 };
 
 static void __init rk3588_clk_init(struct device_node *np)
-- 
2.17.1

