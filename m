Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF71782D46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjHUP3X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjHUP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:29:22 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFC0E2;
        Mon, 21 Aug 2023 08:29:20 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E302A24E2AB;
        Mon, 21 Aug 2023 23:29:16 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Aug
 2023 23:29:17 +0800
Received: from localhost.localdomain (113.72.145.205) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Aug
 2023 23:29:16 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz
Date:   Mon, 21 Aug 2023 23:29:15 +0800
Message-ID: <20230821152915.208366-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.205]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
But now PLL0 rate is 1GHz and the cpu frequency loads become
333/500/500/1000MHz in fact.

So PLL0 rate should be set to 1.5GHz. Change the parent of cpu_root clock
and the divider of cpu_core before the setting.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---

Hi Stephen and Emil,

This patch fixes the issue about lower rate of CPUfreq[1]
and sets PLL0 rate to 1.5GHz. In order not to affect the cpu 
operation, the cpu_root's parent clock should be changed first.
And the divider of the cpu_core clock should be set to 2 so they
won't crash when setting 1.5GHz without voltage regulation.

[1]: https://github.com/starfive-tech/VisionFive2/issues/55

This patch is based on linux-next(20230818) which has merge PLL driver
on the StarFive JH7110 SoC.

Thanks,
Xingyu Wu

---
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 3884eff9fe93..b6b9e967dfc7 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -501,7 +501,52 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return jh7110_reset_controller_register(priv, "rst-sys", 0);
+	ret = jh7110_reset_controller_register(priv, "rst-sys", 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set PLL0 rate to 1.5GHz
+	 * In order to not affect the cpu when the PLL0 rate is changing,
+	 * we need to switch the parent of cpu_root clock to osc clock first,
+	 * and then switch back after setting the PLL0 rate.
+	 */
+	pllclk = clk_get(priv->dev, "pll0_out");
+	if (!IS_ERR(pllclk)) {
+		struct clk *osc = clk_get(&pdev->dev, "osc");
+		struct clk *cpu_root = priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
+		struct clk *cpu_core = priv->reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
+
+		if (IS_ERR(osc)) {
+			clk_put(pllclk);
+			return PTR_ERR(osc);
+		}
+
+		/*
+		 * CPU need voltage regulation by CPUfreq if set 1.5GHz.
+		 * So in this driver, cpu_core need to be set the divider to be 2 first
+		 * and will be 750M after setting parent.
+		 */
+		ret = clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
+		if (ret)
+			goto failed_set;
+
+		ret = clk_set_parent(cpu_root, osc);
+		if (ret)
+			goto failed_set;
+
+		ret = clk_set_rate(pllclk, 1500000000);
+		if (ret)
+			goto failed_set;
+
+		ret = clk_set_parent(cpu_root, pllclk);
+
+failed_set:
+		clk_put(pllclk);
+		clk_put(osc);
+	}
+
+	return ret;
 }
 
 static const struct of_device_id jh7110_syscrg_match[] = {
-- 
2.25.1

