Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428FD7CB912
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjJQDMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjJQDLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84695;
        Mon, 16 Oct 2023 20:11:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2ibTB001790;
        Tue, 17 Oct 2023 03:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=FzE+nJADc6KEGAFQ2X715waVEHS3cgEjoG+xFy2ZWV0=;
 b=DTP+j7tBRyKKE611AAHouZ/2ia2eIRnrF07+u56RR93500ab261AJEY4vtX026fyX6V/
 QbRnx8AkTW/Zywwr97LD+BocFRkXZs7+EESq57vUWZeIDM40xclQyeZkJfmzHc4aYoPZ
 bkYctzhGQ8iz+pxuEYd6oggE6bkMFgSqLmuB5wSpCCFV95e7dlT0P62a65fF0rGkWNlN
 t+S43cEvlWrz3Sv+ECXw1DmRWNQv/AQCr+jkQTdXlKyzWamuE7BmrYAcopWGbBRbYIAz
 aHdpPWck6po8MatNC8UQ2HigTfSy/B7wMDluG0YObIb/xwnzRYgRF60FxaKNI/+wnIQt 5A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsc00rn87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BTrK015408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:29 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:29 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:19 -0700
Subject: [PATCH 11/12] usb: dwc3: qcom: Flatten the Qualcomm dwc3 binding
 and implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-11-ab4a84165470@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=4205;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=ImJHEcIMUBk4PcNkXVlrmYRzg2mrBn4SOJYskaxLj5E=;
 b=5xgiKeNEgVWe2+vUO6Z6W89TqjWFPT12cuw903CKZ6j4bpJT62LXh/JTN1qCzbk/CL+115ob3jqR
 tnTT7o0zAU8GpUSzparunmMDpGx839xbTROBXRgLZx5/XWL4V/1z
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 48gqXxpA4vVzBBprT7u5h4GUOh-x6Zdn
X-Proofpoint-GUID: 48gqXxpA4vVzBBprT7u5h4GUOh-x6Zdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
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

The USB block found in most Qualcomm platforms is modelled as three
different independent device drivers, and represented in DeviceTree as
two layered nodes. But as shown by the already existing layering
violations in the Qualcomm glue driver they can not be operated
independently.

In the current model, the probing of the core is asynchronous, and in a
number of places there's risk that the driver dereferences NULL
pointers, as it peeks into the core's drvdata.

There is also no way, in the current design to make the core notify the
glue upon DRD mode changes. Among the past proposals have been attempts
to provide a callback registration API, but as there is no way to know
when the core is probed this doesn't work.

Based on the recent refactoring its now possible to instantiate the glue
and core from a single representation of the DWC3 IP-block. This will
also allow for the glue to pass a callback to be called for DRD mode
changes.

The only overlapping handling between the Qualcomm glue and the core is
the release of reset, which is left to the core to handle.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 49 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index cf6c391ba498..3c9a2b5cd559 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -686,6 +686,16 @@ static int dwc3_qcom_probe_core(struct platform_device *pdev, struct dwc3_qcom *
 	return 0;
 }
 
+static bool dwc3_qcom_has_separate_dwc3_of_node(struct device *dev)
+{
+	struct device_node *np;
+
+	np = of_get_compatible_child(dev->of_node, "snps,dwc3");
+	of_node_put(np);
+
+	return !!np;
+}
+
 static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 {
 	struct dwc3_qcom	*qcom = platform_get_drvdata(pdev);
@@ -795,11 +805,14 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	int			ret, i;
 	bool			ignore_pipe_clk;
 	bool			wakeup_source;
+	bool			legacy_binding;
 
 	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
 	if (!qcom)
 		return -ENOMEM;
 
+	legacy_binding = dwc3_qcom_has_separate_dwc3_of_node(dev);
+
 	platform_set_drvdata(pdev, qcom);
 	qcom->dev = &pdev->dev;
 
@@ -823,24 +836,26 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		}
 	}
 
-	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
-	if (IS_ERR(qcom->resets)) {
-		return dev_err_probe(&pdev->dev, PTR_ERR(qcom->resets),
-				     "failed to get resets\n");
-	}
+	if (legacy_binding) {
+		qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
+		if (IS_ERR(qcom->resets)) {
+			return dev_err_probe(&pdev->dev, PTR_ERR(qcom->resets),
+					     "failed to get resets\n");
+		}
 
-	ret = reset_control_assert(qcom->resets);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to assert resets, err=%d\n", ret);
-		return ret;
-	}
+		ret = reset_control_assert(qcom->resets);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to assert resets, err=%d\n", ret);
+			return ret;
+		}
 
-	usleep_range(10, 1000);
+		usleep_range(10, 1000);
 
-	ret = reset_control_deassert(qcom->resets);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		ret = reset_control_deassert(qcom->resets);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
+			goto reset_assert;
+		}
 	}
 
 	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
@@ -851,7 +866,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	if (np) {
+	if (legacy_binding) {
 		parent_res = res;
 	} else {
 		memcpy(&local_res, res, sizeof(struct resource));
@@ -882,7 +897,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ignore_pipe_clk)
 		dwc3_qcom_select_utmi_clk(qcom);
 
-	if (np)
+	if (legacy_binding)
 		ret = dwc3_qcom_of_register_core(pdev);
 	else
 		ret = dwc3_qcom_probe_core(pdev, qcom);

-- 
2.25.1

