Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459087CC487
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbjJQNTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbjJQNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:19:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96F510D;
        Tue, 17 Oct 2023 06:19:29 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HCkmh4011698;
        Tue, 17 Oct 2023 13:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+d1KRSggdTGEKfw6LpfvQegBYY+tc+X8fQ3kuYQ0mLA=;
 b=T65StbMHYtx4559usWL+NwvaTnU0wrS7tbFtHTtTx2rZKlcK7f26a/aONu3w42gZU34T
 rVmvc9uhKUHrcAx7lKBYNdmv0lsN/DlksLypQIUGDptckphbcMvoLwDruhjP5Kp4kOkU
 RTHc11sYfN/LFxIlIXycKqv9MF2QjRKTvIBjvG0dBNCEXuGc77ryeVbSjnRurYUNWzrf
 Sn+aXoMF8UG9ItDxWMzgO2OgbN33lVer22DM/AYoqOrfWC3Hl0Q2GkXqrXRRB+zcp6Nh
 G6qpxiQkPvtcR4O2rrEcQd7y0xtUpIvWSTaIKjqXWb8uYOt0vxquV4DKQY5aDwXAaOrw JA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsb3xsyr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HDJLl8009197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:21 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 06:19:16 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC 3/8] usb: dwc3: qcom: Enable autosuspend for host mode
Date:   Tue, 17 Oct 2023 18:48:47 +0530
Message-ID: <20231017131851.8299-4-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131851.8299-1-quic_kriskura@quicinc.com>
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vGCiM_K0LPQoQeiAwMfksFbnVTl5ewS9
X-Proofpoint-ORIG-GUID: vGCiM_K0LPQoQeiAwMfksFbnVTl5ewS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in host mode, enable autosuspend for xhci and root hubs.

a) Register a vendor call back to get information of successful role
change by core. When xhci is enumerated successfully, configure it to
use_autosuspend. The decision of whether or not to do runtime_allow for
xhci node is left to userspace:
(echo auto > */xhci-auto/power/control).

b) Register to usb-core notifications in set_mode vendor callback to
identify when root hubs are being created. Configure them to
use_autosuspend accordingly.

c) Configure any connected device to use_autosuspend. In general for
mobile use cases, autosuspend is enabled and wakeup is enabled only
for hubs and audio devices. So let userspace choose to configure
autosuspend_delay and wakeup capability of connected devices.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c      |  3 +++
 drivers/usb/dwc3/core.h      |  9 ++++++++
 drivers/usb/dwc3/dwc3-qcom.c | 42 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 53a8d92ad663..b4d1d1c98dd5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -233,6 +233,9 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+	if (!ret)
+		dwc3_notify_mode_changed(dwc, dwc->current_dr_role);
+
 out:
 	pm_runtime_mark_last_busy(dwc->dev);
 	pm_runtime_put_autosuspend(dwc->dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index aefcb0d388b7..5ed7fd5eb776 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -974,10 +974,12 @@ struct dwc3_scratchpad_array {
  * @notify_cable_disconnect: Notify glue of cable removal
  *				irrespective of host or device mode.
  * @set_mode: Notify glue before mode change is about to happen.
+ * @mode_changed: Notify glue that mode change was done successfully
  */
 struct dwc3_glue_ops {
 	void	(*notify_cable_disconnect)(void *glue_data);
 	void	(*set_mode)(void *glue_data, u32 desired_dr_role);
+	void	(*mode_changed)(void *glue_data, u32 current_dr_role);
 };
 
 struct dwc3_glue_data {
@@ -1600,6 +1602,13 @@ static inline void dwc3_notify_set_mode(struct dwc3 *dwc,
 		dwc->glue_ops->set_mode(dwc->glue_data, desired_dr_role);
 }
 
+static inline void dwc3_notify_mode_changed(struct dwc3 *dwc,
+					    u32 current_dr_role)
+{
+	if (dwc->glue_ops && dwc->glue_ops->mode_changed)
+		dwc->glue_ops->mode_changed(dwc->glue_data, current_dr_role);
+}
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 4013a5e6c6c0..9c7b23888f11 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -91,6 +91,7 @@ struct dwc3_qcom {
 
 	bool			enable_rt;
 	enum usb_role		current_role;
+	struct notifier_block	xhci_nb;
 };
 
 static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
@@ -676,6 +677,27 @@ static const struct software_node dwc3_qcom_swnode = {
 	.properties = dwc3_qcom_acpi_properties,
 };
 
+static int dwc3_xhci_event_notifier(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
+{
+	struct usb_device *udev = ptr;
+
+	if (event != USB_DEVICE_ADD)
+		return NOTIFY_DONE;
+
+	/*
+	 * If this is a roothub corresponding to this controller, enable autosuspend
+	 */
+	if (!udev->parent) {
+		pm_runtime_use_autosuspend(&udev->dev);
+		pm_runtime_set_autosuspend_delay(&udev->dev, 1000);
+	}
+
+	usb_mark_last_busy(udev);
+
+	return NOTIFY_DONE;
+}
+
 static void dwc3_qcom_handle_cable_disconnect(void *data)
 {
 	struct dwc3_qcom *qcom = (struct dwc3_qcom *)data;
@@ -688,6 +710,8 @@ static void dwc3_qcom_handle_cable_disconnect(void *data)
 		pm_runtime_get_sync(qcom->dev);
 		dwc3_qcom_vbus_override_enable(qcom, false);
 		pm_runtime_put_autosuspend(qcom->dev);
+	} else if (qcom->current_role == USB_ROLE_HOST) {
+		usb_unregister_notify(&qcom->xhci_nb);
 	}
 
 	pm_runtime_mark_last_busy(qcom->dev);
@@ -711,15 +735,33 @@ static void dwc3_qcom_handle_set_mode(void *data, u32 desired_dr_role)
 		qcom->current_role = USB_ROLE_DEVICE;
 	} else if ((desired_dr_role == DWC3_GCTL_PRTCAP_HOST) &&
 		   (qcom->current_role != USB_ROLE_HOST)) {
+		qcom->xhci_nb.notifier_call = dwc3_xhci_event_notifier;
+		usb_register_notify(&qcom->xhci_nb);
 		qcom->current_role = USB_ROLE_HOST;
 	}
 
 	pm_runtime_mark_last_busy(qcom->dev);
 }
 
+static void dwc3_qcom_handle_mode_changed(void *data, u32 current_dr_role)
+{
+	struct dwc3_qcom *qcom = (struct dwc3_qcom *)data;
+
+	/*
+	 * XHCI platform device is allocated upon host init.
+	 * So ensure we are in host mode before enabling autosuspend.
+	 */
+	if ((current_dr_role == DWC3_GCTL_PRTCAP_HOST) &&
+	    (qcom->current_role == USB_ROLE_HOST)) {
+		pm_runtime_use_autosuspend(&qcom->dwc->xhci->dev);
+		pm_runtime_set_autosuspend_delay(&qcom->dwc->xhci->dev, 0);
+	}
+}
+
 struct dwc3_glue_ops dwc3_qcom_glue_hooks = {
 	.notify_cable_disconnect = dwc3_qcom_handle_cable_disconnect,
 	.set_mode = dwc3_qcom_handle_set_mode,
+	.mode_changed = dwc3_qcom_handle_mode_changed,
 };
 
 static int dwc3_qcom_probe_core(struct platform_device *pdev, struct dwc3_qcom *qcom)
-- 
2.42.0

