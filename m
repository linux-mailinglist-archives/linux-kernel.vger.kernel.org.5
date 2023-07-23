Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8875E3D2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGWQ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGWQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:26:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF01999;
        Sun, 23 Jul 2023 09:26:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55adfa61199so2561412a12.2;
        Sun, 23 Jul 2023 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129548; x=1690734348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNZDSYoGb3uZl1I3ymSzL6L6meDQzuQ8PM9FVmAR7qU=;
        b=PEfU5yjjNgEDTN/b3EIfG3zOydNiwp4jwFDp7XbfB9kgD7nbTsgXc74/g4N49AI68/
         8UuV1157/Ve4YkeLCEUk+cf442JFUvqtuwhirxZQWUJdPyU96L9Ng94Ejnz8Qq3r+dqw
         1bSRdLpyGW2gf5qEqa95eJrDCh02NEwPgJonTsm7GuZizmobBFrgnBySgMbUZHETdLhk
         3GKQcDjNsD8QsQNRvSDp4gmxNLFIxn4V2u1AYQL73e/VDrj4vBCJpFv5ajTEaKI26cfp
         CBNRSNsuMZzHNJUTBZF5hZxKRRMsk0uOME286IF8Xaiv1DiMFu97zSE81+5D8yToaauL
         o1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129548; x=1690734348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNZDSYoGb3uZl1I3ymSzL6L6meDQzuQ8PM9FVmAR7qU=;
        b=AeALi36blOio4YpzxVC3ZXy8Zd/iweGD9LbYYWNsQxGxMFnqZtsbIWUupuUSLtpwgS
         SrQKxxi+n87YR3WTJ+7NAg8HENu5RyN4QL5DFPE6O3eMZV6ztKMy5eihKP5Fv/O89vbx
         Fp46PXo1+FLpka3E5LVgRlXaDqi+JZCahzXA8PXvoAYMStlPf0pjkundl+1VQpp9NfL7
         pw5uPFGaZBqaanIQbpF/gQVVn474/cccjgXGDx6F6L+CXeS+MvL/Eqrx+I1418Qznmqf
         u5jR7veNybs4+C4a6jglf/CTEHt17L/kTqd20EsmyYIBoOu9ne/KQQJxv1xbBjel1eTP
         S8nA==
X-Gm-Message-State: ABy/qLb8jn9u49yKgH+6oBqkv9/BsBW20YY7G872GuZ3l8n4qXd/pOfr
        QGEdTuO3F1uGtbfKsnmBxyLGNcdw7nGkIP3V
X-Google-Smtp-Source: APBJJlE3v12bkTAw6IWNH1uzsfnsYBnYvH8bHpu4pFrepngmxWclsIrp1fhm/aY8GeuvId7EwKQicQ==
X-Received: by 2002:a17:90b:1b47:b0:263:6114:f0f9 with SMTP id nv7-20020a17090b1b4700b002636114f0f9mr7023160pjb.42.1690129548626;
        Sun, 23 Jul 2023 09:25:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090aae8300b00265a7145fe5sm6883787pjq.41.2023.07.23.09.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:25:48 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/13] clk: hisilicon: hip04: Convert into platform driver module
Date:   Mon, 24 Jul 2023 00:22:36 +0800
Message-Id: <20230723162245.35033-12-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hip04.c | 39 +++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index 785b9faf3ea5..9aa2481781cb 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -10,11 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hip04-clock.h>
 
@@ -27,16 +24,28 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
 	{ HIP04_CLK_168M, "clk168m",  NULL, 0, 168750000, },
 };
 
-static void __init hip04_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
+static const struct hisi_clocks hip04_clks = {
+	.fixed_rate_clks = hip04_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hip04_fixed_rate_clks),
+};
+
+static const struct of_device_id hip04_clk_match_table[] = {
+	{ .compatible = "hisilicon,hip04-clock",
+	  .data = &hip04_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hip04_clk_match_table);
+
+static struct platform_driver hip04_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
+	.driver		= {
+		.name	= "hip04-clock",
+		.of_match_table = hip04_clk_match_table,
+	},
+};
 
-	clk_data = hisi_clk_init(np, HIP04_NR_CLKS);
-	if (!clk_data)
-		return;
+module_platform_driver(hip04_clk_driver);
 
-	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
-				     ARRAY_SIZE(hip04_fixed_rate_clks),
-				     clk_data);
-}
-CLK_OF_DECLARE(hip04_clk, "hisilicon,hip04-clock", hip04_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon HiP04 Clock Driver");
-- 
2.40.1

