Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDD766E41
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjG1N1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbjG1N0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:26:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED546A2;
        Fri, 28 Jul 2023 06:26:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SCxrHi021636;
        Fri, 28 Jul 2023 13:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=U4+TVMRsJZjMgXnPzsJ3uOErxFdZEK3WZbIk30sRS3k=;
 b=VDUodzfXkqHniCWJiWTMazRg4ZEymFQVe79lDGdouSr04j5QQk3SKl8qoh+znpZcKT2F
 XmBnVPsYHszo+eT6epRjRzGkVFeyt360SgS0EaCl66TsS6u5CcyjofIt9ZSvOUZUgcmv
 PQrWZpLnaZfFPZ+1yNcQbWcLXxBbJhKdghkF6RS8IF1aX5NvqLXlzPrqsOFTehJB9eJR
 34xDF3zZtvpxvIBbmfi0WSBcTr4LA9LqD8yjTc6AsKUB6UNL8wAscHTDicE+H0fHJqT+
 HJhG20nNZMwMsyLvgnjsRf/bOVfMZjD5FrpMsbZgYvvCrBZjqnrafWA9R48cjj5su2Gx WQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s469hh1gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:25:56 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDPuN1002374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:25:56 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:25:52 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 13/33] iris: vidc: add helper functions for power management
Date:   Fri, 28 Jul 2023 18:53:24 +0530
Message-ID: <1690550624-14642-14-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LAx9nLJITVufFzoxgXQqC8UGYFFAtuSD
X-Proofpoint-GUID: LAx9nLJITVufFzoxgXQqC8UGYFFAtuSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

this implements functions for calculating current load of the
hardware. Depending on the count of instances and
resolutions it selects the best clock rate for the video
core. Also it scales clocks, power and enable/disable dcvs.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/msm_vidc_power.h   |  94 ++++
 .../platform/qcom/iris/vidc/src/msm_vidc_power.c   | 560 +++++++++++++++++++++
 2 files changed, 654 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_power.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_power.c

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_power.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_power.h
new file mode 100644
index 0000000..cb424f5
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_power.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _MSM_VIDC_POWER_H_
+#define _MSM_VIDC_POWER_H_
+
+#include "msm_vidc_debug.h"
+#include "msm_vidc_inst.h"
+#include "msm_vidc_internal.h"
+
+#define COMPRESSION_RATIO_MAX 5
+
+/* TODO: Move to dtsi OR use source clock instead of branch clock.*/
+#define MSM_VIDC_CLOCK_SOURCE_SCALING_RATIO 3
+
+enum vidc_bus_type {
+	PERF,
+	DDR,
+	LLCC,
+};
+
+/*
+ * Minimum dimensions for which to calculate bandwidth.
+ * This means that anything bandwidth(0, 0) ==
+ * bandwidth(BASELINE_DIMENSIONS.width, BASELINE_DIMENSIONS.height)
+ */
+static const struct {
+	int height, width;
+} BASELINE_DIMENSIONS = {
+	.width = 1280,
+	.height = 720,
+};
+
+/* converts Mbps to bps (the "b" part can be bits or bytes based on context) */
+#define kbps(__mbps) ((__mbps) * 1000)
+#define bps(__mbps) (kbps(__mbps) * 1000)
+
+static inline u32 get_type_frm_name(const char *name)
+{
+	if (!strcmp(name, "venus-llcc"))
+		return LLCC;
+	else if (!strcmp(name, "venus-ddr"))
+		return DDR;
+	else
+		return PERF;
+}
+
+#define DUMP_HEADER_MAGIC 0xdeadbeef
+#define DUMP_FP_FMT "%FP" /* special format for fp_t */
+
+struct dump {
+	char *key;
+	char *format;
+	size_t val;
+};
+
+void __dump(struct dump dump[], int len);
+
+static inline bool __ubwc(enum msm_vidc_colorformat_type f)
+{
+	switch (f) {
+	case MSM_VIDC_FMT_NV12C:
+	case MSM_VIDC_FMT_TP10C:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline int __bpp(enum msm_vidc_colorformat_type f)
+{
+	switch (f) {
+	case MSM_VIDC_FMT_NV12:
+	case MSM_VIDC_FMT_NV21:
+	case MSM_VIDC_FMT_NV12C:
+	case MSM_VIDC_FMT_RGBA8888C:
+		return 8;
+	case MSM_VIDC_FMT_P010:
+	case MSM_VIDC_FMT_TP10C:
+		return 10;
+	default:
+		d_vpr_e("Unsupported colorformat (%x)", f);
+		return INT_MAX;
+	}
+}
+
+u64 msm_vidc_max_freq(struct msm_vidc_inst *inst);
+int msm_vidc_scale_power(struct msm_vidc_inst *inst, bool scale_buses);
+void msm_vidc_power_data_reset(struct msm_vidc_inst *inst);
+
+#endif
diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_power.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_power.c
new file mode 100644
index 0000000..cb5c7b7c
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_power.c
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "msm_vidc_buffer.h"
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_driver.h"
+#include "msm_vidc_inst.h"
+#include "msm_vidc_internal.h"
+#include "msm_vidc_platform.h"
+#include "msm_vidc_power.h"
+#include "venus_hfi.h"
+
+/* Q16 Format */
+#define MSM_VIDC_MIN_UBWC_COMPLEXITY_FACTOR (1 << 16)
+#define MSM_VIDC_MAX_UBWC_COMPLEXITY_FACTOR (4 << 16)
+#define MSM_VIDC_MIN_UBWC_COMPRESSION_RATIO (1 << 16)
+#define MSM_VIDC_MAX_UBWC_COMPRESSION_RATIO (5 << 16)
+
+void __dump(struct dump dump[], int len)
+{
+	int c = 0;
+
+	for (c = 0; c < len; ++c) {
+		char format_line[128] = "", formatted_line[128] = "";
+
+		if (dump[c].val == DUMP_HEADER_MAGIC) {
+			snprintf(formatted_line, sizeof(formatted_line), "%s\n",
+				 dump[c].key);
+		} else {
+			snprintf(format_line, sizeof(format_line),
+				 "    %-35s: %s\n", dump[c].key,
+					 dump[c].format);
+			snprintf(formatted_line, sizeof(formatted_line),
+				 format_line, dump[c].val);
+		}
+		d_vpr_b("%s", formatted_line);
+	}
+}
+
+u64 msm_vidc_max_freq(struct msm_vidc_inst *inst)
+{
+	struct msm_vidc_core *core;
+	struct frequency_table *freq_tbl;
+	u64 freq = 0;
+
+	core = inst->core;
+
+	if (!core->resource || !core->resource->freq_set.freq_tbl ||
+	    !core->resource->freq_set.count) {
+		i_vpr_e(inst, "%s: invalid frequency table\n", __func__);
+		return freq;
+	}
+	freq_tbl = core->resource->freq_set.freq_tbl;
+	freq = freq_tbl[0].freq;
+
+	i_vpr_l(inst, "%s: rate = %llu\n", __func__, freq);
+	return freq;
+}
+
+static int fill_dynamic_stats(struct msm_vidc_inst *inst,
+			      struct vidc_bus_vote_data *vote_data)
+{
+	struct msm_vidc_input_cr_data *temp, *next;
+	u32 cf = MSM_VIDC_MAX_UBWC_COMPLEXITY_FACTOR;
+	u32 cr = MSM_VIDC_MIN_UBWC_COMPRESSION_RATIO;
+	u32 input_cr = MSM_VIDC_MIN_UBWC_COMPRESSION_RATIO;
+	u32 frame_size;
+
+	if (inst->power.fw_cr)
+		cr = inst->power.fw_cr;
+
+	if (inst->power.fw_cf) {
+		cf = inst->power.fw_cf;
+		frame_size = (msm_vidc_get_mbs_per_frame(inst) / (32 * 8) * 3) / 2;
+		if (frame_size)
+			cf = cf / frame_size;
+	}
+
+	list_for_each_entry_safe(temp, next, &inst->enc_input_crs, list)
+		input_cr = min(input_cr, temp->input_cr);
+
+	vote_data->compression_ratio = cr;
+	vote_data->complexity_factor = cf;
+	vote_data->input_cr = input_cr;
+
+	/* Sanitize CF values from HW */
+	cf = clamp_t(u32, cf, MSM_VIDC_MIN_UBWC_COMPLEXITY_FACTOR,
+		     MSM_VIDC_MAX_UBWC_COMPLEXITY_FACTOR);
+	cr = clamp_t(u32, cr, MSM_VIDC_MIN_UBWC_COMPRESSION_RATIO,
+		     MSM_VIDC_MAX_UBWC_COMPRESSION_RATIO);
+	input_cr = clamp_t(u32, input_cr, MSM_VIDC_MIN_UBWC_COMPRESSION_RATIO,
+			   MSM_VIDC_MAX_UBWC_COMPRESSION_RATIO);
+
+	vote_data->compression_ratio = cr;
+	vote_data->complexity_factor = cf;
+	vote_data->input_cr = input_cr;
+
+	i_vpr_l(inst,
+		"Input CR = %d Recon CR = %d Complexity Factor = %d\n",
+		vote_data->input_cr, vote_data->compression_ratio,
+		vote_data->complexity_factor);
+
+	return 0;
+}
+
+static int msm_vidc_set_buses(struct msm_vidc_inst *inst)
+{
+	int rc = 0;
+	struct msm_vidc_core *core;
+	struct msm_vidc_inst *temp;
+	u64 total_bw_ddr = 0, total_bw_llcc = 0;
+	u64 curr_time_ns;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+	curr_time_ns = ktime_get_ns();
+	list_for_each_entry(temp, &core->instances, list) {
+		/* skip for session where no input is there to process */
+		if (!temp->max_input_data_size)
+			continue;
+
+		/* skip inactive session bus bandwidth */
+		if (!is_active_session(temp->last_qbuf_time_ns, curr_time_ns)) {
+			temp->active = false;
+			continue;
+		}
+
+		if (temp->power.power_mode == VIDC_POWER_TURBO) {
+			total_bw_ddr = INT_MAX;
+			total_bw_llcc = INT_MAX;
+			break;
+		}
+
+		total_bw_ddr += temp->power.ddr_bw;
+		total_bw_llcc += temp->power.sys_cache_bw;
+	}
+	mutex_unlock(&core->lock);
+
+	rc = venus_hfi_scale_buses(inst, total_bw_ddr, total_bw_llcc);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+int msm_vidc_scale_buses(struct msm_vidc_inst *inst)
+{
+	int rc = 0;
+	struct msm_vidc_core *core;
+	struct vidc_bus_vote_data *vote_data;
+	struct v4l2_format *out_f;
+	struct v4l2_format *inp_f;
+	u32 operating_rate, frame_rate;
+
+	core = inst->core;
+	if (!core->resource) {
+		i_vpr_e(inst, "%s: invalid resource params\n", __func__);
+		return -EINVAL;
+	}
+	vote_data = &inst->bus_data;
+
+	vote_data->power_mode = VIDC_POWER_NORMAL;
+	if (inst->power.buffer_counter < DCVS_WINDOW)
+		vote_data->power_mode = VIDC_POWER_TURBO;
+
+	if (vote_data->power_mode == VIDC_POWER_TURBO)
+		goto set_buses;
+
+	out_f = &inst->fmts[OUTPUT_PORT];
+	inp_f = &inst->fmts[INPUT_PORT];
+
+	vote_data->codec = inst->codec;
+	vote_data->input_width = inp_f->fmt.pix_mp.width;
+	vote_data->input_height = inp_f->fmt.pix_mp.height;
+	vote_data->output_width = out_f->fmt.pix_mp.width;
+	vote_data->output_height = out_f->fmt.pix_mp.height;
+	vote_data->lcu_size = (inst->codec == MSM_VIDC_HEVC ||
+			inst->codec == MSM_VIDC_VP9) ? 32 : 16;
+	vote_data->fps = inst->max_rate;
+
+	if (is_encode_session(inst)) {
+		vote_data->domain = MSM_VIDC_ENCODER;
+		vote_data->bitrate = inst->capabilities[BIT_RATE].value;
+		vote_data->rotation = inst->capabilities[ROTATION].value;
+		vote_data->b_frames_enabled =
+			inst->capabilities[B_FRAME].value > 0;
+
+		/* scale bitrate if operating rate is larger than frame rate */
+		frame_rate = msm_vidc_get_frame_rate(inst);
+		operating_rate = inst->max_rate;
+		if (frame_rate && operating_rate && operating_rate > frame_rate)
+			vote_data->bitrate = (vote_data->bitrate / frame_rate) * operating_rate;
+
+		vote_data->num_formats = 1;
+		vote_data->color_formats[0] =
+			v4l2_colorformat_to_driver(inst,
+						   inst->fmts[INPUT_PORT].fmt.pix_mp.pixelformat,
+						   __func__);
+	} else if (is_decode_session(inst)) {
+		u32 color_format;
+
+		vote_data->domain = MSM_VIDC_DECODER;
+		vote_data->bitrate = inst->max_input_data_size * vote_data->fps * 8;
+		color_format =
+			v4l2_colorformat_to_driver(inst,
+						   inst->fmts[OUTPUT_PORT].fmt.pix_mp.pixelformat,
+						   __func__);
+		if (is_linear_colorformat(color_format)) {
+			vote_data->num_formats = 2;
+			/*
+			 * 0 index - dpb colorformat
+			 * 1 index - opb colorformat
+			 */
+			if (is_10bit_colorformat(color_format))
+				vote_data->color_formats[0] = MSM_VIDC_FMT_TP10C;
+			else
+				vote_data->color_formats[0] = MSM_VIDC_FMT_NV12;
+			vote_data->color_formats[1] = color_format;
+		} else {
+			vote_data->num_formats = 1;
+			vote_data->color_formats[0] = color_format;
+		}
+	}
+	vote_data->work_mode = inst->capabilities[STAGE].value;
+	if (core->resource->subcache_set.set_to_fw)
+		vote_data->use_sys_cache = true;
+	vote_data->num_vpp_pipes = core->capabilities[NUM_VPP_PIPE].value;
+	fill_dynamic_stats(inst, vote_data);
+
+	call_session_op(core, calc_bw, inst, vote_data);
+
+	inst->power.ddr_bw = vote_data->calc_bw_ddr;
+	inst->power.sys_cache_bw = vote_data->calc_bw_llcc;
+
+	if (!inst->stats.avg_bw_llcc)
+		inst->stats.avg_bw_llcc = inst->power.sys_cache_bw;
+	else
+		inst->stats.avg_bw_llcc =
+			(inst->stats.avg_bw_llcc + inst->power.sys_cache_bw) / 2;
+
+	if (!inst->stats.avg_bw_ddr)
+		inst->stats.avg_bw_ddr = inst->power.ddr_bw;
+	else
+		inst->stats.avg_bw_ddr =
+			(inst->stats.avg_bw_ddr + inst->power.ddr_bw) / 2;
+
+set_buses:
+	inst->power.power_mode = vote_data->power_mode;
+	rc = msm_vidc_set_buses(inst);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+int msm_vidc_set_clocks(struct msm_vidc_inst *inst)
+{
+	int rc = 0;
+	struct msm_vidc_core *core;
+	struct msm_vidc_inst *temp;
+	u64 freq;
+	u64 rate = 0;
+	bool increment, decrement;
+	u64 curr_time_ns;
+	int i = 0;
+
+	core = inst->core;
+
+	if (!core->resource || !core->resource->freq_set.freq_tbl ||
+	    !core->resource->freq_set.count) {
+		d_vpr_e("%s: invalid frequency table\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&core->lock);
+	increment = false;
+	decrement = true;
+	freq = 0;
+	curr_time_ns = ktime_get_ns();
+	list_for_each_entry(temp, &core->instances, list) {
+		/* skip for session where no input is there to process */
+		if (!temp->max_input_data_size)
+			continue;
+
+		/* skip inactive session clock rate */
+		if (!is_active_session(temp->last_qbuf_time_ns, curr_time_ns)) {
+			temp->active = false;
+			continue;
+		}
+		freq += temp->power.min_freq;
+
+		/* increment even if one session requested for it */
+		if (temp->power.dcvs_flags & MSM_VIDC_DCVS_INCR)
+			increment = true;
+		/* decrement only if all sessions requested for it */
+		if (!(temp->power.dcvs_flags & MSM_VIDC_DCVS_DECR))
+			decrement = false;
+	}
+
+	/*
+	 * keep checking from lowest to highest rate until
+	 * table rate >= requested rate
+	 */
+	for (i = core->resource->freq_set.count - 1; i >= 0; i--) {
+		rate = core->resource->freq_set.freq_tbl[i].freq;
+		if (rate >= freq)
+			break;
+	}
+	if (i < 0)
+		i = 0;
+	if (increment) {
+		if (i > 0)
+			rate = core->resource->freq_set.freq_tbl[i - 1].freq;
+	} else if (decrement) {
+		if (i < (int)(core->platform->data.freq_tbl_size - 1))
+			rate = core->resource->freq_set.freq_tbl[i + 1].freq;
+	}
+	core->power.clk_freq = (u32)rate;
+
+	i_vpr_p(inst, "%s: clock rate %llu requested %llu increment %d decrement %d\n",
+		__func__, rate, freq, increment, decrement);
+	mutex_unlock(&core->lock);
+
+	rc = venus_hfi_scale_clocks(inst, rate);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int msm_vidc_apply_dcvs(struct msm_vidc_inst *inst)
+{
+	int rc = 0;
+	int bufs_with_fw = 0;
+	struct msm_vidc_power *power;
+
+	/* skip dcvs */
+	if (!inst->power.dcvs_mode)
+		return 0;
+
+	power = &inst->power;
+
+	if (is_decode_session(inst)) {
+		bufs_with_fw = msm_vidc_num_buffers(inst, MSM_VIDC_BUF_OUTPUT,
+						    MSM_VIDC_ATTR_QUEUED);
+	} else {
+		bufs_with_fw = msm_vidc_num_buffers(inst, MSM_VIDC_BUF_INPUT,
+						    MSM_VIDC_ATTR_QUEUED);
+	}
+
+	/* +1 as one buffer is going to be queued after the function */
+	bufs_with_fw += 1;
+
+	/*
+	 * DCVS decides clock level based on below algorithm
+	 *
+	 * Limits :
+	 * min_threshold : Buffers required for reference by FW.
+	 * nom_threshold : Midpoint of Min and Max thresholds
+	 * max_threshold : Min Threshold + DCVS extra buffers, allocated
+	 *				   for smooth flow.
+	 * 1) When buffers outside FW are reaching client's extra buffers,
+	 *    FW is slow and will impact pipeline, Increase clock.
+	 * 2) When pending buffers with FW are less than FW requested,
+	 *    pipeline has cushion to absorb FW slowness, Decrease clocks.
+	 * 3) When DCVS has engaged(Inc or Dec):
+	 *    For decode:
+	 *        - Pending buffers with FW transitions past the nom_threshold,
+	 *        switch to calculated load, this smoothens the clock transitions.
+	 *    For encode:
+	 *        - Always switch to calculated load.
+	 * 4) Otherwise maintain previous Load config.
+	 */
+	if (bufs_with_fw >= power->max_threshold) {
+		power->dcvs_flags = MSM_VIDC_DCVS_INCR;
+		goto exit;
+	} else if (bufs_with_fw < power->min_threshold) {
+		power->dcvs_flags = MSM_VIDC_DCVS_DECR;
+		goto exit;
+	}
+
+	/* encoder: dcvs window handling */
+	if (is_encode_session(inst)) {
+		power->dcvs_flags = 0;
+		goto exit;
+	}
+
+	/* decoder: dcvs window handling */
+	if ((power->dcvs_flags & MSM_VIDC_DCVS_DECR && bufs_with_fw >= power->nom_threshold) ||
+	    (power->dcvs_flags & MSM_VIDC_DCVS_INCR && bufs_with_fw <= power->nom_threshold)) {
+		power->dcvs_flags = 0;
+	}
+
+exit:
+	i_vpr_p(inst, "dcvs: bufs_with_fw %d th[%d %d %d] flags %#x\n",
+		bufs_with_fw, power->min_threshold,
+		power->nom_threshold, power->max_threshold,
+		power->dcvs_flags);
+
+	return rc;
+}
+
+int msm_vidc_scale_clocks(struct msm_vidc_inst *inst)
+{
+	struct msm_vidc_core *core;
+
+	core = inst->core;
+
+	if (inst->power.buffer_counter < DCVS_WINDOW ||
+	    is_sub_state(inst, MSM_VIDC_DRC) ||
+	    is_sub_state(inst, MSM_VIDC_DRAIN)) {
+		inst->power.min_freq = msm_vidc_max_freq(inst);
+		inst->power.dcvs_flags = 0;
+	} else {
+		inst->power.min_freq =
+			call_session_op(core, calc_freq, inst, inst->max_input_data_size);
+		msm_vidc_apply_dcvs(inst);
+	}
+	inst->power.curr_freq = inst->power.min_freq;
+	msm_vidc_set_clocks(inst);
+
+	return 0;
+}
+
+int msm_vidc_scale_power(struct msm_vidc_inst *inst, bool scale_buses)
+{
+	struct msm_vidc_core *core;
+	struct msm_vidc_buffer *vbuf;
+	u32 data_size = 0;
+	u32 cnt = 0;
+	u32 fps;
+	u32 frame_rate, operating_rate;
+	u32 timestamp_rate = 0, input_rate = 0;
+
+	core = inst->core;
+
+	if (!inst->active) {
+		/* scale buses for inactive -> active session */
+		scale_buses = true;
+		inst->active = true;
+	}
+
+	/*
+	 * consider avg. filled length in decode batching case
+	 * to avoid overvoting for the entire batch due to single
+	 * frame with huge filled length
+	 */
+	if (inst->decode_batch.enable) {
+		list_for_each_entry(vbuf, &inst->buffers.input.list, list) {
+			if (vbuf->attr & MSM_VIDC_ATTR_DEFERRED ||
+			    vbuf->attr & MSM_VIDC_ATTR_QUEUED) {
+				data_size += vbuf->data_size;
+				cnt++;
+			}
+		}
+		if (cnt)
+			data_size /= cnt;
+	} else {
+		list_for_each_entry(vbuf, &inst->buffers.input.list, list)
+			data_size = max(data_size, vbuf->data_size);
+	}
+	inst->max_input_data_size = data_size;
+
+	frame_rate = msm_vidc_get_frame_rate(inst);
+	operating_rate = msm_vidc_get_operating_rate(inst);
+	fps = max(frame_rate, operating_rate);
+	/*
+	 * Consider input queuing rate in power scaling in
+	 * because client may not set the frame rate / operating rate
+	 * and we need to rely on input queue rate
+	 */
+	if (is_decode_session(inst)) {
+		/*
+		 * when buffer detected fps is more than client set value by 12.5%,
+		 * utilize buffer detected fps to scale clock.
+		 */
+		timestamp_rate = msm_vidc_get_timestamp_rate(inst);
+		input_rate = msm_vidc_get_input_rate(inst);
+		if (timestamp_rate > (fps + fps / 8))
+			fps = timestamp_rate;
+
+		if (input_rate > fps)
+			fps = input_rate;
+	}
+	inst->max_rate = fps;
+
+	/* no pending inputs - skip scale power */
+	if (!inst->max_input_data_size)
+		return 0;
+
+	if (msm_vidc_scale_clocks(inst))
+		i_vpr_e(inst, "failed to scale clock\n");
+
+	if (scale_buses) {
+		if (msm_vidc_scale_buses(inst))
+			i_vpr_e(inst, "failed to scale bus\n");
+	}
+
+	i_vpr_hp(inst,
+		 "power: inst: clk %lld ddr %d llcc %d dcvs flags %#x fps %u (%u %u %u %u) core: clk %lld ddr %lld llcc %lld\n",
+		 inst->power.curr_freq, inst->power.ddr_bw,
+		 inst->power.sys_cache_bw, inst->power.dcvs_flags,
+		 inst->max_rate, frame_rate, operating_rate, timestamp_rate,
+		 input_rate, core->power.clk_freq, core->power.bw_ddr,
+		 core->power.bw_llcc);
+
+	return 0;
+}
+
+void msm_vidc_dcvs_data_reset(struct msm_vidc_inst *inst)
+{
+	struct msm_vidc_power *dcvs;
+	u32 min_count, actual_count, max_count;
+
+	dcvs = &inst->power;
+	if (is_encode_session(inst)) {
+		min_count = inst->buffers.input.min_count;
+		actual_count = inst->buffers.input.actual_count;
+		max_count = min((min_count + DCVS_ENC_EXTRA_INPUT_BUFFERS), actual_count);
+	} else if (is_decode_session(inst)) {
+		min_count = inst->buffers.output.min_count;
+		actual_count = inst->buffers.output.actual_count;
+		max_count = min((min_count + DCVS_DEC_EXTRA_OUTPUT_BUFFERS), actual_count);
+	} else {
+		i_vpr_e(inst, "%s: invalid domain type %d\n",
+			__func__, inst->domain);
+		return;
+	}
+
+	dcvs->min_threshold = min_count;
+	dcvs->max_threshold = max_count;
+	dcvs->dcvs_window = min_count < max_count ? max_count - min_count : 0;
+	dcvs->nom_threshold = dcvs->min_threshold + (dcvs->dcvs_window / 2);
+	dcvs->dcvs_flags = 0;
+
+	i_vpr_p(inst, "%s: dcvs: thresholds [%d %d %d] flags %#x\n",
+		__func__, dcvs->min_threshold,
+		dcvs->nom_threshold, dcvs->max_threshold,
+		dcvs->dcvs_flags);
+}
+
+void msm_vidc_power_data_reset(struct msm_vidc_inst *inst)
+{
+	int rc = 0;
+
+	msm_vidc_dcvs_data_reset(inst);
+
+	inst->power.buffer_counter = 0;
+	inst->power.fw_cr = 0;
+	inst->power.fw_cf = INT_MAX;
+
+	rc = msm_vidc_scale_power(inst, true);
+	if (rc)
+		i_vpr_e(inst, "%s: failed to scale power\n", __func__);
+}
-- 
2.7.4

