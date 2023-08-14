Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E602277BAC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjHNN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHNN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA796E6D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AAB260EB3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5F3C433C8;
        Mon, 14 Aug 2023 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692021405;
        bh=ui9S2zLXIqp7a7NZ2j9yfURvaM6ingzVBOVAHsIfZMI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NVcCWJ8pGVtPfaYsPyATGrGUOAw64t/qcPKTHvhl6mokcB3pm324tqVQihxiGRVmH
         z9TrtUKpVe6oFIo+H5Z0wFsogWUzcqijJlbrvcsfWWNqkBqY2YmyljeDGzCCZWaUJt
         CDyPaJRbcQCUPplgEYPqVIaVNJlKoei0cGOv/qbbcIOdLzBcay5JGQ4FdipWvxuAdT
         rk4jrcljBx6XLmH8igrvPdjdvKTlHzjBflJld9NjUXWoCQR002gWNClwU/KXUksS7f
         SNwUhuCvh4HCYJgeMzx0YHN3ffRi2G05ZWeyP/PXUDANVo61Vlt7nbEd77GrzJPgJS
         2Zx36GTum+q+A==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 14 Aug 2023 15:56:19 +0200
Subject: [PATCH RFC 07/13] drm/connector: hdmi: Calculate TMDS character
 rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-kms-hdmi-connector-state-v1-7-048054df3654@kernel.org>
References: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
In-Reply-To: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6299; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ui9S2zLXIqp7a7NZ2j9yfURvaM6ingzVBOVAHsIfZMI=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCm3jNrsLWZW3MpO3VK3v2qzj4bdlCj/F6kCGyavP2y4o
 qXzwnbljlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEyk14KR4UYwW/m3pR2TNMw5
 Q95La3179vs8+4fPP5kP5wdv+OtaMIWRYbvvvi/1jB0LemXEmAPn9XGy2a+esS8kkjFt855Kjfb
 zzAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most HDMI drivers have some code to calculate the TMDS character rate,
usually to adjust an internal clock to match what the mode requires.

Since the TMDS character rates mostly depends on the resolution, whether
we need to repeat pixels or not, the bpc count and the format, we can
now derive it from the HDMI connector state that stores all those infos
and remove the duplication from drivers.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_hdmi_connector.c | 77 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h          | 11 ++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/drm_hdmi_connector.c b/drivers/gpu/drm/drm_hdmi_connector.c
index 55f685c0095b..e49782a284a5 100644
--- a/drivers/gpu/drm/drm_hdmi_connector.c
+++ b/drivers/gpu/drm/drm_hdmi_connector.c
@@ -82,6 +82,7 @@ __drm_atomic_helper_hdmi_connector_duplicate_state(struct drm_hdmi_connector *hd
 	struct drm_hdmi_connector_state *old_hdmi_state =
 		connector_state_to_hdmi_connector_state(old_state);
 
+	new_hdmi_state->tmds_char_rate = old_hdmi_state->tmds_char_rate;
 	new_hdmi_state->output_bpc = old_hdmi_state->output_bpc;
 	new_hdmi_state->output_format = old_hdmi_state->output_format;
 	new_hdmi_state->broadcast_rgb = old_hdmi_state->broadcast_rgb;
@@ -257,6 +258,69 @@ connector_state_get_adjusted_mode(const struct drm_connector_state *state)
 	return &crtc_state->adjusted_mode;
 }
 
+static enum drm_mode_status
+drm_hdmi_connector_clock_valid(const struct drm_hdmi_connector *hdmi_connector,
+			       const struct drm_display_mode *mode,
+			       unsigned long long clock)
+{
+	const struct drm_connector *connector = &hdmi_connector->base;
+	const struct drm_display_info *info = &connector->display_info;
+
+	if (info->max_tmds_clock && clock > info->max_tmds_clock * 1000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
+/**
+ * drm_hdmi_connector_compute_mode_clock() - Computes the TMDS Character Rate
+ * @mode: Display mode to compute the clock for
+ * @bpc: Bits per character
+ * @fmt: Output Pixel Format used
+ *
+ * Returns the TMDS Character Rate for a given mode, bpc count and output format.
+ *
+ * RETURNS:
+ * The TMDS Character Rate, in Hertz
+ */
+unsigned long long
+drm_hdmi_connector_compute_mode_clock(const struct drm_display_mode *mode,
+				      unsigned int bpc,
+				      enum hdmi_colorspace fmt)
+{
+	unsigned long long clock = mode->clock * 1000ULL;
+
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
+		clock = clock * 2;
+
+	if (fmt == HDMI_COLORSPACE_YUV422)
+		bpc = 8;
+
+	clock = clock * bpc;
+	do_div(clock, 8);
+
+	return clock;
+}
+EXPORT_SYMBOL(drm_hdmi_connector_compute_mode_clock);
+
+static int
+drm_hdmi_connector_compute_clock(const struct drm_hdmi_connector *hdmi_connector,
+				 struct drm_hdmi_connector_state *hdmi_state,
+				 const struct drm_display_mode *mode,
+				 unsigned int bpc,
+				 enum hdmi_colorspace fmt)
+{
+	unsigned long long clock;
+
+	clock = drm_hdmi_connector_compute_mode_clock(mode, bpc, fmt);
+	if (!drm_hdmi_connector_clock_valid(hdmi_connector, mode, clock) != MODE_OK)
+		return -EINVAL;
+
+	hdmi_state->tmds_char_rate = clock;
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_hdmi_connector_atomic_check() - Helper to check HDMI connector atomic state
  * @connector: the parent connector this state refers to
@@ -275,6 +339,8 @@ connector_state_get_adjusted_mode(const struct drm_connector_state *state)
 int drm_atomic_helper_hdmi_connector_atomic_check(struct drm_connector *connector,
 						  struct drm_atomic_state *state)
 {
+	struct drm_hdmi_connector *hdmi_connector =
+		connector_to_hdmi_connector(connector);
 	struct drm_connector_state *old_state =
 		drm_atomic_get_old_connector_state(state, connector);
 	struct drm_hdmi_connector_state *old_hdmi_state =
@@ -283,6 +349,16 @@ int drm_atomic_helper_hdmi_connector_atomic_check(struct drm_connector *connecto
 		drm_atomic_get_new_connector_state(state, connector);
 	struct drm_hdmi_connector_state *new_hdmi_state =
 		connector_state_to_hdmi_connector_state(new_state);
+	const struct drm_display_mode *mode =
+		connector_state_get_adjusted_mode(new_state);
+	int ret;
+
+	ret = drm_hdmi_connector_compute_clock(hdmi_connector, new_hdmi_state,
+					       mode,
+					       new_hdmi_state->output_bpc,
+					       new_hdmi_state->output_format);
+	if (!ret)
+		return ret;
 
 	if (old_hdmi_state->broadcast_rgb != new_hdmi_state->broadcast_rgb ||
 	    old_hdmi_state->output_format != new_hdmi_state->output_format ||
@@ -374,6 +450,7 @@ void drm_atomic_helper_hdmi_connector_print_state(struct drm_printer *p,
 	drm_printf(p, "\toutput_bpc=%u\n", hdmi_state->output_bpc);
 	drm_printf(p, "\toutput_format=%s\n",
 		   drm_hdmi_connector_get_output_format_name(hdmi_state->output_format));
+	drm_printf(p, "\ttmds_char_rate=%llu\n", hdmi_state->tmds_char_rate);
 }
 EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_print_state);
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 995700110a16..03c5af34323d 100644
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
@@ -2085,6 +2086,11 @@ struct drm_hdmi_connector_state {
 	 */
 	enum hdmi_colorspace output_format;
 
+	/**
+	 * @tmds_char_rate: TMDS Character Rate, in Hz.
+	 */
+	unsigned long long tmds_char_rate;
+
 	/**
 	 * @broadcast_rgb: Connector property to pass the Broadcast RGB
 	 * selection value.
@@ -2146,6 +2152,11 @@ struct drm_hdmi_connector {
 #define connector_to_hdmi_connector(connector) \
 	container_of_const(connector, struct drm_hdmi_connector, base)
 
+unsigned long long
+drm_hdmi_connector_compute_mode_clock(const struct drm_display_mode *mode,
+				      unsigned int bpc,
+				      enum hdmi_colorspace fmt);
+
 int drmm_hdmi_connector_init(struct drm_device *dev,
 			     struct drm_hdmi_connector *hdmi_connector,
 			     const struct drm_connector_funcs *funcs,

-- 
2.41.0

