Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6E77750D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjHJJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjHJJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:57:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A410CF;
        Thu, 10 Aug 2023 02:57:08 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A6G8Cp012243;
        Thu, 10 Aug 2023 09:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=KU+4Q2s1497g3SHP38qNUcCPl71jlIaBprjPUFm6oSs=;
 b=Ca8JhZrVlknmjS52SUhsTGii+dK5WjmYsfbjKDxTyBv4qh248N0C1/wC3fWZfVQ30DMQ
 lUPbwDjok4pFFu9VaGJq6alKq20BkPgVgIrQlul3onFd9uz8NU+nPyLMFEhFym6xxcOQ
 jxpQ1AbYEp759Ws/b6eNgLFpKjlbyR6I5mMA8DzxAcSWC1/2Jd/nfoYguLaH/avw6t9x
 UKTqQI2Y9ASHK5EjtHjcRdOADbKBDvIPB0MiIqNIpDQFPm1pKWuvS7J/4BxaIA2Bzvo1
 C/OUi9lQ9NLjWCGd+Cn6/IwgB9p+WE/Xppm8LacWqQFOLCF2F5I7W1D4U6gHRjv2PpUm tA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc1ny3dvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A9ua3x019989
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:36 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 10 Aug 2023 02:56:30 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 2/5] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Date:   Thu, 10 Aug 2023 15:26:05 +0530
Message-ID: <b17b55b2ff2277bb9bfa99acdb2f98ed420dfb6e.1691660905.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1691660905.git.quic_varada@quicinc.com>
References: <cover.1691660905.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C3ttlCIMWpzPMyYTR6lzam9JHAxBYxqF
X-Proofpoint-ORIG-GUID: C3ttlCIMWpzPMyYTR6lzam9JHAxBYxqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_09,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the M31 USB2 phy driver.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6:
	Kconfig:Add COMPILE_TEST and remove USB_GADGET from 'depends'
		Change 'selects' USB_PHY -> GENERIC_PHY
	Driver:	Use correct headers
		const int -> unsigned int for 'nregs' in private data
		Use generic names for clk, phy in m31 phy structure
		Init register details directly instead of using macro
		Use dev_err_probe in the error paths of driver probe
v5:
	Kconfig and Makefile:- place snippet according to sorted order
	Use generic phy instead of usb-phy
	Use ARRAY_SIZE for reg init instead of blank last entry
	Fix copyright year

v4:
	Remove unused enum
	Error handling for devm_clk_get
v1:
	Combine driver, makefile and kconfig into 1 patch
	Remove 'qscratch' region and its usage. The controller driver takes care
	of those settings
	Use compatible/data to handle ipq5332 init
	Drop the default case
	Get resources by index instead of name as there is only one resource
	Add clock
	Fix review comments in the driver
---
 drivers/phy/qualcomm/Kconfig        |  11 ++
 drivers/phy/qualcomm/Makefile       |   1 +
 drivers/phy/qualcomm/phy-qcom-m31.c | 248 ++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index ced6038..d891058 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -143,6 +143,17 @@ config PHY_QCOM_EUSB2_REPEATER
 	  PMICs. The repeater is paired with a Synopsys eUSB2 Phy
 	  on Qualcomm SOCs.
 
+config PHY_QCOM_M31_USB
+	tristate "Qualcomm M31 HS PHY driver support"
+	depends on USB && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable this to support M31 HS PHY transceivers on Qualcomm chips
+	  with DWC3 USB core. It handles PHY initialization, clock
+	  management required after resetting the hardware and power
+	  management. This driver is required even for peripheral only or
+	  host only mode configurations.
+
 config PHY_QCOM_USB_HS
 	tristate "Qualcomm USB HS PHY module"
 	depends on USB_ULPI_BUS
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index df94581..ffd609a 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
 obj-$(CONFIG_PHY_QCOM_EDP)		+= phy-qcom-edp.o
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)	+= phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
+obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
 obj-$(CONFIG_PHY_QCOM_PCIE2)		+= phy-qcom-pcie2.o
 
 obj-$(CONFIG_PHY_QCOM_QMP_COMBO)	+= phy-qcom-qmp-combo.o
diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
new file mode 100644
index 0000000..d6a8d06
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2014-2023, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#define USB2PHY_PORT_UTMI_CTRL1		0x40
+
+#define USB2PHY_PORT_UTMI_CTRL2		0x44
+ #define UTMI_ULPI_SEL			BIT(7)
+ #define UTMI_TEST_MUX_SEL		BIT(6)
+
+#define HS_PHY_CTRL_REG			0x10
+ #define UTMI_OTG_VBUS_VALID		BIT(20)
+ #define SW_SESSVLD_SEL			BIT(28)
+
+#define USB_PHY_UTMI_CTRL0		0x3c
+
+#define USB_PHY_UTMI_CTRL5		0x50
+ #define POR_EN				BIT(1)
+
+#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
+ #define COMMONONN			BIT(7)
+ #define FSEL				BIT(4)
+ #define RETENABLEN			BIT(3)
+ #define FREQ_24MHZ			(GENMASK(6, 6) | GENMASK(4, 4))
+
+#define USB_PHY_HS_PHY_CTRL2		0x64
+ #define USB2_SUSPEND_N_SEL		BIT(3)
+ #define USB2_SUSPEND_N			BIT(2)
+ #define USB2_UTMI_CLK_EN		BIT(1)
+
+#define USB_PHY_CFG0			0x94
+ #define UTMI_PHY_OVERRIDE_EN		BIT(1)
+
+#define USB_PHY_REFCLK_CTRL		0xa0
+ #define CLKCORE			BIT(1)
+
+#define USB2PHY_PORT_POWERDOWN		0xa4
+ #define POWER_UP			BIT(0)
+ #define POWER_DOWN			0
+
+#define USB_PHY_FSEL_SEL		0xb8
+ #define FREQ_SEL			BIT(0)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_1	0xbc
+ #define USB2_0_TX_ENABLE		BIT(2)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_4	0xc8
+ #define HSTX_SLEW_RATE_565PS		GENMASK(1, 0)
+ #define PLL_CHARGING_PUMP_CURRENT_35UA	GENMASK(4, 3)
+ #define ODT_VALUE_38_02_OHM		GENMASK(7, 6)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_5	0xcc
+ #define ODT_VALUE_45_02_OHM		BIT(2)
+ #define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	BIT(0)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_11	0xe4
+ #define XCFG_COARSE_TUNE_NUM		BIT(1)
+ #define XCFG_FINE_TUNE_NUM		BIT(3)
+
+struct m31_phy_regs {
+	u32 off;
+	u32 val;
+	u32 delay;
+};
+
+struct m31_priv_data {
+	bool				ulpi_mode;
+	const struct m31_phy_regs	*regs;
+	unsigned int			nregs;
+};
+
+struct m31_phy_regs m31_ipq5332_regs[] = {
+	{ USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0 },
+	{ USB_PHY_UTMI_CTRL5, POR_EN, 15 },
+	{ USB_PHY_FSEL_SEL, FREQ_SEL, 0 },
+	{ USB_PHY_HS_PHY_CTRL_COMMON0, COMMONONN | FREQ_24MHZ | RETENABLEN, 0 },
+	{ USB_PHY_UTMI_CTRL5, POR_EN, 0 },
+	{ USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0 },
+	{ USB2PHY_USB_PHY_M31_XCFGI_11, XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM, 0 },
+	{ USB2PHY_USB_PHY_M31_XCFGI_4, HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
+				       ODT_VALUE_38_02_OHM, 0 },
+	{ USB2PHY_USB_PHY_M31_XCFGI_1, USB2_0_TX_ENABLE, 0 },
+	{ USB2PHY_USB_PHY_M31_XCFGI_5, ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA, 4 },
+	{ USB_PHY_UTMI_CTRL5, 0x0, 0 },
+	{ USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0 },
+};
+
+struct m31usb_phy {
+	struct phy			*phy;
+	void __iomem			*base;
+	const struct m31_phy_regs	*regs;
+	int				nregs;
+
+	struct regulator		*vreg;
+	struct clk			*clk;
+	struct reset_control		*reset;
+
+	bool				ulpi_mode;
+};
+
+static int m31usb_phy_init(struct phy *phy)
+{
+	struct m31usb_phy *qphy = phy_get_drvdata(phy);
+	const struct m31_phy_regs *regs = qphy->regs;
+	int i, ret;
+
+	ret = regulator_enable(qphy->vreg);
+	if (ret) {
+		dev_err(&phy->dev, "failed to enable regulator, %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(qphy->clk);
+	if (ret) {
+		if (qphy->vreg)
+			regulator_disable(qphy->vreg);
+		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		return ret;
+	}
+
+	/* Perform phy reset */
+	reset_control_assert(qphy->reset);
+	udelay(5);
+	reset_control_deassert(qphy->reset);
+
+	/* configure for ULPI mode if requested */
+	if (qphy->ulpi_mode)
+		writel(0x0, qphy->base + USB2PHY_PORT_UTMI_CTRL2);
+
+	/* Enable the PHY */
+	writel(POWER_UP, qphy->base + USB2PHY_PORT_POWERDOWN);
+
+	/* Turn on phy ref clock */
+	for (i = 0; i < qphy->nregs; i++) {
+		writel(regs[i].val, qphy->base + regs[i].off);
+		if (regs[i].delay)
+			udelay(regs[i].delay);
+	}
+
+	return 0;
+}
+
+static int m31usb_phy_shutdown(struct phy *phy)
+{
+	struct m31usb_phy *qphy = phy_get_drvdata(phy);
+
+	/* Disable the PHY */
+	writel_relaxed(POWER_DOWN, qphy->base + USB2PHY_PORT_POWERDOWN);
+
+	clk_disable_unprepare(qphy->clk);
+
+	regulator_disable(qphy->vreg);
+
+	return 0;
+}
+
+static const struct phy_ops m31usb_phy_gen_ops = {
+	.power_on	= m31usb_phy_init,
+	.power_off	= m31usb_phy_shutdown,
+	.owner		= THIS_MODULE,
+};
+
+static int m31usb_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	const struct m31_priv_data *data;
+	struct device *dev = &pdev->dev;
+	struct m31usb_phy *qphy;
+
+	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
+	if (!qphy)
+		return -ENOMEM;
+
+	qphy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qphy->base))
+		return PTR_ERR(qphy->base);
+
+	qphy->reset = devm_reset_control_get_exclusive_by_index(dev, 0);
+	if (IS_ERR(qphy->reset))
+		return PTR_ERR(qphy->reset);
+
+	qphy->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(qphy->clk))
+		return dev_err_probe(dev, PTR_ERR(qphy->clk),
+						"failed to get clk\n");
+
+	data = of_device_get_match_data(dev);
+	qphy->regs		= data->regs;
+	qphy->nregs		= data->nregs;
+	qphy->ulpi_mode		= data->ulpi_mode;
+
+	qphy->phy = devm_phy_create(dev, NULL, &m31usb_phy_gen_ops);
+	if (IS_ERR(qphy->phy))
+		return dev_err_probe(dev, PTR_ERR(qphy->phy),
+						"failed to create phy\n");
+
+	qphy->vreg = devm_regulator_get(dev, "vdda-phy");
+	if (IS_ERR(qphy->vreg))
+		return dev_err_probe(dev, PTR_ERR(qphy->phy),
+						"failed to get vreg\n");
+
+	phy_set_drvdata(qphy->phy, qphy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (!IS_ERR(phy_provider))
+		dev_info(dev, "Registered M31 USB phy\n");
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct m31_priv_data m31_ipq5332_data = {
+	.ulpi_mode = false,
+	.regs = m31_ipq5332_regs,
+	.nregs = ARRAY_SIZE(m31_ipq5332_regs),
+};
+
+static const struct of_device_id m31usb_phy_id_table[] = {
+	{ .compatible = "qcom,ipq5332-usb-hsphy", .data = &m31_ipq5332_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, m31usb_phy_id_table);
+
+static struct platform_driver m31usb_phy_driver = {
+	.probe = m31usb_phy_probe,
+	.driver = {
+		.name = "qcom-m31usb-phy",
+		.of_match_table = m31usb_phy_id_table,
+	},
+};
+
+module_platform_driver(m31usb_phy_driver);
+
+MODULE_DESCRIPTION("USB2 Qualcomm M31 HSPHY driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

