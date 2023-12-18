Return-Path: <linux-kernel+bounces-3471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B6E816CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22A4281944
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D22938FB6;
	Mon, 18 Dec 2023 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YQL+b2L3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613020319;
	Mon, 18 Dec 2023 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsJhd018720;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=vLWVflzGpI+Jo2k1Eg3SqmsgzB7LOhhG3o6SoZkBRRc=; b=YQ
	L+b2L3uhBRPdq2Mdrt5CiiRJRt46aYK/rs2islRK6YGKapMIGrjDmXIfYGizvhCi
	OvrAraXLZO2KFe7QxHePQl2alm9bWF4XIRmk1eI4V6soNYFiJ8uR1d5Cux99Ag58
	5MQkD4FEGznSqav64f/6/evTki7jLMGa5xB4Npbeq8j8d+31OWAMHig0hrg3AwRS
	rYsNy5FW2SbEgIlr324YCbX9RLqVcucbf8gksX1iNhjOerLG1rIAr1D8zrBCw9LX
	YKS+GR4QJ5k99pS18OnuJjFdWjN+KOg8PWKgQRWFQxLQp/fnqfXlicO9e8pelE3F
	vfJJGOEOMOfBabROKx1w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mfe04np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0Hl004853;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ae-1;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX72r029995;
	Mon, 18 Dec 2023 11:33:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6II029972;
	Mon, 18 Dec 2023 11:33:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 5377E2314; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 21/34] media: iris: implement internal buffer management
Date: Mon, 18 Dec 2023 17:02:16 +0530
Message-Id: <1702899149-21321-22-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rx914hXB-zqkaMxTFQopuNafJYIhPCPb
X-Proofpoint-GUID: rx914hXB-zqkaMxTFQopuNafJYIhPCPb
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

Implement functions for creating, queueing, releasing
and destroying buffers for internal usage.
During any bitstream parameter change, these internal buffers
needs to be reallocated and requeued. To optimize the same,
driver checks for reusability of any buffer and skip
re-allocation/re-queue.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |   2 +
 .../media/platform/qcom/vcodec/iris/iris_buffer.c  | 312 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_buffer.h  |  12 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   4 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    |   3 +
 5 files changed, 333 insertions(+)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index c044f78..ce4eaff 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -53,6 +53,8 @@
 
 #define HFI_PROP_DEC_START_FROM_RAP_FRAME	0x03000169
 
+#define HFI_PROP_COMV_BUFFER_COUNT		0x03000193
+
 #define HFI_SYS_ERROR_WD_TIMEOUT		0x05000001
 
 struct hfi_debug_header {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
index 6d4e722..2a3989c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
@@ -6,8 +6,22 @@
 #include "../buffers.h"
 #include "iris_buffer.h"
 #include "iris_helpers.h"
+#include "iris_hfi.h"
+#include "hfi_defines.h"
+#include "iris_hfi_packet.h"
 #include "iris_instance.h"
 
+static const u32 dec_ip_int_buf_type[] = {
+	BUF_BIN,
+	BUF_COMV,
+	BUF_NON_COMV,
+	BUF_LINE,
+};
+
+static const u32 dec_op_int_buf_type[] = {
+	BUF_DPB,
+};
+
 static int input_min_count(struct iris_inst *inst)
 {
 	return MIN_BUFFERS;
@@ -225,3 +239,301 @@ int iris_free_buffers(struct iris_inst *inst,
 
 	return 0;
 }
+
+static int iris_get_internal_buf_info(struct iris_inst *inst,
+				      enum iris_buffer_type buffer_type)
+{
+	struct iris_buffers *buffers;
+	struct iris_core *core;
+	u32 buf_count;
+	u32 buf_size;
+
+	core = inst->core;
+
+	buf_size = call_session_op(core, int_buf_size,
+				   inst, buffer_type);
+
+	buf_count = iris_get_buf_min_count(inst, buffer_type);
+
+	buffers = iris_get_buffer_list(inst, buffer_type);
+	if (!buffers)
+		return -EINVAL;
+
+	if (buf_size && buf_size <= buffers->size &&
+	    buf_count && buf_count <= buffers->min_count) {
+		buffers->reuse = true;
+	} else {
+		buffers->reuse = false;
+		buffers->size = buf_size;
+		buffers->min_count = buf_count;
+	}
+
+	return 0;
+}
+
+int iris_get_internal_buffers(struct iris_inst *inst,
+			      u32 plane)
+{
+	int ret = 0;
+	u32 i = 0;
+
+	if (plane == INPUT_MPLANE) {
+		for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+			ret = iris_get_internal_buf_info(inst, dec_ip_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
+	} else {
+		return iris_get_internal_buf_info(inst, BUF_DPB);
+	}
+
+	return ret;
+}
+
+static int iris_create_internal_buffer(struct iris_inst *inst,
+				       enum iris_buffer_type buffer_type, u32 index)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *buffer;
+	struct iris_core *core;
+
+	core = inst->core;
+
+	buffers = iris_get_buffer_list(inst, buffer_type);
+	if (!buffers)
+		return -EINVAL;
+
+	if (!buffers->size)
+		return 0;
+
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&buffer->list);
+	buffer->type = buffer_type;
+	buffer->index = index;
+	buffer->buffer_size = buffers->size;
+	buffer->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_NO_KERNEL_MAPPING;
+	list_add_tail(&buffer->list, &buffers->list);
+
+	buffer->kvaddr = dma_alloc_attrs(core->dev, buffer->buffer_size,
+					 &buffer->device_addr, GFP_KERNEL, buffer->dma_attrs);
+
+	if (!buffer->kvaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int iris_create_internal_buffers(struct iris_inst *inst,
+					enum iris_buffer_type buffer_type)
+{
+	struct iris_buffers *buffers;
+	int ret = 0;
+	int i;
+
+	buffers = iris_get_buffer_list(inst, buffer_type);
+	if (!buffers)
+		return -EINVAL;
+
+	if (buffers->reuse)
+		return 0;
+
+	for (i = 0; i < buffers->min_count; i++) {
+		ret = iris_create_internal_buffer(inst, buffer_type, i);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int iris_create_input_internal_buffers(struct iris_inst *inst)
+{
+	int ret = 0;
+	u32 i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+		ret = iris_create_internal_buffers(inst, dec_ip_int_buf_type[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int iris_create_output_internal_buffers(struct iris_inst *inst)
+{
+	return iris_create_internal_buffers(inst, BUF_DPB);
+}
+
+static int set_num_comv(struct iris_inst *inst)
+{
+	u32 num_comv;
+
+	num_comv = inst->cap[NUM_COMV].value;
+
+	return iris_hfi_set_property(inst,
+					HFI_PROP_COMV_BUFFER_COUNT,
+					HFI_HOST_FLAGS_NONE,
+					HFI_PORT_BITSTREAM,
+					HFI_PAYLOAD_U32,
+					&num_comv,
+					sizeof(u32));
+}
+
+static int iris_queue_internal_buffers(struct iris_inst *inst,
+				       enum iris_buffer_type buffer_type)
+{
+	struct iris_buffer *buffer, *dummy;
+	struct iris_buffers *buffers;
+	int ret = 0;
+
+	if (buffer_type == BUF_COMV) {
+		ret = set_num_comv(inst);
+		if (ret)
+			return ret;
+	}
+
+	buffers = iris_get_buffer_list(inst, buffer_type);
+	if (!buffers)
+		return -EINVAL;
+
+	list_for_each_entry_safe(buffer, dummy, &buffers->list, list) {
+		if (buffer->attr & BUF_ATTR_PENDING_RELEASE)
+			continue;
+		if (buffer->attr & BUF_ATTR_QUEUED)
+			continue;
+		ret = iris_hfi_queue_buffer(inst, buffer);
+		if (ret)
+			return ret;
+		buffer->attr |= BUF_ATTR_QUEUED;
+	}
+
+	return ret;
+}
+
+int iris_queue_input_internal_buffers(struct iris_inst *inst)
+{
+	int ret = 0;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+		ret = iris_queue_internal_buffers(inst, dec_ip_int_buf_type[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int iris_queue_output_internal_buffers(struct iris_inst *inst)
+{
+	return iris_queue_internal_buffers(inst, BUF_DPB);
+}
+
+int iris_destroy_internal_buffer(struct iris_inst *inst,
+				 struct iris_buffer *buffer)
+{
+	struct iris_buffer *buf, *dummy;
+	struct iris_buffers *buffers;
+	struct iris_core *core;
+
+	core = inst->core;
+
+	buffers = iris_get_buffer_list(inst, buffer->type);
+	if (!buffers)
+		return -EINVAL;
+
+	list_for_each_entry_safe(buf, dummy, &buffers->list, list) {
+		if (buf->device_addr == buffer->device_addr) {
+			list_del(&buf->list);
+			dma_free_attrs(core->dev, buf->buffer_size, buf->kvaddr,
+				       buf->device_addr, buf->dma_attrs);
+			buf->kvaddr = NULL;
+			buf->device_addr = 0;
+			kfree(buf);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+int iris_destroy_internal_buffers(struct iris_inst *inst,
+				  u32 plane)
+{
+	struct iris_buffer *buf, *dummy;
+	struct iris_buffers *buffers;
+	const u32 *internal_buf_type;
+	int ret = 0;
+	u32 i, len;
+
+	if (plane == INPUT_MPLANE) {
+		internal_buf_type = dec_ip_int_buf_type;
+		len = ARRAY_SIZE(dec_ip_int_buf_type);
+	} else {
+		internal_buf_type = dec_op_int_buf_type;
+		len = ARRAY_SIZE(dec_op_int_buf_type);
+	}
+
+	for (i = 0; i < len; i++) {
+		buffers = iris_get_buffer_list(inst, internal_buf_type[i]);
+		if (!buffers)
+			return -EINVAL;
+
+		if (buffers->reuse)
+			continue;
+
+		list_for_each_entry_safe(buf, dummy, &buffers->list, list) {
+			ret = iris_destroy_internal_buffer(inst, buf);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int iris_release_internal_buffers(struct iris_inst *inst,
+					 enum iris_buffer_type buffer_type)
+{
+	struct iris_buffer *buffer, *dummy;
+	struct iris_buffers *buffers;
+	int ret = 0;
+
+	buffers = iris_get_buffer_list(inst, buffer_type);
+	if (!buffers)
+		return -EINVAL;
+
+	if (buffers->reuse)
+		return 0;
+
+	list_for_each_entry_safe(buffer, dummy, &buffers->list, list) {
+		if (buffer->attr & BUF_ATTR_PENDING_RELEASE)
+			continue;
+		if (!(buffer->attr & BUF_ATTR_QUEUED))
+			continue;
+		ret = iris_hfi_release_buffer(inst, buffer);
+		if (ret)
+			return ret;
+		buffer->attr |= BUF_ATTR_PENDING_RELEASE;
+	}
+
+	return ret;
+}
+
+int iris_release_input_internal_buffers(struct iris_inst *inst)
+{
+	int ret = 0;
+	u32 i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+		ret = iris_release_internal_buffers(inst, dec_ip_int_buf_type[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
index 1cd76a9..ece894e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
@@ -46,4 +46,16 @@ int iris_allocate_buffers(struct iris_inst *inst,
 int iris_free_buffers(struct iris_inst *inst,
 		      enum iris_buffer_type buf_type);
 
+int iris_get_internal_buffers(struct iris_inst *inst,
+			      u32 plane);
+int iris_create_input_internal_buffers(struct iris_inst *inst);
+int iris_create_output_internal_buffers(struct iris_inst *inst);
+int iris_queue_input_internal_buffers(struct iris_inst *inst);
+int iris_queue_output_internal_buffers(struct iris_inst *inst);
+int iris_destroy_internal_buffer(struct iris_inst *inst,
+				 struct iris_buffer *buffer);
+int iris_destroy_internal_buffers(struct iris_inst *inst,
+				  u32 plane);
+int iris_release_input_internal_buffers(struct iris_inst *inst);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index 4aefdc4..ca2339e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -16,6 +16,10 @@ int iris_hfi_session_close(struct iris_inst *inst);
 int iris_hfi_set_property(struct iris_inst *inst,
 			  u32 packet_type, u32 flag, u32 plane, u32 payload_type,
 			  void *payload, u32 payload_size);
+int iris_hfi_queue_buffer(struct iris_inst *inst,
+			  struct iris_buffer *buffer);
+int iris_hfi_release_buffer(struct iris_inst *inst,
+			    struct iris_buffer *buffer);
 
 irqreturn_t iris_hfi_isr(int irq, void *data);
 irqreturn_t iris_hfi_isr_handler(int irq, void *data);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index b131a50..566048e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -39,6 +39,9 @@ void vdec_inst_init(struct iris_inst *inst)
 	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
 	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	inst->buffers.output.min_count = iris_get_buf_min_count(inst, BUF_OUTPUT);
+	inst->buffers.output.actual_count = inst->buffers.output.min_count;
+	inst->buffers.output.size = f->fmt.pix_mp.plane_fmt[0].sizeimage;
 	inst->fw_min_count = 0;
 }
 
-- 
2.7.4


