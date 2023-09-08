Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF9798025
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbjIHB04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjIHB0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:26:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C8D1BD7;
        Thu,  7 Sep 2023 18:26:50 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3881CjQv003442;
        Fri, 8 Sep 2023 01:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=mm5+MIf8ec1N7dZcJjcJXyLKRdnr/sX42C3UviovjGU=;
 b=VoubLACptmvylNboROHvqqamgcSo5rULvhhnB5NjQn405gmmaRLDVnRFUeIAAh0dPPeh
 vcUbEJc8MKgKEZli2Ic9XczidKEni2myWcSRkatAKdw8fxj6wtRxH3LCdpt4CJPrMIR5
 iUYrHNCwAnOJrrQAoM27Juq4Ypq+To7D6WvP8rt5sKkXGy6YuMDQxQH8kUexFv38KqRM
 CQ5rU6FlTdv9EuslSpcblwEvwxojFT15DTxz491EfcfE1gw2e5+2lTi33M537WKPSOeL
 PrxZBPzCCJ+Ph9pYAUUjus0mtSYsvzi1ElS0GwzWnfZG2I+H1TzzSyoN6tqVlbRIhstX hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sym368kge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 01:26:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3881QWfM017260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 01:26:32 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 18:26:32 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>
CC:     <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <quic_parellan@quicinc.com>, <nespera@igalia.com>,
        Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow
Date:   Thu, 7 Sep 2023 18:26:16 -0700
Message-ID: <20230908012616.20654-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zL33eVymXT6-HCyZ8F4hRA2DUIUzBuQ1
X-Proofpoint-GUID: zL33eVymXT6-HCyZ8F4hRA2DUIUzBuQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 mlxlogscore=890 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_dpu_plane_calc_bw() uses integer variables to calculate the bandwidth
used during plane bandwidth calculations. However for high resolution
displays this overflows easily and leads to below errors

[dpu error]crtc83 failed performance check -7

Promote the intermediate variables to u64 to avoid overflow.

changes in v2:
	- change to u64 where actually needed in the math

Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling for display")
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/32
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index c2aaaded07ed..98c1b22e9bca 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -119,6 +119,7 @@ static u64 _dpu_plane_calc_bw(const struct dpu_mdss_cfg *catalog,
 	struct dpu_sw_pipe_cfg *pipe_cfg)
 {
 	int src_width, src_height, dst_height, fps;
+	u64 plane_pixel_rate, plane_bit_rate;
 	u64 plane_prefill_bw;
 	u64 plane_bw;
 	u32 hw_latency_lines;
@@ -136,13 +137,12 @@ static u64 _dpu_plane_calc_bw(const struct dpu_mdss_cfg *catalog,
 	scale_factor = src_height > dst_height ?
 		mult_frac(src_height, 1, dst_height) : 1;
 
-	plane_bw =
-		src_width * mode->vtotal * fps * fmt->bpp *
-		scale_factor;
+	plane_pixel_rate = src_width * mode->vtotal * fps;
+	plane_bit_rate = plane_pixel_rate * fmt->bpp;
 
-	plane_prefill_bw =
-		src_width * hw_latency_lines * fps * fmt->bpp *
-		scale_factor * mode->vtotal;
+	plane_bw = plane_bit_rate * scale_factor;
+
+	plane_prefill_bw = plane_bw * hw_latency_lines;
 
 	if ((vbp+vpw) > hw_latency_lines)
 		do_div(plane_prefill_bw, (vbp+vpw));
-- 
2.40.1

