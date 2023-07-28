Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9062766E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjG1N2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjG1N2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:28:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617949EA;
        Fri, 28 Jul 2023 06:27:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S9DdlL004300;
        Fri, 28 Jul 2023 13:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+ZaDGwVUfhnyAOVh0gNt/Fg30/Df8MffdW8wq9Xy488=;
 b=Zj2h3PGEunE1lV8/A/X3R7+SThqj27zK+cZ3IPuvVOoj4gxv9yLAlJEQXT7yZ+Uy/4ZP
 SKsd6m+3/Qe2g2e19Y5v6ZOaUd3cKzdOdynjs6gZPk0fkW2sxb76JIMu1HIf+8Jd9SAT
 hqHNKVyfgEGVl4oFHsog4EXxO6SGd7+GA3kvDJQtXW18uDXkaf5iknYqo6XZ85EfJWIv
 0oMjvnG9nYPfqEU2FGkRN/tIVqnSPNKDinhwVtKhxIdzG825ACNghiXJ0gDGmgosypAr
 zc6xIWhNmzqTb9/cFuCCfM72dNWrIVoeoW7r744Xxwyc3qN/QVArtjfry9XqBuKW24mK eg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s403vhk4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQUF8003910
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:30 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:26:26 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 23/33] iris: vidc: add PIL functionality for video firmware
Date:   Fri, 28 Jul 2023 18:53:34 +0530
Message-ID: <1690550624-14642-24-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-GUID: 21EPb-dA_DQNaRBeUp6pY0Az-bCLsUjK
X-Proofpoint-ORIG-GUID: 21EPb-dA_DQNaRBeUp6pY0Az-bCLsUjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Here is the implementation of loading/unloading fw in memory
via mdt loader. This also implements fw suspend and resume.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../media/platform/qcom/iris/vidc/inc/firmware.h   |  18 ++
 .../media/platform/qcom/iris/vidc/src/firmware.c   | 294 +++++++++++++++++++++
 2 files changed, 312 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/firmware.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/firmware.c

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/firmware.h b/drivers/media/platform/qcom/iris/vidc/inc/firmware.h
new file mode 100644
index 0000000..bd52180
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/firmware.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _MSM_VIDC_FIRMWARE_H_
+#define _MSM_VIDC_FIRMWARE_H_
+
+struct msm_vidc_core;
+
+int fw_load(struct msm_vidc_core *core);
+int fw_unload(struct msm_vidc_core *core);
+int fw_suspend(struct msm_vidc_core *core);
+int fw_resume(struct msm_vidc_core *core);
+void fw_coredump(struct msm_vidc_core *core);
+
+#endif
diff --git a/drivers/media/platform/qcom/iris/vidc/src/firmware.c b/drivers/media/platform/qcom/iris/vidc/src/firmware.c
new file mode 100644
index 0000000..f420096
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/src/firmware.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/firmware.h>
+#include <linux/list.h>
+#include <linux/of_address.h>
+#include <linux/devcoredump.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/types.h>
+
+#include "firmware.h"
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_platform.h"
+
+#define MAX_FIRMWARE_NAME_SIZE	128
+
+struct tzbsp_memprot {
+	u32 cp_start;
+	u32 cp_size;
+	u32 cp_nonpixel_start;
+	u32 cp_nonpixel_size;
+};
+
+enum tzbsp_video_state {
+	TZBSP_VIDEO_STATE_SUSPEND = 0,
+	TZBSP_VIDEO_STATE_RESUME = 1,
+	TZBSP_VIDEO_STATE_RESTORE_THRESHOLD = 2,
+};
+
+static int protect_cp_mem(struct msm_vidc_core *core)
+{
+	struct tzbsp_memprot memprot;
+	int rc = 0;
+	struct context_bank_info *cb;
+
+	memprot.cp_start = 0x0;
+	memprot.cp_size = 0x0;
+	memprot.cp_nonpixel_start = 0x0;
+	memprot.cp_nonpixel_size = 0x0;
+
+	venus_hfi_for_each_context_bank(core, cb) {
+		if (cb->region == MSM_VIDC_NON_SECURE) {
+			memprot.cp_size = cb->addr_range.start;
+
+			d_vpr_h("%s: memprot.cp_size: %#x\n",
+				__func__, memprot.cp_size);
+		}
+
+		if (cb->region == MSM_VIDC_SECURE_NONPIXEL) {
+			memprot.cp_nonpixel_start = cb->addr_range.start;
+			memprot.cp_nonpixel_size = cb->addr_range.size;
+
+			d_vpr_h("%s: cp_nonpixel_start: %#x size: %#x\n",
+				__func__, memprot.cp_nonpixel_start,
+				memprot.cp_nonpixel_size);
+		}
+	}
+
+	rc = qcom_scm_mem_protect_video_var(memprot.cp_start,
+					    memprot.cp_size,
+					    memprot.cp_nonpixel_start,
+					    memprot.cp_nonpixel_size);
+	if (rc)
+		d_vpr_e("Failed to protect memory(%d)\n", rc);
+
+	return rc;
+}
+
+static int __load_fw_to_memory(struct platform_device *pdev,
+			       const char *fw_name)
+{
+	int rc = 0;
+	const struct firmware *firmware = NULL;
+	struct msm_vidc_core *core;
+	char firmware_name[MAX_FIRMWARE_NAME_SIZE] = { 0 };
+	struct device_node *node = NULL;
+	struct resource res = { 0 };
+	phys_addr_t phys = 0;
+	size_t res_size = 0;
+	ssize_t fw_size = 0;
+	void *virt = NULL;
+	int pas_id = 0;
+
+	if (!fw_name || !(*fw_name) || !pdev) {
+		d_vpr_e("%s: Invalid inputs\n", __func__);
+		return -EINVAL;
+	}
+	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4) {
+		d_vpr_e("%s: Invalid fw name\n", __func__);
+		return -EINVAL;
+	}
+
+	core = dev_get_drvdata(&pdev->dev);
+	if (!core) {
+		d_vpr_e("%s: core not found in device %s",
+			__func__, dev_name(&pdev->dev));
+		return -EINVAL;
+	}
+	scnprintf(firmware_name, ARRAY_SIZE(firmware_name), "%s.mbn", fw_name);
+
+	pas_id = core->platform->data.pas_id;
+
+	node = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
+	if (!node) {
+		d_vpr_e("%s: failed to read \"memory-region\"\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	if (rc) {
+		d_vpr_e("%s: failed to read \"memory-region\", error %d\n",
+			__func__, rc);
+		goto exit;
+	}
+	phys = res.start;
+	res_size = (size_t)resource_size(&res);
+
+	rc = request_firmware(&firmware, firmware_name, &pdev->dev);
+	if (rc) {
+		d_vpr_e("%s: failed to request fw \"%s\", error %d\n",
+			__func__, firmware_name, rc);
+		goto exit;
+	}
+
+	fw_size = qcom_mdt_get_size(firmware);
+	if (fw_size < 0 || res_size < (size_t)fw_size) {
+		rc = -EINVAL;
+		d_vpr_e("%s: out of bound fw image fw size: %ld, res_size: %lu",
+			__func__, fw_size, res_size);
+		goto exit;
+	}
+
+	virt = memremap(phys, res_size, MEMREMAP_WC);
+	if (!virt) {
+		d_vpr_e("%s: failed to remap fw memory phys %pa[p]\n",
+			__func__, &phys);
+		return -ENOMEM;
+	}
+
+	/* prevent system suspend during fw_load */
+	pm_stay_awake(pdev->dev.parent);
+	rc = qcom_mdt_load(&pdev->dev, firmware, firmware_name,
+			   pas_id, virt, phys, res_size, NULL);
+	pm_relax(pdev->dev.parent);
+	if (rc) {
+		d_vpr_e("%s: error %d loading fw \"%s\"\n",
+			__func__, rc, firmware_name);
+		goto exit;
+	}
+	rc = qcom_scm_pas_auth_and_reset(pas_id);
+	if (rc) {
+		d_vpr_e("%s: error %d authenticating fw \"%s\"\n",
+			__func__, rc, firmware_name);
+		goto exit;
+	}
+
+	memunmap(virt);
+	release_firmware(firmware);
+	d_vpr_h("%s: firmware \"%s\" loaded successfully\n",
+		__func__, firmware_name);
+
+	return pas_id;
+
+exit:
+	if (virt)
+		memunmap(virt);
+	if (firmware)
+		release_firmware(firmware);
+
+	return rc;
+}
+
+int fw_load(struct msm_vidc_core *core)
+{
+	int rc;
+
+	if (!core->resource->fw_cookie) {
+		core->resource->fw_cookie = __load_fw_to_memory(core->pdev,
+								core->platform->data.fwname);
+		if (core->resource->fw_cookie <= 0) {
+			d_vpr_e("%s: firmware download failed %d\n",
+				__func__, core->resource->fw_cookie);
+			core->resource->fw_cookie = 0;
+			return -ENOMEM;
+		}
+	}
+
+	rc = protect_cp_mem(core);
+	if (rc) {
+		d_vpr_e("%s: protect memory failed\n", __func__);
+		goto fail_protect_mem;
+	}
+
+	return rc;
+
+fail_protect_mem:
+	if (core->resource->fw_cookie)
+		qcom_scm_pas_shutdown(core->resource->fw_cookie);
+	core->resource->fw_cookie = 0;
+	return rc;
+}
+
+int fw_unload(struct msm_vidc_core *core)
+{
+	int ret;
+
+	if (!core->resource->fw_cookie)
+		return -EINVAL;
+
+	ret = qcom_scm_pas_shutdown(core->resource->fw_cookie);
+	if (ret)
+		d_vpr_e("Firmware unload failed rc=%d\n", ret);
+
+	core->resource->fw_cookie = 0;
+
+	return ret;
+}
+
+int fw_suspend(struct msm_vidc_core *core)
+{
+	return qcom_scm_set_remote_state(TZBSP_VIDEO_STATE_SUSPEND, 0);
+}
+
+int fw_resume(struct msm_vidc_core *core)
+{
+	return qcom_scm_set_remote_state(TZBSP_VIDEO_STATE_RESUME, 0);
+}
+
+void fw_coredump(struct msm_vidc_core *core)
+{
+	int rc = 0;
+	struct platform_device *pdev;
+	struct device_node *node = NULL;
+	struct resource res = {0};
+	phys_addr_t mem_phys = 0;
+	size_t res_size = 0;
+	void *mem_va = NULL;
+	char *data = NULL, *dump = NULL;
+	u64 total_size;
+
+	pdev = core->pdev;
+
+	node = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
+	if (!node) {
+		d_vpr_e("%s: DT error getting \"memory-region\" property\n",
+			__func__);
+		return;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	if (rc) {
+		d_vpr_e("%s: error %d while getting \"memory-region\" resource\n",
+			__func__, rc);
+		return;
+	}
+
+	mem_phys = res.start;
+	res_size = (size_t)resource_size(&res);
+
+	mem_va = memremap(mem_phys, res_size, MEMREMAP_WC);
+	if (!mem_va) {
+		d_vpr_e("%s: unable to remap firmware memory\n", __func__);
+		return;
+	}
+	total_size = res_size + TOTAL_QSIZE + ALIGNED_SFR_SIZE;
+
+	data = vmalloc(total_size);
+	if (!data) {
+		memunmap(mem_va);
+		return;
+	}
+	dump = data;
+
+	/* copy firmware dump */
+	memcpy(data, mem_va, res_size);
+	memunmap(mem_va);
+
+	/* copy queues(cmd, msg, dbg) dump(along with headers) */
+	data += res_size;
+	memcpy(data, (char *)core->iface_q_table.align_virtual_addr, TOTAL_QSIZE);
+
+	/* copy sfr dump */
+	data += TOTAL_QSIZE;
+	memcpy(data, (char *)core->sfr.align_virtual_addr, ALIGNED_SFR_SIZE);
+
+	dev_coredumpv(&pdev->dev, dump, total_size, GFP_KERNEL);
+}
-- 
2.7.4

