Return-Path: <linux-kernel+bounces-26221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB282DCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2981F21D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E4917BC2;
	Mon, 15 Jan 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="SZBOTWXE"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D6182AA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3376d424a79so6916750f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1705334802; x=1705939602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqVmGq7cOGaTLOSCYXLFwYOFgoyzsg0JNnPbRbL+2qg=;
        b=SZBOTWXErqeERnQ4SiFZ/NYVGiqSqwKoVJaubKwgXbThjRtV7k+OH6QaCcQ5/ZBxLy
         6t3GmtyTULM7BTbmyvTPi4xNB1dj9zdpnrjlZtsG5FK7Uyb+rBMMRfu9veUVN3uOpD6j
         +1rVynP0KCkJAOOeLomvFgvPqsoE7yL76IkCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334802; x=1705939602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqVmGq7cOGaTLOSCYXLFwYOFgoyzsg0JNnPbRbL+2qg=;
        b=rNySlX1281sDl9Sh7DtWvJWMg1rZ8o3CnqzZEuk6+TYfW7oGEZ5I0R09r778SrXLgz
         lHrM1m6r+ILOBKYYQ4D+heWtK8yfAHo8QcuRI0WvO4yaJH0um51pmKFKHFB+IxG7oJh1
         Bsn6Sl4GZXT4M0HFdVo+ELUn60/nx+CjIw23T6Wx40luR1dQ0JLbDdEsPfg0UyDeX+F0
         mQ6uWXvgV3oPGODZhIvSGDoqJp6wMLZSXzlLV+HQcg1fucPXgbTqf6W4J38nKMdE/zPD
         xWnQMGdQS78B01r9Vl10hhJpk1KnZ251oYrbYXmwJccg5YOeumIldqmZ00OprgkR8+1I
         XuJw==
X-Gm-Message-State: AOJu0YzHCH05a+01Wz79R7YJr/L2ZyKGzkwzs+5JG80esvNDRc3YV/ik
	CdzUCZ7V815+tl+deKObzHwcuCEZQxlbol5dvLD0ZWL1EHaLgg==
X-Google-Smtp-Source: AGHT+IGAiZVOAbahlK853e9lBAb8rm+DtxdE3mGCj7VryIezlI0uyO9U9FExM1kRX3pwdttjeMe10w==
X-Received: by 2002:a7b:cd15:0:b0:40e:5138:a32 with SMTP id f21-20020a7bcd15000000b0040e51380a32mr3068804wmj.145.1705334801856;
        Mon, 15 Jan 2024 08:06:41 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm20174140wmq.44.2024.01.15.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:41 -0800 (PST)
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
Subject: [PATCH v2 2/4] drm/uAPI: Add "force color format" drm property as setting for userspace
Date: Mon, 15 Jan 2024 16:05:52 +0000
Message-ID: <20240115160554.720247-3-andri@yngvason.is>
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

Add a new general drm property "force color format" which can be used
by userspace to tell the graphics driver which color format to use.

Possible options are:
    - auto (default/current behaviour)
    - rgb
    - ycbcr444
    - ycbcr422 (supported by neither amdgpu or i915)
    - ycbcr420

In theory the auto option should choose the best available option for the
current setup, but because of bad internal conversion some monitors look
better with rgb and some with ycbcr444.

Also, because of bad shielded connectors and/or cables, it might be
preferable to use the less bandwidth heavy ycbcr422 and ycbcr420 formats
for a signal that is less susceptible to interference.

In the future, automatic color calibration for screens might also depend on
this option being available.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---

Changes in v2:
 - Renamed to "force color format" from "preferred color format"
 - Removed Reported-by pointing to invalid email address

---
 drivers/gpu/drm/drm_atomic_helper.c |  4 +++
 drivers/gpu/drm/drm_atomic_uapi.c   |  4 +++
 drivers/gpu/drm/drm_connector.c     | 48 +++++++++++++++++++++++++++++
 include/drm/drm_connector.h         | 16 ++++++++++
 4 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 39ef0a6addeba..1dabd164c4f09 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -707,6 +707,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			if (old_connector_state->max_requested_bpc !=
 			    new_connector_state->max_requested_bpc)
 				new_crtc_state->connectors_changed = true;
+
+			if (old_connector_state->force_color_format !=
+			    new_connector_state->force_color_format)
+				new_crtc_state->connectors_changed = true;
 		}
 
 		if (funcs->atomic_check)
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 29d4940188d49..e45949bf4615f 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -776,6 +776,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->max_requested_bpc = val;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		state->privacy_screen_sw_state = val;
+	} else if (property == connector->force_color_format_property) {
+		state->force_color_format = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -859,6 +861,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->max_requested_bpc;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		*val = state->privacy_screen_sw_state;
+	} else if (property == connector->force_color_format_property) {
+		*val = state->force_color_format;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b0516505f7ae9..e0535e58b4535 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1061,6 +1061,14 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
 	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
 };
 
+static const struct drm_prop_enum_list drm_force_color_format_enum_list[] = {
+	{ 0, "auto" },
+	{ DRM_COLOR_FORMAT_RGB444, "rgb" },
+	{ DRM_COLOR_FORMAT_YCBCR444, "ycbcr444" },
+	{ DRM_COLOR_FORMAT_YCBCR422, "ycbcr422" },
+	{ DRM_COLOR_FORMAT_YCBCR420, "ycbcr420" },
+};
+
 DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
 		 drm_dp_subconnector_enum_list)
 
@@ -1396,6 +1404,15 @@ static const u32 dp_colorspaces =
  *	drm_connector_attach_max_bpc_property() to create and attach the
  *	property to the connector during initialization.
  *
+ * force color format:
+ *	This property is used by userspace to change the used color format. When
+ *	used the driver will use the selected format if valid for the hardware,
+ *	sink, and current resolution and refresh rate combination. Drivers to
+ *	use the function drm_connector_attach_force_color_format_property()
+ *	to create and attach the property to the connector during
+ *	initialization. Possible values are "auto", "rgb", "ycbcr444",
+ *	"ycbcr422", and "ycbcr420".
+ *
  * Connectors also have one standardized atomic property:
  *
  * CRTC_ID:
@@ -2457,6 +2474,37 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
 
+/**
+ * drm_connector_attach_force_color_format_property - attach "force color format" property
+ * @connector: connector to attach force color format property on.
+ *
+ * This is used to add support for selecting a color format on a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_force_color_format_property(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (!connector->force_color_format_property) {
+		prop = drm_property_create_enum(dev, 0, "force color format",
+						drm_force_color_format_enum_list,
+						ARRAY_SIZE(drm_force_color_format_enum_list));
+		if (!prop)
+			return -ENOMEM;
+
+		connector->force_color_format_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop, 0);
+	connector->state->force_color_format = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_force_color_format_property);
+
 /**
  * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADA" property
  * @connector: connector to attach the property on.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index fe88d7fc6b8f4..9830e7c09c0ba 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1026,6 +1026,14 @@ struct drm_connector_state {
 	 */
 	enum drm_privacy_screen_status privacy_screen_sw_state;
 
+	/**
+	 * @force_color_format: Property set by userspace to tell the GPU
+	 * driver which color format to use. It only gets applied if hardware,
+	 * meaning both the computer and the monitor, and the driver support the
+	 * given format at the current resolution and refresh rate.
+	 */
+	u32 force_color_format;
+
 	/**
 	 * @hdr_output_metadata:
 	 * DRM blob property for HDR output metadata
@@ -1699,6 +1707,12 @@ struct drm_connector {
 	 */
 	struct drm_property *privacy_screen_hw_state_property;
 
+	/**
+	 * @force_color_format_property: Default connector property for the
+	 * force color format to be driven out of the connector.
+	 */
+	struct drm_property *force_color_format_property;
+
 #define DRM_CONNECTOR_POLL_HPD (1 << 0)
 #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
 #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
@@ -2053,6 +2067,8 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+int drm_connector_attach_force_color_format_property(struct drm_connector *connector);
+
 /**
  * struct drm_tile_group - Tile group metadata
  * @refcount: reference count
-- 
2.43.0


