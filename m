Return-Path: <linux-kernel+bounces-119378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561188C7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E121F2CB03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612D14037C;
	Tue, 26 Mar 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0vxuehs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355D13D28E;
	Tue, 26 Mar 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467684; cv=none; b=hxfuFECROJCXVgNqxIx2yHskzXOjtCsW2qrJeiOHvhDVGw+G3tVsxj/fqgiRnmM0Owweou5f07HE8ugSvx/PUxfHnr5PMCtJ/7AVExJOA8NIaL+HvGh40GXQ3C3R3FwuCEpyXCGeRCVxIU5rpW4RHyNtI2/5NOC+8krjog9oj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467684; c=relaxed/simple;
	bh=PJN1OHyYE0CkZQDnbXihywPPQJ4Gfxn5J0vRF99as+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/rUXUbSfOivgfbh0BtPrJvn5zTI1rvs6mUFDthQN5WQK5D1GwDUs0NKDaRbcisF0AJ9m/Z9WjhJJqIXi+6OsVG/rlsnaV04AfpSPLYu4kYQ+SZDFbKHQdFD6I4yFnBFJLoQ3OCS4SJMD4yMwz7XdGlU1K23/A61a8yyGQkfpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0vxuehs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52497C433F1;
	Tue, 26 Mar 2024 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467684;
	bh=PJN1OHyYE0CkZQDnbXihywPPQJ4Gfxn5J0vRF99as+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A0vxuehstW0jRDw/3gL/oLecuBWLHsv4zWj19t9+Bn/Lm7r18lVoqIJ4FIqL8djzA
	 Di5pOmIyMETf9OmLi3X+3xAk3bYAWG2OsNBERO+9Gd+S3Wt6BTWEMeomdfhRayoutd
	 02pIAMumA3eq6ipBJnXx12UXoRO1NQrXpqottj+ja0p3oHTlV2k7228O40cHl83z7M
	 UYIIVttFF5EMMpiqLiIQIf5DA8/Av9Hlmk4wFDgXnUnVVwUalDx9C4rCju3NQAxM9B
	 Vk7jXG18TsJTZ02INmiMWZRpkRuLARZElFFvmmVY3X8cevGAaCSOnhpHlz89euSUdD
	 LA2L1/pBlj9OQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 Mar 2024 16:40:23 +0100
Subject: [PATCH v11 19/28] drm/connector: hdmi: Add RGB Quantization Range
 to the connector state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-kms-hdmi-connector-state-v11-19-c5680ffcf261@kernel.org>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
In-Reply-To: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Sebastian Wick <sebastian.wick@redhat.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4104; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PJN1OHyYE0CkZQDnbXihywPPQJ4Gfxn5J0vRF99as+s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGlMb9I3p9671n865Id7uOCruZFyx6bZnpD8sMjWs3WWT
 auj1PVdHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi7+MY6x33Lc27Y7FB4fq/
 rNKbt+crx3yUCPz14Uum9t6Ixv8cWR/OpWtJLWU8nmD7orm64sveAMaGh+5bt3eaC2ktLdO+IK2
 b+22pikVh9XbF2fETT6oq7mYt+iLtq7muv91jg/5WXl/RO78B
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
index c844cbeb675b..e693fe51abf5 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -49,10 +49,37 @@ connector_state_get_mode(const struct drm_connector_state *conn_state)
 		return NULL;
 
 	return &crtc_state->mode;
 }
 
+static bool hdmi_is_full_range(const struct drm_connector *connector,
+			       const struct drm_connector_state *conn_state)
+{
+	const struct drm_display_info *display = &connector->display_info;
+	const struct drm_display_mode *mode =
+		connector_state_get_mode(conn_state);
+
+	/*
+	 * The Broadcast RGB property only applies to RGB format, and
+	 * i915 just assumes limited range for YCbCr output, so let's
+	 * just do the same.
+	 */
+	if (conn_state->hdmi.output_format != HDMI_COLORSPACE_RGB)
+		return false;
+
+	if (conn_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_FULL)
+		return true;
+
+	if (conn_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+		return false;
+
+	if (!display->is_hdmi)
+		return true;
+
+	return drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_FULL ? true : false;
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
 
+	new_conn_state->hdmi.is_full_range = hdmi_is_full_range(connector, new_conn_state);
+
 	ret = hdmi_compute_config(connector, new_conn_state, mode);
 	if (ret)
 		return ret;
 
 	if (old_conn_state->hdmi.broadcast_rgb != new_conn_state->hdmi.broadcast_rgb ||
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3e57d98d8418..ec6c6beda5c9 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1145,10 +1145,11 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
 	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB) {
 		drm_printf(p, "\tbroadcast_rgb=%s\n",
 			   drm_hdmi_connector_get_broadcast_rgb_name(state->hdmi.broadcast_rgb));
+		drm_printf(p, "\tis_full_range=%c\n", state->hdmi.is_full_range ? 'y' : 'n');
 		drm_printf(p, "\toutput_bpc=%u\n", state->hdmi.output_bpc);
 		drm_printf(p, "\toutput_format=%s\n",
 			   drm_hdmi_connector_get_output_format_name(state->hdmi.output_format));
 		drm_printf(p, "\ttmds_char_rate=%llu\n", state->hdmi.tmds_char_rate);
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a40eaf3a8ce4..f5e960e89de3 100644
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
+		bool is_full_range;
+
 		/**
 		 * @output_bpc: Bits per color channel to output.
 		 */
 		unsigned int output_bpc;
 

-- 
2.44.0


