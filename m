Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D06809B86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573190AbjLHFIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjLHFH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:07:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A931BE8;
        Thu,  7 Dec 2023 21:07:31 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7MBS5e001067;
        Fri, 8 Dec 2023 05:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=eeLR85+kbSapfFZmfvg0b/rt0VHwpwGwpf53vtFvn/k=;
 b=in0Hcl5NsZoG0FSBDkshKKcrma34rwWfIyh2X6rmI6CAM7eOKeF5ebZG7GKfpl3OR9os
 U2DOYbGop8p1NmoU6g92+L+eGq26klJUW5nYnQs/mO73LudcOCutKPO1MSHOl7qA4feZ
 kr2CBgXJZcJtl+WnCfJOty857Z+WDyMAscV0bnSeqsF2HHyUMoEnU0AB4HlmHMFMZsdY
 rTMBtr27dplB+e+EOGM+ofDaBG5kigdZsJ4h50JTjgIVkBPYnVPxF5Naep3M0XghDkHl
 Hw8ZOXvKzRZ+SWesOrhxm65esOZVdKCq2SowQV4GVm3tsF/5gjD8xDVZozXeM1xjTcPw 1g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utynu40s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 05:07:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B857Ov1014150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Dec 2023 05:07:24 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 21:07:23 -0800
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <quic_parellan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/16] drm/msm/dpu: reserve cdm blocks for writeback in case of YUV output
Date:   Thu, 7 Dec 2023 21:06:39 -0800
Message-ID: <20231208050641.32582-15-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VpWKmM70eAP2ONFA0t3hoLpvOkKM9cux
X-Proofpoint-ORIG-GUID: VpWKmM70eAP2ONFA0t3hoLpvOkKM9cux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=775
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve CDM blocks for writeback if the format of the output fb
is YUV. At the moment, the reservation is done only for writeback
but can easily be extended by relaxing the checks once other
interfaces are ready to output YUV.

changes in v2:
	- use needs_cdm from topology struct
	- drop fb related checks from atomic_mode_set()

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 862912727925..a576e3e62429 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -16,6 +16,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_file.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_framebuffer.h>
 
 #include "msm_drv.h"
 #include "dpu_kms.h"
@@ -583,6 +584,7 @@ static int dpu_encoder_virt_atomic_check(
 	struct drm_display_mode *adj_mode;
 	struct msm_display_topology topology;
 	struct dpu_global_state *global_state;
+	struct drm_framebuffer *fb;
 	struct drm_dsc_config *dsc;
 	int i = 0;
 	int ret = 0;
@@ -623,6 +625,22 @@ static int dpu_encoder_virt_atomic_check(
 
 	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state, dsc);
 
+	/*
+	 * Use CDM only for writeback at the moment as other interfaces cannot handle it.
+	 * if writeback itself cannot handle cdm for some reason it will fail in its atomic_check()
+	 * earlier.
+	 */
+	if (dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) {
+		fb = conn_state->writeback_job->fb;
+
+		if (fb && DPU_FORMAT_IS_YUV(to_dpu_format(msm_framebuffer_format(fb))))
+			topology.needs_cdm = true;
+		if (topology.needs_cdm && !dpu_enc->cur_master->hw_cdm)
+			crtc_state->mode_changed = true;
+		else if (!topology.needs_cdm && dpu_enc->cur_master->hw_cdm)
+			crtc_state->mode_changed = true;
+	}
+
 	/*
 	 * Release and Allocate resources on every modeset
 	 * Dont allocate when active is false.
@@ -1063,6 +1081,15 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 
 	dpu_enc->dsc_mask = dsc_mask;
 
+	if (dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) {
+		struct dpu_hw_blk *hw_cdm = NULL;
+
+		dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
+					      drm_enc->base.id, DPU_HW_BLK_CDM,
+					      &hw_cdm, 1);
+		dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
+	}
+
 	cstate = to_dpu_crtc_state(crtc_state);
 
 	for (i = 0; i < num_lm; i++) {
-- 
2.40.1

