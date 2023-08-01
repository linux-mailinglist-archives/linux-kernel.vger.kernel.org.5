Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FEC76AD42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjHAJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjHAJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:27:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE7F173F;
        Tue,  1 Aug 2023 02:25:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3719PSxhC019513, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3719PSxhC019513
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 17:25:28 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 1 Aug 2023 17:25:42 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Aug 2023 17:25:41 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 1 Aug 2023 17:25:41 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver
Date:   Tue, 1 Aug 2023 17:25:26 +0800
Message-ID: <20230801092541.25261-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek DHC RTD SoCs integrate dwc3 IP and has some customizations to
support different generations of SoCs.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v1 to v2 change:
    Remove the the code about the property realtek,enable-l4icg.
    Select USB_ROLE_SWITCH in Kconfig.
    Add dependency OF and ARCH_REALTEK in Kconfig.
---
 drivers/usb/dwc3/Kconfig    |  12 +
 drivers/usb/dwc3/Makefile   |   1 +
 drivers/usb/dwc3/dwc3-rtk.c | 499 ++++++++++++++++++++++++++++++++++++
 3 files changed, 512 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-rtk.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index be954a9abbe0..baa6a38b2f13 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -168,4 +168,16 @@ config USB_DWC3_AM62
 	  The Designware Core USB3 IP is programmed to operate in
 	  in USB 2.0 mode only.
 	  Say 'Y' or 'M' here if you have one such device
+
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
index 9f66bd82b639..38d19e4369a5 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
 obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
 obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
+obj-$(CONFIG_USB_DWC3_RTK)		+= dwc3-rtk.o
diff --git a/drivers/usb/dwc3/dwc3-rtk.c b/drivers/usb/dwc3/dwc3-rtk.c
new file mode 100644
index 000000000000..5c2b2f4e422d
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-rtk.c
@@ -0,0 +1,499 @@
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
+#define WRAP_USB_DBUS_PWR_CTRL_REG 0x160
+#define DBUS_PWR_CTRL_EN BIT(0)
+
+struct dwc3_rtk {
+	struct device *dev;
+	void __iomem *regs;
+	size_t regs_size;
+
+	struct dwc3 *dwc;
+
+	int cur_dr_mode; /* current dr mode */
+	bool support_drd_mode; /* if support Host/device switch */
+	struct usb_role_switch *role_switch;
+
+	bool unlink_usb3_port;
+	bool disable_usb3_phy;
+};
+
+static void switch_usb2_dr_mode(struct dwc3_rtk *rtk, int dr_mode)
+{
+	switch (dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		writel(USB2_PHY_SWITCH_DEVICE |
+			    (~USB2_PHY_SWITCH_MASK &
+			      readl(rtk->regs + WRAP_USB2_PHY_REG)),
+			    rtk->regs + WRAP_USB2_PHY_REG);
+		break;
+	case USB_DR_MODE_HOST:
+		writel(USB2_PHY_SWITCH_HOST |
+			    (~USB2_PHY_SWITCH_MASK &
+			      readl(rtk->regs + WRAP_USB2_PHY_REG)),
+			    rtk->regs + WRAP_USB2_PHY_REG);
+		break;
+	default:
+		dev_dbg(rtk->dev, "%s: dr_mode=%d\n", __func__, dr_mode);
+		break;
+	}
+}
+
+static void switch_dwc3_dr_mode(struct dwc3_rtk *rtk, int dr_mode)
+{
+	if (!rtk->dwc->role_sw)
+		goto out;
+
+	switch (dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		usb_role_switch_set_role(rtk->dwc->role_sw, USB_ROLE_DEVICE);
+		break;
+	case USB_DR_MODE_HOST:
+		usb_role_switch_set_role(rtk->dwc->role_sw, USB_ROLE_HOST);
+		break;
+	default:
+		dev_dbg(rtk->dev, "%s dr_mode=%d\n", __func__, dr_mode);
+		break;
+	}
+
+out:
+	return;
+}
+
+static int dwc3_rtk_get_dr_mode(struct dwc3_rtk *rtk)
+{
+	enum usb_role role;
+
+	role = rtk->cur_dr_mode;
+
+	if (rtk->dwc && rtk->dwc->role_sw)
+		role = usb_role_switch_get_role(rtk->dwc->role_sw);
+	else
+		dev_dbg(rtk->dev, "%s not usb_role_switch role=%d\n", __func__, role);
+
+	return role;
+}
+
+static int dwc3_rtk_set_dr_mode(struct dwc3_rtk *rtk, int dr_mode)
+{
+	if (!rtk->support_drd_mode)
+		return rtk->cur_dr_mode;
+
+	rtk->cur_dr_mode = dr_mode;
+
+	switch_dwc3_dr_mode(rtk, dr_mode);
+	mdelay(10);
+	switch_usb2_dr_mode(rtk, dr_mode);
+
+	return rtk->cur_dr_mode;
+}
+
+#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
+static int dwc3_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role role)
+{
+	struct dwc3_rtk *rtk = usb_role_switch_get_drvdata(sw);
+
+	switch (role) {
+	case USB_ROLE_HOST:
+		dwc3_rtk_set_dr_mode(rtk, USB_DR_MODE_HOST);
+		break;
+	case USB_ROLE_DEVICE:
+		dwc3_rtk_set_dr_mode(rtk, USB_DR_MODE_PERIPHERAL);
+		break;
+	default:
+		dwc3_rtk_set_dr_mode(rtk, 0);
+	}
+
+	return 0;
+}
+
+static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
+{
+	struct dwc3_rtk *rtk = usb_role_switch_get_drvdata(sw);
+	enum usb_role role = USB_ROLE_NONE;
+	int dr_mode;
+
+	dr_mode = dwc3_rtk_get_dr_mode(rtk);
+	switch (dr_mode) {
+	case USB_DR_MODE_HOST:
+		role = USB_ROLE_HOST;
+		break;
+	case USB_DR_MODE_PERIPHERAL:
+		role = USB_ROLE_DEVICE;
+		break;
+	default:
+		dev_dbg(rtk->dev, "%s dr_mode=%d", __func__, dr_mode);
+		break;
+	}
+	return role;
+}
+
+static int dwc3_rtk_setup_role_switch(struct dwc3_rtk *rtk)
+{
+	struct usb_role_switch_desc dwc3_role_switch = {NULL};
+
+	dwc3_role_switch.name = strchrnul(dev_name(rtk->dev), '.') + 1;
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
+static int dwc3_rtk_init(struct dwc3_rtk *rtk)
+{
+	struct device *dev = rtk->dev;
+	void __iomem *regs = rtk->regs;
+	const struct soc_device_attribute rtk_soc_kylin_a00[] = {
+		{ .family = "Realtek Kylin", .revision = "A00", },
+		{ /* empty */ } };
+	const struct soc_device_attribute rtk_soc_kylin[] = {
+		{ .family = "Realtek Kylin", }, { /* empty */ } };
+	const struct soc_device_attribute rtk_soc_hercules[] = {
+		{ .family = "Realtek Hercules", }, { /* empty */ } };
+	const struct soc_device_attribute rtk_soc_hw_clock_gating_quirk[] = {
+		{ .family = "Realtek Kylin", },
+		{ .family = "Realtek Hercules", },
+		{ .family = "Realtek Thor", },
+		{ .family = "Realtek Hank", },
+		{ .family = "Realtek Groot", },
+		{ .family = "Realtek Stark", },
+		{ /* empty */ } };
+
+	if (soc_device_match(rtk_soc_kylin_a00)) {
+		writel(DISABLE_MULTI_REQ | readl(regs + WRAP_CTR_REG),
+		       regs + WRAP_CTR_REG);
+		dev_info(dev, "[bug fixed] 1295/1296 A00: add workaround to disable multiple request for D-Bus");
+	}
+
+	if (soc_device_match(rtk_soc_hercules)) {
+		writel(USB2_PHY_EN_PHY_PLL_PORT1 |
+		       readl(regs + WRAP_USB2_PHY_REG),
+		       regs + WRAP_USB2_PHY_REG);
+		dev_info(dev, "[bug fixed] 1395 add workaround to disable usb2 port 2 suspend!");
+	}
+
+	writel(TXHSVM_EN | readl(regs + WRAP_USB2_PHY_UTMI_REG),
+	       regs + WRAP_USB2_PHY_UTMI_REG);
+
+	if (rtk->unlink_usb3_port) {
+		void __iomem *reg;
+		int val;
+
+		reg =  rtk->regs + WRAP_USB_HMAC_CTR0_REG;
+		val = U3PORT_DIS | readl(reg);
+		writel(val, reg);
+	}
+
+	if (rtk->disable_usb3_phy) {
+		void __iomem *reg;
+		int val;
+
+		reg = rtk->regs + WRAP_CTR_REG;
+		val = FORCE_PIPE3_PHY_STATUS_TO_0 | readl(reg);
+		writel(val, reg);
+
+		reg = rtk->regs + WRAP_PHY_PIPE_REG;
+		val = ~CLOCK_ENABLE_FOR_PIPE3_PCLK & readl(reg);
+		val |= RESET_DISABLE_PIPE3_P0;
+		writel(val, reg);
+
+		reg =  rtk->regs + WRAP_USB_HMAC_CTR0_REG;
+		val = U3PORT_DIS | readl(reg);
+		writel(val, reg);
+
+		reg = rtk->regs + WRAP_APHY_REG;
+		val = ~USB3_MBIAS_ENABLE & readl(reg);
+		writel(val, reg);
+
+		dev_info(rtk->dev, "%s: disable usb 3.0 phy\n", __func__);
+	}
+
+	if (!soc_device_match(rtk_soc_kylin)) {
+		void __iomem *reg;
+		int val;
+
+		reg = rtk->regs + WRAP_USB_DBUS_PWR_CTRL_REG;
+		if (soc_device_match(rtk_soc_hw_clock_gating_quirk))
+			reg += 0x4;
+
+		val = DBUS_PWR_CTRL_EN | readl(reg);
+		writel(val, reg);
+	}
+
+	writel(DESC_R2W_MULTI_DISABLE | readl(regs + WRAP_CTR_REG),
+	       regs + WRAP_CTR_REG);
+
+	/* Set phy Dp/Dm initial state to host mode to avoid the Dp glitch */
+	writel(USB2_PHY_SWITCH_HOST |
+	       (~USB2_PHY_SWITCH_MASK &
+	       readl(rtk->regs + WRAP_USB2_PHY_REG)),
+	       rtk->regs + WRAP_USB2_PHY_REG);
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
+	int dr_mode;
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
+		return -ENODEV;
+	}
+
+	dwc3_pdev = of_find_device_by_node(dwc3_node);
+	if (!dwc3_pdev) {
+		dev_err(dev, "failed to find dwc3 core platform_device\n");
+		of_node_put(dwc3_node);
+		return -ENODEV;
+	}
+
+	dwc3_dev = &dwc3_pdev->dev;
+	rtk->dwc = platform_get_drvdata(dwc3_pdev);
+	if (!rtk->dwc) {
+		dev_err(dev, "failed to find dwc3 core\n");
+		of_node_put(dwc3_node);
+		return -ENODEV;
+	}
+
+	dr_mode = usb_get_dr_mode(dwc3_dev);
+	if (dr_mode != rtk->dwc->dr_mode) {
+		dev_info(dev, "dts set dr_mode=%d, but dwc3 set dr_mode=%d\n",
+			 dr_mode, rtk->dwc->dr_mode);
+		dr_mode = rtk->dwc->dr_mode;
+	}
+
+	rtk->cur_dr_mode = dr_mode;
+
+	if (device_property_read_bool(dwc3_dev, "usb-role-switch"))
+		rtk->support_drd_mode = true;
+	else
+		rtk->support_drd_mode = false;
+
+	if (rtk->support_drd_mode) {
+		dwc3_rtk_setup_role_switch(rtk);
+		rtk->cur_dr_mode = dwc3_rtk_get_dr_mode(rtk);
+	}
+
+	switch_usb2_dr_mode(rtk, rtk->cur_dr_mode);
+
+	of_node_put(dwc3_node);
+	platform_device_put(dwc3_pdev);
+
+	return ret;
+}
+
+static int dwc3_rtk_probe(struct platform_device *pdev)
+{
+	struct dwc3_rtk *rtk;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct resource *res;
+	void __iomem *regs;
+	int ret = 0;
+	unsigned long probe_time = jiffies;
+
+	rtk = devm_kzalloc(dev, sizeof(*rtk), GFP_KERNEL);
+	if (!rtk) {
+		ret = -ENOMEM;
+		goto err1;
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
+		goto err1;
+	}
+
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err1;
+	}
+
+	rtk->regs = regs;
+	rtk->regs_size = resource_size(res);
+
+	rtk->unlink_usb3_port = false;
+	if (of_property_read_bool(node, "realtek,unlink-usb3-port"))
+		rtk->unlink_usb3_port = true;
+
+	rtk->disable_usb3_phy = false;
+	if (of_property_read_bool(node, "realtek,disable-usb3-phy"))
+		rtk->disable_usb3_phy = true;
+
+	ret = dwc3_rtk_probe_dwc3_core(rtk);
+	if (ret) {
+		dev_err(dev, "%s failed to add dwc3 core\n", __func__);
+		goto err1;
+	}
+
+	dev_dbg(dev, "%s ok! (take %d ms)\n", __func__,
+		jiffies_to_msecs(jiffies - probe_time));
+
+	return 0;
+
+err1:
+	return ret;
+}
+
+static void dwc3_rtk_remove(struct platform_device *pdev)
+{
+	struct dwc3_rtk *rtk = platform_get_drvdata(pdev);
+
+	rtk->dwc = NULL;
+
+	if (rtk->support_drd_mode)
+		dwc3_rtk_remove_role_switch(rtk);
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
+	switch_usb2_dr_mode(rtk, rtk->cur_dr_mode);
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

