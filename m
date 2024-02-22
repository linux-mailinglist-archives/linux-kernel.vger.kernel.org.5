Return-Path: <linux-kernel+bounces-75827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44D85EF99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A3B2352E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002A2940D;
	Thu, 22 Feb 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1k+yJGC"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A72233B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570970; cv=none; b=VoaFWQ0mRH/ibrin6DmmrYld8h93FJ96dECSexlHyQbpRFMjl4p+S3uRGnUcJWcsrN6OYUZh08pJC7Zz9zV0FJeKpzoE6Axq/EINxe5+jt/tVkf+15Np/IoZsv3xYDA407+dxSNwNVRQiH0NDLRH/K/PWxf7u6DTH+JlY8kTx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570970; c=relaxed/simple;
	bh=ndooDbku8kIQaCfAwEvZLh2O8ok1jgIAYCDtodmMyoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjeiqvfxnFJHM51b/bpO2SS+YAhtQ3e2tGxSHK2HQIMdOoF/zesb5xjB6D53LF/vQ+tK3cyAbXEFSbAOlyWv8hKeGQRCNHCaWp7/Nt9LaTxUmUdXo4HdcI/wkeFV60w4ote1MBOo5zW48EdE1mTq0HIENZiGbpbnDG+oqziIuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z1k+yJGC; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c15bfa17b2so695342b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708570966; x=1709175766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu/V/yIxxPTU9BuvQgksMezTJmyKx+N2w/iRf/Kb/uE=;
        b=Z1k+yJGCKr6DrMRaXb/VQgPlOmQj7wxhpbi0p5W+TbIhpJT5xmpU3qqZF7HYxHrvfp
         QjwKXeRignzavv1GoS4rWfQ9JzrbF/8IfOULjuMQKSZQNr09rnqmH82qGr1jnPE/NqSw
         kBRRlku2YdNMsUjIsRwT7a8KrjRcHf91hEYhPLK6qi3wPSAhDmjYeZuGvnvT5X1+N7hi
         pSmdozDMcfw/WSJPkQUOchUsFfQNn3fJbz9deRz7wXAY0et1pEudfBSpjH1EowI91634
         xp/P9GUWa651OKm5NXsiluwGHZtRtk8lxLCWPNknQlia13ZDvPaQA+ee5+yjndyl3ONn
         OVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708570966; x=1709175766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu/V/yIxxPTU9BuvQgksMezTJmyKx+N2w/iRf/Kb/uE=;
        b=luCEgZoiMaIF/ysPnuBoawXs7qEG7EPkrxSq6uyo6hm28JMYlKE+vrQ+4F4n7GgXWx
         PysAqVPAS/n+PSFTJFCKMJH/XX3VLvwTSUH0rHmQv5tJcjyRft6nkf/1fOQccTAfjYZn
         OcTjXuqbeEJhkolSKtXk07dyv0VlkOwNyap5H3Z+iRpwxcmYbMIyuRiWTPyMijAPWbcE
         ewWI9Dj76ztBLpRvjR//rswWZ4ED7QhZog09E/Q+/RI8EN27sVGWd1fcYpkd8cnSJOJr
         aTin/3O5YMHc2ajFLipxdliuwpYJjE28UBabHV5K+/jWNCHoDa2sd4ilNgxpfnuKPx5t
         pkCg==
X-Forwarded-Encrypted: i=1; AJvYcCWwkoNh164TJiXUFGMpE7V2vHcjj7OHrZllXSgImgASoOPJkpyl+HjWPruK/8eFUTF/ElSORPPGhzS7hG9oR7dUT5cgyk5OmNiwsL4d
X-Gm-Message-State: AOJu0YxU10KW7n6HKijBILZ72XnoQZBJT27XXZKj21QlFySVdL5E2ggW
	H1pi7uIGTTcG62Xl8l578RjxHm0/4CXmgjb+TP4mE5/SrDEcq/ifOZVwFHCB6tk=
X-Google-Smtp-Source: AGHT+IHPfXGtwYRjqJtRE72B3DjWSJUtuvJRZsdgap9ekkYqdlVlAd1Lwfog12HtnZSLtW81xSOjAg==
X-Received: by 2002:a05:6808:1642:b0:3c0:4d21:e62a with SMTP id az2-20020a056808164200b003c04d21e62amr24604480oib.31.1708570966119;
        Wed, 21 Feb 2024 19:02:46 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id d28-20020a05680808fc00b003c16c9977d5sm587777oic.21.2024.02.21.19.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 19:02:45 -0800 (PST)
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
Subject: [PATCH v2 12/15] clk: samsung: Add CPU clock support for Exynos850
Date: Wed, 21 Feb 2024 21:02:32 -0600
Message-Id: <20240222030235.27815-13-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222030235.27815-1-semen.protsenko@linaro.org>
References: <20240222030235.27815-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement CPU clock control for Exynos850 SoC. It follows the same
procedure which is already implemented for other SoCs in clk-cpu.c:

1. Set the correct rate for the alternate parent (if needed) before
   switching to use it as the CPU clock
2. Switch to the alternate parent, so the CPU continues to get clocked
   while the PLL is being re-configured
3. Adjust the dividers for the CPU related buses (ACLK, ATCLK, etc)
4. Re-configure the PLL for the new CPU clock rate. It's done
   automatically, as the CPU clock rate change propagates to the PLL
   clock, because the CPU clock has CLK_SET_RATE_PARENT flag set in
   exynos_register_cpu_clock()
5. Once the PLL is locked, set it back as the CPU clock source
6. Set alternate parent clock rate back to max speed

As in already existing clk-cpu.c code, the divider and mux clocks are
configured in a low-level fashion (using direct register access instead
of CCF API), to avoid affecting how DIV and MUX clock flags are declared
in the actual clock driver (clk-exynos850.c).

No functional change. This patch adds support for Exynos850 CPU clock,
but doesn't enable it per se.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Changed .ctrl_base field to .base, to reflect changes made in
    previous commits

 drivers/clk/samsung/clk-cpu.c | 183 ++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-cpu.h |   4 +
 2 files changed, 187 insertions(+)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 89b24fd5d0a9..34c195a980b2 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -29,6 +29,7 @@
  * down in order to keep the output clock rate within the previous OPP limits.
  */
 
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -397,6 +398,178 @@ static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	return 0;
 }
 
+/* ---- Exynos850 ----------------------------------------------------------- */
+
+#define E850_DIV_RATIO_MASK	GENMASK(3, 0)
+#define E850_BUSY_MASK		BIT(16)
+
+/* Max time for divider or mux to stabilize, usec */
+#define E850_DIV_MUX_STAB_TIME	100
+/* OSCCLK clock rate, Hz */
+#define E850_OSCCLK		(26 * MHZ)
+
+/**
+ * struct exynos850_cpuclk_regs - Register offsets for Exynos850 CPU clocks
+ * @mux:		offset of MUX register for choosing CPU clock source
+ * @divs:		offsets of DIV registers (ACLK, ATCLK, PCLKDBG and
+ *			PERIPHCLK)
+ */
+struct exynos850_cpuclk_regs {
+	u32 mux;
+	u32 divs[4];
+};
+
+static const struct exynos850_cpuclk_regs e850cl0_cpuclk_regs = {
+	.mux	= 0x100c,
+	.divs	= { 0x1800, 0x1808, 0x180c, 0x1810 },
+};
+
+static const struct exynos850_cpuclk_regs e850cl1_cpuclk_regs = {
+	.mux	= 0x1000,
+	.divs	= { 0x1800, 0x1808, 0x180c, 0x1810 },
+};
+
+/*
+ * Set alternate parent rate to "rate" value or less.
+ *
+ * rate: Desired alt_parent rate, or 0 for max alt_parent rate
+ *
+ * Exynos850 doesn't have CPU clock divider in CMU_CPUCLx block (CMUREF divider
+ * doesn't affect CPU speed). So CPUCLx_SWITCH divider from CMU_TOP is used
+ * instead to adjust alternate parent speed.
+ *
+ * It's possible to use clk_set_max_rate() instead of this function, but it
+ * would set overly pessimistic rate values to alternate parent.
+ */
+static int exynos850_alt_parent_set_max_rate(const struct clk_hw *alt_parent,
+					     unsigned long rate)
+{
+	struct clk_hw *clk_div, *clk_divp;
+	unsigned long divp_rate, div_rate, div;
+	int ret;
+
+	/* Divider from CMU_TOP */
+	clk_div = clk_hw_get_parent(alt_parent);
+	if (!clk_div)
+		return -ENOENT;
+	/* Divider's parent from CMU_TOP */
+	clk_divp = clk_hw_get_parent(clk_div);
+	if (!clk_divp)
+		return -ENOENT;
+	/* Divider input rate */
+	divp_rate = clk_hw_get_rate(clk_divp);
+	if (!divp_rate)
+		return -EINVAL;
+
+	/* Calculate new alt_parent rate for integer divider value */
+	if (rate == 0)
+		div = 1;
+	else
+		div = DIV_ROUND_UP(divp_rate, rate);
+	div_rate = DIV_ROUND_UP(divp_rate, div);
+	WARN_ON(div >= MAX_DIV);
+
+	/* alt_parent will propagate this change up to the divider */
+	ret = clk_set_rate(alt_parent->clk, div_rate);
+	if (ret)
+		return ret;
+	udelay(E850_DIV_MUX_STAB_TIME);
+
+	return 0;
+}
+
+/* Handler for pre-rate change notification from parent clock */
+static int exynos850_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
+					    struct exynos_cpuclk *cpuclk)
+{
+	const unsigned int shifts[4] = { 16, 12, 8, 4 }; /* E850_CPU_DIV0() */
+	const struct exynos850_cpuclk_regs * const regs = cpuclk->chip->regs;
+	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	const struct clk_hw *alt_parent = cpuclk->alt_parent;
+	void __iomem *base = cpuclk->base;
+	unsigned long alt_prate = clk_hw_get_rate(alt_parent);
+	unsigned long flags;
+	u32 mux_reg;
+	size_t i;
+	int ret;
+
+	/* No actions are needed when switching to or from OSCCLK parent */
+	if (ndata->new_rate == E850_OSCCLK || ndata->old_rate == E850_OSCCLK)
+		return 0;
+
+	/* Find out the divider values to use for clock data */
+	while ((cfg_data->prate * 1000) != ndata->new_rate) {
+		if (cfg_data->prate == 0)
+			return -EINVAL;
+		cfg_data++;
+	}
+
+	/*
+	 * If the old parent clock speed is less than the clock speed of
+	 * the alternate parent, then it should be ensured that at no point
+	 * the armclk speed is more than the old_prate until the dividers are
+	 * set.  Also workaround the issue of the dividers being set to lower
+	 * values before the parent clock speed is set to new lower speed
+	 * (this can result in too high speed of armclk output clocks).
+	 */
+	if (alt_prate > ndata->old_rate || ndata->old_rate > ndata->new_rate) {
+		unsigned long tmp_rate = min(ndata->old_rate, ndata->new_rate);
+
+		ret = exynos850_alt_parent_set_max_rate(alt_parent, tmp_rate);
+		if (ret)
+			return ret;
+	}
+
+	spin_lock_irqsave(cpuclk->lock, flags);
+
+	/* Select the alternate parent */
+	mux_reg = readl(base + regs->mux);
+	writel(mux_reg | 1, base + regs->mux);
+	wait_until_mux_stable(base + regs->mux, 16, 1, 0);
+
+	/* Alternate parent is active now. Set the dividers */
+	for (i = 0; i < ARRAY_SIZE(shifts); ++i) {
+		unsigned long div = (cfg_data->div0 >> shifts[i]) & 0xf;
+		u32 val;
+
+		val = readl(base + regs->divs[i]);
+		val = (val & ~E850_DIV_RATIO_MASK) | div;
+		writel(val, base + regs->divs[i]);
+		wait_until_divider_stable(base + regs->divs[i], E850_BUSY_MASK);
+	}
+
+	spin_unlock_irqrestore(cpuclk->lock, flags);
+
+	return 0;
+}
+
+/* Handler for post-rate change notification from parent clock */
+static int exynos850_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
+					     struct exynos_cpuclk *cpuclk)
+{
+	const struct exynos850_cpuclk_regs * const regs = cpuclk->chip->regs;
+	const struct clk_hw *alt_parent = cpuclk->alt_parent;
+	void __iomem *base = cpuclk->base;
+	unsigned long flags;
+	u32 mux_reg;
+
+	/* No actions are needed when switching to or from OSCCLK parent */
+	if (ndata->new_rate == E850_OSCCLK || ndata->old_rate == E850_OSCCLK)
+		return 0;
+
+	spin_lock_irqsave(cpuclk->lock, flags);
+
+	/* Select main parent (PLL) for mux */
+	mux_reg = readl(base + regs->mux);
+	writel(mux_reg & ~1, base + regs->mux);
+	wait_until_mux_stable(base + regs->mux, 16, 1, 0);
+
+	spin_unlock_irqrestore(cpuclk->lock, flags);
+
+	/* Set alt_parent rate back to max */
+	return exynos850_alt_parent_set_max_rate(alt_parent, 0);
+}
+
 /* -------------------------------------------------------------------------- */
 
 /* Common round rate callback usable for all types of CPU clocks */
@@ -459,6 +632,16 @@ static const struct exynos_cpuclk_chip exynos_clkcpu_chips[] = {
 		.pre_rate_cb	= exynos5433_cpuclk_pre_rate_change,
 		.post_rate_cb	= exynos5433_cpuclk_post_rate_change,
 	},
+	[CPUCLK_LAYOUT_E850_CL0] = {
+		.regs		= &e850cl0_cpuclk_regs,
+		.pre_rate_cb	= exynos850_cpuclk_pre_rate_change,
+		.post_rate_cb	= exynos850_cpuclk_post_rate_change,
+	},
+	[CPUCLK_LAYOUT_E850_CL1] = {
+		.regs		= &e850cl1_cpuclk_regs,
+		.pre_rate_cb	= exynos850_cpuclk_pre_rate_change,
+		.post_rate_cb	= exynos850_cpuclk_post_rate_change,
+	},
 };
 
 /* helper function to register a CPU clock */
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index 4382ab005ad3..892843611b0a 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -17,10 +17,14 @@
  * enum exynos_cpuclk_layout - CPU clock registers layout compatibility
  * @CPUCLK_LAYOUT_E4210: Exynos4210 compatible layout
  * @CPUCLK_LAYOUT_E5433: Exynos5433 compatible layout
+ * @CPUCLK_LAYOUT_E850_CL0: Exynos850 cluster 0 compatible layout
+ * @CPUCLK_LAYOUT_E850_CL1: Exynos850 cluster 1 compatible layout
  */
 enum exynos_cpuclk_layout {
 	CPUCLK_LAYOUT_E4210,
 	CPUCLK_LAYOUT_E5433,
+	CPUCLK_LAYOUT_E850_CL0,
+	CPUCLK_LAYOUT_E850_CL1,
 };
 
 /**
-- 
2.39.2


