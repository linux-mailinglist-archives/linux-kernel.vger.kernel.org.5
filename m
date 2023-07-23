Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9924D75E3BF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGWQYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGWQYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:24:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91C120;
        Sun, 23 Jul 2023 09:24:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso1862845a12.1;
        Sun, 23 Jul 2023 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129445; x=1690734245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrFfLWtuEeyZX21Fz2US96pmiJe/UZVkhX3z1c8xfNU=;
        b=Z1OfuxuLPdQ9VJrdKZwX0n4i3ztQZtvR13hI592VBHLywQtUdC1sCe728jOkJY092z
         eRWRF9n1Ij0rQuVO/pqzl+b/o6GWucq4xqntJGZfKK+T/BJwbbAjyp9qLtSfOiOmJ+As
         Ls0SWNQF4tS26pDAHe4R9r0NLlpmkwa8HN5v5e7zDripX1lnOxMhbKGEoB7s79JvbH7Z
         ekZqJBOAQVkNteF4RJNo0IY33EAtHqETLfFJXZmirpSuRoxSyQj9KTqQRjepIKxsZwrU
         VgIPfW3kc0JR/+Upvrx/VeugcRJllOXDTlX8GylN2gatenP1qsiFguPX83t6UPF7pQdz
         ydeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129445; x=1690734245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrFfLWtuEeyZX21Fz2US96pmiJe/UZVkhX3z1c8xfNU=;
        b=fsM/facodGmg+o/CJc+EwuXOqBp30nd/NbvHMdUWW7tQAsG1mES8zsAaWONx+dVPXZ
         knQ/eOM7f7mkaxrWMlSqKEfaGNqslD0rRY/tORi0VZue/kpwdqKwHKVc92WxGWt1ys43
         65EtD+Jcbq27UZDLkedIFL6bZ4l2OhSjvtypUq8h1n1aCZd5KFNugQx7lrBiJd1IbCyP
         2xn16cN8iuoaoyqw72Jey+5RIN2HtzGu0gUBI7xu0SdUjHrS0LJimgJ/snTq3Q35jdwr
         kqunueWfFVFgTOm7QkDAyo9SjYIxJTJ4v/SsZxqR4weHRNMQNGNc2xUz3qa06aGM0w8k
         uqrQ==
X-Gm-Message-State: ABy/qLaD/raHBME1NOiTujgH7etSWpy7kSqHQK+RdZAr18CRih8LX9zf
        Q3o1Idm+7v2DtAzbCm6bMCc3zl2hOHB2EbOB
X-Google-Smtp-Source: APBJJlG+YJxdWbsm3mBUTt9H/4X/wmu/58vn371XNf6qnw0E+76HWNXAEq1x7xCyKfJG0iRjMz5PEg==
X-Received: by 2002:a17:90a:d182:b0:262:f06a:13e0 with SMTP id fu2-20020a17090ad18200b00262f06a13e0mr6512882pjb.5.1690129445024;
        Sun, 23 Jul 2023 09:24:05 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090aae8300b00265a7145fe5sm6883787pjq.41.2023.07.23.09.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:24:04 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/13] clk: hisilicon: hi3798cv200: Use helper functions
Date:   Mon, 24 Jul 2023 00:22:28 +0800
Message-Id: <20230723162245.35033-4-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3798cv200.c | 196 +++---------------------
 1 file changed, 20 insertions(+), 176 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index a0b16be1e25d..c2079bf293b2 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include "clk.h"
 #include "crg.h"
-#include "reset.h"
 
 /* hi3798CV200 core CRG */
 #define HI3798CV200_INNER_CLK_OFFSET		64
@@ -41,6 +40,7 @@
 
 #define HI3798CV200_CRG_NR_CLKS			128
 
+#define HI3798CV200_SYSCTRL_NR_CLKS		16
 static const struct hisi_fixed_rate_clock hi3798cv200_fixed_rate_clks[] = {
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
@@ -193,90 +193,18 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
-static struct hisi_clock_data *hi3798cv200_clk_register(
-				struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	/* hisi_phase_clock is resource managed */
-	ret = hisi_clk_register_phase(&pdev->dev,
-				hi3798cv200_phase_clks,
-				ARRAY_SIZE(hi3798cv200_phase_clks),
-				clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_fixed_rate(hi3798cv200_fixed_rate_clks,
-				     ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				     clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798cv200_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				crg->clk_data);
-	hisi_clk_unregister_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
-	.register_clks = hi3798cv200_clk_register,
-	.unregister_clks = hi3798cv200_clk_unregister,
+static const struct hisi_clocks hi3798cv200_crg_clks = {
+	.nr = HI3798CV200_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3798cv200_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
+	.mux_clks = hi3798cv200_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3798cv200_mux_clks),
+	.phase_clks = hi3798cv200_phase_clks,
+	.phase_clks_num = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.gate_clks = hi3798cv200_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_gate_clks),
 };
 
-/* hi3798CV200 sysctrl CRG */
-
-#define HI3798CV200_SYSCTRL_NR_CLKS 16
-
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
 		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
@@ -286,115 +214,31 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x48, 10, 0, },
 };
 
-static struct hisi_clock_data *hi3798cv200_sysctrl_clk_register(
-					struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_SYSCTRL_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798cv200_sysctrl_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
-	.register_clks = hi3798cv200_sysctrl_clk_register,
-	.unregister_clks = hi3798cv200_sysctrl_clk_unregister,
+static const struct hisi_clocks hi3798cv200_sysctrl_clks = {
+	.nr = HI3798CV200_SYSCTRL_NR_CLKS,
+	.gate_clks = hi3798cv200_sysctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
 };
 
 static const struct of_device_id hi3798cv200_crg_match_table[] = {
 	{ .compatible = "hisilicon,hi3798cv200-crg",
-		.data = &hi3798cv200_crg_funcs },
+		.data = &hi3798cv200_crg_clks },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
-		.data = &hi3798cv200_sysctrl_funcs },
+		.data = &hi3798cv200_sysctrl_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3798cv200_crg_match_table);
 
-static int hi3798cv200_crg_probe(struct platform_device *pdev)
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
-static void hi3798cv200_crg_remove(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-}
-
 static struct platform_driver hi3798cv200_crg_driver = {
-	.probe          = hi3798cv200_crg_probe,
-	.remove_new	= hi3798cv200_crg_remove,
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
 	.driver         = {
 		.name   = "hi3798cv200-crg",
 		.of_match_table = hi3798cv200_crg_match_table,
 	},
 };
 
-static int __init hi3798cv200_crg_init(void)
-{
-	return platform_driver_register(&hi3798cv200_crg_driver);
-}
-core_initcall(hi3798cv200_crg_init);
-
-static void __exit hi3798cv200_crg_exit(void)
-{
-	platform_driver_unregister(&hi3798cv200_crg_driver);
-}
-module_exit(hi3798cv200_crg_exit);
+module_platform_driver(hi3798cv200_crg_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3798CV200 CRG Driver");
-- 
2.40.1

