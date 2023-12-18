Return-Path: <linux-kernel+bounces-3485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D1816CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E7B23C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175841860;
	Mon, 18 Dec 2023 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j6MQRq59"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B41CAB2;
	Mon, 18 Dec 2023 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBHw62032490;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=VvqHhZOTTYvc/rwKV2zir+K0UrIHVwkgCzFSeUnMfF4=; b=j6
	MQRq590+BQX8ZYbrtTHRCXKoEqT1ZmCSXa5c2lg9PYt2gBVuDYEoj3OsbUTinr6H
	cxWOaDyLiXUfuueqPaJih7mFUlo75OYk4hxZ4igmmoMcXRv3HkSTInrD8UzQOzrf
	Pk9E7AjZ9AOmp95O4kpTov8Ob0kUmZu+wRAj56jLBR1OqfRpgsykmkXYgplo9wqQ
	SojX3JyLNgIrJQGBchOg9qxUuvquX0ZGbtDF0w7zOk8IzTaPAnOrqUZEXmNOwsEA
	TfRwGtewUuOsHaPe8cXvSsjHqha6EKcNFcqaihqMY7aOJleI6WVLNWGQBOOb4Taq
	WvUfo/tBZy6NE/UQE+eA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mfe04nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0Hm004853;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ae-2;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBa9rU000378;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX8m5030064;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 6725A2383; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 29/34] media: iris: implement power management
Date: Mon, 18 Dec 2023 17:02:24 +0530
Message-Id: <1702899149-21321-30-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bTHmOPnAKerMh8myzEXcM0HtyEWAWpNV
X-Proofpoint-GUID: bTHmOPnAKerMh8myzEXcM0HtyEWAWpNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Hardware specific power sequence include programming specific
sequence of registers. Implements this sequence for iris3.

Introduce video device suspend and resume using runtime PM.

Also, implement iris3 specific calculation for clock and
bus bandwidth which depends on hardware configuration,
codec format, resolution and frame rate.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   2 +
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |   7 +
 .../media/platform/qcom/vcodec/iris/iris_common.h  |   7 +
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   4 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  66 +++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   4 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c | 175 +++++++-
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   5 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  48 +++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   4 +
 .../platform/qcom/vcodec/iris/iris_hfi_response.c  |   2 +
 .../platform/qcom/vcodec/iris/iris_instance.h      |  10 +
 .../media/platform/qcom/vcodec/iris/iris_power.c   | 173 ++++++++
 .../media/platform/qcom/vcodec/iris/iris_power.h   |  15 +
 .../media/platform/qcom/vcodec/iris/iris_probe.c   | 118 +++++-
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  42 +-
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    |   7 +
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |  36 +-
 .../platform/qcom/vcodec/iris/platform_common.h    |  18 +
 .../media/platform/qcom/vcodec/iris/resources.c    | 280 +++++++++++++
 .../media/platform/qcom/vcodec/iris/resources.h    |   8 +
 .../media/platform/qcom/vcodec/iris/vpu_common.c   |  87 ++++
 .../media/platform/qcom/vcodec/iris/vpu_common.h   |  10 +
 .../media/platform/qcom/vcodec/iris/vpu_iris3.c    | 454 ++++++++++++++++++---
 .../platform/qcom/vcodec/iris/vpu_iris3_power.c    |  97 +++++
 .../platform/qcom/vcodec/iris/vpu_iris3_power.h    |  13 +
 26 files changed, 1614 insertions(+), 78 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_power.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_power.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 7e3d9f1..4c8f8f6 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -13,10 +13,12 @@ iris-objs += iris_probe.o \
              iris_hfi_response.o \
              iris_hfi_packet.o \
              iris_buffer.o \
+             iris_power.o \
              resources.o \
              vpu_common.o \
              vpu_iris3.o \
              vpu_iris3_buffer.o \
+             vpu_iris3_power.o \
              platform_common.o \
              platform_sm8550.o
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index bbe8ca6..872674e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -12,6 +12,7 @@
 
 #define HFI_CMD_BEGIN				0x01000000
 #define HFI_CMD_INIT				0x01000001
+#define HFI_CMD_POWER_COLLAPSE			0x01000002
 #define HFI_CMD_OPEN				0x01000003
 #define HFI_CMD_CLOSE				0x01000004
 #define HFI_CMD_START				0x01000005
@@ -46,10 +47,16 @@ enum hfi_property_mode_type {
 
 #define HFI_BITMASK_FRAME_MBS_ONLY_FLAG		0x00000001
 
+#define HFI_TRUE				0x00000001
+
+#define HFI_FALSE				0x00000000
+
 #define HFI_PROP_BEGIN				0x03000000
 
 #define HFI_PROP_IMAGE_VERSION			0x03000001
 
+#define HFI_PROP_INTRA_FRAME_POWER_COLLAPSE	0x03000002
+
 enum hfi_codec_type {
 	HFI_CODEC_DECODE_AVC	= 1,
 	HFI_CODEC_ENCODE_AVC	= 2,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index 24b322a..3ab4767 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -28,6 +28,8 @@
 #define MAX_DPB_LIST_ARRAY_SIZE (16 * 4)
 #define MAX_DPB_LIST_PAYLOAD_SIZE (16 * 4 * 4)
 
+#define INPUT_TIMER_LIST_SIZE 30
+
 enum codec_type {
 	H264	= BIT(0),
 	HEVC	= BIT(1),
@@ -128,4 +130,9 @@ struct iris_hfi_frame_info {
 	u32	overflow;
 };
 
+struct iris_input_timer {
+	struct list_head	list;
+	u64			time_us;
+};
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 6452ea7..50553d2 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -101,6 +101,10 @@ struct iris_core {
 	struct list_head			instances;
 	u32					intr_status;
 	char					fw_version[IRIS_VERSION_LENGTH];
+	struct mutex				pm_lock; /* lock for pm operations */
+	u32					skip_pc_count;
+	bool					power_enabled;
+	struct iris_core_power			power;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index a5b8aef..395a189 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -3,12 +3,15 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/pm_runtime.h>
+
 #include "hfi_defines.h"
 #include "iris_core.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
 #include "iris_instance.h"
+#include "iris_power.h"
 #include "iris_vidc.h"
 
 int check_core_lock(struct iris_core *core)
@@ -479,6 +482,8 @@ int queue_deferred_buffers(struct iris_inst *inst, enum iris_buffer_type buf_typ
 	if (!buffers)
 		return -EINVAL;
 
+	iris_scale_power(inst);
+
 	list_for_each_entry(buf, &buffers->list, list) {
 		if (!(buf->attr & BUF_ATTR_DEFERRED))
 			continue;
@@ -775,6 +780,9 @@ int session_streamoff(struct iris_inst *inst, u32 plane)
 	if (ret)
 		goto error;
 
+	if (plane == INPUT_MPLANE)
+		iris_flush_input_timer(inst);
+
 	/* no more queued buffers after streamoff */
 	count = get_num_queued_buffers(inst, buffer_type);
 	if (count) {
@@ -797,3 +805,61 @@ int session_streamoff(struct iris_inst *inst, u32 plane)
 
 	return ret;
 }
+
+int iris_pm_get(struct iris_core *core)
+{
+	int ret;
+
+	mutex_lock(&core->pm_lock);
+	ret = pm_runtime_resume_and_get(core->dev);
+	mutex_unlock(&core->pm_lock);
+
+	return ret;
+}
+
+int iris_pm_put(struct iris_core *core, bool autosuspend)
+{
+	int ret;
+
+	mutex_lock(&core->pm_lock);
+
+	if (autosuspend)
+		ret = pm_runtime_put_autosuspend(core->dev);
+	else
+		ret = pm_runtime_put_sync(core->dev);
+	if (ret > 0)
+		ret = 0;
+
+	mutex_unlock(&core->pm_lock);
+
+	return ret;
+}
+
+int iris_pm_get_put(struct iris_core *core)
+{
+	int ret = 0;
+
+	mutex_lock(&core->pm_lock);
+
+	if (pm_runtime_suspended(core->dev)) {
+		ret = pm_runtime_resume_and_get(core->dev);
+		if (ret < 0)
+			goto error;
+
+		ret = pm_runtime_put_autosuspend(core->dev);
+	}
+	if (ret > 0)
+		ret = 0;
+
+error:
+	mutex_unlock(&core->pm_lock);
+
+	return ret;
+}
+
+void iris_pm_touch(struct iris_core *core)
+{
+	mutex_lock(&core->pm_lock);
+	pm_runtime_mark_last_busy(core->dev);
+	mutex_unlock(&core->pm_lock);
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 3a9889e..c628b2e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -51,5 +51,9 @@ int iris_vb2_buffer_done(struct iris_inst *inst,
 int iris_release_nonref_buffers(struct iris_inst *inst);
 void iris_destroy_buffers(struct iris_inst *inst);
 int session_streamoff(struct iris_inst *inst, u32 plane);
+int iris_pm_get(struct iris_core *core);
+int iris_pm_put(struct iris_core *core, bool autosuspend);
+int iris_pm_get_put(struct iris_core *core);
+void iris_pm_touch(struct iris_core *core);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 2b3fa47..2850fd5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -67,6 +67,41 @@ static bool validate_session(struct iris_core *core,
 	return valid;
 }
 
+static int iris_power_off(struct iris_core *core)
+{
+	int ret;
+
+	if (!core->power_enabled)
+		return 0;
+
+	ret = call_vpu_op(core, power_off, core);
+	if (ret) {
+		dev_err(core->dev, "Failed to power off, err: %d\n", ret);
+		return ret;
+	}
+	core->power_enabled = false;
+
+	return ret;
+}
+
+static int iris_power_on(struct iris_core *core)
+{
+	int ret;
+
+	if (core->power_enabled)
+		return 0;
+
+	ret = call_vpu_op(core, power_on, core);
+	if (ret) {
+		dev_err(core->dev, "Failed to power on, err: %d\n", ret);
+		return ret;
+	}
+
+	core->power_enabled = true;
+
+	return ret;
+}
+
 static int sys_init(struct iris_core *core)
 {
 	int ret;
@@ -113,20 +148,24 @@ int iris_hfi_core_init(struct iris_core *core)
 	if (ret)
 		goto error;
 
+	ret = iris_power_on(core);
+	if (ret)
+		goto error;
+
 	core->use_tz = use_tz(core->dev);
 	if (!core->use_tz)
-		goto error;
+		goto error_power_off;
 
 	pas_id = core->platform_data->pas_id;
 	fw_name = core->platform_data->fwname;
 	ret = load_fw(core->dev, fw_name, &mem_phys, &mem_size,
 		      pas_id, core->use_tz);
 	if (ret)
-		goto error;
+		goto error_power_off;
 
 	ret = auth_reset_fw(pas_id);
 	if (ret)
-		goto error;
+		goto error_power_off;
 
 	cp_start = core->cap[CP_START].value;
 	cp_size = core->cap[CP_SIZE].value;
@@ -135,22 +174,24 @@ int iris_hfi_core_init(struct iris_core *core)
 	ret = protect_secure_region(cp_start, cp_size, cp_nonpixel_start,
 				    cp_nonpixel_size, pas_id);
 	if (ret)
-		goto error;
+		goto error_power_off;
 
 	ret = call_vpu_op(core, boot_firmware, core);
 	if (ret)
-		goto error;
+		goto error_power_off;
 
 	ret = sys_init(core);
 	if (ret)
-		goto error;
+		goto error_power_off;
 
 	ret = sys_image_version(core);
 	if (ret)
-		goto error;
+		goto error_power_off;
 
 	return ret;
 
+error_power_off:
+	iris_power_off(core);
 error:
 	dev_err(core->dev, "%s(): failed with ret %d\n", __func__, ret);
 
@@ -170,6 +211,8 @@ int iris_hfi_core_deinit(struct iris_core *core)
 
 	unload_fw(core->platform_data->pas_id);
 
+	iris_power_off(core);
+
 	return ret;
 }
 
@@ -573,16 +616,24 @@ irqreturn_t iris_hfi_isr(int irq, void *data)
 irqreturn_t iris_hfi_isr_handler(int irq, void *data)
 {
 	struct iris_core *core = data;
+	int ret;
 
 	if (!core)
 		return IRQ_NONE;
 
+	ret = iris_pm_get(core);
+	if (ret)
+		goto exit;
+
 	mutex_lock(&core->lock);
 	call_vpu_op(core, clear_interrupt, core);
 	mutex_unlock(&core->lock);
 
 	__response_handler(core);
 
+	iris_pm_put(core, true);
+
+exit:
 	if (!call_vpu_op(core, watchdog, core, core->intr_status))
 		enable_irq(irq);
 
@@ -701,3 +752,113 @@ int iris_hfi_release_buffer(struct iris_inst *inst,
 
 	return ret;
 }
+
+int prepare_pc(struct iris_core *core)
+{
+	int ret;
+
+	ret = hfi_packet_sys_pc_prep(core, core->packet, core->packet_size);
+	if (ret)
+		goto err_pc_prep;
+
+	ret = iris_hfi_queue_cmd_write(core, core->packet);
+	if (ret)
+		goto err_pc_prep;
+
+	return ret;
+
+err_pc_prep:
+	dev_err(core->dev, "Failed to prepare iris for power off\n");
+
+	return ret;
+}
+
+int iris_hfi_pm_suspend(struct iris_core *core)
+{
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	if (!core_in_valid_state(core))
+		return -EINVAL;
+
+	if (!core->power_enabled)
+		return 0;
+
+	if (core->skip_pc_count >= MAX_PC_SKIP_COUNT) {
+		dev_err(core->dev, "Failed to PC for %d times\n", core->skip_pc_count);
+		core->skip_pc_count = 0;
+		iris_change_core_state(core, IRIS_CORE_ERROR);
+		iris_core_deinit_locked(core);
+		return -EINVAL;
+	}
+
+	iris_flush_debug_queue(core, core->packet, core->packet_size);
+
+	ret = call_vpu_op(core, prepare_pc, core);
+	if (ret) {
+		core->skip_pc_count++;
+		iris_pm_touch(core);
+		return -EAGAIN;
+	}
+
+	ret = set_hw_state(false);
+	if (ret)
+		return ret;
+
+	ret = iris_power_off(core);
+	if (ret)
+		return ret;
+
+	core->skip_pc_count = 0;
+
+	return ret;
+}
+
+int iris_hfi_pm_resume(struct iris_core *core)
+{
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	if (!core_in_valid_state(core))
+		return -EINVAL;
+
+	if (core->power_enabled)
+		return 0;
+
+	ret = iris_power_on(core);
+	if (ret)
+		goto error;
+
+	ret = set_hw_state(true);
+	if (ret)
+		goto err_power_off;
+
+	ret = call_vpu_op(core, boot_firmware, core);
+	if (ret)
+		goto err_suspend_hw;
+
+	ret = hfi_packet_sys_interframe_powercollapse(core, core->packet, core->packet_size);
+	if (ret)
+		goto err_suspend_hw;
+
+	ret = iris_hfi_queue_cmd_write(core, core->packet);
+	if (ret)
+		goto err_suspend_hw;
+
+	return ret;
+
+err_suspend_hw:
+	set_hw_state(false);
+err_power_off:
+	iris_power_off(core);
+error:
+	dev_err(core->dev, "Failed to Resume\n");
+
+	return -EBUSY;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index ab479a9..465bfc5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -9,6 +9,8 @@
 #include "iris_instance.h"
 #include "iris_core.h"
 
+#define MAX_PC_SKIP_COUNT 10
+
 int iris_hfi_core_init(struct iris_core *core);
 int iris_hfi_core_deinit(struct iris_core *core);
 int iris_hfi_session_open(struct iris_inst *inst);
@@ -32,6 +34,9 @@ int iris_hfi_queue_buffer(struct iris_inst *inst,
 			  struct iris_buffer *buffer);
 int iris_hfi_release_buffer(struct iris_inst *inst,
 			    struct iris_buffer *buffer);
+int iris_hfi_pm_suspend(struct iris_core *core);
+int iris_hfi_pm_resume(struct iris_core *core);
+int prepare_pc(struct iris_core *core);
 
 irqreturn_t iris_hfi_isr(int irq, void *data);
 irqreturn_t iris_hfi_isr_handler(int irq, void *data);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index 8dafd04..fab206cf 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -622,3 +622,51 @@ int hfi_packet_session_property(struct iris_inst *inst,
 
 	return ret;
 }
+
+int hfi_packet_sys_interframe_powercollapse(struct iris_core *core,
+					    u8 *pkt, u32 pkt_size)
+{
+	u32 payload = 0;
+	int ret;
+
+	ret = hfi_create_header(pkt, pkt_size,
+				0 /*session_id*/,
+				core->header_id++);
+	if (ret)
+		return ret;
+
+	payload = HFI_TRUE;
+
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_PROP_INTRA_FRAME_POWER_COLLAPSE,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				&payload,
+				sizeof(u32));
+
+	return ret;
+}
+
+int hfi_packet_sys_pc_prep(struct iris_core *core,
+			   u8 *pkt, u32 pkt_size)
+{
+	int ret;
+
+	ret = hfi_create_header(pkt, pkt_size,
+				0 /*session_id*/,
+				core->header_id++);
+	if (ret)
+		return ret;
+
+	ret = hfi_create_packet(pkt, pkt_size,
+				HFI_CMD_POWER_COLLAPSE,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_NONE,
+				HFI_PORT_NONE,
+				core->packet_id++,
+				NULL, 0);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index 8999c28..849b585 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -104,5 +104,9 @@ int hfi_packet_session_command(struct iris_inst *inst, u32 pkt_type,
 int hfi_packet_session_property(struct iris_inst *inst,
 				u32 pkt_type, u32 flags, u32 port,
 				u32 payload_type, void *payload, u32 payload_size);
+int hfi_packet_sys_interframe_powercollapse(struct iris_core *core,
+					    u8 *pkt, u32 pkt_size);
+int hfi_packet_sys_pc_prep(struct iris_core *core,
+			   u8 *pkt, u32 pkt_size);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
index 3548f9d..a4d5d9c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
@@ -928,6 +928,8 @@ static int handle_response(struct iris_core *core, void *response)
 	struct hfi_header *hdr;
 	int ret;
 
+	iris_pm_touch(core);
+
 	hdr = (struct hfi_header *)response;
 	ret = validate_hdr_packet(core, hdr);
 	if (ret)
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 50154bf..3c85e78 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -47,6 +47,11 @@
  * @dst_subcr_params: subscription params to fw on output port
  * @dpb_list_payload: array of dpb buffers
  * @once_per_session_set: boolean to set once per session property
+ * @max_rate: max input rate
+ * @max_input_data_size: max size of input data
+ * @power: structure of power info
+ * @bus_data: structure of bus data
+ * @input_timer_list: list head of input timer
  */
 
 struct iris_inst {
@@ -80,6 +85,11 @@ struct iris_inst {
 	struct subscription_params	dst_subcr_params;
 	u32				dpb_list_payload[MAX_DPB_LIST_ARRAY_SIZE];
 	bool				once_per_session_set;
+	u32				max_rate;
+	u32				max_input_data_size;
+	struct iris_inst_power		power;
+	struct bus_vote_data		bus_data;
+	struct list_head		input_timer_list;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_power.c b/drivers/media/platform/qcom/vcodec/iris/iris_power.c
new file mode 100644
index 0000000..77439e3
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_power.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_power.h"
+#include "iris_helpers.h"
+#include "resources.h"
+
+static int iris_set_buses(struct iris_inst *inst)
+{
+	struct iris_inst *instance;
+	struct iris_core *core;
+	u64 total_bw_ddr = 0;
+	int ret;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+	list_for_each_entry(instance, &core->instances, list) {
+		if (!instance->max_input_data_size)
+			continue;
+
+		total_bw_ddr += instance->power.bus_bw;
+	}
+
+	ret = vote_buses(core, total_bw_ddr);
+
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+static int iris_vote_buses(struct iris_inst *inst)
+{
+	struct v4l2_format *out_f, *inp_f;
+	struct bus_vote_data *vote_data;
+	struct iris_core *core;
+
+	core = inst->core;
+
+	vote_data = &inst->bus_data;
+
+	out_f = inst->fmt_dst;
+	inp_f = inst->fmt_src;
+
+	vote_data->width = inp_f->fmt.pix_mp.width;
+	vote_data->height = inp_f->fmt.pix_mp.height;
+	vote_data->fps = inst->max_rate;
+
+	if (is_linear_colorformat(out_f->fmt.pix_mp.pixelformat)) {
+		vote_data->color_formats[0] = V4L2_PIX_FMT_NV12;
+		vote_data->color_formats[1] = out_f->fmt.pix_mp.pixelformat;
+	} else {
+		vote_data->color_formats[0] = out_f->fmt.pix_mp.pixelformat;
+	}
+
+	call_session_op(core, calc_bw, inst, vote_data);
+
+	inst->power.bus_bw = vote_data->bus_bw;
+
+	return iris_set_buses(inst);
+}
+
+static int iris_set_clocks(struct iris_inst *inst)
+{
+	struct iris_inst *instance;
+	struct iris_core *core;
+	int ret = 0;
+	u64 freq;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+
+	freq = 0;
+	list_for_each_entry(instance, &core->instances, list) {
+		if (!instance->max_input_data_size)
+			continue;
+
+		freq += instance->power.min_freq;
+	}
+
+	core->power.clk_freq = freq;
+
+	ret = opp_set_rate(core, freq);
+
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+static int iris_scale_clocks(struct iris_inst *inst)
+{
+	struct iris_buffer *vbuf;
+	struct iris_core *core;
+	u32 data_size = 0;
+
+	core = inst->core;
+
+	list_for_each_entry(vbuf, &inst->buffers.input.list, list)
+		data_size = max(data_size, vbuf->data_size);
+
+	inst->max_input_data_size = data_size;
+
+	inst->max_rate = inst->cap[QUEUED_RATE].value >> 16;
+
+	if (!inst->max_input_data_size)
+		return 0;
+
+	inst->power.min_freq = call_session_op(core, calc_freq, inst,
+					       inst->max_input_data_size);
+	iris_set_clocks(inst);
+
+	return 0;
+}
+
+int iris_scale_power(struct iris_inst *inst)
+{
+	iris_scale_clocks(inst);
+	iris_vote_buses(inst);
+
+	return 0;
+}
+
+int iris_update_input_rate(struct iris_inst *inst, u64 time_us)
+{
+	struct iris_input_timer *prev_timer = NULL;
+	struct iris_input_timer *input_timer;
+	u64 input_timer_sum_us = 0;
+	u64 counter = 0;
+
+	input_timer = kzalloc(sizeof(*input_timer), GFP_KERNEL);
+	if (!input_timer)
+		return -ENOMEM;
+
+	input_timer->time_us = time_us;
+	INIT_LIST_HEAD(&input_timer->list);
+	list_add_tail(&input_timer->list, &inst->input_timer_list);
+	list_for_each_entry(input_timer, &inst->input_timer_list, list) {
+		if (prev_timer) {
+			input_timer_sum_us += input_timer->time_us - prev_timer->time_us;
+			counter++;
+		}
+		prev_timer = input_timer;
+	}
+
+	if (input_timer_sum_us && counter >= INPUT_TIMER_LIST_SIZE)
+		inst->cap[QUEUED_RATE].value =
+			(s32)(DIV64_U64_ROUND_CLOSEST(counter * 1000000,
+				input_timer_sum_us) << 16);
+
+	if (counter >= INPUT_TIMER_LIST_SIZE) {
+		input_timer = list_first_entry(&inst->input_timer_list,
+					       struct iris_input_timer, list);
+		list_del_init(&input_timer->list);
+		kfree(input_timer);
+	}
+
+	return 0;
+}
+
+int iris_flush_input_timer(struct iris_inst *inst)
+{
+	struct iris_input_timer *input_timer, *dummy_timer;
+
+	list_for_each_entry_safe(input_timer, dummy_timer, &inst->input_timer_list, list) {
+		list_del_init(&input_timer->list);
+		kfree(input_timer);
+	}
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_power.h b/drivers/media/platform/qcom/vcodec/iris/iris_power.h
new file mode 100644
index 0000000..28dbd5f
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_power.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_POWER_H_
+#define _IRIS_POWER_H_
+
+#include "iris_instance.h"
+
+int iris_scale_power(struct iris_inst *inst);
+int iris_update_input_rate(struct iris_inst *inst, u64 time_us);
+int iris_flush_input_timer(struct iris_inst *inst);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index bf484a3..2571e27 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -6,14 +6,15 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "../hfi_queue.h"
 #include "iris_core.h"
+#include "iris_ctrls.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
-#include "resources.h"
 #include "iris_vidc.h"
-#include "iris_ctrls.h"
+#include "resources.h"
 
 static int init_iris_isr(struct iris_core *core)
 {
@@ -70,6 +71,8 @@ static void iris_remove(struct platform_device *pdev)
 	if (!core)
 		return;
 
+	iris_pm_get(core);
+
 	iris_core_deinit(core);
 	hfi_queue_deinit(core->dev, &core->iface_q_table, &core->sfr,
 			 &core->command_queue, &core->message_queue,
@@ -79,7 +82,10 @@ static void iris_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
+	iris_pm_put(core, false);
+
 	mutex_destroy(&core->lock);
+	mutex_destroy(&core->pm_lock);
 	core->state = IRIS_CORE_DEINIT;
 }
 
@@ -97,6 +103,7 @@ static int iris_probe(struct platform_device *pdev)
 
 	core->state = IRIS_CORE_DEINIT;
 	mutex_init(&core->lock);
+	mutex_init(&core->pm_lock);
 
 	core->packet_size = IFACEQ_CORE_PKT_SIZE;
 	core->packet = devm_kzalloc(core->dev, core->packet_size, GFP_KERNEL);
@@ -117,58 +124,66 @@ static int iris_probe(struct platform_device *pdev)
 	if (core->irq < 0)
 		return core->irq;
 
+	pm_runtime_set_autosuspend_delay(core->dev, AUTOSUSPEND_DELAY_VALUE);
+	pm_runtime_use_autosuspend(core->dev);
+	ret = devm_pm_runtime_enable(core->dev);
+	if (ret) {
+		dev_err(core->dev, "failed to enable runtime pm\n");
+		goto err_runtime_disable;
+	}
+
 	ret = init_iris_isr(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: Failed to init isr with %d\n", __func__, ret);
-		return ret;
+		goto err_runtime_disable;
 	}
 
 	ret = init_platform(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: init platform failed with %d\n", __func__, ret);
-		return ret;
+		goto err_runtime_disable;
 	}
 
 	ret = init_vpu(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: init vpu failed with %d\n", __func__, ret);
-		return ret;
+		goto err_runtime_disable;
 	}
 
 	ret = init_ops(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: init ops failed with %d\n", __func__, ret);
-		return ret;
+		goto err_runtime_disable;
 	}
 
 	ret = init_resources(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: init resource failed with %d\n", __func__, ret);
-		return ret;
+		goto err_runtime_disable;
 	}
 
 	ret = iris_init_core_caps(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: init core caps failed with %d\n", __func__, ret);
-		return ret;
+		goto err_runtime_disable;
 	}
 
 	ret = iris_init_instance_caps(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
 			      "%s: init inst caps failed with %d\n", __func__, ret);
-		return ret;
+		goto err_runtime_disable;
 	}
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
-		return ret;
+		goto err_runtime_disable;
 
 	ret = iris_register_video_device(core);
 	if (ret)
@@ -194,14 +209,29 @@ static int iris_probe(struct platform_device *pdev)
 		goto err_vdev_unreg;
 	}
 
+	ret = iris_pm_get(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret, "%s: failed to get runtime pm\n", __func__);
+		goto err_queue_deinit;
+	}
+
 	ret = iris_core_init(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret, "%s: core init failed\n", __func__);
 		goto err_queue_deinit;
 	}
 
+	ret = iris_pm_put(core, false);
+	if (ret) {
+		pm_runtime_get_noresume(core->dev);
+		dev_err_probe(core->dev, ret, "%s: failed to put runtime pm\n", __func__);
+		goto err_core_deinit;
+	}
+
 	return ret;
 
+err_core_deinit:
+	iris_core_deinit(core);
 err_queue_deinit:
 	hfi_queue_deinit(core->dev, &core->iface_q_table, &core->sfr,
 			 &core->command_queue, &core->message_queue,
@@ -210,10 +240,77 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_runtime_disable:
+	pm_runtime_put_noidle(core->dev);
+	pm_runtime_set_suspended(core->dev);
 
 	return ret;
 }
 
+static int iris_pm_suspend(struct device *dev)
+{
+	struct iris_core *core;
+	int ret;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	core = dev_get_drvdata(dev);
+
+	mutex_lock(&core->lock);
+	if (!core_in_valid_state(core)) {
+		ret = 0;
+		goto unlock;
+	}
+
+	if (!core->power_enabled) {
+		ret = 0;
+		goto unlock;
+	}
+
+	ret = iris_hfi_pm_suspend(core);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+static int iris_pm_resume(struct device *dev)
+{
+	struct iris_core *core;
+	int ret;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	core = dev_get_drvdata(dev);
+
+	mutex_lock(&core->lock);
+	if (!core_in_valid_state(core)) {
+		ret = 0;
+		goto unlock;
+	}
+
+	if (core->power_enabled) {
+		ret = 0;
+		goto unlock;
+	}
+
+	ret = iris_hfi_pm_resume(core);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+static const struct dev_pm_ops iris_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(iris_pm_suspend, iris_pm_resume, NULL)
+};
+
 static const struct of_device_id iris_dt_match[] = {
 	{
 		.compatible = "qcom,sm8550-iris",
@@ -229,6 +326,7 @@ static struct platform_driver qcom_iris_driver = {
 	.driver = {
 		.name = "qcom-iris",
 		.of_match_table = iris_dt_match,
+		.pm = &iris_pm_ops,
 	},
 };
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
index f34434fc..c0878f1 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -10,6 +10,7 @@
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_instance.h"
+#include "iris_power.h"
 #include "iris_vb2.h"
 #include "iris_vdec.h"
 
@@ -111,39 +112,52 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto error;
 	}
 
+	ret = iris_pm_get(inst->core);
+	if (ret)
+		goto error;
+
 	if (!inst->once_per_session_set) {
 		inst->once_per_session_set = true;
 		ret = iris_hfi_session_set_codec(inst);
 		if (ret)
-			goto error;
+			goto err_pm_get;
 
 		ret = iris_hfi_session_set_default_header(inst);
 		if (ret)
-			goto error;
+			goto err_pm_get;
 
 		ret = iris_alloc_and_queue_session_int_bufs(inst, BUF_PERSIST);
 		if (ret)
-			goto error;
+			goto err_pm_get;
 	}
 
+	iris_scale_power(inst);
+
 	if (q->type == INPUT_MPLANE)
 		ret = vdec_streamon_input(inst);
 	else if (q->type == OUTPUT_MPLANE)
 		ret = vdec_streamon_output(inst);
 	if (ret)
-		goto error;
+		goto err_pm_get;
 
 	buf_type = v4l2_type_to_driver(q->type);
 	if (!buf_type) {
 		ret = -EINVAL;
-		goto error;
+		goto err_pm_get;
 	}
 
 	ret = queue_deferred_buffers(inst, buf_type);
 	if (ret)
+		goto err_pm_get;
+
+	ret = iris_pm_put(inst->core, true);
+	if (ret)
 		goto error;
 
 	return ret;
+
+err_pm_get:
+	iris_pm_put(inst->core, false);
 error:
 	iris_inst_change_state(inst, IRIS_INST_ERROR);
 
@@ -165,6 +179,10 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 	if (q->type != INPUT_MPLANE && q->type != OUTPUT_MPLANE)
 		goto error;
 
+	ret = iris_pm_get_put(inst->core);
+	if (ret)
+		goto error;
+
 	if (q->type == INPUT_MPLANE)
 		ret = session_streamoff(inst, INPUT_MPLANE);
 	else if (q->type == OUTPUT_MPLANE)
@@ -181,6 +199,8 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 
 void iris_vb2_buf_queue(struct vb2_buffer *vb2)
 {
+	u64 ktime_ns = ktime_get_ns();
+	struct iris_core *core;
 	struct iris_inst *inst;
 	int ret;
 
@@ -188,11 +208,23 @@ void iris_vb2_buf_queue(struct vb2_buffer *vb2)
 	if (!inst || !inst->core)
 		return;
 
+	core = inst->core;
+
 	if (!vb2->planes[0].bytesused && vb2->type == INPUT_MPLANE) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
+	if (vb2->type == INPUT_MPLANE) {
+		ret = iris_update_input_rate(inst, div_u64(ktime_ns, 1000));
+		if (ret)
+			goto exit;
+	}
+
+	ret = iris_pm_get_put(core);
+	if (ret)
+		goto exit;
+
 	ret = vdec_qbuf(inst, vb2);
 
 exit:
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 7884ba6..371615e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -12,6 +12,7 @@
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
+#include "iris_power.h"
 #include "iris_vdec.h"
 
 #define UNSPECIFIED_COLOR_FORMAT 5
@@ -1069,6 +1070,8 @@ static int process_streamon_input(struct iris_inst *inst)
 	enum iris_inst_sub_state set_sub_state = IRIS_INST_SUB_NONE;
 	int ret;
 
+	iris_scale_power(inst);
+
 	ret = iris_hfi_start(inst, INPUT_MPLANE);
 	if (ret)
 		return ret;
@@ -1150,6 +1153,8 @@ static int process_streamon_output(struct iris_inst *inst)
 	bool drain_pending = false;
 	int ret;
 
+	iris_scale_power(inst);
+
 	if (inst->sub_state & IRIS_INST_SUB_DRC &&
 	    inst->sub_state & IRIS_INST_SUB_DRC_LAST)
 		clear_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_DRC_LAST;
@@ -1287,6 +1292,8 @@ int vdec_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2)
 		return 0;
 	}
 
+	iris_scale_power(inst);
+
 	ret = queue_buffer(inst, buf);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index d37ef04..437d6b4 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -9,12 +9,13 @@
 
 #include "iris_buffer.h"
 #include "iris_common.h"
+#include "iris_ctrls.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_instance.h"
+#include "iris_power.h"
 #include "iris_vdec.h"
 #include "iris_vidc.h"
-#include "iris_ctrls.h"
 #include "iris_vb2.h"
 
 #define VIDC_DRV_NAME "iris_driver"
@@ -162,17 +163,23 @@ int vidc_open(struct file *filp)
 	int i = 0;
 	int ret;
 
-	ret = iris_core_init(core);
+	ret = iris_pm_get(core);
 	if (ret)
 		return ret;
 
+	ret = iris_core_init(core);
+	if (ret)
+		goto fail_pm_put;
+
 	ret = iris_core_init_wait(core);
 	if (ret)
-		return ret;
+		goto fail_pm_put;
 
 	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
-	if (!inst)
-		return -ENOMEM;
+	if (!inst) {
+		ret = -ENOMEM;
+		goto fail_pm_put;
+	}
 
 	inst->core = core;
 	inst->session_id = hash32_ptr(inst);
@@ -198,6 +205,7 @@ int vidc_open(struct file *filp)
 	INIT_LIST_HEAD(&inst->buffers.persist.list);
 	INIT_LIST_HEAD(&inst->buffers.vpss.list);
 	INIT_LIST_HEAD(&inst->caps_list);
+	INIT_LIST_HEAD(&inst->input_timer_list);
 	for (i = 0; i < MAX_SIGNAL; i++)
 		init_completion(&inst->completions[i]);
 
@@ -211,11 +219,16 @@ int vidc_open(struct file *filp)
 	if (ret)
 		goto fail_inst_deinit;
 
+	iris_scale_power(inst);
+
 	ret = iris_hfi_session_open(inst);
 	if (ret) {
 		dev_err(core->dev, "%s: session open failed\n", __func__);
 		goto fail_core_deinit;
 	}
+
+	iris_pm_put(core, true);
+
 	filp->private_data = &inst->fh;
 
 	return 0;
@@ -233,6 +246,8 @@ int vidc_open(struct file *filp)
 	mutex_destroy(&inst->ctx_q_lock);
 	mutex_destroy(&inst->lock);
 	kfree(inst);
+fail_pm_put:
+	iris_pm_put(core, false);
 
 	return ret;
 }
@@ -240,20 +255,25 @@ int vidc_open(struct file *filp)
 int vidc_close(struct file *filp)
 {
 	struct iris_inst *inst;
+	struct iris_core *core;
 
 	inst = get_vidc_inst(filp, NULL);
 	if (!inst)
 		return -EINVAL;
 
+	core = inst->core;
+
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	vdec_inst_deinit(inst);
 	mutex_lock(&inst->lock);
+	iris_pm_get(core);
 	close_session(inst);
 	iris_inst_change_state(inst, IRIS_INST_CLOSE);
 	vidc_vb2_queue_deinit(inst);
 	vidc_v4l2_fh_deinit(inst);
 	iris_destroy_buffers(inst);
 	vidc_remove_session(inst);
+	iris_pm_put(core, false);
 	mutex_unlock(&inst->lock);
 	mutex_destroy(&inst->ctx_q_lock);
 	mutex_destroy(&inst->lock);
@@ -965,11 +985,17 @@ static int vidc_dec_cmd(struct file *filp, void *fh,
 		goto unlock;
 	}
 
+	ret = iris_pm_get(inst->core);
+	if (ret)
+		goto unlock;
+
 	if (dec->cmd == V4L2_DEC_CMD_START)
 		ret = vdec_start_cmd(inst);
 	else if (dec->cmd == V4L2_DEC_CMD_STOP)
 		ret = vdec_stop_cmd(inst);
 
+	iris_pm_put(inst->core, true);
+
 unlock:
 	mutex_unlock(&inst->lock);
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index 22a8f5b..81de610 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -15,6 +15,7 @@ struct iris_core;
 struct iris_inst;
 
 #define HW_RESPONSE_TIMEOUT_VALUE     (1000)
+#define AUTOSUSPEND_DELAY_VALUE       (HW_RESPONSE_TIMEOUT_VALUE + 500)
 
 #define BIT_DEPTH_8 (8 << 16 | 8)
 #define BIT_DEPTH_10 (10 << 16 | 10)
@@ -64,6 +65,11 @@ struct reg_preset_info {
 	u32              mask;
 };
 
+struct iris_core_power {
+	u64 clk_freq;
+	u64 bus_bw;
+};
+
 struct ubwc_config_data {
 	u32	max_channels;
 	u32	mal_length;
@@ -74,6 +80,18 @@ struct ubwc_config_data {
 	u32	bank_spreading;
 };
 
+struct bus_vote_data {
+	u32 color_formats[2];
+	int height, width;
+	u32 fps;
+	u64 bus_bw;
+};
+
+struct iris_inst_power {
+	u64 min_freq;
+	u32 bus_bw;
+};
+
 enum plat_core_cap_type {
 	CORE_CAP_NONE = 0,
 	DEC_CODECS,
diff --git a/drivers/media/platform/qcom/vcodec/iris/resources.c b/drivers/media/platform/qcom/vcodec/iris/resources.c
index 8cfdcd6..c9e3754 100644
--- a/drivers/media/platform/qcom/vcodec/iris/resources.c
+++ b/drivers/media/platform/qcom/vcodec/iris/resources.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -15,6 +17,8 @@
 #include "platform_common.h"
 #include "resources.h"
 
+#define BW_THRESHOLD 50000
+
 static void iris_pd_release(void *res)
 {
 	struct device *pd = (struct device *)res;
@@ -59,6 +63,34 @@ static int iris_opp_dl_get(struct device *dev, struct device *supplier)
 	return ret;
 }
 
+int opp_set_rate(struct iris_core *core, u64 freq)
+{
+	unsigned long opp_freq = 0;
+	struct dev_pm_opp *opp;
+	int ret;
+
+	opp_freq = freq;
+
+	opp = dev_pm_opp_find_freq_ceil(core->dev, &opp_freq);
+	if (IS_ERR(opp)) {
+		opp = dev_pm_opp_find_freq_floor(core->dev, &opp_freq);
+		if (IS_ERR(opp)) {
+			dev_err(core->dev,
+				"unable to find freq %lld in opp table\n", freq);
+			return -EINVAL;
+		}
+	}
+	dev_pm_opp_put(opp);
+
+	ret = dev_pm_opp_set_rate(core->dev, opp_freq);
+	if (ret) {
+		dev_err(core->dev, "failed to set rate\n");
+		return ret;
+	}
+
+	return ret;
+}
+
 static int init_bus(struct iris_core *core)
 {
 	const struct bus_info *bus_tbl;
@@ -135,6 +167,10 @@ static int init_power_domains(struct iris_core *core)
 		}
 	}
 
+	ret = devm_pm_opp_set_clkname(core->dev, "vcodec_core");
+	if (ret)
+		return ret;
+
 	ret = devm_pm_opp_of_add_table(core->dev);
 	if (ret) {
 		dev_err(core->dev, "%s: failed to add opp table\n", __func__);
@@ -144,6 +180,56 @@ static int init_power_domains(struct iris_core *core)
 	return ret;
 }
 
+int enable_power_domains(struct iris_core *core, const char *name)
+{
+	struct power_domain_info *pdinfo = NULL;
+	int ret;
+	u32 i;
+
+	ret = opp_set_rate(core, ULONG_MAX);
+	if (ret)
+		return ret;
+
+	core->pd_count = core->platform_data->pd_tbl_size;
+	for (i = 0; i < (core->pd_count - 1); i++) {
+		pdinfo = &core->power_domain_tbl[i];
+		if (strcmp(pdinfo->name, name))
+			continue;
+		ret = pm_runtime_get_sync(pdinfo->genpd_dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = opp_set_rate(core, ULONG_MAX);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+int disable_power_domains(struct iris_core *core, const char *name)
+{
+	struct power_domain_info *pdinfo = NULL;
+	int ret;
+	u32 i;
+
+	ret = opp_set_rate(core, 0);
+	if (ret)
+		return ret;
+
+	core->pd_count = core->platform_data->pd_tbl_size;
+	for (i = 0; i < (core->pd_count - 1); i++) {
+		pdinfo = &core->power_domain_tbl[i];
+		if (strcmp(pdinfo->name, name))
+			continue;
+		ret = pm_runtime_put_sync(pdinfo->genpd_dev);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int init_clocks(struct iris_core *core)
 {
 	const struct clock_info *clk_tbl;
@@ -204,6 +290,200 @@ static int init_reset_clocks(struct iris_core *core)
 	return 0;
 }
 
+int unvote_buses(struct iris_core *core)
+{
+	struct bus_info *bus = NULL;
+	int ret = 0;
+	u32 i;
+
+	core->power.bus_bw = 0;
+	core->bus_count = core->platform_data->bus_tbl_size;
+
+	for (i = 0; i < core->bus_count; i++) {
+		bus = &core->bus_tbl[i];
+		if (!bus->icc)
+			return -EINVAL;
+
+		ret = icc_set_bw(bus->icc, 0, 0);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int vote_buses(struct iris_core *core, unsigned long bus_bw)
+{
+	unsigned long bw_kbps = 0, bw_prev = 0;
+	struct bus_info *bus = NULL;
+	int ret = 0;
+	u32 i;
+
+	core->bus_count = core->platform_data->bus_tbl_size;
+
+	for (i = 0; i < core->bus_count; i++) {
+		bus = &core->bus_tbl[i];
+		if (bus && bus->icc) {
+			if (!strcmp(bus->name, "iris-ddr")) {
+				bw_kbps = bus_bw;
+				bw_prev = core->power.bus_bw;
+			} else {
+				bw_kbps = bus->bw_max_kbps;
+				bw_prev = core->power.bus_bw ?
+						bw_kbps : 0;
+			}
+
+			bw_kbps = clamp_t(typeof(bw_kbps), bw_kbps,
+					  bus->bw_min_kbps, bus->bw_max_kbps);
+
+			if (abs(bw_kbps - bw_prev) < BW_THRESHOLD && bw_prev)
+				continue;
+
+			ret = icc_set_bw(bus->icc, bw_kbps, 0);
+			if (ret)
+				return ret;
+
+			if (!strcmp(bus->name, "iris-ddr"))
+				core->power.bus_bw = bw_kbps;
+		}
+	}
+
+	return ret;
+}
+
+static int deassert_reset_control(struct iris_core *core)
+{
+	struct reset_info *rcinfo = NULL;
+	int ret = 0;
+	u32 i;
+
+	core->reset_count = core->platform_data->clk_rst_tbl_size;
+
+	for (i = 0; i < (core->reset_count - 1); i++) {
+		rcinfo = &core->reset_tbl[i];
+		ret = reset_control_deassert(rcinfo->rst);
+		if (ret) {
+			dev_err(core->dev, "deassert reset control failed. ret = %d\n", ret);
+			continue;
+		}
+	}
+
+	return ret;
+}
+
+static int assert_reset_control(struct iris_core *core)
+{
+	struct reset_info *rcinfo = NULL;
+	int ret = 0, cnt = 0;
+	u32 i;
+
+	core->reset_count = core->platform_data->clk_rst_tbl_size;
+
+	for (i = 0; i < (core->reset_count - 1); i++) {
+		rcinfo = &core->reset_tbl[i];
+		if (!rcinfo->rst)
+			return -EINVAL;
+
+		ret = reset_control_assert(rcinfo->rst);
+		if (ret) {
+			dev_err(core->dev, "failed to assert reset control %s, ret = %d\n",
+				rcinfo->name, ret);
+			goto deassert_reset_control;
+		}
+		cnt++;
+
+		usleep_range(1000, 1100);
+	}
+
+	return ret;
+deassert_reset_control:
+	for (i = 0; i < cnt; i++) {
+		rcinfo = &core->reset_tbl[i];
+		reset_control_deassert(rcinfo->rst);
+	}
+
+	return ret;
+}
+
+int reset_ahb2axi_bridge(struct iris_core *core)
+{
+	int ret;
+
+	ret = assert_reset_control(core);
+	if (ret)
+		return ret;
+
+	ret = deassert_reset_control(core);
+
+	return ret;
+}
+
+int disable_unprepare_clock(struct iris_core *core, const char *clk_name)
+{
+	struct clock_info *cl;
+	bool found = false;
+	u32 i;
+
+	core->clk_count = core->platform_data->clk_tbl_size;
+
+	for (i = 0; i < core->clk_count; i++) {
+		cl = &core->clock_tbl[i];
+		if (!cl->clk)
+			return -EINVAL;
+
+		if (strcmp(cl->name, clk_name))
+			continue;
+
+		found = true;
+		clk_disable_unprepare(cl->clk);
+		cl->prev = 0;
+		break;
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	return 0;
+}
+
+int prepare_enable_clock(struct iris_core *core, const char *clk_name)
+{
+	struct clock_info *cl;
+	bool found = false;
+	int ret = 0;
+	u32 i;
+
+	core->clk_count = core->platform_data->clk_tbl_size;
+
+	for (i = 0; i < core->clk_count; i++) {
+		cl = &core->clock_tbl[i];
+		if (!cl->clk)
+			return -EINVAL;
+
+		if (strcmp(cl->name, clk_name))
+			continue;
+
+		found = true;
+
+		ret = clk_prepare_enable(cl->clk);
+		if (ret) {
+			dev_err(core->dev, "failed to enable clock %s\n", cl->name);
+			return ret;
+		}
+
+		if (!__clk_is_enabled(cl->clk)) {
+			clk_disable_unprepare(cl->clk);
+			return -EINVAL;
+		}
+		break;
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	return ret;
+}
+
 int init_resources(struct iris_core *core)
 {
 	int ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/resources.h b/drivers/media/platform/qcom/vcodec/iris/resources.h
index d21bcc7e..09857ed 100644
--- a/drivers/media/platform/qcom/vcodec/iris/resources.h
+++ b/drivers/media/platform/qcom/vcodec/iris/resources.h
@@ -31,6 +31,14 @@ struct reset_info {
 	const char		*name;
 };
 
+int enable_power_domains(struct iris_core *core, const char *name);
+int disable_power_domains(struct iris_core *core, const char *name);
+int unvote_buses(struct iris_core *core);
+int vote_buses(struct iris_core *core, unsigned long bus_bw);
+int reset_ahb2axi_bridge(struct iris_core *core);
+int opp_set_rate(struct iris_core *core, u64 freq);
+int disable_unprepare_clock(struct iris_core *core, const char *clk_name);
+int prepare_enable_clock(struct iris_core *core, const char *clk_name);
 int init_resources(struct iris_core *core);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_common.c b/drivers/media/platform/qcom/vcodec/iris/vpu_common.c
index 3282510..8ef1029 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_common.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_common.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/iopoll.h>
+
 #include "vpu_iris3.h"
 #include "iris_core.h"
 #include "iris_helpers.h"
@@ -17,6 +19,9 @@ int write_register(struct iris_core *core, u32 reg, u32 value)
 	if (ret)
 		return ret;
 
+	if (!core->power_enabled)
+		return -EINVAL;
+
 	base_addr = core->reg_base;
 	base_addr += reg;
 	writel_relaxed(value, base_addr);
@@ -27,10 +32,46 @@ int write_register(struct iris_core *core, u32 reg, u32 value)
 	return ret;
 }
 
+int write_register_masked(struct iris_core *core, u32 reg, u32 value, u32 mask)
+{
+	void __iomem *base_addr;
+	u32 prev_val, new_val;
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	if (!core->power_enabled)
+		return -EINVAL;
+
+	base_addr = core->reg_base;
+	base_addr += reg;
+
+	prev_val = readl_relaxed(base_addr);
+	/*
+	 * Memory barrier to ensure register read is correct
+	 */
+	rmb();
+
+	new_val = (prev_val & ~mask) | (value & mask);
+
+	writel_relaxed(new_val, base_addr);
+	/*
+	 * Memory barrier to make sure value is written into the register.
+	 */
+	wmb();
+
+	return ret;
+}
+
 int read_register(struct iris_core *core, u32 reg, u32 *value)
 {
 	void __iomem *base_addr;
 
+	if (!core->power_enabled)
+		return -EINVAL;
+
 	base_addr = core->reg_base;
 
 	*value = readl_relaxed(base_addr + reg);
@@ -41,6 +82,52 @@ int read_register(struct iris_core *core, u32 reg, u32 *value)
 	return 0;
 }
 
+int read_register_with_poll_timeout(struct iris_core *core, u32 reg,
+				    u32 mask, u32 exp_val, u32 sleep_us,
+				    u32 timeout_us)
+{
+	void __iomem *base_addr;
+	u32 val = 0;
+	int ret;
+
+	if (!core->power_enabled)
+		return -EINVAL;
+
+	base_addr = core->reg_base;
+
+	ret = readl_relaxed_poll_timeout(base_addr + reg, val, ((val & mask) == exp_val),
+					 sleep_us, timeout_us);
+	/*
+	 * Memory barrier to make sure value is read correctly from the
+	 * register.
+	 */
+	rmb();
+
+	return ret;
+}
+
+int set_preset_registers(struct iris_core *core)
+{
+	const struct reg_preset_info *reg_prst;
+	unsigned int prst_count;
+	int cnt, ret = 0;
+
+	reg_prst = core->platform_data->reg_prst_tbl;
+	prst_count = core->platform_data->reg_prst_tbl_size;
+
+	if (!reg_prst || !prst_count)
+		return 0;
+
+	for (cnt = 0; cnt < prst_count; cnt++) {
+		ret = write_register_masked(core, reg_prst[cnt].reg,
+					    reg_prst[cnt].value, reg_prst[cnt].mask);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static const struct compat_handle compat_handle[] = {
 	{
 		.compat                  = "qcom,sm8550-iris",
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_common.h b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
index 7fba8c2..aef5606 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
@@ -24,6 +24,9 @@ struct vpu_ops {
 	int (*raise_interrupt)(struct iris_core *core);
 	int (*clear_interrupt)(struct iris_core *core);
 	int (*watchdog)(struct iris_core *core, u32 intr_status);
+	int (*power_on)(struct iris_core *core);
+	int (*power_off)(struct iris_core *core);
+	int (*prepare_pc)(struct iris_core *core);
 };
 
 #define call_session_op(c, op, ...)			\
@@ -32,11 +35,18 @@ struct vpu_ops {
 
 struct vpu_session_ops {
 	int (*int_buf_size)(struct iris_inst *inst, enum iris_buffer_type type);
+	u64 (*calc_freq)(struct iris_inst *inst, u32 data_size);
+	int (*calc_bw)(struct iris_inst *inst, struct bus_vote_data *data);
 };
 
 int init_vpu(struct iris_core *core);
 
 int write_register(struct iris_core *core, u32 reg, u32 value);
+int write_register_masked(struct iris_core *core, u32 reg, u32 value, u32 mask);
 int read_register(struct iris_core *core, u32 reg, u32 *value);
+int read_register_with_poll_timeout(struct iris_core *core, u32 reg,
+				    u32 mask, u32 exp_val, u32 sleep_us,
+				    u32 timeout_us);
+int set_preset_registers(struct iris_core *core);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
index efea5aa..85ed38d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
@@ -5,73 +5,105 @@
 
 #include <linux/delay.h>
 
+#include "iris_hfi.h"
 #include "vpu_iris3.h"
 #include "vpu_iris3_buffer.h"
+#include "vpu_iris3_power.h"
 
 #define VIDEO_ARCH_LX 1
 
-#define CPU_BASE_OFFS_IRIS3     0x000A0000
-
-#define CPU_CS_BASE_OFFS_IRIS3      (CPU_BASE_OFFS_IRIS3)
-#define CPU_IC_BASE_OFFS_IRIS3      (CPU_BASE_OFFS_IRIS3)
-
-#define CPU_CS_VCICMDARG0_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x24)
-#define CPU_CS_VCICMDARG1_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x28)
-
-#define CPU_CS_A2HSOFTINTCLR_IRIS3  (CPU_CS_BASE_OFFS_IRIS3 + 0x1C)
+#define VCODEC_BASE_OFFS_IRIS3                 0x00000000
+#define AON_MVP_NOC_RESET                      0x0001F000
+#define CPU_BASE_OFFS_IRIS3                    0x000A0000
+#define AON_BASE_OFFS                          0x000E0000
+#define CPU_CS_BASE_OFFS_IRIS3                 (CPU_BASE_OFFS_IRIS3)
+#define CPU_IC_BASE_OFFS_IRIS3                 (CPU_BASE_OFFS_IRIS3)
 
+#define CPU_CS_A2HSOFTINTCLR_IRIS3             (CPU_CS_BASE_OFFS_IRIS3 + 0x1C)
+#define CPU_CS_VCICMDARG0_IRIS3                (CPU_CS_BASE_OFFS_IRIS3 + 0x24)
+#define CPU_CS_VCICMDARG1_IRIS3                (CPU_CS_BASE_OFFS_IRIS3 + 0x28)
 /* HFI_CTRL_INIT */
-#define CPU_CS_SCIACMD_IRIS3        (CPU_CS_BASE_OFFS_IRIS3 + 0x48)
-
+#define CPU_CS_SCIACMD_IRIS3                   (CPU_CS_BASE_OFFS_IRIS3 + 0x48)
 /* HFI_CTRL_STATUS */
-#define CPU_CS_SCIACMDARG0_IRIS3    (CPU_CS_BASE_OFFS_IRIS3 + 0x4C)
-#define CPU_CS_SCIACMDARG0_HFI_CTRL_INIT_IDLE_MSG_BMSK_IRIS3     0x40000000
-
-#define CPU_CS_H2XSOFTINTEN_IRIS3   (CPU_CS_BASE_OFFS_IRIS3 + 0x148)
-
-#define CPU_CS_X2RPMH_IRIS3         (CPU_CS_BASE_OFFS_IRIS3 + 0x168)
-
-/* UC_REGION_ADDR */
-#define CPU_CS_SCIBARG1_IRIS3       (CPU_CS_BASE_OFFS_IRIS3 + 0x64)
-
-/* UC_REGION_ADDR */
-#define CPU_CS_SCIBARG2_IRIS3       (CPU_CS_BASE_OFFS_IRIS3 + 0x68)
-
+#define CPU_CS_SCIACMDARG0_IRIS3               (CPU_CS_BASE_OFFS_IRIS3 + 0x4C)
 /* HFI_QTBL_INFO */
-#define CPU_CS_SCIACMDARG1_IRIS3    (CPU_CS_BASE_OFFS_IRIS3 + 0x50)
-
+#define CPU_CS_SCIACMDARG1_IRIS3               (CPU_CS_BASE_OFFS_IRIS3 + 0x50)
 /* HFI_QTBL_ADDR */
-#define CPU_CS_SCIACMDARG2_IRIS3    (CPU_CS_BASE_OFFS_IRIS3 + 0x54)
-
+#define CPU_CS_SCIACMDARG2_IRIS3               (CPU_CS_BASE_OFFS_IRIS3 + 0x54)
 /* SFR_ADDR */
-#define CPU_CS_SCIBCMD_IRIS3        (CPU_CS_BASE_OFFS_IRIS3 + 0x5C)
-
-#define UC_REGION_ADDR_IRIS3        CPU_CS_SCIBARG1_IRIS3
-#define UC_REGION_SIZE_IRIS3	    CPU_CS_SCIBARG2_IRIS3
-
-#define QTBL_INFO_IRIS3             CPU_CS_SCIACMDARG1_IRIS3
-#define QTBL_ADDR_IRIS3             CPU_CS_SCIACMDARG2_IRIS3
-
-#define SFR_ADDR_IRIS3              CPU_CS_SCIBCMD_IRIS3
+#define CPU_CS_SCIBCMD_IRIS3                   (CPU_CS_BASE_OFFS_IRIS3 + 0x5C)
+#define CPU_CS_SCIBCMDARG0_IRIS3               (CPU_CS_BASE_OFFS_IRIS3 + 0x60)
+/* UC_REGION_ADDR */
+#define CPU_CS_SCIBARG1_IRIS3                  (CPU_CS_BASE_OFFS_IRIS3 + 0x64)
+/* UC_REGION_ADDR */
+#define CPU_CS_SCIBARG2_IRIS3                  (CPU_CS_BASE_OFFS_IRIS3 + 0x68)
+#define CPU_CS_H2XSOFTINTEN_IRIS3              (CPU_CS_BASE_OFFS_IRIS3 + 0x148)
+#define CPU_CS_AHB_BRIDGE_SYNC_RESET           (CPU_CS_BASE_OFFS_IRIS3 + 0x160)
+#define CPU_CS_X2RPMH_IRIS3                    (CPU_CS_BASE_OFFS_IRIS3 + 0x168)
 
-#define CTRL_INIT_IRIS3             CPU_CS_SCIACMD_IRIS3
+#define CPU_IC_SOFTINT_IRIS3                   (CPU_IC_BASE_OFFS_IRIS3 + 0x150)
+#define CPU_IC_SOFTINT_H2A_SHFT_IRIS3          0x0
 
-#define CTRL_STATUS_IRIS3           CPU_CS_SCIACMDARG0_IRIS3
-#define CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3	0xfe
-#define CTRL_ERROR_STATUS__M_IRIS3 \
-		CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3
-#define CTRL_INIT_IDLE_MSG_BMSK_IRIS3 \
-		CPU_CS_SCIACMDARG0_HFI_CTRL_INIT_IDLE_MSG_BMSK_IRIS3
+#define CPU_CS_SCIACMDARG0_HFI_CTRL_INIT_IDLE_MSG_BMSK_IRIS3     0x40000000
+#define CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3	     0xfe
+#define CPU_CS_SCIACMDARG0_HFI_CTRL_PC_READY_IRIS3               0x100
+
+#define AON_WRAPPER_MVP_NOC_RESET_REQ          (AON_MVP_NOC_RESET + 0x000)
+#define AON_WRAPPER_MVP_NOC_RESET_ACK          (AON_MVP_NOC_RESET + 0x004)
+
+#define WRAPPER_BASE_OFFS_IRIS3                0x000B0000
+#define WRAPPER_INTR_STATUS_IRIS3              (WRAPPER_BASE_OFFS_IRIS3 + 0x0C)
+#define WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3   0x8
+#define WRAPPER_INTR_STATUS_A2H_BMSK_IRIS3     0x4
+
+#define WRAPPER_INTR_MASK_IRIS3	               (WRAPPER_BASE_OFFS_IRIS3 + 0x10)
+#define WRAPPER_INTR_MASK_A2HWD_BMSK_IRIS3     0x8
+#define WRAPPER_INTR_MASK_A2HCPU_BMSK_IRIS3    0x4
+
+#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL_IRIS3 (WRAPPER_BASE_OFFS_IRIS3 + 0x54)
+#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS_IRIS3  (WRAPPER_BASE_OFFS_IRIS3 + 0x58)
+#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL       (WRAPPER_BASE_OFFS_IRIS3 + 0x5C)
+#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS	       (WRAPPER_BASE_OFFS_IRIS3 + 0x60)
+#define WRAPPER_CORE_POWER_STATUS              (WRAPPER_BASE_OFFS_IRIS3 + 0x80)
+#define WRAPPER_CORE_CLOCK_CONFIG_IRIS3        (WRAPPER_BASE_OFFS_IRIS3 + 0x88)
+
+#define WRAPPER_TZ_BASE_OFFS                   0x000C0000
+#define WRAPPER_TZ_CPU_STATUS                  (WRAPPER_TZ_BASE_OFFS + 0x10)
+#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG        (WRAPPER_TZ_BASE_OFFS + 0x14)
+#define WRAPPER_TZ_QNS4PDXFIFO_RESET           (WRAPPER_TZ_BASE_OFFS + 0x18)
+
+#define CTRL_INIT_IRIS3                        CPU_CS_SCIACMD_IRIS3
+#define CTRL_STATUS_IRIS3                      CPU_CS_SCIACMDARG0_IRIS3
+#define CTRL_ERROR_STATUS__M_IRIS3             CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3
+#define CTRL_INIT_IDLE_MSG_BMSK_IRIS3          CPU_CS_SCIACMDARG0_HFI_CTRL_INIT_IDLE_MSG_BMSK_IRIS3
+#define CTRL_STATUS_PC_READY_IRIS3             CPU_CS_SCIACMDARG0_HFI_CTRL_PC_READY_IRIS3
+
+#define QTBL_INFO_IRIS3                        CPU_CS_SCIACMDARG1_IRIS3
+#define QTBL_ADDR_IRIS3                        CPU_CS_SCIACMDARG2_IRIS3
+#define SFR_ADDR_IRIS3                         CPU_CS_SCIBCMD_IRIS3
+#define UC_REGION_ADDR_IRIS3                   CPU_CS_SCIBARG1_IRIS3
+#define UC_REGION_SIZE_IRIS3                   CPU_CS_SCIBARG2_IRIS3
+
+#define AON_WRAPPER_MVP_NOC_LPI_CONTROL        (AON_BASE_OFFS)
+#define AON_WRAPPER_MVP_NOC_LPI_STATUS         (AON_BASE_OFFS + 0x4)
+
+#define VCODEC_SS_IDLE_STATUSN                 (VCODEC_BASE_OFFS_IRIS3 + 0x70)
+
+static int interrupt_init_iris3(struct iris_core *core)
+{
+	u32 mask_val;
+	int ret;
 
-#define WRAPPER_BASE_OFFS_IRIS3		         0x000B0000
-#define WRAPPER_INTR_STATUS_IRIS3	         (WRAPPER_BASE_OFFS_IRIS3 + 0x0C)
-#define WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3  0x8
-#define WRAPPER_INTR_STATUS_A2H_BMSK_IRIS3	  0x4
+	ret = read_register(core, WRAPPER_INTR_MASK_IRIS3, &mask_val);
+	if (ret)
+		return ret;
 
-#define CPU_IC_SOFTINT_IRIS3        (CPU_IC_BASE_OFFS_IRIS3 + 0x150)
-#define CPU_IC_SOFTINT_H2A_SHFT_IRIS3	0x0
+	mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BMSK_IRIS3 |
+		      WRAPPER_INTR_MASK_A2HCPU_BMSK_IRIS3);
+	ret = write_register(core, WRAPPER_INTR_MASK_IRIS3, mask_val);
 
-#define WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3  0x8
+	return ret;
+}
 
 static int setup_ucregion_memory_map_iris3(struct iris_core *core)
 {
@@ -196,15 +228,335 @@ static int watchdog_iris3(struct iris_core *core, u32 intr_status)
 	return 0;
 }
 
+static bool is_iris3_hw_power_collapsed(struct iris_core *core)
+{
+	u32 value = 0, pwr_status = 0;
+	int ret;
+
+	ret = read_register(core, WRAPPER_CORE_POWER_STATUS, &value);
+	if (ret)
+		return false;
+
+	pwr_status = value & BIT(1);
+
+	return pwr_status ? false : true;
+}
+
+static int power_off_iris3_hardware(struct iris_core *core)
+{
+	u32 value = 0;
+	int ret, i;
+
+	if (is_iris3_hw_power_collapsed(core))
+		goto disable_power;
+
+	dev_err(core->dev, "Video hw is power ON\n");
+
+	ret = read_register(core, WRAPPER_CORE_CLOCK_CONFIG_IRIS3, &value);
+	if (ret)
+		goto disable_power;
+
+	if (value) {
+		ret = write_register(core, WRAPPER_CORE_CLOCK_CONFIG_IRIS3, 0);
+		if (ret)
+			goto disable_power;
+	}
+
+	for (i = 0; i < core->cap[NUM_VPP_PIPE].value; i++) {
+		ret = read_register_with_poll_timeout(core, VCODEC_SS_IDLE_STATUSN + 4 * i,
+						      0x400000, 0x400000, 2000, 20000);
+	}
+
+	ret = write_register(core, AON_WRAPPER_MVP_NOC_RESET_REQ, 0x3);
+	if (ret)
+		goto disable_power;
+
+	ret = read_register_with_poll_timeout(core, AON_WRAPPER_MVP_NOC_RESET_ACK,
+					      0x3, 0x3, 200, 2000);
+	ret = write_register(core, AON_WRAPPER_MVP_NOC_RESET_REQ, 0x0);
+	if (ret)
+		goto disable_power;
+
+	ret = read_register_with_poll_timeout(core, AON_WRAPPER_MVP_NOC_RESET_ACK,
+					      0x3, 0x0, 200, 2000);
+
+	ret = write_register(core, CPU_CS_AHB_BRIDGE_SYNC_RESET, 0x3);
+	if (ret)
+		goto disable_power;
+	ret = write_register(core, CPU_CS_AHB_BRIDGE_SYNC_RESET, 0x2);
+	if (ret)
+		goto disable_power;
+	ret = write_register(core, CPU_CS_AHB_BRIDGE_SYNC_RESET, 0x0);
+	if (ret)
+		goto disable_power;
+
+disable_power:
+	ret = disable_power_domains(core, "vcodec");
+	if (ret) {
+		dev_err(core->dev, "disable power domain vcodec failed\n");
+		ret = 0;
+	}
+
+	disable_unprepare_clock(core, "vcodec_core");
+	if (ret) {
+		dev_err(core->dev, "disable unprepare vcodec_core failed\n");
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int power_off_iris3_controller(struct iris_core *core)
+{
+	int ret;
+
+	ret = write_register(core, CPU_CS_X2RPMH_IRIS3, 0x3);
+	if (ret)
+		goto disable_power;
+
+	ret = write_register_masked(core, AON_WRAPPER_MVP_NOC_LPI_CONTROL,
+				    0x1, BIT(0));
+	if (ret)
+		goto disable_power;
+
+	ret = read_register_with_poll_timeout(core, AON_WRAPPER_MVP_NOC_LPI_STATUS,
+					      0x1, 0x1, 200, 2000);
+
+	ret = write_register_masked(core, WRAPPER_IRIS_CPU_NOC_LPI_CONTROL,
+				    0x1, BIT(0));
+	if (ret)
+		goto disable_power;
+
+	ret = read_register_with_poll_timeout(core, WRAPPER_IRIS_CPU_NOC_LPI_STATUS,
+					      0x1, 0x1, 200, 2000);
+
+	ret = write_register(core, WRAPPER_DEBUG_BRIDGE_LPI_CONTROL_IRIS3, 0x0);
+	if (ret)
+		goto disable_power;
+
+	ret = read_register_with_poll_timeout(core, WRAPPER_DEBUG_BRIDGE_LPI_STATUS_IRIS3,
+					      0xffffffff, 0x0, 200, 2000);
+
+	ret = write_register(core, WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG, 0x3);
+	if (ret)
+		goto disable_power;
+
+	ret = write_register(core, WRAPPER_TZ_QNS4PDXFIFO_RESET, 0x1);
+	if (ret)
+		goto disable_power;
+
+	ret = write_register(core, WRAPPER_TZ_QNS4PDXFIFO_RESET, 0x0);
+	if (ret)
+		goto disable_power;
+
+	ret = write_register(core, WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG, 0x0);
+	if (ret)
+		goto disable_power;
+
+disable_power:
+	disable_unprepare_clock(core, "core_clk");
+	if (ret) {
+		dev_err(core->dev, "disable unprepare core_clk failed\n");
+		ret = 0;
+	}
+
+	/* power down process */
+	ret = disable_power_domains(core, "iris-ctl");
+	if (ret) {
+		dev_err(core->dev, "disable power domain iris-ctl failed\n");
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int power_off_iris3(struct iris_core *core)
+{
+	if (!core->power_enabled)
+		return 0;
+
+	opp_set_rate(core, 0);
+	power_off_iris3_hardware(core);
+	power_off_iris3_controller(core);
+	unvote_buses(core);
+
+	if (!call_vpu_op(core, watchdog, core, core->intr_status))
+		disable_irq_nosync(core->irq);
+
+	core->power_enabled = false;
+
+	return 0;
+}
+
+static int power_on_iris3_controller(struct iris_core *core)
+{
+	int ret;
+
+	ret = enable_power_domains(core, "iris-ctl");
+	if (ret)
+		return ret;
+
+	ret = reset_ahb2axi_bridge(core);
+	if (ret)
+		goto err_disable_power;
+
+	ret = prepare_enable_clock(core, "gcc_video_axi0");
+	if (ret)
+		goto err_disable_power;
+
+	ret = prepare_enable_clock(core, "core_clk");
+	if (ret)
+		goto err_disable_clock;
+
+	return ret;
+
+err_disable_clock:
+	disable_unprepare_clock(core, "gcc_video_axi0");
+err_disable_power:
+	disable_power_domains(core, "iris-ctl");
+
+	return ret;
+}
+
+static int power_on_iris3_hardware(struct iris_core *core)
+{
+	int ret;
+
+	ret = enable_power_domains(core, "vcodec");
+	if (ret)
+		return ret;
+
+	ret = prepare_enable_clock(core, "vcodec_core");
+	if (ret)
+		goto err_disable_power;
+
+	return ret;
+
+err_disable_power:
+	disable_power_domains(core, "vcodec");
+
+	return ret;
+}
+
+static int power_on_iris3(struct iris_core *core)
+{
+	u32 freq = 0;
+	int ret;
+
+	if (core->power_enabled)
+		return 0;
+
+	if (!core_in_valid_state(core))
+		return -EINVAL;
+
+	ret = vote_buses(core, INT_MAX);
+	if (ret)
+		goto err;
+
+	ret = power_on_iris3_controller(core);
+	if (ret)
+		goto err_unvote_bus;
+
+	ret = power_on_iris3_hardware(core);
+	if (ret)
+		goto err_power_off_ctrl;
+
+	core->power_enabled = true;
+
+	freq = core->power.clk_freq ? core->power.clk_freq :
+				      (u32)ULONG_MAX;
+
+	opp_set_rate(core, freq);
+
+	set_preset_registers(core);
+
+	interrupt_init_iris3(core);
+	core->intr_status = 0;
+	enable_irq(core->irq);
+
+	return ret;
+
+err_power_off_ctrl:
+	power_off_iris3_controller(core);
+err_unvote_bus:
+	unvote_buses(core);
+err:
+	core->power_enabled = false;
+
+	return ret;
+}
+
+static int prepare_pc_iris3(struct iris_core *core)
+{
+	u32 wfi_status = 0, idle_status = 0, pc_ready = 0;
+	u32 ctrl_status = 0;
+	int ret;
+
+	ret = read_register(core, CTRL_STATUS_IRIS3, &ctrl_status);
+	if (ret)
+		return ret;
+
+	pc_ready = ctrl_status & CTRL_STATUS_PC_READY_IRIS3;
+	idle_status = ctrl_status & BIT(30);
+
+	if (pc_ready)
+		return 0;
+
+	ret = read_register(core, WRAPPER_TZ_CPU_STATUS, &wfi_status);
+	if (ret)
+		return ret;
+
+	wfi_status &= BIT(0);
+	if (!wfi_status || !idle_status)
+		goto skip_power_off;
+
+	ret = prepare_pc(core);
+	if (ret)
+		goto skip_power_off;
+
+	ret = read_register_with_poll_timeout(core, CTRL_STATUS_IRIS3,
+					      CTRL_STATUS_PC_READY_IRIS3,
+					      CTRL_STATUS_PC_READY_IRIS3, 250, 2500);
+	if (ret)
+		goto skip_power_off;
+
+	ret = read_register_with_poll_timeout(core, WRAPPER_TZ_CPU_STATUS,
+					      BIT(0), 0x1, 250, 2500);
+	if (ret)
+		goto skip_power_off;
+
+	return ret;
+
+skip_power_off:
+	ret = read_register(core, CTRL_STATUS_IRIS3, &ctrl_status);
+	if (ret)
+		return ret;
+
+	ret = read_register(core, WRAPPER_TZ_CPU_STATUS, &wfi_status);
+	if (ret)
+		return ret;
+
+	wfi_status &= BIT(0);
+	dev_err(core->dev, "Skip PC, wfi=%#x, idle=%#x, pcr=%#x, ctrl=%#x)\n",
+		wfi_status, idle_status, pc_ready, ctrl_status);
+
+	return -EAGAIN;
+}
+
 static const struct vpu_ops iris3_ops = {
 	.boot_firmware = boot_firmware_iris3,
 	.raise_interrupt = raise_interrupt_iris3,
 	.clear_interrupt = clear_interrupt_iris3,
 	.watchdog = watchdog_iris3,
+	.power_on = power_on_iris3,
+	.power_off = power_off_iris3,
+	.prepare_pc = prepare_pc_iris3,
 };
 
 static const struct vpu_session_ops iris3_session_ops = {
 	.int_buf_size = iris_int_buf_size_iris3,
+	.calc_freq = iris_calc_freq_iris3,
+	.calc_bw = iris_calc_bw_iris3,
 };
 
 int init_iris3(struct iris_core *core)
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
new file mode 100644
index 0000000..5a02f24
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_core.h"
+#include "iris_instance.h"
+#include "iris_helpers.h"
+#include "platform_common.h"
+#include "vpu_iris3_power.h"
+
+u64 iris_calc_freq_iris3(struct iris_inst *inst, u32 data_size)
+{
+	u64 vsp_cycles = 0, vpp_cycles = 0, fw_cycles = 0;
+	u64 fw_vpp_cycles = 0, bitrate = 0, freq = 0;
+	u32 base_cycles = 0, fps, mbpf;
+	u32 height = 0, width = 0;
+	struct v4l2_format *inp_f;
+	u32 mbs_per_second;
+
+	inp_f = inst->fmt_src;
+	width = max(inp_f->fmt.pix_mp.width, inst->crop.width);
+	height = max(inp_f->fmt.pix_mp.height, inst->crop.height);
+
+	mbpf = NUM_MBS_PER_FRAME(height, width);
+	fps = inst->max_rate;
+	mbs_per_second = mbpf * fps;
+
+	fw_cycles = fps * inst->cap[MB_CYCLES_FW].value;
+	fw_vpp_cycles = fps * inst->cap[MB_CYCLES_FW_VPP].value;
+
+	vpp_cycles = mbs_per_second * inst->cap[MB_CYCLES_VPP].value /
+		inst->cap[PIPE].value;
+	vpp_cycles += max(vpp_cycles / 20, fw_vpp_cycles);
+
+	if (inst->cap[PIPE].value > 1)
+		vpp_cycles += div_u64(vpp_cycles * 59, 1000);
+
+	base_cycles = inst->cap[MB_CYCLES_VSP].value;
+	bitrate = fps * data_size * 8;
+	vsp_cycles = bitrate;
+
+	if (inst->codec == VP9) {
+		vsp_cycles = div_u64(vsp_cycles * 170, 100);
+	} else {
+		base_cycles = 0;
+		vsp_cycles = div_u64(vsp_cycles, 2);
+	}
+	vsp_cycles = div_u64(vsp_cycles * 21, 20);
+
+	if (inst->cap[STAGE].value == STAGE_1)
+		vsp_cycles = vsp_cycles * 3;
+
+	vsp_cycles += mbs_per_second * base_cycles;
+
+	freq = max3(vpp_cycles, vsp_cycles, fw_cycles);
+
+	return freq;
+}
+
+int iris_calc_bw_iris3(struct iris_inst *inst, struct bus_vote_data *data)
+{
+	const struct bw_info *bw_tbl = NULL;
+	unsigned int num_rows = 0;
+	unsigned int i, mbs, mbps;
+	struct iris_core *core;
+
+	if (!data)
+		return 0;
+
+	core = inst->core;
+
+	mbs = (ALIGN(data->height, 16) / 16) * (ALIGN(data->width, 16) / 16);
+	mbps = mbs * data->fps;
+	if (mbps == 0)
+		return 0;
+
+	bw_tbl = core->platform_data->bw_tbl_dec;
+	num_rows = core->platform_data->bw_tbl_dec_size;
+
+	if (!bw_tbl || num_rows == 0)
+		return 0;
+
+	for (i = 0; i < num_rows; i++) {
+		if (i != 0 && mbps > bw_tbl[i].mbs_per_sec)
+			break;
+
+		if (is_10bit_colorformat(data->color_formats[0]))
+			data->bus_bw = bw_tbl[i].bw_ddr_10bit;
+		else
+			data->bus_bw = bw_tbl[i].bw_ddr;
+	}
+
+	dev_info(core->dev, "bus_bw %llu\n", data->bus_bw);
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.h b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.h
new file mode 100644
index 0000000..2a37a9e
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __H_VPU_IRIS3_POWER_H__
+#define __H_VPU_IRIS3_POWER_H__
+
+u64 iris_calc_freq_iris3(struct iris_inst *inst, u32 data_size);
+int iris_calc_bw_iris3(struct iris_inst *inst,
+		       struct bus_vote_data *vote_data);
+
+#endif
-- 
2.7.4


