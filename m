Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFAF75BD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGUEhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGUEg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:36:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0604F2D53;
        Thu, 20 Jul 2023 21:36:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L4Aia8017058;
        Fri, 21 Jul 2023 04:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rCHEV2mDgjw1NhIEC1Xs4Wq2mRyDSQx9Ia6U74mbGyU=;
 b=Bdh+g9HU3wblmp8p+s+zmlvK94B/Tg1GROwUMNQ+oZoKMaakPJ3HJ5li61bVOx9p3Bvf
 TPxs8TQZdBaQub+8YhF3mK2FfP/CjVghDX/UXUVi3Ck6z5g7BRlN9z2dydv49yXIo0R2
 ChyzEfhzCq+DBbA5Ttk2RKxv+dPlHg0pT+jtcjdJaMtbdHK04KAYnesBe8VnjaAZ3mtV
 ywOKLuMv8D91LNi0qGuaO4869qOjTp+qjkoS/s5P4snvL2EsUfTgl0tp6fxEX4V5graD
 59vyR3ICOZAMWktQ1i4eHBWVMm5pMHnM8s5H7mUMSrh5Z1aIrFfUu6VxhiP2FJFZYqhb dQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryfyf0awd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:36:09 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L4a8rG025724
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:36:08 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 21:36:00 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 3/6] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Date:   Fri, 21 Jul 2023 10:05:28 +0530
Message-ID: <068a44b38a01740b06ea3646611c8dfdacf3f7b0.1689913334.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1689913334.git.quic_varada@quicinc.com>
References: <cover.1689913334.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OP3EHA9qSjsbQBDw8LzOWuV1Bpe2VAIn
X-Proofpoint-ORIG-GUID: OP3EHA9qSjsbQBDw8LzOWuV1Bpe2VAIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_01,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the M31 USB2 phy driver.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
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
 drivers/phy/qualcomm/phy-qcom-m31.c | 264 ++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index ced6038..d638906 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -143,6 +143,17 @@ config PHY_QCOM_EUSB2_REPEATER
 	  PMICs. The repeater is paired with a Synopsys eUSB2 Phy
 	  on Qualcomm SOCs.
 
+config PHY_QCOM_M31_USB
+	tristate "Qualcomm M31 HS PHY driver support"
+	depends on (USB || USB_GADGET) && ARCH_QCOM
+	select USB_PHY
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
index 0000000..4627425
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2014-2016, 2020-2023, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/usb/of.h>
+#include <linux/usb/phy.h>
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
+	const int			nregs;
+};
+
+#define M31_REG(__o, __v, __d)	\
+	{ .off = __o, .val = __v, .delay = __d }
+
+struct m31_phy_regs m31_ipq5332_regs[] = {
+	M31_REG(USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0),
+	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN, 15),
+	M31_REG(USB_PHY_FSEL_SEL, FREQ_SEL, 0),
+	M31_REG(USB_PHY_HS_PHY_CTRL_COMMON0,
+		COMMONONN | FREQ_24MHZ | RETENABLEN, 0),
+	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN, 0),
+	M31_REG(USB_PHY_HS_PHY_CTRL2,
+		USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_11,
+		XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_4,
+		HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
+		ODT_VALUE_38_02_OHM, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_1, USB2_0_TX_ENABLE, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_5,
+		ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA, 4),
+	M31_REG(USB_PHY_UTMI_CTRL5, 0x0, 0),
+	M31_REG(USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),
+};
+
+struct m31usb_phy {
+	struct phy			*phy;
+	void __iomem			*base;
+	const struct m31_phy_regs	*regs;
+	int				nregs;
+
+	struct clk			*cfg_ahb_clk;
+	struct reset_control		*phy_reset;
+
+	bool				cable_connected;
+	bool				suspended;
+	bool				ulpi_mode;
+};
+
+static void m31usb_phy_enable_clock(struct m31usb_phy *qphy)
+{
+	const struct m31_phy_regs *regs = qphy->regs;
+	int i;
+
+	for (i = 0; i < qphy->nregs; i++) {
+		writel(regs[i].val, qphy->base + regs[i].off);
+		if (regs[i].delay)
+			udelay(regs[i].delay);
+	}
+}
+
+static int m31usb_phy_init(struct phy *phy)
+{
+	int ret;
+	struct m31usb_phy *qphy = phy_get_drvdata(phy);
+
+	ret = clk_prepare_enable(qphy->cfg_ahb_clk);
+	if (ret) {
+		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		return ret;
+	}
+
+	/* Perform phy reset */
+	reset_control_assert(qphy->phy_reset);
+	udelay(5);
+	reset_control_deassert(qphy->phy_reset);
+
+	/* configure for ULPI mode if requested */
+	if (qphy->ulpi_mode)
+		writel(0x0, qphy->base + USB2PHY_PORT_UTMI_CTRL2);
+
+	/* Enable the PHY */
+	writel(POWER_UP, qphy->base + USB2PHY_PORT_POWERDOWN);
+
+	/* Make sure above write completed */
+	wmb();
+
+	/* Turn on phy ref clock */
+	m31usb_phy_enable_clock(qphy);
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
+	/* Make sure above write completed */
+	wmb();
+
+	clk_disable_unprepare(qphy->cfg_ahb_clk);
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
+	const struct m31_priv_data *data;
+	struct device *dev = &pdev->dev;
+	struct m31usb_phy *qphy;
+	struct phy_provider *phy_provider;
+	int ret;
+
+	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
+	if (!qphy)
+		return -ENOMEM;
+
+	qphy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qphy->base))
+		return PTR_ERR(qphy->base);
+
+	qphy->phy_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
+	if (IS_ERR(qphy->phy_reset))
+		return PTR_ERR(qphy->phy_reset);
+
+	qphy->cfg_ahb_clk = devm_clk_get(dev, "cfg_ahb");
+	if (IS_ERR(qphy->cfg_ahb_clk)) {
+		ret = PTR_ERR(qphy->cfg_ahb_clk);
+		dev_err(dev, "failed to get cfg_ahb clock, %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, qphy);
+
+	data = of_device_get_match_data(dev);
+	qphy->regs		= data->regs;
+	qphy->nregs		= data->nregs;
+	qphy->ulpi_mode		= data->ulpi_mode;
+
+	qphy->phy = devm_phy_create(dev, NULL, &m31usb_phy_gen_ops);
+	if (IS_ERR(qphy->phy)) {
+		ret = PTR_ERR(qphy->phy);
+		dev_err(dev, "failed to create phy, %d\n", ret);
+		qphy->phy = NULL;
+		return ret;
+	}
+
+	dev_set_drvdata(dev, qphy);
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
+	.probe		= m31usb_phy_probe,
+	.driver = {
+		.name	= "qcom-m31usb-phy",
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

