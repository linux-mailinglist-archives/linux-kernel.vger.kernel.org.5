Return-Path: <linux-kernel+bounces-157545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE28B12B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A151F24FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E33BBF3;
	Wed, 24 Apr 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9sC9ttG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D121E531;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984157; cv=none; b=E4vPH3R72Gbsuj2Z/zDcQmWvUYqLYTo8BgXvepe4iKMwp5+hWG+ux+AmhmYZLB2ag0REIFIKwWO2OyZT5Urw9vkFkOUcuVuRAFm1ceTq81uIUXzf8Ep4xpvrCwdXfY09j8wK3wm1YMn/zl85Z06O721QvkiqYeesP5gvGopdfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984157; c=relaxed/simple;
	bh=MPYzPLFc+E4qcsMha5Vki6lijhYY47basZ7H6LtDB4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBRiIESiHJiZWr1Fwq7O+YA8ATFyZ7sVFRAMb8dwbd8nTtBPCdQjzadE2SNtFfeI/xwxGkyYZUMtZnDimTdaC3JuvP+OiXWHPBPUCsk47LA30TFjnjf2klb2+IQVcs7bH1ACLRUpNMMBRXF0yn9QAv1juzcWJGopGYy2wTMpTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9sC9ttG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC76DC4AF51;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984156;
	bh=MPYzPLFc+E4qcsMha5Vki6lijhYY47basZ7H6LtDB4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A9sC9ttGvhQPQF1qqi3DA/G3uCCCd4pbjWs+7KsmKrYPjZO6iZ/bP/rev8/W3/qDp
	 3wObMvzJrcTmSr3cfXMc9baFfHGlVNqnA4qXKcVYMPkQaqeRhwHHHlO9390cazk0su
	 PEEm02sBtrmW3VMh5un0Gd0IyB8qPvSpLFn3xTK6kBpwROeyQUgn1qibbGh0Ee7zUH
	 xI29XK9297qzEuhB4BV2F1QUXbwukRm895YBc2tEctjGs9muSWoyV+sEJrtmbkeQD/
	 srvF6Jv9DXQFqLz7gO1IghEhXcBaO90yDZfv5ukto9MdR9LYmZ3wmFKRGO/WGYaXlr
	 sPFy5PdX2Q/1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE751C4345F;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 24 Apr 2024 20:42:33 +0200
Subject: [PATCH v10 06/12] clk: mmp: Add Marvell PXA1908 APBCP driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-pxa1908-lkml-v10-6-36cdfb5841f9@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3684;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=DwulIPxd/+HN8QJZqhj7kppSzA5y+2rXqI0LiVhzZmU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmKVKUhwmvy+/dGu4d2gwEzxNMuvNqqiInz2Tbe
 +CpDX1oP3WJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZilSlAAKCRCaEZ6wQi2W
 4SJvEACeLqxJjtAb6V8VAVjSHcRaafwkrJs8sD6KUbXSyisN/DCII0KYsZZjsNoEzZcZ/WaqYEH
 OOUnY0YFuZvUoln4te3I4Nv1M9JxTtBE6w5h9+270TMY8OVszxoOIN2YMgivHUYVHJOCmNgx0Xu
 mJAnTGYRNaipRiHXOttdbMlIwdfBZoaH4i76EkkWk4SDkrRA9W7lrElio54BxDckrmIE9zwAdTa
 Lo65V2I/DLLqtd171Zn96hS2CoLyjcQIDyOZxVB8aVvca1NFO+lOw863BOTvGa/Er3p1RoJOByy
 54mU6bgDHm+bAwWSkEf4CqRTaFDZiNTQM+x6JSzwLAi3EiYgW07XwUoGtV7OUg4Lu1Fl7vTM4X8
 stoEqw106lpoztTD6UjOR7oLaeDA416GQxSHrYfIUt1C1XQrvObUjGqnXdX7A2/YGjVWNEmv44P
 bqBACJfzBZoj0cGK5vObKOtwOi0stl1Gf6632CH8SuTDBpx0ohy/v+zimEgmcq5rM6CbEMpAgn7
 ikPUS4q3AC/a8YgdTHx+yVuT7ZIHL5loOQnOKwKvDmV7kEHvnfA3N1a67U6tHNCmh/TOEbY9isc
 ErqiBiydIrZBNgNRH0wJT9lVXRXGQ+BIVo/yafM57K3XSkgSZoiE/EFdlvZEQff8SmQt9XzyTsA
 NsAaM44HOg8H81Q==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/default with
 auth_id=112
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add driver for the APBCP controller block found on Marvell's PXA1908
SoC.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/clk/mmp/Makefile            |  2 +-
 drivers/clk/mmp/clk-pxa1908-apbcp.c | 84 +++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 685bb80f8ae1..038bcd4d035e 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
 obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
 obj-$(CONFIG_COMMON_CLK_MMP2_AUDIO) += clk-audio.o
 
-obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-pxa1908-apbc.o
+obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-pxa1908-apbc.o clk-pxa1908-apbcp.o
diff --git a/drivers/clk/mmp/clk-pxa1908-apbcp.c b/drivers/clk/mmp/clk-pxa1908-apbcp.c
new file mode 100644
index 000000000000..2a53cf276407
--- /dev/null
+++ b/drivers/clk/mmp/clk-pxa1908-apbcp.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/units.h>
+
+#include <dt-bindings/clock/marvell,pxa1908.h>
+
+#include "clk.h"
+
+#define APBCP_UART2		0x1c
+#define APBCP_TWSI2		0x28
+#define APBCP_AICER		0x38
+
+#define APBCP_NR_CLKS		4
+
+struct pxa1908_clk_unit {
+	struct mmp_clk_unit unit;
+	void __iomem *base;
+};
+
+static DEFINE_SPINLOCK(uart2_lock);
+
+static const char * const uart_parent_names[] = {"pll1_117", "uart_pll"};
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
+	mmp_register_mux_clks(unit, apbcp_mux_clks, pxa_unit->base,
+			ARRAY_SIZE(apbcp_mux_clks));
+	mmp_register_gate_clks(unit, apbcp_gate_clks, pxa_unit->base,
+			ARRAY_SIZE(apbcp_gate_clks));
+}
+
+static int pxa1908_apbcp_probe(struct platform_device *pdev)
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
+	mmp_clk_init(pdev->dev.of_node, &pxa_unit->unit, APBCP_NR_CLKS);
+
+	pxa1908_apb_p_periph_clk_init(pxa_unit);
+
+	return 0;
+}
+
+static const struct of_device_id pxa1908_apbcp_match_table[] = {
+	{ .compatible = "marvell,pxa1908-apbcp" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pxa1908_apbcp_match_table);
+
+static struct platform_driver pxa1908_apbcp_driver = {
+	.probe = pxa1908_apbcp_probe,
+	.driver = {
+		.name = "pxa1908-apbcp",
+		.of_match_table = pxa1908_apbcp_match_table
+	}
+};
+module_platform_driver(pxa1908_apbcp_driver);
+
+MODULE_AUTHOR("Duje Mihanović <duje.mihanovic@skole.hr>");
+MODULE_DESCRIPTION("Marvell PXA1908 APBCP Clock Driver");
+MODULE_LICENSE("GPL");

-- 
2.44.0



