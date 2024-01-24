Return-Path: <linux-kernel+bounces-36407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA97383A038
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E076E1C24A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C868747A;
	Wed, 24 Jan 2024 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lGvWib3L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719A33F1;
	Wed, 24 Jan 2024 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067673; cv=none; b=Y4TdmqFNmCaIhTc8ijzHvz0dmiGMaVlY09Nl64jGPG4T8hIjUd1ypXGYIFmIqT48W75Ok4N2AQyB/P73kG5RM/7sthOtJ39EozSPu9A6uRu5o4XovXjXZNrfy7yoem5slsrBOUgwSwmFLIRWAaUlD4sKpTC4YffizX71KO2WxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067673; c=relaxed/simple;
	bh=YbdZbFhNRexnzQJ8KzOSQyOP7gMOqMh44cT2Q10sWjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=utroHsG66fyzOFXrkKoiyiip5pootgIgd/4QVxdkcb8BhCzxfNtnzRMBlvW2+VCwlvGvYANJWL+QXSfs2M8B60Jq5oU5QCed28GNeHcd/EFlO/UbdZijQ7RxQUXVq7BuIyg//ySBDw//E+rc+POHIr9F5g8zVUC8sxxemCUY3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lGvWib3L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O2gbbD023828;
	Wed, 24 Jan 2024 03:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=WwO
	90U/7nROoyjnpAOtpVHQe8d4IDwOjDg1DW/rOxj8=; b=lGvWib3LAAz2yK971qE
	BP3xg3Q6QFPsWSEh9CGYxXD3CJC+q32bJ/V/Wf6WVtsANCo/c3qDqwPd8FmNB5w6
	GvWDn8MLyuBzQ0kK7cG0AJmebDrc8f8dZXMZN44M36DokfGEi74tH3gOfs2MAtse
	iophD86SqE4FsstVeb74eLM5Ko7F5gJuFZBg5E9PTWU7CGUemT6nlISVSY6tvLkQ
	PUEFeI5/jkd+9NRi0UWTqvvrXDgCx2FoeE5yETM7L4ur+z3CMV8746NZv/UXOWSc
	8YTagV7QJgqDRUkdXaOUPFyKrp70E/hutCSaBu8dPx1AskV3oZf2EAiqKdnMf9gr
	6wQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgwgp8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 03:41:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O3f5dp006867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 03:41:05 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 19:41:05 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 23 Jan 2024 19:40:33 -0800
Subject: [PATCH v2] soc: qcom: aoss: Add tracepoints in qmp_send()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-qcom-aoss-tracepoints-v2-1-bd73baa31977@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALCGsGUC/3WNQQ6CMBBFr0K6dkxbIFpX3sOwaMdBJsEWWiAaw
 t0t7F2+n//yVpEoMiVxK1YRaeHEwWfQp0JgZ/2LgJ+ZhZa6lEZfYMTwBhtSgilapCGwnxJgfS0
 1Wk1OG5FdZxOBi9Zjl20/930eh0gtf47Yo8nccZpC/B7tRe3rnqmkUv8yiwIFVWvK2miJbeXu4
 8zIHs/5Lppt236PproU0QAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706067665; l=3418;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=YbdZbFhNRexnzQJ8KzOSQyOP7gMOqMh44cT2Q10sWjc=;
 b=KGynfMBTdsUN1OLz9q6Kxsv3hI2XLzIULKgOk1lRKxJS02TfLhH83cM/NZbLvdPkX5NdzjE6X
 kERAoDvPtwlBRs/yfiYivnYmUmVIumfNe7hDC6ZZ22wpnR3aoDFusM0
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wa9w-FKY8zl-ePD7pX-lI2pmtA1qvHbQ
X-Proofpoint-ORIG-GUID: wa9w-FKY8zl-ePD7pX-lI2pmtA1qvHbQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240025

Add tracepoint for tracing the messages being sent and the success
thereof. This is useful as the system has a variety of clients sending
requests to the always-on subsystem.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v2:
- Corrected copy-paste error in include guard (now _TRACE_QCOM_AOSS_H)
- Link to v1: https://lore.kernel.org/r/20240117-qcom-aoss-tracepoints-v1-1-4f935920cf4b@quicinc.com
---
 drivers/soc/qcom/Makefile     |  1 +
 drivers/soc/qcom/qcom_aoss.c  |  7 +++++++
 drivers/soc/qcom/trace-aoss.h | 48 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 05b3d54e8dc9..9268e15e1719 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_rpmh-rsc.o := -I$(src)
+CFLAGS_qcom_aoss.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index aff0cfb71482..db94b2d17e7d 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -13,6 +13,9 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/qcom_aoss.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace-aoss.h"
+
 #define QMP_DESC_MAGIC			0x0
 #define QMP_DESC_VERSION		0x4
 #define QMP_DESC_FEATURES		0x8
@@ -235,6 +238,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
 
 	mutex_lock(&qmp->tx_lock);
 
+	trace_aoss_send(buf);
+
 	/* The message RAM only implements 32-bit accesses */
 	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
 			 buf, sizeof(buf) / sizeof(u32));
@@ -256,6 +261,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
 		ret = 0;
 	}
 
+	trace_aoss_send_done(buf, ret);
+
 	mutex_unlock(&qmp->tx_lock);
 
 	return ret;
diff --git a/drivers/soc/qcom/trace-aoss.h b/drivers/soc/qcom/trace-aoss.h
new file mode 100644
index 000000000000..554029b33b44
--- /dev/null
+++ b/drivers/soc/qcom/trace-aoss.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_aoss
+
+#if !defined(_TRACE_QCOM_AOSS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_AOSS_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(aoss_send,
+	TP_PROTO(const char *msg),
+	TP_ARGS(msg),
+	TP_STRUCT__entry(
+		__string(msg, msg)
+	),
+	TP_fast_assign(
+		__assign_str(msg, msg);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+TRACE_EVENT(aoss_send_done,
+	TP_PROTO(const char *msg, int ret),
+	TP_ARGS(msg, ret),
+	TP_STRUCT__entry(
+		__string(msg, msg)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__assign_str(msg, msg);
+		__entry->ret = ret;
+	),
+	TP_printk("%s: %d", __get_str(msg), __entry->ret)
+);
+
+#endif /* _TRACE_QCOM_AOSS_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-aoss
+
+#include <trace/define_trace.h>

---
base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
change-id: 20230927-qcom-aoss-tracepoints-c5832ca2eb29

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


