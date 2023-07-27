Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61E765FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjG0Wel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjG0Wed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:34:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6A30F4;
        Thu, 27 Jul 2023 15:34:06 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RMUUC8007491;
        Thu, 27 Jul 2023 22:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=AYcny/53hY52cWTE7ag90lTf0NNuwpwG2MUncJh7ew8=;
 b=in8s+YeTIDVxcol3wGr48wk4jwhW76vpuNC5kvhuS9A00ssXe5ZA2CoL0PUoyoc/bI+E
 QLi8wfl9qSyMuDi3A97TMz++4uzYYJBXh3X9MeoGNEk3lJ2DphMDH4VBxo1+o1T6KKNg
 PBqUsExiyzru0uDkcB3FKnFAeEsiSWxLCC02yFF2jQd0b2nijwmrVihzIHEGzpimxGX8
 2sbDDrxpBXjo2IFxC8AMZrjnGMYNr8rpsE1exOWx5eywsLNIlMh0X5xIrafd+V3KW06D
 6KCghfnUlWeTPdq/OIaguR5O1eFNQ6xZSItvSWEqHF8lUxBMIXTOGpiB7oj9iS/z+hpv Zw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3mpt20ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 22:33:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RMXf8D010731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 22:33:41 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 15:33:35 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v10 03/11] usb: dwc3: core: Access XHCI address space temporarily to read port info
Date:   Fri, 28 Jul 2023 04:02:59 +0530
Message-ID: <20230727223307.8096-4-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230727223307.8096-1-quic_kriskura@quicinc.com>
References: <20230727223307.8096-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M1hyEZhHN7TeBi-cUTvKdW0U28v_z-Xf
X-Proofpoint-GUID: M1hyEZhHN7TeBi-cUTvKdW0U28v_z-Xf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307270205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently host-only capable DWC3 controllers support Multiport.
Temporarily map XHCI address space for host-only controllers and parse
XHCI Extended Capabilities registers to read number of usb2 ports and
usb3 ports present on multiport controller. Each USB Port is at least HS
capable.

Since the extcaps header is only being used, move port_count related
macros and structure from xhci.h to xhci-ext-caps.h.

The port info for usb2 and usb3 phy are identified as num_usb2_ports
and num_usb3_ports. The intention is as follows:

Wherever we need to perform phy operations like:

LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
{
	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
}

If number of usb2 ports is 3, loop can go from index 0-2 for
usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
if the first 2 ports are SS capable or some other ports like (2 and 3)
are SS capable. So instead, num_usb2_ports is used to loop around all
phy's (both hs and ss) for performing phy operations. If any
usb3_generic_phy turns out to be NULL, phy operation just bails out.

num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
phy's as we need to know how many SS capable ports are there for this.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c          | 61 ++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h          |  5 +++
 drivers/usb/host/xhci-ext-caps.h | 27 ++++++++++++++
 drivers/usb/host/xhci.h          | 27 --------------
 4 files changed, 93 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f6689b731718..edc79ce70588 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include "io.h"
 
 #include "debug.h"
+#include "../host/xhci-ext-caps.h"
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
@@ -1767,6 +1768,51 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_read_port_info(struct dwc3 *dwc)
+{
+	void __iomem *base;
+	u8 major_revision;
+	u32 offset = 0;
+	u32 val;
+
+	/*
+	 * Remap xHCI address space to access XHCI ext cap regs,
+	 * since it is needed to get port info.
+	 */
+	base = ioremap(dwc->xhci_resources[0].start,
+				resource_size(&dwc->xhci_resources[0]));
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	do {
+		offset = xhci_find_next_ext_cap(base, offset,
+				XHCI_EXT_CAPS_PROTOCOL);
+		if (!offset)
+			break;
+
+		val = readl(base + offset);
+		major_revision = XHCI_EXT_PORT_MAJOR(val);
+
+		val = readl(base + offset + 0x08);
+		if (major_revision == 0x03) {
+			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
+		} else if (major_revision <= 0x02) {
+			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
+		} else {
+			dev_err(dwc->dev,
+				"Unrecognized port major revision %d\n",
+							major_revision);
+		}
+	} while (1);
+
+	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
+			dwc->num_usb2_ports, dwc->num_usb3_ports);
+
+	iounmap(base);
+
+	return 0;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -1774,6 +1820,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	void __iomem		*regs;
 	struct dwc3		*dwc;
 	int			ret;
+	unsigned int		hw_mode;
 
 	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
@@ -1854,6 +1901,20 @@ static int dwc3_probe(struct platform_device *pdev)
 			goto err_disable_clks;
 	}
 
+	/*
+	 * Currently only DWC3 controllers that are host-only capable
+	 * support Multiport.
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_read_port_info(dwc);
+		if (ret)
+			goto err_disable_clks;
+	} else {
+		dwc->num_usb2_ports = 1;
+		dwc->num_usb3_ports = 1;
+	}
+
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8b1295e4dcdd..0840808e8a40 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1029,6 +1029,8 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @num_usb2_ports: number of USB2 ports
+ * @num_usb3_ports: number of USB3 ports
  * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
  * @ulpi_ready: flag to indicate that ULPI is initialized
@@ -1168,6 +1170,9 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	u8			num_usb2_ports;
+	u8			num_usb3_ports;
+
 	bool			phys_ready;
 
 	struct ulpi		*ulpi;
diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index e8af0a125f84..96eb36a58738 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -79,6 +79,33 @@
 /* true: Controller Not Ready to accept doorbell or op reg writes after reset */
 #define XHCI_STS_CNR		(1 << 11)
 
+/**
+ * struct xhci_protocol_caps
+ * @revision:		major revision, minor revision, capability ID,
+ *			and next capability pointer.
+ * @name_string:	Four ASCII characters to say which spec this xHC
+ *			follows, typically "USB ".
+ * @port_info:		Port offset, count, and protocol-defined information.
+ */
+struct xhci_protocol_caps {
+	u32	revision;
+	u32	name_string;
+	u32	port_info;
+};
+
+#define	XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
+#define	XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
+#define	XHCI_EXT_PORT_PSIC(x)	(((x) >> 28) & 0x0f)
+#define	XHCI_EXT_PORT_OFF(x)	((x) & 0xff)
+#define	XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
+
+#define	XHCI_EXT_PORT_PSIV(x)	(((x) >> 0) & 0x0f)
+#define	XHCI_EXT_PORT_PSIE(x)	(((x) >> 4) & 0x03)
+#define	XHCI_EXT_PORT_PLT(x)	(((x) >> 6) & 0x03)
+#define	XHCI_EXT_PORT_PFD(x)	(((x) >> 8) & 0x01)
+#define	XHCI_EXT_PORT_LP(x)	(((x) >> 14) & 0x03)
+#define	XHCI_EXT_PORT_PSIM(x)	(((x) >> 16) & 0xffff)
+
 #include <linux/io.h>
 
 /**
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..77016338bee1 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -558,33 +558,6 @@ struct xhci_doorbell_array {
 #define DB_VALUE(ep, stream)	((((ep) + 1) & 0xff) | ((stream) << 16))
 #define DB_VALUE_HOST		0x00000000
 
-/**
- * struct xhci_protocol_caps
- * @revision:		major revision, minor revision, capability ID,
- *			and next capability pointer.
- * @name_string:	Four ASCII characters to say which spec this xHC
- *			follows, typically "USB ".
- * @port_info:		Port offset, count, and protocol-defined information.
- */
-struct xhci_protocol_caps {
-	u32	revision;
-	u32	name_string;
-	u32	port_info;
-};
-
-#define	XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
-#define	XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
-#define	XHCI_EXT_PORT_PSIC(x)	(((x) >> 28) & 0x0f)
-#define	XHCI_EXT_PORT_OFF(x)	((x) & 0xff)
-#define	XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
-
-#define	XHCI_EXT_PORT_PSIV(x)	(((x) >> 0) & 0x0f)
-#define	XHCI_EXT_PORT_PSIE(x)	(((x) >> 4) & 0x03)
-#define	XHCI_EXT_PORT_PLT(x)	(((x) >> 6) & 0x03)
-#define	XHCI_EXT_PORT_PFD(x)	(((x) >> 8) & 0x01)
-#define	XHCI_EXT_PORT_LP(x)	(((x) >> 14) & 0x03)
-#define	XHCI_EXT_PORT_PSIM(x)	(((x) >> 16) & 0xffff)
-
 #define PLT_MASK        (0x03 << 6)
 #define PLT_SYM         (0x00 << 6)
 #define PLT_ASYM_RX     (0x02 << 6)
-- 
2.40.0

