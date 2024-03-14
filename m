Return-Path: <linux-kernel+bounces-103159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1F787BBBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596961F22339
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E166EB53;
	Thu, 14 Mar 2024 11:10:51 +0000 (UTC)
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D266CDA3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414651; cv=none; b=Y7WAqMF40FpYfjGy+iGaPl7RP6xomezwpnTR0MW+I585CQV5H2NddmRNPdp1EMkcRbU1Xig5Scqme5WOJMH4rtc0vbrNaIv8R3nz2TqLapixZeYYE/WmNzHT5dNi3cOG8W6kK0yXEiCStBEhO9tvTimaTjU+3rJL9nXk5jhAeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414651; c=relaxed/simple;
	bh=kNJD2vfdVNOWGd8yX3s8kD7ohIaKfeALYGkpdHnoD1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=syykownVQFYC62Frwxhk+PNbUfMtYWsXeHy/5G8E3ooyviZhaqETNuE4oWRZnzCbeHmPhaVYOl3yOPUnP10q7/qQouQNI+4SOhSo+eZL7TK30a5S9ee4bqTYQnzvKZC66NWSMl1LXx7xvBvZzAn+lTBciXue9lLeWvQ9TigF4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4TwPgF0vxKz4x71L
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:05:29 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by laurent.telenet-ops.be with bizsmtp
	id yb5G2B00R0SSLxL01b5GhH; Thu, 14 Mar 2024 12:05:21 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rkitO-003gBz-Tu;
	Thu, 14 Mar 2024 12:05:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rkitg-00F90v-Fj;
	Thu, 14 Mar 2024 12:05:16 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] clk: starfive: jh7100: Use provided clocks instead of hardcoded names
Date: Thu, 14 Mar 2024 12:05:13 +0100
Message-Id: <898aa0925a9598d44721d00145015b215434cb3b.1710414195.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Starfive JH7100 clock driver does not use the DT "clocks" property
to find its external input clocks, but instead relies on the names of
the actual external clock providers.  This is fragile, and caused
breakage when sanitizing clock names in DT.

Fix this by obtaining the external input clocks through the DT "clocks"
property, and using their clk_hw objects or corresponding name.

Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
After this is applied, the workaround in commit 7921e231f85a349d
("riscv: dts: starfive: jh7100: fix root clock names") can be reverted.
---
 drivers/clk/starfive/clk-starfive-jh7100.c | 47 +++++++++++++++-------
 drivers/clk/starfive/clk-starfive-jh71x0.h |  1 +
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 0342db24c27e10df..08e6f03f2cfc36c1 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -18,10 +19,18 @@
 #include "clk-starfive-jh71x0.h"
 
 /* external clocks */
-#define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
-#define JH7100_CLK_OSC_AUD		(JH7100_CLK_END + 1)
-#define JH7100_CLK_GMAC_RMII_REF	(JH7100_CLK_END + 2)
-#define JH7100_CLK_GMAC_GR_MII_RX	(JH7100_CLK_END + 3)
+enum {
+	EXT_CLK_OSC_SYS,
+	EXT_CLK_OSC_AUD,
+	EXT_CLK_GMAC_RMII_REF,
+	EXT_CLK_GMAC_GR_MII_RX,
+	EXT_NUM_CLKS
+};
+
+#define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + EXT_CLK_OSC_SYS)
+#define JH7100_CLK_OSC_AUD		(JH7100_CLK_END + EXT_CLK_OSC_AUD)
+#define JH7100_CLK_GMAC_RMII_REF	(JH7100_CLK_END + EXT_CLK_GMAC_RMII_REF)
+#define JH7100_CLK_GMAC_GR_MII_RX	(JH7100_CLK_END + EXT_CLK_GMAC_GR_MII_RX)
 
 static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
 	JH71X0__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 0, 4,
@@ -284,8 +293,12 @@ static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data
 
 static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 {
+	static const char *jh7100_ext_clk[EXT_NUM_CLKS] =
+		{ "osc_sys", "osc_aud", "gmac_rmii_ref", "gmac_gr_mii_rxclk" };
 	struct jh71x0_clk_priv *priv;
+	const char *osc_sys;
 	unsigned int idx;
+	struct clk *clk;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7100_CLK_PLL0_OUT), GFP_KERNEL);
@@ -298,13 +311,23 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	for (idx = 0; idx < EXT_NUM_CLKS; idx++) {
+		clk = devm_clk_get(&pdev->dev, jh7100_ext_clk[idx]);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		priv->ext[idx] = __clk_get_hw(clk);
+	}
+
+	osc_sys = clk_hw_get_name(priv->ext[EXT_CLK_OSC_SYS]);
+
 	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
-							 "osc_sys", 0, 40, 1);
+							 osc_sys, 0, 40, 1);
 	if (IS_ERR(priv->pll[0]))
 		return PTR_ERR(priv->pll[0]);
 
 	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
-							 "osc_sys", 0, 64, 1);
+							 osc_sys, 0, 64, 1);
 	if (IS_ERR(priv->pll[1]))
 		return PTR_ERR(priv->pll[1]);
 
@@ -331,16 +354,10 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 
 			if (pidx < JH7100_CLK_PLL0_OUT)
 				parents[i].hw = &priv->reg[pidx].hw;
-			else if (pidx < JH7100_CLK_END)
+			else if (pidx < JH7100_CLK_OSC_SYS)
 				parents[i].hw = priv->pll[pidx - JH7100_CLK_PLL0_OUT];
-			else if (pidx == JH7100_CLK_OSC_SYS)
-				parents[i].fw_name = "osc_sys";
-			else if (pidx == JH7100_CLK_OSC_AUD)
-				parents[i].fw_name = "osc_aud";
-			else if (pidx == JH7100_CLK_GMAC_RMII_REF)
-				parents[i].fw_name = "gmac_rmii_ref";
-			else if (pidx == JH7100_CLK_GMAC_GR_MII_RX)
-				parents[i].fw_name = "gmac_gr_mii_rxclk";
+			else if (pidx <= JH7100_CLK_GMAC_GR_MII_RX)
+				parents[i].hw = priv->ext[pidx - JH7100_CLK_OSC_SYS];
 		}
 
 		clk->hw.init = &init;
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 23e052fc15495c41..4f46939179cd7418 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -115,6 +115,7 @@ struct jh71x0_clk_priv {
 	struct device *dev;
 	void __iomem *base;
 	struct clk_hw *pll[3];
+	struct clk_hw *ext[4];
 	struct jh71x0_clk reg[];
 };
 
-- 
2.34.1


