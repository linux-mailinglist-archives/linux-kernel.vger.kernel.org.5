Return-Path: <linux-kernel+bounces-3444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C9816C57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B37B2287E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4731720B0E;
	Mon, 18 Dec 2023 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S/8grHhs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17A1B28F;
	Mon, 18 Dec 2023 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAs71B019168;
	Mon, 18 Dec 2023 11:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Els7lv4fHIpc+8oVgCKZtE/UP4RNB6Llyf5lFWQyGsk=; b=S/
	8grHhsJ0q+lTgvD7Wiwaqh99x4BJAMI4wtiMZOrC09xkgyILMwoSm9rbUOrusUFC
	BuvWZBPdT+HssACd3OyLyPFreYY87rQSGgdONvmZ+rTddgBBaJeKFoINgcjw4z7Z
	NEkA5Phr9/S7HSYWZgfx7dj5hhN6iOFDf+l/bWGqnrlDlzStpZHf4vOV3LkJns51
	Yc62cea+pzXOcf39z9j0/0d3S0ZtCy2RyjoV0gIEdsqAo6/nAPyV3AEBGvJuuV4q
	eCNzr5hW5dBqJLGvtF+cYgTYYBK3awWwtqixKrkR73PmZIR41/xzBh1tN/a9KHBx
	Bhmb1cKyGwo9hJWiRcxw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2gw0rkcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7qJ030018;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyh4-1;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX54Y029912;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6sG029966;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 3570422D7; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 09/34] media: iris: initialize shared queues for host and firmware communication
Date: Mon, 18 Dec 2023 17:02:04 +0530
Message-Id: <1702899149-21321-10-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NIs9DIMFJPcCORCSVmkJfpjG89p7Rr79
X-Proofpoint-ORIG-GUID: NIs9DIMFJPcCORCSVmkJfpjG89p7Rr79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Shared queues are used for communication between driver and firmware.
There are 3 types of queues:
Command queue - driver to write any command to firmware.
Message queue - firmware to send any response to driver.
Debug queue - firmware to write debug message.

Above queues are initialized and configured to firmware during probe.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |  2 ++
 .../media/platform/qcom/vcodec/iris/iris_core.h    | 11 ++++++++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   | 31 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 12a74de..59798e5d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -1,3 +1,5 @@
+iris-objs += ../hfi_queue.o
+
 iris-objs += iris_probe.o \
              resources.o \
              iris_state.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 56a5b7d..77124f9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <media/v4l2-device.h>
 
+#include "../hfi_queue.h"
 #include "iris_state.h"
 
 /**
@@ -30,6 +31,11 @@
  * @reset_tbl: table of iris reset clocks
  * @reset_count: count of iris reset clocks
  * @state: current state of core
+ * @iface_q_table: Interface queue table memory
+ * @command_queue: shared interface queue to send commands to firmware
+ * @message_queue: shared interface queue to receive responses from firmware
+ * @debug_queue: shared interface queue to receive debug info from firmware
+ * @sfr: SFR register memory
  */
 
 struct iris_core {
@@ -49,6 +55,11 @@ struct iris_core {
 	struct reset_info			*reset_tbl;
 	u32					reset_count;
 	enum iris_core_state			state;
+	struct mem_desc				iface_q_table;
+	struct iface_q_info			command_queue;
+	struct iface_q_info			message_queue;
+	struct iface_q_info			debug_queue;
+	struct mem_desc				sfr;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 7bb9c92..fd349a3 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -7,6 +7,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+#include "../hfi_queue.h"
 #include "iris_core.h"
 #include "resources.h"
 
@@ -50,6 +51,10 @@ static void iris_remove(struct platform_device *pdev)
 	if (!core)
 		return;
 
+	hfi_queue_deinit(core->dev, &core->iface_q_table, &core->sfr,
+			 &core->command_queue, &core->message_queue,
+			 &core->debug_queue);
+
 	video_unregister_device(core->vdev_dec);
 
 	v4l2_device_unregister(&core->v4l2_dev);
@@ -59,6 +64,7 @@ static int iris_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iris_core *core;
+	u64 dma_mask;
 	int ret;
 
 	core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
@@ -91,8 +97,33 @@ static int iris_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, core);
 
+	/*
+	 * Specify the max value of address space, which can be used
+	 * for buffer transactions.
+	 */
+	dma_mask = DMA_BIT_MASK(32);
+	dma_mask &= ~BIT(29);
+
+	ret = dma_set_mask_and_coherent(dev, dma_mask);
+	if (ret)
+		goto err_vdev_unreg;
+
+	dma_set_max_seg_size(&pdev->dev, (unsigned int)DMA_BIT_MASK(32));
+	dma_set_seg_boundary(&pdev->dev, (unsigned long)DMA_BIT_MASK(64));
+
+	ret = hfi_queue_init(core->dev, &core->iface_q_table, &core->sfr,
+			     &core->command_queue, &core->message_queue,
+			     &core->debug_queue, core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: interface queues init failed\n", __func__);
+		goto err_vdev_unreg;
+	}
+
 	return ret;
 
+err_vdev_unreg:
+	iris_unregister_video_device(core);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
 
-- 
2.7.4


