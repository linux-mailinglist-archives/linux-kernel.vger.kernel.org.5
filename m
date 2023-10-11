Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A557C4DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjJKJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbjJKJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:01:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A21C9;
        Wed, 11 Oct 2023 02:01:04 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B5BkYa002077;
        Wed, 11 Oct 2023 09:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Y4wEDoMpk13iZO/vnhoLmHfho056wqVjGdKTmHs3Muw=;
 b=e9fVRaHl48lGxeBaxs6dkGZ8KhQhNcRUGcLhRs1U9QkCSUop44BXT9Rv9eiEZ2HZWwkt
 fmDwA6Cn7eJrKiCaqOaJi9FQLiy9yH6Rpf36O2cFMWk7hR2MeQh7a5rs6d7ED9SKH/A4
 ChfyOGrnIbENmDzZwcj3Mc3WngjeeCTyiHfh5ttlslae9V2R0VOnuMdB0HDcQ1EOYXRU
 t0C7gbjaCWRqCkV+5/zEJTV81QPCYHKPb/wZGfRkVL0xQZEA4Rhxtn6VoIaPgxXGxvrK
 F/POQbTcnjBlr6w3zrLLkhEuAsrpPMjUduFRZb6vjH3Gc69+O6tlJv00LMVLBQczhUPb mg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnkwngjsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 09:00:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B90ucM013656
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 09:00:56 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 11 Oct 2023 02:00:51 -0700
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
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH V2 2/4] clk: qcom: branch: Add mem ops support for branch2 clocks
Date:   Wed, 11 Oct 2023 14:30:26 +0530
Message-ID: <20231011090028.1706653-3-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2zM7KYbvdVmmK5it56QkqekRq0m7HckJ
X-Proofpoint-GUID: 2zM7KYbvdVmmK5it56QkqekRq0m7HckJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=980
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

Clock CBCRs with memories need an update for memory before enable/disable
of the clock, which helps retain the respective block's register contents.
Add support for the mem ops to handle this sequence.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 drivers/clk/qcom/clk-branch.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-branch.h | 21 ++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index fc4735f74f0f..9ac8d04b425a 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -134,6 +135,42 @@ static void clk_branch2_disable(struct clk_hw *hw)
 	clk_branch_toggle(hw, false, clk_branch2_check_halt);
 }
 
+static int clk_branch2_mem_enable(struct clk_hw *hw)
+{
+	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
+	const char *name = clk_hw_get_name(&mem_br->branch.clkr.hw);
+	u32 val;
+	int timeout = 200, ret;
+
+	regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
+			mem_br->mem_enable_ack_bit, mem_br->mem_enable_ack_bit);
+
+	ret = regmap_read_poll_timeout(mem_br->branch.clkr.regmap, mem_br->mem_ack_reg,
+			val, val & mem_br->mem_enable_ack_bit, 0, timeout);
+	if (ret) {
+		WARN(1, "%s mem enable failed", name);
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
+						mem_br->mem_enable_ack_bit, 0);
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
index 0cf800b9d08d..fa1ef1cf1aff 100644
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
+ * @mem_enable_ack_bit: ANDed with @mem_ack_reg to check memory enablement
+ * @branch: handle clock gating
+ *
+ * Clock which can gate its memories.
+ */
+struct clk_mem_branch {
+	u32	mem_enable_reg;
+	u32	mem_ack_reg;
+	u32	mem_enable_ack_bit;
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

