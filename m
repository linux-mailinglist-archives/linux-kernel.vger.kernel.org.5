Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7746B7FB7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjK1KaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbjK1K3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:29:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0830F8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:26:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD74C433C9;
        Tue, 28 Nov 2023 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701167181;
        bh=jSpZuOH1RdsM4aSPqCaZdH7lflfIrdCTw/BW9GZsfMs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LD9odYMb8xkmfFHtuzo7/Atp+jNyi9GjjKUwj41qzOJOGo8Bs/YVw6j/ycHdLbyMY
         AxgmB+N75LHNGLOKmGors6DAbmH4678IrE5oJduYyx5Vb7zTRsoqbo/Pbr1X0Tm/Ri
         zmLdWL/+3+36z81zuGZ6YMgXheXJ+RwAOx9RD9fo9YWqZKaE6WOU6S95B0UpBC45/9
         tcjm0cPSZm6KC7OZCVjiczXqKRN0BgjXcU/yvqdaNa4zCEhVpwkHkTwpBRyrMyOWtO
         2omU4qypbjs5GgG0I81R9ZdilOJ4thWeeAzOU7WY4wqXJvvvfQFCBdWD3OghIAfUlw
         5cous/EkXlEmg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 28 Nov 2023 11:24:53 +0100
Subject: [PATCH v4 42/45] drm/sun4i: hdmi: Move mode_set into enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-kms-hdmi-connector-state-v4-42-c7602158306e@kernel.org>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
In-Reply-To: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2808; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jSpZuOH1RdsM4aSPqCaZdH7lflfIrdCTw/BW9GZsfMs=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmp+y8/NdksrL1KXD5lh++zKCaTEPESUdGL5ztF5z2fI
 reUa9LljlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzkHgcjw8ewjfb3Pzp1pZmz
 9h7nrHr3Y8medWFiu1885rU2bTcW82BkaE2LY1Ro+aRocH2ZfzbT+8PM6g0ymX4fl8zhOmDUMte
 OGQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're not doing anything special in atomic_mode_set so we can simply
merge it into atomic_enable.

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
2.41.0

