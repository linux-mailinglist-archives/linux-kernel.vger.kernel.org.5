Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550078939D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHZDMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 23:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjHZDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:11:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8536E26BF;
        Fri, 25 Aug 2023 20:11:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37Q3AtzP6031129, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37Q3AtzP6031129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Aug 2023 11:10:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 26 Aug 2023 11:10:16 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 26 Aug 2023 11:10:29 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Sat, 26 Aug 2023 11:10:15 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver
Date:   Sat, 26 Aug 2023 11:10:06 +0800
Message-ID: <20230826031028.1892-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek DHC RTD SoCs integrate dwc3 IP and has some customizations to
support different generations of SoCs.

The RTD1619b subclass SoC only supports USB 2.0 from dwc3. The driver
can set a maximum speed to support this. Add role switching function,
that can switch USB roles through other drivers, or switch USB roles
through user space through set /sys/class/usb_role/.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
v5 to v6 minor change:
    1. Revised a function return check.
    2. Add address for device name.
    3. Change dev_info to dev_dbg.
v4 to v5 change:
    1. Use enumeration and define usb_role uniformly instead of
       dr_mode to avoid confusing dr_mode and usb_role.
    2. Split the register read and write to separate operations.
v3 to v4 change:
    Get max-speed from dwc3 node.
    Add the register set for pm control.
v2 to v3 change:
    Remove the support_drd_mode of struct dwc3_rtk.
    Remove unlink_usb3_port and disable_usb3_phy.
    Disabled usb3 phy if the max speed is not super-speed.
v1 to v2 change:
    Remove the code about the property realtek,enable-l4icg.
    Select USB_ROLE_SWITCH in Kconfig.
    Add dependency OF and ARCH_REALTEK in Kconfig.
---
 drivers/usb/dwc3/Kconfig    |  11 +
 drivers/usb/dwc3/Makefile   |   1 +
 drivers/usb/dwc3/dwc3-rtk.c | 475 ++++++++++++++++++++++++++++++++++++
 3 files changed, 487 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-rtk.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 98efcbb76c88..5fc27b20df63 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -178,4 +178,15 @@ config USB_DWC3_OCTEON
 	  Only the host mode is currently supported.
 	  Say 'Y' or 'M' here if you have one such device.
 
+config USB_DWC3_RTK
+	tristate "Realtek DWC3 Platform Driver"
+	depends on OF && ARCH_REALTEK
+	default USB_DWC3
+	select USB_ROLE_SWITCH
+	help
+	  RTK DHC RTD SoCs with DesignWare Core USB3 IP inside,
+	  and IP Core configured for USB 2.0 and USB 3.0 in host
+	  or dual-role mode.
+	  Say 'Y' or 'M' if you have such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index fe1493d4bbe5..124eda2522d9 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
 obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
 obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
 obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
+obj-$(CONFIG_USB_DWC3_RTK)		+= dwc3-rtk.o
diff --git a/drivers/usb/dwc3/dwc3-rtk.c b/drivers/usb/dwc3/dwc3-rtk.c
new file mode 100644
index 000000000000..590028e8fdcb
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-rtk.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dwc3-rtk.c - Realtek DWC3 Specific Glue layer
+ *
+ * Copyright (C) 2023 Realtek Semiconductor Corporation
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/suspend.h>
+#include <linux/sys_soc.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/of.h>
+#include <linux/usb/role.h>
+
+#include "core.h"
+
+#define WRAP_CTR_REG  0x0
+#define DISABLE_MULTI_REQ BIT(1)
+#define DESC_R2W_MULTI_DISABLE BIT(9)
+#define FORCE_PIPE3_PHY_STATUS_TO_0 BIT(13)
+
+#define WRAP_USB2_PHY_UTMI_REG 0x8
+#define TXHSVM_EN BIT(3)
+
+#define WRAP_PHY_PIPE_REG 0xC
+#define RESET_DISABLE_PIPE3_P0 BIT(0)
+#define CLOCK_ENABLE_FOR_PIPE3_PCLK BIT(1)
+
+#define WRAP_USB_HMAC_CTR0_REG 0x60
+#define U3PORT_DIS BIT(8)
+
+#define WRAP_USB2_PHY_REG  0x70
+#define USB2_PHY_EN_PHY_PLL_PORT0 BIT(12)
+#define USB2_PHY_EN_PHY_PLL_PORT1 BIT(13)
+#define USB2_PHY_SWITCH_MASK 0x707
+#define USB2_PHY_SWITCH_DEVICE 0x0
+#define USB2_PHY_SWITCH_HOST 0x606
+
+#define WRAP_APHY_REG 0x128
+#define USB3_MBIAS_ENABLE BIT(1)
+
+/* pm control */
+#define WRAP_USB_DBUS_PWR_CTRL_REG 0x160
+#define USB_DBUS_PWR_CTRL_REG 0x0
+#define DBUS_PWR_CTRL_EN BIT(0)
+
+struct dwc3_rtk {
+	struct device *dev;
+	void __iomem *regs;
+	size_t regs_size;
+	void __iomem *pm_base;
+
+	struct dwc3 *dwc;
+
+	enum usb_role cur_role;
+	struct usb_role_switch *role_switch;
+};
+
+static void switch_usb2_role(struct dwc3_rtk *rtk, enum usb_role role)
+{
+	void __iomem *reg;
+	int val;
+
+	reg = rtk->regs + WRAP_USB2_PHY_REG;
+	val = ~USB2_PHY_SWITCH_MASK & readl(reg);
+
+	switch (role) {
+	case USB_ROLE_DEVICE:
+		writel(USB2_PHY_SWITCH_DEVICE | val, reg);
+		break;
+	case USB_ROLE_HOST:
+		writel(USB2_PHY_SWITCH_HOST | val, reg);
+		break;
+	default:
+		dev_dbg(rtk->dev, "%s: role=%d\n", __func__, role);
+		break;
+	}
+}
+
+static void switch_dwc3_role(struct dwc3_rtk *rtk, enum usb_role role)
+{
+	if (!rtk->dwc->role_sw)
+		return;
+
+	usb_role_switch_set_role(rtk->dwc->role_sw, role);
+}
+
+static enum usb_role dwc3_rtk_get_role(struct dwc3_rtk *rtk)
+{
+	enum usb_role role;
+
+	role = rtk->cur_role;
+
+	if (rtk->dwc && rtk->dwc->role_sw)
+		role = usb_role_switch_get_role(rtk->dwc->role_sw);
+	else
+		dev_dbg(rtk->dev, "%s not usb_role_switch role=%d\n", __func__, role);
+
+	return role;
+}
+
+static void dwc3_rtk_set_role(struct dwc3_rtk *rtk, enum usb_role role)
+{
+	rtk->cur_role = role;
+
+	switch_dwc3_role(rtk, role);
+	mdelay(10);
+	switch_usb2_role(rtk, role);
+}
+
+#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
+static int dwc3_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role role)
+{
+	struct dwc3_rtk *rtk = usb_role_switch_get_drvdata(sw);
+
+	dwc3_rtk_set_role(rtk, role);
+
+	return 0;
+}
+
+static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
+{
+	struct dwc3_rtk *rtk = usb_role_switch_get_drvdata(sw);
+
+	return dwc3_rtk_get_role(rtk);
+}
+
+static int dwc3_rtk_setup_role_switch(struct dwc3_rtk *rtk)
+{
+	struct usb_role_switch_desc dwc3_role_switch = {NULL};
+
+	dwc3_role_switch.name = dev_name(rtk->dev);
+	dwc3_role_switch.driver_data = rtk;
+	dwc3_role_switch.allow_userspace_control = true;
+	dwc3_role_switch.fwnode = dev_fwnode(rtk->dev);
+	dwc3_role_switch.set = dwc3_usb_role_switch_set;
+	dwc3_role_switch.get = dwc3_usb_role_switch_get;
+	rtk->role_switch = usb_role_switch_register(rtk->dev, &dwc3_role_switch);
+	if (IS_ERR(rtk->role_switch))
+		return PTR_ERR(rtk->role_switch);
+
+	return 0;
+}
+
+static int dwc3_rtk_remove_role_switch(struct dwc3_rtk *rtk)
+{
+	if (rtk->role_switch)
+		usb_role_switch_unregister(rtk->role_switch);
+
+	rtk->role_switch = NULL;
+
+	return 0;
+}
+#else
+#define dwc3_rtk_setup_role_switch(x) 0
+#define dwc3_rtk_remove_role_switch(x) 0
+#endif
+
+static const char *const speed_names[] = {
+	[USB_SPEED_UNKNOWN] = "UNKNOWN",
+	[USB_SPEED_LOW] = "low-speed",
+	[USB_SPEED_FULL] = "full-speed",
+	[USB_SPEED_HIGH] = "high-speed",
+	[USB_SPEED_WIRELESS] = "wireless",
+	[USB_SPEED_SUPER] = "super-speed",
+	[USB_SPEED_SUPER_PLUS] = "super-speed-plus",
+};
+
+static enum usb_device_speed __get_dwc3_maximum_speed(struct device_node *np)
+{
+	struct device_node *dwc3_np;
+	const char *maximum_speed;
+	int ret;
+
+	dwc3_np = of_get_compatible_child(np, "snps,dwc3");
+	if (!dwc3_np)
+		return USB_SPEED_UNKNOWN;
+
+	ret = of_property_read_string(dwc3_np, "maximum-speed", &maximum_speed);
+	if (ret < 0)
+		return USB_SPEED_UNKNOWN;
+
+	ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
+
+	return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
+}
+
+static int dwc3_rtk_init(struct dwc3_rtk *rtk)
+{
+	struct device *dev = rtk->dev;
+	void __iomem *reg;
+	int val;
+	enum usb_device_speed maximum_speed;
+	const struct soc_device_attribute rtk_soc_kylin_a00[] = {
+		{ .family = "Realtek Kylin", .revision = "A00", },
+		{ /* empty */ } };
+	const struct soc_device_attribute rtk_soc_hercules[] = {
+		{ .family = "Realtek Hercules", }, { /* empty */ } };
+	const struct soc_device_attribute rtk_soc_thor[] = {
+		{ .family = "Realtek Thor", }, { /* empty */ } };
+
+	if (soc_device_match(rtk_soc_kylin_a00)) {
+		reg = rtk->regs + WRAP_CTR_REG;
+		val = readl(reg);
+		writel(DISABLE_MULTI_REQ | val, reg);
+		dev_info(dev, "[bug fixed] 1295/1296 A00: add workaround to disable multiple request for D-Bus");
+	}
+
+	if (soc_device_match(rtk_soc_hercules)) {
+		reg = rtk->regs + WRAP_USB2_PHY_REG;
+		val = readl(reg);
+		writel(USB2_PHY_EN_PHY_PLL_PORT1 | val, reg);
+		dev_info(dev, "[bug fixed] 1395 add workaround to disable usb2 port 2 suspend!");
+	}
+
+	reg = rtk->regs + WRAP_USB2_PHY_UTMI_REG;
+	val = readl(reg);
+	writel(TXHSVM_EN | val, reg);
+
+	maximum_speed = __get_dwc3_maximum_speed(dev->of_node);
+	if (maximum_speed != USB_SPEED_UNKNOWN && maximum_speed <= USB_SPEED_HIGH) {
+		if (soc_device_match(rtk_soc_thor)) {
+			reg = rtk->regs + WRAP_USB_HMAC_CTR0_REG;
+			val = readl(reg);
+			writel(U3PORT_DIS | val, reg);
+		} else {
+			reg = rtk->regs + WRAP_CTR_REG;
+			val = readl(reg);
+			writel(FORCE_PIPE3_PHY_STATUS_TO_0 | val, reg);
+
+			reg = rtk->regs + WRAP_PHY_PIPE_REG;
+			val = ~CLOCK_ENABLE_FOR_PIPE3_PCLK & readl(reg);
+			writel(RESET_DISABLE_PIPE3_P0 | val, reg);
+
+			reg =  rtk->regs + WRAP_USB_HMAC_CTR0_REG;
+			val = readl(reg);
+			writel(U3PORT_DIS | val, reg);
+
+			reg = rtk->regs + WRAP_APHY_REG;
+			val = readl(reg);
+			writel(~USB3_MBIAS_ENABLE & val, reg);
+
+			dev_dbg(rtk->dev, "%s: disable usb 3.0 phy\n", __func__);
+		}
+	}
+
+	reg = rtk->regs + WRAP_CTR_REG;
+	val = readl(reg);
+	writel(DESC_R2W_MULTI_DISABLE | val, reg);
+
+	/* Set phy Dp/Dm initial state to host mode to avoid the Dp glitch */
+	reg = rtk->regs + WRAP_USB2_PHY_REG;
+	val = ~USB2_PHY_SWITCH_MASK & readl(reg);
+	writel(USB2_PHY_SWITCH_HOST | val, reg);
+
+	if (rtk->pm_base) {
+		reg = rtk->pm_base + USB_DBUS_PWR_CTRL_REG;
+		val = DBUS_PWR_CTRL_EN | readl(reg);
+		writel(val, reg);
+	}
+
+	return 0;
+}
+
+static int dwc3_rtk_probe_dwc3_core(struct dwc3_rtk *rtk)
+{
+	struct device *dev = rtk->dev;
+	struct device_node *node = dev->of_node;
+	struct platform_device *dwc3_pdev;
+	struct device *dwc3_dev;
+	struct device_node *dwc3_node;
+	enum usb_dr_mode dr_mode;
+	int ret = 0;
+
+	ret = dwc3_rtk_init(rtk);
+	if (ret)
+		return -EINVAL;
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to add dwc3 core\n");
+		return ret;
+	}
+
+	dwc3_node = of_get_compatible_child(node, "snps,dwc3");
+	if (!dwc3_node) {
+		dev_err(dev, "failed to find dwc3 core node\n");
+		ret = -ENODEV;
+		goto depopulate;
+	}
+
+	dwc3_pdev = of_find_device_by_node(dwc3_node);
+	if (!dwc3_pdev) {
+		dev_err(dev, "failed to find dwc3 core platform_device\n");
+		ret = -ENODEV;
+		goto err_node_put;
+	}
+
+	dwc3_dev = &dwc3_pdev->dev;
+	rtk->dwc = platform_get_drvdata(dwc3_pdev);
+	if (!rtk->dwc) {
+		dev_err(dev, "failed to find dwc3 core\n");
+		ret = -ENODEV;
+		goto err_pdev_put;
+	}
+
+	dr_mode = usb_get_dr_mode(dwc3_dev);
+	if (dr_mode != rtk->dwc->dr_mode) {
+		dev_info(dev, "dts set dr_mode=%d, but dwc3 set dr_mode=%d\n",
+			 dr_mode, rtk->dwc->dr_mode);
+		dr_mode = rtk->dwc->dr_mode;
+	}
+
+	switch (dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		rtk->cur_role = USB_ROLE_DEVICE;
+		break;
+	case USB_DR_MODE_HOST:
+		rtk->cur_role = USB_ROLE_HOST;
+		break;
+	default:
+		dev_dbg(rtk->dev, "%s: dr_mode=%d\n", __func__, dr_mode);
+		break;
+	}
+
+	if (device_property_read_bool(dwc3_dev, "usb-role-switch")) {
+		ret = dwc3_rtk_setup_role_switch(rtk);
+		if (ret) {
+			dev_err(dev, "dwc3_rtk_setup_role_switch fail=%d\n", ret);
+			goto err_pdev_put;
+		}
+		rtk->cur_role = dwc3_rtk_get_role(rtk);
+	}
+
+	switch_usb2_role(rtk, rtk->cur_role);
+
+	return 0;
+
+err_pdev_put:
+	platform_device_put(dwc3_pdev);
+err_node_put:
+	of_node_put(dwc3_node);
+depopulate:
+	of_platform_depopulate(dev);
+
+	return ret;
+}
+
+static int dwc3_rtk_probe(struct platform_device *pdev)
+{
+	struct dwc3_rtk *rtk;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *regs;
+	int ret = 0;
+
+	rtk = devm_kzalloc(dev, sizeof(*rtk), GFP_KERNEL);
+	if (!rtk) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	platform_set_drvdata(pdev, rtk);
+
+	rtk->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing memory resource\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto out;
+	}
+
+	rtk->regs = regs;
+	rtk->regs_size = resource_size(res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		rtk->pm_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(rtk->pm_base)) {
+			ret = PTR_ERR(rtk->pm_base);
+			goto out;
+		}
+	}
+
+	ret = dwc3_rtk_probe_dwc3_core(rtk);
+
+out:
+	return ret;
+}
+
+static void dwc3_rtk_remove(struct platform_device *pdev)
+{
+	struct dwc3_rtk *rtk = platform_get_drvdata(pdev);
+
+	rtk->dwc = NULL;
+
+	dwc3_rtk_remove_role_switch(rtk);
+
+	of_platform_depopulate(rtk->dev);
+}
+
+static void dwc3_rtk_shutdown(struct platform_device *pdev)
+{
+	struct dwc3_rtk *rtk = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(rtk->dev);
+}
+
+static const struct of_device_id rtk_dwc3_match[] = {
+	{ .compatible = "realtek,rtd-dwc3" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rtk_dwc3_match);
+
+#ifdef CONFIG_PM_SLEEP
+static int dwc3_rtk_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int dwc3_rtk_resume(struct device *dev)
+{
+	struct dwc3_rtk *rtk = dev_get_drvdata(dev);
+
+	dwc3_rtk_init(rtk);
+
+	switch_usb2_role(rtk, rtk->cur_role);
+
+	/* runtime set active to reflect active state. */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_rtk_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_rtk_suspend, dwc3_rtk_resume)
+};
+
+#define DEV_PM_OPS	(&dwc3_rtk_dev_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
+static struct platform_driver dwc3_rtk_driver = {
+	.probe		= dwc3_rtk_probe,
+	.remove_new	= dwc3_rtk_remove,
+	.driver		= {
+		.name	= "rtk-dwc3",
+		.of_match_table = rtk_dwc3_match,
+		.pm	= DEV_PM_OPS,
+	},
+	.shutdown	= dwc3_rtk_shutdown,
+};
+
+module_platform_driver(dwc3_rtk_driver);
+
+MODULE_AUTHOR("Stanley Chang <stanley_chang@realtek.com>");
+MODULE_DESCRIPTION("DesignWare USB3 Realtek Glue Layer");
+MODULE_ALIAS("platform:rtk-dwc3");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: phy_rtk_usb2 phy_rtk_usb3");
-- 
2.34.1

