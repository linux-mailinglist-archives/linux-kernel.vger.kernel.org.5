Return-Path: <linux-kernel+bounces-61658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA46485150B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF828AF92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625A53381;
	Mon, 12 Feb 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvXtsgUX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971253370;
	Mon, 12 Feb 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743703; cv=none; b=WQRxsG6GdF86ue8jq8fm5RgukeJn6q8nWetau77Mm+dyS7zXRBH1xjX0FRnWb4BEiFWlrGxRY4XvE3xiB8yHgHE2JdolpDPNhO1iS1Hmrt3w/O3EzD97akVLfUCuigNaAg5Fyfnww1KE9nCvAovQsnIiTgVt1HBya/BtUIhBxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743703; c=relaxed/simple;
	bh=ci5SXLQ8r+SDTkTN3qL9hTBNHtCYxbWVXNFozrAXNJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUxaYmKNaGstzl727pHReS52ijnBg0vIGcgyxWt2f+EavW0L1a0JD1uxnF9zSvNhTG+QtBS+MQ7XzCCR5h+Ycr8oa6YuUMXhzyWPmS0AWpKNb+NHdW0bg4fncNEHAwUyrs09RDmbMCpn1e+YhLiUesr7Wv+MKt9A0jAyTk4M8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvXtsgUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F2C43394;
	Mon, 12 Feb 2024 13:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743702;
	bh=ci5SXLQ8r+SDTkTN3qL9hTBNHtCYxbWVXNFozrAXNJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VvXtsgUXImjSaVgCODruwvV9ZumrAAba+6jnvpSbe3tqVwcm1usY6xUnA5mh2I+Xs
	 +tbH2+qIdlc428yek+Ni5uEw9SfnmVDO7LoRDws4lA7qVdzZULTtN35UwvDcKVb76Z
	 qf6uotrOk+PI5uyQ1gKk5IEAuDYYVrsGjV1oYttH8BKNrRD/41mXUizzez3o0UVs/n
	 KNiRAs2LyhfcqQub3iKDicXEUVd4e6xHCE1qznzdrPfchPwjewJN3gwNzlJctfKzGT
	 VxqZlbIekwIdcRciadIPgnvJKZGZAZJJc0LTE88CcVRo3MQNjXD0IfzuFMnj+bqyG7
	 9KFme+OP08DsQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:13:16 +0100
Subject: [PATCH v6 33/36] drm/sun4i: hdmi: Move mode_set into enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-33-f4bcdc979e6f@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Sui Jingfeng <sui.jingfeng@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2857; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ci5SXLQ8r+SDTkTN3qL9hTBNHtCYxbWVXNFozrAXNJ4=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJIvzDAv4tH3yJqdc3GugZLf7sl3hg9i818emV5Z3p
 /yd7m3ZUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIks9GRkePbvT5fXcUe+2WLR
 N851lD5k41nql7V+++NVf0ts3Z+LPWZk+Dh7l+8fsxSHjfPm/TwQOKH3ns5xzos9AmURVRo/Xpi
 tZwcA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We're not doing anything special in atomic_mode_set so we can simply
merge it into atomic_enable.

Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 38 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 799a26215cc2..bae69d696765 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -103,33 +103,11 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder,
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
 	struct drm_display_info *display = &hdmi->connector.display_info;
+	unsigned int x, y;
 	u32 val = 0;
 
 	DRM_DEBUG_DRIVER("Enabling the HDMI Output\n");
 
-	clk_prepare_enable(hdmi->tmds_clk);
-
-	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
-	val |= SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
-	val |= SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
-	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
-
-	val = SUN4I_HDMI_VID_CTRL_ENABLE;
-	if (display->is_hdmi)
-		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
-
-	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
-}
-
-static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
-				struct drm_crtc_state *crtc_state,
-				struct drm_connector_state *conn_state)
-{
-	const struct drm_display_mode *mode = &crtc_state->mode;
-	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
-	unsigned int x, y;
-	u32 val;
-
 	clk_set_rate(hdmi->mod_clk, mode->crtc_clock * 1000);
 	clk_set_rate(hdmi->tmds_clk, mode->crtc_clock * 1000);
 
@@ -181,6 +159,19 @@ static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
 		val |= SUN4I_HDMI_VID_TIMING_POL_VSYNC;
 
 	writel(val, hdmi->base + SUN4I_HDMI_VID_TIMING_POL_REG);
+
+	clk_prepare_enable(hdmi->tmds_clk);
+
+	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
+	val |= SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
+	val |= SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
+	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
+
+	val = SUN4I_HDMI_VID_CTRL_ENABLE;
+	if (display->is_hdmi)
+		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
+
+	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
 }
 
 static enum drm_mode_status sun4i_hdmi_mode_valid(struct drm_encoder *encoder,
@@ -206,7 +197,6 @@ static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs = {
 	.atomic_check	= sun4i_hdmi_atomic_check,
 	.atomic_disable	= sun4i_hdmi_disable,
 	.atomic_enable	= sun4i_hdmi_enable,
-	.atomic_mode_set	= sun4i_hdmi_mode_set,
 	.mode_valid	= sun4i_hdmi_mode_valid,
 };
 

-- 
2.43.0


