Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333547E0ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjKCVyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjKCVxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:53:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F223D5A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 14:53:50 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3LSZ8r004521;
        Fri, 3 Nov 2023 21:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZwSQsV0rJVY3FXPpR987A+Fln9pKhEeMDyb7+8jIUos=;
 b=fpnNGQNeZyT6A9GFJSFPMEdzA5rkjMfvdfJQ1KzHnlXpqwMVL3NkGZ8oojMehfF7FTka
 PPdZ9C9esgaXWkVsz5Iur7WV38536OWoplwCBheW1/KnK6HrPybRML1n1dbP+SsafVpd
 tSNK+dK+cwE12vGxbHRKw563tvE0oHIPvtwNnnoD/u46UfK6vdF/YPCGSnQ/Wv8wqu9/
 0t8moXK/az1+2u7daVSPN6/6K/+vdTCpUGUzW2X/0vbgTgmp0LpvpGBZEw0idXeV9zLk
 bGKHH63ujWTW0Rdhp0W/vmg2qpNu39EfWzLmSehTI+q4rOFWVcNSo86nkr5VgcOaZfUa RQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4reva62v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 21:53:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3Lra5h003856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 21:53:36 GMT
Received: from hyd-lablnx450.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 14:53:31 -0700
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_saipraka@quicinc.com>,
        <quic_pkondeti@quicinc.com>, <quic_molvera@quicinc.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Date:   Sat, 4 Nov 2023 03:21:23 +0530
Message-ID: <20231103215124.1095-3-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M2pdkuPqEFYEHa-TVOAKW_7vv2q7NHzx
X-Proofpoint-ORIG-GUID: M2pdkuPqEFYEHa-TVOAKW_7vv2q7NHzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_20,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030185
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
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 +++++++++++++++++++++-
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 68c1f4908473..590b7c285299 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -25,6 +25,64 @@ struct actlr_data {
 	u32 actlr;
 };

+static const struct actlr_data sm8550_apps_actlr_data[] = {
+	{ 0x18a0, 0x0000, 0x00000103 },
+	{ 0x18e0, 0x0000, 0x00000103 },
+	{ 0x0800, 0x0020, 0x00000001 },
+	{ 0x1800, 0x00c0, 0x00000001 },
+	{ 0x1820, 0x0000, 0x00000001 },
+	{ 0x1860, 0x0000, 0x00000001 },
+	{ 0x0c01, 0x0020, 0x00000303 },
+	{ 0x0c02, 0x0020, 0x00000303 },
+	{ 0x0c03, 0x0020, 0x00000303 },
+	{ 0x0c04, 0x0020, 0x00000303 },
+	{ 0x0c05, 0x0020, 0x00000303 },
+	{ 0x0c06, 0x0020, 0x00000303 },
+	{ 0x0c07, 0x0020, 0x00000303 },
+	{ 0x0c08, 0x0020, 0x00000303 },
+	{ 0x0c09, 0x0020, 0x00000303 },
+	{ 0x0c0c, 0x0020, 0x00000303 },
+	{ 0x0c0d, 0x0020, 0x00000303 },
+	{ 0x0c0e, 0x0020, 0x00000303 },
+	{ 0x0c0f, 0x0020, 0x00000303 },
+	{ 0x1961, 0x0000, 0x00000303 },
+	{ 0x1962, 0x0000, 0x00000303 },
+	{ 0x1963, 0x0000, 0x00000303 },
+	{ 0x1964, 0x0000, 0x00000303 },
+	{ 0x1965, 0x0000, 0x00000303 },
+	{ 0x1966, 0x0000, 0x00000303 },
+	{ 0x1967, 0x0000, 0x00000303 },
+	{ 0x1968, 0x0000, 0x00000303 },
+	{ 0x1969, 0x0000, 0x00000303 },
+	{ 0x196c, 0x0000, 0x00000303 },
+	{ 0x196d, 0x0000, 0x00000303 },
+	{ 0x196e, 0x0000, 0x00000303 },
+	{ 0x196f, 0x0000, 0x00000303 },
+	{ 0x19c1, 0x0010, 0x00000303 },
+	{ 0x19c2, 0x0010, 0x00000303 },
+	{ 0x19c3, 0x0010, 0x00000303 },
+	{ 0x19c4, 0x0010, 0x00000303 },
+	{ 0x19c5, 0x0010, 0x00000303 },
+	{ 0x19c6, 0x0010, 0x00000303 },
+	{ 0x19c7, 0x0010, 0x00000303 },
+	{ 0x19c8, 0x0010, 0x00000303 },
+	{ 0x19c9, 0x0010, 0x00000303 },
+	{ 0x19cc, 0x0010, 0x00000303 },
+	{ 0x19cd, 0x0010, 0x00000303 },
+	{ 0x19ce, 0x0010, 0x00000303 },
+	{ 0x19cf, 0x0010, 0x00000303 },
+	{ 0x1c00, 0x0002, 0x00000103 },
+	{ 0x1c01, 0x0000, 0x00000001 },
+	{ 0x1920, 0x0000, 0x00000103 },
+	{ 0x1923, 0x0000, 0x00000103 },
+	{ 0x1924, 0x0000, 0x00000103 },
+	{ 0x1940, 0x0000, 0x00000103 },
+	{ 0x1941, 0x0004, 0x00000103 },
+	{ 0x1943, 0x0000, 0x00000103 },
+	{ 0x1944, 0x0000, 0x00000103 },
+	{ 0x1947, 0x0000, 0x00000103 },
+};
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -444,6 +502,16 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
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
@@ -507,6 +575,11 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
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
@@ -530,16 +603,20 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
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
--
2.17.1

