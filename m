Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254E37F3EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjKVHLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjKVHLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:11:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE9D4F;
        Tue, 21 Nov 2023 23:11:34 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5pbxB026792;
        Wed, 22 Nov 2023 07:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=8KIIwOOYOAIVazDSSyJZiSoqwV8HHBUfe3McSpMe1TE=;
 b=kKY8t7vNAZgNm0ZH+/86F3Vg3hSmWTXw11nbPCUFoySbik2L44/W/2/9F9OpaVRtPrvA
 aIRRVUN5YvK8C34rTLRzUqh4kq/Y9ZKnb5Djwp5ItVQl4FGJ+6U/qAPMNJ6bTDq7KkIy
 hJk+wJapi7G4FjSgWvriL5mpWik/yINbgVuAJtIrigrx2GTtjil/uOLaW5xlpnEdaQr7
 tS85mCVhj+eC76xWFTYFBVykljQ0vFtbxm1t+wMjj2c/l4ClO4d3R4U/v3VQvR6h7kQx
 HxL3UHRh7t/0z184gxYx58CkARhTzn17OuycSpZ0BCL8RyNh8w6algIyLMi0Xa8urVTn xA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugu54avpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 07:11:08 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AM7079U009949;
        Wed, 22 Nov 2023 07:11:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3uhcusg3yn-1;
        Wed, 22 Nov 2023 07:11:07 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM73gRb016631;
        Wed, 22 Nov 2023 07:11:07 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3AM7B6Ck027691;
        Wed, 22 Nov 2023 07:11:07 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id A51AA20A65; Tue, 21 Nov 2023 23:11:06 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 09/11] phy: qualcomm: phy-qcom-qmp-ufs: Use tbls_hs_max instead of tbls_hs_g4
Date:   Tue, 21 Nov 2023 23:10:40 -0800
Message-Id: <1700637042-11104-10-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com>
References: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mjiel9YjSWy5SyAmriOj2vmlnC8hDKRD
X-Proofpoint-ORIG-GUID: Mjiel9YjSWy5SyAmriOj2vmlnC8hDKRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=961 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220050
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Table tbls_hs_g4 is added to support HS Gear 4 and applied only if PHY
submode is HS_G4. In future, we are adding support for Gear 5 and higher.
To avoiding adding more tables, like tbls_hs_g5, let's use tbls_hs_max
instead of tbls_hs_g4. In addition, max_hs_gear is added to indicate the
maximum supported HS Gear of each configuration, so that we can check PHY
submode against it to tell if tbls_hs_max needs to be applied.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 49 +++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index ad91f92..cae27a9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -735,8 +735,11 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_cfg_tbls tbls;
 	/* Additional sequence for HS Series B */
 	const struct qmp_phy_cfg_tbls tbls_hs_b;
-	/* Additional sequence for HS G4 */
-	const struct qmp_phy_cfg_tbls tbls_hs_g4;
+	/* Additional sequence for maximum supported HS Gear */
+	const struct qmp_phy_cfg_tbls tbls_hs_max;
+
+	/* Maximum supported HS Gear */
+	u32 max_hs_gear;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -839,7 +842,7 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
 	.lanes			= 1,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G3,
 	.tbls = {
 		.serdes		= msm8996_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(msm8996_ufsphy_serdes),
@@ -864,7 +867,7 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G4,
 	.tbls = {
 		.serdes		= sm8350_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
@@ -879,7 +882,7 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
 		.serdes		= sm8350_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
 	},
-	.tbls_hs_g4 = {
+	.tbls_hs_max = {
 		.tx		= sm8350_ufsphy_g4_tx,
 		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
 		.rx		= sm8350_ufsphy_g4_rx,
@@ -898,7 +901,7 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G4,
 	.tbls = {
 		.serdes		= sm8350_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
@@ -913,7 +916,7 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 		.serdes		= sm8350_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
 	},
-	.tbls_hs_g4 = {
+	.tbls_hs_max = {
 		.tx		= sm8350_ufsphy_g4_tx,
 		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
 		.rx		= sm8350_ufsphy_g4_rx,
@@ -932,7 +935,7 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G3,
 	.tbls = {
 		.serdes		= sdm845_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
@@ -960,7 +963,7 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 	.lanes			= 1,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G3,
 	.tbls = {
 		.serdes		= sm6115_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_serdes),
@@ -988,7 +991,7 @@ static const struct qmp_phy_cfg sm7150_ufsphy_cfg = {
 	.lanes			= 1,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G3,
 	.tbls = {
 		.serdes		= sdm845_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
@@ -1016,7 +1019,7 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G4,
 	.tbls = {
 		.serdes		= sm8150_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
@@ -1031,7 +1034,7 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 		.serdes		= sm8150_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
 	},
-	.tbls_hs_g4 = {
+	.tbls_hs_max = {
 		.tx		= sm8150_ufsphy_hs_g4_tx,
 		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
 		.rx		= sm8150_ufsphy_hs_g4_rx,
@@ -1050,7 +1053,7 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G4,
 	.tbls = {
 		.serdes		= sm8150_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
@@ -1065,7 +1068,7 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
 		.serdes		= sm8150_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
 	},
-	.tbls_hs_g4 = {
+	.tbls_hs_max = {
 		.tx		= sm8250_ufsphy_hs_g4_tx,
 		.tx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
 		.rx		= sm8250_ufsphy_hs_g4_rx,
@@ -1084,7 +1087,7 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G4,
 	.tbls = {
 		.serdes		= sm8350_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
@@ -1099,7 +1102,7 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 		.serdes		= sm8350_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
 	},
-	.tbls_hs_g4 = {
+	.tbls_hs_max = {
 		.tx		= sm8350_ufsphy_g4_tx,
 		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
 		.rx		= sm8350_ufsphy_g4_rx,
@@ -1118,7 +1121,7 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets,
-
+	.max_hs_gear		= UFS_HS_G4,
 	.tbls = {
 		.serdes		= sm8350_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
@@ -1133,7 +1136,7 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 		.serdes		= sm8350_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
 	},
-	.tbls_hs_g4 = {
+	.tbls_hs_max = {
 		.tx		= sm8350_ufsphy_g4_tx,
 		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
 		.rx		= sm8350_ufsphy_g4_rx,
@@ -1152,7 +1155,7 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
 	.lanes			= 2,
 
 	.offsets		= &qmp_ufs_offsets_v6,
-
+	.max_hs_gear		= UFS_HS_G4,
 	.tbls = {
 		.serdes		= sm8550_ufsphy_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_serdes),
@@ -1235,11 +1238,11 @@ static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg
 	if (qmp->mode == PHY_MODE_UFS_HS_B)
 		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
 	qmp_ufs_lanes_init(qmp, &cfg->tbls);
-	if (qmp->submode == UFS_HS_G4)
-		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g4);
+	if (qmp->submode == cfg->max_hs_gear)
+		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_max);
 	qmp_ufs_pcs_init(qmp, &cfg->tbls);
-	if (qmp->submode == UFS_HS_G4)
-		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
+	if (qmp->submode == cfg->max_hs_gear)
+		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_max);
 }
 
 static int qmp_ufs_com_init(struct qmp_ufs *qmp)
-- 
2.7.4

