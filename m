Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3367CB8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjJQDLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjJQDLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE9E6;
        Mon, 16 Oct 2023 20:11:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H1IKEx028531;
        Tue, 17 Oct 2023 03:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=MD0vRGHKVSv5tIsJbfLJScCBWTTC11d48ggnY3hpncA=;
 b=GZ17xj8HVCv5IrGwLOqqizzrC1yyD8gQPjBSpWoVv8ytnZzCdFYkPjA5GLU7ZOFtDmvc
 tyqcxIjvlNdBQLE2QDOirblDFZ2GZ3vi5QMa55KpQfzZZ2FfgQWUOm/o4PAnI1aFi1PX
 9gc788xIUtkj8EchlSHaH4SVsBs2vPRk1F+7yXkx+5vr2791rXLjs+oqMplAIpHAvo6G
 2COR22ewn5w47/vgHoc9afGgTbQGiOcFF6jxipg2C1vIKhehm7si2UyZEWw0YbTFKWjR
 H1SQSY2NisAiF0ZSIasMj3UHzfMfEkErzZ0yTtoweLyKn9QWqcLXHQfc0b6en+x/0bgZ Qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsc00rn85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BS1D004288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:28 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:28 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:14 -0700
Subject: [PATCH 06/12] usb: dwc3: qcom: Add dwc3 core reference in driver
 state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-6-ab4a84165470@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=6798;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=OHMsrdi0Hzr9WxOlgv0n2OO76ee9XeZshUlE7WLt4EY=;
 b=8oDVcUrabfpdmkepZcoPwwfn/+YQhm1r+TQyWFC/6MXILfa7fUx3L4Fd8QND8WHoJE7bgp3IoJBo
 RUNAb8I/AQVc9xVLpxTYPJ5fZ7zAUWbLT/cPdi41VoofBFl8+OI7
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mHUZbxxDkktl5ArGb2OLDIZFwmP2Zj8Z
X-Proofpoint-GUID: mHUZbxxDkktl5ArGb2OLDIZFwmP2Zj8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=991 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the coming changes the Qualcomm DWC3 glue will be able to either
manage the DWC3 core as a child platform_device, or directly instantiate
it within its own context.

Introduce a reference to the dwc3 core state and make the driver
reference the dwc3 core either the child device or this new reference.

As the new member isn't assigned, and qcom->dwc_dev is assigned in all
current cases, the change should have no functional impact.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 100 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7c810712d246..901e5050363b 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -67,7 +67,8 @@ struct dwc3_acpi_pdata {
 struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
-	struct platform_device	*dwc_dev;
+	struct platform_device	*dwc_dev; /* only used when core is separate device */
+	struct dwc3		*dwc; /* not used when core is separate device */
 	struct clk		**clks;
 	int			num_clocks;
 	struct reset_control	*resets;
@@ -263,7 +264,11 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 		goto put_path_ddr;
 	}
 
-	max_speed = usb_get_maximum_speed(&qcom->dwc_dev->dev);
+	if (qcom->dwc_dev)
+		max_speed = usb_get_maximum_speed(&qcom->dwc_dev->dev);
+	else
+		max_speed = usb_get_maximum_speed(qcom->dev);
+
 	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN) {
 		ret = icc_set_bw(qcom->icc_path_ddr,
 				USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
@@ -311,7 +316,10 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 	/*
 	 * FIXME: Fix this layering violation.
 	 */
-	dwc = platform_get_drvdata(qcom->dwc_dev);
+	if (qcom->dwc_dev)
+		dwc = platform_get_drvdata(qcom->dwc_dev);
+	else
+		dwc = qcom->dwc;
 
 	/* Core driver may not have probed yet. */
 	if (!dwc)
@@ -322,10 +330,14 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 
 static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc_dev);
 	struct usb_device *udev;
 	struct usb_hcd __maybe_unused *hcd;
+	struct dwc3 *dwc;
 
+	if (qcom->dwc_dev)
+		dwc = platform_get_drvdata(qcom->dwc_dev);
+	else
+		dwc = qcom->dwc;
 	/*
 	 * FIXME: Fix this layering violation.
 	 */
@@ -485,12 +497,17 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 static irqreturn_t qcom_dwc3_resume_irq(int irq, void *data)
 {
 	struct dwc3_qcom *qcom = data;
-	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc_dev);
+	struct dwc3	*dwc;
 
 	/* If pm_suspended then let pm_resume take care of resuming h/w */
 	if (qcom->pm_suspended)
 		return IRQ_HANDLED;
 
+	if (qcom->dwc_dev)
+		dwc = platform_get_drvdata(qcom->dwc_dev);
+	else
+		dwc = qcom->dwc;
+
 	/*
 	 * This is safe as role switching is done from a freezable workqueue
 	 * and the wakeup interrupts are disabled as part of resume.
@@ -936,25 +953,33 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto depopulate;
 
-	qcom->mode = usb_get_dr_mode(&qcom->dwc_dev->dev);
+	if (qcom->dwc_dev)
+		qcom->mode = usb_get_dr_mode(&qcom->dwc_dev->dev);
+	else
+		qcom->mode = usb_get_dr_mode(dev);
 
 	/* enable vbus override for device mode */
 	if (qcom->mode != USB_DR_MODE_HOST)
 		dwc3_qcom_vbus_override_enable(qcom, true);
 
-	/* register extcon to override sw_vbus on Vbus change later */
-	ret = dwc3_qcom_register_extcon(qcom);
-	if (ret)
-		goto interconnect_exit;
+	if (qcom->dwc_dev) {
+		/* register extcon to override sw_vbus on Vbus change later */
+		ret = dwc3_qcom_register_extcon(qcom);
+		if (ret)
+			goto interconnect_exit;
+	}
 
 	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
 	device_init_wakeup(&pdev->dev, wakeup_source);
-	device_init_wakeup(&qcom->dwc_dev->dev, wakeup_source);
+	if (qcom->dwc_dev)
+		device_init_wakeup(&qcom->dwc_dev->dev, wakeup_source);
 
 	qcom->is_suspended = false;
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_forbid(dev);
+	if (qcom->dwc_dev) {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+		pm_runtime_forbid(dev);
+	}
 
 	return 0;
 
@@ -983,6 +1008,9 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i;
 
+	if (qcom->dwc)
+		dwc3_remove(qcom->dwc);
+
 	device_remove_software_node(&qcom->dwc_dev->dev);
 	if (np)
 		of_platform_depopulate(&pdev->dev);
@@ -998,8 +1026,10 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	dwc3_qcom_interconnect_exit(qcom);
 	reset_control_assert(qcom->resets);
 
-	pm_runtime_allow(dev);
-	pm_runtime_disable(dev);
+	if (qcom->dwc_dev) {
+		pm_runtime_allow(dev);
+		pm_runtime_disable(dev);
+	}
 }
 
 static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
@@ -1008,6 +1038,12 @@ static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
 	bool wakeup = device_may_wakeup(dev);
 	int ret;
 
+	if (qcom->dwc) {
+		ret = dwc3_suspend(qcom->dwc);
+		if (ret)
+			return ret;
+	}
+
 	ret = dwc3_qcom_suspend(qcom, wakeup);
 	if (ret)
 		return ret;
@@ -1029,12 +1065,33 @@ static int __maybe_unused dwc3_qcom_pm_resume(struct device *dev)
 
 	qcom->pm_suspended = false;
 
+	if (qcom->dwc) {
+		ret = dwc3_resume(qcom->dwc);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
+static void dwc3_qcom_complete(struct device *dev)
+{
+	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+
+	if (qcom->dwc)
+		dwc3_complete(qcom->dwc);
+}
+
 static int __maybe_unused dwc3_qcom_runtime_suspend(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+	int ret;
+
+	if (qcom->dwc) {
+		ret = dwc3_runtime_suspend(qcom->dwc);
+		if (ret)
+			return ret;
+	}
 
 	return dwc3_qcom_suspend(qcom, true);
 }
@@ -1042,12 +1099,21 @@ static int __maybe_unused dwc3_qcom_runtime_suspend(struct device *dev)
 static int __maybe_unused dwc3_qcom_runtime_resume(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dwc3_qcom_resume(qcom, true);
+	if (ret)
+		return ret;
 
-	return dwc3_qcom_resume(qcom, true);
+	if (qcom->dwc)
+		return dwc3_runtime_resume(qcom->dwc);
+
+	return 0;
 }
 
 static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_qcom_pm_suspend, dwc3_qcom_pm_resume)
+	.complete = dwc3_qcom_complete,
 	SET_RUNTIME_PM_OPS(dwc3_qcom_runtime_suspend, dwc3_qcom_runtime_resume,
 			   NULL)
 };

-- 
2.25.1

