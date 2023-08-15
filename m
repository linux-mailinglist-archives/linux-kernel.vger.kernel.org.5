Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB16D77C9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbjHOIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbjHOIwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:52:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9698E73;
        Tue, 15 Aug 2023 01:52:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F8M42L004981;
        Tue, 15 Aug 2023 08:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kOF8MCRoTC98yU585UAufHI6w01swXfWYALguhzxBwg=;
 b=KfAlkYlS1wxyNUbwvSNwQYvy0q4xl6kzkMnzkHJwOnTd+8Nn/c17A06jA1NjBRtUoMbG
 Yao8a+64ijWDzIoZi86ojDIno75BjrISOQpwiag8ZwYcLIJRIhbypY36ThnupqGCU6RC
 w774vkCqpSaX3gZIBb76LVAzSonY19AeIdZde/G3fcjJZyKFfwE2A9Ey3lkEa80PRSt8
 auD2po2iP2EIOCuf/+GruOKwTQ8wp60OyGMY+GN0BRS15+6f4pBJg9Gyj9E1ttq9sneP
 Q7LEXWdWLm0KUbUuOsFTJJXNHyisiC99tQnjY6pb+n7ojSma/qTGv7QlUgg9TZHTKh4Y ZQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg0v40fsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:52:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37F8qauY004955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:52:36 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 01:52:32 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v4 3/4] clk: qcom: common: add _qcom_cc_really_probe
Date:   Tue, 15 Aug 2023 16:52:04 +0800
Message-ID: <20230815085205.9868-4-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815085205.9868-1-quic_luoj@quicinc.com>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A94Z6RLik1-CpO1yEtbQT_p7d4bEtMUq
X-Proofpoint-ORIG-GUID: A94Z6RLik1-CpO1yEtbQT_p7d4bEtMUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_08,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the common function _qcom_cc_really_probe, which takes
struct device as parameter.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/common.c | 10 ++++++++--
 drivers/clk/qcom/common.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..4cbdbfb65606 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -234,11 +234,10 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
-int qcom_cc_really_probe(struct platform_device *pdev,
+int _qcom_cc_really_probe(struct device *dev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
 	int i, ret;
-	struct device *dev = &pdev->dev;
 	struct qcom_reset_controller *reset;
 	struct qcom_cc *cc;
 	struct gdsc_desc *scd;
@@ -305,6 +304,13 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(_qcom_cc_really_probe);
+
+int qcom_cc_really_probe(struct platform_device *pdev,
+			 const struct qcom_cc_desc *desc, struct regmap *regmap)
+{
+	return _qcom_cc_really_probe(&pdev->dev, desc, regmap);
+}
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
 int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..9710ade9bf15 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -58,6 +58,8 @@ extern int qcom_cc_register_sleep_clk(struct device *dev);
 
 extern struct regmap *qcom_cc_map(struct platform_device *pdev,
 				  const struct qcom_cc_desc *desc);
+extern int _qcom_cc_really_probe(struct device *dev,
+			 const struct qcom_cc_desc *desc, struct regmap *regmap);
 extern int qcom_cc_really_probe(struct platform_device *pdev,
 				const struct qcom_cc_desc *desc,
 				struct regmap *regmap);
-- 
2.17.1

