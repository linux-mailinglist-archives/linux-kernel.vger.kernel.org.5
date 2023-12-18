Return-Path: <linux-kernel+bounces-3446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F67816C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED57D2819AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C7225D2;
	Mon, 18 Dec 2023 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="niS5GENc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937971B29D;
	Mon, 18 Dec 2023 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAs3ZU027066;
	Mon, 18 Dec 2023 11:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=UBiV64Si8CIj4lSYpZDjtUg79mUR31H12KPH3CgY11w=; b=ni
	S5GENcpsmHocQwELi0F+Sn/c7Eo+LGqL/neAoBMknJ8xkMrJbViW5/asF7xn8lHR
	91F1HIhjKkkBR842ILEBvkYViaXC+kff6Om+x//YEg4OO7qvMxiBOsprM+Ctgkal
	oCHT1lzSgcdM9tmKSCQ9Wyu+54EpryjaRlGcZ6kcedy368SMt+sJXu2lyi9ByktL
	uCowc+EBZVcm1ZYX9uDHfCw+TVLjN4viyO1vha6cW7X3dmh1TYSQ6qyo+927dSfM
	5ziCc7wX07hcXd6pHQ7ZPMvOmZ8UZhaGwqZ+RKTp4Z7xuEBcXdv9N65ocHia7ILP
	WbCFhQxq0Tm16UCkMURQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mjfr3a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7FE030042;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyha-1;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX72n029995;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6IG029972;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 3F9562304; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 13/34] media: iris: introduce platform specific capabilities for core and instance
Date: Mon, 18 Dec 2023 17:02:08 +0530
Message-Id: <1702899149-21321-14-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OMgNGxZktJeK8alVapkhuj-SvUeSu5mx
X-Proofpoint-ORIG-GUID: OMgNGxZktJeK8alVapkhuj-SvUeSu5mx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Capabilities are set of video specifications and features supported
by a specific platform(SOC). Each capability is defined with
min, max, range, default value and corresponding HFI.

Also, platform data defines different resource details for
a specific platform(SOC). This change defines resource tables
for sm8550 platform data and use for initializing these resources.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   4 +-
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  42 ++-
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   5 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  19 ++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   1 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  20 +-
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  84 ++++++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |  27 +-
 .../platform/qcom/vcodec/iris/platform_common.c    |  29 ++
 .../platform/qcom/vcodec/iris/platform_common.h    | 194 +++++++++++++
 .../platform/qcom/vcodec/iris/platform_sm8550.c    | 316 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/resources.c    |  74 +++--
 12 files changed, 759 insertions(+), 56 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_common.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_common.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 90241b5..c50e3241 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -9,6 +9,8 @@ iris-objs += iris_probe.o \
              iris_hfi_packet.o \
              resources.o \
              vpu_common.o \
-             vpu_iris3.o
+             vpu_iris3.o \
+             platform_common.o \
+             platform_sm8550.o
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index 4c48c90..fb383b2 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -6,10 +6,46 @@
 #ifndef _HFI_DEFINES_H_
 #define _HFI_DEFINES_H_
 
-#define HFI_VIDEO_ARCH_LX		0x1
+#define HFI_VIDEO_ARCH_LX			0x1
 
-#define HFI_CMD_INIT			0x01000001
+#define HFI_CMD_INIT				0x01000001
 
-#define HFI_PROP_IMAGE_VERSION		0x03000001
+#define HFI_PROP_IMAGE_VERSION			0x03000001
+
+#define HFI_PROP_UBWC_MAX_CHANNELS		0x03000003
+#define HFI_PROP_UBWC_MAL_LENGTH		0x03000004
+#define HFI_PROP_UBWC_HBB			0x03000005
+#define HFI_PROP_UBWC_BANK_SWZL_LEVEL1		0x03000006
+#define HFI_PROP_UBWC_BANK_SWZL_LEVEL2		0x03000007
+#define HFI_PROP_UBWC_BANK_SWZL_LEVEL3		0x03000008
+#define HFI_PROP_UBWC_BANK_SPREADING		0x03000009
+
+#define HFI_PROP_PROFILE			0x03000107
+
+#define HFI_PROP_LEVEL				0x03000108
+
+#define HFI_PROP_TIER				0x03000109
+
+#define HFI_PROP_STAGE				0x0300010a
+
+#define HFI_PROP_PIPE				0x0300010b
+
+#define HFI_PROP_FRAME_RATE			0x0300010c
+
+#define HFI_PROP_LUMA_CHROMA_BIT_DEPTH		0x0300010f
+
+#define HFI_PROP_CODED_FRAMES			0x03000120
+
+#define HFI_PROP_CABAC_SESSION			0x03000121
+
+#define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
+
+#define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
+
+#define HFI_PROP_DECODE_ORDER_OUTPUT		0x0300015b
+
+#define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
+
+#define HFI_PROP_DEC_START_FROM_RAP_FRAME	0x03000169
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 64678fd..3c8497a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -11,6 +11,7 @@
 
 #include "../hfi_queue.h"
 #include "iris_state.h"
+#include "platform_common.h"
 #include "resources.h"
 #include "vpu_common.h"
 
@@ -46,6 +47,8 @@
  * @header_id: id of packet header
  * @packet_id: id of packet
  * @vpu_ops: a pointer to vpu ops
+ * @platform_data: a structure for platform data
+ * @cap: an array for supported core capabilities
  */
 
 struct iris_core {
@@ -78,6 +81,8 @@ struct iris_core {
 	u32					header_id;
 	u32					packet_id;
 	const struct vpu_ops			*vpu_ops;
+	struct platform_data			*platform_data;
+	struct plat_core_cap			cap[CORE_CAP_MAX + 1];
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 22c706a..c31dfd5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -13,3 +13,22 @@ int check_core_lock(struct iris_core *core)
 
 	return fatal ? -EINVAL : 0;
 }
+
+int iris_init_core_caps(struct iris_core *core)
+{
+	struct plat_core_cap *core_platform_data;
+	int i, num_core_caps;
+
+	core_platform_data = core->platform_data->core_data;
+	if (!core_platform_data)
+		return -EINVAL;
+
+	num_core_caps = core->platform_data->core_data_size;
+
+	for (i = 0; i < num_core_caps && i < CORE_CAP_MAX; i++) {
+		core->cap[core_platform_data[i].type].type = core_platform_data[i].type;
+		core->cap[core_platform_data[i].type].value = core_platform_data[i].value;
+	}
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 314a8d75..4c7ddbf 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -9,5 +9,6 @@
 #include "iris_core.h"
 
 int check_core_lock(struct iris_core *core);
+int iris_init_core_caps(struct iris_core *core);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 7b3cbbc..b0390b542 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -79,8 +79,12 @@ static int sys_image_version(struct iris_core *core)
 
 int iris_hfi_core_init(struct iris_core *core)
 {
+	u32 cp_nonpixel_start, cp_nonpixel_size;
 	phys_addr_t mem_phys = 0;
+	u32 cp_start, cp_size;
+	const char *fw_name;
 	size_t mem_size = 0;
+	u32 pas_id;
 	int ret;
 
 	ret = check_core_lock(core);
@@ -97,17 +101,23 @@ int iris_hfi_core_init(struct iris_core *core)
 	if (!core->use_tz)
 		goto error;
 
-	ret = load_fw(core->dev, FW_NAME, &mem_phys, &mem_size,
-		      IRIS_PAS_ID, core->use_tz);
+	pas_id = core->platform_data->pas_id;
+	fw_name = core->platform_data->fwname;
+	ret = load_fw(core->dev, fw_name, &mem_phys, &mem_size,
+		      pas_id, core->use_tz);
 	if (ret)
 		goto error;
 
-	ret = auth_reset_fw(IRIS_PAS_ID);
+	ret = auth_reset_fw(pas_id);
 	if (ret)
 		goto error;
 
-	ret = protect_secure_region(CP_START, CP_SIZE, CP_NONPIXEL_START,
-				    CP_NONPIXEL_SIZE, IRIS_PAS_ID);
+	cp_start = core->cap[CP_START].value;
+	cp_size = core->cap[CP_SIZE].value;
+	cp_nonpixel_start = core->cap[CP_NONPIXEL_START].value;
+	cp_nonpixel_size = core->cap[CP_NONPIXEL_SIZE].value;
+	ret = protect_secure_region(cp_start, cp_size, cp_nonpixel_start,
+				    cp_nonpixel_size, pas_id);
 	if (ret)
 		goto error;
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index 73bba07..f31dd84 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -89,6 +89,90 @@ int hfi_packet_sys_init(struct iris_core *core,
 	if (ret)
 		goto error;
 
+	payload = core->platform_data->ubwc_config->max_channels;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_UBWC_MAX_CHANNELS,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
+	payload = core->platform_data->ubwc_config->mal_length;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_UBWC_MAL_LENGTH,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
+	payload = core->platform_data->ubwc_config->highest_bank_bit;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_UBWC_HBB,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
+	payload = core->platform_data->ubwc_config->bank_swzl_level;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_UBWC_BANK_SWZL_LEVEL1,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
+	payload = core->platform_data->ubwc_config->bank_swz2_level;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_UBWC_BANK_SWZL_LEVEL2,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
+	payload = core->platform_data->ubwc_config->bank_swz3_level;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_UBWC_BANK_SWZL_LEVEL3,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
+	payload = core->platform_data->ubwc_config->bank_spreading;
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_UBWC_BANK_SPREADING,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+	if (ret)
+		goto error;
+
 	return ret;
 
 error:
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 773481f..9d6a6c5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -9,6 +9,7 @@
 
 #include "../hfi_queue.h"
 #include "iris_core.h"
+#include "iris_helpers.h"
 #include "resources.h"
 
 static int iris_register_video_device(struct iris_core *core)
@@ -92,6 +93,13 @@ static int iris_probe(struct platform_device *pdev)
 	if (core->irq < 0)
 		return core->irq;
 
+	ret = init_platform(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: init platform failed with %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = init_vpu(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
@@ -106,6 +114,13 @@ static int iris_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = iris_init_core_caps(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: init core caps failed with %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
 		return ret;
@@ -116,12 +131,7 @@ static int iris_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, core);
 
-	/*
-	 * Specify the max value of address space, which can be used
-	 * for buffer transactions.
-	 */
-	dma_mask = DMA_BIT_MASK(32);
-	dma_mask &= ~BIT(29);
+	dma_mask = core->cap[DMA_MASK].value;
 
 	ret = dma_set_mask_and_coherent(dev, dma_mask);
 	if (ret)
@@ -160,7 +170,10 @@ static int iris_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id iris_dt_match[] = {
-	{ .compatible = "qcom,sm8550-iris", },
+	{
+		.compatible = "qcom,sm8550-iris",
+		.data = &sm8550_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, iris_dt_match);
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.c b/drivers/media/platform/qcom/vcodec/iris/platform_common.c
new file mode 100644
index 0000000..043adc8
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "iris_core.h"
+#include "platform_common.h"
+
+int init_platform(struct iris_core *core)
+{
+	struct platform_data *platform = NULL;
+
+	platform = devm_kzalloc(core->dev, sizeof(*platform),
+				GFP_KERNEL);
+	if (!platform)
+		return -ENOMEM;
+
+	core->platform_data = platform;
+
+	core->platform_data = (struct platform_data *)of_device_get_match_data(core->dev);
+	if (!core->platform_data)
+		return -ENODEV;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
new file mode 100644
index 0000000..e478b02
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _PLATFORM_COMMON_H_
+#define _PLATFORM_COMMON_H_
+
+#include <linux/bits.h>
+
+struct iris_core;
+
+#define HW_RESPONSE_TIMEOUT_VALUE     (1000)
+
+#define BIT_DEPTH_8 (8 << 16 | 8)
+#define BIT_DEPTH_10 (10 << 16 | 10)
+
+#define CODED_FRAMES_PROGRESSIVE 0x0
+#define CODED_FRAMES_INTERLACE 0x1
+
+#define DEFAULT_MAX_HOST_BUF_COUNT			64
+#define DEFAULT_MAX_HOST_BURST_BUF_COUNT		256
+
+#define UBWC_CONFIG(mc, ml, hbb, bs1, bs2, bs3, bsp) \
+{	                                                 \
+	.max_channels = mc,                              \
+	.mal_length = ml,                                \
+	.highest_bank_bit = hbb,                         \
+	.bank_swzl_level = bs1,                          \
+	.bank_swz2_level = bs2,                          \
+	.bank_swz3_level = bs3,                          \
+	.bank_spreading = bsp,                           \
+}
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
+enum stage_type {
+	STAGE_NONE = 0,
+	STAGE_1 = 1,
+	STAGE_2 = 2,
+};
+
+enum pipe_type {
+	PIPE_NONE = 0,
+	PIPE_1 = 1,
+	PIPE_2 = 2,
+	PIPE_4 = 4,
+};
+
+extern struct platform_data sm8550_data;
+
+struct bw_info {
+	u32 mbs_per_sec;
+	u32 bw_ddr;
+	u32 bw_ddr_10bit;
+};
+
+struct reg_preset_info {
+	u32              reg;
+	u32              value;
+	u32              mask;
+};
+
+struct ubwc_config_data {
+	u32	max_channels;
+	u32	mal_length;
+	u32	highest_bank_bit;
+	u32	bank_swzl_level;
+	u32	bank_swz2_level;
+	u32	bank_swz3_level;
+	u32	bank_spreading;
+};
+
+enum plat_core_cap_type {
+	CORE_CAP_NONE = 0,
+	DEC_CODECS,
+	MAX_SESSION_COUNT,
+	MAX_MBPF,
+	MAX_MBPS,
+	MAX_MBPF_HQ,
+	MAX_MBPS_HQ,
+	MAX_MBPF_B_FRAME,
+	MAX_MBPS_B_FRAME,
+	MAX_ENH_LAYER_COUNT,
+	NUM_VPP_PIPE,
+	FW_UNLOAD,
+	FW_UNLOAD_DELAY,
+	HW_RESPONSE_TIMEOUT,
+	NON_FATAL_FAULTS,
+	DMA_MASK,
+	CP_START,
+	CP_SIZE,
+	CP_NONPIXEL_START,
+	CP_NONPIXEL_SIZE,
+	CORE_CAP_MAX,
+};
+
+struct plat_core_cap {
+	enum plat_core_cap_type type;
+	u32 value;
+};
+
+enum plat_inst_cap_type {
+	INST_CAP_NONE = 0,
+	FRAME_WIDTH,
+	FRAME_HEIGHT,
+	PIX_FMTS,
+	MBPF,
+	QUEUED_RATE,
+	MB_CYCLES_VSP,
+	MB_CYCLES_VPP,
+	MB_CYCLES_LP,
+	MB_CYCLES_FW,
+	MB_CYCLES_FW_VPP,
+	NUM_COMV,
+	PROFILE,
+	LEVEL,
+	HEVC_TIER,
+	DISPLAY_DELAY_ENABLE,
+	DISPLAY_DELAY,
+	OUTPUT_ORDER,
+	INPUT_BUF_HOST_MAX_COUNT,
+	STAGE,
+	PIPE,
+	POC,
+	CODED_FRAMES,
+	BIT_DEPTH,
+	DEFAULT_HEADER,
+	RAP_FRAME,
+	INST_CAP_MAX,
+};
+
+enum plat_inst_cap_flags {
+	CAP_FLAG_NONE			= 0,
+	CAP_FLAG_DYNAMIC_ALLOWED	= BIT(0),
+	CAP_FLAG_MENU			= BIT(1),
+	CAP_FLAG_INPUT_PORT		= BIT(2),
+	CAP_FLAG_OUTPUT_PORT		= BIT(3),
+	CAP_FLAG_CLIENT_SET		= BIT(4),
+	CAP_FLAG_BITMASK		= BIT(5),
+	CAP_FLAG_VOLATILE		= BIT(6),
+};
+
+struct plat_inst_cap {
+	enum plat_inst_cap_type cap_id;
+	enum codec_type codec;
+	s32 min;
+	s32 max;
+	u32 step_or_mask;
+	s32 value;
+	u32 v4l2_id;
+	u32 hfi_id;
+	enum plat_inst_cap_flags flags;
+};
+
+struct platform_data {
+	const struct bus_info *bus_tbl;
+	unsigned int bus_tbl_size;
+	const struct bw_info *bw_tbl_dec;
+	unsigned int bw_tbl_dec_size;
+	const char * const *pd_tbl;
+	unsigned int pd_tbl_size;
+	const char * const *opp_pd_tbl;
+	unsigned int opp_pd_tbl_size;
+	const struct clock_info *clk_tbl;
+	unsigned int clk_tbl_size;
+	const char * const *clk_rst_tbl;
+	unsigned int clk_rst_tbl_size;
+	const struct reg_preset_info *reg_prst_tbl;
+	unsigned int reg_prst_tbl_size;
+	struct ubwc_config_data *ubwc_config;
+	const char *fwname;
+	u32 pas_id;
+	struct plat_core_cap *core_data;
+	u32 core_data_size;
+	struct plat_inst_cap *inst_cap_data;
+	u32 inst_cap_data_size;
+};
+
+int init_platform(struct iris_core *core);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
new file mode 100644
index 0000000..c75017e
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/clock/qcom,sm8550-gcc.h>
+#include <dt-bindings/clock/qcom,sm8450-videocc.h>
+
+#include <media/v4l2-ctrls.h>
+
+#include "hfi_defines.h"
+#include "platform_common.h"
+#include "resources.h"
+
+#define CODECS_ALL     (H264 | HEVC | VP9)
+
+#define DEFAULT_FPS        30
+#define MINIMUM_FPS         1
+#define MAXIMUM_FPS       480
+
+static struct plat_core_cap core_data_sm8550[] = {
+	{DEC_CODECS, H264 | HEVC | VP9},
+	{MAX_SESSION_COUNT, 16},
+	{MAX_MBPF, 278528}, /* ((8192x4352)/256) * 2 */
+	{MAX_MBPS, 7833600}, /* max_load 7680x4320@60fps */
+	{NUM_VPP_PIPE, 4},
+	{HW_RESPONSE_TIMEOUT, HW_RESPONSE_TIMEOUT_VALUE},
+	{DMA_MASK, GENMASK(31, 29) - 1},
+	{CP_START, 0},
+	{CP_SIZE, 0x25800000},
+	{CP_NONPIXEL_START, 0x01000000},
+	{CP_NONPIXEL_SIZE, 0x24800000},
+};
+
+static struct plat_inst_cap instance_cap_data_sm8550[] = {
+	{FRAME_WIDTH, CODECS_ALL, 96, 8192, 1, 1920},
+
+	{FRAME_WIDTH, VP9, 96, 4096, 1, 1920},
+
+	{FRAME_HEIGHT, CODECS_ALL, 96, 8192, 1, 1080},
+
+	{FRAME_HEIGHT, VP9, 96, 4096, 1, 1080},
+
+	{PIX_FMTS, H264,
+		FMT_NV12,
+		FMT_NV12C,
+		FMT_NV12 | FMT_NV21 | FMT_NV12C,
+		FMT_NV12C},
+
+	{PIX_FMTS, HEVC | VP9,
+		FMT_NV12,
+		FMT_TP10C,
+		FMT_NV12 | FMT_NV21 | FMT_NV12C | FMT_TP10C,
+		FMT_NV12C},
+
+	{MBPF, CODECS_ALL, 36, 138240, 1, 138240},
+
+	/* (4096 * 2304) / 256 */
+	{MBPF, VP9, 36, 36864, 1, 36864},
+
+	{QUEUED_RATE, CODECS_ALL,
+		(MINIMUM_FPS << 16), INT_MAX,
+		1, (DEFAULT_FPS << 16)},
+
+	{MB_CYCLES_VSP, CODECS_ALL, 25, 25, 1, 25},
+
+	{MB_CYCLES_VSP, VP9, 60, 60, 1, 60},
+
+	{MB_CYCLES_VPP, CODECS_ALL, 200, 200, 1, 200},
+
+	{MB_CYCLES_LP, CODECS_ALL, 200, 200, 1, 200},
+
+	{MB_CYCLES_FW, CODECS_ALL, 489583, 489583, 1, 489583},
+
+	{MB_CYCLES_FW_VPP, CODECS_ALL, 66234, 66234, 1, 66234},
+
+	{NUM_COMV, CODECS_ALL,
+		0, INT_MAX, 1, 0},
+
+	{PROFILE, H264,
+		V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
+		V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_HIGH),
+		V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+		V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+		HFI_PROP_PROFILE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{PROFILE, HEVC,
+		V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
+		V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
+		BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10),
+		V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
+		V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
+		HFI_PROP_PROFILE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{PROFILE, VP9,
+		V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+		V4L2_MPEG_VIDEO_VP9_PROFILE_2,
+		BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_0) |
+		BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_2),
+		V4L2_MPEG_VIDEO_VP9_PROFILE_0,
+		V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
+		HFI_PROP_PROFILE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{LEVEL, H264,
+		V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
+		V4L2_MPEG_VIDEO_H264_LEVEL_6_2,
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1B) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_3) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_2),
+		V4L2_MPEG_VIDEO_H264_LEVEL_6_1,
+		V4L2_CID_MPEG_VIDEO_H264_LEVEL,
+		HFI_PROP_LEVEL,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{LEVEL, HEVC,
+		V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
+		V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2),
+		V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1,
+		V4L2_CID_MPEG_VIDEO_HEVC_LEVEL,
+		HFI_PROP_LEVEL,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{LEVEL, VP9,
+		V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
+		V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_1_0) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_1_1) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_2_0) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_2_1) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_3_0) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_3_1) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_4_0) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_4_1) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_0) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_1) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_2) |
+		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_6_0),
+		V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
+		V4L2_CID_MPEG_VIDEO_VP9_LEVEL,
+		HFI_PROP_LEVEL,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{HEVC_TIER, HEVC,
+		V4L2_MPEG_VIDEO_HEVC_TIER_MAIN,
+		V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
+		BIT(V4L2_MPEG_VIDEO_HEVC_TIER_MAIN) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_TIER_HIGH),
+		V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
+		V4L2_CID_MPEG_VIDEO_HEVC_TIER,
+		HFI_PROP_TIER,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{DISPLAY_DELAY_ENABLE, CODECS_ALL,
+		0, 1, 1, 0,
+		V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE,
+		HFI_PROP_DECODE_ORDER_OUTPUT,
+		CAP_FLAG_INPUT_PORT},
+
+	{DISPLAY_DELAY, CODECS_ALL,
+		0, 1, 1, 0,
+		V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY,
+		HFI_PROP_DECODE_ORDER_OUTPUT,
+		CAP_FLAG_INPUT_PORT},
+
+	{OUTPUT_ORDER, CODECS_ALL,
+		0, 1, 1, 0,
+		0,
+		HFI_PROP_DECODE_ORDER_OUTPUT,
+		CAP_FLAG_INPUT_PORT},
+
+	{INPUT_BUF_HOST_MAX_COUNT, CODECS_ALL,
+		DEFAULT_MAX_HOST_BUF_COUNT, DEFAULT_MAX_HOST_BURST_BUF_COUNT,
+		1, DEFAULT_MAX_HOST_BUF_COUNT,
+		0,
+		HFI_PROP_BUFFER_HOST_MAX_COUNT,
+		CAP_FLAG_INPUT_PORT},
+
+	{STAGE, CODECS_ALL,
+		STAGE_1,
+		STAGE_2, 1,
+		STAGE_2,
+		0,
+		HFI_PROP_STAGE},
+
+	{PIPE, CODECS_ALL,
+		PIPE_1,
+		PIPE_4, 1,
+		PIPE_4,
+		0,
+		HFI_PROP_PIPE},
+
+	{POC, H264, 0, 2, 1, 1,
+		0,
+		HFI_PROP_PIC_ORDER_CNT_TYPE},
+
+	{CODED_FRAMES, H264 | HEVC,
+		CODED_FRAMES_PROGRESSIVE, CODED_FRAMES_PROGRESSIVE,
+		0, CODED_FRAMES_PROGRESSIVE,
+		0,
+		HFI_PROP_CODED_FRAMES},
+
+	{BIT_DEPTH, CODECS_ALL, BIT_DEPTH_8, BIT_DEPTH_10, 1, BIT_DEPTH_8,
+		0,
+		HFI_PROP_LUMA_CHROMA_BIT_DEPTH},
+
+	{DEFAULT_HEADER, CODECS_ALL,
+		0, 1, 1, 0,
+		0,
+		HFI_PROP_DEC_DEFAULT_HEADER},
+
+	{RAP_FRAME, CODECS_ALL,
+		0, 1, 1, 1,
+		0,
+		HFI_PROP_DEC_START_FROM_RAP_FRAME,
+		CAP_FLAG_INPUT_PORT},
+};
+
+static const struct bus_info sm8550_bus_table[] = {
+	{ NULL, "iris-cnoc", 1000, 1000     },
+	{ NULL, "iris-ddr",  1000, 15000000 },
+};
+
+static const struct clock_info sm8550_clk_table[] = {
+	{ NULL, "gcc_video_axi0", GCC_VIDEO_AXI0_CLK, 0 },
+	{ NULL, "core_clk",       VIDEO_CC_MVS0C_CLK, 0 },
+	{ NULL, "vcodec_core",    VIDEO_CC_MVS0_CLK,  1 },
+};
+
+static const char * const sm8550_clk_reset_table[] = { "video_axi_reset", NULL };
+
+static const char * const sm8550_pd_table[] = { "iris-ctl", "vcodec", NULL };
+
+static const char * const sm8550_opp_pd_table[] = { "mxc", "mmcx", NULL };
+
+static const struct bw_info sm8550_bw_table_dec[] = {
+	{ 2073600, 1608000, 2742000 },	/* 4096x2160@60 */
+	{ 1036800,  826000, 1393000 },	/* 4096x2160@30 */
+	{  489600,  567000,  723000 },	/* 1920x1080@60 */
+	{  244800,  294000,  372000 },	/* 1920x1080@30 */
+};
+
+static const struct reg_preset_info sm8550_reg_preset_table[] = {
+	{ 0xB0088, 0x0, 0x11 },
+};
+
+static struct ubwc_config_data ubwc_config_sm8550[] = {
+	UBWC_CONFIG(8, 32, 16, 0, 1, 1, 1),
+};
+
+struct platform_data sm8550_data = {
+	.bus_tbl = sm8550_bus_table,
+	.bus_tbl_size = ARRAY_SIZE(sm8550_bus_table),
+	.clk_tbl = sm8550_clk_table,
+	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
+	.clk_rst_tbl = sm8550_clk_reset_table,
+	.clk_rst_tbl_size = ARRAY_SIZE(sm8550_clk_reset_table),
+
+	.bw_tbl_dec = sm8550_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(sm8550_bw_table_dec),
+
+	.pd_tbl = sm8550_pd_table,
+	.pd_tbl_size = ARRAY_SIZE(sm8550_pd_table),
+	.opp_pd_tbl = sm8550_opp_pd_table,
+	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
+
+	.reg_prst_tbl = sm8550_reg_preset_table,
+	.reg_prst_tbl_size = ARRAY_SIZE(sm8550_reg_preset_table),
+	.fwname = "vpu30_4v.mbn",
+	.pas_id = 9,
+
+	.core_data = core_data_sm8550,
+	.core_data_size = ARRAY_SIZE(core_data_sm8550),
+	.inst_cap_data = instance_cap_data_sm8550,
+	.inst_cap_data_size = ARRAY_SIZE(instance_cap_data_sm8550),
+	.ubwc_config = ubwc_config_sm8550,
+};
diff --git a/drivers/media/platform/qcom/vcodec/iris/resources.c b/drivers/media/platform/qcom/vcodec/iris/resources.c
index 5aebbe4..8cfdcd6 100644
--- a/drivers/media/platform/qcom/vcodec/iris/resources.c
+++ b/drivers/media/platform/qcom/vcodec/iris/resources.c
@@ -3,9 +3,6 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <dt-bindings/clock/qcom,sm8550-gcc.h>
-#include <dt-bindings/clock/qcom,sm8450-videocc.h>
-
 #include <linux/clk.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
@@ -15,28 +12,9 @@
 #include <linux/sort.h>
 
 #include "iris_core.h"
+#include "platform_common.h"
 #include "resources.h"
 
-static const struct bus_info plat_bus_table[] = {
-	{ NULL, "iris-cnoc", 1000, 1000     },
-	{ NULL, "iris-ddr",  1000, 15000000 },
-};
-
-static const char * const plat_pd_table[] = { "iris-ctl", "vcodec", NULL };
-#define PD_COUNT 2
-
-static const char * const plat_opp_pd_table[] = { "mxc", "mmcx", NULL };
-#define OPP_PD_COUNT 2
-
-static const struct clock_info plat_clk_table[] = {
-	{ NULL, "gcc_video_axi0", GCC_VIDEO_AXI0_CLK, 0, 0 },
-	{ NULL, "core_clk",       VIDEO_CC_MVS0C_CLK, 0, 0 },
-	{ NULL, "vcodec_core",    VIDEO_CC_MVS0_CLK,  1, 0 },
-};
-
-static const char * const plat_clk_reset_table[] = { "video_axi_reset", NULL };
-#define RESET_COUNT 1
-
 static void iris_pd_release(void *res)
 {
 	struct device *pd = (struct device *)res;
@@ -83,10 +61,13 @@ static int iris_opp_dl_get(struct device *dev, struct device *supplier)
 
 static int init_bus(struct iris_core *core)
 {
+	const struct bus_info *bus_tbl;
 	struct bus_info *binfo = NULL;
 	u32 i = 0;
 
-	core->bus_count = ARRAY_SIZE(plat_bus_table);
+	bus_tbl = core->platform_data->bus_tbl;
+
+	core->bus_count = core->platform_data->bus_tbl_size;
 	core->bus_tbl = devm_kzalloc(core->dev,
 				     sizeof(struct bus_info) * core->bus_count,
 				     GFP_KERNEL);
@@ -95,9 +76,9 @@ static int init_bus(struct iris_core *core)
 
 	for (i = 0; i < core->bus_count; i++) {
 		binfo = &core->bus_tbl[i];
-		binfo->name = plat_bus_table[i].name;
-		binfo->bw_min_kbps = plat_bus_table[i].bw_min_kbps;
-		binfo->bw_max_kbps = plat_bus_table[i].bw_max_kbps;
+		binfo->name = bus_tbl[i].name;
+		binfo->bw_min_kbps = bus_tbl[i].bw_min_kbps;
+		binfo->bw_max_kbps = bus_tbl[i].bw_max_kbps;
 		binfo->icc = devm_of_icc_get(core->dev, binfo->name);
 		if (IS_ERR(binfo->icc)) {
 			dev_err(core->dev,
@@ -112,20 +93,24 @@ static int init_bus(struct iris_core *core)
 static int init_power_domains(struct iris_core *core)
 {
 	struct power_domain_info *pdinfo = NULL;
+	const char * const *opp_pd_tbl;
+	const char * const *pd_tbl;
 	struct device **opp_vdevs = NULL;
+	u32 opp_pd_cnt, i;
 	int ret;
-	u32 i;
 
-	core->pd_count = PD_COUNT;
+	pd_tbl = core->platform_data->pd_tbl;
+
+	core->pd_count = core->platform_data->pd_tbl_size;
 	core->power_domain_tbl = devm_kzalloc(core->dev,
 					      sizeof(struct power_domain_info) * core->pd_count,
 					      GFP_KERNEL);
 	if (!core->power_domain_tbl)
 		return -ENOMEM;
 
-	for (i = 0; i < core->pd_count; i++) {
+	for (i = 0; i < (core->pd_count - 1); i++) {
 		pdinfo = &core->power_domain_tbl[i];
-		pdinfo->name = plat_pd_table[i];
+		pdinfo->name = pd_tbl[i];
 		ret = iris_pd_get(core, pdinfo);
 		if (ret) {
 			dev_err(core->dev,
@@ -134,11 +119,14 @@ static int init_power_domains(struct iris_core *core)
 		}
 	}
 
-	ret = devm_pm_opp_attach_genpd(core->dev, plat_opp_pd_table, &opp_vdevs);
+	opp_pd_tbl = core->platform_data->opp_pd_tbl;
+	opp_pd_cnt = core->platform_data->opp_pd_tbl_size;
+
+	ret = devm_pm_opp_attach_genpd(core->dev, opp_pd_tbl, &opp_vdevs);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < OPP_PD_COUNT; i++) {
+	for (i = 0; i < (opp_pd_cnt - 1) ; i++) {
 		ret = iris_opp_dl_get(core->dev, opp_vdevs[i]);
 		if (ret) {
 			dev_err(core->dev, "%s: failed to create dl: %s\n",
@@ -158,10 +146,13 @@ static int init_power_domains(struct iris_core *core)
 
 static int init_clocks(struct iris_core *core)
 {
+	const struct clock_info *clk_tbl;
 	struct clock_info *cinfo = NULL;
 	u32 i;
 
-	core->clk_count = ARRAY_SIZE(plat_clk_table);
+	clk_tbl = core->platform_data->clk_tbl;
+
+	core->clk_count = core->platform_data->clk_tbl_size;
 	core->clock_tbl = devm_kzalloc(core->dev,
 				       sizeof(struct clock_info) * core->clk_count,
 				       GFP_KERNEL);
@@ -170,9 +161,9 @@ static int init_clocks(struct iris_core *core)
 
 	for (i = 0; i < core->clk_count; i++) {
 		cinfo = &core->clock_tbl[i];
-		cinfo->name = plat_clk_table[i].name;
-		cinfo->clk_id = plat_clk_table[i].clk_id;
-		cinfo->has_scaling = plat_clk_table[i].has_scaling;
+		cinfo->name = clk_tbl[i].name;
+		cinfo->clk_id = clk_tbl[i].clk_id;
+		cinfo->has_scaling = clk_tbl[i].has_scaling;
 		cinfo->clk = devm_clk_get(core->dev, cinfo->name);
 		if (IS_ERR(cinfo->clk)) {
 			dev_err(core->dev,
@@ -187,18 +178,21 @@ static int init_clocks(struct iris_core *core)
 static int init_reset_clocks(struct iris_core *core)
 {
 	struct reset_info *rinfo = NULL;
+	const char * const *rst_tbl;
 	u32 i = 0;
 
-	core->reset_count = RESET_COUNT;
+	rst_tbl = core->platform_data->clk_rst_tbl;
+
+	core->reset_count = core->platform_data->clk_rst_tbl_size;
 	core->reset_tbl = devm_kzalloc(core->dev,
 				       sizeof(struct reset_info) * core->reset_count,
 				       GFP_KERNEL);
 	if (!core->reset_tbl)
 		return -ENOMEM;
 
-	for (i = 0; i < core->reset_count; i++) {
+	for (i = 0; i < (core->reset_count - 1); i++) {
 		rinfo = &core->reset_tbl[i];
-		rinfo->name = plat_clk_reset_table[i];
+		rinfo->name = rst_tbl[i];
 		rinfo->rst = devm_reset_control_get(core->dev, rinfo->name);
 		if (IS_ERR(rinfo->rst)) {
 			dev_err(core->dev,
-- 
2.7.4


