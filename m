Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52097DF5E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbjKBPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjKBPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:15 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0E184;
        Thu,  2 Nov 2023 08:12:05 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id E136283668;
        Thu,  2 Nov 2023 16:12:03 +0100 (CET)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Thu, 02 Nov 2023 16:11:07 +0100
Subject: [PATCH v7 01/10] clk: mmp: Switch to use struct u32_fract instead
 of custom one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231102-pxa1908-lkml-v7-1-cabb1a0cb52b@skole.hr>
References: <20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr>
In-Reply-To: <20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10456;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=sqxBtjyINvn8G7N2wkQVSk/v1B3ysA2Koysxb18POPo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlQ7w43Yv6bShtALLqUOTgGZ9xZ1XbQVL+J01Ms
 vZP5e/w5mCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZUO8OAAKCRCaEZ6wQi2W
 4RNHEACJpEbEwC7DEhsqO819dHKppa9ECj93d8A29xKR+vKQic/vuCi/2fjPpGcQ8ChwYaadBit
 n8oxARJbFSfymJGOgsXMTFAZRSrwmgViGWK9Yu/uTfXA9kkN05edf04x5Trt5JQwJhFjvfX5pxI
 gI/ByFnkYGZPQQ0diHt5TUmAD2XEvLYk+wMYL0zwGu/Poqakj8zi9YEoqXho2nnNvN1SuUEBrDe
 UUP4BG24CtRbk/x6yUmN6XJk7fMEtwNqModtsjuYBmGq9V8T0gqj3Yjf5BXTuR1EnyDlcYDIP8+
 Gtbw3EfUgqlA+v1uFi4dTEuBckyoVssyRriYT0jlw1NQCg323TRCRCgG6LMt7gPQ2YDmW959qmF
 TqycEbJbFK6phdYbSkpgbeWR1VcKU1rugeJa4OApcO4JdUSJ2GohB/ZKx7IBzr2ERd5U7ef8fn1
 Law71WiTYQzDI3zzZzzBXjlvs17wyvj7JJPFpa8QoEiJQzzyv3MBZ1U8i3/nhVDaGO/EoIamRNZ
 eRb+iBd1Ylb64uZPdQPeduRBFnQ+I4xLU6p/KwsUb5jD1D6xCHALGAlm0k2kZXBIu0NMHqnQIeA
 7u/b40omg9P6w8F8VUsWfr/WkgjQqPEkNiiztByqk3lBx6Jvxvmg3T6cIsb/e4oTUSa6mmRL+TQ
 US1dFmMs/VoMnfA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The struct mmp_clk_factor_tbl repeats the generic struct u32_fract.
Kill the custom one and use the generic one instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Duje Mihanović <duje.mihanovic@skole.hr>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/clk/mmp/clk-frac.c       | 57 ++++++++++++++++++++--------------------
 drivers/clk/mmp/clk-of-mmp2.c    | 26 +++++++++---------
 drivers/clk/mmp/clk-of-pxa168.c  |  4 +--
 drivers/clk/mmp/clk-of-pxa1928.c |  6 ++---
 drivers/clk/mmp/clk-of-pxa910.c  |  4 +--
 drivers/clk/mmp/clk.h            | 10 +++----
 6 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index 1b90867b60c4..6556f6ada2e8 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -26,14 +26,15 @@ static long clk_factor_round_rate(struct clk_hw *hw, unsigned long drate,
 {
 	struct mmp_clk_factor *factor = to_clk_factor(hw);
 	u64 rate = 0, prev_rate;
+	struct u32_fract *d;
 	int i;
 
 	for (i = 0; i < factor->ftbl_cnt; i++) {
-		prev_rate = rate;
-		rate = *prate;
-		rate *= factor->ftbl[i].den;
-		do_div(rate, factor->ftbl[i].num * factor->masks->factor);
+		d = &factor->ftbl[i];
 
+		prev_rate = rate;
+		rate = (u64)(*prate) * d->denominator;
+		do_div(rate, d->numerator * factor->masks->factor);
 		if (rate > drate)
 			break;
 	}
@@ -52,23 +53,22 @@ static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
 {
 	struct mmp_clk_factor *factor = to_clk_factor(hw);
 	struct mmp_clk_factor_masks *masks = factor->masks;
-	unsigned int val, num, den;
+	struct u32_fract d;
+	unsigned int val;
 	u64 rate;
 
 	val = readl_relaxed(factor->base);
 
 	/* calculate numerator */
-	num = (val >> masks->num_shift) & masks->num_mask;
+	d.numerator = (val >> masks->num_shift) & masks->num_mask;
 
 	/* calculate denominator */
-	den = (val >> masks->den_shift) & masks->den_mask;
-
-	if (!den)
+	d.denominator = (val >> masks->den_shift) & masks->den_mask;
+	if (!d.denominator)
 		return 0;
 
-	rate = parent_rate;
-	rate *= den;
-	do_div(rate, num * factor->masks->factor);
+	rate = (u64)parent_rate * d.denominator;
+	do_div(rate, d.numerator * factor->masks->factor);
 
 	return rate;
 }
@@ -82,18 +82,18 @@ static int clk_factor_set_rate(struct clk_hw *hw, unsigned long drate,
 	int i;
 	unsigned long val;
 	unsigned long flags = 0;
+	struct u32_fract *d;
 	u64 rate = 0;
 
 	for (i = 0; i < factor->ftbl_cnt; i++) {
-		rate = prate;
-		rate *= factor->ftbl[i].den;
-		do_div(rate, factor->ftbl[i].num * factor->masks->factor);
+		d = &factor->ftbl[i];
 
+		rate = (u64)prate * d->denominator;
+		do_div(rate, d->numerator * factor->masks->factor);
 		if (rate > drate)
 			break;
 	}
-	if (i > 0)
-		i--;
+	d = i ? &factor->ftbl[i - 1] : &factor->ftbl[0];
 
 	if (factor->lock)
 		spin_lock_irqsave(factor->lock, flags);
@@ -101,10 +101,10 @@ static int clk_factor_set_rate(struct clk_hw *hw, unsigned long drate,
 	val = readl_relaxed(factor->base);
 
 	val &= ~(masks->num_mask << masks->num_shift);
-	val |= (factor->ftbl[i].num & masks->num_mask) << masks->num_shift;
+	val |= (d->numerator & masks->num_mask) << masks->num_shift;
 
 	val &= ~(masks->den_mask << masks->den_shift);
-	val |= (factor->ftbl[i].den & masks->den_mask) << masks->den_shift;
+	val |= (d->denominator & masks->den_mask) << masks->den_shift;
 
 	writel_relaxed(val, factor->base);
 
@@ -118,7 +118,8 @@ static int clk_factor_init(struct clk_hw *hw)
 {
 	struct mmp_clk_factor *factor = to_clk_factor(hw);
 	struct mmp_clk_factor_masks *masks = factor->masks;
-	u32 val, num, den;
+	struct u32_fract d;
+	u32 val;
 	int i;
 	unsigned long flags = 0;
 
@@ -128,23 +129,22 @@ static int clk_factor_init(struct clk_hw *hw)
 	val = readl(factor->base);
 
 	/* calculate numerator */
-	num = (val >> masks->num_shift) & masks->num_mask;
+	d.numerator = (val >> masks->num_shift) & masks->num_mask;
 
 	/* calculate denominator */
-	den = (val >> masks->den_shift) & masks->den_mask;
+	d.denominator = (val >> masks->den_shift) & masks->den_mask;
 
 	for (i = 0; i < factor->ftbl_cnt; i++)
-		if (den == factor->ftbl[i].den && num == factor->ftbl[i].num)
+		if (d.denominator == factor->ftbl[i].denominator &&
+		    d.numerator == factor->ftbl[i].numerator)
 			break;
 
 	if (i >= factor->ftbl_cnt) {
 		val &= ~(masks->num_mask << masks->num_shift);
-		val |= (factor->ftbl[0].num & masks->num_mask) <<
-			masks->num_shift;
+		val |= (factor->ftbl[0].numerator & masks->num_mask) << masks->num_shift;
 
 		val &= ~(masks->den_mask << masks->den_shift);
-		val |= (factor->ftbl[0].den & masks->den_mask) <<
-			masks->den_shift;
+		val |= (factor->ftbl[0].denominator & masks->den_mask) << masks->den_shift;
 	}
 
 	if (!(val & masks->enable_mask) || i >= factor->ftbl_cnt) {
@@ -168,8 +168,7 @@ static const struct clk_ops clk_factor_ops = {
 struct clk *mmp_clk_register_factor(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *base,
 		struct mmp_clk_factor_masks *masks,
-		struct mmp_clk_factor_tbl *ftbl,
-		unsigned int ftbl_cnt, spinlock_t *lock)
+		struct u32_fract *ftbl, unsigned int ftbl_cnt, spinlock_t *lock)
 {
 	struct mmp_clk_factor *factor;
 	struct clk_init_data init;
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index eaad36ee323d..a4f15cee630e 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -143,9 +143,9 @@ static struct mmp_clk_factor_masks uart_factor_masks = {
 	.den_shift = 0,
 };
 
-static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
-	{.num = 8125, .den = 1536},	/*14.745MHZ */
-	{.num = 3521, .den = 689},	/*19.23MHZ */
+static struct u32_fract uart_factor_tbl[] = {
+	{ .numerator = 8125, .denominator = 1536 },	/* 14.745MHZ */
+	{ .numerator = 3521, .denominator =  689 },	/* 19.23MHZ */
 };
 
 static struct mmp_clk_factor_masks i2s_factor_masks = {
@@ -157,16 +157,16 @@ static struct mmp_clk_factor_masks i2s_factor_masks = {
 	.enable_mask = 0xd0000000,
 };
 
-static struct mmp_clk_factor_tbl i2s_factor_tbl[] = {
-	{.num = 24868, .den =  511},	/*  2.0480 MHz */
-	{.num = 28003, .den =  793},	/*  2.8224 MHz */
-	{.num = 24941, .den = 1025},	/*  4.0960 MHz */
-	{.num = 28003, .den = 1586},	/*  5.6448 MHz */
-	{.num = 31158, .den = 2561},	/*  8.1920 MHz */
-	{.num = 16288, .den = 1845},	/* 11.2896 MHz */
-	{.num = 20772, .den = 2561},	/* 12.2880 MHz */
-	{.num =  8144, .den = 1845},	/* 22.5792 MHz */
-	{.num = 10386, .den = 2561},	/* 24.5760 MHz */
+static struct u32_fract i2s_factor_tbl[] = {
+	{ .numerator = 24868, .denominator =  511 },	/*  2.0480 MHz */
+	{ .numerator = 28003, .denominator =  793 },	/*  2.8224 MHz */
+	{ .numerator = 24941, .denominator = 1025 },	/*  4.0960 MHz */
+	{ .numerator = 28003, .denominator = 1586 },	/*  5.6448 MHz */
+	{ .numerator = 31158, .denominator = 2561 },	/*  8.1920 MHz */
+	{ .numerator = 16288, .denominator = 1845 },	/* 11.2896 MHz */
+	{ .numerator = 20772, .denominator = 2561 },	/* 12.2880 MHz */
+	{ .numerator =  8144, .denominator = 1845 },	/* 22.5792 MHz */
+	{ .numerator = 10386, .denominator = 2561 },	/* 24.5760 MHz */
 };
 
 static DEFINE_SPINLOCK(acgr_lock);
diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index fb0df64cf053..ab5f83e77305 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -106,8 +106,8 @@ static struct mmp_clk_factor_masks uart_factor_masks = {
 	.den_shift = 0,
 };
 
-static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
-	{.num = 8125, .den = 1536},	/*14.745MHZ */
+static struct u32_fract uart_factor_tbl[] = {
+	{ .numerator = 8125, .denominator = 1536 },	/* 14.745MHZ */
 };
 
 static void pxa168_pll_init(struct pxa168_clk_unit *pxa_unit)
diff --git a/drivers/clk/mmp/clk-of-pxa1928.c b/drivers/clk/mmp/clk-of-pxa1928.c
index 9def4b5f10e9..ebb6e278eda3 100644
--- a/drivers/clk/mmp/clk-of-pxa1928.c
+++ b/drivers/clk/mmp/clk-of-pxa1928.c
@@ -61,9 +61,9 @@ static struct mmp_clk_factor_masks uart_factor_masks = {
 	.den_shift = 0,
 };
 
-static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
-	{.num = 832, .den = 234},	/*58.5MHZ */
-	{.num = 1, .den = 1},		/*26MHZ */
+static struct u32_fract uart_factor_tbl[] = {
+	{ .numerator = 832, .denominator = 234 },	/* 58.5MHZ */
+	{ .numerator =   1, .denominator =   1 },	/* 26MHZ */
 };
 
 static void pxa1928_pll_init(struct pxa1928_clk_unit *pxa_unit)
diff --git a/drivers/clk/mmp/clk-of-pxa910.c b/drivers/clk/mmp/clk-of-pxa910.c
index 7a38c424782e..fe65e7bdb411 100644
--- a/drivers/clk/mmp/clk-of-pxa910.c
+++ b/drivers/clk/mmp/clk-of-pxa910.c
@@ -86,8 +86,8 @@ static struct mmp_clk_factor_masks uart_factor_masks = {
 	.den_shift = 0,
 };
 
-static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
-	{.num = 8125, .den = 1536},	/*14.745MHZ */
+static struct u32_fract uart_factor_tbl[] = {
+	{ .numerator = 8125, .denominator = 1536 },	/* 14.745MHZ */
 };
 
 static void pxa910_pll_init(struct pxa910_clk_unit *pxa_unit)
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 55ac05379781..c83cec169ddc 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -3,6 +3,7 @@
 #define __MACH_MMP_CLK_H
 
 #include <linux/clk-provider.h>
+#include <linux/math.h>
 #include <linux/pm_domain.h>
 #include <linux/clkdev.h>
 
@@ -20,16 +21,11 @@ struct mmp_clk_factor_masks {
 	unsigned int enable_mask;
 };
 
-struct mmp_clk_factor_tbl {
-	unsigned int num;
-	unsigned int den;
-};
-
 struct mmp_clk_factor {
 	struct clk_hw hw;
 	void __iomem *base;
 	struct mmp_clk_factor_masks *masks;
-	struct mmp_clk_factor_tbl *ftbl;
+	struct u32_fract *ftbl;
 	unsigned int ftbl_cnt;
 	spinlock_t *lock;
 };
@@ -37,7 +33,7 @@ struct mmp_clk_factor {
 extern struct clk *mmp_clk_register_factor(const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *base, struct mmp_clk_factor_masks *masks,
-		struct mmp_clk_factor_tbl *ftbl, unsigned int ftbl_cnt,
+		struct u32_fract *ftbl, unsigned int ftbl_cnt,
 		spinlock_t *lock);
 
 /* Clock type "mix" */

-- 
2.42.0


