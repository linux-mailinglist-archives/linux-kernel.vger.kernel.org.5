Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F37A86D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjITOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbjITOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98564195;
        Wed, 20 Sep 2023 07:36:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F97DC433C9;
        Wed, 20 Sep 2023 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220568;
        bh=DzOTh1VFkUk6x4mUY8kh1kcBDRxTH0+m1q8DKEjv3MM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=V5jw9Ipzl1ixMNxB1zBAi5RyHpFAD5BXSJnGy1v+C77NyBbJWatMBBJualt9ngHy9
         qhzEvJkJEyNyLQ+NoJj/Ooa3xYJQgbJRui23zen+355djkFs3F1RIbWZvRCL0Ip2X6
         6L8toWH0JFFVUjDPwItj56J5h+hLckH5jMM+ZkheSpN4Ib99kz8z+HGNFvz3ozmxcV
         D/k9Ammqy9Veh70B0YeaU7fgohJhdTrR7aNnCR48r9yMZd4EISPqyulOoqryMJ6UWc
         nyuKtvQ3NcNx44vWojAPAz0WB2PZog5QPO6O2eWgWOR3hYKoa+sUtc6Hq/Sicf6yo0
         rakDiAN6YDhLQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:24 +0200
Subject: [PATCH RFC v2 09/37] drm/connector: hdmi: Add custom hook to
 filter TMDS character rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-9-17932daddd7d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4585; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DzOTh1VFkUk6x4mUY8kh1kcBDRxTH0+m1q8DKEjv3MM=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczJYGVdrTFBSuGEy812IguOFURe7ElfVvc+et2K+0S
 mee+aqZHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZjI1hRGhmnin5beP2F5wSdA
 xuz4BcsHcvnF5Vu8LxTOf32s0LrqlwTDP5V7X2aqN2XNF9Y0nLBJ/oPhmjLprrtV2WcuHypN4Dq
 4nAkA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the HDMI controllers have an upper TMDS character rate limit
they can't exceed. On "embedded"-grade display controllers, it will
typically be lower than what high-grade monitors can provide these days,
so drivers will filter the TMDS character rate based on the controller
capabilities.

To make that easier to handle for drivers, let's provide an optional
hook to be implemented by drivers so they can tell the HDMI controller
helpers if a given TMDS character rate is reachable for them or not.

This will then be useful to figure out the best format and bpc count for
a given mode.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  4 ++++
 drivers/gpu/drm/drm_connector.c           |  4 ++++
 include/drm/drm_connector.h               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 0417d964a590..9539b952fd8c 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -640,11 +640,15 @@ hdmi_clock_valid(const struct drm_connector *connector,
 		 const struct drm_display_mode *mode,
 		 unsigned long long clock)
 {
+	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
 	const struct drm_display_info *info = &connector->display_info;
 
 	if (info->max_tmds_clock && clock > info->max_tmds_clock * 1000)
 		return MODE_CLOCK_HIGH;
 
+	if (funcs && funcs->tmds_char_rate_valid)
+		return funcs->tmds_char_rate_valid(connector, mode, clock);
+
 	return MODE_OK;
 }
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 4c1af97971bb..2bc52465f940 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -457,6 +457,7 @@ EXPORT_SYMBOL(drmm_connector_init);
  * @dev: DRM device
  * @connector: A pointer to the HDMI connector to init
  * @funcs: callbacks for this connector
+ * @hdmi_funcs: HDMI-related callbacks for this connector
  * @connector_type: user visible type of the connector
  * @ddc: optional pointer to the associated ddc adapter
  * @supported_formats: Bitmask of @hdmi_colorspace listing supported output formats
@@ -476,6 +477,7 @@ EXPORT_SYMBOL(drmm_connector_init);
 int drmm_connector_hdmi_init(struct drm_device *dev,
 			     struct drm_connector *connector,
 			     const struct drm_connector_funcs *funcs,
+			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
 			     int connector_type,
 			     struct i2c_adapter *ddc,
 			     unsigned long supported_formats,
@@ -502,6 +504,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 		connector->max_bpc = max_bpc;
 	}
 
+	connector->hdmi.funcs = hdmi_funcs;
+
 	return 0;
 }
 EXPORT_SYMBOL(drmm_connector_hdmi_init);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 025380ebd128..468cae3cb739 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1077,6 +1077,30 @@ struct drm_connector_state {
 	} hdmi;
 };
 
+/**
+ * struct drm_connector_hdmi_funcs - drm_hdmi_connector control functions
+ */
+struct drm_connector_hdmi_funcs {
+	/**
+	 * @tmds_char_rate_valid:
+	 *
+	 * This callback is invoked at atomic_check time to figure out
+	 * whether a particular TMDS character rate is supported by the
+	 * driver.
+	 *
+	 * The @tmds_char_rate_valid callback is optional.
+	 *
+	 * Returns:
+	 *
+	 * Either &drm_mode_status.MODE_OK or one of the failure reasons
+	 * in &enum drm_mode_status.
+	 */
+	enum drm_mode_status
+	(*tmds_char_rate_valid)(const struct drm_connector *connector,
+				const struct drm_display_mode *mode,
+				unsigned long long tmds_rate);
+};
+
 /**
  * struct drm_connector_funcs - control connectors on a given device
  *
@@ -1947,6 +1971,11 @@ struct drm_connector {
 		 * supported by the controller.
 		 */
 		unsigned long supported_formats;
+
+		/**
+		 * @funcs: HDMI connector Control Functions
+		 */
+		const struct drm_connector_hdmi_funcs *funcs;
 	} hdmi;
 };
 
@@ -1969,6 +1998,7 @@ int drmm_connector_init(struct drm_device *dev,
 int drmm_connector_hdmi_init(struct drm_device *dev,
 			     struct drm_connector *connector,
 			     const struct drm_connector_funcs *funcs,
+			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
 			     int connector_type,
 			     struct i2c_adapter *ddc,
 			     unsigned long supported_formats,

-- 
2.41.0

