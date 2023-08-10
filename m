Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28357777017
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjHJGMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjHJGMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:12:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8772A26A2;
        Wed,  9 Aug 2023 23:12:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A5Dgcn004843;
        Thu, 10 Aug 2023 06:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0HbzvvjcjLz9l5agv6qPHBWnjXgbYSBxd5SJZlQ6Tko=;
 b=lEYDw4VHsXlzNZXWRPXFytwW4o3ZsLWlgOJEhkTDu5YmKkDtZBiDMb9PkYEmtI9ERKo5
 pEl25uL0xtzVAFno7K2Xko/CUrYmSdJ508vKHWKyTKZINMUJ4691YZz5lO7qekGFhfh4
 0rKZzAR1aft5GIgFlzjGZni0SuByA/AUefVrHq6QmwegVjY2+ZKIdayiz//suj0VZYp+
 8C0DyXB5JL6lDwi5yLVLWJGrDuBDAKf+TYK5HTAi6oeqobHGwA/JlJ6RsI0qkf4eUbNJ
 /KMdcBFdWPTXo0ogaB92egbIvTSRoTtxCC0DW8g0xMH5dQKf4TF9ZaXBnZHXJEwrh4dI bA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sch7cru7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:12:21 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A6CLiv022819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:12:21 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 23:12:17 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 4/6] soc: qcom: Add LLCC support for multi channel DDR
Date:   Thu, 10 Aug 2023 11:41:38 +0530
Message-ID: <20230810061140.15608-5-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mtf7zB05vn6mQDvRqcXwvg27y52EjX5u
X-Proofpoint-GUID: Mtf7zB05vn6mQDvRqcXwvg27y52EjX5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_05,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100051
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
 drivers/soc/qcom/llcc-qcom.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 76e8083d053d..4fad2cff5e1e 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
@@ -998,6 +999,24 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
 	return ret;
 }

+static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index, int num_config)
+{
+	int ret;
+
+	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
+	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
+		if (num_config != DEF_NUM_CFG)
+			return -EINVAL;
+		*cfg_index = DEF_NUM_CFG - 1;
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
@@ -1034,6 +1053,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	const struct qcom_llcc_config *cfg;
 	const struct llcc_slice_config *llcc_cfg;
 	u32 sz;
+	u8 cfg_index;
 	u32 version;
 	struct regmap *regmap;

@@ -1051,11 +1071,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	}

 	cfgs = of_device_get_match_data(&pdev->dev);
-	if (!cfgs || cfgs->num_config != DEF_NUM_CFG) {
+	if (!cfgs) {
 		ret = -EINVAL;
 		goto err;
 	}
-	cfg = &cfgs->llcc_config[DEF_NUM_CFG - 1];
+	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index, cfgs->num_config);
+	if (ret)
+		goto err;
+	cfg = &cfgs->llcc_config[cfg_index];

 	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
 	if (ret)
--
2.41.0

