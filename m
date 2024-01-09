Return-Path: <linux-kernel+bounces-21226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC72B828C43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A49289528
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048853D963;
	Tue,  9 Jan 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="UuzbJPPt"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784B3D570
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e4582ed74so25202335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704823914; x=1705428714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K35iyXrIjP9JEaVNwNgowQ2gmFwtnlNnPCP001WTzs=;
        b=UuzbJPPt6/VYdgVQKcYpuRJuDbVBbvuHP3kCmeHoi3EpmcO/wmzm3+edGaTnnbiB1M
         zzh4XTci7lixZFRj5NKxNcDnlkyQraVmD16qmTNzJNXrLfpTYmAvy3wE0kS4n0z2Ucpd
         c1wnBDQkQlaIKrBPrwL/ta9zjH3T+cC77cEPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823914; x=1705428714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K35iyXrIjP9JEaVNwNgowQ2gmFwtnlNnPCP001WTzs=;
        b=OfyQH/j6OJbDFuXg0UviRLQogcuI1zIs6pwfjVCQd1ZQlNydtf+etubpH1CaBvtP26
         4jG9d/xn7m1hcPT1/O7JM0NGWLQoD/DQY24Z5GousIhy+nzZZ0TJzNItxVEu8kvW79Ch
         oG+H7a+SlBwZk079SL1BGe3F8oaB8kgsOFTEAtrJdH6NXe6qWKjfYs0aVQ2ZNBWGpH6q
         PkvAwvld8KnV2mUrxel+U9uN+i8leA6SQbjqyf8OM8MrXUiGDDUW6YG6mflDltfC+HeZ
         SbRcVbD9cKHAgQBJFZc7v34unxsUQkDVlWCtqR5FrkMxXRS2JefQ4+b62fFq+rhDXu/1
         Ceog==
X-Gm-Message-State: AOJu0Yx8VMRJYnw68cYZ6C+KTyDWiV6KCpmaKJ52WBjIriAlWzewhw1n
	DorPrHCmPlBIdHX0ljkc8qcKrwy6F63qCw==
X-Google-Smtp-Source: AGHT+IHCvkhLBDjMnPPg6VS4Uza9HPKoHPU28wAqqAGezxMnCAYYxMWKNpbjFIpaRNQwjFu2XbHG4A==
X-Received: by 2002:a05:600c:5251:b0:40c:24b1:8d07 with SMTP id fc17-20020a05600c525100b0040c24b18d07mr1582485wmb.192.1704823913857;
        Tue, 09 Jan 2024 10:11:53 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b0040e527602c8sm2104579wms.9.2024.01.09.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:11:53 -0800 (PST)
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
Subject: [PATCH 7/7] drm/i915/display: Add handling for new "preferred color format" property
Date: Tue,  9 Jan 2024 18:11:04 +0000
Message-ID: <20240109181104.1670304-8-andri@yngvason.is>
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

This commit implements the "preferred color format" drm property for the
Intel GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Co-developed-by: Andri Yngvason <andri@yngvason.is>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/gpu/drm/i915/display/intel_dp.c     | 16 ++++++++++------
 drivers/gpu/drm/i915/display/intel_dp_mst.c |  5 +++++
 drivers/gpu/drm/i915/display/intel_hdmi.c   | 12 +++++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index c40fe8a847614..f241798660d0b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2698,21 +2698,23 @@ intel_dp_compute_output_format(struct intel_encoder *encoder,
 	struct intel_connector *connector = intel_dp->attached_connector;
 	const struct drm_display_info *info = &connector->base.display_info;
 	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
-	bool ycbcr_420_only;
+	bool ycbcr_420_output;
 	int ret;
 
-	ycbcr_420_only = drm_mode_is_420_only(info, adjusted_mode);
+	ycbcr_420_output = drm_mode_is_420_only(info, adjusted_mode) ||
+			   (conn_state->preferred_color_format == DRM_COLOR_FORMAT_YCBCR420 &&
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
-
 	ret = intel_dp_compute_link_config(encoder, crtc_state, conn_state,
 					   respect_downstream_limits);
 	if (ret) {
@@ -5912,9 +5914,11 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 	intel_attach_broadcast_rgb_property(connector);
 	if (HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 	} else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index e7574ca0604e6..4a850eb9b8d4d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1210,6 +1210,11 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 		drm_dbg_kms(&dev_priv->drm, "[%s:%d] HDCP MST init failed, skipping.\n",
 			    connector->name, connector->base.id);
 
+	connector->preferred_color_format_property =
+		intel_dp->attached_connector->base.preferred_color_format_property;
+	if (connector->preferred_color_format_property)
+		drm_connector_attach_preferred_color_format_property(connector);
+
 	connector->active_color_format_property =
 		intel_dp->attached_connector->base.active_color_format_property;
 	if (connector->active_color_format_property)
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index ce0221f90de92..3030589d245d7 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2214,19 +2214,24 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
 	const struct drm_display_info *info = &connector->base.display_info;
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
-	bool ycbcr_420_only = drm_mode_is_420_only(info, adjusted_mode);
+	bool ycbcr_420_output;
 	int ret;
 
+	ycbcr_420_output = drm_mode_is_420_only(info, adjusted_mode) ||
+			   (conn_state->preferred_color_format == DRM_COLOR_FORMAT_YCBCR420 &&
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
 	}
 
 	crtc_state->output_format = intel_hdmi_output_format(crtc_state);
+
 	ret = intel_hdmi_compute_clock(encoder, crtc_state, respect_downstream_limits);
 	if (ret) {
 		if (crtc_state->sink_format == INTEL_OUTPUT_FORMAT_YCBCR420 ||
@@ -2613,6 +2618,7 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 
 	if (!HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
+		drm_connector_attach_preferred_color_format_property(connector);
 		drm_connector_attach_active_color_format_property(connector);
 	}
 }
-- 
2.43.0


