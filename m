Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7D7754A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjHIIBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjHIIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:01:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC41736;
        Wed,  9 Aug 2023 01:01:24 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37953lwT030120;
        Wed, 9 Aug 2023 08:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PGlkphZklzrmw9lf7Qf6hvlt1uz+HLiNoqHvXNGe6NA=;
 b=h8uA2M7MsxzN1s28JcXwuAWuXu+Fbf6vLRT3A5LgN8HLAJvrLT3QFqSbFxzeJvulH11z
 6A3xT+Z4F8TMGr0YBxb3UjrFGQVugt4Q7ntIjMKORK1ueZigHxseeTDA//v6qnYsclVc
 9IlasYBi1BdNg4130raRDmuZsXz8LhIDRnkkMISIDtx1OEbq+4tdWRRN6qCjbvKa6dVC
 GjmZDJWPPD8Grxc0FKoE0CdKFb3bt/C9L3r36zjHa9NBvUg5VpyLMDYok6Zb+m8njsWR
 aOAJJMENdJ9Z5na6x6zTAA09nRBndbAVObDkC0BVF+/GTcoc+dTRXG7hgRZ600Ix6lqm NQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbmrqj7e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:01:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37981AKh000983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 08:01:10 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 01:01:06 -0700
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
Subject: [PATCH v1 1/4] clk: qcom: branch: Add clk_branch2_qca8k_ops
Date:   Wed, 9 Aug 2023 16:00:44 +0800
Message-ID: <20230809080047.19877-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230809080047.19877-1-quic_luoj@quicinc.com>
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wsAg7wrsow8VaXTcldvAnXb3-iFDcvi3
X-Proofpoint-ORIG-GUID: wsAg7wrsow8VaXTcldvAnXb3-iFDcvi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_05,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=930
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clk_branch2_qca8k_ops for supporting clock controller
where the hardware register is accessed by MDIO bus, and the
spin clock can't be used because of sleep during the MDIO
operation.

The clock is enabled by the .prepare instead of .enable when
the clk_branch2_qca8k_ops is used.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/clk-branch.c | 8 ++++++++
 drivers/clk/qcom/clk-branch.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index fc4735f74f0f..d07f2677c877 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -153,3 +154,10 @@ const struct clk_ops clk_branch_simple_ops = {
 	.is_enabled = clk_is_enabled_regmap,
 };
 EXPORT_SYMBOL_GPL(clk_branch_simple_ops);
+
+const struct clk_ops clk_branch2_qca8k_ops = {
+	.prepare = clk_branch2_enable,
+	.unprepare = clk_branch2_disable,
+	.is_prepared = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_qca8k_ops);
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 0cf800b9d08d..37b092bf4d79 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2013, The Linux Foundation. All rights reserved. */
+/* Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved. */
 
 #ifndef __QCOM_CLK_BRANCH_H__
 #define __QCOM_CLK_BRANCH_H__
@@ -85,6 +86,7 @@ extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;
 extern const struct clk_ops clk_branch2_aon_ops;
+extern const struct clk_ops clk_branch2_qca8k_ops;
 
 #define to_clk_branch(_hw) \
 	container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
-- 
2.17.1

