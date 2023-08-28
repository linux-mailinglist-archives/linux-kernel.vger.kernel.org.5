Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D070478B1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjH1NcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjH1Nbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:31:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC11FA7;
        Mon, 28 Aug 2023 06:31:50 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SDGe5F030637;
        Mon, 28 Aug 2023 13:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RsAnSBZHyyBzcbBOUdyMzFgumP7+xs46cq7zeZGpo4E=;
 b=SrP7Jf65MReLVNpxse1nSFt29Y8pSr2BdzlU1IKTnbrvL9R8PlkkC/uI23yptp4hWNAG
 NpwS4l/hgV7Y/65fOBG5TYPSFprlwQqXcQiMZ1MRkP3fK9KlTMsx4B00Jtj64JBJkbk/
 XNGu0S+t4gtdmV2N2VXsu1U5OQKe92LWmWG1CMJGaTecjB0t3wI0eAoF7aeLbtw++7BI
 HElYJks2iNP9YeT1yyF1PQH2QLKzHpXXIAitMbc5hZOCdE42GphcZ6fFBqPxzZUlXYKn
 XOqcPMH3Ufk5c7rJgubz/PtbrpMfaAbrhpPACUycUvGDqq35bAJB0VdJp4WnoM/mPPdX Aw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9sdkdj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SDVaCF013575
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:36 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 06:31:30 -0700
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
Subject: [PATCH v11 07/13] usb: dwc3: qcom: Add helper function to request threaded IRQ
Date:   Mon, 28 Aug 2023 19:00:27 +0530
Message-ID: <20230828133033.11988-8-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: _DHdTTLH5NPGSD5CUdVn25MsVs3rYtOj
X-Proofpoint-ORIG-GUID: _DHdTTLH5NPGSD5CUdVn25MsVs3rYtOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_10,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=639 mlxscore=0 bulkscore=0
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

Cleanup setup irq call by implementing a new prep_irq helper function
and using it to request threaded IRQ's.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 63 +++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3de43df6bbe8..f14ddc9c541d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -535,6 +535,24 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
 	return ret;
 }
 
+static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
+				char *disp_name, int irq)
+{
+	int ret;
+
+	/* Keep wakeup interrupts disabled until suspend */
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					disp_name, qcom);
+
+	if (ret)
+		dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
+
+	return ret;
+}
+
 static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
@@ -545,61 +563,40 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
 				pdata ? pdata->hs_phy_irq_index : -1);
 	if (irq > 0) {
-		/* Keep wakeup interrupts disabled until suspend */
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"qcom_dwc3 HS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq",
+						"qcom_dwc3 HS", irq);
+		if (ret)
 			return ret;
-		}
 		qcom->hs_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
 				pdata ? pdata->dp_hs_phy_irq_index : -1);
 	if (irq > 0) {
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"qcom_dwc3 DP_HS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_prep_irq(qcom, "dp_hs_phy_irq",
+						"qcom_dwc3 DP_HS", irq);
+		if (ret)
 			return ret;
-		}
 		qcom->dp_hs_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
 				pdata ? pdata->dm_hs_phy_irq_index : -1);
 	if (irq > 0) {
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"qcom_dwc3 DM_HS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_prep_irq(qcom, "dm_hs_phy_irq",
+						"qcom_dwc3 DM_HS", irq);
+		if (ret)
 			return ret;
-		}
 		qcom->dm_hs_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
 				pdata ? pdata->ss_phy_irq_index : -1);
 	if (irq > 0) {
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"qcom_dwc3 SS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_prep_irq(qcom, "ss_phy_irq",
+						"qcom_dwc3 SS", irq);
+		if (ret)
 			return ret;
-		}
 		qcom->ss_phy_irq = irq;
 	}
 
-- 
2.40.0

