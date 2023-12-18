Return-Path: <linux-kernel+bounces-3480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA4816CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F801F25041
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2C3FB39;
	Mon, 18 Dec 2023 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HPHbcOzD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D243B2A8;
	Mon, 18 Dec 2023 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIArrqu023249;
	Mon, 18 Dec 2023 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Z+YyFcHZoap2j/dtnB//4TT29/XubabIqnFS3x68d88=; b=HP
	HbcOzDWp7UlWaoaKcCuEb5T6KOP4q547IkWThF+crClrpXawwacmMldnptjDN5Jr
	S+Et8v2377q0AaeIsP/KfecRZYgilMuOyGGibOxwzn+sb9IKHu0uIvk14d/HBxgr
	9ctOiYgaQTkhSKLDH76DAjvuNZ1jzn/vKeQGhpzvIro2av33oYMbn/Nnl3zKNbfX
	xelRpPnWy4vBZ0LVWGIEe/QcqS/l7LMfcICoqc+/946s0zkZGroi38chvPF0PFvu
	tT3GQg+rbhOdEYXHfdfDh21swvz2qP+Z7vNI7Qg6NBlOAnrQ+JBff4I0/xECw3u4
	CTDmaSN/nbVqqvWcpOsA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2md2r4n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0Ho004853;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ae-4;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7dP029984;
	Mon, 18 Dec 2023 11:36:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6a8029970;
	Mon, 18 Dec 2023 11:36:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 51204230C; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 20/34] media: iris: add video hardware internal buffer count and size calculation
Date: Mon, 18 Dec 2023 17:02:15 +0530
Message-Id: <1702899149-21321-21-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0cYxUNueEMdBjUclxbGTb8vDKFBWxrpS
X-Proofpoint-GUID: 0cYxUNueEMdBjUclxbGTb8vDKFBWxrpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Video driver needs various kind of internal buffers for
frame processing. Internal buffer size calculation depends
on hardware architecture, color format, resolution and codec.

Add APIs to calculate min count and size of different
internal buffers for different codecs for iris3.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   1 +
 .../media/platform/qcom/vcodec/iris/iris_buffer.c  |  48 ++
 .../media/platform/qcom/vcodec/iris/iris_common.h  |   1 +
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   2 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  13 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   4 +
 .../platform/qcom/vcodec/iris/iris_instance.h      |   2 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    |   1 +
 .../media/platform/qcom/vcodec/iris/vpu_common.h   |   8 +
 .../media/platform/qcom/vcodec/iris/vpu_iris3.c    |   6 +
 .../platform/qcom/vcodec/iris/vpu_iris3_buffer.c   | 201 +++++
 .../platform/qcom/vcodec/iris/vpu_iris3_buffer.h   | 845 +++++++++++++++++++++
 12 files changed, 1132 insertions(+)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index a94e36b..7e3d9f1 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -16,6 +16,7 @@ iris-objs += iris_probe.o \
              resources.o \
              vpu_common.o \
              vpu_iris3.o \
+             vpu_iris3_buffer.o \
              platform_common.o \
              platform_sm8550.o
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
index b9cffbf..6d4e722 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
@@ -17,6 +17,14 @@ static int output_min_count(struct iris_inst *inst)
 {
 	int output_min_count;
 
+	/* fw_min_count > 0 indicates reconfig event has already arrived */
+	if (inst->fw_min_count) {
+		if (is_split_mode_enabled(inst) && inst->codec == VP9)
+			return min_t(u32, 4, inst->fw_min_count);
+		else
+			return inst->fw_min_count;
+	}
+
 	switch (inst->codec) {
 	case H264:
 	case HEVC:
@@ -33,6 +41,38 @@ static int output_min_count(struct iris_inst *inst)
 	return output_min_count;
 }
 
+static u32 internal_buffer_count(struct iris_inst *inst,
+				 enum iris_buffer_type buffer_type)
+{
+	u32 count = 0;
+
+	if (buffer_type == BUF_BIN || buffer_type == BUF_LINE ||
+	    buffer_type == BUF_PERSIST) {
+		count = 1;
+	} else if (buffer_type == BUF_COMV || buffer_type == BUF_NON_COMV) {
+		if (inst->codec == H264 || inst->codec == HEVC)
+			count = 1;
+		else
+			count = 0;
+	} else {
+		count = 0;
+	}
+
+	return count;
+}
+
+static int dpb_count(struct iris_inst *inst)
+{
+	int count = 0;
+
+	if (is_split_mode_enabled(inst)) {
+		count = inst->fw_min_count ?
+			inst->fw_min_count : inst->buffers.output.min_count;
+	}
+
+	return count;
+}
+
 int iris_get_buf_min_count(struct iris_inst *inst,
 			   enum iris_buffer_type buffer_type)
 {
@@ -41,6 +81,14 @@ int iris_get_buf_min_count(struct iris_inst *inst,
 		return input_min_count(inst);
 	case BUF_OUTPUT:
 		return output_min_count(inst);
+	case BUF_BIN:
+	case BUF_COMV:
+	case BUF_NON_COMV:
+	case BUF_LINE:
+	case BUF_PERSIST:
+		return internal_buffer_count(inst, buffer_type);
+	case BUF_DPB:
+		return dpb_count(inst);
 	default:
 		return 0;
 	}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index 4edadc3..a83d1c1 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -15,6 +15,7 @@
 #define OUTPUT_MPLANE V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE
 #define DEFAULT_WIDTH 320
 #define DEFAULT_HEIGHT 240
+#define DEFAULT_BSE_VPP_DELAY    2
 
 #define MB_IN_PIXEL (16 * 16)
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 30f7ad7..154991c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -50,6 +50,7 @@
  * @header_id: id of packet header
  * @packet_id: id of packet
  * @vpu_ops: a pointer to vpu ops
+ * @session_ops: a pointer to session level ops
  * @dec_codecs_count: supported codec count for decoder
  * @platform_data: a structure for platform data
  * @cap: an array for supported core capabilities
@@ -91,6 +92,7 @@ struct iris_core {
 	u32					header_id;
 	u32					packet_id;
 	const struct vpu_ops			*vpu_ops;
+	const struct vpu_session_ops		*session_ops;
 	u32					dec_codecs_count;
 	struct platform_data			*platform_data;
 	struct plat_core_cap			cap[CORE_CAP_MAX + 1];
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 54a7851..335885f 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -66,6 +66,19 @@ int get_mbpf(struct iris_inst *inst)
 	return NUM_MBS_PER_FRAME(height, width);
 }
 
+bool is_linear_colorformat(u32 colorformat)
+{
+	return colorformat == V4L2_PIX_FMT_NV12 || colorformat == V4L2_PIX_FMT_NV21;
+}
+
+bool is_split_mode_enabled(struct iris_inst *inst)
+{
+	if (is_linear_colorformat(inst->fmt_dst->fmt.pix_mp.pixelformat))
+		return true;
+
+	return false;
+}
+
 static int process_inst_timeout(struct iris_inst *inst)
 {
 	struct iris_inst *instance;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 3bae969..9e85510 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -12,6 +12,7 @@
 #include "iris_core.h"
 #include "iris_instance.h"
 #include "iris_buffer.h"
+#include "iris_instance.h"
 #include "platform_common.h"
 
 #define NUM_MBS_PER_FRAME(__height, __width) \
@@ -26,4 +27,7 @@ enum iris_buffer_type v4l2_type_to_driver(u32 type);
 int get_mbpf(struct iris_inst *inst);
 int close_session(struct iris_inst *inst);
 
+bool is_linear_colorformat(u32 colorformat);
+bool is_split_mode_enabled(struct iris_inst *inst);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index a5c6cb48..5d4c856 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -36,6 +36,7 @@
  * @caps_list: list head of capability
  * @codec: codec type
  * @buffers: structure of buffer info
+ * @fw_min_count: minimnum count of buffers needed by fw
  */
 
 struct iris_inst {
@@ -58,6 +59,7 @@ struct iris_inst {
 	struct list_head		caps_list;
 	enum codec_type			codec;
 	struct iris_buffers_info	buffers;
+	u32				fw_min_count;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 1b957a13..b131a50 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -39,6 +39,7 @@ void vdec_inst_init(struct iris_inst *inst)
 	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
 	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	inst->fw_min_count = 0;
 }
 
 void vdec_inst_deinit(struct iris_inst *inst)
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_common.h b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
index 6512039..7fba8c2 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
@@ -26,6 +26,14 @@ struct vpu_ops {
 	int (*watchdog)(struct iris_core *core, u32 intr_status);
 };
 
+#define call_session_op(c, op, ...)			\
+	(((c) && (c)->session_ops && (c)->session_ops->op) ? \
+	((c)->session_ops->op(__VA_ARGS__)) : 0)
+
+struct vpu_session_ops {
+	int (*int_buf_size)(struct iris_inst *inst, enum iris_buffer_type type);
+};
+
 int init_vpu(struct iris_core *core);
 
 int write_register(struct iris_core *core, u32 reg, u32 value);
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
index a34d0ed..efea5aa 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 
 #include "vpu_iris3.h"
+#include "vpu_iris3_buffer.h"
 
 #define VIDEO_ARCH_LX 1
 
@@ -202,9 +203,14 @@ static const struct vpu_ops iris3_ops = {
 	.watchdog = watchdog_iris3,
 };
 
+static const struct vpu_session_ops iris3_session_ops = {
+	.int_buf_size = iris_int_buf_size_iris3,
+};
+
 int init_iris3(struct iris_core *core)
 {
 	core->vpu_ops = &iris3_ops;
+	core->session_ops = &iris3_session_ops;
 
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
new file mode 100644
index 0000000..44f9342
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_core.h"
+#include "iris_helpers.h"
+#include "iris_instance.h"
+#include "vpu_iris3_buffer.h"
+
+static u32 dec_bin_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, num_vpp_pipes;
+	struct iris_core *core;
+	struct v4l2_format *f;
+	u32 size = 0;
+
+	core = inst->core;
+
+	num_vpp_pipes = core->cap[NUM_VPP_PIPE].value;
+
+	f = inst->fmt_src;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	if (inst->codec == H264)
+		size = hfi_buffer_bin_h264d(width, height, num_vpp_pipes);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_bin_h265d(width, height, num_vpp_pipes);
+	else if (inst->codec == VP9)
+		size = hfi_buffer_bin_vp9d(width, height,
+					   num_vpp_pipes);
+	return size;
+}
+
+static u32 dec_comv_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, num_comv;
+	struct v4l2_format *f;
+	u32 size = 0;
+
+	f = inst->fmt_src;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	num_comv = inst->buffers.output.min_count;
+
+	if (inst->codec == H264)
+		size = hfi_buffer_comv_h264d(width, height, num_comv);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_comv_h265d(width, height, num_comv);
+
+	inst->cap[NUM_COMV].value = num_comv;
+
+	return size;
+}
+
+static u32 dec_non_comv_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, num_vpp_pipes;
+	struct iris_core *core;
+	struct v4l2_format *f;
+	u32 size = 0;
+
+	core = inst->core;
+
+	num_vpp_pipes = core->cap[NUM_VPP_PIPE].value;
+
+	f = inst->fmt_src;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	if (inst->codec == H264)
+		size = hfi_buffer_non_comv_h264d(width, height, num_vpp_pipes);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_non_comv_h265d(width, height, num_vpp_pipes);
+
+	return size;
+}
+
+static u32 dec_line_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, out_min_count, num_vpp_pipes;
+	struct iris_core *core;
+	struct v4l2_format *f;
+	u32 size = 0;
+	bool is_opb;
+
+	core = inst->core;
+	num_vpp_pipes = core->cap[NUM_VPP_PIPE].value;
+
+	is_opb = true;
+
+	f = inst->fmt_src;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+	out_min_count = inst->buffers.output.min_count;
+	if (inst->codec == H264)
+		size = hfi_buffer_line_h264d(width, height, is_opb,
+					     num_vpp_pipes);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_line_h265d(width, height, is_opb,
+					     num_vpp_pipes);
+	else if (inst->codec == VP9)
+		size = hfi_buffer_line_vp9d(width, height, out_min_count,
+					    is_opb, num_vpp_pipes);
+	return size;
+}
+
+static u32 dec_persist_size_iris3(struct iris_inst *inst)
+{
+	u32 size = 0;
+
+	if (inst->codec == H264)
+		size = hfi_buffer_persist_h264d(0);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_persist_h265d(0);
+	else if (inst->codec == VP9)
+		size = hfi_buffer_persist_vp9d();
+
+	return size;
+}
+
+static u32 dec_dpb_size_iris3(struct iris_inst *inst)
+{
+	struct v4l2_format *f;
+	u32 width, height;
+	u32 color_fmt;
+	u32 size = 0;
+
+	f = inst->fmt_dst;
+	color_fmt = f->fmt.pix_mp.pixelformat;
+	if (!is_linear_colorformat(color_fmt))
+		return size;
+
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	if (color_fmt == V4L2_PIX_FMT_NV12 ||
+	    color_fmt == V4L2_PIX_FMT_QC08C) {
+		size =
+		hfi_nv12_ubwc_il_calc_buf_size_v2(width, height,
+						  ALIGN(width, 128),
+						  ALIGN(height, 32),
+						  ALIGN(width, 128),
+						  ALIGN((height + 1) >> 1, 32),
+						  ALIGN(DIV_ROUND_UP(width, 32), 64),
+						  ALIGN(DIV_ROUND_UP(height, 8), 16),
+						  ALIGN(DIV_ROUND_UP((width + 1) >> 1, 16), 64),
+						  ALIGN(DIV_ROUND_UP((height + 1) >> 1, 8), 16));
+	} else if (color_fmt == V4L2_PIX_FMT_QC10C) {
+		size =
+		hfi_yuv420_tp10_ubwc_calc_buf_size(ALIGN(ALIGN(width, 192) * 4 / 3, 256),
+						   ALIGN(height, 16),
+						   ALIGN(ALIGN(width, 192) * 4 / 3, 256),
+						   ALIGN((height + 1) >> 1, 16),
+						   ALIGN(DIV_ROUND_UP(width, 48), 64),
+						   ALIGN(DIV_ROUND_UP(height, 4), 16),
+						   ALIGN(DIV_ROUND_UP((width + 1) >> 1, 24), 64),
+						   ALIGN(DIV_ROUND_UP((height + 1) >> 1, 4), 16));
+	}
+
+	return size;
+}
+
+struct iris_buf_type_handle {
+	enum iris_buffer_type type;
+	u32 (*handle)(struct iris_inst *inst);
+};
+
+int iris_int_buf_size_iris3(struct iris_inst *inst,
+			    enum iris_buffer_type buffer_type)
+{
+	const struct iris_buf_type_handle *buf_type_handle_arr = NULL;
+	u32 size = 0, buf_type_handle_size = 0;
+	int i;
+
+	static const struct iris_buf_type_handle dec_internal_buf_type_handle[] = {
+		{BUF_BIN,             dec_bin_size_iris3          },
+		{BUF_COMV,            dec_comv_size_iris3         },
+		{BUF_NON_COMV,        dec_non_comv_size_iris3     },
+		{BUF_LINE,            dec_line_size_iris3         },
+		{BUF_PERSIST,         dec_persist_size_iris3      },
+		{BUF_DPB,             dec_dpb_size_iris3          },
+	};
+
+	buf_type_handle_size = ARRAY_SIZE(dec_internal_buf_type_handle);
+	buf_type_handle_arr = dec_internal_buf_type_handle;
+
+	if (!buf_type_handle_arr || !buf_type_handle_size)
+		return size;
+
+	for (i = 0; i < buf_type_handle_size; i++) {
+		if (buf_type_handle_arr[i].type == buffer_type) {
+			size = buf_type_handle_arr[i].handle(inst);
+			break;
+		}
+	}
+
+	return size;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h
new file mode 100644
index 0000000..b520c79
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h
@@ -0,0 +1,845 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _VPU_IRIS3_BUFFER_H_
+#define _VPU_IRIS3_BUFFER_H_
+
+#include <linux/types.h>
+#include <linux/minmax.h>
+#include <linux/align.h>
+
+#include "iris_instance.h"
+
+#define DMA_ALIGNMENT 256
+
+#define BUFFER_ALIGNMENT_512_BYTES 512
+#define BUFFER_ALIGNMENT_256_BYTES 256
+#define BUFFER_ALIGNMENT_64_BYTES 64
+#define BUFFER_ALIGNMENT_32_BYTES 32
+#define BUFFER_ALIGNMENT_16_BYTES 16
+
+#define HFI_ALIGNMENT_4096 (4096)
+
+#define HFI_COL_FMT_NV12C_Y_TILE_HEIGHT (8)
+#define HFI_COL_FMT_NV12C_Y_TILE_WIDTH (32)
+#define HFI_COL_FMT_NV12C_UV_TILE_HEIGHT (8)
+#define HFI_COL_FMT_NV12C_UV_TILE_WIDTH (16)
+
+#define NUM_HW_PIC_BUF 32
+#define SIZE_HW_PIC(size_per_buf) (NUM_HW_PIC_BUF * (size_per_buf))
+
+#define MAX_TILE_COLUMNS 32
+
+#define LCU_MAX_SIZE_PELS 64
+#define LCU_MIN_SIZE_PELS 16
+
+#define HDR10_HIST_EXTRADATA_SIZE (4 * 1024)
+
+#define BIN_BUFFER_THRESHOLD (1280 * 736)
+
+#define VPP_CMD_MAX_SIZE (BIT(20))
+
+#define H264D_MAX_SLICE 1800
+
+#define SIZE_H264D_BUFTAB_T (256)
+#define SIZE_H264D_HW_PIC_T (BIT(11))
+#define SIZE_H264D_BSE_CMD_PER_BUF (32 * 4)
+#define SIZE_H264D_VPP_CMD_PER_BUF (512)
+
+#define NUM_SLIST_BUF_H264 (256 + 32)
+#define SIZE_SLIST_BUF_H264 (512)
+#define H264_DISPLAY_BUF_SIZE (3328)
+#define H264_NUM_FRM_INFO (66)
+
+#define H265_NUM_TILE_COL 32
+#define H265_NUM_TILE_ROW 128
+#define H265_NUM_TILE (H265_NUM_TILE_ROW * H265_NUM_TILE_COL + 1)
+#define SIZE_H265D_BSE_CMD_PER_BUF (16 * sizeof(u32))
+
+#define NUM_SLIST_BUF_H265 (80 + 20)
+#define SIZE_SLIST_BUF_H265 (BIT(10))
+#define H265_DISPLAY_BUF_SIZE (3072)
+#define H265_NUM_FRM_INFO (48)
+
+#define VP9_NUM_FRAME_INFO_BUF 32
+#define VP9_NUM_PROBABILITY_TABLE_BUF (VP9_NUM_FRAME_INFO_BUF + 4)
+#define VP9_PROB_TABLE_SIZE (3840)
+#define VP9_FRAME_INFO_BUF_SIZE (6144)
+
+#define VP9_UDC_HEADER_BUF_SIZE (3 * 128)
+#define MAX_SUPERFRAME_HEADER_LEN (34)
+#define CCE_TILE_OFFSET_SIZE ALIGN(32 * 4 * 4, BUFFER_ALIGNMENT_32_BYTES)
+
+#define SIZE_SEI_USERDATA (4096)
+#define SIZE_DOLBY_RPU_METADATA (41 * 1024)
+
+#define H264_CABAC_HDR_RATIO_HD_TOT 1
+#define H264_CABAC_RES_RATIO_HD_TOT 3
+
+#define H265D_MAX_SLICE 1200
+#define SIZE_H265D_HW_PIC_T SIZE_H264D_HW_PIC_T
+#define H265_CABAC_HDR_RATIO_HD_TOT 2
+#define H265_CABAC_RES_RATIO_HD_TOT 2
+#define SIZE_H265D_VPP_CMD_PER_BUF (256)
+
+#define VPX_DECODER_FRAME_CONCURENCY_LVL (2)
+#define VPX_DECODER_FRAME_BIN_HDR_BUDGET 1
+#define VPX_DECODER_FRAME_BIN_RES_BUDGET 3
+#define VPX_DECODER_FRAME_BIN_DENOMINATOR 2
+
+#define VPX_DECODER_FRAME_BIN_RES_BUDGET_RATIO (3 / 2)
+
+#define MAX_FE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE 64
+#define MAX_FE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE 64
+#define MAX_FE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE 64
+
+#define MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE (128 / 8)
+#define MAX_SE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE (128 / 8)
+#define MAX_SE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE (128 / 8)
+
+#define MAX_PE_NBR_DATA_LCU64_LINE_BUFFER_SIZE (64 * 2 * 3)
+#define MAX_FE_NBR_DATA_LUMA_LINE_BUFFER_SIZE 640
+
+static inline
+u32 size_h264d_hw_bin_buffer(u32 frame_width, u32 frame_height,
+			     u32 num_vpp_pipes)
+{
+	u32 size_yuv, size_bin_hdr, size_bin_res;
+
+	size_yuv = ((frame_width * frame_height) <= BIN_BUFFER_THRESHOLD) ?
+			((BIN_BUFFER_THRESHOLD * 3) >> 1) :
+			((frame_width * frame_height * 3) >> 1);
+	size_bin_hdr = size_yuv * H264_CABAC_HDR_RATIO_HD_TOT;
+	size_bin_res = size_yuv * H264_CABAC_RES_RATIO_HD_TOT;
+	size_bin_hdr = ALIGN(size_bin_hdr / num_vpp_pipes,
+			     DMA_ALIGNMENT) * num_vpp_pipes;
+	size_bin_res = ALIGN(size_bin_res / num_vpp_pipes,
+			     DMA_ALIGNMENT) * num_vpp_pipes;
+
+	return size_bin_hdr + size_bin_res;
+}
+
+static inline
+u32 hfi_buffer_bin_h264d(u32 frame_width, u32 frame_height,
+			 u32 num_vpp_pipes)
+{
+	u32 n_aligned_w, n_aligned_h;
+
+	n_aligned_w =
+		ALIGN(frame_width, BUFFER_ALIGNMENT_16_BYTES);
+	n_aligned_h =
+		ALIGN(frame_height, BUFFER_ALIGNMENT_16_BYTES);
+
+	return size_h264d_hw_bin_buffer(n_aligned_w, n_aligned_h,
+					num_vpp_pipes);
+}
+
+static inline
+u32 size_h265d_hw_bin_buffer(u32 frame_width, u32 frame_height,
+			     u32 num_vpp_pipes)
+{
+	u32 size_yuv, size_bin_hdr, size_bin_res;
+
+	size_yuv = ((frame_width * frame_height) <= BIN_BUFFER_THRESHOLD) ?
+		((BIN_BUFFER_THRESHOLD * 3) >> 1) :
+		((frame_width * frame_height * 3) >> 1);
+	size_bin_hdr = size_yuv * H265_CABAC_HDR_RATIO_HD_TOT;
+	size_bin_res = size_yuv * H265_CABAC_RES_RATIO_HD_TOT;
+	size_bin_hdr = ALIGN(size_bin_hdr / num_vpp_pipes, DMA_ALIGNMENT) *
+			num_vpp_pipes;
+	size_bin_res = ALIGN(size_bin_res / num_vpp_pipes, DMA_ALIGNMENT) *
+			num_vpp_pipes;
+
+	return size_bin_hdr + size_bin_res;
+}
+
+static inline
+u32 hfi_buffer_bin_h265d(u32 frame_width, u32 frame_height,
+			 u32 num_vpp_pipes)
+{
+	u32 n_aligned_w, n_aligned_h;
+
+	n_aligned_w = ALIGN(frame_width, BUFFER_ALIGNMENT_16_BYTES);
+	n_aligned_h = ALIGN(frame_height, BUFFER_ALIGNMENT_16_BYTES);
+	return size_h265d_hw_bin_buffer(n_aligned_w, n_aligned_h,
+					num_vpp_pipes);
+}
+
+static inline
+u32 hfi_buffer_bin_vp9d(u32 frame_width, u32 frame_height,
+			u32 num_vpp_pipes)
+{
+	u32 _size_yuv, _size;
+
+	_size_yuv = ALIGN(frame_width, BUFFER_ALIGNMENT_16_BYTES) *
+		ALIGN(frame_height, BUFFER_ALIGNMENT_16_BYTES) * 3 / 2;
+	_size = ALIGN(((max_t(u32, _size_yuv, ((BIN_BUFFER_THRESHOLD * 3) >> 1)) *
+			VPX_DECODER_FRAME_BIN_HDR_BUDGET / VPX_DECODER_FRAME_BIN_DENOMINATOR *
+			VPX_DECODER_FRAME_CONCURENCY_LVL) / num_vpp_pipes),
+		      DMA_ALIGNMENT) +
+		ALIGN(((max_t(u32, _size_yuv, ((BIN_BUFFER_THRESHOLD * 3) >> 1)) *
+			VPX_DECODER_FRAME_BIN_RES_BUDGET / VPX_DECODER_FRAME_BIN_DENOMINATOR *
+			VPX_DECODER_FRAME_CONCURENCY_LVL) / num_vpp_pipes),
+		      DMA_ALIGNMENT);
+
+	return _size * num_vpp_pipes;
+}
+
+static inline
+u32 hfi_buffer_comv_h264d(u32 frame_width, u32 frame_height,
+			  u32 _comv_bufcount)
+{
+	u32 frame_width_in_mbs = ((frame_width + 15) >> 4);
+	u32 frame_height_in_mbs = ((frame_height + 15) >> 4);
+	u32 col_mv_aligned_width = (frame_width_in_mbs << 7);
+	u32 col_zero_aligned_width = (frame_width_in_mbs << 2);
+	u32 col_zero_size = 0, size_colloc = 0;
+
+	col_mv_aligned_width =
+		ALIGN(col_mv_aligned_width, BUFFER_ALIGNMENT_16_BYTES);
+	col_zero_aligned_width =
+		ALIGN(col_zero_aligned_width, BUFFER_ALIGNMENT_16_BYTES);
+	col_zero_size = col_zero_aligned_width *
+			((frame_height_in_mbs + 1) >> 1);
+	col_zero_size =
+		ALIGN(col_zero_size, BUFFER_ALIGNMENT_64_BYTES);
+	col_zero_size <<= 1;
+	col_zero_size =
+		ALIGN(col_zero_size, BUFFER_ALIGNMENT_512_BYTES);
+	size_colloc = col_mv_aligned_width *
+			((frame_height_in_mbs + 1) >> 1);
+	size_colloc =
+		ALIGN(size_colloc, BUFFER_ALIGNMENT_64_BYTES);
+	size_colloc <<= 1;
+	size_colloc =
+		ALIGN(size_colloc, BUFFER_ALIGNMENT_512_BYTES);
+	size_colloc += (col_zero_size + SIZE_H264D_BUFTAB_T * 2);
+
+	return (size_colloc * (_comv_bufcount)) +
+		BUFFER_ALIGNMENT_512_BYTES;
+}
+
+static inline
+u32 hfi_buffer_comv_h265d(u32 frame_width, u32 frame_height,
+			  u32 _comv_bufcount)
+{
+	u32 _size;
+
+	_size = ALIGN(((((frame_width + 15) >> 4) *
+		       ((frame_height + 15) >> 4)) << 8),
+		     BUFFER_ALIGNMENT_512_BYTES);
+	_size *= _comv_bufcount;
+	_size += BUFFER_ALIGNMENT_512_BYTES;
+
+	return _size;
+}
+
+static inline
+u32 size_h264d_bse_cmd_buf(u32 frame_width, u32 frame_height)
+{
+	u32 _height = ALIGN(frame_height,
+			    BUFFER_ALIGNMENT_32_BYTES);
+	return min_t(u32, (((_height + 15) >> 4) * 48), H264D_MAX_SLICE) *
+		SIZE_H264D_BSE_CMD_PER_BUF;
+}
+
+static inline
+u32 size_h264d_vpp_cmd_buf(u32 frame_width, u32 frame_height)
+{
+	u32 _size, _height;
+
+	_height = ALIGN(frame_height, BUFFER_ALIGNMENT_32_BYTES);
+	_size = min_t(u32, (((_height + 15) >> 4) * 48), H264D_MAX_SLICE) *
+			SIZE_H264D_VPP_CMD_PER_BUF;
+
+	if (_size > VPP_CMD_MAX_SIZE)
+		_size = VPP_CMD_MAX_SIZE;
+
+	return _size;
+}
+
+static inline
+u32 hfi_buffer_non_comv_h264d(u32 frame_width, u32 frame_height,
+			      u32 num_vpp_pipes)
+{
+	u32 _size_bse, _size_vpp, _size;
+
+	_size_bse = size_h264d_bse_cmd_buf(frame_width, frame_height);
+	_size_vpp = size_h264d_vpp_cmd_buf(frame_width, frame_height);
+	_size = ALIGN(_size_bse, DMA_ALIGNMENT) +
+		ALIGN(_size_vpp, DMA_ALIGNMENT) +
+		ALIGN(SIZE_HW_PIC(SIZE_H264D_HW_PIC_T), DMA_ALIGNMENT);
+
+	return ALIGN(_size, DMA_ALIGNMENT);
+}
+
+static inline
+u32 size_h265d_bse_cmd_buf(u32 frame_width, u32 frame_height)
+{
+	u32 _size;
+
+	_size = ALIGN(((ALIGN(frame_width, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS) *
+		      (ALIGN(frame_height, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS)) *
+		     NUM_HW_PIC_BUF, DMA_ALIGNMENT);
+	_size = min_t(u32, _size, H265D_MAX_SLICE + 1);
+	_size = 2 * _size * SIZE_H265D_BSE_CMD_PER_BUF;
+
+	return _size;
+}
+
+static inline
+u32 size_h265d_vpp_cmd_buf(u32 frame_width, u32 frame_height)
+{
+	u32 _size;
+
+	_size = ALIGN(((ALIGN(frame_width, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS) *
+		      (ALIGN(frame_height, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS)) *
+		     NUM_HW_PIC_BUF, DMA_ALIGNMENT);
+	_size = min_t(u32, _size, H265D_MAX_SLICE + 1);
+	_size = ALIGN(_size, 4);
+	_size = 2 * _size * SIZE_H265D_VPP_CMD_PER_BUF;
+	if (_size > VPP_CMD_MAX_SIZE)
+		_size = VPP_CMD_MAX_SIZE;
+
+	return _size;
+}
+
+static inline
+u32 hfi_buffer_non_comv_h265d(u32 frame_width, u32 frame_height,
+			      u32 num_vpp_pipes)
+{
+	u32 _size_bse, _size_vpp, _size;
+
+	_size_bse = size_h265d_bse_cmd_buf(frame_width, frame_height);
+	_size_vpp = size_h265d_vpp_cmd_buf(frame_width, frame_height);
+	_size = ALIGN(_size_bse, DMA_ALIGNMENT) +
+		ALIGN(_size_vpp, DMA_ALIGNMENT) +
+		ALIGN(NUM_HW_PIC_BUF * 20 * 22 * 4, DMA_ALIGNMENT) +
+		ALIGN(2 * sizeof(u16) *
+		      (ALIGN(frame_width, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS) *
+		      (ALIGN(frame_height, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS),
+		      DMA_ALIGNMENT) +
+		ALIGN(SIZE_HW_PIC(SIZE_H265D_HW_PIC_T),
+		      DMA_ALIGNMENT) +
+		HDR10_HIST_EXTRADATA_SIZE;
+
+	return ALIGN(_size, DMA_ALIGNMENT);
+}
+
+static inline u32 size_h264d_lb_fe_top_data(u32 frame_width, u32 frame_height)
+{
+	return MAX_FE_NBR_DATA_LUMA_LINE_BUFFER_SIZE * ALIGN(frame_width, 16) * 3;
+}
+
+static inline u32 size_h264d_lb_fe_top_ctrl(u32 frame_width, u32 frame_height)
+{
+	return MAX_FE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE * ((frame_width + 15) >> 4);
+}
+
+static inline u32 size_h264d_lb_fe_left_ctrl(u32 frame_width, u32 frame_height)
+{
+	return MAX_FE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE * ((frame_height + 15) >> 4);
+}
+
+static inline u32 size_h264d_lb_se_top_ctrl(u32 frame_width, u32 frame_height)
+{
+	return MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE * ((frame_width + 15) >> 4);
+}
+
+static inline u32 size_h264d_lb_se_left_ctrl(u32 frame_width, u32 frame_height)
+{
+	return MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE * ((frame_height + 15) >> 4);
+}
+
+static inline u32 size_h264d_lb_pe_top_data(u32 frame_width, u32 frame_height)
+{
+	return MAX_PE_NBR_DATA_LCU64_LINE_BUFFER_SIZE *  ((frame_width + 15) >> 4);
+}
+
+static inline u32 size_h264d_lb_vsp_top(u32 frame_width, u32 frame_height)
+{
+	return (((frame_width + 15) >> 4) << 7);
+}
+
+static inline u32 size_h264d_lb_recon_dma_metadata_wr(u32 frame_width, u32 frame_height)
+{
+	return ALIGN(frame_height, 16) * 32;
+}
+
+static inline u32 size_h264d_qp(u32 frame_width, u32 frame_height)
+{
+	return ((frame_width + 63) >> 6) * ((frame_height + 63) >> 6) * 128;
+}
+
+static inline
+u32 size_vpss_lb(u32 frame_width, u32 frame_height, u32 num_vpp_pipes)
+{
+	u32 vpss_4tap_left_buffer_size = 0, vpss_div2_left_buffer_size = 0;
+	u32 vpss_4tap_top_buffer_size = 0, vpss_div2_top_buffer_size = 0;
+	u32 opb_lb_wr_llb_y_buffer_size, opb_lb_wr_llb_uv_buffer_size;
+	u32 opb_wr_top_line_chroma_buffer_size;
+	u32 opb_wr_top_line_luma_buffer_size;
+	u32 macrotiling_size = 32, size;
+
+	opb_wr_top_line_luma_buffer_size =
+		ALIGN(frame_width, macrotiling_size) /
+		macrotiling_size * 256;
+	opb_wr_top_line_luma_buffer_size =
+		ALIGN(opb_wr_top_line_luma_buffer_size, DMA_ALIGNMENT) +
+		(MAX_TILE_COLUMNS - 1) * 256;
+	opb_wr_top_line_luma_buffer_size =
+		max_t(u32, opb_wr_top_line_luma_buffer_size,
+		      (32 * ALIGN(frame_height, 8)));
+	opb_wr_top_line_chroma_buffer_size =
+		opb_wr_top_line_luma_buffer_size;
+	opb_lb_wr_llb_uv_buffer_size =
+		ALIGN((ALIGN(frame_height, 8) / (4 / 2)) * 64,
+		      BUFFER_ALIGNMENT_32_BYTES);
+	opb_lb_wr_llb_y_buffer_size =
+		ALIGN((ALIGN(frame_height, 8) / (4 / 2)) * 64,
+		      BUFFER_ALIGNMENT_32_BYTES);
+	size = num_vpp_pipes * 2 *
+		(vpss_4tap_top_buffer_size + vpss_div2_top_buffer_size) +
+		2 * (vpss_4tap_left_buffer_size + vpss_div2_left_buffer_size) +
+		opb_wr_top_line_luma_buffer_size +
+		opb_wr_top_line_chroma_buffer_size +
+		opb_lb_wr_llb_uv_buffer_size +
+		opb_lb_wr_llb_y_buffer_size;
+
+	return size;
+}
+
+static inline
+u32 hfi_buffer_line_h264d(u32 frame_width, u32 frame_height,
+			  bool is_opb, u32 num_vpp_pipes)
+{
+	u32 vpss_lb_size = 0;
+	u32 _size;
+
+	_size = ALIGN(size_h264d_lb_fe_top_data(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h264d_lb_fe_top_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h264d_lb_fe_left_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) * num_vpp_pipes +
+		ALIGN(size_h264d_lb_se_top_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h264d_lb_se_left_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) * num_vpp_pipes +
+		ALIGN(size_h264d_lb_pe_top_data(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h264d_lb_vsp_top(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h264d_lb_recon_dma_metadata_wr(frame_width, frame_height),
+		      DMA_ALIGNMENT) * 2 +
+		ALIGN(size_h264d_qp(frame_width, frame_height),
+		      DMA_ALIGNMENT);
+	_size = ALIGN(_size, DMA_ALIGNMENT);
+	if (is_opb)
+		vpss_lb_size = size_vpss_lb(frame_width, frame_height,
+					    num_vpp_pipes);
+
+	_size = ALIGN((_size + vpss_lb_size),
+		      DMA_ALIGNMENT);
+
+	return _size;
+}
+
+static inline
+u32 size_h265d_lb_fe_top_data(u32 frame_width, u32 frame_height)
+{
+	return MAX_FE_NBR_DATA_LUMA_LINE_BUFFER_SIZE *
+		(ALIGN(frame_width, 64) + 8) * 2;
+}
+
+static inline
+u32 size_h265d_lb_fe_top_ctrl(u32 frame_width, u32 frame_height)
+{
+	return MAX_FE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE *
+		(ALIGN(frame_width, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS);
+}
+
+static inline
+u32 size_h265d_lb_fe_left_ctrl(u32 frame_width, u32 frame_height)
+{
+	return MAX_FE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE *
+		(ALIGN(frame_height, LCU_MAX_SIZE_PELS) / LCU_MIN_SIZE_PELS);
+}
+
+static inline
+u32 size_h265d_lb_se_top_ctrl(u32 frame_width, u32 frame_height)
+{
+	return (LCU_MAX_SIZE_PELS / 8 * (128 / 8)) * ((frame_width + 15) >> 4);
+}
+
+static inline
+u32 size_h265d_lb_se_left_ctrl(u32 frame_width, u32 frame_height)
+{
+	return max_t(u32, ((frame_height + 16 - 1) / 8) *
+		     MAX_SE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE,
+		     max_t(u32, ((frame_height + 32 - 1) / 8) *
+			   MAX_SE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE,
+			   ((frame_height + 64 - 1) / 8) *
+			   MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE));
+}
+
+static inline
+u32 size_h265d_lb_pe_top_data(u32 frame_width, u32 frame_height)
+{
+	return MAX_PE_NBR_DATA_LCU64_LINE_BUFFER_SIZE *
+		(ALIGN(frame_width, LCU_MIN_SIZE_PELS) / LCU_MIN_SIZE_PELS);
+}
+
+static inline
+u32 size_h265d_lb_vsp_top(u32 frame_width, u32 frame_height)
+{
+	return ((frame_width + 63) >> 6) * 128;
+}
+
+static inline
+u32 size_h265d_lb_vsp_left(u32 frame_width, u32 frame_height)
+{
+	return ((frame_height + 63) >> 6) * 128;
+}
+
+static inline
+u32 size_h265d_lb_recon_dma_metadata_wr(u32 frame_width, u32 frame_height)
+{
+	return size_h264d_lb_recon_dma_metadata_wr(frame_width, frame_height);
+}
+
+static inline
+u32 size_h265d_qp(u32 frame_width, u32 frame_height)
+{
+	return size_h264d_qp(frame_width, frame_height);
+}
+
+static inline
+u32 hfi_buffer_line_h265d(u32 frame_width, u32 frame_height,
+			  bool is_opb, u32 num_vpp_pipes)
+{
+	u32 vpss_lb_size = 0, _size;
+
+	_size = ALIGN(size_h265d_lb_fe_top_data(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h265d_lb_fe_top_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h265d_lb_fe_left_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) * num_vpp_pipes +
+		ALIGN(size_h265d_lb_se_left_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) * num_vpp_pipes +
+		ALIGN(size_h265d_lb_se_top_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h265d_lb_pe_top_data(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h265d_lb_vsp_top(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_h265d_lb_vsp_left(frame_width, frame_height),
+		      DMA_ALIGNMENT) * num_vpp_pipes +
+		ALIGN(size_h265d_lb_recon_dma_metadata_wr(frame_width, frame_height),
+		      DMA_ALIGNMENT) * 4 +
+		ALIGN(size_h265d_qp(frame_width, frame_height),
+		      DMA_ALIGNMENT);
+	if (is_opb)
+		vpss_lb_size = size_vpss_lb(frame_width, frame_height, num_vpp_pipes);
+
+	return ALIGN((_size + vpss_lb_size), DMA_ALIGNMENT);
+}
+
+static inline
+u32 size_vpxd_lb_fe_left_ctrl(u32 frame_width, u32 frame_height)
+{
+	return max_t(u32, ((frame_height + 15) >> 4) * MAX_FE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE,
+		     max_t(u32, ((frame_height + 31) >> 5) * MAX_FE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE,
+			   ((frame_height + 63) >> 6) * MAX_FE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE));
+}
+
+static inline
+u32 size_vpxd_lb_fe_top_ctrl(u32 frame_width, u32 frame_height)
+{
+	return ((ALIGN(frame_width, 64) + 8) * 10 * 2);
+}
+
+static inline
+u32 size_vpxd_lb_se_top_ctrl(u32 frame_width, u32 frame_height)
+{
+	return ((frame_width + 15) >> 4) * MAX_FE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE;
+}
+
+static inline
+u32 size_vpxd_lb_se_left_ctrl(u32 frame_width, u32 frame_height)
+{
+	return max_t(u32, ((frame_height + 15) >> 4) * MAX_SE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE,
+		     max_t(u32, ((frame_height + 31) >> 5) * MAX_SE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE,
+			   ((frame_height + 63) >> 6) * MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE));
+}
+
+static inline
+u32 size_vpxd_lb_recon_dma_metadata_wr(u32 frame_width, u32 frame_height)
+{
+	return ALIGN((ALIGN(frame_height, 8) / (4 / 2)) * 64,
+		     BUFFER_ALIGNMENT_32_BYTES);
+}
+
+static inline
+u32 size_mp2d_lb_fe_top_data(u32 frame_width, u32 frame_height)
+{
+	return ((ALIGN(frame_width, 16) + 8) * 10 * 2);
+}
+
+static inline
+u32 size_vp9d_lb_fe_top_data(u32 frame_width, u32 frame_height)
+{
+	return (ALIGN(ALIGN(frame_width, 8), 64) + 8) * 10 * 2;
+}
+
+static inline
+u32 size_vp9d_lb_pe_top_data(u32 frame_width, u32 frame_height)
+{
+	return ((ALIGN(ALIGN(frame_width, 8), 64) >> 6) * 176);
+}
+
+static inline
+u32 size_vp9d_lb_vsp_top(u32 frame_width, u32 frame_height)
+{
+	return (((ALIGN(ALIGN(frame_width, 8), 64) >> 6) * 64 * 8) + 256);
+}
+
+static inline u32 hfi_iris3_vp9d_comv_size(void)
+{
+	return (((8192 + 63) >> 6) * ((4320 + 63) >> 6) * 8 * 8 * 2 * 8);
+}
+
+static inline
+u32 size_vp9d_qp(u32 frame_width, u32 frame_height)
+{
+	return size_h264d_qp(frame_width, frame_height);
+}
+
+static inline
+u32 hfi_iris3_vp9d_lb_size(u32 frame_width, u32 frame_height,
+			   u32 num_vpp_pipes)
+{
+	return ALIGN(size_vpxd_lb_fe_left_ctrl(frame_width, frame_height),
+		     DMA_ALIGNMENT) * num_vpp_pipes +
+		ALIGN(size_vpxd_lb_se_left_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) * num_vpp_pipes +
+		ALIGN(size_vp9d_lb_vsp_top(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_vpxd_lb_fe_top_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		2 * ALIGN(size_vpxd_lb_recon_dma_metadata_wr(frame_width, frame_height),
+			  DMA_ALIGNMENT) +
+		ALIGN(size_vpxd_lb_se_top_ctrl(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_vp9d_lb_pe_top_data(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_vp9d_lb_fe_top_data(frame_width, frame_height),
+		      DMA_ALIGNMENT) +
+		ALIGN(size_vp9d_qp(frame_width, frame_height),
+		      DMA_ALIGNMENT);
+}
+
+static inline
+u32 hfi_buffer_line_vp9d(u32 frame_width, u32 frame_height,
+			 u32 _yuv_bufcount_min, bool is_opb,
+			 u32 num_vpp_pipes)
+{
+	u32 vpss_lb_size = 0;
+	u32 _lb_size = 0;
+
+	_lb_size = hfi_iris3_vp9d_lb_size(frame_width, frame_height,
+					  num_vpp_pipes);
+
+	if (is_opb)
+		vpss_lb_size = size_vpss_lb(frame_width, frame_height,
+					    num_vpp_pipes);
+
+	return _lb_size + vpss_lb_size;
+}
+
+static inline u32 hfi_buffer_persist_h264d(u32 rpu_enabled)
+{
+	return ALIGN(SIZE_SLIST_BUF_H264 * NUM_SLIST_BUF_H264 +
+		    H264_DISPLAY_BUF_SIZE * H264_NUM_FRM_INFO +
+		    NUM_HW_PIC_BUF * SIZE_SEI_USERDATA +
+		    (rpu_enabled) * NUM_HW_PIC_BUF * SIZE_DOLBY_RPU_METADATA,
+		    DMA_ALIGNMENT);
+}
+
+static inline
+u32 hfi_buffer_persist_h265d(u32 rpu_enabled)
+{
+	return ALIGN((SIZE_SLIST_BUF_H265 * NUM_SLIST_BUF_H265 +
+		      H265_NUM_FRM_INFO * H265_DISPLAY_BUF_SIZE +
+		      H265_NUM_TILE * sizeof(u32) +
+		      NUM_HW_PIC_BUF * SIZE_SEI_USERDATA +
+		      rpu_enabled * NUM_HW_PIC_BUF * SIZE_DOLBY_RPU_METADATA),
+		     DMA_ALIGNMENT);
+}
+
+static inline u32 hfi_buffer_persist_vp9d(void)
+{
+	return ALIGN(VP9_NUM_PROBABILITY_TABLE_BUF * VP9_PROB_TABLE_SIZE,
+		     DMA_ALIGNMENT) +
+		ALIGN(hfi_iris3_vp9d_comv_size(), DMA_ALIGNMENT) +
+		ALIGN(MAX_SUPERFRAME_HEADER_LEN, DMA_ALIGNMENT) +
+		ALIGN(VP9_UDC_HEADER_BUF_SIZE, DMA_ALIGNMENT) +
+		ALIGN(VP9_NUM_FRAME_INFO_BUF * CCE_TILE_OFFSET_SIZE,
+		      DMA_ALIGNMENT) +
+		ALIGN(VP9_NUM_FRAME_INFO_BUF * VP9_FRAME_INFO_BUF_SIZE,
+		      DMA_ALIGNMENT) +
+		HDR10_HIST_EXTRADATA_SIZE;
+}
+
+static inline
+u32 hfi_nv12_ubwc_il_calc_y_buf_size(u32 frame_width, u32 frame_height,
+				     u32 stride_multiple,
+				     u32 min_buf_height_multiple)
+{
+	u32 stride, buf_height;
+
+	stride = ALIGN(frame_width, stride_multiple);
+	buf_height = ALIGN(frame_height, min_buf_height_multiple);
+
+	return ALIGN(stride * buf_height, HFI_ALIGNMENT_4096);
+}
+
+static inline
+u32 hfi_nv12_ubwc_il_calc_uv_buf_size(u32 frame_width, u32 frame_height,
+				      u32 stride_multiple,
+				      u32 min_buf_height_multiple)
+{
+	u32 uv_stride, uv_buf_height;
+
+	uv_stride = ALIGN(frame_width, stride_multiple);
+	uv_buf_height = ALIGN(((frame_height + 1) >> 1),
+			      min_buf_height_multiple);
+
+	return ALIGN(uv_stride * uv_buf_height, HFI_ALIGNMENT_4096);
+}
+
+static inline
+u32 hfi_ubwc_calc_metadata_plane_stride(u32 frame_width,
+					u32 metadata_stride_multiple,
+					u32 tile_width_in_pels)
+{
+	return ALIGN(((frame_width + (tile_width_in_pels - 1)) / tile_width_in_pels),
+		     metadata_stride_multiple);
+}
+
+static inline
+u32 hfi_ubwc_metadata_plane_bufheight(u32 frame_height,
+				      u32 metadata_height_multiple,
+				      u32 tile_height_in_pels)
+{
+	return ALIGN(((frame_height + (tile_height_in_pels - 1)) / tile_height_in_pels),
+		     metadata_height_multiple);
+}
+
+static inline
+u32 hfi_ubwc_uv_metadata_plane_stride(u32 frame_width,
+				      u32 metadata_stride_multiple,
+				      u32 tile_width_in_pels)
+{
+	return ALIGN(((((frame_width + 1) >> 1) + tile_width_in_pels - 1) /
+		      tile_width_in_pels), metadata_stride_multiple);
+}
+
+static inline
+u32 hfi_ubwc_uv_metadata_plane_bufheight(u32 frame_height,
+					 u32 metadata_height_multiple,
+					 u32 tile_height_in_pels)
+{
+	return ALIGN(((((frame_height + 1) >> 1) + tile_height_in_pels - 1) /
+		      tile_height_in_pels), metadata_height_multiple);
+}
+
+static inline
+u32 hfi_ubwc_metadata_plane_buffer_size(u32 _metadata_tride, u32 _metadata_buf_height)
+{
+	return ALIGN(_metadata_tride * _metadata_buf_height, HFI_ALIGNMENT_4096);
+}
+
+static inline
+u32 hfi_nv12_ubwc_il_calc_buf_size_v2(u32 frame_width,
+				      u32 frame_height,
+				      u32 y_stride_multiple,
+				      u32 y_buffer_height_multiple,
+				      u32 uv_stride_multiple,
+				      u32 uv_buffer_height_multiple,
+				      u32 y_metadata_stride_multiple,
+				      u32 y_metadata_buffer_height_multiple,
+				      u32 uv_metadata_stride_multiple,
+				      u32 uv_metadata_buffer_height_multiple)
+{
+	u32 y_buf_size, uv_buf_size, y_meta_size, uv_meta_size;
+	u32 half_height = (frame_height + 1) >> 1;
+	u32 stride, _height;
+
+	y_buf_size =
+		hfi_nv12_ubwc_il_calc_y_buf_size(frame_width, half_height,
+						 y_stride_multiple,
+						 y_buffer_height_multiple);
+	uv_buf_size =
+		hfi_nv12_ubwc_il_calc_uv_buf_size(frame_width, half_height,
+						  uv_stride_multiple,
+						  uv_buffer_height_multiple);
+	stride =
+		hfi_ubwc_calc_metadata_plane_stride(frame_width,
+						    y_metadata_stride_multiple,
+						    HFI_COL_FMT_NV12C_Y_TILE_WIDTH);
+	_height =
+		hfi_ubwc_metadata_plane_bufheight(half_height,
+						  y_metadata_buffer_height_multiple,
+						  HFI_COL_FMT_NV12C_Y_TILE_HEIGHT);
+	y_meta_size = hfi_ubwc_metadata_plane_buffer_size(stride, _height);
+	stride =
+		hfi_ubwc_uv_metadata_plane_stride(frame_width,
+						  uv_metadata_stride_multiple,
+						  HFI_COL_FMT_NV12C_UV_TILE_WIDTH);
+	_height =
+		hfi_ubwc_uv_metadata_plane_bufheight(half_height,
+						     uv_metadata_buffer_height_multiple,
+						     HFI_COL_FMT_NV12C_UV_TILE_HEIGHT);
+	uv_meta_size = hfi_ubwc_metadata_plane_buffer_size(stride, _height);
+
+	return (y_buf_size + uv_buf_size + y_meta_size + uv_meta_size) << 1;
+}
+
+static inline
+u32 hfi_yuv420_tp10_ubwc_calc_y_buf_size(u32 y_stride,
+					 u32 y_buf_height)
+{
+	return ALIGN(y_stride * y_buf_height, HFI_ALIGNMENT_4096);
+}
+
+static inline
+u32 hfi_yuv420_tp10_ubwc_calc_uv_buf_size(u32 uv_stride,
+					  u32 uv_buf_height)
+{
+	return ALIGN(uv_stride * uv_buf_height, HFI_ALIGNMENT_4096);
+}
+
+static inline
+u32 hfi_yuv420_tp10_ubwc_calc_buf_size(u32 y_stride, u32 y_buf_height,
+				       u32 uv_stride, u32 uv_buf_height,
+				       u32 y_md_stride, u32 y_md_height,
+				       u32 uv_md_stride, u32 uv_md_height)
+{
+	u32 y_data_size, uv_data_size, y_md_size, uv_md_size;
+
+	y_data_size = hfi_yuv420_tp10_ubwc_calc_y_buf_size(y_stride, y_buf_height);
+	uv_data_size = hfi_yuv420_tp10_ubwc_calc_uv_buf_size(uv_stride, uv_buf_height);
+	y_md_size = hfi_ubwc_metadata_plane_buffer_size(y_md_stride, y_md_height);
+	uv_md_size = hfi_ubwc_metadata_plane_buffer_size(uv_md_stride, uv_md_height);
+
+	return y_data_size + uv_data_size + y_md_size + uv_md_size;
+}
+
+int iris_int_buf_size_iris3(struct iris_inst *inst,
+			    enum iris_buffer_type buffer_type);
+
+#endif
-- 
2.7.4


