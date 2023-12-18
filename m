Return-Path: <linux-kernel+bounces-3442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E491816C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188751F238FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840A200B8;
	Mon, 18 Dec 2023 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mXzdEBwv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10261A599;
	Mon, 18 Dec 2023 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsiFI000419;
	Mon, 18 Dec 2023 11:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=a51Llo11f74sG1XbLU6Wq7g1dB96aeHoBOscTkyce+s=; b=mX
	zdEBwv7zCiWnTucfta3ulBRMfiey4awPgdm58olUTIrCEaCSgCs5JJVx1aUTEbek
	KpVzrP/1dVk2+KmsxfLBj7S5zWqYV6Eq4heTIiTPRniCapfQcxRy/SCDmhyQ3nVC
	+lMygGcf8kT7SYC51Tu01d92a96LpFhDrunTNVVFE97jI1Qq/UrlJg9/PsMHbDFX
	tCTgAe+CJycj3k8a9cHeGfbLpgr+c9l8n27zwuoFt9vhutO/Lkpulvkzv5oiTM64
	mR7h3fusT0VrB5C3da8atdsQ5rR9ZGpAoFsrFLDcE7wEaZlC048DdqyCJbJxHlR6
	Um6fzo8Zek3YqOo931kQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xy4443-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7FF030042;
	Mon, 18 Dec 2023 11:33:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyhp-1;
	Mon, 18 Dec 2023 11:33:08 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7Xb029998;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6Fk029971;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 32FCE22D6; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 08/34] media: iris: introduce state machine for iris core
Date: Mon, 18 Dec 2023 17:02:03 +0530
Message-Id: <1702899149-21321-9-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -XW7r2OCz6pdpvq95lnIEhvNw-SIYYhw
X-Proofpoint-ORIG-GUID: -XW7r2OCz6pdpvq95lnIEhvNw-SIYYhw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduces different states for core. State transitions
are defined, based on which they would be allowed/rejected/ignored.

IRIS_CORE_DEINIT - default state.
IRIS_CORE_INIT_WAIT -  wait state for video core to complete
initialization.
IRIS_CORE_INIT - core state with core initialized. FW loaded and
HW brought out of reset, shared queues established between host
driver and firmware.
IRIS_CORE_ERROR - error state.

            |
            v
       -----------
  +--->| DEINIT  |<---+
  |    -----------    |
  |         |         |
  |         v         |
  |    -----------    |
  |    |INIT_WAIT|    |
  |    -----------    |
  |      /     \      |
  |     /       \     |
  |    /         \    |
  |   v           v   v
 -----------   ----------.
 |  INIT   |-->|  ERROR |
 -----------   ----------.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |  3 +-
 .../media/platform/qcom/vcodec/iris/iris_core.h    |  4 ++
 .../media/platform/qcom/vcodec/iris/iris_state.c   | 64 ++++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_state.h   | 22 ++++++++
 4 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 0748819..12a74de 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -1,4 +1,5 @@
 iris-objs += iris_probe.o \
-             resources.o
+             resources.o \
+             iris_state.o
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index c2bc95d..56a5b7d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <media/v4l2-device.h>
 
+#include "iris_state.h"
+
 /**
  * struct iris_core - holds core parameters valid for all instances
  *
@@ -27,6 +29,7 @@
  * @clk_count: count of iris clocks
  * @reset_tbl: table of iris reset clocks
  * @reset_count: count of iris reset clocks
+ * @state: current state of core
  */
 
 struct iris_core {
@@ -45,6 +48,7 @@ struct iris_core {
 	u32					clk_count;
 	struct reset_info			*reset_tbl;
 	u32					reset_count;
+	enum iris_core_state			state;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
new file mode 100644
index 0000000..22557af
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_core.h"
+#include "iris_state.h"
+
+#define IRIS_STATE(name)[IRIS_CORE_##name] = "CORE_"#name
+
+static const char * const core_state_names[] = {
+	IRIS_STATE(DEINIT),
+	IRIS_STATE(INIT_WAIT),
+	IRIS_STATE(INIT),
+	IRIS_STATE(ERROR),
+};
+
+#undef IRIS_STATE
+
+bool core_in_valid_state(struct iris_core *core)
+{
+	return core->state == IRIS_CORE_INIT ||
+		core->state == IRIS_CORE_INIT_WAIT;
+}
+
+static const char *core_state_name(enum iris_core_state state)
+{
+	if ((unsigned int)state < ARRAY_SIZE(core_state_names))
+		return core_state_names[state];
+
+	return "UNKNOWN_STATE";
+}
+
+static bool iris_allow_core_state_change(struct iris_core *core,
+					 enum iris_core_state req_state)
+{
+	if (core->state == IRIS_CORE_DEINIT)
+		return req_state == IRIS_CORE_INIT_WAIT || req_state == IRIS_CORE_ERROR;
+	else if (core->state == IRIS_CORE_INIT_WAIT)
+		return req_state == IRIS_CORE_INIT || req_state == IRIS_CORE_ERROR;
+	else if (core->state == IRIS_CORE_INIT)
+		return req_state == IRIS_CORE_DEINIT || req_state == IRIS_CORE_ERROR;
+	else if (core->state == IRIS_CORE_ERROR)
+		return req_state == IRIS_CORE_DEINIT;
+
+	dev_warn(core->dev, "core state change %s -> %s is not allowed\n",
+		 core_state_name(core->state), core_state_name(req_state));
+
+	return false;
+}
+
+int iris_change_core_state(struct iris_core *core,
+			   enum iris_core_state request_state)
+{
+	if (core->state == request_state)
+		return 0;
+
+	if (!iris_allow_core_state_change(core, request_state))
+		return -EINVAL;
+
+	core->state = request_state;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
new file mode 100644
index 0000000..ee20842
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_STATE_H_
+#define _IRIS_STATE_H_
+
+struct iris_core;
+
+enum iris_core_state {
+	IRIS_CORE_DEINIT,
+	IRIS_CORE_INIT_WAIT,
+	IRIS_CORE_INIT,
+	IRIS_CORE_ERROR,
+};
+
+bool core_in_valid_state(struct iris_core *core);
+int iris_change_core_state(struct iris_core *core,
+			   enum iris_core_state request_state);
+
+#endif
-- 
2.7.4


