Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4278BBEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjH2AGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjH2AGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:06:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082EEE;
        Mon, 28 Aug 2023 17:06:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SNortl026925;
        Tue, 29 Aug 2023 00:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=kKXYGL7cB/RzvsEpwhNFWR8HuB4115o4ZC2x3xx/0CY=;
 b=Kr1Jfnulyt8KZbrovu/ikKbQYVqlZGETb1ZGWzV1v2HzwEMgwsQ7tW/N/AYhSCf3c1YN
 +x/+ohg/FxGzoqOuS/dXkPE4dOldPQJ3+XmwwHkmn2J29zu0ymEn3eLeJ0nEs5rwRUHh
 HI0Zr5nJv8iPW4vHFM/mI3QvRghYpFOKXawoJUMeI2YhPumOZpY9Yes+0Sx90Zpfa3rH
 d7XWTbx52tTBCS2AeafzLCpPHDs+DTZfCCZXJaRIRESvTbd35odN6yBa2QXrXusRO8Li
 9s8JHq2yzTcidNUzhlHzO8o2G2+ABEfKoIVA9zLknoMRfMdpxpyt4DqxuKBmAlNygXhl xQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss2xb88yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T05ikb017387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 00:05:44 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 17:05:43 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Mon, 28 Aug 2023 17:05:08 -0700
Subject: [PATCH RFC v6 02/10] drm: Introduce solid fill DRM plane property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230828-solid-fill-v6-2-a820efcce852@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693267542; l=8905;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=pMEwv2KHa6bkdVvV9UWcficFFdoxJFKyeeIdxTXhu64=;
 b=Elk3Tw58Yqy7aGiBIKL71NRPNrzd8a8ffWhyEePKrbQ/9hT6jW4jkojeLE7YJwLWN1pRxIl21
 etlvL8FXASABCP+7Q46oYhnxpM8kYffzIAPbA0nxeuB+m11tmGSBm5v
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PFA-oxyAeoBPVRtCPEI3XbSoGzwfoSX-
X-Proofpoint-GUID: PFA-oxyAeoBPVRtCPEI3XbSoGzwfoSX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_19,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document and add support for solid_fill property to drm_plane. In
addition, add support for setting and getting the values for solid_fill.

To enable solid fill planes, userspace must assign a property blob to
the "solid_fill" plane property containing the following information:

struct drm_mode_solid_fill {
	u32 r, g, b;
};

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  9 ++++++++
 drivers/gpu/drm/drm_atomic_uapi.c         | 26 ++++++++++++++++++++++
 drivers/gpu/drm/drm_blend.c               | 30 ++++++++++++++++++++++++++
 include/drm/drm_blend.h                   |  1 +
 include/drm/drm_plane.h                   | 36 +++++++++++++++++++++++++++++++
 include/uapi/drm/drm_mode.h               | 24 +++++++++++++++++++++
 6 files changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 01638c51ce0a..86fb876efbe6 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -254,6 +254,11 @@ void __drm_atomic_helper_plane_state_reset(struct drm_plane_state *plane_state,
 	plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 	plane_state->pixel_source = DRM_PLANE_PIXEL_SOURCE_FB;
 
+	if (plane_state->solid_fill_blob) {
+		drm_property_blob_put(plane_state->solid_fill_blob);
+		plane_state->solid_fill_blob = NULL;
+	}
+
 	if (plane->color_encoding_property) {
 		if (!drm_object_property_get_default_value(&plane->base,
 							   plane->color_encoding_property,
@@ -336,6 +341,9 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 	if (state->fb)
 		drm_framebuffer_get(state->fb);
 
+	if (state->solid_fill_blob)
+		drm_property_blob_get(state->solid_fill_blob);
+
 	state->fence = NULL;
 	state->commit = NULL;
 	state->fb_damage_clips = NULL;
@@ -385,6 +393,7 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
 		drm_crtc_commit_put(state->commit);
 
 	drm_property_blob_put(state->fb_damage_clips);
+	drm_property_blob_put(state->solid_fill_blob);
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 454f980e16c9..1cae596ab693 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -316,6 +316,20 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 }
 EXPORT_SYMBOL(drm_atomic_set_crtc_for_connector);
 
+static void drm_atomic_set_solid_fill_prop(struct drm_plane_state *state)
+{
+	struct drm_mode_solid_fill *user_info;
+
+	if (!state->solid_fill_blob)
+		return;
+
+	user_info = (struct drm_mode_solid_fill *)state->solid_fill_blob->data;
+
+	state->solid_fill.r = user_info->r;
+	state->solid_fill.g = user_info->g;
+	state->solid_fill.b = user_info->b;
+}
+
 static void set_out_fence_for_crtc(struct drm_atomic_state *state,
 				   struct drm_crtc *crtc, s32 __user *fence_ptr)
 {
@@ -546,6 +560,15 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_h = val;
 	} else if (property == plane->pixel_source_property) {
 		state->pixel_source = val;
+	} else if (property == plane->solid_fill_property) {
+		ret = drm_atomic_replace_property_blob_from_id(dev,
+				&state->solid_fill_blob,
+				val, sizeof(struct drm_mode_solid_fill),
+				-1, &replaced);
+		if (ret)
+			return ret;
+
+		drm_atomic_set_solid_fill_prop(state);
 	} else if (property == plane->alpha_property) {
 		state->alpha = val;
 	} else if (property == plane->blend_mode_property) {
@@ -620,6 +643,9 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 		*val = state->src_h;
 	} else if (property == plane->pixel_source_property) {
 		*val = state->pixel_source;
+	} else if (property == plane->solid_fill_property) {
+		*val = state->solid_fill_blob ?
+			state->solid_fill_blob->base.id : 0;
 	} else if (property == plane->alpha_property) {
 		*val = state->alpha;
 	} else if (property == plane->blend_mode_property) {
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index c3c57bae06b7..273021cc21c8 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -200,6 +200,10 @@
  *	"FB":
  *		Framebuffer source set by the "FB_ID" property.
  *
+ * solid_fill:
+ *	solid_fill is set up with drm_plane_create_solid_fill_property(). It
+ *	contains pixel data that drivers can use to fill a plane.
+ *
  * Note that all the property extensions described here apply either to the
  * plane or the CRTC (e.g. for the background color, which currently is not
  * exposed and assumed to be black).
@@ -705,3 +709,29 @@ int drm_plane_create_pixel_source_property(struct drm_plane *plane,
 	return 0;
 }
 EXPORT_SYMBOL(drm_plane_create_pixel_source_property);
+
+/**
+ * drm_plane_create_solid_fill_property - create a new solid_fill property
+ * @plane: drm plane
+ *
+ * This creates a new property blob that holds pixel data for solid fill planes.
+ * The property is exposed to userspace as a property blob called "solid_fill".
+ *
+ * For information on what the blob contains, see `drm_mode_solid_fill`.
+ */
+int drm_plane_create_solid_fill_property(struct drm_plane *plane)
+{
+	struct drm_property *prop;
+
+	prop = drm_property_create(plane->dev,
+			DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_BLOB,
+			"solid_fill", 0);
+	if (!prop)
+		return -ENOMEM;
+
+	drm_object_attach_property(&plane->base, prop, 0);
+	plane->solid_fill_property = prop;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_create_solid_fill_property);
diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
index 122bbfbaae33..e7158fbee389 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -60,4 +60,5 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
 					 unsigned int supported_modes);
 int drm_plane_create_pixel_source_property(struct drm_plane *plane,
 					   unsigned long extra_sources);
+int drm_plane_create_solid_fill_property(struct drm_plane *plane);
 #endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 89508b4dea4a..a38e18bfb43e 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -46,6 +46,18 @@ enum drm_plane_pixel_source {
 	DRM_PLANE_PIXEL_SOURCE_MAX
 };
 
+/**
+ * struct solid_fill_property - RGB values for solid fill plane
+ *
+ * TODO: Add solid fill source and corresponding pixel source
+ *       that supports RGBA color
+ */
+struct drm_solid_fill {
+	uint32_t r;
+	uint32_t g;
+	uint32_t b;
+};
+
 /**
  * struct drm_plane_state - mutable plane state
  *
@@ -130,6 +142,23 @@ struct drm_plane_state {
 	 */
 	enum drm_plane_pixel_source pixel_source;
 
+	/**
+	 * @solid_fill_blob:
+	 *
+	 * Blob containing relevant information for a solid fill plane
+	 * including pixel format and data. See
+	 * drm_plane_create_solid_fill_property() for more details.
+	 */
+	struct drm_property_blob *solid_fill_blob;
+
+	/**
+	 * @solid_fill:
+	 *
+	 * Pixel data for solid fill planes. See
+	 * drm_plane_create_solid_fill_property() for more details.
+	 */
+	struct drm_solid_fill solid_fill;
+
 	/**
 	 * @alpha:
 	 * Opacity of the plane with 0 as completely transparent and 0xffff as
@@ -720,6 +749,13 @@ struct drm_plane {
 	 */
 	struct drm_property *pixel_source_property;
 
+	/**
+	 * @solid_fill_property:
+	 * Optional solid_fill property for this plane. See
+	 * drm_plane_create_solid_fill_property().
+	 */
+	struct drm_property *solid_fill_property;
+
 	/**
 	 * @alpha_property:
 	 * Optional alpha property for this plane. See
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 43691058d28f..1fd92886d66c 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
 	char name[DRM_DISPLAY_MODE_LEN];
 };
 
+/**
+ * struct drm_mode_solid_fill - User info for solid fill planes
+ *
+ * This is the userspace API solid fill information structure.
+ *
+ * Userspace can enable solid fill planes by assigning the plane "solid_fill"
+ * property to a blob containing a single drm_mode_solid_fill struct populated with an RGB323232
+ * color and setting the pixel source to "SOLID_FILL".
+ *
+ * For information on the plane property, see drm_plane_create_solid_fill_property()
+ *
+ * @r: Red color value of single pixel
+ * @g: Green color value of single pixel
+ * @b: Blue color value of single pixel
+ * @pad: padding
+ */
+struct drm_mode_solid_fill {
+	__u32 r;
+	__u32 g;
+	__u32 b;
+	__u32 pad;
+};
+
+
 struct drm_mode_card_res {
 	__u64 fb_id_ptr;
 	__u64 crtc_id_ptr;

-- 
2.42.0

