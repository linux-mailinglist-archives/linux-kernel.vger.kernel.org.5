Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9737EFDB4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 05:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjKRE2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 23:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRE2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 23:28:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F4D6C;
        Fri, 17 Nov 2023 20:27:58 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI4PBgm009358;
        Sat, 18 Nov 2023 04:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mmbeYwPJXBs03oqwKkyxo03V4OBjPFgRa6rJJ6jq74I=;
 b=Ew2hxtAdC8my2ihzyC4bBf+TYdBvFG5tkV5FJPROg1JPIFSLtefTdOwbcCPy5wabofYv
 sjq4lSFDZiPOzj2swrQgqGVb5T1UevVW7VzWh+B07L34KFVTL14yYMtoaH6DpBIKmI7N
 otiRw3k5HjUlJgnSq7VIU76Lc/wXyeb99Az89e4kKBLlgPA9x9tktjET0pvRnZf06r2Q
 eTYmrw53KWG6om90tgvnoJ3dYMt2lDY1WX8Bg9oHLaZtQXcSUbE3J7pzzPHH0snubgOq
 zoyOeQ7IenibyBIIoTABw5VVnBK/rNtXz4+etfl3UidZT15anSGWb5zXx8N2zGMv5Pw8 ig== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uep1qr0ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 04:27:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI4RhWY005891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 04:27:43 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 20:27:42 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC:     <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v2 2/6] iommu/arm-smmu-qcom: Add support for TBUs
Date:   Fri, 17 Nov 2023 20:27:26 -0800
Message-ID: <20231118042730.2799-3-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
References: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I9o253_haUnl9NecnLEHSkYFIxvoruw6
X-Proofpoint-ORIG-GUID: I9o253_haUnl9NecnLEHSkYFIxvoruw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_02,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM MMU-500 implements a Translation Buffer Unit (TBU) for each
connected master besides a single TCU which controls and manages the
address translations.

Allow the Qualcomm SMMU driver to probe for any TBU devices that can
provide additional debug features like triggering transactions, logging
outstanding transactions, snapshot capture etc. The primary use-case
would be to get information from a TBU and print it during a context
fault.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 8 ++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..1622abace484 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved
  */
 
 #include <linux/acpi.h>
 #include <linux/adreno-smmu-priv.h>
 #include <linux/delay.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 
 #include "arm-smmu.h"
@@ -444,6 +446,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	const struct device_node *np = smmu->dev->of_node;
 	const struct arm_smmu_impl *impl;
 	struct qcom_smmu *qsmmu;
+	int ret;
 
 	if (!data)
 		return ERR_PTR(-EINVAL);
@@ -467,6 +470,11 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	qsmmu->smmu.impl = impl;
 	qsmmu->cfg = data->cfg;
 
+	INIT_LIST_HEAD(&qsmmu->tbu_list);
+	ret = devm_of_platform_populate(smmu->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return &qsmmu->smmu;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 593910567b88..2164a9cf3dde 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ARM_SMMU_QCOM_H
@@ -12,6 +12,8 @@ struct qcom_smmu {
 	bool bypass_quirk;
 	u8 bypass_cbndx;
 	u32 stall_enabled;
+	struct mutex tbu_list_lock;  /* protects tbu_list */
+	struct list_head tbu_list;
 };
 
 enum qcom_smmu_impl_reg_offset {
