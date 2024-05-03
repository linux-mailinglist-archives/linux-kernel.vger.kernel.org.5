Return-Path: <linux-kernel+bounces-167758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8468BAEC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4561F2452C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901A15534B;
	Fri,  3 May 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PD7bTcKT"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C41E4B1;
	Fri,  3 May 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746080; cv=none; b=oV9+jWFhF0lpR3Lss3ftKh+typgmtaD2sV53NLfH+N+84+AvvQ9NtDUgLDJ6VkXdZGVBwQJqKxWvC5lGjDXNzvZkefYAMgJkpPdem9rx3tCkul2xi1thsw6u3rmfGyT6ipzaruTY7jMNxGwqCfuV5x76OhecOpSOai91DbiUl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746080; c=relaxed/simple;
	bh=hLQChgYtET0WRL3137IYLuOShHL1o5R/z9XElRCzlXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKUkofNOKvhTvEqGecYnpaNhr6ktRZJB9Rs9zkGakNlb1YSreAyrK69vhek9vi4q+5c2aB9vhrftxTPusGwCPQeEjy+lQEjhXQoFjHQd2oXfJHDTczDKDPhEwI229YS645RutTZfvn+xYfCsWr87oXEsePNG1mQLEeDibZy8Afg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PD7bTcKT; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8B6BE0012;
	Fri,  3 May 2024 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sSrxzyJYyHA2ZncHIX4c1wnuyo/szR276JP38Uilf4=;
	b=PD7bTcKTQUjHWKGO5rA1jVIn9BCkyxxTA5zR1VzznvYhonKW2PWGXU7brmVc3aRC7/KSv4
	DRs838tY5RmDphCi3sWM7FwBharAZQJLoxZs8aSNAVs+XWHbxsRpq0EFKZdpM0dIqY6oBQ
	2H+yQHy6c6qGAoMdFTX/NSAu7VzGJ43DYKzUO71YLLrha6u1Y+v765Dt39jrvg3lA+C4b8
	d6sES4G7ntd52wB9G+0rzLJ62ZWCnNuwp2pSrPGNx4M4yuueVQNRz0LrmVh0T4LPD4auoT
	0Ql772cZAlOwCQG/sZEYPrX3aP2wqMfP7aSioLNVJbPO4gAkvMKIhHP6USkbWg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 03 May 2024 16:20:51 +0200
Subject: [PATCH v2 06/11] mfd: olb: Add support for Mobileye OLB
 system-controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-mbly-olb-v2-6-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
In-Reply-To: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Mobileye OLB system-controller gets used in EyeQ5, EyeQ6L and EyeQ6H
platforms. It hosts clock, reset and pinctrl functionality.

Tiny iomem resources are declared for all cells. Some features are
spread apart. Pinctrl is only used on EyeQ5.

EyeQ6H is special: it hosts seven OLB controllers, each with a
compatible. That means many clock and reset cells. Use cell->devname
for explicit device names rather than clk-eyeq.ID or clk-eyeq.ID.auto.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/mfd/Kconfig        |  10 +++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/mobileye-olb.c | 180 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4b023ee229cf..d004a3f4d493 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1030,6 +1030,16 @@ config MFD_OCELOT
 
 	  If unsure, say N.
 
+config MFD_OLB
+	bool "Mobileye EyeQ OLB System Controller Support"
+	select MFD_CORE
+	depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
+	default MACH_EYEQ5 || MACH_EYEQ6H
+	help
+	  Say yes here to add support for EyeQ platforms (EyeQ5, EyeQ6L and
+	  EyeQ6H). This core MFD platform driver provides clock, reset and
+	  pinctrl (only EyeQ5) support.
+
 config EZX_PCAP
 	bool "Motorola EZXPCAP Support"
 	depends on SPI_MASTER
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c66f07edcd0e..d872833966a8 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -120,6 +120,8 @@ obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o
 obj-$(CONFIG_MFD_OCELOT)	+= ocelot-soc.o
 
+obj-$(CONFIG_MFD_OLB)		+= mobileye-olb.o
+
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
 obj-$(CONFIG_MFD_CPCAP)		+= motorola-cpcap.o
 
diff --git a/drivers/mfd/mobileye-olb.c b/drivers/mfd/mobileye-olb.c
new file mode 100644
index 000000000000..1640d63a3ddd
--- /dev/null
+++ b/drivers/mfd/mobileye-olb.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * System controller multi-function device for EyeQ platforms.
+ *
+ * Mobileye EyeQ5, EyeQ6L and EyeQ6H platforms have MMIO mapped registers
+ * controlling core platform clocks, resets and pin control. Many other
+ * features are present and not yet exposed.
+ *
+ * Declare cells for each compatible. Only EyeQ5 has pinctrl.
+ * EyeQ6H has seven OLB instances; each has a name which we propagate to
+ * sub-devices using cell->devname.
+ *
+ * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define OLB_MFD_CELL(_name, _res, _devname) \
+	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, false, NULL, _devname)
+
+struct olb_match_data {
+	const struct mfd_cell	*cells;
+	int			nb_cells; /* int to match devm_mfd_add_devices() argument */
+};
+
+#define OLB_DATA(_cells) { .cells = (_cells), .nb_cells = ARRAY_SIZE(_cells) }
+
+static int olb_probe(struct platform_device *pdev)
+{
+	const struct olb_match_data *match_data;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	match_data = device_get_match_data(dev);
+	if (!match_data)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				    match_data->cells, match_data->nb_cells,
+				    res, 0, NULL);
+}
+
+static const struct resource olb_eyeq5_clk_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x02C, 10 * 8, "pll"),
+	DEFINE_RES_MEM_NAMED(0x11C, 1 * 4, "ospi"),
+};
+
+static const struct resource olb_eyeq5_reset_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x004, 2 * 4, "d0"),
+	DEFINE_RES_MEM_NAMED(0x200, 13 * 4, "d1"),
+	DEFINE_RES_MEM_NAMED(0x120, 1 * 4, "d2"),
+};
+
+static const struct resource olb_eyeq5_pinctrl_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x0B0, 12 * 4, "pinctrl"),
+};
+
+static const struct mfd_cell olb_eyeq5_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq5_clk_resources, NULL),
+	OLB_MFD_CELL("reset-eyeq", olb_eyeq5_reset_resources, NULL),
+	OLB_MFD_CELL("eyeq5-pinctrl", olb_eyeq5_pinctrl_resources, NULL),
+};
+
+static const struct olb_match_data olb_eyeq5_match_data = OLB_DATA(olb_eyeq5_cells);
+
+static const struct resource olb_eyeq6l_clk_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x02C, 4 * 8, "pll"),
+};
+
+static const struct resource olb_eyeq6l_reset_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x004, 2 * 4, "d0"),
+	DEFINE_RES_MEM_NAMED(0x200, 13 * 4, "d1"),
+};
+
+static const struct mfd_cell olb_eyeq6l_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq6l_clk_resources, NULL),
+	OLB_MFD_CELL("reset-eyeq", olb_eyeq6l_reset_resources, NULL),
+};
+
+static const struct olb_match_data olb_eyeq6l_match_data = OLB_DATA(olb_eyeq6l_cells);
+
+static const struct resource olb_eyeq6h_acc_clk_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x040, 7 * 8, "pll"),
+};
+
+static const struct resource olb_eyeq6h_acc_reset_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x000, 15 * 4, "d0"),
+};
+
+static const struct mfd_cell olb_eyeq6h_acc_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq6h_acc_clk_resources, "clk-eyeq-acc"),
+	OLB_MFD_CELL("reset-eyeq", olb_eyeq6h_acc_reset_resources, "reset-eyeq-acc"),
+};
+
+static const struct olb_match_data olb_eyeq6h_acc_match_data = OLB_DATA(olb_eyeq6h_acc_cells);
+
+static const struct resource olb_eyeq6h_we_clk_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x074, 1 * 8, "pll"),
+};
+
+static const struct resource olb_eyeq6h_we_reset_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x004, 4 * 4, "d0"),
+};
+
+static const struct mfd_cell olb_eyeq6h_west_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq6h_we_clk_resources, "clk-eyeq-west"),
+	OLB_MFD_CELL("reset-eyeq", olb_eyeq6h_we_reset_resources, "reset-eyeq-west"),
+};
+
+static const struct olb_match_data olb_eyeq6h_west_match_data = OLB_DATA(olb_eyeq6h_west_cells);
+
+static const struct mfd_cell olb_eyeq6h_east_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq6h_we_clk_resources, "clk-eyeq-east"),
+	OLB_MFD_CELL("reset-eyeq", olb_eyeq6h_we_reset_resources, "reset-eyeq-east"),
+};
+
+static const struct olb_match_data olb_eyeq6h_east_match_data = OLB_DATA(olb_eyeq6h_east_cells);
+
+static const struct resource olb_eyeq6h_south_clk_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x000, 4 * 8, "pll"),
+	DEFINE_RES_MEM_NAMED(0x070, 1 * 4, "emmc"),
+	DEFINE_RES_MEM_NAMED(0x090, 1 * 4, "ospi"),
+	DEFINE_RES_MEM_NAMED(0x098, 1 * 4, "tsu"),
+};
+
+static const struct mfd_cell olb_eyeq6h_south_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq6h_south_clk_resources, "clk-eyeq-south"),
+};
+
+static const struct olb_match_data olb_eyeq6h_south_match_data = OLB_DATA(olb_eyeq6h_south_cells);
+
+static const struct resource olb_eyeq6h_ddr_clk_resources[] = {
+	DEFINE_RES_MEM_NAMED(0x074, 1 * 8, "pll"),
+};
+
+static const struct mfd_cell olb_eyeq6h_ddr0_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq6h_ddr_clk_resources, "clk-eyeq-ddr0"),
+};
+
+static const struct olb_match_data olb_eyeq6h_ddr0_match_data = OLB_DATA(olb_eyeq6h_ddr0_cells);
+
+static const struct mfd_cell olb_eyeq6h_ddr1_cells[] = {
+	OLB_MFD_CELL("clk-eyeq", olb_eyeq6h_ddr_clk_resources, "clk-eyeq-ddr1"),
+};
+
+static const struct olb_match_data olb_eyeq6h_ddr1_match_data = OLB_DATA(olb_eyeq6h_ddr1_cells);
+
+static const struct of_device_id olb_of_match[] = {
+	{ .compatible = "mobileye,eyeq5-olb", .data = &olb_eyeq5_match_data },
+	{ .compatible = "mobileye,eyeq6l-olb", .data = &olb_eyeq6l_match_data },
+	{ .compatible = "mobileye,eyeq6h-acc-olb", .data = &olb_eyeq6h_acc_match_data },
+	/* No central: it only has an early clock handled using CLK_OF_DECLARE_DRIVER(). */
+	{ .compatible = "mobileye,eyeq6h-east-olb", .data = &olb_eyeq6h_east_match_data },
+	{ .compatible = "mobileye,eyeq6h-west-olb", .data = &olb_eyeq6h_west_match_data },
+	{ .compatible = "mobileye,eyeq6h-south-olb", .data = &olb_eyeq6h_south_match_data },
+	{ .compatible = "mobileye,eyeq6h-ddr0-olb", .data = &olb_eyeq6h_ddr0_match_data },
+	{ .compatible = "mobileye,eyeq6h-ddr1-olb", .data = &olb_eyeq6h_ddr1_match_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, olb_of_match);
+
+static struct platform_driver olb_driver = {
+	.probe =  olb_probe,
+	.driver = {
+		.name = "olb",
+		.of_match_table = olb_of_match,
+	},
+};
+builtin_platform_driver(olb_driver);

-- 
2.45.0


