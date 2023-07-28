Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448C766591
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjG1Hnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjG1Hnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:43:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99EB6;
        Fri, 28 Jul 2023 00:43:51 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S62CoO009561;
        Fri, 28 Jul 2023 06:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=q8DCUXejvrxrBsmlj5ksQRW0+XixJo9Je9crSxDJwmc=;
 b=gqG4cU7WBBlepGx1jqeDjRhfSP/ah1OMtORTdnRCK8Xe3/BMw3DkJv2uk250/PNiqd6X
 B6GWuev+8JoF4PxF7BOatU1hLMpqJyBfrLcM8VTdm8MCFJgsdfIeXt93vMb/CRKa0yhy
 gbdIaFeWDElOu92gQxvwX/HQ4PhNKzlWj15gZ3KxnuJlE47ZvQ40TQBObcIHoUfAnpsr
 mVY4PgEZ3vpDfH0EeUbXZ+6nYNf15Uy9BKznmLtpCfaZJiB4C/ZHvM0+Onse6RSFpWLw
 eAAeIDsIuI/7LcW+XWy+69SiYFWnGI5bJVV4JLDBTcDf4FqXI6sfT4Y8NkIUmex5AtNY Fg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s468r0783-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 06:35:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S6ZSfe008729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 06:35:28 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 23:35:22 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v4 08/11] remoteproc: qcom: q6v5: Add multipd interrupts support
Date:   Fri, 28 Jul 2023 12:04:09 +0530
Message-ID: <20230728063412.1641856-9-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
References: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7_fmshPnMu6TDiOP9wx4J5sxyPQLMgJN
X-Proofpoint-ORIG-GUID: 7_fmshPnMu6TDiOP9wx4J5sxyPQLMgJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=913
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280059
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
Changes in v4:
	- Rebased on linux-next

Changes in v3:
	- Rebased on linux-next

 drivers/remoteproc/qcom_q6v5.c | 37 +++++++++++++++++++++++++++++++---
 drivers/remoteproc/qcom_q6v5.h | 11 ++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 192c7aa0e39e..d535f3365865 100644
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
@@ -139,7 +139,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
+irqreturn_t q6v5_ready_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 
@@ -183,7 +183,16 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
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
+
+irqreturn_t q6v5_stop_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 
@@ -220,6 +229,28 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
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

