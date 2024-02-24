Return-Path: <linux-kernel+bounces-79843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D986277D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9152282445
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F20C53377;
	Sat, 24 Feb 2024 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWQqARyI"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E24F61C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806065; cv=none; b=ap67WEhnF42PuVzQGxU57NOafNgpzDOJf9CzXRRUUdf0EdSdo99R0dcHw1gDF8gn6bhDGiT3z6GWrq8WqkCYATZQVcQ/2rQM1KK7rK7H5oxbYxnyPyrkxs/JtnY6aw6eTOKfcNLx2C0wdIaJfMerye0SzTMjBTfsVJBOSHG63hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806065; c=relaxed/simple;
	bh=/bokbG/13B4Rq8pTUpOOZajb+pMZCBVUzRNl3zqiVlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPb4GvwuFR+e6q/veHCIimyMye/ulIQi0bOlk332DEKgDkOLAqwJ17V7S3RAU6v+pAMLvpOfMy/O4UgaPyMlp7kUwyrshTyL9MbsLPKE3I532D8E5Z2X3skBA6GMYlY1Nzg0k6AT4TOd7jV+NrsTZFqtiwWZoyk5yzIltCBs344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWQqARyI; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21fa086008fso976175fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708806062; x=1709410862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN2UWeJ2Y6EenGAeuO3GljZkDZayc7fncQnG812Xabg=;
        b=FWQqARyIGVGB3b9zqZi0PRfqW2ofEdlgeYDqnBWC34R3JEJPBnh8Mr0YCJAQFQceM3
         JAirQibtjB9hgYuYrVN34eReuny7L8ktIQ5QaR0Xc5YIzWiTqix1PhVglQebQZUB4c3Y
         +bhyCdFfR+3j8bd0cEQoyiU2PtuJhrIenbwaC67NGJ097bGN9jN3N5b5Wx/IQoZrSJSC
         tLEwM+HQvHyh5vXbe+cJwY12UXe33fArXBiuBcM0Vq0omSIORyS34x6lR29RCZm5WPM1
         4FEyOwQDAnUhaK7m7DMUYvjnNFH5+N8/MN1ReLYgAfwvlRVEuAVDvW1iWawLAx5SnShR
         ifLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806062; x=1709410862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN2UWeJ2Y6EenGAeuO3GljZkDZayc7fncQnG812Xabg=;
        b=m5t2LVMInGxj3FwN8non+yP/S1UGhD9insN/Oz96foKuLXeQkaFQKTkXYWIrZ9IYwy
         OE56uQ/XMViexy1ta6zJuiRZHvjssOj+fXdEN0WghPT3jXfxiXPrP/TIDmB+f/8gnLcX
         PsjV31JeUC5j7cCwkD6GXqJnZgT1fAVxUowMmLubdgxGwl06cG34OQ1TnVLe/BB1Jj30
         U++Ehj/u/2d5etQaUjx+dsbmW5rEZmNYJr2kIKnngsSea3aLKXRX+2tiwmKvq6YZRshe
         wfGA02rRfOiu89khZ2EdUfBrvXdIJzehkUmu8BFDjwC1HP7U87HiuQ50LA9LhVvNojnw
         QvUw==
X-Forwarded-Encrypted: i=1; AJvYcCUgmGip+xdbINHfKjVZL9Clpg7G4WtfApejtOIGvpUW8P/9HzZOH0As1rrJMk3J3fvL9+GO4s8zKE+TXJMe2BQ3x6S9gMfjS4wYJltc
X-Gm-Message-State: AOJu0YzbC3924J3kY/kZwKLPQBB11DHoRAYly9KjlN5pklGR5qYrcSV+
	YliVuJ6hoaGQL6741gLVITae87BUDybbXat8O3ditJkJQFhIKY+HrpQLhKuCE80=
X-Google-Smtp-Source: AGHT+IFfqENRmopUTkTwwQ1a6djbqtdWtCsUtmwNY4lLcrJNH1YTphv/hiI7myCmYeGaYAnGis4G2A==
X-Received: by 2002:a05:6871:4cd:b0:21e:7ad8:dce8 with SMTP id n13-20020a05687104cd00b0021e7ad8dce8mr3125937oai.23.1708806062054;
        Sat, 24 Feb 2024 12:21:02 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id xd12-20020a056870ce4c00b0021f86169b99sm578648oab.43.2024.02.24.12.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:21:01 -0800 (PST)
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
Subject: [PATCH v3 10/15] clk: samsung: Keep register offsets in chip specific structure
Date: Sat, 24 Feb 2024 14:20:48 -0600
Message-Id: <20240224202053.25313-11-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240224202053.25313-1-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Abstract CPU clock registers by keeping their offsets in a dedicated
chip specific structure to accommodate for oncoming Exynos850 support,
which has different offsets for cluster 0 and cluster 1. This rework
also makes it possible to use exynos_set_safe_div() for all chips, so
exynos5433_set_safe_div() is removed here to reduce the code
duplication. The ".regs" field has to be (void *) as different Exynos
chips can have very different register layout, so this way it's possible
for ".regs" to point to different structures, each representing its own
chip's layout.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Changed struct exynos_cpuclk_chip.regs field type from (void *) to
    (struct exynls_cpuclk_regs *)
  - Moved struct exynos_cpuclk_regs above struct exynos_cpuclk_chip, as
    the former is used in the latter

Changes in v2:
  - Improved the commit message: explained why .regs field has to be
    (void *)
  - Changed .ctrl_base field to .base to reflect changes in previous
    commits

 drivers/clk/samsung/clk-cpu.c | 156 +++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 70 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index eb2b67d08f89..e29d08a1c8b3 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -43,14 +43,34 @@ struct exynos_cpuclk;
 typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
 				       struct exynos_cpuclk *cpuclk);
 
+/**
+ * struct exynos_cpuclk_regs - Register offsets for CPU related clocks
+ * @mux_sel: offset of CPU MUX_SEL register (for selecting MUX clock parent)
+ * @mux_stat: offset of CPU MUX_STAT register (for checking MUX clock status)
+ * @div_cpu0: offset of CPU DIV0 register (for modifying divider values)
+ * @div_cpu1: offset of CPU DIV1 register (for modifying divider values)
+ * @div_stat_cpu0: offset of CPU DIV0_STAT register (for checking DIV status)
+ * @div_stat_cpu1: offset of CPU DIV1_STAT register (for checking DIV status)
+ */
+struct exynos_cpuclk_regs {
+	u32 mux_sel;
+	u32 mux_stat;
+	u32 div_cpu0;
+	u32 div_cpu1;
+	u32 div_stat_cpu0;
+	u32 div_stat_cpu1;
+};
+
 /**
  * struct exynos_cpuclk_chip - Chip specific data for CPU clock
+ * @regs: register offsets for CPU related clocks
  * @pre_rate_cb: callback to run before CPU clock rate change
  * @post_rate_cb: callback to run after CPU clock rate change
  */
 struct exynos_cpuclk_chip {
-	exynos_rate_change_fn_t	pre_rate_cb;
-	exynos_rate_change_fn_t	post_rate_cb;
+	const struct exynos_cpuclk_regs * const	regs;
+	exynos_rate_change_fn_t			pre_rate_cb;
+	exynos_rate_change_fn_t			post_rate_cb;
 };
 
 /**
@@ -130,43 +150,48 @@ static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,
 	pr_err("%s: re-parenting mux timed-out\n", __func__);
 }
 
-/* ---- Exynos 3/4/5 -------------------------------------------------------- */
-
-#define E4210_SRC_CPU		0x200
-#define E4210_STAT_CPU		0x400
-#define E4210_DIV_CPU0		0x500
-#define E4210_DIV_CPU1		0x504
-#define E4210_DIV_STAT_CPU0	0x600
-#define E4210_DIV_STAT_CPU1	0x604
-
-#define E4210_DIV0_RATIO0_MASK	GENMASK(2, 0)
-#define E4210_DIV1_HPM_MASK	GENMASK(6, 4)
-#define E4210_DIV1_COPY_MASK	GENMASK(2, 0)
-#define E4210_MUX_HPM_MASK	BIT(20)
-#define E4210_DIV0_ATB_SHIFT	16
-#define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
-
 /*
  * Helper function to set the 'safe' dividers for the CPU clock. The parameters
  * div and mask contain the divider value and the register bit mask of the
  * dividers to be programmed.
  */
-static void exynos_set_safe_div(void __iomem *base, unsigned long div,
+static void exynos_set_safe_div(struct exynos_cpuclk *cpuclk, unsigned long div,
 				unsigned long mask)
 {
+	const struct exynos_cpuclk_regs * const regs = cpuclk->chip->regs;
+	void __iomem *base = cpuclk->base;
 	unsigned long div0;
 
-	div0 = readl(base + E4210_DIV_CPU0);
+	div0 = readl(base + regs->div_cpu0);
 	div0 = (div0 & ~mask) | (div & mask);
-	writel(div0, base + E4210_DIV_CPU0);
-	wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, mask);
+	writel(div0, base + regs->div_cpu0);
+	wait_until_divider_stable(base + regs->div_stat_cpu0, mask);
 }
 
+/* ---- Exynos 3/4/5 -------------------------------------------------------- */
+
+#define E4210_DIV0_RATIO0_MASK	GENMASK(2, 0)
+#define E4210_DIV1_HPM_MASK	GENMASK(6, 4)
+#define E4210_DIV1_COPY_MASK	GENMASK(2, 0)
+#define E4210_MUX_HPM_MASK	BIT(20)
+#define E4210_DIV0_ATB_SHIFT	16
+#define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
+
+static const struct exynos_cpuclk_regs e4210_cpuclk_regs = {
+	.mux_sel	= 0x200,
+	.mux_stat	= 0x400,
+	.div_cpu0	= 0x500,
+	.div_cpu1	= 0x504,
+	.div_stat_cpu0	= 0x600,
+	.div_stat_cpu1	= 0x604,
+};
+
 /* handler for pre-rate change notification from parent clock */
 static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 					 struct exynos_cpuclk *cpuclk)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	const struct exynos_cpuclk_regs * const regs = cpuclk->chip->regs;
 	void __iomem *base = cpuclk->base;
 	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
 	unsigned long div0, div1 = 0, mux_reg;
@@ -189,8 +214,8 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	div0 = cfg_data->div0;
 	if (cpuclk->flags & CLK_CPU_HAS_DIV1) {
 		div1 = cfg_data->div1;
-		if (readl(base + E4210_SRC_CPU) & E4210_MUX_HPM_MASK)
-			div1 = readl(base + E4210_DIV_CPU1) &
+		if (readl(base + regs->mux_sel) & E4210_MUX_HPM_MASK)
+			div1 = readl(base + regs->div_cpu1) &
 				(E4210_DIV1_HPM_MASK | E4210_DIV1_COPY_MASK);
 	}
 
@@ -217,22 +242,22 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 			alt_div |= E4210_DIV0_ATB_MASK;
 			alt_div_mask |= E4210_DIV0_ATB_MASK;
 		}
-		exynos_set_safe_div(base, alt_div, alt_div_mask);
+		exynos_set_safe_div(cpuclk, alt_div, alt_div_mask);
 		div0 |= alt_div;
 	}
 
 	/* select sclk_mpll as the alternate parent */
-	mux_reg = readl(base + E4210_SRC_CPU);
-	writel(mux_reg | (1 << 16), base + E4210_SRC_CPU);
-	wait_until_mux_stable(base + E4210_STAT_CPU, 16, 2);
+	mux_reg = readl(base + regs->mux_sel);
+	writel(mux_reg | (1 << 16), base + regs->mux_sel);
+	wait_until_mux_stable(base + regs->mux_stat, 16, 2);
 
 	/* alternate parent is active now. set the dividers */
-	writel(div0, base + E4210_DIV_CPU0);
-	wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, DIV_MASK_ALL);
+	writel(div0, base + regs->div_cpu0);
+	wait_until_divider_stable(base + regs->div_stat_cpu0, DIV_MASK_ALL);
 
 	if (cpuclk->flags & CLK_CPU_HAS_DIV1) {
-		writel(div1, base + E4210_DIV_CPU1);
-		wait_until_divider_stable(base + E4210_DIV_STAT_CPU1,
+		writel(div1, base + regs->div_cpu1);
+		wait_until_divider_stable(base + regs->div_stat_cpu1,
 					  DIV_MASK_ALL);
 	}
 
@@ -245,6 +270,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 					  struct exynos_cpuclk *cpuclk)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	const struct exynos_cpuclk_regs * const regs = cpuclk->chip->regs;
 	void __iomem *base = cpuclk->base;
 	unsigned long div = 0, div_mask = DIV_MASK;
 	unsigned long mux_reg;
@@ -262,50 +288,37 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	spin_lock_irqsave(cpuclk->lock, flags);
 
 	/* select mout_apll as the alternate parent */
-	mux_reg = readl(base + E4210_SRC_CPU);
-	writel(mux_reg & ~(1 << 16), base + E4210_SRC_CPU);
-	wait_until_mux_stable(base + E4210_STAT_CPU, 16, 1);
+	mux_reg = readl(base + regs->mux_sel);
+	writel(mux_reg & ~(1 << 16), base + regs->mux_sel);
+	wait_until_mux_stable(base + regs->mux_stat, 16, 1);
 
 	if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 		div |= (cfg_data->div0 & E4210_DIV0_ATB_MASK);
 		div_mask |= E4210_DIV0_ATB_MASK;
 	}
 
-	exynos_set_safe_div(base, div, div_mask);
+	exynos_set_safe_div(cpuclk, div, div_mask);
 	spin_unlock_irqrestore(cpuclk->lock, flags);
 	return 0;
 }
 
 /* ---- Exynos5433 ---------------------------------------------------------- */
 
-#define E5433_MUX_SEL2		0x208
-#define E5433_MUX_STAT2		0x408
-#define E5433_DIV_CPU0		0x600
-#define E5433_DIV_CPU1		0x604
-#define E5433_DIV_STAT_CPU0	0x700
-#define E5433_DIV_STAT_CPU1	0x704
-
-/*
- * Helper function to set the 'safe' dividers for the CPU clock. The parameters
- * div and mask contain the divider value and the register bit mask of the
- * dividers to be programmed.
- */
-static void exynos5433_set_safe_div(void __iomem *base, unsigned long div,
-				    unsigned long mask)
-{
-	unsigned long div0;
-
-	div0 = readl(base + E5433_DIV_CPU0);
-	div0 = (div0 & ~mask) | (div & mask);
-	writel(div0, base + E5433_DIV_CPU0);
-	wait_until_divider_stable(base + E5433_DIV_STAT_CPU0, mask);
-}
+static const struct exynos_cpuclk_regs e5433_cpuclk_regs = {
+	.mux_sel	= 0x208,
+	.mux_stat	= 0x408,
+	.div_cpu0	= 0x600,
+	.div_cpu1	= 0x604,
+	.div_stat_cpu0	= 0x700,
+	.div_stat_cpu1	= 0x704,
+};
 
 /* handler for pre-rate change notification from parent clock */
 static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 					     struct exynos_cpuclk *cpuclk)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	const struct exynos_cpuclk_regs * const regs = cpuclk->chip->regs;
 	void __iomem *base = cpuclk->base;
 	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
 	unsigned long div0, div1 = 0, mux_reg;
@@ -342,21 +355,21 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 		alt_div = DIV_ROUND_UP(alt_prate, tmp_rate) - 1;
 		WARN_ON(alt_div >= MAX_DIV);
 
-		exynos5433_set_safe_div(base, alt_div, alt_div_mask);
+		exynos_set_safe_div(cpuclk, alt_div, alt_div_mask);
 		div0 |= alt_div;
 	}
 
 	/* select the alternate parent */
-	mux_reg = readl(base + E5433_MUX_SEL2);
-	writel(mux_reg | 1, base + E5433_MUX_SEL2);
-	wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 2);
+	mux_reg = readl(base + regs->mux_sel);
+	writel(mux_reg | 1, base + regs->mux_sel);
+	wait_until_mux_stable(base + regs->mux_stat, 0, 2);
 
 	/* alternate parent is active now. set the dividers */
-	writel(div0, base + E5433_DIV_CPU0);
-	wait_until_divider_stable(base + E5433_DIV_STAT_CPU0, DIV_MASK_ALL);
+	writel(div0, base + regs->div_cpu0);
+	wait_until_divider_stable(base + regs->div_stat_cpu0, DIV_MASK_ALL);
 
-	writel(div1, base + E5433_DIV_CPU1);
-	wait_until_divider_stable(base + E5433_DIV_STAT_CPU1, DIV_MASK_ALL);
+	writel(div1, base + regs->div_cpu1);
+	wait_until_divider_stable(base + regs->div_stat_cpu1, DIV_MASK_ALL);
 
 	spin_unlock_irqrestore(cpuclk->lock, flags);
 	return 0;
@@ -366,6 +379,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 					      struct exynos_cpuclk *cpuclk)
 {
+	const struct exynos_cpuclk_regs * const regs = cpuclk->chip->regs;
 	void __iomem *base = cpuclk->base;
 	unsigned long div = 0, div_mask = DIV_MASK;
 	unsigned long mux_reg;
@@ -374,11 +388,11 @@ static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	spin_lock_irqsave(cpuclk->lock, flags);
 
 	/* select apll as the alternate parent */
-	mux_reg = readl(base + E5433_MUX_SEL2);
-	writel(mux_reg & ~1, base + E5433_MUX_SEL2);
-	wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 1);
+	mux_reg = readl(base + regs->mux_sel);
+	writel(mux_reg & ~1, base + regs->mux_sel);
+	wait_until_mux_stable(base + regs->mux_stat, 0, 1);
 
-	exynos5433_set_safe_div(base, div, div_mask);
+	exynos_set_safe_div(cpuclk, div, div_mask);
 	spin_unlock_irqrestore(cpuclk->lock, flags);
 	return 0;
 }
@@ -436,10 +450,12 @@ static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
 
 static const struct exynos_cpuclk_chip exynos_clkcpu_chips[] = {
 	[CPUCLK_LAYOUT_E4210] = {
+		.regs		= &e4210_cpuclk_regs,
 		.pre_rate_cb	= exynos_cpuclk_pre_rate_change,
 		.post_rate_cb	= exynos_cpuclk_post_rate_change,
 	},
 	[CPUCLK_LAYOUT_E5433] = {
+		.regs		= &e5433_cpuclk_regs,
 		.pre_rate_cb	= exynos5433_cpuclk_pre_rate_change,
 		.post_rate_cb	= exynos5433_cpuclk_post_rate_change,
 	},
-- 
2.39.2


