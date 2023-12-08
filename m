Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6837809B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573179AbjLHFHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjLHFH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:07:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C679C1985;
        Thu,  7 Dec 2023 21:07:22 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B83ihCV027334;
        Fri, 8 Dec 2023 05:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ILRUVSzTnfb8eMFGGZcyWRL+zvxEFuhSba8P7jnspgg=;
 b=bhdi2ZtiNl03lNvQd+/MMiETn3JtflBq2e93nXkLTwPTTGqDuVOQMoubhQBfvSzO6d3Y
 YqqhBgSScNa5YwCO9NTFT5v2zCau1Y5kTIxZR5PTj0XXbYyrl4V/WAdcd2Bxm6JUyKuG
 Au7DGp6qQG9dDls3xdcnN+juYTs8EvAlbkDs9ccgSSa7rnVgLcizS3GGOCgUsiU2TKDv
 KNfV65qDP6pJlDShb5isl0tAr7ZpUg7LVGrBBveWjJqewRFyP3P//aWFjwuT5CJ/DI5z
 XfS0rfGvEwcwKBImXv8fGNlS8pMAOYqTIRrudKTJYHodDm+8ybkpYKipZctnbUAARP2w NQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu8p0b0bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 05:07:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B857FQl007422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Dec 2023 05:07:15 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 21:07:15 -0800
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
Subject: [PATCH v2 09/16] drm/msm/dpu: add support to allocate CDM from RM
Date:   Thu, 7 Dec 2023 21:06:34 -0800
Message-ID: <20231208050641.32582-10-quic_abhinavk@quicinc.com>
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
X-Proofpoint-GUID: BflWKOiBKmizOOAfkHISkakpk3lpQ92A
X-Proofpoint-ORIG-GUID: BflWKOiBKmizOOAfkHISkakpk3lpQ92A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Even though there is usually only one CDM block, it can be
used by either HDMI, DisplayPort OR Writeback interfaces.

Hence its allocation needs to be tracked properly by the
resource manager to ensure appropriate availability of the
block.

changes in v2:
	- move needs_cdm to topology struct

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 38 +++++++++++++++++++--
 drivers/gpu/drm/msm/msm_drv.h               |  2 ++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 9db4cf61bd29..5df545904057 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -98,6 +98,7 @@ enum dpu_hw_blk_type {
 	DPU_HW_BLK_DSPP,
 	DPU_HW_BLK_MERGE_3D,
 	DPU_HW_BLK_DSC,
+	DPU_HW_BLK_CDM,
 	DPU_HW_BLK_MAX,
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index df6271017b80..a0cd36e45a01 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -135,6 +135,7 @@ struct dpu_global_state {
 	uint32_t ctl_to_enc_id[CTL_MAX - CTL_0];
 	uint32_t dspp_to_enc_id[DSPP_MAX - DSPP_0];
 	uint32_t dsc_to_enc_id[DSC_MAX - DSC_0];
+	uint32_t cdm_to_enc_id;
 };
 
 struct dpu_global_state
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 7ed476b96304..b58a9c2ae326 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -435,6 +435,26 @@ static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
 	return 0;
 }
 
+static int _dpu_rm_reserve_cdm(struct dpu_rm *rm,
+			       struct dpu_global_state *global_state,
+			       struct drm_encoder *enc)
+{
+	/* try allocating only one CDM block */
+	if (!rm->cdm_blk) {
+		DPU_ERROR("CDM block does not exist\n");
+		return -EIO;
+	}
+
+	if (global_state->cdm_to_enc_id) {
+		DPU_ERROR("CDM_0 is already allocated\n");
+		return -EIO;
+	}
+
+	global_state->cdm_to_enc_id = enc->base.id;
+
+	return 0;
+}
+
 static int _dpu_rm_make_reservation(
 		struct dpu_rm *rm,
 		struct dpu_global_state *global_state,
@@ -460,6 +480,14 @@ static int _dpu_rm_make_reservation(
 	if (ret)
 		return ret;
 
+	if (reqs->topology.needs_cdm) {
+		ret = _dpu_rm_reserve_cdm(rm, global_state, enc);
+		if (ret) {
+			DPU_ERROR("unable to find CDM blk\n");
+			return ret;
+		}
+	}
+
 	return ret;
 }
 
@@ -470,9 +498,9 @@ static int _dpu_rm_populate_requirements(
 {
 	reqs->topology = req_topology;
 
-	DRM_DEBUG_KMS("num_lm: %d num_dsc: %d num_intf: %d\n",
+	DRM_DEBUG_KMS("num_lm: %d num_dsc: %d num_intf: %d cdm: %d\n",
 		      reqs->topology.num_lm, reqs->topology.num_dsc,
-		      reqs->topology.num_intf);
+		      reqs->topology.num_intf, reqs->topology.needs_cdm);
 
 	return 0;
 }
@@ -501,6 +529,7 @@ void dpu_rm_release(struct dpu_global_state *global_state,
 		ARRAY_SIZE(global_state->dsc_to_enc_id), enc->base.id);
 	_dpu_rm_clear_mapping(global_state->dspp_to_enc_id,
 		ARRAY_SIZE(global_state->dspp_to_enc_id), enc->base.id);
+	_dpu_rm_clear_mapping(&global_state->cdm_to_enc_id, 1, enc->base.id);
 }
 
 int dpu_rm_reserve(
@@ -574,6 +603,11 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
 		hw_to_enc_id = global_state->dsc_to_enc_id;
 		max_blks = ARRAY_SIZE(rm->dsc_blks);
 		break;
+	case DPU_HW_BLK_CDM:
+		hw_blks = &rm->cdm_blk;
+		hw_to_enc_id = &global_state->cdm_to_enc_id;
+		max_blks = 1;
+		break;
 	default:
 		DPU_ERROR("blk type %d not managed by rm\n", type);
 		return 0;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index a205127ccc93..1ebad634781c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -92,12 +92,14 @@ enum msm_event_wait {
  * @num_intf:     number of interfaces the panel is mounted on
  * @num_dspp:     number of dspp blocks used
  * @num_dsc:      number of Display Stream Compression (DSC) blocks used
+ * @needs_cdm:    indicates whether cdm block is needed for this display topology
  */
 struct msm_display_topology {
 	u32 num_lm;
 	u32 num_intf;
 	u32 num_dspp;
 	u32 num_dsc;
+	bool needs_cdm;
 };
 
 /* Commit/Event thread specific structure */
-- 
2.40.1

