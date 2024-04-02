Return-Path: <linux-kernel+bounces-128699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FC895E5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901A7B25025
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D17B15ECFB;
	Tue,  2 Apr 2024 21:03:15 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CE79DD4;
	Tue,  2 Apr 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091794; cv=none; b=Tc56ErObf3ul8CKlVWFXnQYaW1t/LCCSbL53iWPJnf+76kpUF/+NNKuM3BS4YH9Wf5/3QWlG5Sqj/G1hjiGfLMgx6ukOc41i7/BcPXBeOnLxSjjP7rBnV9S3q/OGTwVRcxtgYOEs4aUZwsdDEte1RyFBLEFqQCfphQXz79gx6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091794; c=relaxed/simple;
	bh=GKxSVHl41N3PI8aUaTk6GbH7PZMe9l+sFayphAmGjVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZsEDUhiaG18OSDX0ubfsuz8rNYy3ZDenuLPtcecZ1kqEbBrCDm04cz7428L6w8sbYqlQjzTZimfDkKebq0keP/654FSnIrhIRpKWNJXg6ZEHewIs3h1CE5/R+byihlAfkcDL0rKsmuYqNxulcu38yIyqRKIbWfmfd18RIKi+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id E059387FFA;
	Tue,  2 Apr 2024 22:55:51 +0200 (CEST)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 02 Apr 2024 22:55:41 +0200
Subject: [PATCH v9 5/9] clk: mmp: Add Marvell PXA1908 clock driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240402-pxa1908-lkml-v9-5-25a003e83c6f@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
In-Reply-To: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Rob Herring <robh@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13438;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=GKxSVHl41N3PI8aUaTk6GbH7PZMe9l+sFayphAmGjVs=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmDHDNh6Ka+INvVk3b264qx3QL3yXH2kyRcz0v/
 i58bempi3iJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZgxwzQAKCRCaEZ6wQi2W
 4e6FD/9a/E3n/O9GgsUvAR4VVjRAkLslHbJ2BWgYqrqMcMIzdRn8M10yMHwRm17FWcaU/s0kVWl
 pqrlcjpZmbN0dRC5TWRexou+poV5fjC9ryrNXhk5gEmJpqiikzkS8WUJQ7gzvAYuWRe+rqTtaQx
 l+5ERNWSEEWlJIH1YyI7/v9FVjHYJw6Euley3PD4DK4Zwhia5IvD4TjFMBXUd7UXfnhqAIQZLyx
 n8HCHj217euyHQdthqqPvU0RKAZNZk0mWQm+pHqFCmQP7RSi7qw6zHjVzbfRWWMVoADfiwvTk/7
 FUT7sJlLlQasifLsISOjiqfo2vhsglziTjZDI07EmhMvPk7xAOGpaeVT8ikEXvvXbI2HaabWHtu
 /q4RphowbrZaOGDKCoo9dszYQ0NR+8hobp054WLcPzRrA+F9hsN4rBTKKXU14tJMGayQ+WVAqE1
 lYuLvzJzoPZlu/jg3i0kKmTUZ5/GPl1lV2Vel55bAZEOqSf5/mTwZYqZyjthDzEqEqmhfGbbR0W
 znlDoWpvTr7aT3ebpmrfoIYFbv63t4dn9qxWqMkztk/sLHvtDVXLpq6f1X0pr3RGr4kdA9qqzPX
 z5+Sspu3zxvrtCEGEMSkf7SgaugL1c9/U+AczwDzMU2ARcXozr9kF14Q/Nqsh68KKnUoxqvOIiR
 cUx1R4ttY9cOGFA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Add driver for Marvell PXA1908 clock controller blocks. The SoC has
numerous clock controller blocks, currently supporting APBC, APBCP, MPMU
and APMU.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/clk/mmp/Makefile         |   2 +-
 drivers/clk/mmp/clk-of-pxa1908.c | 328 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 441bf83080a1..69f9c3afde83 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
 obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
 obj-$(CONFIG_COMMON_CLK_MMP2_AUDIO) += clk-audio.o
 
-obj-y += clk-of-pxa1928.o
+obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-of-pxa1908.o
diff --git a/drivers/clk/mmp/clk-of-pxa1908.c b/drivers/clk/mmp/clk-of-pxa1908.c
new file mode 100644
index 000000000000..6f1f6e25a718
--- /dev/null
+++ b/drivers/clk/mmp/clk-of-pxa1908.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/units.h>
+
+#include <dt-bindings/clock/marvell,pxa1908.h>
+
+#include "clk.h"
+
+#define APMU_CLK_GATE_CTRL	0x40
+#define MPMU_UART_PLL		0x14
+
+#define APBC_UART0		0x0
+#define APBC_UART1		0x4
+#define APBC_GPIO		0x8
+#define APBC_PWM0		0xc
+#define APBC_PWM1		0x10
+#define APBC_PWM2		0x14
+#define APBC_PWM3		0x18
+#define APBC_SSP0		0x1c
+#define APBC_SSP1		0x20
+#define APBC_IPC_RST		0x24
+#define APBC_RTC		0x28
+#define APBC_TWSI0		0x2c
+#define APBC_KPC		0x30
+#define APBC_SWJTAG		0x40
+#define APBC_SSP2		0x4c
+#define APBC_TWSI1		0x60
+#define APBC_THERMAL		0x6c
+#define APBC_TWSI3		0x70
+
+#define APBCP_UART2		0x1c
+#define APBCP_TWSI2		0x28
+#define APBCP_AICER		0x38
+
+#define APMU_CCIC1		0x24
+#define APMU_ISP		0x38
+#define APMU_DSI1		0x44
+#define APMU_DISP1		0x4c
+#define APMU_CCIC0		0x50
+#define APMU_SDH0		0x54
+#define APMU_SDH1		0x58
+#define APMU_USB		0x5c
+#define APMU_NF			0x60
+#define APMU_VPU		0xa4
+#define APMU_GC			0xcc
+#define APMU_SDH2		0xe0
+#define APMU_GC2D		0xf4
+#define APMU_TRACE		0x108
+#define APMU_DVC_DFC_DEBUG	0x140
+
+#define MPMU_NR_CLKS		39
+#define APBC_NR_CLKS		19
+#define APBCP_NR_CLKS		4
+#define APMU_NR_CLKS		17
+
+struct pxa1908_clk_unit {
+	struct mmp_clk_unit unit;
+	void __iomem *mpmu_base;
+	void __iomem *apmu_base;
+	void __iomem *apbc_base;
+	void __iomem *apbcp_base;
+	void __iomem *apbs_base;
+	void __iomem *ciu_base;
+};
+
+static struct mmp_param_fixed_rate_clk fixed_rate_clks[] = {
+	{PXA1908_CLK_CLK32, "clk32", NULL, 0, 32768},
+	{PXA1908_CLK_VCTCXO, "vctcxo", NULL, 0, 26 * HZ_PER_MHZ},
+	{PXA1908_CLK_PLL1_624, "pll1_624", NULL, 0, 624 * HZ_PER_MHZ},
+	{PXA1908_CLK_PLL1_416, "pll1_416", NULL, 0, 416 * HZ_PER_MHZ},
+	{PXA1908_CLK_PLL1_499, "pll1_499", NULL, 0, 499 * HZ_PER_MHZ},
+	{PXA1908_CLK_PLL1_832, "pll1_832", NULL, 0, 832 * HZ_PER_MHZ},
+	{PXA1908_CLK_PLL1_1248, "pll1_1248", NULL, 0, 1248 * HZ_PER_MHZ},
+};
+
+static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
+	{PXA1908_CLK_PLL1_D2, "pll1_d2", "pll1_624", 1, 2, 0},
+	{PXA1908_CLK_PLL1_D4, "pll1_d4", "pll1_d2", 1, 2, 0},
+	{PXA1908_CLK_PLL1_D6, "pll1_d6", "pll1_d2", 1, 3, 0},
+	{PXA1908_CLK_PLL1_D8, "pll1_d8", "pll1_d4", 1, 2, 0},
+	{PXA1908_CLK_PLL1_D12, "pll1_d12", "pll1_d6", 1, 2, 0},
+	{PXA1908_CLK_PLL1_D13, "pll1_d13", "pll1_624", 1, 13, 0},
+	{PXA1908_CLK_PLL1_D16, "pll1_d16", "pll1_d8", 1, 2, 0},
+	{PXA1908_CLK_PLL1_D24, "pll1_d24", "pll1_d12", 1, 2, 0},
+	{PXA1908_CLK_PLL1_D48, "pll1_d48", "pll1_d24", 1, 2, 0},
+	{PXA1908_CLK_PLL1_D96, "pll1_d96", "pll1_d48", 1, 2, 0},
+	{PXA1908_CLK_PLL1_32, "pll1_32", "pll1_d13", 2, 3, 0},
+	{PXA1908_CLK_PLL1_208, "pll1_208", "pll1_d2", 2, 3, 0},
+	{PXA1908_CLK_PLL1_117, "pll1_117", "pll1_624", 3, 16, 0},
+};
+
+static struct mmp_clk_factor_masks uart_factor_masks = {
+	.factor = 2,
+	.num_mask = GENMASK(12, 0),
+	.den_mask = GENMASK(12, 0),
+	.num_shift = 16,
+	.den_shift = 0,
+};
+
+static struct u32_fract uart_factor_tbl[] = {
+	{.numerator = 8125, .denominator = 1536},	/* 14.745MHz */
+};
+
+static DEFINE_SPINLOCK(pll1_lock);
+static struct mmp_param_general_gate_clk pll1_gate_clks[] = {
+	{PXA1908_CLK_PLL1_D2_GATE, "pll1_d2_gate", "pll1_d2", 0, APMU_CLK_GATE_CTRL, 29, 0, &pll1_lock},
+	{PXA1908_CLK_PLL1_416_GATE, "pll1_416_gate", "pll1_416", 0, APMU_CLK_GATE_CTRL, 27, 0, &pll1_lock},
+	{PXA1908_CLK_PLL1_624_GATE, "pll1_624_gate", "pll1_624", 0, APMU_CLK_GATE_CTRL, 26, 0, &pll1_lock},
+	{PXA1908_CLK_PLL1_832_GATE, "pll1_832_gate", "pll1_832", 0, APMU_CLK_GATE_CTRL, 30, 0, &pll1_lock},
+	{PXA1908_CLK_PLL1_1248_GATE, "pll1_1248_gate", "pll1_1248", 0, APMU_CLK_GATE_CTRL, 28, 0, &pll1_lock},
+};
+
+static void pxa1908_pll_init(struct pxa1908_clk_unit *pxa_unit)
+{
+	struct mmp_clk_unit *unit = &pxa_unit->unit;
+
+	mmp_register_fixed_rate_clks(unit, fixed_rate_clks,
+					ARRAY_SIZE(fixed_rate_clks));
+
+	mmp_register_fixed_factor_clks(unit, fixed_factor_clks,
+					ARRAY_SIZE(fixed_factor_clks));
+
+	mmp_clk_register_factor("uart_pll", "pll1_d4",
+			CLK_SET_RATE_PARENT,
+			pxa_unit->mpmu_base + MPMU_UART_PLL,
+			&uart_factor_masks, uart_factor_tbl,
+			ARRAY_SIZE(uart_factor_tbl), NULL);
+
+}
+
+static DEFINE_SPINLOCK(pwm0_lock);
+static DEFINE_SPINLOCK(pwm2_lock);
+
+static DEFINE_SPINLOCK(uart0_lock);
+static DEFINE_SPINLOCK(uart1_lock);
+static DEFINE_SPINLOCK(uart2_lock);
+
+static const char * const uart_parent_names[] = {"pll1_117", "uart_pll"};
+static const char * const ssp_parent_names[] = {"pll1_d16", "pll1_d48", "pll1_d24", "pll1_d12"};
+
+static struct mmp_param_gate_clk apbc_gate_clks[] = {
+	{PXA1908_CLK_TWSI0, "twsi0_clk", "pll1_32", CLK_SET_RATE_PARENT, APBC_TWSI0, 0x7, 3, 0, 0, NULL},
+	{PXA1908_CLK_TWSI1, "twsi1_clk", "pll1_32", CLK_SET_RATE_PARENT, APBC_TWSI1, 0x7, 3, 0, 0, NULL},
+	{PXA1908_CLK_TWSI3, "twsi3_clk", "pll1_32", CLK_SET_RATE_PARENT, APBC_TWSI3, 0x7, 3, 0, 0, NULL},
+	{PXA1908_CLK_GPIO, "gpio_clk", "vctcxo", CLK_SET_RATE_PARENT, APBC_GPIO, 0x7, 3, 0, 0, NULL},
+	{PXA1908_CLK_KPC, "kpc_clk", "clk32", CLK_SET_RATE_PARENT, APBC_KPC, 0x7, 3, 0, MMP_CLK_GATE_NEED_DELAY, NULL},
+	{PXA1908_CLK_RTC, "rtc_clk", "clk32", CLK_SET_RATE_PARENT, APBC_RTC, 0x87, 0x83, 0, MMP_CLK_GATE_NEED_DELAY, NULL},
+	{PXA1908_CLK_PWM0, "pwm0_clk", "pwm01_apb_share", CLK_SET_RATE_PARENT, APBC_PWM0, 0x2, 2, 0, 0, &pwm0_lock},
+	{PXA1908_CLK_PWM1, "pwm1_clk", "pwm01_apb_share", CLK_SET_RATE_PARENT, APBC_PWM1, 0x6, 2, 0, 0, NULL},
+	{PXA1908_CLK_PWM2, "pwm2_clk", "pwm23_apb_share", CLK_SET_RATE_PARENT, APBC_PWM2, 0x2, 2, 0, 0, NULL},
+	{PXA1908_CLK_PWM3, "pwm3_clk", "pwm23_apb_share", CLK_SET_RATE_PARENT, APBC_PWM3, 0x6, 2, 0, 0, NULL},
+	{PXA1908_CLK_UART0, "uart0_clk", "uart0_mux", CLK_SET_RATE_PARENT, APBC_UART0, 0x7, 3, 0, 0, &uart0_lock},
+	{PXA1908_CLK_UART1, "uart1_clk", "uart1_mux", CLK_SET_RATE_PARENT, APBC_UART1, 0x7, 3, 0, 0, &uart1_lock},
+};
+
+static struct mmp_param_mux_clk apbc_mux_clks[] = {
+	{0, "uart0_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, APBC_UART0, 4, 3, 0, &uart0_lock},
+	{0, "uart1_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, APBC_UART1, 4, 3, 0, &uart1_lock},
+	{0, "ssp0_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), 0, APBC_SSP0, 4, 3, 0, NULL},
+	{0, "ssp2_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), 0, APBC_SSP2, 4, 3, 0, NULL},
+};
+
+static void pxa1908_apb_periph_clk_init(struct pxa1908_clk_unit *pxa_unit)
+{
+	struct mmp_clk_unit *unit = &pxa_unit->unit;
+
+	mmp_clk_register_gate(NULL, "pwm01_apb_share", "pll1_d48",
+			CLK_SET_RATE_PARENT,
+			pxa_unit->apbc_base + APBC_PWM0,
+			0x5, 1, 0, 0, &pwm0_lock);
+	mmp_clk_register_gate(NULL, "pwm23_apb_share", "pll1_d48",
+			CLK_SET_RATE_PARENT,
+			pxa_unit->apbc_base + APBC_PWM2,
+			0x5, 1, 0, 0, &pwm2_lock);
+	mmp_register_mux_clks(unit, apbc_mux_clks, pxa_unit->apbc_base,
+			ARRAY_SIZE(apbc_mux_clks));
+	mmp_register_gate_clks(unit, apbc_gate_clks, pxa_unit->apbc_base,
+			ARRAY_SIZE(apbc_gate_clks));
+}
+
+static struct mmp_param_gate_clk apbcp_gate_clks[] = {
+	{PXA1908_CLK_UART2, "uart2_clk", "uart2_mux", CLK_SET_RATE_PARENT, APBCP_UART2, 0x7, 0x3, 0x0, 0, &uart2_lock},
+	{PXA1908_CLK_TWSI2, "twsi2_clk", "pll1_32", CLK_SET_RATE_PARENT, APBCP_TWSI2, 0x7, 0x3, 0x0, 0, NULL},
+	{PXA1908_CLK_AICER, "ripc_clk", NULL, 0, APBCP_AICER, 0x7, 0x2, 0x0, 0, NULL},
+};
+
+static struct mmp_param_mux_clk apbcp_mux_clks[] = {
+	{0, "uart2_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, APBCP_UART2, 4, 3, 0, &uart2_lock},
+};
+
+static void pxa1908_apb_p_periph_clk_init(struct pxa1908_clk_unit *pxa_unit)
+{
+	struct mmp_clk_unit *unit = &pxa_unit->unit;
+
+	mmp_register_mux_clks(unit, apbcp_mux_clks, pxa_unit->apbcp_base,
+			ARRAY_SIZE(apbcp_mux_clks));
+	mmp_register_gate_clks(unit, apbcp_gate_clks, pxa_unit->apbcp_base,
+			ARRAY_SIZE(apbcp_gate_clks));
+}
+
+static DEFINE_SPINLOCK(sdh0_lock);
+static DEFINE_SPINLOCK(sdh1_lock);
+static DEFINE_SPINLOCK(sdh2_lock);
+
+static const char * const sdh_parent_names[] = {"pll1_416", "pll1_624"};
+
+static struct mmp_clk_mix_config sdh_mix_config = {
+	.reg_info = DEFINE_MIX_REG_INFO(3, 8, 2, 6, 11),
+};
+
+static struct mmp_param_gate_clk apmu_gate_clks[] = {
+	{PXA1908_CLK_USB, "usb_clk", NULL, 0, APMU_USB, 0x9, 0x9, 0x1, 0, NULL},
+	{PXA1908_CLK_SDH0, "sdh0_clk", "sdh0_mix_clk", CLK_SET_RATE_PARENT | CLK_SET_RATE_UNGATE, APMU_SDH0, 0x12, 0x12, 0x0, 0, &sdh0_lock},
+	{PXA1908_CLK_SDH1, "sdh1_clk", "sdh1_mix_clk", CLK_SET_RATE_PARENT | CLK_SET_RATE_UNGATE, APMU_SDH1, 0x12, 0x12, 0x0, 0, &sdh1_lock},
+	{PXA1908_CLK_SDH2, "sdh2_clk", "sdh2_mix_clk", CLK_SET_RATE_PARENT | CLK_SET_RATE_UNGATE, APMU_SDH2, 0x12, 0x12, 0x0, 0, &sdh2_lock}
+};
+
+static void pxa1908_axi_periph_clk_init(struct pxa1908_clk_unit *pxa_unit)
+{
+	struct mmp_clk_unit *unit = &pxa_unit->unit;
+
+	mmp_register_general_gate_clks(unit, pll1_gate_clks,
+			pxa_unit->apmu_base, ARRAY_SIZE(pll1_gate_clks));
+
+	sdh_mix_config.reg_info.reg_clk_ctrl = pxa_unit->apmu_base + APMU_SDH0;
+	mmp_clk_register_mix(NULL, "sdh0_mix_clk", sdh_parent_names,
+			ARRAY_SIZE(sdh_parent_names), CLK_SET_RATE_PARENT,
+			&sdh_mix_config, &sdh0_lock);
+	sdh_mix_config.reg_info.reg_clk_ctrl = pxa_unit->apmu_base + APMU_SDH1;
+	mmp_clk_register_mix(NULL, "sdh1_mix_clk", sdh_parent_names,
+			ARRAY_SIZE(sdh_parent_names), CLK_SET_RATE_PARENT,
+			&sdh_mix_config, &sdh1_lock);
+	sdh_mix_config.reg_info.reg_clk_ctrl = pxa_unit->apmu_base + APMU_SDH2;
+	mmp_clk_register_mix(NULL, "sdh2_mix_clk", sdh_parent_names,
+			ARRAY_SIZE(sdh_parent_names), CLK_SET_RATE_PARENT,
+			&sdh_mix_config, &sdh2_lock);
+
+	mmp_register_gate_clks(unit, apmu_gate_clks, pxa_unit->apmu_base,
+			ARRAY_SIZE(apmu_gate_clks));
+}
+
+static void __init pxa1908_apbc_clk_init(struct device_node *np)
+{
+	struct pxa1908_clk_unit *pxa_unit;
+
+	pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
+	if (!pxa_unit)
+		return;
+
+	pxa_unit->apbc_base = of_iomap(np, 0);
+	if (!pxa_unit->apbc_base) {
+		pr_err("failed to map apbc registers\n");
+		kfree(pxa_unit);
+		return;
+	}
+
+	mmp_clk_init(np, &pxa_unit->unit, APBC_NR_CLKS);
+
+	pxa1908_apb_periph_clk_init(pxa_unit);
+}
+CLK_OF_DECLARE(pxa1908_apbc, "marvell,pxa1908-apbc", pxa1908_apbc_clk_init);
+
+static void __init pxa1908_apbcp_clk_init(struct device_node *np)
+{
+	struct pxa1908_clk_unit *pxa_unit;
+
+	pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
+	if (!pxa_unit)
+		return;
+
+	pxa_unit->apbcp_base = of_iomap(np, 0);
+	if (!pxa_unit->apbcp_base) {
+		pr_err("failed to map apbcp registers\n");
+		kfree(pxa_unit);
+		return;
+	}
+
+	mmp_clk_init(np, &pxa_unit->unit, APBCP_NR_CLKS);
+
+	pxa1908_apb_p_periph_clk_init(pxa_unit);
+}
+CLK_OF_DECLARE(pxa1908_apbcp, "marvell,pxa1908-apbcp", pxa1908_apbcp_clk_init);
+
+static void __init pxa1908_mpmu_clk_init(struct device_node *np)
+{
+	struct pxa1908_clk_unit *pxa_unit;
+
+	pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
+	if (!pxa_unit)
+		return;
+
+	pxa_unit->mpmu_base = of_iomap(np, 0);
+	if (!pxa_unit->mpmu_base) {
+		pr_err("failed to map mpmu registers\n");
+		kfree(pxa_unit);
+		return;
+	}
+
+	mmp_clk_init(np, &pxa_unit->unit, MPMU_NR_CLKS);
+
+	pxa1908_pll_init(pxa_unit);
+}
+CLK_OF_DECLARE(pxa1908_mpmu, "marvell,pxa1908-mpmu", pxa1908_mpmu_clk_init);
+
+static void __init pxa1908_apmu_clk_init(struct device_node *np)
+{
+	struct pxa1908_clk_unit *pxa_unit;
+
+	pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
+	if (!pxa_unit)
+		return;
+
+	pxa_unit->apmu_base = of_iomap(np, 0);
+	if (!pxa_unit->apmu_base) {
+		pr_err("failed to map apmu registers\n");
+		kfree(pxa_unit);
+		return;
+	}
+
+	mmp_clk_init(np, &pxa_unit->unit, APMU_NR_CLKS);
+
+	pxa1908_axi_periph_clk_init(pxa_unit);
+}
+CLK_OF_DECLARE(pxa1908_apmu, "marvell,pxa1908-apmu", pxa1908_apmu_clk_init);

-- 
2.44.0



