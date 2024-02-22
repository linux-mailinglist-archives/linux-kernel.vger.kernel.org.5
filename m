Return-Path: <linux-kernel+bounces-77111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC9E860155
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DE31C23EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54314CAD4;
	Thu, 22 Feb 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmT/rE2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101A14CABF;
	Thu, 22 Feb 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625758; cv=none; b=eqdLA7E/d55GE68pWZHmFm6EHiKq82z6DZDX9Bhl9GJOA5ubh02otCAK5iP5wEvFrJJOLkSLWUqGJYLPubWLLzp/mYQLDjMZ60SD8G1/qK+OluddHaXf1v7TWBZISB+t+KGsFpdBifXR4+QtHgQlGN4Jo/WNJz4TZeLyLFvY2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625758; c=relaxed/simple;
	bh=HwA8pHzZqVdQyHV/A0cE4sshsUXIMq0spgAC4b0SoHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N38usgn8fj4X/uf119U+0RkM3xQIrrRlLDs+m4HCLCGgfqGGKMvqjGCeVAv6hBPMNooL7Yp/7rTtzXyFqf7+DJrxBBHXPKfFzB+B6imovBQbJHjJSN6HMRRMQc7B3KksW4qY+VVTAqhAFx+Ny/xdfLDe0OERGf0QwFxwE7JzL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmT/rE2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E27C433F1;
	Thu, 22 Feb 2024 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625758;
	bh=HwA8pHzZqVdQyHV/A0cE4sshsUXIMq0spgAC4b0SoHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qmT/rE2rhMFDIHrJCGBxP+N9iYDNev4YbiCdQ1llWH1TWCYk+Ial8qXGuWGm3zEZp
	 h/SDvGDs+mp9KiSkdkvqRyY4ns6TBhMn00Z7IFt+qn/ty2LbBLnw2hmPzdUJ8so7to
	 hFK7qgI2FGauNYfYYMtOG/bbGd5GwIhw5bVx8OJFgcYoA073Klg2IfL6a+CgHQhgwV
	 VJDGd6KRhc2OgM/YD3y/ePUSkEFxJ4NprmsVwNmn6Jkc6z/mKcRptQtv7UUGCRChhl
	 j1aKoXCAdPo9Ks/vBSuU8eJKdg1bJqpH2a37Cb1Eyr2ae6+MslxwiHuyoYZ0v75r2I
	 vThmaF4lzrdqw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Feb 2024 19:14:18 +0100
Subject: [PATCH v7 32/36] drm/sun4i: hdmi: Convert encoder to atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-kms-hdmi-connector-state-v7-32-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HwA8pHzZqVdQyHV/A0cE4sshsUXIMq0spgAC4b0SoHc=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnX+/5e5Ev7lbvnxKZUft0ONiGLa4p+WsJN3fEVjf8dt
 aPUHn3vKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwETW2DAyvFW67JV4+cM3dvn9
 n48pzH5/KWOy18UPFzoErJ84XfVes5Thr/gBXvZl29JP3dK4srGK7+q8DdaHV8cuVBKfMneGocQ
 FGRYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The sun4i_hdmi driver still uses the non-atomic variants of the encoder
hooks, so let's convert to their atomic equivalents.

Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 152375f3de2e..799a26215cc2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -82,7 +82,8 @@ static int sun4i_hdmi_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
-static void sun4i_hdmi_disable(struct drm_encoder *encoder)
+static void sun4i_hdmi_disable(struct drm_encoder *encoder,
+			       struct drm_atomic_state *state)
 {
 	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
 	u32 val;
@@ -96,7 +97,8 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
 	clk_disable_unprepare(hdmi->tmds_clk);
 }
 
-static void sun4i_hdmi_enable(struct drm_encoder *encoder)
+static void sun4i_hdmi_enable(struct drm_encoder *encoder,
+			      struct drm_atomic_state *state)
 {
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
@@ -120,9 +122,10 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 }
 
 static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
-				struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *conn_state)
 {
+	const struct drm_display_mode *mode = &crtc_state->mode;
 	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
 	unsigned int x, y;
 	u32 val;
@@ -201,9 +204,9 @@ static enum drm_mode_status sun4i_hdmi_mode_valid(struct drm_encoder *encoder,
 
 static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs = {
 	.atomic_check	= sun4i_hdmi_atomic_check,
-	.disable	= sun4i_hdmi_disable,
-	.enable		= sun4i_hdmi_enable,
-	.mode_set	= sun4i_hdmi_mode_set,
+	.atomic_disable	= sun4i_hdmi_disable,
+	.atomic_enable	= sun4i_hdmi_enable,
+	.atomic_mode_set	= sun4i_hdmi_mode_set,
 	.mode_valid	= sun4i_hdmi_mode_valid,
 };
 

-- 
2.43.2


