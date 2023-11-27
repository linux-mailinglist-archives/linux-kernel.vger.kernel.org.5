Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900007FA3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjK0OzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjK0OzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:55:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C65A8;
        Mon, 27 Nov 2023 06:55:12 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARCd40U015593;
        Mon, 27 Nov 2023 14:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Vh37UVXR5nk5/AzISWikhLbcI2bsv8QZJ/MzjEfRCvQ=;
 b=BxuB0JUFsHFogizIRgKMmqqLCXYn/cc+SpyDb3oxLcoRdq1eDEg+z0lRrXuVq+MyDTev
 FtYcpwQ3wssNY/Me6IECLvQFoH9sPEmD30yLd5eCu03tQ9r0AakSsfjY2xCdY2WoOFCU
 sUnMcjXioW37EjRhOmoQjzpOk4kSuEiC4Zye9e9a+Gequq8tVDrKA3JkfqtQvzzDVurB
 xbA4Hl76MP2iYQcsV2IhkY8hBm+DOa9cjSBqb7j8kXRRk+0aRCGkwHqmwd6ikkb8STgB
 o5R4sDbmpAVCq/o/0rMGzBfQaHaaYjSM34S1HFmKXLNhhuKZlQUkddAX71+99fyv/aen 2A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt4qgjfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 14:54:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AREsoaO006238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 14:54:50 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 06:54:44 -0800
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_bjorande@quicinc.com>,
        <mani@kernel.org>, <quic_eberman@quicinc.com>,
        <robdclark@chromium.org>, <u.kleine-koenig@pengutronix.de>,
        <robh@kernel.org>, <vladimir.oltean@nxp.com>,
        <quic_pkondeti@quicinc.com>, <quic_molvera@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Subject: [PATCH v3 2/4] iommu/arm-smmu: add ACTLR data and support for SM8550
Date:   Mon, 27 Nov 2023 20:24:10 +0530
Message-ID: <20231127145412.3981-3-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231127145412.3981-1-quic_bibekkum@quicinc.com>
References: <20231127145412.3981-1-quic_bibekkum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UezS2yHwJQb0IqKAhc1i6HiUGs--X0fx
X-Proofpoint-GUID: UezS2yHwJQb0IqKAhc1i6HiUGs--X0fx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_13,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACTLR data table for SM8550 along with support for
same including SM8550 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 4a38cae29be2..247eaa194129 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -20,6 +20,75 @@ struct actlr_config {
 	u32 actlr;
 };

+#define PREFETCH_DISABLE	0
+#define PREFETCH_SHALLOW	BIT(8)
+#define PREFETCH_DEEP		(BIT(9) | BIT(8))
+#define PREFETCH_DEEP_GFX	(BIT(9) | BIT(8) | BIT(5) | BIT(3))
+#define CPRE			BIT(1)		/* Enable context caching in the prefetch buffer */
+#define CMTLB			BIT(0)		/* Enable context caching in the macro TLB */
+
+static const struct actlr_config sm8550_apps_actlr_cfg[] = {
+	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x0800, 0x0020, PREFETCH_DISABLE | CMTLB },
+	{ 0x1800, 0x00c0, PREFETCH_DISABLE | CMTLB },
+	{ 0x1820, 0x0000, PREFETCH_DISABLE | CMTLB },
+	{ 0x1860, 0x0000, PREFETCH_DISABLE | CMTLB },
+	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c07, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c08, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c09, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0c, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0d, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0e, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0f, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1961, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1962, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1963, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1964, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1965, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1966, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1967, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1968, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1969, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196c, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196d, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196e, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196f, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c1, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c2, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c3, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c4, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c5, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c6, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c7, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c8, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c9, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cc, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cd, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19ce, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cf, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1c00, 0x0002, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1c01, 0x0000, PREFETCH_DISABLE | CMTLB },
+	{ 0x1920, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1923, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1924, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1940, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1941, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1943, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1944, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+};
+
+static const struct actlr_config sm8550_gfx_actlr_cfg[] = {
+	{ 0x0000, 0x03ff, PREFETCH_DEEP_GFX | CPRE | CMTLB },
+};
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -557,6 +626,17 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+
+static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrcfg = sm8550_apps_actlr_cfg,
+	.actlrcfg_size = ARRAY_SIZE(sm8550_apps_actlr_cfg),
+	.actlrcfg_gfx = sm8550_gfx_actlr_cfg,
+	.actlrcfg_gfx_size = ARRAY_SIZE(sm8550_gfx_actlr_cfg),
+};
+
 static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
 	.adreno_impl = &qcom_adreno_smmu_500_impl,
@@ -590,6 +670,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
 	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ }
 };
--
2.17.1

