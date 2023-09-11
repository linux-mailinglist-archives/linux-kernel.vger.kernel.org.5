Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CA179C125
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjILAcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjILAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:32:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99EF76C7;
        Mon, 11 Sep 2023 17:16:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BLVKsp005455;
        Mon, 11 Sep 2023 22:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=yez8gB2HyVf32KW7kcUHDh1APonpOcYVEipEXie3wrc=;
 b=nm5q5ErrGcw69lKzMr2/ugzxDFpbaWyNB4TqFiGphc9g4+mVMDi9R/WTlJC9f1fJHQU1
 OI9wTivAYIT7NkvECkJgXBVn7blkV4R+V/lAgRO0oj6rm0lvBRs2dlQlOZ9bcCWhk82M
 2EH2Gb/8wgciSqDV3NOMy4oloMcLv0fHHpzAlj26DEnMv+AWfbVedRUNqZhiEejIlE9n
 IYFliwv6wo82G62FX8/GBrsFqSUdikLg5pTVTuRVG9bmVAUnGLpB6g16fKYuPVCpDpqH
 i+EkT121fWAOkfSBQYxI/zhKRJPa9qdEBPm1OMQzT9LrSdPYGY3h+hkQmCW9wkNe+0ib pg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1u3yt9aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:16:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BMGmhf008181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:16:48 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 15:16:48 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <quic_parellan@quicinc.com>, <nespera@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] drm/msm/dpu: try multirect based on mdp clock limits
Date:   Mon, 11 Sep 2023 15:16:27 -0700
Message-ID: <20230911221627.9569-2-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230911221627.9569-1-quic_abhinavk@quicinc.com>
References: <20230911221627.9569-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: To3ih1vviybwnSeFpHPx_L-WU_Te1E4Z
X-Proofpoint-ORIG-GUID: To3ih1vviybwnSeFpHPx_L-WU_Te1E4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_17,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=701 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's certainly possible that for large resolutions a single DPU SSPP
cannot process the image without exceeding the MDP clock limits but
it can still process it in multirect mode because the source rectangles
will get divided and can fall within the MDP clock limits.

If the SSPP cannot process the image even in multirect mode, then it
will be rejected in dpu_plane_atomic_check_pipe().

Hence try using multirect for resolutions which cannot be processed
by a single SSPP without exceeding the MDP clock limits.

changes in v2:
	- use crtc_state's adjusted_mode instead of mode
	- fix the UBWC condition to check maxlinewidth

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 0be195f9149c..bf063e21e3dd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -792,6 +792,8 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 										 plane);
 	int ret = 0, min_scale;
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
+	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
+	u64 max_mdp_clk_rate = kms->perf.max_core_clk_rate;
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
 	struct dpu_sw_pipe *pipe = &pstate->pipe;
 	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
@@ -860,14 +862,16 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 
 	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
-	if (drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) {
+	if ((drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) ||
+	     _dpu_plane_calc_clk(&crtc_state->adjusted_mode, pipe_cfg) > max_mdp_clk_rate) {
 		/*
 		 * In parallel multirect case only the half of the usual width
 		 * is supported for tiled formats. If we are here, we know that
 		 * full width is more than max_linewidth, thus each rect is
 		 * wider than allowed.
 		 */
-		if (DPU_FORMAT_IS_UBWC(fmt)) {
+		if (DPU_FORMAT_IS_UBWC(fmt) &&
+		    drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) {
 			DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u, tiled format\n",
 					DRM_RECT_ARG(&pipe_cfg->src_rect), max_linewidth);
 			return -E2BIG;
-- 
2.40.1

