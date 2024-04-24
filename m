Return-Path: <linux-kernel+bounces-157546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B935B8B12BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2E01C23A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5DD3C087;
	Wed, 24 Apr 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAWtzfDb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751811EA84;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984157; cv=none; b=rnrZYBcB/ckLGezIVQvAGmHebGQiUwpo+Dm9xamvsSEg3io/HPDrUjOcNoVAnwT+GK9iEmWyHpc4ttH6bnqb/aRDsN2PTQVEOBFmB73tbmiVVbjUf/QEJqjhwmyXfSzxbiM2kpXq8gahNr6ELozEiFa70jlOTXSQvK5JARBZv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984157; c=relaxed/simple;
	bh=whO/XxDwr7gJpNQE/+XH4l3BnuoAP711UtZ/w1lT+Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TM0BHqbw2aKF/ow2d+TH+l1T7p25r2wgcx3A2Ek2UHYXdA9eJ6F/2+cZr0d0O08TI2zz1uuPRQv2GIXMuP8imPoeIYnpEoy1KIgHsUY+7A4FJJcBdgGHCiBs4s/t0j/6eckg8xfVDENeanVY9jsIGi5abGw+tX/DcnwFFTYzVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAWtzfDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19C79C4AF07;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984157;
	bh=whO/XxDwr7gJpNQE/+XH4l3BnuoAP711UtZ/w1lT+Pk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qAWtzfDbBlht4z9ZPKZfI3/a52r/TgLjoZLyEkc2g0yTaLbgF4Y3F+BRikTVADTYD
	 6Y8bcWuUfaGRnW4PfC/qyHbEq0bz/4phLnep7oYpBWQvn8QqGunVsIEu781ynRWZjA
	 ty05AhkUdDd9t9PC/wkaUzA+AHaSlUpyG47pr0smi/NFNRyu1QpB2TPSrt2j1X4/yj
	 4Ypg2mLOA/oP9FtNiUQ/EwfGbxPCatk+DMNUsiHp99D1C6/K5lz7G0Juj+4rQUHH7h
	 +MUqRrUTgUrUo/aAYy3exPnt5pjpfuRfFjkFb0NyXP0F8jdfwRyoCy4KAcuwm9muJ4
	 xVci0mm/3xfRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E7C4345F;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 24 Apr 2024 20:42:35 +0200
Subject: [PATCH v10 08/12] clk: mmp: Add Marvell PXA1908 MPMU driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-pxa1908-lkml-v10-8-36cdfb5841f9@skole.hr>
References: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
In-Reply-To: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4933;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=MIVdNTKAY9OVH9IjklU845Z4UdR/PDrcCquAbJJe6OI=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmKVKV6ER5Biz8/HXsJ7iCUice5Eb/BGs66g8QA
 YnXQbEanKiJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZilSlQAKCRCaEZ6wQi2W
 4QpHD/9QJqww9J/LLRGG0VZNWEgsqm8xDUUUnJsa3Pqs0sXnP+DRdQUpvKrpG2nfR5xqtVe6Bb8
 czjHHdzQV6kX53FFuknNilkTt7XZOGiJrLNy7xa4v69EvNiiaLi2JbjSI5sUv0gqdFJ+3jZ4iyw
 J3X4f2tjHmiLyMkPPKsmDcPNQbgKiSuCttmOSSQYO53Tbg/g8gIuCz+wfEj5mgT+xt8HeCHnTQx
 ibm32ueEYOreQQXkOt4bCGo6SyFKe2yV8FIRQr0d8xUQ5geYgi334xjibVojIq4zklsURM7bfpw
 E15W4EnhP2q/Auc3gPT8SWW4+urqgHb7z2fuRGpeXen4TMW0JVG0FK7YzpD4nY1FrbiER19dc1H
 Qdzr6+E7zw8Sz9l6j5i+rHOyTy9eq1XnThF/OrtXqas7hCePTwTnEhWFzYbfn7vRaKXqMVI1Zqt
 WBPdLUAQi4Ss9J78eCys4405g3a+baGlwlapWVgZl7AbnsteqYepigjuNXQhaDOfWSTXzAqi9hL
 Zrat5KZ3bbe1QYIL5/vn2UtSnL2WFYz/fs+9CsPLcLAU3ikO2MYf9hYdys3C5wUAM/8Aqqih0Vt
 qJFXnbsEHK8WedSM/Epf3OdTy2c8CgHBrLQo+RA6AyO1sAdoc6J760+k1HMpOjD87EWXM7FClym
 jHQn/SoJQtJWM+w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/default with
 auth_id=112
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add driver for the MPMU controller block on Marvell's PXA1908 SoC. The
driver is incomplete, currently only supporting the fixed PLL1; dynamic
PLLs 2-4 and CPU/DDR/AXI clock support is missing.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/clk/mmp/Makefile           |   2 +-
 drivers/clk/mmp/clk-pxa1908-mpmu.c | 112 +++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index a8b1a4b08824..062cd87fa8dd 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
 obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
 obj-$(CONFIG_COMMON_CLK_MMP2_AUDIO) += clk-audio.o
 
-obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-pxa1908-apbc.o clk-pxa1908-apbcp.o clk-pxa1908-apmu.o
+obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-pxa1908-apbc.o clk-pxa1908-apbcp.o clk-pxa1908-apmu.o clk-pxa1908-mpmu.o
diff --git a/drivers/clk/mmp/clk-pxa1908-mpmu.c b/drivers/clk/mmp/clk-pxa1908-mpmu.c
new file mode 100644
index 000000000000..e3337bacaadd
--- /dev/null
+++ b/drivers/clk/mmp/clk-pxa1908-mpmu.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/units.h>
+
+#include <dt-bindings/clock/marvell,pxa1908.h>
+
+#include "clk.h"
+
+#define MPMU_UART_PLL		0x14
+
+#define MPMU_NR_CLKS		39
+
+struct pxa1908_clk_unit {
+	struct mmp_clk_unit unit;
+	void __iomem *base;
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
+static struct u32_fract uart_factor_tbl[] = {
+	{.numerator = 8125, .denominator = 1536},	/* 14.745MHz */
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
+			pxa_unit->base + MPMU_UART_PLL,
+			&uart_factor_masks, uart_factor_tbl,
+			ARRAY_SIZE(uart_factor_tbl), NULL);
+}
+
+static int pxa1908_mpmu_probe(struct platform_device *pdev)
+{
+	struct pxa1908_clk_unit *pxa_unit;
+
+	pxa_unit = devm_kzalloc(&pdev->dev, sizeof(*pxa_unit), GFP_KERNEL);
+	if (IS_ERR(pxa_unit))
+		return PTR_ERR(pxa_unit);
+
+	pxa_unit->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pxa_unit->base))
+		return PTR_ERR(pxa_unit->base);
+
+	mmp_clk_init(pdev->dev.of_node, &pxa_unit->unit, MPMU_NR_CLKS);
+
+	pxa1908_pll_init(pxa_unit);
+
+	return 0;
+}
+
+static const struct of_device_id pxa1908_mpmu_match_table[] = {
+	{ .compatible = "marvell,pxa1908-mpmu" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pxa1908_mpmu_match_table);
+
+static struct platform_driver pxa1908_mpmu_driver = {
+	.probe = pxa1908_mpmu_probe,
+	.driver = {
+		.name = "pxa1908-mpmu",
+		.of_match_table = pxa1908_mpmu_match_table
+	}
+};
+module_platform_driver(pxa1908_mpmu_driver);
+
+MODULE_AUTHOR("Duje Mihanović <duje.mihanovic@skole.hr>");
+MODULE_DESCRIPTION("Marvell PXA1908 MPMU Clock Driver");
+MODULE_LICENSE("GPL");

-- 
2.44.0



