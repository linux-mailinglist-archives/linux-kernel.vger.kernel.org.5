Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B276961A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjGaMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjGaMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:21:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338C2115;
        Mon, 31 Jul 2023 05:21:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f1240a22so4074034b3a.0;
        Mon, 31 Jul 2023 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806084; x=1691410884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXzfAG4N6TwCpk4DoqL7m8vRm6P+/nRHCvi921nmTkw=;
        b=h2jGtt1S0vFkHCG8ptTHy0q0OgmxijH6JZgOyS3z1bPR4dlMvpTYQrqWmFOeTlTx15
         VHNu78gBWi91jgx6YNLIo0guPHtoyHtkb9xsgF+g8mXFnhmNctfy0RJi+AAWrxRMotRq
         P6UIdn5+0jsS95S3LcFYP9LtDfTjJfmmmpRc2+cFhvnKMfSNVceET9MscaIOcM4a/xjK
         hsUvZlDmXugjyxP/oFfewQ4RN1TCoVTgU7jgbYzvszH02L6LAVzohA1qHfFPgVBat/Co
         reKHUXcsrqLKtHdQnursWoDltB6d2kxQ3sKtnLpuj2QRtyHPhnBpZ5Wi8t7kyhw6vMMv
         Udcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806084; x=1691410884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXzfAG4N6TwCpk4DoqL7m8vRm6P+/nRHCvi921nmTkw=;
        b=Kj1eu1CGbg+uT6s/gUjcb2k1fZkB0AUBLS7iieDArhB5bbZDX27ngWT1iHG5fQCoM6
         c5KaTv9Ut3U+FXaGm4xRrx5Da8WwfaC7GCF+dOpJzmXqP9CTRQfGZKQH6rLx5fMeKZJ4
         84tfesIyNrJ7A4DfQZ4QQDFjd/7hNXTYnXfJ8AMaB/1Az9WYFyxHtCciN+J4dToLksOY
         uL4XVrwZw6iQpk/K/rzQpG4RTujvZp5YnBZzW0IX4XG8TM2BmSt4GjPu2OJe1TLEvfgJ
         ZLBpgFs/rGvF5lzildv3UmXF1n/jTLhQv1eCwTgs2YflngbN+3YE4fFf1eJlMhn5cc4o
         8sYw==
X-Gm-Message-State: ABy/qLZVm5rMMIBzwvkPQmktNN+tnM/5A6W5G3RCoh5xCKDE2L0Rzbqp
        OpQ7xW4kFArGLDlxuQx/F+lKF6UIr/qo4QIe
X-Google-Smtp-Source: APBJJlHCXY0fMx/F1ljLnXHyP7J0g1Cv2EiqT7IjjKAkz7Hc25J2GvuFNmt86g0GAYbQOdsIlvjHdQ==
X-Received: by 2002:a05:6a00:1797:b0:682:4e4c:48bc with SMTP id s23-20020a056a00179700b006824e4c48bcmr12662550pfg.21.1690806083942;
        Mon, 31 Jul 2023 05:21:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:21:23 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/13] clk: hisilicon: hi6220: Convert into platform driver module
Date:   Mon, 31 Jul 2023 20:18:10 +0800
Message-Id: <20230731121821.22242-11-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731121821.22242-1-mmyangfl@gmail.com>
References: <20230731121821.22242-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi6220.c | 231 ++++++++++++++---------------
 1 file changed, 112 insertions(+), 119 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index e7cdf72d4b06..6eac73408745 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -9,20 +9,24 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hi6220-clock.h>
 
 #include "clk.h"
 
+static int
+hi6220_clk_register_divider_stub(struct device *dev, const void *clks,
+				 size_t num, struct hisi_clock_data *data)
+{
+	/* INCOMPLETE PATCH */
+	hi6220_clk_register_divider(clks, num, data);
+	return 0;
+}
 
 /* clocks in AO (always on) controller */
-static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] = {
 	{ HI6220_REF32K,	"ref32k",	NULL, 0, 32764,     },
 	{ HI6220_CLK_TCXO,	"clk_tcxo",	NULL, 0, 19200000,  },
 	{ HI6220_MMC1_PAD,	"mmc1_pad",	NULL, 0, 100000000, },
@@ -38,7 +42,7 @@ static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] __initdata = {
 	{ HI6220_PLL_DDR,	"ddrpll0",      NULL, 0, 1600000000,},
 };
 
-static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] __initdata = {
+static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] = {
 	{ HI6220_300M,         "clk_300m",    "syspll",          1, 4, 0, },
 	{ HI6220_150M,         "clk_150m",    "clk_300m",        1, 2, 0, },
 	{ HI6220_PICOPHY_SRC,  "picophy_src", "clk_150m",        1, 4, 0, },
@@ -51,7 +55,7 @@ static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] __initdata = {
 	{ HI6220_MMC2_SMP,     "mmc2_sample", "mmc2_sel",        1, 8, 0, },
 };
 
-static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
+static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] = {
 	{ HI6220_WDT0_PCLK,   "wdt0_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 12, 0, },
 	{ HI6220_WDT1_PCLK,   "wdt1_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 13, 0, },
 	{ HI6220_WDT2_PCLK,   "wdt2_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 14, 0, },
@@ -69,47 +73,43 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
 	{ HI6220_RTC1_PCLK,   "rtc1_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 26, 0, },
 };
 
-static void __init hi6220_clk_ao_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data_ao;
-
-	clk_data_ao = hisi_clk_init(np, HI6220_AO_NR_CLKS);
-	if (!clk_data_ao)
-		return;
-
-	hisi_clk_register_fixed_rate(hi6220_fixed_rate_clks,
-				ARRAY_SIZE(hi6220_fixed_rate_clks), clk_data_ao);
-
-	hisi_clk_register_fixed_factor(hi6220_fixed_factor_clks,
-				ARRAY_SIZE(hi6220_fixed_factor_clks), clk_data_ao);
+static const struct hisi_clocks hi6220_ao_clks = {
+	.nr = HI6220_AO_NR_CLKS,
+	.fixed_rate_clks = hi6220_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi6220_fixed_rate_clks),
+	.fixed_factor_clks = hi6220_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi6220_fixed_factor_clks),
+	.gate_sep_clks = hi6220_separated_gate_clks_ao,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_ao),
+};
 
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
-				ARRAY_SIZE(hi6220_separated_gate_clks_ao), clk_data_ao);
+static void hi6220_clk_ao_early_init(struct device_node *np)
+{
+	hisi_clk_early_init(np, &hi6220_ao_clks);
 }
 /* Allow reset driver to probe as well */
-CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
-
+CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_early_init);
 
 /* clocks in sysctrl */
-static const char *mmc0_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc0_mux1_p[] __initdata = { "mmc0_mux0", "pll_media_gate", };
-static const char *mmc0_src_p[] __initdata = { "mmc0srcsel", "mmc0_div", };
-static const char *mmc1_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc1_mux1_p[] __initdata = { "mmc1_mux0", "pll_media_gate", };
-static const char *mmc1_src_p[]  __initdata = { "mmc1srcsel", "mmc1_div", };
-static const char *mmc2_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc2_mux1_p[] __initdata = { "mmc2_mux0", "pll_media_gate", };
-static const char *mmc2_src_p[]  __initdata = { "mmc2srcsel", "mmc2_div", };
-static const char *mmc0_sample_in[] __initdata = { "mmc0_sample", "mmc0_pad", };
-static const char *mmc1_sample_in[] __initdata = { "mmc1_sample", "mmc1_pad", };
-static const char *mmc2_sample_in[] __initdata = { "mmc2_sample", "mmc2_pad", };
-static const char *uart1_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart2_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart3_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart4_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *hifi_src[] __initdata = { "syspll", "pll_media_gate", };
-
-static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
+static const char *const mmc0_mux0_p[] = { "pll_ddr_gate", "syspll", };
+static const char *const mmc0_mux1_p[] = { "mmc0_mux0", "pll_media_gate", };
+static const char *const mmc0_src_p[] = { "mmc0srcsel", "mmc0_div", };
+static const char *const mmc1_mux0_p[] = { "pll_ddr_gate", "syspll", };
+static const char *const mmc1_mux1_p[] = { "mmc1_mux0", "pll_media_gate", };
+static const char *const mmc1_src_p[]  = { "mmc1srcsel", "mmc1_div", };
+static const char *const mmc2_mux0_p[] = { "pll_ddr_gate", "syspll", };
+static const char *const mmc2_mux1_p[] = { "mmc2_mux0", "pll_media_gate", };
+static const char *const mmc2_src_p[]  = { "mmc2srcsel", "mmc2_div", };
+static const char *const mmc0_sample_in[] = { "mmc0_sample", "mmc0_pad", };
+static const char *const mmc1_sample_in[] = { "mmc1_sample", "mmc1_pad", };
+static const char *const mmc2_sample_in[] = { "mmc2_sample", "mmc2_pad", };
+static const char *const uart1_src[] = { "clk_tcxo", "clk_150m", };
+static const char *const uart2_src[] = { "clk_tcxo", "clk_150m", };
+static const char *const uart3_src[] = { "clk_tcxo", "clk_150m", };
+static const char *const uart4_src[] = { "clk_tcxo", "clk_150m", };
+static const char *const hifi_src[] = { "syspll", "pll_media_gate", };
+
+static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] = {
 	{ HI6220_MMC0_CLK,      "mmc0_clk",      "mmc0_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 0,  0, },
 	{ HI6220_MMC0_CIUCLK,   "mmc0_ciuclk",   "mmc0_smp_in",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 0,  0, },
 	{ HI6220_MMC1_CLK,      "mmc1_clk",      "mmc1_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 1,  0, },
@@ -146,7 +146,7 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
 	{ HI6220_CS_ATB_SYSPLL, "cs_atb_syspll", "syspll",         CLK_SET_RATE_PARENT|CLK_IS_CRITICAL,   0x270, 12, 0, },
 };
 
-static struct hisi_mux_clock hi6220_mux_clks_sys[] __initdata = {
+static struct hisi_mux_clock hi6220_mux_clks_sys[] = {
 	{ HI6220_MMC0_SRC,    "mmc0_src",    mmc0_src_p,     ARRAY_SIZE(mmc0_src_p),     CLK_SET_RATE_PARENT, 0x4,   0,  1, 0, },
 	{ HI6220_MMC0_SMP_IN, "mmc0_smp_in", mmc0_sample_in, ARRAY_SIZE(mmc0_sample_in), CLK_SET_RATE_PARENT, 0x4,   0,  1, 0, },
 	{ HI6220_MMC1_SRC,    "mmc1_src",    mmc1_src_p,     ARRAY_SIZE(mmc1_src_p),     CLK_SET_RATE_PARENT, 0x4,   2,  1, 0, },
@@ -166,7 +166,7 @@ static struct hisi_mux_clock hi6220_mux_clks_sys[] __initdata = {
 	{ HI6220_MMC2_MUX1,   "mmc2_mux1",   mmc2_mux1_p,    ARRAY_SIZE(mmc2_mux1_p),    CLK_SET_RATE_PARENT, 0x400, 15, 1, CLK_MUX_HIWORD_MASK,},
 };
 
-static struct hi6220_divider_clock hi6220_div_clks_sys[] __initdata = {
+static struct hi6220_divider_clock hi6220_div_clks_sys[] = {
 	{ HI6220_CLK_BUS,     "clk_bus",     "clk_300m",      CLK_SET_RATE_PARENT, 0x490, 0,  4, 7, },
 	{ HI6220_MMC0_DIV,    "mmc0_div",    "mmc0_syspll",   CLK_SET_RATE_PARENT, 0x494, 0,  6, 7, },
 	{ HI6220_MMC1_DIV,    "mmc1_div",    "mmc1_syspll",   CLK_SET_RATE_PARENT, 0x498, 0,  6, 7, },
@@ -177,32 +177,23 @@ static struct hi6220_divider_clock hi6220_div_clks_sys[] __initdata = {
 	{ HI6220_CS_ATB_DIV,  "cs_atb_div",  "cs_atb_syspll", CLK_SET_RATE_PARENT, 0x4a4, 0,  4, 7, },
 };
 
-static void __init hi6220_clk_sys_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI6220_SYS_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_sys,
-			ARRAY_SIZE(hi6220_separated_gate_clks_sys), clk_data);
-
-	hisi_clk_register_mux(hi6220_mux_clks_sys,
-			ARRAY_SIZE(hi6220_mux_clks_sys), clk_data);
-
-	hi6220_clk_register_divider(hi6220_div_clks_sys,
-			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
-}
-CLK_OF_DECLARE_DRIVER(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
-
+static const struct hisi_clocks hi6220_sys_clks = {
+	.nr = HI6220_SYS_NR_CLKS,
+	.mux_clks = hi6220_mux_clks_sys,
+	.mux_clks_num = ARRAY_SIZE(hi6220_mux_clks_sys),
+	.gate_sep_clks = hi6220_separated_gate_clks_sys,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_sys),
+	.customized_clks = hi6220_div_clks_sys,
+	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_sys),
+	.clk_register_customized = hi6220_clk_register_divider_stub,
+};
 
 /* clocks in media controller */
-static const char *clk_1000_1200_src[] __initdata = { "pll_gpu_gate", "media_syspll_src", };
-static const char *clk_1440_1200_src[] __initdata = { "media_syspll_src", "media_pll_src", };
-static const char *clk_1000_1440_src[] __initdata = { "pll_gpu_gate", "media_pll_src", };
+static const char *const clk_1000_1200_src[] = { "pll_gpu_gate", "media_syspll_src", };
+static const char *const clk_1440_1200_src[] = { "media_syspll_src", "media_pll_src", };
+static const char *const clk_1000_1440_src[] = { "pll_gpu_gate", "media_pll_src", };
 
-static struct hisi_gate_clock hi6220_separated_gate_clks_media[] __initdata = {
+static struct hisi_gate_clock hi6220_separated_gate_clks_media[] = {
 	{ HI6220_DSI_PCLK,       "dsi_pclk",         "vpucodec",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 0,  0, },
 	{ HI6220_G3D_PCLK,       "g3d_pclk",         "vpucodec",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 1,  0, },
 	{ HI6220_ACLK_CODEC_VPU, "aclk_codec_vpu",   "ade_core_src",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 3,  0, },
@@ -218,13 +209,13 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_media[] __initdata = {
 	{ HI6220_MED_SYSPLL,     "media_syspll_src", "media_syspll",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 17, 0, },
 };
 
-static struct hisi_mux_clock hi6220_mux_clks_media[] __initdata = {
+static struct hisi_mux_clock hi6220_mux_clks_media[] = {
 	{ HI6220_1440_1200, "clk_1440_1200", clk_1440_1200_src, ARRAY_SIZE(clk_1440_1200_src), CLK_SET_RATE_PARENT, 0x51c, 0, 1, 0, },
 	{ HI6220_1000_1200, "clk_1000_1200", clk_1000_1200_src, ARRAY_SIZE(clk_1000_1200_src), CLK_SET_RATE_PARENT, 0x51c, 1, 1, 0, },
 	{ HI6220_1000_1440, "clk_1000_1440", clk_1000_1440_src, ARRAY_SIZE(clk_1000_1440_src), CLK_SET_RATE_PARENT, 0x51c, 6, 1, 0, },
 };
 
-static struct hi6220_divider_clock hi6220_div_clks_media[] __initdata = {
+static struct hi6220_divider_clock hi6220_div_clks_media[] = {
 	{ HI6220_CODEC_JPEG,    "codec_jpeg_aclk", "media_pll_src",  CLK_SET_RATE_PARENT, 0xcbc, 0,  4, 23, },
 	{ HI6220_ISP_SCLK_SRC,  "isp_sclk_src",    "isp_sclk_gate",  CLK_SET_RATE_PARENT, 0xcbc, 8,  4, 15, },
 	{ HI6220_ISP_SCLK1,     "isp_sclk1",       "isp_sclk_gate1", CLK_SET_RATE_PARENT, 0xcbc, 24, 4, 31, },
@@ -234,28 +225,19 @@ static struct hi6220_divider_clock hi6220_div_clks_media[] __initdata = {
 	{ HI6220_CODEC_VPU_SRC, "codec_vpu_src",   "codec_vpu_gate", CLK_SET_RATE_PARENT, 0xcc4, 24, 6, 31, },
 };
 
-static void __init hi6220_clk_media_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI6220_MEDIA_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_media,
-				ARRAY_SIZE(hi6220_separated_gate_clks_media), clk_data);
-
-	hisi_clk_register_mux(hi6220_mux_clks_media,
-				ARRAY_SIZE(hi6220_mux_clks_media), clk_data);
-
-	hi6220_clk_register_divider(hi6220_div_clks_media,
-				ARRAY_SIZE(hi6220_div_clks_media), clk_data);
-}
-CLK_OF_DECLARE_DRIVER(hi6220_clk_media, "hisilicon,hi6220-mediactrl", hi6220_clk_media_init);
-
+static const struct hisi_clocks hi6220_media_clks = {
+	.nr = HI6220_MEDIA_NR_CLKS,
+	.mux_clks = hi6220_mux_clks_media,
+	.mux_clks_num = ARRAY_SIZE(hi6220_mux_clks_media),
+	.gate_sep_clks = hi6220_separated_gate_clks_media,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_media),
+	.customized_clks = hi6220_div_clks_media,
+	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_media),
+	.clk_register_customized = hi6220_clk_register_divider_stub,
+};
 
 /* clocks in pmctrl */
-static struct hisi_gate_clock hi6220_gate_clks_power[] __initdata = {
+static struct hisi_gate_clock hi6220_gate_clks_power[] = {
 	{ HI6220_PLL_GPU_GATE,   "pll_gpu_gate",   "gpupll",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x8,  0,  0, },
 	{ HI6220_PLL1_DDR_GATE,  "pll1_ddr_gate",  "ddrpll1",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x10, 0,  0, },
 	{ HI6220_PLL_DDR_GATE,   "pll_ddr_gate",   "ddrpll0",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x18, 0,  0, },
@@ -263,26 +245,19 @@ static struct hisi_gate_clock hi6220_gate_clks_power[] __initdata = {
 	{ HI6220_PLL0_BBP_GATE,  "pll0_bbp_gate",  "bbppll0",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x48, 0,  0, },
 };
 
-static struct hi6220_divider_clock hi6220_div_clks_power[] __initdata = {
+static struct hi6220_divider_clock hi6220_div_clks_power[] = {
 	{ HI6220_DDRC_SRC,  "ddrc_src",  "ddr_sel_src", CLK_SET_RATE_PARENT, 0x5a8, 0, 4, 0, },
 	{ HI6220_DDRC_AXI1, "ddrc_axi1", "ddrc_src",    CLK_SET_RATE_PARENT, 0x5a8, 8, 2, 0, },
 };
 
-static void __init hi6220_clk_power_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI6220_POWER_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi6220_gate_clks_power,
-				ARRAY_SIZE(hi6220_gate_clks_power), clk_data);
-
-	hi6220_clk_register_divider(hi6220_div_clks_power,
-				ARRAY_SIZE(hi6220_div_clks_power), clk_data);
-}
-CLK_OF_DECLARE(hi6220_clk_power, "hisilicon,hi6220-pmctrl", hi6220_clk_power_init);
+static const struct hisi_clocks hi6220_power_clks = {
+	.nr = HI6220_POWER_NR_CLKS,
+	.gate_clks = hi6220_gate_clks_power,
+	.gate_clks_num = ARRAY_SIZE(hi6220_gate_clks_power),
+	.customized_clks = hi6220_div_clks_power,
+	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_power),
+	.clk_register_customized = hi6220_clk_register_divider_stub,
+};
 
 /* clocks in acpu */
 static const struct hisi_gate_clock hi6220_acpu_sc_gate_sep_clks[] = {
@@ -290,18 +265,36 @@ static const struct hisi_gate_clock hi6220_acpu_sc_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0xc, 11, 0, },
 };
 
-static void __init hi6220_clk_acpu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks);
+static const struct hisi_clocks hi6220_acpu_clks = {
+	.gate_sep_clks = hi6220_acpu_sc_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
+static const struct of_device_id hi6220_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi6220-aoctrl",
+	  .data = &hi6220_ao_clks },
+	{ .compatible = "hisilicon,hi6220-sysctrl",
+	  .data = &hi6220_sys_clks },
+	{ .compatible = "hisilicon,hi6220-mediactrl",
+	  .data = &hi6220_media_clks },
+	{ .compatible = "hisilicon,hi6220-pmctrl",
+	  .data = &hi6220_power_clks },
+	{ .compatible = "hisilicon,hi6220-acpu-sctrl",
+	  .data = &hi6220_acpu_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi6220_clk_match_table);
+
+static struct platform_driver hi6220_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
+	.driver		= {
+		.name	= "hi6220-clock",
+		.of_match_table = hi6220_clk_match_table,
+	},
+};
 
-	hisi_clk_register_gate_sep(hi6220_acpu_sc_gate_sep_clks,
-				   ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks),
-				   clk_data);
-}
+module_platform_driver(hi6220_clk_driver);
 
-CLK_OF_DECLARE(hi6220_clk_acpu, "hisilicon,hi6220-acpu-sctrl", hi6220_clk_acpu_init);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi6220 Clock Driver");
-- 
2.40.1

