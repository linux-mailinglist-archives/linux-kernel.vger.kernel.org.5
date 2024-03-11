Return-Path: <linux-kernel+bounces-99016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919BA878267
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4871A283A53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DFB56B7F;
	Mon, 11 Mar 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHLhhgL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900F56B66;
	Mon, 11 Mar 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168652; cv=none; b=dVSEtfii5KZzsF88i5utnHfuJ85twhNy7TZqKlPP3+EWXua4X4oCoEq0T4j3hlz38qvSZlGXP/iFtn9CYVsB/gpGnAKD+AMl3fFMyvLoqaPUDPlKKD0h6zQvrrqq+EuoLi1lVH4U5K8+yLpwho+Apn3KJLI754RBROV+d3K6MCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168652; c=relaxed/simple;
	bh=PB5uZMP81Svihtcjmn3oN1XmVQnFwiL8nPkDTykrcLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqgrG0GgWrwSCGZs+Yws+jutKwOe1OvyGhLMI3aLuex2MCQai3/mzthEsEaSqvZKoVE3xZLmvOM3ZEStGGI5tM+dIUmukvmBKT/lPsMcIu7lvhYUS+cVbebPUxd4e+M11pmWO/Su9yFW+pu6RH0zjTMyqC/XzvkHDuv3N8HKiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHLhhgL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27697C43390;
	Mon, 11 Mar 2024 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710168652;
	bh=PB5uZMP81Svihtcjmn3oN1XmVQnFwiL8nPkDTykrcLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HHLhhgL0z6zZ58+62ouYTmjVoG++B2jJO91V/QTUckdDVZKE2TTJOI0ix5eU+IcMy
	 WlO5iQDfKEzjPrLxjzCirmoPJvpZyNZLQOgevwX1jY3xQT6NsIJaKB+rh3M9/BqNTi
	 2YaAN9jJI2yDBaLFM9DrTkBYLdAQjyzp7PJFov/rv0Q8gH2xxKVUBsenFWOifXYo/3
	 Dn1X/SgElh3m1AiZ1s+ux0+Pn5Jc07Bv0OoU1ZqzKv/1CPFVF43acATdA+tgdbVy8i
	 bx4dhP9B0ZwtEJTGZFTql9b35XontsPz/WV9CPbpI9Ds5og5FRHLP8R78PitMKQtu3
	 Dox4sli7kYk8Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 11 Mar 2024 15:49:46 +0100
Subject: [PATCH v9 18/27] drm/connector: hdmi: Add RGB Quantization Range
 to the connector state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-kms-hdmi-connector-state-v9-18-d45890323344@kernel.org>
References: <20240311-kms-hdmi-connector-state-v9-0-d45890323344@kernel.org>
In-Reply-To: <20240311-kms-hdmi-connector-state-v9-0-d45890323344@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PB5uZMP81Svihtcjmn3oN1XmVQnFwiL8nPkDTykrcLI=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnvpQSOr9k4Kyap8/PUucy/P5et4puWyvJxd6dl7xOt/
 4LpwqnhHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZiIWxIjQ4dIyLcV6u7sm8L4
 Yj00TqhKteitDzAV/3o5qvLjhg+8QQz/nbjDdhUvVlT7xuHcvlZd+ObjDVa8Bx/PM9+/4PyV/Mp
 CTgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

HDMI controller drivers will need to figure out the RGB range they need
to configure based on a mode and property values. Let's expose that in
the HDMI connector state so drivers can just use that value.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c              |  1 +
 drivers/gpu/drm/drm_atomic_state_helper.c | 29 +++++++++++++++++++++++++++++
 include/drm/drm_connector.h               |  6 ++++++
 3 files changed, 36 insertions(+)

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
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 0e8fb653965a..e66272c0d006 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -662,10 +662,37 @@ connector_state_get_mode(const struct drm_connector_state *conn_state)
 		return NULL;
 
 	return &crtc_state->mode;
 }
 
+static bool hdmi_is_full_range(const struct drm_connector *connector,
+			       const struct drm_connector_state *state)
+{
+	const struct drm_display_info *display = &connector->display_info;
+	const struct drm_display_mode *mode =
+		connector_state_get_mode(state);
+
+	/*
+	 * The Broadcast RGB property only applies to RGB format, and
+	 * i915 just assumes limited range for YCbCr output, so let's
+	 * just do the same.
+	 */
+	if (state->hdmi.output_format != HDMI_COLORSPACE_RGB)
+		return false;
+
+	if (state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_FULL)
+		return true;
+
+	if (state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
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
@@ -908,10 +935,12 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		drm_atomic_get_new_connector_state(state, connector);
 	const struct drm_display_mode *mode =
 		connector_state_get_mode(new_state);
 	int ret;
 
+	new_state->hdmi.is_full_range = hdmi_is_full_range(connector, new_state);
+
 	ret = hdmi_compute_config(connector, new_state, mode);
 	if (ret)
 		return ret;
 
 	if (old_state->hdmi.broadcast_rgb != new_state->hdmi.broadcast_rgb ||
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index bb6b6a36ade3..3eaf4d54364d 100644
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
2.43.2


