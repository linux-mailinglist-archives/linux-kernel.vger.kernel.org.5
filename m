Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53264766E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjG1N2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjG1N2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:28:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FC49E8;
        Fri, 28 Jul 2023 06:27:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S9RPeF010756;
        Fri, 28 Jul 2023 13:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ud1QmpytpS8kljsAju5FtPOx6RIqUoSKID8szClshbU=;
 b=K2KNQ0HdCH57mNSUt8nA1UTNm9bxXJ7zTbrdZQo1XtzMCydB4eedBmh2pKrjRYaXYT3g
 pEYE4KZFPXXMdPkC0Pr/y6wLxlZA5/5D/pxkG7mYnOiizA6tlKzjrKupxs5Wz+3A2gat
 TSTtdi4f0O48rdH+roqLBwBP9yOcaCyYUh3cZheq0TV1hXraY/DZEWvxkYvwH0ZlS5na
 Y9BIlyzLxZt0RHy+QCR9LT1aJ7PcG1rgSpXNDGTWBttVgSctokHWXeFeUR3vZnn5gcKl
 kOrU++wwS/RdcQFo0CqfljiEItf8hUQxarEda/z1Skm6FeFYvzX3qHSPHX8nhpitf/w2 tA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3n2kbcp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:24 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQNb8003833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:23 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:26:19 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 21/33] iris: vidc: hfi: Add packetization layer
Date:   Fri, 28 Jul 2023 18:53:32 +0530
Message-ID: <1690550624-14642-22-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-GUID: sUjhxMZuyDqmKoNH8rbNBIUIn_Qv7RCu
X-Proofpoint-ORIG-GUID: sUjhxMZuyDqmKoNH8rbNBIUIn_Qv7RCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=908 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements hfi packets used to communicate the info
to/from firmware.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/hfi_command.h      | 190 ++++++
 .../media/platform/qcom/iris/vidc/inc/hfi_packet.h |  52 ++
 .../media/platform/qcom/iris/vidc/src/hfi_packet.c | 657 +++++++++++++++++++++
 3 files changed, 899 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_command.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/hfi_packet.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/hfi_packet.c

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/hfi_command.h b/drivers/media/platform/qcom/iris/vidc/inc/hfi_command.h
new file mode 100644
index 0000000..5542e56
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/hfi_command.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __H_HFI_COMMAND_H__
+#define __H_HFI_COMMAND_H__
+
+//todo: DP: remove below headers
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define HFI_VIDEO_ARCH_LX               0x1
+
+struct hfi_header {
+	u32 size;
+	u32 session_id;
+	u32 header_id;
+	u32 reserved[4];
+	u32 num_packets;
+};
+
+struct hfi_packet {
+	u32 size;
+	u32 type;
+	u32 flags;
+	u32 payload_info;
+	u32 port;
+	u32 packet_id;
+	u32 reserved[2];
+};
+
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
+enum hfi_packet_host_flags {
+	HFI_HOST_FLAGS_NONE                = 0x00000000,
+	HFI_HOST_FLAGS_INTR_REQUIRED       = 0x00000001,
+	HFI_HOST_FLAGS_RESPONSE_REQUIRED   = 0x00000002,
+	HFI_HOST_FLAGS_NON_DISCARDABLE     = 0x00000004,
+	HFI_HOST_FLAGS_GET_PROPERTY        = 0x00000008,
+};
+
+enum hfi_packet_firmware_flags {
+	HFI_FW_FLAGS_NONE          = 0x00000000,
+	HFI_FW_FLAGS_SUCCESS       = 0x00000001,
+	HFI_FW_FLAGS_INFORMATION   = 0x00000002,
+	HFI_FW_FLAGS_SESSION_ERROR = 0x00000004,
+	HFI_FW_FLAGS_SYSTEM_ERROR  = 0x00000008,
+};
+
+enum hfi_packet_payload_info {
+	HFI_PAYLOAD_NONE      = 0x00000000,
+	HFI_PAYLOAD_U32       = 0x00000001,
+	HFI_PAYLOAD_S32       = 0x00000002,
+	HFI_PAYLOAD_U64       = 0x00000003,
+	HFI_PAYLOAD_S64       = 0x00000004,
+	HFI_PAYLOAD_STRUCTURE = 0x00000005,
+	HFI_PAYLOAD_BLOB      = 0x00000006,
+	HFI_PAYLOAD_STRING    = 0x00000007,
+	HFI_PAYLOAD_Q16       = 0x00000008,
+	HFI_PAYLOAD_U32_ENUM  = 0x00000009,
+	HFI_PAYLOAD_32_PACKED = 0x0000000a,
+	HFI_PAYLOAD_U32_ARRAY = 0x0000000b,
+	HFI_PAYLOAD_S32_ARRAY = 0x0000000c,
+	HFI_PAYLOAD_64_PACKED = 0x0000000d,
+};
+
+enum hfi_packet_port_type {
+	HFI_PORT_NONE      = 0x00000000,
+	HFI_PORT_BITSTREAM = 0x00000001,
+	HFI_PORT_RAW       = 0x00000002,
+};
+
+enum hfi_buffer_type {
+	HFI_BUFFER_BITSTREAM      = 0x00000001,
+	HFI_BUFFER_RAW            = 0x00000002,
+	HFI_BUFFER_METADATA       = 0x00000003,
+	HFI_BUFFER_SUBCACHE       = 0x00000004,
+	HFI_BUFFER_PARTIAL_DATA   = 0x00000005,
+	HFI_BUFFER_DPB            = 0x00000006,
+	HFI_BUFFER_BIN            = 0x00000007,
+	HFI_BUFFER_LINE           = 0x00000008,
+	HFI_BUFFER_ARP            = 0x00000009,
+	HFI_BUFFER_COMV           = 0x0000000A,
+	HFI_BUFFER_NON_COMV       = 0x0000000B,
+	HFI_BUFFER_PERSIST        = 0x0000000C,
+	HFI_BUFFER_VPSS           = 0x0000000D,
+};
+
+enum hfi_buffer_host_flags {
+	HFI_BUF_HOST_FLAG_NONE               = 0x00000000,
+	HFI_BUF_HOST_FLAG_RELEASE            = 0x00000001,
+	HFI_BUF_HOST_FLAG_READONLY           = 0x00000010,
+	HFI_BUF_HOST_FLAG_CODEC_CONFIG       = 0x00000100,
+	HFI_BUF_HOST_FLAGS_CB_NON_SECURE       = 0x00000200,
+	HFI_BUF_HOST_FLAGS_CB_SECURE_PIXEL     = 0x00000400,
+	HFI_BUF_HOST_FLAGS_CB_SECURE_BITSTREAM = 0x00000800,
+	HFI_BUF_HOST_FLAGS_CB_SECURE_NON_PIXEL = 0x00001000,
+	HFI_BUF_HOST_FLAGS_CB_NON_SECURE_PIXEL = 0x00002000,
+};
+
+enum hfi_buffer_firmware_flags {
+	HFI_BUF_FW_FLAG_NONE            = 0x00000000,
+	HFI_BUF_FW_FLAG_RELEASE_DONE    = 0x00000001,
+	HFI_BUF_FW_FLAG_READONLY        = 0x00000010,
+	HFI_BUF_FW_FLAG_CODEC_CONFIG    = 0x00000100,
+	HFI_BUF_FW_FLAG_LAST            = 0x10000000,
+	HFI_BUF_FW_FLAG_PSC_LAST        = 0x20000000,
+};
+
+enum hfi_metapayload_header_flags {
+	HFI_METADATA_FLAGS_NONE         = 0x00000000,
+	HFI_METADATA_FLAGS_TOP_FIELD    = 0x00000001,
+	HFI_METADATA_FLAGS_BOTTOM_FIELD = 0x00000002,
+};
+
+struct metabuf_header {
+	u32 count;
+	u32 size;
+	u32 version;
+	u32 reserved[5];
+};
+
+struct metapayload_header {
+	u32 type;
+	u32 size;
+	u32 version;
+	u32 offset;
+	u32 flags;
+	u32 reserved[3];
+};
+
+enum hfi_property_mode_type {
+	HFI_MODE_NONE                 = 0x00000000,
+	HFI_MODE_PORT_SETTINGS_CHANGE = 0x00000001,
+	HFI_MODE_PROPERTY             = 0x00000002,
+	HFI_MODE_METADATA             = 0x00000004,
+	HFI_MODE_DYNAMIC_METADATA     = 0x00000005,
+};
+
+enum hfi_reserve_type {
+	HFI_RESERVE_START = 0x1,
+	HFI_RESERVE_STOP  = 0x2,
+};
+
+#define HFI_CMD_BEGIN                                           0x01000000
+#define HFI_CMD_INIT                                            0x01000001
+#define HFI_CMD_POWER_COLLAPSE                                  0x01000002
+#define HFI_CMD_OPEN                                            0x01000003
+#define HFI_CMD_CLOSE                                           0x01000004
+#define HFI_CMD_START                                           0x01000005
+#define HFI_CMD_STOP                                            0x01000006
+#define HFI_CMD_DRAIN                                           0x01000007
+#define HFI_CMD_RESUME                                          0x01000008
+#define HFI_CMD_BUFFER                                          0x01000009
+#define HFI_CMD_DELIVERY_MODE                                   0x0100000A
+#define HFI_CMD_SUBSCRIBE_MODE                                  0x0100000B
+#define HFI_CMD_SETTINGS_CHANGE                                 0x0100000C
+
+#define HFI_SSR_TYPE_SW_ERR_FATAL       0x1
+#define HFI_SSR_TYPE_SW_DIV_BY_ZERO     0x2
+#define HFI_SSR_TYPE_CPU_WDOG_IRQ       0x3
+#define HFI_SSR_TYPE_NOC_ERROR          0x4
+#define HFI_BITMASK_HW_CLIENT_ID                        0x000000f0
+#define HFI_BITMASK_SSR_TYPE                            0x0000000f
+#define HFI_CMD_SSR                                             0x0100000D
+
+#define HFI_STABILITY_TYPE_VCODEC_HUNG        0x1
+#define HFI_STABILITY_TYPE_ENC_BUFFER_FULL    0x2
+#define HFI_BITMASK_STABILITY_TYPE                      0x0000000f
+#define HFI_CMD_STABILITY                                       0x0100000E
+
+#define HFI_CMD_RESERVE                                         0x0100000F
+#define HFI_CMD_FLUSH                                           0x01000010
+#define HFI_CMD_PAUSE                                           0x01000011
+#define HFI_CMD_END                                             0x01FFFFFF
+
+#endif //__H_HFI_COMMAND_H__
diff --git a/drivers/media/platform/qcom/iris/vidc/inc/hfi_packet.h b/drivers/media/platform/qcom/iris/vidc/inc/hfi_packet.h
new file mode 100644
index 0000000..dc19c85
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/hfi_packet.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _HFI_PACKET_H_
+#define _HFI_PACKET_H_
+
+#include "hfi_command.h"
+#include "hfi_property.h"
+#include "msm_vidc_core.h"
+#include "msm_vidc_inst.h"
+#include "msm_vidc_internal.h"
+
+u32 get_hfi_port(struct msm_vidc_inst *inst,
+		 enum msm_vidc_port_type port);
+u32 get_hfi_port_from_buffer_type(struct msm_vidc_inst *inst,
+				  enum msm_vidc_buffer_type buffer_type);
+u32 hfi_buf_type_from_driver(enum msm_vidc_domain_type domain,
+			     enum msm_vidc_buffer_type buffer_type);
+u32 hfi_buf_type_to_driver(enum msm_vidc_domain_type domain,
+			   enum hfi_buffer_type buffer_type,
+			   enum hfi_packet_port_type port_type);
+u32 get_hfi_codec(struct msm_vidc_inst *inst);
+u32 get_hfi_colorformat(struct msm_vidc_inst *inst,
+			enum msm_vidc_colorformat_type colorformat);
+int get_hfi_buffer(struct msm_vidc_inst *inst,
+		   struct msm_vidc_buffer *buffer, struct hfi_buffer *buf);
+int hfi_create_header(u8 *packet, u32 packet_size,
+		      u32 session_id, u32 header_id);
+int hfi_create_packet(u8 *packet, u32 packet_size,
+		      u32 pkt_type, u32 pkt_flags, u32 payload_type, u32 port,
+		      u32 packet_id, void *payload, u32 payload_size);
+int hfi_create_buffer(u8 *packet, u32 packet_size, u32 *offset,
+		      enum msm_vidc_domain_type domain,
+		      struct msm_vidc_buffer *data);
+int hfi_packet_sys_init(struct msm_vidc_core *core,
+			u8 *pkt, u32 pkt_size);
+int hfi_packet_image_version(struct msm_vidc_core *core,
+			     u8 *pkt, u32 pkt_size);
+int hfi_packet_sys_pc_prep(struct msm_vidc_core *core,
+			   u8 *pkt, u32 pkt_size);
+int hfi_packet_sys_debug_config(struct msm_vidc_core *core, u8 *pkt,
+				u32 pkt_size, u32 debug_config);
+int hfi_packet_session_command(struct msm_vidc_inst *inst, u32 pkt_type,
+			       u32 flags, u32 port, u32 session_id,
+			       u32 payload_type, void *payload, u32 payload_size);
+int hfi_packet_sys_intraframe_powercollapse(struct msm_vidc_core *core, u8 *pkt,
+					    u32 pkt_size, u32 enable);
+
+#endif // _HFI_PACKET_H_
diff --git a/drivers/media/platform/qcom/iris/vidc/src/hfi_packet.c b/drivers/media/platform/qcom/iris/vidc/src/hfi_packet.c
new file mode 100644
index 0000000..2cf777c
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/src/hfi_packet.c
@@ -0,0 +1,657 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "hfi_packet.h"
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_driver.h"
+#include "msm_vidc_inst.h"
+#include "msm_vidc_platform.h"
+
+u32 get_hfi_port(struct msm_vidc_inst *inst,
+		 enum msm_vidc_port_type port)
+{
+	u32 hfi_port = HFI_PORT_NONE;
+
+	if (is_decode_session(inst)) {
+		switch (port) {
+		case INPUT_PORT:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		case OUTPUT_PORT:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		default:
+			i_vpr_e(inst, "%s: invalid port type %d\n",
+				__func__, port);
+			break;
+		}
+	} else if (is_encode_session(inst)) {
+		switch (port) {
+		case INPUT_PORT:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		case OUTPUT_PORT:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		default:
+			i_vpr_e(inst, "%s: invalid port type %d\n",
+				__func__, port);
+			break;
+		}
+	} else {
+		i_vpr_e(inst, "%s: invalid domain %#x\n",
+			__func__, inst->domain);
+	}
+
+	return hfi_port;
+}
+
+u32 get_hfi_port_from_buffer_type(struct msm_vidc_inst *inst,
+				  enum msm_vidc_buffer_type buffer_type)
+{
+	u32 hfi_port = HFI_PORT_NONE;
+
+	if (is_decode_session(inst)) {
+		switch (buffer_type) {
+		case MSM_VIDC_BUF_INPUT:
+		case MSM_VIDC_BUF_BIN:
+		case MSM_VIDC_BUF_COMV:
+		case MSM_VIDC_BUF_NON_COMV:
+		case MSM_VIDC_BUF_LINE:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		case MSM_VIDC_BUF_OUTPUT:
+		case MSM_VIDC_BUF_DPB:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		case MSM_VIDC_BUF_PERSIST:
+			hfi_port = HFI_PORT_NONE;
+			break;
+		default:
+			i_vpr_e(inst, "%s: invalid buffer type %d\n",
+				__func__, buffer_type);
+			break;
+		}
+	} else if (is_encode_session(inst)) {
+		switch (buffer_type) {
+		case MSM_VIDC_BUF_INPUT:
+		case MSM_VIDC_BUF_VPSS:
+			hfi_port = HFI_PORT_RAW;
+			break;
+		case MSM_VIDC_BUF_OUTPUT:
+		case MSM_VIDC_BUF_BIN:
+		case MSM_VIDC_BUF_COMV:
+		case MSM_VIDC_BUF_NON_COMV:
+		case MSM_VIDC_BUF_LINE:
+		case MSM_VIDC_BUF_DPB:
+			hfi_port = HFI_PORT_BITSTREAM;
+			break;
+		case MSM_VIDC_BUF_ARP:
+			hfi_port = HFI_PORT_NONE;
+			break;
+		default:
+			i_vpr_e(inst, "%s: invalid buffer type %d\n",
+				__func__, buffer_type);
+			break;
+		}
+	} else {
+		i_vpr_e(inst, "%s: invalid domain %#x\n",
+			__func__, inst->domain);
+	}
+
+	return hfi_port;
+}
+
+u32 hfi_buf_type_from_driver(enum msm_vidc_domain_type domain,
+			     enum msm_vidc_buffer_type buffer_type)
+{
+	switch (buffer_type) {
+	case MSM_VIDC_BUF_INPUT:
+		if (domain == MSM_VIDC_DECODER)
+			return HFI_BUFFER_BITSTREAM;
+		else
+			return HFI_BUFFER_RAW;
+	case MSM_VIDC_BUF_OUTPUT:
+		if (domain == MSM_VIDC_DECODER)
+			return HFI_BUFFER_RAW;
+		else
+			return HFI_BUFFER_BITSTREAM;
+	case MSM_VIDC_BUF_BIN:
+		return HFI_BUFFER_BIN;
+	case MSM_VIDC_BUF_ARP:
+		return HFI_BUFFER_ARP;
+	case MSM_VIDC_BUF_COMV:
+		return HFI_BUFFER_COMV;
+	case MSM_VIDC_BUF_NON_COMV:
+		return HFI_BUFFER_NON_COMV;
+	case MSM_VIDC_BUF_LINE:
+		return HFI_BUFFER_LINE;
+	case MSM_VIDC_BUF_DPB:
+		return HFI_BUFFER_DPB;
+	case MSM_VIDC_BUF_PERSIST:
+		return HFI_BUFFER_PERSIST;
+	case MSM_VIDC_BUF_VPSS:
+		return HFI_BUFFER_VPSS;
+	default:
+		d_vpr_e("invalid buffer type %d\n",
+			buffer_type);
+		return 0;
+	}
+}
+
+u32 hfi_buf_type_to_driver(enum msm_vidc_domain_type domain,
+			   enum hfi_buffer_type buffer_type,
+			   enum hfi_packet_port_type port_type)
+{
+	switch (buffer_type) {
+	case HFI_BUFFER_BITSTREAM:
+		if (domain == MSM_VIDC_DECODER)
+			return MSM_VIDC_BUF_INPUT;
+		else
+			return MSM_VIDC_BUF_OUTPUT;
+	case HFI_BUFFER_RAW:
+		if (domain == MSM_VIDC_DECODER)
+			return MSM_VIDC_BUF_OUTPUT;
+		else
+			return MSM_VIDC_BUF_INPUT;
+	case HFI_BUFFER_BIN:
+		return MSM_VIDC_BUF_BIN;
+	case HFI_BUFFER_ARP:
+		return MSM_VIDC_BUF_ARP;
+	case HFI_BUFFER_COMV:
+		return MSM_VIDC_BUF_COMV;
+	case HFI_BUFFER_NON_COMV:
+		return MSM_VIDC_BUF_NON_COMV;
+	case HFI_BUFFER_LINE:
+		return MSM_VIDC_BUF_LINE;
+	case HFI_BUFFER_DPB:
+		return MSM_VIDC_BUF_DPB;
+	case HFI_BUFFER_PERSIST:
+		return MSM_VIDC_BUF_PERSIST;
+	case HFI_BUFFER_VPSS:
+		return MSM_VIDC_BUF_VPSS;
+	default:
+		d_vpr_e("invalid buffer type %d\n",
+			buffer_type);
+		return 0;
+	}
+}
+
+u32 get_hfi_codec(struct msm_vidc_inst *inst)
+{
+	switch (inst->codec) {
+	case MSM_VIDC_H264:
+		if (is_encode_session(inst))
+			return HFI_CODEC_ENCODE_AVC;
+		else
+			return HFI_CODEC_DECODE_AVC;
+	case MSM_VIDC_HEVC:
+		if (is_encode_session(inst))
+			return HFI_CODEC_ENCODE_HEVC;
+		else
+			return HFI_CODEC_DECODE_HEVC;
+	case MSM_VIDC_VP9:
+		return HFI_CODEC_DECODE_VP9;
+	default:
+		i_vpr_e(inst, "invalid codec %d, domain %d\n",
+			inst->codec, inst->domain);
+		return 0;
+	}
+}
+
+u32 get_hfi_colorformat(struct msm_vidc_inst *inst,
+			enum msm_vidc_colorformat_type colorformat)
+{
+	u32 hfi_colorformat = HFI_COLOR_FMT_NV12_UBWC;
+
+	switch (colorformat) {
+	case MSM_VIDC_FMT_NV12:
+		hfi_colorformat = HFI_COLOR_FMT_NV12;
+		break;
+	case MSM_VIDC_FMT_NV12C:
+		hfi_colorformat = HFI_COLOR_FMT_NV12_UBWC;
+		break;
+	case MSM_VIDC_FMT_P010:
+		hfi_colorformat = HFI_COLOR_FMT_P010;
+		break;
+	case MSM_VIDC_FMT_TP10C:
+		hfi_colorformat = HFI_COLOR_FMT_TP10_UBWC;
+		break;
+	case MSM_VIDC_FMT_RGBA8888:
+		hfi_colorformat = HFI_COLOR_FMT_RGBA8888;
+		break;
+	case MSM_VIDC_FMT_RGBA8888C:
+		hfi_colorformat = HFI_COLOR_FMT_RGBA8888_UBWC;
+		break;
+	case MSM_VIDC_FMT_NV21:
+		hfi_colorformat = HFI_COLOR_FMT_NV21;
+		break;
+	default:
+		i_vpr_e(inst, "%s: invalid colorformat %d\n",
+			__func__, colorformat);
+		break;
+	}
+
+	return hfi_colorformat;
+}
+
+static u32 get_hfi_region_flag(enum msm_vidc_buffer_region region)
+{
+	switch (region) {
+	case MSM_VIDC_NON_SECURE:
+		return HFI_BUF_HOST_FLAGS_CB_NON_SECURE;
+	case MSM_VIDC_NON_SECURE_PIXEL:
+		return HFI_BUF_HOST_FLAGS_CB_NON_SECURE_PIXEL;
+	case MSM_VIDC_SECURE_PIXEL:
+		return HFI_BUF_HOST_FLAGS_CB_SECURE_PIXEL;
+	case MSM_VIDC_SECURE_NONPIXEL:
+		return HFI_BUF_HOST_FLAGS_CB_SECURE_NON_PIXEL;
+	case MSM_VIDC_SECURE_BITSTREAM:
+		return HFI_BUF_HOST_FLAGS_CB_SECURE_BITSTREAM;
+	case MSM_VIDC_REGION_MAX:
+	case MSM_VIDC_REGION_NONE:
+	default:
+		return HFI_BUF_HOST_FLAG_NONE;
+	}
+}
+
+int get_hfi_buffer(struct msm_vidc_inst *inst,
+		   struct msm_vidc_buffer *buffer, struct hfi_buffer *buf)
+{
+	memset(buf, 0, sizeof(struct hfi_buffer));
+	buf->type = hfi_buf_type_from_driver(inst->domain, buffer->type);
+	buf->index = buffer->index;
+	buf->base_address = buffer->device_addr;
+	buf->addr_offset = 0;
+	buf->buffer_size = buffer->buffer_size;
+	/*
+	 * for decoder input buffers, firmware (BSE HW) needs 256 aligned
+	 * buffer size otherwise it will truncate or ignore the data after 256
+	 * aligned size which may lead to error concealment
+	 */
+	if (is_decode_session(inst) && is_input_buffer(buffer->type))
+		buf->buffer_size = ALIGN(buffer->buffer_size, 256);
+	buf->data_offset = buffer->data_offset;
+	buf->data_size = buffer->data_size;
+	if (buffer->attr & MSM_VIDC_ATTR_READ_ONLY)
+		buf->flags |= HFI_BUF_HOST_FLAG_READONLY;
+	if (buffer->attr & MSM_VIDC_ATTR_PENDING_RELEASE)
+		buf->flags |= HFI_BUF_HOST_FLAG_RELEASE;
+	buf->flags |= get_hfi_region_flag(buffer->region);
+	buf->timestamp = buffer->timestamp;
+
+	return 0;
+}
+
+int hfi_create_header(u8 *packet, u32 packet_size, u32 session_id,
+		      u32 header_id)
+{
+	struct hfi_header *hdr = (struct hfi_header *)packet;
+
+	if (!packet || packet_size < sizeof(struct hfi_header)) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	memset(hdr, 0, sizeof(struct hfi_header));
+
+	hdr->size = sizeof(struct hfi_header);
+	hdr->session_id = session_id;
+	hdr->header_id = header_id;
+	hdr->num_packets = 0;
+	return 0;
+}
+
+int hfi_create_packet(u8 *packet, u32 packet_size, u32 pkt_type,
+		      u32 pkt_flags, u32 payload_type, u32 port,
+		      u32 packet_id, void *payload, u32 payload_size)
+{
+	struct hfi_header *hdr;
+	struct hfi_packet *pkt;
+	u32 pkt_size;
+
+	if (!packet) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		return -EINVAL;
+	}
+	hdr = (struct hfi_header *)packet;
+	if (hdr->size < sizeof(struct hfi_header)) {
+		d_vpr_e("%s: invalid hdr size %d\n", __func__, hdr->size);
+		return -EINVAL;
+	}
+	pkt = (struct hfi_packet *)(packet + hdr->size);
+	pkt_size = sizeof(struct hfi_packet) + payload_size;
+	if (packet_size < hdr->size  + pkt_size) {
+		d_vpr_e("%s: invalid packet_size %d, %d %d\n",
+			__func__, packet_size, hdr->size, pkt_size);
+		return -EINVAL;
+	}
+	memset(pkt, 0, pkt_size);
+	pkt->size = pkt_size;
+	pkt->type = pkt_type;
+	pkt->flags = pkt_flags;
+	pkt->payload_info = payload_type;
+	pkt->port = port;
+	pkt->packet_id = packet_id;
+	if (payload_size)
+		memcpy((u8 *)pkt + sizeof(struct hfi_packet),
+		       payload, payload_size);
+
+	hdr->num_packets++;
+	hdr->size += pkt->size;
+	return 0;
+}
+
+int hfi_packet_sys_init(struct msm_vidc_core *core,
+			u8 *pkt, u32 pkt_size)
+{
+	int rc = 0;
+	u32 payload = 0;
+
+	rc = hfi_create_header(pkt, pkt_size,
+			       0 /*session_id*/,
+			       core->header_id++);
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_CMD_SYSTEM_INIT */
+	payload = HFI_VIDEO_ARCH_LX;
+	d_vpr_h("%s: arch %d\n", __func__, payload);
+	core->sys_init_id = core->packet_id++;
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_CMD_INIT,
+			       (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+			       HFI_HOST_FLAGS_INTR_REQUIRED |
+			       HFI_HOST_FLAGS_NON_DISCARDABLE),
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->sys_init_id,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_PROP_UBWC_MAX_CHANNELS */
+	payload = core->platform->data.ubwc_config->max_channels;
+	d_vpr_h("%s: ubwc max channels %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_UBWC_MAX_CHANNELS,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_PROP_UBWC_MAL_LENGTH */
+	payload = core->platform->data.ubwc_config->mal_length;
+	d_vpr_h("%s: ubwc mal length %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_UBWC_MAL_LENGTH,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_PROP_UBWC_HBB */
+	payload = core->platform->data.ubwc_config->highest_bank_bit;
+	d_vpr_h("%s: ubwc hbb %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_UBWC_HBB,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_PROP_UBWC_BANK_SWZL_LEVEL1 */
+	payload = core->platform->data.ubwc_config->bank_swzl_level;
+	d_vpr_h("%s: ubwc swzl1 %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_UBWC_BANK_SWZL_LEVEL1,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_PROP_UBWC_BANK_SWZL_LEVEL2 */
+	payload = core->platform->data.ubwc_config->bank_swz2_level;
+	d_vpr_h("%s: ubwc swzl2 %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_UBWC_BANK_SWZL_LEVEL2,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_PROP_UBWC_BANK_SWZL_LEVEL3 */
+	payload = core->platform->data.ubwc_config->bank_swz3_level;
+	d_vpr_h("%s: ubwc swzl3 %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_UBWC_BANK_SWZL_LEVEL3,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	/* HFI_PROP_UBWC_BANK_SPREADING */
+	payload = core->platform->data.ubwc_config->bank_spreading;
+	d_vpr_h("%s: ubwc bank spreading %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_UBWC_BANK_SPREADING,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_sys_init;
+
+	d_vpr_h("System init packet created\n");
+	return rc;
+
+err_sys_init:
+	d_vpr_e("%s: create packet failed\n", __func__);
+	return rc;
+}
+
+int hfi_packet_image_version(struct msm_vidc_core *core,
+			     u8 *pkt, u32 pkt_size)
+{
+	int rc = 0;
+
+	rc = hfi_create_header(pkt, pkt_size,
+			       0 /*session_id*/,
+			       core->header_id++);
+	if (rc)
+		goto err_img_version;
+
+	/* HFI_PROP_IMAGE_VERSION */
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_IMAGE_VERSION,
+			       (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+			       HFI_HOST_FLAGS_INTR_REQUIRED |
+			       HFI_HOST_FLAGS_GET_PROPERTY),
+			       HFI_PAYLOAD_NONE,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       NULL, 0);
+	if (rc)
+		goto err_img_version;
+
+	d_vpr_h("Image version packet created\n");
+	return rc;
+
+err_img_version:
+	d_vpr_e("%s: create packet failed\n", __func__);
+	return rc;
+}
+
+int hfi_packet_sys_pc_prep(struct msm_vidc_core *core,
+			   u8 *pkt, u32 pkt_size)
+{
+	int rc = 0;
+
+	rc = hfi_create_header(pkt, pkt_size,
+			       0 /*session_id*/,
+			       core->header_id++);
+	if (rc)
+		goto err_sys_pc;
+
+	/* HFI_CMD_POWER_COLLAPSE */
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_CMD_POWER_COLLAPSE,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_NONE,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       NULL, 0);
+	if (rc)
+		goto err_sys_pc;
+
+	d_vpr_h("Power collapse packet created\n");
+	return rc;
+
+err_sys_pc:
+	d_vpr_e("%s: create packet failed\n", __func__);
+	return rc;
+}
+
+int hfi_packet_sys_debug_config(struct msm_vidc_core *core,
+				u8 *pkt, u32 pkt_size, u32 debug_config)
+{
+	int rc = 0;
+	u32 payload = 0;
+
+	rc = hfi_create_header(pkt, pkt_size,
+			       0 /*session_id*/,
+			       core->header_id++);
+	if (rc)
+		goto err_debug;
+
+	/* HFI_PROP_DEBUG_CONFIG */
+	payload = 0; /*TODO:Change later*/
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_DEBUG_CONFIG,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32_ENUM,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_debug;
+
+	/* HFI_PROP_DEBUG_LOG_LEVEL */
+	payload = debug_config; /*TODO:Change later*/
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_DEBUG_LOG_LEVEL,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32_ENUM,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err_debug;
+
+err_debug:
+	if (rc)
+		d_vpr_e("%s: create packet failed\n", __func__);
+
+	return rc;
+}
+
+int hfi_packet_session_command(struct msm_vidc_inst *inst, u32 pkt_type,
+			       u32 flags, u32 port, u32 session_id,
+			       u32 payload_type, void *payload, u32 payload_size)
+{
+	int rc = 0;
+	struct msm_vidc_core *core;
+
+	core = inst->core;
+
+	rc = hfi_create_header(inst->packet, inst->packet_size,
+			       session_id, core->header_id++);
+	if (rc)
+		goto err_cmd;
+
+	rc = hfi_create_packet(inst->packet,
+			       inst->packet_size,
+			       pkt_type,
+			       flags,
+			       payload_type,
+			       port,
+			       core->packet_id++,
+			       payload,
+			       payload_size);
+	if (rc)
+		goto err_cmd;
+
+	i_vpr_h(inst, "Command packet 0x%x created\n", pkt_type);
+	return rc;
+
+err_cmd:
+	i_vpr_e(inst, "%s: create packet failed\n", __func__);
+	return rc;
+}
+
+int hfi_packet_sys_intraframe_powercollapse(struct msm_vidc_core *core,
+					    u8 *pkt, u32 pkt_size, u32 enable)
+{
+	int rc = 0;
+	u32 payload = 0;
+
+	rc = hfi_create_header(pkt, pkt_size,
+			       0 /*session_id*/,
+			       core->header_id++);
+	if (rc)
+		goto err;
+
+	/* HFI_PROP_INTRA_FRAME_POWER_COLLAPSE */
+	payload = enable;
+	d_vpr_h("%s: intra frame power collapse %d\n", __func__, payload);
+	rc = hfi_create_packet(pkt, pkt_size,
+			       HFI_PROP_INTRA_FRAME_POWER_COLLAPSE,
+			       HFI_HOST_FLAGS_NONE,
+			       HFI_PAYLOAD_U32,
+			       HFI_PORT_NONE,
+			       core->packet_id++,
+			       &payload,
+			       sizeof(u32));
+	if (rc)
+		goto err;
+
+	d_vpr_h("IFPC packet created\n");
+	return rc;
+
+err:
+	d_vpr_e("%s: create packet failed\n", __func__);
+	return rc;
+}
-- 
2.7.4

