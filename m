Return-Path: <linux-kernel+bounces-139919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21978A0924
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A41A1F21F44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426113DDB7;
	Thu, 11 Apr 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzoDDAdB"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A913E401;
	Thu, 11 Apr 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819187; cv=none; b=g3boEItyRE4U3rGbjdQXghu341NGVxjxxqKp1dEAbdltdwhNmewvqZN+LN2JT9aO42e4nY+B76GCh8f4OeAebFy1LqktMa7W6njGngMGNMuwAX1N/Ea121bGBmhqMxjEm4SGYWblE3oE0xiYejEAGoZFG9PK88QZMBK9o6SasEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819187; c=relaxed/simple;
	bh=jqDNrGAyxsYzMLYgVvkvn3DsQMoDqzG2Abl6HqZwq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEgbOwZcDNIAytvo5pEHrGKmRwHnXhweZpshES8zFu7R4TY07QIwy8ZDzdkyQxq8rE/GfTmbJQDptI4DXTIPtDea7lF2NQYDWLj1oBY7lkPxSxU+USdfShg5aY+CsxUAViYWW0OTtJq53JVMYK+zgFf8F4BFpd10DJDVgOEIZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzoDDAdB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so4479349a12.3;
        Thu, 11 Apr 2024 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819185; x=1713423985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC6rG1fD3ItI1XoGthXm2AMsyO+JK9+EA6lFFhllInI=;
        b=UzoDDAdBPipNhPjmSiKsBwrVYM9Nmy4moDoOo8TjEVgqA1+9hK/8siV8Vh31oHjkIl
         blWoWZs2rB3zt4Jh4SzgvjTZs+0sfIdlLqPyAauKFVgFKBwh1+rQAJ32aSviA46t+k92
         ayXU40MWa1aM7xYA7AJHvD8HWjTgD9YYHKC3HfmaTZOviMg63LKnfzM4s6MlFv1XI40E
         F8cFtieVxo77HFgQLAD2PJh2UvaaCj7EahQJjG6t4hL0O75AmH/zel4eRuOXTjOAGIFq
         4XKCtZbqjMiiTf2AWs+fFEklx2TW+CATLkDG3UwebdJ4khYGAXG7Dsac6bz+1NJTm3k8
         ZqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819185; x=1713423985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC6rG1fD3ItI1XoGthXm2AMsyO+JK9+EA6lFFhllInI=;
        b=XMVeEpLSZJ3XIhd/ejE7GW6PokfVg/m2uGU2l3sEY1HUWTy3+D/B5FFPE2I8HBdPoc
         wR8+fET2pHB/v+386/ECteU78obyXNQ4rcFEuiM0glm1h9hntmAxvRKWmjDoUSvWSFOo
         kQTsC04otVW9Fa5gyA4S+mHcVsot3R70RKSBi/LyH95WjfNND1kPVShR4EcnvmiB2B6F
         mxBAzn3Xodyp/yHgCScLP8gat7dlgrynSepkvkxODP/N7NzjOOXQfzLuycAa2hXp8b8Q
         5/gSTC3mlPv2B+ELLggqP2gTXVrgxQFxZCg0OscLmUJAqz1DKrnkoK5X3cTorxB65jul
         yiew==
X-Forwarded-Encrypted: i=1; AJvYcCWrP0TQjmrNMuxQT9DtCXK/zpA9RRObuVK0FI6LKjRMjOgf1LuLOLq8i9oNNfye04YiWM/rXiIFnl4B+u2T5AMAu0lwEgr3t3YEqGT0
X-Gm-Message-State: AOJu0YykavXGa3KaCh1uvfXM+2gpjvldCEPl8rYu+Bw6elTcA893tIDm
	s2D4AYxUoBVUzPaK+Rvw4CNysgXXDxzgObv4/lGN4HFFKkBqMU+Pe78oKQF6
X-Google-Smtp-Source: AGHT+IHVpxim+VMN+tSfSxUAe7KmRI2Ia10uE+rJv2PfANbSaawmw6qTs5pDsl5r3fIbhyFLkeKOyQ==
X-Received: by 2002:a05:6a20:3c88:b0:1a7:6ec4:d27e with SMTP id b8-20020a056a203c8800b001a76ec4d27emr6094070pzj.14.1712819184767;
        Thu, 11 Apr 2024 00:06:24 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:24 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 03/13] clk: hisilicon: hi3798cv200: Use helper functions
Date: Thu, 11 Apr 2024 15:04:48 +0800
Message-ID: <20240411070503.38093-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411070503.38093-2-mmyangfl@gmail.com>
References: <20240411070503.38093-2-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3798cv200.c | 200 +++---------------------
 1 file changed, 22 insertions(+), 178 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index f651b197e45a..9ce590cc4142 100644
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
-	.driver         = {
-		.name   = "hi3798cv200-crg",
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
+	.driver = {
+		.name = "hi3798cv200-crg",
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
2.43.0


