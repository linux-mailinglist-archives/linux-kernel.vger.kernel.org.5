Return-Path: <linux-kernel+bounces-118899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157288C0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505631C2F14F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045F6F09C;
	Tue, 26 Mar 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fAoVx0Yn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286255787;
	Tue, 26 Mar 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452881; cv=none; b=lZ4aHj6sgUsknYGzgTZ5eUEPO5QeKoJxcS3hHKObkl4/vqAvWueqwMdQL8R7CTVFRCxRv5pxSSdp9Gmu+JZSaTvzeZrWc7FnF5XJaXI7Fw8K5qUzStyA+DL19L/Lvr1+UX9Q8S6WL98Mw1wzALRmE0NdjEowRjJFMX0IO4vQpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452881; c=relaxed/simple;
	bh=dFn6prtebGVubnmdSxvWacjGF8JCmZ0UO26uVsorS8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG3UDz7mRtAhfWOOlZ6TFe+VlPOvU0a7eMK14luoO+YIg7Q9E7QgeT3aJhdGp+WB3ACD4St3b/3apb/244w93z0SvFELxYCibGFfsJK5o/RJwSnvr9osOvAbbGNtcF9e8l1Z+Mi5NJC7lRM2Rs3hURzwegf38HUEVnsARpyipy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fAoVx0Yn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q9W2EC032533;
	Tue, 26 Mar 2024 11:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=60BJR/M/yjlny23RVdEdD7YqpcDfziuTkLosy9/FnuM=; b=fA
	oVx0Yn7i1rC5lklQt/sHzlYhxfli89ymr64r40Med3KUymx8jr95W/8YU/gW5WEh
	6h8IWtgLaonZg1WNDxhQeTVWfZcwjf5D4v4oOJiiR8ZwyhEOW5PYwDRDIwo89n05
	b2HtxyTK3NiPFoTw+HuJ5MMm/7pc9oVUDnPulvjnJ8FSllrlhhksZtmYfGnglhPi
	hVED5JPG07dOD4u3ijvTdbP8et1iQsIFI5yDFRFfvxA98JTDV/qXADOYT+6JSF9y
	1HpmJH5/eD3pXLiM3UO8BywKeDACXMp+RN5GIQkyVP7pgfNJw95MQz7LLfEXaV5d
	d74Du8k8HSXVUyvISbvQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3twdgfx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 11:34:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QBXsEt012178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 11:33:54 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 04:33:48 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v18 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue driver
Date: Tue, 26 Mar 2024 17:02:51 +0530
Message-ID: <20240326113253.3010447-8-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: skMpZNp_ablnGszGtsmBWTu3idx9dN0l
X-Proofpoint-ORIG-GUID: skMpZNp_ablnGszGtsmBWTu3idx9dN0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260080

On multiport supported controllers, each port has its own DP/DM
and SS (if super speed capable) interrupts. As per the bindings,
their interrupt names differ from standard ones having "_x" added
as suffix (x indicates port number). Identify from the interrupt
names whether the controller is a multiport controller or not.
Refactor dwc3_qcom_setup_irq() call to parse multiport interrupts
along with non-multiport ones accordingly..

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 137 ++++++++++++++++++++++++++---------
 1 file changed, 103 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index cae5dab8fcfc..35eb338514bc 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -52,6 +52,13 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
+struct dwc3_qcom_port {
+	int			qusb2_phy_irq;
+	int			dp_hs_phy_irq;
+	int			dm_hs_phy_irq;
+	int			ss_phy_irq;
+};
+
 struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
@@ -59,11 +66,8 @@ struct dwc3_qcom {
 	struct clk		**clks;
 	int			num_clocks;
 	struct reset_control	*resets;
-
-	int			qusb2_phy_irq;
-	int			dp_hs_phy_irq;
-	int			dm_hs_phy_irq;
-	int			ss_phy_irq;
+	struct dwc3_qcom_port	ports[DWC3_MAX_PORTS];
+	u8			num_ports;
 	enum usb_device_speed	usb2_speed;
 
 	struct extcon_dev	*edev;
@@ -354,24 +358,24 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->ports[0].qusb2_phy_irq);
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq);
 	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq);
 	}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->ports[0].ss_phy_irq);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_enable_wakeup_irq(qcom->qusb2_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->ports[0].qusb2_phy_irq, 0);
 
 	/*
 	 * Configure DP/DM line interrupts based on the USB2 device attached to
@@ -383,20 +387,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 */
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
-						IRQ_TYPE_EDGE_FALLING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq,
+					    IRQ_TYPE_EDGE_FALLING);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
-						IRQ_TYPE_EDGE_FALLING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq,
+					    IRQ_TYPE_EDGE_FALLING);
 	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
-						IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
-						IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq,
+					    IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq,
+					    IRQ_TYPE_EDGE_RISING);
 	}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->ports[0].ss_phy_irq, 0);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -517,42 +521,107 @@ static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
 	return ret;
 }
 
-static int dwc3_qcom_setup_irq(struct platform_device *pdev)
+static int dwc3_qcom_setup_port_irq(struct platform_device *pdev, int port_index, bool is_multiport)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	const char *irq_name;
 	int irq;
 	int ret;
 
-	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_%d", port_index + 1);
+	else
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_irq");
+	if (!irq_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname_optional(pdev, irq_name);
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "qusb2_phy");
+		ret = dwc3_qcom_request_irq(qcom, irq, irq_name);
 		if (ret)
 			return ret;
-		qcom->qusb2_phy_irq = irq;
+		qcom->ports[port_index].dp_hs_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dm_hs_phy_%d", port_index + 1);
+	else
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dm_hs_phy_irq");
+	if (!irq_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname_optional(pdev, irq_name);
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "dp_hs_phy_irq");
+		ret = dwc3_qcom_request_irq(qcom, irq, irq_name);
 		if (ret)
 			return ret;
-		qcom->dp_hs_phy_irq = irq;
+		qcom->ports[port_index].dm_hs_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "dm_hs_phy_irq");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ss_phy_%d", port_index + 1);
+	else
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ss_phy_irq");
+	if (!irq_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname_optional(pdev, irq_name);
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "dm_hs_phy_irq");
+		ret = dwc3_qcom_request_irq(qcom, irq, irq_name);
 		if (ret)
 			return ret;
-		qcom->dm_hs_phy_irq = irq;
+		qcom->ports[port_index].ss_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "ss_phy_irq");
+	if (is_multiport)
+		return 0;
+
+	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
+		ret = dwc3_qcom_request_irq(qcom, irq, "qusb2_phy");
+		if (ret)
+			return ret;
+		qcom->ports[port_index].qusb2_phy_irq = irq;
+	}
+
+	return 0;
+}
+
+static int dwc3_qcom_find_num_ports(struct platform_device *pdev)
+{
+	char irq_name[14];
+	int port_num;
+	int irq;
+
+	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_1");
+	if (irq <= 0)
+		return 1;
+
+	for (port_num = 2; port_num <= DWC3_MAX_PORTS; port_num++) {
+		sprintf(irq_name, "dp_hs_phy_%d", port_num);
+
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq <= 0)
+			return port_num - 1;
+	}
+
+	return DWC3_MAX_PORTS;
+}
+
+static int dwc3_qcom_setup_irq(struct platform_device *pdev)
+{
+	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	bool is_multiport;
+	int ret;
+	int i;
+
+	qcom->num_ports = dwc3_qcom_find_num_ports(pdev);
+	is_multiport = (qcom->num_ports > 1);
+
+	for (i = 0; i < qcom->num_ports; i++) {
+		ret = dwc3_qcom_setup_port_irq(pdev, i, is_multiport);
 		if (ret)
 			return ret;
-		qcom->ss_phy_irq = irq;
 	}
 
 	return 0;
-- 
2.34.1


