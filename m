Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691C765FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjG0WfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjG0Wer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:34:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BC35AB;
        Thu, 27 Jul 2023 15:34:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RKIj74015134;
        Thu, 27 Jul 2023 22:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VSgr7GQMu0oxXRIZ+p2Owp962oHKtnM365/vgl+plDg=;
 b=V5ylW/sXOB8auPO30vYZ5uOWe45qO8gv8H94APt628dk7IgeZ01eBeIZeQb0ZU8j0eJ+
 oWG7jdQ7Fp1VD2d6ftkNBtbYESKnWRCbzf2Kk3fIHW4RoXqQF6NRg5USSyF0UX8ezSOU
 34RI54fyQbO95oL1VbrCEwRmRfKJFBlHdSSwu6n7Hi4YJfz3JMql+YBb7DX3oCINetQ7
 MloXIBuwrUQwRfROQstNxEsrsmJYa0f14NNgbHeDVSK9R0PCdl0NMhFGkJjiXgGdTdxq
 htGCkKk0oNN5waLjddh93TSI8klVX6lwjbIMcN0OYbPLYHI80VXDNPLHc36o4w10KF8x 8A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3mpt20jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 22:34:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RMY6GU013461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 22:34:06 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 15:34:00 -0700
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
Subject: [PATCH v10 07/11] usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
Date:   Fri, 28 Jul 2023 04:03:03 +0530
Message-ID: <20230727223307.8096-8-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mkGJOnaucjrSbnzEPhtgQyxglIfnyZsl
X-Proofpoint-GUID: mkGJOnaucjrSbnzEPhtgQyxglIfnyZsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=866
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

Currently wakeup is supported by only single port controllers. Read speed
of each port and accordingly enable IRQ's for those ports.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 64 ++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index ad89ded116d3..a98223291306 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -81,7 +81,7 @@ struct dwc3_qcom {
 	int					dp_hs_phy_irq[DWC3_MAX_PORTS];
 	int					dm_hs_phy_irq[DWC3_MAX_PORTS];
 	int					ss_phy_irq[DWC3_MAX_PORTS];
-	enum usb_device_speed			usb2_speed;
+	enum usb_device_speed			usb2_speed[DWC3_MAX_PORTS];
 
 	struct extcon_dev			*edev;
 	struct extcon_dev			*host_edev;
@@ -349,7 +349,8 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 	return dwc->xhci;
 }
 
-static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
+static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom,
+							int port_index)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 	struct usb_device *udev;
@@ -362,12 +363,10 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 
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
@@ -400,23 +399,29 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
+	int i;
+
 	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
 
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[0]);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[0]);
-	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[0]);
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[0]);
-	}
+	for (i = 0; i < qcom->data->num_ports; i++) {
+		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
+			dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[i]);
+		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
+				(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
+			dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[i]);
+		} else {
+			dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq[i]);
+			dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq[i]);
+		}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq[0]);
+		dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq[i]);
+	}
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
+	int i;
+
 	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq, 0);
 
 	/*
@@ -427,22 +432,25 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 * disconnect and remote wakeup. When no device is connected, configure both
 	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
 	 */
+	for (i = 0; i < qcom->data->num_ports; i++) {
+		qcom->usb2_speed[i] = dwc3_qcom_read_usb2_speed(qcom, i);
 
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[0],
+		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
+			dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[i],
 						IRQ_TYPE_EDGE_FALLING);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[0],
+		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
+			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
+			dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[i],
 						IRQ_TYPE_EDGE_FALLING);
-	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[0],
+		} else {
+			dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq[i],
 						IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[0],
+			dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq[i],
 						IRQ_TYPE_EDGE_RISING);
-	}
+		}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq[0], 0);
+		dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq[i], 0);
+	}
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -468,10 +476,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
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

