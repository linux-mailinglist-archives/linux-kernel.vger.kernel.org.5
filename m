Return-Path: <linux-kernel+bounces-146590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D928A67AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEFF282AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1075A127E1C;
	Tue, 16 Apr 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FymRNc5c"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5626127B7A;
	Tue, 16 Apr 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261909; cv=none; b=szfzoY/8D3Vv84MbCCF1e9L3Pxa/W9AC38Jt7yD+fR7ZRZ+XSCac4SApdIO9JYe+Jz0sVa9uBSkW5wQzX9VX6MScdHiaOJTuHegp7ulLeqnu2jQ+NkoqPU+Z7Oupc0Lk3iZ90d/75ScjppG/dqdSzJ9ApDjsmWRdMK3JXtCKUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261909; c=relaxed/simple;
	bh=O6604vi/bj5igXZdGKPwpCmuP/mf360WhfeWzANdq9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipQkJlhiXPu9urrTDu/fka9t3Q1vGEkDc3E5Ypja/RVoRYEUcCwxcOledZkFD+mjFfl1jv3yDcIyGyMH/Cig8k9mNAAAk6WZZQ7mugjn/rksE2u5sbap93I1ZwevE4lduCVXY4yUE6ZVoQaONDQRQhD53r5A1Hn6NSRIfO+9i50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FymRNc5c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e455b630acso17991185ad.1;
        Tue, 16 Apr 2024 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261907; x=1713866707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBKLoEacHSWOE25HfyrDdRRp12aAe56L7a96hJM6/NY=;
        b=FymRNc5c2hKIVSNey5cOb+smZGk9JHreIn6rhQbTrurN5kQkw1zCEIyBQHqlPOGeP9
         NItEvZP2zguBT0oWRqEpxytRJQZEwzRuGef9cTGpPs/nbYlU53kKaGKBNecVMaO4FzU9
         KgYiNRWHjzLYJn026R1G/wHTFhkQNG3REqSXBkMxSxEg+QXPwg+0vyBB54qqkfCPWSRV
         uB3sJrDS+P4KEWq1jrV3teXKy+U/38Fe+jl6L2FClbuHi2GheD2znqRJJMLH/GIQ6+7D
         tpyTir1i1+XMV/789zD5OFNGsY4swUO/nGvlwk6JxCSwJksTni03C7KQokmYTZ20Co2l
         3wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261907; x=1713866707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBKLoEacHSWOE25HfyrDdRRp12aAe56L7a96hJM6/NY=;
        b=mEEdSXudUI0EyjiNye33eGQ8nCshxxx/ykgmdzI3SHfqDdWA68uX3XqFIrvwkZrWwK
         JZhDJc+edLwqCIpan6dwWQmvx/xjnvTMVgMdtZf2oY1B58JM+9bGwqcd2x8+xF6lwy/b
         s3HTiAleD7kDJHre1uPlUGNYHrRHnDW0KxhGnS4VqxgiDs4S8AfRPAST3uekL87oQoSe
         VgABOKv3FXy3dcm4crPAhpOiMChr4bid6kJ2koE8em++JvPIDdV54DbDVz0B6ixWs15s
         dXx4lCskHZT5voVe9saSQxtZyu/kQMNs4EoXtFNjw0Uz33PzrE9rW1rh7nHk6fvIrDGM
         8KZA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6OWcsvAkp9pccExch3jkICwzuwRbV4iboSTE3RPSe+vf58j1iuM87jaQhpe9WScTugjR/cIKMAD+NCpWXC4bdAx7Wlrski4A6b/I
X-Gm-Message-State: AOJu0YydVdtI/UwdY7/9etBsi2upDT1hz37FalJBQpZFePpfYmjpEypX
	98HCPiNFr5T5K9nAXluqtYWPfYrijuoyygU+o0EHf5aJ6Q4/eWAt7Da9NkSM
X-Google-Smtp-Source: AGHT+IHIX1f7NSdLTD1FFpTzQI+nNaV+l7uaCGrc1EU7Dtf4qOzgfOvKFRr5IVgo0mJE1e5B0Y7KmQ==
X-Received: by 2002:a17:903:249:b0:1dd:de1a:bd02 with SMTP id j9-20020a170903024900b001ddde1abd02mr12064445plh.41.1713261906891;
        Tue, 16 Apr 2024 03:05:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001e0b287c1d2sm9353651plg.215.2024.04.16.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:05:06 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v10 04/13] clk: hisilicon: hi3519: Use helper functions
Date: Tue, 16 Apr 2024 18:03:38 +0800
Message-ID: <20240416100347.395295-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416100347.395295-1-mmyangfl@gmail.com>
References: <20240416100347.395295-1-mmyangfl@gmail.com>
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
index 141b727ff60d..cb541de752da 100644
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
-				ARRAY_SIZE(hi3519_gate_clks),
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


