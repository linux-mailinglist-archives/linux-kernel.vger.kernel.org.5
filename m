Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7046E769616
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjGaMWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGaMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:21:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D919B7;
        Mon, 31 Jul 2023 05:21:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686f090316dso2832217b3a.2;
        Mon, 31 Jul 2023 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806070; x=1691410870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSnN3BCJfqaTSOI9w7xIxc4ZZxFlhc3oORJ8up3814o=;
        b=VBM+eksiW93A6yCVZp6681Io/HAvhk4VeX3zAeeVzdGwCbcTm+3P/WDP293fYGIe6H
         QD3AGnvEhjzwTSYlENNu3a+S4PzmiiMidz2yfzhv4gPpgts6h3mdlM7M/REnK47RaTrs
         U1Gk4g47yyW5k9Zd378lHxpanM5EZNlwZJ/kqEa8EKoZZRkQJdwhJOZufD5qKaN+4oCF
         JxK58Di5ukCD06QWPb9wcZz5AL4aUS9qEI0xQALK42eDmldJ61ICyeoq4QqJQ1VICFQB
         B/0gop0BBGiSHosd1M9tYUjLw/CSvet1sz5BnVjYFsWNP8SHtrT9ZG1cWt/sedVszGhn
         30cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806070; x=1691410870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSnN3BCJfqaTSOI9w7xIxc4ZZxFlhc3oORJ8up3814o=;
        b=QS8xIHVkQprq5cspkuGQR1kWxwVUH3OnuY/w/F7vbiIuLyZV39YMODrJjGTb6g8XQh
         wEHUwOy9Vv+g2t7Qd8pzxXJsYmuQttqFStKwGdXycPyHoxkZZxrBPJvNQDXgB5njuBj+
         /e36u6NBeUrC9ubKGYfIxgv/J536GjV5iTYreC4JB8MI9k6lEtR5kkN1UN4rZYoPCqP5
         Wwbo7+2htSbaJ4VgxcpJmH0ssjc49pPkRdLP5T1gzmanfSC1VTNrC0aLkX3TIglge8ca
         dwO/1Tz6cQONBzFWnPyXSTAThOxvekMhtfawqWaBprMjEcJDGeyZ3PxEPqUFFJRHtDCP
         P/Wg==
X-Gm-Message-State: ABy/qLb9UV4+5skCX+aThTcr7wNEV9w2iU1qgRt+oVPpmLFfw821UrnK
        7dN8UK18L+pw45QlMPELow0ifiu+QlNtMnPA
X-Google-Smtp-Source: APBJJlFPwwLaeaLvU80GxIKdOzfwFFPmAuRa9v5lAisozESB/F+oY6IVMaw/ajAg5a1Za2GlFXzU6w==
X-Received: by 2002:a05:6a20:7fa5:b0:131:f3a:4020 with SMTP id d37-20020a056a207fa500b001310f3a4020mr10909321pzj.33.1690806070299;
        Mon, 31 Jul 2023 05:21:10 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:21:10 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/13] clk: hisilicon: hi3620: Convert into platform driver module
Date:   Mon, 31 Jul 2023 20:18:09 +0800
Message-Id: <20230731121821.22242-10-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731121821.22242-1-mmyangfl@gmail.com>
References: <20230731121821.22242-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/clk/hisilicon/clk-hi3620.c | 189 +++++++++++++++--------------
 1 file changed, 96 insertions(+), 93 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..a08778de8dc2 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -22,48 +23,48 @@
 #include "clk.h"
 
 /* clock parent list */
-static const char *const timer0_mux_p[] __initconst = { "osc32k", "timerclk01", };
-static const char *const timer1_mux_p[] __initconst = { "osc32k", "timerclk01", };
-static const char *const timer2_mux_p[] __initconst = { "osc32k", "timerclk23", };
-static const char *const timer3_mux_p[] __initconst = { "osc32k", "timerclk23", };
-static const char *const timer4_mux_p[] __initconst = { "osc32k", "timerclk45", };
-static const char *const timer5_mux_p[] __initconst = { "osc32k", "timerclk45", };
-static const char *const timer6_mux_p[] __initconst = { "osc32k", "timerclk67", };
-static const char *const timer7_mux_p[] __initconst = { "osc32k", "timerclk67", };
-static const char *const timer8_mux_p[] __initconst = { "osc32k", "timerclk89", };
-static const char *const timer9_mux_p[] __initconst = { "osc32k", "timerclk89", };
-static const char *const uart0_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart1_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart2_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart3_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart4_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const spi0_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
-static const char *const spi1_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
-static const char *const spi2_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
+static const char *const timer0_mux_p[] = { "osc32k", "timerclk01", };
+static const char *const timer1_mux_p[] = { "osc32k", "timerclk01", };
+static const char *const timer2_mux_p[] = { "osc32k", "timerclk23", };
+static const char *const timer3_mux_p[] = { "osc32k", "timerclk23", };
+static const char *const timer4_mux_p[] = { "osc32k", "timerclk45", };
+static const char *const timer5_mux_p[] = { "osc32k", "timerclk45", };
+static const char *const timer6_mux_p[] = { "osc32k", "timerclk67", };
+static const char *const timer7_mux_p[] = { "osc32k", "timerclk67", };
+static const char *const timer8_mux_p[] = { "osc32k", "timerclk89", };
+static const char *const timer9_mux_p[] = { "osc32k", "timerclk89", };
+static const char *const uart0_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart1_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart2_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart3_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart4_mux_p[] = { "osc26m", "pclk", };
+static const char *const spi0_mux_p[] = { "osc26m", "rclk_cfgaxi", };
+static const char *const spi1_mux_p[] = { "osc26m", "rclk_cfgaxi", };
+static const char *const spi2_mux_p[] = { "osc26m", "rclk_cfgaxi", };
 /* share axi parent */
-static const char *const saxi_mux_p[] __initconst = { "armpll3", "armpll2", };
-static const char *const pwm0_mux_p[] __initconst = { "osc32k", "osc26m", };
-static const char *const pwm1_mux_p[] __initconst = { "osc32k", "osc26m", };
-static const char *const sd_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc1_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc1_mux2_p[] __initconst = { "osc26m", "mmc1_div", };
-static const char *const g2d_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const venc_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const vdec_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const vpp_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const edc0_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const ldi0_mux_p[] __initconst = { "armpll2", "armpll4",
+static const char *const saxi_mux_p[] = { "armpll3", "armpll2", };
+static const char *const pwm0_mux_p[] = { "osc32k", "osc26m", };
+static const char *const pwm1_mux_p[] = { "osc32k", "osc26m", };
+static const char *const sd_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc1_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc1_mux2_p[] = { "osc26m", "mmc1_div", };
+static const char *const g2d_mux_p[] = { "armpll2", "armpll3", };
+static const char *const venc_mux_p[] = { "armpll2", "armpll3", };
+static const char *const vdec_mux_p[] = { "armpll2", "armpll3", };
+static const char *const vpp_mux_p[] = { "armpll2", "armpll3", };
+static const char *const edc0_mux_p[] = { "armpll2", "armpll3", };
+static const char *const ldi0_mux_p[] = { "armpll2", "armpll4",
 					     "armpll3", "armpll5", };
-static const char *const edc1_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const ldi1_mux_p[] __initconst = { "armpll2", "armpll4",
+static const char *const edc1_mux_p[] = { "armpll2", "armpll3", };
+static const char *const ldi1_mux_p[] = { "armpll2", "armpll4",
 					     "armpll3", "armpll5", };
-static const char *const rclk_hsic_p[] __initconst = { "armpll3", "armpll2", };
-static const char *const mmc2_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc3_mux_p[] __initconst = { "armpll2", "armpll3", };
+static const char *const rclk_hsic_p[] = { "armpll3", "armpll2", };
+static const char *const mmc2_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc3_mux_p[] = { "armpll2", "armpll3", };
 
 
 /* fixed rate clocks */
-static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] = {
 	{ HI3620_OSC32K,   "osc32k",   NULL, 0, 32768, },
 	{ HI3620_OSC26M,   "osc26m",   NULL, 0, 26000000, },
 	{ HI3620_PCLK,     "pclk",     NULL, 0, 26000000, },
@@ -76,13 +77,13 @@ static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
 };
 
 /* fixed factor clocks */
-static struct hisi_fixed_factor_clock hi3620_fixed_factor_clks[] __initdata = {
+static struct hisi_fixed_factor_clock hi3620_fixed_factor_clks[] = {
 	{ HI3620_RCLK_TCXO,   "rclk_tcxo",   "osc26m",   1, 4,  0, },
 	{ HI3620_RCLK_CFGAXI, "rclk_cfgaxi", "armpll2",  1, 30, 0, },
 	{ HI3620_RCLK_PICO,   "rclk_pico",   "hsic_div", 1, 40, 0, },
 };
 
-static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
+static struct hisi_mux_clock hi3620_mux_clks[] = {
 	{ HI3620_TIMER0_MUX, "timer0_mux", timer0_mux_p, ARRAY_SIZE(timer0_mux_p), CLK_SET_RATE_PARENT, 0,     15, 2, 0,                   },
 	{ HI3620_TIMER1_MUX, "timer1_mux", timer1_mux_p, ARRAY_SIZE(timer1_mux_p), CLK_SET_RATE_PARENT, 0,     17, 2, 0,                   },
 	{ HI3620_TIMER2_MUX, "timer2_mux", timer2_mux_p, ARRAY_SIZE(timer2_mux_p), CLK_SET_RATE_PARENT, 0,     19, 2, 0,                   },
@@ -120,7 +121,7 @@ static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
 	{ HI3620_MMC3_MUX,   "mmc3_mux",   mmc3_mux_p,   ARRAY_SIZE(mmc3_mux_p),   CLK_SET_RATE_PARENT, 0x140, 9,  1, CLK_MUX_HIWORD_MASK, },
 };
 
-static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
+static struct hisi_divider_clock hi3620_div_clks[] = {
 	{ HI3620_SHAREAXI_DIV, "saxi_div",   "saxi_mux",  0, 0x100, 0, 5, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_CFGAXI_DIV,   "cfgaxi_div", "saxi_div",  0, 0x100, 5, 2, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_SD_DIV,       "sd_div",     "sd_mux",	  0, 0x108, 0, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
@@ -130,7 +131,7 @@ static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
 	{ HI3620_MMC3_DIV,     "mmc3_div",   "mmc3_mux",  0, 0x140, 5, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
 };
 
-static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
+static struct hisi_gate_clock hi3620_separated_gate_clks[] = {
 	{ HI3620_TIMERCLK01,   "timerclk01",   "timer_rclk01", CLK_SET_RATE_PARENT, 0x20, 0, 0, },
 	{ HI3620_TIMER_RCLK01, "timer_rclk01", "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x20, 1, 0, },
 	{ HI3620_TIMERCLK23,   "timerclk23",   "timer_rclk23", CLK_SET_RATE_PARENT, 0x20, 2, 0, },
@@ -192,29 +193,19 @@ static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
 	{ HI3620_MCU_CLK,      "mcu_clk",      "acp_clk",      CLK_SET_RATE_PARENT, 0x50, 24, 0, },
 };
 
-static void __init hi3620_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI3620_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hi3620_fixed_rate_clks,
-				     ARRAY_SIZE(hi3620_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_fixed_factor(hi3620_fixed_factor_clks,
-				       ARRAY_SIZE(hi3620_fixed_factor_clks),
-				       clk_data);
-	hisi_clk_register_mux(hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3620_div_clks, ARRAY_SIZE(hi3620_div_clks),
-				  clk_data);
-	hisi_clk_register_gate_sep(hi3620_separated_gate_clks,
-				   ARRAY_SIZE(hi3620_separated_gate_clks),
-				   clk_data);
-}
-CLK_OF_DECLARE(hi3620_clk, "hisilicon,hi3620-clock", hi3620_clk_init);
+static const struct hisi_clocks hi3620_clks = {
+	.nr = HI3620_NR_CLKS,
+	.fixed_rate_clks = hi3620_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3620_fixed_rate_clks),
+	.fixed_factor_clks = hi3620_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3620_fixed_factor_clks),
+	.mux_clks = hi3620_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3620_mux_clks),
+	.divider_clks = hi3620_div_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3620_div_clks),
+	.gate_sep_clks = hi3620_separated_gate_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3620_separated_gate_clks),
+};
 
 struct hisi_mmc_clock {
 	unsigned int		id;
@@ -252,7 +243,7 @@ struct clk_mmc {
 
 #define to_mmc(_hw) container_of(_hw, struct clk_mmc, hw)
 
-static struct hisi_mmc_clock hi3620_mmc_clks[] __initdata = {
+static struct hisi_mmc_clock hi3620_mmc_clks[] = {
 	{ HI3620_SD_CIUCLK,	"sd_bclk1", "sd_clk", CLK_SET_RATE_PARENT, 0x1f8, 0, 0x1f8, 1, 3, 0x1f8, 4, 4, 0x1f8, 8, 4},
 	{ HI3620_MMC_CIUCLK1,   "mmc_bclk1", "mmc_clk1", CLK_SET_RATE_PARENT, 0x1f8, 12, 0x1f8, 13, 3, 0x1f8, 16, 4, 0x1f8, 20, 4},
 	{ HI3620_MMC_CIUCLK2,   "mmc_bclk2", "mmc_clk2", CLK_SET_RATE_PARENT, 0x1f8, 24, 0x1f8, 25, 3, 0x1f8, 28, 4, 0x1fc, 0, 4},
@@ -408,8 +399,9 @@ static const struct clk_ops clk_mmc_ops = {
 	.recalc_rate = mmc_clk_recalc_rate,
 };
 
-static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
-			void __iomem *base, struct device_node *np)
+static struct clk *
+clk_register_hisi_mmc(struct device *dev, const struct hisi_mmc_clock *mmc_clk,
+		      void __iomem *base)
 {
 	struct clk_mmc *mclk;
 	struct clk *clk;
@@ -445,39 +437,50 @@ static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
 	return clk;
 }
 
-static void __init hi3620_mmc_clk_init(struct device_node *node)
+static int hisi_register_clk_mmc(struct device *dev, const void *clocks,
+				 size_t num, struct hisi_clock_data *data)
 {
-	void __iomem *base;
-	int i, num = ARRAY_SIZE(hi3620_mmc_clks);
-	struct clk_onecell_data *clk_data;
+	const struct hisi_mmc_clock *clks = clocks;
 
-	if (!node) {
-		pr_err("failed to find pctrl node in DTS\n");
-		return;
-	}
+	for (int i = 0; i < num; i++) {
+		struct clk *clk = clk_register_hisi_mmc(dev, &clks[i], data->base);
 
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("failed to map pctrl\n");
-		return;
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			return PTR_ERR(clk);
+		}
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (WARN_ON(!clk_data))
-		return;
+	return 0;
+}
 
-	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
-		return;
+static const struct hisi_clocks hi3620_clks_mmc = {
+	.customized_clks = hi3620_mmc_clks,
+	.customized_clks_num = ARRAY_SIZE(hi3620_mmc_clks),
+	.clk_register_customized = hisi_register_clk_mmc,
+};
 
-	for (i = 0; i < num; i++) {
-		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-		clk_data->clks[mmc_clk->id] =
-			hisi_register_clk_mmc(mmc_clk, base, node);
-	}
+static const struct of_device_id hi3620_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi3620-clock",
+	  .data = &hi3620_clks },
+	{ .compatible = "hisilicon,hi3620-mmc-clock",
+	  .data = &hi3620_clks_mmc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi3620_clk_match_table);
+
+static struct platform_driver hi3620_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
+	.driver = {
+		.name = "hi3620-clock",
+		.of_match_table = hi3620_clk_match_table,
+	},
+};
 
-	clk_data->clk_num = num;
-	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-}
+module_platform_driver(hi3620_clk_driver);
 
-CLK_OF_DECLARE(hi3620_mmc_clk, "hisilicon,hi3620-mmc-clock", hi3620_mmc_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon Hi3620 Clock Driver");
-- 
2.40.1

