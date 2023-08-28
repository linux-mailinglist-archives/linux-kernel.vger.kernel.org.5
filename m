Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E644E78B1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjH1NcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjH1NcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:32:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9089A7;
        Mon, 28 Aug 2023 06:31:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SBKbEs010222;
        Mon, 28 Aug 2023 13:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=k6IUSa+uGFs5xf9uiZLtsgKAVhzYVl08ylSK53UWfe0=;
 b=FMLPUp0uP3f5j52GqUhHs0S8km3h3Ylh9N9ELBv7gma4YcwOmzM4/3x4ltgDhOvhfluO
 IhDJppu0MahsMe+inquH/cVI1ce3mp7M/kIH0hEt+atmdoIgh5dBTprzoAtdkQF5z/YW
 ojiXZPe2+DyPb61QirlPK38ukiWcZrFKeuZPShD8LhssP5mieNsF4zyEQ/dBLTO738hQ
 ez+u0PYbbPQQfJpq61UoSRM6+UgdiOK9CvgmfAbi4E4FAIDEP4xMKOgO/kHHHZXv45WK
 9BF3IANaWSzwVCNLw8Qu7rCk0cysvTAVNwAcDFX/ZQQ35PhyuLdUwizFZ/xClbSYpmhv 3A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqapfkn83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SDVhBr006707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:43 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 06:31:36 -0700
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
Subject: [PATCH v11 08/13] usb: dwc3: qcom: Refactor IRQ handling in QCOM Glue driver
Date:   Mon, 28 Aug 2023 19:00:28 +0530
Message-ID: <20230828133033.11988-9-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TqMpum04mbwDdawbwVjKEWfXzmdR6NMR
X-Proofpoint-GUID: TqMpum04mbwDdawbwVjKEWfXzmdR6NMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_10,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=904 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
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

Refactor setup_irq call to facilitate reading multiport IRQ's along
with non mulitport ones. Read through the interrupt-names property
to figure out, the type of interrupt (DP/DM/HS/SS) and to which port
it belongs. Also keep track of port index to calculate port count
based on interrupts provided as input in DT.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 215 +++++++++++++++++++++++++----------
 1 file changed, 155 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index f14ddc9c541d..05990142cbc8 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -53,14 +53,24 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
+#define NUM_PHY_IRQ		4
+
+#define DP_HS_PHY_IRQ_INDEX	0
+#define DM_HS_PHY_IRQ_INDEX	1
+#define SS_PHY_IRQ_INDEX	2
+#define HS_PHY_IRQ_INDEX	3
+
 struct dwc3_acpi_pdata {
 	u32			qscratch_base_offset;
 	u32			qscratch_base_size;
 	u32			dwc3_core_base_size;
+
+	/*
+	 * The phy_irq_index corresponds to ACPI indexes of (in order) DP/DM/SS
+	 * IRQ's respectively.
+	 */
+	int			phy_irq_index[NUM_PHY_IRQ - 1];
 	int			hs_phy_irq_index;
-	int			dp_hs_phy_irq_index;
-	int			dm_hs_phy_irq_index;
-	int			ss_phy_irq_index;
 	bool			is_urs;
 };
 
@@ -73,10 +83,12 @@ struct dwc3_qcom {
 	int			num_clocks;
 	struct reset_control	*resets;
 
+	/*
+	 * The phy_irq corresponds to IRQ's registered for (in order) DP/DM/SS
+	 * respectively.
+	 */
+	int			phy_irq[NUM_PHY_IRQ - 1][DWC3_MAX_PORTS];
 	int			hs_phy_irq;
-	int			dp_hs_phy_irq;
-	int			dm_hs_phy_irq;
-	int			ss_phy_irq;
 	enum usb_device_speed	usb2_speed;
 
 	struct extcon_dev	*edev;
@@ -91,6 +103,8 @@ struct dwc3_qcom {
 	bool			pm_suspended;
 	struct icc_path		*icc_path_ddr;
 	struct icc_path		*icc_path_apps;
+
+	int			num_ports;
 };
 
 static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
@@ -375,16 +389,16 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
 	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
+		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
 	}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][0]);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
@@ -401,20 +415,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 */
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
+		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0],
 						IRQ_TYPE_EDGE_FALLING);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
+		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0],
 						IRQ_TYPE_EDGE_FALLING);
 	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
+		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0],
 						IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
+		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0],
 						IRQ_TYPE_EDGE_RISING);
 	}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][0], 0);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -535,8 +549,8 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
 	return ret;
 }
 
-static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
-				char *disp_name, int irq)
+static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, const char *irq_name,
+				const char *disp_name, int irq)
 {
 	int ret;
 
@@ -553,51 +567,136 @@ static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
 	return ret;
 }
 
+static int dwc3_qcom_get_irq_index(const char *irq_name)
+{
+	/*
+	 * If we are reading IRQ not supported by the driver
+	 * like pwr_event_irq, then return -1 indicating the next
+	 * helper function to skip processing IRQ name further.
+	 */
+	int irq_index = -1;
+
+	if (strncmp(irq_name, "dp_hs_phy", strlen("dp_hs_phy")) == 0)
+		irq_index = DP_HS_PHY_IRQ_INDEX;
+	else if (strncmp(irq_name, "dm_hs_phy", strlen("dm_hs_phy")) == 0)
+		irq_index = DM_HS_PHY_IRQ_INDEX;
+	else if (strncmp(irq_name, "ss_phy", strlen("ss_phy")) == 0)
+		irq_index = SS_PHY_IRQ_INDEX;
+	else if (strncmp(irq_name, "hs_phy", strlen("hs_phy")) == 0)
+		irq_index = HS_PHY_IRQ_INDEX;
+
+	return irq_index;
+}
+
+static int dwc3_qcom_get_port_index(const char *irq_name, int irq_index)
+{
+	int port_index = -1;
+
+	switch (irq_index) {
+	case DP_HS_PHY_IRQ_INDEX:
+		if (strcmp(irq_name, "dp_hs_phy_irq") == 0)
+			port_index = 1;
+		else
+			sscanf(irq_name, "dp_hs_phy_%d", &port_index);
+		break;
+
+	case DM_HS_PHY_IRQ_INDEX:
+		if (strcmp(irq_name, "dm_hs_phy_irq") == 0)
+			port_index = 1;
+		else
+			sscanf(irq_name, "dm_hs_phy_%d", &port_index);
+		break;
+
+	case SS_PHY_IRQ_INDEX:
+		if (strcmp(irq_name, "ss_phy_irq") == 0)
+			port_index = 1;
+		else
+			sscanf(irq_name, "ss_phy_%d", &port_index);
+		break;
+
+	case HS_PHY_IRQ_INDEX:
+		port_index = 1;
+		break;
+	}
+
+	if (port_index > DWC3_MAX_PORTS)
+		port_index = -1;
+
+	return port_index;
+}
+
+static int dwc3_qcom_get_acpi_index(struct dwc3_qcom *qcom, int irq_index,
+					int port_index)
+{
+	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
+	int acpi_index = -1;
+
+	/*
+	 * Currently multiport supported targets don't have an ACPI variant.
+	 * So return -1 if we are not dealing with first port of the controller.
+	 */
+	if ((pdata == NULL) || (port_index != 1))
+		goto done;
+
+	if (irq_index == HS_PHY_IRQ_INDEX)
+		acpi_index = pdata->hs_phy_irq_index;
+	else
+		acpi_index = pdata->phy_irq_index[irq_index];
+
+done:
+	return acpi_index;
+}
+
 static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
-	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
+	struct device_node *np = pdev->dev.of_node;
+	const char **irq_names;
+	int port_index;
+	int acpi_index;
+	int irq_count;
+	int irq_index;
 	int irq;
 	int ret;
+	int i;
 
-	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
-				pdata ? pdata->hs_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq",
-						"qcom_dwc3 HS", irq);
-		if (ret)
-			return ret;
-		qcom->hs_phy_irq = irq;
-	}
+	irq_count = of_property_count_strings(np, "interrupt-names");
+	irq_names = devm_kzalloc(&pdev->dev, sizeof(*irq_names) * irq_count, GFP_KERNEL);
+	if (!irq_names)
+		return -ENOMEM;
 
-	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
-				pdata ? pdata->dp_hs_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_prep_irq(qcom, "dp_hs_phy_irq",
-						"qcom_dwc3 DP_HS", irq);
-		if (ret)
-			return ret;
-		qcom->dp_hs_phy_irq = irq;
-	}
+	ret = of_property_read_string_array(np, "interrupt-names",
+						irq_names, irq_count);
+	for (i = 0; i < irq_count; i++) {
+		irq_index = dwc3_qcom_get_irq_index(irq_names[i]);
+		if (irq_index == -1) {
+			dev_dbg(&pdev->dev, "Invalid IRQ not handled");
+			continue;
+		}
 
-	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
-				pdata ? pdata->dm_hs_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_prep_irq(qcom, "dm_hs_phy_irq",
-						"qcom_dwc3 DM_HS", irq);
-		if (ret)
-			return ret;
-		qcom->dm_hs_phy_irq = irq;
-	}
+		port_index = dwc3_qcom_get_port_index(irq_names[i], irq_index);
+		if (port_index == -1) {
+			dev_dbg(&pdev->dev, "Port index invalid. IRQ not handled");
+			continue;
+		}
 
-	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
-				pdata ? pdata->ss_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_prep_irq(qcom, "ss_phy_irq",
-						"qcom_dwc3 SS", irq);
-		if (ret)
-			return ret;
-		qcom->ss_phy_irq = irq;
+		acpi_index = dwc3_qcom_get_acpi_index(qcom, irq_index, port_index);
+
+		irq = dwc3_qcom_get_irq(pdev, irq_names[i], acpi_index);
+		if (irq > 0) {
+			ret = dwc3_qcom_prep_irq(qcom, irq_names[i],
+							irq_names[i], irq);
+			if (ret)
+				return ret;
+
+			if (irq_index == HS_PHY_IRQ_INDEX)
+				qcom->hs_phy_irq = irq;
+			else
+				qcom->phy_irq[irq_index][port_index-1] = irq;
+
+			if (qcom->num_ports < port_index)
+				qcom->num_ports = port_index;
+		}
 	}
 
 	return 0;
@@ -1030,20 +1129,16 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
+	.phy_irq_index = {4, 3, 2},
 	.hs_phy_irq_index = 1,
-	.dp_hs_phy_irq_index = 4,
-	.dm_hs_phy_irq_index = 3,
-	.ss_phy_irq_index = 2
 };
 
 static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
+	.phy_irq_index = {4, 3, 2},
 	.hs_phy_irq_index = 1,
-	.dp_hs_phy_irq_index = 4,
-	.dm_hs_phy_irq_index = 3,
-	.ss_phy_irq_index = 2,
 	.is_urs = true,
 };
 
-- 
2.40.0

