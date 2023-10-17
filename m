Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F037CB8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjJQDMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjJQDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C092ED;
        Mon, 16 Oct 2023 20:11:38 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2Qrlc004223;
        Tue, 17 Oct 2023 03:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=7QoYq0484bQLTNEeVVKI0cUqPKuEr3nagBeGog2HPR4=;
 b=TBlR0ipNkIa9vHRBraLmzKouO5RRl5v+jIA2HD4Oo4/aJn/refj7wxbgrinUQUcuGd0o
 lOiVXeTT9GkGd3RlngbPicgySY27THHWlReQRy7icRPh+xFBXpGq5xvJUroJLUvR+65e
 zPoi277togfc5eJTktp71Zhtrl9CQukKLHexrETdGTePE3pXVzE8E1mgB6Efo2LxPAfL
 6Q8oACg2iApjbJVOGjsZbQSqLNfOLiUxegnHIbbe6jH18CGzAX20R2JflasR50smO6Em
 j8Zxca1LAysMcW8W1ZkGYEFWBu7i93FdFGtQdJrYVtV6OMaJKu3FmMCWSsQ5UqhlVh6b 3A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsaf0rx4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BSFE004291
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:28 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:28 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:15 -0700
Subject: [PATCH 07/12] usb: dwc3: qcom: Instantiate dwc3 core directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-7-ab4a84165470@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=5049;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=IoOw46hHewkcLoa43K/KkscSV0tG1fc05W5lIf48pBw=;
 b=d3EQp59hH5C+zkqVaWM+8GRRhh7Jn7V8ZsJrEoDpMCJ5sqnnWtisd8YH1cq5U9djmuYYAdl4jvLg
 eCd6NJovDg5RIm2zJL+t3XVUypG3nHI0FSeQBftzJ49FBInUqe+n
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PkYls-J9VTfaZf7L1SdPXa2BsfkN5IOR
X-Proofpoint-ORIG-GUID: PkYls-J9VTfaZf7L1SdPXa2BsfkN5IOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=662 malwarescore=0
 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm DWC3 glue builds up a platform_device programmatically in
order to probe the DWC3 core when running off ACPI data. But with the
newly introduced support for instantiating the core directly from the
glue, this code can be replaced with a single function call.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 85 ++++++++------------------------------------
 1 file changed, 15 insertions(+), 70 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 901e5050363b..cc0fe010ee8c 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -56,7 +56,6 @@
 struct dwc3_acpi_pdata {
 	u32			qscratch_base_offset;
 	u32			qscratch_base_size;
-	u32			dwc3_core_base_size;
 	int			hs_phy_irq_index;
 	int			dp_hs_phy_irq_index;
 	int			dm_hs_phy_irq_index;
@@ -676,75 +675,17 @@ static const struct software_node dwc3_qcom_swnode = {
 	.properties = dwc3_qcom_acpi_properties,
 };
 
-static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
+static int dwc3_qcom_probe_core(struct platform_device *pdev, struct dwc3_qcom *qcom)
 {
-	struct dwc3_qcom	*qcom = platform_get_drvdata(pdev);
-	struct device		*dev = &pdev->dev;
-	struct resource		*res, *child_res = NULL;
-	int			irq;
-	int			ret;
-
-	qcom->dwc_dev = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
-	if (!qcom->dwc_dev)
-		return -ENOMEM;
-
-	qcom->dwc_dev->dev.parent = dev;
-	qcom->dwc_dev->dev.type = dev->type;
-	qcom->dwc_dev->dev.dma_mask = dev->dma_mask;
-	qcom->dwc_dev->dev.dma_parms = dev->dma_parms;
-	qcom->dwc_dev->dev.coherent_dma_mask = dev->coherent_dma_mask;
-
-	child_res = kcalloc(2, sizeof(*child_res), GFP_KERNEL);
-	if (!child_res) {
-		platform_device_put(qcom->dwc_dev);
-		return -ENOMEM;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	child_res[0].flags = res->flags;
-	child_res[0].start = res->start;
-	child_res[0].end = child_res[0].start +
-		qcom->acpi_pdata->dwc3_core_base_size;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out;
-	}
-	child_res[1].flags = IORESOURCE_IRQ;
-	child_res[1].start = child_res[1].end = irq;
+	struct dwc3 *dwc;
 
-	ret = platform_device_add_resources(qcom->dwc_dev, child_res, 2);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add resources\n");
-		goto out;
-	}
+	dwc = dwc3_probe(pdev);
+	if (IS_ERR(dwc))
+		return PTR_ERR(dwc);
 
-	ret = device_add_software_node(&qcom->dwc_dev->dev, &dwc3_qcom_swnode);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add properties\n");
-		goto out;
-	}
+	qcom->dwc = dwc;
 
-	ret = platform_device_add(qcom->dwc_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add device\n");
-		device_remove_software_node(&qcom->dwc_dev->dev);
-		goto out;
-	}
-	kfree(child_res);
 	return 0;
-
-out:
-	platform_device_put(qcom->dwc_dev);
-	kfree(child_res);
-	return ret;
 }
 
 static int dwc3_qcom_of_register_core(struct platform_device *pdev)
@@ -871,6 +812,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
+		ret = device_add_software_node(&pdev->dev, &dwc3_qcom_swnode);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to add properties\n");
+			return ret;
+		}
+
 		if (qcom->acpi_pdata->is_urs) {
 			ret = dwc3_qcom_acpi_merge_urs_resources(pdev);
 			if (ret < 0)
@@ -942,7 +889,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (np)
 		ret = dwc3_qcom_of_register_core(pdev);
 	else
-		ret = dwc3_qcom_acpi_register_core(pdev);
+		ret = dwc3_qcom_probe_core(pdev, qcom);
 
 	if (ret) {
 		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
@@ -986,10 +933,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 interconnect_exit:
 	dwc3_qcom_interconnect_exit(qcom);
 depopulate:
-	if (np)
+	if (qcom->dwc_dev)
 		of_platform_depopulate(&pdev->dev);
 	else
-		platform_device_put(pdev);
+		dwc3_remove(qcom->dwc);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
@@ -1128,7 +1075,6 @@ MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
 static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
-	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
 	.hs_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,
@@ -1138,7 +1084,6 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
-	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
 	.hs_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,

-- 
2.25.1

