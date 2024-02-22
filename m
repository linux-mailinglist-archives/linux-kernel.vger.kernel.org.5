Return-Path: <linux-kernel+bounces-75828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C885EF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEBF1F235D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552562BAEB;
	Thu, 22 Feb 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scZRBduR"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02F224FB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570970; cv=none; b=UBbf5h4XFWP1hN7wwfRhjewNmq14frXhrt3d+s0gHSrfgrKctJ+gm06taN6J5c7fR/qDYhMMWMqsOqXEE6P7yMAhU3ADaTA2X/L/beFOby858mpV57VGYo7g11QeInhIuEXPSOMME2MXClMW9I8L4ITJKhr/Nr9THmoWgYKrRZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570970; c=relaxed/simple;
	bh=r6h1NTeFTkbjAGya8zua/jcWtSX1k++dA2oUrhCyAv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxAuGItieNr0nwbCPPGJVO41DNNZKjSPjFSIkkl4zLk5CrwR6T7iacHlyjhH+sf+9A2PG8wvf/wUwrErnnKaUE4EQCkMMkSC2w+1zfLk5+rJLaXJ5JT8WKHs45R0eU3VufuuYfqYTBFVrZpagQiQA39k6ajOxjVT8y04m184BtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=scZRBduR; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1652613d3so1912358b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708570967; x=1709175767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FVV9XkzNkckGF5r8p15gninEMa0F9j2UMwTU7X9t5U=;
        b=scZRBduRa515C5gQ60zOEJASctFC4+FOyPMXT6OFTaWZQO0PNNlZIiFTHlD3b5spHU
         o3uMSi7tWHsEhcUkWauWZXFGdI0F8Ef0g/X7VgrcM2789owNsubqrHKmH23xTDXYAGjv
         T+Tl8+5oCOuXizo752X8sSyWGggGClU3LZyQ4+tsdZyLo8cX4DWurdvtNQ5Cr8TM7OOS
         ph9b6zCZGRBylEhfYCp+I3ObpQGSwKNjYMle6jiM4Z0ISzKv722DHtzDLc/moZitLJ/S
         P8RhQYG2BIlJp/EHA0j5AofZuUqbxhae+ohNzi2D2yYZKBd/avhcB3GV9i0Ko7gspTQo
         a4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708570967; x=1709175767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FVV9XkzNkckGF5r8p15gninEMa0F9j2UMwTU7X9t5U=;
        b=it/avuRlxYmzcYeP3VOf1TGafcSBLG1TGWRqsy03Eb0wNT5ZZ3DNLs/ceGsJMVLRlc
         njuzq+kSXJlA9ClTGuwKQOeJ8FB3pWmscXtLz5RaJzU3E0QfKGEy7c4ET3Wb1UaF/qk+
         zufPfRgcnAs53LciI3xbEFu8keUVEdlew0k+UjRGp/ShpGUYnDe8h/hQj3ZwbsedCc/f
         7CKlK05iymYTjA8CP/UoqErFeXlsyl7McW8WASgClLN6nEUGXV3KYK0MvXaMnhxT0QuJ
         I5014M95GJa74S1HCEkqveheRQkq+SlbreuehKMshQQMB/YzZdrfFYIHOMQpAn11JopD
         3R8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7Sr3y+QKFj9ZDrIlYMbPZ/ySeKpWrCTuG9syWhozGGs42N7I5cn7paDsgIO+APe2r40yXNw4e3K+41Z0Uwq3KwW/fNb3lBjthWUrT
X-Gm-Message-State: AOJu0YwIrC3SyokbePDcYnSEE3HX1RjhYFZ2b/iHqTK/BcNeurbnXR6Y
	LrTUDysOlI1RoU2iGtPZqr4+Q2ByU1GqgIXynJAJIzBfLb6Wox+RZpgfX8ovG6U=
X-Google-Smtp-Source: AGHT+IFDqLwUZKoz0hGjxt5wtidJ2c+JHpOH/RWc0W4xfJqMkTkS0kRod9I9+S/Y+Pj5xpFpNXgpIg==
X-Received: by 2002:a05:6808:1249:b0:3c1:7c2b:8d51 with SMTP id o9-20020a056808124900b003c17c2b8d51mr229612oiv.54.1708570967058;
        Wed, 21 Feb 2024 19:02:47 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id l26-20020aca191a000000b003c16b1d3862sm640909oii.50.2024.02.21.19.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 19:02:46 -0800 (PST)
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
Subject: [PATCH v2 13/15] clk: samsung: Implement manual PLL control for ARM64 SoCs
Date: Wed, 21 Feb 2024 21:02:33 -0600
Message-Id: <20240222030235.27815-14-semen.protsenko@linaro.org>
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

Some ARM64 Exynos chips are capable to control PLL clocks automatically.
For those chips, whether the PLL is controlled automatically or manually
is chosen in PLL_CON1 register with next bits:

    [28]  ENABLE_AUTOMATIC_CLKGATING
    [1]   MANUAL_PLL_CTRL
    [0]   AUTO_PLL_CTRL

The bl2 bootloader sets 0x10000001 value for some PLL_CON1 registers,
which means any attempt to control those PLLs manually (e.g.
disabling/enabling those PLLs or changing MUX parent clocks) would lead
to PLL lock timeout with error message like this:

    Could not lock PLL ...

At the moment, all Samsung clock drivers implement manual clock control.
So in order to make it possible to control PLLs, corresponding PLL_CON1
registers should be set to 0x2 first.

Some older ARM64 chips don't implement the automatic clock control
though. It also might be desirable to configure some PLLs for manual
control, while keeping the default configuration for the rest. So it'd
convenient to choose this PLL mode for each CMU separately. Introduce
manual_plls field to CMU structure to choose the PLL control mode.
Because it'll be initialized with "false" in all existing CMU
structures by default, it won't affect any existing clock drivers,
allowing for this feature to be enabled gradually when it's needed with
no change for the rest of users. In case .manual_plls is set, set
PLL_CON1 registers to manual control, akin to what's already done for
gate clocks in exynos_arm64_init_clocks(). Of course, PLL_CON1 registers
should be added to corresponding struct samsung_cmu_info::clk_regs array
to make sure they get initialized.

No functional change. This patch adds a feature, but doesn't enable it
for any users.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - none

 drivers/clk/samsung/clk-exynos-arm64.c | 44 +++++++++++++++++---------
 drivers/clk/samsung/clk.h              |  4 +++
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
index 6fb7194df7ab..55490209b9a9 100644
--- a/drivers/clk/samsung/clk-exynos-arm64.c
+++ b/drivers/clk/samsung/clk-exynos-arm64.c
@@ -25,6 +25,19 @@
 #define GATE_OFF_START		0x2000
 #define GATE_OFF_END		0x2fff
 
+/* PLL CON register offsets range */
+#define PLL_CON_START		0x100
+#define PLL_CON_END		0x600
+
+/* PLL register bits */
+#define PLL_CON1_MANUAL		BIT(1)
+
+/* Helper macros to check for particular clock regiter by its offset */
+#define IS_GATE_REG(o)		((o) >= GATE_OFF_START && (o) <= GATE_OFF_END)
+#define IS_PLL_CONx_REG(o)	((o) >= PLL_CON_START && (o) <= PLL_CON_END)
+#define IS_PLL_CON1_REG(o)	\
+	(IS_PLL_CONx_REG(o) && ((o) & 0xf) == 0x4 && !((o) & 0x10))
+
 struct exynos_arm64_cmu_data {
 	struct samsung_clk_reg_dump *clk_save;
 	unsigned int nr_clk_save;
@@ -40,15 +53,16 @@ struct exynos_arm64_cmu_data {
 
 /**
  * exynos_arm64_init_clocks - Set clocks initial configuration
- * @np:			CMU device tree node with "reg" property (CMU addr)
- * @reg_offs:		Register offsets array for clocks to init
- * @reg_offs_len:	Number of register offsets in reg_offs array
+ * @np:		CMU device tree node with "reg" property (CMU addr)
+ * @cmu:	CMU data
  *
- * Set manual control mode for all gate clocks.
+ * Set manual control mode for all gate and PLL clocks.
  */
 static void __init exynos_arm64_init_clocks(struct device_node *np,
-		const unsigned long *reg_offs, size_t reg_offs_len)
+					    const struct samsung_cmu_info *cmu)
 {
+	const unsigned long *reg_offs = cmu->clk_regs;
+	size_t reg_offs_len = cmu->nr_clk_regs;
 	void __iomem *reg_base;
 	size_t i;
 
@@ -60,14 +74,14 @@ static void __init exynos_arm64_init_clocks(struct device_node *np,
 		void __iomem *reg = reg_base + reg_offs[i];
 		u32 val;
 
-		/* Modify only gate clock registers */
-		if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OFF_END)
-			continue;
-
-		val = readl(reg);
-		val |= GATE_MANUAL;
-		val &= ~GATE_ENABLE_HWACG;
-		writel(val, reg);
+		if (cmu->manual_plls && IS_PLL_CON1_REG(reg_offs[i])) {
+			writel(PLL_CON1_MANUAL, reg);
+		} else if (IS_GATE_REG(reg_offs[i])) {
+			val = readl(reg);
+			val |= GATE_MANUAL;
+			val &= ~GATE_ENABLE_HWACG;
+			writel(val, reg);
+		}
 	}
 
 	iounmap(reg_base);
@@ -177,7 +191,7 @@ void __init exynos_arm64_register_cmu(struct device *dev,
 		pr_err("%s: could not enable bus clock %s; err = %d\n",
 		       __func__, cmu->clk_name, err);
 
-	exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
+	exynos_arm64_init_clocks(np, cmu);
 	samsung_cmu_register_one(np, cmu);
 }
 
@@ -224,7 +238,7 @@ int __init exynos_arm64_register_cmu_pm(struct platform_device *pdev,
 		       __func__, cmu->clk_name, ret);
 
 	if (set_manual)
-		exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
+		exynos_arm64_init_clocks(np, cmu);
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index a763309e6f12..a70bd7cce39f 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -330,6 +330,7 @@ struct samsung_clock_reg_cache {
  * @suspend_regs: list of clock registers to set before suspend
  * @nr_suspend_regs: count of clock registers in @suspend_regs
  * @clk_name: name of the parent clock needed for CMU register access
+ * @manual_plls: Enable manual control for PLL clocks
  */
 struct samsung_cmu_info {
 	const struct samsung_pll_clock *pll_clks;
@@ -354,6 +355,9 @@ struct samsung_cmu_info {
 	const struct samsung_clk_reg_dump *suspend_regs;
 	unsigned int nr_suspend_regs;
 	const char *clk_name;
+
+	/* ARM64 Exynos CMUs */
+	bool manual_plls;
 };
 
 struct samsung_clk_provider *samsung_clk_init(struct device *dev,
-- 
2.39.2


