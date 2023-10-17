Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94D7CC483
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbjJQNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343909AbjJQNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:19:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC65FE;
        Tue, 17 Oct 2023 06:19:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H7ma5t026891;
        Tue, 17 Oct 2023 13:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=rgMWQvDIlBZ3I4lsQBtNwRv/iqSA1kwp0/GIONZOCzk=;
 b=g443ruVIIFwcRAmuu8TfxKDPsKZBnWFG26eSCCv+9QpkmJQpRYrJgWhttNNamgzbuDlA
 4S/NndHDSscbWTR27bl7EotjarkOOvFgbxG8KILqlPUHPvutEhbr5dYg+n5X2G56heft
 fj/vA+ZapDnxaLOp2UDbXwZMyTrYnSTAZnSgEbGllEoYNtaVBTqvpBd61tqjTYpe7+Ub
 ji+EqP44NfckS7WOo65PkxXQxxzar3dELuEOBjvZFcKiByvs87G8kbHzyR7zjm5FQIg0
 5euLWYtKfYdCWtMaeMllrJuKmsv5OKRGPr0SuJ72AB6w2qy96ISp1pgmNh9tNctBNr47 yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsd1rsq9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HDJFfU030793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:19:15 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 06:19:11 -0700
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
Subject: [RFC 2/8] usb: dwc3: core: Register vendor hooks for dwc3-qcom
Date:   Tue, 17 Oct 2023 18:48:46 +0530
Message-ID: <20231017131851.8299-3-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: 5nADOxH7sYXhkYGnJO-JCK19HEv24HaR
X-Proofpoint-ORIG-GUID: 5nADOxH7sYXhkYGnJO-JCK19HEv24HaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=944 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on QC targets, the conndone/disconnect events in device mode are
generated by controller when software writes to QSCRATCH registers in qcom
glue layer rather than the vbus line being routed to dwc3 core IP for it
to recognize and generate these events.

We need to write '1' to  UTMI_OTG_VBUS_VALID bit of QSCRATCH_HS_PHY_CTRL
register to generate a connection done event and "0" if we need to
generate a disconnect event during cable removal or mode switch. Exactly
what is done by "dwc3_qcom_vbus_override_enable" call in dwc3-qcom.

When the disconnect is not generated upon cable removal, the connected
flag of dwc3 is left marked as "true" and it blocks runtime suspend.

The goal of these vendor hooks is to let the mode change and cable removal
notifications from core reach the  glue layers so that glue can take
necessary action.

Before flattening the device tree, glue driver is not sure when the core
probe was completed as core probe can be deferred. In this case, glue is
not sure when to register vendor hooks. So mandate enabling runtime only
for flattened device node platforms so that glue can know when to register
vendor hooks.

The following are the requirements aimed in this implementation:

1. When enum in device mode, Glue/core must stay active.

2. When cable is connected but UDC is not written yet, then glue/core
must be suspended.

3. Upon removing cable in device mode, the disconnect event must be
generated and unblock runtime suspend for dwc3 core.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c      | 15 ++++++-
 drivers/usb/dwc3/core.h      | 39 +++++++++++++++++-
 drivers/usb/dwc3/drd.c       |  9 ++++
 drivers/usb/dwc3/dwc3-qcom.c | 79 ++++++++++++++++++++++++++++++++++--
 4 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 923a6c623850..53a8d92ad663 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -137,6 +137,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (!desired_dr_role)
 		goto out;
 
+	dwc3_notify_set_mode(dwc, desired_dr_role);
+
 	if (desired_dr_role == dwc->current_dr_role)
 		goto out;
 
@@ -1751,7 +1753,8 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 	return 0;
 }
 
-struct dwc3 *dwc3_probe(struct platform_device *pdev)
+struct dwc3 *dwc3_probe(struct platform_device *pdev,
+			struct dwc3_glue_data *glue_data)
 {
 	struct device		*dev = &pdev->dev;
 	struct resource		*res, dwc_res;
@@ -1765,6 +1768,11 @@ struct dwc3 *dwc3_probe(struct platform_device *pdev)
 
 	dwc->dev = dev;
 
+	if (glue_data) {
+		dwc->glue_data = glue_data->glue_data;
+		dwc->glue_ops = glue_data->ops;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "missing memory resource\n");
@@ -1914,7 +1922,7 @@ static int dwc3_plat_probe(struct platform_device *pdev)
 {
 	struct dwc3 *dwc;
 
-	dwc = dwc3_probe(pdev);
+	dwc = dwc3_probe(pdev, NULL);
 	if (IS_ERR(dwc))
 		return PTR_ERR(dwc);
 
@@ -1925,6 +1933,9 @@ static int dwc3_plat_probe(struct platform_device *pdev)
 
 void dwc3_remove(struct dwc3 *dwc)
 {
+	dwc->glue_data = NULL;
+	dwc->glue_ops = NULL;
+
 	pm_runtime_get_sync(dwc->dev);
 
 	dwc3_core_exit_mode(dwc);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3ec4a961befe..aefcb0d388b7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -968,6 +968,23 @@ struct dwc3_scratchpad_array {
 	__le64	dma_adr[DWC3_MAX_HIBER_SCRATCHBUFS];
 };
 
+/*
+ * struct dwc3_glue_ops - The ops indicate the notifications that
+ *				need to be passed on to glue layer.
+ * @notify_cable_disconnect: Notify glue of cable removal
+ *				irrespective of host or device mode.
+ * @set_mode: Notify glue before mode change is about to happen.
+ */
+struct dwc3_glue_ops {
+	void	(*notify_cable_disconnect)(void *glue_data);
+	void	(*set_mode)(void *glue_data, u32 desired_dr_role);
+};
+
+struct dwc3_glue_data {
+	void			*glue_data;
+	struct dwc3_glue_ops	*ops;
+};
+
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
@@ -1124,6 +1141,9 @@ struct dwc3_scratchpad_array {
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
  * @debug_root: root debugfs directory for this device to put its files in.
+ * @glue_data: Private data stored by core to be passed on to glue during
+ *		role switch notifications.
+ * @glue_ops: Store pointers to glue notifcation callbacks.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1340,6 +1360,9 @@ struct dwc3 {
 	int			last_fifo_depth;
 	int			num_ep_resized;
 	struct dentry		*debug_root;
+
+	void			*glue_data;
+	const struct dwc3_glue_ops *glue_ops;
 };
 
 #define INCRX_BURST_MODE 0
@@ -1553,7 +1576,8 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
 int dwc3_core_soft_reset(struct dwc3 *dwc);
 
-struct dwc3 *dwc3_probe(struct platform_device *pdev);
+struct dwc3 *dwc3_probe(struct platform_device *pdev,
+			struct dwc3_glue_data *glue_data);
 void dwc3_remove(struct dwc3 *dwc);
 
 int dwc3_runtime_suspend(struct dwc3 *dwc);
@@ -1563,6 +1587,19 @@ int dwc3_suspend(struct dwc3 *dwc);
 int dwc3_resume(struct dwc3 *dwc);
 void dwc3_complete(struct dwc3 *dwc);
 
+static inline void dwc3_notify_cable_disconnect(struct dwc3 *dwc)
+{
+	if (dwc->glue_ops && dwc->glue_ops->notify_cable_disconnect)
+		dwc->glue_ops->notify_cable_disconnect(dwc->glue_data);
+}
+
+static inline void dwc3_notify_set_mode(struct dwc3 *dwc,
+					u32 desired_dr_role)
+{
+	if (dwc->glue_ops && dwc->glue_ops->set_mode)
+		dwc->glue_ops->set_mode(dwc->glue_data, desired_dr_role);
+}
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 039bf241769a..947faeef0e4d 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -461,6 +461,15 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 		break;
 	}
 
+	/*
+	 * When cable is removed, the role changes to default mode.
+	 * In the case we are in device mode and removed the cable, the
+	 * glue needs to know that we are disconnected. It must not notify
+	 * the change of mode to default mode.
+	 */
+	if (role == USB_ROLE_NONE)
+		dwc3_notify_cable_disconnect(dwc);
+
 	dwc3_set_mode(dwc, mode);
 	return 0;
 }
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3c9a2b5cd559..4013a5e6c6c0 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -88,6 +88,9 @@ struct dwc3_qcom {
 	bool			pm_suspended;
 	struct icc_path		*icc_path_ddr;
 	struct icc_path		*icc_path_apps;
+
+	bool			enable_rt;
+	enum usb_role		current_role;
 };
 
 static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
@@ -673,16 +676,71 @@ static const struct software_node dwc3_qcom_swnode = {
 	.properties = dwc3_qcom_acpi_properties,
 };
 
+static void dwc3_qcom_handle_cable_disconnect(void *data)
+{
+	struct dwc3_qcom *qcom = (struct dwc3_qcom *)data;
+	/*
+	 * If we are in device mode and get a cable disconnect,
+	 * handle it by clearing OTG_VBUS_VALID bit in wrapper.
+	 * The next set_mode to default role can be ignored.
+	 */
+	if (qcom->current_role == USB_ROLE_DEVICE) {
+		pm_runtime_get_sync(qcom->dev);
+		dwc3_qcom_vbus_override_enable(qcom, false);
+		pm_runtime_put_autosuspend(qcom->dev);
+	}
+
+	pm_runtime_mark_last_busy(qcom->dev);
+	qcom->current_role = USB_ROLE_NONE;
+}
+
+static void dwc3_qcom_handle_set_mode(void *data, u32 desired_dr_role)
+{
+	struct dwc3_qcom *qcom = (struct dwc3_qcom *)data;
+
+	/*
+	 * If we are in device mode and get a cable disconnect,
+	 * handle it by clearing OTG_VBUS_VALID bit in wrapper.
+	 * The next set_mode to default role can be ignored and
+	 * so the OTG_VBUS_VALID should be set iff the current role
+	 * is NONE and we need to enter DEVICE mode.
+	 */
+	if ((qcom->current_role == USB_ROLE_NONE) &&
+	    (desired_dr_role == DWC3_GCTL_PRTCAP_DEVICE)) {
+		dwc3_qcom_vbus_override_enable(qcom, true);
+		qcom->current_role = USB_ROLE_DEVICE;
+	} else if ((desired_dr_role == DWC3_GCTL_PRTCAP_HOST) &&
+		   (qcom->current_role != USB_ROLE_HOST)) {
+		qcom->current_role = USB_ROLE_HOST;
+	}
+
+	pm_runtime_mark_last_busy(qcom->dev);
+}
+
+struct dwc3_glue_ops dwc3_qcom_glue_hooks = {
+	.notify_cable_disconnect = dwc3_qcom_handle_cable_disconnect,
+	.set_mode = dwc3_qcom_handle_set_mode,
+};
+
 static int dwc3_qcom_probe_core(struct platform_device *pdev, struct dwc3_qcom *qcom)
 {
 	struct dwc3 *dwc;
 
-	dwc = dwc3_probe(pdev);
+	struct dwc3_glue_data qcom_glue_data = {
+		.glue_data	= qcom,
+		.ops		= &dwc3_qcom_glue_hooks,
+	};
+
+	dwc = dwc3_probe(pdev,
+			 qcom->enable_rt ? &qcom_glue_data : NULL);
 	if (IS_ERR(dwc))
 		return PTR_ERR(dwc);
 
 	qcom->dwc = dwc;
 
+	if (qcom->enable_rt)
+		pm_runtime_allow(qcom->dev);
+
 	return 0;
 }
 
@@ -897,6 +955,23 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ignore_pipe_clk)
 		dwc3_qcom_select_utmi_clk(qcom);
 
+	qcom->enable_rt = device_property_read_bool(dev,
+				"qcom,enable-rt");
+	if (!legacy_binding) {
+		/*
+		 * If we are enabling runtime, then we are using flattened
+		 * device implementation.
+		 */
+		qcom->mode = usb_get_dr_mode(dev);
+
+		if (qcom->mode == USB_DR_MODE_HOST)
+			qcom->current_role = USB_ROLE_HOST;
+		else if (qcom->mode == USB_DR_MODE_PERIPHERAL)
+			qcom->current_role = USB_ROLE_DEVICE;
+		else
+			qcom->current_role = USB_ROLE_NONE;
+	}
+
 	if (legacy_binding)
 		ret = dwc3_qcom_of_register_core(pdev);
 	else
@@ -913,8 +988,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	if (qcom->dwc_dev)
 		qcom->mode = usb_get_dr_mode(&qcom->dwc_dev->dev);
-	else
-		qcom->mode = usb_get_dr_mode(dev);
 
 	/* enable vbus override for device mode */
 	if (qcom->mode != USB_DR_MODE_HOST)
-- 
2.42.0

