Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7433478BBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjH2AGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjH2AGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:06:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C479F132;
        Mon, 28 Aug 2023 17:06:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SNvXiE017471;
        Tue, 29 Aug 2023 00:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=yYVFc/ODP72Bi8XZ7f0b9MDHl0/TzWzKng/STHj8vU8=;
 b=RWv/bTR+l6wSs+RO3qnmgH1abDnecf8oPFKXwyZKG+RANVNZkTqzb/FrE/1JMua84oZI
 N4QYy4nXLrYwb9Lf+bQLDwnffKsyfMqHSqEh6BgUhtADz6M0T5BYtyl9PyyFuN5k72OC
 kmyYL291pXS0IXIlrhA0l3P2+bOfdrFPWmK+p9kHSIcrRkWafRirQfT3/NutTDFitSSa
 ABS8lTh+8yOPAogVkglpi/zmUGkwxjYMny65PsZDU6dD6LlL4obUbGdvwtDnSaqg0+Q3
 JgeH+QJLxH0A8/zQaDhNeh6w+XIgyNsXesxHULRG6XATw6Q9nppfCK3O5Del3gyNwzL1 EQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9m8vykj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:45 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T05iKb017391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:44 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 17:05:44 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Mon, 28 Aug 2023 17:05:10 -0700
Subject: [PATCH RFC v6 04/10] drm/atomic: Add pixel source to plane state
 dump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230828-solid-fill-v6-4-a820efcce852@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693267543; l=2030;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=tvOVEGwiP7rEh28nfHCt63yueya2/gFQGEZxjA4ocgI=;
 b=iMnDEiy/gN51pmc5eyOMM4vl5mjQMunzDXYEGoIp0G0aoVgE3xxbuwIGMYaf6vA0UcZYeHOiq
 8BdLfkgZYe/DUmJ5NdJwYwSX2gikCpL4mAdGX7KoXJlNqY3g94fzIW6
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ot1UQUzlfb8I84rLHOaGsz6kZN3Ffsuu
X-Proofpoint-GUID: ot1UQUzlfb8I84rLHOaGsz6kZN3Ffsuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_19,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=440
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pixel source to the atomic plane state dump

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_atomic.c        | 1 +
 drivers/gpu/drm/drm_blend.c         | 1 +
 drivers/gpu/drm/drm_crtc_internal.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index b4c6ffc438da..bcecb64ccfad 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -713,6 +713,7 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 
 	drm_printf(p, "plane[%u]: %s\n", plane->base.id, plane->name);
 	drm_printf(p, "\tcrtc=%s\n", state->crtc ? state->crtc->name : "(null)");
+	drm_printf(p, "\tpixel-source=%s\n", drm_get_pixel_source_name(state->pixel_source));
 	drm_printf(p, "\tfb=%u\n", state->fb ? state->fb->base.id : 0);
 	if (state->fb)
 		drm_framebuffer_print_info(p, 2, state->fb);
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 1016a206ca0c..3d484aa1e029 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -643,6 +643,7 @@ static const struct drm_prop_enum_list drm_pixel_source_enum_list[] = {
 	{ DRM_PLANE_PIXEL_SOURCE_FB, "FB" },
 	{ DRM_PLANE_PIXEL_SOURCE_SOLID_FILL, "SOLID_FILL" },
 };
+DRM_ENUM_NAME_FN(drm_get_pixel_source_name, drm_pixel_source_enum_list);
 
 /**
  * drm_plane_create_pixel_source_property - create a new pixel source property
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 501a10edd0e1..7bc93ba449d5 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -267,6 +267,7 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
 				 u32 format, u64 modifier);
 struct drm_mode_rect *
 __drm_plane_get_damage_clips(const struct drm_plane_state *state);
+const char *drm_get_pixel_source_name(int val);
 
 /* drm_bridge.c */
 void drm_bridge_detach(struct drm_bridge *bridge);

-- 
2.42.0

