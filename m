Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5680D766E46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjG1N1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjG1N1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:27:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5374205;
        Fri, 28 Jul 2023 06:26:16 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SCTpwu029619;
        Fri, 28 Jul 2023 13:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=06NvEMJDO8PfbtWRhw5YMdDI6raD7tbpxMlxM6wD8AI=;
 b=jgEl/0njW2g4u2331TzEePL6YUwzR1wSaHdiWFCC2nrDD8VyNect2buo6VabGcX1VBF0
 ZsVFO9lVGs98/SNhBcz3sL3uSSfBGijJgKu1G4Yc+rO7IMwK5tbGrCQC+3W4az3+V53E
 FNA2Fo5PZFhSttD1lVcJDFEOSIGjom6lhW5+tYaBJB6Jntu38CDkEPW7lOW/vGrBLSFr
 gtz+wILc1pHi41xPltONN463HusR6rKB/OFloxI1c7byGuNoi97oOyga0Sfl5Jln3fYS
 m8Jx/CnrfVP6NYTcY4GcLfbuhD554XeTMPNfTxXuVK6rqhsa6ZcflZ85UA1Ma1YjbCHV oQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s447kh7u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:03 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQ2Fh002438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:02 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:25:59 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 15/33] iris: add vidc buffer files
Date:   Fri, 28 Jul 2023 18:53:26 +0530
Message-ID: <1690550624-14642-16-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WcM0Q6GkC1Cc8Wb4eYqZT23lHlYk4TRa
X-Proofpoint-GUID: WcM0Q6GkC1Cc8Wb4eYqZT23lHlYk4TRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the size and count calcualtions of
different types of buffers for encoder and decoder.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/msm_vidc_buffer.h  |  32 +++
 .../platform/qcom/iris/vidc/src/msm_vidc_buffer.c  | 290 +++++++++++++++++++++
 2 files changed, 322 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_buffer.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_buffer.c

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_buffer.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_buffer.h
new file mode 100644
index 0000000..0fffcf0
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_buffer.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __H_MSM_VIDC_BUFFER_H__
+#define __H_MSM_VIDC_BUFFER_H__
+
+#include "msm_vidc_inst.h"
+
+#define MIN_DEC_INPUT_BUFFERS  4
+#define MIN_DEC_OUTPUT_BUFFERS 4
+
+#define MIN_ENC_INPUT_BUFFERS  4
+#define MIN_ENC_OUTPUT_BUFFERS 4
+
+#define DCVS_ENC_EXTRA_INPUT_BUFFERS  4
+#define DCVS_DEC_EXTRA_OUTPUT_BUFFERS 4
+
+u32 msm_vidc_input_min_count(struct msm_vidc_inst *inst);
+u32 msm_vidc_output_min_count(struct msm_vidc_inst *inst);
+u32 msm_vidc_input_extra_count(struct msm_vidc_inst *inst);
+u32 msm_vidc_output_extra_count(struct msm_vidc_inst *inst);
+u32 msm_vidc_internal_buffer_count(struct msm_vidc_inst *inst,
+				   enum msm_vidc_buffer_type buffer_type);
+u32 msm_vidc_decoder_input_size(struct msm_vidc_inst *inst);
+u32 msm_vidc_decoder_output_size(struct msm_vidc_inst *inst);
+u32 msm_vidc_encoder_input_size(struct msm_vidc_inst *inst);
+u32 msm_vidc_encoder_output_size(struct msm_vidc_inst *inst);
+
+#endif // __H_MSM_VIDC_BUFFER_H__
diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_buffer.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_buffer.c
new file mode 100644
index 0000000..a2a0eea
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_buffer.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "msm_media_info.h"
+#include "msm_vidc_buffer.h"
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_driver.h"
+#include "msm_vidc_inst.h"
+#include "msm_vidc_internal.h"
+
+/* Generic function for all targets. Not being used for iris2 */
+u32 msm_vidc_input_min_count(struct msm_vidc_inst *inst)
+{
+	u32 input_min_count = 0;
+	u32 hb_enh_layer = 0;
+
+	if (is_decode_session(inst)) {
+		input_min_count = MIN_DEC_INPUT_BUFFERS;
+	} else if (is_encode_session(inst)) {
+		input_min_count = MIN_ENC_INPUT_BUFFERS;
+		if (is_hierb_type_requested(inst)) {
+			hb_enh_layer =
+				inst->capabilities[ENH_LAYER_COUNT].value;
+			if (inst->codec == MSM_VIDC_H264 &&
+			    !inst->capabilities[LAYER_ENABLE].value) {
+				hb_enh_layer = 0;
+			}
+			if (hb_enh_layer)
+				input_min_count = (1 << hb_enh_layer) + 2;
+		}
+	} else {
+		i_vpr_e(inst, "%s: invalid domain %d\n",
+			__func__, inst->domain);
+		return 0;
+	}
+
+	return input_min_count;
+}
+
+u32 msm_vidc_output_min_count(struct msm_vidc_inst *inst)
+{
+	u32 output_min_count;
+
+	if (!is_decode_session(inst) && !is_encode_session(inst))
+		return 0;
+
+	if (is_encode_session(inst))
+		return MIN_ENC_OUTPUT_BUFFERS;
+
+	/* decoder handling below */
+	/* fw_min_count > 0 indicates reconfig event has already arrived */
+	if (inst->fw_min_count) {
+		if (is_split_mode_enabled(inst) &&
+		    inst->codec == MSM_VIDC_VP9) {
+			/*
+			 * return opb min buffer count as min(4, fw_min_count)
+			 * fw min count is used for dpb min count
+			 */
+			return min_t(u32, 4, inst->fw_min_count);
+		} else {
+			return inst->fw_min_count;
+		}
+	}
+
+	/* initial handling before reconfig event arrived */
+	switch (inst->codec) {
+	case MSM_VIDC_H264:
+	case MSM_VIDC_HEVC:
+		output_min_count = 4;
+		break;
+	case MSM_VIDC_VP9:
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
+u32 msm_vidc_input_extra_count(struct msm_vidc_inst *inst)
+{
+	u32 count = 0;
+	struct msm_vidc_core *core;
+
+	core = inst->core;
+
+	if (is_decode_session(inst)) {
+		/*
+		 * if decode batching enabled, ensure minimum batch size
+		 * count of input buffers present on input port
+		 */
+		if (core->capabilities[DECODE_BATCH].value &&
+		    inst->decode_batch.enable) {
+			if (inst->buffers.input.min_count < inst->decode_batch.size) {
+				count = inst->decode_batch.size -
+					inst->buffers.input.min_count;
+			}
+		}
+	} else if (is_encode_session(inst)) {
+		/* add dcvs buffers, if platform supports dcvs */
+		if (core->capabilities[DCVS].value)
+			count = DCVS_ENC_EXTRA_INPUT_BUFFERS;
+	}
+
+	return count;
+}
+
+u32 msm_vidc_output_extra_count(struct msm_vidc_inst *inst)
+{
+	u32 count = 0;
+	struct msm_vidc_core *core;
+
+	core = inst->core;
+
+	if (is_decode_session(inst)) {
+		/* add dcvs buffers, if platform supports dcvs */
+		if (core->capabilities[DCVS].value)
+			count = DCVS_DEC_EXTRA_OUTPUT_BUFFERS;
+		/*
+		 * if decode batching enabled, ensure minimum batch size
+		 * count of extra output buffers added on output port
+		 */
+		if (core->capabilities[DECODE_BATCH].value &&
+		    inst->decode_batch.enable &&
+			count < inst->decode_batch.size)
+			count = inst->decode_batch.size;
+	}
+
+	return count;
+}
+
+u32 msm_vidc_internal_buffer_count(struct msm_vidc_inst *inst,
+				   enum msm_vidc_buffer_type buffer_type)
+{
+	u32 count = 0;
+
+	if (is_encode_session(inst))
+		return 1;
+
+	if (is_decode_session(inst)) {
+		if (buffer_type == MSM_VIDC_BUF_BIN ||
+		    buffer_type == MSM_VIDC_BUF_LINE ||
+		    buffer_type == MSM_VIDC_BUF_PERSIST) {
+			count = 1;
+		} else if (buffer_type == MSM_VIDC_BUF_COMV ||
+			buffer_type == MSM_VIDC_BUF_NON_COMV) {
+			if (inst->codec == MSM_VIDC_H264 ||
+			    inst->codec == MSM_VIDC_HEVC)
+				count = 1;
+			else
+				count = 0;
+		} else {
+			i_vpr_e(inst, "%s: unsupported buffer type %s\n",
+				__func__, buf_name(buffer_type));
+			count = 0;
+		}
+	}
+
+	return count;
+}
+
+u32 msm_vidc_decoder_input_size(struct msm_vidc_inst *inst)
+{
+	u32 frame_size, num_mbs;
+	u32 div_factor = 1;
+	u32 base_res_mbs = NUM_MBS_4k;
+	struct v4l2_format *f;
+	u32 bitstream_size_overwrite = 0;
+	enum msm_vidc_codec_type codec;
+
+	bitstream_size_overwrite =
+		inst->capabilities[BITSTREAM_SIZE_OVERWRITE].value;
+	if (bitstream_size_overwrite) {
+		frame_size = bitstream_size_overwrite;
+		i_vpr_h(inst, "client configured bitstream buffer size %d\n",
+			frame_size);
+		return frame_size;
+	}
+
+	/*
+	 * Decoder input size calculation:
+	 * For 8k resolution, buffer size is calculated as 8k mbs / 4 and
+	 * for 8k cases we expect width/height to be set always.
+	 * In all other cases, buffer size is calculated as
+	 * 4k mbs for VP8/VP9 and 4k / 2 for remaining codecs.
+	 */
+	f = &inst->fmts[INPUT_PORT];
+	codec = v4l2_codec_to_driver(inst, f->fmt.pix_mp.pixelformat, __func__);
+	num_mbs = msm_vidc_get_mbs_per_frame(inst);
+	if (num_mbs > NUM_MBS_4k) {
+		div_factor = 4;
+		base_res_mbs = inst->capabilities[MBPF].value;
+	} else {
+		base_res_mbs = NUM_MBS_4k;
+		if (codec == MSM_VIDC_VP9)
+			div_factor = 1;
+		else
+			div_factor = 2;
+	}
+
+	frame_size = base_res_mbs * MB_SIZE_IN_PIXEL * 3 / 2 / div_factor;
+
+	 /* multiply by 10/8 (1.25) to get size for 10 bit case */
+	if (codec == MSM_VIDC_VP9 || codec == MSM_VIDC_HEVC)
+		frame_size = frame_size + (frame_size >> 2);
+
+	i_vpr_h(inst, "set input buffer size to %d\n", frame_size);
+
+	return ALIGN(frame_size, SZ_4K);
+}
+
+u32 msm_vidc_decoder_output_size(struct msm_vidc_inst *inst)
+{
+	u32 size;
+	struct v4l2_format *f;
+	enum msm_vidc_colorformat_type colorformat;
+
+	f = &inst->fmts[OUTPUT_PORT];
+	colorformat = v4l2_colorformat_to_driver(inst, f->fmt.pix_mp.pixelformat,
+						 __func__);
+	size = video_buffer_size(colorformat, f->fmt.pix_mp.width,
+				 f->fmt.pix_mp.height, true);
+	return size;
+}
+
+u32 msm_vidc_encoder_input_size(struct msm_vidc_inst *inst)
+{
+	u32 size;
+	struct v4l2_format *f;
+	u32 width, height;
+	enum msm_vidc_colorformat_type colorformat;
+
+	f = &inst->fmts[INPUT_PORT];
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+	colorformat = v4l2_colorformat_to_driver(inst, f->fmt.pix_mp.pixelformat,
+						 __func__);
+	size = video_buffer_size(colorformat, width, height, true);
+	return size;
+}
+
+u32 msm_vidc_encoder_output_size(struct msm_vidc_inst *inst)
+{
+	u32 frame_size;
+	u32 mbs_per_frame;
+	u32 width, height;
+	struct v4l2_format *f;
+	enum msm_vidc_codec_type codec;
+
+	f = &inst->fmts[OUTPUT_PORT];
+	codec = v4l2_codec_to_driver(inst, f->fmt.pix_mp.pixelformat, __func__);
+	/*
+	 * Encoder output size calculation: 32 Align width/height
+	 * For resolution <= 480x360p : YUVsize * 2
+	 * For resolution > 360p & <= 4K : YUVsize / 2
+	 * For resolution > 4k : YUVsize / 4
+	 * Initially frame_size = YUVsize * 2;
+	 */
+
+	width = ALIGN(f->fmt.pix_mp.width, BUFFER_ALIGNMENT_SIZE(32));
+	height = ALIGN(f->fmt.pix_mp.height, BUFFER_ALIGNMENT_SIZE(32));
+	mbs_per_frame = NUM_MBS_PER_FRAME(width, height);
+	frame_size = (width * height * 3);
+
+	/* Image session: 2 x yuv size */
+	if (inst->capabilities[BITRATE_MODE].value == V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)
+		goto skip_calc;
+
+	if (mbs_per_frame <= NUM_MBS_360P)
+		(void)frame_size; /* Default frame_size = YUVsize * 2 */
+	else if (mbs_per_frame <= NUM_MBS_4k)
+		frame_size = frame_size >> 2;
+	else
+		frame_size = frame_size >> 3;
+
+skip_calc:
+	/* multiply by 10/8 (1.25) to get size for 10 bit case */
+	if (codec == MSM_VIDC_HEVC)
+		frame_size = frame_size + (frame_size >> 2);
+
+	frame_size = ALIGN(frame_size, SZ_4K);
+
+	return frame_size;
+}
-- 
2.7.4

