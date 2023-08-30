Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3D78DF78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbjH3TJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbjH3K5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:57:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7D1A1;
        Wed, 30 Aug 2023 03:57:43 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UAowN5025732;
        Wed, 30 Aug 2023 10:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6ApzRDi9+5T/yvoF4BSR1HmpWrrT1en5k1oQ4x5JPE8=;
 b=NnY+zsPJdn4KU6yA2ozRVm5LRlT4zZTVhckVvMRv6Bxz8ZBK/TihFWWt3MDb9bdFkS4u
 kXooz7qNaplZim0SFmW63BjpLrfodujPSGvKvkJ9K0eMiedLcFGNXYzsyRQPwGNs1DZ7
 sQPPioarAx7uW3bXpfB1+txvz1BexY2amQkV1uW51fhq/OX6ubPLWjbwe0jCKu3QnYwy
 MD7J1mZl8su/qzoY6p2PyAmMZRmaLQNFjXSGKAn8wwSfH195DwXXYEiaw/AvPIn47iNk
 vfBrGuRkHblcwy78JxpkJLvCdLMtufgUr/6ICyGiDyUy0uRqBSGM0cfs89ZbOSkRKS8k tA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssmcv9mmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UAvd9p030554
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:57:39 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 03:57:34 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v8 4/6] soc: qcom: Add LLCC support for multi channel DDR
Date:   Wed, 30 Aug 2023 16:26:52 +0530
Message-ID: <20230830105654.28057-5-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1lSkc2PgVUpXR0ZzgZMX6JBQyGHPSc2P
X-Proofpoint-GUID: 1lSkc2PgVUpXR0ZzgZMX6JBQyGHPSc2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC support for multi channel DDR configuration
based on a feature register.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index cbef8d825361..c31d9e39e864 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
@@ -995,6 +996,24 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
 	return ret;
 }

+static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index, int num_config)
+{
+	int ret;
+
+	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
+	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
+		if (num_config > 1)
+			return -EINVAL;
+		*cfg_index = 0;
+		return 0;
+	}
+
+	if (!ret && *cfg_index >= num_config)
+		ret = -EINVAL;
+
+	return ret;
+}
+
 static int qcom_llcc_remove(struct platform_device *pdev)
 {
 	/* Set the global pointer to a error code to avoid referencing it */
@@ -1031,6 +1050,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	const struct qcom_llcc_config *cfg;
 	const struct llcc_slice_config *llcc_cfg;
 	u32 sz;
+	u8 cfg_index;
 	u32 version;
 	struct regmap *regmap;

@@ -1052,7 +1072,10 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto err;
 	}
-	cfg = &cfgs->llcc_config[0];
+	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index, cfgs->num_config);
+	if (ret)
+		goto err;
+	cfg = &cfgs->llcc_config[cfg_index];

 	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
 	if (ret)
--
2.41.0

