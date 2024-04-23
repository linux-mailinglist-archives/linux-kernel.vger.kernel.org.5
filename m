Return-Path: <linux-kernel+bounces-154911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E158AE2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61238282072
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85398137744;
	Tue, 23 Apr 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc84L7Vl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DF136E07;
	Tue, 23 Apr 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869199; cv=none; b=btsU4k9D45qKu2vgcD5hBk5VjxH7KbygMqZ0WLUt3nqBH9TvaX5Bnr+4S9MSdmfnGCs9Q+W2LzgmsFuGn6AqD7iFVVYgUn97nKnR7Y2GIX9UpYkQWOOM2vjL77Onv9v0iIew9SZqhdPRH6Jl4K+qWsyk9vbdNnQPqFVN43GxFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869199; c=relaxed/simple;
	bh=qzfgVKbyx/ZW6EQh/njMwRTT7IngtuLEE0DO8Z6nLmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJJMmVsCHWKgdB+YYjgwPdN+niG/6uSh5cBjv8oZ5Ju+jGTdNcIrInMEsbuudkFq3YzP9Cw4fdeNObLiarv0TdSXjKjxu2vXOkLKq9YX4bU0hOEk0a3Eps0NKgySCrm2J9vXxak8BJxoWJP2UcEH9UuFNKchzUvpzwlqo3Q8sgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc84L7Vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DC4C3277B;
	Tue, 23 Apr 2024 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713869199;
	bh=qzfgVKbyx/ZW6EQh/njMwRTT7IngtuLEE0DO8Z6nLmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nc84L7Vlie4XE7EFg2aBGIbnv/s+ItZsOrlr0m+hqshd0pC8fDC+PVSJhW0dW6ZJT
	 R6novmjtviPf+eOwmzY7xW/HYjad3/1e46JK3VpRF9hKFWGr1U9y/9kseLR128MQRc
	 /eotbdZvivBTEZKfwkG1U/nj7e5m7clyUzDKCpuEvQMCiylqtjUo0tYww4K39B8yQR
	 Nio5bsX0yR/MS/RDzcZwgT7O3r5rEmbHKJjrl7QMJy/T5qSZKkLfYKLpaofRkb9u9o
	 niy4HrJAasTCPhVn+YFHkqAgxbbQLjqN9k9TFTIKGs0scVstZdYn+Jbbc+sAu/1MLf
	 RNvcgydp65tUA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 23 Apr 2024 12:45:48 +0200
Subject: [PATCH v12 19/28] drm/connector: hdmi: Add RGB Quantization Range
 to the connector state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-kms-hdmi-connector-state-v12-19-3338e4c0b189@kernel.org>
References: <20240423-kms-hdmi-connector-state-v12-0-3338e4c0b189@kernel.org>
In-Reply-To: <20240423-kms-hdmi-connector-state-v12-0-3338e4c0b189@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Sebastian Wick <sebastian.wick@redhat.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qzfgVKbyx/ZW6EQh/njMwRTT7IngtuLEE0DO8Z6nLmY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGnqE4MN5wsHvg2L5/h/2TRgpVf1QtNtXDZ/XRLsjb48d
 2TdnHe2YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykVoWxYZo0h5Jo0oQG5t11
 WzN1P9699DPyq/i2PdeVMp2eP1VzKJBqyo15d/vc429/XOTm3zgfzVgroRU8pcngTdOfFzwKOh+
 0d5d6xeer+Kp/yRdp6nzOJzwlVU7LZKnLldtz+5Kyqpq3qwMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

HDMI controller drivers will need to figure out the RGB range they need
to configure based on a mode and property values. Let's expose that in
the HDMI connector state so drivers can just use that value.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 29 +++++++++++++++++++++++++
 drivers/gpu/drm/drm_atomic.c                    |  1 +
 include/drm/drm_connector.h                     |  6 +++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c844cbeb675b..6be3a7d9e0cc 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -49,10 +49,37 @@ connector_state_get_mode(const struct drm_connector_state *conn_state)
 		return NULL;
 
 	return &crtc_state->mode;
 }
 
+static bool hdmi_is_limited_range(const struct drm_connector *connector,
+				  const struct drm_connector_state *conn_state)
+{
+	const struct drm_display_info *info = &connector->display_info;
+	const struct drm_display_mode *mode =
+		connector_state_get_mode(conn_state);
+
+	/*
+	 * The Broadcast RGB property only applies to RGB format, and
+	 * i915 just assumes limited range for YCbCr output, so let's
+	 * just do the same.
+	 */
+	if (conn_state->hdmi.output_format != HDMI_COLORSPACE_RGB)
+		return true;
+
+	if (conn_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_FULL)
+		return false;
+
+	if (conn_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+		return true;
+
+	if (!info->is_hdmi)
+		return false;
+
+	return drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
+}
+
 static bool
 sink_supports_format_bpc(const struct drm_connector *connector,
 			 const struct drm_display_info *info,
 			 const struct drm_display_mode *mode,
 			 unsigned int format, unsigned int bpc)
@@ -307,10 +334,12 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		drm_atomic_get_new_connector_state(state, connector);
 	const struct drm_display_mode *mode =
 		connector_state_get_mode(new_conn_state);
 	int ret;
 
+	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
+
 	ret = hdmi_compute_config(connector, new_conn_state, mode);
 	if (ret)
 		return ret;
 
 	if (old_conn_state->hdmi.broadcast_rgb != new_conn_state->hdmi.broadcast_rgb ||
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3e57d98d8418..07b4b394e3bf 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1145,10 +1145,11 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
 	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB) {
 		drm_printf(p, "\tbroadcast_rgb=%s\n",
 			   drm_hdmi_connector_get_broadcast_rgb_name(state->hdmi.broadcast_rgb));
+		drm_printf(p, "\tis_limited_range=%c\n", state->hdmi.is_limited_range ? 'y' : 'n');
 		drm_printf(p, "\toutput_bpc=%u\n", state->hdmi.output_bpc);
 		drm_printf(p, "\toutput_format=%s\n",
 			   drm_hdmi_connector_get_output_format_name(state->hdmi.output_format));
 		drm_printf(p, "\ttmds_char_rate=%llu\n", state->hdmi.tmds_char_rate);
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a40eaf3a8ce4..1fca26d51218 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1068,10 +1068,16 @@ struct drm_connector_state {
 		 * @broadcast_rgb: Connector property to pass the
 		 * Broadcast RGB selection value.
 		 */
 		enum drm_hdmi_broadcast_rgb broadcast_rgb;
 
+		/**
+		 * @is_full_range: Is the output supposed to use a full
+		 * RGB Quantization Range or not?
+		 */
+		bool is_limited_range;
+
 		/**
 		 * @output_bpc: Bits per color channel to output.
 		 */
 		unsigned int output_bpc;
 

-- 
2.44.0


