Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3AD7BB588
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjJFKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjJFKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:40:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CEE109
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:40:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso346376266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696588828; x=1697193628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsvlUk0I/Jmqgi7UvERQUiTfmds5yfl9psPydolMUvs=;
        b=hK/o5DciXYAwDg9A406+q0Z8g7m7yhGnBumj2vZS/fls9ilc7iPGsGYTb64IdUNdZy
         R6dXnzcUySo9A93ofIVrtuL9ZRlz405zIzSUWwY9nMdmikwqLy9YxdB92O5t5u/zhY2D
         6IoOjJy/d1fPIwwF9fb6kNNmuskNPiXGvAhCB6FJnflY5/geiKnkDu5O+A71THuGgNj7
         DP9jonMEf0fFHE0xGDync/Zi4KTsAa2N6LeDrhFBmWFXoSwbQ3wrMQYeH8+Xjw54g4Sc
         RFNlUS8BqGV+Td8JRafpZ2p5TuXRNgUBz8ri03u9FNff5stb/GvUcLDK1UlGl+n4DpQb
         dpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588828; x=1697193628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsvlUk0I/Jmqgi7UvERQUiTfmds5yfl9psPydolMUvs=;
        b=Az1dKpnyfMmybXlUqVioWcKlKRYctLmmnkn3JflDrT2btt+5NV5xNNgovSm9i6gXs4
         xpO+TdqGSdXffaF+D/8drs8whxYNl6zABNt8xlWximfo6zySw5rd35DzfZyBFy9lLTkB
         xdh0sGykxEls1iMND0e5C2JPExID4wC/j4SQgkFYunFPtgAxcfXv6HqnyXoBCKkAeJKW
         GwpgfcBl50lszqzIGzQ6wqCErnIQ4jx94CkKrZ8nG65XKuxyqR4eHhNLAvRJAm7gg6y+
         1K+tax7njyD5mxmE75CWmqwLlEV5fyoIPtZuaOCquv4lq2xc5h62anVNsSTIhyMn4B37
         LvOA==
X-Gm-Message-State: AOJu0YzR9BmDUojjOHy5Unb0IUm6hXo/HX0E6jrHk70BAE40ac73tCog
        HbxwDa1sFPf7jeIHnvS7RGmpXg==
X-Google-Smtp-Source: AGHT+IGmn6jc7KSAoJv7k+t4PYqtTDHM3ZC5bvEOwDH+LSoqrYhZi8jRFY2Q2LvBMEjKEGh0YK8Cyw==
X-Received: by 2002:a17:906:1ba1:b0:9b6:5d6f:cef8 with SMTP id r1-20020a1709061ba100b009b65d6fcef8mr7039253ejg.47.1696588827890;
        Fri, 06 Oct 2023 03:40:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cb349d570sm2642490ejb.185.2023.10.06.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:40:27 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 4/4] clk: renesas: add minimal boot support for RZ/G3S SoC
Date:   Fri,  6 Oct 2023 13:39:59 +0300
Message-Id: <20231006103959.197485-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add minimal clock and reset support for RZ/G3S SoC to be able to boot
Linux from SD Card/eMMC. This includes necessary core clocks for booting
and GIC, SCIF, GPIO, SD0 mod clocks and resets.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected Rb tag
- passed max rate to DEF_G3S_DIV()

Changes in v2:
- used RZ/G3S specific definition for CPG_CLKDIVSTATUS register
- removed CLK_PLL3_DIV2_2, CLK_SD0_DIV, CLK_S0_DIV2
- added space after { and before } in array initializations
- s/indexes/indices/g
- s/.osc/OSC and moved it in core output clocks section
- s/.osc2/OSC2 and moved it in core output clock section
- s/SD0_DIV4/.sd0_div4

 drivers/clk/renesas/Kconfig         |   7 +-
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a08g045-cpg.c | 214 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.c     |   6 +
 drivers/clk/renesas/rzg2l-cpg.h     |   1 +
 5 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 37632a0659d8..69396e197959 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -37,6 +37,7 @@ config CLK_RENESAS
 	select CLK_R9A07G043 if ARCH_R9A07G043
 	select CLK_R9A07G044 if ARCH_R9A07G044
 	select CLK_R9A07G054 if ARCH_R9A07G054
+	select CLK_R9A08G045 if ARCH_R9A08G045
 	select CLK_R9A09G011 if ARCH_R9A09G011
 	select CLK_SH73A0 if ARCH_SH73A0
 
@@ -179,6 +180,10 @@ config CLK_R9A07G054
 	bool "RZ/V2L clock support" if COMPILE_TEST
 	select CLK_RZG2L
 
+config CLK_R9A08G045
+	bool "RZ/G3S clock support" if COMPILE_TEST
+	select CLK_RZG2L
+
 config CLK_R9A09G011
 	bool "RZ/V2M clock support" if COMPILE_TEST
 	select CLK_RZG2L
@@ -215,7 +220,7 @@ config CLK_RCAR_USB2_CLOCK_SEL
 	  This is a driver for R-Car USB2 clock selector
 
 config CLK_RZG2L
-	bool "Renesas RZ/{G2L,G2UL,V2L} family clock support" if COMPILE_TEST
+	bool "Renesas RZ/{G2L,G2UL,G3S,V2L} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
 
 # Generic
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index de907623fe3f..879a07d445f9 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_CLK_R9A06G032)		+= r9a06g032-clocks.o
 obj-$(CONFIG_CLK_R9A07G043)		+= r9a07g043-cpg.o
 obj-$(CONFIG_CLK_R9A07G044)		+= r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+= r9a07g044-cpg.o
+obj-$(CONFIG_CLK_R9A08G045)		+= r9a08g045-cpg.o
 obj-$(CONFIG_CLK_R9A09G011)		+= r9a09g011-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
 
diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
new file mode 100644
index 000000000000..389d32b32168
--- /dev/null
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3S CPG driver
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/r9a08g045-cpg.h>
+
+#include "rzg2l-cpg.h"
+
+/* RZ/G3S Specific registers. */
+#define G3S_CPG_PL2_DDIV		(0x204)
+#define G3S_CPG_SDHI_DDIV		(0x218)
+#define G3S_CPG_PLL_DSEL		(0x240)
+#define G3S_CPG_SDHI_DSEL		(0x244)
+#define G3S_CLKDIVSTATUS		(0x280)
+#define G3S_CLKSELSTATUS		(0x284)
+
+/* RZ/G3S Specific division configuration.  */
+#define G3S_DIVPL2B		DDIV_PACK(G3S_CPG_PL2_DDIV, 4, 3)
+#define G3S_DIV_SDHI0		DDIV_PACK(G3S_CPG_SDHI_DDIV, 0, 1)
+
+/* RZ/G3S Clock status configuration. */
+#define G3S_DIVPL1A_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 0, 1)
+#define G3S_DIVPL2B_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 5, 1)
+#define G3S_DIVPL3A_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 8, 1)
+#define G3S_DIVPL3B_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 9, 1)
+#define G3S_DIVPL3C_STS		DDIV_PACK(G3S_CLKDIVSTATUS, 10, 1)
+#define G3S_DIV_SDHI0_STS	DDIV_PACK(G3S_CLKDIVSTATUS, 24, 1)
+
+#define G3S_SEL_PLL4_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 6, 1)
+#define G3S_SEL_SDHI0_STS	SEL_PLL_PACK(G3S_CLKSELSTATUS, 16, 1)
+
+/* RZ/G3S Specific clocks select. */
+#define G3S_SEL_PLL4		SEL_PLL_PACK(G3S_CPG_PLL_DSEL, 6, 1)
+#define G3S_SEL_SDHI0		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 0, 2)
+
+/* PLL 1/4/6 configuration registers macro. */
+#define G3S_PLL146_CONF(clk1, clk2)	((clk1) << 22 | (clk2) << 12)
+
+#define DEF_G3S_MUX(_name, _id, _conf, _parent_names, _mux_flags, _clk_flags) \
+	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = (_conf), \
+		 .parent_names = (_parent_names), \
+		 .num_parents = ARRAY_SIZE((_parent_names)), \
+		 .mux_flags = CLK_MUX_HIWORD_MASK | (_mux_flags), \
+		 .flag = (_clk_flags))
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R9A08G045_SWD,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+
+	/* Internal Core Clocks */
+	CLK_OSC_DIV1000,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL2_DIV2,
+	CLK_PLL2_DIV2_8,
+	CLK_PLL2_DIV6,
+	CLK_PLL3,
+	CLK_PLL3_DIV2,
+	CLK_PLL3_DIV2_4,
+	CLK_PLL3_DIV2_8,
+	CLK_PLL3_DIV6,
+	CLK_PLL4,
+	CLK_PLL6,
+	CLK_PLL6_DIV2,
+	CLK_SEL_SDHI0,
+	CLK_SEL_PLL4,
+	CLK_P1_DIV2,
+	CLK_P3_DIV2,
+	CLK_SD0_DIV4,
+
+	/* Module Clocks */
+	MOD_CLK_BASE,
+};
+
+/* Divider tables */
+static const struct clk_div_table dtable_1_2[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 0, 0 },
+};
+
+static const struct clk_div_table dtable_1_8[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 2, 4 },
+	{ 3, 8 },
+	{ 0, 0 },
+};
+
+static const struct clk_div_table dtable_1_32[] = {
+	{ 0, 1 },
+	{ 1, 2 },
+	{ 2, 4 },
+	{ 3, 8 },
+	{ 4, 32 },
+	{ 0, 0 },
+};
+
+/* Mux clock names tables. */
+static const char * const sel_sdhi[] = { ".pll2_div2", ".pll6", ".pll2_div6" };
+static const char * const sel_pll4[] = { ".osc_div1000", ".pll4" };
+
+/* Mux clock indices tables. */
+static const u32 mtable_sd[] = { 0, 2, 3 };
+static const u32 mtable_pll4[] = { 0, 1 };
+
+static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal", CLK_EXTAL),
+
+	/* Internal Core Clocks */
+	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
+	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8)),
+	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
+	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
+	DEF_FIXED(".pll4", CLK_PLL4, CLK_EXTAL, 100, 3),
+	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
+	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
+	DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
+	DEF_FIXED(".pll2_div6", CLK_PLL2_DIV6, CLK_PLL2, 1, 6),
+	DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
+	DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
+	DEF_FIXED(".pll3_div2_8", CLK_PLL3_DIV2_8, CLK_PLL3_DIV2, 1, 8),
+	DEF_FIXED(".pll3_div6", CLK_PLL3_DIV6, CLK_PLL3, 1, 6),
+	DEF_FIXED(".pll6_div2", CLK_PLL6_DIV2, CLK_PLL6, 1, 2),
+	DEF_SD_MUX(".sel_sd0", CLK_SEL_SDHI0, G3S_SEL_SDHI0, G3S_SEL_SDHI0_STS, sel_sdhi,
+		   mtable_sd, 0, NULL),
+	DEF_SD_MUX(".sel_pll4", CLK_SEL_PLL4, G3S_SEL_PLL4, G3S_SEL_PLL4_STS, sel_pll4,
+		   mtable_pll4, CLK_SET_PARENT_GATE, NULL),
+
+	/* Core output clk */
+	DEF_G3S_DIV("I", R9A08G045_CLK_I, CLK_PLL1, DIVPL1A, G3S_DIVPL1A_STS, dtable_1_8,
+		    0, 0, 0, NULL),
+	DEF_G3S_DIV("P0", R9A08G045_CLK_P0, CLK_PLL2_DIV2_8, G3S_DIVPL2B, G3S_DIVPL2B_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_G3S_DIV("SD0", R9A08G045_CLK_SD0, CLK_SEL_SDHI0, G3S_DIV_SDHI0, G3S_DIV_SDHI0_STS,
+		    dtable_1_2, 800000000UL, 500000000UL, CLK_SET_RATE_PARENT,
+		    rzg3s_cpg_div_clk_notifier),
+	DEF_FIXED(".sd0_div4", CLK_SD0_DIV4, R9A08G045_CLK_SD0, 1, 4),
+	DEF_FIXED("M0", R9A08G045_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
+	DEF_G3S_DIV("P1", R9A08G045_CLK_P1, CLK_PLL3_DIV2_4, DIVPL3A, G3S_DIVPL3A_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A08G045_CLK_P1, 1, 2),
+	DEF_G3S_DIV("P2", R9A08G045_CLK_P2, CLK_PLL3_DIV2_8, DIVPL3B, G3S_DIVPL3B_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL3C_STS,
+		    dtable_1_32, 0, 0, 0, NULL),
+	DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),
+	DEF_FIXED("S0", R9A08G045_CLK_S0, CLK_SEL_PLL4, 1, 2),
+	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
+	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
+};
+
+static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
+	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0),
+	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
+	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
+	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1),
+	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2),
+	DEF_MOD("sdhi0_aclk",		R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3),
+	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
+	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+};
+
+static const struct rzg2l_reset r9a08g045_resets[] = {
+	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
+	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
+	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
+	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
+	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
+	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+};
+
+static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
+	MOD_CLK_BASE + R9A08G045_GIC600_GICCLK,
+	MOD_CLK_BASE + R9A08G045_IA55_CLK,
+	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
+};
+
+const struct rzg2l_cpg_info r9a08g045_cpg_info = {
+	/* Core Clocks */
+	.core_clks = r9a08g045_core_clks,
+	.num_core_clks = ARRAY_SIZE(r9a08g045_core_clks),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks = r9a08g045_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r9a08g045_crit_mod_clks),
+
+	/* Module Clocks */
+	.mod_clks = r9a08g045_mod_clks,
+	.num_mod_clks = ARRAY_SIZE(r9a08g045_mod_clks),
+	.num_hw_mod_clks = R9A08G045_VBAT_BCLK + 1,
+
+	/* Resets */
+	.resets = r9a08g045_resets,
+	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
+
+	.has_clk_mon_regs = true,
+};
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 49dc6c5c0b0c..d62f1bc1f60e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1706,6 +1706,12 @@ static const struct of_device_id rzg2l_cpg_match[] = {
 		.data = &r9a07g054_cpg_info,
 	},
 #endif
+#ifdef CONFIG_CLK_R9A08G045
+	{
+		.compatible = "renesas,r9a08g045-cpg",
+		.data = &r9a08g045_cpg_info,
+	},
+#endif
 #ifdef CONFIG_CLK_R9A09G011
 	{
 		.compatible = "renesas,r9a09g011-cpg",
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 4755befaf38e..6e38c8fc888c 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -284,6 +284,7 @@ struct rzg2l_cpg_info {
 extern const struct rzg2l_cpg_info r9a07g043_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
+extern const struct rzg2l_cpg_info r9a08g045_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
 int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event, void *data);
-- 
2.39.2

