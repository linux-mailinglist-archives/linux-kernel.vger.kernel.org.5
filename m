Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA178B1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjH1Nc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjH1NcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:32:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474F1A7;
        Mon, 28 Aug 2023 06:32:01 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SC5NJu024361;
        Mon, 28 Aug 2023 13:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=5LBS7G1eAG7yzj43EJX4SQV0Y6tJQDOm9R5KFAK3apA=;
 b=n4kSktbpDo9+DKmZgagGC/8DGWLEX+UOGYSwycZ7MfiUIavl8FY5/kzvAvVeg4+ZMOCf
 vcTdAXRVUQLl/6N7WvG15Y3n6BQVfBbZuIygrkn5fzzigeHqmGU11/Sd5zfnruunFLbj
 0RTPoLHchxgtLpaJpeUoyO/IfM1Euijg3IiIbAvLhSNiA5BvjHzD/Vy1pmdqeuvycjea
 oYDavHTm47CMyw5WTvXl0/2RgVd/SRh6vbUaXIYciBkvTR8AAJQo5/PkurNwW6BPxExs
 iurAeUlnMn/M2nroAsawwJlU1LZHYeDyySHRem5rCcpXZexTwEkgurf3YbwMxBYpjXOB ZQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9sdkdjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SDVncc030731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:49 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 06:31:43 -0700
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
Subject: [PATCH v11 09/13] usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
Date:   Mon, 28 Aug 2023 19:00:29 +0530
Message-ID: <20230828133033.11988-10-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: zPIxTr0hx7XNncbgQAj2lYTu17SUcxbD
X-Proofpoint-ORIG-GUID: zPIxTr0hx7XNncbgQAj2lYTu17SUcxbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_10,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=876 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently wakeup is supported by only single port controllers. Read speed
of each port and accordingly enable IRQ's for those ports.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 65 +++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 05990142cbc8..f8f8c5e39a01 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -89,7 +89,7 @@ struct dwc3_qcom {
 	 */
 	int			phy_irq[NUM_PHY_IRQ - 1][DWC3_MAX_PORTS];
 	int			hs_phy_irq;
-	enum usb_device_speed	usb2_speed;
+	enum usb_device_speed	usb2_speed[DWC3_MAX_PORTS];
 
 	struct extcon_dev	*edev;
 	struct extcon_dev	*host_edev;
@@ -335,7 +335,8 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 	return dwc->xhci;
 }
 
-static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
+static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom,
+							int port_index)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 	struct usb_device *udev;
@@ -348,12 +349,10 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 
 	/*
 	 * It is possible to query the speed of all children of
-	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
-	 * currently supports only 1 port per controller. So
-	 * this is sufficient.
+	 * USB2.0 root hub via usb_hub_for_each_child().
 	 */
 #ifdef CONFIG_USB
-	udev = usb_hub_find_child(hcd->self.root_hub, 1);
+	udev = usb_hub_find_child(hcd->self.root_hub, port_index + 1);
 #else
 	udev = NULL;
 #endif
@@ -386,23 +385,29 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
+	int i;
+
 	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
 
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
-	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
-	}
+	for (i = 0; i < qcom->num_ports; i++) {
+		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
+			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
+		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
+			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
+			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
+		} else {
+			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
+			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
+		}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][0]);
+		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][i]);
+	}
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
+	int i;
+
 	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq, 0);
 
 	/*
@@ -413,22 +418,24 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 * disconnect and remote wakeup. When no device is connected, configure both
 	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
 	 */
-
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0],
+	for (i = 0; i < qcom->num_ports; i++) {
+		qcom->usb2_speed[i] = dwc3_qcom_read_usb2_speed(qcom, i);
+		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
+			dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i],
 						IRQ_TYPE_EDGE_FALLING);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0],
+		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
+			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
+			dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i],
 						IRQ_TYPE_EDGE_FALLING);
-	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0],
+		} else {
+			dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i],
 						IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0],
+			dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i],
 						IRQ_TYPE_EDGE_RISING);
-	}
+		}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][0], 0);
+		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][i], 0);
+	}
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -454,10 +461,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 	 * The role is stable during suspend as role switching is done from a
 	 * freezable workqueue.
 	 */
-	if (dwc3_qcom_is_host(qcom) && wakeup) {
-		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
+	if (dwc3_qcom_is_host(qcom) && wakeup)
 		dwc3_qcom_enable_interrupts(qcom);
-	}
 
 	qcom->is_suspended = true;
 
-- 
2.40.0

