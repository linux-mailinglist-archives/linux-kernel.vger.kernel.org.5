Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84377F971C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjK0BPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0BPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:15:52 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9BC11A;
        Sun, 26 Nov 2023 17:15:54 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-589d4033e84so1979753eaf.1;
        Sun, 26 Nov 2023 17:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701047754; x=1701652554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG+LEJpMPY45hXHK8zjCJtt5tVB81mqwDrLnUNB4Tc8=;
        b=Ualf07nXADtDMmgf36z4oTZRHAS2qnWmqe2HkMQfQ/k4oZ+YoPltv6kMxnufw/RZXw
         6I+qAljhLYfac5lBh5tDYIRMD9LTkg/cssyHUaui2pWzpq4YYPNewR07YJvqjn00smAa
         KYpTZiKbGXEkrwUyqm+M3b/nL9KbW5cU7x3uFWu2XPOz0AoYzHRffP6zsMnlABduEG0R
         uBSLDu3x1o6CKMXqAEffWx2jeS8KqZxStj4q6nHusw5tnoC+/Eb23VKUgjHl5weVEOr2
         UlEJJ94fQNUnZ4XEiMylC2DgMXAwr242ZhQbb+nE32nB74KnvRkY9sNrq4keM8oa/PX2
         Vm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701047754; x=1701652554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG+LEJpMPY45hXHK8zjCJtt5tVB81mqwDrLnUNB4Tc8=;
        b=PbH/JKh+HMtDAERQsHGzOI4xJ7rqDPU+JZ9SPyNPEUnpZZdLy0+jtdBCNmupVZ1ls2
         c1+48T8g5HkbOem8VopBGXuhlx6vB5G6nzFFxZ0O+R+RnN/3Q5UIpCKN+JK7CjQyU1Hs
         rsZ8SwV3aUYNRiDiT0ZdsaOK5hp9Yst9ikDeXO9itDD/sWnc9Z3sqY1pEXsKmpV6H+Ex
         Hm8AlohgMdnb7satT4ZknogjYxi5KWCvt1J3F6MEf4c+uEap4XlhZfNr4e+uQCioUKAM
         9azxBmXKyNSfacQYCbVZcRczkZs5L6qecuBGk3p8loW64xHVsMcMqnXsMADJYoWpHEn6
         ZAfw==
X-Gm-Message-State: AOJu0Yw/TCYr0f3a6A6yJ4O7ztTMVhgwJwOidwTfVK0XjUNbptVg7rHI
        GuKj8EW9v13vbe/Zem1z38s=
X-Google-Smtp-Source: AGHT+IFmCVafoTFRmhtjgrWT9WW7zj0kJQzaXxwMd9fPx1i+QdtpJd3lrcgEpRJJDDkJsz6ut+F+Kw==
X-Received: by 2002:a05:6820:551:b0:58d:6da4:ea70 with SMTP id n17-20020a056820055100b0058d6da4ea70mr4636441ooj.3.1701047753624;
        Sun, 26 Nov 2023 17:15:53 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id v65-20020a4a5a44000000b0058a784d6ff2sm1420134ooa.12.2023.11.26.17.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 17:15:53 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v2 3/4] clk: sophgo: Add SG2042 clock generator driver
Date:   Mon, 27 Nov 2023 09:15:42 +0800
Message-Id: <c06130afb4bdc1890b4e8d29388fa6feef1f1826.1701044106.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701044106.git.unicorn_wang@outlook.com>
References: <cover.1701044106.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add a driver for the SOPHGO SG2042 clock generator.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 MAINTAINERS                            |    7 +
 drivers/clk/Kconfig                    |    1 +
 drivers/clk/Makefile                   |    1 +
 drivers/clk/sophgo/Kconfig             |    8 +
 drivers/clk/sophgo/Makefile            |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c | 1357 ++++++++++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h |  222 ++++
 7 files changed, 1598 insertions(+)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..93187d59b498 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20269,6 +20269,13 @@ S:	Maintained
 F:	arch/riscv/boot/dts/sophgo/
 F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
 
+SOPHGO CLOCK DRIVER
+M:	Chen Wang <unicorn_wang@outlook.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/sophgo/
+F:	drivers/clk/sophgo/
+F:	include/dt-bindings/clock/sophgo-sg2042-clk.h
+
 SOUND
 M:	Jaroslav Kysela <perex@perex.cz>
 M:	Takashi Iwai <tiwai@suse.com>
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c30d0d396f7a..514343934fda 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -499,6 +499,7 @@ source "drivers/clk/rockchip/Kconfig"
 source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/socfpga/Kconfig"
+source "drivers/clk/sophgo/Kconfig"
 source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ed71f2e0ee36..aa5d2cf0b6a6 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-y					+= socfpga/
+obj-$(CONFIG_ARCH_SOPHGO)		+= sophgo/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
new file mode 100644
index 000000000000..b0fbe4499870
--- /dev/null
+++ b/drivers/clk/sophgo/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config CLK_SOPHGO_SG2042
+	bool "Sophgo SG2042 clock support"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	default ARCH_SOPHGO
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
index 000000000000..e8cd06a72b81
--- /dev/null
+++ b/drivers/clk/sophgo/clk-sophgo-sg2042.c
@@ -0,0 +1,1357 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sophgo SG2042 Clock Generator Driver
+ *
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+
+#include <dt-bindings/clock/sophgo-sg2042-clk.h>
+
+#include "clk-sophgo-sg2042.h"
+
+#define div_mask(width) ((1 << (width)) - 1)
+#define ENCODE_PLL_CTRL(fbdiv, p1, p2, refdiv) \
+	(((fbdiv & 0xfff) << 16) | ((p2 & 0x7) << 12) | ((p1 & 0x7) << 8) | (refdiv & 0x3f))
+
+static inline int __sg2042_pll_enable(struct sg2042_pll_clock *pll, bool en)
+{
+	unsigned int value = 0;
+	unsigned long enter;
+	struct regmap *map = pll->map;
+
+	if (en) {
+		/* wait pll lock */
+		enter = jiffies;
+		regmap_read(map, pll->offset_status, &value);
+		while (!((value >> pll->shift_status_lock) & 0x1)) {
+			regmap_read(map, pll->shift_status_lock, &value);
+			if (time_after(jiffies, enter + HZ / 10))
+				pr_warn("%s not locked\n", pll->name);
+		}
+		/* wait pll updating */
+		enter = jiffies;
+		regmap_read(map, pll->shift_status_updating, &value);
+		while (((value >> pll->shift_status_updating) & 0x1)) {
+			regmap_read(map, pll->shift_status_updating, &value);
+			if (time_after(jiffies, enter + HZ / 10))
+				pr_warn("%s still updating\n", pll->name);
+		}
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
+static unsigned int __sg2042_get_table_div(
+	const struct clk_div_table *table,
+	unsigned int val)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val == val)
+			return clkt->div;
+	return 0;
+}
+
+static unsigned int __sg2042_get_div(
+	const struct clk_div_table *table,
+	unsigned int val,
+	unsigned long flags, u8 width)
+{
+	if (flags & CLK_DIVIDER_ONE_BASED)
+		return val;
+	if (flags & CLK_DIVIDER_POWER_OF_TWO)
+		return 1 << val;
+	if (flags & CLK_DIVIDER_MAX_AT_ZERO)
+		return val ? val : div_mask(width) + 1;
+	if (table)
+		return __sg2042_get_table_div(table, val);
+	return val + 1;
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
+static unsigned long __sg2042_pll_recalc_rate(
+	unsigned int reg_value,
+	unsigned long parent_rate)
+{
+	unsigned int fbdiv, refdiv;
+	unsigned int postdiv1, postdiv2;
+	u64 rate, numerator, denominator;
+
+	fbdiv = (reg_value >> 16) & 0xfff;
+	refdiv = reg_value & 0x3f;
+	postdiv1 = (reg_value >> 8) & 0x7;
+	postdiv2 = (reg_value >> 12) & 0x7;
+
+	numerator = parent_rate * fbdiv;
+	denominator = refdiv * postdiv1 * postdiv2;
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
+static int __sg2042_pll_get_postdiv_1_2(
+	unsigned long rate,
+	unsigned long prate,
+	unsigned int fbdiv,
+	unsigned int refdiv,
+	unsigned int *postdiv1,
+	unsigned int *postdiv2)
+{
+	int index = 0;
+	int ret = 0;
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
+	} else {
+		/* (div1 * div2) > 7, use array search */
+		for (index = 0; index < ARRAY_SIZE(postdiv1_2); index++) {
+			if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
+				continue;
+			} else {
+				/* found it */
+				break;
+			}
+		}
+		if (index < ARRAY_SIZE(postdiv1_2)) {
+			*postdiv1 = postdiv1_2[index][1];
+			*postdiv2 = postdiv1_2[index][0];
+		} else {
+			pr_debug("%s can not find in postdiv array!\n", __func__);
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
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
+/*
+ * Based on the given FOUTPISTDIV and the input FREF to calculate
+ * the REFDIV/FBDIV/PSTDIV1/POSTDIV2 combination for pllctrl register.
+ * @req_rate: expected output clock rate, i.e. FOUTPISTDIV
+ * @parent_rate: input parent clock rate, i.e. FREF
+ * @best: output to hold calculated combination of REFDIV/FBDIV/PSTDIV1/POSTDIV2
+ */
+static int __sg2042_get_pll_ctl_setting(
+	struct sg2042_pll_ctrl *best,
+	unsigned long req_rate,
+	unsigned long parent_rate)
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
+			ret = __sg2042_pll_get_postdiv_1_2(
+				req_rate, parent_rate, fbdiv, refdiv,
+				&postdiv1, &postdiv2);
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
+static unsigned long sg2042_clk_pll_recalc_rate(
+	struct clk_hw *hw,
+	unsigned long parent_rate)
+{
+	unsigned int value;
+	unsigned long rate;
+	struct sg2042_pll_clock *pll = to_sg2042_pll_clk(hw);
+
+	regmap_read(pll->map, pll->offset_ctrl, &value);
+	rate = __sg2042_pll_recalc_rate(value, parent_rate);
+
+	pr_debug("--> %s: pll_recalc_rate: val = %ld\n",
+		clk_hw_get_name(hw), rate);
+	return rate;
+}
+
+static long sg2042_clk_pll_round_rate(
+	struct clk_hw *hw,
+	unsigned long req_rate,
+	unsigned long *prate)
+{
+	unsigned int value;
+	struct sg2042_pll_ctrl pctrl_table;
+	long proper_rate;
+	int ret;
+
+	ret = __sg2042_get_pll_ctl_setting(&pctrl_table, req_rate, *prate);
+	if (ret) {
+		proper_rate = 0;
+		goto out;
+	}
+
+	value = ENCODE_PLL_CTRL(pctrl_table.fbdiv, pctrl_table.postdiv1,
+			     pctrl_table.postdiv2, pctrl_table.refdiv);
+	proper_rate = (long)__sg2042_pll_recalc_rate(value, *prate);
+
+out:
+	pr_debug("--> %s: pll_round_rate: val = %ld\n",
+		clk_hw_get_name(hw), proper_rate);
+	return proper_rate;
+}
+
+static int sg2042_clk_pll_determine_rate(
+	struct clk_hw *hw,
+	struct clk_rate_request *req)
+{
+	req->rate = sg2042_clk_pll_round_rate(hw, min(req->rate, req->max_rate),
+					  &req->best_parent_rate);
+	pr_debug("--> %s: pll_determine_rate: val = %ld\n",
+		clk_hw_get_name(hw), req->rate);
+	return 0;
+}
+
+static int sg2042_clk_pll_set_rate(
+	struct clk_hw *hw,
+	unsigned long rate,
+	unsigned long parent_rate)
+{
+	unsigned long flags;
+	unsigned int value;
+	int ret = 0;
+	struct sg2042_pll_ctrl pctrl_table;
+	struct sg2042_pll_clock *pll = to_sg2042_pll_clk(hw);
+
+	spin_lock_irqsave(pll->lock, flags);
+	if (__sg2042_pll_enable(pll, 0)) {
+		pr_warn("Can't disable pll(%s), status error\n", pll->name);
+		goto out;
+	}
+	ret = __sg2042_get_pll_ctl_setting(&pctrl_table, rate, parent_rate);
+	if (ret) {
+		pr_warn("%s: Can't find a proper pll setting\n", pll->name);
+		goto out2;
+	}
+
+	value = ENCODE_PLL_CTRL(pctrl_table.fbdiv, pctrl_table.postdiv1,
+			     pctrl_table.postdiv2, pctrl_table.refdiv);
+
+	/* write the value to top register */
+	regmap_write(pll->map, pll->offset_ctrl, value);
+
+out2:
+	__sg2042_pll_enable(pll, 1);
+out:
+	spin_unlock_irqrestore(pll->lock, flags);
+
+	pr_debug("--> %s: pll_set_rate: val = 0x%x\n",
+		clk_hw_get_name(hw), value);
+	return ret;
+}
+
+static unsigned long sg2042_clk_divider_recalc_rate(
+	struct clk_hw *hw,
+	unsigned long parent_rate)
+{
+	struct sg2042_divider_clock *divider = to_sg2042_clk_divider(hw);
+	unsigned int val;
+	unsigned long ret_rate;
+
+	val = readl(divider->reg) >> divider->shift;
+	val &= div_mask(divider->width);
+
+	ret_rate = divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->div_flags, divider->width);
+
+	pr_debug("--> %s: divider_recalc_rate: val = %ld\n",
+		clk_hw_get_name(hw), ret_rate);
+	return ret_rate;
+}
+
+static long sg2042_clk_divider_round_rate(
+	struct clk_hw *hw,
+	unsigned long rate,
+	unsigned long *prate)
+{
+	int bestdiv;
+	unsigned long ret_rate;
+	struct sg2042_divider_clock *divider = to_sg2042_clk_divider(hw);
+
+	/* if read only, just return current value */
+	if (divider->div_flags & CLK_DIVIDER_READ_ONLY) {
+		bestdiv = readl(divider->reg) >> divider->shift;
+		bestdiv &= div_mask(divider->width);
+		bestdiv = __sg2042_get_div(divider->table, bestdiv, divider->div_flags,
+				   divider->width);
+		ret_rate = DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+	} else {
+		ret_rate = divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->div_flags);
+	}
+
+	pr_debug("--> %s: divider_round_rate: val = %ld\n",
+		clk_hw_get_name(hw), ret_rate);
+	return ret_rate;
+}
+
+static int sg2042_clk_divider_set_rate(
+	struct clk_hw *hw,
+	unsigned long rate,
+	unsigned long parent_rate)
+{
+	unsigned int value;
+	unsigned int val, val2;
+	unsigned long flags = 0;
+	struct sg2042_divider_clock *divider = to_sg2042_clk_divider(hw);
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->div_flags);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/* div assert */
+	val = readl(divider->reg);
+	val &= ~0x1;
+	writel(val, divider->reg);
+
+	if (divider->div_flags & CLK_DIVIDER_HIWORD_MASK) {
+		val = div_mask(divider->width) << (divider->shift + 16);
+	} else {
+		val = readl(divider->reg);
+		val &= ~(div_mask(divider->width) << divider->shift);
+	}
+
+	val |= value << divider->shift;
+	writel(val, divider->reg);
+	val2 = val;
+
+	if (!(divider->div_flags & CLK_DIVIDER_READ_ONLY))
+		val |= 1 << 3;
+
+	/* de-assert */
+	val |= 1;
+	writel(val, divider->reg);
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	pr_debug("--> %s: divider_set_rate: register val = 0x%x\n",
+		clk_hw_get_name(hw), val2);
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
+		.shift_status_lock = 8 + _shift,			\
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
+		.shift_status_lock = 8 + _shift,			\
+		.shift_status_updating = _shift,			\
+		.shift_enable = _shift,					\
+	}
+
+static struct sg2042_pll_clock sg2042_pll_clks[] = {
+	SG2042_PLL_RO(FPLL_CLK, "fpll_clock", "cgi",
+		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_FPLL_CONTROL, 3),
+	SG2042_PLL_RO(DPLL0_CLK, "dpll0_clock", "cgi",
+		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL0_CONTROL, 4),
+	SG2042_PLL_RO(DPLL1_CLK, "dpll1_clock", "cgi",
+		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL1_CONTROL, 5),
+	SG2042_PLL(MPLL_CLK, "mpll_clock", "cgi",
+		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_MPLL_CONTROL, 0),
+};
+
+#define SG2042_DIV(_id, _name, _parent_name,				\
+		  _r_ctrl, _shift, _width,				\
+		  _div_flag, _init_val) {				\
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
+		.initial_val = _init_val,				\
+		.table = NULL,						\
+	}
+
+#define SG2042_DIV_RO(_id, _name, _parent_name,				\
+		  _r_ctrl, _shift, _width,				\
+		  _div_flag, _init_val) {				\
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
+		.div_flags = _div_flag,					\
+		.initial_val = _init_val,				\
+		.table = NULL,						\
+	}
+
+/*
+ * DIV items in the array are sorted according to the clock-tree diagram,
+ * from top to bottom, from upstream to downstream. Read TRM for details.
+ */
+#define DEF_DIVFLAG (CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO)
+static struct sg2042_divider_clock sg2042_div_clks[] = {
+	SG2042_DIV_RO(DIV_CLK_DPLL0_DDR01_0,
+		"clk_div_ddr01_0", "clk_gate_ddr01_div0",
+		R_CLKDIVREG27, 16, 5,
+		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
+	SG2042_DIV_RO(DIV_CLK_FPLL_DDR01_1,
+		"clk_div_ddr01_1", "clk_gate_ddr01_div1",
+		R_CLKDIVREG28, 16, 5,
+		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
+
+	SG2042_DIV_RO(DIV_CLK_DPLL1_DDR23_0,
+		"clk_div_ddr23_0", "clk_gate_ddr23_div0",
+		R_CLKDIVREG29, 16, 5,
+		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
+	SG2042_DIV_RO(DIV_CLK_FPLL_DDR23_1,
+		"clk_div_ddr23_1", "clk_gate_ddr23_div1",
+		R_CLKDIVREG30, 16, 5,
+		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
+
+	SG2042_DIV(DIV_CLK_MPLL_RP_CPU_NORMAL_0,
+		"clk_div_rp_cpu_normal_0", "clk_gate_rp_cpu_normal_div0",
+		R_CLKDIVREG0, 16, 5, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_RP_CPU_NORMAL_1,
+		"clk_div_rp_cpu_normal_1", "clk_gate_rp_cpu_normal_div1",
+		R_CLKDIVREG1, 16, 5, DEF_DIVFLAG, 0),
+
+	SG2042_DIV(DIV_CLK_MPLL_AXI_DDR_0,
+		"clk_div_axi_ddr_0", "clk_gate_axi_ddr_div0",
+		R_CLKDIVREG25, 16, 5, DEF_DIVFLAG, 5),
+	SG2042_DIV(DIV_CLK_FPLL_AXI_DDR_1,
+		"clk_div_axi_ddr_1", "clk_gate_axi_ddr_div1",
+		R_CLKDIVREG26, 16, 5, DEF_DIVFLAG, 5),
+
+	SG2042_DIV(DIV_CLK_FPLL_TOP_RP_CMN_DIV2,
+		"clk_div_top_rp_cmn_div2", "clk_mux_rp_cpu_normal",
+		R_CLKDIVREG3, 16, 16, DEF_DIVFLAG, 0),
+
+	SG2042_DIV(DIV_CLK_FPLL_50M_A53, "clk_div_50m_a53", "fpll_clock",
+		R_CLKDIVREG2, 16, 8, DEF_DIVFLAG, 0),
+	/* downstream of div_50m_a53 */
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER1, "clk_div_timer1", "clk_div_50m_a53",
+		R_CLKDIVREG6, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER2, "clk_div_timer2", "clk_div_50m_a53",
+		R_CLKDIVREG7, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER3, "clk_div_timer3", "clk_div_50m_a53",
+		R_CLKDIVREG8, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER4, "clk_div_timer4", "clk_div_50m_a53",
+		R_CLKDIVREG9, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER5, "clk_div_timer5", "clk_div_50m_a53",
+		R_CLKDIVREG10, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER6, "clk_div_timer6", "clk_div_50m_a53",
+		R_CLKDIVREG11, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER7, "clk_div_timer7", "clk_div_50m_a53",
+		R_CLKDIVREG12, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER8, "clk_div_timer8", "clk_div_50m_a53",
+		R_CLKDIVREG13, 16, 16, DEF_DIVFLAG, 0),
+
+	SG2042_DIV_RO(DIV_CLK_FPLL_UART_500M, "clk_div_uart_500m", "fpll_clock",
+		R_CLKDIVREG4, 16, 7,
+		CLK_DIVIDER_READ_ONLY, 0),
+	SG2042_DIV(DIV_CLK_FPLL_AHB_LPC, "clk_div_ahb_lpc", "fpll_clock",
+		R_CLKDIVREG5, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_EFUSE, "clk_div_efuse", "fpll_clock",
+		R_CLKDIVREG14, 16, 7, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_TX_ETH0, "clk_div_tx_eth0", "fpll_clock",
+		R_CLKDIVREG16, 16, 11, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_PTP_REF_I_ETH0,
+		"clk_div_ptp_ref_i_eth0", "fpll_clock",
+		R_CLKDIVREG17, 16, 8, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_REF_ETH0, "clk_div_ref_eth0", "fpll_clock",
+		R_CLKDIVREG18, 16, 8, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_EMMC, "clk_div_emmc", "fpll_clock",
+		R_CLKDIVREG19, 16, 5, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_SD, "clk_div_sd", "fpll_clock",
+		R_CLKDIVREG21, 16, 5, DEF_DIVFLAG, 0),
+
+	SG2042_DIV(DIV_CLK_FPLL_TOP_AXI0, "clk_div_top_axi0", "fpll_clock",
+		R_CLKDIVREG23, 16, 5, DEF_DIVFLAG, 0),
+	/* downstream of div_top_axi0 */
+	SG2042_DIV(DIV_CLK_FPLL_100K_EMMC, "clk_div_100k_emmc", "clk_div_top_axi0",
+		R_CLKDIVREG20, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_100K_SD, "clk_div_100k_sd", "clk_div_top_axi0",
+		R_CLKDIVREG22, 16, 16, DEF_DIVFLAG, 0),
+	SG2042_DIV(DIV_CLK_FPLL_GPIO_DB, "clk_div_gpio_db", "clk_div_top_axi0",
+		R_CLKDIVREG15, 16, 16, DEF_DIVFLAG, 0),
+
+	SG2042_DIV(DIV_CLK_FPLL_TOP_AXI_HSPERI,
+		"clk_div_top_axi_hsperi", "fpll_clock",
+		R_CLKDIVREG24, 16, 5, DEF_DIVFLAG, 0),
+};
+
+#define SG2042_GATE(_id, _name, _parent_name, _flags, _r_enable, _bit_idx) { \
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
+static const struct sg2042_gate_clock sg2042_gate_clks[] = {
+	SG2042_GATE(GATE_CLK_DDR01_DIV0, "clk_gate_ddr01_div0", "dpll0_clock",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		R_CLKDIVREG27, 4),
+	SG2042_GATE(GATE_CLK_DDR01_DIV1, "clk_gate_ddr01_div1", "fpll_clock",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKDIVREG28, 4),
+
+	SG2042_GATE(GATE_CLK_DDR23_DIV0, "clk_gate_ddr23_div0", "dpll1_clock",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		R_CLKDIVREG29, 4),
+	SG2042_GATE(GATE_CLK_DDR23_DIV1, "clk_gate_ddr23_div1", "fpll_clock",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKDIVREG30, 4),
+
+	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV0, "clk_gate_rp_cpu_normal_div0", "mpll_clock",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKDIVREG0, 4),
+	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV1,
+		"clk_gate_rp_cpu_normal_div1", "fpll_clock",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKDIVREG1, 4),
+
+	SG2042_GATE(GATE_CLK_AXI_DDR_DIV0, "clk_gate_axi_ddr_div0", "mpll_clock",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKDIVREG25, 4),
+	SG2042_GATE(GATE_CLK_AXI_DDR_DIV1, "clk_gate_axi_ddr_div1", "fpll_clock",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKDIVREG26, 4),
+
+	/* upon are gate clocks as input source for the muxes */
+
+	SG2042_GATE(GATE_CLK_DDR01, "clk_gate_ddr01", "clk_mux_ddr01",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKENREG1, 14),
+
+	SG2042_GATE(GATE_CLK_DDR23, "clk_gate_ddr23", "clk_mux_ddr23",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKENREG1, 15),
+
+	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL,
+		"clk_gate_rp_cpu_normal", "clk_mux_rp_cpu_normal",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKENREG0, 0),
+
+	SG2042_GATE(GATE_CLK_AXI_DDR, "clk_gate_axi_ddr", "clk_mux_axi_ddr",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
+		R_CLKENREG1, 13),
+
+	/* upon are gate clocks directly downstream of muxes */
+
+	/* downstream of clk_div_top_rp_cmn_div2 */
+	SG2042_GATE(GATE_CLK_TOP_RP_CMN_DIV2,
+		"clk_gate_top_rp_cmn_div2", "clk_div_top_rp_cmn_div2",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 2),
+	SG2042_GATE(GATE_CLK_HSDMA, "clk_gate_hsdma", "clk_gate_top_rp_cmn_div2",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 10),
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
+		"clk_gate_axi_pcie0", "clk_gate_rp_cpu_normal",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1, 8),
+	SG2042_GATE(GATE_CLK_AXI_PCIE1,
+		"clk_gate_axi_pcie1", "clk_gate_rp_cpu_normal",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1, 9),
+
+	/* downstream of div_50m_a53 */
+	SG2042_GATE(GATE_CLK_A53_50M, "clk_gate_a53_50m", "clk_div_50m_a53",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 1),
+	SG2042_GATE(GATE_CLK_TIMER1, "clk_gate_timer1", "clk_div_timer1",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 12),
+	SG2042_GATE(GATE_CLK_TIMER2, "clk_gate_timer2", "clk_div_timer2",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 13),
+	SG2042_GATE(GATE_CLK_TIMER3, "clk_gate_timer3", "clk_div_timer3",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 14),
+	SG2042_GATE(GATE_CLK_TIMER4, "clk_gate_timer4", "clk_div_timer4",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 15),
+	SG2042_GATE(GATE_CLK_TIMER5, "clk_gate_timer5", "clk_div_timer5",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 16),
+	SG2042_GATE(GATE_CLK_TIMER6, "clk_gate_timer6", "clk_div_timer6",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 17),
+	SG2042_GATE(GATE_CLK_TIMER7, "clk_gate_timer7", "clk_div_timer7",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 18),
+	SG2042_GATE(GATE_CLK_TIMER8, "clk_gate_timer8", "clk_div_timer8",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 19),
+
+	/* gate clocks downstream from div clocks one-to-one */
+	SG2042_GATE(GATE_CLK_UART_500M, "clk_gate_uart_500m", "clk_div_uart_500m",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 4),
+	SG2042_GATE(GATE_CLK_AHB_LPC, "clk_gate_ahb_lpc", "clk_div_ahb_lpc",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 7),
+	SG2042_GATE(GATE_CLK_EFUSE, "clk_gate_efuse", "clk_div_efuse",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 20),
+	SG2042_GATE(GATE_CLK_TX_ETH0, "clk_gate_tx_eth0", "clk_div_tx_eth0",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 30),
+	SG2042_GATE(GATE_CLK_PTP_REF_I_ETH0,
+		"clk_gate_ptp_ref_i_eth0", "clk_div_ptp_ref_i_eth0",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 0),
+	SG2042_GATE(GATE_CLK_REF_ETH0, "clk_gate_ref_eth0", "clk_div_ref_eth0",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 1),
+	SG2042_GATE(GATE_CLK_EMMC_100M, "clk_gate_emmc", "clk_div_emmc",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 3),
+	SG2042_GATE(GATE_CLK_SD_100M, "clk_gate_sd", "clk_div_sd",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 6),
+
+	/* downstream of clk_div_top_axi0 */
+	SG2042_GATE(GATE_CLK_AHB_ROM, "clk_gate_ahb_rom", "clk_div_top_axi0",
+		 0, R_CLKENREG0, 8),
+	SG2042_GATE(GATE_CLK_AHB_SF, "clk_gate_ahb_sf", "clk_div_top_axi0",
+		0, R_CLKENREG0, 9),
+	SG2042_GATE(GATE_CLK_AXI_SRAM, "clk_gate_axi_sram", "clk_div_top_axi0",
+		CLK_IGNORE_UNUSED, R_CLKENREG0, 10),
+	SG2042_GATE(GATE_CLK_APB_TIMER, "clk_gate_apb_timer", "clk_div_top_axi0",
+		CLK_IGNORE_UNUSED, R_CLKENREG0, 11),
+	SG2042_GATE(GATE_CLK_APB_EFUSE, "clk_gate_apb_efuse", "clk_div_top_axi0",
+		0, R_CLKENREG0, 21),
+	SG2042_GATE(GATE_CLK_APB_GPIO, "clk_gate_apb_gpio", "clk_div_top_axi0",
+		0, R_CLKENREG0, 22),
+	SG2042_GATE(GATE_CLK_APB_GPIO_INTR,
+		"clk_gate_apb_gpio_intr", "clk_div_top_axi0",
+		0, R_CLKENREG0, 23),
+	SG2042_GATE(GATE_CLK_APB_I2C, "clk_gate_apb_i2c", "clk_div_top_axi0",
+		0, R_CLKENREG0, 26),
+	SG2042_GATE(GATE_CLK_APB_WDT, "clk_gate_apb_wdt", "clk_div_top_axi0",
+		0, R_CLKENREG0, 27),
+	SG2042_GATE(GATE_CLK_APB_PWM, "clk_gate_apb_pwm", "clk_div_top_axi0",
+		0, R_CLKENREG0, 28),
+	SG2042_GATE(GATE_CLK_APB_RTC, "clk_gate_apb_rtc", "clk_div_top_axi0",
+		0, R_CLKENREG0, 29),
+	SG2042_GATE(GATE_CLK_TOP_AXI0, "clk_gate_top_axi0", "clk_div_top_axi0",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_CLKENREG1, 11),
+	/* downstream of DIV clocks which are sourced from clk_div_top_axi0 */
+	SG2042_GATE(GATE_CLK_GPIO_DB, "clk_gate_gpio_db", "clk_div_gpio_db",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 24),
+	SG2042_GATE(GATE_CLK_100K_EMMC, "clk_gate_100k_emmc", "clk_div_100k_emmc",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 4),
+	SG2042_GATE(GATE_CLK_100K_SD, "clk_gate_100k_sd", "clk_div_100k_sd",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 7),
+
+	/* downstream of clk_div_top_axi_hsperi */
+	SG2042_GATE(GATE_CLK_SYSDMA_AXI,
+		"clk_gate_sysdma_axi", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 3),
+	SG2042_GATE(GATE_CLK_APB_UART,
+		"clk_gate_apb_uart", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 5),
+	SG2042_GATE(GATE_CLK_AXI_DBG_I2C,
+		"clk_gate_axi_dbg_i2c", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 6),
+	SG2042_GATE(GATE_CLK_APB_SPI,
+		"clk_gate_apb_spi", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 25),
+	SG2042_GATE(GATE_CLK_AXI_ETH0,
+		"clk_gate_axi_eth0", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT, R_CLKENREG0, 31),
+	SG2042_GATE(GATE_CLK_AXI_EMMC,
+		"clk_gate_axi_emmc", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 2),
+	SG2042_GATE(GATE_CLK_AXI_SD,
+		"clk_gate_axi_sd", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT, R_CLKENREG1, 5),
+	SG2042_GATE(GATE_CLK_TOP_AXI_HSPERI,
+		"clk_gate_top_axi_hsperi", "clk_div_top_axi_hsperi",
+		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_CLKENREG1, 12),
+
+	/* downstream of clk_gate_rp_cpu_normal about rxu */
+	SG2042_GATE(GATE_CLK_RXU0, "clk_gate_rxu0", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 0),
+	SG2042_GATE(GATE_CLK_RXU1, "clk_gate_rxu1", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 1),
+	SG2042_GATE(GATE_CLK_RXU2, "clk_gate_rxu2", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 2),
+	SG2042_GATE(GATE_CLK_RXU3, "clk_gate_rxu3", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 3),
+	SG2042_GATE(GATE_CLK_RXU4, "clk_gate_rxu4", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 4),
+	SG2042_GATE(GATE_CLK_RXU5, "clk_gate_rxu5", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 5),
+	SG2042_GATE(GATE_CLK_RXU6, "clk_gate_rxu6", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 6),
+	SG2042_GATE(GATE_CLK_RXU7, "clk_gate_rxu7", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 7),
+	SG2042_GATE(GATE_CLK_RXU8, "clk_gate_rxu8", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 8),
+	SG2042_GATE(GATE_CLK_RXU9, "clk_gate_rxu9", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 9),
+	SG2042_GATE(GATE_CLK_RXU10, "clk_gate_rxu10", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 10),
+	SG2042_GATE(GATE_CLK_RXU11, "clk_gate_rxu11", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 11),
+	SG2042_GATE(GATE_CLK_RXU12, "clk_gate_rxu12", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 12),
+	SG2042_GATE(GATE_CLK_RXU13, "clk_gate_rxu13", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 13),
+	SG2042_GATE(GATE_CLK_RXU14, "clk_gate_rxu14", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 14),
+	SG2042_GATE(GATE_CLK_RXU15, "clk_gate_rxu15", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 15),
+	SG2042_GATE(GATE_CLK_RXU16, "clk_gate_rxu16", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 16),
+	SG2042_GATE(GATE_CLK_RXU17, "clk_gate_rxu17", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 17),
+	SG2042_GATE(GATE_CLK_RXU18, "clk_gate_rxu18", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 18),
+	SG2042_GATE(GATE_CLK_RXU19, "clk_gate_rxu19", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 19),
+	SG2042_GATE(GATE_CLK_RXU20, "clk_gate_rxu20", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 20),
+	SG2042_GATE(GATE_CLK_RXU21, "clk_gate_rxu21", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 21),
+	SG2042_GATE(GATE_CLK_RXU22, "clk_gate_rxu22", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 22),
+	SG2042_GATE(GATE_CLK_RXU23, "clk_gate_rxu23", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 23),
+	SG2042_GATE(GATE_CLK_RXU24, "clk_gate_rxu24", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 24),
+	SG2042_GATE(GATE_CLK_RXU25, "clk_gate_rxu25", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 25),
+	SG2042_GATE(GATE_CLK_RXU26, "clk_gate_rxu26", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 26),
+	SG2042_GATE(GATE_CLK_RXU27, "clk_gate_rxu27", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 27),
+	SG2042_GATE(GATE_CLK_RXU28, "clk_gate_rxu28", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 28),
+	SG2042_GATE(GATE_CLK_RXU29, "clk_gate_rxu29", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 29),
+	SG2042_GATE(GATE_CLK_RXU30, "clk_gate_rxu30", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 30),
+	SG2042_GATE(GATE_CLK_RXU31, "clk_gate_rxu31", "clk_gate_rp_cpu_normal",
+		0, R_RP_RXU_CLK_ENABLE, 31),
+
+	/* downstream of clk_gate_rp_cpu_normal about mp */
+	SG2042_GATE(GATE_CLK_MP0, "clk_gate_mp0", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP0_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP1, "clk_gate_mp1", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP1_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP2, "clk_gate_mp2", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP2_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP3, "clk_gate_mp3", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP3_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP4, "clk_gate_mp4", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP4_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP5, "clk_gate_mp5", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP5_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP6, "clk_gate_mp6", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP6_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP7, "clk_gate_mp7", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP7_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP8, "clk_gate_mp8", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP8_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP9, "clk_gate_mp9", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP9_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP10, "clk_gate_mp10", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP10_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP11, "clk_gate_mp11", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP11_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP12, "clk_gate_mp12", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP12_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP13, "clk_gate_mp13", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP13_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP14, "clk_gate_mp14", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP14_CONTROL_REG, 0),
+	SG2042_GATE(GATE_CLK_MP15, "clk_gate_mp15", "clk_gate_rp_cpu_normal",
+		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP15_CONTROL_REG, 0),
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
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_MUX_READ_ONLY,
+		R_CLKSELREG0, 2, 1),
+	SG2042_MUX(MUX_CLK_DDR23, "clk_mux_ddr23", clk_mux_ddr23_p,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_MUX_READ_ONLY,
+		R_CLKSELREG0, 3, 1),
+	SG2042_MUX(MUX_CLK_RP_CPU_NORMAL, "clk_mux_rp_cpu_normal", clk_mux_rp_cpu_normal_p,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+		R_CLKSELREG0, 0, 1),
+	SG2042_MUX(MUX_CLK_AXI_DDR, "clk_mux_axi_ddr", clk_mux_axi_ddr_p,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+		R_CLKSELREG0, 1, 1),
+};
+
+DEFINE_SPINLOCK(sg2042_clk_lock);
+
+static int sg2042_clk_register_plls(struct sg2042_clk_data *clk_data,
+				   struct sg2042_pll_clock pll_clks[],
+				   int num_pll_clks)
+{
+	struct clk_hw *hw;
+	struct sg2042_pll_clock *pll;
+	int i, ret = 0;
+
+	for (i = 0; i < num_pll_clks; i++) {
+		pll = &(pll_clks[i]);
+		/* assign these for ops usage during registration */
+		pll->map = clk_data->syscon;
+		pll->lock = &sg2042_clk_lock;
+
+		hw = &pll->hw;
+		ret = clk_hw_register(NULL, hw);
+		if (ret) {
+			pr_err("failed to register clock %s\n", pll->name);
+			break;
+		}
+
+		dbg_info("registered [%d : %s]\n", pll->id, pll->name);
+		clk_data->onecell_data.hws[pll->id] = hw;
+	}
+
+	/* leave unregister to outside if failed */
+	return ret;
+}
+
+static int sg2042_clk_register_divs(struct sg2042_clk_data *clk_data,
+				   struct sg2042_divider_clock div_clks[],
+				   int num_div_clks)
+{
+	struct clk_hw *hw;
+	struct sg2042_divider_clock *div;
+	int i, val, ret = 0;
+
+	for (i = 0; i < num_div_clks; i++) {
+		div = &(div_clks[i]);
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
+		dbg_info("registered [%d : %s]\n", div->id, div->name);
+		clk_data->onecell_data.hws[div->id] = hw;
+
+		if (div->initial_val >= 0) {
+			regmap_read(clk_data->syscon, div->offset_ctrl, &val);
+
+			/*
+			 * set a default divider factor,
+			 * clk driver should not select divider clock as the
+			 * clock source, before set the divider by right process
+			 * (assert div, set div factor, de assert div).
+			 */
+			if (div->initial_val > 0)
+				val |= (div->initial_val << 16 | 1 << 3);
+			else {
+				/*
+				 * the div register is config to use divider
+				 * factor, don't change divider
+				 */
+				if (!(val >> 3 & 0x1))
+					val |= 1 << 16;
+			}
+
+			regmap_write(clk_data->syscon, div->offset_ctrl, val);
+		}
+	}
+
+	/* leave unregister to outside if failed */
+	return ret;
+}
+
+static int sg2042_clk_register_gates(struct sg2042_clk_data *clk_data,
+				    const struct sg2042_gate_clock gate_clks[],
+				    int num_gate_clks)
+{
+	struct clk_hw *hw;
+	const struct sg2042_gate_clock *gate;
+	int i, ret = 0;
+
+	for (i = 0; i < num_gate_clks; i++) {
+		gate = &(gate_clks[i]);
+		hw = clk_hw_register_gate(
+			NULL,
+			gate->name,
+			gate->parent_name,
+			gate->flags,
+			clk_data->iobase + gate->offset_enable,
+			gate->bit_idx,
+			0,
+			&sg2042_clk_lock);
+		if (IS_ERR(hw)) {
+			pr_err("failed to register clock %s\n", gate->name);
+			ret = PTR_ERR(hw);
+			break;
+		}
+
+		dbg_info("registered [%d : %s]\n", gate->id, gate->name);
+		clk_data->onecell_data.hws[gate->id] = hw;
+	}
+
+	/* leave unregister to outside if failed */
+	return ret;
+}
+
+static int sg2042_mux_notifier_cb(struct notifier_block *nb,
+				unsigned long event, void *data)
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
+		dbg_info("%s: trying to switch parent from %d to 1\n",
+			clk_hw_get_name(hw), mux->original_index);
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
+		dbg_info("%s: switch parent from %d to %d\n",
+			clk_hw_get_name(hw),
+			ops->get_parent(hw),
+			mux->original_index);
+		ret = ops->set_parent(hw, mux->original_index);
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int sg2042_clk_register_muxs(struct sg2042_clk_data *clk_data,
+				   struct sg2042_mux_clock mux_clks[],
+				   int num_mux_clks)
+{
+	struct clk_hw *hw;
+	struct sg2042_mux_clock *mux;
+	int i, ret = 0;
+
+	for (i = 0; i < num_mux_clks; i++) {
+		mux = &(mux_clks[i]);
+
+		hw = clk_hw_register_mux_table(
+			NULL,
+			mux->name,
+			mux->parent_names,
+			mux->num_parents,
+			mux->flags,
+			clk_data->iobase + mux->offset_select,
+			mux->shift,
+			BIT(mux->width) - 1,
+			0,
+			sg2042_mux_table,
+			&sg2042_clk_lock);
+		if (IS_ERR(hw)) {
+			pr_err("failed to register clock %s\n", mux->name);
+			ret = PTR_ERR(hw);
+			break;
+		}
+
+		dbg_info("registered [%d : %s]\n", mux->id, mux->name);
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
+			ret = clk_notifier_register(hw->clk, &(mux->clk_nb));
+			if (ret) {
+				pr_err("failed to register clock notifier for %s\n",
+					mux->name);
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
+		mux = &(mux_clks[i]);
+
+		hw = clk_data->onecell_data.hws[mux->id];
+
+		if (hw != NULL)
+			clk_notifier_unregister(hw->clk, &(mux->clk_nb));
+	}
+
+	/* leave clk unregister to outside if failed */
+	return ret;
+}
+
+static int __init sg2042_clk_init_clk_data(
+	struct device_node *node,
+	int num_clks,
+	struct sg2042_clk_data **pp_clk_data)
+{
+	int ret = 0;
+	struct sg2042_clk_data *clk_data = NULL;
+	struct device_node *np_syscon;
+
+	np_syscon = of_get_parent(node);
+	if (!np_syscon) {
+		pr_err("failed to get syscon node\n");
+		ret = -EINVAL;
+		goto error_out;
+	}
+
+	clk_data = kzalloc(struct_size(clk_data, onecell_data.hws, num_clks), GFP_KERNEL);
+	if (!clk_data) {
+		ret = -ENOMEM;
+		goto error_out;
+	}
+
+	clk_data->syscon = device_node_to_regmap(np_syscon);
+	if (IS_ERR_OR_NULL(clk_data->syscon)) {
+		pr_err("cannot get regmap(syscon) %ld\n", PTR_ERR(clk_data->syscon));
+		ret = -ENODEV;
+		goto cleanup;
+	}
+	clk_data->iobase = of_iomap(np_syscon, 0);
+	clk_data->onecell_data.num = num_clks;
+
+	*pp_clk_data = clk_data;
+	return ret;
+
+cleanup:
+	kfree(clk_data);
+
+error_out:
+	return ret;
+}
+
+static void __init sg2042_clk_init(struct device_node *node)
+{
+	struct sg2042_clk_data *clk_data = NULL;
+	int i, ret = 0;
+	int num_clks = 0;
+
+	num_clks = ARRAY_SIZE(sg2042_pll_clks) +
+		   ARRAY_SIZE(sg2042_div_clks) +
+		   ARRAY_SIZE(sg2042_gate_clks) +
+		   ARRAY_SIZE(sg2042_mux_clks);
+	if (num_clks == 0) {
+		ret = -EINVAL;
+		goto error_out;
+	}
+
+	ret = sg2042_clk_init_clk_data(node, num_clks, &clk_data);
+	if (ret < 0)
+		goto error_out;
+
+	ret = sg2042_clk_register_plls(clk_data, sg2042_pll_clks,
+				ARRAY_SIZE(sg2042_pll_clks));
+	if (ret)
+		goto cleanup;
+
+	ret = sg2042_clk_register_divs(clk_data, sg2042_div_clks,
+				ARRAY_SIZE(sg2042_div_clks));
+	if (ret)
+		goto cleanup;
+
+	ret = sg2042_clk_register_gates(clk_data, sg2042_gate_clks,
+				ARRAY_SIZE(sg2042_gate_clks));
+	if (ret)
+		goto cleanup;
+
+	ret = sg2042_clk_register_muxs(clk_data, sg2042_mux_clks,
+				ARRAY_SIZE(sg2042_mux_clks));
+	if (ret)
+		goto cleanup;
+
+	for (i = 0; i < num_clks; i++)
+		dbg_info("provider [%d]: %s\n", i, clk_hw_get_name(clk_data->onecell_data.hws[i]));
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, &clk_data->onecell_data);
+	if (ret)
+		goto cleanup;
+
+	return;
+
+cleanup:
+	for (i = 0; i < num_clks; i++) {
+		if (clk_data->onecell_data.hws[i] != NULL)
+			clk_hw_unregister(clk_data->onecell_data.hws[i]);
+	}
+	kfree(clk_data);
+
+error_out:
+	pr_err("%s failed error number %d\n", __func__, ret);
+}
+
+CLK_OF_DECLARE(sg2042_clk, "sophgo,sg2042-clkgen", sg2042_clk_init);
diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.h b/drivers/clk/sophgo/clk-sophgo-sg2042.h
new file mode 100644
index 000000000000..ca1c8b9a937a
--- /dev/null
+++ b/drivers/clk/sophgo/clk-sophgo-sg2042.h
@@ -0,0 +1,222 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CLK_SOPHGO_SG2042_H
+#define __CLK_SOPHGO_SG2042_H
+
+#include <linux/regmap.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#define R_PLL_STAT		0xC0
+#define R_PLL_CLKEN_CONTROL	0xC4
+#define R_MPLL_CONTROL		0xE8
+#define R_FPLL_CONTROL		0xF4
+#define R_DPLL0_CONTROL		0xF8
+#define R_DPLL1_CONTROL		0xFC
+
+#define R_CLKENREG0		0x2000
+#define R_CLKENREG1		0x2004
+#define R_CLKSELREG0		0x2020
+#define R_CLKDIVREG0		0x2040
+#define R_CLKDIVREG1		0x2044
+#define R_CLKDIVREG2		0x2048
+#define R_CLKDIVREG3		0x204C
+#define R_CLKDIVREG4		0x2050
+#define R_CLKDIVREG5		0x2054
+#define R_CLKDIVREG6		0x2058
+#define R_CLKDIVREG7		0x205C
+#define R_CLKDIVREG8		0x2060
+#define R_CLKDIVREG9		0x2064
+#define R_CLKDIVREG10		0x2068
+#define R_CLKDIVREG11		0x206C
+#define R_CLKDIVREG12		0x2070
+#define R_CLKDIVREG13		0x2074
+#define R_CLKDIVREG14		0x2078
+#define R_CLKDIVREG15		0x207C
+#define R_CLKDIVREG16		0x2080
+#define R_CLKDIVREG17		0x2084
+#define R_CLKDIVREG18		0x2088
+#define R_CLKDIVREG19		0x208C
+#define R_CLKDIVREG20		0x2090
+#define R_CLKDIVREG21		0x2094
+#define R_CLKDIVREG22		0x2098
+#define R_CLKDIVREG23		0x209C
+#define R_CLKDIVREG24		0x20A0
+#define R_CLKDIVREG25		0x20A4
+#define R_CLKDIVREG26		0x20A8
+#define R_CLKDIVREG27		0x20AC
+#define R_CLKDIVREG28		0x20B0
+#define R_CLKDIVREG29		0x20B4
+#define R_CLKDIVREG30		0x20B8
+
+#define R_RP_RXU_CLK_ENABLE	0x0368
+#define R_MP0_STATUS_REG	0x0380
+#define R_MP0_CONTROL_REG	0x0384
+#define R_MP1_STATUS_REG	0x0388
+#define R_MP1_CONTROL_REG	0x038C
+#define R_MP2_STATUS_REG	0x0390
+#define R_MP2_CONTROL_REG	0x0394
+#define R_MP3_STATUS_REG	0x0398
+#define R_MP3_CONTROL_REG	0x039C
+#define R_MP4_STATUS_REG	0x03A0
+#define R_MP4_CONTROL_REG	0x03A4
+#define R_MP5_STATUS_REG	0x03A8
+#define R_MP5_CONTROL_REG	0x03AC
+#define R_MP6_STATUS_REG	0x03B0
+#define R_MP6_CONTROL_REG	0x03B4
+#define R_MP7_STATUS_REG	0x03B8
+#define R_MP7_CONTROL_REG	0x03BC
+#define R_MP8_STATUS_REG	0x03C0
+#define R_MP8_CONTROL_REG	0x03C4
+#define R_MP9_STATUS_REG	0x03C8
+#define R_MP9_CONTROL_REG	0x03CC
+#define R_MP10_STATUS_REG	0x03D0
+#define R_MP10_CONTROL_REG	0x03D4
+#define R_MP11_STATUS_REG	0x03D8
+#define R_MP11_CONTROL_REG	0x03DC
+#define R_MP12_STATUS_REG	0x03E0
+#define R_MP12_CONTROL_REG	0x03E4
+#define R_MP13_STATUS_REG	0x03E8
+#define R_MP13_CONTROL_REG	0x03EC
+#define R_MP14_STATUS_REG	0x03F0
+#define R_MP14_CONTROL_REG	0x03F4
+#define R_MP15_STATUS_REG	0x03F8
+#define R_MP15_CONTROL_REG	0x03FC
+
+/*
+ * clock common data
+ * @iobase & @syscon: point to the same address (top of syscon), the reason
+ *  we use two different type of pointer just due to pll uses regmap while
+ *  others use iomem.
+ * @lock: clock register access lock
+ * @onecell_data: used for adding provider
+ */
+struct sg2042_clk_data {
+	void __iomem *iobase;
+	struct regmap *syscon;
+	struct clk_hw_onecell_data onecell_data;
+};
+
+/*
+ * PLL clock
+ * @id:				used to map clk_onecell_data
+ * @name:			used for print even when clk registration failed
+ * @map:			used for regmap read/write, regmap is more useful
+ *				then iomem address when we have multiple offsets
+ *				for different registers
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
+ * @lock:		spinlock to protect register access
+ * @offset_ctrl:	offset of divider control registers
+ * @shift:		shift of "Clock Divider Factor" in divider control register
+ * @width:		width of "Clock Divider Factor" in divider control register
+ * @div_flags:		private flags for this clock, not for framework-specific
+ * @initial_val:	initial value of the divider, a value < 0 means ignoring
+ *			setting of initial value.
+ * @table:		the div table that the divider supports
+ */
+struct sg2042_divider_clock {
+	struct clk_hw	hw;
+
+	/* private data */
+	unsigned int id;
+	const char *name;
+
+	void __iomem *reg;
+	spinlock_t *lock;
+
+	unsigned long offset_ctrl;
+	u8 shift;
+	u8 width;
+	u8 div_flags;
+	s32 initial_val;
+	struct clk_div_table *table;
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
+ * Gate clock
+ * @id:			used to map clk_onecell_data
+ * @name:		string of this clock name
+ * @parent_name:	string array of parents' clock name
+ * @flags:		framework-specific flags for this clock
+ * @offset_select:	offset of mux selection registers
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
+#ifdef DEBUG
+	#define dbg_info(format, arg...) \
+		pr_info("--> %s: "format"", __func__, ## arg)
+#else
+	#define dbg_info(format, arg...)
+#endif
+
+#endif /* __CLK_SOPHGO_SG2042_H */
-- 
2.25.1

