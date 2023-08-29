Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C978BBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjH2AHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjH2AG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:06:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E5132;
        Mon, 28 Aug 2023 17:06:22 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SNpqkF028335;
        Tue, 29 Aug 2023 00:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=frEd2qAKB+tPEdB5Udic2is+LAWhdUmU9wggUYz/uig=;
 b=A8+qjbD0OW0wTkDB2cuOSaRrWxUzfWXhdb6A3RwXTuiZo56tK5HRzaB1//fSJj5hqokW
 YdcpHfgAe7cagdmlPL9pRsmRIQLCSpzpl7wR3s/t0kGvkLD0vWk4FvXb/180eIGz462k
 ImUEgeAHSq64FAR5ZKmVpucgxz7aj656RPIVZCZJNzms8jQE9SPN8RdqrC92zEaDkIL7
 mN3h6fa+aEBxJyyp9tpkRmrmjezWMcCMqUkLzRGcEwgoHlpnD4BbUBYDFPy+hfABAcue
 xGBQ5yNOBfVCDVDZoG+ZoM6trtK3XyWtwLDTvrd+qSgTTHAdzYlpZ7veDYOSpdqtya3g XQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss2xb88yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:45 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T05iLM032272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:44 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 17:05:44 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Mon, 28 Aug 2023 17:05:11 -0700
Subject: [PATCH RFC v6 05/10] drm/atomic: Add solid fill data to plane
 state dump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230828-solid-fill-v6-5-a820efcce852@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693267543; l=2463;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=B6+VSz0hVAjv3UX/8u0N4AzCGT2usoyESZ+PILuKGDQ=;
 b=pOarswNm8P1NKFdDIOD25sPBIKtktJaazyPsowdeEVe7RecvX8xzEv5G+cUAAsffxv13WXzXM
 qw6a90FbnPNCLdcxX9+joXF+Q4jn7kPVNa88E/RmucgdAvIRl2bDAaz
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F7tMKGU3tGER_oSE-bWy4hbPOl57fibD
X-Proofpoint-GUID: F7tMKGU3tGER_oSE-bWy4hbPOl57fibD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_19,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=629 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add solid_fill property data to the atomic plane state dump.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_atomic.c | 4 ++++
 drivers/gpu/drm/drm_plane.c  | 8 ++++++++
 include/drm/drm_plane.h      | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index bcecb64ccfad..3cb599b3304a 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -717,6 +717,10 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 	drm_printf(p, "\tfb=%u\n", state->fb ? state->fb->base.id : 0);
 	if (state->fb)
 		drm_framebuffer_print_info(p, 2, state->fb);
+	drm_printf(p, "\tsolid_fill=%u\n",
+			state->solid_fill_blob ? state->solid_fill_blob->base.id : 0);
+	if (state->solid_fill_blob)
+		drm_plane_solid_fill_print_info(p, 2, state);
 	drm_printf(p, "\tcrtc-pos=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&dest));
 	drm_printf(p, "\tsrc-pos=" DRM_RECT_FP_FMT "\n", DRM_RECT_FP_ARG(&src));
 	drm_printf(p, "\trotation=%x\n", state->rotation);
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 559d101162ba..6244b622a21a 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1495,6 +1495,14 @@ __drm_plane_get_damage_clips(const struct drm_plane_state *state)
 					state->fb_damage_clips->data : NULL);
 }
 
+void drm_plane_solid_fill_print_info(struct drm_printer *p, unsigned int indent,
+				     const struct drm_plane_state *state)
+{
+	drm_printf_indent(p, indent, "r=0x%x\n", state->solid_fill.r);
+	drm_printf_indent(p, indent, "g=0x%x\n", state->solid_fill.g);
+	drm_printf_indent(p, indent, "b=0x%x\n", state->solid_fill.b);
+}
+
 /**
  * drm_plane_get_damage_clips - Returns damage clips.
  * @state: Plane state.
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 49995c4be2ab..a58f84b6bd5e 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -1001,6 +1001,9 @@ drm_plane_get_damage_clips_count(const struct drm_plane_state *state);
 struct drm_mode_rect *
 drm_plane_get_damage_clips(const struct drm_plane_state *state);
 
+void drm_plane_solid_fill_print_info(struct drm_printer *p, unsigned int indent,
+				     const struct drm_plane_state *state);
+
 int drm_plane_create_scaling_filter_property(struct drm_plane *plane,
 					     unsigned int supported_filters);
 

-- 
2.42.0

