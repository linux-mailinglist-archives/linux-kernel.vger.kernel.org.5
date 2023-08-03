Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758F476E60B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjHCK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjHCK7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:59:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7EB35A6;
        Thu,  3 Aug 2023 03:58:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3739rxYJ018463;
        Thu, 3 Aug 2023 10:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=IvbjYkcQ4xO4GHSYw7uTvmpP+2Y7A3N1+mj5asrdtcg=;
 b=CLA/IoNCJxPPjucy//YmLKdvT/BEL8AjURbzlfcE6EZaSp0sy6LtQNcJnM7Uh8rKxIbf
 v9bRhp2nAc4fKybwhoQgX3at+6kVq13TE94t2P57P4Lzkj3dBNjLoHp4IbahMaipp6og
 Mso9eQbqKKrbJ+zWYY+u8l1eA7D+0m9P4OTGtbPll38aLM9CKazM7iPVRmt7J3R281rQ
 zh5ZJ5m6AvmgmihGGDL2jLgzB2VMWVMCDqDFwcL6dhsB3HYi+4xez2BRd1Vas7ip7D2h
 jrTilk//DKexoSTV0RokLzuTeeOq6uRU2fD0wCGZf1UEfmYrhDo6Y/d2e5Dnfb9VeLFE zQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7vtv9gmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 10:58:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373Awfoi017055
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 10:58:41 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 03:58:35 -0700
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH V5 5/8] clk: qcom: gcc-qdu1000: Add gcc_ddrss_ecpri_gsi_clk support
Date:   Thu, 3 Aug 2023 16:27:38 +0530
Message-ID: <20230803105741.2292309-6-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
References: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MYL_YMJT-fcAlmc425GK1uP33GKpYaSr
X-Proofpoint-ORIG-GUID: MYL_YMJT-fcAlmc425GK1uP33GKpYaSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gcc_ddrss_ecpri_gsi_clk support as per the latest hardware
version of QDU1000 and QRU100 SoCs.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
Changes since v4:
 - Split the patch
 - Newly added

 drivers/clk/qcom/gcc-qdu1000.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index 97fd1947637a..5bf62f04cf12 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -1132,6 +1132,26 @@ static struct clk_branch gcc_ddrss_ecpri_dma_clk = {
 	},
 };
 
+static struct clk_branch gcc_ddrss_ecpri_gsi_clk = {
+	.halt_reg = 0x54298,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x54298,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x54298,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ddrss_ecpri_gsi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ecpri_ahb_clk = {
 	.halt_reg = 0x3a008,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -2523,6 +2543,7 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
 	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
 	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
 	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
+	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_qdu1000_resets[] = {
-- 
2.25.1

