Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978B785371
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjHWJFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjHWIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:53:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01471BF3;
        Wed, 23 Aug 2023 01:51:09 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N79CcG028861;
        Wed, 23 Aug 2023 08:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iW5JrOC1YQW/pJrddy1rYFptRArjo3CS53FyfQ1uQHM=;
 b=RjfITr4+GiPymyaUihIiBGXjAS5+KCWykQfyZxAaehCVj4A70+JPFviMciSA7D892tmG
 i9cbnpdSeeSAIMJxCPzaXvpfqrRH/UXXUIZjQdHnftYnOT1gZ6L/sDaVZNbGDhl7GZSs
 F1SfgVXUvpuI6Zc+XBsegtH6uJ0z4aSFNqPzXpQ29j1qaI+QQ0YzqwCl16a2XnAPCaeZ
 7D6BeCtc93BMH898wzAADLzHFPwJNUvpu0dAyvImqoW3xZJC5xPfZ1zEB0a9XJvXefq3
 1GE+fEfO8b+vzBZnI6KddBJu4OVYypkhaYlQ8DSO2xSKh6nguqeXaTDF9Kelde+hoeZK uA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2exscce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 08:50:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N8ouEa003305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 08:50:56 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 23 Aug 2023 01:50:53 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v5 1/4] clk: qcom: branch: Add clk_branch2_mdio_ops
Date:   Wed, 23 Aug 2023 16:50:28 +0800
Message-ID: <20230823085031.27252-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823085031.27252-1-quic_luoj@quicinc.com>
References: <20230823085031.27252-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qYFs-SrUI_osTXn6RoFsju5_3EhuzfFm
X-Proofpoint-ORIG-GUID: qYFs-SrUI_osTXn6RoFsju5_3EhuzfFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=924
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clk_branch2_mdio_ops for supporting clock controller
where the hardware register is accessed by MDIO bus, and the
spin lock can't be used because of sleep during the MDIO
operation.

The clock is enabled by the .prepare instead of .enable when
the clk_branch2_mdio_ops is used.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/clk-branch.c | 7 +++++++
 drivers/clk/qcom/clk-branch.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index fc4735f74f0f..5e08c026ca4a 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -153,3 +153,10 @@ const struct clk_ops clk_branch_simple_ops = {
 	.is_enabled = clk_is_enabled_regmap,
 };
 EXPORT_SYMBOL_GPL(clk_branch_simple_ops);
+
+const struct clk_ops clk_branch2_mdio_ops = {
+	.prepare = clk_branch2_enable,
+	.unprepare = clk_branch2_disable,
+	.is_prepared = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_mdio_ops);
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 0cf800b9d08d..4b006e8eec5e 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -85,6 +85,7 @@ extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;
 extern const struct clk_ops clk_branch2_aon_ops;
+extern const struct clk_ops clk_branch2_mdio_ops;
 
 #define to_clk_branch(_hw) \
 	container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
-- 
2.17.1

