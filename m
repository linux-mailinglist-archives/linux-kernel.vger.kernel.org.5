Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068727ADDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjIYRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:23:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E97101;
        Mon, 25 Sep 2023 10:23:49 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PFHX9d024729;
        Mon, 25 Sep 2023 17:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=T3OwJhM/JeYff7ROz0beeSE0n+kPH8oKWpl5fSpxi08=;
 b=fPlX3INTdzefshW29dvh5eKmq3ojDVVVAwcsW/k98AvzVjciaPc/npfsr/BgwOSnFTJA
 tna4BjI1+ZrhN4bfMEtWIsnUeYumKTrf/MHYQ9FVlq5eBDnlX6wQeSaF5TQypeJsW0jv
 7QQn34uU7DAY7vyPwVEDUZWWT7XJD9YXK3fE67fN3ItSTtYq61j7yuCZqNmOUGDfei8e
 BMmC0TmcvxRMMF7tCYl6CDCLfKunY512n306FbxEHdUCrWRzCh7a0ektR+/ncqD0/lk/
 UrNzLVaIW3Qn4o6XdsBndDUwQDVja0nxUgbHR3eiydwGlYNBR/sZIQxBTr167SHNyNtq NQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb6tt181x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 17:23:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PHNY0k024258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 17:23:34 GMT
Received: from hu-omprsing-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 25 Sep 2023 10:23:29 -0700
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
To:     <quic_omprsing@quicinc.com>
CC:     <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
Subject: [PATCH V3] crypto: qcom-rng - Add hw_random interface support
Date:   Mon, 25 Sep 2023 22:53:12 +0530
Message-ID: <20230925172312.2843262-1-quic_omprsing@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XHIHu42yXeYgLyf3DQvJZGrf8le_2F77
X-Proofpoint-ORIG-GUID: XHIHu42yXeYgLyf3DQvJZGrf8le_2F77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309250135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Om Prakash Singh <omprsing@qti.qualcomm.com>

Add hw_random interface support in qcom-rng driver as new IP block
in Qualcomm SoC has inbuilt NIST SP800 90B compliant entropic source
to generate true random number.

Keeping current rng_alg interface as well for random number generation
using Kernel Crypto API.

Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
---

Changes in V3:
- Fix qcom_rng_read() implementation to account for remaining bytes read
- Update qcom_rng_generate() return condition for success case
- Added hwrng structure as part of qcom_rng structure

Changes in V2:
- Updated patch to fix the return value from qcom_rng_generate() to be
  consistent with current implementation
- Updated patch to make it more concise
- Removed unnecessary use local variable and it's initialization
- Updated patch to use devm_hwrng_register() instead of hwrng_register()
- Updated subject line of the patch

This patch is depends on [1]
[1] https://lore.kernel.org/lkml/20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org/


 drivers/crypto/qcom-rng.c | 66 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index fb54b8cfc35f..94cc9b539491 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
+#include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -28,17 +29,25 @@
 
 #define WORD_SZ			4
 
+#define QCOM_TRNG_QUALITY	1024
+
 struct qcom_rng {
 	struct mutex lock;
 	void __iomem *base;
 	struct clk *clk;
-	unsigned int skip_init;
+	struct hwrng hwrng;
+	struct qcom_rng_of_data *of_data;
 };
 
 struct qcom_rng_ctx {
 	struct qcom_rng *rng;
 };
 
+struct qcom_rng_of_data {
+	bool skip_init;
+	bool hwrng_support;
+};
+
 static struct qcom_rng *qcom_rng_dev;
 
 static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
@@ -66,11 +75,11 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 		} else {
 			/* copy only remaining bytes */
 			memcpy(data, &val, max - currsize);
-			break;
+			currsize = max;
 		}
 	} while (currsize < max);
 
-	return 0;
+	return currsize;
 }
 
 static int qcom_rng_generate(struct crypto_rng *tfm,
@@ -92,6 +101,9 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
 	mutex_unlock(&rng->lock);
 	clk_disable_unprepare(rng->clk);
 
+	if (ret >= 0)
+		ret = 0;
+
 	return ret;
 }
 
@@ -101,6 +113,13 @@ static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
 	return 0;
 }
 
+static int qcom_hwrng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
+{
+	struct qcom_rng *qrng =  container_of(hwrng, struct qcom_rng, hwrng);
+
+	return qcom_rng_read(qrng, data, max);
+}
+
 static int qcom_rng_enable(struct qcom_rng *rng)
 {
 	u32 val;
@@ -136,7 +155,7 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
 
 	ctx->rng = qcom_rng_dev;
 
-	if (!ctx->rng->skip_init)
+	if (!ctx->rng->of_data->skip_init)
 		return qcom_rng_enable(ctx->rng);
 
 	return 0;
@@ -177,15 +196,31 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->skip_init = (unsigned long)device_get_match_data(&pdev->dev);
+	rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
 	if (ret) {
 		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
 		qcom_rng_dev = NULL;
+		return ret;
+	}
+
+	if (rng->of_data->hwrng_support) {
+		rng->hwrng.name = "qcom_hwrng";
+		rng->hwrng.read = qcom_hwrng_read;
+		rng->hwrng.quality = QCOM_TRNG_QUALITY;
+		ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
+		if (ret) {
+			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
+			qcom_rng_dev = NULL;
+			goto fail;
+		}
 	}
 
+	return ret;
+fail:
+	crypto_unregister_rng(&qcom_rng_alg);
 	return ret;
 }
 
@@ -198,6 +233,21 @@ static int qcom_rng_remove(struct platform_device *pdev)
 	return 0;
 }
 
+struct qcom_rng_of_data qcom_prng_of_data = {
+	.skip_init = false,
+	.hwrng_support = false,
+};
+
+struct qcom_rng_of_data qcom_prng_ee_of_data = {
+	.skip_init = true,
+	.hwrng_support = false,
+};
+
+struct qcom_rng_of_data qcom_trng_of_data = {
+	.skip_init = true,
+	.hwrng_support = true,
+};
+
 static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 	{ .id = "QCOM8160", .driver_data = 1 },
 	{}
@@ -205,9 +255,9 @@ static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
 
 static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
-	{ .compatible = "qcom,prng", .data = (void *)0},
-	{ .compatible = "qcom,prng-ee", .data = (void *)1},
-	{ .compatible = "qcom,trng", .data = (void *)1},
+	{ .compatible = "qcom,prng", .data = &qcom_prng_of_data },
+	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_of_data },
+	{ .compatible = "qcom,trng", .data = &qcom_trng_of_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
-- 
2.25.1

