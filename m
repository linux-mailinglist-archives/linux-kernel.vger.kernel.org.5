Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD997F80A1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKXSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbjKXSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:51:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E92128;
        Fri, 24 Nov 2023 10:51:23 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOIpJpQ013983;
        Fri, 24 Nov 2023 18:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=BAKsVFzlF5IujEReLD889BfkxLLZ3bVRRTMGdedotqc=;
 b=jYZQgcf1HsaB8DJlBvZXZcieomNjSYKKZDgPG/yYV85SL11edsFGmCA9S35jQYihLqKe
 WQCuuJT5M0lONxHPylzFTMhqNqgr4/EH7SL/wMxuvCIK8Tnbd+skC0n1TALK0msT+rbs
 a7dQBt4hkQAedoV3DEc0rMveJ7unhSetHG8b1iyLE4Te2KpWtljdtqQHtoG1bLdCAMot
 Y4UlFX07bLxewkMVxXxRRl8eFkR77haPXiu3zyp92JUYTExe8i8sD5G0jbIUX+Wr9OV1
 m+5USQpj1l6ncsUe1HZgxOIx3YOIpHmH9DbJf1sgQglx9j/dlxX78Z+eDnjeaC1WekMP hA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujp8x1vvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 18:51:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOIpIrs026889
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 18:51:18 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 10:51:14 -0800
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_anusha@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH] remoteproc: qcom: q6v5: Get crash reason from specific SMEM partition
Date:   Sat, 25 Nov 2023 00:20:59 +0530
Message-ID: <20231124185059.3395563-1-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mR5gi813XbhiQSoQFrtKzPrCqdaHan-U
X-Proofpoint-ORIG-GUID: mR5gi813XbhiQSoQFrtKzPrCqdaHan-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_05,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=854 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240145
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q6v5 fatal and watchdog IRQ handlers always retrieves the crash reason
information from SMEM global partition (QCOM_SMEM_HOST_ANY).

For some targets like IPQ9574 and IPQ5332, crash reason information is
present in target specific partition due to which the crash reason is
not printed in the current implementation.

Add support to pass crash_reason_smem_id along with crash_reason item
number in qcom_q6v5_init call and use the same to get the crash
information from SMEM in fatal and watchdog IRQ handlers.

This patch depends on [1] which adds support for IPQ9574 and IPQ5332
remoteproc q5v5_mpd driver.

[1]: https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/

Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5.c      | 10 +++++++---
 drivers/remoteproc/qcom_q6v5.h      |  4 +++-
 drivers/remoteproc/qcom_q6v5_adsp.c |  3 ++-
 drivers/remoteproc/qcom_q6v5_mpd.c  |  2 +-
 drivers/remoteproc/qcom_q6v5_mss.c  |  5 +++--
 drivers/remoteproc/qcom_q6v5_pas.c  |  3 ++-
 drivers/remoteproc/qcom_q6v5_wcss.c |  4 +++-
 7 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 0e32f13c196d..072e41730110 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -100,7 +100,8 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
+	msg = qcom_smem_get(q6v5->crash_reason_smem_id, q6v5->crash_reason,
+			    &len);
 	if (!IS_ERR(msg) && len > 0 && msg[0])
 		dev_err(q6v5->dev, "watchdog received: %s\n", msg);
 	else
@@ -121,7 +122,8 @@ irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 	if (!q6v5->running)
 		return IRQ_HANDLED;
 
-	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
+	msg = qcom_smem_get(q6v5->crash_reason_smem_id, q6v5->crash_reason,
+			    &len);
 	if (!IS_ERR(msg) && len > 0 && msg[0])
 		dev_err(q6v5->dev, "fatal error received: %s\n", msg);
 	else
@@ -279,7 +281,8 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
  * Return: 0 on success, negative errno on failure
  */
 int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
-		   struct rproc *rproc, int crash_reason, const char *load_state,
+		   struct rproc *rproc, int crash_reason,
+		   int crash_reason_smem_id, const char *load_state,
 		   void (*handover)(struct qcom_q6v5 *q6v5))
 {
 	int ret;
@@ -287,6 +290,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	q6v5->rproc = rproc;
 	q6v5->dev = &pdev->dev;
 	q6v5->crash_reason = crash_reason;
+	q6v5->crash_reason_smem_id = crash_reason_smem_id;
 	q6v5->handover = handover;
 
 	init_completion(&q6v5->start_done);
diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
index 4e1bb1a68284..21cd879e6e1e 100644
--- a/drivers/remoteproc/qcom_q6v5.h
+++ b/drivers/remoteproc/qcom_q6v5.h
@@ -41,6 +41,7 @@ struct qcom_q6v5 {
 	struct completion spawn_done;
 
 	int crash_reason;
+	int crash_reason_smem_id;
 
 	bool running;
 
@@ -49,7 +50,8 @@ struct qcom_q6v5 {
 };
 
 int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
-		   struct rproc *rproc, int crash_reason, const char *load_state,
+		   struct rproc *rproc, int crash_reason,
+		   int crash_reason_smem_id, const char *load_state,
 		   void (*handover)(struct qcom_q6v5 *q6v5));
 void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
 
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 6c67514cc493..30d91205f199 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -732,7 +732,8 @@ static int adsp_probe(struct platform_device *pdev)
 		goto disable_pm;
 
 	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
-			     desc->load_state, qcom_adsp_pil_handover);
+			     QCOM_SMEM_HOST_ANY, desc->load_state,
+			     qcom_adsp_pil_handover);
 	if (ret)
 		goto disable_pm;
 
diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c b/drivers/remoteproc/qcom_q6v5_mpd.c
index b133285888c7..839f6a15b88d 100644
--- a/drivers/remoteproc/qcom_q6v5_mpd.c
+++ b/drivers/remoteproc/qcom_q6v5_mpd.c
@@ -726,7 +726,7 @@ static int q6_wcss_probe(struct platform_device *pdev)
 		goto free_rproc;
 
 	ret = qcom_q6v5_init(&wcss->q6, pdev, rproc,
-			     WCSS_CRASH_REASON, NULL, NULL);
+			     WCSS_CRASH_REASON, WCSS_SMEM_HOST, NULL, NULL);
 	if (ret)
 		goto free_rproc;
 
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 394b2c1cb5e2..45ecb87d73ef 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -26,6 +26,7 @@
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/smem.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 
@@ -2093,8 +2094,8 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->need_mem_protection = desc->need_mem_protection;
 	qproc->has_mba_logs = desc->has_mba_logs;
 
-	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM, "modem",
-			     qcom_msa_handover);
+	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
+			     QCOM_SMEM_HOST_ANY, "modem", qcom_msa_handover);
 	if (ret)
 		goto detach_proxy_pds;
 
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 913a5d2068e8..6a29b6ab181f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -728,7 +728,8 @@ static int adsp_probe(struct platform_device *pdev)
 		goto free_rproc;
 	adsp->proxy_pd_count = ret;
 
-	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem, desc->load_state,
+	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
+			     QCOM_SMEM_HOST_ANY, desc->load_state,
 			     qcom_pas_handover);
 	if (ret)
 		goto detach_proxy_pds;
diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index cff1fa07d1de..077ecfa2cf86 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/smem.h>
 #include "qcom_common.h"
 #include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
@@ -1047,7 +1048,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
+	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem,
+			     QCOM_SMEM_HOST_ANY, NULL, NULL);
 	if (ret)
 		goto free_rproc;
 
-- 
2.41.0

