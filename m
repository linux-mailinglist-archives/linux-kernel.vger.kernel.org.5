Return-Path: <linux-kernel+bounces-3452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E462B816C89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6A21C22C97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7251C2BB;
	Mon, 18 Dec 2023 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ncHS4f50"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540A1A738;
	Mon, 18 Dec 2023 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBXju6014283;
	Mon, 18 Dec 2023 11:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=UVtFoZQTiLhQyF2RBCz838+WNd8b3K5QQcCs6KV3zyg=; b=nc
	HS4f50Ya9mYZG3RtiqOeL1YvVol3QLvfJqoih/w0nDwmjuXpBGIkC9amng+5udxL
	ejl35DPgrP5Ty5hnrvURo4/bmpTIXFvN5oSCelhC0VXsRu3933w0D2dOJqqvp+iN
	ypXKhpv8epRY28aAnzHsTiwVvruhipFiv8mKmrnfo7Tx/bMQOWB9bTDqafXPN7If
	6ANizV3KM8onTnDxtwh+vV7Wml9F6tubCKWVHBw2WwdDCgpa4fn4mvVtE7/1O81f
	JD8DXf+kxTI0kW5+2ZK1HQy68ECxmM1f8i7hMuT7vMprkc9Dmf8YSa1J3rp9H4+b
	6Hdiw21pNenWsrDiskkA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v156dm7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:36:13 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBVmpN028250;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyv2-1;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBVmqt028240;
	Mon, 18 Dec 2023 11:36:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6kk029964;
	Mon, 18 Dec 2023 11:36:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 44B292306; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 15/34] media: iris: add handling for interrupt service routine(ISR) invoked by hardware
Date: Mon, 18 Dec 2023 17:02:10 +0530
Message-Id: <1702899149-21321-16-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4taH3vpbOrmM7Mi-RerpCbJpvu8R3cCg
X-Proofpoint-GUID: 4taH3vpbOrmM7Mi-RerpCbJpvu8R3cCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Allocate interrupt resources, enable the interrupt line and IRQ handling.
Register the IRQ handler to be called when interrupt occurs and
the function to be called from IRQ handler thread.
The threads invoke the driver's response handler which handles
all different responses from firmware.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   1 +
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  10 ++
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   4 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  29 +++-
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   3 +
 .../platform/qcom/vcodec/iris/iris_hfi_response.c  | 184 +++++++++++++++++++++
 .../platform/qcom/vcodec/iris/iris_hfi_response.h  |  20 +++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |  27 +++
 .../media/platform/qcom/vcodec/iris/vpu_common.h   |   2 +
 .../media/platform/qcom/vcodec/iris/vpu_iris3.c    |  44 +++++
 10 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 3c076d0..85fdf63 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -8,6 +8,7 @@ iris-objs += iris_probe.o \
              iris_state.o \
              iris_helpers.o \
              iris_hfi.o \
+             iris_hfi_response.o \
              iris_hfi_packet.o \
              resources.o \
              vpu_common.o \
diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index 423ba1a..9dd5f11 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -6,6 +6,8 @@
 #ifndef _HFI_DEFINES_H_
 #define _HFI_DEFINES_H_
 
+#include <linux/types.h>
+
 #define HFI_VIDEO_ARCH_LX			0x1
 
 #define HFI_CMD_INIT				0x01000001
@@ -50,4 +52,12 @@
 
 #define HFI_PROP_DEC_START_FROM_RAP_FRAME	0x03000169
 
+#define HFI_SYS_ERROR_WD_TIMEOUT		0x05000001
+
+struct hfi_debug_header {
+	u32   size;
+	u32   debug_level;
+	u32   reserved[2];
+};
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index b47520a..c125bce 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -45,6 +45,7 @@
  * @use_tz: a flag that suggests presence of trustzone
  * @packet: pointer to packet from driver to fw
  * @packet_size: size of packet
+ * @response_packet: a pointer to response packet from fw to driver
  * @sys_init_id: id of sys init packet
  * @header_id: id of packet header
  * @packet_id: id of packet
@@ -52,6 +53,7 @@
  * @platform_data: a structure for platform data
  * @cap: an array for supported core capabilities
  * @instances: a list_head of all instances
+ * @intr_status: interrupt status
  */
 
 struct iris_core {
@@ -82,6 +84,7 @@ struct iris_core {
 	unsigned int				use_tz;
 	u8					*packet;
 	u32					packet_size;
+	u8					*response_packet;
 	u32					sys_init_id;
 	u32					header_id;
 	u32					packet_id;
@@ -89,6 +92,7 @@ struct iris_core {
 	struct platform_data			*platform_data;
 	struct plat_core_cap			cap[CORE_CAP_MAX + 1];
 	struct list_head			instances;
+	u32					intr_status;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index d144ae5..4b8d8c7 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -5,10 +5,11 @@
 
 #include "../firmware.h"
 #include "../hfi_queue.h"
+#include "hfi_defines.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
-#include "hfi_defines.h"
+#include "iris_hfi_response.h"
 #include "vpu_common.h"
 
 static int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt)
@@ -253,3 +254,29 @@ int iris_hfi_session_close(struct iris_inst *inst)
 
 	return ret;
 }
+
+irqreturn_t iris_hfi_isr(int irq, void *data)
+{
+	disable_irq_nosync(irq);
+
+	return IRQ_WAKE_THREAD;
+}
+
+irqreturn_t iris_hfi_isr_handler(int irq, void *data)
+{
+	struct iris_core *core = data;
+
+	if (!core)
+		return IRQ_NONE;
+
+	mutex_lock(&core->lock);
+	call_vpu_op(core, clear_interrupt, core);
+	mutex_unlock(&core->lock);
+
+	__response_handler(core);
+
+	if (!call_vpu_op(core, watchdog, core, core->intr_status))
+		enable_irq(irq);
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index 8a057cc..8a62986 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -14,4 +14,7 @@ int iris_hfi_core_deinit(struct iris_core *core);
 int iris_hfi_session_open(struct iris_inst *inst);
 int iris_hfi_session_close(struct iris_inst *inst);
 
+irqreturn_t iris_hfi_isr(int irq, void *data);
+irqreturn_t iris_hfi_isr_handler(int irq, void *data);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
new file mode 100644
index 0000000..829f3f6
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "hfi_defines.h"
+#include "iris_hfi_packet.h"
+#include "iris_hfi_response.h"
+
+static void print_sfr_message(struct iris_core *core)
+{
+	struct sfr_buffer *vsfr = NULL;
+	u32 vsfr_size = 0;
+	void *p = NULL;
+
+	vsfr = (struct sfr_buffer *)core->sfr.kernel_vaddr;
+	if (vsfr) {
+		if (vsfr->bufsize != core->sfr.size)
+			return;
+		vsfr_size = vsfr->bufsize - sizeof(u32);
+		p = memchr(vsfr->rg_data, '\0', vsfr_size);
+	/* SFR isn't guaranteed to be NULL terminated */
+		if (!p)
+			vsfr->rg_data[vsfr_size - 1] = '\0';
+	}
+}
+
+static int validate_packet(u8 *response_pkt, u8 *core_resp_pkt,
+			   u32 core_resp_pkt_size)
+{
+	u32 response_pkt_size = 0;
+	u8 *response_limit;
+
+	if (!response_pkt || !core_resp_pkt || !core_resp_pkt_size)
+		return -EINVAL;
+
+	response_limit = core_resp_pkt + core_resp_pkt_size;
+
+	if (response_pkt < core_resp_pkt || response_pkt > response_limit)
+		return -EINVAL;
+
+	response_pkt_size = *(u32 *)response_pkt;
+	if (!response_pkt_size)
+		return -EINVAL;
+
+	if (response_pkt_size < sizeof(struct hfi_packet))
+		return -EINVAL;
+
+	if (response_pkt + response_pkt_size > response_limit)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int validate_hdr_packet(struct iris_core *core,
+			       struct hfi_header *hdr)
+{
+	struct hfi_packet *packet;
+	int i, ret = 0;
+	u8 *pkt;
+
+	if (hdr->size < sizeof(*hdr) + sizeof(*packet))
+		return -EINVAL;
+
+	pkt = (u8 *)((u8 *)hdr + sizeof(*hdr));
+
+	for (i = 0; i < hdr->num_packets; i++) {
+		packet = (struct hfi_packet *)pkt;
+		ret = validate_packet(pkt, core->response_packet, core->packet_size);
+		if (ret)
+			return ret;
+
+		pkt += packet->size;
+	}
+
+	return ret;
+}
+
+static int handle_system_error(struct iris_core *core,
+			       struct hfi_packet *pkt)
+{
+	print_sfr_message(core);
+
+	iris_core_deinit(core);
+
+	return 0;
+}
+
+static int handle_response(struct iris_core *core, void *response)
+{
+	struct hfi_header *hdr;
+	int ret;
+
+	hdr = (struct hfi_header *)response;
+	ret = validate_hdr_packet(core, hdr);
+	if (ret)
+		return handle_system_error(core, NULL);
+
+	return ret;
+}
+
+static int iris_hfi_queue_read(struct iris_core *core, void *pkt,
+			       struct iface_q_info *q_info)
+{
+	u32 tx_req;
+
+	if (!core_in_valid_state(core))
+		return -EINVAL;
+
+	if (!q_info || !q_info->q_array.kernel_vaddr || !pkt) {
+		dev_err(core->dev, "cannot read from shared Q's\n");
+		return -ENODATA;
+	}
+
+	if (read_queue(q_info, pkt, &tx_req))
+		return -ENODATA;
+
+	return 0;
+}
+
+int __response_handler(struct iris_core *core)
+{
+	int ret = 0;
+
+	if (call_vpu_op(core, watchdog, core, core->intr_status)) {
+		struct hfi_packet pkt = {.type = HFI_SYS_ERROR_WD_TIMEOUT};
+
+		mutex_lock(&core->lock);
+		iris_change_core_state(core, IRIS_CORE_ERROR);
+		dev_err(core->dev, "%s: CPU WD error received\n", __func__);
+		mutex_unlock(&core->lock);
+
+		return handle_system_error(core, &pkt);
+	}
+
+	memset(core->response_packet, 0, core->packet_size);
+	while (!iris_hfi_queue_read(core, core->response_packet, &core->message_queue)) {
+		ret = handle_response(core, core->response_packet);
+		if (ret)
+			continue;
+		if (core->state != IRIS_CORE_INIT)
+			break;
+		memset(core->response_packet, 0, core->packet_size);
+	}
+
+	iris_flush_debug_queue(core, core->response_packet, core->packet_size);
+
+	return ret;
+}
+
+void iris_flush_debug_queue(struct iris_core *core,
+			    u8 *packet, u32 packet_size)
+{
+	struct hfi_debug_header *pkt;
+	bool local_packet = false;
+	u8 *log;
+
+	if (!packet || !packet_size) {
+		packet = kzalloc(IFACEQ_CORE_PKT_SIZE, GFP_KERNEL);
+		if (!packet)
+			return;
+
+		packet_size = IFACEQ_CORE_PKT_SIZE;
+
+		local_packet = true;
+	}
+
+	while (!iris_hfi_queue_read(core, packet, &core->debug_queue)) {
+		pkt = (struct hfi_debug_header *)packet;
+
+		if (pkt->size < sizeof(*pkt))
+			continue;
+
+		if (pkt->size >= packet_size)
+			continue;
+
+		packet[pkt->size] = '\0';
+		log = (u8 *)packet + sizeof(*pkt) + 1;
+		dev_dbg(core->dev, "%s", log);
+	}
+
+	if (local_packet)
+		kfree(packet);
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.h
new file mode 100644
index 0000000..c1d2d27
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_HFI_RESPONSE_H_
+#define _IRIS_HFI_RESPONSE_H_
+
+#include "iris_core.h"
+
+struct sfr_buffer {
+	u32 bufsize;
+	u8 rg_data[];
+};
+
+int __response_handler(struct iris_core *core);
+void iris_flush_debug_queue(struct iris_core *core,
+			    u8 *packet, u32 packet_size);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 4f20da8..8c591da 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -10,9 +10,25 @@
 #include "../hfi_queue.h"
 #include "iris_core.h"
 #include "iris_helpers.h"
+#include "iris_hfi.h"
 #include "resources.h"
 #include "iris_vidc.h"
 
+static int init_iris_isr(struct iris_core *core)
+{
+	int ret;
+
+	ret = devm_request_threaded_irq(core->dev, core->irq, iris_hfi_isr,
+					iris_hfi_isr_handler, IRQF_TRIGGER_HIGH, "iris", core);
+	if (ret) {
+		dev_err(core->dev, "%s: Failed to allocate iris IRQ\n", __func__);
+		return ret;
+	}
+	disable_irq_nosync(core->irq);
+
+	return ret;
+}
+
 static int iris_register_video_device(struct iris_core *core)
 {
 	struct video_device *vdev;
@@ -86,6 +102,10 @@ static int iris_probe(struct platform_device *pdev)
 	if (!core->packet)
 		return -ENOMEM;
 
+	core->response_packet = devm_kzalloc(core->dev, core->packet_size, GFP_KERNEL);
+	if (!core->response_packet)
+		return -ENOMEM;
+
 	INIT_LIST_HEAD(&core->instances);
 
 	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
@@ -96,6 +116,13 @@ static int iris_probe(struct platform_device *pdev)
 	if (core->irq < 0)
 		return core->irq;
 
+	ret = init_iris_isr(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: Failed to init isr with %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = init_platform(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_common.h b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
index 790496a..6512039 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
@@ -22,6 +22,8 @@ struct compat_handle {
 struct vpu_ops {
 	int (*boot_firmware)(struct iris_core *core);
 	int (*raise_interrupt)(struct iris_core *core);
+	int (*clear_interrupt)(struct iris_core *core);
+	int (*watchdog)(struct iris_core *core, u32 intr_status);
 };
 
 int init_vpu(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
index 95bf223..a34d0ed 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
@@ -17,6 +17,8 @@
 #define CPU_CS_VCICMDARG0_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x24)
 #define CPU_CS_VCICMDARG1_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x28)
 
+#define CPU_CS_A2HSOFTINTCLR_IRIS3  (CPU_CS_BASE_OFFS_IRIS3 + 0x1C)
+
 /* HFI_CTRL_INIT */
 #define CPU_CS_SCIACMD_IRIS3        (CPU_CS_BASE_OFFS_IRIS3 + 0x48)
 
@@ -57,10 +59,19 @@
 #define CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3	0xfe
 #define CTRL_ERROR_STATUS__M_IRIS3 \
 		CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3
+#define CTRL_INIT_IDLE_MSG_BMSK_IRIS3 \
+		CPU_CS_SCIACMDARG0_HFI_CTRL_INIT_IDLE_MSG_BMSK_IRIS3
+
+#define WRAPPER_BASE_OFFS_IRIS3		         0x000B0000
+#define WRAPPER_INTR_STATUS_IRIS3	         (WRAPPER_BASE_OFFS_IRIS3 + 0x0C)
+#define WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3  0x8
+#define WRAPPER_INTR_STATUS_A2H_BMSK_IRIS3	  0x4
 
 #define CPU_IC_SOFTINT_IRIS3        (CPU_IC_BASE_OFFS_IRIS3 + 0x150)
 #define CPU_IC_SOFTINT_H2A_SHFT_IRIS3	0x0
 
+#define WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3  0x8
+
 static int setup_ucregion_memory_map_iris3(struct iris_core *core)
 {
 	int ret;
@@ -153,9 +164,42 @@ static int raise_interrupt_iris3(struct iris_core *core)
 	return write_register(core, CPU_IC_SOFTINT_IRIS3, 1 << CPU_IC_SOFTINT_H2A_SHFT_IRIS3);
 }
 
+static int clear_interrupt_iris3(struct iris_core *core)
+{
+	u32 intr_status = 0, mask = 0;
+	int ret;
+
+	ret = read_register(core, WRAPPER_INTR_STATUS_IRIS3, &intr_status);
+	if (ret)
+		return ret;
+
+	mask = (WRAPPER_INTR_STATUS_A2H_BMSK_IRIS3 |
+		WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3 |
+		CTRL_INIT_IDLE_MSG_BMSK_IRIS3);
+
+	if (intr_status & mask)
+		core->intr_status |= intr_status;
+
+	ret = write_register(core, CPU_CS_A2HSOFTINTCLR_IRIS3, 1);
+
+	return ret;
+}
+
+static int watchdog_iris3(struct iris_core *core, u32 intr_status)
+{
+	if (intr_status & WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3) {
+		dev_err(core->dev, "%s: received watchdog interrupt\n", __func__);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 static const struct vpu_ops iris3_ops = {
 	.boot_firmware = boot_firmware_iris3,
 	.raise_interrupt = raise_interrupt_iris3,
+	.clear_interrupt = clear_interrupt_iris3,
+	.watchdog = watchdog_iris3,
 };
 
 int init_iris3(struct iris_core *core)
-- 
2.7.4


