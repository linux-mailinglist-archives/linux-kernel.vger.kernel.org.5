Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315297EB162
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjKNN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjKNN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:57:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514D184;
        Tue, 14 Nov 2023 05:57:40 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEBu2W1022180;
        Tue, 14 Nov 2023 13:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=w5UCpaz3Zq6dC68llce1pHBAMDao5lmmp9n6zlvVR3Y=;
 b=jhuREr3yE2G9/Mk+UGYl9Kw93vwAis+3Oatj/oKdSVCcvjZlPYgNaASeu2xHRuCMRNPg
 1k+fxreUaxTzwvumFn2hc82+R2oB1ASdswn/P0FdlhAQ+Tc7YvmG+sO4QAHY0u6tIeVC
 qxUZuZU9rETH5SMGonCuqi4w2jSo27vQllbqpNXMIVKYqMR1omBnEzy5R/UTQvjrE0BI
 ig0Z2VDaD3U72wxuIU9p8J8FMO3hcVbBeDHYSs7HO5mxOqjSemJifIdJ70EPYc8rI2GE
 Y8U4j5T/lFrbYMr51uXD5XrP9nrQ9YwPMv9IBBFFBgHcKn/NguW1k0JX36s72VJg9lHi 3g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubw6hhk29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 13:57:27 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEDvRIj011379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 13:57:27 GMT
Received: from hyd-lablnx450.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 05:57:22 -0800
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Subject: [PATCH v2 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Date:   Tue, 14 Nov 2023 19:26:53 +0530
Message-ID: <20231114135654.30475-3-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XbffI96zI-q3OP_M_XGVtx2D4bx4DjXA
X-Proofpoint-GUID: XbffI96zI-q3OP_M_XGVtx2D4bx4DjXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACTLR data table for SM8550 along with support for
same including SM8550 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92 +++++++++++++++++++++-
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 578c662c7c30..0eaf6f2a2e49 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -25,6 +25,70 @@ struct actlr_data {
 	u32 actlr;
 };

+#define PRE_FETCH_1	0
+#define PRE_FETCH_2	BIT(8)
+#define PRE_FETCH_3	(BIT(9) | BIT(8))
+#define CPRE		BIT(1)		/* Enable context caching in the prefetch buffer */
+#define CMTLB		BIT(0)		/* Enable context caching in the macro TLB */
+
+static const struct actlr_data sm8550_apps_actlr_data[] = {
+	{ 0x18a0, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x18e0, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x0800, 0x0020, PRE_FETCH_1 | CMTLB },
+	{ 0x1800, 0x00c0, PRE_FETCH_1 | CMTLB },
+	{ 0x1820, 0x0000, PRE_FETCH_1 | CMTLB },
+	{ 0x1860, 0x0000, PRE_FETCH_1 | CMTLB },
+	{ 0x0c01, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c02, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c03, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c04, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c05, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c06, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c07, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c08, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c09, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c0c, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c0d, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c0e, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x0c0f, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1961, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1962, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1963, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1964, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1965, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1966, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1967, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1968, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1969, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x196c, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x196d, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x196e, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x196f, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c1, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c2, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c3, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c4, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c5, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c6, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c7, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c8, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19c9, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19cc, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19cd, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19ce, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x19cf, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
+	{ 0x1c00, 0x0002, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1c01, 0x0000, PRE_FETCH_1 | CMTLB },
+	{ 0x1920, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1923, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1924, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1940, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1941, 0x0004, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1943, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1944, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+	{ 0x1947, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
+};
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -459,6 +523,16 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
 	.tlb_sync = qcom_smmu_tlb_sync,
 };

+
+static const struct arm_smmu_impl sm8550_smmu_500_impl = {
+	.init_context = qcom_smmu_init_context,
+	.cfg_probe = qcom_smmu_cfg_probe,
+	.def_domain_type = qcom_smmu_def_domain_type,
+	.reset = arm_mmu500_reset,
+	.write_s2cr = qcom_smmu_write_s2cr,
+	.tlb_sync = qcom_smmu_tlb_sync,
+};
+
 static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.def_domain_type = qcom_smmu_def_domain_type,
@@ -522,6 +596,11 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
 	.reg_offset = qcom_smmu_impl0_reg_offset,
 };

+static const struct actlr_config sm8550_actlrcfg = {
+	.adata = sm8550_apps_actlr_data,
+	.size = ARRAY_SIZE(sm8550_apps_actlr_data),
+};
+
 /*
  * It is not yet possible to use MDP SMMU with the bypass quirk on the msm8996,
  * there are not enough context banks.
@@ -545,16 +624,20 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+
+static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
+	.impl = &sm8550_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrcfg = &sm8550_actlrcfg,
+};
+
 static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
 	.adreno_impl = &qcom_adreno_smmu_500_impl,
 	.cfg = &qcom_smmu_impl0_cfg,
 };

-/*
- * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
- * special handling and can not be covered by the qcom,smmu-500 entry.
- */
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
@@ -579,6 +662,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
 	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ }
 };
--
2.17.1

