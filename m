Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3185C7990F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245583AbjIHUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbjIHUZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:25:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA949C;
        Fri,  8 Sep 2023 13:25:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Cf1dQ026960;
        Fri, 8 Sep 2023 18:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VQa+l5fjSpshTSgHvyDB3UkN94/rJpy8jWTI3ZYkuBg=;
 b=OKRy8SdWNg78t4ZJiaWublCuoLyCFzPl+fyvXDVJ3VgD5EvzoNIFRMaz9QovhnnLQaw+
 TiXODJObVN1Oa/GphqJzAwckJGSVUMkdLRBe1mN0G7UIrBnGuq2DeAqYN7HUshaDdvVO
 7yPSEWAW9vvsB/nu0R3TLmHTev45JiU4tpNvKIFOgANWPizFHvvBdHebX53vWW2kWMk8
 OunPHkS0GHVle5R3v9L9OHoyUpOoEfcOAt3SR0kNuYsQrus33icxtkU0zQrv1HiN5nlP
 D/TeP+SxXBlZCYp0FHmZpFx3bK7ML2h+KM0LOkwhM3zSOgmpFcwwQCy/91nL2P3mBr0W oQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syu01229s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 18:54:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388IsvTU012976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 18:54:57 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 8 Sep 2023 11:54:57 -0700
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
Subject: [PATCH 2/2] drm/msm/dpu: try multirect based on mdp clock limits
Date:   Fri, 8 Sep 2023 11:54:27 -0700
Message-ID: <20230908185427.29026-2-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908185427.29026-1-quic_abhinavk@quicinc.com>
References: <20230908185427.29026-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8WmarzNsTZcJqPehkHvTiXOyRIDRCLU0
X-Proofpoint-GUID: 8WmarzNsTZcJqPehkHvTiXOyRIDRCLU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=718 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080173
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 62dd9f9b4dce..85072328cd53 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -792,6 +792,7 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 										 plane);
 	int ret = 0, min_scale;
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
+	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
 	struct dpu_sw_pipe *pipe = &pstate->pipe;
 	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
@@ -860,7 +861,8 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 
 	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
-	if (drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) {
+	if ((drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) ||
+	     _dpu_plane_calc_clk(&crtc_state->mode, pipe_cfg) > kms->perf.max_core_clk_rate) {
 		/*
 		 * In parallel multirect case only the half of the usual width
 		 * is supported for tiled formats. If we are here, we know that
-- 
2.40.1

