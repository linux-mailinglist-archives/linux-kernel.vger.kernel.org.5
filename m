Return-Path: <linux-kernel+bounces-26223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A282882DCFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E931C217E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9818AF4;
	Mon, 15 Jan 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="jN3vEsw5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BC182DA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso42326575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1705334806; x=1705939606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdtBBD/PsT+CMOt03gpuRaURCK/Kf9ifF8Qmw3C9ypA=;
        b=jN3vEsw5AZNY+J7UfD1CR7cIQbor/W4m3Po0xllVZ3sV1fJCIDQgNSzsQM9wHR1GPS
         weWICbXBUELHySxj0/SY6qFOXWJnsUpQX+0Vq8IJL1Lucd2hVzmo8knnxanuEKRv8gTZ
         ElRTlBbxsTx7UXWUF3vAXYTcVK+ETYQdA8BFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334806; x=1705939606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdtBBD/PsT+CMOt03gpuRaURCK/Kf9ifF8Qmw3C9ypA=;
        b=jto3jFUx4jpVLGBHSW7Duljf6Kr7bQ55gUVI+hfpnA71TJzbWL0mwlBqSyGtN54cZ5
         e2Rjn7rauqWqzU44FcwvEujarH16TPA+wrQ+yXk0aIblge7LRef7n8hIUtlWLEtt6TTy
         59feFHZB1shXLwT+TAAVedTgcEbUlHj2haQSv9OfF4gR32IBEqXhxoHqu6QsRpQzD6XV
         W5i2khEzIH0nvRucXI8BzcllV9QPqWnktgJeIqguEnCdUhSxUV+sh1O334hYHh6r4j8f
         SsWHXG9z0q1VCGrIawezpH2M34A1zAYTBWdAvtQuIvNPpTZJBo0VSDCQThEiNok0D8z7
         MLmA==
X-Gm-Message-State: AOJu0YxRp/RxPQ8n7nrJ72JDHn0DraEOvhnVVteXiArZfMQjWwBTaHAc
	LlH0LRgVd3MKQdm86mQARNKyNBdFpuB1XQ==
X-Google-Smtp-Source: AGHT+IHpqJt7PYL/T1kUb/MG4+ntZ8TRnDliR4DSwYmn+/sZY/n2Xxy8iGjJp3XSHJ9WOx+vBUYUwg==
X-Received: by 2002:a05:600c:4f90:b0:40d:5f45:5094 with SMTP id n16-20020a05600c4f9000b0040d5f455094mr2778999wmq.104.1705334806635;
        Mon, 15 Jan 2024 08:06:46 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm20174140wmq.44.2024.01.15.08.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:46 -0800 (PST)
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
Subject: [PATCH v2 4/4] drm/i915/display: Add handling for new "force color format" property
Date: Mon, 15 Jan 2024 16:05:54 +0000
Message-ID: <20240115160554.720247-5-andri@yngvason.is>
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
Intel GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Co-Developed-by: Andri Yngvason <andri@yngvason.is>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---

Changes in v2:
 - Renamed to "force color format" from "preferred color format"
 - Modeset will fail if color format cannot be satisfied

---
 drivers/gpu/drm/i915/display/intel_dp.c     | 35 ++++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_dp_mst.c |  5 +++
 drivers/gpu/drm/i915/display/intel_hdmi.c   | 29 ++++++++++++++---
 3 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 7d2b8ce48fda1..71e822483572e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2799,6 +2799,16 @@ static bool intel_dp_has_audio(struct intel_encoder *encoder,
 		return intel_conn_state->force_audio == HDMI_AUDIO_ON;
 }
 
+static u32 intel_output_format_to_drm_color_format(enum intel_output_format input)
+{
+	switch (input) {
+	case INTEL_OUTPUT_FORMAT_RGB: return DRM_COLOR_FORMAT_RGB444;
+	case INTEL_OUTPUT_FORMAT_YCBCR444: return DRM_COLOR_FORMAT_YCBCR444;
+	case INTEL_OUTPUT_FORMAT_YCBCR420: return DRM_COLOR_FORMAT_YCBCR420;
+	}
+	return 0;
+}
+
 static int
 intel_dp_compute_output_format(struct intel_encoder *encoder,
 			       struct intel_crtc_state *crtc_state,
@@ -2810,17 +2820,20 @@ intel_dp_compute_output_format(struct intel_encoder *encoder,
 	struct intel_connector *connector = intel_dp->attached_connector;
 	const struct drm_display_info *info = &connector->base.display_info;
 	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
-	bool ycbcr_420_only;
+	bool ycbcr_420_output;
 	int ret;
 
-	ycbcr_420_only = drm_mode_is_420_only(info, adjusted_mode);
+	ycbcr_420_output = drm_mode_is_420_only(info, adjusted_mode) ||
+			   (conn_state->force_color_format == DRM_COLOR_FORMAT_YCBCR420 &&
+			    drm_mode_is_420_also(&connector->base.display_info, adjusted_mode));
 
-	if (ycbcr_420_only && !connector->base.ycbcr_420_allowed) {
+	crtc_state->sink_format = ycbcr_420_output ? INTEL_OUTPUT_FORMAT_YCBCR420 :
+						     INTEL_OUTPUT_FORMAT_RGB;
+
+	if (ycbcr_420_output && !connector->base.ycbcr_420_allowed) {
 		drm_dbg_kms(&i915->drm,
 			    "YCbCr 4:2:0 mode but YCbCr 4:2:0 output not possible. Falling back to RGB.\n");
 		crtc_state->sink_format = INTEL_OUTPUT_FORMAT_RGB;
-	} else {
-		crtc_state->sink_format = intel_dp_sink_format(connector, adjusted_mode);
 	}
 
 	crtc_state->output_format = intel_dp_output_format(connector, crtc_state->sink_format);
@@ -2840,6 +2853,11 @@ intel_dp_compute_output_format(struct intel_encoder *encoder,
 						   respect_downstream_limits);
 	}
 
+	if (conn_state->force_color_format && conn_state->force_color_format !=
+	    intel_output_format_to_drm_color_format(crtc_state->sink_format)) {
+		ret = -EINVAL;
+	}
+
 	return ret;
 }
 
@@ -6179,10 +6197,13 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 		intel_attach_force_audio_property(connector);
 
 	intel_attach_broadcast_rgb_property(connector);
-	if (HAS_GMCH(dev_priv))
+	if (HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
-	else if (DISPLAY_VER(dev_priv) >= 5)
+		drm_connector_attach_force_color_format_property(connector);
+	} else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
+		drm_connector_attach_force_color_format_property(connector);
+	}
 
 	/* Register HDMI colorspace for case of lspcon */
 	if (intel_bios_encoder_is_lspcon(dp_to_dig_port(intel_dp)->base.devdata)) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 8a94323350303..dcb3abcc6d83e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1572,6 +1572,11 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 		drm_dbg_kms(&dev_priv->drm, "[%s:%d] HDCP MST init failed, skipping.\n",
 			    connector->name, connector->base.id);
 
+	connector->force_color_format_property =
+		intel_dp->attached_connector->base.force_color_format_property;
+	if (connector->force_color_format_property)
+		drm_connector_attach_force_color_format_property(connector);
+
 	return connector;
 
 err:
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 39e4f5f7c8171..a612173411b26 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2205,6 +2205,16 @@ intel_hdmi_output_format(const struct intel_crtc_state *crtc_state)
 	return crtc_state->sink_format;
 }
 
+static u32 intel_output_format_to_drm_color_format(enum intel_output_format input)
+{
+	switch (input) {
+	case INTEL_OUTPUT_FORMAT_RGB: return DRM_COLOR_FORMAT_RGB444;
+	case INTEL_OUTPUT_FORMAT_YCBCR444: return DRM_COLOR_FORMAT_YCBCR444;
+	case INTEL_OUTPUT_FORMAT_YCBCR420: return DRM_COLOR_FORMAT_YCBCR420;
+	}
+	return 0;
+}
+
 static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 					    struct intel_crtc_state *crtc_state,
 					    const struct drm_connector_state *conn_state,
@@ -2214,13 +2224,17 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
 	const struct drm_display_info *info = &connector->base.display_info;
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
-	bool ycbcr_420_only = drm_mode_is_420_only(info, adjusted_mode);
+	bool ycbcr_420_output;
 	int ret;
 
+	ycbcr_420_output = drm_mode_is_420_only(info, adjusted_mode) ||
+			   (conn_state->force_color_format == DRM_COLOR_FORMAT_YCBCR420 &&
+			    drm_mode_is_420_also(&connector->base.display_info, adjusted_mode));
+
 	crtc_state->sink_format =
-		intel_hdmi_sink_format(crtc_state, connector, ycbcr_420_only);
+		intel_hdmi_sink_format(crtc_state, connector, ycbcr_420_output);
 
-	if (ycbcr_420_only && crtc_state->sink_format != INTEL_OUTPUT_FORMAT_YCBCR420) {
+	if (ycbcr_420_output && crtc_state->sink_format != INTEL_OUTPUT_FORMAT_YCBCR420) {
 		drm_dbg_kms(&i915->drm,
 			    "YCbCr 4:2:0 mode but YCbCr 4:2:0 output not possible. Falling back to RGB.\n");
 		crtc_state->sink_format = INTEL_OUTPUT_FORMAT_RGB;
@@ -2240,6 +2254,11 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 		ret = intel_hdmi_compute_clock(encoder, crtc_state, respect_downstream_limits);
 	}
 
+	if (conn_state->force_color_format && conn_state->force_color_format !=
+	    intel_output_format_to_drm_color_format(crtc_state->output_format)) {
+		ret = -EINVAL;
+	}
+
 	return ret;
 }
 
@@ -2611,8 +2630,10 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 	if (DISPLAY_VER(dev_priv) >= 10)
 		drm_connector_attach_hdr_output_metadata_property(connector);
 
-	if (!HAS_GMCH(dev_priv))
+	if (!HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
+		drm_connector_attach_force_color_format_property(connector);
+	}
 }
 
 /*
-- 
2.43.0


