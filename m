Return-Path: <linux-kernel+bounces-61631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B638514B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04601F21C44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B63F9DC;
	Mon, 12 Feb 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1MN1sec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB03F9C4;
	Mon, 12 Feb 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743656; cv=none; b=fJjvRpcZVq1Bh+boWFpFwBhdFyOUHuJ9DjpJ7rmgoh+22A083MMKXvWcFqC6t6WtOKKgnOHaVzQuBaJOCdkc46vNkDRIwg802yLFcO1C0H8fPwPUFPkD1JPjwTcGRAv25NFVoaOKXYWhOy0/w8Rtv1Tp7U9KUpBJ8hLz5jcqZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743656; c=relaxed/simple;
	bh=s5W/xSAdD1+rl96fJKi18NgBJWzOCTMahxkAxJFesPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHoF+lrmWsO9WTttoBWXRx98X3ZYjmY/sgOh9a5A77UzDCvNkkgqBwIgdh43J88ZYevbx2OeEG+7pR2soVC6JxRG0elhVuSplDb+zprMyYm3Rq7u45SunqE5/HqCJsrF3BtvscX91Wp1Yu7nI4ifxQJR0PfcJe68NgcIUM8LNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1MN1sec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D21C43390;
	Mon, 12 Feb 2024 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743656;
	bh=s5W/xSAdD1+rl96fJKi18NgBJWzOCTMahxkAxJFesPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q1MN1secIYCFbTnoKCzZKJf5MRpdSH4v4ih46cyrxLB1pWAIJ66jKTuM9mk6XokKc
	 bRCxg5Ri5iGvZ86KzDmfr1RGwT6xGztKaR+PYJzWeOqcfaD6wU/oNLk/RZNSyiydqE
	 c7qZrw3SDCX75q6mGib4SYStbsgzyMQzaVCRAX8RGLmXra3sAWftruAO1F9uZWCSou
	 GxaNK2r+tpsKCW5TOV1EjAfC+0tOWBe9u1cmB7LKKpP+iEMeJdfHDuarfBFehruVDN
	 F5lhOtpo9M+YO1R5hyxiu87H0Qu7XI9lMOykzp3m8RryVD0NRL4BzEMmJbocUpTNsJ
	 ryUiW8GefFtVg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:13:00 +0100
Subject: [PATCH v6 17/36] drm/connector: hdmi: Add HDMI compute clock
 helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-17-f4bcdc979e6f@kernel.org>
References: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
In-Reply-To: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, 
 Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4017; i=mripard@kernel.org;
 h=from:subject:message-id; bh=s5W/xSAdD1+rl96fJKi18NgBJWzOCTMahxkAxJFesPk=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJDMKZI1Pz/wlzNsgN231LvETAWeq1XNt/5etaroy6
 +/NYufIjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEyER4/hn/mGgwdXN2sE3rpv
 I2b/8mZ+D2PB5vb33g+YtvQq9LCHiTD8lbt97uBup1UeFzv/tLb0Vch/79pxRmGFshOP+dbjl6O
 e8AMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

A lot of HDMI drivers have some variation of the formula to calculate
the TMDS character rate from a mode, but few of them actually take all
parameters into account.

Let's create a helper to provide that rate taking all parameters into
account.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_connector.c | 71 +++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  5 +++
 2 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b895bea667f7..332477c6a987 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2982,6 +2982,77 @@ void drm_connector_update_privacy_screen(const struct drm_connector_state *conne
 }
 EXPORT_SYMBOL(drm_connector_update_privacy_screen);
 
+/**
+ * drm_connector_hdmi_compute_mode_clock() - Computes the TMDS Character Rate
+ * @mode: Display mode to compute the clock for
+ * @bpc: Bits per character
+ * @fmt: Output Pixel Format used
+ *
+ * Returns the TMDS Character Rate for a given mode, bpc count and output format.
+ *
+ * RETURNS:
+ * The TMDS Character Rate, in Hertz, or 0 on error.
+ */
+unsigned long long
+drm_connector_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
+				      unsigned int bpc,
+				      enum hdmi_colorspace fmt)
+{
+	unsigned long long clock = mode->clock * 1000ULL;
+	unsigned int vic = drm_match_cea_mode(mode);
+
+	/*
+	 * CTA-861-G Spec, section 5.4 - Color Coding and Quantization
+	 * mandates that VIC 1 always uses 8 bpc.
+	 */
+	if (vic == 1 && bpc != 8)
+		return 0;
+
+	/*
+	 * HDMI 2.0 Spec, section 7.1 - YCbCr 4:2:0 Pixel Encoding
+	 * specifies that YUV420 encoding is only available for those
+	 * VICs.
+	 */
+	if (fmt == HDMI_COLORSPACE_YUV420 &&
+	    !(vic == 96 || vic == 97 || vic == 101 ||
+	      vic == 102 || vic == 106 || vic == 107))
+		return 0;
+
+	if (fmt == HDMI_COLORSPACE_YUV422) {
+		/*
+		 * HDMI 1.4b Spec, section 6.2.3 - Pixel Encoding Requirements
+		 * specifies that YUV422 is 36-bit only.
+		 */
+		if (bpc != 12)
+			return 0;
+
+		/*
+		 * HDMI 1.0 Spec, section 6.5 - Pixel Encoding
+		 * specifies that YUV422 requires two 12-bits components per
+		 * pixel clock, which is equivalent in our calculation to three
+		 * 8-bits components
+		 */
+		bpc = 8;
+	}
+
+	/*
+	 * HDMI 2.0 Spec, Section 7.1 - YCbCr 4:2:0 Pixel Encoding
+	 * specifies that YUV420 encoding is carried at a TMDS Character Rate
+	 * equal to half the pixel clock rate.
+	 */
+	if (fmt == HDMI_COLORSPACE_YUV420)
+		clock = clock / 2;
+
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
+		clock = clock * 2;
+
+	clock = clock * bpc;
+	do_div(clock, 8);
+
+	return clock;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_compute_mode_clock);
+
 int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 				    struct drm_property *property,
 				    uint64_t value)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 74db5ce47e01..0cc5a8732664 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -38,6 +38,7 @@ struct drm_connector_helper_funcs;
 struct drm_modeset_acquire_ctx;
 struct drm_device;
 struct drm_crtc;
+struct drm_display_mode;
 struct drm_encoder;
 struct drm_panel;
 struct drm_property;
@@ -2136,6 +2137,10 @@ void drm_connector_attach_privacy_screen_properties(struct drm_connector *conn);
 void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
+unsigned long long
+drm_connector_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
+				      unsigned int bpc,
+				      enum hdmi_colorspace fmt);
 
 /**
  * struct drm_tile_group - Tile group metadata

-- 
2.43.0


