Return-Path: <linux-kernel+bounces-3473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB81816CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E4C28194D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690539840;
	Mon, 18 Dec 2023 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SnLij52D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76339AC4;
	Mon, 18 Dec 2023 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsh8Q018842;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Cw+LvLfKYSxI3dwsopUF85tuELonc2iteRwa9ian3SQ=; b=Sn
	Lij52D31QkAoNWeejGz5FJ+95Xfjk+VZTtH46Uo2DNB5fw8I6MJGvHciEnP2v6Cq
	3gl9ZU0B6zbTI+adzBRaNbOO62T3rnbEIkG/BOn+qxjUcSpNY4YkmHNDD0xUwKMU
	qSC0Kl3VA1W8HOP+gk2/4Xl6E5cYIiJxG9Eee78ETbROu00xIvtpA5r5VLHzYQmp
	ynyJc9RVxMNwg+GmNl4dotYsrgI4GGiEf7wDKddg6hWK7k3pqhz7Ylb5h70jhT8O
	GNm2c25z7+BLWnFXGm/GzeJ2KwMWgMWcG1MSi6DbR1HOO5b6g2fAoCh8zhlcOZZO
	scojmTIm8i08JhRoAYUg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mfe04nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX6PM029956;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ad-2;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX8rY030072;
	Mon, 18 Dec 2023 11:33:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX86P030060;
	Mon, 18 Dec 2023 11:33:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 6480E237A; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 28/34] media: iris: add instance sub states and implement DRC and Drain sequence
Date: Mon, 18 Dec 2023 17:02:23 +0530
Message-Id: <1702899149-21321-29-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sBoqHN7be_eJTBDeL1-DYLxK4PL4_mzC
X-Proofpoint-GUID: sBoqHN7be_eJTBDeL1-DYLxK4PL4_mzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Implement decoder commands for CMD_START and CMD_STOP.
HFI_CMD_DRAIN - set to firmware as part of stop command
to initiate drain.
HFI_CMD_RESUME - set to firmware as part of start command
to resume the buffer processing on specific plane.

Also, introduce different sub states for instances.
Sub state transitions are defined, based on which they would
be allowed/rejected/ignored.

- IRIS_INST_SUB_DRAIN - indicates drain is in progress.
- IRIS_INST_SUB_DRC - indicates source change is received from
  firmware and source change event is sent to client.
- IRIS_INST_SUB_DRAIN_LAST - indicates last buffer is received
  from firmware as part of drain sequence .
- IRIS_INST_SUB_DRC_LAST - indicates last buffer is received
  from firmware as part of source change.
- IRIS_INST_SUB_INPUT_PAUSE - source change is received form
  firmware. This indicates that firmware is paused to process
  any further input frames.
- IRIS_INST_SUB_OUTPUT_PAUSE - last buffer is received form
  firmware as part of drain or drc sequence . This indicates
  that firmware is paused to process any further output frames.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  19 ++
 .../media/platform/qcom/vcodec/iris/iris_buffer.c  |  56 +++++-
 .../media/platform/qcom/vcodec/iris/iris_buffer.h  |   3 +-
 .../media/platform/qcom/vcodec/iris/iris_common.h  |   1 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c | 118 ++++++++++++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   4 +-
 .../platform/qcom/vcodec/iris/iris_hfi_response.c  | 106 ++++++++++-
 .../platform/qcom/vcodec/iris/iris_instance.h      |   2 +
 .../media/platform/qcom/vcodec/iris/iris_state.c   | 211 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_state.h   |  24 +++
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 145 ++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   2 +
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |  79 +++++++-
 13 files changed, 760 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index 104ef9c..bbe8ca6 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -16,7 +16,10 @@
 #define HFI_CMD_CLOSE				0x01000004
 #define HFI_CMD_START				0x01000005
 #define HFI_CMD_STOP				0x01000006
+#define HFI_CMD_DRAIN				0x01000007
+#define HFI_CMD_RESUME				0x01000008
 #define HFI_CMD_BUFFER				0x01000009
+#define HFI_CMD_PAUSE				0x01000011
 
 #define HFI_PROP_IMAGE_VERSION			0x03000001
 
@@ -208,6 +211,20 @@ enum hfi_picture_type {
 
 #define HFI_SYSTEM_ERROR_END			0x05FFFFFF
 
+#define HFI_INFORMATION_BEGIN			0x06000000
+
+#define HFI_INFO_UNSUPPORTED			0x06000001
+
+#define HFI_INFO_DATA_CORRUPT			0x06000002
+
+#define HFI_INFO_BUFFER_OVERFLOW		0x06000004
+
+#define HFI_INFO_HFI_FLAG_DRAIN_LAST		0x06000006
+
+#define HFI_INFO_HFI_FLAG_PSC_LAST		0x06000007
+
+#define HFI_INFORMATION_END			0x06FFFFFF
+
 struct hfi_debug_header {
 	u32   size;
 	u32   debug_level;
@@ -242,6 +259,8 @@ enum hfi_buffer_firmware_flags {
 	HFI_BUF_FW_FLAG_NONE		= 0x00000000,
 	HFI_BUF_FW_FLAG_RELEASE_DONE	= 0x00000001,
 	HFI_BUF_FW_FLAG_READONLY	= 0x00000010,
+	HFI_BUF_FW_FLAG_LAST		= 0x10000000,
+	HFI_BUF_FW_FLAG_PSC_LAST	= 0x20000000,
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
index ab25026..f85b52c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
@@ -547,7 +547,7 @@ static int iris_release_internal_buffers(struct iris_inst *inst,
 	return ret;
 }
 
-int iris_release_input_internal_buffers(struct iris_inst *inst)
+static int iris_release_input_internal_buffers(struct iris_inst *inst)
 {
 	int ret = 0;
 	u32 i = 0;
@@ -581,3 +581,57 @@ int iris_alloc_and_queue_session_int_bufs(struct iris_inst *inst,
 
 	return ret;
 }
+
+int iris_alloc_and_queue_input_int_bufs(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = iris_get_internal_buffers(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_release_input_internal_buffers(inst);
+	if (ret)
+		return ret;
+
+	ret = iris_create_input_internal_buffers(inst);
+	if (ret)
+		return ret;
+
+	ret = iris_queue_input_internal_buffers(inst);
+
+	return ret;
+}
+
+int iris_alloc_and_queue_additional_dpb_buffers(struct iris_inst *inst)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *buffer;
+	int cur_min_count = 0;
+	int ret;
+	int i;
+
+	ret = iris_get_internal_buf_info(inst, BUF_DPB);
+	if (ret)
+		return ret;
+
+	buffers = iris_get_buffer_list(inst, BUF_DPB);
+	if (!buffers)
+		return -EINVAL;
+
+	list_for_each_entry(buffer, &buffers->list, list)
+		cur_min_count++;
+
+	if (cur_min_count >= buffers->min_count)
+		return 0;
+
+	for (i = cur_min_count; i < buffers->min_count; i++) {
+		ret = iris_create_internal_buffers(inst, BUF_DPB);
+		if (ret)
+			return ret;
+	}
+
+	ret = iris_queue_internal_buffers(inst, BUF_DPB);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
index 59c4a10..6ab5f22 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
@@ -57,8 +57,9 @@ int iris_destroy_internal_buffer(struct iris_inst *inst,
 				 struct iris_buffer *buffer);
 int iris_destroy_internal_buffers(struct iris_inst *inst,
 				  u32 plane);
-int iris_release_input_internal_buffers(struct iris_inst *inst);
 int iris_alloc_and_queue_session_int_bufs(struct iris_inst *inst,
 					  enum iris_buffer_type buffer_type);
+int iris_alloc_and_queue_input_int_bufs(struct iris_inst *inst);
+int iris_alloc_and_queue_additional_dpb_buffers(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index 5fd96d3..24b322a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -76,6 +76,7 @@ enum iris_buffer_flags {
 	BUF_FLAG_PFRAME		= 0x00000010,
 	BUF_FLAG_BFRAME		= 0x00000020,
 	BUF_FLAG_ERROR		= 0x00000040,
+	BUF_FLAG_LAST		= 0x00100000,
 };
 
 enum iris_buffer_attributes {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index e0da3be..2b3fa47 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -445,6 +445,124 @@ int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
 	return ret;
 }
 
+int iris_hfi_pause(struct iris_inst *inst, u32 plane)
+{
+	struct iris_core *core;
+	int ret = 0;
+
+	if (!inst->packet)
+		return -EINVAL;
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+
+	if (!validate_session(core, inst)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (plane != INPUT_MPLANE && plane != OUTPUT_MPLANE)
+		goto unlock;
+
+	ret = hfi_packet_session_command(inst,
+					 HFI_CMD_PAUSE,
+					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+					 HFI_HOST_FLAGS_INTR_REQUIRED),
+					 get_hfi_port(plane),
+					 inst->session_id,
+					 HFI_PAYLOAD_NONE,
+					 NULL,
+					 0);
+	if (ret)
+		goto unlock;
+
+	ret = iris_hfi_queue_cmd_write(inst->core, inst->packet);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+int iris_hfi_resume(struct iris_inst *inst, u32 plane, u32 payload)
+{
+	struct iris_core *core;
+	int ret = 0;
+
+	if (!inst->packet)
+		return -EINVAL;
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+
+	if (!validate_session(core, inst)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (plane != INPUT_MPLANE && plane != OUTPUT_MPLANE)
+		goto unlock;
+
+	ret = hfi_packet_session_command(inst,
+					 HFI_CMD_RESUME,
+					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+					 HFI_HOST_FLAGS_INTR_REQUIRED),
+					 get_hfi_port(plane),
+					 inst->session_id,
+					 HFI_PAYLOAD_U32,
+					 &payload,
+					 sizeof(u32));
+	if (ret)
+		goto unlock;
+
+	ret = iris_hfi_queue_cmd_write(inst->core, inst->packet);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+int iris_hfi_drain(struct iris_inst *inst, u32 plane)
+{
+	struct iris_core *core;
+	int ret = 0;
+
+	if (!inst->packet)
+		return -EINVAL;
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+
+	if (!validate_session(core, inst)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (plane != INPUT_MPLANE)
+		goto unlock;
+
+	ret = hfi_packet_session_command(inst,
+					 HFI_CMD_DRAIN,
+					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+					 HFI_HOST_FLAGS_INTR_REQUIRED |
+					 HFI_HOST_FLAGS_NON_DISCARDABLE),
+					 get_hfi_port(plane),
+					 inst->session_id,
+					 HFI_PAYLOAD_NONE,
+					 NULL,
+					 0);
+	if (ret)
+		goto unlock;
+
+	ret = iris_hfi_queue_cmd_write(inst->core, inst->packet);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
 irqreturn_t iris_hfi_isr(int irq, void *data)
 {
 	disable_irq_nosync(irq);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index f054c2d..ab479a9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -25,7 +25,9 @@ int iris_hfi_session_set_default_header(struct iris_inst *inst);
 
 int iris_hfi_start(struct iris_inst *inst, u32 plane);
 int iris_hfi_stop(struct iris_inst *inst, u32 plane);
-
+int iris_hfi_drain(struct iris_inst *inst, u32 plane);
+int iris_hfi_pause(struct iris_inst *inst, u32 plane);
+int iris_hfi_resume(struct iris_inst *inst, u32 plane, u32 cmd);
 int iris_hfi_queue_buffer(struct iris_inst *inst,
 			  struct iris_buffer *buffer);
 int iris_hfi_release_buffer(struct iris_inst *inst,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
index b1236dd..3548f9d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
@@ -103,6 +103,10 @@ static int get_driver_buffer_flags(struct iris_inst *inst, u32 hfi_flags)
 	if (inst->hfi_frame_info.overflow)
 		driver_flags |= BUF_FLAG_ERROR;
 
+	if (hfi_flags & HFI_BUF_FW_FLAG_LAST ||
+	    hfi_flags & HFI_BUF_FW_FLAG_PSC_LAST)
+		driver_flags |= BUF_FLAG_LAST;
+
 	return driver_flags;
 }
 
@@ -187,6 +191,46 @@ static int validate_hdr_packet(struct iris_core *core, struct hfi_header *hdr)
 	return ret;
 }
 
+static int handle_session_info(struct iris_inst *inst,
+			       struct hfi_packet *pkt)
+{
+	struct iris_core *core;
+	int ret = 0;
+	char *info;
+
+	core = inst->core;
+
+	switch (pkt->type) {
+	case HFI_INFO_UNSUPPORTED:
+		info = "unsupported";
+		break;
+	case HFI_INFO_DATA_CORRUPT:
+		info = "data corrupt";
+		inst->hfi_frame_info.data_corrupt = 1;
+		break;
+	case HFI_INFO_BUFFER_OVERFLOW:
+		info = "buffer overflow";
+		inst->hfi_frame_info.overflow = 1;
+		break;
+	case HFI_INFO_HFI_FLAG_DRAIN_LAST:
+		info = "drain last flag";
+		ret = iris_inst_sub_state_change_drain_last(inst);
+		break;
+	case HFI_INFO_HFI_FLAG_PSC_LAST:
+		info = "drc last flag";
+		ret = iris_inst_sub_state_change_drc_last(inst);
+		break;
+	default:
+		info = "unknown";
+		break;
+	}
+
+	dev_dbg(core->dev, "session info received %#x: %s\n",
+		pkt->type, info);
+
+	return ret;
+}
+
 static int handle_session_error(struct iris_inst *inst,
 				struct hfi_packet *pkt)
 {
@@ -375,9 +419,21 @@ static int handle_output_buffer(struct iris_inst *inst,
 	bool found;
 	int ret = 0;
 
+	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_LAST) {
+		ret = iris_inst_sub_state_change_drain_last(inst);
+		if (ret)
+			return ret;
+	}
+
 	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_RELEASE_DONE)
 		return handle_release_output_buffer(inst, hfi_buffer);
 
+	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_PSC_LAST) {
+		ret = iris_inst_sub_state_change_drc_last(inst);
+		if (ret)
+			return ret;
+	}
+
 	if (!(hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY))
 		ret = handle_non_read_only_buffer(inst, hfi_buffer);
 
@@ -488,6 +544,26 @@ static int handle_release_internal_buffer(struct iris_inst *inst,
 	return ret;
 }
 
+static int handle_session_stop(struct iris_inst *inst,
+			       struct hfi_packet *pkt)
+{
+	int ret = 0;
+	enum signal_session_response signal_type = -1;
+
+	if (pkt->port == HFI_PORT_RAW) {
+		signal_type = SIGNAL_CMD_STOP_OUTPUT;
+		ret = iris_inst_sub_state_change_pause(inst, OUTPUT_MPLANE);
+	} else if (pkt->port == HFI_PORT_BITSTREAM) {
+		signal_type = SIGNAL_CMD_STOP_INPUT;
+		ret = iris_inst_sub_state_change_pause(inst, INPUT_MPLANE);
+	}
+
+	if (signal_type != -1)
+		signal_session_msg_receipt(inst, signal_type);
+
+	return ret;
+}
+
 static int handle_session_buffer(struct iris_inst *inst,
 				 struct hfi_packet *pkt)
 {
@@ -549,18 +625,30 @@ static int handle_session_buffer(struct iris_inst *inst,
 	return ret;
 }
 
+static int handle_session_drain(struct iris_inst *inst,
+				struct hfi_packet *pkt)
+{
+	int ret = 0;
+
+	if (inst->sub_state & IRIS_INST_SUB_DRAIN)
+		ret = iris_inst_change_sub_state(inst, 0, IRIS_INST_SUB_INPUT_PAUSE);
+
+	return ret;
+}
+
 static int handle_src_change(struct iris_inst *inst,
 			     struct hfi_packet *pkt)
 {
-	int ret = 0;
+	int ret;
 
-	if (pkt->port == HFI_PORT_BITSTREAM)
-		ret = vdec_src_change(inst);
-	else if (pkt->port == HFI_PORT_RAW)
-		ret = 0;
+	if (pkt->port != HFI_PORT_BITSTREAM)
+		return 0;
 
+	ret = iris_inst_sub_state_change_drc(inst);
 	if (ret)
-		iris_inst_change_state(inst, IRIS_INST_ERROR);
+		return ret;
+
+	ret = vdec_src_change(inst);
 
 	return ret;
 }
@@ -572,9 +660,14 @@ static int handle_session_command(struct iris_inst *inst,
 	static const struct iris_hfi_packet_handle hfi_pkt_handle[] = {
 		{HFI_CMD_OPEN,              NULL                    },
 		{HFI_CMD_CLOSE,             handle_session_close    },
+		{HFI_CMD_START,             NULL                    },
+		{HFI_CMD_STOP,              handle_session_stop     },
+		{HFI_CMD_DRAIN,             handle_session_drain    },
 		{HFI_CMD_BUFFER,            handle_session_buffer   },
 		{HFI_CMD_SETTINGS_CHANGE,   handle_src_change       },
 		{HFI_CMD_SUBSCRIBE_MODE,    NULL                    },
+		{HFI_CMD_PAUSE,             NULL                    },
+		{HFI_CMD_RESUME,            NULL                    },
 	};
 
 	for (i = 0; i < ARRAY_SIZE(hfi_pkt_handle); i++) {
@@ -774,6 +867,7 @@ static int handle_session_response(struct iris_core *core,
 	int i, j;
 	static const struct iris_inst_hfi_range be[] = {
 		{HFI_SESSION_ERROR_BEGIN,  HFI_SESSION_ERROR_END,  handle_session_error    },
+		{HFI_INFORMATION_BEGIN,    HFI_INFORMATION_END,    handle_session_info     },
 		{HFI_PROP_BEGIN,           HFI_PROP_END,           handle_session_property },
 		{HFI_CMD_BEGIN,            HFI_CMD_END,            handle_session_command  },
 	};
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index cddf143..50154bf 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -39,6 +39,7 @@
  * @buffers: structure of buffer info
  * @fw_min_count: minimnum count of buffers needed by fw
  * @state: instance state
+ * @sub_state: instance sub state
  * @ipsc_properties_set: boolean to set ipsc properties to fw
  * @opsc_properties_set: boolean to set opsc properties to fw
  * @hfi_frame_info: structure of frame info
@@ -71,6 +72,7 @@ struct iris_inst {
 	struct iris_buffers_info	buffers;
 	u32				fw_min_count;
 	enum iris_inst_state		state;
+	enum iris_inst_sub_state	sub_state;
 	bool				ipsc_properties_set;
 	bool				opsc_properties_set;
 	struct iris_hfi_frame_info	hfi_frame_info;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
index 04e7dc8..952ba2a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -239,3 +239,214 @@ int iris_inst_state_change_streamoff(struct iris_inst *inst, u32 plane)
 
 	return iris_inst_change_state(inst, new_state);
 }
+
+struct iris_inst_sub_state_change_allow {
+	enum iris_inst_state state;
+	enum state_change allow;
+	u32 sub_state_mask;
+};
+
+static int iris_inst_allow_sub_state(struct iris_inst *inst, enum iris_inst_sub_state sub_state)
+{
+	int i;
+	static struct iris_inst_sub_state_change_allow sub_state_allow[] = {
+		{IRIS_INST_OPEN,              STATE_CHANGE_DISALLOW,    IRIS_INST_SUB_DRC         |
+									IRIS_INST_SUB_DRAIN       |
+									IRIS_INST_SUB_DRC_LAST    |
+									IRIS_INST_SUB_DRAIN_LAST  |
+									IRIS_INST_SUB_INPUT_PAUSE |
+									IRIS_INST_SUB_OUTPUT_PAUSE},
+
+		{IRIS_INST_INPUT_STREAMING,   STATE_CHANGE_DISALLOW,    IRIS_INST_SUB_DRC_LAST    |
+									IRIS_INST_SUB_DRAIN_LAST  |
+									IRIS_INST_SUB_OUTPUT_PAUSE},
+
+		{IRIS_INST_INPUT_STREAMING,   STATE_CHANGE_ALLOW,       IRIS_INST_SUB_DRC         |
+									IRIS_INST_SUB_DRAIN       |
+									IRIS_INST_SUB_INPUT_PAUSE },
+
+		{IRIS_INST_OUTPUT_STREAMING,  STATE_CHANGE_DISALLOW,    IRIS_INST_SUB_DRC         |
+									IRIS_INST_SUB_DRAIN       |
+									IRIS_INST_SUB_INPUT_PAUSE },
+
+		{IRIS_INST_OUTPUT_STREAMING,  STATE_CHANGE_ALLOW,       IRIS_INST_SUB_DRC_LAST    |
+									IRIS_INST_SUB_DRAIN_LAST  |
+									IRIS_INST_SUB_OUTPUT_PAUSE},
+
+		{IRIS_INST_STREAMING,         STATE_CHANGE_ALLOW,       IRIS_INST_SUB_DRC         |
+									IRIS_INST_SUB_DRAIN       |
+									IRIS_INST_SUB_DRC_LAST    |
+									IRIS_INST_SUB_DRAIN_LAST  |
+									IRIS_INST_SUB_INPUT_PAUSE |
+									IRIS_INST_SUB_OUTPUT_PAUSE},
+
+		{IRIS_INST_CLOSE,             STATE_CHANGE_ALLOW,       IRIS_INST_SUB_DRC         |
+									IRIS_INST_SUB_DRAIN       |
+									IRIS_INST_SUB_DRC_LAST    |
+									IRIS_INST_SUB_DRAIN_LAST  |
+									IRIS_INST_SUB_INPUT_PAUSE |
+									IRIS_INST_SUB_OUTPUT_PAUSE},
+
+		{IRIS_INST_ERROR,             STATE_CHANGE_ALLOW,       IRIS_INST_SUB_DRC         |
+									IRIS_INST_SUB_DRAIN       |
+									IRIS_INST_SUB_DRC_LAST    |
+									IRIS_INST_SUB_DRAIN_LAST  |
+									IRIS_INST_SUB_INPUT_PAUSE |
+									IRIS_INST_SUB_OUTPUT_PAUSE},
+	};
+
+	if (!sub_state)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(sub_state_allow); i++) {
+		if (sub_state_allow[i].state != inst->state)
+			continue;
+
+		if (sub_state_allow[i].allow == STATE_CHANGE_DISALLOW)
+			if (sub_state_allow[i].sub_state_mask & sub_state) {
+				dev_dbg(inst->core->dev, "state %d with disallowed sub state %x\n",
+					inst->state, sub_state);
+				return -EINVAL;
+			}
+
+		if (sub_state_allow[i].allow == STATE_CHANGE_ALLOW) {
+			if ((sub_state_allow[i].sub_state_mask & sub_state) != sub_state)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int iris_inst_change_sub_state(struct iris_inst *inst,
+			       enum iris_inst_sub_state clear_sub_state,
+			       enum iris_inst_sub_state set_sub_state)
+{
+	enum iris_inst_sub_state prev_sub_state;
+	int ret;
+
+	if (IS_SESSION_ERROR(inst))
+		return 0;
+
+	if (!clear_sub_state && !set_sub_state)
+		return 0;
+
+	if ((clear_sub_state & set_sub_state) ||
+	    set_sub_state > IRIS_INST_MAX_SUB_STATE_VALUE ||
+	    clear_sub_state > IRIS_INST_MAX_SUB_STATE_VALUE)
+		return -EINVAL;
+
+	prev_sub_state = inst->sub_state;
+
+	ret = iris_inst_allow_sub_state(inst, set_sub_state);
+	if (ret)
+		return ret;
+
+	inst->sub_state |= set_sub_state;
+	inst->sub_state &= ~clear_sub_state;
+
+	if (inst->sub_state != prev_sub_state)
+		dev_dbg(inst->core->dev, "state %d and sub state changed to %x\n",
+			inst->sub_state, inst->sub_state);
+
+	return 0;
+}
+
+int iris_inst_sub_state_change_drc(struct iris_inst *inst)
+{
+	enum iris_inst_sub_state set_sub_state = 0;
+
+	if (inst->sub_state & IRIS_INST_SUB_DRC)
+		return STATE_CHANGE_DISALLOW;
+
+	if (inst->state == IRIS_INST_INPUT_STREAMING ||
+	    inst->state == IRIS_INST_OPEN)
+		set_sub_state = IRIS_INST_SUB_INPUT_PAUSE;
+	else
+		set_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_INPUT_PAUSE;
+
+	return iris_inst_change_sub_state(inst, 0, set_sub_state);
+}
+
+int iris_inst_sub_state_change_drain_last(struct iris_inst *inst)
+{
+	enum iris_inst_sub_state set_sub_state = IRIS_INST_SUB_NONE;
+
+	if (inst->sub_state & IRIS_INST_SUB_DRAIN_LAST)
+		return STATE_CHANGE_DISALLOW;
+
+	if (!(inst->sub_state & IRIS_INST_SUB_DRAIN) ||
+	    !(inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE))
+		return STATE_CHANGE_DISALLOW;
+
+	set_sub_state = IRIS_INST_SUB_DRAIN_LAST | IRIS_INST_SUB_OUTPUT_PAUSE;
+
+	return iris_inst_change_sub_state(inst, 0, set_sub_state);
+}
+
+int iris_inst_sub_state_change_drc_last(struct iris_inst *inst)
+{
+	enum iris_inst_sub_state set_sub_state = IRIS_INST_SUB_NONE;
+
+	if (inst->sub_state & IRIS_INST_SUB_DRC_LAST)
+		return STATE_CHANGE_DISALLOW;
+
+	if (!(inst->sub_state & IRIS_INST_SUB_DRC) ||
+	    !(inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE))
+		return STATE_CHANGE_DISALLOW;
+
+	set_sub_state = IRIS_INST_SUB_DRC_LAST | IRIS_INST_SUB_OUTPUT_PAUSE;
+
+	return iris_inst_change_sub_state(inst, 0, set_sub_state);
+}
+
+int iris_inst_sub_state_change_pause(struct iris_inst *inst, u32 plane)
+{
+	enum iris_inst_sub_state set_sub_state = IRIS_INST_SUB_NONE;
+
+	if (plane == INPUT_MPLANE) {
+		if (inst->sub_state & IRIS_INST_SUB_DRC &&
+		    !(inst->sub_state & IRIS_INST_SUB_DRC_LAST))
+			return STATE_CHANGE_DISALLOW;
+
+		if (inst->sub_state & IRIS_INST_SUB_DRAIN &&
+		    !(inst->sub_state & IRIS_INST_SUB_DRAIN_LAST))
+			return STATE_CHANGE_DISALLOW;
+
+		set_sub_state = IRIS_INST_SUB_INPUT_PAUSE;
+	} else {
+		set_sub_state = IRIS_INST_SUB_OUTPUT_PAUSE;
+	}
+
+	return iris_inst_change_sub_state(inst, 0, set_sub_state);
+}
+
+bool is_drc_pending(struct iris_inst *inst)
+{
+	return inst->sub_state & IRIS_INST_SUB_DRC &&
+		inst->sub_state & IRIS_INST_SUB_DRC_LAST;
+}
+
+bool is_drain_pending(struct iris_inst *inst)
+{
+	return inst->sub_state & IRIS_INST_SUB_DRAIN &&
+		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
+}
+
+bool allow_cmd(struct iris_inst *inst, u32 cmd)
+{
+	if (cmd == V4L2_DEC_CMD_START) {
+		if (inst->state == IRIS_INST_INPUT_STREAMING ||
+		    inst->state == IRIS_INST_OUTPUT_STREAMING ||
+		    inst->state == IRIS_INST_STREAMING)
+			if (is_drc_pending(inst) || is_drain_pending(inst))
+				return true;
+	} else if (cmd == V4L2_DEC_CMD_STOP) {
+		if (inst->state == IRIS_INST_INPUT_STREAMING ||
+		    inst->state == IRIS_INST_STREAMING)
+			if (inst->sub_state != IRIS_INST_SUB_DRAIN)
+				return true;
+	}
+
+	return false;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
index 47558ed..76db8f5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
@@ -25,6 +25,19 @@ enum iris_inst_state {
 	IRIS_INST_ERROR,
 };
 
+#define IRIS_INST_SUB_NONE		0
+#define IRIS_INST_SUB_STATES		6
+#define IRIS_INST_MAX_SUB_STATE_VALUE	((1 << IRIS_INST_SUB_STATES) - 1)
+
+enum iris_inst_sub_state {
+	IRIS_INST_SUB_DRAIN		= BIT(0),
+	IRIS_INST_SUB_DRC		= BIT(1),
+	IRIS_INST_SUB_DRAIN_LAST	= BIT(2),
+	IRIS_INST_SUB_DRC_LAST		= BIT(3),
+	IRIS_INST_SUB_INPUT_PAUSE	= BIT(4),
+	IRIS_INST_SUB_OUTPUT_PAUSE	= BIT(5),
+};
+
 enum state_change {
 	STATE_CHANGE_ALLOW,
 	STATE_CHANGE_DISALLOW,
@@ -40,6 +53,9 @@ int iris_change_core_state(struct iris_core *core,
 
 int iris_inst_change_state(struct iris_inst *inst,
 			   enum iris_inst_state request_state);
+int iris_inst_change_sub_state(struct iris_inst *inst,
+			       enum iris_inst_sub_state clear_sub_state,
+			       enum iris_inst_sub_state set_sub_state);
 
 bool allow_s_fmt(struct iris_inst *inst, u32 type);
 bool allow_reqbufs(struct iris_inst *inst, u32 type);
@@ -51,4 +67,12 @@ bool allow_s_ctrl(struct iris_inst *inst, u32 cap_id);
 int iris_inst_state_change_streamon(struct iris_inst *inst, u32 plane);
 int iris_inst_state_change_streamoff(struct iris_inst *inst, u32 plane);
 
+int iris_inst_sub_state_change_drc(struct iris_inst *inst);
+int iris_inst_sub_state_change_drain_last(struct iris_inst *inst);
+int iris_inst_sub_state_change_drc_last(struct iris_inst *inst);
+int iris_inst_sub_state_change_pause(struct iris_inst *inst, u32 plane);
+bool is_drc_pending(struct iris_inst *inst);
+bool is_drain_pending(struct iris_inst *inst);
+bool allow_cmd(struct iris_inst *inst, u32 cmd);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 7eb74c3..7884ba6 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -1066,16 +1066,35 @@ static int vdec_subscribe_dst_change_param(struct iris_inst *inst)
 
 static int process_streamon_input(struct iris_inst *inst)
 {
+	enum iris_inst_sub_state set_sub_state = IRIS_INST_SUB_NONE;
 	int ret;
 
 	ret = iris_hfi_start(inst, INPUT_MPLANE);
 	if (ret)
 		return ret;
 
+	if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+		ret = iris_inst_change_sub_state(inst, IRIS_INST_SUB_INPUT_PAUSE, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (inst->sub_state & IRIS_INST_SUB_DRC ||
+	    inst->sub_state & IRIS_INST_SUB_DRAIN) {
+		if (!(inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE)) {
+			ret = iris_hfi_pause(inst, INPUT_MPLANE);
+			if (ret)
+				return ret;
+			set_sub_state = IRIS_INST_SUB_INPUT_PAUSE;
+		}
+	}
+
 	ret = iris_inst_state_change_streamon(inst, INPUT_MPLANE);
 	if (ret)
 		return ret;
 
+	ret = iris_inst_change_sub_state(inst, 0, set_sub_state);
+
 	return ret;
 }
 
@@ -1127,16 +1146,51 @@ int vdec_streamon_input(struct iris_inst *inst)
 
 static int process_streamon_output(struct iris_inst *inst)
 {
+	enum iris_inst_sub_state clear_sub_state = IRIS_INST_SUB_NONE;
+	bool drain_pending = false;
 	int ret;
 
+	if (inst->sub_state & IRIS_INST_SUB_DRC &&
+	    inst->sub_state & IRIS_INST_SUB_DRC_LAST)
+		clear_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_DRC_LAST;
+
+	if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+		ret = iris_alloc_and_queue_input_int_bufs(inst);
+		if (ret)
+			return ret;
+		ret = set_stage(inst, STAGE);
+		if (ret)
+			return ret;
+		ret = set_pipe(inst, PIPE);
+		if (ret)
+			return ret;
+	}
+
+	drain_pending = inst->sub_state & IRIS_INST_SUB_DRAIN &&
+		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
+
+	if (!drain_pending && inst->state == IRIS_INST_INPUT_STREAMING) {
+		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
+		}
+	}
+
 	ret = iris_hfi_start(inst, OUTPUT_MPLANE);
 	if (ret)
 		return ret;
 
+	if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE)
+		clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
+
 	ret = iris_inst_state_change_streamon(inst, OUTPUT_MPLANE);
 	if (ret)
 		return ret;
 
+	ret = iris_inst_change_sub_state(inst, clear_sub_state, 0);
+
 	return ret;
 }
 
@@ -1242,3 +1296,94 @@ int vdec_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2)
 
 	return ret;
 }
+
+static int process_resume(struct iris_inst *inst)
+{
+	enum iris_inst_sub_state clear_sub_state = IRIS_INST_SUB_NONE;
+	int ret;
+
+	if (inst->sub_state & IRIS_INST_SUB_DRC &&
+	    inst->sub_state & IRIS_INST_SUB_DRC_LAST) {
+		clear_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_DRC_LAST;
+
+		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
+		}
+		if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, OUTPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
+		}
+	} else if (inst->sub_state & IRIS_INST_SUB_DRAIN &&
+			   inst->sub_state & IRIS_INST_SUB_DRAIN_LAST) {
+		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
+		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_DRAIN);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
+		}
+		if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, OUTPUT_MPLANE, HFI_CMD_DRAIN);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
+		}
+	}
+
+	ret = iris_inst_change_sub_state(inst, clear_sub_state, 0);
+
+	return ret;
+}
+
+int vdec_start_cmd(struct iris_inst *inst)
+{
+	int ret;
+
+	vb2_clear_last_buffer_dequeued(inst->vb2q_dst);
+
+	if (inst->sub_state & IRIS_INST_SUB_DRC &&
+	    inst->sub_state & IRIS_INST_SUB_DRC_LAST &&
+	    inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+		ret = iris_alloc_and_queue_input_int_bufs(inst);
+		if (ret)
+			return ret;
+
+		ret = set_stage(inst, STAGE);
+		if (ret)
+			return ret;
+
+		ret = set_pipe(inst, PIPE);
+		if (ret)
+			return ret;
+	}
+
+	ret = iris_alloc_and_queue_additional_dpb_buffers(inst);
+	if (ret)
+		return ret;
+
+	ret = queue_deferred_buffers(inst, BUF_OUTPUT);
+	if (ret)
+		return ret;
+
+	ret = process_resume(inst);
+
+	return ret;
+}
+
+int vdec_stop_cmd(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = iris_hfi_drain(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_inst_change_sub_state(inst, 0, IRIS_INST_SUB_DRAIN);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
index d666c54..974b95e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
@@ -19,5 +19,7 @@ int vdec_src_change(struct iris_inst *inst);
 int vdec_streamon_input(struct iris_inst *inst);
 int vdec_streamon_output(struct iris_inst *inst);
 int vdec_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2);
+int vdec_start_cmd(struct iris_inst *inst);
+int vdec_stop_cmd(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 0165340..d37ef04 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -901,7 +901,82 @@ static int vidc_g_selection(struct file *filp, void *fh, struct v4l2_selection *
 	return ret;
 }
 
-static const struct v4l2_file_operations v4l2_file_ops = {
+static int vidc_try_dec_cmd(struct file *filp, void *fh,
+			    struct v4l2_decoder_cmd *dec)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !dec)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (dec->cmd != V4L2_DEC_CMD_STOP && dec->cmd != V4L2_DEC_CMD_START) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+	dec->flags = 0;
+	if (dec->cmd == V4L2_DEC_CMD_STOP) {
+		dec->stop.pts = 0;
+	} else if (dec->cmd == V4L2_DEC_CMD_START) {
+		dec->start.speed = 0;
+		dec->start.format = V4L2_DEC_START_FMT_NONE;
+	}
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_dec_cmd(struct file *filp, void *fh,
+			struct v4l2_decoder_cmd *dec)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !dec)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (dec->cmd != V4L2_DEC_CMD_START &&
+	    dec->cmd != V4L2_DEC_CMD_STOP) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (inst->state == IRIS_INST_OPEN)
+		goto unlock;
+
+	if (!allow_cmd(inst, dec->cmd)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (dec->cmd == V4L2_DEC_CMD_START)
+		ret = vdec_start_cmd(inst);
+	else if (dec->cmd == V4L2_DEC_CMD_STOP)
+		ret = vdec_stop_cmd(inst);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static struct v4l2_file_operations v4l2_file_ops = {
 	.owner                          = THIS_MODULE,
 	.open                           = vidc_open,
 	.release                        = vidc_close,
@@ -950,6 +1025,8 @@ static const struct v4l2_ioctl_ops v4l2_ioctl_ops = {
 	.vidioc_subscribe_event         = vidc_subscribe_event,
 	.vidioc_unsubscribe_event       = vidc_unsubscribe_event,
 	.vidioc_g_selection             = vidc_g_selection,
+	.vidioc_try_decoder_cmd         = vidc_try_dec_cmd,
+	.vidioc_decoder_cmd             = vidc_dec_cmd,
 };
 
 int init_ops(struct iris_core *core)
-- 
2.7.4


