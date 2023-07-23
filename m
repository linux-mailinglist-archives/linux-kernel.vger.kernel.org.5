Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828875E3CA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGWQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGWQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:25:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B619A6;
        Sun, 23 Jul 2023 09:25:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668730696a4so1953268b3a.1;
        Sun, 23 Jul 2023 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129497; x=1690734297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4prFBDtTDxUhVTvO99EFoP9a0PGrs/5AlOq53YLHt8=;
        b=YGKTlpNzjPIn1Y9YvwjyQOKhwfSlEByAPdjPFB+1p3HrGOyoo6uCNSBh6dMnFQ9z+D
         5yUgoCKGnZfVoV2qljCucR5ufjbE0zeOHfFyfq4xeOdWILzV8C4r0RJsr6nm16vkkWoU
         Flh6xapSmZwdWZKJtOUn9CEJUY27hUoHxSqXzhl1uvgKq8vv+nrVSliLEpp6YEMlNvSL
         Ph/a1FAamVn+EI3z7ojse1g/z1JoXlzu47dU8tAptYzQiKJyiAaeVe3pvfslSBmWo+1O
         +HwwkZgeWpUar6wBcjU+0QYEFPyIeKsNZzZPtVpNKXq8Ug84PZ5S0BtHwfRbYPA5Nt8M
         T5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129497; x=1690734297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4prFBDtTDxUhVTvO99EFoP9a0PGrs/5AlOq53YLHt8=;
        b=JueHvcK6QZ5bK1Svf1Pw8H0fcC582LCS5zXSN403ESzLI8TRs+r45s7mGnAQgfZYeK
         Mycu5xZN5uq9rOTCgsXd/C85jUHxjjZV/8wiGTA4sLPOCxKRSQ4e5AXaNAz2w8qgu3go
         v73JXedxpcU2GBOjTx+5NlKxseQu+Spxh/YX0NSqdt0LoCu2FYg5NIfzkOSknQU1TPW6
         H3aTkhb7o2K6sVTnodM/J6q+5Dsa8v6Gz93wLg4FN6tyA0rZ8EN5OhwXeHjeh1SHcb/o
         pZWCN7BNfO8z+GjFfDWZ9fWZQQ/o0/K4fV/9zbyIkXFrFiR/C0wHdoTnCBIvFdV+fGil
         pcdA==
X-Gm-Message-State: ABy/qLbXv7XD/N1Da7HbjD+FDKtP9BzW4J2qht/iNvTWAQ8pNI4ZI8j/
        EbZOri5KwYZcwc9L6yL7JtPLMHrUxKlXMzys
X-Google-Smtp-Source: APBJJlHi1ZQEoPa84vS27giKVRnovK0FLIBmII8aUH2BCEWf31AQLSzHepKi4LdH8t6fzAruJCGypw==
X-Received: by 2002:a17:90a:1b0f:b0:262:f0e8:a389 with SMTP id q15-20020a17090a1b0f00b00262f0e8a389mr5463163pjq.36.1690129496909;
        Sun, 23 Jul 2023 09:24:56 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090aae8300b00265a7145fe5sm6883787pjq.41.2023.07.23.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:24:56 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/13] clk: hisilicon: hi3660: Convert into module
Date:   Mon, 24 Jul 2023 00:22:32 +0800
Message-Id: <20230723162245.35033-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230723162245.35033-1-mmyangfl@gmail.com>
References: <20230723162245.35033-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3660.c | 192 ++++++++---------------------
 1 file changed, 53 insertions(+), 139 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 41f61726ab19..9ece1d57cbe6 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -5,9 +5,13 @@
  */
 
 #include <dt-bindings/clock/hi3660-clock.h>
+
 #include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
@@ -469,169 +473,79 @@ static const struct hisi_gate_clock hi3660_iomcu_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x90, 0, 0, },
 };
 
-static struct hisi_clock_data *clk_crgctrl_data;
-
-static void hi3660_clk_iomcu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_iomcu_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
-				   clk_data);
-}
-
-static void hi3660_clk_pmuctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pmu_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3660_pmu_gate_clks,
-			       ARRAY_SIZE(hi3660_pmu_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_iomcu_clks = {
+	.gate_sep_clks = hi3660_iomcu_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
+};
 
-static void hi3660_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pctrl_gate_clks);
+static const struct hisi_clocks hi3660_clk_pmuctrl_clks = {
+	.gate_clks = hi3660_pmu_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pmu_gate_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_pctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_pctrl_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_pctrl_clks = {
+	.gate_clks = hi3660_pctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pctrl_gate_clks),
+};
 
-static void hi3660_clk_sctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_sctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_divider_clks);
+static const struct hisi_clocks hi3660_clk_sctrl_clks = {
+	.mux_clks = hi3660_sctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_sctrl_mux_clks),
+	.divider_clks = hi3660_sctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_sctrl_divider_clks),
+	.gate_clks = hi3660_sctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_clks),
+	.gate_sep_clks = hi3660_sctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_sctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_sctrl_gate_clks), clk_data);
-	hisi_clk_register_gate_sep(hi3660_sctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_mux(hi3660_sctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_sctrl_mux_clks), clk_data);
-	hisi_clk_register_divider(hi3660_sctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_sctrl_divider_clks),
-				  clk_data);
-}
+static const struct hisi_clocks hi3660_clk_crgctrl_clks = {
+	.fixed_rate_clks = hi3660_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3660_fixed_rate_clks),
+	.fixed_factor_clks = hi3660_crg_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
+	.mux_clks = hi3660_crgctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_crgctrl_mux_clks),
+	.divider_clks = hi3660_crgctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_crgctrl_divider_clks),
+	.gate_clks = hi3660_crgctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_clks),
+	.gate_sep_clks = hi3660_crgctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
+};
 
 static void hi3660_clk_crgctrl_early_init(struct device_node *np)
 {
-	int nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_crg_fixed_factor_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_divider_clks);
-	int i;
-
-	clk_crgctrl_data = hisi_clk_init(np, nr);
-	if (!clk_crgctrl_data)
-		return;
-
-	for (i = 0; i < nr; i++)
-		clk_crgctrl_data->clk_data.clks[i] = ERR_PTR(-EPROBE_DEFER);
-
-	hisi_clk_register_fixed_rate(hi3660_fixed_rate_clks,
-				     ARRAY_SIZE(hi3660_fixed_rate_clks),
-				     clk_crgctrl_data);
+	hisi_clk_early_init(np, &hi3660_clk_crgctrl_clks);
 }
 CLK_OF_DECLARE_DRIVER(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl",
 		      hi3660_clk_crgctrl_early_init);
 
-static void hi3660_clk_crgctrl_init(struct device_node *np)
-{
-	struct clk **clks;
-	int i;
-
-	if (!clk_crgctrl_data)
-		hi3660_clk_crgctrl_early_init(np);
-
-	/* clk_crgctrl_data initialization failed */
-	if (!clk_crgctrl_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_crgctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
-				   clk_crgctrl_data);
-	hisi_clk_register_gate(hi3660_crgctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_crgctrl_gate_clks),
-			       clk_crgctrl_data);
-	hisi_clk_register_mux(hi3660_crgctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_crgctrl_mux_clks),
-			      clk_crgctrl_data);
-	hisi_clk_register_fixed_factor(hi3660_crg_fixed_factor_clks,
-				       ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
-				       clk_crgctrl_data);
-	hisi_clk_register_divider(hi3660_crgctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
-				  clk_crgctrl_data);
-
-	clks = clk_crgctrl_data->clk_data.clks;
-	for (i = 0; i < clk_crgctrl_data->clk_data.clk_num; i++) {
-		if (IS_ERR(clks[i]) && PTR_ERR(clks[i]) != -EPROBE_DEFER)
-			pr_err("Failed to register crgctrl clock[%d] err=%ld\n",
-			       i, PTR_ERR(clks[i]));
-	}
-}
-
 static const struct of_device_id hi3660_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3660-crgctrl",
-	  .data = hi3660_clk_crgctrl_init },
+	  .data = &hi3660_clk_crgctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pctrl",
-	  .data = hi3660_clk_pctrl_init },
+	  .data = &hi3660_clk_pctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pmuctrl",
-	  .data = hi3660_clk_pmuctrl_init },
+	  .data = &hi3660_clk_pmuctrl_clks },
 	{ .compatible = "hisilicon,hi3660-sctrl",
-	  .data = hi3660_clk_sctrl_init },
+	  .data = &hi3660_clk_sctrl_clks },
 	{ .compatible = "hisilicon,hi3660-iomcu",
-	  .data = hi3660_clk_iomcu_init },
+	  .data = &hi3660_clk_iomcu_clks },
 	{ }
 };
-
-static int hi3660_clk_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
-	void (*init_func)(struct device_node *np);
-
-	init_func = of_device_get_match_data(dev);
-	if (!init_func)
-		return -ENODEV;
-
-	init_func(np);
-
-	return 0;
-}
+MODULE_DEVICE_TABLE(of, hi3660_clk_match_table);
 
 static struct platform_driver hi3660_clk_driver = {
-	.probe          = hi3660_clk_probe,
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
 	.driver         = {
 		.name   = "hi3660-clk",
 		.of_match_table = hi3660_clk_match_table,
 	},
 };
 
-static int __init hi3660_clk_init(void)
-{
-	return platform_driver_register(&hi3660_clk_driver);
-}
-core_initcall(hi3660_clk_init);
+module_platform_driver(hi3660_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3660 Clock Driver");
-- 
2.40.1

