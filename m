Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DAF7E1E4D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjKFKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjKFKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:31:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE0D76;
        Mon,  6 Nov 2023 02:31:00 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6AT8hl005917;
        Mon, 6 Nov 2023 10:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ui0TpnDxm/PD0ICcBgQgSuY/u4cUR2raymATdRzjfng=;
 b=FXMq7xX4tVFwynOgG67UFoOz/rQKUDDTyn+hF0vtCVvZgbicOCWdm9mdxHduJw++fnhq
 Jjd6cnHq/IUAgVesGpQzjrM0m7/dUUjfxv9ZCvTyyunD80qvscEeC0rJ6/ahn/u+VKHq
 BqZ/Ak4vi+JwLxME9I8yaNW+oxn0QDYVgHN1jS6zroivPxbuUGfce2p6ZamZrr5HhwPW
 +7ZvstWDSVkCOoHIQ4v48Sj8l8mhZK1HOrmFJbqeZNYAcPV2RQt8ffwaEVGoT6aJ6vuu
 ZgT3SiltAvz+mAGCtm+tEc/dcrGzrteDoMEZcZ5y4ZYGcxkCmZuDIw2aHYVobicErPeP Xw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6xdu806r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 10:30:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6AUu3E007848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 10:30:56 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 02:30:51 -0800
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH V3 2/4] clk: qcom: branch: Add mem ops support for branch2 clocks
Date:   Mon, 6 Nov 2023 16:00:25 +0530
Message-ID: <20231106103027.3988871-3-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231106103027.3988871-1-quic_imrashai@quicinc.com>
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4gvZTFpkkUmhGVkov1VJO46lonNShc6N
X-Proofpoint-ORIG-GUID: 4gvZTFpkkUmhGVkov1VJO46lonNShc6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_08,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/clk/qcom/clk-branch.c | 39 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-branch.h | 21 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index fc4735f74f0f..61bdd2147bed 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -134,6 +135,44 @@ static void clk_branch2_disable(struct clk_hw *hw)
 	clk_branch_toggle(hw, false, clk_branch2_check_halt);
 }
 
+static int clk_branch2_mem_enable(struct clk_hw *hw)
+{
+	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
+	struct clk_branch branch = mem_br->branch;
+	const char *name = clk_hw_get_name(&branch.clkr.hw);
+	u32 val;
+	int ret;
+
+	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
+			mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
+
+	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
+			val, val & mem_br->mem_enable_ack_mask, 0, 200);
+	if (ret) {
+		WARN(1, "%s mem enable failed\n", name);
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
+						mem_br->mem_enable_ack_mask, 0);
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

