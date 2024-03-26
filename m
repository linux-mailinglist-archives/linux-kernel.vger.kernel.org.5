Return-Path: <linux-kernel+bounces-119368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868DA88C7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41181322D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F813E3F1;
	Tue, 26 Mar 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTESZzTv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A113E057;
	Tue, 26 Mar 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467657; cv=none; b=if9YKbNR94PE1PGXfxCuWML+CAwB1kt4QJs2yKb6Wnsssb2czGK3Q5wuMQLdMALSQIrQcgME0Zuh28CfSjkz1Jsf7LE+lcONA6oixB3twrluJuPB0lKthQv88lXc4JvCeJaSWaDSpueMqWqTtPpyLVHiiyB7lywItjn5WXayJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467657; c=relaxed/simple;
	bh=ZS3wISB0X/kpWLhWogqJqYoscE5+wIH8Om8Y+yVdq+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VC9clhM3qtMF8YzrWM6wRHCEoT+BVVnqumjcUc0ejO49K7N8eAb1H/wksiAUmyTrbyr61SChSipz8fhXXNfAuZ/pLs7ybXf8/b6XdgujJOywtqrYmlmDjGAi/oZMDC0Va40pXi8fk78iu81qpOUk+MeMjaigSYrPgniWGZ7qvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTESZzTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B99C433F1;
	Tue, 26 Mar 2024 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467657;
	bh=ZS3wISB0X/kpWLhWogqJqYoscE5+wIH8Om8Y+yVdq+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MTESZzTvtZX7Al2McGXBjbqxhwa2AQckfMaF/LBiQu1AokgzSuzfrXwH0O2lcgOzp
	 owZfBl6UNydsnfN/g3z6rAkIuI3ZjqUlfoW9+lIMh/fDtxEpYjotXpzV1KX+E4zxDB
	 P8l4p27bn5xdWuhR/Blxsknu6JbDsgpUdvOuzJv2Agx6TI9JmmV2zPnV+KvPU9b9LH
	 6JOLl1djw1Xi2K8fTYer4S+3avm32owl8Y5OqN2hkGIn6kxpDgHys4su7G9mNmPiOx
	 tefmFuwXWB8essZR9Mtkt/qAW/9AhLWzMNbDhR+NsuMhoKkSHp1R1iyfsIRil/7dvU
	 fA6nuVsxGEkIg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 Mar 2024 16:40:13 +0100
Subject: [PATCH v11 09/28] drm/display: hdmi: Add HDMI compute clock helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-kms-hdmi-connector-state-v11-9-c5680ffcf261@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3675; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZS3wISB0X/kpWLhWogqJqYoscE5+wIH8Om8Y+yVdq+w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGlMb5KixIxX/k3k4XbKORnb/3ftnRNWj66qLi8RvX3u5
 aclP56/75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+faWseFbTY7Hiv5TDj3/
 q39q1M9oLnupqnmu4+i62gVrKlNUPddXHXq9/z57lQ1X/a0WkeL4g4wN7beNNz+dMUvVbUuR2Gn
 DzjdXg5u7kr+Ul3erOZad+Vx3iJfrnYqtqFjWwfAHyWJvWWoB
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
 drivers/gpu/drm/display/drm_hdmi_helper.c | 70 +++++++++++++++++++++++++++++++
 include/drm/display/drm_hdmi_helper.h     |  4 ++
 2 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index faf5e9efa7d3..2518dd1a07e7 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -193,5 +193,75 @@ void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
 	}
 
 	frame->itc = conn_state->content_type != DRM_MODE_CONTENT_TYPE_NO_DATA;
 }
 EXPORT_SYMBOL(drm_hdmi_avi_infoframe_content_type);
+
+/**
+ * drm_hdmi_compute_mode_clock() - Computes the TMDS Character Rate
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
+drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
+			    unsigned int bpc, enum hdmi_colorspace fmt)
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
+EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
index 76d234826e22..57e3b18c15ec 100644
--- a/include/drm/display/drm_hdmi_helper.h
+++ b/include/drm/display/drm_hdmi_helper.h
@@ -22,6 +22,10 @@ drm_hdmi_infoframe_set_hdr_metadata(struct hdmi_drm_infoframe *frame,
 				    const struct drm_connector_state *conn_state);
 
 void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
 					 const struct drm_connector_state *conn_state);
 
+unsigned long long
+drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
+			    unsigned int bpc, enum hdmi_colorspace fmt);
+
 #endif

-- 
2.44.0


