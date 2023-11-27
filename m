Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE57F9F55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjK0MOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjK0MOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:14:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D618E;
        Mon, 27 Nov 2023 04:14:39 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARC7EZI020721;
        Mon, 27 Nov 2023 12:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Hrl2aH6q5tbRJjwS/p1ZIAlXo3Tyl2J9JqtUC+NcOlg=;
 b=YD6B/fVBqLFdkxJD2qKKpwi3dtpVBgMoxrn9oOlOdroTej7KsSVIaRRafayCk8guQWtT
 /Ja2GQb/0q8nU1iGmKqnb/RJMNAh5JbfX/5M7vrCgpOtHTZWIyOPS7zLrQIb4/ZzNDTD
 19kQSkaV8nX1rp//sKBKS/BMh/ewLWcwT48uwRxwy64uHdyswwh8XM8t2xpyKDlx0AkN
 InSSTiSgTr+04kG1ihlAatXn/wHhkfsqN8Y0mGeNzyEINzwEHNfwduWhY83F5cnfkiBr
 ommgv/c0ZvgIwy/0V6zPdbhGVST667G6aaX7W6ZwKj0IJ6CMqPN+4gG+JoCNpvsuSnab 4g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umsvag498-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:14:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARCEXGx014992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:14:33 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 04:14:27 -0800
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Mon, 27 Nov 2023 17:43:50 +0530
Subject: [PATCH v3 2/3] phy: qcom-qmp-pcie: Add endpoint refclk control
 register offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-refclk_always_on-v3-2-26d969fa8f1d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701087256; l=7893;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=zlC1QBfGdF7yJT7+ZJ4klJbwvf3gHtfUq2/3y5cyV8k=;
 b=BTf9zbyAQRK6oWZhsDULCgB8KYfJH14Z852EOUSttxZTA8iQfWKJwGgWH+ziL8RTEaOjd7J5c
 Sd/lDbZvCMFCdrrbjpqr8L73vgh5ZvblIm5AXZjiALOyJTeAZONIzhL
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UNa9VerpIVdQDc-V5Iw6pXCV3hY3lkvx
X-Proofpoint-GUID: UNa9VerpIVdQDc-V5Iw6pXCV3hY3lkvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=784 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms needs to keep endpoint refclk always on, for this
purpose add this offset for all the applicable phy versions.

And also add reg layout for few controllers as we are adding
endpoint refclk control register which changes based upon phy version.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 26 +++++++++++++++++++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h    |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |  4 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h      |  4 ++++
 6 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index a63ca7424974..7fdf9b2596b6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -77,6 +77,7 @@ enum qphy_reg_layout {
 	QPHY_START_CTRL,
 	QPHY_PCS_STATUS,
 	QPHY_PCS_POWER_DOWN_CONTROL,
+	QPHY_PCS_ENDPOINT_REFCLK_CNTRL,
 	/* Keep last to ensure regs_layout arrays are properly initialized */
 	QPHY_LAYOUT_SIZE
 };
@@ -93,6 +94,7 @@ static const unsigned int pciephy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V3_PCS_START_CONTROL,
 	[QPHY_PCS_STATUS]		= QPHY_V3_PCS_PCS_STATUS,
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V3_PCS_POWER_DOWN_CONTROL,
+	[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]	= QPHY_V3_PCS_ENDPOINT_REFCLK_CNTRL,
 };
 
 static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
@@ -107,6 +109,7 @@ static const unsigned int pciephy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V4_PCS_START_CONTROL,
 	[QPHY_PCS_STATUS]		= QPHY_V4_PCS_PCS_STATUS1,
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_POWER_DOWN_CONTROL,
+	[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]	= QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
 };
 
 static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
@@ -114,6 +117,23 @@ static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V5_PCS_START_CONTROL,
 	[QPHY_PCS_STATUS]		= QPHY_V5_PCS_PCS_STATUS1,
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V5_PCS_POWER_DOWN_CONTROL,
+	[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]	= QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
+};
+
+static const unsigned int pciephy_v5_20_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V5_20_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V5_20_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V5_20_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V5_20_PCS_POWER_DOWN_CONTROL,
+	[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]	= QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
+};
+
+static const unsigned int pciephy_v6_20_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V6_20_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V6_20_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V6_20_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_20_PCS_POWER_DOWN_CONTROL,
+	[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]	= QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_CNTRL,
 };
 
 static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
@@ -2956,7 +2976,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= pciephy_v5_regs_layout,
+	.regs			= pciephy_v5_20_regs_layout,
 
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
@@ -3012,7 +3032,7 @@ static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
 	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
 	.vreg_list		= sm8550_qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
-	.regs			= pciephy_v5_regs_layout,
+	.regs			= pciephy_v6_20_regs_layout,
 
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
@@ -3047,7 +3067,7 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
 	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs			= pciephy_v5_regs_layout,
+	.regs			= pciephy_v5_20_regs_layout,
 
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
index a469ae2a10a1..9b166286afda 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
@@ -11,6 +11,7 @@
 #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2		0x0c
 #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4		0x14
 #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x20
+#define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_CNTRL		0x24
 #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1		0x54
 #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
 #define QPHY_V5_PCS_PCIE_EQ_CONFIG2			0xa8
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
index cdf8c04ea078..8b114e538a07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
@@ -9,6 +9,7 @@
 /* Only for QMP V5_20 PHY - PCIe PCS registers */
 #define QPHY_V5_20_PCS_PCIE_POWER_STATE_CONFIG2		0x00c
 #define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_V5_20_PCS_PCIE_ENDPOINT_REFCLK_CNTRL	0x020
 #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5	0x084
 #define QPHY_V5_20_PCS_PCIE_OSC_DTCT_ACTIONS		0x090
 #define QPHY_V5_20_PCS_PCIE_EQ_CONFIG1			0x0a0
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
index e3eb08776339..f7abe95c49ad 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
@@ -10,6 +10,7 @@
 #define QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2		0x00c
 #define QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG		0x018
 #define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_CNTRL	0x020
 #define QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS		0x090
 #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG1			0x0a0
 #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG5			0x108
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
index f0754b6f9e3a..96f9232214d7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
@@ -6,6 +6,10 @@
 #ifndef QCOM_PHY_QMP_PCS_V5_20_H_
 #define QCOM_PHY_QMP_PCS_V5_20_H_
 
+#define QPHY_V5_20_PCS_SW_RESET				0x000
+#define QPHY_V5_20_PCS_PCS_STATUS1			0x014
+#define QPHY_V5_20_PCS_POWER_DOWN_CONTROL		0x040
+#define QPHY_V5_20_PCS_START_CONTROL			0x044
 #define QPHY_V5_20_PCS_G3S2_PRE_GAIN			0x170
 #define QPHY_V5_20_PCS_RX_SIGDET_LVL			0x188
 #define QPHY_V5_20_PCS_EQ_CONFIG2			0x1d8
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
index 9c3f1e4950e6..cc3d40badb5d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
@@ -7,6 +7,10 @@
 #define QCOM_PHY_QMP_PCS_V6_20_H_
 
 /* Only for QMP V6_20 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_20_PCS_SW_RESET				0x000
+#define QPHY_V6_20_PCS_PCS_STATUS1			0x014
+#define QPHY_V6_20_PCS_POWER_DOWN_CONTROL		0x040
+#define QPHY_V6_20_PCS_START_CONTROL			0x044
 #define QPHY_V6_20_PCS_G3S2_PRE_GAIN			0x178
 #define QPHY_V6_20_PCS_RX_SIGDET_LVL			0x190
 #define QPHY_V6_20_PCS_COM_ELECIDLE_DLY_SEL		0x1b8

-- 
2.42.0

