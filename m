Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542F97FB825
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbjK1Kjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjK1KjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:39:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2453266
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:26:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E03C433CA;
        Tue, 28 Nov 2023 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701167187;
        bh=fBonQ0XHrW4s6go71bEhf2QGqRqulcwzMi4AdpPOd0s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SJgEmfRE9FGngIXWrEmCfEYxA36riuzoNlqtHPBAcxOy5yBwSDJ+iW/Ld7ujaRIgQ
         CIixQntEw8lB1pngpx5fo4b8aCVYwSKI5SxSDIDKgzIrxNRIsrcBGZ5j1pj7m0Xs2z
         kOiMIMY/0fHnwgJEjBLjX+Pk09Sp1WuSTWwDFqjjdQ8/L3SxOnYIZCuhkPVkLax7/5
         QHF5ALHhmIJ6XzJ+QGmtinHkov1KJ1xlC+k219KJrAG6b07+LUVzJuBcByjX+t3SEI
         dNsSEw0Y5pqij/iFx9stavbWVzfOjSWFhA2AzFU6L7VNwHfH0BqiO51mNAWMhMj/2O
         BzIh5qka/kUpg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 28 Nov 2023 11:24:55 +0100
Subject: [PATCH v4 44/45] drm/sun4i: hdmi: Consolidate atomic_check and
 mode_valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-kms-hdmi-connector-state-v4-44-c7602158306e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fBonQ0XHrW4s6go71bEhf2QGqRqulcwzMi4AdpPOd0s=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmp+y/fOuN9nqcue4lt38Z6W+bjRlMrIzYythzf5Ox87
 sn86GnKHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZjIz68Mf0UibfSz9/1/vbg+
 SCzulXacQ908Ho4/fy6keCRMdr3rW8PIsNbLN+nd1h53ywrvc1/DT+ml2i/5vVxuwYrsvhCzlwl
 6/AA=
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

atomic_check and mode_valid do not check for the same things which can
lead to surprising result if the userspace commits a mode that didn't go
through mode_valid. Let's merge the two implementations into a function
called by both.

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
2.41.0

