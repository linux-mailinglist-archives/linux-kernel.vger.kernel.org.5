Return-Path: <linux-kernel+bounces-3487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23000816CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADC6283992
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8948A446BA;
	Mon, 18 Dec 2023 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QKcqsOTS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151E37D1F;
	Mon, 18 Dec 2023 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAtqox020050;
	Mon, 18 Dec 2023 11:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=5yHKjL9hcT4dzps/o4iYETybsLwHUpVhtq32vBP6USo=; b=QK
	cqsOTSZ302Uky6Q5w1SmfPJfkJzE2+mMlsaYcxYo7BvJOj3Gh4YeX4OknVJ/Zk38
	suoDJn2ygSeMAkOMWIsrXl1+a46yemSlJNzbdvib9Y+YB+SuTbY3tFpdh8ygzN/g
	oFJsuncQe15vMxbdkUF63nzRAlb2r1WOBqWNs8QDIk8AN5A7uN/8hb9sQ/yC0OGb
	k6xqZFHJiDsSEX2+oeq6F4vexQpH8c/fn2Ig0BOYCl0p9kPsVrayN8liq4y4Hd/2
	/nbV2KvNXUzaO0DyVd68F6sr47n2uuiowOZkRhsfMW/cZl1WA2kuCwKX2T6rf53A
	x17FdPdxsRk50+I8bmlA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v156dm7qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:06 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5Ka029944;
	Mon, 18 Dec 2023 11:40:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00af-5;
	Mon, 18 Dec 2023 11:40:03 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7Xd029998;
	Mon, 18 Dec 2023 11:36:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX62Z029968;
	Mon, 18 Dec 2023 11:36:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 583722342; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 23/34] media: iris: implement iris v4l2 ioctl ops supported by decoder
Date: Mon, 18 Dec 2023 17:02:18 +0530
Message-Id: <1702899149-21321-24-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zph83nyaocpHd_tKYFiHWcRy7M7ufymH
X-Proofpoint-GUID: Zph83nyaocpHd_tKYFiHWcRy7M7ufymH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Implement all iris v4l2 ioctls ops supported by decoder.
Add state checks to ensure ioctl are allowed in valid
instance state only. Codec format can be changed by client
during s_fmt. Update the v4l2 control values according
to the updated codec format.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/iris_buffer.c  |  23 +
 .../media/platform/qcom/vcodec/iris/iris_buffer.h  |   1 +
 .../media/platform/qcom/vcodec/iris/iris_common.h  |   2 +
 .../media/platform/qcom/vcodec/iris/iris_ctrls.c   |  48 +-
 .../media/platform/qcom/vcodec/iris/iris_ctrls.h   |   6 +-
 .../media/platform/qcom/vcodec/iris/iris_helpers.c | 212 +++++++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   8 +
 .../platform/qcom/vcodec/iris/iris_instance.h      |   4 +
 .../media/platform/qcom/vcodec/iris/iris_state.c   |  38 ++
 .../media/platform/qcom/vcodec/iris/iris_state.h   |   6 +
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  17 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 281 ++++++++-
 .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   6 +-
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    | 632 ++++++++++++++++++++-
 .../platform/qcom/vcodec/iris/platform_common.h    |  18 +
 .../platform/qcom/vcodec/iris/platform_sm8550.c    |  42 ++
 16 files changed, 1323 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
index 2a3989c..1ee840e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
@@ -55,6 +55,29 @@ static int output_min_count(struct iris_inst *inst)
 	return output_min_count;
 }
 
+int update_buffer_count(struct iris_inst *inst, u32 plane)
+{
+	switch (plane) {
+	case INPUT_MPLANE:
+		inst->buffers.input.min_count = input_min_count(inst);
+		if (inst->buffers.input.actual_count < inst->buffers.input.min_count)
+			inst->buffers.input.actual_count = inst->buffers.input.min_count;
+
+		break;
+	case OUTPUT_MPLANE:
+		if (!inst->vb2q_src->streaming)
+			inst->buffers.output.min_count = output_min_count(inst);
+		if (inst->buffers.output.actual_count < inst->buffers.output.min_count)
+			inst->buffers.output.actual_count = inst->buffers.output.min_count;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static u32 internal_buffer_count(struct iris_inst *inst,
 				 enum iris_buffer_type buffer_type)
 {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
index ece894e..bdef15f 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
@@ -34,6 +34,7 @@ struct iris_buffers_info {
 	struct iris_buffers	vpss;
 };
 
+int update_buffer_count(struct iris_inst *inst, u32 plane);
 int iris_get_buf_min_count(struct iris_inst *inst,
 			   enum iris_buffer_type buffer_type);
 int iris_get_buffer_size(struct iris_inst *inst,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index a83d1c1..6b771f8 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -17,6 +17,8 @@
 #define DEFAULT_HEIGHT 240
 #define DEFAULT_BSE_VPP_DELAY    2
 
+#define MAX_EVENTS   30
+
 #define MB_IN_PIXEL (16 * 16)
 
 #define NUM_MBS_4k (((4096 + 15) >> 4) * ((2304 + 15) >> 4))
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
index 6b7aeaa..28977e8 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
@@ -209,15 +209,15 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	struct iris_inst *inst = NULL;
 	int ret = 0;
 
+	inst = container_of(ctrl->handler, struct iris_inst, ctrl_handler);
 	switch (ctrl->id) {
 	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
-		ctrl->val = MIN_CAPTURE_BUFFERS;
+		ctrl->val = inst->buffers.output.min_count;
 		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
-		ctrl->val = MIN_OUTPUT_BUFFERS;
+		ctrl->val = inst->buffers.input.min_count;
 		break;
 	default:
-		inst = container_of(ctrl->handler, struct iris_inst, ctrl_handler);
 		cap_id = get_cap_id(inst, ctrl->id);
 		if (is_valid_cap_id(cap_id))
 			ctrl->val = inst->cap[cap_id].value;
@@ -232,12 +232,17 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct cap_entry *entry = NULL, *temp = NULL;
 	struct list_head children_list, firmware_list;
+	struct ctrl_data *priv_ctrl_data;
 	enum plat_inst_cap_type cap_id;
 	bool cap_present[INST_CAP_MAX];
 	struct plat_inst_cap *cap;
 	struct iris_inst *inst;
 	int ret = 0;
 
+	priv_ctrl_data = ctrl->priv ? ctrl->priv : NULL;
+	if (priv_ctrl_data && priv_ctrl_data->skip_s_ctrl)
+		return 0;
+
 	inst = container_of(ctrl->handler, struct iris_inst, ctrl_handler);
 	cap = &inst->cap[0];
 
@@ -249,6 +254,9 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	if (!is_valid_cap_id(cap_id))
 		return -EINVAL;
 
+	if (!allow_s_ctrl(inst, cap_id))
+		return -EBUSY;
+
 	cap[cap_id].flags |= CAP_FLAG_CLIENT_SET;
 
 	if (!inst->vb2q_src->streaming) {
@@ -282,11 +290,12 @@ static const struct v4l2_ctrl_ops ctrl_ops = {
 	.g_volatile_ctrl = vdec_op_g_volatile_ctrl,
 };
 
-int ctrls_init(struct iris_inst *inst)
+int ctrls_init(struct iris_inst *inst, bool init)
 {
 	int num_ctrls = 0, ctrl_idx = 0;
 	struct plat_inst_cap *cap;
 	struct iris_core *core;
+	u64 step_or_mask;
 	int idx = 0;
 	int ret = 0;
 
@@ -300,10 +309,12 @@ int ctrls_init(struct iris_inst *inst)
 	if (!num_ctrls)
 		return -EINVAL;
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler,
-				     INST_CAP_MAX * core->dec_codecs_count);
-	if (ret)
-		return ret;
+	if (init) {
+		ret = v4l2_ctrl_handler_init(&inst->ctrl_handler,
+					     INST_CAP_MAX * core->dec_codecs_count);
+		if (ret)
+			return ret;
+	}
 
 	for (idx = 0; idx < INST_CAP_MAX; idx++) {
 		struct v4l2_ctrl *ctrl;
@@ -316,6 +327,27 @@ int ctrls_init(struct iris_inst *inst)
 			goto error;
 		}
 
+		if (!init) {
+			struct ctrl_data ctrl_priv_data;
+
+			ctrl = v4l2_ctrl_find(&inst->ctrl_handler, cap[idx].v4l2_id);
+			if (ctrl) {
+				step_or_mask = (cap[idx].flags & CAP_FLAG_MENU) ?
+					~(cap[idx].step_or_mask) :
+					cap[idx].step_or_mask;
+				memset(&ctrl_priv_data, 0, sizeof(ctrl_priv_data));
+				ctrl_priv_data.skip_s_ctrl = true;
+				ctrl->priv = &ctrl_priv_data;
+				v4l2_ctrl_modify_range(ctrl,
+						       cap[idx].min,
+						       cap[idx].max,
+						       step_or_mask,
+						       cap[idx].value);
+				ctrl->priv = NULL;
+				continue;
+			}
+		}
+
 		if (cap[idx].flags & CAP_FLAG_MENU) {
 			ctrl = v4l2_ctrl_new_std_menu(&inst->ctrl_handler,
 						      &ctrl_ops,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
index 0f67f4f..22ee6c4b 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
@@ -13,6 +13,10 @@ struct cap_entry {
 	enum plat_inst_cap_type cap_id;
 };
 
+struct ctrl_data {
+	bool skip_s_ctrl;
+};
+
 int set_u32_enum(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
 int set_stage(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
 int set_pipe(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
@@ -25,6 +29,6 @@ int iris_init_instance_caps(struct iris_core *core);
 int iris_init_core_caps(struct iris_core *core);
 int get_inst_capability(struct iris_inst *inst);
 int adjust_v4l2_properties(struct iris_inst *inst);
-int ctrls_init(struct iris_inst *inst);
+int ctrls_init(struct iris_inst *inst, bool init);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 335885f..ff44cda 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -79,6 +79,112 @@ bool is_split_mode_enabled(struct iris_inst *inst)
 	return false;
 }
 
+inline bool is_10bit_colorformat(enum colorformat_type colorformat)
+{
+	return colorformat == FMT_TP10C;
+}
+
+inline bool is_8bit_colorformat(enum colorformat_type colorformat)
+{
+	return colorformat == FMT_NV12 ||
+		colorformat == FMT_NV12C ||
+		colorformat == FMT_NV21;
+}
+
+u32 v4l2_codec_from_driver(struct iris_inst *inst, enum codec_type codec)
+{
+	const struct codec_info *codec_info;
+	struct iris_core *core;
+	u32 v4l2_codec = 0;
+	u32 i, size;
+
+	core = inst->core;
+	codec_info = core->platform_data->format_data->codec_info;
+	size = core->platform_data->format_data->codec_info_size;
+
+	for (i = 0; i < size; i++) {
+		if (codec_info[i].codec == codec)
+			return codec_info[i].v4l2_codec;
+	}
+
+	return v4l2_codec;
+}
+
+enum codec_type v4l2_codec_to_driver(struct iris_inst *inst, u32 v4l2_codec)
+{
+	const struct codec_info *codec_info;
+	enum codec_type codec = 0;
+	struct iris_core *core;
+	u32 i, size;
+
+	core = inst->core;
+	codec_info = core->platform_data->format_data->codec_info;
+	size = core->platform_data->format_data->codec_info_size;
+
+	for (i = 0; i < size; i++) {
+		if (codec_info[i].v4l2_codec == v4l2_codec)
+			return codec_info[i].codec;
+	}
+
+	return codec;
+}
+
+u32 v4l2_colorformat_from_driver(struct iris_inst *inst, enum colorformat_type colorformat)
+{
+	const struct color_format_info *color_format_info;
+	u32 v4l2_colorformat = 0;
+	struct iris_core *core;
+	u32 i, size;
+
+	core = inst->core;
+	color_format_info = core->platform_data->format_data->color_format_info;
+	size = core->platform_data->format_data->color_format_info_size;
+
+	for (i = 0; i < size; i++) {
+		if (color_format_info[i].color_format == colorformat)
+			return color_format_info[i].v4l2_color_format;
+	}
+
+	return v4l2_colorformat;
+}
+
+enum colorformat_type v4l2_colorformat_to_driver(struct iris_inst *inst, u32 v4l2_colorformat)
+{
+	const struct color_format_info *color_format_info;
+	enum colorformat_type colorformat = 0;
+	struct iris_core *core;
+	u32 i, size;
+
+	core = inst->core;
+	color_format_info = core->platform_data->format_data->color_format_info;
+	size = core->platform_data->format_data->color_format_info_size;
+
+	for (i = 0; i < size; i++) {
+		if (color_format_info[i].v4l2_color_format == v4l2_colorformat)
+			return color_format_info[i].color_format;
+	}
+
+	return colorformat;
+}
+
+struct vb2_queue *get_vb2q(struct iris_inst *inst, u32 type)
+{
+	struct vb2_queue *vb2q = NULL;
+
+	switch (type) {
+	case INPUT_MPLANE:
+		vb2q = inst->vb2q_src;
+		break;
+	case OUTPUT_MPLANE:
+		vb2q = inst->vb2q_dst;
+		break;
+	default:
+		return NULL;
+	}
+
+	return vb2q;
+}
+
 static int process_inst_timeout(struct iris_inst *inst)
 {
 	struct iris_inst *instance;
@@ -128,13 +234,119 @@ int close_session(struct iris_inst *inst)
 	inst->packet = NULL;
 
 	if (wait_for_response) {
+		mutex_unlock(&inst->lock);
 		ret = wait_for_completion_timeout(&inst->completions[SIGNAL_CMD_CLOSE],
 						  msecs_to_jiffies(hw_response_timeout_val));
 		if (!ret) {
 			ret = -ETIMEDOUT;
 			process_inst_timeout(inst);
 		}
+		mutex_lock(&inst->lock);
 	}
 
 	return ret;
 }
+
+static int check_core_mbps_mbpf(struct iris_inst *inst)
+{
+	u32 mbpf = 0, mbps = 0, total_mbpf = 0, total_mbps = 0;
+	struct iris_core *core;
+	struct iris_inst *instance;
+	u32 fps;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+	list_for_each_entry(instance, &core->instances, list) {
+		fps = inst->cap[QUEUED_RATE].value >> 16;
+		mbpf = get_mbpf(inst);
+		mbps = mbpf * fps;
+		total_mbpf += mbpf;
+		total_mbps += mbps;
+	}
+	mutex_unlock(&core->lock);
+
+	if (total_mbps > core->cap[MAX_MBPS].value ||
+	    total_mbpf > core->cap[MAX_MBPF].value)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int check_inst_mbpf(struct iris_inst *inst)
+{
+	u32 mbpf = 0, max_mbpf = 0;
+
+	max_mbpf = inst->cap[MBPF].max;
+	mbpf = get_mbpf(inst);
+	if (mbpf > max_mbpf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int check_resolution_supported(struct iris_inst *inst)
+{
+	u32 width = 0, height = 0, min_width, min_height,
+		max_width, max_height;
+
+	width = inst->fmt_src->fmt.pix_mp.width;
+	height = inst->fmt_src->fmt.pix_mp.height;
+
+	min_width = inst->cap[FRAME_WIDTH].min;
+	max_width = inst->cap[FRAME_WIDTH].max;
+	min_height = inst->cap[FRAME_HEIGHT].min;
+	max_height = inst->cap[FRAME_HEIGHT].max;
+
+	if (!(min_width <= width && width <= max_width) ||
+	    !(min_height <= height && height <= max_height))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int check_max_sessions(struct iris_inst *inst)
+{
+	struct iris_core *core;
+	u32 num_sessions = 0;
+	struct iris_inst *i;
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+	list_for_each_entry(i, &core->instances, list) {
+		num_sessions++;
+	}
+	mutex_unlock(&core->lock);
+
+	if (num_sessions > core->cap[MAX_SESSION_COUNT].value)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int check_session_supported(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = check_core_mbps_mbpf(inst);
+	if (ret)
+		goto exit;
+
+	ret = check_inst_mbpf(inst);
+	if (ret)
+		goto exit;
+
+	ret = check_resolution_supported(inst);
+	if (ret)
+		goto exit;
+
+	ret = check_max_sessions(inst);
+	if (ret)
+		goto exit;
+
+	return ret;
+exit:
+	dev_err(inst->core->dev, "current session not supported(%d)\n", ret);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 9e85510..fe85d23 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -28,6 +28,14 @@ int get_mbpf(struct iris_inst *inst);
 int close_session(struct iris_inst *inst);
 
 bool is_linear_colorformat(u32 colorformat);
+bool is_10bit_colorformat(enum colorformat_type colorformat);
+bool is_8bit_colorformat(enum colorformat_type colorformat);
 bool is_split_mode_enabled(struct iris_inst *inst);
+u32 v4l2_codec_from_driver(struct iris_inst *inst, enum codec_type codec);
+enum codec_type v4l2_codec_to_driver(struct iris_inst *inst, u32 v4l2_codec);
+u32 v4l2_colorformat_from_driver(struct iris_inst *inst, enum colorformat_type colorformat);
+enum colorformat_type v4l2_colorformat_to_driver(struct iris_inst *inst, u32 v4l2_colorformat);
+struct vb2_queue *get_vb2q(struct iris_inst *inst, u32 type);
+int check_session_supported(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 275efa8..365f844 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -23,6 +23,7 @@
  * @vb2q_src: source vb2 queue
  * @vb2q_dst: destination vb2 queue
  * @ctx_q_lock: lock to serialize queues related ioctls
+ * @lock: lock to seralise forward and reverse threads
  * @fh: reference of v4l2 file handler
  * @fmt_src: structure of v4l2_format for source
  * @fmt_dst: structure of v4l2_format for destination
@@ -38,6 +39,7 @@
  * @buffers: structure of buffer info
  * @fw_min_count: minimnum count of buffers needed by fw
  * @state: instance state
+ * @ipsc_properties_set: boolean to set ipsc properties to fw
  */
 
 struct iris_inst {
@@ -47,6 +49,7 @@ struct iris_inst {
 	struct vb2_queue		*vb2q_src;
 	struct vb2_queue		*vb2q_dst;
 	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
+	struct mutex			lock;
 	struct v4l2_fh			fh;
 	struct v4l2_format		*fmt_src;
 	struct v4l2_format		*fmt_dst;
@@ -62,6 +65,7 @@ struct iris_inst {
 	struct iris_buffers_info	buffers;
 	u32				fw_min_count;
 	enum iris_inst_state		state;
+	bool				ipsc_properties_set;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
index 9bf79a0..4cf6b69 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -155,3 +155,41 @@ int iris_inst_change_state(struct iris_inst *inst,
 
 	return 0;
 }
+
+bool allow_s_fmt(struct iris_inst *inst, u32 type)
+{
+	return (inst->state == IRIS_INST_OPEN) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_INPUT_STREAMING) ||
+		(type == INPUT_MPLANE && inst->state == IRIS_INST_OUTPUT_STREAMING);
+}
+
+bool allow_reqbufs(struct iris_inst *inst, u32 type)
+{
+	return (inst->state == IRIS_INST_OPEN) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_INPUT_STREAMING) ||
+		(type == INPUT_MPLANE && inst->state == IRIS_INST_OUTPUT_STREAMING);
+}
+
+bool allow_streamon(struct iris_inst *inst, u32 type)
+{
+	return (type == INPUT_MPLANE && inst->state == IRIS_INST_OPEN) ||
+		(type == INPUT_MPLANE && inst->state == IRIS_INST_OUTPUT_STREAMING) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_OPEN) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_INPUT_STREAMING);
+}
+
+bool allow_streamoff(struct iris_inst *inst, u32 type)
+{
+	return (type == INPUT_MPLANE && inst->state == IRIS_INST_INPUT_STREAMING) ||
+		(type == INPUT_MPLANE && inst->state == IRIS_INST_STREAMING) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_OUTPUT_STREAMING) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_STREAMING);
+}
+
+bool allow_s_ctrl(struct iris_inst *inst, u32 cap_id)
+{
+	return ((inst->state == IRIS_INST_OPEN) ||
+		((inst->cap[cap_id].flags & CAP_FLAG_DYNAMIC_ALLOWED) &&
+		(inst->state == IRIS_INST_INPUT_STREAMING ||
+		inst->state == IRIS_INST_STREAMING)));
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
index 6db95a1..35263e8 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
@@ -41,4 +41,10 @@ int iris_change_core_state(struct iris_core *core,
 int iris_inst_change_state(struct iris_inst *inst,
 			   enum iris_inst_state request_state);
 
+bool allow_s_fmt(struct iris_inst *inst, u32 type);
+bool allow_reqbufs(struct iris_inst *inst, u32 type);
+bool allow_streamon(struct iris_inst *inst, u32 type);
+bool allow_streamoff(struct iris_inst *inst, u32 type);
+bool allow_s_ctrl(struct iris_inst *inst, u32 cap_id);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
index 8f499a9..66b5295 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -4,6 +4,7 @@
  */
 
 #include "iris_buffer.h"
+#include "iris_ctrls.h"
 #include "iris_core.h"
 #include "iris_helpers.h"
 #include "iris_instance.h"
@@ -47,6 +48,22 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 	if (!buffer_type)
 		return -EINVAL;
 
+	if (list_empty(&inst->caps_list)) {
+		ret = prepare_dependency_list(inst);
+		if (ret)
+			return ret;
+	}
+
+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		ret = adjust_v4l2_properties(inst);
+		if (ret)
+			return ret;
+	}
+
+	ret = check_session_supported(inst);
+	if (ret)
+		return ret;
+
 	ret = iris_free_buffers(inst, buffer_type);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 566048e..64067d5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -3,13 +3,51 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <media/v4l2-event.h>
+
 #include "iris_buffer.h"
 #include "iris_common.h"
+#include "iris_ctrls.h"
+#include "iris_helpers.h"
 #include "iris_vdec.h"
 
-void vdec_inst_init(struct iris_inst *inst)
+static int vdec_codec_change(struct iris_inst *inst, u32 v4l2_codec)
+{
+	bool session_init = false;
+	int ret;
+
+	if (!inst->codec)
+		session_init = true;
+
+	if (inst->codec && inst->fmt_src->fmt.pix_mp.pixelformat == v4l2_codec)
+		return 0;
+
+	inst->codec = v4l2_codec_to_driver(inst, v4l2_codec);
+	if (!inst->codec)
+		return -EINVAL;
+
+	inst->fmt_src->fmt.pix_mp.pixelformat = v4l2_codec;
+	ret = get_inst_capability(inst);
+	if (ret)
+		return ret;
+
+	ret = ctrls_init(inst, session_init);
+	if (ret)
+		return ret;
+
+	ret = update_buffer_count(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = update_buffer_count(inst, OUTPUT_MPLANE);
+
+	return ret;
+}
+
+int vdec_inst_init(struct iris_inst *inst)
 {
 	struct v4l2_format *f;
+	int ret;
 
 	inst->fmt_src  = kzalloc(sizeof(*inst->fmt_src), GFP_KERNEL);
 	inst->fmt_dst  = kzalloc(sizeof(*inst->fmt_dst), GFP_KERNEL);
@@ -43,6 +81,10 @@ void vdec_inst_init(struct iris_inst *inst)
 	inst->buffers.output.actual_count = inst->buffers.output.min_count;
 	inst->buffers.output.size = f->fmt.pix_mp.plane_fmt[0].sizeimage;
 	inst->fw_min_count = 0;
+
+	ret = vdec_codec_change(inst, inst->fmt_src->fmt.pix_mp.pixelformat);
+
+	return ret;
 }
 
 void vdec_inst_deinit(struct iris_inst *inst)
@@ -50,3 +92,240 @@ void vdec_inst_deinit(struct iris_inst *inst)
 	kfree(inst->fmt_dst);
 	kfree(inst->fmt_src);
 }
+
+static int vdec_check_colorformat_supported(struct iris_inst *inst,
+					    enum colorformat_type colorformat)
+{
+	bool supported = true;
+
+	if (!inst->vb2q_src->streaming)
+		return true;
+
+	if (inst->cap[BIT_DEPTH].value == BIT_DEPTH_8 &&
+	    !is_8bit_colorformat(colorformat))
+		supported = false;
+	if (inst->cap[BIT_DEPTH].value == BIT_DEPTH_10 &&
+	    !is_10bit_colorformat(colorformat))
+		supported = false;
+	if (inst->cap[CODED_FRAMES].value == CODED_FRAMES_INTERLACE)
+		supported = false;
+
+	return supported;
+}
+
+int vdec_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f)
+{
+	struct iris_core *core;
+	u32 array[32] = {0};
+	u32 i = 0;
+
+	if (f->index >= ARRAY_SIZE(array))
+		return -EINVAL;
+
+	core = inst->core;
+	if (f->type == INPUT_MPLANE) {
+		u32 codecs = core->cap[DEC_CODECS].value;
+		u32 codecs_count = hweight32(codecs);
+		u32 idx = 0;
+
+		for (i = 0; i <= codecs_count; i++) {
+			if (codecs & BIT(i)) {
+				if (idx >= ARRAY_SIZE(array))
+					break;
+				array[idx] = codecs & BIT(i);
+				idx++;
+			}
+		}
+		if (!array[f->index])
+			return -EINVAL;
+		f->pixelformat = v4l2_codec_from_driver(inst, array[f->index]);
+		f->flags = V4L2_FMT_FLAG_COMPRESSED;
+		strscpy(f->description, "codec", sizeof(f->description));
+	} else if (f->type == OUTPUT_MPLANE) {
+		u32 formats = inst->cap[PIX_FMTS].step_or_mask;
+		u32 idx = 0;
+
+		for (i = 0; i <= 31; i++) {
+			if (formats & BIT(i)) {
+				if (idx >= ARRAY_SIZE(array))
+					break;
+				if (vdec_check_colorformat_supported(inst, formats & BIT(i))) {
+					array[idx] = formats & BIT(i);
+					idx++;
+				}
+			}
+		}
+		if (!array[f->index])
+			return -EINVAL;
+		f->pixelformat = v4l2_colorformat_from_driver(inst, array[f->index]);
+		strscpy(f->description, "colorformat", sizeof(f->description));
+	}
+
+	if (!f->pixelformat)
+		return -EINVAL;
+
+	memset(f->reserved, 0, sizeof(f->reserved));
+
+	return 0;
+}
+
+int vdec_try_fmt(struct iris_inst *inst, struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	struct v4l2_format *f_inst;
+	u32 pix_fmt;
+
+	memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
+	if (f->type == INPUT_MPLANE) {
+		pix_fmt = v4l2_codec_to_driver(inst, f->fmt.pix_mp.pixelformat);
+		if (!pix_fmt) {
+			f_inst = inst->fmt_src;
+			f->fmt.pix_mp.width = f_inst->fmt.pix_mp.width;
+			f->fmt.pix_mp.height = f_inst->fmt.pix_mp.height;
+			f->fmt.pix_mp.pixelformat = f_inst->fmt.pix_mp.pixelformat;
+			pix_fmt = v4l2_codec_to_driver(inst, f->fmt.pix_mp.pixelformat);
+		}
+	} else if (f->type == OUTPUT_MPLANE) {
+		pix_fmt = v4l2_colorformat_to_driver(inst, f->fmt.pix_mp.pixelformat);
+		if (!pix_fmt) {
+			f_inst = inst->fmt_dst;
+			f->fmt.pix_mp.pixelformat = f_inst->fmt.pix_mp.pixelformat;
+			f->fmt.pix_mp.width = f_inst->fmt.pix_mp.width;
+			f->fmt.pix_mp.height = f_inst->fmt.pix_mp.height;
+		}
+		if (inst->vb2q_src->streaming) {
+			f_inst = inst->fmt_src;
+			f->fmt.pix_mp.height = f_inst->fmt.pix_mp.height;
+			f->fmt.pix_mp.width = f_inst->fmt.pix_mp.width;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	if (pixmp->field == V4L2_FIELD_ANY)
+		pixmp->field = V4L2_FIELD_NONE;
+
+	pixmp->num_planes = 1;
+
+	return 0;
+}
+
+int vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f)
+{
+	struct v4l2_format *fmt, *output_fmt;
+	enum colorformat_type colorformat;
+	u32 codec_align, stride = 0;
+	int ret = 0;
+
+	vdec_try_fmt(inst, f);
+
+	if (f->type == INPUT_MPLANE) {
+		if (inst->fmt_src->fmt.pix_mp.pixelformat !=
+			f->fmt.pix_mp.pixelformat) {
+			ret = vdec_codec_change(inst, f->fmt.pix_mp.pixelformat);
+			if (ret)
+				return ret;
+		}
+
+		fmt = inst->fmt_src;
+		fmt->type = INPUT_MPLANE;
+
+		codec_align = inst->fmt_src->fmt.pix_mp.pixelformat ==
+			V4L2_PIX_FMT_HEVC ? 32 : 16;
+		fmt->fmt.pix_mp.width = ALIGN(f->fmt.pix_mp.width, codec_align);
+		fmt->fmt.pix_mp.height = ALIGN(f->fmt.pix_mp.height, codec_align);
+		fmt->fmt.pix_mp.num_planes = 1;
+		fmt->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
+		fmt->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_INPUT);
+		inst->buffers.input.min_count = iris_get_buf_min_count(inst, BUF_INPUT);
+		if (inst->buffers.input.actual_count <
+			inst->buffers.input.min_count) {
+			inst->buffers.input.actual_count =
+				inst->buffers.input.min_count;
+		}
+		inst->buffers.input.size =
+			fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
+
+		fmt->fmt.pix_mp.colorspace = f->fmt.pix_mp.colorspace;
+		fmt->fmt.pix_mp.xfer_func = f->fmt.pix_mp.xfer_func;
+		fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
+		fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
+
+		output_fmt = inst->fmt_dst;
+		output_fmt->fmt.pix_mp.colorspace = f->fmt.pix_mp.colorspace;
+		output_fmt->fmt.pix_mp.xfer_func = f->fmt.pix_mp.xfer_func;
+		output_fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
+		output_fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
+
+		inst->crop.left = 0;
+		inst->crop.top = 0;
+		inst->crop.width = f->fmt.pix_mp.width;
+		inst->crop.height = f->fmt.pix_mp.height;
+	} else if (f->type == OUTPUT_MPLANE) {
+		fmt = inst->fmt_dst;
+		fmt->type = OUTPUT_MPLANE;
+		if (inst->vb2q_src->streaming) {
+			f->fmt.pix_mp.height = inst->fmt_src->fmt.pix_mp.height;
+			f->fmt.pix_mp.width = inst->fmt_src->fmt.pix_mp.width;
+		}
+		fmt->fmt.pix_mp.pixelformat = f->fmt.pix_mp.pixelformat;
+		codec_align = f->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_QC10C ? 192 : 128;
+		fmt->fmt.pix_mp.width = ALIGN(f->fmt.pix_mp.width, codec_align);
+		codec_align = f->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_QC10C ? 16 : 32;
+		fmt->fmt.pix_mp.height = ALIGN(f->fmt.pix_mp.height, codec_align);
+		fmt->fmt.pix_mp.num_planes = 1;
+		if (f->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_QC10C) {
+			stride = ALIGN(f->fmt.pix_mp.width, 192);
+			fmt->fmt.pix_mp.plane_fmt[0].bytesperline = ALIGN(stride * 4 / 3, 256);
+		} else {
+			fmt->fmt.pix_mp.plane_fmt[0].bytesperline = ALIGN(f->fmt.pix_mp.width, 128);
+		}
+		fmt->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
+
+		if (!inst->vb2q_src->streaming)
+			inst->buffers.output.min_count = iris_get_buf_min_count(inst, BUF_OUTPUT);
+		if (inst->buffers.output.actual_count <
+			inst->buffers.output.min_count) {
+			inst->buffers.output.actual_count =
+				inst->buffers.output.min_count;
+		}
+
+		colorformat = v4l2_colorformat_to_driver(inst, fmt->fmt.pix_mp.pixelformat);
+		inst->buffers.output.size =
+			fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
+		inst->cap[PIX_FMTS].value = colorformat;
+
+		if (!inst->vb2q_src->streaming) {
+			inst->crop.top = 0;
+			inst->crop.left = 0;
+			inst->crop.width = f->fmt.pix_mp.width;
+			inst->crop.height = f->fmt.pix_mp.height;
+		}
+	} else {
+		return -EINVAL;
+	}
+	memcpy(f, fmt, sizeof(*fmt));
+
+	return ret;
+}
+
+int vdec_subscribe_event(struct iris_inst *inst, const struct v4l2_event_subscription *sub)
+{
+	int ret = 0;
+
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		ret = v4l2_event_subscribe(&inst->fh, sub, MAX_EVENTS, NULL);
+		break;
+	case V4L2_EVENT_SOURCE_CHANGE:
+		ret = v4l2_src_change_event_subscribe(&inst->fh, sub);
+		break;
+	case V4L2_EVENT_CTRL:
+		ret = v4l2_ctrl_subscribe_event(&inst->fh, sub);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
index dc8f43f..a2f159d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
@@ -8,7 +8,11 @@
 
 #include "iris_instance.h"
 
-void vdec_inst_init(struct iris_inst *inst);
+int vdec_inst_init(struct iris_inst *inst);
 void vdec_inst_deinit(struct iris_inst *inst);
+int vdec_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
+int vdec_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
+int vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
+int vdec_subscribe_event(struct iris_inst *inst, const struct v4l2_event_subscription *sub);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 68ba75f..5c76821 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -3,6 +3,11 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/videodev2.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+
+#include "iris_buffer.h"
 #include "iris_common.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
@@ -12,6 +17,9 @@
 #include "iris_ctrls.h"
 #include "iris_vb2.h"
 
+#define VIDC_DRV_NAME "iris_driver"
+#define VIDC_BUS_NAME "platform:iris_bus"
+
 static int vidc_v4l2_fh_init(struct iris_inst *inst)
 {
 	struct iris_core *core;
@@ -169,6 +177,7 @@ int vidc_open(struct file *filp)
 	inst->core = core;
 	inst->session_id = hash32_ptr(inst);
 	iris_inst_change_state(inst, IRIS_INST_OPEN);
+	mutex_init(&inst->lock);
 	mutex_init(&inst->ctx_q_lock);
 
 	ret = vidc_add_session(inst);
@@ -200,14 +209,6 @@ int vidc_open(struct file *filp)
 	if (ret)
 		goto fail_inst_deinit;
 
-	ret = get_inst_capability(inst);
-	if (ret)
-		goto fail_queue_deinit;
-
-	ret = ctrls_init(inst);
-	if (ret)
-		goto fail_queue_deinit;
-
 	ret = iris_hfi_session_open(inst);
 	if (ret) {
 		dev_err(core->dev, "%s: session open failed\n", __func__);
@@ -220,7 +221,6 @@ int vidc_open(struct file *filp)
 fail_core_deinit:
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	iris_core_deinit(core);
-fail_queue_deinit:
 	vidc_vb2_queue_deinit(inst);
 fail_inst_deinit:
 	vdec_inst_deinit(inst);
@@ -229,6 +229,7 @@ int vidc_open(struct file *filp)
 	vidc_remove_session(inst);
 fail_free_inst:
 	mutex_destroy(&inst->ctx_q_lock);
+	mutex_destroy(&inst->lock);
 	kfree(inst);
 
 	return ret;
@@ -244,14 +245,16 @@ int vidc_close(struct file *filp)
 
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	vdec_inst_deinit(inst);
+	mutex_lock(&inst->lock);
 	close_session(inst);
 	iris_inst_change_state(inst, IRIS_INST_CLOSE);
 	vidc_vb2_queue_deinit(inst);
 	vidc_v4l2_fh_deinit(inst);
 	vidc_remove_session(inst);
+	mutex_unlock(&inst->lock);
 	mutex_destroy(&inst->ctx_q_lock);
+	mutex_destroy(&inst->lock);
 	kfree(inst);
-
 	filp->private_data = NULL;
 
 	return 0;
@@ -313,6 +316,588 @@ static __poll_t vidc_poll(struct file *filp, struct poll_table_struct *pt)
 	return poll;
 }
 
+static int vidc_enum_fmt(struct file *filp, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct iris_inst *inst;
+	int ret;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = vdec_enum_fmt(inst, f);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_try_fmt(struct file *filp, void *fh, struct v4l2_format *f)
+{
+	struct iris_inst *inst;
+	int ret;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (!allow_s_fmt(inst, f->type)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = vdec_try_fmt(inst, f);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_s_fmt(struct file *filp, void *fh, struct v4l2_format *f)
+{
+	struct iris_inst *inst;
+	int ret;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (!allow_s_fmt(inst, f->type)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = vdec_s_fmt(inst, f);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_g_fmt(struct file *filp, void *fh, struct v4l2_format *f)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (f->type == INPUT_MPLANE)
+		memcpy(f, inst->fmt_src, sizeof(*f));
+	else if (f->type == OUTPUT_MPLANE)
+		memcpy(f, inst->fmt_dst, sizeof(*f));
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_enum_framesizes(struct file *filp, void *fh,
+				struct v4l2_frmsizeenum *fsize)
+{
+	enum colorformat_type colorfmt;
+	struct iris_inst *inst;
+	enum codec_type codec;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !fsize)
+		return -EINVAL;
+
+	if (fsize->index)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	codec = v4l2_codec_to_driver(inst, fsize->pixel_format);
+	if (!codec) {
+		colorfmt = v4l2_colorformat_to_driver(inst, fsize->pixel_format);
+		if (colorfmt == FMT_NONE) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	}
+
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise.min_width = inst->cap[FRAME_WIDTH].min;
+	fsize->stepwise.max_width = inst->cap[FRAME_WIDTH].max;
+	fsize->stepwise.step_width = inst->cap[FRAME_WIDTH].step_or_mask;
+	fsize->stepwise.min_height = inst->cap[FRAME_HEIGHT].min;
+	fsize->stepwise.max_height = inst->cap[FRAME_HEIGHT].max;
+	fsize->stepwise.step_height = inst->cap[FRAME_HEIGHT].step_or_mask;
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_reqbufs(struct file *filp, void *fh, struct v4l2_requestbuffers *b)
+{
+	struct vb2_queue *vb2q = NULL;
+	struct iris_inst *inst;
+	int ret;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !b)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (!allow_reqbufs(inst, b->type)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	vb2q = get_vb2q(inst, b->type);
+	if (!vb2q) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = vb2_reqbufs(vb2q, b);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_querybuf(struct file *filp, void *fh, struct v4l2_buffer *b)
+{
+	struct vb2_queue *vb2q = NULL;
+	struct iris_inst *inst;
+	int ret;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !b)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	vb2q = get_vb2q(inst, b->type);
+	if (!vb2q) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = vb2_querybuf(vb2q, b);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_create_bufs(struct file *filp, void *fh, struct v4l2_create_buffers *b)
+{
+	struct iris_inst *inst;
+	struct vb2_queue *vb2q;
+	struct v4l2_format *f;
+	int ret;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !b)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	f = &b->format;
+	vb2q = get_vb2q(inst, f->type);
+	if (!vb2q) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = vb2_create_bufs(vb2q, b);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_prepare_buf(struct file *filp, void *fh, struct v4l2_buffer *b)
+{
+	struct video_device *vdev;
+	struct iris_inst *inst;
+	struct vb2_queue *vb2q;
+	int ret;
+
+	inst = get_vidc_inst(filp, fh);
+	vdev = video_devdata(filp);
+	if (!inst || !vdev || !vdev->v4l2_dev->mdev)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	vb2q = get_vb2q(inst, b->type);
+	if (!vb2q) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = vb2_prepare_buf(vb2q, vdev->v4l2_dev->mdev, b);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_qbuf(struct file *filp, void *fh, struct v4l2_buffer *b)
+{
+	struct video_device *vdev;
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	vdev = video_devdata(filp);
+	if (!inst || !b)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (b->type == INPUT_MPLANE)
+		ret = vb2_qbuf(inst->vb2q_src, vdev->v4l2_dev->mdev, b);
+	else if (b->type == OUTPUT_MPLANE)
+		ret = vb2_qbuf(inst->vb2q_dst, vdev->v4l2_dev->mdev, b);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_dqbuf(struct file *filp, void *fh, struct v4l2_buffer *b)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !b)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (b->type == INPUT_MPLANE)
+		ret = vb2_dqbuf(inst->vb2q_src, b, true);
+	else if (b->type == OUTPUT_MPLANE)
+		ret = vb2_dqbuf(inst->vb2q_dst, b, true);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_streamon(struct file *filp, void *fh, enum v4l2_buf_type type)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!allow_streamon(inst, type)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (type == INPUT_MPLANE)
+		ret = vb2_streamon(inst->vb2q_src, type);
+	else if (type == OUTPUT_MPLANE)
+		ret = vb2_streamon(inst->vb2q_dst, type);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_streamoff(struct file *filp, void *fh, enum v4l2_buf_type type)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!allow_streamoff(inst, type)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (type == INPUT_MPLANE)
+		ret = vb2_streamoff(inst->vb2q_src, type);
+	else if (type == OUTPUT_MPLANE)
+		ret = vb2_streamoff(inst->vb2q_dst, type);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_querycap(struct file *filp, void *fh, struct v4l2_capability *cap)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	strscpy(cap->driver, VIDC_DRV_NAME, sizeof(cap->driver));
+	strscpy(cap->bus_info, VIDC_BUS_NAME, sizeof(cap->bus_info));
+	memset(cap->reserved, 0, sizeof(cap->reserved));
+	strscpy(cap->card, "iris_decoder", sizeof(cap->card));
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_queryctrl(struct file *filp, void *fh, struct v4l2_queryctrl *q_ctrl)
+{
+	struct v4l2_ctrl *ctrl;
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !q_ctrl)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ctrl = v4l2_ctrl_find(&inst->ctrl_handler, q_ctrl->id);
+	if (!ctrl) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	q_ctrl->minimum = ctrl->minimum;
+	q_ctrl->maximum = ctrl->maximum;
+	q_ctrl->default_value = ctrl->default_value;
+	q_ctrl->flags = 0;
+	q_ctrl->step = ctrl->step;
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_querymenu(struct file *filp, void *fh, struct v4l2_querymenu *qmenu)
+{
+	struct v4l2_ctrl *ctrl;
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !qmenu)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ctrl = v4l2_ctrl_find(&inst->ctrl_handler, qmenu->id);
+	if (!ctrl) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (ctrl->type != V4L2_CTRL_TYPE_MENU) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (qmenu->index < ctrl->minimum || qmenu->index > ctrl->maximum) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (ctrl->menu_skip_mask & (1 << qmenu->index)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
+{
+	struct iris_inst *inst;
+	int ret;
+
+	inst = container_of(fh, struct iris_inst, fh);
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = vdec_subscribe_event(inst, sub);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_unsubscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
+{
+	struct iris_inst *inst;
+	int ret;
+
+	inst = container_of(fh, struct iris_inst, fh);
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = v4l2_event_unsubscribe(&inst->fh, sub);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_g_selection(struct file *filp, void *fh, struct v4l2_selection *s)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !s)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (s->type != OUTPUT_MPLANE && s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP:
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+	case V4L2_SEL_TGT_COMPOSE_PADDED:
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+	case V4L2_SEL_TGT_COMPOSE:
+		s->r.left = inst->crop.left;
+		s->r.top = inst->crop.top;
+		s->r.width = inst->crop.width;
+		s->r.height = inst->crop.height;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
 static const struct v4l2_file_operations v4l2_file_ops = {
 	.owner                          = THIS_MODULE,
 	.open                           = vidc_open,
@@ -335,11 +920,38 @@ static struct vb2_mem_ops iris_vb2_mem_ops = {
 	.unmap_dmabuf                   = iris_vb2_unmap_dmabuf,
 };
 
+static const struct v4l2_ioctl_ops v4l2_ioctl_ops = {
+	.vidioc_enum_fmt_vid_cap        = vidc_enum_fmt,
+	.vidioc_enum_fmt_vid_out        = vidc_enum_fmt,
+	.vidioc_try_fmt_vid_cap_mplane  = vidc_try_fmt,
+	.vidioc_try_fmt_vid_out_mplane  = vidc_try_fmt,
+	.vidioc_s_fmt_vid_cap_mplane    = vidc_s_fmt,
+	.vidioc_s_fmt_vid_out_mplane    = vidc_s_fmt,
+	.vidioc_g_fmt_vid_cap_mplane    = vidc_g_fmt,
+	.vidioc_g_fmt_vid_out_mplane    = vidc_g_fmt,
+	.vidioc_enum_framesizes         = vidc_enum_framesizes,
+	.vidioc_reqbufs                 = vidc_reqbufs,
+	.vidioc_querybuf                = vidc_querybuf,
+	.vidioc_create_bufs             = vidc_create_bufs,
+	.vidioc_prepare_buf             = vidc_prepare_buf,
+	.vidioc_qbuf                    = vidc_qbuf,
+	.vidioc_dqbuf                   = vidc_dqbuf,
+	.vidioc_streamon                = vidc_streamon,
+	.vidioc_streamoff               = vidc_streamoff,
+	.vidioc_querycap                = vidc_querycap,
+	.vidioc_queryctrl               = vidc_queryctrl,
+	.vidioc_querymenu               = vidc_querymenu,
+	.vidioc_subscribe_event         = vidc_subscribe_event,
+	.vidioc_unsubscribe_event       = vidc_unsubscribe_event,
+	.vidioc_g_selection             = vidc_g_selection,
+};
+
 int init_ops(struct iris_core *core)
 {
 	core->v4l2_file_ops = &v4l2_file_ops;
 	core->vb2_ops = &iris_vb2_ops;
 	core->vb2_mem_ops = &iris_vb2_mem_ops;
+	core->v4l2_ioctl_ops = &v4l2_ioctl_ops;
 
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index e242614..abd11fa 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -166,6 +166,23 @@ struct plat_inst_caps {
 	struct plat_inst_cap cap[INST_CAP_MAX + 1];
 };
 
+struct codec_info {
+	u32 v4l2_codec;
+	enum codec_type codec;
+};
+
+struct color_format_info {
+	u32 v4l2_color_format;
+	enum colorformat_type color_format;
+};
+
+struct format_capability {
+	struct codec_info *codec_info;
+	u32 codec_info_size;
+	struct color_format_info *color_format_info;
+	u32 color_format_info_size;
+};
+
 struct platform_data {
 	const struct bus_info *bus_tbl;
 	unsigned int bus_tbl_size;
@@ -182,6 +199,7 @@ struct platform_data {
 	const struct reg_preset_info *reg_prst_tbl;
 	unsigned int reg_prst_tbl_size;
 	struct ubwc_config_data *ubwc_config;
+	struct format_capability *format_data;
 	const char *fwname;
 	u32 pas_id;
 	struct plat_core_cap *core_data;
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index 0759ac5..85bc677 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -19,6 +19,40 @@
 #define MINIMUM_FPS         1
 #define MAXIMUM_FPS       480
 
+static struct codec_info codec_data_sm8550[] = {
+	{
+		.v4l2_codec  = V4L2_PIX_FMT_H264,
+		.codec  = H264,
+	},
+	{
+		.v4l2_codec  = V4L2_PIX_FMT_HEVC,
+		.codec  = HEVC,
+	},
+	{
+		.v4l2_codec  = V4L2_PIX_FMT_VP9,
+		.codec  = VP9,
+	},
+};
+
+static struct color_format_info color_format_data_sm8550[] = {
+	{
+		.v4l2_color_format = V4L2_PIX_FMT_NV12,
+		.color_format = FMT_NV12,
+	},
+	{
+		.v4l2_color_format = V4L2_PIX_FMT_NV21,
+		.color_format = FMT_NV21,
+	},
+	{
+		.v4l2_color_format = V4L2_PIX_FMT_QC08C,
+		.color_format = FMT_NV12C,
+	},
+	{
+		.v4l2_color_format = V4L2_PIX_FMT_QC10C,
+		.color_format = FMT_TP10C,
+	},
+};
+
 static struct plat_core_cap core_data_sm8550[] = {
 	{DEC_CODECS, H264 | HEVC | VP9},
 	{MAX_SESSION_COUNT, 16},
@@ -341,6 +375,13 @@ static struct ubwc_config_data ubwc_config_sm8550[] = {
 	UBWC_CONFIG(8, 32, 16, 0, 1, 1, 1),
 };
 
+static struct format_capability format_data_sm8550 = {
+	.codec_info = codec_data_sm8550,
+	.codec_info_size = ARRAY_SIZE(codec_data_sm8550),
+	.color_format_info = color_format_data_sm8550,
+	.color_format_info_size = ARRAY_SIZE(color_format_data_sm8550),
+};
+
 struct platform_data sm8550_data = {
 	.bus_tbl = sm8550_bus_table,
 	.bus_tbl_size = ARRAY_SIZE(sm8550_bus_table),
@@ -367,4 +408,5 @@ struct platform_data sm8550_data = {
 	.inst_cap_data = instance_cap_data_sm8550,
 	.inst_cap_data_size = ARRAY_SIZE(instance_cap_data_sm8550),
 	.ubwc_config = ubwc_config_sm8550,
+	.format_data = &format_data_sm8550,
 };
-- 
2.7.4


