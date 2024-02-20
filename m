Return-Path: <linux-kernel+bounces-72251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487085B12B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA87285B19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159EC44C9E;
	Tue, 20 Feb 2024 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUtk65uQ"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A5482C8;
	Tue, 20 Feb 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398605; cv=none; b=jxS0nIyHpYtRCoeHhTJXOWhPKWr/Gcy+b3GoVFdbNT6m3sGHnRUrYu/nhKtjuJJdQ8nlA83FXa0of5AWGCk73N0+P++g7laweOPRA7T5vIYwVHl5sIw95N3vTQELiNQuETA90kHIIuVBobLbAwzvglBrVstjxAOyNK9fBm1p+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398605; c=relaxed/simple;
	bh=OAvS5GNlRik3zfKUxE5S82z0SpY6h7jBs4kGMDzs5RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKAZqz5ZC6JrvbFxljLAlq+W2XBipGRToL0otLwNl3RCuYTpY7HMdVzmVu7gQtAPoJpGwD5aSMk/u83Xc+hEhG08w7JhRkO8ZVCKTbTeA6KcU4uX4q+FPNW8MPTQRW3DhxKGPomojTdA/Yxzk3lyZOXX+aheynm6T0dExB0UydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUtk65uQ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59883168a83so2214117eaf.2;
        Mon, 19 Feb 2024 19:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708398601; x=1709003401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74iGTIIjtQ35YqyJpEPrkTahywSCIFHwna0yjeTLOok=;
        b=fUtk65uQRwmFqlI0Kg2/04aCt/iNuZLA9coC3ooVsIyNDr3E70HMQToLeJOrzrpxLp
         qr4QTR/hMBwXB9lnXvEeovZUaqR9/yRBEUGhHnsXGs85hiv3MQiUioLxCZpkevdCChl/
         lvMgj0y2mh7pZeAGwTSAvIeAmY9LFtV4d4QqPd5D7H43ivKkB5EAKGlBRRRjt7Fxet/e
         xwMBLWOxDTGsv6y0+ZxikTIF55iMcHrqSe7DDPeQ3Aw2fRabAWAvvP9dh+1ndVNIz08N
         3Gha4wCpRJHitIUaML9o2BrQLAvN2NmgfpDY4ielNiE+73lKcFVOBpfo8GQEHo7ClkJR
         yVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398601; x=1709003401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74iGTIIjtQ35YqyJpEPrkTahywSCIFHwna0yjeTLOok=;
        b=tAQxUyVCsiNswhm5JsH+/cBra0YqSLaKl6A16vwoTtZlzK/NWD61T/dcA2lX9mAWMo
         67ZTBtXc8cbISU6uagQdOTY1RJYEN/GvwAe6W92MwQdr3jbHdg4E8xm1krYmxWtS/1RN
         r7TyAI6VFvpuw94n1Jxu9o1ET0ERW3L+DMYY7J4Ug4TBiFb2jtmomuoI8YUtNGZA0CWO
         /DdLrQEW7DIAM9823/ZM+VaFIdnaMzLmWrjBeEDBuHPS74QxBZ9XQwm5g7EoF4/ruNeQ
         AAhVA5p3KzZb/4gnRrOlieyXChPD3wFwBrvkNlcMaraNRAQYNe/OWDuc7lAKx4xK5XJk
         i2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUcWD/RvIQbEU+U9uXRrpaLdvyDTyNbHn/RAZVpcqKGhx3mwfBNI8epzf+grFzIXA7yTksLvqrO5sCq0a96TChDdCihj73T/DqG0+dirocCe5zPzyy1Gxg7KYKPHxuctwRB63BORMeT3/ZxDEaUYDC4ueGymwQUfQk9vPVmAfXknR0BMA==
X-Gm-Message-State: AOJu0YwjxtRV/SGmH5PDIU49+/G2Xwir2GWxFh2aCdTM6L6rYztIGO5y
	7mtq16HhVuflEXKc/B6On2kQvQNhLX9IyR6vzE74jn5fhTNijih/YdUYtVFVwhY=
X-Google-Smtp-Source: AGHT+IFqkrn48Ys+BIVuisIi1DKGYbNMZp8NxZX87B1TyBbH6g8Rbs3XuiG8tHTYVZm7gGEso6ogJA==
X-Received: by 2002:a4a:dd8b:0:b0:59f:8a3f:ec5c with SMTP id h11-20020a4add8b000000b0059f8a3fec5cmr9534762oov.6.1708398601112;
        Mon, 19 Feb 2024 19:10:01 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id g23-20020a4a7557000000b0059a096ee494sm1274983oof.47.2024.02.19.19.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:10:00 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v11 4/5] clk: sophgo: Add SG2042 clock driver
Date: Tue, 20 Feb 2024 11:09:53 +0800
Message-Id: <d7c74c2cfa410850c044ff2879720db06c2f8272.1708397315.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add a driver for the SOPHGO SG2042 clocks.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/clk/Kconfig                    |    1 +
 drivers/clk/Makefile                   |    1 +
 drivers/clk/sophgo/Kconfig             |    8 +
 drivers/clk/sophgo/Makefile            |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c | 1401 ++++++++++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h |  233 ++++
 6 files changed, 1646 insertions(+)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..bc28502ec3c9 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -489,6 +489,7 @@ source "drivers/clk/rockchip/Kconfig"
 source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/socfpga/Kconfig"
+source "drivers/clk/sophgo/Kconfig"
 source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 14fa8d4ecc1f..4abe16c8ccdf 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-y					+= socfpga/
+obj-y					+= sophgo/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
new file mode 100644
index 000000000000..feab0b805a29
--- /dev/null
+++ b/drivers/clk/sophgo/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config CLK_SOPHGO_SG2042
+	bool "Sophgo SG2042 clock support"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	default y
+	help
+	  Say yes here to support the clock controller on the Sophgo SG2042 SoC.
diff --git a/drivers/clk/sophgo/Makefile b/drivers/clk/sophgo/Makefile
new file mode 100644
index 000000000000..13834cce260c
--- /dev/null
+++ b/drivers/clk/sophgo/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CLK_SOPHGO_SG2042)	+= clk-sophgo-sg2042.o
diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.c b/drivers/clk/sophgo/clk-sophgo-sg2042.c
new file mode 100644
index 000000000000..91ea84042ce0
--- /dev/null
+++ b/drivers/clk/sophgo/clk-sophgo-sg2042.c
@@ -0,0 +1,1401 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sophgo SG2042 Clock Generator Driver
+ *
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#include <linux/bits.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * The clock of SG2042 is composed of three parts.
+ * The registers of these three parts of the clock are scattered in three
+ * different memory address spaces:
+ * - pll clocks
+ * - gate clocks for RP subsystem
+ * - div/mux, and gate clocks working for other subsystem than RP subsystem
+ */
+#include <dt-bindings/clock/sophgo,sg2042-pll.h>
+#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
+
+#include "clk-sophgo-sg2042.h"
+
+#define KHZ 1000UL
+#define MHZ (KHZ * KHZ)
+
+#define REFDIV_MIN 1
+#define REFDIV_MAX 63
+#define FBDIV_MIN 16
+#define FBDIV_MAX 320
+
+#define PLL_FREF_SG2042 (25 * MHZ)
+
+#define PLL_FOUTPOSTDIV_MIN (16 * MHZ)
+#define PLL_FOUTPOSTDIV_MAX (3200 * MHZ)
+
+#define PLL_FOUTVCO_MIN (800 * MHZ)
+#define PLL_FOUTVCO_MAX (3200 * MHZ)
+
+struct sg2042_pll_ctrl {
+	unsigned long freq;
+	unsigned int fbdiv;
+	unsigned int postdiv1;
+	unsigned int postdiv2;
+	unsigned int refdiv;
+};
+
+#define PLLCTRL_FBDIV_SHIFT	16
+#define PLLCTRL_FBDIV_MASK	(GENMASK(27, 16) >> PLLCTRL_FBDIV_SHIFT)
+#define PLLCTRL_POSTDIV2_SHIFT	12
+#define PLLCTRL_POSTDIV2_MASK	(GENMASK(14, 12) >> PLLCTRL_POSTDIV2_SHIFT)
+#define PLLCTRL_POSTDIV1_SHIFT	8
+#define PLLCTRL_POSTDIV1_MASK	(GENMASK(10, 8) >> PLLCTRL_POSTDIV1_SHIFT)
+#define PLLCTRL_REFDIV_SHIFT	0
+#define PLLCTRL_REFDIV_MASK	(GENMASK(5, 0) >> PLLCTRL_REFDIV_SHIFT)
+
+static inline u32 sg2042_pll_ctrl_encode(struct sg2042_pll_ctrl *ctrl)
+{
+	return (((ctrl->fbdiv & PLLCTRL_FBDIV_MASK) << PLLCTRL_FBDIV_SHIFT) |
+		((ctrl->postdiv2 & PLLCTRL_POSTDIV2_MASK) << PLLCTRL_POSTDIV2_SHIFT) |
+		((ctrl->postdiv1 & PLLCTRL_POSTDIV1_MASK) << PLLCTRL_POSTDIV1_SHIFT) |
+		((ctrl->refdiv & PLLCTRL_REFDIV_MASK) << PLLCTRL_REFDIV_SHIFT));
+}
+
+static inline void sg2042_pll_ctrl_decode(unsigned int reg_value,
+					  struct sg2042_pll_ctrl *ctrl)
+{
+	ctrl->fbdiv = (reg_value >> PLLCTRL_FBDIV_SHIFT) & PLLCTRL_FBDIV_MASK;
+	ctrl->refdiv = (reg_value >> PLLCTRL_REFDIV_SHIFT) & PLLCTRL_REFDIV_MASK;
+	ctrl->postdiv1 = (reg_value >> PLLCTRL_POSTDIV1_SHIFT) & PLLCTRL_POSTDIV1_MASK;
+	ctrl->postdiv2 = (reg_value >> PLLCTRL_POSTDIV2_SHIFT) & PLLCTRL_POSTDIV2_MASK;
+}
+
+static inline int sg2042_pll_enable(struct sg2042_pll_clock *pll, bool en)
+{
+	unsigned int value = 0;
+	struct regmap *map = pll->map;
+
+	if (en) {
+		/* wait pll lock */
+		if (regmap_read_poll_timeout_atomic(map,
+						    pll->offset_status,
+						    value,
+						    ((value >> pll->shift_status_lock) & 0x1),
+						    0,
+						    100000))
+			pr_warn("%s not locked\n", pll->name);
+
+		/* wait pll updating */
+		if (regmap_read_poll_timeout_atomic(map,
+						    pll->offset_status,
+						    value,
+						    !((value >> pll->shift_status_updating) & 0x1),
+						    0,
+						    100000))
+			pr_warn("%s still updating\n", pll->name);
+
+		/* enable pll */
+		regmap_read(map, pll->offset_enable, &value);
+		regmap_write(map, pll->offset_enable, value | (1 << pll->shift_enable));
+	} else {
+		/* disable pll */
+		regmap_read(map, pll->offset_enable, &value);
+		regmap_write(map, pll->offset_enable, value & (~(1 << pll->shift_enable)));
+	}
+
+	return 0;
+}
+
+/*
+ * @reg_value: current register value
+ * @parent_rate: parent frequency
+ *
+ * This function is used to calculate below "rate" in equation
+ * rate = (parent_rate/REFDIV) x FBDIV/POSTDIV1/POSTDIV2
+ *      = (parent_rate x FBDIV) / (REFDIV x POSTDIV1 x POSTDIV2)
+ */
+static unsigned long sg2042_pll_recalc_rate(unsigned int reg_value,
+					    unsigned long parent_rate)
+{
+	struct sg2042_pll_ctrl ctrl_table;
+	u64 rate, numerator, denominator;
+
+	sg2042_pll_ctrl_decode(reg_value, &ctrl_table);
+
+	numerator = parent_rate * ctrl_table.fbdiv;
+	denominator = ctrl_table.refdiv * ctrl_table.postdiv1 * ctrl_table.postdiv2;
+	do_div(numerator, denominator);
+	rate = numerator;
+
+	return rate;
+}
+
+/*
+ * Below array is the total combination lists of POSTDIV1 and POSTDIV2
+ * for example:
+ * postdiv1_2[0] = {2, 4, 8}
+ *           ==> div1 = 2, div2 = 4 , div1 * div2 = 8
+ * And POSTDIV_RESULT_INDEX point to 3rd element in the array
+ */
+#define	POSTDIV_RESULT_INDEX	2
+static int postdiv1_2[][3] = {
+	{2, 4,  8}, {3, 3,  9}, {2, 5, 10}, {2, 6, 12},
+	{2, 7, 14}, {3, 5, 15}, {4, 4, 16}, {3, 6, 18},
+	{4, 5, 20}, {3, 7, 21}, {4, 6, 24}, {5, 5, 25},
+	{4, 7, 28}, {5, 6, 30}, {5, 7, 35}, {6, 6, 36},
+	{6, 7, 42}, {7, 7, 49}
+};
+
+/*
+ * Based on input rate/prate/fbdiv/refdiv, look up the postdiv1_2 table
+ * to get the closest postdiiv combination.
+ * @rate: FOUTPOSTDIV
+ * @prate: parent rate, i.e. FREF
+ * @fbdiv: FBDIV
+ * @refdiv: REFDIV
+ * @postdiv1: POSTDIV1, output
+ * @postdiv2: POSTDIV2, output
+ * See TRM:
+ * FOUTPOSTDIV = FREF * FBDIV / REFDIV / (POSTDIV1 * POSTDIV2)
+ * So we get following formula to get POSTDIV1 and POSTDIV2:
+ * POSTDIV = (prate/REFDIV) x FBDIV/rate
+ * above POSTDIV = POSTDIV1*POSTDIV2
+ */
+static int sg2042_pll_get_postdiv_1_2(unsigned long rate,
+				      unsigned long prate,
+				      unsigned int fbdiv,
+				      unsigned int refdiv,
+				      unsigned int *postdiv1,
+				      unsigned int *postdiv2)
+{
+	int index = 0;
+	u64 tmp0;
+
+	/* prate/REFDIV and result save to tmp0 */
+	tmp0 = prate;
+	do_div(tmp0, refdiv);
+
+	/* ((prate/REFDIV) x FBDIV) and result save to tmp0 */
+	tmp0 *= fbdiv;
+
+	/* ((prate/REFDIV) x FBDIV)/rate and result save to tmp0 */
+	do_div(tmp0, rate);
+
+	/* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 value */
+	if (tmp0 <= 7) {
+		/* (div1 * div2) <= 7, no need to use array search */
+		*postdiv1 = tmp0;
+		*postdiv2 = 1;
+		return 0;
+	}
+
+	/* (div1 * div2) > 7, use array search */
+	for (index = 0; index < ARRAY_SIZE(postdiv1_2); index++) {
+		if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
+			continue;
+		} else {
+			/* found it */
+			*postdiv1 = postdiv1_2[index][1];
+			*postdiv2 = postdiv1_2[index][0];
+			return 0;
+		}
+	}
+	pr_warn("%s can not find in postdiv array!\n", __func__);
+	return -EINVAL;
+}
+
+/*
+ * Based on the given FOUTPISTDIV and the input FREF to calculate
+ * the REFDIV/FBDIV/PSTDIV1/POSTDIV2 combination for pllctrl register.
+ * @req_rate: expected output clock rate, i.e. FOUTPISTDIV
+ * @parent_rate: input parent clock rate, i.e. FREF
+ * @best: output to hold calculated combination of REFDIV/FBDIV/PSTDIV1/POSTDIV2
+ */
+static int sg2042_get_pll_ctl_setting(struct sg2042_pll_ctrl *best,
+				      unsigned long req_rate,
+				      unsigned long parent_rate)
+{
+	int ret;
+	unsigned int fbdiv, refdiv, postdiv1, postdiv2;
+	unsigned long foutpostdiv;
+	u64 tmp;
+	u64 foutvco;
+
+	if (parent_rate != PLL_FREF_SG2042) {
+		pr_alert("INVALID FREF: %ld\n", parent_rate);
+		return -EINVAL;
+	}
+
+	if (req_rate < PLL_FOUTPOSTDIV_MIN || req_rate > PLL_FOUTPOSTDIV_MAX) {
+		pr_alert("INVALID FOUTPOSTDIV: %ld\n", req_rate);
+		return -EINVAL;
+	}
+
+	memset(best, 0, sizeof(struct sg2042_pll_ctrl));
+
+	for (refdiv = REFDIV_MIN; refdiv < REFDIV_MAX + 1; refdiv++) {
+		/* required by hardware: FREF/REFDIV must > 10 */
+		tmp = parent_rate;
+		do_div(tmp, refdiv);
+		if (tmp <= 10)
+			continue;
+
+		for (fbdiv = FBDIV_MIN; fbdiv < FBDIV_MAX + 1; fbdiv++) {
+			/*
+			 * FOUTVCO = FREF*FBDIV/REFDIV validation
+			 * required by hardware, FOUTVCO must [800MHz, 3200MHz]
+			 */
+			foutvco = parent_rate * fbdiv;
+			do_div(foutvco, refdiv);
+			if (foutvco < PLL_FOUTVCO_MIN || foutvco > PLL_FOUTVCO_MAX)
+				continue;
+
+			ret = sg2042_pll_get_postdiv_1_2(req_rate, parent_rate,
+							 fbdiv, refdiv,
+							 &postdiv1, &postdiv2);
+			if (ret)
+				continue;
+
+			/*
+			 * FOUTPOSTDIV = FREF*FBDIV/REFDIV/(POSTDIV1*POSTDIV2)
+			 *             = FOUTVCO/(POSTDIV1*POSTDIV2)
+			 */
+			tmp = foutvco;
+			do_div(tmp, (postdiv1 * postdiv2));
+			foutpostdiv = (unsigned long)tmp;
+			/* Iterative to approach the expected value */
+			if (abs_diff(foutpostdiv, req_rate) <
+			    abs_diff(best->freq, req_rate)) {
+				best->freq = foutpostdiv;
+				best->refdiv = refdiv;
+				best->fbdiv = fbdiv;
+				best->postdiv1 = postdiv1;
+				best->postdiv2 = postdiv2;
+				if (foutpostdiv == req_rate)
+					return 0;
+			}
+			continue;
+		}
+	}
+
+	if (best->freq == 0)
+		return -EINVAL;
+	else
+		return 0;
+}
+
+/*
+ * @hw: ccf use to hook get sg2042_pll_clock
+ * @parent_rate: parent rate
+ *
+ * The is function will be called through clk_get_rate
+ * and return current rate after decoding reg value
+ */
+static unsigned long sg2042_clk_pll_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	unsigned int value;
+	unsigned long rate;
+	struct sg2042_pll_clock *pll = to_sg2042_pll_clk(hw);
+
+	regmap_read(pll->map, pll->offset_ctrl, &value);
+	rate = sg2042_pll_recalc_rate(value, parent_rate);
+
+	pr_debug("--> %s: pll_recalc_rate: val = %ld\n",
+		 clk_hw_get_name(hw), rate);
+	return rate;
+}
+
+static long sg2042_clk_pll_round_rate(struct clk_hw *hw,
+				      unsigned long req_rate,
+				      unsigned long *prate)
+{
+	unsigned int value;
+	struct sg2042_pll_ctrl pctrl_table;
+	long proper_rate;
+	int ret;
+
+	ret = sg2042_get_pll_ctl_setting(&pctrl_table, req_rate, *prate);
+	if (ret) {
+		proper_rate = 0;
+		goto out;
+	}
+
+	value = sg2042_pll_ctrl_encode(&pctrl_table);
+	proper_rate = (long)sg2042_pll_recalc_rate(value, *prate);
+
+out:
+	pr_debug("--> %s: pll_round_rate: val = %ld\n",
+		 clk_hw_get_name(hw), proper_rate);
+	return proper_rate;
+}
+
+static int sg2042_clk_pll_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	req->rate = sg2042_clk_pll_round_rate(hw, min(req->rate, req->max_rate),
+					      &req->best_parent_rate);
+	pr_debug("--> %s: pll_determine_rate: val = %ld\n",
+		 clk_hw_get_name(hw), req->rate);
+	return 0;
+}
+
+static int sg2042_clk_pll_set_rate(struct clk_hw *hw,
+				   unsigned long rate,
+				   unsigned long parent_rate)
+{
+	unsigned long flags;
+	unsigned int value;
+	int ret = 0;
+	struct sg2042_pll_ctrl pctrl_table;
+	struct sg2042_pll_clock *pll = to_sg2042_pll_clk(hw);
+
+	spin_lock_irqsave(pll->lock, flags);
+	if (sg2042_pll_enable(pll, 0)) {
+		pr_warn("Can't disable pll(%s), status error\n", pll->name);
+		goto out;
+	}
+	ret = sg2042_get_pll_ctl_setting(&pctrl_table, rate, parent_rate);
+	if (ret) {
+		pr_warn("%s: Can't find a proper pll setting\n", pll->name);
+		goto out2;
+	}
+
+	value = sg2042_pll_ctrl_encode(&pctrl_table);
+
+	/* write the value to top register */
+	regmap_write(pll->map, pll->offset_ctrl, value);
+
+out2:
+	sg2042_pll_enable(pll, 1);
+out:
+	spin_unlock_irqrestore(pll->lock, flags);
+
+	pr_debug("--> %s: pll_set_rate: val = 0x%x\n",
+		 clk_hw_get_name(hw), value);
+	return ret;
+}
+
+static const struct clk_ops sg2042_clk_pll_ops = {
+	.recalc_rate = sg2042_clk_pll_recalc_rate,
+	.round_rate = sg2042_clk_pll_round_rate,
+	.determine_rate = sg2042_clk_pll_determine_rate,
+	.set_rate = sg2042_clk_pll_set_rate,
+};
+
+static const struct clk_ops sg2042_clk_pll_ro_ops = {
+	.recalc_rate = sg2042_clk_pll_recalc_rate,
+	.round_rate = sg2042_clk_pll_round_rate,
+};
+
+#define DIV_MASK(width) GENMASK(((width) - 1), 0)
+
+static unsigned long sg2042_clk_divider_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct sg2042_divider_clock *divider = to_sg2042_clk_divider(hw);
+	unsigned int val;
+	unsigned long ret_rate;
+
+	if (!(readl(divider->reg) & BIT(3))) {
+		val = (int)(divider->initval);
+	} else {
+		val = readl(divider->reg) >> divider->shift;
+		val &= DIV_MASK(divider->width);
+	}
+
+	ret_rate = divider_recalc_rate(hw, parent_rate, val, NULL,
+				       divider->div_flags, divider->width);
+
+	pr_debug("--> %s: divider_recalc_rate: ret_rate = %ld\n",
+		 clk_hw_get_name(hw), ret_rate);
+	return ret_rate;
+}
+
+static long sg2042_clk_divider_round_rate(struct clk_hw *hw,
+					  unsigned long rate,
+					  unsigned long *prate)
+{
+	int bestdiv;
+	unsigned long ret_rate;
+	struct sg2042_divider_clock *divider = to_sg2042_clk_divider(hw);
+
+	/* if read only, just return current value */
+	if (divider->div_flags & CLK_DIVIDER_READ_ONLY) {
+		if (!(readl(divider->reg) & BIT(3))) {
+			bestdiv = (int)(divider->initval);
+		} else {
+			bestdiv = readl(divider->reg) >> divider->shift;
+			bestdiv &= DIV_MASK(divider->width);
+		}
+		ret_rate = DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+	} else {
+		ret_rate = divider_round_rate(hw, rate, prate, NULL,
+					      divider->width, divider->div_flags);
+	}
+
+	pr_debug("--> %s: divider_round_rate: val = %ld\n",
+		 clk_hw_get_name(hw), ret_rate);
+	return ret_rate;
+}
+
+static int sg2042_clk_divider_set_rate(struct clk_hw *hw,
+				       unsigned long rate,
+				       unsigned long parent_rate)
+{
+	unsigned int value;
+	unsigned int val, val2;
+	unsigned long flags = 0;
+	struct sg2042_divider_clock *divider = to_sg2042_clk_divider(hw);
+
+	value = divider_get_val(rate, parent_rate, NULL,
+				divider->width, divider->div_flags);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/*
+	 * The sequence of clock frequency modification is:
+	 * Assert to reset divider.
+	 * Modify the value of Clock Divide Factor (and High Wide if needed).
+	 * De-assert to restore divided clock with new frequency.
+	 */
+	val = readl(divider->reg);
+
+	/* assert */
+	val &= ~0x1;
+	writel(val, divider->reg);
+
+	if (divider->div_flags & CLK_DIVIDER_HIWORD_MASK) {
+		val = DIV_MASK(divider->width) << (divider->shift + 16);
+	} else {
+		val = readl(divider->reg);
+		val &= ~(DIV_MASK(divider->width) << divider->shift);
+	}
+	val |= value << divider->shift;
+	val |= 1 << 3;
+	writel(val, divider->reg);
+	val2 = val;
+
+	/* de-assert */
+	val |= 1;
+	writel(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	pr_debug("--> %s: divider_set_rate: register val = 0x%x\n",
+		 clk_hw_get_name(hw), val2);
+	return 0;
+}
+
+static const struct clk_ops sg2042_clk_divider_ops = {
+	.recalc_rate = sg2042_clk_divider_recalc_rate,
+	.round_rate = sg2042_clk_divider_round_rate,
+	.set_rate = sg2042_clk_divider_set_rate,
+};
+
+static const struct clk_ops sg2042_clk_divider_ro_ops = {
+	.recalc_rate = sg2042_clk_divider_recalc_rate,
+	.round_rate = sg2042_clk_divider_round_rate,
+};
+
+#define SG2042_PLL(_id, _name, _parent_name, _r_stat, _r_enable, _r_ctrl, _shift) \
+	{								\
+		.hw.init = CLK_HW_INIT_PARENTS(				\
+				_name,					\
+				(const char *[]){_parent_name},		\
+				&sg2042_clk_pll_ops,			\
+				CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_NOCACHE),\
+		.id = _id,						\
+		.name = _name,						\
+		.offset_ctrl = _r_ctrl,					\
+		.offset_status = _r_stat,				\
+		.offset_enable = _r_enable,				\
+		.shift_status_lock = 8 + (_shift),			\
+		.shift_status_updating = _shift,			\
+		.shift_enable = _shift,					\
+	}
+
+#define SG2042_PLL_RO(_id, _name, _parent_name, _r_stat, _r_enable, _r_ctrl, _shift) \
+	{								\
+		.hw.init = CLK_HW_INIT_PARENTS(				\
+				_name,					\
+				(const char *[]){_parent_name},		\
+				&sg2042_clk_pll_ro_ops,			\
+				CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_NOCACHE),\
+		.id = _id,						\
+		.name = _name,						\
+		.offset_ctrl = _r_ctrl,					\
+		.offset_status = _r_stat,				\
+		.offset_enable = _r_enable,				\
+		.shift_status_lock = 8 + (_shift),			\
+		.shift_status_updating = _shift,			\
+		.shift_enable = _shift,					\
+	}
+
+static struct sg2042_pll_clock sg2042_pll_clks[] = {
+	SG2042_PLL(MPLL_CLK, "mpll_clock", "cgi_main",
+		   R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_MPLL_CONTROL, 0),
+	SG2042_PLL_RO(FPLL_CLK, "fpll_clock", "cgi_main",
+		      R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_FPLL_CONTROL, 3),
+	SG2042_PLL_RO(DPLL0_CLK, "dpll0_clock", "cgi_dpll0",
+		      R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL0_CONTROL, 4),
+	SG2042_PLL_RO(DPLL1_CLK, "dpll1_clock", "cgi_dpll1",
+		      R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL1_CONTROL, 5),
+};
+
+#define SG2042_DIV(_id, _name, _parent_name,				\
+		  _r_ctrl, _shift, _width,				\
+		  _div_flag, _initval) {				\
+		.hw.init = CLK_HW_INIT_PARENTS(				\
+				_name,					\
+				(const char *[]){_parent_name},		\
+				&sg2042_clk_divider_ops,		\
+				0),					\
+		.id = _id,						\
+		.name = _name,						\
+		.offset_ctrl = _r_ctrl,					\
+		.shift = _shift,					\
+		.width = _width,					\
+		.div_flags = _div_flag,					\
+		.initval = _initval,					\
+	}
+
+#define SG2042_DIV_RO(_id, _name, _parent_name,				\
+		  _r_ctrl, _shift, _width,				\
+		  _div_flag, _initval) {				\
+		.hw.init = CLK_HW_INIT_PARENTS(				\
+				_name,					\
+				(const char *[]){_parent_name},		\
+				&sg2042_clk_divider_ro_ops,		\
+				0),					\
+		.id = _id,						\
+		.name = _name,						\
+		.offset_ctrl = _r_ctrl,					\
+		.shift = _shift,					\
+		.width = _width,					\
+		.div_flags = (_div_flag) | CLK_DIVIDER_READ_ONLY,	\
+		.initval = _initval,					\
+	}
+
+/*
+ * DIV items in the array are sorted according to the clock-tree diagram,
+ * from top to bottom, from upstream to downstream. Read TRM for details.
+ */
+#define DEF_DIVFLAG (CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO)
+static struct sg2042_divider_clock sg2042_div_clks[] = {
+	SG2042_DIV_RO(DIV_CLK_DPLL0_DDR01_0,
+		      "clk_div_ddr01_0", "clk_gate_ddr01_div0",
+		      R_CLKDIVREG27, 16, 5, DEF_DIVFLAG, 1),
+	SG2042_DIV_RO(DIV_CLK_FPLL_DDR01_1,
+		      "clk_div_ddr01_1", "clk_gate_ddr01_div1",
+		      R_CLKDIVREG28, 16, 5, DEF_DIVFLAG, 1),
+
+	SG2042_DIV_RO(DIV_CLK_DPLL1_DDR23_0,
+		      "clk_div_ddr23_0", "clk_gate_ddr23_div0",
+		      R_CLKDIVREG29, 16, 5, DEF_DIVFLAG, 1),
+	SG2042_DIV_RO(DIV_CLK_FPLL_DDR23_1,
+		      "clk_div_ddr23_1", "clk_gate_ddr23_div1",
+		      R_CLKDIVREG30, 16, 5, DEF_DIVFLAG, 1),
+
+	SG2042_DIV(DIV_CLK_MPLL_RP_CPU_NORMAL_0,
+		   "clk_div_rp_cpu_normal_0", "clk_gate_rp_cpu_normal_div0",
+		   R_CLKDIVREG0, 16, 5, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_RP_CPU_NORMAL_1,
+		   "clk_div_rp_cpu_normal_1", "clk_gate_rp_cpu_normal_div1",
+		   R_CLKDIVREG1, 16, 5, DEF_DIVFLAG, 1),
+
+	SG2042_DIV(DIV_CLK_MPLL_AXI_DDR_0,
+		   "clk_div_axi_ddr_0", "clk_gate_axi_ddr_div0",
+		   R_CLKDIVREG25, 16, 5, DEF_DIVFLAG, 2),
+	SG2042_DIV(DIV_CLK_FPLL_AXI_DDR_1,
+		   "clk_div_axi_ddr_1", "clk_gate_axi_ddr_div1",
+		   R_CLKDIVREG26, 16, 5, DEF_DIVFLAG, 1),
+
+	SG2042_DIV(DIV_CLK_FPLL_TOP_RP_CMN_DIV2,
+		   "clk_div_top_rp_cmn_div2", "clk_mux_rp_cpu_normal",
+		   R_CLKDIVREG3, 16, 16, DEF_DIVFLAG, 2),
+
+	SG2042_DIV(DIV_CLK_FPLL_50M_A53, "clk_div_50m_a53", "fpll_clock",
+		   R_CLKDIVREG2, 16, 8, DEF_DIVFLAG, 20),
+	/* downstream of div_50m_a53 */
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER1, "clk_div_timer1", "clk_div_50m_a53",
+		   R_CLKDIVREG6, 16, 16, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER2, "clk_div_timer2", "clk_div_50m_a53",
+		   R_CLKDIVREG7, 16, 16, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER3, "clk_div_timer3", "clk_div_50m_a53",
+		   R_CLKDIVREG8, 16, 16, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER4, "clk_div_timer4", "clk_div_50m_a53",
+		   R_CLKDIVREG9, 16, 16, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER5, "clk_div_timer5", "clk_div_50m_a53",
+		   R_CLKDIVREG10, 16, 16, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER6, "clk_div_timer6", "clk_div_50m_a53",
+		   R_CLKDIVREG11, 16, 16, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER7, "clk_div_timer7", "clk_div_50m_a53",
+		   R_CLKDIVREG12, 16, 16, DEF_DIVFLAG, 1),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER8, "clk_div_timer8", "clk_div_50m_a53",
+		   R_CLKDIVREG13, 16, 16, DEF_DIVFLAG, 1),
+
+	/*
+	 * Set clk_div_uart_500m as RO, because the width of CLKDIVREG4 is too
+	 * narrow for us to produce 115200. Use UART internal divider directly.
+	 */
+	SG2042_DIV_RO(DIV_CLK_FPLL_UART_500M, "clk_div_uart_500m", "fpll_clock",
+		      R_CLKDIVREG4, 16, 7, DEF_DIVFLAG, 2),
+	SG2042_DIV(DIV_CLK_FPLL_AHB_LPC, "clk_div_ahb_lpc", "fpll_clock",
+		   R_CLKDIVREG5, 16, 16, DEF_DIVFLAG, 5),
+	SG2042_DIV(DIV_CLK_FPLL_EFUSE, "clk_div_efuse", "fpll_clock",
+		   R_CLKDIVREG14, 16, 7, DEF_DIVFLAG, 40),
+	SG2042_DIV(DIV_CLK_FPLL_TX_ETH0, "clk_div_tx_eth0", "fpll_clock",
+		   R_CLKDIVREG16, 16, 11, DEF_DIVFLAG, 8),
+	SG2042_DIV(DIV_CLK_FPLL_PTP_REF_I_ETH0,
+		   "clk_div_ptp_ref_i_eth0", "fpll_clock",
+		   R_CLKDIVREG17, 16, 8, DEF_DIVFLAG, 20),
+	SG2042_DIV(DIV_CLK_FPLL_REF_ETH0, "clk_div_ref_eth0", "fpll_clock",
+		   R_CLKDIVREG18, 16, 8, DEF_DIVFLAG, 40),
+	SG2042_DIV(DIV_CLK_FPLL_EMMC, "clk_div_emmc", "fpll_clock",
+		   R_CLKDIVREG19, 16, 5, DEF_DIVFLAG, 10),
+	SG2042_DIV(DIV_CLK_FPLL_SD, "clk_div_sd", "fpll_clock",
+		   R_CLKDIVREG21, 16, 5, DEF_DIVFLAG, 10),
+
+	SG2042_DIV(DIV_CLK_FPLL_TOP_AXI0, "clk_div_top_axi0", "fpll_clock",
+		   R_CLKDIVREG23, 16, 5, DEF_DIVFLAG, 10),
+	/* downstream of div_top_axi0 */
+	SG2042_DIV(DIV_CLK_FPLL_100K_EMMC, "clk_div_100k_emmc", "clk_div_top_axi0",
+		   R_CLKDIVREG20, 16, 16, DEF_DIVFLAG, 1000),
+	SG2042_DIV(DIV_CLK_FPLL_100K_SD, "clk_div_100k_sd", "clk_div_top_axi0",
+		   R_CLKDIVREG22, 16, 16, DEF_DIVFLAG, 1000),
+	SG2042_DIV(DIV_CLK_FPLL_GPIO_DB, "clk_div_gpio_db", "clk_div_top_axi0",
+		   R_CLKDIVREG15, 16, 16, DEF_DIVFLAG, 1000),
+
+	SG2042_DIV(DIV_CLK_FPLL_TOP_AXI_HSPERI,
+		   "clk_div_top_axi_hsperi", "fpll_clock",
+		   R_CLKDIVREG24, 16, 5, DEF_DIVFLAG, 4),
+};
+
+#define SG2042_GATE(_id, _name, _parent_name, _flags, \
+		    _r_enable, _bit_idx) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent_name,	\
+		.flags = _flags,		\
+		.offset_enable = _r_enable,	\
+		.bit_idx = _bit_idx,		\
+	}
+
+/*
+ * GATE items in the array are sorted according to the clock-tree diagram,
+ * from top to bottom, from upstream to downstream. Read TRM for details.
+ */
+
+/* Gate clocks which control registers are defined in CLOCK. */
+static const struct sg2042_gate_clock sg2042_gate_clks[] = {
+	SG2042_GATE(GATE_CLK_DDR01_DIV0, "clk_gate_ddr01_div0", "dpll0_clock",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		    R_CLKDIVREG27, 4),
+	SG2042_GATE(GATE_CLK_DDR01_DIV1, "clk_gate_ddr01_div1", "fpll_clock",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKDIVREG28, 4),
+
+	SG2042_GATE(GATE_CLK_DDR23_DIV0, "clk_gate_ddr23_div0", "dpll1_clock",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		    R_CLKDIVREG29, 4),
+	SG2042_GATE(GATE_CLK_DDR23_DIV1, "clk_gate_ddr23_div1", "fpll_clock",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKDIVREG30, 4),
+
+	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV0, "clk_gate_rp_cpu_normal_div0", "mpll_clock",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKDIVREG0, 4),
+	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV1,
+		    "clk_gate_rp_cpu_normal_div1", "fpll_clock",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKDIVREG1, 4),
+
+	SG2042_GATE(GATE_CLK_AXI_DDR_DIV0, "clk_gate_axi_ddr_div0", "mpll_clock",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKDIVREG25, 4),
+	SG2042_GATE(GATE_CLK_AXI_DDR_DIV1, "clk_gate_axi_ddr_div1", "fpll_clock",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKDIVREG26, 4),
+
+	/* upon are gate clocks as input source for the muxes */
+
+	SG2042_GATE(GATE_CLK_DDR01, "clk_gate_ddr01", "clk_mux_ddr01",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKENREG1, 14),
+
+	SG2042_GATE(GATE_CLK_DDR23, "clk_gate_ddr23", "clk_mux_ddr23",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKENREG1, 15),
+
+	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL,
+		    "clk_gate_rp_cpu_normal", "clk_mux_rp_cpu_normal",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKENREG0, 0),
+
+	SG2042_GATE(GATE_CLK_AXI_DDR, "clk_gate_axi_ddr", "clk_mux_axi_ddr",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKENREG1, 13),
+
+	/* upon are gate clocks directly downstream of muxes */
+
+	/* downstream of clk_div_top_rp_cmn_div2 */
+	SG2042_GATE(GATE_CLK_TOP_RP_CMN_DIV2,
+		    "clk_gate_top_rp_cmn_div2", "clk_div_top_rp_cmn_div2",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 2),
+	SG2042_GATE(GATE_CLK_HSDMA, "clk_gate_hsdma", "clk_gate_top_rp_cmn_div2",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 10),
+
+	/*
+	 * downstream of clk_gate_rp_cpu_normal
+	 *
+	 * FIXME: there should be one 1/2 DIV between clk_gate_rp_cpu_normal
+	 * and clk_gate_axi_pcie0/clk_gate_axi_pcie1.
+	 * But the 1/2 DIV is fixed and no configurable register exported, so
+	 * when reading from these two clocks, the rate value are still the
+	 * same as that of clk_gate_rp_cpu_normal, it's not correct.
+	 * This just affects the value read.
+	 */
+	SG2042_GATE(GATE_CLK_AXI_PCIE0,
+		    "clk_gate_axi_pcie0", "clk_gate_rp_cpu_normal",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1, 8),
+	SG2042_GATE(GATE_CLK_AXI_PCIE1,
+		    "clk_gate_axi_pcie1", "clk_gate_rp_cpu_normal",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1, 9),
+
+	/* downstream of div_50m_a53 */
+	SG2042_GATE(GATE_CLK_A53_50M, "clk_gate_a53_50m", "clk_div_50m_a53",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 1),
+	SG2042_GATE(GATE_CLK_TIMER1, "clk_gate_timer1", "clk_div_timer1",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 12),
+	SG2042_GATE(GATE_CLK_TIMER2, "clk_gate_timer2", "clk_div_timer2",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 13),
+	SG2042_GATE(GATE_CLK_TIMER3, "clk_gate_timer3", "clk_div_timer3",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 14),
+	SG2042_GATE(GATE_CLK_TIMER4, "clk_gate_timer4", "clk_div_timer4",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 15),
+	SG2042_GATE(GATE_CLK_TIMER5, "clk_gate_timer5", "clk_div_timer5",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 16),
+	SG2042_GATE(GATE_CLK_TIMER6, "clk_gate_timer6", "clk_div_timer6",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 17),
+	SG2042_GATE(GATE_CLK_TIMER7, "clk_gate_timer7", "clk_div_timer7",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 18),
+	SG2042_GATE(GATE_CLK_TIMER8, "clk_gate_timer8", "clk_div_timer8",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 19),
+
+	/* gate clocks downstream from div clocks one-to-one */
+	SG2042_GATE(GATE_CLK_UART_500M, "clk_gate_uart_500m", "clk_div_uart_500m",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 4),
+	SG2042_GATE(GATE_CLK_AHB_LPC, "clk_gate_ahb_lpc", "clk_div_ahb_lpc",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 7),
+	SG2042_GATE(GATE_CLK_EFUSE, "clk_gate_efuse", "clk_div_efuse",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 20),
+	SG2042_GATE(GATE_CLK_TX_ETH0, "clk_gate_tx_eth0", "clk_div_tx_eth0",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 30),
+	SG2042_GATE(GATE_CLK_PTP_REF_I_ETH0,
+		    "clk_gate_ptp_ref_i_eth0", "clk_div_ptp_ref_i_eth0",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 0),
+	SG2042_GATE(GATE_CLK_REF_ETH0, "clk_gate_ref_eth0", "clk_div_ref_eth0",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 1),
+	SG2042_GATE(GATE_CLK_EMMC_100M, "clk_gate_emmc", "clk_div_emmc",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 3),
+	SG2042_GATE(GATE_CLK_SD_100M, "clk_gate_sd", "clk_div_sd",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 6),
+
+	/* downstream of clk_div_top_axi0 */
+	SG2042_GATE(GATE_CLK_AHB_ROM, "clk_gate_ahb_rom", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 8),
+	SG2042_GATE(GATE_CLK_AHB_SF, "clk_gate_ahb_sf", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 9),
+	SG2042_GATE(GATE_CLK_AXI_SRAM, "clk_gate_axi_sram", "clk_div_top_axi0",
+		    CLK_IGNORE_UNUSED, R_CLKENREG0, 10),
+	SG2042_GATE(GATE_CLK_APB_TIMER, "clk_gate_apb_timer", "clk_div_top_axi0",
+		    CLK_IGNORE_UNUSED, R_CLKENREG0, 11),
+	SG2042_GATE(GATE_CLK_APB_EFUSE, "clk_gate_apb_efuse", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 21),
+	SG2042_GATE(GATE_CLK_APB_GPIO, "clk_gate_apb_gpio", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 22),
+	SG2042_GATE(GATE_CLK_APB_GPIO_INTR,
+		    "clk_gate_apb_gpio_intr", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 23),
+	SG2042_GATE(GATE_CLK_APB_I2C, "clk_gate_apb_i2c", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 26),
+	SG2042_GATE(GATE_CLK_APB_WDT, "clk_gate_apb_wdt", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 27),
+	SG2042_GATE(GATE_CLK_APB_PWM, "clk_gate_apb_pwm", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 28),
+	SG2042_GATE(GATE_CLK_APB_RTC, "clk_gate_apb_rtc", "clk_div_top_axi0",
+		    0, R_CLKENREG0, 29),
+	SG2042_GATE(GATE_CLK_TOP_AXI0, "clk_gate_top_axi0", "clk_div_top_axi0",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKENREG1, 11),
+	/* downstream of DIV clocks which are sourced from clk_div_top_axi0 */
+	SG2042_GATE(GATE_CLK_GPIO_DB, "clk_gate_gpio_db", "clk_div_gpio_db",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 24),
+	SG2042_GATE(GATE_CLK_100K_EMMC, "clk_gate_100k_emmc", "clk_div_100k_emmc",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 4),
+	SG2042_GATE(GATE_CLK_100K_SD, "clk_gate_100k_sd", "clk_div_100k_sd",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 7),
+
+	/* downstream of clk_div_top_axi_hsperi */
+	SG2042_GATE(GATE_CLK_SYSDMA_AXI,
+		    "clk_gate_sysdma_axi", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 3),
+	SG2042_GATE(GATE_CLK_APB_UART,
+		    "clk_gate_apb_uart", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 5),
+	SG2042_GATE(GATE_CLK_AXI_DBG_I2C,
+		    "clk_gate_axi_dbg_i2c", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 6),
+	SG2042_GATE(GATE_CLK_APB_SPI,
+		    "clk_gate_apb_spi", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 25),
+	SG2042_GATE(GATE_CLK_AXI_ETH0,
+		    "clk_gate_axi_eth0", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT, R_CLKENREG0, 31),
+	SG2042_GATE(GATE_CLK_AXI_EMMC,
+		    "clk_gate_axi_emmc", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 2),
+	SG2042_GATE(GATE_CLK_AXI_SD,
+		    "clk_gate_axi_sd", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT, R_CLKENREG1, 5),
+	SG2042_GATE(GATE_CLK_TOP_AXI_HSPERI,
+		    "clk_gate_top_axi_hsperi", "clk_div_top_axi_hsperi",
+		    CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		    R_CLKENREG1, 12),
+};
+
+/*
+ * Gate clocks for RP subsystem (including the MP subsystem), which control
+ * registers are defined in SYS_CTRL.
+ */
+static const struct sg2042_gate_clock sg2042_gate_rp[] = {
+	/* downstream of clk_gate_rp_cpu_normal about rxu */
+	SG2042_GATE(GATE_CLK_RXU0, "clk_gate_rxu0", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 0),
+	SG2042_GATE(GATE_CLK_RXU1, "clk_gate_rxu1", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 1),
+	SG2042_GATE(GATE_CLK_RXU2, "clk_gate_rxu2", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 2),
+	SG2042_GATE(GATE_CLK_RXU3, "clk_gate_rxu3", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 3),
+	SG2042_GATE(GATE_CLK_RXU4, "clk_gate_rxu4", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 4),
+	SG2042_GATE(GATE_CLK_RXU5, "clk_gate_rxu5", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 5),
+	SG2042_GATE(GATE_CLK_RXU6, "clk_gate_rxu6", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 6),
+	SG2042_GATE(GATE_CLK_RXU7, "clk_gate_rxu7", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 7),
+	SG2042_GATE(GATE_CLK_RXU8, "clk_gate_rxu8", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 8),
+	SG2042_GATE(GATE_CLK_RXU9, "clk_gate_rxu9", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 9),
+	SG2042_GATE(GATE_CLK_RXU10, "clk_gate_rxu10", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 10),
+	SG2042_GATE(GATE_CLK_RXU11, "clk_gate_rxu11", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 11),
+	SG2042_GATE(GATE_CLK_RXU12, "clk_gate_rxu12", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 12),
+	SG2042_GATE(GATE_CLK_RXU13, "clk_gate_rxu13", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 13),
+	SG2042_GATE(GATE_CLK_RXU14, "clk_gate_rxu14", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 14),
+	SG2042_GATE(GATE_CLK_RXU15, "clk_gate_rxu15", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 15),
+	SG2042_GATE(GATE_CLK_RXU16, "clk_gate_rxu16", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 16),
+	SG2042_GATE(GATE_CLK_RXU17, "clk_gate_rxu17", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 17),
+	SG2042_GATE(GATE_CLK_RXU18, "clk_gate_rxu18", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 18),
+	SG2042_GATE(GATE_CLK_RXU19, "clk_gate_rxu19", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 19),
+	SG2042_GATE(GATE_CLK_RXU20, "clk_gate_rxu20", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 20),
+	SG2042_GATE(GATE_CLK_RXU21, "clk_gate_rxu21", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 21),
+	SG2042_GATE(GATE_CLK_RXU22, "clk_gate_rxu22", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 22),
+	SG2042_GATE(GATE_CLK_RXU23, "clk_gate_rxu23", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 23),
+	SG2042_GATE(GATE_CLK_RXU24, "clk_gate_rxu24", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 24),
+	SG2042_GATE(GATE_CLK_RXU25, "clk_gate_rxu25", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 25),
+	SG2042_GATE(GATE_CLK_RXU26, "clk_gate_rxu26", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 26),
+	SG2042_GATE(GATE_CLK_RXU27, "clk_gate_rxu27", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 27),
+	SG2042_GATE(GATE_CLK_RXU28, "clk_gate_rxu28", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 28),
+	SG2042_GATE(GATE_CLK_RXU29, "clk_gate_rxu29", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 29),
+	SG2042_GATE(GATE_CLK_RXU30, "clk_gate_rxu30", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 30),
+	SG2042_GATE(GATE_CLK_RXU31, "clk_gate_rxu31", "clk_gate_rp_cpu_normal",
+		    0, R_RP_RXU_CLK_ENABLE, 31),
+
+	/* downstream of clk_gate_rp_cpu_normal about mp */
+	SG2042_GATE(GATE_CLK_MP0, "clk_gate_mp0", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP0_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP1, "clk_gate_mp1", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP1_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP2, "clk_gate_mp2", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP2_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP3, "clk_gate_mp3", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP3_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP4, "clk_gate_mp4", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP4_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP5, "clk_gate_mp5", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP5_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP6, "clk_gate_mp6", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP6_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP7, "clk_gate_mp7", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP7_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP8, "clk_gate_mp8", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP8_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP9, "clk_gate_mp9", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP9_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP10, "clk_gate_mp10", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP10_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP11, "clk_gate_mp11", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP11_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP12, "clk_gate_mp12", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP12_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP13, "clk_gate_mp13", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP13_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP14, "clk_gate_mp14", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP14_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP15, "clk_gate_mp15", "clk_gate_rp_cpu_normal",
+		    CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP15_CONTROL_REG, 0),
+};
+
+#define SG2042_MUX(_id, _name, _parent_names, _flags, _r_select, _shift, _width) { \
+		.id = _id,					\
+		.name = _name,					\
+		.parent_names = _parent_names,			\
+		.num_parents = ARRAY_SIZE(_parent_names),	\
+		.flags = _flags,				\
+		.offset_select = _r_select,			\
+		.shift = _shift,				\
+		.width = _width,				\
+	}
+
+/*
+ * Note: regarding names for mux clock, "0/1" or "div0/div1" means the
+ * first/second parent input source, not the register value.
+ * For example:
+ * "clk_div_ddr01_0" is the name of Clock divider 0 control of DDR01, and
+ * "clk_gate_ddr01_div0" is the gate clock in front of the "clk_div_ddr01_0",
+ * they are both controlled by register CLKDIVREG27;
+ * "clk_div_ddr01_1" is the name of Clock divider 1 control of DDR01, and
+ * "clk_gate_ddr01_div1" is the gate clock in front of the "clk_div_ddr01_1",
+ * they are both controlled by register CLKDIVREG28;
+ * While for register value of mux selection, use Clock Select for DDR01’s clock
+ * as example, see CLKSELREG0, bit[2].
+ * 1: Select in_dpll0_clk as clock source, correspondng to the parent input
+ *    source from "clk_div_ddr01_0".
+ * 0: Select in_fpll_clk as clock source, corresponding to the parent input
+ *    source from "clk_div_ddr01_1".
+ * So we need a table to define the array of register values corresponding to
+ * the parent index and tell CCF about this when registering mux clock.
+ */
+static const u32 sg2042_mux_table[] = {1, 0};
+
+static const char *const clk_mux_ddr01_p[] = {
+			"clk_div_ddr01_0", "clk_div_ddr01_1"};
+static const char *const clk_mux_ddr23_p[] = {
+			"clk_div_ddr23_0", "clk_div_ddr23_1"};
+static const char *const clk_mux_rp_cpu_normal_p[] = {
+			"clk_div_rp_cpu_normal_0", "clk_div_rp_cpu_normal_1"};
+static const char *const clk_mux_axi_ddr_p[] = {
+			"clk_div_axi_ddr_0", "clk_div_axi_ddr_1"};
+
+static struct sg2042_mux_clock sg2042_mux_clks[] = {
+	SG2042_MUX(MUX_CLK_DDR01, "clk_mux_ddr01", clk_mux_ddr01_p,
+		   CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_MUX_READ_ONLY,
+		   R_CLKSELREG0, 2, 1),
+	SG2042_MUX(MUX_CLK_DDR23, "clk_mux_ddr23", clk_mux_ddr23_p,
+		   CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_MUX_READ_ONLY,
+		   R_CLKSELREG0, 3, 1),
+	SG2042_MUX(MUX_CLK_RP_CPU_NORMAL, "clk_mux_rp_cpu_normal", clk_mux_rp_cpu_normal_p,
+		   CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+		   R_CLKSELREG0, 0, 1),
+	SG2042_MUX(MUX_CLK_AXI_DDR, "clk_mux_axi_ddr", clk_mux_axi_ddr_p,
+		   CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+		   R_CLKSELREG0, 1, 1),
+};
+
+static DEFINE_SPINLOCK(sg2042_clk_lock);
+
+static int sg2042_clk_register_plls(struct sg2042_clk_data *clk_data,
+				    struct sg2042_pll_clock pll_clks[],
+				    int num_pll_clks)
+{
+	struct clk_hw *hw;
+	struct sg2042_pll_clock *pll;
+	int i, ret = 0;
+
+	for (i = 0; i < num_pll_clks; i++) {
+		pll = &pll_clks[i];
+		/* assign these for ops usage during registration */
+		pll->map = clk_data->regmap;
+		pll->lock = &sg2042_clk_lock;
+
+		hw = &pll->hw;
+		ret = clk_hw_register(NULL, hw);
+		if (ret) {
+			pr_err("failed to register clock %s\n", pll->name);
+			break;
+		}
+
+		clk_data->onecell_data.hws[pll->id] = hw;
+	}
+
+	/* leave unregister to outside if failed */
+	return ret;
+}
+
+static int sg2042_clk_register_divs(struct sg2042_clk_data *clk_data,
+				    struct sg2042_divider_clock div_clks[],
+				    int num_div_clks)
+{
+	struct clk_hw *hw;
+	struct sg2042_divider_clock *div;
+	int i, ret = 0;
+
+	for (i = 0; i < num_div_clks; i++) {
+		div = &div_clks[i];
+
+		if (div->div_flags & CLK_DIVIDER_HIWORD_MASK) {
+			if (div->width + div->shift > 16) {
+				pr_warn("divider value exceeds LOWORD field\n");
+				ret = -EINVAL;
+				break;
+			}
+		}
+
+		div->reg = clk_data->iobase + div->offset_ctrl;
+		div->lock = &sg2042_clk_lock;
+
+		hw = &div->hw;
+		ret = clk_hw_register(NULL, hw);
+		if (ret) {
+			pr_err("failed to register clock %s\n", div->name);
+			break;
+		}
+
+		clk_data->onecell_data.hws[div->id] = hw;
+	}
+
+	/* leave unregister to outside if failed */
+	return ret;
+}
+
+static int sg2042_clk_register_gates(struct sg2042_clk_data *clk_data,
+				     const struct sg2042_gate_clock gate_clks[],
+				     int num_gate_clks)
+{
+	struct clk_hw *hw;
+	const struct sg2042_gate_clock *gate;
+	int i, ret = 0;
+
+	for (i = 0; i < num_gate_clks; i++) {
+		gate = &gate_clks[i];
+		hw = clk_hw_register_gate(NULL,
+					  gate->name,
+					  gate->parent_name,
+					  gate->flags,
+					  clk_data->iobase + gate->offset_enable,
+					  gate->bit_idx,
+					  0,
+					  &sg2042_clk_lock);
+		if (IS_ERR(hw)) {
+			pr_err("failed to register clock %s\n", gate->name);
+			ret = PTR_ERR(hw);
+			break;
+		}
+
+		clk_data->onecell_data.hws[gate->id] = hw;
+	}
+
+	/* leave unregister to outside if failed */
+	return ret;
+}
+
+static int sg2042_mux_notifier_cb(struct notifier_block *nb,
+				  unsigned long event,
+				  void *data)
+{
+	int ret = 0;
+	struct clk_notifier_data *ndata = data;
+	struct clk_hw *hw = __clk_get_hw(ndata->clk);
+	const struct clk_ops *ops = &clk_mux_ops;
+	struct sg2042_mux_clock *mux = to_sg2042_mux_nb(nb);
+
+	/* To switch to fpll before changing rate and restore after that */
+	if (event == PRE_RATE_CHANGE) {
+		mux->original_index = ops->get_parent(hw);
+
+		/*
+		 * "1" is the array index of the second parent input source of
+		 * mux. For SG2042, it's fpll for all mux clocks.
+		 * "0" is the array index of the frist parent input source of
+		 * mux, For SG2042, it's mpll.
+		 * FIXME, any good idea to avoid magic number?
+		 */
+		if (mux->original_index == 0)
+			ret = ops->set_parent(hw, 1);
+	} else if (event == POST_RATE_CHANGE) {
+		ret = ops->set_parent(hw, mux->original_index);
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int sg2042_clk_register_muxs(struct sg2042_clk_data *clk_data,
+				    struct sg2042_mux_clock mux_clks[],
+				    int num_mux_clks)
+{
+	struct clk_hw *hw;
+	struct sg2042_mux_clock *mux;
+	int i, ret = 0;
+
+	for (i = 0; i < num_mux_clks; i++) {
+		mux = &mux_clks[i];
+
+		hw = clk_hw_register_mux_table(NULL,
+					       mux->name,
+					       mux->parent_names,
+					       mux->num_parents,
+					       mux->flags,
+					       clk_data->iobase + mux->offset_select,
+					       mux->shift,
+					       BIT(mux->width) - 1,
+					       0,
+					       sg2042_mux_table,
+					       &sg2042_clk_lock);
+		if (IS_ERR(hw)) {
+			pr_err("failed to register clock %s\n", mux->name);
+			ret = PTR_ERR(hw);
+			break;
+		}
+
+		clk_data->onecell_data.hws[mux->id] = hw;
+
+		/*
+		 * FIXME: Theoretically, we should set parent for the
+		 * mux, but seems hardware has done this for us with
+		 * default value, so we don't set parent again here.
+		 */
+
+		if (!(mux->flags & CLK_MUX_READ_ONLY)) {
+			mux->clk_nb.notifier_call = sg2042_mux_notifier_cb;
+			ret = clk_notifier_register(hw->clk, &mux->clk_nb);
+			if (ret) {
+				pr_err("failed to register clock notifier for %s\n",
+				       mux->name);
+				goto error_cleanup;
+			}
+		}
+	}
+
+	return 0;
+
+error_cleanup:
+	/* unregister notifier and release the memory allocated */
+	for (i = 0; i < num_mux_clks; i++) {
+		mux = &mux_clks[i];
+
+		hw = clk_data->onecell_data.hws[mux->id];
+
+		if (hw)
+			clk_notifier_unregister(hw->clk, &mux->clk_nb);
+	}
+
+	/* leave clk unregister to outside if failed */
+	return ret;
+}
+
+/*
+ * @pll: flag if pll or not
+ *       1: yes, 0: no
+ */
+static int sg2042_init_clkdata(struct device_node *node,
+			       int num_clks,
+			       struct sg2042_clk_data **pp_clk_data,
+			       bool pll)
+{
+	int ret = 0;
+	struct sg2042_clk_data *clk_data = NULL;
+
+	clk_data = kzalloc(struct_size(clk_data, onecell_data.hws, num_clks), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	if (pll) {
+		clk_data->regmap = device_node_to_regmap(node);
+		if (IS_ERR(clk_data->regmap)) {
+			ret = PTR_ERR(clk_data->regmap);
+			goto cleanup;
+		}
+	} else {
+		clk_data->iobase = of_iomap(node, 0);
+		if (!clk_data->iobase) {
+			ret = -EIO;
+			goto cleanup;
+		}
+	}
+
+	clk_data->onecell_data.num = num_clks;
+
+	*pp_clk_data = clk_data;
+
+	return 0;
+
+cleanup:
+	kfree(clk_data);
+	return ret;
+}
+
+static void __init sg2042_clkgen_init(struct device_node *node)
+{
+	struct sg2042_clk_data *clk_data = NULL;
+	int i, ret = 0;
+	int num_clks = 0;
+
+	num_clks = ARRAY_SIZE(sg2042_div_clks) +
+		   ARRAY_SIZE(sg2042_gate_clks) +
+		   ARRAY_SIZE(sg2042_mux_clks);
+	if (num_clks == 0) {
+		ret = -EINVAL;
+		goto error_out;
+	}
+
+	ret = sg2042_init_clkdata(node, num_clks, &clk_data, 0);
+	if (ret < 0)
+		goto error_out;
+
+	ret = sg2042_clk_register_divs(clk_data, sg2042_div_clks,
+				       ARRAY_SIZE(sg2042_div_clks));
+	if (ret)
+		goto cleanup;
+
+	ret = sg2042_clk_register_gates(clk_data, sg2042_gate_clks,
+					ARRAY_SIZE(sg2042_gate_clks));
+	if (ret)
+		goto cleanup;
+
+	ret = sg2042_clk_register_muxs(clk_data, sg2042_mux_clks,
+				       ARRAY_SIZE(sg2042_mux_clks));
+	if (ret)
+		goto cleanup;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, &clk_data->onecell_data);
+	if (ret)
+		goto cleanup;
+
+	return;
+
+cleanup:
+	for (i = 0; i < num_clks; i++) {
+		if (clk_data->onecell_data.hws[i])
+			clk_hw_unregister(clk_data->onecell_data.hws[i]);
+	}
+	kfree(clk_data);
+
+error_out:
+	pr_err("%s failed error number %d\n", __func__, ret);
+}
+
+static void __init sg2042_rpgate_init(struct device_node *node)
+{
+	struct sg2042_clk_data *clk_data = NULL;
+	int i, ret = 0;
+	int num_clks = 0;
+
+	num_clks = ARRAY_SIZE(sg2042_gate_rp);
+	if (num_clks == 0) {
+		ret = -EINVAL;
+		goto error_out;
+	}
+
+	ret = sg2042_init_clkdata(node, num_clks, &clk_data, 0);
+	if (ret < 0)
+		goto error_out;
+
+	ret = sg2042_clk_register_gates(clk_data, sg2042_gate_rp,
+					ARRAY_SIZE(sg2042_gate_rp));
+	if (ret)
+		goto cleanup;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, &clk_data->onecell_data);
+	if (ret)
+		goto cleanup;
+
+	return;
+
+cleanup:
+	for (i = 0; i < num_clks; i++) {
+		if (clk_data->onecell_data.hws[i])
+			clk_hw_unregister(clk_data->onecell_data.hws[i]);
+	}
+	kfree(clk_data);
+
+error_out:
+	pr_err("%s failed error number %d\n", __func__, ret);
+}
+
+static void __init sg2042_pll_init(struct device_node *node)
+{
+	struct sg2042_clk_data *clk_data = NULL;
+	int i, ret = 0;
+	int num_clks = 0;
+
+	num_clks = ARRAY_SIZE(sg2042_pll_clks);
+	if (num_clks == 0) {
+		ret = -EINVAL;
+		goto error_out;
+	}
+
+	ret = sg2042_init_clkdata(node, num_clks, &clk_data, 1);
+	if (ret < 0)
+		goto error_out;
+
+	ret = sg2042_clk_register_plls(clk_data, sg2042_pll_clks,
+				       ARRAY_SIZE(sg2042_pll_clks));
+	if (ret)
+		goto cleanup;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, &clk_data->onecell_data);
+	if (ret)
+		goto cleanup;
+
+	return;
+
+cleanup:
+	for (i = 0; i < num_clks; i++) {
+		if (clk_data->onecell_data.hws[i])
+			clk_hw_unregister(clk_data->onecell_data.hws[i]);
+	}
+	kfree(clk_data);
+
+error_out:
+	pr_err("%s failed error number %d\n", __func__, ret);
+}
+
+CLK_OF_DECLARE(sg2042_clkgen, "sophgo,sg2042-clkgen", sg2042_clkgen_init);
+CLK_OF_DECLARE(sg2042_rpgate, "sophgo,sg2042-rpgate", sg2042_rpgate_init);
+CLK_OF_DECLARE(sg2042_pll, "sophgo,sg2042-pll", sg2042_pll_init);
diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.h b/drivers/clk/sophgo/clk-sophgo-sg2042.h
new file mode 100644
index 000000000000..d0a42a41c7b4
--- /dev/null
+++ b/drivers/clk/sophgo/clk-sophgo-sg2042.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CLK_SOPHGO_SG2042_H
+#define __CLK_SOPHGO_SG2042_H
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+/* Registers defined in SYS_CTRL */
+#define R_PLL_BEGIN		0xC0
+#define R_PLL_STAT		(0xC0 - R_PLL_BEGIN)
+#define R_PLL_CLKEN_CONTROL	(0xC4 - R_PLL_BEGIN)
+#define R_MPLL_CONTROL		(0xE8 - R_PLL_BEGIN)
+#define R_FPLL_CONTROL		(0xF4 - R_PLL_BEGIN)
+#define R_DPLL0_CONTROL		(0xF8 - R_PLL_BEGIN)
+#define R_DPLL1_CONTROL		(0xFC - R_PLL_BEGIN)
+
+#define R_SYSGATE_BEGIN		0x0368
+#define R_RP_RXU_CLK_ENABLE	(0x0368 - R_SYSGATE_BEGIN)
+#define R_MP0_STATUS_REG	(0x0380 - R_SYSGATE_BEGIN)
+#define R_MP0_CONTROL_REG	(0x0384 - R_SYSGATE_BEGIN)
+#define R_MP1_STATUS_REG	(0x0388 - R_SYSGATE_BEGIN)
+#define R_MP1_CONTROL_REG	(0x038C - R_SYSGATE_BEGIN)
+#define R_MP2_STATUS_REG	(0x0390 - R_SYSGATE_BEGIN)
+#define R_MP2_CONTROL_REG	(0x0394 - R_SYSGATE_BEGIN)
+#define R_MP3_STATUS_REG	(0x0398 - R_SYSGATE_BEGIN)
+#define R_MP3_CONTROL_REG	(0x039C - R_SYSGATE_BEGIN)
+#define R_MP4_STATUS_REG	(0x03A0 - R_SYSGATE_BEGIN)
+#define R_MP4_CONTROL_REG	(0x03A4 - R_SYSGATE_BEGIN)
+#define R_MP5_STATUS_REG	(0x03A8 - R_SYSGATE_BEGIN)
+#define R_MP5_CONTROL_REG	(0x03AC - R_SYSGATE_BEGIN)
+#define R_MP6_STATUS_REG	(0x03B0 - R_SYSGATE_BEGIN)
+#define R_MP6_CONTROL_REG	(0x03B4 - R_SYSGATE_BEGIN)
+#define R_MP7_STATUS_REG	(0x03B8 - R_SYSGATE_BEGIN)
+#define R_MP7_CONTROL_REG	(0x03BC - R_SYSGATE_BEGIN)
+#define R_MP8_STATUS_REG	(0x03C0 - R_SYSGATE_BEGIN)
+#define R_MP8_CONTROL_REG	(0x03C4 - R_SYSGATE_BEGIN)
+#define R_MP9_STATUS_REG	(0x03C8 - R_SYSGATE_BEGIN)
+#define R_MP9_CONTROL_REG	(0x03CC - R_SYSGATE_BEGIN)
+#define R_MP10_STATUS_REG	(0x03D0 - R_SYSGATE_BEGIN)
+#define R_MP10_CONTROL_REG	(0x03D4 - R_SYSGATE_BEGIN)
+#define R_MP11_STATUS_REG	(0x03D8 - R_SYSGATE_BEGIN)
+#define R_MP11_CONTROL_REG	(0x03DC - R_SYSGATE_BEGIN)
+#define R_MP12_STATUS_REG	(0x03E0 - R_SYSGATE_BEGIN)
+#define R_MP12_CONTROL_REG	(0x03E4 - R_SYSGATE_BEGIN)
+#define R_MP13_STATUS_REG	(0x03E8 - R_SYSGATE_BEGIN)
+#define R_MP13_CONTROL_REG	(0x03EC - R_SYSGATE_BEGIN)
+#define R_MP14_STATUS_REG	(0x03F0 - R_SYSGATE_BEGIN)
+#define R_MP14_CONTROL_REG	(0x03F4 - R_SYSGATE_BEGIN)
+#define R_MP15_STATUS_REG	(0x03F8 - R_SYSGATE_BEGIN)
+#define R_MP15_CONTROL_REG	(0x03FC - R_SYSGATE_BEGIN)
+
+/* Registers defined in CLOCK */
+#define R_CLKENREG0		0x00
+#define R_CLKENREG1		0x04
+#define R_CLKSELREG0		0x20
+#define R_CLKDIVREG0		0x40
+#define R_CLKDIVREG1		0x44
+#define R_CLKDIVREG2		0x48
+#define R_CLKDIVREG3		0x4C
+#define R_CLKDIVREG4		0x50
+#define R_CLKDIVREG5		0x54
+#define R_CLKDIVREG6		0x58
+#define R_CLKDIVREG7		0x5C
+#define R_CLKDIVREG8		0x60
+#define R_CLKDIVREG9		0x64
+#define R_CLKDIVREG10		0x68
+#define R_CLKDIVREG11		0x6C
+#define R_CLKDIVREG12		0x70
+#define R_CLKDIVREG13		0x74
+#define R_CLKDIVREG14		0x78
+#define R_CLKDIVREG15		0x7C
+#define R_CLKDIVREG16		0x80
+#define R_CLKDIVREG17		0x84
+#define R_CLKDIVREG18		0x88
+#define R_CLKDIVREG19		0x8C
+#define R_CLKDIVREG20		0x90
+#define R_CLKDIVREG21		0x94
+#define R_CLKDIVREG22		0x98
+#define R_CLKDIVREG23		0x9C
+#define R_CLKDIVREG24		0xA0
+#define R_CLKDIVREG25		0xA4
+#define R_CLKDIVREG26		0xA8
+#define R_CLKDIVREG27		0xAC
+#define R_CLKDIVREG28		0xB0
+#define R_CLKDIVREG29		0xB4
+#define R_CLKDIVREG30		0xB8
+
+/*
+ * Common data of clock-controller
+ * Note: this structure will be used both by clkgen & sysclk.
+ * @iobase: base address of clock-controller
+ * @regmap: base address of clock-controller for pll, just due to PLL uses
+ *  regmap while others use iomem.
+ * @lock: clock register access lock
+ * @onecell_data: used for adding providers.
+ */
+struct sg2042_clk_data {
+	void __iomem *iobase;
+	struct regmap *regmap;
+	struct clk_hw_onecell_data onecell_data;
+};
+
+/*
+ * PLL clock
+ * @id:				used to map clk_onecell_data
+ * @name:			used for print even when clk registration failed
+ * @map:			used for regmap read/write, regmap is more useful
+ *				then iomem address when we have multiple offsets
+ *				for different registers.
+ *				NOTE: PLL registers are all in SYS_CTRL!
+ * @lock:			spinlock to protect register access
+ * @offset_status:		offset of pll status registers
+ * @offset_enable:		offset of pll enable registers
+ * @offset_ctrl:		offset of pll control registers
+ * @shift_status_lock:		shift of XXX_LOCK in pll status register
+ * @shift_status_updating:	shift of UPDATING_XXX in pll status register
+ * @shift_enable:		shift of XXX_CLK_EN in pll enable register
+ */
+struct sg2042_pll_clock {
+	struct clk_hw	hw;
+
+	/* private data */
+	unsigned int id;
+	const char *name;
+
+	struct regmap *map;
+	/* modification of frequency can only be served one at the time */
+	spinlock_t *lock;
+
+	u32 offset_status;
+	u32 offset_enable;
+	u32 offset_ctrl;
+	u8 shift_status_lock;
+	u8 shift_status_updating;
+	u8 shift_enable;
+};
+
+#define to_sg2042_pll_clk(_hw) container_of(_hw, struct sg2042_pll_clock, hw)
+
+/*
+ * Divider clock
+ * @id:			used to map clk_onecell_data
+ * @name:		used for print even when clk registration failed
+ * @reg:		used for readl/writel.
+ *			NOTE: DIV registers are ALL in CLOCK!
+ * @lock:		spinlock to protect register access
+ * @offset_ctrl:	offset of divider control registers
+ * @shift:		shift of "Clock Divider Factor" in divider control register
+ * @width:		width of "Clock Divider Factor" in divider control register
+ * @div_flags:		private flags for this clock, not for framework-specific
+ * @initval:		In the divider control register, we can configure whether
+ *			to use the value of "Clock Divider Factor" or just use
+ *			the initial value pre-configured by IC. BIT[3] controls
+ *			this and by default (value is 0), means initial value
+ *			is used.
+ *			**NOTE** that we cannot read the initial value (default
+ *			value when poweron) and default value of "Clock Divider
+ *			Factor" is zero, which I think is a hardware design flaw
+ *			and should be sync-ed with the initial value. So in
+ *			software we have to add a configuration item (initval)
+ *			to manually configure this value and use it when BIT[3]
+ *			is zero.
+ */
+struct sg2042_divider_clock {
+	struct clk_hw	hw;
+
+	/* private data */
+	unsigned int id;
+	const char *name;
+
+	void __iomem *reg;
+	/* modification of frequency can only be served one at the time */
+	spinlock_t *lock;
+
+	unsigned long offset_ctrl;
+	u8 shift;
+	u8 width;
+	u8 div_flags;
+	u32 initval;
+};
+
+#define to_sg2042_clk_divider(_hw)	\
+	container_of(_hw, struct sg2042_divider_clock, hw)
+
+/*
+ * Gate clock
+ * @id:			used to map clk_onecell_data
+ * @name:		string of this clock name
+ * @parent_name:	string of parent clock name
+ * @flags:		framework-specific flags for this clock
+ * @offset_enable:	offset of gate enable registers
+ * @bit_idx:		which bit in the register controls gating of this clock
+ */
+struct sg2042_gate_clock {
+	unsigned int id;
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	unsigned long offset_enable;
+	u8 bit_idx;
+};
+
+/*
+ * Mux clock
+ * @id:			used to map clk_onecell_data
+ * @name:		string of this clock name
+ * @parent_name:	string array of parents' clock name
+ * @flags:		framework-specific flags for this clock
+ * @offset_select:	offset of mux selection registers
+ *			NOTE: MUX registers are ALL in CLOCK!
+ * @shift:		shift of "Clock Select" in mux selection register
+ * @width:		width of "Clock Select" in mux selection register
+ * @clk_nb:		used for notification
+ * @original_index:	set by notifier callback
+ */
+struct sg2042_mux_clock {
+	unsigned int id;
+	const char *name;
+	const char * const *parent_names;
+	u8 num_parents;
+	unsigned long flags;
+	unsigned long offset_select;
+	u8 shift;
+	u8 width;
+	struct notifier_block clk_nb;
+	u8 original_index;
+};
+
+#define to_sg2042_mux_nb(_nb) container_of(_nb, struct sg2042_mux_clock, clk_nb)
+
+#endif /* __CLK_SOPHGO_SG2042_H */
-- 
2.25.1


