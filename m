Return-Path: <linux-kernel+bounces-130905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C576F897F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD511F22B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CD57333;
	Thu,  4 Apr 2024 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e730BuGs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2456B7C;
	Thu,  4 Apr 2024 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207609; cv=none; b=U6EgtayhKBizs1fs9/S+I3G2ZG6QVpPK6s39PtWlRUwXg0x+9LP6+hByEbzqH09T0sQJrLlG3r3Ke+YLXlakUB7B9+24yPvXxSEMTT1M8HLe/6obdTfJLYCjxHFqSlpXaa24+93PuuHbrVMxPyIuC71mFHA5KmfVPvOpP0S5Nps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207609; c=relaxed/simple;
	bh=4V0eFBIjR9DPCwjlVi3fSA4aijVRdO22PtIf8wXBeyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+X7yfuWZNVL4V8qEHgs+dZgc31BMuyVZ06JjPFP4ehHpY4AJ4kPX28n1TtgnshpDs/IS+c/eL92RVrFL8KaKwl7eQOJRKVVUS8vA72Ii5LIar3RKIzlqjLUvxWZCIt9ANimKOmUI8nFZ0DX+yiqCvQmtgVPN8QKve1FzjtKXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e730BuGs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43453EO0018894;
	Thu, 4 Apr 2024 05:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=loF04AMCW/vlX+IACFVbp2fBcecuggobccGXCFGEFLs=; b=e7
	30BuGs0paF5qb6PIgu8GCh289mvZigcJzcYpBg7LAJDes/7otln9Fs5WndPuk4n9
	KiT+wAvtPyA5aGtWnzHMNOA1bUcTDrbCiepy1CkAJk90LQ2VZDESgV9TzEA0r6Sz
	PLVIw3EAu1ei+KyzJG54ry79CkDswY6JgdbjFrdzTrxvap7bcC69h8CNksbhbZ16
	RicTH6GAVj9jZdHp7CTnGf4736qdUqnH73PwVO99v9mwbYpfYFuTXgXm7jxV7LBn
	gRP7pgErIE6P21mwnmM6BqZysD42XyjpD+fy1qenKLi/FmMGejRohTmaqoRUmjUV
	aghuMs/UGpOfWld7wM6A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en3gmmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 05:13:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4345DMud028519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 05:13:22 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 22:13:17 -0700
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
Subject: [PATCH v19 6/9] usb: dwc3: qcom: Add helper function to request wakeup interrupts
Date: Thu, 4 Apr 2024 10:42:26 +0530
Message-ID: <20240404051229.3082902-7-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JplDQaXNPU3h8d435i8OLFqOzbNx90FO
X-Proofpoint-ORIG-GUID: JplDQaXNPU3h8d435i8OLFqOzbNx90FO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_01,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=902 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404040033

The logic for requesting interrupts is duplicated for each interrupt. In
the upcoming patches that introduces support for multiport, it would be
better to clean up the duplication before reading mulitport related
interrupts.

Refactor interrupt setup call by adding a new helper function for
requesting the wakeup interrupts. To simplify implementation, make
the display name same as the interrupt name expected in DT.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 53 ++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index f6b2fab49d5e..cae5dab8fcfc 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -501,6 +501,22 @@ static void dwc3_qcom_select_utmi_clk(struct dwc3_qcom *qcom)
 			  PIPE_UTMI_CLK_DIS);
 }
 
+static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
+				 const char *name)
+{
+	int ret;
+
+	/* Keep wakeup interrupts disabled until suspend */
+	ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					name, qcom);
+	if (ret)
+		dev_err(qcom->dev, "failed to request irq %s: %d\n", name, ret);
+
+	return ret;
+}
+
 static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
@@ -509,54 +525,33 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
 	if (irq > 0) {
-		/* Keep wakeup interrupts disabled until suspend */
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 QUSB2", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "qusb2_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "qusb2_phy");
+		if (ret)
 			return ret;
-		}
 		qcom->qusb2_phy_irq = irq;
 	}
 
 	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 DP_HS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "dp_hs_phy_irq");
+		if (ret)
 			return ret;
-		}
 		qcom->dp_hs_phy_irq = irq;
 	}
 
 	irq = platform_get_irq_byname_optional(pdev, "dm_hs_phy_irq");
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 DM_HS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "dm_hs_phy_irq");
+		if (ret)
 			return ret;
-		}
 		qcom->dm_hs_phy_irq = irq;
 	}
 
 	irq = platform_get_irq_byname_optional(pdev, "ss_phy_irq");
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 SS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
+		if (ret)
 			return ret;
-		}
 		qcom->ss_phy_irq = irq;
 	}
 
-- 
2.34.1


