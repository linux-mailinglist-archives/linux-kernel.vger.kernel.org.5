Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6178776B99E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjHAQ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHAQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:28:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD9133
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:28:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1qQsDv-00018q-Q3; Tue, 01 Aug 2023 18:27:51 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1qQsDu-000QYa-SP; Tue, 01 Aug 2023 18:27:50 +0200
Received: from afa by dude05.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <afa@pengutronix.de>)
        id 1qQsDt-00Dkrt-2z;
        Tue, 01 Aug 2023 18:27:49 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: composite-8m: avoid glitches when set_rate would be a no-op
Date:   Tue,  1 Aug 2023 18:27:31 +0200
Message-Id: <20230801162731.3278396-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reconfiguring the clock divider to the exact same value is observed
on an i.MX8MN to often cause a short clock pause, probably because
the divider restarts counting from the time the register is written.

This issue doesn't show up normally, because the clock framework will
take care to not call set_rate when the clock rate is the same.
However, when we configure an upstream clock (e.g. an audio_pll), the
common code will call set_rate with the newly calculated rate on all
children. As the new rate is different, we enter set_rate and compute
the same divider values, write them back and cause the glitch (e.g.
on a SAI's MCLK).

To avoid the glitch, we skip writing the same value back again.

Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/clk/imx/clk-composite-8m.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00..3e9a092e136c 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -97,7 +97,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	int prediv_value;
 	int div_value;
 	int ret;
-	u32 val;
+	u32 orig, val;
 
 	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
 						&prediv_value, &div_value);
@@ -106,13 +106,15 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 
 	spin_lock_irqsave(divider->lock, flags);
 
-	val = readl(divider->reg);
-	val &= ~((clk_div_mask(divider->width) << divider->shift) |
-			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+	orig = readl(divider->reg);
+	val = orig & ~((clk_div_mask(divider->width) << divider->shift) |
+		       (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
 
 	val |= (u32)(prediv_value  - 1) << divider->shift;
 	val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
-	writel(val, divider->reg);
+
+	if (val != orig)
+		writel(val, divider->reg);
 
 	spin_unlock_irqrestore(divider->lock, flags);
 
-- 
2.39.2

