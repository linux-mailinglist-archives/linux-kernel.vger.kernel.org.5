Return-Path: <linux-kernel+bounces-3445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1896816C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449311F2394E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DE3219EF;
	Mon, 18 Dec 2023 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TpAnRsLP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44371B28C;
	Mon, 18 Dec 2023 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAs0cd008210;
	Mon, 18 Dec 2023 11:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=yjMHqh/n3Ch2ZrS6Ma1pzlwfHJQlBFURK7vxHKSwTCE=; b=Tp
	AnRsLPYnGNzagew7+f4F+ikwkLSvJbgC6YGH0LBwzl5IdRK3RgYy5c4GiPbuz+3B
	F0Won4jJaL0E5+QYnnYHrbG0x5nnHU3HAsswbHxtl87vhdM/cc0z+TuKv9B7hvrz
	iMrDOQVFVwYHKuknV2IiN9E+oI1X9fRz3cpYoUi9GJ7nCnuU0sKKHa8RTDivyub1
	DbJ5iK3K5Vh4UjSNHPleDw7zmaNq2SC6YDdihgiD9aZC27WMIEKsItmvntxkcMZQ
	SdM7lfB6cFYZyjMlxcjlCQCPWfJK4vanJoTgUXKJZuyJHUunhOsTondB24OKh9Rt
	/jb/0KN+FCboEAxMedtA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2m49g5h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7u7030031;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyh6-1;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7dN029984;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6a6029970;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 3A92F22D9; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 11/34] media: iris: introduce packetization layer for creating HFI packets
Date: Mon, 18 Dec 2023 17:02:06 +0530
Message-Id: <1702899149-21321-12-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4WoFG18BTgNUMyPf2ImxNsnxuVzUyCBA
X-Proofpoint-GUID: 4WoFG18BTgNUMyPf2ImxNsnxuVzUyCBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Host firmware interface (HFI) is well defined set of interfaces
for communication between host driver and firmware.
The command and responses are exchanged in form of packets.
One or multiple packets are grouped under packet header.
Each packet has packet type which describes the specific HFI
and payload which holds the corresponding value for that HFI.

Sys_init is the first packets sent to firmware, which initializes
the firmware. Sys_image_version packet is to get the firmware
version string.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   1 +
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  15 +++
 .../media/platform/qcom/vcodec/iris/iris_core.h    |  10 ++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  69 +++++++++++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    | 129 +++++++++++++++++++++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |  71 ++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |   5 +
 7 files changed, 300 insertions(+)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 74bd344..a2d5d74 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -6,6 +6,7 @@ iris-objs += iris_probe.o \
              iris_state.o \
              iris_helpers.o \
              iris_hfi.o \
+             iris_hfi_packet.o \
              resources.o
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
new file mode 100644
index 0000000..4c48c90
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _HFI_DEFINES_H_
+#define _HFI_DEFINES_H_
+
+#define HFI_VIDEO_ARCH_LX		0x1
+
+#define HFI_CMD_INIT			0x01000001
+
+#define HFI_PROP_IMAGE_VERSION		0x03000001
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 2740ff1..de0cfef 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -39,6 +39,11 @@
  * @sfr: SFR register memory
  * @lock: a lock for this strucure
  * @use_tz: a flag that suggests presence of trustzone
+ * @packet: pointer to packet from driver to fw
+ * @packet_size: size of packet
+ * @sys_init_id: id of sys init packet
+ * @header_id: id of packet header
+ * @packet_id: id of packet
  */
 
 struct iris_core {
@@ -65,6 +70,11 @@ struct iris_core {
 	struct mem_desc				sfr;
 	struct mutex				lock; /* lock for core structure */
 	unsigned int				use_tz;
+	u8					*packet;
+	u32					packet_size;
+	u32					sys_init_id;
+	u32					header_id;
+	u32					packet_id;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 4f51a8c..fe16448 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -4,8 +4,67 @@
  */
 
 #include "../firmware.h"
+#include "../hfi_queue.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
+#include "iris_hfi_packet.h"
+
+static int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt)
+{
+	struct iface_q_info *q_info;
+	struct hfi_header *header;
+	u32 packet_size, rx_req;
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	if (!core_in_valid_state(core))
+		return -EINVAL;
+
+	q_info = &core->command_queue;
+	if (!q_info || !q_info->q_array.kernel_vaddr || !pkt) {
+		dev_err(core->dev, "cannot write to shared CMD Q's\n");
+		return -ENODATA;
+	}
+
+	header = pkt;
+	packet_size = header->size;
+
+	if (!write_queue(q_info, pkt, packet_size, &rx_req)) {
+		dev_err(core->dev, "queue full\n");
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
+static int sys_init(struct iris_core *core)
+{
+	int ret;
+
+	ret = hfi_packet_sys_init(core, core->packet, core->packet_size);
+	if (ret)
+		return ret;
+
+	ret = iris_hfi_queue_cmd_write(core, core->packet);
+
+	return ret;
+}
+
+static int sys_image_version(struct iris_core *core)
+{
+	int ret;
+
+	ret = hfi_packet_image_version(core, core->packet, core->packet_size);
+	if (ret)
+		return ret;
+
+	ret = iris_hfi_queue_cmd_write(core, core->packet);
+
+	return ret;
+}
 
 #define CP_START           0
 #define CP_SIZE            0x25800000
@@ -46,6 +105,16 @@ int iris_hfi_core_init(struct iris_core *core)
 
 	ret = protect_secure_region(CP_START, CP_SIZE, CP_NONPIXEL_START,
 				    CP_NONPIXEL_SIZE, IRIS_PAS_ID);
+	if (ret)
+		goto error;
+
+	ret = sys_init(core);
+	if (ret)
+		goto error;
+
+	ret = sys_image_version(core);
+	if (ret)
+		goto error;
 
 	return ret;
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
new file mode 100644
index 0000000..73bba07
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_core.h"
+#include "iris_hfi_packet.h"
+#include "hfi_defines.h"
+
+static int hfi_create_header(u8 *packet, u32 packet_size, u32 session_id,
+			     u32 header_id)
+{
+	struct hfi_header *hdr = (struct hfi_header *)packet;
+
+	if (!packet || packet_size < sizeof(*hdr))
+		return -EINVAL;
+
+	memset(hdr, 0, sizeof(*hdr));
+
+	hdr->size = sizeof(*hdr);
+	hdr->session_id = session_id;
+	hdr->header_id = header_id;
+	hdr->num_packets = 0;
+
+	return 0;
+}
+
+static int hfi_create_packet(u8 *packet, u32 packet_size, u32 pkt_type,
+			     u32 pkt_flags, u32 payload_type, u32 port,
+			     u32 packet_id, void *payload, u32 payload_size)
+{
+	struct hfi_header *hdr;
+	struct hfi_packet *pkt;
+	u32 pkt_size;
+
+	if (!packet)
+		return -EINVAL;
+
+	hdr = (struct hfi_header *)packet;
+	if (hdr->size < sizeof(*hdr))
+		return -EINVAL;
+
+	pkt = (struct hfi_packet *)(packet + hdr->size);
+	pkt_size = sizeof(*pkt) + payload_size;
+	if (packet_size < hdr->size  + pkt_size)
+		return -EINVAL;
+
+	memset(pkt, 0, pkt_size);
+	pkt->size = pkt_size;
+	pkt->type = pkt_type;
+	pkt->flags = pkt_flags;
+	pkt->payload_info = payload_type;
+	pkt->port = port;
+	pkt->packet_id = packet_id;
+	if (payload_size)
+		memcpy((u8 *)pkt + sizeof(*pkt),
+		       payload, payload_size);
+
+	hdr->num_packets++;
+	hdr->size += pkt->size;
+
+	return 0;
+}
+
+int hfi_packet_sys_init(struct iris_core *core,
+			u8 *pkt, u32 pkt_size)
+{
+	u32 payload = 0;
+	int ret;
+
+	ret = hfi_create_header(pkt, pkt_size,
+				0,
+				core->header_id++);
+	if (ret)
+		goto error;
+
+	payload = HFI_VIDEO_ARCH_LX;
+	core->sys_init_id = core->packet_id++;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_CMD_INIT,
+				(HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+				HFI_HOST_FLAGS_INTR_REQUIRED |
+				HFI_HOST_FLAGS_NON_DISCARDABLE),
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->sys_init_id,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	dev_err(core->dev, "%s: create sys init packet failed\n", __func__);
+
+	return ret;
+}
+
+int hfi_packet_image_version(struct iris_core *core,
+			     u8 *pkt, u32 pkt_size)
+{
+	int ret;
+
+	ret = hfi_create_header(pkt, pkt_size,
+				0,
+				core->header_id++);
+	if (ret)
+		goto error;
+
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_IMAGE_VERSION,
+				(HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+				HFI_HOST_FLAGS_INTR_REQUIRED |
+				HFI_HOST_FLAGS_GET_PROPERTY),
+				HFI_PAYLOAD_NONE,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				NULL, 0);
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	dev_err(core->dev, "%s: create image version packet failed\n", __func__);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
new file mode 100644
index 0000000..e36612c
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_HFI_PACKET_H_
+#define _IRIS_HFI_PACKET_H_
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
+enum hfi_packet_host_flags {
+	HFI_HOST_FLAGS_NONE			= 0x00000000,
+	HFI_HOST_FLAGS_INTR_REQUIRED		= 0x00000001,
+	HFI_HOST_FLAGS_RESPONSE_REQUIRED	= 0x00000002,
+	HFI_HOST_FLAGS_NON_DISCARDABLE		= 0x00000004,
+	HFI_HOST_FLAGS_GET_PROPERTY		= 0x00000008,
+};
+
+enum hfi_packet_firmware_flags {
+	HFI_FW_FLAGS_NONE		= 0x00000000,
+	HFI_FW_FLAGS_SUCCESS		= 0x00000001,
+	HFI_FW_FLAGS_INFORMATION	= 0x00000002,
+	HFI_FW_FLAGS_SESSION_ERROR	= 0x00000004,
+	HFI_FW_FLAGS_SYSTEM_ERROR	= 0x00000008,
+};
+
+enum hfi_packet_payload_info {
+	HFI_PAYLOAD_NONE	= 0x00000000,
+	HFI_PAYLOAD_U32		= 0x00000001,
+	HFI_PAYLOAD_S32		= 0x00000002,
+	HFI_PAYLOAD_U64		= 0x00000003,
+	HFI_PAYLOAD_S64		= 0x00000004,
+	HFI_PAYLOAD_STRUCTURE	= 0x00000005,
+	HFI_PAYLOAD_BLOB	= 0x00000006,
+	HFI_PAYLOAD_STRING	= 0x00000007,
+	HFI_PAYLOAD_Q16		= 0x00000008,
+	HFI_PAYLOAD_U32_ENUM	= 0x00000009,
+	HFI_PAYLOAD_32_PACKED	= 0x0000000a,
+	HFI_PAYLOAD_U32_ARRAY	= 0x0000000b,
+	HFI_PAYLOAD_S32_ARRAY	= 0x0000000c,
+	HFI_PAYLOAD_64_PACKED	= 0x0000000d,
+};
+
+enum hfi_packet_port_type {
+	HFI_PORT_NONE		= 0x00000000,
+	HFI_PORT_BITSTREAM	= 0x00000001,
+	HFI_PORT_RAW		= 0x00000002,
+};
+
+int hfi_packet_sys_init(struct iris_core *core,
+			u8 *pkt, u32 pkt_size);
+int hfi_packet_image_version(struct iris_core *core,
+			     u8 *pkt, u32 pkt_size);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index f39b4aa..570c64e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -79,6 +79,11 @@ static int iris_probe(struct platform_device *pdev)
 	core->state = IRIS_CORE_DEINIT;
 	mutex_init(&core->lock);
 
+	core->packet_size = IFACEQ_CORE_PKT_SIZE;
+	core->packet = devm_kzalloc(core->dev, core->packet_size, GFP_KERNEL);
+	if (!core->packet)
+		return -ENOMEM;
+
 	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->reg_base))
 		return PTR_ERR(core->reg_base);
-- 
2.7.4


