Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDD7F588C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjKWGsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjKWGs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:48:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0595DC1;
        Wed, 22 Nov 2023 22:48:34 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5VaB7014995;
        Thu, 23 Nov 2023 06:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zLe1y3kuWGQrjLMqYkPVWmcXsNYl0WXXwIpjab4Plz4=;
 b=DNNnC7lOSXtU5zIU+TnDja5irCwXOVF+0kY/3eoaQ5lKcoVq/ZRvMtbK40izK00Q92O4
 oJk+c2w+vZQGGFXIoy7/MrQXteZemlZU2/SOowu9+LdrU7W5m9FoRnT6dS1wBtTY2y5E
 MbappMS5uPwgIRKnJNad2MnDnR2SQqHguA3fbwhCkXVmzynurfu6YdnKCWqfCRUlrYQN
 Hy1Q68M9jjgVM8Dp3vjH7R4t/S/QrKQANwytgdmwCgi0R5TlC+TwBkjeOIvUdCAYek1B
 6MPGJM0Zo4TG9KE3DrQtSAZFLGeLraMLwusqXCYz2D+JBCKEsXfGusqR7GkJJQY5h7UD UQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhkfnsuwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 06:48:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN6mU1m011867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 06:48:30 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 22:48:25 -0800
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH V5 2/4] clk: qcom: branch: Add mem ops support for branch2 clocks
Date:   Thu, 23 Nov 2023 12:17:33 +0530
Message-ID: <20231123064735.2979802-3-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123064735.2979802-1-quic_imrashai@quicinc.com>
References: <20231123064735.2979802-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PLb76y0kAOXpdAIQUv2jy3diYun7Sdxa
X-Proofpoint-ORIG-GUID: PLb76y0kAOXpdAIQUv2jy3diYun7Sdxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

Add the support for mem ops implementation to handle the sequence of
enable/disable of the memories in ethernet PHY, prior to enable/disable
of the respective clocks, which helps retain the respecive block's
register contents.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 drivers/clk/qcom/clk-branch.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-branch.h | 21 +++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index fc4735f74f0f..c1dba33ac31a 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -134,6 +135,43 @@ static void clk_branch2_disable(struct clk_hw *hw)
 	clk_branch_toggle(hw, false, clk_branch2_check_halt);
 }
 
+static int clk_branch2_mem_enable(struct clk_hw *hw)
+{
+	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
+	struct clk_branch branch = mem_br->branch;
+	u32 val;
+	int ret;
+
+	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
+			   mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
+
+	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
+				       val, val & mem_br->mem_enable_ack_mask, 0, 200);
+	if (ret) {
+		WARN(1, "%s mem enable failed\n", clk_hw_get_name(&branch.clkr.hw));
+		return ret;
+	}
+
+	return clk_branch2_enable(hw);
+}
+
+static void clk_branch2_mem_disable(struct clk_hw *hw)
+{
+	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
+
+	regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
+			   mem_br->mem_enable_ack_mask, 0);
+
+	return clk_branch2_disable(hw);
+}
+
+const struct clk_ops clk_branch2_mem_ops = {
+	.enable = clk_branch2_mem_enable,
+	.disable = clk_branch2_mem_disable,
+	.is_enabled = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_mem_ops);
+
 const struct clk_ops clk_branch2_ops = {
 	.enable = clk_branch2_enable,
 	.disable = clk_branch2_disable,
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 0cf800b9d08d..8ffed603c050 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -38,6 +38,23 @@ struct clk_branch {
 	struct clk_regmap clkr;
 };
 
+/**
+ * struct clk_mem_branch - gating clock which are associated with memories
+ *
+ * @mem_enable_reg: branch clock memory gating register
+ * @mem_ack_reg: branch clock memory ack register
+ * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
+ * @branch: branch clock gating handle
+ *
+ * Clock which can gate its memories.
+ */
+struct clk_mem_branch {
+	u32	mem_enable_reg;
+	u32	mem_ack_reg;
+	u32	mem_enable_ack_mask;
+	struct clk_branch branch;
+};
+
 /* Branch clock common bits for HLOS-owned clocks */
 #define CBCR_CLK_OFF			BIT(31)
 #define CBCR_NOC_FSM_STATUS		GENMASK(30, 28)
@@ -85,8 +102,12 @@ extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;
 extern const struct clk_ops clk_branch2_aon_ops;
+extern const struct clk_ops clk_branch2_mem_ops;
 
 #define to_clk_branch(_hw) \
 	container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
 
+#define to_clk_mem_branch(_hw) \
+	container_of(to_clk_branch(_hw), struct clk_mem_branch, branch)
+
 #endif
-- 
2.25.1

