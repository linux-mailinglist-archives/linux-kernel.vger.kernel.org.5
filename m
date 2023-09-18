Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C807A435B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbjIRHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbjIRHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:44:38 -0400
Received: from mail-m49226.qiye.163.com (mail-m49226.qiye.163.com [45.254.49.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4F18E;
        Mon, 18 Sep 2023 00:42:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=T9yjZlm7HyhCsWHXpRZQ0PVqlymuih1rHp3kM2Xsqf50HYG5brDEkzqRHx6hMnYqwegM4oaEaoxrLKpfkJ/Lk0p+xWkMMquwFnO1UnYlwtiZS7txcqAhuh5KCyVpgbedQuTeCoT5nNSrFNj0WOTkr3ma/Yukfm2LbQgohf3OS+w=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=R+b+U05rjVQsHcLYYo7FvRmUm3DUdEyeUtl3J6etFps=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 83310680600;
        Mon, 18 Sep 2023 15:31:58 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 6/8] clk: rockchip: rk3568: Support module build
Date:   Mon, 18 Sep 2023 15:31:49 +0800
Message-Id: <20230918073151.7660-7-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918073151.7660-1-zhangqing@rock-chips.com>
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpCGFZCGkwfSUlCHR4YGhpVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa73405372eb5kusn83310680600
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6ATo*Tz1IHUoCFAxPSA8Q
        LhMaCRJVSlVKTUJOS0lJSEpCT0hLVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhKQk43Bg++
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support CLK_OF_DECLARE and module_platform_driver
double clk init method.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3568.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 64d2278825ab..5907f7e14201 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -1653,6 +1653,7 @@ static void __init rk3568_clk_init(struct device_node *np)
 
 CLK_OF_DECLARE(rk3568_cru, "rockchip,rk3568-cru", rk3568_clk_init);
 
+#ifdef MODULE
 struct clk_rk3568_inits {
 	void (*inits)(struct device_node *np);
 };
@@ -1675,8 +1676,9 @@ static const struct of_device_id clk_rk3568_match_table[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, clk_rk3568_match_table);
 
-static int __init clk_rk3568_probe(struct platform_device *pdev)
+static int clk_rk3568_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct clk_rk3568_inits *init_data;
@@ -1692,10 +1694,16 @@ static int __init clk_rk3568_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver clk_rk3568_driver = {
+	.probe		= clk_rk3568_probe,
 	.driver		= {
 		.name	= "clk-rk3568",
 		.of_match_table = clk_rk3568_match_table,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver_probe(clk_rk3568_driver, clk_rk3568_probe);
+module_platform_driver(clk_rk3568_driver);
+
+MODULE_DESCRIPTION("Rockchip RK3568 Clock Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:clk-rk3568");
+#endif /* MODULE */
-- 
2.17.1

