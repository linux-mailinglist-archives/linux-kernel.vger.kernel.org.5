Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1276CFA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjHBOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjHBOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:07:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3E72726;
        Wed,  2 Aug 2023 07:07:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372CfB0v011873;
        Wed, 2 Aug 2023 14:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=HWaB3j2GUiIV3JA1mJ7uLPzAboDdgM2xc69Nr/GA/Ck=;
 b=lsdGh0+536evUGnw020sGcDBGdNMpTugJ3tZX7aPaHh4HCK0fQKg0beuDIGRJtzSTpNd
 QZfiRgnJjxiIQU0dyZPipSWUxQ68/Cj/rM8I6j2xpQzj8363F4YzYJR0QbxMgh81bYUT
 X6dxX9YrKrBy9bjgNoAvs/V1XyscnrCFGLPYQzhWdVRrblC5RNXE9j2AWgumd3np9Qts
 B8qtAWgVszUiq+m7PPb86X1sSL/BpUS2htskWmduztePKwevRoJWM/V5WPVuUQ4TTRIN
 kcnDhRe7bwc1z8Uswisrh/dCU+PXhuX9oXz1k9VIWHkaZ9PM2ETCVCfwR9IRcHOc+oVX vA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b32jq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 14:07:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372E7S2D023439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 14:07:28 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 07:07:21 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v5 08/11] remoteproc: qcom: q6v5: Add multipd interrupts support
Date:   Wed, 2 Aug 2023 19:36:03 +0530
Message-ID: <20230802140606.2041889-9-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
References: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k5Q1c_cM8dvP9wD7IN9D6DtXhHJaV6Rj
X-Proofpoint-ORIG-GUID: k5Q1c_cM8dvP9wD7IN9D6DtXhHJaV6Rj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=807 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multipd model, root & user pd remoteproc's interrupts are
different. User pd needs additional interrupts like spawn.
Instead of going with qcom_q6v5_init(), we defined a new
function to register userpd rproc interrupts in mpd driver.
Since userpd rproc uses some of common interrupts like fatal,
ready, static is removed from ISR handler and used in userpd
interrupt registration.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in v5:
	- Exported symbols to resolve errors reported here
https://lore.kernel.org/oe-kbuild-all/202307301307.LGjSxmY8-lkp@intel.com/

Changes in v4:
	- Rebased on linux-next

Changes in v3:
	- Rebased on linux-next

 drivers/remoteproc/qcom_q6v5.c | 41 +++++++++++++++++++++++++++++++---
 drivers/remoteproc/qcom_q6v5.h | 11 +++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 192c7aa0e39e..f8f05fd686e5 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -118,7 +118,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
+irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 	size_t len;
@@ -138,8 +138,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(q6v5_fatal_interrupt);
 
-static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
+irqreturn_t q6v5_ready_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 
@@ -147,6 +148,7 @@ static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(q6v5_ready_interrupt);
 
 /**
  * qcom_q6v5_wait_for_start() - wait for remote processor start signal
@@ -183,7 +185,17 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
+irqreturn_t q6v5_spawn_interrupt(int irq, void *data)
+{
+	struct qcom_q6v5 *q6v5 = data;
+
+	complete(&q6v5->spawn_done);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(q6v5_spawn_interrupt);
+
+irqreturn_t q6v5_stop_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 
@@ -191,6 +203,7 @@ static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(q6v5_stop_interrupt);
 
 /**
  * qcom_q6v5_request_stop() - request the remote processor to stop
@@ -220,6 +233,28 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
 
+/**
+ * qcom_q6v5_request_spawn() - request the remote processor to spawn
+ * @q6v5:      reference to qcom_q6v5 context
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5)
+{
+	int ret;
+
+	ret = qcom_smem_state_update_bits(q6v5->spawn_state,
+					  BIT(q6v5->spawn_bit), BIT(q6v5->spawn_bit));
+
+	ret = wait_for_completion_timeout(&q6v5->spawn_done, 5 * HZ);
+
+	qcom_smem_state_update_bits(q6v5->spawn_state,
+				    BIT(q6v5->spawn_bit), 0);
+
+	return ret == 0 ? -ETIMEDOUT : 0;
+}
+EXPORT_SYMBOL_GPL(qcom_q6v5_request_spawn);
+
 /**
  * qcom_q6v5_panic() - panic handler to invoke a stop on the remote
  * @q6v5:	reference to qcom_q6v5 context
diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
index 5a859c41896e..4e1bb1a68284 100644
--- a/drivers/remoteproc/qcom_q6v5.h
+++ b/drivers/remoteproc/qcom_q6v5.h
@@ -18,21 +18,27 @@ struct qcom_q6v5 {
 
 	struct qcom_smem_state *state;
 	struct qmp *qmp;
+	struct qcom_smem_state *shutdown_state;
+	struct qcom_smem_state *spawn_state;
 
 	struct icc_path *path;
 
 	unsigned stop_bit;
+	unsigned shutdown_bit;
+	unsigned spawn_bit;
 
 	int wdog_irq;
 	int fatal_irq;
 	int ready_irq;
 	int handover_irq;
 	int stop_irq;
+	int spawn_irq;
 
 	bool handover_issued;
 
 	struct completion start_done;
 	struct completion stop_done;
+	struct completion spawn_done;
 
 	int crash_reason;
 
@@ -50,7 +56,12 @@ void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon);
+int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
 unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
+irqreturn_t q6v5_fatal_interrupt(int irq, void *data);
+irqreturn_t q6v5_ready_interrupt(int irq, void *data);
+irqreturn_t q6v5_spawn_interrupt(int irq, void *data);
+irqreturn_t q6v5_stop_interrupt(int irq, void *data);
 
 #endif
-- 
2.34.1

