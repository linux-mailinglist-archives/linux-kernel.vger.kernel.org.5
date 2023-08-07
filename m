Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADFE771C30
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHGIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHGIWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:22:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1D170B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:22:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1qSvV9-00009U-TV; Mon, 07 Aug 2023 10:22:07 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1qSvV8-001hda-UD; Mon, 07 Aug 2023 10:22:06 +0200
Received: from afa by dude05.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <afa@pengutronix.de>)
        id 1qSvV8-009n6M-1f;
        Mon, 07 Aug 2023 10:22:06 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Peng Fan <peng.fan@oss.nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
Date:   Mon,  7 Aug 2023 10:22:00 +0200
Message-Id: <20230807082201.2332746-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reconfiguring the clock divider to the exact same value is observed
on an i.MX8MN to often cause a longer than usual clock pause, probably
because the divider restarts counting whenever the register is rewritten.

This issue doesn't show up normally, because the clock framework will
take care to not call set_rate when the clock rate is the same.
However, when we reconfigure an upstream clock, the common code will
call set_rate with the newly calculated rate on all children, e.g.:

  - sai5 is running normally and divides Audio PLL out by 16.
  - Audio PLL rate is increased by 32Hz (glitch-free kdiv change)
  - rates for children are recalculated and rates are set recursively
  - imx8m_clk_composite_divider_set_rate(sai5) is called with
    32/16 = 2Hz more
  - imx8m_clk_composite_divider_set_rate computes same divider as before
  - divider register is written, so it restarts counting from zero and
    MCLK is briefly paused, so instead of e.g. 40ns, MCLK is low for 120ns.

Some external clock consumers can be upset by such unexpected clock pauses,
so let's make sure we only rewrite the divider value when the value to be
written is actually different.

Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
  - replace glitch with clock pause instead (Peng)
  - describe how bug triggers in more detail (Peng)
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

