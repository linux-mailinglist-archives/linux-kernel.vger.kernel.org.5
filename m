Return-Path: <linux-kernel+bounces-21221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8635C828C38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BF2B21CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F28B3D384;
	Tue,  9 Jan 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="fq1GBTbr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9B3C6A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so34643035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704823893; x=1705428693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab6S82YVhL2fQWMl7n/iDflNvLFt/phlZFbHK/9RmUw=;
        b=fq1GBTbrZbQyxPMF0QpQ/uHN2osqF60fTCQdTVQGqr6CLPDii77IBJBMB9+1RpLFSt
         4bSzvvvVaZaydL+ZhGW55rGlrSMR4gXSPs2Ij7Rx1goZ0aFFH4ZKZKKglEoN5AgMDxZC
         7p8eqYRBXmtSYY7LNw/fR8b0tl31+GFAUSVLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823893; x=1705428693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab6S82YVhL2fQWMl7n/iDflNvLFt/phlZFbHK/9RmUw=;
        b=FkGr7V+SPbszMjFSVveUfnK4EqaNBhmQWnm1MH4ejj7sLhQoLYKQ0lphpM5edpxjpL
         RulxDgF/XAUwQA6F8yBhcBWR6et1Pw6FEh3z8Qt7LEieGPplgGOypXaBf8EaqXXyKQR4
         jbwv3fcxUiBk0V5kTfBtBzAObyemiFipEpBCWuMmm/WedUd2uw6NgNRYlduLwa8OLu8X
         HHtUO5iZdnK4jaxqFL55j4cuHPshwXeS11jxBW6kmjVj3juv3haDC0kr37oL9tOyErd+
         csm4J63+Tz+6Z8LVpRBWmHPVBPW/MpatgAs0JLaZ5zTvntekB6abGzgCmkCHOrCNk5WB
         awYw==
X-Gm-Message-State: AOJu0YwwbplKh6NRMV88SgTX9AXD9atlg7LqU+RSaZHFA/Mm7ttIFS7l
	+ag/aRxGXXJJwP9J3Nv2+LZnNuU12ABsYw==
X-Google-Smtp-Source: AGHT+IECX0laRRtfF4jvavSEkKwLcA9a4P5MCiLvTCxN6JaHCGAk1yoL0mgxvPQHa7eWzawwSwZVFQ==
X-Received: by 2002:a05:600c:1c20:b0:40e:53f8:5242 with SMTP id j32-20020a05600c1c2000b0040e53f85242mr186194wms.72.1704823893245;
        Tue, 09 Jan 2024 10:11:33 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b0040e527602c8sm2104579wms.9.2024.01.09.10.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:11:32 -0800 (PST)
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
Subject: [PATCH 3/7] drm/amd/display: Add handling for new "active color format" property
Date: Tue,  9 Jan 2024 18:11:00 +0000
Message-ID: <20240109181104.1670304-4-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109181104.1670304-1-andri@yngvason.is>
References: <20240109181104.1670304-1-andri@yngvason.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Werner Sembach <wse@tuxedocomputers.com>

This commit implements the "active color format" drm property for the AMD
GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 ++++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 10e041a3b2545..b44d06c3b1706 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6882,6 +6882,24 @@ int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
 	return 0;
 }
 
+static int convert_dc_pixel_encoding_into_drm_color_format(
+	enum dc_pixel_encoding display_pixel_encoding)
+{
+	switch (display_pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+		return DRM_COLOR_FORMAT_RGB444;
+	case PIXEL_ENCODING_YCBCR422:
+		return DRM_COLOR_FORMAT_YCBCR422;
+	case PIXEL_ENCODING_YCBCR444:
+		return DRM_COLOR_FORMAT_YCBCR444;
+	case PIXEL_ENCODING_YCBCR420:
+		return DRM_COLOR_FORMAT_YCBCR420;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 					  struct drm_crtc_state *crtc_state,
 					  struct drm_connector_state *conn_state)
@@ -7436,8 +7454,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.underscan_vborder_property,
 				0);
 
-	if (!aconnector->mst_root)
+	if (!aconnector->mst_root) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_active_color_format_property(&aconnector->base);
+	}
 
 	aconnector->base.state->max_bpc = 16;
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
@@ -8969,6 +8989,26 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		kfree(dummy_updates);
 	}
 
+	/* Extract information from crtc to communicate it to userspace as connector properties */
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
+		struct drm_crtc *crtc = new_con_state->crtc;
+		struct dc_stream_state *stream;
+
+		if (crtc) {
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+			stream = dm_new_crtc_state->stream;
+
+			if (stream) {
+				drm_connector_set_active_color_format_property(connector,
+					convert_dc_pixel_encoding_into_drm_color_format(
+						dm_new_crtc_state->stream->timing.pixel_encoding));
+			}
+		} else {
+			drm_connector_set_active_color_format_property(connector, 0);
+		}
+	}
+
 	/**
 	 * Enable interrupts for CRTCs that are newly enabled or went through
 	 * a modeset. It was intentionally deferred until after the front end
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 11da0eebee6c4..a4d1b3ea8f81c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -600,6 +600,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->max_bpc_property)
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
+	connector->active_color_format_property = master->base.active_color_format_property;
+	if (connector->active_color_format_property)
+		drm_connector_attach_active_color_format_property(&aconnector->base);
+
 	connector->vrr_capable_property = master->base.vrr_capable_property;
 	if (connector->vrr_capable_property)
 		drm_connector_attach_vrr_capable_property(connector);
-- 
2.43.0


