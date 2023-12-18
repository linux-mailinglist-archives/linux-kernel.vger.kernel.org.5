Return-Path: <linux-kernel+bounces-3454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A8816C94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0821281A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42F200DD;
	Mon, 18 Dec 2023 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h6wv04H/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30881A731;
	Mon, 18 Dec 2023 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBSDl9013281;
	Mon, 18 Dec 2023 11:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=AT6XCjkhjq3ISyvWWHdZVQ0FD6UCnq0F78em27ik0vU=; b=h6
	wv04H/d/RwSFopH0Hr8u+mHOkwflTKOwvpRS1D0cgM1qU8FswZKKCVMtRMiVho4i
	uJORx3/yMGj5pMoV/YNFqH2exuXZlybDr/lX1k4hqBvYwcaJv+XkOVmrf9ZjmsS9
	NtT/SbHA+qByfQUGpLi4LOjRRYVKVFple16UkrN2j1csQ+q8Lv/Oy7uTEBGdHST2
	t4CMrOkDDBGYfljOyF5UvFP9wwSR6Vn2UK2BuwSDVaKuSYLTNkFyvOeHdl9Wkw+6
	UKNE/oAdHXxz6Pf6Wgmtq25agmnUbqHniatLYdDJIroNKwl1McV3fXDHavL8MHmt
	JdUgpURVrKmUPuEzodQg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0gbh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:36:13 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5MF029943;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyju-1;
	Mon, 18 Dec 2023 11:33:10 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX72t029995;
	Mon, 18 Dec 2023 11:33:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6B3029969;
	Mon, 18 Dec 2023 11:33:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 4EB74230B; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 19/34] media: iris: implement HFI to queue and release buffers
Date: Mon, 18 Dec 2023 17:02:14 +0530
Message-Id: <1702899149-21321-20-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DU0PAr79gSsWFZMPeAeSOdjevmmzDE0j
X-Proofpoint-GUID: DU0PAr79gSsWFZMPeAeSOdjevmmzDE0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce and implement HFIs to queue and release
all input, output and internal buffers to/from firmware.

HFI_CMD_BUFFER - to submit the buffer to firmware.
HFI_CMD_BUFFER with HFI_BUF_HOST_FLAG_RELEASE - to request
firmware to release the buffer.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  | 25 +++++++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c | 85 ++++++++++++++++++++++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |  4 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    | 78 ++++++++++++++++++++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    | 15 ++++
 5 files changed, 207 insertions(+)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index 9dd5f11..c044f78 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -13,6 +13,7 @@
 #define HFI_CMD_INIT				0x01000001
 #define HFI_CMD_OPEN				0x01000003
 #define HFI_CMD_CLOSE				0x01000004
+#define HFI_CMD_BUFFER				0x01000009
 
 #define HFI_PROP_IMAGE_VERSION			0x03000001
 
@@ -60,4 +61,28 @@ struct hfi_debug_header {
 	u32   reserved[2];
 };
 
+enum hfi_buffer_type {
+	HFI_BUFFER_BITSTREAM		= 0x00000001,
+	HFI_BUFFER_RAW			= 0x00000002,
+	HFI_BUFFER_METADATA		= 0x00000003,
+	HFI_BUFFER_SUBCACHE		= 0x00000004,
+	HFI_BUFFER_PARTIAL_DATA		= 0x00000005,
+	HFI_BUFFER_DPB			= 0x00000006,
+	HFI_BUFFER_BIN			= 0x00000007,
+	HFI_BUFFER_LINE			= 0x00000008,
+	HFI_BUFFER_ARP			= 0x00000009,
+	HFI_BUFFER_COMV			= 0x0000000A,
+	HFI_BUFFER_NON_COMV		= 0x0000000B,
+	HFI_BUFFER_PERSIST		= 0x0000000C,
+	HFI_BUFFER_VPSS			= 0x0000000D,
+};
+
+enum hfi_buffer_host_flags {
+	HFI_BUF_HOST_FLAG_NONE			= 0x00000000,
+	HFI_BUF_HOST_FLAG_RELEASE		= 0x00000001,
+	HFI_BUF_HOST_FLAG_READONLY		= 0x00000010,
+	HFI_BUF_HOST_FLAG_CODEC_CONFIG		= 0x00000100,
+	HFI_BUF_HOST_FLAGS_CB_NON_SECURE	= 0x00000200,
+};
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 24ddb98..8f1e456 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -309,3 +309,88 @@ int iris_hfi_set_property(struct iris_inst *inst,
 
 	return ret;
 }
+
+int iris_hfi_queue_buffer(struct iris_inst *inst,
+			  struct iris_buffer *buffer)
+{
+	struct hfi_buffer hfi_buffer;
+	struct iris_core *core;
+	int ret;
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
+	ret = get_hfi_buffer(buffer, &hfi_buffer);
+	if (ret)
+		goto unlock;
+
+	ret = hfi_packet_session_command(inst,
+					 HFI_CMD_BUFFER,
+					 HFI_HOST_FLAGS_INTR_REQUIRED,
+					 get_hfi_port_from_buffer_type(buffer->type),
+					 inst->session_id,
+					 HFI_PAYLOAD_STRUCTURE,
+					 &hfi_buffer,
+					 sizeof(hfi_buffer));
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
+int iris_hfi_release_buffer(struct iris_inst *inst,
+			    struct iris_buffer *buffer)
+{
+	struct hfi_buffer hfi_buffer;
+	struct iris_core *core;
+	int ret;
+
+	if (!inst->packet || !buffer)
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
+	ret = get_hfi_buffer(buffer, &hfi_buffer);
+	if (ret)
+		goto unlock;
+
+	hfi_buffer.flags |= HFI_BUF_HOST_FLAG_RELEASE;
+
+	ret = hfi_packet_session_command(inst,
+					 HFI_CMD_BUFFER,
+					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+					 HFI_HOST_FLAGS_INTR_REQUIRED),
+					 get_hfi_port_from_buffer_type(buffer->type),
+					 inst->session_id,
+					 HFI_PAYLOAD_STRUCTURE,
+					 &hfi_buffer,
+					 sizeof(hfi_buffer));
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
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index bf991bb..4aefdc4 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -19,5 +19,9 @@ int iris_hfi_set_property(struct iris_inst *inst,
 
 irqreturn_t iris_hfi_isr(int irq, void *data);
 irqreturn_t iris_hfi_isr_handler(int irq, void *data);
+int iris_hfi_queue_buffer(struct iris_inst *inst,
+			  struct iris_buffer *buffer);
+int iris_hfi_release_buffer(struct iris_inst *inst,
+			    struct iris_buffer *buffer);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index 749d978..a3544d8 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -4,9 +4,87 @@
  */
 
 #include "iris_core.h"
+#include "iris_helpers.h"
 #include "iris_hfi_packet.h"
 #include "hfi_defines.h"
 
+u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type)
+{
+	u32 hfi_port = HFI_PORT_NONE;
+
+	switch (buffer_type) {
+	case BUF_INPUT:
+	case BUF_BIN:
+	case BUF_COMV:
+	case BUF_NON_COMV:
+	case BUF_LINE:
+		hfi_port = HFI_PORT_BITSTREAM;
+		break;
+	case BUF_OUTPUT:
+	case BUF_DPB:
+		hfi_port = HFI_PORT_RAW;
+		break;
+	case BUF_PERSIST:
+		hfi_port = HFI_PORT_NONE;
+		break;
+	default:
+		break;
+	}
+
+	return hfi_port;
+}
+
+static u32 hfi_buf_type_from_driver(enum iris_buffer_type buffer_type)
+{
+	switch (buffer_type) {
+	case BUF_INPUT:
+		return HFI_BUFFER_BITSTREAM;
+	case BUF_OUTPUT:
+		return HFI_BUFFER_RAW;
+	case BUF_BIN:
+		return HFI_BUFFER_BIN;
+	case BUF_COMV:
+		return HFI_BUFFER_COMV;
+	case BUF_NON_COMV:
+		return HFI_BUFFER_NON_COMV;
+	case BUF_LINE:
+		return HFI_BUFFER_LINE;
+	case BUF_DPB:
+		return HFI_BUFFER_DPB;
+	case BUF_PERSIST:
+		return HFI_BUFFER_PERSIST;
+	default:
+		return 0;
+	}
+}
+
+int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf)
+{
+	memset(buf, 0, sizeof(*buf));
+	buf->type = hfi_buf_type_from_driver(buffer->type);
+	buf->index = buffer->index;
+	buf->base_address = buffer->device_addr;
+	buf->addr_offset = 0;
+	buf->buffer_size = buffer->buffer_size;
+	/*
+	 * for decoder input buffers, firmware (BSE HW) needs 256 aligned
+	 * buffer size otherwise it will truncate or ignore the data after 256
+	 * aligned size which may lead to error concealment
+	 */
+	if (buffer->type == BUF_INPUT)
+		buf->buffer_size = ALIGN(buffer->buffer_size, 256);
+	buf->data_offset = buffer->data_offset;
+	buf->data_size = buffer->data_size;
+	if (buffer->attr & BUF_ATTR_READ_ONLY)
+		buf->flags |= HFI_BUF_HOST_FLAG_READONLY;
+	if (buffer->attr & BUF_ATTR_PENDING_RELEASE)
+		buf->flags |= HFI_BUF_HOST_FLAG_RELEASE;
+	buf->flags |= HFI_BUF_HOST_FLAGS_CB_NON_SECURE;
+	buf->timestamp = buffer->timestamp;
+
+	return 0;
+}
+
 static int hfi_create_header(u8 *packet, u32 packet_size, u32 session_id,
 			     u32 header_id)
 {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index bea7ed9..bf18553 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -27,6 +27,19 @@ struct hfi_packet {
 	u32 reserved[2];
 };
 
+struct hfi_buffer {
+	u32 type;
+	u32 index;
+	u64 base_address;
+	u32 addr_offset;
+	u32 buffer_size;
+	u32 data_offset;
+	u32 data_size;
+	u64 timestamp;
+	u32 flags;
+	u32 reserved[5];
+};
+
 enum hfi_packet_host_flags {
 	HFI_HOST_FLAGS_NONE			= 0x00000000,
 	HFI_HOST_FLAGS_INTR_REQUIRED		= 0x00000001,
@@ -66,6 +79,8 @@ enum hfi_packet_port_type {
 	HFI_PORT_RAW		= 0x00000002,
 };
 
+u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type);
+int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf);
 int hfi_packet_sys_init(struct iris_core *core,
 			u8 *pkt, u32 pkt_size);
 int hfi_packet_image_version(struct iris_core *core,
-- 
2.7.4


