Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61A769620
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjGaMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjGaMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:22:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59741992;
        Mon, 31 Jul 2023 05:21:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686e0213c0bso2949282b3a.1;
        Mon, 31 Jul 2023 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806111; x=1691410911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO4VB8kjNhkNDNCG7UDzQ3uTczAZ82geNh1f0TcTnsg=;
        b=QeTFblqucIb4/yU5gag7jLOpjAG0Oau1kRE1zP59I2LA5Onaax1Z9QpYY+2bVpaOiM
         qW4DY4oZoN+Tt6CdRgT9czzBV303r5eYYx0zx3xSZ21NpUF67erVL6jh83MzmQ6a3kU9
         +/JkW1pB1QuCQD7mw8jqzUzdxmNY7xK45MbnHqEFGDa7UD1wTiTShsHaW/G8DsdHIIi2
         SZBAz+xZj1Ui3oBpQ+I+/D5IQGFTgYW2De5tN4j0hrNLuoCtRmvDLoqLl2cHDriqKc6A
         zfdR323SZQun0qA+VPJY/nUUK96Mpdbwy5WbHYrkALuup/1SXBd0cs8vOoqpjHaNp7Z2
         xOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806111; x=1691410911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO4VB8kjNhkNDNCG7UDzQ3uTczAZ82geNh1f0TcTnsg=;
        b=EBHQwHe2n/ePU8JgG4zQ2K1edzNyL1YwZg5SEuL74Xluic+vj2jPqknXAZRP8fuoZq
         AJU/OBFKiZMbSFLvRNCgtKBxw94eGo5Vpd5apJ90w0D/N7thU1SevFgYy2nUJDtmcSfC
         AbmschsV43Ml0N9KV4OAFIwd3HHpuEHDP2EmFvMndZ9dEU9WB3SsBgwk/8baZfTHYwBs
         L1DjwTi5i4Pw8uCEM3EzgutxS8yvMIxC5n32+JMvmSoWUWpFG90HEE5C77p3PHWmuaNV
         jtTv46ACsdYsoIUNJJbgon+uZ+OjDiRbIsYSgazdHIYxcxhOKhmDlLbbz+C2eOapaTyr
         qFHA==
X-Gm-Message-State: ABy/qLak1hBHlF6uePQPIuIGgQtf2I4mzXZL1adCbwJ3mxdifC5BM+Rx
        maG4Z5q8Em5qthY8dZRPsFVQnJkqrrfmZvBT
X-Google-Smtp-Source: APBJJlHLdFrN3lT19tDA/nrcKp4B09FZlEUTCHTuM98W/YoEk8TE3MICjJA8JNHtnQnWp7N5D+YaPg==
X-Received: by 2002:a05:6a21:66cb:b0:13b:77e6:4fad with SMTP id ze11-20020a056a2166cb00b0013b77e64fadmr8391391pzb.59.1690806111424;
        Mon, 31 Jul 2023 05:21:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:21:51 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/13] clk: hisilicon: hix5hd2: Convert into platform driver module
Date:   Mon, 31 Jul 2023 20:18:12 +0800
Message-Id: <20230731121821.22242-13-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hix5hd2.c | 85 ++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 64bdd3f05725..6f988a7574b4 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -4,13 +4,17 @@
  * Copyright (c) 2014 Hisilicon Limited.
  */
 
-#include <linux/of_address.h>
 #include <dt-bindings/clock/hix5hd2-clock.h>
+
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
 #include "clk.h"
 
-static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] = {
 	{ HIX5HD2_FIXED_1200M, "1200m", NULL, 0, 1200000000, },
 	{ HIX5HD2_FIXED_400M, "400m", NULL, 0, 400000000, },
 	{ HIX5HD2_FIXED_48M, "48m", NULL, 0, 48000000, },
@@ -43,19 +47,19 @@ static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
 	{ HIX5HD2_FIXED_83M, "83m", NULL, 0, 83333333, },
 };
 
-static const char *const sfc_mux_p[] __initconst = {
+static const char *const sfc_mux_p[] = {
 		"24m", "150m", "200m", "100m", "75m", };
 static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
 
-static const char *const sdio_mux_p[] __initconst = {
+static const char *const sdio_mux_p[] = {
 		"75m", "100m", "50m", "15m", };
 static u32 sdio_mux_table[] = {0, 1, 2, 3};
 
-static const char *const fephy_mux_p[] __initconst = { "25m", "125m"};
+static const char *const fephy_mux_p[] = { "25m", "125m"};
 static u32 fephy_mux_table[] = {0, 1};
 
 
-static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
+static struct hisi_mux_clock hix5hd2_mux_clks[] = {
 	{ HIX5HD2_SFC_MUX, "sfc_mux", sfc_mux_p, ARRAY_SIZE(sfc_mux_p),
 		CLK_SET_RATE_PARENT, 0x5c, 8, 3, 0, sfc_mux_table, },
 	{ HIX5HD2_MMC_MUX, "mmc_mux", sdio_mux_p, ARRAY_SIZE(sdio_mux_p),
@@ -67,7 +71,7 @@ static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
 		CLK_SET_RATE_PARENT, 0x120, 8, 2, 0, fephy_mux_table, },
 };
 
-static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
+static struct hisi_gate_clock hix5hd2_gate_clks[] = {
 	/* sfc */
 	{ HIX5HD2_SFC_CLK, "clk_sfc", "sfc_mux",
 		CLK_SET_RATE_PARENT, 0x5c, 0, 0, },
@@ -153,7 +157,7 @@ struct hix5hd2_clk_complex {
 	u32		phy_rst_mask;
 };
 
-static struct hix5hd2_complex_clock hix5hd2_complex_clks[] __initdata = {
+static struct hix5hd2_complex_clock hix5hd2_complex_clks[] = {
 	{"clk_mac0", "clk_fephy", HIX5HD2_MAC0_CLK,
 		0xcc, 0xa, 0x500, 0x120, 0, 0x10, TYPE_ETHER},
 	{"clk_mac1", "clk_fwd_sys", HIX5HD2_MAC1_CLK,
@@ -249,21 +253,22 @@ static const struct clk_ops clk_complex_ops = {
 	.disable = clk_complex_disable,
 };
 
-static void __init
-hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
+static int
+hix5hd2_clk_register_complex(struct device *dev, const void *clocks, size_t num,
 			     struct hisi_clock_data *data)
 {
+	const struct hix5hd2_complex_clock *clks = clocks;
 	void __iomem *base = data->base;
 	int i;
 
-	for (i = 0; i < nums; i++) {
+	for (i = 0; i < num; i++) {
 		struct hix5hd2_clk_complex *p_clk;
 		struct clk *clk;
 		struct clk_init_data init;
 
 		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
-			return;
+			return -ENOMEM;
 
 		init.name = clks[i].name;
 		if (clks[i].type == TYPE_ETHER)
@@ -289,31 +294,45 @@ hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
 			kfree(p_clk);
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(p_clk);
 		}
 
 		data->clk_data.clks[clks[i].id] = clk;
 	}
-}
 
-static void __init hix5hd2_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HIX5HD2_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hix5hd2_fixed_rate_clks,
-				     ARRAY_SIZE(hix5hd2_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_mux(hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
-					clk_data);
-	hisi_clk_register_gate(hix5hd2_gate_clks,
-			ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
-	hix5hd2_clk_register_complex(hix5hd2_complex_clks,
-				     ARRAY_SIZE(hix5hd2_complex_clks),
-				     clk_data);
+	return 0;
 }
 
-CLK_OF_DECLARE(hix5hd2_clk, "hisilicon,hix5hd2-clock", hix5hd2_clk_init);
+static const struct hisi_clocks hix5hd2_clks = {
+	.nr = HIX5HD2_NR_CLKS,
+	.fixed_rate_clks = hix5hd2_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hix5hd2_fixed_rate_clks),
+	.mux_clks = hix5hd2_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hix5hd2_mux_clks),
+	.gate_clks = hix5hd2_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hix5hd2_gate_clks),
+	.customized_clks = hix5hd2_complex_clks,
+	.customized_clks_num = ARRAY_SIZE(hix5hd2_complex_clks),
+	.clk_register_customized = hix5hd2_clk_register_complex,
+};
+
+static const struct of_device_id hix5hd2_clk_match_table[] = {
+	{ .compatible = "hisilicon,hix5hd2-clock",
+	  .data = &hix5hd2_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hix5hd2_clk_match_table);
+
+static struct platform_driver hix5hd2_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
+	.driver		= {
+		.name	= "hix5hd2-clock",
+		.of_match_table = hix5hd2_clk_match_table,
+	},
+};
+
+module_platform_driver(hix5hd2_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hix5hd2 Clock Driver");
-- 
2.40.1

