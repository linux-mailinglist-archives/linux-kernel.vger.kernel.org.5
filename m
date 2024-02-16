Return-Path: <linux-kernel+bounces-69408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE5858895
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F6028C79A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0830E148307;
	Fri, 16 Feb 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lam8AI4O"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4711419A2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122770; cv=none; b=U2k6e6qdTi9ZsmQHGne3/7kaSaZC6QIyOcI0dXENYfjfEvn2r8aGSqEzBWG0QZnRmBU216cuWVpMTdEcNw1VEwRpIwjHse8ntaSK04C0H1jgouGKe7iZQForO8JH96rMWJhzCS5WoUAMlFEcFjCGlcZ9pkTFNCaIhyUjKlrslgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122770; c=relaxed/simple;
	bh=Ug0aSHXvGjRRHpg8YcHJDBWSFTS5hBgzkfvVGyxjYYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esnAZrY4cNpDKYbZApQMUNrtfLDtBrrPrfbqmodrhCALi2jPUH/sN6ynWJ0m8DcSmZiAG/SJovcFM9LdEeddp7r6r5Q2PE3teLzO+LKq5+QQmtU08x0UJUsnIghtwUEkZwEDDPm37qXs57dgcl4889Rt0l43XQDx97jDivS1MbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lam8AI4O; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2e452c852so1200067a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708122767; x=1708727567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h/AGQpeHRpCr+IvQpsM+5P7zd5DzznbvZF/IRa0p4Q=;
        b=lam8AI4OYBnAvqqsk5nywrCPReslho2S8iitYkCUjEhUOT08lZVzti1A+S4EXaS7tf
         yfBamEDvAas+2Lbaghtqn2G10GXGjM2eude3fRnNt3W2WSghoYhVvyZKddvMgcbKqmyy
         SWOY5og79n26TbNpbQ+EdN0H+Q/4tardnkuSq/1wfh/RnyA+kr5EzA+FT2L5JxM1HKzq
         eFTTqNeABcm1B3oNgW4il7CPzKIJ7PsuYG+n9mva1Y66UaqP0TSTbO5JpOeQUdT9fM3O
         IinPY9mZry1lMbxzvoWedhI2bpiiFle9Ozt5T0msjHYq/xCr+cugWQvzqfaGbFkk84Cs
         8mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122767; x=1708727567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h/AGQpeHRpCr+IvQpsM+5P7zd5DzznbvZF/IRa0p4Q=;
        b=wYx+vCHlqbYVFegP5lzmnUwrTklvB80J6Mlb4kHQF3I+NGf1by7gIiY0drfcNQNnLb
         y/fKluYQ8K8R8d65Z9GdmIhLuWZW97wAxQg9KEqtn2apN1TTOYsCl64XGOh77FA+J+lu
         958n5DwcW8gc7nZt+3d93qNkCCq7J6vA+udoLJexbXH+4M3+TrTE5jVbi9imRxGVKdON
         oAL6T1uLhGqyGgdq0QRYgRF4cZw+cBJxVyv5w8niFJWNFK+/gGR+5ybQvtklWZvBBIxI
         2eyp4YODTb5BCDbIZeCMhOrcSx6Du6pz5Pdb/CoVQetT9YL+6cXnFEK8Ur7GwltOaGhP
         1tKw==
X-Forwarded-Encrypted: i=1; AJvYcCUHzAqG1GNfoWPJBBO5AM918/thtS56KLod9ggyu6u/NFpmkfsqMTQOxFov7TaOkwoL1rLvVU4veXmdYd7eItx3fHbGTNDqVE19BaGz
X-Gm-Message-State: AOJu0Yx5Fb+Sdi/DJQNpyurcqGE8ugXpnUXTJ+OdYlWY2Xpx55zQ9Wwe
	nlZH1UKOeGG1j80+OavhCOnhMVeIKwSxbkYFZtTQgg6aRNOnF2gEDyyNlZgAbkc=
X-Google-Smtp-Source: AGHT+IHpn8VAi29hfI8nDBvQPOtxwtO9IkcVqfYbTJC8Q5AbSD82k2A8ohimqqByqdoytRY/A8HATg==
X-Received: by 2002:a05:6870:2105:b0:214:dfe8:2b6a with SMTP id f5-20020a056870210500b00214dfe82b6amr6594730oae.51.1708122767499;
        Fri, 16 Feb 2024 14:32:47 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id mj12-20020a0568700d8c00b00219f34db8f6sm198423oab.46.2024.02.16.14.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:32:47 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] clk: samsung: Improve clk-cpu.c style
Date: Fri, 16 Feb 2024 16:32:31 -0600
Message-Id: <20240216223245.12273-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216223245.12273-1-semen.protsenko@linaro.org>
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk-cpu.c has numerous style issues reported by checkpatch and easily
identified otherwise. Give it some love and fix those warnings where it
makes sense. Also make stabilization time a named constant to get rid of
the magic number in clk-cpu.c.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-cpu.c | 65 ++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 3e62ade120c5..e02730776aaa 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -16,18 +16,18 @@
  * of the SoC or supplied after the SoC characterization.
  *
  * The below implementation of the CPU clock allows the rate changes of the CPU
- * clock and the corresponding rate changes of the auxillary clocks of the CPU
+ * clock and the corresponding rate changes of the auxiliary clocks of the CPU
  * domain. The platform clock driver provides a clock register configuration
  * for each configurable rate which is then used to program the clock hardware
- * registers to acheive a fast co-oridinated rate change for all the CPU domain
+ * registers to achieve a fast coordinated rate change for all the CPU domain
  * clocks.
  *
  * On a rate change request for the CPU clock, the rate change is propagated
- * upto the PLL supplying the clock to the CPU domain clock blocks. While the
+ * up to the PLL supplying the clock to the CPU domain clock blocks. While the
  * CPU domain PLL is reconfigured, the CPU domain clocks are driven using an
  * alternate clock source. If required, the alternate clock source is divided
  * down in order to keep the output clock rate within the previous OPP limits.
-*/
+ */
 
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -50,17 +50,19 @@
 #define E5433_DIV_STAT_CPU0	0x500
 #define E5433_DIV_STAT_CPU1	0x504
 
-#define E4210_DIV0_RATIO0_MASK	0x7
-#define E4210_DIV1_HPM_MASK	(0x7 << 4)
-#define E4210_DIV1_COPY_MASK	(0x7 << 0)
-#define E4210_MUX_HPM_MASK	(1 << 20)
+#define E4210_DIV0_RATIO0_MASK	GENMASK(2, 0)
+#define E4210_DIV1_HPM_MASK	GENMASK(6, 4)
+#define E4210_DIV1_COPY_MASK	GENMASK(2, 0)
+#define E4210_MUX_HPM_MASK	BIT(20)
 #define E4210_DIV0_ATB_SHIFT	16
 #define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
 
+/* Divider stabilization time, msec */
+#define MAX_STAB_TIME		10
 #define MAX_DIV			8
-#define DIV_MASK		7
-#define DIV_MASK_ALL		0xffffffff
-#define MUX_MASK		7
+#define DIV_MASK		GENMASK(2, 0)
+#define DIV_MASK_ALL		GENMASK(31, 0)
+#define MUX_MASK		GENMASK(2, 0)
 
 /*
  * Helper function to wait until divider(s) have stabilized after the divider
@@ -68,7 +70,7 @@
  */
 static void wait_until_divider_stable(void __iomem *div_reg, unsigned long mask)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	unsigned long timeout = jiffies + msecs_to_jiffies(MAX_STAB_TIME);
 
 	do {
 		if (!(readl(div_reg) & mask))
@@ -86,9 +88,9 @@ static void wait_until_divider_stable(void __iomem *div_reg, unsigned long mask)
  * value was changed.
  */
 static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,
-					unsigned long mux_value)
+				  unsigned long mux_value)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	unsigned long timeout = jiffies + msecs_to_jiffies(MAX_STAB_TIME);
 
 	do {
 		if (((readl(mux_reg) >> mux_pos) & MUX_MASK) == mux_value)
@@ -101,18 +103,18 @@ static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,
 	pr_err("%s: re-parenting mux timed-out\n", __func__);
 }
 
-/* common round rate callback useable for all types of CPU clocks */
-static long exynos_cpuclk_round_rate(struct clk_hw *hw,
-			unsigned long drate, unsigned long *prate)
+/* common round rate callback usable for all types of CPU clocks */
+static long exynos_cpuclk_round_rate(struct clk_hw *hw, unsigned long drate,
+				     unsigned long *prate)
 {
 	struct clk_hw *parent = clk_hw_get_parent(hw);
 	*prate = clk_hw_round_rate(parent, drate);
 	return *prate;
 }
 
-/* common recalc rate callback useable for all types of CPU clocks */
+/* common recalc rate callback usable for all types of CPU clocks */
 static unsigned long exynos_cpuclk_recalc_rate(struct clk_hw *hw,
-			unsigned long parent_rate)
+					       unsigned long parent_rate)
 {
 	/*
 	 * The CPU clock output (armclk) rate is the same as its parent
@@ -135,7 +137,7 @@ static const struct clk_ops exynos_cpuclk_clk_ops = {
  * dividers to be programmed.
  */
 static void exynos_set_safe_div(void __iomem *base, unsigned long div,
-					unsigned long mask)
+				unsigned long mask)
 {
 	unsigned long div0;
 
@@ -151,7 +153,6 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
 	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
-	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
 	unsigned long div0, div1 = 0, mux_reg;
 	unsigned long flags;
 
@@ -187,6 +188,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	 */
 	if (alt_prate > ndata->old_rate || ndata->old_rate > ndata->new_rate) {
 		unsigned long tmp_rate = min(ndata->old_rate, ndata->new_rate);
+		unsigned long alt_div, alt_div_mask = DIV_MASK;
 
 		alt_div = DIV_ROUND_UP(alt_prate, tmp_rate) - 1;
 		WARN_ON(alt_div >= MAX_DIV);
@@ -215,7 +217,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	if (cpuclk->flags & CLK_CPU_HAS_DIV1) {
 		writel(div1, base + E4210_DIV_CPU1);
 		wait_until_divider_stable(base + E4210_DIV_STAT_CPU1,
-				DIV_MASK_ALL);
+					  DIV_MASK_ALL);
 	}
 
 	spin_unlock_irqrestore(cpuclk->lock, flags);
@@ -263,7 +265,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
  * dividers to be programmed.
  */
 static void exynos5433_set_safe_div(void __iomem *base, unsigned long div,
-					unsigned long mask)
+				    unsigned long mask)
 {
 	unsigned long div0;
 
@@ -279,7 +281,6 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
 	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
-	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
 	unsigned long div0, div1 = 0, mux_reg;
 	unsigned long flags;
 
@@ -309,6 +310,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	 */
 	if (alt_prate > ndata->old_rate || ndata->old_rate > ndata->new_rate) {
 		unsigned long tmp_rate = min(ndata->old_rate, ndata->new_rate);
+		unsigned long alt_div, alt_div_mask = DIV_MASK;
 
 		alt_div = DIV_ROUND_UP(alt_prate, tmp_rate) - 1;
 		WARN_ON(alt_div >= MAX_DIV);
@@ -358,7 +360,7 @@ static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
  * notifications of the parent clock of cpuclk.
  */
 static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
-				unsigned long event, void *data)
+				     unsigned long event, void *data)
 {
 	struct clk_notifier_data *ndata = data;
 	struct exynos_cpuclk *cpuclk;
@@ -381,7 +383,7 @@ static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
  * notifications of the parent clock of cpuclk.
  */
 static int exynos5433_cpuclk_notifier_cb(struct notifier_block *nb,
-				unsigned long event, void *data)
+					 unsigned long event, void *data)
 {
 	struct clk_notifier_data *ndata = data;
 	struct exynos_cpuclk *cpuclk;
@@ -438,11 +440,10 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	else
 		cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
 
-
 	ret = clk_notifier_register(parent->clk, &cpuclk->clk_nb);
 	if (ret) {
 		pr_err("%s: failed to register clock notifier for %s\n",
-				__func__, name);
+		       __func__, name);
 		goto free_cpuclk;
 	}
 
@@ -454,7 +455,7 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 
 	ret = clk_hw_register(NULL, &cpuclk->hw);
 	if (ret) {
-		pr_err("%s: could not register cpuclk %s\n", __func__,	name);
+		pr_err("%s: could not register cpuclk %s\n", __func__, name);
 		goto free_cpuclk_data;
 	}
 
@@ -482,8 +483,8 @@ void __init samsung_clk_register_cpu(struct samsung_clk_provider *ctx,
 		for (num_cfgs = 0; list->cfg[num_cfgs].prate != 0; )
 			num_cfgs++;
 
-		exynos_register_cpu_clock(ctx, list->id, list->name, hws[list->parent_id],
-				hws[list->alt_parent_id], list->offset, list->cfg, num_cfgs,
-				list->flags);
+		exynos_register_cpu_clock(ctx, list->id, list->name,
+			hws[list->parent_id], hws[list->alt_parent_id],
+			list->offset, list->cfg, num_cfgs, list->flags);
 	}
 }
-- 
2.39.2


