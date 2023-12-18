Return-Path: <linux-kernel+bounces-3478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4D816CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5351C22C90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29F3D0D8;
	Mon, 18 Dec 2023 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h7zOB8Js"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBD3B187;
	Mon, 18 Dec 2023 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBM4IU021485;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=lMKp0y/4t5au0RD/mod2lpTCZDH1CTSHKwpmYwCU3Ao=; b=h7
	zOB8JsDFx1QjH1V3H7xjK8usXoh0toOPR37q2hD74GrwkF4qdDLtOIrF92CVElhO
	2XBJmJmksjwWGXfw/rE3cJWQNTUQMP6uoCdhZbgkEsDSgXojFIE4OBefb7beCbmD
	2SuLqwsMDZFqLGT0lvwqnZWPNKpsKN2GBz+AQd7VF01J3Vz+glUef54s9Kt4ORgz
	xOAsVafqehQ4zK//bjorxcTB72slCDgVxoTrMFaPXyz+HL9dbddzdnc3Az9yEy+c
	/e2PbTDsAhfTGkX3R9fqQg0bID4Aistfefe2lwWRRf+yRyNUWOeMStb1tk8giUA3
	iqO+hj65XSbR47jKnVnQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2ghdgnby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX6PN029956;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ad-3;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7Xf029998;
	Mon, 18 Dec 2023 11:36:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6Fm029971;
	Mon, 18 Dec 2023 11:36:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 5D1182348; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 25/34] media: iris: subscribe src change and handle firmware responses
Date: Mon, 18 Dec 2023 17:02:20 +0530
Message-Id: <1702899149-21321-26-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZU2fDNi4bfxReJzlVZjn67Azg-RhH70l
X-Proofpoint-ORIG-GUID: ZU2fDNi4bfxReJzlVZjn67Azg-RhH70l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Driver can subscribe to different bitstream parameters
for which it expects a response from firmware.
These are vital bitstream parameters which requires
reconfiguration of buffers or sending updated info
to client. Incase of any change in these subscribed
parameters, firmware sends a response, which is then
sent to client as source change event.

HFI_CMD_SUBSCRIBE_MODE with HFI_MODE_PORT_SETTINGS_CHANGE
- to subscribe for different bitstream parameters.

Below properties are set to firmware as part of this:
HFI_PROP_BITSTREAM_RESOLUTION
HFI_PROP_CROP_OFFSETS
HFI_PROP_LUMA_CHROMA_BIT_DEPTH
HFI_PROP_CODED_FRAMES
HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT
HFI_PROP_PIC_ORDER_CNT_TYPE
HFI_PROP_SIGNAL_COLOR_INFO
HFI_PROP_PROFILE
HFI_PROP_LEVEL
HFI_PROP_TIER

Add the handling of different responses
from firmware. Below are different types of responses:

System responses:
- System error - response in case of system error occurred.
- System property - response for system level property - sys image version.
- System init - response for video core init completion.

Session responses:
- Session error - response in case of any session level error.
- Session property - response for all session properties.
  HFI_PROP_BITSTREAM_RESOLUTION
  HFI_PROP_CROP_OFFSETS
  HFI_PROP_LUMA_CHROMA_BIT_DEPTH
  HFI_PROP_CODED_FRAMES
  HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT
  HFI_PROP_PIC_ORDER_CNT_TYPE
  HFI_PROP_SIGNAL_COLOR_INFO
  HFI_PROP_PROFILE
  HFI_PROP_LEVEL
  HFI_PROP_TIER

- Session command - response for session level commands.
  HFI_CMD_OPEN - response for open competition.
  HFI_CMD_CLOSE - response for open competition.
  HFI_CMD_SETTINGS_CHANGE - response for change in subscribe parameters.
  HFI_CMD_SUBSCRIBE_MODE - response for info on subscribed properties.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  | 114 +++-
 .../media/platform/qcom/vcodec/iris/iris_common.h  |  25 +-
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   2 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  29 +-
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   4 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    | 195 +++++++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |  11 +-
 .../platform/qcom/vcodec/iris/iris_hfi_response.c  | 364 ++++++++++++-
 .../platform/qcom/vcodec/iris/iris_instance.h      |   8 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 580 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   4 +
 .../platform/qcom/vcodec/iris/platform_common.h    |   6 +
 .../platform/qcom/vcodec/iris/platform_sm8550.c    |  44 ++
 13 files changed, 1375 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index a6078a5..0ef6bad 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -10,6 +10,7 @@
 
 #define HFI_VIDEO_ARCH_LX			0x1
 
+#define HFI_CMD_BEGIN				0x01000000
 #define HFI_CMD_INIT				0x01000001
 #define HFI_CMD_OPEN				0x01000003
 #define HFI_CMD_CLOSE				0x01000004
@@ -31,7 +32,18 @@ enum hfi_property_mode_type {
 	HFI_MODE_PROPERTY				= 0x00000002,
 };
 
-#define HFI_CMD_SUBSCRIBE_MODE		0x0100000B
+#define HFI_CMD_SUBSCRIBE_MODE			0x0100000B
+#define HFI_CMD_SETTINGS_CHANGE			0x0100000C
+#define HFI_CMD_END				0x01FFFFFF
+
+#define HFI_BITMASK_BITSTREAM_WIDTH		0xffff0000
+#define HFI_BITMASK_BITSTREAM_HEIGHT		0x0000ffff
+
+#define HFI_BITMASK_FRAME_MBS_ONLY_FLAG		0x00000001
+
+#define HFI_PROP_BEGIN				0x03000000
+
+#define HFI_PROP_IMAGE_VERSION			0x03000001
 
 enum hfi_color_format {
 	HFI_COLOR_FMT_OPAQUE        = 0,
@@ -46,8 +58,12 @@ enum hfi_color_format {
 
 #define HFI_PROP_COLOR_FORMAT			0x03000101
 
+#define HFI_PROP_BITSTREAM_RESOLUTION		0x03000103
+
 #define HFI_PROP_LINEAR_STRIDE_SCANLINE		0x03000104
 
+#define HFI_PROP_CROP_OFFSETS			0x03000105
+
 #define HFI_PROP_PROFILE			0x03000107
 
 #define HFI_PROP_LEVEL				0x03000108
@@ -68,13 +84,83 @@ enum hfi_color_format {
 
 #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
 
+#define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
+
 #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
 
+#define HFI_PROP_QUALITY_MODE			0x03000148
+
+enum hfi_color_primaries {
+	HFI_PRIMARIES_RESERVED		= 0,
+	HFI_PRIMARIES_BT709		= 1,
+	HFI_PRIMARIES_UNSPECIFIED	= 2,
+	HFI_PRIMARIES_BT470_SYSTEM_M	= 4,
+	HFI_PRIMARIES_BT470_SYSTEM_BG	= 5,
+	HFI_PRIMARIES_BT601_525		= 6,
+	HFI_PRIMARIES_SMPTE_ST240M	= 7,
+	HFI_PRIMARIES_GENERIC_FILM	= 8,
+	HFI_PRIMARIES_BT2020		= 9,
+	HFI_PRIMARIES_SMPTE_ST428_1	= 10,
+	HFI_PRIMARIES_SMPTE_RP431_2	= 11,
+	HFI_PRIMARIES_SMPTE_EG431_1	= 12,
+	HFI_PRIMARIES_SMPTE_EBU_TECH	= 22,
+};
+
+enum hfi_transfer_characteristics {
+	HFI_TRANSFER_RESERVED		= 0,
+	HFI_TRANSFER_BT709		= 1,
+	HFI_TRANSFER_UNSPECIFIED	= 2,
+	HFI_TRANSFER_BT470_SYSTEM_M	= 4,
+	HFI_TRANSFER_BT470_SYSTEM_BG	= 5,
+	HFI_TRANSFER_BT601_525_OR_625	= 6,
+	HFI_TRANSFER_SMPTE_ST240M	= 7,
+	HFI_TRANSFER_LINEAR		= 8,
+	HFI_TRANSFER_LOG_100_1		= 9,
+	HFI_TRANSFER_LOG_SQRT		= 10,
+	HFI_TRANSFER_XVYCC		= 11,
+	HFI_TRANSFER_BT1361_0		= 12,
+	HFI_TRANSFER_SRGB_SYCC		= 13,
+	HFI_TRANSFER_BT2020_14		= 14,
+	HFI_TRANSFER_BT2020_15		= 15,
+	HFI_TRANSFER_SMPTE_ST2084_PQ	= 16,
+	HFI_TRANSFER_SMPTE_ST428_1	= 17,
+	HFI_TRANSFER_BT2100_2_HLG	= 18,
+};
+
+enum hfi_matrix_coefficients {
+	HFI_MATRIX_COEFF_SRGB_SMPTE_ST428_1		= 0,
+	HFI_MATRIX_COEFF_BT709				= 1,
+	HFI_MATRIX_COEFF_UNSPECIFIED			= 2,
+	HFI_MATRIX_COEFF_RESERVED			= 3,
+	HFI_MATRIX_COEFF_FCC_TITLE_47			= 4,
+	HFI_MATRIX_COEFF_BT470_SYS_BG_OR_BT601_625	= 5,
+	HFI_MATRIX_COEFF_BT601_525_BT1358_525_OR_625	= 6,
+	HFI_MATRIX_COEFF_SMPTE_ST240			= 7,
+	HFI_MATRIX_COEFF_YCGCO				= 8,
+	HFI_MATRIX_COEFF_BT2020_NON_CONSTANT		= 9,
+	HFI_MATRIX_COEFF_BT2020_CONSTANT		= 10,
+	HFI_MATRIX_COEFF_SMPTE_ST2085			= 11,
+	HFI_MATRIX_COEFF_SMPTE_CHROM_DERV_NON_CONSTANT	= 12,
+	HFI_MATRIX_COEFF_SMPTE_CHROM_DERV_CONSTANT	= 13,
+	HFI_MATRIX_COEFF_BT2100				= 14,
+};
+
+#define HFI_PROP_SIGNAL_COLOR_INFO		0x03000155
+
 #define HFI_PROP_DECODE_ORDER_OUTPUT		0x0300015b
 
+enum hfi_picture_type {
+	HFI_PICTURE_IDR	= 0x00000001,
+	HFI_PICTURE_P	= 0x00000002,
+	HFI_PICTURE_B	= 0x00000004,
+	HFI_PICTURE_I	= 0x00000008,
+	HFI_PICTURE_CRA	= 0x00000010,
+	HFI_PICTURE_BLA	= 0x00000020,
+};
+
 #define HFI_PROP_PICTURE_TYPE			0x03000162
 
-#define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
+#define HFI_PROP_DEC_DEFAULT_HEADER             0x03000168
 
 #define HFI_PROP_DEC_START_FROM_RAP_FRAME	0x03000169
 
@@ -86,7 +172,29 @@ enum hfi_color_format {
 
 #define HFI_PROP_COMV_BUFFER_COUNT		0x03000193
 
-#define HFI_SYS_ERROR_WD_TIMEOUT		0x05000001
+#define HFI_PROP_END				0x03FFFFFF
+
+#define HFI_SESSION_ERROR_BEGIN			0x04000000
+
+#define HFI_ERROR_UNKNOWN_SESSION		0x04000001
+
+#define HFI_ERROR_MAX_SESSIONS			0x04000002
+
+#define HFI_ERROR_FATAL				0x04000003
+
+#define HFI_ERROR_INVALID_STATE			0x04000004
+
+#define HFI_ERROR_INSUFFICIENT_RESOURCES	0x04000005
+
+#define HFI_ERROR_BUFFER_NOT_SET		0x04000006
+
+#define HFI_SESSION_ERROR_END			0x04FFFFFF
+
+#define HFI_SYSTEM_ERROR_BEGIN			0x05000000
+
+#define HFI_SYS_ERROR_WD_TIMEOUT                0x05000001
+
+#define HFI_SYSTEM_ERROR_END			0x05FFFFFF
 
 struct hfi_debug_header {
 	u32   size;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index 6b771f8..0fbd139 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -8,7 +8,6 @@
 #include <media/v4l2-dev.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
-#include <media/v4l2-ioctl.h>
 #include <media/videobuf2-v4l2.h>
 
 #define INPUT_MPLANE V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE
@@ -16,6 +15,7 @@
 #define DEFAULT_WIDTH 320
 #define DEFAULT_HEIGHT 240
 #define DEFAULT_BSE_VPP_DELAY    2
+#define IRIS_VERSION_LENGTH   128
 
 #define MAX_EVENTS   30
 
@@ -23,6 +23,9 @@
 
 #define NUM_MBS_4k (((4096 + 15) >> 4) * ((2304 + 15) >> 4))
 
+#define MAX_DPB_LIST_ARRAY_SIZE (16 * 4)
+#define MAX_DPB_LIST_PAYLOAD_SIZE (16 * 4 * 4)
+
 enum codec_type {
 	H264	= BIT(0),
 	HEVC	= BIT(1),
@@ -95,4 +98,24 @@ struct iris_buffer {
 	struct dma_buf_attachment	*attach;
 };
 
+struct subscription_params {
+	u32	bitstream_resolution;
+	u32	crop_offsets[2];
+	u32	bit_depth;
+	u32	coded_frames;
+	u32	fw_min_count;
+	u32	pic_order_cnt;
+	u32	color_info;
+	u32	profile;
+	u32	level;
+	u32	tier;
+};
+
+struct iris_hfi_frame_info {
+	u32	picture_type;
+	u32	no_output;
+	u32	data_corrupt;
+	u32	overflow;
+};
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 154991c..6452ea7 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -57,6 +57,7 @@
  * @inst_caps: a pointer to supported instance capabilities
  * @instances: a list_head of all instances
  * @intr_status: interrupt status
+ * @fw_version: firmware version
  */
 
 struct iris_core {
@@ -99,6 +100,7 @@ struct iris_core {
 	struct plat_inst_caps			*inst_caps;
 	struct list_head			instances;
 	u32					intr_status;
+	char					fw_version[IRIS_VERSION_LENGTH];
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index ff44cda..4cad673 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include "hfi_defines.h"
+#include "iris_core.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
@@ -66,7 +68,7 @@ int get_mbpf(struct iris_inst *inst)
 	return NUM_MBS_PER_FRAME(height, width);
 }
 
-bool is_linear_colorformat(u32 colorformat)
+inline bool is_linear_colorformat(u32 colorformat)
 {
 	return colorformat == V4L2_PIX_FMT_NV12 || colorformat == V4L2_PIX_FMT_NV21;
 }
@@ -350,3 +352,28 @@ int check_session_supported(struct iris_inst *inst)
 
 	return ret;
 }
+
+int signal_session_msg_receipt(struct iris_inst *inst,
+			       enum signal_session_response cmd)
+{
+	if (cmd < MAX_SIGNAL)
+		complete(&inst->completions[cmd]);
+
+	return 0;
+}
+
+struct iris_inst *to_instance(struct iris_core *core, u32 session_id)
+{
+	struct iris_inst *inst = NULL;
+
+	mutex_lock(&core->lock);
+	list_for_each_entry(inst, &core->instances, list) {
+		if (inst->session_id == session_id) {
+			mutex_unlock(&core->lock);
+			return inst;
+		}
+	}
+	mutex_unlock(&core->lock);
+
+	return NULL;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index fe85d23..cb22adf 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -31,6 +31,10 @@ bool is_linear_colorformat(u32 colorformat);
 bool is_10bit_colorformat(enum colorformat_type colorformat);
 bool is_8bit_colorformat(enum colorformat_type colorformat);
 bool is_split_mode_enabled(struct iris_inst *inst);
+int signal_session_msg_receipt(struct iris_inst *inst,
+			       enum signal_session_response cmd);
+struct iris_inst *to_instance(struct iris_core *core, u32 session_id);
+
 u32 v4l2_codec_from_driver(struct iris_inst *inst, enum codec_type codec);
 enum codec_type v4l2_codec_to_driver(struct iris_inst *inst, u32 v4l2_codec);
 u32 v4l2_colorformat_from_driver(struct iris_inst *inst, enum colorformat_type colorformat);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index d4cdfcf..dc7157d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -100,6 +100,201 @@ u32 get_hfi_colorformat(u32 colorformat)
 	return hfi_colorformat;
 }
 
+u32 get_hfi_color_primaries(u32 primaries)
+{
+	u32 hfi_primaries = HFI_PRIMARIES_RESERVED;
+
+	switch (primaries) {
+	case V4L2_COLORSPACE_DEFAULT:
+		hfi_primaries = HFI_PRIMARIES_RESERVED;
+		break;
+	case V4L2_COLORSPACE_REC709:
+		hfi_primaries = HFI_PRIMARIES_BT709;
+		break;
+	case V4L2_COLORSPACE_470_SYSTEM_M:
+		hfi_primaries = HFI_PRIMARIES_BT470_SYSTEM_M;
+		break;
+	case V4L2_COLORSPACE_470_SYSTEM_BG:
+		hfi_primaries = HFI_PRIMARIES_BT470_SYSTEM_BG;
+		break;
+	case V4L2_COLORSPACE_SMPTE170M:
+		hfi_primaries = HFI_PRIMARIES_BT601_525;
+		break;
+	case V4L2_COLORSPACE_SMPTE240M:
+		hfi_primaries = HFI_PRIMARIES_SMPTE_ST240M;
+		break;
+	case V4L2_COLORSPACE_BT2020:
+		hfi_primaries = HFI_PRIMARIES_BT2020;
+		break;
+	case V4L2_COLORSPACE_DCI_P3:
+		hfi_primaries = HFI_PRIMARIES_SMPTE_RP431_2;
+		break;
+	default:
+		break;
+	}
+
+	return hfi_primaries;
+}
+
+u32 get_hfi_transfer_char(u32 characterstics)
+{
+	u32 hfi_characterstics = HFI_TRANSFER_RESERVED;
+
+	switch (characterstics) {
+	case V4L2_XFER_FUNC_DEFAULT:
+		hfi_characterstics = HFI_TRANSFER_RESERVED;
+		break;
+	case V4L2_XFER_FUNC_709:
+		hfi_characterstics = HFI_TRANSFER_BT709;
+		break;
+	case V4L2_XFER_FUNC_SMPTE240M:
+		hfi_characterstics = HFI_TRANSFER_SMPTE_ST240M;
+		break;
+	case V4L2_XFER_FUNC_SRGB:
+		hfi_characterstics = HFI_TRANSFER_SRGB_SYCC;
+		break;
+	case V4L2_XFER_FUNC_SMPTE2084:
+		hfi_characterstics = HFI_TRANSFER_SMPTE_ST2084_PQ;
+		break;
+	default:
+		break;
+	}
+
+	return hfi_characterstics;
+}
+
+u32 get_hfi_matrix_coefficients(u32 coefficients)
+{
+	u32 hfi_coefficients = HFI_MATRIX_COEFF_RESERVED;
+
+	switch (coefficients) {
+	case V4L2_YCBCR_ENC_DEFAULT:
+		hfi_coefficients = HFI_MATRIX_COEFF_RESERVED;
+		break;
+	case V4L2_YCBCR_ENC_709:
+		hfi_coefficients = HFI_MATRIX_COEFF_BT709;
+		break;
+	case V4L2_YCBCR_ENC_XV709:
+		hfi_coefficients = HFI_MATRIX_COEFF_BT709;
+		break;
+	case V4L2_YCBCR_ENC_XV601:
+		hfi_coefficients = HFI_MATRIX_COEFF_BT470_SYS_BG_OR_BT601_625;
+		break;
+	case V4L2_YCBCR_ENC_601:
+		hfi_coefficients = HFI_MATRIX_COEFF_BT601_525_BT1358_525_OR_625;
+		break;
+	case V4L2_YCBCR_ENC_SMPTE240M:
+		hfi_coefficients = HFI_MATRIX_COEFF_SMPTE_ST240;
+		break;
+	case V4L2_YCBCR_ENC_BT2020:
+		hfi_coefficients = HFI_MATRIX_COEFF_BT2020_NON_CONSTANT;
+		break;
+	case V4L2_YCBCR_ENC_BT2020_CONST_LUM:
+		hfi_coefficients = HFI_MATRIX_COEFF_BT2020_CONSTANT;
+		break;
+	default:
+		break;
+	}
+
+	return hfi_coefficients;
+}
+
+u32 get_v4l2_color_primaries(u32 hfi_primaries)
+{
+	u32 primaries = V4L2_COLORSPACE_DEFAULT;
+
+	switch (hfi_primaries) {
+	case HFI_PRIMARIES_RESERVED:
+		primaries = V4L2_COLORSPACE_DEFAULT;
+		break;
+	case HFI_PRIMARIES_BT709:
+		primaries = V4L2_COLORSPACE_REC709;
+		break;
+	case HFI_PRIMARIES_BT470_SYSTEM_M:
+		primaries = V4L2_COLORSPACE_470_SYSTEM_M;
+		break;
+	case HFI_PRIMARIES_BT470_SYSTEM_BG:
+		primaries = V4L2_COLORSPACE_470_SYSTEM_BG;
+		break;
+	case HFI_PRIMARIES_BT601_525:
+		primaries = V4L2_COLORSPACE_SMPTE170M;
+		break;
+	case HFI_PRIMARIES_SMPTE_ST240M:
+		primaries = V4L2_COLORSPACE_SMPTE240M;
+		break;
+	case HFI_PRIMARIES_BT2020:
+		primaries = V4L2_COLORSPACE_BT2020;
+		break;
+	case V4L2_COLORSPACE_DCI_P3:
+		primaries = HFI_PRIMARIES_SMPTE_RP431_2;
+		break;
+	default:
+		break;
+	}
+
+	return primaries;
+}
+
+u32 get_v4l2_transfer_char(u32 hfi_characterstics)
+{
+	u32 characterstics = V4L2_XFER_FUNC_DEFAULT;
+
+	switch (hfi_characterstics) {
+	case HFI_TRANSFER_RESERVED:
+		characterstics = V4L2_XFER_FUNC_DEFAULT;
+		break;
+	case HFI_TRANSFER_BT709:
+		characterstics = V4L2_XFER_FUNC_709;
+		break;
+	case HFI_TRANSFER_SMPTE_ST240M:
+		characterstics = V4L2_XFER_FUNC_SMPTE240M;
+		break;
+	case HFI_TRANSFER_SRGB_SYCC:
+		characterstics = V4L2_XFER_FUNC_SRGB;
+		break;
+	case HFI_TRANSFER_SMPTE_ST2084_PQ:
+		characterstics = V4L2_XFER_FUNC_SMPTE2084;
+		break;
+	default:
+		break;
+	}
+
+	return characterstics;
+}
+
+u32 get_v4l2_matrix_coefficients(u32 hfi_coefficients)
+{
+	u32 coefficients = V4L2_YCBCR_ENC_DEFAULT;
+
+	switch (hfi_coefficients) {
+	case HFI_MATRIX_COEFF_RESERVED:
+		coefficients = V4L2_YCBCR_ENC_DEFAULT;
+		break;
+	case HFI_MATRIX_COEFF_BT709:
+		coefficients = V4L2_YCBCR_ENC_709;
+		break;
+	case HFI_MATRIX_COEFF_BT470_SYS_BG_OR_BT601_625:
+		coefficients = V4L2_YCBCR_ENC_XV601;
+		break;
+	case HFI_MATRIX_COEFF_BT601_525_BT1358_525_OR_625:
+		coefficients = V4L2_YCBCR_ENC_601;
+		break;
+	case HFI_MATRIX_COEFF_SMPTE_ST240:
+		coefficients = V4L2_YCBCR_ENC_SMPTE240M;
+		break;
+	case HFI_MATRIX_COEFF_BT2020_NON_CONSTANT:
+		coefficients = V4L2_YCBCR_ENC_BT2020;
+		break;
+	case HFI_MATRIX_COEFF_BT2020_CONSTANT:
+		coefficients = V4L2_YCBCR_ENC_BT2020_CONST_LUM;
+		break;
+	default:
+		break;
+	}
+
+	return coefficients;
+}
+
 int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf)
 {
 	memset(buf, 0, sizeof(*buf));
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index 4276d6d..f813116 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -80,10 +80,17 @@ enum hfi_packet_port_type {
 };
 
 u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type);
-int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf);
-u32 get_hfi_colorformat(u32 colorformat);
 u32 get_hfi_port(u32 plane);
 
+u32 get_hfi_colorformat(u32 colorformat);
+u32 get_hfi_color_primaries(u32 primaries);
+u32 get_hfi_transfer_char(u32 characterstics);
+u32 get_hfi_matrix_coefficients(u32 coefficients);
+u32 get_v4l2_color_primaries(u32 hfi_primaries);
+u32 get_v4l2_transfer_char(u32 hfi_characterstics);
+u32 get_v4l2_matrix_coefficients(u32 hfi_coefficients);
+int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf);
+
 int hfi_packet_sys_init(struct iris_core *core,
 			u8 *pkt, u32 pkt_size);
 int hfi_packet_image_version(struct iris_core *core,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
index 829f3f6..4ca9314 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
@@ -4,8 +4,27 @@
  */
 
 #include "hfi_defines.h"
+#include "iris_helpers.h"
 #include "iris_hfi_packet.h"
 #include "iris_hfi_response.h"
+#include "iris_vdec.h"
+
+struct iris_core_hfi_range {
+	u32 begin;
+	u32 end;
+	int (*handle)(struct iris_core *core, struct hfi_packet *pkt);
+};
+
+struct iris_inst_hfi_range {
+	u32 begin;
+	u32 end;
+	int (*handle)(struct iris_inst *inst, struct hfi_packet *pkt);
+};
+
+struct iris_hfi_packet_handle {
+	enum hfi_buffer_type type;
+	int (*handle)(struct iris_inst *inst, struct hfi_packet *pkt);
+};
 
 static void print_sfr_message(struct iris_core *core)
 {
@@ -25,8 +44,7 @@ static void print_sfr_message(struct iris_core *core)
 	}
 }
 
-static int validate_packet(u8 *response_pkt, u8 *core_resp_pkt,
-			   u32 core_resp_pkt_size)
+static int validate_packet(u8 *response_pkt, u8 *core_resp_pkt, u32 core_resp_pkt_size)
 {
 	u32 response_pkt_size = 0;
 	u8 *response_limit;
@@ -52,8 +70,7 @@ static int validate_packet(u8 *response_pkt, u8 *core_resp_pkt,
 	return 0;
 }
 
-static int validate_hdr_packet(struct iris_core *core,
-			       struct hfi_header *hdr)
+static int validate_hdr_packet(struct iris_core *core, struct hfi_header *hdr)
 {
 	struct hfi_packet *packet;
 	int i, ret = 0;
@@ -76,6 +93,45 @@ static int validate_hdr_packet(struct iris_core *core,
 	return ret;
 }
 
+static int handle_session_error(struct iris_inst *inst,
+				struct hfi_packet *pkt)
+{
+	struct iris_core *core;
+	char *error;
+
+	core = inst->core;
+
+	switch (pkt->type) {
+	case HFI_ERROR_MAX_SESSIONS:
+		error = "exceeded max sessions";
+		break;
+	case HFI_ERROR_UNKNOWN_SESSION:
+		error = "unknown session id";
+		break;
+	case HFI_ERROR_INVALID_STATE:
+		error = "invalid operation for current state";
+		break;
+	case HFI_ERROR_INSUFFICIENT_RESOURCES:
+		error = "insufficient resources";
+		break;
+	case HFI_ERROR_BUFFER_NOT_SET:
+		error = "internal buffers not set";
+		break;
+	case HFI_ERROR_FATAL:
+		error = "fatal error";
+		break;
+	default:
+		error = "unknown";
+		break;
+	}
+
+	dev_err(core->dev, "session error received %#x: %s\n",
+		pkt->type, error);
+	iris_inst_change_state(inst, IRIS_INST_ERROR);
+
+	return 0;
+}
+
 static int handle_system_error(struct iris_core *core,
 			       struct hfi_packet *pkt)
 {
@@ -86,6 +142,301 @@ static int handle_system_error(struct iris_core *core,
 	return 0;
 }
 
+static int handle_system_init(struct iris_core *core,
+			      struct hfi_packet *pkt)
+{
+	if (!(pkt->flags & HFI_FW_FLAGS_SUCCESS))
+		return 0;
+
+	mutex_lock(&core->lock);
+	if (pkt->packet_id != core->sys_init_id)
+		goto unlock;
+
+	iris_change_core_state(core, IRIS_CORE_INIT);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return 0;
+}
+
+static int handle_session_close(struct iris_inst *inst,
+				struct hfi_packet *pkt)
+{
+	signal_session_msg_receipt(inst, SIGNAL_CMD_CLOSE);
+
+	return 0;
+}
+
+static int handle_src_change(struct iris_inst *inst,
+			     struct hfi_packet *pkt)
+{
+	int ret = 0;
+
+	if (pkt->port == HFI_PORT_BITSTREAM)
+		ret = vdec_src_change(inst);
+	else if (pkt->port == HFI_PORT_RAW)
+		ret = 0;
+
+	if (ret)
+		iris_inst_change_state(inst, IRIS_INST_ERROR);
+
+	return ret;
+}
+
+static int handle_session_command(struct iris_inst *inst,
+				  struct hfi_packet *pkt)
+{
+	int i, ret = 0;
+	static const struct iris_hfi_packet_handle hfi_pkt_handle[] = {
+		{HFI_CMD_OPEN,              NULL                    },
+		{HFI_CMD_CLOSE,             handle_session_close    },
+		{HFI_CMD_SETTINGS_CHANGE,   handle_src_change       },
+		{HFI_CMD_SUBSCRIBE_MODE,    NULL                    },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(hfi_pkt_handle); i++) {
+		if (hfi_pkt_handle[i].type == pkt->type) {
+			if (hfi_pkt_handle[i].handle) {
+				ret = hfi_pkt_handle[i].handle(inst, pkt);
+				if (ret)
+					return ret;
+			}
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(hfi_pkt_handle))
+		return -EINVAL;
+
+	return ret;
+}
+
+static int handle_dpb_list_property(struct iris_inst *inst,
+				    struct hfi_packet *pkt)
+{
+	u8 *payload_start;
+	u32 payload_size;
+
+	payload_size = pkt->size - sizeof(*pkt);
+	payload_start = (u8 *)((u8 *)pkt + sizeof(*pkt));
+	memset(inst->dpb_list_payload, 0, MAX_DPB_LIST_ARRAY_SIZE);
+
+	if (payload_size > MAX_DPB_LIST_PAYLOAD_SIZE) {
+		iris_inst_change_state(inst, IRIS_INST_ERROR);
+		return -EINVAL;
+	}
+
+	memcpy(inst->dpb_list_payload, payload_start, payload_size);
+
+	return 0;
+}
+
+static int handle_session_property(struct iris_inst *inst,
+				   struct hfi_packet *pkt)
+{
+	u32 *payload_ptr = NULL;
+	int ret = 0;
+
+	if (pkt->port != HFI_PORT_BITSTREAM)
+		return 0;
+
+	if (pkt->flags & HFI_FW_FLAGS_INFORMATION)
+		return 0;
+
+	payload_ptr = (u32 *)((u8 *)pkt + sizeof(*pkt));
+	if (!payload_ptr)
+		return -EINVAL;
+
+	switch (pkt->type) {
+	case HFI_PROP_BITSTREAM_RESOLUTION:
+		inst->src_subcr_params.bitstream_resolution = payload_ptr[0];
+		break;
+	case HFI_PROP_CROP_OFFSETS:
+		inst->src_subcr_params.crop_offsets[0] = payload_ptr[0];
+		inst->src_subcr_params.crop_offsets[1] = payload_ptr[1];
+		break;
+	case HFI_PROP_LUMA_CHROMA_BIT_DEPTH:
+		inst->src_subcr_params.bit_depth = payload_ptr[0];
+		break;
+	case HFI_PROP_CODED_FRAMES:
+		inst->src_subcr_params.coded_frames = payload_ptr[0];
+		break;
+	case HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT:
+		inst->src_subcr_params.fw_min_count = payload_ptr[0];
+		break;
+	case HFI_PROP_PIC_ORDER_CNT_TYPE:
+		inst->src_subcr_params.pic_order_cnt = payload_ptr[0];
+		break;
+	case HFI_PROP_SIGNAL_COLOR_INFO:
+		inst->src_subcr_params.color_info = payload_ptr[0];
+		break;
+	case HFI_PROP_PROFILE:
+		inst->src_subcr_params.profile = payload_ptr[0];
+		break;
+	case HFI_PROP_LEVEL:
+		inst->src_subcr_params.level = payload_ptr[0];
+		break;
+	case HFI_PROP_TIER:
+		inst->src_subcr_params.tier = payload_ptr[0];
+		break;
+	case HFI_PROP_PICTURE_TYPE:
+		inst->hfi_frame_info.picture_type = payload_ptr[0];
+		break;
+	case HFI_PROP_DPB_LIST:
+		ret = handle_dpb_list_property(inst, pkt);
+		if (ret)
+			break;
+		break;
+	case HFI_PROP_NO_OUTPUT:
+		inst->hfi_frame_info.no_output = 1;
+		break;
+	case HFI_PROP_QUALITY_MODE:
+	case HFI_PROP_STAGE:
+	case HFI_PROP_PIPE:
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int handle_image_version_property(struct iris_core *core,
+					 struct hfi_packet *pkt)
+{
+	u8 *str_image_version;
+	u32 req_bytes;
+	u32 i = 0;
+
+	req_bytes = pkt->size - sizeof(*pkt);
+	if (req_bytes < IRIS_VERSION_LENGTH - 1)
+		return -EINVAL;
+
+	str_image_version = (u8 *)pkt + sizeof(*pkt);
+
+	for (i = 0; i < IRIS_VERSION_LENGTH - 1; i++) {
+		if (str_image_version[i] != '\0')
+			core->fw_version[i] = str_image_version[i];
+		else
+			core->fw_version[i] = ' ';
+	}
+	core->fw_version[i] = '\0';
+
+	return 0;
+}
+
+static int handle_system_property(struct iris_core *core,
+				  struct hfi_packet *pkt)
+{
+	int ret = 0;
+
+	switch (pkt->type) {
+	case HFI_PROP_IMAGE_VERSION:
+		ret = handle_image_version_property(core, pkt);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int handle_system_response(struct iris_core *core,
+				  struct hfi_header *hdr)
+{
+	struct hfi_packet *packet;
+	u8 *pkt, *start_pkt;
+	int ret = 0;
+	int i, j;
+	static const struct iris_core_hfi_range be[] = {
+		{HFI_SYSTEM_ERROR_BEGIN,   HFI_SYSTEM_ERROR_END,   handle_system_error     },
+		{HFI_PROP_BEGIN,           HFI_PROP_END,           handle_system_property  },
+		{HFI_CMD_BEGIN,            HFI_CMD_END,            handle_system_init      },
+	};
+
+	start_pkt = (u8 *)((u8 *)hdr + sizeof(*hdr));
+	for (i = 0; i < ARRAY_SIZE(be); i++) {
+		pkt = start_pkt;
+		for (j = 0; j < hdr->num_packets; j++) {
+			packet = (struct hfi_packet *)pkt;
+			if (packet->flags & HFI_FW_FLAGS_SYSTEM_ERROR) {
+				ret = handle_system_error(core, packet);
+				return ret;
+			}
+
+			if (packet->type > be[i].begin && packet->type < be[i].end) {
+				ret = be[i].handle(core, packet);
+				if (ret)
+					return ret;
+
+				if (packet->type >  HFI_SYSTEM_ERROR_BEGIN &&
+				    packet->type < HFI_SYSTEM_ERROR_END)
+					return 0;
+			}
+			pkt += packet->size;
+		}
+	}
+
+	return ret;
+}
+
+static int handle_session_response(struct iris_core *core,
+				   struct hfi_header *hdr)
+{
+	struct hfi_packet *packet;
+	struct iris_inst *inst;
+	u8 *pkt, *start_pkt;
+	int ret = 0;
+	int i, j;
+	static const struct iris_inst_hfi_range be[] = {
+		{HFI_SESSION_ERROR_BEGIN,  HFI_SESSION_ERROR_END,  handle_session_error    },
+		{HFI_PROP_BEGIN,           HFI_PROP_END,           handle_session_property },
+		{HFI_CMD_BEGIN,            HFI_CMD_END,            handle_session_command  },
+	};
+
+	inst = to_instance(core, hdr->session_id);
+	if (!inst)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	memset(&inst->hfi_frame_info, 0, sizeof(struct iris_hfi_frame_info));
+
+	pkt = (u8 *)((u8 *)hdr + sizeof(*hdr));
+	for (i = 0; i < hdr->num_packets; i++) {
+		packet = (struct hfi_packet *)pkt;
+		if (packet->type == HFI_CMD_SETTINGS_CHANGE) {
+			if (packet->port == HFI_PORT_BITSTREAM) {
+				vdec_init_src_change_param(inst);
+				break;
+			}
+		}
+		pkt += packet->size;
+	}
+
+	start_pkt = (u8 *)((u8 *)hdr + sizeof(*hdr));
+	for (i = 0; i < ARRAY_SIZE(be); i++) {
+		pkt = start_pkt;
+		for (j = 0; j < hdr->num_packets; j++) {
+			packet = (struct hfi_packet *)pkt;
+			if (packet->flags & HFI_FW_FLAGS_SESSION_ERROR)
+				handle_session_error(inst, packet);
+
+			if (packet->type > be[i].begin && packet->type < be[i].end) {
+				ret = be[i].handle(inst, packet);
+				if (ret)
+					iris_inst_change_state(inst, IRIS_INST_ERROR);
+			}
+			pkt += packet->size;
+		}
+	}
+
+	memset(&inst->hfi_frame_info, 0, sizeof(struct iris_hfi_frame_info));
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
 static int handle_response(struct iris_core *core, void *response)
 {
 	struct hfi_header *hdr;
@@ -96,6 +447,11 @@ static int handle_response(struct iris_core *core, void *response)
 	if (ret)
 		return handle_system_error(core, NULL);
 
+	if (!hdr->session_id)
+		return handle_system_response(core, hdr);
+	else
+		return handle_session_response(core, hdr);
+
 	return ret;
 }
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 365f844..4f51d68 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -40,6 +40,10 @@
  * @fw_min_count: minimnum count of buffers needed by fw
  * @state: instance state
  * @ipsc_properties_set: boolean to set ipsc properties to fw
+ * @hfi_frame_info: structure of frame info
+ * @src_subcr_params: subscription params to fw on input port
+ * @dst_subcr_params: subscription params to fw on output port
+ * @dpb_list_payload: array of dpb buffers
  */
 
 struct iris_inst {
@@ -66,6 +70,10 @@ struct iris_inst {
 	u32				fw_min_count;
 	enum iris_inst_state		state;
 	bool				ipsc_properties_set;
+	struct iris_hfi_frame_info	hfi_frame_info;
+	struct subscription_params	src_subcr_params;
+	struct subscription_params	dst_subcr_params;
+	u32				dpb_list_payload[MAX_DPB_LIST_ARRAY_SIZE];
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 7d16c96..ac47fc0 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -14,6 +14,13 @@
 #include "iris_hfi_packet.h"
 #include "iris_vdec.h"
 
+#define UNSPECIFIED_COLOR_FORMAT 5
+
+struct vdec_prop_type_handle {
+	u32 type;
+	int (*handle)(struct iris_inst *inst);
+};
+
 static int vdec_codec_change(struct iris_inst *inst, u32 v4l2_codec)
 {
 	bool session_init = false;
@@ -376,6 +383,455 @@ int vdec_subscribe_property(struct iris_inst *inst, u32 plane)
 					(subscribe_prop_size + 1) * sizeof(u32));
 }
 
+static int vdec_set_bitstream_resolution(struct iris_inst *inst)
+{
+	u32 resolution;
+
+	resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
+		inst->fmt_src->fmt.pix_mp.height;
+	inst->src_subcr_params.bitstream_resolution = resolution;
+
+	return iris_hfi_set_property(inst,
+					HFI_PROP_BITSTREAM_RESOLUTION,
+					HFI_HOST_FLAGS_NONE,
+					get_hfi_port(INPUT_MPLANE),
+					HFI_PAYLOAD_U32,
+					&resolution,
+					sizeof(u32));
+}
+
+static int vdec_set_crop_offsets(struct iris_inst *inst)
+{
+	u32 left_offset, top_offset, right_offset, bottom_offset;
+	u32 payload[2] = {0};
+
+	left_offset = inst->crop.left;
+	top_offset = inst->crop.top;
+	right_offset = (inst->fmt_src->fmt.pix_mp.width -
+		inst->crop.width);
+	bottom_offset = (inst->fmt_src->fmt.pix_mp.height -
+		inst->crop.height);
+
+	payload[0] = left_offset << 16 | top_offset;
+	payload[1] = right_offset << 16 | bottom_offset;
+	inst->src_subcr_params.crop_offsets[0] = payload[0];
+	inst->src_subcr_params.crop_offsets[1] = payload[1];
+
+	return iris_hfi_set_property(inst,
+					HFI_PROP_CROP_OFFSETS,
+					HFI_HOST_FLAGS_NONE,
+					get_hfi_port(INPUT_MPLANE),
+					HFI_PAYLOAD_64_PACKED,
+					&payload,
+					sizeof(u64));
+}
+
+static int vdec_set_bit_depth(struct iris_inst *inst)
+{
+	u32 bitdepth = 8 << 16 | 8;
+	u32 pix_fmt;
+
+	pix_fmt = inst->fmt_dst->fmt.pix_mp.pixelformat;
+	if (is_10bit_colorformat(pix_fmt))
+		bitdepth = 10 << 16 | 10;
+
+	inst->src_subcr_params.bit_depth = bitdepth;
+	inst->cap[BIT_DEPTH].value = bitdepth;
+
+	return iris_hfi_set_property(inst,
+					HFI_PROP_LUMA_CHROMA_BIT_DEPTH,
+					HFI_HOST_FLAGS_NONE,
+					get_hfi_port(INPUT_MPLANE),
+					HFI_PAYLOAD_U32,
+					&bitdepth,
+					sizeof(u32));
+}
+
+static int vdec_set_coded_frames(struct iris_inst *inst)
+{
+	u32 coded_frames = 0;
+
+	if (inst->cap[CODED_FRAMES].value == CODED_FRAMES_PROGRESSIVE)
+		coded_frames = HFI_BITMASK_FRAME_MBS_ONLY_FLAG;
+	inst->src_subcr_params.coded_frames = coded_frames;
+
+	return iris_hfi_set_property(inst,
+					HFI_PROP_CODED_FRAMES,
+					HFI_HOST_FLAGS_NONE,
+					get_hfi_port(INPUT_MPLANE),
+					HFI_PAYLOAD_U32,
+					&coded_frames,
+					sizeof(u32));
+}
+
+static int vdec_set_min_output_count(struct iris_inst *inst)
+{
+	u32 min_output;
+
+	min_output = inst->buffers.output.min_count;
+	inst->src_subcr_params.fw_min_count = min_output;
+
+	return iris_hfi_set_property(inst,
+					HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT,
+					HFI_HOST_FLAGS_NONE,
+					get_hfi_port(INPUT_MPLANE),
+					HFI_PAYLOAD_U32,
+					&min_output,
+					sizeof(u32));
+}
+
+static int vdec_set_picture_order_count(struct iris_inst *inst)
+{
+	u32 poc = 0;
+
+	inst->src_subcr_params.pic_order_cnt = poc;
+
+	return iris_hfi_set_property(inst,
+					HFI_PROP_PIC_ORDER_CNT_TYPE,
+					HFI_HOST_FLAGS_NONE,
+					get_hfi_port(INPUT_MPLANE),
+					HFI_PAYLOAD_U32,
+					&poc,
+					sizeof(u32));
+}
+
+static int vdec_set_colorspace(struct iris_inst *inst)
+{
+	u32 video_signal_type_present_flag = 0, color_info = 0;
+	u32 matrix_coeff = HFI_MATRIX_COEFF_RESERVED;
+	u32 video_format = UNSPECIFIED_COLOR_FORMAT;
+	struct v4l2_pix_format_mplane *pixmp = NULL;
+	u32 full_range = V4L2_QUANTIZATION_DEFAULT;
+	u32 transfer_char = HFI_TRANSFER_RESERVED;
+	u32 colour_description_present_flag = 0;
+	u32 primaries = HFI_PRIMARIES_RESERVED;
+
+	int ret;
+
+	if (inst->codec == VP9)
+		return 0;
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
+	color_info = (matrix_coeff & 0xFF) |
+		((transfer_char << 8) & 0xFF00) |
+		((primaries << 16) & 0xFF0000) |
+		((colour_description_present_flag << 24) & 0x1000000) |
+		((full_range << 25) & 0x2000000) |
+		((video_format << 26) & 0x1C000000) |
+		((video_signal_type_present_flag << 29) & 0x20000000);
+
+	inst->src_subcr_params.color_info = color_info;
+
+	ret = iris_hfi_set_property(inst,
+				    HFI_PROP_SIGNAL_COLOR_INFO,
+				    HFI_HOST_FLAGS_NONE,
+				    get_hfi_port(INPUT_MPLANE),
+				    HFI_PAYLOAD_32_PACKED,
+				    &color_info,
+				    sizeof(u32));
+
+	return ret;
+}
+
+static int vdec_set_profile(struct iris_inst *inst)
+{
+	u32 profile;
+
+	profile = inst->cap[PROFILE].value;
+	inst->src_subcr_params.profile = profile;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_PROFILE,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(INPUT_MPLANE),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &profile,
+				     sizeof(u32));
+}
+
+static int vdec_set_level(struct iris_inst *inst)
+{
+	u32 level;
+
+	level = inst->cap[LEVEL].value;
+	inst->src_subcr_params.level = level;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_LEVEL,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(INPUT_MPLANE),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &level,
+				     sizeof(u32));
+}
+
+static int vdec_set_tier(struct iris_inst *inst)
+{
+	u32 tier;
+
+	tier = inst->cap[HEVC_TIER].value;
+	inst->src_subcr_params.tier = tier;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_TIER,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(INPUT_MPLANE),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &tier,
+				     sizeof(u32));
+}
+
+int vdec_subscribe_src_change_param(struct iris_inst *inst)
+{
+	const u32 *src_change_param;
+	u32 src_change_param_size;
+	struct iris_core *core;
+	u32 payload[32] = {0};
+	int ret;
+	u32 i, j;
+
+	static const struct vdec_prop_type_handle prop_type_handle_arr[] = {
+		{HFI_PROP_BITSTREAM_RESOLUTION,          vdec_set_bitstream_resolution   },
+		{HFI_PROP_CROP_OFFSETS,                  vdec_set_crop_offsets           },
+		{HFI_PROP_LUMA_CHROMA_BIT_DEPTH,         vdec_set_bit_depth              },
+		{HFI_PROP_CODED_FRAMES,                  vdec_set_coded_frames           },
+		{HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT,    vdec_set_min_output_count       },
+		{HFI_PROP_PIC_ORDER_CNT_TYPE,            vdec_set_picture_order_count    },
+		{HFI_PROP_SIGNAL_COLOR_INFO,             vdec_set_colorspace             },
+		{HFI_PROP_PROFILE,                       vdec_set_profile                },
+		{HFI_PROP_LEVEL,                         vdec_set_level                  },
+		{HFI_PROP_TIER,                          vdec_set_tier                   },
+	};
+
+	core = inst->core;
+
+	payload[0] = HFI_MODE_PORT_SETTINGS_CHANGE;
+	if (inst->codec == H264) {
+		src_change_param_size = core->platform_data->avc_subscribe_param_size;
+		src_change_param = core->platform_data->avc_subscribe_param;
+	} else if (inst->codec == HEVC) {
+		src_change_param_size = core->platform_data->hevc_subscribe_param_size;
+		src_change_param = core->platform_data->hevc_subscribe_param;
+	} else if (inst->codec == VP9) {
+		src_change_param_size = core->platform_data->vp9_subscribe_param_size;
+		src_change_param = core->platform_data->vp9_subscribe_param;
+	} else {
+		src_change_param = NULL;
+		return -EINVAL;
+	}
+
+	if (!src_change_param || !src_change_param_size)
+		return -EINVAL;
+
+	for (i = 0; i < src_change_param_size; i++)
+		payload[i + 1] = src_change_param[i];
+
+	ret = iris_hfi_session_subscribe_mode(inst,
+					      HFI_CMD_SUBSCRIBE_MODE,
+					      INPUT_MPLANE,
+					      HFI_PAYLOAD_U32_ARRAY,
+					      &payload[0],
+					      ((src_change_param_size + 1) * sizeof(u32)));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < src_change_param_size; i++) {
+		for (j = 0; j < ARRAY_SIZE(prop_type_handle_arr); j++) {
+			if (prop_type_handle_arr[j].type == src_change_param[i]) {
+				ret = prop_type_handle_arr[j].handle(inst);
+				if (ret)
+					return ret;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+int vdec_init_src_change_param(struct iris_inst *inst)
+{
+	u32 left_offset, top_offset, right_offset, bottom_offset;
+	struct v4l2_pix_format_mplane *pixmp_ip, *pixmp_op;
+	u32 primaries, matrix_coeff, transfer_char;
+	struct subscription_params *subsc_params;
+	u32 colour_description_present_flag = 0;
+	u32 video_signal_type_present_flag = 0;
+	u32 full_range = 0, video_format = 0;
+
+	subsc_params = &inst->src_subcr_params;
+	pixmp_ip = &inst->fmt_src->fmt.pix_mp;
+	pixmp_op = &inst->fmt_dst->fmt.pix_mp;
+
+	subsc_params->bitstream_resolution =
+		pixmp_ip->width << 16 | pixmp_ip->height;
+
+	left_offset = inst->crop.left;
+	top_offset = inst->crop.top;
+	right_offset = (pixmp_ip->width - inst->crop.width);
+	bottom_offset = (pixmp_ip->height - inst->crop.height);
+	subsc_params->crop_offsets[0] =
+			left_offset << 16 | top_offset;
+	subsc_params->crop_offsets[1] =
+			right_offset << 16 | bottom_offset;
+
+	subsc_params->fw_min_count = inst->buffers.output.min_count;
+
+	primaries = get_hfi_color_primaries(pixmp_op->colorspace);
+	matrix_coeff = get_hfi_matrix_coefficients(pixmp_op->ycbcr_enc);
+	transfer_char = get_hfi_transfer_char(pixmp_op->xfer_func);
+	full_range = pixmp_op->quantization == V4L2_QUANTIZATION_FULL_RANGE ? 1 : 0;
+	subsc_params->color_info =
+		(matrix_coeff & 0xFF) |
+		((transfer_char << 8) & 0xFF00) |
+		((primaries << 16) & 0xFF0000) |
+		((colour_description_present_flag << 24) & 0x1000000) |
+		((full_range << 25) & 0x2000000) |
+		((video_format << 26) & 0x1C000000) |
+		((video_signal_type_present_flag << 29) & 0x20000000);
+
+	subsc_params->profile = inst->cap[PROFILE].value;
+	subsc_params->level = inst->cap[LEVEL].value;
+	subsc_params->tier = inst->cap[HEVC_TIER].value;
+	subsc_params->pic_order_cnt = inst->cap[POC].value;
+	subsc_params->bit_depth = inst->cap[BIT_DEPTH].value;
+	if (inst->cap[CODED_FRAMES].value ==
+			CODED_FRAMES_PROGRESSIVE)
+		subsc_params->coded_frames = HFI_BITMASK_FRAME_MBS_ONLY_FLAG;
+	else
+		subsc_params->coded_frames = 0;
+
+	return 0;
+}
+
+static int vdec_read_input_subcr_params(struct iris_inst *inst)
+{
+	struct v4l2_pix_format_mplane *pixmp_ip, *pixmp_op;
+	u32 primaries, matrix_coeff, transfer_char;
+	struct subscription_params subsc_params;
+	u32 colour_description_present_flag = 0;
+	u32 video_signal_type_present_flag = 0;
+	u32 full_range = 0;
+	u32 width, height;
+
+	subsc_params = inst->src_subcr_params;
+	pixmp_ip = &inst->fmt_src->fmt.pix_mp;
+	pixmp_op = &inst->fmt_dst->fmt.pix_mp;
+	width = (subsc_params.bitstream_resolution &
+		HFI_BITMASK_BITSTREAM_WIDTH) >> 16;
+	height = subsc_params.bitstream_resolution &
+		HFI_BITMASK_BITSTREAM_HEIGHT;
+
+	pixmp_ip->width = width;
+	pixmp_ip->height = height;
+
+	pixmp_op->width = pixmp_op->pixelformat == V4L2_PIX_FMT_QC10C ?
+		ALIGN(width, 192) : ALIGN(width, 128);
+	pixmp_op->height = pixmp_op->pixelformat == V4L2_PIX_FMT_QC10C ?
+		ALIGN(height, 16) : ALIGN(height, 32);
+	pixmp_op->plane_fmt[0].bytesperline =
+		pixmp_op->pixelformat == V4L2_PIX_FMT_QC10C ?
+		ALIGN(ALIGN(width, 192) * 4 / 3, 256) :
+		ALIGN(width, 128);
+	pixmp_op->plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
+
+	matrix_coeff = subsc_params.color_info & 0xFF;
+	transfer_char = (subsc_params.color_info & 0xFF00) >> 8;
+	primaries = (subsc_params.color_info & 0xFF0000) >> 16;
+	colour_description_present_flag =
+		(subsc_params.color_info & 0x1000000) >> 24;
+	full_range = (subsc_params.color_info & 0x2000000) >> 25;
+	video_signal_type_present_flag =
+		(subsc_params.color_info & 0x20000000) >> 29;
+
+	pixmp_op->colorspace = V4L2_COLORSPACE_DEFAULT;
+	pixmp_op->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+	pixmp_op->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	pixmp_op->quantization = V4L2_QUANTIZATION_DEFAULT;
+
+	if (video_signal_type_present_flag) {
+		pixmp_op->quantization =
+			full_range ?
+			V4L2_QUANTIZATION_FULL_RANGE :
+			V4L2_QUANTIZATION_LIM_RANGE;
+		if (colour_description_present_flag) {
+			pixmp_op->colorspace =
+				get_v4l2_color_primaries(primaries);
+			pixmp_op->xfer_func =
+				get_v4l2_transfer_char(transfer_char);
+			pixmp_op->ycbcr_enc =
+				get_v4l2_matrix_coefficients(matrix_coeff);
+		}
+	}
+
+	pixmp_ip->colorspace = pixmp_op->colorspace;
+	pixmp_ip->xfer_func = pixmp_op->xfer_func;
+	pixmp_ip->ycbcr_enc = pixmp_op->ycbcr_enc;
+	pixmp_ip->quantization = pixmp_op->quantization;
+
+	inst->crop.top = subsc_params.crop_offsets[0] & 0xFFFF;
+	inst->crop.left = (subsc_params.crop_offsets[0] >> 16) & 0xFFFF;
+	inst->crop.height = pixmp_ip->height -
+		(subsc_params.crop_offsets[1] & 0xFFFF) - inst->crop.top;
+	inst->crop.width = pixmp_ip->width -
+		((subsc_params.crop_offsets[1] >> 16) & 0xFFFF) - inst->crop.left;
+
+	inst->cap[PROFILE].value = subsc_params.profile;
+	inst->cap[LEVEL].value = subsc_params.level;
+	inst->cap[HEVC_TIER].value = subsc_params.tier;
+	inst->cap[POC].value = subsc_params.pic_order_cnt;
+
+	if (subsc_params.bit_depth == BIT_DEPTH_8)
+		inst->cap[BIT_DEPTH].value = BIT_DEPTH_8;
+	else
+		inst->cap[BIT_DEPTH].value = BIT_DEPTH_10;
+
+	if (subsc_params.coded_frames & HFI_BITMASK_FRAME_MBS_ONLY_FLAG)
+		inst->cap[CODED_FRAMES].value = CODED_FRAMES_PROGRESSIVE;
+	else
+		inst->cap[CODED_FRAMES].value = CODED_FRAMES_INTERLACE;
+
+	inst->fw_min_count = subsc_params.fw_min_count;
+	inst->buffers.output.min_count = iris_get_buf_min_count(inst, BUF_OUTPUT);
+
+	return 0;
+}
+
+int vdec_src_change(struct iris_inst *inst)
+{
+	struct v4l2_event event = {0};
+	u32 ret;
+
+	if (!inst->vb2q_src->streaming)
+		return 0;
+
+	ret = vdec_read_input_subcr_params(inst);
+	if (ret)
+		return ret;
+
+	event.type = V4L2_EVENT_SOURCE_CHANGE;
+	event.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION;
+	v4l2_event_queue_fh(&inst->fh, &event);
+
+	return ret;
+}
+
 static int vdec_set_colorformat(struct iris_inst *inst)
 {
 	u32 hfi_colorformat;
@@ -483,3 +939,127 @@ int vdec_set_output_property(struct iris_inst *inst)
 
 	return vdec_set_ubwc_stride_scanline(inst);
 }
+
+int vdec_subscribe_dst_change_param(struct iris_inst *inst)
+{
+	u32 prop_type, payload_size, payload_type;
+	struct subscription_params subsc_params;
+	const u32 *dst_change_param = NULL;
+	u32 dst_change_param_size = 0;
+	struct iris_core *core;
+	u32 payload[32] = {0};
+	int ret;
+	u32 i;
+
+	core = inst->core;
+
+	payload[0] = HFI_MODE_PORT_SETTINGS_CHANGE;
+	if (inst->codec == H264) {
+		dst_change_param_size = core->platform_data->avc_subscribe_param_size;
+		dst_change_param = core->platform_data->avc_subscribe_param;
+	} else if (inst->codec == HEVC) {
+		dst_change_param_size = core->platform_data->hevc_subscribe_param_size;
+		dst_change_param = core->platform_data->hevc_subscribe_param;
+	} else if (inst->codec == VP9) {
+		dst_change_param_size = core->platform_data->vp9_subscribe_param_size;
+		dst_change_param = core->platform_data->vp9_subscribe_param;
+	} else {
+		dst_change_param = NULL;
+		return -EINVAL;
+	}
+
+	if (!dst_change_param || !dst_change_param_size)
+		return -EINVAL;
+
+	payload[0] = HFI_MODE_PORT_SETTINGS_CHANGE;
+	for (i = 0; i < dst_change_param_size; i++)
+		payload[i + 1] = dst_change_param[i];
+
+	ret = iris_hfi_session_subscribe_mode(inst,
+					      HFI_CMD_SUBSCRIBE_MODE,
+					      OUTPUT_MPLANE,
+					      HFI_PAYLOAD_U32_ARRAY,
+					      &payload[0],
+					      ((dst_change_param_size + 1) * sizeof(u32)));
+	if (ret)
+		return ret;
+
+	subsc_params = inst->dst_subcr_params;
+	for (i = 0; i < dst_change_param_size; i++) {
+		payload[0] = 0;
+		payload[1] = 0;
+		payload_size = 0;
+		payload_type = 0;
+		prop_type = dst_change_param[i];
+		switch (prop_type) {
+		case HFI_PROP_BITSTREAM_RESOLUTION:
+			payload[0] = subsc_params.bitstream_resolution;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_CROP_OFFSETS:
+			payload[0] = subsc_params.crop_offsets[0];
+			payload[1] = subsc_params.crop_offsets[1];
+			payload_size = sizeof(u64);
+			payload_type = HFI_PAYLOAD_64_PACKED;
+			break;
+		case HFI_PROP_LUMA_CHROMA_BIT_DEPTH:
+			payload[0] = subsc_params.bit_depth;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_CODED_FRAMES:
+			payload[0] = subsc_params.coded_frames;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT:
+			payload[0] = subsc_params.fw_min_count;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_PIC_ORDER_CNT_TYPE:
+			payload[0] = subsc_params.pic_order_cnt;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_SIGNAL_COLOR_INFO:
+			payload[0] = subsc_params.color_info;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_PROFILE:
+			payload[0] = subsc_params.profile;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_LEVEL:
+			payload[0] = subsc_params.level;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		case HFI_PROP_TIER:
+			payload[0] = subsc_params.tier;
+			payload_size = sizeof(u32);
+			payload_type = HFI_PAYLOAD_U32;
+			break;
+		default:
+			prop_type = 0;
+			ret = -EINVAL;
+			break;
+		}
+		if (prop_type) {
+			ret = iris_hfi_set_property(inst,
+						    prop_type,
+						    HFI_HOST_FLAGS_NONE,
+						    get_hfi_port(OUTPUT_MPLANE),
+						    payload_type,
+						    &payload,
+						    payload_size);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
index 6b0306c..e0db653 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
@@ -16,5 +16,9 @@ int vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int vdec_subscribe_event(struct iris_inst *inst, const struct v4l2_event_subscription *sub);
 int vdec_subscribe_property(struct iris_inst *inst, u32 plane);
 int vdec_set_output_property(struct iris_inst *inst);
+int vdec_init_src_change_param(struct iris_inst *inst);
+int vdec_src_change(struct iris_inst *inst);
+int vdec_subscribe_src_change_param(struct iris_inst *inst);
+int vdec_subscribe_dst_change_param(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index fc12bde..22a8f5b 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -206,6 +206,12 @@ struct platform_data {
 	u32 core_data_size;
 	struct plat_inst_cap *inst_cap_data;
 	u32 inst_cap_data_size;
+	const u32 *avc_subscribe_param;
+	unsigned int avc_subscribe_param_size;
+	const u32 *hevc_subscribe_param;
+	unsigned int hevc_subscribe_param_size;
+	const u32 *vp9_subscribe_param;
+	unsigned int vp9_subscribe_param_size;
 	const u32 *dec_input_prop;
 	unsigned int dec_input_prop_size;
 	const u32 *dec_output_prop_avc;
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index 6a4bfa3..7ae9715 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -382,6 +382,38 @@ static struct format_capability format_data_sm8550 = {
 	.color_format_info_size = ARRAY_SIZE(color_format_data_sm8550),
 };
 
+static const u32 sm8550_vdec_src_change_param_avc[] = {
+	HFI_PROP_BITSTREAM_RESOLUTION,
+	HFI_PROP_CROP_OFFSETS,
+	HFI_PROP_CODED_FRAMES,
+	HFI_PROP_LUMA_CHROMA_BIT_DEPTH,
+	HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT,
+	HFI_PROP_PIC_ORDER_CNT_TYPE,
+	HFI_PROP_PROFILE,
+	HFI_PROP_LEVEL,
+	HFI_PROP_SIGNAL_COLOR_INFO,
+};
+
+static const u32 sm8550_vdec_src_change_param_hevc[] = {
+	HFI_PROP_BITSTREAM_RESOLUTION,
+	HFI_PROP_CROP_OFFSETS,
+	HFI_PROP_LUMA_CHROMA_BIT_DEPTH,
+	HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT,
+	HFI_PROP_PROFILE,
+	HFI_PROP_LEVEL,
+	HFI_PROP_TIER,
+	HFI_PROP_SIGNAL_COLOR_INFO,
+};
+
+static const u32 sm8550_vdec_src_change_param_vp9[] = {
+	HFI_PROP_BITSTREAM_RESOLUTION,
+	HFI_PROP_CROP_OFFSETS,
+	HFI_PROP_LUMA_CHROMA_BIT_DEPTH,
+	HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT,
+	HFI_PROP_PROFILE,
+	HFI_PROP_LEVEL,
+};
+
 static const u32 sm8550_vdec_input_properties[] = {
 	HFI_PROP_NO_OUTPUT,
 };
@@ -430,6 +462,18 @@ struct platform_data sm8550_data = {
 	.ubwc_config = ubwc_config_sm8550,
 	.format_data = &format_data_sm8550,
 
+	.avc_subscribe_param =
+		sm8550_vdec_src_change_param_avc,
+	.avc_subscribe_param_size =
+		ARRAY_SIZE(sm8550_vdec_src_change_param_avc),
+	.hevc_subscribe_param =
+		sm8550_vdec_src_change_param_hevc,
+	.hevc_subscribe_param_size =
+		ARRAY_SIZE(sm8550_vdec_src_change_param_hevc),
+	.vp9_subscribe_param =
+		sm8550_vdec_src_change_param_vp9,
+	.vp9_subscribe_param_size =
+		ARRAY_SIZE(sm8550_vdec_src_change_param_vp9),
 	.dec_input_prop = sm8550_vdec_input_properties,
 	.dec_input_prop_size = ARRAY_SIZE(sm8550_vdec_input_properties),
 	.dec_output_prop_avc = sm8550_vdec_output_properties_avc,
-- 
2.7.4


