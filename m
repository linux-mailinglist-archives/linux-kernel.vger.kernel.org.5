Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99577BC8CB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbjJGPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbjJGPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:49:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CEBC;
        Sat,  7 Oct 2023 08:49:16 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397FX0in019228;
        Sat, 7 Oct 2023 15:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=J4NP7JDmyt+wbcbtOopTBz9Qmtzk9G5xhxbI3dCwcv4=;
 b=bq6dyV9GOmh5M+TrQhd3cxlTsvGTIF7EXTKDLNFlKN6bHt6bG58/6JrUS1j2lWIJkaMy
 7g1CfuOPRSM8BrVsJnAIWmSxbpmDGJORXWiLP7ghTa5IkbN/pjNpHzVFZdRg45krczme
 dclSoWhnEFdONLLSkOSeGkHulsunPuKQMKkqNTGLVdeErvzuhS3lQ/0NLKcyDYjd95+V
 Pz7ahyAK68V46p8zEqQv45zk1wFwQ59aJIFjlor91kZQ8zNQeogpV3/grk2kYqI84Hlx
 IiNBk/bPkALtKEj/3k0vT9OCBNtNWY5zmHraGsLBbQFRf+aRvcL8fa0QaRZ0jxZDeW51 HQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjxx88yfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 15:49:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397Fn6tW028797
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 15:49:06 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 7 Oct 2023 08:49:00 -0700
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
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v13 06/10] usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
Date:   Sat, 7 Oct 2023 21:18:02 +0530
Message-ID: <20231007154806.605-7-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007154806.605-1-quic_kriskura@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JdczK7afancdIcBpmVGkdTP1YJQiM0tp
X-Proofpoint-ORIG-GUID: JdczK7afancdIcBpmVGkdTP1YJQiM0tp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 mlxlogscore=779 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310070143
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
index 863892284146..651b9775a0c2 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -90,7 +90,7 @@ struct dwc3_qcom {
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
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
-	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
-		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
-	}
+	for (i = 0; i < qcom->num_ports; i++) {
+		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
+			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
+		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
+			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
+			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
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
-		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0],
+	for (i = 0; i < qcom->num_ports; i++) {
+		qcom->usb2_speed[i] = dwc3_qcom_read_usb2_speed(qcom, i);
+		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
+			dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i],
 						IRQ_TYPE_EDGE_FALLING);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0],
+		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
+			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
+			dwc3_qcom_enable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i],
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
2.42.0

