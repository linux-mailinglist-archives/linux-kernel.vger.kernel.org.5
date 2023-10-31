Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62C7DD2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346847AbjJaQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346670AbjJaQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:48:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F5E6;
        Tue, 31 Oct 2023 09:48:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD124C433C8;
        Tue, 31 Oct 2023 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698770935;
        bh=QJmVeePAcx7pV7co2N1PaJoFmnt45FQ/oBA2SPqfG3E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TTnDbqzhaIZg6xykK+YYO26NzZCUZMkdG8Br5D4Lk8NxtADtnJ9Uowhm3PfXBkU4C
         gbujt0UanSQidnvTFs24pqjQeBdELmyKqURFDxpgxOanSkXLr718VZ4+lM4z2xOMgy
         hVEz5fLz+x0UXuz7Ps4NJft92xCXXySTm/6F/mLkf5+AKy3TWvdOTySraxI2TAgvxp
         gS6RxGBC/nS07mop/Vq4Gj5lJldO4V0JdqL0fR3p0F1CMZ1NCfrj0y7WNj3lkquY2S
         ZsjIadQaCvXu5eZvgN5jX8AS2qde8oGY7fZFFD4pSoFIOm8Yun52QuDN1YumZAZU6Y
         ROcC4tn5XgRzw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 31 Oct 2023 17:48:20 +0100
Subject: [PATCH RFC v3 07/37] drm/connector: hdmi: Add HDMI compute clock
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-kms-hdmi-connector-state-v3-7-328b0fae43a7@kernel.org>
References: <20231031-kms-hdmi-connector-state-v3-0-328b0fae43a7@kernel.org>
In-Reply-To: <20231031-kms-hdmi-connector-state-v3-0-328b0fae43a7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QJmVeePAcx7pV7co2N1PaJoFmnt45FQ/oBA2SPqfG3E=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmO+vcq10fZy/qFds8/VsejM0/550uf07ZtzVzNh9pui
 Z4sDnvRUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgImUazIy/N5akXL99KLSiWw3
 zwowKq6+9b/6i4igwd1FgRdyDY7k5TP800zRq7p5/dS7rXXHd345tm76HctLIjxTtDTYp5/5smS
 1ByMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of HDMI drivers have some variation of the formula to calculate
the TMDS character rate from a mode, but few of them actually take all
parameters into account.

Let's create a helper to provide that rate taking all parameters into
account.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_connector.c | 34 ++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 9037e1b1b383..a96c9b54c554 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2955,6 +2955,40 @@ void drm_connector_update_privacy_screen(const struct drm_connector_state *conne
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
+ * The TMDS Character Rate, in Hertz
+ */
+unsigned long long
+drm_connector_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
+				      unsigned int bpc,
+				      enum hdmi_colorspace fmt)
+{
+	unsigned long long clock = mode->clock * 1000ULL;
+
+	if (fmt == HDMI_COLORSPACE_YUV420)
+		clock = clock / 2;
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
+EXPORT_SYMBOL(drm_connector_hdmi_compute_mode_clock);
+
 int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 				    struct drm_property *property,
 				    uint64_t value)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 32f0b3b7383e..781a5726a26a 100644
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
@@ -2118,6 +2119,10 @@ void drm_connector_attach_privacy_screen_properties(struct drm_connector *conn);
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
2.41.0

