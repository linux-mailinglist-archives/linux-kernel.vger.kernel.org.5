Return-Path: <linux-kernel+bounces-3451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726F816C85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CC6281CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9091C2A1;
	Mon, 18 Dec 2023 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QZrGMNdu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE91B26E;
	Mon, 18 Dec 2023 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBJih7018958;
	Mon, 18 Dec 2023 11:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Ii26TUpLDcoDUZzoj7f1vyuG0tLLz7zFj9QofAAkMJc=; b=QZ
	rGMNdu31ybxjmQvSAmfYuBIR32xUGJN3EkhF4PeV+9cBGrOSAlplCfxg5g1WMim4
	3tubvgSWRvaDsq19MlX+ucIlyF5r8oZe2D1KiKlqaNupN9CvdpX8hU53kqc3yR+m
	YILDLSvYRQ+EQqENs4CMbMLYyl13XQz+dg4EISp10+fkCSxZTzxpu8Aqd6AgHupf
	W8rISJ7d2es94YGHJYRQAyeBUP4X1caD5JeWyOhg+Ov9xW0Rz42VJ1TYRRV/kL0o
	dP1GZ/MYGWBMFseqzaPYMHya1RsOCD4dU+1EQgRtzr3ARFNvGuijYmb5+T95H538
	l4KP/c+tyoctDXyoWjFw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mb9g4my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:36:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBVmVB028246;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyjr-1;
	Mon, 18 Dec 2023 11:33:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5Aq029911;
	Mon, 18 Dec 2023 11:33:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6q7029965;
	Mon, 18 Dec 2023 11:33:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 49C562308; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 17/34] media: iris: implement vb2_ops queue setup
Date: Mon, 18 Dec 2023 17:02:12 +0530
Message-Id: <1702899149-21321-18-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cSe5nSbz30KhCIGHqG7yaTukO9KC5Hzn
X-Proofpoint-GUID: cSe5nSbz30KhCIGHqG7yaTukO9KC5Hzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Implement queue_setup vb2_ops.
Calculate the buffer count and buffer size as par video
hardware requirement and updates to client.
Also, allocate the video driver buffers for output and
capture plane.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   4 +-
 .../media/platform/qcom/vcodec/iris/iris_buffer.c  | 179 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_buffer.h  |  49 ++++++
 .../media/platform/qcom/vcodec/iris/iris_common.h  |  71 +++++++-
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  24 +++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   4 +-
 .../platform/qcom/vcodec/iris/iris_instance.h      |   6 +
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  71 ++++++++
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.h |  15 ++
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    |   5 +-
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |  19 ++-
 .../platform/qcom/vcodec/iris/platform_common.h    |  16 +-
 12 files changed, 442 insertions(+), 21 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vb2.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 7fdee5b..a94e36b 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -1,9 +1,10 @@
-iris-objs += ../hfi_queue.o ../firmware.o
+iris-objs += ../hfi_queue.o ../firmware.o ../buffers.o
 
 iris-objs += iris_probe.o \
              iris_state.o \
              iris_core.o \
              iris_vidc.o \
+             iris_vb2.o \
              iris_vdec.o \
              iris_state.o \
              iris_ctrls.o \
@@ -11,6 +12,7 @@ iris-objs += iris_probe.o \
              iris_hfi.o \
              iris_hfi_response.o \
              iris_hfi_packet.o \
+             iris_buffer.o \
              resources.o \
              vpu_common.o \
              vpu_iris3.o \
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
new file mode 100644
index 0000000..b9cffbf
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "../buffers.h"
+#include "iris_buffer.h"
+#include "iris_helpers.h"
+#include "iris_instance.h"
+
+static int input_min_count(struct iris_inst *inst)
+{
+	return MIN_BUFFERS;
+}
+
+static int output_min_count(struct iris_inst *inst)
+{
+	int output_min_count;
+
+	switch (inst->codec) {
+	case H264:
+	case HEVC:
+		output_min_count = 4;
+		break;
+	case VP9:
+		output_min_count = 9;
+		break;
+	default:
+		output_min_count = 4;
+		break;
+	}
+
+	return output_min_count;
+}
+
+int iris_get_buf_min_count(struct iris_inst *inst,
+			   enum iris_buffer_type buffer_type)
+{
+	switch (buffer_type) {
+	case BUF_INPUT:
+		return input_min_count(inst);
+	case BUF_OUTPUT:
+		return output_min_count(inst);
+	default:
+		return 0;
+	}
+}
+
+static u32 input_buffer_size(struct iris_inst *inst)
+{
+	u32 base_res_mbs = NUM_MBS_4k;
+	u32 frame_size, num_mbs;
+	struct v4l2_format *f;
+	u32 div_factor = 1;
+	u32 codec;
+
+	f = inst->fmt_src;
+	codec = f->fmt.pix_mp.pixelformat;
+
+	num_mbs = get_mbpf(inst);
+	if (num_mbs > NUM_MBS_4k) {
+		div_factor = 4;
+		base_res_mbs = inst->cap[MBPF].value;
+	} else {
+		base_res_mbs = NUM_MBS_4k;
+		if (codec == V4L2_PIX_FMT_VP9)
+			div_factor = 1;
+		else
+			div_factor = 2;
+	}
+
+	frame_size = base_res_mbs * MB_IN_PIXEL * 3 / 2 / div_factor;
+
+	 /* multiply by 10/8 (1.25) to get size for 10 bit case */
+	if (codec == V4L2_PIX_FMT_VP9 || codec == V4L2_PIX_FMT_HEVC)
+		frame_size = frame_size + (frame_size >> 2);
+
+	return ALIGN(frame_size, SZ_4K);
+}
+
+static u32 output_buffer_size(struct iris_inst *inst)
+{
+	struct v4l2_format *f;
+	u32 size;
+
+	f = inst->fmt_dst;
+
+	size = video_raw_buffer_size(f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width,
+				     f->fmt.pix_mp.height);
+	return size;
+}
+
+int iris_get_buffer_size(struct iris_inst *inst,
+			 enum iris_buffer_type buffer_type)
+{
+	switch (buffer_type) {
+	case BUF_INPUT:
+		return input_buffer_size(inst);
+	case BUF_OUTPUT:
+		return output_buffer_size(inst);
+	default:
+		return 0;
+	}
+}
+
+struct iris_buffers *iris_get_buffer_list(struct iris_inst *inst,
+					  enum iris_buffer_type buffer_type)
+{
+	switch (buffer_type) {
+	case BUF_INPUT:
+		return &inst->buffers.input;
+	case BUF_OUTPUT:
+		return &inst->buffers.output;
+	case BUF_READ_ONLY:
+		return &inst->buffers.read_only;
+	case BUF_BIN:
+		return &inst->buffers.bin;
+	case BUF_ARP:
+		return &inst->buffers.arp;
+	case BUF_COMV:
+		return &inst->buffers.comv;
+	case BUF_NON_COMV:
+		return &inst->buffers.non_comv;
+	case BUF_LINE:
+		return &inst->buffers.line;
+	case BUF_DPB:
+		return &inst->buffers.dpb;
+	case BUF_PERSIST:
+		return &inst->buffers.persist;
+	case BUF_VPSS:
+		return &inst->buffers.vpss;
+	default:
+		return NULL;
+	}
+}
+
+int iris_allocate_buffers(struct iris_inst *inst,
+			  enum iris_buffer_type buf_type,
+			  u32 num_buffers)
+{
+	struct iris_buffer *buf = NULL;
+	struct iris_buffers *buffers;
+	int idx = 0;
+
+	buffers = iris_get_buffer_list(inst, buf_type);
+	if (!buffers)
+		return -EINVAL;
+
+	for (idx = 0; idx < num_buffers; idx++) {
+		buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+		if (!buf)
+			return -EINVAL;
+
+		INIT_LIST_HEAD(&buf->list);
+		list_add_tail(&buf->list, &buffers->list);
+		buf->type = buf_type;
+		buf->index = idx;
+	}
+
+	return 0;
+}
+
+int iris_free_buffers(struct iris_inst *inst,
+		      enum iris_buffer_type buf_type)
+{
+	struct iris_buffer *buf, *dummy;
+	struct iris_buffers *buffers;
+
+	buffers = iris_get_buffer_list(inst, buf_type);
+	if (!buffers)
+		return -EINVAL;
+
+	list_for_each_entry_safe(buf, dummy, &buffers->list, list) {
+		list_del_init(&buf->list);
+		kfree(buf);
+	}
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
new file mode 100644
index 0000000..1cd76a9
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_BUFFER_H_
+#define _IRIS_BUFFER_H_
+
+#define MIN_BUFFERS  4
+
+#include "iris_common.h"
+
+struct iris_inst;
+
+struct iris_buffers {
+	struct list_head	list; // list of "struct iris_buffer"
+	u32			min_count;
+	u32			actual_count;
+	u32			size;
+	bool			reuse;
+};
+
+struct iris_buffers_info {
+	struct iris_buffers	input;
+	struct iris_buffers	output;
+	struct iris_buffers	read_only;
+	struct iris_buffers	bin;
+	struct iris_buffers	arp;
+	struct iris_buffers	comv;
+	struct iris_buffers	non_comv;
+	struct iris_buffers	line;
+	struct iris_buffers	dpb;
+	struct iris_buffers	persist;
+	struct iris_buffers	vpss;
+};
+
+int iris_get_buf_min_count(struct iris_inst *inst,
+			   enum iris_buffer_type buffer_type);
+int iris_get_buffer_size(struct iris_inst *inst,
+			 enum iris_buffer_type buffer_type);
+struct iris_buffers *iris_get_buffer_list(struct iris_inst *inst,
+					  enum iris_buffer_type buffer_type);
+int iris_allocate_buffers(struct iris_inst *inst,
+			  enum iris_buffer_type buf_type,
+			  u32 num_buffers);
+int iris_free_buffers(struct iris_inst *inst,
+		      enum iris_buffer_type buf_type);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index 3e4dd71..4edadc3 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -5,6 +5,7 @@
 #ifndef _IRIS_COMMON_H_
 #define _IRIS_COMMON_H_
 
+#include <media/v4l2-dev.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
@@ -14,7 +15,31 @@
 #define OUTPUT_MPLANE V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE
 #define DEFAULT_WIDTH 320
 #define DEFAULT_HEIGHT 240
-#define DEFAULT_BUF_SIZE 115200
+
+#define MB_IN_PIXEL (16 * 16)
+
+#define NUM_MBS_4k (((4096 + 15) >> 4) * ((2304 + 15) >> 4))
+
+enum codec_type {
+	H264	= BIT(0),
+	HEVC	= BIT(1),
+	VP9	= BIT(2),
+};
+
+enum colorformat_type {
+	FMT_NONE	= 0,
+	FMT_NV12C	= BIT(0),
+	FMT_NV12	= BIT(1),
+	FMT_NV21	= BIT(2),
+	FMT_TP10C	= BIT(3),
+};
+
+struct rect_desc {
+	u32 left;
+	u32 top;
+	u32 width;
+	u32 height;
+};
 
 enum signal_session_response {
 	SIGNAL_CMD_STOP_INPUT = 0,
@@ -23,4 +48,48 @@ enum signal_session_response {
 	MAX_SIGNAL,
 };
 
+enum iris_buffer_type {
+	BUF_NONE,
+	BUF_INPUT,
+	BUF_OUTPUT,
+	BUF_READ_ONLY,
+	BUF_BIN,
+	BUF_ARP,
+	BUF_COMV,
+	BUF_NON_COMV,
+	BUF_LINE,
+	BUF_DPB,
+	BUF_PERSIST,
+	BUF_VPSS,
+};
+
+enum iris_buffer_attributes {
+	BUF_ATTR_DEFERRED		= BIT(0),
+	BUF_ATTR_READ_ONLY		= BIT(1),
+	BUF_ATTR_PENDING_RELEASE	= BIT(2),
+	BUF_ATTR_QUEUED			= BIT(3),
+	BUF_ATTR_DEQUEUED		= BIT(4),
+	BUF_ATTR_BUFFER_DONE		= BIT(5),
+};
+
+struct iris_buffer {
+	struct list_head		list;
+	struct iris_inst		*inst;
+	enum iris_buffer_type		type;
+	u32				index;
+	int				fd;
+	u32				buffer_size;
+	u32				data_offset;
+	u32				data_size;
+	u64				device_addr;
+	void				*kvaddr;
+	unsigned long			dma_attrs;
+	u32				flags;
+	u64				timestamp;
+	enum iris_buffer_attributes	attr;
+	void				*dmabuf;
+	struct sg_table			*sg_table;
+	struct dma_buf_attachment	*attach;
+};
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 8d8bc3a..54a7851 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -42,6 +42,30 @@ u32 get_port_info(struct iris_inst *inst,
 	return HFI_PORT_NONE;
 }
 
+enum iris_buffer_type v4l2_type_to_driver(u32 type)
+{
+	switch (type) {
+	case INPUT_MPLANE:
+		return BUF_INPUT;
+	case OUTPUT_MPLANE:
+		return BUF_OUTPUT;
+	default:
+		return 0;
+	}
+}
+
+int get_mbpf(struct iris_inst *inst)
+{
+	int height = 0, width = 0;
+	struct v4l2_format *inp_f;
+
+	inp_f = inst->fmt_src;
+	width = max(inp_f->fmt.pix_mp.width, inst->crop.width);
+	height = max(inp_f->fmt.pix_mp.height, inst->crop.height);
+
+	return NUM_MBS_PER_FRAME(height, width);
+}
+
 static int process_inst_timeout(struct iris_inst *inst)
 {
 	struct iris_inst *instance;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 60c79124..3bae969 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -11,6 +11,7 @@
 
 #include "iris_core.h"
 #include "iris_instance.h"
+#include "iris_buffer.h"
 #include "platform_common.h"
 
 #define NUM_MBS_PER_FRAME(__height, __width) \
@@ -21,7 +22,8 @@ bool res_is_less_than(u32 width, u32 height,
 		      u32 ref_width, u32 ref_height);
 u32 get_port_info(struct iris_inst *inst,
 		  enum plat_inst_cap_type cap_id);
-
+enum iris_buffer_type v4l2_type_to_driver(u32 type);
+int get_mbpf(struct iris_inst *inst);
 int close_session(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index f6a3066..a5c6cb48 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -8,6 +8,8 @@
 
 #include <media/v4l2-ctrls.h>
 
+#include "iris_buffer.h"
+#include "iris_common.h"
 #include "iris_core.h"
 #include "iris_common.h"
 #include "platform_common.h"
@@ -25,6 +27,7 @@
  * @fmt_src: structure of v4l2_format for source
  * @fmt_dst: structure of v4l2_format for destination
  * @ctrl_handler: reference of v4l2 ctrl handler
+ * @crop: structure of crop info
  * @packet: HFI packet
  * @packet_size: HFI packet size
  * @completions: structure of signal completions
@@ -32,6 +35,7 @@
  * @num_ctrls: supported number of controls
  * @caps_list: list head of capability
  * @codec: codec type
+ * @buffers: structure of buffer info
  */
 
 struct iris_inst {
@@ -45,6 +49,7 @@ struct iris_inst {
 	struct v4l2_format		*fmt_src;
 	struct v4l2_format		*fmt_dst;
 	struct v4l2_ctrl_handler	ctrl_handler;
+	struct rect_desc		crop;
 	void				*packet;
 	u32				packet_size;
 	struct completion		completions[MAX_SIGNAL];
@@ -52,6 +57,7 @@ struct iris_inst {
 	u32				num_ctrls;
 	struct list_head		caps_list;
 	enum codec_type			codec;
+	struct iris_buffers_info	buffers;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
new file mode 100644
index 0000000..b040d27
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_buffer.h"
+#include "iris_core.h"
+#include "iris_helpers.h"
+#include "iris_instance.h"
+#include "iris_vb2.h"
+
+int iris_vb2_queue_setup(struct vb2_queue *q,
+			 unsigned int *num_buffers, unsigned int *num_planes,
+			 unsigned int sizes[], struct device *alloc_devs[])
+{
+	enum iris_buffer_type buffer_type = 0;
+	struct iris_buffers *buffers;
+	struct iris_inst *inst;
+	struct iris_core *core;
+	struct v4l2_format *f;
+	int ret;
+
+	if (!q || !num_buffers || !num_planes || !sizes)
+		return -EINVAL;
+
+	inst = vb2_get_drv_priv(q);
+	if (!inst || !inst->core)
+		return -EINVAL;
+
+	core = inst->core;
+
+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		f = inst->fmt_src;
+	else
+		f = inst->fmt_dst;
+
+	if (*num_planes) {
+		if (*num_planes != f->fmt.pix_mp.num_planes ||
+		    sizes[0] < f->fmt.pix_mp.plane_fmt[0].sizeimage)
+			return -EINVAL;
+	}
+
+	buffer_type = v4l2_type_to_driver(q->type);
+	if (!buffer_type)
+		return -EINVAL;
+
+	ret = iris_free_buffers(inst, buffer_type);
+	if (ret)
+		return ret;
+
+	buffers = iris_get_buffer_list(inst, buffer_type);
+	if (!buffers)
+		return -EINVAL;
+
+	buffers->min_count = iris_get_buf_min_count(inst, buffer_type);
+	if (*num_buffers < buffers->min_count)
+		*num_buffers = buffers->min_count;
+	buffers->actual_count = *num_buffers;
+	*num_planes = 1;
+
+	buffers->size = iris_get_buffer_size(inst, buffer_type);
+
+	f->fmt.pix_mp.plane_fmt[0].sizeimage = buffers->size;
+	sizes[0] = f->fmt.pix_mp.plane_fmt[0].sizeimage;
+
+	ret = iris_allocate_buffers(inst, buffer_type, *num_buffers);
+
+	q->dev = core->dev;
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
new file mode 100644
index 0000000..8a8e1039
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_VB2_H_
+#define _IRIS_VB2_H_
+
+#include <media/videobuf2-v4l2.h>
+
+int iris_vb2_queue_setup(struct vb2_queue *q,
+			 unsigned int *num_buffers, unsigned int *num_planes,
+			 unsigned int sizes[], struct device *alloc_devs[]);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 984be34..1b957a13 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include "iris_buffer.h"
 #include "iris_common.h"
 #include "iris_vdec.h"
 
@@ -22,7 +23,7 @@ void vdec_inst_init(struct iris_inst *inst)
 	f->fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
 	f->fmt.pix_mp.num_planes = 1;
 	f->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
-	f->fmt.pix_mp.plane_fmt[0].sizeimage = DEFAULT_BUF_SIZE;
+	f->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_INPUT);
 	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
 
 	f = inst->fmt_dst;
@@ -32,7 +33,7 @@ void vdec_inst_init(struct iris_inst *inst)
 	f->fmt.pix_mp.height = ALIGN(DEFAULT_HEIGHT, 32);
 	f->fmt.pix_mp.num_planes = 1;
 	f->fmt.pix_mp.plane_fmt[0].bytesperline = ALIGN(DEFAULT_WIDTH, 128);
-	f->fmt.pix_mp.plane_fmt[0].sizeimage = DEFAULT_BUF_SIZE;
+	f->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
 	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
 	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
 	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 3a26edb..410de720 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -10,6 +10,7 @@
 #include "iris_vdec.h"
 #include "iris_vidc.h"
 #include "iris_ctrls.h"
+#include "iris_vb2.h"
 
 static int vidc_v4l2_fh_init(struct iris_inst *inst)
 {
@@ -168,13 +169,22 @@ int vidc_open(struct file *filp)
 	inst->core = core;
 	inst->session_id = hash32_ptr(inst);
 	mutex_init(&inst->ctx_q_lock);
-	for (i = 0; i < MAX_SIGNAL; i++)
-		init_completion(&inst->completions[i]);
 
 	ret = vidc_add_session(inst);
 	if (ret)
 		goto fail_free_inst;
 
+	INIT_LIST_HEAD(&inst->buffers.input.list);
+	INIT_LIST_HEAD(&inst->buffers.output.list);
+	INIT_LIST_HEAD(&inst->buffers.read_only.list);
+	INIT_LIST_HEAD(&inst->buffers.bin.list);
+	INIT_LIST_HEAD(&inst->buffers.arp.list);
+	INIT_LIST_HEAD(&inst->buffers.comv.list);
+	INIT_LIST_HEAD(&inst->buffers.non_comv.list);
+	INIT_LIST_HEAD(&inst->buffers.line.list);
+	INIT_LIST_HEAD(&inst->buffers.dpb.list);
+	INIT_LIST_HEAD(&inst->buffers.persist.list);
+	INIT_LIST_HEAD(&inst->buffers.vpss.list);
 	INIT_LIST_HEAD(&inst->caps_list);
 	for (i = 0; i < MAX_SIGNAL; i++)
 		init_completion(&inst->completions[i]);
@@ -306,9 +316,14 @@ static const struct v4l2_file_operations v4l2_file_ops = {
 	.poll                           = vidc_poll,
 };
 
+static const struct vb2_ops iris_vb2_ops = {
+	.queue_setup                    = iris_vb2_queue_setup,
+};
+
 int init_ops(struct iris_core *core)
 {
 	core->v4l2_file_ops = &v4l2_file_ops;
+	core->vb2_ops = &iris_vb2_ops;
 
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index 8305c65..e242614 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -9,6 +9,8 @@
 #include <linux/bits.h>
 #include <media/v4l2-ctrls.h>
 
+#include "iris_common.h"
+
 struct iris_core;
 struct iris_inst;
 
@@ -35,20 +37,6 @@ struct iris_inst;
 	.bank_spreading = bsp,                           \
 }
 
-enum codec_type {
-	H264	= BIT(0),
-	HEVC	= BIT(1),
-	VP9	= BIT(2),
-};
-
-enum colorformat_type {
-	FMT_NONE	= 0,
-	FMT_NV12C	= BIT(0),
-	FMT_NV12	= BIT(1),
-	FMT_NV21	= BIT(2),
-	FMT_TP10C	= BIT(3),
-};
-
 enum stage_type {
 	STAGE_NONE = 0,
 	STAGE_1 = 1,
-- 
2.7.4


