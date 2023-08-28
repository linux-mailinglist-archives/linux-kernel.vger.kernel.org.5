Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9528278B1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjH1Nby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjH1Nbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:31:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61180B9;
        Mon, 28 Aug 2023 06:31:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SCvCQK026485;
        Mon, 28 Aug 2023 13:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=hsDLfXDFoifE+Xht/EkpdnDqlFdnxup28A/lfFHe4Y4=;
 b=S5kB7/VD/EnKuxWzGfNcn++wGL3a+aVqQBoeovu1Dcwe+aYMJtLEjB8LwIunTnyryK4A
 ppm3a4Kyze7RqeTXl927Ab6miZpqxtvZAqgUFCwCuEv9j3evVgZ/9Jdx2zCRTqGEUgfw
 bwLcqSLbGYznkxTJASMV05Q3T/AW7rHZu6ypsg3z7RewLvYtO9zMxk3EGcDk6PF+kJvo
 kc50hIKH8alecsidc1zMkNlnXwaAyz6bAbo6/YE+GAS5lwL634IxrAOUIJyLOcyWGu89
 cxZFOUrzlQGAGdpmqDUnfyKj0h3k14bep+UCgrhYYe+7/iRrbZ6T0mAps+0uY+ibAfm2 6g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqapfkn74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SDVGBC024334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:16 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 06:31:10 -0700
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
Subject: [PATCH v11 04/13] usb: dwc3: core: Access XHCI address space temporarily to read port info
Date:   Mon, 28 Aug 2023 19:00:24 +0530
Message-ID: <20230828133033.11988-5-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230828133033.11988-1-quic_kriskura@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NS8XU1YBSK_YF8ZxtrN9qrSMZjbyNbtN
X-Proofpoint-GUID: NS8XU1YBSK_YF8ZxtrN9qrSMZjbyNbtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_10,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/dwc3/core.c | 61 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  5 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..85cebeb6d662 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include "io.h"
 
 #include "debug.h"
+#include "../host/xhci-ext-caps.h"
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
@@ -1751,6 +1752,51 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
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
@@ -1758,6 +1804,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	void __iomem		*regs;
 	struct dwc3		*dwc;
 	int			ret;
+	unsigned int		hw_mode;
 
 	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
@@ -1838,6 +1885,20 @@ static int dwc3_probe(struct platform_device *pdev)
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
index a69ac67d89fe..5b0f2aa115d2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1026,6 +1026,8 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @num_usb2_ports: number of USB2 ports
+ * @num_usb3_ports: number of USB3 ports
  * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
  * @ulpi_ready: flag to indicate that ULPI is initialized
@@ -1165,6 +1167,9 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	u8			num_usb2_ports;
+	u8			num_usb3_ports;
+
 	bool			phys_ready;
 
 	struct ulpi		*ulpi;
-- 
2.40.0

