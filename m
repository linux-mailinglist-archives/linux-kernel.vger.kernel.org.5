Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39C7A86BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjITOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjITOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854EDEB;
        Wed, 20 Sep 2023 07:35:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BF8C433C9;
        Wed, 20 Sep 2023 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220554;
        bh=JesZ3/fGi45agkZSRIpZKjw+nUimuCRXqZlxL7MJq34=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rN6jdbxR+lin7qkeZL8yAqr/9jAXLXWnjbHZLeMB3wWStx51gdaKnwaxY4i882Tzn
         nvDHWD/Sq+Ts4Rz+N91IJz2929Pg8QrcsD9wsk122eC01Z91DvG1eYbfT5hqq1F+CN
         dGRQ/N0DItDe+mUiWq3X12tKUAjBdxoUXPgeEP8t4qALwXRQd+qgmtpxrM8lZadLCm
         hmR4j1P67xycAaOAbEYkcdU8kcI7VIjEXV13xFm2ApyA/JTfkxhtT+DSxIMhfxq1Zq
         oEC68LBlpqGJYB3uVR5TBDWhqwc+c9FlSNdPM0DyymJdjzyxyt/7zutX+7/74Bv78T
         EDd+FdC9Y0WBw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:19 +0200
Subject: [PATCH RFC v2 04/37] drm/connector: hdmi: Add helper to get the
 RGB range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-4-17932daddd7d@kernel.org>
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
In-Reply-To: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3424; i=mripard@kernel.org;
 h=from:subject:message-id; bh=JesZ3/fGi45agkZSRIpZKjw+nUimuCRXqZlxL7MJq34=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczJbnTpQ8z3V13da+PPDPnKPHGC5skdTlOr3x/S4Wu
 /T5DVEFHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZhISBDD/5AFbUndRWYKhxny
 b5xofhR9Tl/LQ7PfUc06N3zryfolKxgZVhdcd78bEheQzxT0e7OP7ZlfbOUq00O+hSc/yTlpvMe
 MBwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI controller drivers will need to figure out the RGB range they need
to configure based on a given atomic state.

Let's provide a helper to provide that information.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 39 +++++++++++++++++++++++++++++++
 include/drm/drm_atomic_state_helper.h     |  5 ++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 4b24ebb7e3e8..0f7e5ba555b8 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -31,6 +31,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
@@ -621,6 +622,15 @@ int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_tv_check);
 
+static const struct drm_display_mode *
+connector_state_get_adjusted_mode(const struct drm_connector_state *state)
+{
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state = crtc->state;
+
+	return &crtc_state->adjusted_mode;
+}
+
 /**
  * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
  * @connector: DRM Connector
@@ -656,6 +666,35 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
 
+/**
+ * drm_atomic_helper_connector_hdmi_is_full_range() - Checks whether a state uses Full-Range RGB
+ * @connector: the HDMI connector this state refers to
+ * @state: the HDMI connector state to check
+ *
+ * RETURNS:
+ * True if @state requires a Full range RGB output, False otherwise
+ */
+bool
+drm_atomic_helper_connector_hdmi_is_full_range(const struct drm_connector *connector,
+					       const struct drm_connector_state *state)
+{
+	const struct drm_display_mode *mode =
+		connector_state_get_adjusted_mode(state);
+	const struct drm_display_info *display = &connector->display_info;
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
+	return drm_default_rgb_quant_range(mode);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_is_full_range);
+
 /**
  * __drm_atomic_helper_connector_duplicate_state - copy atomic connector state
  * @connector: connector object
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index d59d2b3aef9a..c6d941b9e846 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -88,6 +88,11 @@ void
 __drm_atomic_helper_connector_destroy_state(struct drm_connector_state *state);
 void drm_atomic_helper_connector_destroy_state(struct drm_connector *connector,
 					  struct drm_connector_state *state);
+
+bool
+drm_atomic_helper_connector_hdmi_is_full_range(const struct drm_connector *connector,
+					       const struct drm_connector_state *state);
+
 void __drm_atomic_helper_private_obj_duplicate_state(struct drm_private_obj *obj,
 						     struct drm_private_state *state);
 

-- 
2.41.0

