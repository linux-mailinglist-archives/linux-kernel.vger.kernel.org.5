Return-Path: <linux-kernel+bounces-69412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C98588A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE061C21AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801BA14A4D2;
	Fri, 16 Feb 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGelz+X2"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F55148FE3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122774; cv=none; b=GrQNTG0lv3OFt2BH1e1GFdo+iNQ+256JNYOC4rI7DC+V8PYGXgGdB1i3IL+GhCzanJugLc7YZeFkV9WxqjqGcacz9E9PD/zUhjzQzegFjzsYWwTsu7LRAeOpVE8qjUaFXbJ1QNBuHa9UH0iLEFLVBHXvTaBNBGHQkcgYgxoMhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122774; c=relaxed/simple;
	bh=fUhPeOsXzdNBsgyQxrK5IygDWIDaj8fhKRsiYpXQ/2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewLU79Kr8drsHwlm11azVNJ6+M1FbngH/V09MA0d1CNSkBdVVszE9IXxKUrkRMp9fWR/AngaQDMUH9l24V9rUTNIsIMmv04JBRr7MicqQ36tzf58j+PLXz9hfLtnx69n9XIIOHvJ+IRj9BV4QhThX776+N6ewp+jB7xBxU/R03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGelz+X2; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2185a9966bcso1005790fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708122771; x=1708727571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlC/G6qyLD1CwPpss1xClTu9E95TKvCvWeyrCtKG5kY=;
        b=qGelz+X2/WUYFpaVUPxY+y87ukCI3bLkN9E4o1PmfA7C/0+rh2oVbnFdS4VRXDsJvy
         BeLhlGBKI6smGXcQyPZrXZ7jr8m4x/wAqHnmQIPz+CSLkNZWRlEO4psI3ELXqlx7p2Sd
         wLCLlK5gzg7WfEPTYDT8AgjMFs+B29/v586OKe4JbMrIx3VC5qussasvaidDPReJfYVx
         j4I3gysef9kCc7dUUBJrknj6OLtYpeX6cNTF+9ffIe+d17/hcZACz2g2bMNrEj7I/WkK
         QXbfLnGr6OYXb0EexN99y3SyxQUPiOEIrAdHYiqFSzge6flefkVps8dQg98EggIGHhWD
         5DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122771; x=1708727571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlC/G6qyLD1CwPpss1xClTu9E95TKvCvWeyrCtKG5kY=;
        b=PKEV/ySQyliDYZlcaW3eYXYoEUED8guIkOM3LH+PKfiWGYhsqa/n/8P22iRw40sY76
         4tltpdR6tN146tFz3uGWa4zCzhDBtQCkxyOVd9+UA3r6ETtofN70NLC3Yx2BRle/VZhL
         6zCBuU9hdIMViON8IiLF19/XyrytwxUeylY8lwlKknhO5SwEUKQ4UafiwpV/KkZvBN8K
         49LjrxqhAnKCc2b1shekHPuzKB5PEMPYTorja2X4bX8GOL/j3AfvtzEN0JfjgNhOTzeF
         NMYnK6M+OhkNM26S2Bt8GfgjUx/4IQay1YlWg23pBTzN5dzeqhjKJcNO7CFbDqyOnq/y
         orzw==
X-Forwarded-Encrypted: i=1; AJvYcCUaRZv/MN1fV7F4tTVrNtPZ9eV78ZsLfQ9TAdftysTzDhMI7Sjk4mknSEY9gFYmoQTU+NffTPmPuaJ8+AaHRwwuc9OXdzw1FDqSfYK/
X-Gm-Message-State: AOJu0YzaJ3l2zgAPVv32C8/E/b6MgO/pIGwwkx6ndlRQJw6YhGTVEgRf
	wd360/jvHVASb+eCm6Lh1PHVMUqTqYixMgQhyerpG9CnKnLqh4T5yJePNDzwR3I=
X-Google-Smtp-Source: AGHT+IGgBApNRJdHSI5RltpwrFjfe0Qj3vZrtXr7b8eXFtTr0yxqKQTrNrnJdUOvMQ6fSTrYCOGONA==
X-Received: by 2002:a05:6871:5828:b0:21a:5fa3:48a7 with SMTP id oj40-20020a056871582800b0021a5fa348a7mr4293326oac.26.1708122770919;
        Fri, 16 Feb 2024 14:32:50 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id n24-20020a9d7418000000b006e2e1400bd2sm142227otk.0.2024.02.16.14.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:32:50 -0800 (PST)
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
Subject: [PATCH 06/16] clk: samsung: Group CPU clock functions by chip
Date: Fri, 16 Feb 2024 16:32:35 -0600
Message-Id: <20240216223245.12273-7-semen.protsenko@linaro.org>
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

clk-cpu.c is going to get messy as new chips support is added.
Restructure the code by pulling related functions and definitions
together, grouping those by their relation to a particular chip or other
categories, to simplify the code navigation.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-cpu.c | 114 ++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 427018e8dd8c..d550a4bb632f 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -38,34 +38,6 @@
 #include "clk.h"
 #include "clk-cpu.h"
 
-#define E4210_SRC_CPU		0x0
-#define E4210_STAT_CPU		0x200
-#define E4210_DIV_CPU0		0x300
-#define E4210_DIV_CPU1		0x304
-#define E4210_DIV_STAT_CPU0	0x400
-#define E4210_DIV_STAT_CPU1	0x404
-
-#define E5433_MUX_SEL2		0x008
-#define E5433_MUX_STAT2		0x208
-#define E5433_DIV_CPU0		0x400
-#define E5433_DIV_CPU1		0x404
-#define E5433_DIV_STAT_CPU0	0x500
-#define E5433_DIV_STAT_CPU1	0x504
-
-#define E4210_DIV0_RATIO0_MASK	GENMASK(2, 0)
-#define E4210_DIV1_HPM_MASK	GENMASK(6, 4)
-#define E4210_DIV1_COPY_MASK	GENMASK(2, 0)
-#define E4210_MUX_HPM_MASK	BIT(20)
-#define E4210_DIV0_ATB_SHIFT	16
-#define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
-
-/* Divider stabilization time, msec */
-#define MAX_STAB_TIME		10
-#define MAX_DIV			8
-#define DIV_MASK		GENMASK(2, 0)
-#define DIV_MASK_ALL		GENMASK(31, 0)
-#define MUX_MASK		GENMASK(2, 0)
-
 struct exynos_cpuclk;
 
 typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
@@ -103,6 +75,15 @@ struct exynos_cpuclk {
 	exynos_rate_change_fn_t			post_rate_cb;
 };
 
+/* ---- Common code --------------------------------------------------------- */
+
+/* Divider stabilization time, msec */
+#define MAX_STAB_TIME		10
+#define MAX_DIV			8
+#define DIV_MASK		GENMASK(2, 0)
+#define DIV_MASK_ALL		GENMASK(31, 0)
+#define MUX_MASK		GENMASK(2, 0)
+
 /*
  * Helper function to wait until divider(s) have stabilized after the divider
  * value has changed.
@@ -142,33 +123,21 @@ static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,
 	pr_err("%s: re-parenting mux timed-out\n", __func__);
 }
 
-/* common round rate callback usable for all types of CPU clocks */
-static long exynos_cpuclk_round_rate(struct clk_hw *hw, unsigned long drate,
-				     unsigned long *prate)
-{
-	struct clk_hw *parent = clk_hw_get_parent(hw);
-	*prate = clk_hw_round_rate(parent, drate);
-	return *prate;
-}
+/* ---- Exynos 3/4/5 -------------------------------------------------------- */
 
-/* common recalc rate callback usable for all types of CPU clocks */
-static unsigned long exynos_cpuclk_recalc_rate(struct clk_hw *hw,
-					       unsigned long parent_rate)
-{
-	/*
-	 * The CPU clock output (armclk) rate is the same as its parent
-	 * rate. Although there exist certain dividers inside the CPU
-	 * clock block that could be used to divide the parent clock,
-	 * the driver does not make use of them currently, except during
-	 * frequency transitions.
-	 */
-	return parent_rate;
-}
+#define E4210_SRC_CPU		0x0
+#define E4210_STAT_CPU		0x200
+#define E4210_DIV_CPU0		0x300
+#define E4210_DIV_CPU1		0x304
+#define E4210_DIV_STAT_CPU0	0x400
+#define E4210_DIV_STAT_CPU1	0x404
 
-static const struct clk_ops exynos_cpuclk_clk_ops = {
-	.recalc_rate = exynos_cpuclk_recalc_rate,
-	.round_rate = exynos_cpuclk_round_rate,
-};
+#define E4210_DIV0_RATIO0_MASK	GENMASK(2, 0)
+#define E4210_DIV1_HPM_MASK	GENMASK(6, 4)
+#define E4210_DIV1_COPY_MASK	GENMASK(2, 0)
+#define E4210_MUX_HPM_MASK	BIT(20)
+#define E4210_DIV0_ATB_SHIFT	16
+#define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
 
 /*
  * Helper function to set the 'safe' dividers for the CPU clock. The parameters
@@ -300,6 +269,15 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	return 0;
 }
 
+/* ---- Exynos5433 ---------------------------------------------------------- */
+
+#define E5433_MUX_SEL2		0x008
+#define E5433_MUX_STAT2		0x208
+#define E5433_DIV_CPU0		0x400
+#define E5433_DIV_CPU1		0x404
+#define E5433_DIV_STAT_CPU0	0x500
+#define E5433_DIV_STAT_CPU1	0x504
+
 /*
  * Helper function to set the 'safe' dividers for the CPU clock. The parameters
  * div and mask contain the divider value and the register bit mask of the
@@ -398,6 +376,36 @@ static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+
+/* Common round rate callback usable for all types of CPU clocks */
+static long exynos_cpuclk_round_rate(struct clk_hw *hw, unsigned long drate,
+				     unsigned long *prate)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	*prate = clk_hw_round_rate(parent, drate);
+	return *prate;
+}
+
+/* Common recalc rate callback usable for all types of CPU clocks */
+static unsigned long exynos_cpuclk_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	/*
+	 * The CPU clock output (armclk) rate is the same as its parent
+	 * rate. Although there exist certain dividers inside the CPU
+	 * clock block that could be used to divide the parent clock,
+	 * the driver does not make use of them currently, except during
+	 * frequency transitions.
+	 */
+	return parent_rate;
+}
+
+static const struct clk_ops exynos_cpuclk_clk_ops = {
+	.recalc_rate = exynos_cpuclk_recalc_rate,
+	.round_rate = exynos_cpuclk_round_rate,
+};
+
 /*
  * This notifier function is called for the pre-rate and post-rate change
  * notifications of the parent clock of cpuclk.
-- 
2.39.2


