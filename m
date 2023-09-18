Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1E7A4321
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbjIRHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbjIRHnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:43:12 -0400
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 00:41:58 PDT
Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com [45.254.49.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E741B5;
        Mon, 18 Sep 2023 00:41:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=acOd2ke57QbjXIpr8WEZCRZSAYNGHf1HbxM9U1aGgLGr9PLnd+ACr878zLkd6X952/kTisl1H5l+X/5JEBTo0iYQ09aTdV94GKaJ0dM7q5b2nXv12U5Cmlk5QR8AZU80E4GXJ+0q11TBfZXMiS8UWgN2wqx5pqAI9PZYUXFBTOY=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=vyECsO4uy90lTUrx8mOBqqu8I+jSj4HmGYI/qGQDg4o=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 801BC680358;
        Mon, 18 Sep 2023 15:31:57 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
Subject: [PATCH v1 5/8] clk: rockchip: rk3399: Support module build
Date:   Mon, 18 Sep 2023 15:31:48 +0800
Message-Id: <20230918073151.7660-6-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918073151.7660-1-zhangqing@rock-chips.com>
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoaTlZCTE9CSh1IGUgdTk9VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8aa73401362eb5kusn801bc680358
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6Tjo5Qz1KN0oJIgwvSBA6
        MysKCUJVSlVKTUJOS0lJSEpDT0NIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhJS0g3Bg++
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
 drivers/clk/rockchip/clk-rk3399.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index ee3bda968574..dcc794dbb190 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1571,6 +1571,7 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
 }
 CLK_OF_DECLARE(rk3399_cru_pmu, "rockchip,rk3399-pmucru", rk3399_pmu_clk_init);
 
+#ifdef MODULE
 struct clk_rk3399_inits {
 	void (*inits)(struct device_node *np);
 };
@@ -1593,8 +1594,9 @@ static const struct of_device_id clk_rk3399_match_table[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, clk_rk3399_match_table);
 
-static int __init clk_rk3399_probe(struct platform_device *pdev)
+static int clk_rk3399_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
@@ -1612,10 +1614,16 @@ static int __init clk_rk3399_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver clk_rk3399_driver = {
+	.probe		= clk_rk3399_probe,
 	.driver		= {
 		.name	= "clk-rk3399",
 		.of_match_table = clk_rk3399_match_table,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver_probe(clk_rk3399_driver, clk_rk3399_probe);
+module_platform_driver(clk_rk3399_driver);
+
+MODULE_DESCRIPTION("Rockchip RK3399 Clock Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:clk-rk3399");
+#endif /* MODULE */
-- 
2.17.1

