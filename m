Return-Path: <linux-kernel+bounces-21223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56849828C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6714E1C24C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B73D553;
	Tue,  9 Jan 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="V/emrowL"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB13D54E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso34426705e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704823904; x=1705428704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FOig009jjEjeh+vnprQEku+JrOLkbdtfCg1b2Ndzfw=;
        b=V/emrowLlMo7scB/HM3bojKlx9zLBgGmFXHveB3ahM1LwP/FdW3M6Q1VY75XPuegLo
         Oup0i50h7Msl1bjREO+24D5N39xo2o775I3K7lLpin9vftkL+T8vAd5gpqTxUL6/LMie
         g+cfp66SDqPQDUylggj7Cczgq9e0uovyL4MNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823904; x=1705428704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FOig009jjEjeh+vnprQEku+JrOLkbdtfCg1b2Ndzfw=;
        b=ZJrOhWf7mpVnJQ7O48AhDfXHHXYW4YpEFMwewoODUcUjT/IWq4GYWsx1AlGNgaoDk7
         vgK6rZJ6YE4pLYsoIW1VFHPq9IjNeOcuqAe+i8s6rC66GxcIi0knq6ezwinnQtj9fzSi
         AmXiq6YFgca1czguZlqv833p0VIb2ATVlBmT563jM9sygtCoWvyAwl/0KLNWuyp6GmcY
         c3glNVaKTdN9mjAOeRO6kYOoZsi8XOoL44zI1gY9O/VuU0CtZhK3o9c/p8jF15q6gEUC
         ZuImPykbrYgku5hClaeDe+1sK8vx4YmzroH9poi7oMcb+1f+TZPw3atPglZkLkZICZse
         vk4Q==
X-Gm-Message-State: AOJu0YzJTTll4uGlchDsVDX2Vmra/AHt04mlw1JQE/EW0nGWfEQJJZkl
	URhm95nn/J9X1rOB409SevNd5IBwkpd/Bw==
X-Google-Smtp-Source: AGHT+IFzA8uBOAMbRxLaFNUGf0cxS9vZD5/6R/qJ13W5c3i448PbrK2IbE7snX+W95EFhYkD/m0DGA==
X-Received: by 2002:a7b:ce10:0:b0:40e:4572:57ea with SMTP id m16-20020a7bce10000000b0040e457257eamr1973874wmc.65.1704823904568;
        Tue, 09 Jan 2024 10:11:44 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b0040e527602c8sm2104579wms.9.2024.01.09.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:11:44 -0800 (PST)
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
	Dan Carpenter <dan.carpenter@oracle.com>,
	Andri Yngvason <andri@yngvason.is>
Subject: [PATCH 5/7] drm/uAPI: Add "preferred color format" drm property as setting for userspace
Date: Tue,  9 Jan 2024 18:11:02 +0000
Message-ID: <20240109181104.1670304-6-andri@yngvason.is>
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

Add a new general drm property "preferred color format" which can be used
by userspace to tell the graphic drivers to which color format to use.

Possible options are:
    - auto (default/current behaviour)
    - rgb
    - ycbcr444
    - ycbcr422 (not supported by both amdgpu and i915)
    - ycbcr420

In theory the auto option should choose the best available option for the
current setup, but because of bad internal conversion some monitors look
better with rgb and some with ycbcr444.

Also, because of bad shielded connectors and/or cables, it might be
preferable to use the less bandwidth heavy ycbcr422 and ycbcr420 formats
for a signal that is less deceptible to interference.

In the future, automatic color calibration for screens might also depend on
this option being available.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/gpu/drm/drm_atomic_helper.c |  4 +++
 drivers/gpu/drm/drm_atomic_uapi.c   |  4 +++
 drivers/gpu/drm/drm_connector.c     | 50 ++++++++++++++++++++++++++++-
 include/drm/drm_connector.h         | 17 ++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 68ffcc0b00dca..745a43d9c5da3 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -707,6 +707,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			if (old_connector_state->max_requested_bpc !=
 			    new_connector_state->max_requested_bpc)
 				new_crtc_state->connectors_changed = true;
+
+			if (old_connector_state->preferred_color_format !=
+			    new_connector_state->preferred_color_format)
+				new_crtc_state->connectors_changed = true;
 		}
 
 		if (funcs->atomic_check)
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 98d3b10c08ae1..eba5dea1249e5 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -798,6 +798,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->max_requested_bpc = val;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		state->privacy_screen_sw_state = val;
+	} else if (property == connector->preferred_color_format_property) {
+		state->preferred_color_format = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -881,6 +883,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->max_requested_bpc;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		*val = state->privacy_screen_sw_state;
+	} else if (property == connector->preferred_color_format_property) {
+		*val = state->preferred_color_format;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 30d62e505d188..4de48a38792cf 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1061,6 +1061,14 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
 	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
 };
 
+static const struct drm_prop_enum_list drm_preferred_color_format_enum_list[] = {
+	{ 0, "auto" },
+	{ DRM_COLOR_FORMAT_RGB444, "rgb" },
+	{ DRM_COLOR_FORMAT_YCBCR444, "ycbcr444" },
+	{ DRM_COLOR_FORMAT_YCBCR422, "ycbcr422" },
+	{ DRM_COLOR_FORMAT_YCBCR420, "ycbcr420" },
+};
+
 static const struct drm_prop_enum_list drm_active_color_format_enum_list[] = {
 	{ 0, "not applicable" },
 	{ DRM_COLOR_FORMAT_RGB444, "rgb" },
@@ -1398,11 +1406,20 @@ static const u32 dp_colorspaces =
  *	drm_connector_attach_max_bpc_property() to create and attach the
  *	property to the connector during initialization.
  *
+ * preferred color format:
+ *	This property is used by userspace to change the used color format. When
+ *	used the driver will use the selected format if valid for the hardware,
+ *	sink, and current resolution and refresh rate combination. Drivers to
+ *	use the function drm_connector_attach_preferred_color_format_property()
+ *	to create and attach the property to the connector during
+ *	initialization. Possible values are "auto", "rgb", "ycbcr444",
+ *	"ycbcr422", and "ycbcr420".
+ *
  * active color format:
  *	This read-only property tells userspace the color format actually used
  *	by the hardware display engine "on the cable" on a connector. The chosen
  *	value depends on hardware capabilities, both display engine and
- *	connected monitor. Drivers shall use
+ *	connected monitor, and the "preferred color format". Drivers shall use
  *	drm_connector_attach_active_color_format_property() to install this
  *	property. Possible values are "not applicable", "rgb", "ycbcr444",
  *	"ycbcr422", and "ycbcr420".
@@ -2468,6 +2485,37 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
 
+/**
+ * drm_connector_attach_preferred_color_format_property - attach "preferred color format" property
+ * @connector: connector to attach preferred color format property on.
+ *
+ * This is used to add support for selecting a color format on a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_preferred_color_format_property(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (!connector->preferred_color_format_property) {
+		prop = drm_property_create_enum(dev, 0, "preferred color format",
+						drm_preferred_color_format_enum_list,
+						ARRAY_SIZE(drm_preferred_color_format_enum_list));
+		if (!prop)
+			return -ENOMEM;
+
+		connector->preferred_color_format_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop, 0);
+	connector->state->preferred_color_format = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_preferred_color_format_property);
+
 /**
  * drm_connector_attach_active_color_format_property - attach "active color format" property
  * @connector: connector to attach active color format property on.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 9ae73cfdceeb1..d7bc54c8b42cb 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1026,6 +1026,16 @@ struct drm_connector_state {
 	 */
 	enum drm_privacy_screen_status privacy_screen_sw_state;
 
+	/**
+	 * preferred_color_format: Property set by userspace to tell the GPU
+	 * driver which color format to use. It only gets applied if hardware,
+	 * meaning both the computer and the monitor, and the driver support the
+	 * given format at the current resolution and refresh rate. Userspace
+	 * can check for (un-)successful application via the "active color
+	 * format" property.
+	 */
+	u32 preferred_color_format;
+
 	/**
 	 * @hdr_output_metadata:
 	 * DRM blob property for HDR output metadata
@@ -1699,6 +1709,12 @@ struct drm_connector {
 	 */
 	struct drm_property *privacy_screen_hw_state_property;
 
+	/**
+	 * @preferred_color_format_property: Default connector property for the
+	 * preferred color format to be driven out of the connector.
+	 */
+	struct drm_property *preferred_color_format_property;
+
 	/**
 	 * @active_color_format_property: Default connector property for the
 	 * active color format to be driven out of the connector.
@@ -2059,6 +2075,7 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+int drm_connector_attach_preferred_color_format_property(struct drm_connector *connector);
 int drm_connector_attach_active_color_format_property(struct drm_connector *connector);
 void drm_connector_set_active_color_format_property(struct drm_connector *connector,
 						    u32 active_color_format);
-- 
2.43.0


