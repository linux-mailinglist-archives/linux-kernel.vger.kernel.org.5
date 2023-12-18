Return-Path: <linux-kernel+bounces-3484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C0816CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C71B23BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8664174E;
	Mon, 18 Dec 2023 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BwZrPQCo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE8839863;
	Mon, 18 Dec 2023 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAto4o007911;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=DjeCHraDg5N5KWkgTBSLo6OX0aOTajhJqdyfe0iWaX8=; b=Bw
	ZrPQCo3m2x7GTbnlBE5tsR4gOI7b2JwjOcFjV4XV/iWzQWLs2G5K6Jgw0Wwo4MVo
	Ut/I85lEOtytVKtVOorkPTqlIDJ1lUX6xKpcs66SQAab4Tsafmz34Wqxc8HZHijC
	F4jEntymbQ8xpq0iFXkYUJdy3uZGepHqmMGVP7/COmdm2a247xwj2ZuvdJSlvVb1
	574hqMRLrZjB/mS5r5K68CxIrCn8TV7QyFrAGmPtb/B8jVreKG0MpLoJwvPow0jB
	0YnyWDcAqBQXdgsL9YFVlh1YlSy0mJhHUx/13wqQxazBAtM+oAa3uNyM1vOvtZtO
	gtz5VnTqCJCQaMxRbiBQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mb9g4xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0wv004854;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ag-1;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX8re030072;
	Mon, 18 Dec 2023 11:36:10 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX8rs030066;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 71B33238E; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 33/34] media: iris: add vb2 streaming and buffer ops for encoder
Date: Mon, 18 Dec 2023 17:02:28 +0530
Message-Id: <1702899149-21321-34-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bnmkmXwdjsNr_IO3z2ssx7KfZtGHpn73
X-Proofpoint-GUID: bnmkmXwdjsNr_IO3z2ssx7KfZtGHpn73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

During stream on, set some mandatory properties
to firmware to start a session. Set all v4l2 properties set
by client, to firmware prepared with the dependency graph.
Also, configure the hardware internal buffers required
for frame processing. Send HFI_CMD_START on capture and
output planes to start the processing on respective planes.
The instance state is changed accordingly.

During stream off, send HFI_CMD_STOP to firmware which is
a synchronous command. After the response is received from
firmware, the session is closed on firmware and
instance state is changed accordingly.

Buffers are submitted and received via HFI_CMD_BUFFER.

Add Internal buffer size calculations for Encoder.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  11 +
 .../media/platform/qcom/vcodec/iris/iris_buffer.c  | 296 ++++++++--
 .../media/platform/qcom/vcodec/iris/iris_ctrls.c   |  49 +-
 .../media/platform/qcom/vcodec/iris/iris_ctrls.h   |   1 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c | 169 +++++-
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   6 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  22 +-
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    | 137 +++--
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   9 +-
 .../platform/qcom/vcodec/iris/iris_hfi_response.c  | 143 +++--
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  62 +-
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 137 +----
 .../media/platform/qcom/vcodec/iris/iris_venc.c    | 423 ++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_venc.h    |   3 +
 .../platform/qcom/vcodec/iris/platform_common.h    |   5 +
 .../platform/qcom/vcodec/iris/platform_sm8550.c    |   2 +
 .../platform/qcom/vcodec/iris/vpu_iris3_buffer.c   | 198 ++++++-
 .../platform/qcom/vcodec/iris/vpu_iris3_buffer.h   | 624 +++++++++++++++++++++
 .../platform/qcom/vcodec/iris/vpu_iris3_power.c    |   2 +-
 19 files changed, 1992 insertions(+), 307 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index bc32c99..59765de 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -284,6 +284,10 @@ enum hfi_picture_type {
 
 #define HFI_PROP_NO_OUTPUT			0x0300016a
 
+#define HFI_PROP_BUFFER_MARK			0x0300016c
+
+#define HFI_PROP_RAW_RESOLUTION			0x03000178
+
 #define HFI_PROP_DPB_LIST			0x0300017A
 
 #define HFI_PROP_TOTAL_PEAK_BITRATE		0x0300017C
@@ -372,4 +376,11 @@ enum hfi_buffer_firmware_flags {
 	HFI_BUF_FW_FLAG_PSC_LAST	= 0x20000000,
 };
 
+enum hfi_hevc_profile_type {
+	HFI_H265_PROFILE_MAIN			= 0,
+	HFI_H265_PROFILE_MAIN_STILL_PICTURE	= 1,
+	HFI_H265_PROFILE_MAIN_10		= 2,
+	HFI_H265_PROFILE_MAIN_10_STILL_PICTURE	= 3,
+};
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
index f85b52c..18418e4e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
@@ -10,6 +10,7 @@
 #include "hfi_defines.h"
 #include "iris_hfi_packet.h"
 #include "iris_instance.h"
+#include "vpu_iris3_buffer.h"
 
 static const u32 dec_ip_int_buf_type[] = {
 	BUF_BIN,
@@ -22,15 +23,51 @@ static const u32 dec_op_int_buf_type[] = {
 	BUF_DPB,
 };
 
+static const u32 enc_ip_int_buf_type[] = {
+	BUF_VPSS,
+};
+
+static const u32 enc_op_int_buf_type[] = {
+	BUF_BIN,
+	BUF_COMV,
+	BUF_NON_COMV,
+	BUF_LINE,
+	BUF_DPB,
+};
+
 static int input_min_count(struct iris_inst *inst)
 {
-	return MIN_BUFFERS;
+	u32 input_min_count = 0;
+	u32 total_hb_layer = 0;
+
+	if (inst->domain == DECODER) {
+		input_min_count = MIN_BUFFERS;
+	} else if (inst->domain == ENCODER) {
+		total_hb_layer = is_hierb_type_requested(inst) ?
+			inst->cap[ENH_LAYER_COUNT].value + 1 : 0;
+		if (inst->codec == H264 &&
+		    !inst->cap[LAYER_ENABLE].value) {
+			total_hb_layer = 0;
+		}
+		input_min_count =
+			hfi_iris3_enc_min_input_buf_count(total_hb_layer);
+	} else {
+		return 0;
+	}
+
+	return input_min_count;
 }
 
 static int output_min_count(struct iris_inst *inst)
 {
 	int output_min_count;
 
+	if (inst->domain != DECODER && inst->domain != ENCODER)
+		return 0;
+
+	if (inst->domain == ENCODER)
+		return MIN_BUFFERS;
+
 	/* fw_min_count > 0 indicates reconfig event has already arrived */
 	if (inst->fw_min_count) {
 		if (is_split_mode_enabled(inst) && inst->codec == VP9)
@@ -83,16 +120,21 @@ static u32 internal_buffer_count(struct iris_inst *inst,
 {
 	u32 count = 0;
 
-	if (buffer_type == BUF_BIN || buffer_type == BUF_LINE ||
-	    buffer_type == BUF_PERSIST) {
-		count = 1;
-	} else if (buffer_type == BUF_COMV || buffer_type == BUF_NON_COMV) {
-		if (inst->codec == H264 || inst->codec == HEVC)
+	if (inst->domain == ENCODER)
+		return 1;
+
+	if (inst->domain == DECODER) {
+		if (buffer_type == BUF_BIN || buffer_type == BUF_LINE ||
+		    buffer_type == BUF_PERSIST) {
 			count = 1;
-		else
+		} else if (buffer_type == BUF_COMV || buffer_type == BUF_NON_COMV) {
+			if (inst->codec == H264 || inst->codec == HEVC)
+				count = 1;
+			else
+				count = 0;
+		} else {
 			count = 0;
-	} else {
-		count = 0;
+		}
 	}
 
 	return count;
@@ -102,6 +144,9 @@ static int dpb_count(struct iris_inst *inst)
 {
 	int count = 0;
 
+	if (inst->domain == ENCODER)
+		return get_recon_buf_count(inst);
+
 	if (is_split_mode_enabled(inst)) {
 		count = inst->fw_min_count ?
 			inst->fw_min_count : inst->buffers.output.min_count;
@@ -123,6 +168,7 @@ int iris_get_buf_min_count(struct iris_inst *inst,
 	case BUF_NON_COMV:
 	case BUF_LINE:
 	case BUF_PERSIST:
+	case BUF_ARP:
 		return internal_buffer_count(inst, buffer_type);
 	case BUF_DPB:
 		return dpb_count(inst);
@@ -131,7 +177,7 @@ int iris_get_buf_min_count(struct iris_inst *inst,
 	}
 }
 
-static u32 input_buffer_size(struct iris_inst *inst)
+static u32 dec_input_buffer_size(struct iris_inst *inst)
 {
 	u32 base_res_mbs = NUM_MBS_4k;
 	u32 frame_size, num_mbs;
@@ -163,7 +209,7 @@ static u32 input_buffer_size(struct iris_inst *inst)
 	return ALIGN(frame_size, SZ_4K);
 }
 
-static u32 output_buffer_size(struct iris_inst *inst)
+static u32 dec_output_buffer_size(struct iris_inst *inst)
 {
 	struct v4l2_format *f;
 	u32 size;
@@ -175,17 +221,97 @@ static u32 output_buffer_size(struct iris_inst *inst)
 	return size;
 }
 
+static u32 enc_input_buffer_size(struct iris_inst *inst)
+{
+	struct v4l2_format *f;
+	u32 size;
+
+	f = inst->fmt_src;
+
+	size = video_raw_buffer_size(f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width,
+				     f->fmt.pix_mp.height);
+	return size;
+}
+
+static inline
+u32 hfi_buffer_bitstream_enc(u32 frame_width, u32 frame_height,
+			     u32 rc_type, bool is_ten_bit)
+{
+	u32 aligned_width, aligned_height, bitstream_size, yuv_size;
+
+	aligned_width = ALIGN(frame_width, 32);
+	aligned_height = ALIGN(frame_height, 32);
+	bitstream_size = aligned_width * aligned_height * 3;
+	yuv_size = (aligned_width * aligned_height * 3) >> 1;
+	if (aligned_width * aligned_height > (4096 * 2176))
+		/* bitstream_size = 0.25 * yuv_size; */
+		bitstream_size = (bitstream_size >> 3);
+	else if (aligned_width * aligned_height > (1280 * 720))
+		/* bitstream_size = 0.5 * yuv_size; */
+		bitstream_size = (bitstream_size >> 2);
+
+	if ((rc_type == HFI_RC_CQ || rc_type == HFI_RC_OFF) &&
+	    bitstream_size < yuv_size)
+		bitstream_size = (bitstream_size << 1);
+
+	if (is_ten_bit)
+		bitstream_size = (bitstream_size) + (bitstream_size >> 2);
+
+	return ALIGN(bitstream_size, HFI_ALIGNMENT_4096);
+}
+
+static u32 enc_output_buffer_size(struct iris_inst *inst)
+{
+	u32 hfi_rc_type = HFI_RC_VBR_CFR;
+	enum codec_type codec;
+	int bitrate_mode, frame_rc;
+	bool is_ten_bit = false;
+	struct v4l2_format *f;
+	u32 frame_size;
+
+	f = inst->fmt_dst;
+	codec = v4l2_codec_to_driver(inst, f->fmt.pix_mp.pixelformat);
+	if (codec == HEVC)
+		is_ten_bit = true;
+
+	bitrate_mode = inst->cap[BITRATE_MODE].value;
+	frame_rc = inst->cap[FRAME_RC_ENABLE].value;
+	if (!frame_rc)
+		hfi_rc_type = HFI_RC_OFF;
+	else if (bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)
+		hfi_rc_type = HFI_RC_CQ;
+
+	frame_size = hfi_buffer_bitstream_enc(f->fmt.pix_mp.width,
+					      f->fmt.pix_mp.height,
+					      hfi_rc_type, is_ten_bit);
+
+	return frame_size;
+}
+
 int iris_get_buffer_size(struct iris_inst *inst,
 			 enum iris_buffer_type buffer_type)
 {
-	switch (buffer_type) {
-	case BUF_INPUT:
-		return input_buffer_size(inst);
-	case BUF_OUTPUT:
-		return output_buffer_size(inst);
-	default:
-		return 0;
+	if (inst->domain == DECODER) {
+		switch (buffer_type) {
+		case BUF_INPUT:
+			return dec_input_buffer_size(inst);
+		case BUF_OUTPUT:
+			return dec_output_buffer_size(inst);
+		default:
+			break;
+		}
+	} else if (inst->domain == ENCODER) {
+		switch (buffer_type) {
+		case BUF_INPUT:
+			return enc_input_buffer_size(inst);
+		case BUF_OUTPUT:
+			return enc_output_buffer_size(inst);
+		default:
+			break;
+		}
 	}
+
+	return 0;
 }
 
 struct iris_buffers *iris_get_buffer_list(struct iris_inst *inst,
@@ -300,14 +426,30 @@ int iris_get_internal_buffers(struct iris_inst *inst,
 	int ret = 0;
 	u32 i = 0;
 
-	if (plane == INPUT_MPLANE) {
-		for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
-			ret = iris_get_internal_buf_info(inst, dec_ip_int_buf_type[i]);
-			if (ret)
-				return ret;
+	if (inst->domain == DECODER) {
+		if (plane == INPUT_MPLANE) {
+			for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+				ret = iris_get_internal_buf_info(inst, dec_ip_int_buf_type[i]);
+				if (ret)
+					return ret;
+			}
+		} else {
+			return iris_get_internal_buf_info(inst, BUF_DPB);
+		}
+	} else if (inst->domain == ENCODER) {
+		if (plane == INPUT_MPLANE) {
+			for (i = 0; i < ARRAY_SIZE(enc_ip_int_buf_type); i++) {
+				ret = iris_get_internal_buf_info(inst, enc_ip_int_buf_type[i]);
+				if (ret)
+					return ret;
+			}
+		} else {
+			for (i = 0; i < ARRAY_SIZE(enc_op_int_buf_type); i++) {
+				ret = iris_get_internal_buf_info(inst, enc_op_int_buf_type[i]);
+				if (ret)
+					return ret;
+			}
 		}
-	} else {
-		return iris_get_internal_buf_info(inst, BUF_DPB);
 	}
 
 	return ret;
@@ -377,10 +519,18 @@ int iris_create_input_internal_buffers(struct iris_inst *inst)
 	int ret = 0;
 	u32 i = 0;
 
-	for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
-		ret = iris_create_internal_buffers(inst, dec_ip_int_buf_type[i]);
-		if (ret)
-			return ret;
+	if (inst->domain == DECODER) {
+		for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+			ret = iris_create_internal_buffers(inst, dec_ip_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
+	} else if (inst->domain == ENCODER) {
+		for (i = 0; i < ARRAY_SIZE(enc_ip_int_buf_type); i++) {
+			ret = iris_create_internal_buffers(inst, enc_ip_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
@@ -388,7 +538,20 @@ int iris_create_input_internal_buffers(struct iris_inst *inst)
 
 int iris_create_output_internal_buffers(struct iris_inst *inst)
 {
-	return iris_create_internal_buffers(inst, BUF_DPB);
+	int ret = 0;
+	u32 i = 0;
+
+	if (inst->domain == DECODER) {
+		return iris_create_internal_buffers(inst, BUF_DPB);
+	} else if (inst->domain == ENCODER) {
+		for (i = 0; i < ARRAY_SIZE(enc_op_int_buf_type); i++) {
+			ret = iris_create_internal_buffers(inst, enc_op_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
 }
 
 static int set_num_comv(struct iris_inst *inst)
@@ -413,7 +576,7 @@ static int iris_queue_internal_buffers(struct iris_inst *inst,
 	struct iris_buffers *buffers;
 	int ret = 0;
 
-	if (buffer_type == BUF_COMV) {
+	if (inst->domain == DECODER && buffer_type == BUF_COMV) {
 		ret = set_num_comv(inst);
 		if (ret)
 			return ret;
@@ -442,10 +605,18 @@ int iris_queue_input_internal_buffers(struct iris_inst *inst)
 	int ret = 0;
 	u32 i;
 
-	for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
-		ret = iris_queue_internal_buffers(inst, dec_ip_int_buf_type[i]);
-		if (ret)
-			return ret;
+	if (inst->domain == DECODER) {
+		for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+			ret = iris_queue_internal_buffers(inst, dec_ip_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
+	} else if (inst->domain == ENCODER) {
+		for (i = 0; i < ARRAY_SIZE(enc_ip_int_buf_type); i++) {
+			ret = iris_queue_internal_buffers(inst, enc_ip_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
@@ -453,7 +624,20 @@ int iris_queue_input_internal_buffers(struct iris_inst *inst)
 
 int iris_queue_output_internal_buffers(struct iris_inst *inst)
 {
-	return iris_queue_internal_buffers(inst, BUF_DPB);
+	int ret = 0;
+	u32 i = 0;
+
+	if (inst->domain == DECODER) {
+		return iris_queue_internal_buffers(inst, BUF_DPB);
+	} else if (inst->domain == ENCODER) {
+		for (i = 0; i < ARRAY_SIZE(enc_op_int_buf_type); i++) {
+			ret = iris_queue_internal_buffers(inst, enc_op_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
 }
 
 int iris_destroy_internal_buffer(struct iris_inst *inst,
@@ -489,16 +673,26 @@ int iris_destroy_internal_buffers(struct iris_inst *inst,
 {
 	struct iris_buffer *buf, *dummy;
 	struct iris_buffers *buffers;
-	const u32 *internal_buf_type;
+	const u32 *internal_buf_type = NULL;
 	int ret = 0;
-	u32 i, len;
-
-	if (plane == INPUT_MPLANE) {
-		internal_buf_type = dec_ip_int_buf_type;
-		len = ARRAY_SIZE(dec_ip_int_buf_type);
-	} else {
-		internal_buf_type = dec_op_int_buf_type;
-		len = ARRAY_SIZE(dec_op_int_buf_type);
+	u32 i, len = 0;
+
+	if (inst->domain == DECODER) {
+		if (plane == INPUT_MPLANE) {
+			internal_buf_type = dec_ip_int_buf_type;
+			len = ARRAY_SIZE(dec_ip_int_buf_type);
+		} else {
+			internal_buf_type = dec_op_int_buf_type;
+			len = ARRAY_SIZE(dec_op_int_buf_type);
+		}
+	} else if (inst->domain == ENCODER) {
+		if (plane == INPUT_MPLANE) {
+			internal_buf_type = enc_ip_int_buf_type;
+			len = ARRAY_SIZE(enc_ip_int_buf_type);
+		} else {
+			internal_buf_type = enc_op_int_buf_type;
+			len = ARRAY_SIZE(enc_op_int_buf_type);
+		}
 	}
 
 	for (i = 0; i < len; i++) {
@@ -552,10 +746,12 @@ static int iris_release_input_internal_buffers(struct iris_inst *inst)
 	int ret = 0;
 	u32 i = 0;
 
-	for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
-		ret = iris_release_internal_buffers(inst, dec_ip_int_buf_type[i]);
-		if (ret)
-			return ret;
+	if (inst->domain == DECODER) {
+		for (i = 0; i < ARRAY_SIZE(dec_ip_int_buf_type); i++) {
+			ret = iris_release_internal_buffers(inst, dec_ip_int_buf_type[i]);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
@@ -566,7 +762,7 @@ int iris_alloc_and_queue_session_int_bufs(struct iris_inst *inst,
 {
 	int ret;
 
-	if (buffer_type != BUF_PERSIST)
+	if (buffer_type != BUF_ARP && buffer_type != BUF_PERSIST)
 		return -EINVAL;
 
 	ret = iris_get_internal_buf_info(inst, buffer_type);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
index af99ac73..559b0dd 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
@@ -723,11 +723,20 @@ int set_stage(struct iris_inst *inst,
 
 	hfi_id = inst->cap[cap_id].hfi_id;
 
-	inp_f = inst->fmt_src;
-	height = inp_f->fmt.pix_mp.height;
-	width = inp_f->fmt.pix_mp.width;
-	if (res_is_less_than(width, height, 1280, 720))
-		work_mode = STAGE_1;
+	if (inst->domain == DECODER) {
+		inp_f = inst->fmt_src;
+		height = inp_f->fmt.pix_mp.height;
+		width = inp_f->fmt.pix_mp.width;
+		if (res_is_less_than(width, height, 1280, 720))
+			work_mode = STAGE_1;
+	} else if (inst->domain == ENCODER) {
+		if (inst->cap[SLICE_MODE].value ==
+		    V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES)
+			work_mode = STAGE_1;
+
+		if (!inst->cap[GOP_SIZE].value)
+			work_mode = STAGE_2;
+	}
 
 	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
 				     get_port_info(inst, cap_id),
@@ -743,6 +752,12 @@ int set_pipe(struct iris_inst *inst,
 	work_route = inst->cap[cap_id].value;
 	hfi_id = inst->cap[cap_id].hfi_id;
 
+	if (inst->domain == ENCODER) {
+		if (inst->cap[SLICE_MODE].value ==
+		    V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES)
+			work_route = PIPE_1;
+	}
+
 	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
 				     get_port_info(inst, cap_id),
 				     HFI_PAYLOAD_U32,
@@ -763,6 +778,30 @@ int set_level(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
 					 &hfi_value, sizeof(u32));
 }
 
+int decide_quality_mode(struct iris_inst *inst)
+{
+	u32 fps, mbpf, mbps, max_hq_mbpf, max_hq_mbps;
+	u32 mode = POWER_SAVE_MODE;
+	struct iris_core *core;
+
+	if (inst->domain != ENCODER)
+		return 0;
+
+	mbpf = NUM_MBS_PER_FRAME(inst->crop.height, inst->crop.width);
+	fps = max3(inst->cap[QUEUED_RATE].value >> 16,
+		   inst->cap[FRAME_RATE].value >> 16,
+		   inst->cap[OPERATING_RATE].value >> 16);
+	mbps = mbpf * fps;
+	core = inst->core;
+	max_hq_mbpf = core->cap[MAX_MBPF_HQ].value;
+	max_hq_mbps = core->cap[MAX_MBPS_HQ].value;
+
+	if (mbpf <= max_hq_mbpf && mbps <= max_hq_mbps)
+		mode = MAX_QUALITY_MODE;
+
+	return mode;
+}
+
 int set_req_sync_frame(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
 {
 	u32 hfi_id, hfi_val;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
index 5421d9f..404d98c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
@@ -33,6 +33,7 @@ int adjust_v4l2_properties(struct iris_inst *inst);
 int ctrls_init(struct iris_inst *inst, bool init);
 int set_q16(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
 int set_level(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int decide_quality_mode(struct iris_inst *inst);
 int set_req_sync_frame(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
 int set_flip(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
 int set_rotation(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index c84bb51..a770157 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -44,15 +44,15 @@ u32 get_port_info(struct iris_inst *inst,
 	if (inst->cap[cap_id].flags & CAP_FLAG_INPUT_PORT &&
 	    inst->cap[cap_id].flags & CAP_FLAG_OUTPUT_PORT) {
 		if (inst->vb2q_dst->streaming)
-			return get_hfi_port(INPUT_MPLANE);
+			return get_hfi_port(inst, INPUT_MPLANE);
 		else
-			return get_hfi_port(OUTPUT_MPLANE);
+			return get_hfi_port(inst, OUTPUT_MPLANE);
 	}
 
 	if (inst->cap[cap_id].flags & CAP_FLAG_INPUT_PORT)
-		return get_hfi_port(INPUT_MPLANE);
+		return get_hfi_port(inst, INPUT_MPLANE);
 	else if (inst->cap[cap_id].flags & CAP_FLAG_OUTPUT_PORT)
-		return get_hfi_port(OUTPUT_MPLANE);
+		return get_hfi_port(inst, OUTPUT_MPLANE);
 	else
 		return HFI_PORT_NONE;
 }
@@ -86,9 +86,14 @@ int get_mbpf(struct iris_inst *inst)
 	int height = 0, width = 0;
 	struct v4l2_format *inp_f;
 
-	inp_f = inst->fmt_src;
-	width = max(inp_f->fmt.pix_mp.width, inst->crop.width);
-	height = max(inp_f->fmt.pix_mp.height, inst->crop.height);
+	if (inst->domain == DECODER) {
+		inp_f = inst->fmt_src;
+		width = max(inp_f->fmt.pix_mp.width, inst->crop.width);
+		height = max(inp_f->fmt.pix_mp.height, inst->crop.height);
+	} else if (inst->domain == ENCODER) {
+		width = inst->crop.width;
+		height = inst->crop.height;
+	}
 
 	return NUM_MBS_PER_FRAME(height, width);
 }
@@ -100,6 +105,9 @@ inline bool is_linear_colorformat(u32 colorformat)
 
 bool is_split_mode_enabled(struct iris_inst *inst)
 {
+	if (inst->domain != DECODER)
+		return false;
+
 	if (is_linear_colorformat(inst->fmt_dst->fmt.pix_mp.pixelformat))
 		return true;
 
@@ -118,6 +126,24 @@ inline bool is_8bit_colorformat(enum colorformat_type colorformat)
 		colorformat == FMT_NV21;
 }
 
+inline bool is_scaling_enabled(struct iris_inst *inst)
+{
+	return inst->crop.left != inst->compose.left ||
+		inst->crop.top != inst->compose.top ||
+		inst->crop.width != inst->compose.width ||
+		inst->crop.height != inst->compose.height;
+}
+
+inline bool is_hierb_type_requested(struct iris_inst *inst)
+{
+	return (inst->codec == H264 &&
+		inst->cap[LAYER_TYPE].value ==
+				V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_B) ||
+		(inst->codec == HEVC &&
+		inst->cap[LAYER_TYPE].value ==
+				V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_B);
+}
+
 u32 v4l2_codec_from_driver(struct iris_inst *inst, enum codec_type codec)
 {
 	const struct codec_info *codec_info;
@@ -319,17 +345,24 @@ static int check_resolution_supported(struct iris_inst *inst)
 	u32 width = 0, height = 0, min_width, min_height,
 		max_width, max_height;
 
-	width = inst->fmt_src->fmt.pix_mp.width;
-	height = inst->fmt_src->fmt.pix_mp.height;
+	if (inst->domain == DECODER) {
+		width = inst->fmt_src->fmt.pix_mp.width;
+		height = inst->fmt_src->fmt.pix_mp.height;
+	} else if (inst->domain == ENCODER) {
+		width = inst->crop.width;
+		height = inst->crop.height;
+	}
 
 	min_width = inst->cap[FRAME_WIDTH].min;
 	max_width = inst->cap[FRAME_WIDTH].max;
 	min_height = inst->cap[FRAME_HEIGHT].min;
 	max_height = inst->cap[FRAME_HEIGHT].max;
 
-	if (!(min_width <= width && width <= max_width) ||
-	    !(min_height <= height && height <= max_height))
-		return -EINVAL;
+	if (inst->domain == DECODER || inst->domain == ENCODER) {
+		if (!(min_width <= width && width <= max_width) ||
+		    !(min_height <= height && height <= max_height))
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -470,7 +503,7 @@ int queue_buffer(struct iris_inst *inst, struct iris_buffer *buf)
 {
 	int ret;
 
-	if (buf->type == BUF_OUTPUT)
+	if (inst->domain == DECODER && buf->type == BUF_OUTPUT)
 		process_requeued_readonly_buffers(inst, buf);
 
 	ret = iris_hfi_queue_buffer(inst, buf);
@@ -653,7 +686,7 @@ static int iris_flush_read_only_buffers(struct iris_inst *inst,
 {
 	struct iris_buffer *ro_buf, *dummy;
 
-	if (type != BUF_OUTPUT)
+	if (inst->domain != DECODER || type != BUF_OUTPUT)
 		return 0;
 
 	list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
@@ -899,6 +932,114 @@ int codec_change(struct iris_inst *inst, u32 v4l2_codec)
 	return ret;
 }
 
+int process_streamon_input(struct iris_inst *inst)
+{
+	enum iris_inst_sub_state set_sub_state = IRIS_INST_SUB_NONE;
+	int ret;
+
+	iris_scale_power(inst);
+
+	ret = iris_hfi_start(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
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
+	ret = iris_inst_state_change_streamon(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_inst_change_sub_state(inst, 0, set_sub_state);
+
+	return ret;
+}
+
+int process_streamon_output(struct iris_inst *inst)
+{
+	enum iris_inst_sub_state clear_sub_state = IRIS_INST_SUB_NONE;
+	bool drain_pending = false;
+	int ret;
+
+	iris_scale_power(inst);
+
+	if (inst->sub_state & IRIS_INST_SUB_DRC &&
+	    inst->sub_state & IRIS_INST_SUB_DRC_LAST)
+		clear_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_DRC_LAST;
+
+	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
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
+	ret = iris_hfi_start(inst, OUTPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE)
+		clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
+
+	ret = iris_inst_state_change_streamon(inst, OUTPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_inst_change_sub_state(inst, clear_sub_state, 0);
+
+	return ret;
+}
+
+int vb2_buffer_to_driver(struct vb2_buffer *vb2, struct iris_buffer *buf)
+{
+	struct vb2_v4l2_buffer *vbuf;
+
+	if (!vb2 || !buf)
+		return -EINVAL;
+
+	vbuf = to_vb2_v4l2_buffer(vb2);
+
+	buf->fd = vb2->planes[0].m.fd;
+	buf->data_offset = vb2->planes[0].data_offset;
+	buf->data_size = vb2->planes[0].bytesused - vb2->planes[0].data_offset;
+	buf->buffer_size = vb2->planes[0].length;
+	buf->timestamp = vb2->timestamp;
+	buf->flags = vbuf->flags;
+	buf->attr = 0;
+
+	return 0;
+}
+
 int iris_pm_get(struct iris_core *core)
 {
 	int ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 39cec8c..bf8448a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -31,7 +31,9 @@ int close_session(struct iris_inst *inst);
 bool is_linear_colorformat(u32 colorformat);
 bool is_10bit_colorformat(enum colorformat_type colorformat);
 bool is_8bit_colorformat(enum colorformat_type colorformat);
+bool is_scaling_enabled(struct iris_inst *inst);
 bool is_split_mode_enabled(struct iris_inst *inst);
+bool is_hierb_type_requested(struct iris_inst *inst);
 int signal_session_msg_receipt(struct iris_inst *inst,
 			       enum signal_session_response cmd);
 struct iris_inst *to_instance(struct iris_core *core, u32 session_id);
@@ -54,6 +56,10 @@ void iris_destroy_buffers(struct iris_inst *inst);
 int session_streamoff(struct iris_inst *inst, u32 plane);
 int process_resume(struct iris_inst *inst);
 int codec_change(struct iris_inst *inst, u32 v4l2_codec);
+int process_streamon_input(struct iris_inst *inst);
+int process_streamon_output(struct iris_inst *inst);
+int vb2_buffer_to_driver(struct vb2_buffer *vb2,
+			 struct iris_buffer *buf);
 int iris_pm_get(struct iris_core *core);
 int iris_pm_put(struct iris_core *core, bool autosuspend);
 int iris_pm_get_put(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 00e598d..4a54293 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -356,7 +356,7 @@ int iris_hfi_session_set_default_header(struct iris_inst *inst)
 	ret = hfi_packet_session_property(inst,
 					  HFI_PROP_DEC_DEFAULT_HEADER,
 					  HFI_HOST_FLAGS_NONE,
-					  get_hfi_port(INPUT_MPLANE),
+					  get_hfi_port(inst, INPUT_MPLANE),
 					  HFI_PAYLOAD_U32,
 					  &default_header,
 					  sizeof(u32));
@@ -394,7 +394,7 @@ int iris_hfi_start(struct iris_inst *inst, u32 plane)
 					 HFI_CMD_START,
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED),
-					 get_hfi_port(plane),
+					 get_hfi_port(inst, plane),
 					 inst->session_id,
 					 HFI_PAYLOAD_NONE,
 					 NULL,
@@ -434,7 +434,7 @@ int iris_hfi_stop(struct iris_inst *inst, u32 plane)
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED |
 					 HFI_HOST_FLAGS_NON_DISCARDABLE),
-					 get_hfi_port(plane),
+					 get_hfi_port(inst, plane),
 					 inst->session_id,
 					 HFI_PAYLOAD_NONE,
 					 NULL,
@@ -472,7 +472,7 @@ int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
 					 cmd,
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED),
-					 get_hfi_port(plane),
+					 get_hfi_port(inst, plane),
 					 inst->session_id,
 					 payload_type,
 					 payload,
@@ -511,7 +511,7 @@ int iris_hfi_pause(struct iris_inst *inst, u32 plane)
 					 HFI_CMD_PAUSE,
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED),
-					 get_hfi_port(plane),
+					 get_hfi_port(inst, plane),
 					 inst->session_id,
 					 HFI_PAYLOAD_NONE,
 					 NULL,
@@ -550,7 +550,7 @@ int iris_hfi_resume(struct iris_inst *inst, u32 plane, u32 payload)
 					 HFI_CMD_RESUME,
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED),
-					 get_hfi_port(plane),
+					 get_hfi_port(inst, plane),
 					 inst->session_id,
 					 HFI_PAYLOAD_U32,
 					 &payload,
@@ -590,7 +590,7 @@ int iris_hfi_drain(struct iris_inst *inst, u32 plane)
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED |
 					 HFI_HOST_FLAGS_NON_DISCARDABLE),
-					 get_hfi_port(plane),
+					 get_hfi_port(inst, plane),
 					 inst->session_id,
 					 HFI_PAYLOAD_NONE,
 					 NULL,
@@ -739,14 +739,14 @@ int iris_hfi_queue_buffer(struct iris_inst *inst,
 		goto unlock;
 	}
 
-	ret = get_hfi_buffer(buffer, &hfi_buffer);
+	ret = get_hfi_buffer(inst, buffer, &hfi_buffer);
 	if (ret)
 		goto unlock;
 
 	ret = hfi_packet_session_command(inst,
 					 HFI_CMD_BUFFER,
 					 HFI_HOST_FLAGS_INTR_REQUIRED,
-					 get_hfi_port_from_buffer_type(buffer->type),
+					 get_hfi_port_from_buffer_type(inst, buffer->type),
 					 inst->session_id,
 					 HFI_PAYLOAD_STRUCTURE,
 					 &hfi_buffer,
@@ -780,7 +780,7 @@ int iris_hfi_release_buffer(struct iris_inst *inst,
 		goto unlock;
 	}
 
-	ret = get_hfi_buffer(buffer, &hfi_buffer);
+	ret = get_hfi_buffer(inst, buffer, &hfi_buffer);
 	if (ret)
 		goto unlock;
 
@@ -790,7 +790,7 @@ int iris_hfi_release_buffer(struct iris_inst *inst,
 					 HFI_CMD_BUFFER,
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED),
-					 get_hfi_port_from_buffer_type(buffer->type),
+					 get_hfi_port_from_buffer_type(inst, buffer->type),
 					 inst->session_id,
 					 HFI_PAYLOAD_STRUCTURE,
 					 &hfi_buffer,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index dd27fa4..e9f3749 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -3,64 +3,108 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include "iris_common.h"
 #include "iris_core.h"
 #include "iris_helpers.h"
 #include "iris_hfi_packet.h"
 #include "hfi_defines.h"
 
-u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type)
+u32 get_hfi_port_from_buffer_type(struct iris_inst *inst, enum iris_buffer_type buffer_type)
 {
 	u32 hfi_port = HFI_PORT_NONE;
 
-	switch (buffer_type) {
-	case BUF_INPUT:
-	case BUF_BIN:
-	case BUF_COMV:
-	case BUF_NON_COMV:
-	case BUF_LINE:
-		hfi_port = HFI_PORT_BITSTREAM;
-		break;
-	case BUF_OUTPUT:
-	case BUF_DPB:
-		hfi_port = HFI_PORT_RAW;
-		break;
-	case BUF_PERSIST:
-		hfi_port = HFI_PORT_NONE;
-		break;
-	default:
-		break;
+	if (inst->domain == DECODER) {
+		switch (buffer_type) {
+		case BUF_INPUT:
+		case BUF_BIN:
+		case BUF_COMV:
+		case BUF_NON_COMV:
+		case BUF_LINE:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		case BUF_OUTPUT:
+		case BUF_DPB:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		case BUF_PERSIST:
+			hfi_port = HFI_PORT_NONE;
+			break;
+		default:
+			break;
+		}
+	} else if (inst->domain == ENCODER) {
+		switch (buffer_type) {
+		case BUF_INPUT:
+		case BUF_VPSS:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		case BUF_OUTPUT:
+		case BUF_BIN:
+		case BUF_COMV:
+		case BUF_NON_COMV:
+		case BUF_LINE:
+		case BUF_DPB:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		case BUF_ARP:
+			hfi_port = HFI_PORT_NONE;
+			break;
+		default:
+			break;
+		}
 	}
 
 	return hfi_port;
 }
 
-u32 get_hfi_port(u32 plane)
+u32 get_hfi_port(struct iris_inst *inst, u32 plane)
 {
 	u32 hfi_port = HFI_PORT_NONE;
 
-	switch (plane) {
-	case INPUT_MPLANE:
-		hfi_port = HFI_PORT_BITSTREAM;
-		break;
-	case OUTPUT_MPLANE:
-		hfi_port = HFI_PORT_RAW;
-		break;
-	default:
-		break;
+	if (inst->domain == DECODER) {
+		switch (plane) {
+		case INPUT_MPLANE:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		case OUTPUT_MPLANE:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		default:
+			break;
+		}
+	} else if (inst->domain == ENCODER) {
+		switch (plane) {
+		case INPUT_MPLANE:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		case OUTPUT_MPLANE:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		default:
+			break;
+		}
 	}
 
 	return hfi_port;
 }
 
-static u32 hfi_buf_type_from_driver(enum iris_buffer_type buffer_type)
+static u32 hfi_buf_type_from_driver(enum domain_type domain, enum iris_buffer_type buffer_type)
 {
 	switch (buffer_type) {
 	case BUF_INPUT:
-		return HFI_BUFFER_BITSTREAM;
+		if (domain == DECODER)
+			return HFI_BUFFER_BITSTREAM;
+		else
+			return HFI_BUFFER_RAW;
 	case BUF_OUTPUT:
-		return HFI_BUFFER_RAW;
+		if (domain == DECODER)
+			return HFI_BUFFER_RAW;
+		else
+			return HFI_BUFFER_BITSTREAM;
 	case BUF_BIN:
 		return HFI_BUFFER_BIN;
+	case BUF_ARP:
+		return HFI_BUFFER_ARP;
 	case BUF_COMV:
 		return HFI_BUFFER_COMV;
 	case BUF_NON_COMV:
@@ -76,13 +120,19 @@ static u32 hfi_buf_type_from_driver(enum iris_buffer_type buffer_type)
 	}
 }
 
-u32 hfi_buf_type_to_driver(enum hfi_buffer_type buf_type)
+u32 hfi_buf_type_to_driver(enum domain_type domain, enum hfi_buffer_type buf_type)
 {
 	switch (buf_type) {
 	case HFI_BUFFER_BITSTREAM:
-		return BUF_INPUT;
+		if (domain == DECODER)
+			return BUF_INPUT;
+		else
+			return BUF_OUTPUT;
 	case HFI_BUFFER_RAW:
-		return BUF_OUTPUT;
+		if (domain == DECODER)
+			return BUF_OUTPUT;
+		else
+			return BUF_INPUT;
 	case HFI_BUFFER_BIN:
 		return BUF_BIN;
 	case HFI_BUFFER_ARP:
@@ -108,9 +158,15 @@ u32 get_hfi_codec(struct iris_inst *inst)
 {
 	switch (inst->codec) {
 	case H264:
-		return HFI_CODEC_DECODE_AVC;
+		if (inst->domain == ENCODER)
+			return HFI_CODEC_ENCODE_AVC;
+		else
+			return HFI_CODEC_DECODE_AVC;
 	case HEVC:
-		return HFI_CODEC_DECODE_HEVC;
+		if (inst->domain == ENCODER)
+			return HFI_CODEC_ENCODE_HEVC;
+		else
+			return HFI_CODEC_DECODE_HEVC;
 	case VP9:
 		return HFI_CODEC_DECODE_VP9;
 	default:
@@ -337,10 +393,11 @@ u32 get_v4l2_matrix_coefficients(u32 hfi_coefficients)
 	return coefficients;
 }
 
-int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf)
+int get_hfi_buffer(struct iris_inst *inst,
+		   struct iris_buffer *buffer, struct hfi_buffer *buf)
 {
-	memset(buf, 0, sizeof(*buf));
-	buf->type = hfi_buf_type_from_driver(buffer->type);
+	memset(buf, 0, sizeof(struct hfi_buffer));
+	buf->type = hfi_buf_type_from_driver(inst->domain, buffer->type);
 	buf->index = buffer->index;
 	buf->base_address = buffer->device_addr;
 	buf->addr_offset = 0;
@@ -350,7 +407,7 @@ int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf)
 	 * buffer size otherwise it will truncate or ignore the data after 256
 	 * aligned size which may lead to error concealment
 	 */
-	if (buffer->type == BUF_INPUT)
+	if (inst->domain == DECODER && buffer->type == BUF_INPUT)
 		buf->buffer_size = ALIGN(buffer->buffer_size, 256);
 	buf->data_offset = buffer->data_offset;
 	buf->data_size = buffer->data_size;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index 82148b7..734a070 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -80,8 +80,8 @@ enum hfi_packet_port_type {
 	HFI_PORT_RAW		= 0x00000002,
 };
 
-u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type);
-u32 get_hfi_port(u32 plane);
+u32 get_hfi_port_from_buffer_type(struct iris_inst *inst, enum iris_buffer_type buffer_type);
+u32 get_hfi_port(struct iris_inst *inst, u32 plane);
 u32 get_hfi_colorformat(u32 colorformat);
 u32 get_hfi_codec(struct iris_inst *inst);
 u32 get_hfi_color_primaries(u32 primaries);
@@ -90,8 +90,9 @@ u32 get_hfi_matrix_coefficients(u32 coefficients);
 u32 get_v4l2_color_primaries(u32 hfi_primaries);
 u32 get_v4l2_transfer_char(u32 hfi_characterstics);
 u32 get_v4l2_matrix_coefficients(u32 hfi_coefficients);
-u32 hfi_buf_type_to_driver(enum hfi_buffer_type buf_type);
-int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf);
+u32 hfi_buf_type_to_driver(enum domain_type domain, enum hfi_buffer_type buf_type);
+int get_hfi_buffer(struct iris_inst *inst,
+		   struct iris_buffer *buffer, struct hfi_buffer *buf);
 
 int hfi_packet_sys_init(struct iris_core *core,
 			u8 *pkt, u32 pkt_size);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
index 1b667a5..08bdb8f 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
@@ -71,7 +71,8 @@ static bool is_valid_hfi_buffer_type(u32 buffer_type)
 static bool is_valid_hfi_port(u32 port, u32 buffer_type)
 {
 	if (port == HFI_PORT_NONE &&
-	    buffer_type != HFI_BUFFER_PERSIST)
+	    buffer_type != HFI_BUFFER_ARP &&
+		buffer_type != HFI_BUFFER_PERSIST)
 		return false;
 
 	if (port != HFI_PORT_BITSTREAM && port != HFI_PORT_RAW)
@@ -103,8 +104,9 @@ static int get_driver_buffer_flags(struct iris_inst *inst, u32 hfi_flags)
 	if (inst->hfi_frame_info.overflow)
 		driver_flags |= BUF_FLAG_ERROR;
 
-	if (hfi_flags & HFI_BUF_FW_FLAG_LAST ||
-	    hfi_flags & HFI_BUF_FW_FLAG_PSC_LAST)
+	if ((inst->domain == ENCODER && (hfi_flags & HFI_BUF_FW_FLAG_LAST)) ||
+	    (inst->domain == DECODER && (hfi_flags & HFI_BUF_FW_FLAG_LAST ||
+					 hfi_flags & HFI_BUF_FW_FLAG_PSC_LAST)))
 		driver_flags |= BUF_FLAG_LAST;
 
 	return driver_flags;
@@ -309,9 +311,12 @@ static int handle_session_close(struct iris_inst *inst,
 static int handle_read_only_buffer(struct iris_inst *inst,
 				   struct iris_buffer *buf)
 {
-	struct iris_buffer *ro_buf, *iter;
+	struct iris_buffer *ro_buf, *iter = NULL;
 	bool found = false;
 
+	if (inst->domain != DECODER && inst->domain != ENCODER)
+		return 0;
+
 	list_for_each_entry(iter, &inst->buffers.read_only.list, list) {
 		if (iter->device_addr == buf->device_addr) {
 			found = true;
@@ -344,6 +349,9 @@ static int handle_non_read_only_buffer(struct iris_inst *inst,
 {
 	struct iris_buffer *ro_buf;
 
+	if (inst->domain != DECODER && inst->domain != ENCODER)
+		return 0;
+
 	list_for_each_entry(ro_buf, &inst->buffers.read_only.list, list) {
 		if (ro_buf->device_addr == buffer->base_address) {
 			ro_buf->attr &= ~BUF_ATTR_READ_ONLY;
@@ -414,9 +422,9 @@ static int handle_input_buffer(struct iris_inst *inst,
 static int handle_output_buffer(struct iris_inst *inst,
 				struct hfi_buffer *hfi_buffer)
 {
-	struct iris_buffers *buffers;
 	struct iris_buffer *buf, *iter;
-	bool found;
+	struct iris_buffers *buffers;
+	bool found, fatal = false;
 	int ret = 0;
 
 	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_LAST) {
@@ -425,17 +433,19 @@ static int handle_output_buffer(struct iris_inst *inst,
 			return ret;
 	}
 
-	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_RELEASE_DONE)
-		return handle_release_output_buffer(inst, hfi_buffer);
+	if (inst->domain == DECODER) {
+		if (hfi_buffer->flags & HFI_BUF_FW_FLAG_RELEASE_DONE)
+			return handle_release_output_buffer(inst, hfi_buffer);
 
-	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_PSC_LAST) {
-		ret = iris_inst_sub_state_change_drc_last(inst);
-		if (ret)
-			return ret;
-	}
+		if (hfi_buffer->flags & HFI_BUF_FW_FLAG_PSC_LAST) {
+			ret = iris_inst_sub_state_change_drc_last(inst);
+			if (ret)
+				return ret;
+		}
 
-	if (!(hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY))
-		ret = handle_non_read_only_buffer(inst, hfi_buffer);
+		if (!(hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY))
+			ret = handle_non_read_only_buffer(inst, hfi_buffer);
+	}
 
 	buffers = iris_get_buffer_list(inst, BUF_OUTPUT);
 	if (!buffers)
@@ -446,9 +456,12 @@ static int handle_output_buffer(struct iris_inst *inst,
 		if (!(iter->attr & BUF_ATTR_QUEUED))
 			continue;
 
-		found = (iter->index == hfi_buffer->index &&
-				iter->device_addr == hfi_buffer->base_address &&
-				iter->data_offset == hfi_buffer->data_offset);
+		if (inst->domain == DECODER)
+			found = (iter->index == hfi_buffer->index &&
+				 iter->device_addr == hfi_buffer->base_address &&
+				 iter->data_offset == hfi_buffer->data_offset);
+		else
+			found = iter->index == hfi_buffer->index;
 
 		if (found) {
 			buf = iter;
@@ -465,14 +478,27 @@ static int handle_output_buffer(struct iris_inst *inst,
 	buf->attr &= ~BUF_ATTR_QUEUED;
 	buf->attr |= BUF_ATTR_DEQUEUED;
 
-	if (inst->buffers.dpb.size && hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY)
-		iris_inst_change_state(inst, IRIS_INST_ERROR);
+	if (inst->domain == ENCODER) {
+		if (inst->hfi_frame_info.data_corrupt)
+			fatal = true;
+		if (inst->hfi_frame_info.overflow) {
+			if (!hfi_buffer->data_size && inst->hfi_rc_type == HFI_RC_CBR_CFR)
+				fatal = true;
+		}
+		if (fatal)
+			iris_inst_change_state(inst, IRIS_INST_ERROR);
+	}
+
+	if (inst->domain == DECODER) {
+		if (inst->buffers.dpb.size && hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY)
+			iris_inst_change_state(inst, IRIS_INST_ERROR);
 
-	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY) {
-		buf->attr |= BUF_ATTR_READ_ONLY;
-		ret = handle_read_only_buffer(inst, buf);
-	} else {
-		buf->attr &= ~BUF_ATTR_READ_ONLY;
+		if (hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY) {
+			buf->attr |= BUF_ATTR_READ_ONLY;
+			ret = handle_read_only_buffer(inst, buf);
+		} else {
+			buf->attr &= ~BUF_ATTR_READ_ONLY;
+		}
 	}
 
 	buf->flags = get_driver_buffer_flags(inst, hfi_buffer->flags);
@@ -521,7 +547,7 @@ static int handle_release_internal_buffer(struct iris_inst *inst,
 	int ret = 0;
 	bool found;
 
-	buffers = iris_get_buffer_list(inst, hfi_buf_type_to_driver(buffer->type));
+	buffers = iris_get_buffer_list(inst, hfi_buf_type_to_driver(inst->domain, buffer->type));
 	if (!buffers)
 		return -EINVAL;
 
@@ -550,12 +576,22 @@ static int handle_session_stop(struct iris_inst *inst,
 	int ret = 0;
 	enum signal_session_response signal_type = -1;
 
-	if (pkt->port == HFI_PORT_RAW) {
-		signal_type = SIGNAL_CMD_STOP_OUTPUT;
-		ret = iris_inst_sub_state_change_pause(inst, OUTPUT_MPLANE);
-	} else if (pkt->port == HFI_PORT_BITSTREAM) {
-		signal_type = SIGNAL_CMD_STOP_INPUT;
-		ret = iris_inst_sub_state_change_pause(inst, INPUT_MPLANE);
+	if (inst->domain == DECODER) {
+		if (pkt->port == HFI_PORT_RAW) {
+			signal_type = SIGNAL_CMD_STOP_OUTPUT;
+			ret = iris_inst_sub_state_change_pause(inst, OUTPUT_MPLANE);
+		} else if (pkt->port == HFI_PORT_BITSTREAM) {
+			signal_type = SIGNAL_CMD_STOP_INPUT;
+			ret = iris_inst_sub_state_change_pause(inst, INPUT_MPLANE);
+		}
+	} else if (inst->domain == ENCODER) {
+		if (pkt->port == HFI_PORT_RAW) {
+			signal_type = SIGNAL_CMD_STOP_INPUT;
+			ret = iris_inst_sub_state_change_pause(inst, INPUT_MPLANE);
+		} else if (pkt->port == HFI_PORT_BITSTREAM) {
+			signal_type = SIGNAL_CMD_STOP_OUTPUT;
+			ret = iris_inst_sub_state_change_pause(inst, OUTPUT_MPLANE);
+		}
 	}
 
 	if (signal_type != -1)
@@ -571,7 +607,7 @@ static int handle_session_buffer(struct iris_inst *inst,
 	u32 hfi_handle_size = 0;
 	int i, ret = 0;
 	const struct iris_hfi_buffer_handle *hfi_handle_arr = NULL;
-	static const struct iris_hfi_buffer_handle input_hfi_handle[] = {
+	static const struct iris_hfi_buffer_handle dec_input_hfi_handle[] = {
 		{HFI_BUFFER_BITSTREAM,      handle_input_buffer               },
 		{HFI_BUFFER_BIN,            handle_release_internal_buffer    },
 		{HFI_BUFFER_COMV,           handle_release_internal_buffer    },
@@ -579,10 +615,24 @@ static int handle_session_buffer(struct iris_inst *inst,
 		{HFI_BUFFER_LINE,           handle_release_internal_buffer    },
 		{HFI_BUFFER_PERSIST,        handle_release_internal_buffer    },
 	};
-	static const struct iris_hfi_buffer_handle output_hfi_handle[] = {
+	static const struct iris_hfi_buffer_handle dec_output_hfi_handle[] = {
 		{HFI_BUFFER_RAW,            handle_output_buffer              },
 		{HFI_BUFFER_DPB,            handle_release_internal_buffer    },
 	};
+	static const struct iris_hfi_buffer_handle enc_input_hfi_handle[] = {
+		{HFI_BUFFER_RAW,            handle_input_buffer               },
+		{HFI_BUFFER_VPSS,           handle_release_internal_buffer    },
+	};
+	static const struct iris_hfi_buffer_handle enc_output_hfi_handle[] = {
+		{HFI_BUFFER_BITSTREAM,      handle_output_buffer              },
+		{HFI_BUFFER_BIN,            handle_release_internal_buffer    },
+		{HFI_BUFFER_COMV,           handle_release_internal_buffer    },
+		{HFI_BUFFER_NON_COMV,       handle_release_internal_buffer    },
+		{HFI_BUFFER_LINE,           handle_release_internal_buffer    },
+		{HFI_BUFFER_ARP,            handle_release_internal_buffer    },
+		{HFI_BUFFER_DPB,            handle_release_internal_buffer    },
+	};
+
 
 	if (pkt->payload_info == HFI_PAYLOAD_NONE)
 		return 0;
@@ -599,12 +649,22 @@ static int handle_session_buffer(struct iris_inst *inst,
 	if (!is_valid_hfi_port(pkt->port, buffer->type))
 		return 0;
 
-	if (pkt->port == HFI_PORT_BITSTREAM) {
-		hfi_handle_size = ARRAY_SIZE(input_hfi_handle);
-		hfi_handle_arr = input_hfi_handle;
-	} else if (pkt->port == HFI_PORT_RAW) {
-		hfi_handle_size = ARRAY_SIZE(output_hfi_handle);
-		hfi_handle_arr = output_hfi_handle;
+	if (inst->domain == DECODER) {
+		if (pkt->port == HFI_PORT_BITSTREAM) {
+			hfi_handle_size = ARRAY_SIZE(dec_input_hfi_handle);
+			hfi_handle_arr = dec_input_hfi_handle;
+		} else if (pkt->port == HFI_PORT_RAW) {
+			hfi_handle_size = ARRAY_SIZE(dec_output_hfi_handle);
+			hfi_handle_arr = dec_output_hfi_handle;
+		}
+	} else if (inst->domain == ENCODER) {
+		if (pkt->port == HFI_PORT_RAW) {
+			hfi_handle_size = ARRAY_SIZE(enc_input_hfi_handle);
+			hfi_handle_arr = enc_input_hfi_handle;
+		} else if (pkt->port == HFI_PORT_BITSTREAM) {
+			hfi_handle_size = ARRAY_SIZE(enc_output_hfi_handle);
+			hfi_handle_arr = enc_output_hfi_handle;
+		}
 	}
 
 	if (!hfi_handle_arr || !hfi_handle_size)
@@ -693,6 +753,9 @@ static int handle_dpb_list_property(struct iris_inst *inst,
 	u8 *payload_start;
 	u32 payload_size;
 
+	if (inst->domain != DECODER)
+		return -EINVAL;
+
 	payload_size = pkt->size - sizeof(*pkt);
 	payload_start = (u8 *)((u8 *)pkt + sizeof(*pkt));
 	memset(inst->dpb_list_payload, 0, MAX_DPB_LIST_ARRAY_SIZE);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
index c0878f1..1a434ff 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -13,6 +13,7 @@
 #include "iris_power.h"
 #include "iris_vb2.h"
 #include "iris_vdec.h"
+#include "iris_venc.h"
 
 int iris_vb2_queue_setup(struct vb2_queue *q,
 			 unsigned int *num_buffers, unsigned int *num_planes,
@@ -58,7 +59,8 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 			return ret;
 	}
 
-	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+	if ((inst->domain == DECODER && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ||
+	    (inst->domain == ENCODER && q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)) {
 		ret = adjust_v4l2_properties(inst);
 		if (ret)
 			return ret;
@@ -112,6 +114,11 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto error;
 	}
 
+	if (inst->domain != DECODER && inst->domain != ENCODER) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	ret = iris_pm_get(inst->core);
 	if (ret)
 		goto error;
@@ -122,21 +129,34 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		if (ret)
 			goto err_pm_get;
 
-		ret = iris_hfi_session_set_default_header(inst);
-		if (ret)
-			goto err_pm_get;
-
-		ret = iris_alloc_and_queue_session_int_bufs(inst, BUF_PERSIST);
-		if (ret)
-			goto err_pm_get;
+		if (inst->domain == ENCODER)  {
+			ret = iris_alloc_and_queue_session_int_bufs(inst, BUF_ARP);
+			if (ret)
+				goto err_pm_get;
+		} else if (inst->domain == DECODER) {
+			ret = iris_hfi_session_set_default_header(inst);
+			if (ret)
+				goto err_pm_get;
+
+			ret = iris_alloc_and_queue_session_int_bufs(inst, BUF_PERSIST);
+			if (ret)
+				goto err_pm_get;
+		}
 	}
 
 	iris_scale_power(inst);
 
-	if (q->type == INPUT_MPLANE)
-		ret = vdec_streamon_input(inst);
-	else if (q->type == OUTPUT_MPLANE)
-		ret = vdec_streamon_output(inst);
+	if (q->type == INPUT_MPLANE) {
+		if (inst->domain == DECODER)
+			ret = vdec_streamon_input(inst);
+		else if (inst->domain == ENCODER)
+			ret = venc_streamon_input(inst);
+	} else if (q->type == OUTPUT_MPLANE) {
+		if (inst->domain == DECODER)
+			ret = vdec_streamon_output(inst);
+		else if (inst->domain == ENCODER)
+			ret = venc_streamon_output(inst);
+	}
 	if (ret)
 		goto err_pm_get;
 
@@ -179,6 +199,11 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 	if (q->type != INPUT_MPLANE && q->type != OUTPUT_MPLANE)
 		goto error;
 
+	if (inst->domain != DECODER && inst->domain != ENCODER) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	ret = iris_pm_get_put(inst->core);
 	if (ret)
 		goto error;
@@ -225,7 +250,10 @@ void iris_vb2_buf_queue(struct vb2_buffer *vb2)
 	if (ret)
 		goto exit;
 
-	ret = vdec_qbuf(inst, vb2);
+	if (inst->domain == DECODER)
+		ret = vdec_qbuf(inst, vb2);
+	else if (inst->domain == ENCODER)
+		ret = venc_qbuf(inst, vb2);
 
 exit:
 	if (ret) {
@@ -270,7 +298,7 @@ void *iris_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
 	buf->inst = inst;
 	buf->dmabuf = dbuf;
 
-	if (buf->type == BUF_OUTPUT) {
+	if (inst->domain == DECODER && buf->type == BUF_OUTPUT) {
 		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
 			if (ro_buf->dmabuf != buf->dmabuf)
 				continue;
@@ -307,7 +335,7 @@ int iris_vb2_map_dmabuf(void *buf_priv)
 		return -EINVAL;
 	}
 
-	if (buf->type == BUF_OUTPUT) {
+	if (inst->domain == DECODER && buf->type == BUF_OUTPUT) {
 		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
 			if (ro_buf->dmabuf != buf->dmabuf)
 				continue;
@@ -356,7 +384,7 @@ void iris_vb2_unmap_dmabuf(void *buf_priv)
 		return;
 	}
 
-	if (buf->type == BUF_OUTPUT) {
+	if (inst->domain == DECODER && buf->type == BUF_OUTPUT) {
 		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
 			if (ro_buf->dmabuf != buf->dmabuf)
 				continue;
@@ -393,7 +421,7 @@ void iris_vb2_detach_dmabuf(void *buf_priv)
 		buf->sg_table = NULL;
 	}
 
-	if (buf->type == BUF_OUTPUT) {
+	if (inst->domain == DECODER && buf->type == BUF_OUTPUT) {
 		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
 			if (ro_buf->dmabuf != buf->dmabuf)
 				continue;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 300d0e9..b2d4739 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -362,7 +362,7 @@ static int vdec_set_bitstream_resolution(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					HFI_PROP_BITSTREAM_RESOLUTION,
 					HFI_HOST_FLAGS_NONE,
-					get_hfi_port(INPUT_MPLANE),
+					get_hfi_port(inst, INPUT_MPLANE),
 					HFI_PAYLOAD_U32,
 					&resolution,
 					sizeof(u32));
@@ -388,7 +388,7 @@ static int vdec_set_crop_offsets(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					HFI_PROP_CROP_OFFSETS,
 					HFI_HOST_FLAGS_NONE,
-					get_hfi_port(INPUT_MPLANE),
+					get_hfi_port(inst, INPUT_MPLANE),
 					HFI_PAYLOAD_64_PACKED,
 					&payload,
 					sizeof(u64));
@@ -409,7 +409,7 @@ static int vdec_set_bit_depth(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					HFI_PROP_LUMA_CHROMA_BIT_DEPTH,
 					HFI_HOST_FLAGS_NONE,
-					get_hfi_port(INPUT_MPLANE),
+					get_hfi_port(inst, INPUT_MPLANE),
 					HFI_PAYLOAD_U32,
 					&bitdepth,
 					sizeof(u32));
@@ -426,7 +426,7 @@ static int vdec_set_coded_frames(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					HFI_PROP_CODED_FRAMES,
 					HFI_HOST_FLAGS_NONE,
-					get_hfi_port(INPUT_MPLANE),
+					get_hfi_port(inst, INPUT_MPLANE),
 					HFI_PAYLOAD_U32,
 					&coded_frames,
 					sizeof(u32));
@@ -442,7 +442,7 @@ static int vdec_set_min_output_count(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT,
 					HFI_HOST_FLAGS_NONE,
-					get_hfi_port(INPUT_MPLANE),
+					get_hfi_port(inst, INPUT_MPLANE),
 					HFI_PAYLOAD_U32,
 					&min_output,
 					sizeof(u32));
@@ -457,7 +457,7 @@ static int vdec_set_picture_order_count(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					HFI_PROP_PIC_ORDER_CNT_TYPE,
 					HFI_HOST_FLAGS_NONE,
-					get_hfi_port(INPUT_MPLANE),
+					get_hfi_port(inst, INPUT_MPLANE),
 					HFI_PAYLOAD_U32,
 					&poc,
 					sizeof(u32));
@@ -509,7 +509,7 @@ static int vdec_set_colorspace(struct iris_inst *inst)
 	ret = iris_hfi_set_property(inst,
 				    HFI_PROP_SIGNAL_COLOR_INFO,
 				    HFI_HOST_FLAGS_NONE,
-				    get_hfi_port(INPUT_MPLANE),
+				    get_hfi_port(inst, INPUT_MPLANE),
 				    HFI_PAYLOAD_32_PACKED,
 				    &color_info,
 				    sizeof(u32));
@@ -527,7 +527,7 @@ static int vdec_set_profile(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 				     HFI_PROP_PROFILE,
 				     HFI_HOST_FLAGS_NONE,
-				     get_hfi_port(INPUT_MPLANE),
+				     get_hfi_port(inst, INPUT_MPLANE),
 				     HFI_PAYLOAD_U32_ENUM,
 				     &profile,
 				     sizeof(u32));
@@ -543,7 +543,7 @@ static int vdec_set_level(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 				     HFI_PROP_LEVEL,
 				     HFI_HOST_FLAGS_NONE,
-				     get_hfi_port(INPUT_MPLANE),
+				     get_hfi_port(inst, INPUT_MPLANE),
 				     HFI_PAYLOAD_U32_ENUM,
 				     &level,
 				     sizeof(u32));
@@ -559,7 +559,7 @@ static int vdec_set_tier(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 				     HFI_PROP_TIER,
 				     HFI_HOST_FLAGS_NONE,
-				     get_hfi_port(INPUT_MPLANE),
+				     get_hfi_port(inst, INPUT_MPLANE),
 				     HFI_PAYLOAD_U32_ENUM,
 				     &tier,
 				     sizeof(u32));
@@ -811,7 +811,7 @@ static int vdec_set_colorformat(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					 HFI_PROP_COLOR_FORMAT,
 					 HFI_HOST_FLAGS_NONE,
-					 get_hfi_port(OUTPUT_MPLANE),
+					 get_hfi_port(inst, OUTPUT_MPLANE),
 					 HFI_PAYLOAD_U32,
 					 &hfi_colorformat,
 					 sizeof(u32));
@@ -839,7 +839,7 @@ static int vdec_set_linear_stride_scanline(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 					 HFI_PROP_LINEAR_STRIDE_SCANLINE,
 					 HFI_HOST_FLAGS_NONE,
-					 get_hfi_port(OUTPUT_MPLANE),
+					 get_hfi_port(inst, OUTPUT_MPLANE),
 					 HFI_PAYLOAD_U64,
 					 &payload,
 					 sizeof(u64));
@@ -887,7 +887,7 @@ static int vdec_set_ubwc_stride_scanline(struct iris_inst *inst)
 	return iris_hfi_set_property(inst,
 				     HFI_PROP_UBWC_STRIDE_SCANLINE,
 				     HFI_HOST_FLAGS_NONE,
-				     get_hfi_port(OUTPUT_MPLANE),
+				     get_hfi_port(inst, OUTPUT_MPLANE),
 				     HFI_PAYLOAD_U32_ARRAY,
 				     &payload[0],
 				     sizeof(u32) * 4);
@@ -1020,7 +1020,7 @@ static int vdec_subscribe_dst_change_param(struct iris_inst *inst)
 			ret = iris_hfi_set_property(inst,
 						    prop_type,
 						    HFI_HOST_FLAGS_NONE,
-						    get_hfi_port(OUTPUT_MPLANE),
+						    get_hfi_port(inst, OUTPUT_MPLANE),
 						    payload_type,
 						    &payload,
 						    payload_size);
@@ -1032,42 +1032,6 @@ static int vdec_subscribe_dst_change_param(struct iris_inst *inst)
 	return ret;
 }
 
-static int process_streamon_input(struct iris_inst *inst)
-{
-	enum iris_inst_sub_state set_sub_state = IRIS_INST_SUB_NONE;
-	int ret;
-
-	iris_scale_power(inst);
-
-	ret = iris_hfi_start(inst, INPUT_MPLANE);
-	if (ret)
-		return ret;
-
-	if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
-		ret = iris_inst_change_sub_state(inst, IRIS_INST_SUB_INPUT_PAUSE, 0);
-		if (ret)
-			return ret;
-	}
-
-	if (inst->sub_state & IRIS_INST_SUB_DRC ||
-	    inst->sub_state & IRIS_INST_SUB_DRAIN) {
-		if (!(inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE)) {
-			ret = iris_hfi_pause(inst, INPUT_MPLANE);
-			if (ret)
-				return ret;
-			set_sub_state = IRIS_INST_SUB_INPUT_PAUSE;
-		}
-	}
-
-	ret = iris_inst_state_change_streamon(inst, INPUT_MPLANE);
-	if (ret)
-		return ret;
-
-	ret = iris_inst_change_sub_state(inst, 0, set_sub_state);
-
-	return ret;
-}
-
 int vdec_streamon_input(struct iris_inst *inst)
 {
 	int ret;
@@ -1114,58 +1078,6 @@ int vdec_streamon_input(struct iris_inst *inst)
 	return ret;
 }
 
-static int process_streamon_output(struct iris_inst *inst)
-{
-	enum iris_inst_sub_state clear_sub_state = IRIS_INST_SUB_NONE;
-	bool drain_pending = false;
-	int ret;
-
-	iris_scale_power(inst);
-
-	if (inst->sub_state & IRIS_INST_SUB_DRC &&
-	    inst->sub_state & IRIS_INST_SUB_DRC_LAST)
-		clear_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_DRC_LAST;
-
-	if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
-		ret = iris_alloc_and_queue_input_int_bufs(inst);
-		if (ret)
-			return ret;
-		ret = set_stage(inst, STAGE);
-		if (ret)
-			return ret;
-		ret = set_pipe(inst, PIPE);
-		if (ret)
-			return ret;
-	}
-
-	drain_pending = inst->sub_state & IRIS_INST_SUB_DRAIN &&
-		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
-
-	if (!drain_pending && inst->state == IRIS_INST_INPUT_STREAMING) {
-		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
-			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
-			if (ret)
-				return ret;
-			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
-		}
-	}
-
-	ret = iris_hfi_start(inst, OUTPUT_MPLANE);
-	if (ret)
-		return ret;
-
-	if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE)
-		clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
-
-	ret = iris_inst_state_change_streamon(inst, OUTPUT_MPLANE);
-	if (ret)
-		return ret;
-
-	ret = iris_inst_change_sub_state(inst, clear_sub_state, 0);
-
-	return ret;
-}
-
 int vdec_streamon_output(struct iris_inst *inst)
 {
 	int ret;
@@ -1220,27 +1132,6 @@ int vdec_streamon_output(struct iris_inst *inst)
 	return ret;
 }
 
-static int vb2_buffer_to_driver(struct vb2_buffer *vb2,
-				struct iris_buffer *buf)
-{
-	struct vb2_v4l2_buffer *vbuf;
-
-	if (!vb2 || !buf)
-		return -EINVAL;
-
-	vbuf = to_vb2_v4l2_buffer(vb2);
-
-	buf->fd = vb2->planes[0].m.fd;
-	buf->data_offset = vb2->planes[0].data_offset;
-	buf->data_size = vb2->planes[0].bytesused - vb2->planes[0].data_offset;
-	buf->buffer_size = vb2->planes[0].length;
-	buf->timestamp = vb2->timestamp;
-	buf->flags = vbuf->flags;
-	buf->attr = 0;
-
-	return 0;
-}
-
 int vdec_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2)
 {
 	struct iris_buffer *buf = NULL;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_venc.c b/drivers/media/platform/qcom/vcodec/iris/iris_venc.c
index 802db40..28c6b20 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_venc.c
@@ -13,6 +13,23 @@
 #include "iris_power.h"
 #include "iris_venc.h"
 
+#define SCALE_FACTOR 8
+#define UNSPECIFIED_COLOR_FORMAT 5
+
+static const u32 enc_input_properties[] = {
+	HFI_PROP_NO_OUTPUT,
+};
+
+static const u32 enc_output_properties[] = {
+	HFI_PROP_PICTURE_TYPE,
+	HFI_PROP_BUFFER_MARK,
+};
+
+struct venc_prop_type_handle {
+	u32 type;
+	int (*handle)(struct iris_inst *inst);
+};
+
 int venc_inst_init(struct iris_inst *inst)
 {
 	struct v4l2_format *f;
@@ -523,3 +540,409 @@ int venc_stop_cmd(struct iris_inst *inst)
 
 	return ret;
 }
+
+int venc_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2)
+{
+	struct iris_buffer *buf = NULL;
+	int ret;
+
+	buf = get_driver_buf(inst, vb2->type, vb2->index);
+	if (!buf)
+		return -EINVAL;
+
+	ret = vb2_buffer_to_driver(vb2, buf);
+	if (ret)
+		return ret;
+
+	if (!allow_qbuf(inst, vb2->type)) {
+		buf->attr |= BUF_ATTR_DEFERRED;
+		return 0;
+	}
+
+	iris_scale_power(inst);
+
+	return queue_buffer(inst, buf);
+}
+
+static int check_scaling_supported(struct iris_inst *inst)
+{
+	u32 iwidth, owidth, iheight, oheight;
+
+	if (!(inst->crop.left != inst->compose.left ||
+	      inst->crop.top != inst->compose.top ||
+	      inst->crop.width != inst->compose.width ||
+	      inst->crop.height != inst->compose.height))
+		return 0;
+
+	iwidth = inst->crop.width;
+	iheight = inst->crop.height;
+	owidth = inst->compose.width;
+	oheight = inst->compose.height;
+
+	if (owidth > iwidth || oheight > iheight)
+		return -EINVAL;
+
+	if (iwidth > owidth * SCALE_FACTOR || iheight > oheight * SCALE_FACTOR)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int venc_set_colorformat(struct iris_inst *inst)
+{
+	u32 hfi_colorformat;
+	u32 pixelformat;
+
+	pixelformat = inst->fmt_src->fmt.pix_mp.pixelformat;
+	hfi_colorformat = get_hfi_colorformat(pixelformat);
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_COLOR_FORMAT,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(inst, INPUT_MPLANE),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &hfi_colorformat,
+				     sizeof(u32));
+}
+
+static int venc_set_stride_scanline(struct iris_inst *inst)
+{
+	u32 color_format, stride_y, scanline_y;
+	u32 stride_uv = 0, scanline_uv = 0;
+	u32 payload[2];
+
+	color_format = inst->cap[PIX_FMTS].value;
+	if (!is_linear_colorformat(color_format))
+		return 0;
+
+	stride_y = color_format == FMT_TP10C ?
+		ALIGN(inst->fmt_src->fmt.pix_mp.width, 192) :
+		ALIGN(inst->fmt_src->fmt.pix_mp.width, 128);
+	scanline_y = color_format == FMT_TP10C ?
+		ALIGN(inst->fmt_src->fmt.pix_mp.height, 16) :
+		ALIGN(inst->fmt_src->fmt.pix_mp.height, 32);
+
+	if (color_format == FMT_NV12 ||
+	    color_format == FMT_NV21) {
+		stride_uv = stride_y;
+		scanline_uv = scanline_y / 2;
+	}
+
+	payload[0] = stride_y << 16 | scanline_y;
+	payload[1] = stride_uv << 16 | scanline_uv;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_LINEAR_STRIDE_SCANLINE,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(inst, INPUT_MPLANE),
+				     HFI_PAYLOAD_64_PACKED,
+				     &payload,
+				     sizeof(u64));
+}
+
+static int venc_set_raw_resolution(struct iris_inst *inst)
+{
+	u32 resolution;
+
+	resolution = (inst->fmt_src->fmt.pix_mp.width << 16) |
+		inst->fmt_src->fmt.pix_mp.height;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_RAW_RESOLUTION,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(inst, INPUT_MPLANE),
+				     HFI_PAYLOAD_32_PACKED,
+				     &resolution,
+				     sizeof(u32));
+}
+
+static int venc_set_bitstream_resolution(struct iris_inst *inst)
+{
+	u32 resolution;
+
+	resolution = (inst->fmt_dst->fmt.pix_mp.width << 16) |
+		inst->fmt_dst->fmt.pix_mp.height;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_BITSTREAM_RESOLUTION,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(inst, OUTPUT_MPLANE),
+				     HFI_PAYLOAD_32_PACKED,
+				     &resolution,
+				     sizeof(u32));
+}
+
+static int venc_set_inp_crop_offsets(struct iris_inst *inst)
+{
+	u32 left_offset, top_offset, right_offset, bottom_offset;
+	u32 crop[2] = {0};
+	u32 width, height;
+
+	left_offset = inst->crop.left;
+	top_offset = inst->crop.top;
+	width = inst->crop.width;
+	height = inst->crop.height;
+
+	right_offset = (inst->fmt_src->fmt.pix_mp.width - width);
+	bottom_offset = (inst->fmt_src->fmt.pix_mp.height - height);
+
+	crop[0] = left_offset << 16 | top_offset;
+	crop[1] = right_offset << 16 | bottom_offset;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_CROP_OFFSETS,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(inst, INPUT_MPLANE),
+				     HFI_PAYLOAD_64_PACKED,
+				     &crop,
+				     sizeof(u64));
+}
+
+static int venc_set_out_crop_offsets(struct iris_inst *inst)
+{
+	u32 left_offset, top_offset, right_offset, bottom_offset;
+	u32 crop[2] = {0};
+	u32 width, height;
+
+	left_offset = inst->compose.left;
+	top_offset = inst->compose.top;
+	width = inst->compose.width;
+	height = inst->compose.height;
+	if (inst->cap[ROTATION].value == 90 || inst->cap[ROTATION].value == 270) {
+		width = inst->compose.height;
+		height = inst->compose.width;
+	}
+
+	right_offset = (inst->fmt_dst->fmt.pix_mp.width - width);
+	bottom_offset = (inst->fmt_dst->fmt.pix_mp.height - height);
+
+	crop[0] = left_offset << 16 | top_offset;
+	crop[1] = right_offset << 16 | bottom_offset;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_CROP_OFFSETS,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(inst, OUTPUT_MPLANE),
+				     HFI_PAYLOAD_64_PACKED,
+				     &crop,
+				     sizeof(u64));
+}
+
+static int venc_set_colorspace(struct iris_inst *inst)
+{
+	u32 video_signal_type_present_flag = 0, payload = 0;
+	u32 matrix_coeff = HFI_MATRIX_COEFF_RESERVED;
+	u32 video_format = UNSPECIFIED_COLOR_FORMAT;
+	struct v4l2_pix_format_mplane *pixmp = NULL;
+	u32 transfer_char = HFI_TRANSFER_RESERVED;
+	u32 colour_description_present_flag = 0;
+	u32 primaries = HFI_PRIMARIES_RESERVED;
+	u32 full_range = 0;
+
+	pixmp = &inst->fmt_src->fmt.pix_mp;
+	if (pixmp->colorspace != V4L2_COLORSPACE_DEFAULT ||
+	    pixmp->ycbcr_enc != V4L2_YCBCR_ENC_DEFAULT ||
+	    pixmp->xfer_func != V4L2_XFER_FUNC_DEFAULT) {
+		colour_description_present_flag = 1;
+		video_signal_type_present_flag = 1;
+		primaries = get_hfi_color_primaries(pixmp->colorspace);
+		matrix_coeff = get_hfi_matrix_coefficients(pixmp->ycbcr_enc);
+		transfer_char = get_hfi_transfer_char(pixmp->xfer_func);
+	}
+
+	if (pixmp->quantization != V4L2_QUANTIZATION_DEFAULT) {
+		video_signal_type_present_flag = 1;
+		full_range = pixmp->quantization ==
+			V4L2_QUANTIZATION_FULL_RANGE ? 1 : 0;
+	}
+
+	payload = (matrix_coeff & 0xFF) |
+		((transfer_char << 8) & 0xFF00) |
+		((primaries << 16) & 0xFF0000) |
+		((colour_description_present_flag << 24) & 0x1000000) |
+		((full_range << 25) & 0x2000000) |
+		((video_format << 26) & 0x1C000000) |
+		((video_signal_type_present_flag << 29) & 0x20000000);
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_SIGNAL_COLOR_INFO,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(inst, INPUT_MPLANE),
+				     HFI_PAYLOAD_32_PACKED,
+				     &payload,
+				     sizeof(u32));
+}
+
+static int venc_set_quality_mode(struct iris_inst *inst)
+{
+	u32 mode;
+
+	mode = decide_quality_mode(inst);
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_QUALITY_MODE,
+				     HFI_HOST_FLAGS_NONE,
+				     HFI_PORT_BITSTREAM,
+				     HFI_PAYLOAD_U32_ENUM,
+				     &mode,
+				     sizeof(u32));
+}
+
+static int venc_set_input_properties(struct iris_inst *inst)
+{
+	int j, ret;
+	static const struct venc_prop_type_handle prop_type_handle_arr[] = {
+		{HFI_PROP_COLOR_FORMAT,               venc_set_colorformat                 },
+		{HFI_PROP_RAW_RESOLUTION,             venc_set_raw_resolution              },
+		{HFI_PROP_CROP_OFFSETS,               venc_set_inp_crop_offsets            },
+		{HFI_PROP_LINEAR_STRIDE_SCANLINE,     venc_set_stride_scanline             },
+		{HFI_PROP_SIGNAL_COLOR_INFO,          venc_set_colorspace                  },
+	};
+
+	for (j = 0; j < ARRAY_SIZE(prop_type_handle_arr); j++) {
+		ret = prop_type_handle_arr[j].handle(inst);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int venc_property_subscription(struct iris_inst *inst, u32 plane)
+{
+	u32 payload[32] = {0};
+	u32 payload_size = 0;
+	u32 i;
+
+	payload[0] = HFI_MODE_PROPERTY;
+	if (plane == INPUT_MPLANE) {
+		for (i = 0; i < ARRAY_SIZE(enc_input_properties); i++)
+			payload[i + 1] = enc_input_properties[i];
+		payload_size = (ARRAY_SIZE(enc_input_properties) + 1) *
+				sizeof(u32);
+	} else if (plane == OUTPUT_MPLANE) {
+		for (i = 0; i < ARRAY_SIZE(enc_output_properties); i++)
+			payload[i + 1] = enc_output_properties[i];
+		payload_size = (ARRAY_SIZE(enc_output_properties) + 1) *
+				sizeof(u32);
+	} else {
+		return -EINVAL;
+	}
+
+	return iris_hfi_session_subscribe_mode(inst,
+					       HFI_CMD_SUBSCRIBE_MODE,
+					       plane,
+					       HFI_PAYLOAD_U32_ARRAY,
+					       &payload[0],
+					       payload_size);
+}
+
+int venc_streamon_input(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = check_session_supported(inst);
+	if (ret)
+		goto error;
+
+	ret = check_scaling_supported(inst);
+	if (ret)
+		goto error;
+
+	ret = venc_set_input_properties(inst);
+	if (ret)
+		goto error;
+
+	ret = iris_get_internal_buffers(inst, INPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = iris_destroy_internal_buffers(inst, INPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = iris_create_input_internal_buffers(inst);
+	if (ret)
+		goto error;
+
+	ret = iris_queue_input_internal_buffers(inst);
+	if (ret)
+		goto error;
+
+	ret = venc_property_subscription(inst, INPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = process_streamon_input(inst);
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	return ret;
+}
+
+static int venc_set_output_properties(struct iris_inst *inst)
+{
+	int j, ret;
+	static const struct venc_prop_type_handle prop_type_handle_arr[] = {
+		{HFI_PROP_BITSTREAM_RESOLUTION,       venc_set_bitstream_resolution    },
+		{HFI_PROP_CROP_OFFSETS,               venc_set_out_crop_offsets        },
+	};
+
+	for (j = 0; j < ARRAY_SIZE(prop_type_handle_arr); j++) {
+		ret = prop_type_handle_arr[j].handle(inst);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int venc_streamon_output(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = venc_set_output_properties(inst);
+	if (ret)
+		goto error;
+
+	ret = set_v4l2_properties(inst);
+	if (ret)
+		goto error;
+
+	ret = venc_set_quality_mode(inst);
+	if (ret)
+		goto error;
+
+	ret = iris_get_internal_buffers(inst, OUTPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = iris_destroy_internal_buffers(inst, OUTPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = iris_create_output_internal_buffers(inst);
+	if (ret)
+		goto error;
+
+	ret = iris_queue_output_internal_buffers(inst);
+	if (ret)
+		goto error;
+
+	ret = venc_property_subscription(inst, OUTPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = process_streamon_output(inst);
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	session_streamoff(inst, OUTPUT_MPLANE);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_venc.h b/drivers/media/platform/qcom/vcodec/iris/iris_venc.h
index 24da63f..b289750 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_venc.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_venc.h
@@ -20,5 +20,8 @@ int venc_subscribe_event(struct iris_inst *inst,
 			 const struct v4l2_event_subscription *sub);
 int venc_start_cmd(struct iris_inst *inst);
 int venc_stop_cmd(struct iris_inst *inst);
+int venc_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2);
+int venc_streamon_input(struct iris_inst *inst);
+int venc_streamon_output(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index effecbb..42ac662 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -71,6 +71,11 @@ enum pipe_type {
 	PIPE_4 = 4,
 };
 
+enum quality_mode {
+	MAX_QUALITY_MODE = 0x1,
+	POWER_SAVE_MODE = 0x2,
+};
+
 extern struct platform_data sm8550_data;
 
 struct bw_info {
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index ef0aad7..17c5856 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -74,6 +74,8 @@ static struct plat_core_cap core_data_sm8550[] = {
 	{CP_SIZE, 0x25800000},
 	{CP_NONPIXEL_START, 0x01000000},
 	{CP_NONPIXEL_SIZE, 0x24800000},
+	{MAX_MBPF_HQ, 8160}, /* ((1920x1088)/256) */
+	{MAX_MBPS_HQ, 489600}, /* ((1920x1088)/256)@60fps */
 };
 
 static struct plat_inst_cap instance_cap_data_sm8550[] = {
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
index 44f9342..9882f00 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.c
@@ -163,6 +163,186 @@ static u32 dec_dpb_size_iris3(struct iris_inst *inst)
 	return size;
 }
 
+static u32 enc_bin_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, num_vpp_pipes, stage, profile;
+	struct iris_core *core;
+	struct v4l2_format *f;
+	u32 size = 0;
+
+	core = inst->core;
+
+	num_vpp_pipes = core->cap[NUM_VPP_PIPE].value;
+	stage = inst->cap[STAGE].value;
+	f = inst->fmt_dst;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+	profile = inst->cap[PROFILE].value;
+
+	if (inst->codec == H264)
+		size = hfi_buffer_bin_h264e(inst->hfi_rc_type, width, height,
+					    stage, num_vpp_pipes, profile);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_bin_h265e(inst->hfi_rc_type, width, height,
+					    stage, num_vpp_pipes, profile);
+
+	return size;
+}
+
+u32 get_recon_buf_count(struct iris_inst *inst)
+{
+	s32 n_bframe, ltr_count, hp_layers = 0, hb_layers = 0;
+	bool is_hybrid_hp = false;
+	u32 num_buf_recon = 0;
+	u32 hfi_codec = 0;
+
+	n_bframe = inst->cap[B_FRAME].value;
+	ltr_count = inst->cap[LTR_COUNT].value;
+
+	if (inst->hfi_layer_type == HFI_HIER_B) {
+		hb_layers = inst->cap[ENH_LAYER_COUNT].value + 1;
+	} else {
+		hp_layers = inst->cap[ENH_LAYER_COUNT].value + 1;
+		if (inst->hfi_layer_type == HFI_HIER_P_HYBRID_LTR)
+			is_hybrid_hp = true;
+	}
+
+	if (inst->codec == H264)
+		hfi_codec = HFI_CODEC_ENCODE_AVC;
+	else if (inst->codec == HEVC)
+		hfi_codec = HFI_CODEC_ENCODE_HEVC;
+
+	num_buf_recon = hfi_iris3_enc_recon_buf_count(n_bframe, ltr_count,
+						      hp_layers, hb_layers,
+						      is_hybrid_hp, hfi_codec);
+
+	return num_buf_recon;
+}
+
+static u32 enc_comv_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, num_recon = 0;
+	struct v4l2_format *f;
+	u32 size = 0;
+
+	f = inst->fmt_dst;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	num_recon = get_recon_buf_count(inst);
+	if (inst->codec == H264)
+		size = hfi_buffer_comv_h264e(width, height, num_recon);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_comv_h265e(width, height, num_recon);
+
+	return size;
+}
+
+static u32 enc_non_comv_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, num_vpp_pipes;
+	struct iris_core *core;
+	struct v4l2_format *f;
+	u32 size = 0;
+
+	core = inst->core;
+
+	num_vpp_pipes = core->cap[NUM_VPP_PIPE].value;
+	f = inst->fmt_dst;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	if (inst->codec == H264)
+		size = hfi_buffer_non_comv_h264e(width, height, num_vpp_pipes);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_non_comv_h265e(width, height, num_vpp_pipes);
+
+	return size;
+}
+
+static u32 enc_line_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, pixfmt, num_vpp_pipes;
+	struct iris_core *core;
+	bool is_tenbit = false;
+	struct v4l2_format *f;
+	u32 size = 0;
+
+	core = inst->core;
+	num_vpp_pipes = core->cap[NUM_VPP_PIPE].value;
+	pixfmt = inst->cap[PIX_FMTS].value;
+
+	f = inst->fmt_dst;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+	is_tenbit = (pixfmt == FMT_TP10C);
+
+	if (inst->codec == H264)
+		size = hfi_buffer_line_h264e(width, height, is_tenbit, num_vpp_pipes);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_line_h265e(width, height, is_tenbit, num_vpp_pipes);
+
+	return size;
+}
+
+static u32 enc_dpb_size_iris3(struct iris_inst *inst)
+{
+	u32 width, height, pixfmt;
+	struct v4l2_format *f;
+	bool is_tenbit;
+	u32 size = 0;
+
+	f = inst->fmt_dst;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	pixfmt = inst->cap[PIX_FMTS].value;
+	is_tenbit = (pixfmt == FMT_TP10C);
+
+	if (inst->codec == H264)
+		size = hfi_buffer_dpb_h264e(width, height);
+	else if (inst->codec == HEVC)
+		size = hfi_buffer_dpb_h265e(width, height, is_tenbit);
+
+	return size;
+}
+
+static u32 enc_arp_size_iris3(struct iris_inst *inst)
+{
+	u32 size = 0;
+
+	HFI_BUFFER_ARP_ENC(size);
+
+	return size;
+}
+
+static u32 enc_vpss_size_iris3(struct iris_inst *inst)
+{
+	bool ds_enable = false, is_tenbit = false;
+	struct v4l2_format *f;
+	u32 width, height;
+	u32 size = 0;
+
+	ds_enable = is_scaling_enabled(inst);
+
+	f = inst->fmt_dst;
+	if (inst->cap[ROTATION].value == 90 ||
+	    inst->cap[ROTATION].value == 270) {
+		width = f->fmt.pix_mp.height;
+		height = f->fmt.pix_mp.width;
+	} else {
+		width = f->fmt.pix_mp.width;
+		height = f->fmt.pix_mp.height;
+	}
+
+	f = inst->fmt_src;
+	is_tenbit = is_10bit_colorformat(f->fmt.pix_mp.pixelformat);
+
+	size = hfi_buffer_vpss_enc(width, height, ds_enable, 0, is_tenbit);
+
+	return size;
+}
+
 struct iris_buf_type_handle {
 	enum iris_buffer_type type;
 	u32 (*handle)(struct iris_inst *inst);
@@ -183,9 +363,23 @@ int iris_int_buf_size_iris3(struct iris_inst *inst,
 		{BUF_PERSIST,         dec_persist_size_iris3      },
 		{BUF_DPB,             dec_dpb_size_iris3          },
 	};
+	static const struct iris_buf_type_handle enc_internal_buf_type_handle[] = {
+		{BUF_BIN,             enc_bin_size_iris3          },
+		{BUF_COMV,            enc_comv_size_iris3         },
+		{BUF_NON_COMV,        enc_non_comv_size_iris3     },
+		{BUF_LINE,            enc_line_size_iris3         },
+		{BUF_DPB,             enc_dpb_size_iris3          },
+		{BUF_ARP,             enc_arp_size_iris3          },
+		{BUF_VPSS,            enc_vpss_size_iris3         },
+	};
 
-	buf_type_handle_size = ARRAY_SIZE(dec_internal_buf_type_handle);
-	buf_type_handle_arr = dec_internal_buf_type_handle;
+	if (inst->domain == DECODER) {
+		buf_type_handle_size = ARRAY_SIZE(dec_internal_buf_type_handle);
+		buf_type_handle_arr = dec_internal_buf_type_handle;
+	} else if (inst->domain == ENCODER) {
+		buf_type_handle_size = ARRAY_SIZE(enc_internal_buf_type_handle);
+		buf_type_handle_arr = enc_internal_buf_type_handle;
+	}
 
 	if (!buf_type_handle_arr || !buf_type_handle_size)
 		return size;
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h
index b520c79..c63b3ac 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_buffer.h
@@ -14,8 +14,10 @@
 
 #define DMA_ALIGNMENT 256
 
+#define BUFFER_ALIGNMENT_4096_BYTES 4096
 #define BUFFER_ALIGNMENT_512_BYTES 512
 #define BUFFER_ALIGNMENT_256_BYTES 256
+#define BUFFER_ALIGNMENT_128_BYTES 128
 #define BUFFER_ALIGNMENT_64_BYTES 64
 #define BUFFER_ALIGNMENT_32_BYTES 32
 #define BUFFER_ALIGNMENT_16_BYTES 16
@@ -26,6 +28,8 @@
 #define HFI_COL_FMT_NV12C_Y_TILE_WIDTH (32)
 #define HFI_COL_FMT_NV12C_UV_TILE_HEIGHT (8)
 #define HFI_COL_FMT_NV12C_UV_TILE_WIDTH (16)
+#define HFI_COL_FMT_TP10C_Y_TILE_HEIGHT (4)
+#define HFI_COL_FMT_TP10C_Y_TILE_WIDTH (48)
 
 #define NUM_HW_PIC_BUF 32
 #define SIZE_HW_PIC(size_per_buf) (NUM_HW_PIC_BUF * (size_per_buf))
@@ -102,6 +106,27 @@
 #define MAX_PE_NBR_DATA_LCU64_LINE_BUFFER_SIZE (64 * 2 * 3)
 #define MAX_FE_NBR_DATA_LUMA_LINE_BUFFER_SIZE 640
 
+#define HFI_BUFFER_ARP_ENC(size) (size = 204800)
+
+#define HFI_MAX_COL_FRAME 6
+#define HFI_VENUS_WIDTH_ALIGNMENT 128
+#define HFI_VENUS_HEIGHT_ALIGNMENT 32
+#define VENUS_METADATA_STRIDE_MULTIPLE 64
+#define VENUS_METADATA_HEIGHT_MULTIPLE 16
+
+#ifndef SYSTEM_LAL_TILE10
+#define SYSTEM_LAL_TILE10 192
+#endif
+
+#define SIZE_SLICE_CMD_BUFFER (ALIGN(20480, BUFFER_ALIGNMENT_256_BYTES))
+#define SIZE_SPS_PPS_SLICE_HDR (2048 + 4096)
+
+#define SIZE_BSE_SLICE_CMD_BUF ((((8192 << 2) + 7) & (~7)) * 3)
+#define SIZE_LAMBDA_LUT (256 * 11)
+
+#define HFI_WORKMODE_1 1
+#define HFI_WORKMODE_2 2
+
 static inline
 u32 size_h264d_hw_bin_buffer(u32 frame_width, u32 frame_height,
 			     u32 num_vpp_pipes)
@@ -842,4 +867,603 @@ u32 hfi_yuv420_tp10_ubwc_calc_buf_size(u32 y_stride, u32 y_buf_height,
 int iris_int_buf_size_iris3(struct iris_inst *inst,
 			    enum iris_buffer_type buffer_type);
 
+static inline
+u32 hfi_iris3_enc_recon_buf_count(s32 n_bframe, s32 ltr_count,
+				  s32 _total_hp_layers,
+				  s32 _total_hb_layers,
+				  bool hybrid_hp,
+				  u32 codec_standard)
+{
+	u32 num_ref = 1;
+
+	if (n_bframe)
+		num_ref = 2;
+
+	if (_total_hp_layers > 1) {
+		if (hybrid_hp)
+			num_ref = (_total_hp_layers + 1) >> 1;
+		else if (codec_standard == HFI_CODEC_ENCODE_HEVC)
+			num_ref = (_total_hp_layers + 1) >> 1;
+		else if (codec_standard == HFI_CODEC_ENCODE_AVC &&
+			 _total_hp_layers < 4)
+			num_ref = (_total_hp_layers - 1);
+		else
+			num_ref = _total_hp_layers;
+	}
+
+	if (ltr_count)
+		num_ref = num_ref + ltr_count;
+
+	if (_total_hb_layers > 1) {
+		if (codec_standard == HFI_CODEC_ENCODE_HEVC)
+			num_ref = (_total_hb_layers);
+		else if (codec_standard == HFI_CODEC_ENCODE_AVC)
+			num_ref = (1 << (_total_hb_layers - 2)) + 1;
+	}
+
+	return num_ref + 1;
+}
+
+static inline
+u32 size_bin_bitstream_enc(u32 rc_type, u32 frame_width, u32 frame_height,
+			   u32 work_mode, u32 lcu_size, u32 profile)
+{
+	u32 size_aligned_width = 0, size_aligned_height = 0;
+	u32 bitstream_size_eval = 0;
+
+	size_aligned_width = ALIGN((frame_width), lcu_size);
+	size_aligned_height = ALIGN((frame_height), lcu_size);
+	if (work_mode == HFI_WORKMODE_2) {
+		if (rc_type == HFI_RC_CQ || rc_type == HFI_RC_OFF) {
+			bitstream_size_eval = (((size_aligned_width) *
+						(size_aligned_height) * 3) >> 1);
+		} else {
+			bitstream_size_eval = ((size_aligned_width) *
+					       (size_aligned_height) * 3);
+			if ((size_aligned_width * size_aligned_height) > (4096 * 2176))
+				bitstream_size_eval >>= 3;
+			else if ((size_aligned_width * size_aligned_height) > (480 * 320))
+				bitstream_size_eval >>= 2;
+
+			if (profile == HFI_H265_PROFILE_MAIN_10 ||
+			    profile == HFI_H265_PROFILE_MAIN_10_STILL_PICTURE)
+				bitstream_size_eval = (bitstream_size_eval * 5 >> 2);
+		}
+	} else {
+		bitstream_size_eval = size_aligned_width * size_aligned_height * 3;
+	}
+
+	return ALIGN(bitstream_size_eval, BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_enc_single_pipe(u32 rc_type, u32 bitbin_size, u32 num_vpp_pipes,
+			 u32 frame_width, u32 frame_height, u32 lcu_size)
+{
+	u32 size_single_pipe_eval = 0, sao_bin_buffer_size = 0;
+	u32 size_aligned_width = 0, size_aligned_height = 0;
+	u32 _padded_bin_sz = 0;
+
+	size_aligned_width = ALIGN((frame_width), lcu_size);
+	size_aligned_height = ALIGN((frame_height), lcu_size);
+	if ((size_aligned_width * size_aligned_height) > (3840 * 2160))
+		size_single_pipe_eval = (bitbin_size / num_vpp_pipes);
+	else if (num_vpp_pipes > 2)
+		size_single_pipe_eval = bitbin_size / 2;
+	else
+		size_single_pipe_eval = bitbin_size;
+
+	sao_bin_buffer_size =
+		(64 * ((((frame_width) + BUFFER_ALIGNMENT_32_BYTES) *
+			((frame_height) + BUFFER_ALIGNMENT_32_BYTES)) >> 10)) + 384;
+	_padded_bin_sz = ALIGN(size_single_pipe_eval, BUFFER_ALIGNMENT_256_BYTES);
+	size_single_pipe_eval = sao_bin_buffer_size + _padded_bin_sz;
+	size_single_pipe_eval = ALIGN(size_single_pipe_eval, BUFFER_ALIGNMENT_256_BYTES);
+
+	return size_single_pipe_eval;
+}
+
+static inline
+u32 hfi_buffer_bin_enc(u32 rc_type, u32 frame_width, u32 frame_height, u32 lcu_size,
+		       u32 work_mode, u32 num_vpp_pipes, u32 profile)
+{
+	u32 bitstream_size = 0, total_bitbin_buffers = 0;
+	u32 size_single_pipe = 0, bitbin_size = 0;
+	u32 _size = 0;
+
+	bitstream_size = size_bin_bitstream_enc(rc_type, frame_width,
+						frame_height, work_mode,
+						lcu_size, profile);
+
+	if (work_mode == HFI_WORKMODE_2) {
+		total_bitbin_buffers = 3;
+		bitbin_size = bitstream_size * 12 / 10;
+		bitbin_size = ALIGN(bitbin_size, BUFFER_ALIGNMENT_256_BYTES);
+	} else if ((lcu_size == 16) || (num_vpp_pipes > 1)) {
+		total_bitbin_buffers = 1;
+		bitbin_size = bitstream_size;
+	}
+
+	if (total_bitbin_buffers > 0) {
+		size_single_pipe = size_enc_single_pipe(rc_type, bitbin_size,
+							num_vpp_pipes, frame_width,
+							frame_height, lcu_size);
+		bitbin_size = size_single_pipe * num_vpp_pipes;
+		_size = ALIGN(bitbin_size, BUFFER_ALIGNMENT_256_BYTES) *
+			      total_bitbin_buffers + 512;
+	} else {
+		/* Avoid 512 Bytes allocation in case of 1Pipe HEVC Direct Mode*/
+		_size = 0;
+	}
+
+	return _size;
+}
+
+static inline
+u32 hfi_buffer_bin_h264e(u32 rc_type, u32 frame_width, u32 frame_height,
+			 u32 work_mode, u32 num_vpp_pipes, u32 profile)
+{
+	return hfi_buffer_bin_enc(rc_type, frame_width, frame_height, 16,
+				  work_mode, num_vpp_pipes, profile);
+}
+
+static inline
+u32 hfi_buffer_bin_h265e(u32 rc_type, u32 frame_width, u32 frame_height,
+			 u32 work_mode, u32 num_vpp_pipes, u32 profile)
+{
+	return hfi_buffer_bin_enc(rc_type, frame_width, frame_height, 32,
+				  work_mode, num_vpp_pipes, profile);
+}
+
+static inline
+u32 size_enc_slice_info_buf(u32 num_lcu_in_frame)
+{
+	return ALIGN((256 + (num_lcu_in_frame << 4)), BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_line_buf_ctrl(u32 frame_width_coded)
+{
+	return ALIGN(frame_width_coded, BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_line_buf_ctrl_id2(u32 frame_width_coded)
+{
+	return ALIGN(frame_width_coded, BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_linebuff_data(bool is_ten_bit, u32 frame_width_coded)
+{
+	u32 _size = 0;
+
+	_size = is_ten_bit ?
+		(((((10 * (frame_width_coded) + 1024) + (BUFFER_ALIGNMENT_256_BYTES - 1)) &
+		   (~(BUFFER_ALIGNMENT_256_BYTES - 1))) * 1) +
+		 (((((10 * (frame_width_coded) + 1024) >> 1) + (BUFFER_ALIGNMENT_256_BYTES - 1)) &
+		   (~(BUFFER_ALIGNMENT_256_BYTES - 1))) * 2)) :
+		(((((8 * (frame_width_coded) + 1024) + (BUFFER_ALIGNMENT_256_BYTES - 1)) &
+		   (~(BUFFER_ALIGNMENT_256_BYTES - 1))) * 1) +
+		 (((((8 * (frame_width_coded) + 1024) >> 1) + (BUFFER_ALIGNMENT_256_BYTES - 1)) &
+		   (~(BUFFER_ALIGNMENT_256_BYTES - 1))) * 2));
+
+	return _size;
+}
+
+static inline
+u32 size_left_linebuff_ctrl(u32 standard, u32 frame_height_coded,
+			    u32 num_vpp_pipes_enc)
+{
+	u32 _size = 0;
+
+	_size = standard == HFI_CODEC_ENCODE_HEVC ?
+		(((frame_height_coded) +
+		 (BUFFER_ALIGNMENT_32_BYTES)) / BUFFER_ALIGNMENT_32_BYTES * 4 * 16) :
+		(((frame_height_coded) + 15) / 16 * 5 * 16);
+
+	if ((num_vpp_pipes_enc) > 1) {
+		_size += BUFFER_ALIGNMENT_512_BYTES;
+		_size = ALIGN(_size, BUFFER_ALIGNMENT_512_BYTES) *
+			num_vpp_pipes_enc;
+	}
+
+	return ALIGN(_size, BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_left_linebuff_recon_pix(bool is_ten_bit, u32 frame_height_coded,
+				 u32 num_vpp_pipes_enc)
+{
+	return (((is_ten_bit + 1) * 2 * (frame_height_coded) + BUFFER_ALIGNMENT_256_BYTES) +
+		(BUFFER_ALIGNMENT_256_BYTES << (num_vpp_pipes_enc - 1)) - 1) &
+		(~((BUFFER_ALIGNMENT_256_BYTES << (num_vpp_pipes_enc - 1)) - 1)) * 1;
+}
+
+static inline
+u32 size_top_linebuff_ctrl_fe(u32 frame_width_coded, u32 standard)
+{
+	u32 _size = 0;
+
+	_size = standard == HFI_CODEC_ENCODE_HEVC ?
+		(64 * ((frame_width_coded) >> 5)) :
+		(BUFFER_ALIGNMENT_256_BYTES + 16 * ((frame_width_coded) >> 4));
+
+	return ALIGN(_size, BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_left_linebuff_ctrl_fe(u32 frame_height_coded, u32 num_vpp_pipes_enc)
+{
+	return (((BUFFER_ALIGNMENT_256_BYTES + 64 * ((frame_height_coded) >> 4)) +
+		 (BUFFER_ALIGNMENT_256_BYTES << (num_vpp_pipes_enc - 1)) - 1) &
+		 (~((BUFFER_ALIGNMENT_256_BYTES << (num_vpp_pipes_enc - 1)) - 1)) * 1) *
+		num_vpp_pipes_enc;
+}
+
+static inline
+u32 size_left_linebuff_metadata_recon_y(u32 frame_height_coded,
+					bool is_ten_bit,
+					u32 num_vpp_pipes_enc)
+{
+	u32 _size = 0;
+
+	_size = ((BUFFER_ALIGNMENT_256_BYTES + 64 * ((frame_height_coded) /
+		  (8 * (is_ten_bit ? 4 : 8)))));
+	_size = ALIGN(_size, BUFFER_ALIGNMENT_256_BYTES);
+
+	return (_size * num_vpp_pipes_enc);
+}
+
+static inline
+u32 size_left_linebuff_metadata_recon_uv(u32 frame_height_coded,
+					 bool is_ten_bit,
+					 u32 num_vpp_pipes_enc)
+{
+	u32 _size = 0;
+
+	_size = ((BUFFER_ALIGNMENT_256_BYTES + 64 * ((frame_height_coded) /
+		  (4 * (is_ten_bit ? 4 : 8)))));
+	_size = ALIGN(_size, BUFFER_ALIGNMENT_256_BYTES);
+
+	return (_size * num_vpp_pipes_enc);
+}
+
+static inline
+u32 size_linebuff_recon_pix(bool is_ten_bit, u32 frame_width_coded)
+{
+	return ALIGN(((is_ten_bit ? 3 : 2) * (frame_width_coded)),
+		     BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_frame_rc_buf_size(u32 standard, u32 frame_height_coded,
+			   u32 num_vpp_pipes_enc)
+{
+	u32 _size = 0;
+
+	_size = (standard == HFI_CODEC_ENCODE_HEVC) ?
+		(256 + 16 * (14 + ((((frame_height_coded) >> 5) + 7) >> 3))) :
+		(256 + 16 * (14 + ((((frame_height_coded) >> 4) + 7) >> 3)));
+	_size *= 11;
+	if (num_vpp_pipes_enc > 1)
+		_size = ALIGN(_size, BUFFER_ALIGNMENT_256_BYTES) * num_vpp_pipes_enc;
+
+	return ALIGN(_size, BUFFER_ALIGNMENT_512_BYTES) * HFI_MAX_COL_FRAME;
+}
+
+static inline u32 enc_bitcnt_buf_size(u32 num_lcu_in_frame)
+{
+	return ALIGN((256 + (4 * (num_lcu_in_frame))), BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline u32 enc_bitmap_buf_size(u32 num_lcu_in_frame)
+{
+	return ALIGN((256 + ((num_lcu_in_frame) >> 3)), BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline u32 size_line_buf_sde(u32 frame_width_coded)
+{
+	return ALIGN((256 + (16 * ((frame_width_coded) >> 4))), BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline u32 size_override_buf(u32 num_lcumb)
+{
+	return ALIGN(((16 * (((num_lcumb) + 7) >> 3))), BUFFER_ALIGNMENT_256_BYTES) * 2;
+}
+
+static inline u32 size_ir_buf(u32 num_lcu_in_frame)
+{
+	return ALIGN((((((num_lcu_in_frame) << 1) + 7) & (~7)) * 3), BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_vpss_line_buf(u32 num_vpp_pipes_enc, u32 frame_height_coded,
+		       u32 frame_width_coded)
+{
+	return ALIGN(((((((8192) >> 2) << 5) * (num_vpp_pipes_enc)) + 64) +
+		      (((((max_t(u32, (frame_width_coded),
+				 (frame_height_coded)) + 3) >> 2) << 5) + 256) * 16)),
+		     BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 size_top_line_buf_first_stg_sao(u32 frame_width_coded)
+{
+	return ALIGN((16 * ((frame_width_coded) >> 5)), BUFFER_ALIGNMENT_256_BYTES);
+}
+
+static inline
+u32 hfi_buffer_line_enc(u32 frame_width, u32 frame_height, bool is_ten_bit,
+			u32 num_vpp_pipes_enc, u32 lcu_size, u32 standard)
+{
+	u32 line_buff_data_size = 0, left_line_buff_ctrl_size = 0;
+	u32 frame_width_coded = 0, frame_height_coded = 0;
+	u32 left_line_buff_metadata_recon__uv__size = 0;
+	u32 left_line_buff_metadata_recon__y__size = 0;
+	u32 width_in_lcus = 0, height_in_lcus = 0;
+	u32 left_line_buff_recon_pix_size = 0;
+	u32 top_line_buff_ctrl_fe_size = 0;
+	u32 line_buff_recon_pix_size = 0;
+
+	width_in_lcus = ((frame_width) + (lcu_size) - 1) / (lcu_size);
+	height_in_lcus = ((frame_height) + (lcu_size) - 1) / (lcu_size);
+	frame_width_coded = width_in_lcus * (lcu_size);
+	frame_height_coded = height_in_lcus * (lcu_size);
+	line_buff_data_size = size_linebuff_data(is_ten_bit, frame_width_coded);
+	left_line_buff_ctrl_size =
+		size_left_linebuff_ctrl(standard, frame_height_coded, num_vpp_pipes_enc);
+	left_line_buff_recon_pix_size =
+		size_left_linebuff_recon_pix(is_ten_bit, frame_height_coded,
+					     num_vpp_pipes_enc);
+	top_line_buff_ctrl_fe_size =
+		size_top_linebuff_ctrl_fe(frame_width_coded, standard);
+	left_line_buff_metadata_recon__y__size =
+		size_left_linebuff_metadata_recon_y(frame_height_coded, is_ten_bit,
+						    num_vpp_pipes_enc);
+	left_line_buff_metadata_recon__uv__size =
+		size_left_linebuff_metadata_recon_uv(frame_height_coded, is_ten_bit,
+						     num_vpp_pipes_enc);
+	line_buff_recon_pix_size = size_linebuff_recon_pix(is_ten_bit, frame_width_coded);
+
+	return size_line_buf_ctrl(frame_width_coded) +
+		size_line_buf_ctrl_id2(frame_width_coded) +
+		line_buff_data_size +
+		left_line_buff_ctrl_size +
+		left_line_buff_recon_pix_size +
+		top_line_buff_ctrl_fe_size +
+		left_line_buff_metadata_recon__y__size +
+		left_line_buff_metadata_recon__uv__size +
+		line_buff_recon_pix_size +
+		size_left_linebuff_ctrl_fe(frame_height_coded,
+					   num_vpp_pipes_enc) +
+		size_line_buf_sde(frame_width_coded) +
+		size_vpss_line_buf(num_vpp_pipes_enc, frame_height_coded,
+				   frame_width_coded) +
+		size_top_line_buf_first_stg_sao(frame_width_coded);
+}
+
+static inline
+u32 hfi_buffer_line_h264e(u32 frame_width, u32 frame_height, bool is_ten_bit,
+			  u32 num_vpp_pipes)
+{
+	return hfi_buffer_line_enc(frame_width, frame_height, 0,
+				   num_vpp_pipes, 16,
+				   HFI_CODEC_ENCODE_AVC);
+}
+
+static inline
+u32 hfi_buffer_line_h265e(u32 frame_width, u32 frame_height, bool is_ten_bit,
+			  u32 num_vpp_pipes)
+{
+	return hfi_buffer_line_enc(frame_width, frame_height,
+				   is_ten_bit, num_vpp_pipes, 32,
+				   HFI_CODEC_ENCODE_HEVC);
+}
+
+static inline
+u32 hfi_buffer_comv_enc(u32 frame_width, u32 frame_height, u32 lcu_size,
+			u32 num_recon, u32 standard)
+{
+	u32 width_in_lcus, height_in_lcus, num_lcu_in_frame;
+	u32 size_colloc_mv = 0, size_colloc_rc = 0;
+	u32 mb_height = ((frame_height) + 15) >> 4;
+	u32 mb_width = ((frame_width) + 15) >> 4;
+
+	width_in_lcus = ((frame_width) + (lcu_size) - 1) / (lcu_size);
+	height_in_lcus = ((frame_height) + (lcu_size) - 1) / (lcu_size);
+	num_lcu_in_frame = width_in_lcus * height_in_lcus;
+	size_colloc_mv = (standard == HFI_CODEC_ENCODE_HEVC) ?
+		(16 * ((num_lcu_in_frame << 2) + BUFFER_ALIGNMENT_32_BYTES)) :
+		(3 * 16 * (width_in_lcus * height_in_lcus + BUFFER_ALIGNMENT_32_BYTES));
+	size_colloc_mv = ALIGN(size_colloc_mv, BUFFER_ALIGNMENT_256_BYTES) * num_recon;
+	size_colloc_rc = (((mb_width + 7) >> 3) * 16 * 2 * mb_height);
+	size_colloc_rc = ALIGN(size_colloc_rc, BUFFER_ALIGNMENT_256_BYTES) * HFI_MAX_COL_FRAME;
+
+	return size_colloc_mv + size_colloc_rc;
+}
+
+static inline
+u32 hfi_buffer_comv_h264e(u32 frame_width, u32 frame_height, u32 num_recon)
+{
+	return hfi_buffer_comv_enc(frame_width, frame_height, 16,
+				   num_recon, HFI_CODEC_ENCODE_AVC);
+}
+
+static inline
+u32 hfi_buffer_comv_h265e(u32 frame_width, u32 frame_height, u32 num_recon)
+{
+	return hfi_buffer_comv_enc(frame_width, frame_height, 32,
+				   num_recon, HFI_CODEC_ENCODE_HEVC);
+}
+
+static inline
+u32 hfi_buffer_non_comv_enc(u32 frame_width, u32 frame_height,
+			    u32 num_vpp_pipes_enc, u32 lcu_size, u32 standard)
+{
+	u32 frame_width_coded = 0, frame_height_coded = 0;
+	u32 width_in_lcus = 0, height_in_lcus = 0;
+	u32 num_lcu_in_frame = 0, num_lcumb = 0;
+	u32 frame_rc_buf_size = 0;
+
+	width_in_lcus = ((frame_width) + (lcu_size) - 1) / (lcu_size);
+	height_in_lcus = ((frame_height) + (lcu_size) - 1) / (lcu_size);
+	num_lcu_in_frame = width_in_lcus * height_in_lcus;
+	frame_width_coded = width_in_lcus * (lcu_size);
+	frame_height_coded = height_in_lcus * (lcu_size);
+	num_lcumb = (frame_height_coded / lcu_size) *
+		((frame_width_coded + lcu_size * 8) / lcu_size);
+	frame_rc_buf_size =
+		size_frame_rc_buf_size(standard, frame_height_coded,
+				       num_vpp_pipes_enc);
+	return size_enc_slice_info_buf(num_lcu_in_frame) +
+		   SIZE_SLICE_CMD_BUFFER +
+		   SIZE_SPS_PPS_SLICE_HDR +
+		   frame_rc_buf_size +
+		   enc_bitcnt_buf_size(num_lcu_in_frame) +
+		   enc_bitmap_buf_size(num_lcu_in_frame) +
+		   SIZE_BSE_SLICE_CMD_BUF +
+		   SIZE_LAMBDA_LUT +
+		   size_override_buf(num_lcumb) +
+		   size_ir_buf(num_lcu_in_frame);
+}
+
+static inline
+u32 hfi_buffer_non_comv_h264e(u32 frame_width, u32 frame_height,
+			      u32 num_vpp_pipes_enc)
+{
+	return hfi_buffer_non_comv_enc(frame_width, frame_height,
+				       num_vpp_pipes_enc, 16,
+				       HFI_CODEC_ENCODE_AVC);
+}
+
+static inline
+u32 hfi_buffer_non_comv_h265e(u32 frame_width, u32 frame_height,
+			      u32 num_vpp_pipes_enc)
+{
+	return hfi_buffer_non_comv_enc(frame_width, frame_height,
+				       num_vpp_pipes_enc, 32,
+				       HFI_CODEC_ENCODE_HEVC);
+}
+
+static inline
+u32 size_enc_ref_buffer(u32 frame_width, u32 frame_height)
+{
+	u32 u_buffer_width = 0, u_buffer_height = 0;
+	u32 u_chroma_buffer_height = 0;
+
+	u_buffer_height = ALIGN(frame_height, HFI_VENUS_HEIGHT_ALIGNMENT);
+	u_chroma_buffer_height = frame_height >> 1;
+	u_chroma_buffer_height = ALIGN(u_chroma_buffer_height, HFI_VENUS_HEIGHT_ALIGNMENT);
+	u_buffer_width = ALIGN(frame_width, HFI_VENUS_WIDTH_ALIGNMENT);
+
+	return (u_buffer_height + u_chroma_buffer_height) * u_buffer_width;
+}
+
+static inline
+u32 size_enc_ten_bit_ref_buffer(u32 frame_width, u32 frame_height)
+{
+	u32 ref_buf_height = 0, ref_luma_stride_in_bytes = 0;
+	u32 chroma_size = 0, ref_buf_size = 0;
+	u32 u_ref_stride = 0, luma_size = 0;
+	u32 ref_chrm_height_in_bytes = 0;
+
+	ref_buf_height = (frame_height + (HFI_VENUS_HEIGHT_ALIGNMENT - 1)) &
+			(~(HFI_VENUS_HEIGHT_ALIGNMENT - 1));
+	ref_luma_stride_in_bytes = ((frame_width + SYSTEM_LAL_TILE10 - 1) / SYSTEM_LAL_TILE10) *
+		SYSTEM_LAL_TILE10;
+	u_ref_stride = 4 * (ref_luma_stride_in_bytes / 3);
+	u_ref_stride = (u_ref_stride + (BUFFER_ALIGNMENT_128_BYTES - 1)) &
+		(~(BUFFER_ALIGNMENT_128_BYTES - 1));
+	luma_size = ref_buf_height * u_ref_stride;
+	ref_chrm_height_in_bytes = (((frame_height + 1) >> 1) + (BUFFER_ALIGNMENT_32_BYTES - 1)) &
+		(~(BUFFER_ALIGNMENT_32_BYTES - 1));
+	chroma_size = u_ref_stride * ref_chrm_height_in_bytes;
+	luma_size = (luma_size + (BUFFER_ALIGNMENT_4096_BYTES - 1)) &
+		(~(BUFFER_ALIGNMENT_4096_BYTES - 1));
+	chroma_size = (chroma_size + (BUFFER_ALIGNMENT_4096_BYTES - 1)) &
+		(~(BUFFER_ALIGNMENT_4096_BYTES - 1));
+	ref_buf_size = luma_size + chroma_size;
+
+	return ref_buf_size;
+}
+
+static inline
+u32 hfi_buffer_dpb_enc(u32 frame_width, u32 frame_height, bool is_ten_bit)
+{
+	u32 metadata_stride, metadata_buf_height, meta_size_y, meta_size_c;
+	u32 ten_bit_ref_buf_size = 0, ref_buf_size = 0;
+	u32 _size = 0;
+
+	if (!is_ten_bit) {
+		ref_buf_size = size_enc_ref_buffer(frame_width, frame_height);
+		metadata_stride =
+			hfi_ubwc_calc_metadata_plane_stride(frame_width, 64,
+							    HFI_COL_FMT_NV12C_Y_TILE_WIDTH);
+		metadata_buf_height =
+			hfi_ubwc_metadata_plane_bufheight(frame_height, 16,
+							  HFI_COL_FMT_NV12C_Y_TILE_HEIGHT);
+		meta_size_y =
+			hfi_ubwc_metadata_plane_buffer_size(metadata_stride, metadata_buf_height);
+		meta_size_c =
+			hfi_ubwc_metadata_plane_buffer_size(metadata_stride, metadata_buf_height);
+		_size = ref_buf_size + meta_size_y + meta_size_c;
+	} else {
+		ten_bit_ref_buf_size = size_enc_ten_bit_ref_buffer(frame_width, frame_height);
+		metadata_stride =
+			hfi_ubwc_calc_metadata_plane_stride(frame_width,
+							    VENUS_METADATA_STRIDE_MULTIPLE,
+							    HFI_COL_FMT_TP10C_Y_TILE_WIDTH);
+		metadata_buf_height =
+			hfi_ubwc_metadata_plane_bufheight(frame_height,
+							  VENUS_METADATA_HEIGHT_MULTIPLE,
+							  HFI_COL_FMT_TP10C_Y_TILE_HEIGHT);
+		meta_size_y =
+			hfi_ubwc_metadata_plane_buffer_size(metadata_stride, metadata_buf_height);
+		meta_size_c =
+			hfi_ubwc_metadata_plane_buffer_size(metadata_stride, metadata_buf_height);
+		_size = ten_bit_ref_buf_size + meta_size_y + meta_size_c;
+	}
+
+	return _size;
+}
+
+static inline
+u32 hfi_buffer_dpb_h264e(u32 frame_width, u32 frame_height)
+{
+	return hfi_buffer_dpb_enc(frame_width, frame_height, 0);
+}
+
+static inline
+u32 hfi_buffer_dpb_h265e(u32 frame_width, u32 frame_height, bool is_ten_bit)
+{
+	return hfi_buffer_dpb_enc(frame_width, frame_height, is_ten_bit);
+}
+
+static inline
+u32 hfi_buffer_vpss_enc(u32 dswidth, u32 dsheight, bool ds_enable,
+			u32 blur, bool is_ten_bit)
+{
+	u32 vpss_size = 0;
+
+	if (ds_enable || blur)
+		vpss_size = hfi_buffer_dpb_enc(dswidth, dsheight, is_ten_bit);
+
+	return vpss_size;
+}
+
+static inline
+u32 hfi_iris3_enc_min_input_buf_count(u32 totalhblayers)
+{
+	u32 numinput = 3;
+
+	if (totalhblayers >= 2)
+		numinput = (1 << (totalhblayers - 1)) + 2;
+
+	return numinput;
+}
+
+u32 enc_output_buffer_size_iris3(struct iris_inst *inst);
+u32 get_recon_buf_count(struct iris_inst *inst);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
index 58498af..2828227 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
@@ -54,7 +54,7 @@ u64 iris_calc_freq_iris3(struct iris_inst *inst, u32 data_size)
 	if (inst->cap[STAGE].value == STAGE_1)
 		vsp_cycles = vsp_cycles * 3;
 
-	vsp_cycles += mbs_per_second * base_cycles;
+		vsp_cycles += mbs_per_second * base_cycles;
 
 	freq = max3(vpp_cycles, vsp_cycles, fw_cycles);
 
-- 
2.7.4


