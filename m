Return-Path: <linux-kernel+bounces-124470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D6891887
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA8F1F21FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1118565F;
	Fri, 29 Mar 2024 12:17:19 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7B69E1E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714639; cv=none; b=CVDTvgRG67kI9Y38mmKjo2OL9S3V3Iq0nJYZWGaR+P31PYA4jI8v8Qw9iFbCD7igg2BDsiQnaD45XLvjLl1/z4fK81RpfzjBhDSXN/BDhERAEbDvdbtf84lwiEKYBeE/AzCJHvKphHdLI6xhvcUL65dGNTnzfrBE2lAIU7DQwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714639; c=relaxed/simple;
	bh=WByLMNgr1x5IXePaODf7nGGqH1BATk1KTcosojsIMeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6ozod4axRjp9EUO8B6AT4hraordk4bij4GbC8Nt1M+Q9pNtAjdsVmjH0eqlB4WJBa8VSyezRkPTxp8IhSAbl0dEv1E8xYGkd18HO0wTvaEjeGCx57WNVZJCerAfYVCY/j20wu0vy/0G9l3pB6CDOxiws7k6e4p3THa7bqvCs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by xavier.telenet-ops.be with bizsmtp
	id 4cGz2C00D0SSLxL01cGzro; Fri, 29 Mar 2024 13:17:06 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rqB9u-005D19-E1;
	Fri, 29 Mar 2024 13:16:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rqBAJ-00203s-EC;
	Fri, 29 Mar 2024 13:16:59 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3] clk: starfive: jh7100: Use clk_hw for external input clocks
Date: Fri, 29 Mar 2024 13:16:58 +0100
Message-Id: <2082b46ab08755b1b66e0630a61619acac9d883f.1711714613.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Starfive JH7100 clock driver does not use the DT "clocks" property
to find the external main input clock, but instead relies on the name of
the actual clock provider ("osc_sys").  This is fragile, and caused
breakage when sanitizing clock node names in DTS.

Fix this by obtaining the external main input clock using
devm_clk_get(), and passing the returned clk_hw object to
devm_clk_hw_register_fixed_factor_parent_hw().

While name-based look-up of the other external input clocks works as-is,
convert them to a similar clk_hw-based scheme to increase uniformity,
and to decrease the number of (multiple identical) name-based look-ups.

Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
After this is applied, the workaround in commit 7921e231f85a349d
("riscv: dts: starfive: jh7100: fix root clock names") can be reverted.

v3:
  - Add Reviewed-by,
  - Make jh7100_ext_clk[] const/__initconst,
  - Add "(multiple identical)".

v2:
  - Use devm_clk_hw_register_fixed_factor_parent_hw(),
  - Drop no longer needed local osc_sys name.
---
 drivers/clk/starfive/clk-starfive-jh7100.c | 48 ++++++++++++++--------
 drivers/clk/starfive/clk-starfive-jh71x0.h |  1 +
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 0342db24c27e10df..bdff207aa1f766e6 100644
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
@@ -284,8 +293,11 @@ static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data
 
 static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 {
+	static const char * const jh7100_ext_clk[EXT_NUM_CLKS] __initconst =
+		{ "osc_sys", "osc_aud", "gmac_rmii_ref", "gmac_gr_mii_rxclk" };
 	struct jh71x0_clk_priv *priv;
 	unsigned int idx;
+	struct clk *clk;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7100_CLK_PLL0_OUT), GFP_KERNEL);
@@ -298,13 +310,21 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
-							 "osc_sys", 0, 40, 1);
+	for (idx = 0; idx < EXT_NUM_CLKS; idx++) {
+		clk = devm_clk_get(&pdev->dev, jh7100_ext_clk[idx]);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		priv->ext[idx] = __clk_get_hw(clk);
+	}
+
+	priv->pll[0] = devm_clk_hw_register_fixed_factor_parent_hw(priv->dev,
+			"pll0_out", priv->ext[EXT_CLK_OSC_SYS], 0, 40, 1);
 	if (IS_ERR(priv->pll[0]))
 		return PTR_ERR(priv->pll[0]);
 
-	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
-							 "osc_sys", 0, 64, 1);
+	priv->pll[1] = devm_clk_hw_register_fixed_factor_parent_hw(priv->dev,
+			"pll1_out", priv->ext[EXT_CLK_OSC_SYS], 0, 64, 1);
 	if (IS_ERR(priv->pll[1]))
 		return PTR_ERR(priv->pll[1]);
 
@@ -331,16 +351,10 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 
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


