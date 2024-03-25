Return-Path: <linux-kernel+bounces-116632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73188A55F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E3AB43DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37315357B;
	Mon, 25 Mar 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="S9r0f+9F"
Received: from mail-m127225.xmail.ntesmail.com (mail-m127225.xmail.ntesmail.com [115.236.127.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC75D464;
	Mon, 25 Mar 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355528; cv=none; b=bPUwIPFf6ZngoiEDxJNDSFDk36Y3R17dkMNPALi8dzL6DV8C7VVh/+SQffJpY7VwiHxU1TjR7J39XbXEFgd3j0Qkbn4cv9/WDJYIrk1Eyih3zBM+Xl58Djk1roQvwVaNuptZBWm/rreJ7wghvbxJ+0AHgfq6AlyVN+CMEmNCTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355528; c=relaxed/simple;
	bh=KD50ATroLq5wbiqV8KIwzZpaujxagamNMl0akgT1LWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UA0AFFwlvOzSFkcMeGZIUI2ApgF5IJMeo+CWIw8Er0BJwXpwD3ikp0szQLhYBgJyDaI+FQI+SO9p+8C2AxpkJiz7u9+hiAHDue/XHQ0HZaeKopw6YLqwwGFXBcALkG0bftsyPJl4iCykHYzFvIhw6Usw1FpIt0/+mOfOV2ZpPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=S9r0f+9F; arc=none smtp.client-ip=115.236.127.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=S9r0f+9FN3LtZ3BxW8+zASeX2mJRD5y9BDprcwER3SnJ+xFG9rwhIRCxSklTmFpxIhFxx3/CToiQVri3c/rLKgrUMobOgAKPhktClxFkhN+0UzbaWTXUcCzQjLK7fv7dw26KEKu8an/FIxniRKoc+pLV46mgUfNRnO5gREEqELY=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=RTrYQS6npXaXjhs3epbhBAkTBe1y8Ij/m1SJhYUQASY=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 4C7647C044A;
	Mon, 25 Mar 2024 12:16:50 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] clk: rockchip: Add support for clk input / output switch
Date: Mon, 25 Mar 2024 12:16:29 +0800
Message-Id: <20240325121537.v1.1.Ibe8286bb98ea1fc3bc6421c30f6e46fc0b1b0d88@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711340191-69588-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1711340191-69588-1-git-send-email-sugar.zhang@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIZTFZKGR4aTk1ISB8aTx5VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5DTUtIVUpLS1VKQl
	kG
X-HM-Tid: 0a8e73d34a1109d2kunm4c7647c044a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6UTo*HTMSOA0ZFQgKNBI3
	GBRPCx5VSlVKTEpKSE9LSUpKSE9CVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBQk9DSjcG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch add support switch for clk-bidirection which located
at GRF, such as SAIx_MCLK_{IN OUT} which share the same pin.
and these config maybe located in many pieces of GRF,
which hard to addressed in one single clk driver. so, we add
this simple helper driver to address this situation.

In order to simplify implement and usage, and also for safety
clk usage (avoid high freq glitch), we set all clk out as disabled
(which means Input default for clk-bidrection) in the pre-stage,
such boot-loader or init by HW default. And then set a safety freq
before enable clk-out, such as "assign-clock-rates" or clk_set_rate
in drivers.

e.g.

1. mclk{out,in}_sai0 define:

  mclkin_sai0: mclkin-sai0 {
      compatible = "fixed-clock";
      #clock-cells = <0>;
      clock-frequency = <12288000>;
      clock-output-names = "mclk_sai0_from_io";
  };

  mclkout_sai0: mclkout-sai0@ff040070 {
      compatible = "rockchip,clk-out";
      reg = <0 0xff040070 0 0x4>;
      clocks = <&cru MCLK_SAI0_OUT2IO>;
      #clock-cells = <0>;
      clock-output-names = "mclk_sai0_to_io";
      rockchip,bit-shift = <4>;
      //example with PD if reg access needed
      power-domains = <&power RK3562_PD_VO>;
  };

Note:

clock-output-names of mclkin_sai0 should equal to strings in drivers. such as:

drivers/clk/rockchip/clk-rk3562.c:
PNAME(clk_sai0_p) = { "clk_sai0_src", "clk_sai0_frac", "xin_osc0_half", "mclk_sai0_from_io" };

2. mclkout_sai0 usage:

  &ext_codec {
      clocks = <&mclkout_sai0>;
      clock-names = "mclk";
      assigned-clocks = <&mclkout_sai0>;
      assigned-clock-rates = <12288000>;
      pinctrl-names = "default";
      pinctrl-0 = <&i2s0m0_mclk>;
  };

  clk_summary on sai0 work:

  cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"

  clk_sai0_src                1        1        0  1188000000          0     0  50000
    clk_sai0_frac             1        1        0    12288000          0     0  50000
      clk_sai0                1        1        0    12288000          0     0  50000
        mclk_sai0             1        1        0    12288000          0     0  50000
          mclk_sai0_out2io    1        1        0    12288000          0     0  50000
            mclk_sai0_to_io   1        1        0    12288000          0     0  50000

  example with PD if reg access needed:

  * PD status when mclk_sai0_to_io on:

  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary

  domain                          status          children
    /device                                                runtime status
  ----------------------------------------------------------------------
  ...

  vo                              on
    /devices/platform/clocks/ff040070.mclkout-sai0         active
  ...

  * PD status when mclk_sai0_to_io off:

  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary

  domain                          status          children
    /device                                                runtime status
  ----------------------------------------------------------------------
  ...

  vo                              off-0
    /devices/platform/clocks/ff040070.mclkout-sai0         suspended
  ...

3. mclkin_sai0 usage:

  please override freq of mclkin as the real external clkin, such as:

  &mclkin_sai0 {
      clock-frequency = <24576000>;
  }

  &ext_codec {
      clocks = <&mclkin_sai0>;
      clock-names = "mclk";
      assigned-clocks = <&cru CLK_SAI0>;
      assigned-clock-parents = <&mclkin_sai0>;
      pinctrl-names = "default";
      pinctrl-0 = <&i2s0m0_mclk>;
  };

  clk_summary on sai0 work:

  cat /sys/kernel/debug/clk/clk_summary | egrep "pll|sai0"

  mclk_sai0_from_io          1        1        0    12288000          0     0  50000
    clk_sai0                 1        1        0    12288000          0     0  50000
      mclk_sai0              1        1        0    12288000          0     0  50000
        mclk_sai0_out2io     0        0        0    12288000          0     0  50000
          mclk_sai0_to_io    0        0        0    12288000          0     0  50000

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 drivers/clk/rockchip/Kconfig   |  6 +++
 drivers/clk/rockchip/Makefile  |  2 +
 drivers/clk/rockchip/clk-out.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-out.c

diff --git a/drivers/clk/rockchip/Kconfig b/drivers/clk/rockchip/Kconfig
index 9aad869..0e7eee8 100644
--- a/drivers/clk/rockchip/Kconfig
+++ b/drivers/clk/rockchip/Kconfig
@@ -107,4 +107,10 @@ config CLK_RK3588
 	help
 	  Build the driver for RK3588 Clock Driver.
 
+config ROCKCHIP_CLK_OUT
+	tristate "Rockchip Clk Out / Input Switch"
+	default y
+	help
+	  Say y here to enable clk out / input switch.
+
 endif
diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 36894f6..30d6060 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -29,3 +29,5 @@ obj-$(CONFIG_CLK_RK3368)        += clk-rk3368.o
 obj-$(CONFIG_CLK_RK3399)        += clk-rk3399.o
 obj-$(CONFIG_CLK_RK3568)	+= clk-rk3568.o
 obj-$(CONFIG_CLK_RK3588)	+= clk-rk3588.o rst-rk3588.o
+
+obj-$(CONFIG_ROCKCHIP_CLK_OUT)  += clk-out.o
diff --git a/drivers/clk/rockchip/clk-out.c b/drivers/clk/rockchip/clk-out.c
new file mode 100644
index 0000000..22dcd98
--- /dev/null
+++ b/drivers/clk/rockchip/clk-out.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Rockchip Electronics Co., Ltd
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+static DEFINE_SPINLOCK(clk_out_lock);
+
+static int rockchip_clk_out_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw *hw;
+	struct resource *res;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	void __iomem *reg;
+	u32 shift = 0;
+	u8 clk_gate_flags = CLK_GATE_HIWORD_MASK;
+	int ret;
+
+	ret = device_property_read_string(dev, "clock-output-names", &clk_name);
+	if (ret)
+		return ret;
+
+	ret = device_property_read_u32(dev, "rockchip,bit-shift", &shift);
+	if (ret)
+		return ret;
+
+	if (device_property_read_bool(dev, "rockchip,bit-set-to-disable"))
+		clk_gate_flags |= CLK_GATE_SET_TO_DISABLE;
+
+	ret = of_clk_parent_fill(node, &parent_name, 1);
+	if (ret != 1)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	reg = devm_ioremap(dev, res->start, resource_size(res));
+	if (!reg)
+		return -ENOMEM;
+
+	pm_runtime_enable(dev);
+
+	hw = clk_hw_register_gate(dev, clk_name, parent_name, CLK_SET_RATE_PARENT,
+				  reg, shift, clk_gate_flags, &clk_out_lock);
+	if (IS_ERR(hw)) {
+		ret = -EINVAL;
+		goto err_disable_pm_runtime;
+	}
+
+	of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+
+	return 0;
+
+err_disable_pm_runtime:
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int rockchip_clk_out_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_clk_out_match[] = {
+	{ .compatible = "rockchip,clk-out", },
+	{},
+};
+
+static struct platform_driver rockchip_clk_out_driver = {
+	.driver = {
+		.name = "rockchip-clk-out",
+		.of_match_table = rockchip_clk_out_match,
+	},
+	.probe = rockchip_clk_out_probe,
+	.remove = rockchip_clk_out_remove,
+};
+
+module_platform_driver(rockchip_clk_out_driver);
+
+MODULE_DESCRIPTION("Rockchip Clock Input-Output-Switch");
+MODULE_AUTHOR("Sugar Zhang <sugar.zhang@rock-chips.com>");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, rockchip_clk_out_match);
-- 
2.7.4


