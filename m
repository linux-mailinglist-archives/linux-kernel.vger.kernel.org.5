Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BEB78BBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjH2AHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjH2AG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:06:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D110DEE;
        Mon, 28 Aug 2023 17:06:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T05l4f010489;
        Tue, 29 Aug 2023 00:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=J7oJQHDD+sNLi3hfl+r+Jl07aEvkXNp2k++7uJYn9TI=;
 b=QcKzWfrQ/OdAa0VoPfz3p/cWoBQNqvbiBV6AFNuSj/SBQ5MmYhieL8dzTLz/P2VB4/ZQ
 2ov1/Dhh94t5geNrpopZTZdXhSe8ghQW/FxRWLpzQrMuxAKAQUNjMqa7EzFzypoRSRNL
 jN7zzn69nhZC0fp2uGMN7vNROZeDXrfC6DTd5GQoomsIzh90EgqOJgkq8tZorkpDNfya
 Hz6UXgl6z8p+TenqS7q5afQjv5DJLMg6i4L4ZBIM8k3sTW2eDMspl7JXnlBMDHXEbdp5
 fEK20BZqDURcmApcNOHPVtEvaRmc5ZXfcB1vjFThEFV/GMUFL29HINvGqruBQmekb2Si cw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss3fr07ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T05kD7027267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:46 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 17:05:46 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Mon, 28 Aug 2023 17:05:16 -0700
Subject: [PATCH RFC v6 10/10] drm/msm/dpu: Add solid fill and pixel source
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230828-solid-fill-v6-10-a820efcce852@quicinc.com>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
In-Reply-To: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     <quic_abhinavk@quicinc.com>, <ppaalanen@gmail.com>,
        <contact@emersion.fr>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693267543; l=975;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=L81L99olUWt0o+jajPCJ1NqBEIDUR3EJafxS7vbxeVs=;
 b=FKTysHNNYwv+cOg3Lg3m5RlOGRptF5yhSP7boCS0N9SfR82LYfvMxOhLJ5aR1lTs/PrABTjAk
 VtJaBhS6msDDLaRD22kTBTGeUbWoeAHk9nuoqL7RY2qBu+DncZolOOe
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _5BrrKKOfm4TOKMr1d6nSmoXqPoIczqC
X-Proofpoint-ORIG-GUID: _5BrrKKOfm4TOKMr1d6nSmoXqPoIczqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_19,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=745
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add solid_fill and pixel_source properties to DPU plane

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 639ecbeeacf8..fda20c5e43b6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1453,6 +1453,8 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
 		DPU_ERROR("failed to install zpos property, rc = %d\n", ret);
 
 	drm_plane_create_alpha_property(plane);
+	drm_plane_create_solid_fill_property(plane);
+	drm_plane_create_pixel_source_property(plane, BIT(DRM_PLANE_PIXEL_SOURCE_SOLID_FILL));
 	drm_plane_create_blend_mode_property(plane,
 			BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 			BIT(DRM_MODE_BLEND_PREMULTI) |

-- 
2.42.0

