Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60309777E53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjHJQcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjHJQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:06:46 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256AD44A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4tWRLrqqWeLGyfJFSnJVygLyn2l6MVUmw75YAMLPyTY=; b=DT6BXPzTbQ74MjyZbRe4wdbLJY
        JaZDQ+3iGXL9V/bV4eaSG2xZZMOCYfg1Y1hiFBnMZ4LZVYAGaxrwXQBPd8gOmx3g/NQqdJTk1U82h
        f+56TaT2o6C4S1dBXFAllndA++BJqAvPC9f9P6MEfaSQSIqHOiBJ7e/OjAdd5DsKTauZX2SqUiqMx
        5XwqZZmzaQAX8L6UFCncMLp7b1+SWgSANTsBDjIC8Oqu3merYfkqU5Wb4dV7+Szyo6uqAhJeUrpaE
        a2MqQVw2DluhqsigeOjKM+jQtE6OGstBkflOqpxHfL/W/uF6cqvPA3vifh5URsDonB+o9CxA4Xog4
        15wZpTiw==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qU89D-00GjYD-Dl; Thu, 10 Aug 2023 18:04:27 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Simon Ser <contact@emersion.fr>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/34] drm/amd/display: add plane CTM driver-specific property
Date:   Thu, 10 Aug 2023 15:03:12 -0100
Message-Id: <20230810160314.48225-33-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810160314.48225-1-mwen@igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plane CTM for pre-blending color space conversion. Only enable
driver-specific plane CTM property on drivers that support both pre- and
post-blending gamut remap matrix, i.e., DCN3+ family. Otherwise it
conflits with DRM CRTC CTM property.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  2 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  7 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 +++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index abb871a912d7..84bf501b02f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -363,6 +363,8 @@ struct amdgpu_mode_info {
 	 * @plane_hdr_mult_property:
 	 */
 	struct drm_property *plane_hdr_mult_property;
+
+	struct drm_property *plane_ctm_property;
 	/**
 	 * @shaper_lut_property: Plane property to set pre-blending shaper LUT
 	 * that converts color content before 3D LUT.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 095f39f04210..6252ee912a63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -769,6 +769,13 @@ struct dm_plane_state {
 	 * S31.32 sign-magnitude.
 	 */
 	__u64 hdr_mult;
+	/**
+	 * @ctm:
+	 *
+	 * Color transformation matrix. See drm_crtc_enable_color_mgmt(). The
+	 * blob (if not NULL) is a &struct drm_color_ctm.
+	 */
+	struct drm_property_blob *ctm;
 	/**
 	 * @shaper_lut: shaper lookup table blob. The blob (if not NULL) is an
 	 * array of &struct drm_color_lut.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 4356846a2bce..86a918ab82be 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -218,6 +218,13 @@ amdgpu_dm_create_color_properties(struct amdgpu_device *adev)
 		return -ENOMEM;
 	adev->mode_info.plane_hdr_mult_property = prop;
 
+	prop = drm_property_create(adev_to_drm(adev),
+				   DRM_MODE_PROP_BLOB,
+				   "AMD_PLANE_CTM", 0);
+	if (!prop)
+		return -ENOMEM;
+	adev->mode_info.plane_ctm_property = prop;
+
 	prop = drm_property_create(adev_to_drm(adev),
 				   DRM_MODE_PROP_BLOB,
 				   "AMD_PLANE_SHAPER_LUT", 0);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 3fd57de7c5be..0b1081c690cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1355,6 +1355,8 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
 
 	if (dm_plane_state->degamma_lut)
 		drm_property_blob_get(dm_plane_state->degamma_lut);
+	if (dm_plane_state->ctm)
+		drm_property_blob_get(dm_plane_state->ctm);
 	if (dm_plane_state->shaper_lut)
 		drm_property_blob_get(dm_plane_state->shaper_lut);
 	if (dm_plane_state->lut3d)
@@ -1436,6 +1438,8 @@ static void dm_drm_plane_destroy_state(struct drm_plane *plane,
 
 	if (dm_plane_state->degamma_lut)
 		drm_property_blob_put(dm_plane_state->degamma_lut);
+	if (dm_plane_state->ctm)
+		drm_property_blob_put(dm_plane_state->ctm);
 	if (dm_plane_state->lut3d)
 		drm_property_blob_put(dm_plane_state->lut3d);
 	if (dm_plane_state->shaper_lut)
@@ -1473,6 +1477,11 @@ dm_atomic_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
 				   dm->adev->mode_info.plane_hdr_mult_property,
 				   AMDGPU_HDR_MULT_DEFAULT);
 
+	/* Only enable plane CTM if both DPP and MPC gamut remap is available. */
+	if (dm->dc->caps.color.mpc.gamut_remap)
+		drm_object_attach_property(&plane->base,
+					   dm->adev->mode_info.plane_ctm_property, 0);
+
 	if (dpp_color_caps.hw_3d_lut) {
 		drm_object_attach_property(&plane->base,
 					   mode_info.plane_shaper_lut_property, 0);
@@ -1530,6 +1539,14 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 			dm_plane_state->hdr_mult = val;
 			dm_plane_state->base.color_mgmt_changed = 1;
 		}
+	} else if (property == adev->mode_info.plane_ctm_property) {
+		ret = drm_property_replace_blob_from_id(plane->dev,
+							&dm_plane_state->ctm,
+							val,
+							sizeof(struct drm_color_ctm), -1,
+							&replaced);
+		dm_plane_state->base.color_mgmt_changed |= replaced;
+		return ret;
 	} else if (property == adev->mode_info.plane_shaper_lut_property) {
 		ret = drm_property_replace_blob_from_id(plane->dev,
 							&dm_plane_state->shaper_lut,
@@ -1591,6 +1608,9 @@ dm_atomic_plane_get_property(struct drm_plane *plane,
 		*val = dm_plane_state->degamma_tf;
 	} else if (property == adev->mode_info.plane_hdr_mult_property) {
 		*val = dm_plane_state->hdr_mult;
+	} else if (property == adev->mode_info.plane_ctm_property) {
+		*val = (dm_plane_state->ctm) ?
+			dm_plane_state->ctm->base.id : 0;
 	} else 	if (property == adev->mode_info.plane_shaper_lut_property) {
 		*val = (dm_plane_state->shaper_lut) ?
 			dm_plane_state->shaper_lut->base.id : 0;
-- 
2.40.1

