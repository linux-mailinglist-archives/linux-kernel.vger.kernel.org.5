Return-Path: <linux-kernel+bounces-80001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C8862983
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C6F1F219E0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37EADDDD;
	Sun, 25 Feb 2024 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsS9B0u+"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB511718;
	Sun, 25 Feb 2024 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844016; cv=none; b=oCYDRTkDw5ze+90LM+PVtGZF9CHLSH9E0EAGcE/N7kQxucB6LL7e/pqYPB/iWdnFl4CMO29s6nV8+PY6AoQTrinUjED5YgeA/L8kqq8lDL+4Vt7c/LmdJ+Z75kjsFwwkedixX9sWftOI59pmRK4stD8YHxG2kfBKUDkpIcqIqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844016; c=relaxed/simple;
	bh=kDjlaWOtaAi15FSIPnGipVDQ0pfmAoSiUyUViqFTfbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOBB9FKUvai0ewSVIGXWBztFEnF3lTNg+WGngoMS2+QBSmOYuzvKnMR5cYas4QT4QnTVtbNZN9wqAW5asInwE1qbpm4AGDGK41K+hHJE6Q4L0WnyYvC5lgDEUwDQ0UbHdEj88Duu+l+2qCuXuPVL5rYHX3sNziBNbeR5ZRgPR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsS9B0u+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so2256407b3a.1;
        Sat, 24 Feb 2024 22:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708844014; x=1709448814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIMPgZQPU9m9+OMB8oqq6hvoj2/cVOca7ZCZVaap+Mw=;
        b=ZsS9B0u+qTJr4W0TihApXgCKNn8eWppAeWHTklx9YNLRUHuU8SHj2JhF00j9TDqrIe
         n67vy8sFfoHAJXKOZwTFHo+D57UyT94aMsx1g5xHhpFcJHfRMg4gJgJfdWcdr5geqKQs
         1JoBCc1F9OQkhc5kxHWwYuAgyCQbfedLJcU5sk58t84PrJgYZSLXhCSnRUf2Ff3zke6+
         qDIahr6eBQ6ct+wKtSgMfWUQO9R+QKCUkHOO2etR3vPzfSWJBdNY+blMujPUNFvj7YFR
         DAdEYCC8FfJlWFw9gV8EXjGYqa6QPi7dU2+TyLvV96vOmRWa4uhz4fIA2BItwT9TwjeS
         imhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708844014; x=1709448814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIMPgZQPU9m9+OMB8oqq6hvoj2/cVOca7ZCZVaap+Mw=;
        b=RZ7nUNJr0IlXSZ2VY/8FSFUB0fDtNtzN28W8w8d5+4FbWSocTRN+0RoVB8vNz6Pl9i
         JAIP7dPpI05ph7wpDTz4D2NoIN3dH39bGcupfWtURjT20uwTFjc/rW2e1q5iXz5jIMky
         neqHa3I6/78+ucBrdFa3ezpQ1Uy+dFCUU3H7NnM2Hu2lev4bXERZ81q5yk7nWc52WZ8Q
         GIiIswbJQoDDOsszOszBTlYb9z/xPZlSYnHemTahYSHfglPKQOR0iIHeAw7pbFEMbk7+
         WhEgLYknsFa5H/VwknH06v59PxjCs2Z2YkmZLz44ewmrw2b/Yx7oyW2SXOlewswtc9gp
         S6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlg9oJcyYezgmdnVUE75k7EGWvR5ybJBMb++6aWP1P6frA5Rrp4fpX7KGHCrIU/Q5mcxm3xOAj6qUTdTLUb187n8EsB4cazsLzeJZd
X-Gm-Message-State: AOJu0YyAPh6wG8Y/mql/AIcz5QeE4H9dizKjmG5qpEwbr/MB6Y1lViZv
	fNofdUJaMZOImspzkHaRBeNliwkwSuV/hIxDE0oEfg2/VHLfupWZvIH+JVstfkKpJw==
X-Google-Smtp-Source: AGHT+IFrdV7vTpmWj7BkRaguJWIiLBWXUxDOnsEB/sn4+VY78g6uloHmnq9A8AZqRWjseMjWxfTJsQ==
X-Received: by 2002:aa7:8b84:0:b0:6e4:8df7:d52e with SMTP id r4-20020aa78b84000000b006e48df7d52emr4268385pfd.18.1708844014322;
        Sat, 24 Feb 2024 22:53:34 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:34 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/13] clk: hisilicon: hi3519: Use helper functions
Date: Sun, 25 Feb 2024 14:52:20 +0800
Message-ID: <20240225065234.413687-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225065234.413687-1-mmyangfl@gmail.com>
References: <20240225065234.413687-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3519.c | 127 ++++-------------------------
 1 file changed, 15 insertions(+), 112 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index b871872d9960..cb541de752da 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "clk.h"
-#include "reset.h"
+#include "crg.h"
 
 #define HI3519_INNER_CLK_OFFSET	64
 #define HI3519_FIXED_24M	65
@@ -73,130 +73,33 @@ static const struct hisi_gate_clock hi3519_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xe4, 18, 0, },
 };
 
-static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3519_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
-				     ARRAY_SIZE(hi3519_fixed_rate_clks),
-				     clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_gate_clks),
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
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3519_fixed_rate_clks,
-				ARRAY_SIZE(hi3519_fixed_rate_clks),
-				clk_data);
-
-unregister_mux:
-	hisi_clk_unregister_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				clk_data);
-unregister_gate:
-	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_gate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3519_clk_unregister(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3519_fixed_rate_clks,
-				ARRAY_SIZE(hi3519_fixed_rate_clks),
-				crg->clk_data);
-}
-
-static int hi3519_clk_probe(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = hi3519_clk_register(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static void hi3519_clk_remove(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	hi3519_clk_unregister(pdev);
-}
-
+static const struct hisi_clocks hi3519_crg_clks = {
+	.nr = HI3519_NR_CLKS,
+	.fixed_rate_clks = hi3519_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3519_fixed_rate_clks),
+	.mux_clks = hi3519_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3519_mux_clks),
+	.gate_clks = hi3519_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3519_gate_clks),
+};
 
 static const struct of_device_id hi3519_clk_match_table[] = {
-	{ .compatible = "hisilicon,hi3519-crg" },
+	{ .compatible = "hisilicon,hi3519-crg",
+	  .data = &hi3519_crg_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3519_clk_match_table);
 
 static struct platform_driver hi3519_clk_driver = {
-	.probe          = hi3519_clk_probe,
-	.remove_new	= hi3519_clk_remove,
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
 	.driver         = {
 		.name   = "hi3519-clk",
 		.of_match_table = hi3519_clk_match_table,
 	},
 };
 
-static int __init hi3519_clk_init(void)
-{
-	return platform_driver_register(&hi3519_clk_driver);
-}
-core_initcall(hi3519_clk_init);
-
-static void __exit hi3519_clk_exit(void)
-{
-	platform_driver_unregister(&hi3519_clk_driver);
-}
-module_exit(hi3519_clk_exit);
+module_platform_driver(hi3519_clk_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3519 Clock Driver");
-- 
2.43.0


