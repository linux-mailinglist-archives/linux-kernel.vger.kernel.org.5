Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E97E803B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbjKJSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbjKJSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A522BE28;
        Fri, 10 Nov 2023 01:21:06 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA8mT8C012886;
        Fri, 10 Nov 2023 09:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=x+yLl1FGHwmlkVl1lM/pBENTu3Y9V9yOSaBE1nFRk08=;
 b=LRLkh/+RR+uoJRASZ3mouooqEaHHdMDEhu4qVmm9XaaDAVxIZmzXCfIzuPoF09/kkodC
 Lk42FLI6u54m7MxY5hrJD8RhZcA0xURy2v07VaQ9Ybp0oajV2HeWLejoeVgL647x8J04
 PjiySnALSD8AXzObhZthAVru3driR5reoJLrgdcyHGLbOiIWAHpnBX5i1b3OSgM9hFG1
 U6KHR5DdJ8zyfx4Nhr+z2lHvWM3O1hegiFOX32QIh0nBTPWNSbB8N+ptmfFmV0qCcp/q
 u9udb/K1WcVuZQ/MmbrnC52/M9DMMiO2nJjXD0nq0v5jXHddf2AX7fvJwtpOI/BYxtpM ug== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93rbsr6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:21:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA9L0dF000587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:21:00 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 01:20:53 -0800
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <quic_mmanikan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v6 08/11] remoteproc: qcom: q6v5: Add multipd interrupts support
Date:   Fri, 10 Nov 2023 14:49:36 +0530
Message-ID: <20231110091939.3025413-9-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110091939.3025413-1-quic_mmanikan@quicinc.com>
References: <20231110091939.3025413-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CeMagys3XLanGOOVjkaAZxeoKxS12Vr6
X-Proofpoint-ORIG-GUID: CeMagys3XLanGOOVjkaAZxeoKxS12Vr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=676 impostorscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v6:
	- Rebased on linux-next

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
index 4ee5e67a9f03..0e32f13c196d 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -112,7 +112,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
+irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 	size_t len;
@@ -132,8 +132,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(q6v5_fatal_interrupt);
 
-static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
+irqreturn_t q6v5_ready_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
 
@@ -141,6 +142,7 @@ static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(q6v5_ready_interrupt);
 
 /**
  * qcom_q6v5_wait_for_start() - wait for remote processor start signal
@@ -177,7 +179,17 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
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
 
@@ -185,6 +197,7 @@ static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(q6v5_stop_interrupt);
 
 /**
  * qcom_q6v5_request_stop() - request the remote processor to stop
@@ -214,6 +227,28 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
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

