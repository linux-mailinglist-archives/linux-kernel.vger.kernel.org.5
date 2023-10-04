Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71CB7B8603
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbjJDRAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbjJDQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:59:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE009B;
        Wed,  4 Oct 2023 09:59:51 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FB8v3001211;
        Wed, 4 Oct 2023 16:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9WxrQs2qZgO3q9GeP0KZrPxayPz5KdCbKHg0xT93Fxw=;
 b=cq0voKoaKB9yIWnoWsLVkRUWD+Id1/811r3fpsECeWyzDkpYqrzPOSMV4FUdkgnvf4hn
 d6iZY2aPnilN02I0IJvMvfeOofMZ7P+8Y6+3vN5ptdTENMuPF2pziu8liHSTdvSd42np
 YTBxemwFSaCb2RuqLYLlpNG5IPRUMmA419ydF7acupeT+yKsM/eloaAeZJ9E9ZG+gidG
 iEvwUSAiaWW6k3S8CEAo4oQolAl5xDpfxrVw9xZNQ7NSGnghUwgutz0D5cpPBZQFR5U+
 l1MK5uPHW7dqTV60Kc8gZvtW0fZrBK179vVfTi5UQdikvbnX7tWWOxAgPt6gFsvvukB9 fw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgr9mjjx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 16:59:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394GxjSN032106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 16:59:45 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 09:59:42 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
Subject: [PATCH v12 3/3] usb: dwc3: qcom: Add helper function to request threaded IRQ
Date:   Wed, 4 Oct 2023 22:29:22 +0530
Message-ID: <20231004165922.25642-4-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004165922.25642-1-quic_kriskura@quicinc.com>
References: <20231004165922.25642-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1-rm1IhHl040xUaLlW7UrkkD4Z6gkptG
X-Proofpoint-ORIG-GUID: 1-rm1IhHl040xUaLlW7UrkkD4Z6gkptG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=647 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup setup irq call by implementing a new prep_irq helper function
and using it to request threaded IRQ's.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 59 ++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3de43df6bbe8..ef2006db7601 100644
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
@@ -545,61 +563,36 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
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
+		ret = dwc3_qcom_prep_irq(qcom, "hs_phy_irq", "qcom_dwc3 HS", irq);
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
+		ret = dwc3_qcom_prep_irq(qcom, "dp_hs_phy_irq", "qcom_dwc3 DP_HS", irq);
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
+		ret = dwc3_qcom_prep_irq(qcom, "dm_hs_phy_irq", "qcom_dwc3 DM_HS", irq);
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
+		ret = dwc3_qcom_prep_irq(qcom, "ss_phy_irq", "qcom_dwc3 SS", irq);
+		if (ret)
 			return ret;
-		}
 		qcom->ss_phy_irq = irq;
 	}
 
-- 
2.42.0

