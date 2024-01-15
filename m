Return-Path: <linux-kernel+bounces-26222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369F82DCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C91F22A55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9C1182DF;
	Mon, 15 Jan 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="f1XqMvAM"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222B17BB1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e775695c6so9636175e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1705334804; x=1705939604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7h5TOlHeh29R5MO3vqvyCpfRR+2j5wkj4KSWlgVsY0=;
        b=f1XqMvAM/gkiRVln52kgZRjSUI4gyps3RPmoYbpMXTFmluU4ZidTR9NkP8eTukJL8q
         TRSve6cFqM2/v1z9oNAM7jKdABO0kgtpVyivb0dL+MbC9U62OtYnre7GDDeUJfOMdSIi
         nqQOrawB3i3S9IokaJSW3W/p9GOehJZj79/tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334804; x=1705939604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7h5TOlHeh29R5MO3vqvyCpfRR+2j5wkj4KSWlgVsY0=;
        b=vn6u2dh2+XrWEbW25rDQBZJkbxWNCWTSlZc7QI6Wurx2/w2Gq701s1FUMU4ZX6q30v
         /sLi8fLghGCvJU2hd8GSeNpSmL6ATFyCSpwDIlGaPnnTiIOkohk+N7o6ZTGLRg69ode4
         enFK7ET6KE6PTGsVsNdV3Xibt0L6gYnrnQjKnhaweJWVJfnJTsDB1q4gXmkhMHfv2bnc
         2e3VQHL4yAqo9GKdoDjW4LKTegCgoygaApZrGw0l+F4mbHDvFKUNC9jbfextllFIyZEW
         SqLYLk9HqH3xNK+vsDbUHzxPvhWlLpHxj1RhmzNEzXJGiaQgH5YPbpSZwEI0kkWc/hJR
         GVHg==
X-Gm-Message-State: AOJu0Yz+DmkOxIvhSpmNvucK/I5QMYS+n15e3RX6g6O6jho7VV+cFK7g
	OKtOPWWBac7iFF6EgZ90fqAvhBwY1XggRA==
X-Google-Smtp-Source: AGHT+IHMlicTU5ZpLWspXuG4eSFL0osighJE+s/ckHvaTE3eH7QH7NJLEqO4581S2L63mZc6rAr+vw==
X-Received: by 2002:a05:600c:524c:b0:40e:397e:16e7 with SMTP id fc12-20020a05600c524c00b0040e397e16e7mr3140605wmb.3.1705334804112;
        Mon, 15 Jan 2024 08:06:44 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm20174140wmq.44.2024.01.15.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:43 -0800 (PST)
From: Andri Yngvason <andri@yngvason.is>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Simon Ser <contact@emersion.fr>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Andri Yngvason <andri@yngvason.is>
Subject: [PATCH v2 3/4] drm/amd/display: Add handling for new "force color format" property
Date: Mon, 15 Jan 2024 16:05:53 +0000
Message-ID: <20240115160554.720247-4-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115160554.720247-1-andri@yngvason.is>
References: <20240115160554.720247-1-andri@yngvason.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Werner Sembach <wse@tuxedocomputers.com>

This commit implements the "force color format" drm property for the
AMD GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Co-Developed-by: Andri Yngvason <andri@yngvason.is>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---

Changes in v2:
 - Renamed to "force color format" from "preferred color format"
 - Modeset will fail if color format cannot be satisfied

---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 63 ++++++++++++++++---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cc4d1f7f97b98..26c4260c78d7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5573,15 +5573,32 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->h_border_right = 0;
 	timing_out->v_border_top = 0;
 	timing_out->v_border_bottom = 0;
-	/* TODO: un-hardcode */
-	if (drm_mode_is_420_only(info, mode_in)
-			|| (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output))
+
+	if (connector_state
+			&& (connector_state->force_color_format == DRM_COLOR_FORMAT_YCBCR420
+			|| aconnector->force_yuv420_output) && drm_mode_is_420(info, mode_in))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+	else if (connector_state
+			&& connector_state->force_color_format == DRM_COLOR_FORMAT_YCBCR444
+			&& connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-	else
+	else if (connector_state
+			&& connector_state->force_color_format == DRM_COLOR_FORMAT_RGB444
+			&& !drm_mode_is_420_only(info, mode_in))
 		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
+	else
+		/*
+		 * connector_state->force_color_format not possible
+		 * || connector_state->force_color_format == 0 (auto)
+		 * || connector_state->force_color_format == DRM_COLOR_FORMAT_YCBCR422
+		 */
+		if (drm_mode_is_420_only(info, mode_in))
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+		else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
+				&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
+		else
+			timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
 
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
 	timing_out->display_color_depth = convert_color_depth_from_display_info(
@@ -6685,6 +6702,33 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
 	return dc_result;
 }
 
+static enum dc_status
+dm_validate_stream_color_format(const struct drm_connector_state *drm_state,
+				const struct dc_stream_state *stream)
+{
+	if (!drm_state->force_color_format)
+		return DC_OK;
+
+	enum dc_pixel_encoding encoding = PIXEL_ENCODING_UNDEFINED;
+	switch (drm_state->force_color_format) {
+	case DRM_COLOR_FORMAT_RGB444:
+		encoding = PIXEL_ENCODING_RGB;
+		break;
+	case DRM_COLOR_FORMAT_YCBCR444:
+		encoding = PIXEL_ENCODING_YCBCR444;
+		break;
+	case DRM_COLOR_FORMAT_YCBCR422:
+		encoding = PIXEL_ENCODING_YCBCR422;
+		break;
+	case DRM_COLOR_FORMAT_YCBCR420:
+		encoding = PIXEL_ENCODING_YCBCR420;
+		break;
+	}
+
+	return encoding == stream->timing.pixel_encoding ?
+	       DC_OK : DC_UNSUPPORTED_VALUE;
+}
+
 struct dc_stream_state *
 create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 				const struct drm_display_mode *drm_mode,
@@ -6717,6 +6761,9 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		if (dc_result == DC_OK)
 			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
 
+		if (dc_result == DC_OK)
+			dc_result = dm_validate_stream_color_format(drm_state, stream);
+
 		if (dc_result != DC_OK) {
 			DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d (%s)\n",
 				      drm_mode->hdisplay,
@@ -7512,8 +7559,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.underscan_vborder_property,
 				0);
 
-	if (!aconnector->mst_root)
+	if (!aconnector->mst_root) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_force_color_format_property(&aconnector->base);
+	}
 
 	aconnector->base.state->max_bpc = 16;
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 941e96f100f4e..437d50f53eb97 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -601,6 +601,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->max_bpc_property)
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
+	connector->force_color_format_property = master->base.force_color_format_property;
+	if (connector->force_color_format_property)
+		drm_connector_attach_force_color_format_property(&aconnector->base);
+
 	connector->vrr_capable_property = master->base.vrr_capable_property;
 	if (connector->vrr_capable_property)
 		drm_connector_attach_vrr_capable_property(connector);
-- 
2.43.0


