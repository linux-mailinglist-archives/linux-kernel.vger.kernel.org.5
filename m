Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D236769610
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGaMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjGaMUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:20:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836DB1721;
        Mon, 31 Jul 2023 05:20:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686b879f605so2873779b3a.1;
        Mon, 31 Jul 2023 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806029; x=1691410829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ut/KGZwAC+2v839dQLwcvcQk8U05gLP0P//4m43bBU=;
        b=i2kYP3iraN2WcSA2Di8Djet40DoH2fQ3xbrIz2yK9sxHs5NZ7AmzVsFMPNfas93a5Y
         /fc5bqZxMd25ildjoXvVUsXxc1GpF/W9jjyaahNq0XaR1Fc8/t09jZU4v1Oi+J09C1EE
         j/rVmdU+htqpgRreMKW9hjesy2YkDpWzHpSwX1hKGMukdVVaHxYW3noG9QCczRI7cqE9
         lrHfZKKPssOaf4Ro6Y0ScVLBcVY5FSAUTYcFtME0Gf1FLbeDi6THPUYHuRu+g6VZAAJX
         7YURDMTqldJ2w/TBTp6Xx2PU7VfTdtwVk1JXcfd+V6E8i1jl2ETdTddX9fLUG7oyVrjj
         iHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806029; x=1691410829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ut/KGZwAC+2v839dQLwcvcQk8U05gLP0P//4m43bBU=;
        b=RTs/bXZgkidoTTTlqwS6pdpCAX6iWgTbeTqZm0W8+RA05wbJJBKZCozo6Ue4ToeJqx
         HCsyToMJqJHjsiMlKbZNp2Mcz9yMzJiyHNwMKCjsEojAAem76XRUsaEo26cPUgCD0Frb
         9tu/iCQpThmi/rTJlqZUc6CfxO7HCjQAu/r857/fRk8AGxrMpeswHgIefW41gaISqdAZ
         uy0ZnphnFK366a3jkdHstKUICHQ6UDz9wZKabAk8js408ZHcQN+HIDkzr2ik6MySAYwd
         HLjdePO6BbRRn1iGLy0Ev9QK4j4YctIITPLcMvLq5aqk5MeveR39MiglXQJm7fbKpS1K
         f3Mg==
X-Gm-Message-State: ABy/qLY1r0vEiJmgAhvuUH10mUdNrnrN8Dq2CeLWVgdjUY1EoKwch6yK
        +voZx/CbIATuM5J60Iri69jKc3jOdphOuNHrULo=
X-Google-Smtp-Source: APBJJlFoRmQx8USG9jyIWDAyr/mkl6znMFoTDxA/zcmUHFqjBSyFR24szSP9qfYmV+Z+RqQ53HW0Vg==
X-Received: by 2002:a05:6a20:8e07:b0:13d:7aa3:aa5d with SMTP id y7-20020a056a208e0700b0013d7aa3aa5dmr4723094pzj.40.1690806029631;
        Mon, 31 Jul 2023 05:20:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:20:29 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/13] clk: hisilicon: hi3559a: Use helper functions
Date:   Mon, 31 Jul 2023 20:18:06 +0800
Message-Id: <20230731121821.22242-7-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3559a.c | 232 +++++-----------------------
 1 file changed, 38 insertions(+), 194 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index ce4028102bc2..83a46b432ca9 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
+#include <linux/sizes.h>
 
 #include <dt-bindings/clock/hi3559av100-clock.h>
 
@@ -452,21 +452,23 @@ static const struct clk_ops hisi_clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 };
 
-static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
-			   int nums, struct hisi_clock_data *data, struct device *dev)
+static int
+hisi_clk_register_pll(struct device *dev, const void *clocks,
+		      size_t num, struct hisi_clock_data *data)
 {
+	const struct hi3559av100_pll_clock *clks = clocks;
 	void __iomem *base = data->base;
 	struct hi3559av100_clk_pll *p_clk = NULL;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
 	int i;
 
-	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
+	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * num, GFP_KERNEL);
 
 	if (!p_clk)
-		return;
+		return -ENOMEM;
 
-	for (i = 0; i < nums; i++) {
+	for (i = 0; i < num; i++) {
 		init.name = clks[i].name;
 		init.flags = 0;
 		init.parent_names =
@@ -494,78 +496,27 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 			devm_kfree(dev, p_clk);
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(clk);
 		}
 
 		data->clk_data.clks[clks[i].id] = clk;
 		p_clk++;
 	}
-}
-
-static struct hisi_clock_data *hi3559av100_clk_register(
-	struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3559AV100_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-					   ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	hisi_clk_register_pll(hi3559av100_pll_clks,
-			      ARRAY_SIZE(hi3559av100_pll_clks), clk_data, &pdev->dev);
-
-	ret = hisi_clk_register_mux(hi3559av100_mux_clks_crg,
-				    ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3559av100_gate_clks,
-				     ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
-	return ERR_PTR(ret);
-}
 
-static void hi3559av100_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), crg->clk_data);
+	return 0;
 }
 
-static const struct hisi_crg_funcs hi3559av100_crg_funcs = {
-	.register_clks = hi3559av100_clk_register,
-	.unregister_clks = hi3559av100_clk_unregister,
+static const struct hisi_clocks hi3559av100_clks = {
+	.nr = HI3559AV100_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3559av100_fixed_rate_clks_crg,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg),
+	.mux_clks = hi3559av100_mux_clks_crg,
+	.mux_clks_num = ARRAY_SIZE(hi3559av100_mux_clks_crg),
+	.gate_clks = hi3559av100_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3559av100_gate_clks),
+	.customized_clks = hi3559av100_pll_clks,
+	.customized_clks_num = ARRAY_SIZE(hi3559av100_pll_clks),
+	.clk_register_customized = hisi_clk_register_pll,
 };
 
 static struct hisi_fixed_rate_clock hi3559av100_shub_fixed_rate_clks[] = {
@@ -673,7 +624,7 @@ static struct hisi_gate_clock hi3559av100_shub_gate_clks[] = {
 	},
 };
 
-static int hi3559av100_shub_default_clk_set(void)
+static int hi3559av100_shub_default_clk_set(struct device *dev, struct hisi_clock_data *data)
 {
 	void __iomem *crg_base;
 	unsigned int val;
@@ -696,148 +647,41 @@ static int hi3559av100_shub_default_clk_set(void)
 	return 0;
 }
 
-static struct hisi_clock_data *hi3559av100_shub_clk_register(
-	struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data = NULL;
-	int ret;
-
-	hi3559av100_shub_default_clk_set();
-
-	clk_data = hisi_clk_alloc(pdev, HI3559AV100_SHUB_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-					   ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3559av100_shub_mux_clks,
-				    ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_divider(hi3559av100_shub_div_clks,
-					ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = hisi_clk_register_gate(hi3559av100_shub_gate_clks,
-				     ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
-	if (ret)
-		goto unregister_factor;
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
-unregister_factor:
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3559av100_shub_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), crg->clk_data);
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3559av100_shub_crg_funcs = {
-	.register_clks = hi3559av100_shub_clk_register,
-	.unregister_clks = hi3559av100_shub_clk_unregister,
+static const struct hisi_clocks hi3559av100_shub_clks = {
+	.nr = HI3559AV100_SHUB_NR_CLKS,
+	.prologue = hi3559av100_shub_default_clk_set,
+	.fixed_rate_clks = hi3559av100_shub_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks),
+	.mux_clks = hi3559av100_shub_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3559av100_shub_mux_clks),
+	.divider_clks = hi3559av100_shub_div_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3559av100_shub_div_clks),
+	.gate_clks = hi3559av100_shub_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3559av100_shub_gate_clks),
 };
 
 static const struct of_device_id hi3559av100_crg_match_table[] = {
 	{
 		.compatible = "hisilicon,hi3559av100-clock",
-		.data = &hi3559av100_crg_funcs
+		.data = &hi3559av100_clks
 	},
 	{
 		.compatible = "hisilicon,hi3559av100-shub-clock",
-		.data = &hi3559av100_shub_crg_funcs
+		.data = &hi3559av100_shub_clks
 	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3559av100_crg_match_table);
 
-static int hi3559av100_crg_probe(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->funcs = of_device_get_match_data(&pdev->dev);
-	if (!crg->funcs)
-		return -ENOENT;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = crg->funcs->register_clks(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static void hi3559av100_crg_remove(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-}
-
 static struct platform_driver hi3559av100_crg_driver = {
-	.probe		= hi3559av100_crg_probe,
-	.remove_new	= hi3559av100_crg_remove,
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
 	.driver		= {
 		.name	= "hi3559av100-clock",
 		.of_match_table = hi3559av100_crg_match_table,
 	},
 };
 
-static int __init hi3559av100_crg_init(void)
-{
-	return platform_driver_register(&hi3559av100_crg_driver);
-}
-core_initcall(hi3559av100_crg_init);
-
-static void __exit hi3559av100_crg_exit(void)
-{
-	platform_driver_unregister(&hi3559av100_crg_driver);
-}
-module_exit(hi3559av100_crg_exit);
-
+module_platform_driver(hi3559av100_crg_driver);
 
 MODULE_DESCRIPTION("HiSilicon Hi3559AV100 CRG Driver");
-- 
2.40.1

