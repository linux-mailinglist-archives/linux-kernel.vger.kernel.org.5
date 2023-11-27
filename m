Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7B7F9F58
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjK0MOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjK0MOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:14:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC810CA;
        Mon, 27 Nov 2023 04:14:46 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARBuci5022349;
        Mon, 27 Nov 2023 12:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Mwt/tc7oxaZVaxbhV5hYKe81nZekUp6gxT1uZJu+xF4=;
 b=Lm8MSf934ZNE1T3gS9kaDm8MdqdqdflC1ym9U2ttfAUjTzCkKJelpDkc0j1fwWjxvLJA
 VzelAuhJDeZaVHMYaefPprKy7Qf+5dttH2ez5//PmjyqGiSVcSoX+LEuysy0GUqsDl6K
 gRTHTFyGYyZb+c53nqCqhGXPr8Y0h3aas5uIMstJDzPv9wY+DsmXQv+3DLzgTk0ZjQby
 3En75hSuR2r5z7PtDLFS/2xbhJQREYUIa+D+hjQKpKsirpCTojlDQE048KoG1+CbWyh0
 80UJgSf/PoU4HSDE29MIgJn0fFxuMHPmyX1/avQE72+Cvl/GGUR2qKLkXqxK+BtRfEoN hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk9adm2un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:14:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARCEdAM014936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:14:39 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 04:14:33 -0800
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Mon, 27 Nov 2023 17:43:51 +0530
Subject: [PATCH v3 3/3] phy: qcom-qmp-pcie: Add support for keeping refclk
 always on
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-refclk_always_on-v3-3-26d969fa8f1d@quicinc.com>
References: <20231127-refclk_always_on-v3-0-26d969fa8f1d@quicinc.com>
In-Reply-To: <20231127-refclk_always_on-v3-0-26d969fa8f1d@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya chundru" <quic_krichai@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701087256; l=2385;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=w21FU3eA0VG4vGK0aaYA0Nrf7F5/HCavLA1e1RaBndc=;
 b=HCVVnv8YB0O2ZOyoGkIuHDninTGdT9FJjAmNErVSYkGZsmuBLpiW7GdMH4pg7zioo4aXFmRUl
 vJfZecH13gLBl6gud4nA0Cv9qODw0DVkOuLTOm8BhBJyVj5bQ01oxnl
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6a_EMSw5V3MRyOLGPyw_vUQEdbw9RpdM
X-Proofpoint-GUID: 6a_EMSw5V3MRyOLGPyw_vUQEdbw9RpdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PCIe low power states like L1.1 or L1.2 the phy will stop
supplying refclk to endpoint. If endpoint asserts clkreq to bring
back link L0, then RC needs to provide refclk to endpoint.

Some platforms with pcie switch fail to drive the clkreq signal to
the host from the endpoints because of the switch board design.
Due to that refclk needs to supplied to the endpoint always.

Add a flag to keep refclk always supplied to endpoint.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 7fdf9b2596b6..e95f677817f7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -43,6 +43,8 @@
 /* QPHY_PCS_STATUS bit */
 #define PHYSTATUS				BIT(6)
 #define PHYSTATUS_4_20				BIT(7)
+/* PCS_PCIE_ENDPOINT_REFCLK_CNTRL */
+#define EPCLK_ALWAYS_ON_EN			BIT(6)
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 
@@ -2264,6 +2266,8 @@ struct qmp_pcie {
 	struct phy *phy;
 	int mode;
 
+	bool refclk_always_on;
+
 	struct clk_fixed_rate pipe_clk_fixed;
 };
 
@@ -3179,6 +3183,10 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
 	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
 	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
 
+	if (qmp->refclk_always_on && cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL])
+		qphy_setbits(pcs_misc, cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL],
+			     EPCLK_ALWAYS_ON_EN);
+
 	if (cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
 		qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
 		qmp_pcie_init_port_b(qmp, tbls);
@@ -3701,6 +3709,12 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
+	qmp->refclk_always_on = of_property_read_bool(dev->of_node, "qcom,refclk-always-on");
+	if (qmp->refclk_always_on && !qmp->cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]) {
+		dev_err(dev, "refclk is always on is present but refclk cntrl offset is not present\n");
+		goto err_node_put;
+	}
+
 	ret = phy_pipe_clk_register(qmp, np);
 	if (ret)
 		goto err_node_put;

-- 
2.42.0

