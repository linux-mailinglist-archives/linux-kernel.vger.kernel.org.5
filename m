Return-Path: <linux-kernel+bounces-61660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E3851511
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4941C21583
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720E537EC;
	Mon, 12 Feb 2024 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8O/NQn0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E50535D9;
	Mon, 12 Feb 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743709; cv=none; b=BAuEhTYbPMP/a9TecBKkKiVfsEkXtGCXsfFVldbAy5OC2od7iPwj0j67linHM4Mgnbmc7mxU8NYxMXLDWBX5y4KPK9Hs4dQSZQSlc9AV4Vw1TFOeH133NN+LCGdaPBZRfV7Iom5dhV7A6zxawY+2WUVckn7T5Rl7MqDf3aSMdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743709; c=relaxed/simple;
	bh=l7az7PI3sr6iJExwxQ3T/NzoIC1/E5ZG/ch/JDJ1A3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyC7rNCM6S0KBeVw4LS/sXW0DfWbsgjSSorzmSuKk2cmjzeJ+ISUXU6cdSp0xDSOwJdkyAUHck1IrjwgIcClYACqEpKcPy6r9iTVL25ulm+v9bIkv9OVh8dG/4si0ZWJSGVWi3lYXkYfvvT6dycm1UG6uQVQdoEY7lR0ixcbgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8O/NQn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F303CC433F1;
	Mon, 12 Feb 2024 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743708;
	bh=l7az7PI3sr6iJExwxQ3T/NzoIC1/E5ZG/ch/JDJ1A3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N8O/NQn02I4O+8iu2op4Zm2Eq6Jx+InYbm/1d+l0itl4L7iu3VhBYcjiFdvQCokqI
	 ceV8oVw6+ukjKLL1KSdpzbzlNPrsXuJsjED7SbBnDl5D9lJqBCut7QcQ9IVfNPF/lN
	 Nh8RuN1RpZzyW5L9pJTnfz6A+phgy8rn2OPvX5X21+aDKMROxN2zU9hHJpRBKXvUAh
	 eY43ADmTm9U19SShlfe5ZqoF5Mjv/fio7u+1n3LykA+Q8OD2WLsOIrRU00Unv1UvGt
	 TbTaSTETGh363AR+B0KQGbTA6YLsHRrfshogutc/uciBk1RSGQhydAiIQ839yp6axH
	 vJp7bq/G63Icw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:13:18 +0100
Subject: [PATCH v6 35/36] drm/sun4i: hdmi: Consolidate atomic_check and
 mode_valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-35-f4bcdc979e6f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4307; i=mripard@kernel.org;
 h=from:subject:message-id; bh=l7az7PI3sr6iJExwxQ3T/NzoIC1/E5ZG/ch/JDJ1A3s=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJEvmCJ7ZZFW76My7xJjZkz+f26+z8/LBCT4P6gz2f
 v35/sSXCR2lLAxiXAyyYoosMcLmS+JOzXrdycY3D2YOKxPIEAYuTgGYiPsmhr/Sr2fMXqlte4TB
 RG5H+/Yr17ep7TyddaxG47NP+/G5E6f/ZGRYyZ3ZO/dL8PaO9S4VRlc6hOZpebVZ6uZ2LdGOE3o
 ks58fAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

atomic_check and mode_valid do not check for the same things which can
lead to surprising result if the userspace commits a mode that didn't go
through mode_valid. Let's merge the two implementations into a function
called by both.

Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 74 +++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index c276d984da6b..b7cf369b1906 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -62,18 +62,6 @@ static int sun4i_hdmi_setup_avi_infoframes(struct sun4i_hdmi *hdmi,
 	return 0;
 }
 
-static int sun4i_hdmi_atomic_check(struct drm_encoder *encoder,
-				   struct drm_crtc_state *crtc_state,
-				   struct drm_connector_state *conn_state)
-{
-	struct drm_display_mode *mode = &crtc_state->mode;
-
-	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
-		return -EINVAL;
-
-	return 0;
-}
-
 static void sun4i_hdmi_disable(struct drm_encoder *encoder,
 			       struct drm_atomic_state *state)
 {
@@ -166,31 +154,61 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder,
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
 }
 
-static enum drm_mode_status sun4i_hdmi_mode_valid(struct drm_encoder *encoder,
-					const struct drm_display_mode *mode)
+static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs = {
+	.atomic_disable	= sun4i_hdmi_disable,
+	.atomic_enable	= sun4i_hdmi_enable,
+};
+
+static enum drm_mode_status
+sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
+				 const struct drm_display_mode *mode,
+				 unsigned long long clock)
 {
-	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
-	unsigned long rate = mode->clock * 1000;
-	unsigned long diff = rate / 200; /* +-0.5% allowed by HDMI spec */
+	const struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
+	unsigned long diff = clock / 200; /* +-0.5% allowed by HDMI spec */
 	long rounded_rate;
 
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
+		return MODE_BAD;
+
 	/* 165 MHz is the typical max pixelclock frequency for HDMI <= 1.2 */
-	if (rate > 165000000)
+	if (clock > 165000000)
 		return MODE_CLOCK_HIGH;
-	rounded_rate = clk_round_rate(hdmi->tmds_clk, rate);
+
+	rounded_rate = clk_round_rate(hdmi->tmds_clk, clock);
 	if (rounded_rate > 0 &&
-	    max_t(unsigned long, rounded_rate, rate) -
-	    min_t(unsigned long, rounded_rate, rate) < diff)
+	    max_t(unsigned long, rounded_rate, clock) -
+	    min_t(unsigned long, rounded_rate, clock) < diff)
 		return MODE_OK;
+
 	return MODE_NOCLOCK;
 }
 
-static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs = {
-	.atomic_check	= sun4i_hdmi_atomic_check,
-	.atomic_disable	= sun4i_hdmi_disable,
-	.atomic_enable	= sun4i_hdmi_enable,
-	.mode_valid	= sun4i_hdmi_mode_valid,
-};
+static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
+					     struct drm_atomic_state *state)
+{
+	struct drm_connector_state *conn_state =
+		drm_atomic_get_new_connector_state(state, connector);
+	struct drm_crtc *crtc = conn_state->crtc;
+	struct drm_crtc_state *crtc_state = crtc->state;
+	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
+	enum drm_mode_status status;
+
+	status = sun4i_hdmi_connector_clock_valid(connector, mode,
+						  mode->clock * 1000);
+	if (status != MODE_OK)
+		return -EINVAL;
+
+	return 0;
+}
+
+static enum drm_mode_status
+sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
+				struct drm_display_mode *mode)
+{
+	return sun4i_hdmi_connector_clock_valid(connector, mode,
+						mode->clock * 1000);
+}
 
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
@@ -236,6 +254,8 @@ static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
 }
 
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
+	.atomic_check	= sun4i_hdmi_connector_atomic_check,
+	.mode_valid	= sun4i_hdmi_connector_mode_valid,
 	.get_modes	= sun4i_hdmi_get_modes,
 };
 

-- 
2.43.0


