Return-Path: <linux-kernel+bounces-118949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A388C1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E540B2E4B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA971741;
	Tue, 26 Mar 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lCQxW+dt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B274C0B;
	Tue, 26 Mar 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455250; cv=none; b=NWUi5YpQv117XYlc5kUR1kmbgD6E0iyAm0J5wOpuLfVaXuiseC/XBugeACtfIcYbv+zH3Pq0/lt8fT2YOwMW6mGe43r1zLplYcdvKJ27esmB8ICX8o2ttjPXDOa844pFKuM2Oc8cLaSNZ0Z1CYJVWiIOc0Nuf8/xWOOQRKgynmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455250; c=relaxed/simple;
	bh=s3ul7ABifYXkUuR0cc2SfEuOiNEdJInvN11hhgXBNVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhkov29GIMXXWdxILEnmgIyandPftGmQjkekvOyNoIhLAOERz84vUISBBtEfbD9/1OxFwPvFrQRkhfrG7rVwtzCz6UuVLwHNYVMabqeMyS7JsDRbnnT0VxIZ7b+9WFBQ8mi+7TQ4O71MxEHaUQVAC6ZfD6ZYBBiABhi/VMJi9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lCQxW+dt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QArnrt003011;
	Tue, 26 Mar 2024 12:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=064ZgTeQnICaVeGB5C98mopJsPIav5RLLFFWUbI1YKQ=; b=lC
	QxW+dtzMtsXF5kMpLO2ExcE3JKRj46GHVjH4k3Xhio8AnN4IkCVgj1J4eDoyCqk4
	/Lnf+dxJ0WQLkVUZY32jH27QaQH38OjyO4tup3w0glZjIRpJ8Bn4svS2Qhxr/PXw
	4s43Z2Bc6/6vvB92ueqxvGuyffhUApiF41Jz3ZgP+3Jy7Kd1cUpSnJRdKut77wXg
	TBDPnHKRHp5YJLQd+g2JoskEae4Dyo7aQezXrf9AJ1ZqaMj10h96P58F7SjviCO5
	O2p57Tbi0mfO6L46494u1njHND7NWLwT73EMnh6Y+lzb5G2WC1+qmgKBoVmuj629
	djBNuIypVf5kWZl1ZHhA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3w0x88gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:14:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QCE3fO004072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 12:14:03 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 05:13:58 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 2/3] clk: qcom: add IPQ9574 interconnect clocks support
Date: Tue, 26 Mar 2024 17:43:11 +0530
Message-ID: <20240326121312.1702701-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326121312.1702701-1-quic_varada@quicinc.com>
References: <20240326121312.1702701-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nJcejhOL0IDW-h75mS_ai0vYaQuS6B6o
X-Proofpoint-ORIG-GUID: nJcejhOL0IDW-h75mS_ai0vYaQuS6B6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260085

Unlike MSM platforms that manage NoC related clocks and scaling
from RPM, IPQ SoCs dont involve RPM in managing NoC related
clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for accessing the peripheral controllers present on
these NoCs. Though exposing these as normal clocks would work,
having a minimalistic interconnect driver to handle these clocks
would make it consistent with other Qualcomm platforms resulting
in common code paths. This is similar to msm8996-cbf's usage of
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: Use indexed identifiers here to avoid confusion
    Fix error messages and move to common.c
v2: Move DTS to separate patch
    Update commit log
    Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
---
 drivers/clk/qcom/Kconfig       |  2 ++
 drivers/clk/qcom/common.c      | 30 ++++++++++++++++
 drivers/clk/qcom/common.h      |  2 ++
 drivers/clk/qcom/gcc-ipq9574.c | 64 +++++++++++++++++++++++++++++++++-
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8ab08e7b5b6c..af73a0b396eb 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -243,6 +243,8 @@ config IPQ_GCC_8074
 
 config IPQ_GCC_9574
 	tristate "IPQ9574 Global Clock Controller"
+	select INTERCONNECT
+	select INTERCONNECT_CLK
 	help
 	  Support for global clock controller on ipq9574 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..b18d38509de5 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -8,6 +8,8 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
 #include <linux/reset-controller.h>
 #include <linux/of.h>
 
@@ -337,4 +339,32 @@ int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe_by_index);
 
+int qcom_cc_icc_register(struct device *dev, struct clk_regmap *clks[],
+			 int *noc_clks, int count, unsigned int first_id)
+{
+	struct icc_provider *provider;
+	struct icc_clk_data *icd;
+	int i;
+
+	icd = devm_kcalloc(dev, count, sizeof(*icd), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(icd))
+		return dev_err_probe(dev, PTR_ERR(icd),
+				     "malloc for clock data failed\n");
+
+	for (i = 0; i < count; i++) {
+		icd[i].clk = clks[noc_clks[i]]->hw.clk;
+		if (IS_ERR_OR_NULL(icd[i].clk))
+			return dev_err_probe(dev, -ENOENT,
+					     "%d clock not found\n", noc_clks[i]);
+		icd[i].name = clk_hw_get_name(&clks[noc_clks[i]]->hw);
+	}
+
+	provider = icc_clk_register(dev, first_id, count, icd);
+	if (IS_ERR_OR_NULL(provider))
+		return dev_err_probe(dev, PTR_ERR(provider),
+				     "icc_clk_register failed\n");
+
+	return 0;
+}
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..4fce5e229fc1 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -65,5 +65,7 @@ extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);
 extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 				  const struct qcom_cc_desc *desc);
+int qcom_cc_icc_register(struct device *dev, struct clk_regmap *clks[],
+			 int *noc_clks, int count, unsigned int first_id);
 
 #endif
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..c63c44b6740f 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -12,6 +12,7 @@
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4301,6 +4302,56 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+#define IPQ_APPS_ID			9574	/* some unique value */
+
+enum {
+	ICC_ANOC_PCIE0,
+	ICC_SNOC_PCIE0,
+	ICC_ANOC_PCIE1,
+	ICC_SNOC_PCIE1,
+	ICC_ANOC_PCIE2,
+	ICC_SNOC_PCIE2,
+	ICC_ANOC_PCIE3,
+	ICC_SNOC_PCIE3,
+	ICC_SNOC_USB,
+	ICC_ANOC_USB_AXI,
+	ICC_NSSNOC_NSSCC,
+	ICC_NSSNOC_SNOC_0,
+	ICC_NSSNOC_SNOC_1,
+	ICC_NSSNOC_PCNOC_1,
+	ICC_NSSNOC_QOSGEN_REF,
+	ICC_NSSNOC_TIMEOUT_REF,
+	ICC_NSSNOC_XO_DCD,
+	ICC_NSSNOC_ATB,
+	ICC_MEM_NOC_NSSNOC,
+	ICC_NSSNOC_MEMNOC,
+	ICC_NSSNOC_MEM_NOC_1,
+};
+
+static int noc_clks[] = {
+	[ICC_ANOC_PCIE0] = GCC_ANOC_PCIE0_1LANE_M_CLK,
+	[ICC_SNOC_PCIE0] = GCC_SNOC_PCIE0_1LANE_S_CLK,
+	[ICC_ANOC_PCIE1] = GCC_ANOC_PCIE1_1LANE_M_CLK,
+	[ICC_SNOC_PCIE1] = GCC_SNOC_PCIE1_1LANE_S_CLK,
+	[ICC_ANOC_PCIE2] = GCC_ANOC_PCIE2_2LANE_M_CLK,
+	[ICC_SNOC_PCIE2] = GCC_SNOC_PCIE2_2LANE_S_CLK,
+	[ICC_ANOC_PCIE3] = GCC_ANOC_PCIE3_2LANE_M_CLK,
+	[ICC_SNOC_PCIE3] = GCC_SNOC_PCIE3_2LANE_S_CLK,
+	[ICC_SNOC_USB] = GCC_SNOC_USB_CLK,
+	[ICC_ANOC_USB_AXI] = GCC_ANOC_USB_AXI_CLK,
+	[ICC_NSSNOC_NSSCC] = GCC_NSSNOC_NSSCC_CLK,
+	[ICC_NSSNOC_SNOC_0] = GCC_NSSNOC_SNOC_CLK,
+	[ICC_NSSNOC_SNOC_1] = GCC_NSSNOC_SNOC_1_CLK,
+	[ICC_NSSNOC_PCNOC_1] = GCC_NSSNOC_PCNOC_1_CLK,
+	[ICC_NSSNOC_QOSGEN_REF] = GCC_NSSNOC_QOSGEN_REF_CLK,
+	[ICC_NSSNOC_TIMEOUT_REF] = GCC_NSSNOC_TIMEOUT_REF_CLK,
+	[ICC_NSSNOC_XO_DCD] = GCC_NSSNOC_XO_DCD_CLK,
+	[ICC_NSSNOC_ATB] = GCC_NSSNOC_ATB_CLK,
+	[ICC_MEM_NOC_NSSNOC] = GCC_MEM_NOC_NSSNOC_CLK,
+	[ICC_NSSNOC_MEMNOC] = GCC_NSSNOC_MEMNOC_CLK,
+	[ICC_NSSNOC_MEM_NOC_1] = GCC_NSSNOC_MEM_NOC_1_CLK,
+};
+
 static const struct of_device_id gcc_ipq9574_match_table[] = {
 	{ .compatible = "qcom,ipq9574-gcc" },
 	{ }
@@ -4327,7 +4378,18 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gcc_ipq9574_desc);
+	int ret;
+
+	ret = qcom_cc_probe(pdev, &gcc_ipq9574_desc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "clock probe failed\n");
+
+	ret = qcom_cc_icc_register(&pdev->dev, gcc_ipq9574_clks, noc_clks,
+				   ARRAY_SIZE(noc_clks), IPQ_APPS_ID);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "interconnect register failed\n");
+
+	return 0;
 }
 
 static struct platform_driver gcc_ipq9574_driver = {
-- 
2.34.1


