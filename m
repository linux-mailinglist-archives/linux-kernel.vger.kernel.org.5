Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC576961D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjGaMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjGaMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:22:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405A1FCE;
        Mon, 31 Jul 2023 05:21:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68706d67ed9so2486177b3a.2;
        Mon, 31 Jul 2023 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806097; x=1691410897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNZDSYoGb3uZl1I3ymSzL6L6meDQzuQ8PM9FVmAR7qU=;
        b=doG3keO2RWRT3NSjvodkF6s4enEt+dLjGqkBxcmNMTZ3Wsi5fjw2jVEIOyAQvTSSfw
         o3M+swgBpkV7+T/z6mgIrkkXP8y8YeyREV+hnMxYzOIkH5GZHMv2cRnX/MeEAOUtzPRD
         iZqVd4iMwO60uoDUMuTJkBK1u8gKW1eAwuff2+2IsNfA5k69iJ9UyIwHY+UopYdAH0l/
         +8qd95boBeq8mZcKHLBksHioFlw6FexI6XYcvJNYTeycQ2ESPRoEAA14euYAHSh75kzi
         q+HAd25vhcYShwIRmPRVFTXY0PPANTV9o66C7y07freTPvr92bBSrzQ3Emurf+coA+cy
         vw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806097; x=1691410897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNZDSYoGb3uZl1I3ymSzL6L6meDQzuQ8PM9FVmAR7qU=;
        b=cFion0epJ37QPrQqZSJ8Gz+QcXI0kNKQlbe+exXGF/L3UKQTnwV2kw6QoX3DXwNtiz
         vA9wa9sq6ZL5fXxgOOpv1chOPBeORNU+0NH1k5eynirSjbF+/3sWRAs7rcYvIpHblTZD
         27dv4uA1FOo16irlFqLBLOolYJ5cJ1irOWCFITEBogg1o1+f9W77h5wo6m5QQISyztQk
         BlCaT5unPRIvOVzCD1dfI4QqdNGsesuKtTcNqC3N+Fy4rBzbeb1QI03XRwEX8103xyKb
         JZ/w/b3iIJUeYICLwAPqzp6SRoK8K/wHFysr+LUmD0S1uQu4IwfkNq2OMwkuYIKfQP4C
         ieSw==
X-Gm-Message-State: ABy/qLZyDp4iKpxumZPZQ/ctCxsQMOjKc213+tTBU4Db4PMq5G3QPYMx
        YtjLZEjCxkXFvn70o4TG+7JuyNEr5j7oGZN/
X-Google-Smtp-Source: APBJJlENtQG6QSUeuBtqXeQonYMajM6o5gUvaP26EAp9EFhsbrCsACpniABidnEstQVXZ86b3Kb9sg==
X-Received: by 2002:a05:6a00:148c:b0:666:8403:9f4 with SMTP id v12-20020a056a00148c00b00666840309f4mr12951107pfu.16.1690806097545;
        Mon, 31 Jul 2023 05:21:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:21:37 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/13] clk: hisilicon: hip04: Convert into platform driver module
Date:   Mon, 31 Jul 2023 20:18:11 +0800
Message-Id: <20230731121821.22242-12-mmyangfl@gmail.com>
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

