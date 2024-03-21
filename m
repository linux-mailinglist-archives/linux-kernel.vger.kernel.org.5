Return-Path: <linux-kernel+bounces-110249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B10885C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548291F26462
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFAD12C556;
	Thu, 21 Mar 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmG7GGX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DEC12C540;
	Thu, 21 Mar 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035044; cv=none; b=IlIQrbip5Kq9PkT7xOyRz+X49MOCf3v6Oo1yNHZbfqKDhmxS0RyfSYIPwfdnj+61OXjJXf8nuy4rBBQN2ro/oug/xfYbrnAfsuq89Ep7e8+BaHdO909JVzfnuejiZj3UyfDrHNR5fV+c9B33FoLrR37oBCwK4cJ2pSaFKiv3mHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035044; c=relaxed/simple;
	bh=0BOJwsJkmVC7ISwyuAdKqvHspV8sorXf1ygF6kiUUOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0bXJNsX6DKnfef2Jj/LefgAOCcUbCllsDSP0crUlG38AuzaZ9i5wGCc1Qs0tqaSYPjmOmYaPsA4JMHi0xsiI3T7eKvPackerOgdMMjJUuzFdhm+kI4SzBmq9OhetDuBZdkHG2GC6g42wtE+cmDLVJHSRzOAoApdZ9aHd91IH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmG7GGX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A2DC43141;
	Thu, 21 Mar 2024 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035043;
	bh=0BOJwsJkmVC7ISwyuAdKqvHspV8sorXf1ygF6kiUUOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZmG7GGX2U5IClgnL/614IHFa4Vc+uz40X9fqO/LOgBkIIDzXCtOZPc3SGQkv3pGYr
	 32hTqDhkefM6wwsVBvoHdK0XRsik2dhamU/YP2lnDxZlVW4AndYmKFrEi9/kH7TQIi
	 JuGA2EbnZApQ5z7MGEXJ1wZ2MKC+A/TjkVh6zpFrMB8gVxlDdeqRom4V9Rk3/TgH0J
	 TfdlCKt9+S30ZAii2qBuvhicwe1ddL8+PwcxvJ9lFrOpJYnzSN1PLjTcMytI93ZRh7
	 xkWYJA62MK7CUCyqjyRvKsyrAz5oLN6RK4yyFxgG/X1+7qK6tDAndCsEAZ/GUKlFMt
	 UVgpK3nKwxxSA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 21 Mar 2024 16:29:23 +0100
Subject: [PATCH v10 27/27] drm/sun4i: hdmi: Switch to HDMI connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-kms-hdmi-connector-state-v10-27-e6c178361898@kernel.org>
References: <20240321-kms-hdmi-connector-state-v10-0-e6c178361898@kernel.org>
In-Reply-To: <20240321-kms-hdmi-connector-state-v10-0-e6c178361898@kernel.org>
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
 Sui Jingfeng <sui.jingfeng@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7059; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0BOJwsJkmVC7ISwyuAdKqvHspV8sorXf1ygF6kiUUOo=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKl/goJzX3svWJo/8XR2u0Hx5N+9nxX3+wlslBLJuTrft
 9Xt9vfijlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEyEyZORYevuFzX/U0uP3tk/
 uXfORqbE1/FLjBNvVyp+K+z3XWnTmcbI8E2fsaGlz+eydXGbLk/cPLk1c1Mkbu+7e/PW1MSqS+H
 OvAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The new HDMI connector infrastructure allows to remove some boilerplate,
especially to generate infoframes. Let's switch to it.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 80 ++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 2d1880c61b50..7ac085aa0a35 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -35,34 +35,28 @@
 	container_of_const(e, struct sun4i_hdmi, encoder)
 
 #define drm_connector_to_sun4i_hdmi(c)		\
 	container_of_const(c, struct sun4i_hdmi, connector)
 
-static int sun4i_hdmi_setup_avi_infoframes(struct sun4i_hdmi *hdmi,
-					   struct drm_display_mode *mode)
+static int sun4i_hdmi_write_infoframe(struct drm_connector *connector,
+				      enum hdmi_infoframe_type type,
+				      const u8 *buffer, size_t len)
 {
-	struct hdmi_avi_infoframe frame;
-	u8 buffer[17];
-	int i, ret;
+	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
+	int i;
 
-	ret = drm_hdmi_avi_infoframe_from_display_mode(&frame,
-						       &hdmi->connector, mode);
-	if (ret < 0) {
-		DRM_ERROR("Failed to get infoframes from mode\n");
-		return ret;
+	if (type != HDMI_INFOFRAME_TYPE_AVI) {
+		drm_err(connector->dev,
+			"Unsupported infoframe type: %u\n", type);
+		return 0;
 	}
 
-	ret = hdmi_avi_infoframe_pack(&frame, buffer, sizeof(buffer));
-	if (ret < 0) {
-		DRM_ERROR("Failed to pack infoframes\n");
-		return ret;
-	}
-
-	for (i = 0; i < sizeof(buffer); i++)
+	for (i = 0; i < len; i++)
 		writeb(buffer[i], hdmi->base + SUN4I_HDMI_AVI_INFOFRAME_REG(i));
 
 	return 0;
+
 }
 
 static void sun4i_hdmi_disable(struct drm_encoder *encoder,
 			       struct drm_atomic_state *state)
 {
@@ -81,18 +75,22 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder,
 static void sun4i_hdmi_enable(struct drm_encoder *encoder,
 			      struct drm_atomic_state *state)
 {
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
-	struct drm_display_info *display = &hdmi->connector.display_info;
+	struct drm_connector *connector = &hdmi->connector;
+	struct drm_display_info *display = &connector->display_info;
+	struct drm_connector_state *conn_state =
+		drm_atomic_get_new_connector_state(state, connector);
+	unsigned long long tmds_rate = conn_state->hdmi.tmds_char_rate;
 	unsigned int x, y;
 	u32 val = 0;
 
 	DRM_DEBUG_DRIVER("Enabling the HDMI Output\n");
 
-	clk_set_rate(hdmi->mod_clk, mode->crtc_clock * 1000);
-	clk_set_rate(hdmi->tmds_clk, mode->crtc_clock * 1000);
+	clk_set_rate(hdmi->mod_clk, tmds_rate);
+	clk_set_rate(hdmi->tmds_clk, tmds_rate);
 
 	/* Set input sync enable */
 	writel(SUN4I_HDMI_UNKNOWN_INPUT_SYNC,
 	       hdmi->base + SUN4I_HDMI_UNKNOWN_REG);
 
@@ -141,11 +139,12 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder,
 
 	writel(val, hdmi->base + SUN4I_HDMI_VID_TIMING_POL_REG);
 
 	clk_prepare_enable(hdmi->tmds_clk);
 
-	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
+	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
+
 	val |= SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
 	val |= SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
 	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
 
 	val = SUN4I_HDMI_VID_CTRL_ENABLE;
@@ -194,23 +193,26 @@ static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
 	struct drm_crtc_state *crtc_state = crtc->state;
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	enum drm_mode_status status;
 
 	status = sun4i_hdmi_connector_clock_valid(connector, mode,
-						  mode->clock * 1000);
+						  conn_state->hdmi.tmds_char_rate);
 	if (status != MODE_OK)
 		return -EINVAL;
 
 	return 0;
 }
 
 static enum drm_mode_status
 sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
-	return sun4i_hdmi_connector_clock_valid(connector, mode,
-						mode->clock * 1000);
+	unsigned long long rate =
+		drm_connector_hdmi_compute_mode_clock(mode, 8,
+						      HDMI_COLORSPACE_RGB);
+
+	return sun4i_hdmi_connector_clock_valid(connector, mode, rate);
 }
 
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
@@ -252,10 +254,15 @@ static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
 	return ddc;
 }
 
+static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
+	.tmds_char_rate_valid	= sun4i_hdmi_connector_clock_valid,
+	.write_infoframe	= sun4i_hdmi_write_infoframe,
+};
+
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
 	.atomic_check	= sun4i_hdmi_connector_atomic_check,
 	.mode_valid	= sun4i_hdmi_connector_mode_valid,
 	.get_modes	= sun4i_hdmi_get_modes,
 };
@@ -273,15 +280,21 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	}
 
 	return connector_status_connected;
 }
 
+static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
+{
+	drm_atomic_helper_connector_reset(connector);
+	__drm_atomic_helper_connector_hdmi_reset(connector, connector->state);
+}
+
 static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
 	.detect			= sun4i_hdmi_connector_detect,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= drm_atomic_helper_connector_reset,
+	.reset			= sun4i_hdmi_connector_reset,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
 #ifdef CONFIG_DRM_SUN4I_HDMI_CEC
@@ -636,14 +649,23 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 	       hdmi->base + SUN4I_HDMI_CEC);
 #endif
 
 	drm_connector_helper_add(&hdmi->connector,
 				 &sun4i_hdmi_connector_helper_funcs);
-	ret = drm_connector_init_with_ddc(drm, &hdmi->connector,
-					  &sun4i_hdmi_connector_funcs,
-					  DRM_MODE_CONNECTOR_HDMIA,
-					  hdmi->ddc_i2c);
+	ret = drmm_connector_hdmi_init(drm, &hdmi->connector,
+				       /*
+					* NOTE: Those are likely to be
+					* wrong, but I couldn't find the
+					* actual ones in the BSP.
+					*/
+				       "AW", "HDMI",
+				       &sun4i_hdmi_connector_funcs,
+				       &sun4i_hdmi_hdmi_connector_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       hdmi->ddc_i2c,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
 	if (ret) {
 		dev_err(dev,
 			"Couldn't initialise the HDMI connector\n");
 		goto err_cleanup_connector;
 	}

-- 
2.44.0


