Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E8575EE18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGXInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjGXInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:43:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F071701;
        Mon, 24 Jul 2023 01:42:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O5CWP2030675;
        Mon, 24 Jul 2023 08:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fRlUdx1JahT8slZ1UyjzZzdieDTlQF0q8s2w31EHaPY=;
 b=mcm9vRbP7GYl6S1zlwRfjS58Q8WA2EfoexYiB2WrpuzQkRGKj6dX+ojqVPdXWXoiv3Ch
 ZFBUfwIA7nEH6IVRPV5SEMYIcRAdvcoiEAmlvbFKZGTmy0oFpLsxuB/UMy0riWMXNXCZ
 8VO8iwZ3ROyaXylwAMCsz78Am4+gLKRuBg1Sx8590T1P0Hdq+1JSxWIPvtTNTCPSDBl6
 b9uYrUE7YIUkQUzrbiSDcz2ju8C2BnsMK7hsF4h33xJQ8AE2G+ylzwmxg1hgiLgfp3L9
 Kkr/xEKA/zO36LmB8wlRGIMH6UljggDWk6ckQEjycV4WOJ4vT5da9F46r972m5VaTv0l tg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s06q9at5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:42:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36O8giGJ012859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:42:44 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 01:42:40 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v5 4/6] soc: qcom: Add LLCC support for multi channel DDR
Date:   Mon, 24 Jul 2023 14:11:53 +0530
Message-ID: <20230724084155.8682-5-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ayX2h8P1-HFByAVwFMoY0c_C7goXso3Y
X-Proofpoint-GUID: ayX2h8P1-HFByAVwFMoY0c_C7goXso3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC support for multi channel DDR configuration
based on a feature register.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 321f8d2079f7..1d2b08dfecea 100644
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
@@ -997,6 +998,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
 	return ret;
 }
 
+static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
+{
+	int ret;
+
+	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
+	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
+		*cfg_index = 0;
+		return 0;
+	}
+
+	return ret;
+}
+
 static int qcom_llcc_remove(struct platform_device *pdev)
 {
 	/* Set the global pointer to a error code to avoid referencing it */
@@ -1033,6 +1047,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	const struct qcom_llcc_config *cfg;
 	const struct llcc_slice_config *llcc_cfg;
 	u32 sz;
+	u8 cfg_index;
 	u32 version;
 	struct regmap *regmap;
 
@@ -1050,7 +1065,16 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	}
 
 	cfgs = of_device_get_match_data(&pdev->dev);
-	cfg = &cfgs->llcc_config[0];
+	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
+	 if (ret)
+		goto err;
+
+	if (cfg_index >= cfgs->num_cfgs) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	cfg = &cfgs->llcc_config[cfg_index];
 
 	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
 	if (ret)
-- 
2.40.1

