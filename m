Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D930D7FB74B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbjK1KZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjK1KYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:24:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02321BD7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:24:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DF1C433C8;
        Tue, 28 Nov 2023 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701167085;
        bh=Cb7+GtJECRpbHHDENegVTVsqnU8i6YNms4Q3cRVoKVQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OPva/WilChgoM+VSzLFIT5MFl6xqdhKFbFvFw4H0HLkeqbbA1YOhIBIKSA3AdDp2k
         u/jJCPLv+YHFVCmZhVx8jJXy4b2MN0AJMJHZfuM/JADMy7HrI4+uNCbdbwTYIgWOiy
         15BGlSBpS2ddKRfKehpENZ1GA+diVt/EiyFlgputDxmNq/H2JCicUfp401g06V/Bkq
         dqtcQUdMr2D191B+aq0lxBoYMSB1lT764wW5uJWZemfKNB9jY0h9Wlcv85GDP5Ric2
         FiahcIA9tY/NeMLUVSjL8djYO3sZwqyjzowfOMhFtviUg1dwn4yXNAVl9cSXRvkNLx
         s2LwP2UnqFvjQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 28 Nov 2023 11:24:19 +0100
Subject: [PATCH v4 08/45] drm/connector: hdmi: Create an HDMI sub-state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-kms-hdmi-connector-state-v4-8-c7602158306e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4194; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Cb7+GtJECRpbHHDENegVTVsqnU8i6YNms4Q3cRVoKVQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmp+y9qLeBzmdg/T0VqTcbm18xaQtO4zkxReCOh+TVSr
 sX5lM+qjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzk1GRGhn9cUzdq7Est65y0
 s/2p6btz3Dp3frluu7joV3xuq9Qa03iGf4p6O4K2sL4WUJ98KpNhttNXbqWdMrrbZvf7i7Tesl6
 RyQ8A
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

The next features we will need to share across drivers will need to
store some parameters for drivers to use, such as the selected output
format.

Let's create a new connector sub-state dedicated to HDMI controllers,
that will eventually store everything we need.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 35 +++++++++++++++++++++++++++++++
 include/drm/drm_atomic_state_helper.h     |  4 ++++
 include/drm/drm_connector.h               |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 784e63d70a42..29cb64e9cf28 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -556,6 +556,22 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
 
+/**
+ * __drm_atomic_helper_connector_hdmi_reset() - Initializes all HDMI @drm_connector_state resources
+ * @connector: DRM connector
+ * @new_state: connector state to reset
+ *
+ * Initializes all HDMI resources from a @drm_connector_state without
+ * actually allocating it. This is useful for HDMI drivers, in
+ * combination with __drm_atomic_helper_connector_reset() or
+ * drm_atomic_helper_connector_reset().
+ */
+void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
+					      struct drm_connector_state *new_state)
+{
+}
+EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
+
 /**
  * drm_atomic_helper_connector_tv_check - Validate an analog TV connector state
  * @connector: DRM Connector
@@ -605,6 +621,25 @@ int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_tv_check);
 
+/**
+ * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
+ * @connector: DRM Connector
+ * @state: the DRM State object
+ *
+ * Provides a default connector state check handler for HDMI connectors.
+ * Checks that a desired connector update is valid, and updates various
+ * fields of derived state.
+ *
+ * RETURNS:
+ * Zero on success, or an errno code otherwise.
+ */
+int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
+					   struct drm_atomic_state *state)
+{
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
+
 /**
  * __drm_atomic_helper_connector_duplicate_state - copy atomic connector state
  * @connector: connector object
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index b9740edb2658..d59d2b3aef9a 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -71,7 +71,11 @@ void __drm_atomic_helper_connector_state_reset(struct drm_connector_state *conn_
 void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 					 struct drm_connector_state *conn_state);
 void drm_atomic_helper_connector_reset(struct drm_connector *connector);
+void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
+					      struct drm_connector_state *new_state);
 void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
+int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
+					   struct drm_atomic_state *state);
 int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
 					 struct drm_atomic_state *state);
 void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 4491c4c2fb6e..000a2a156619 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1031,6 +1031,13 @@ struct drm_connector_state {
 	 * DRM blob property for HDR output metadata
 	 */
 	struct drm_property_blob *hdr_output_metadata;
+
+	/**
+	 * @hdmi: HDMI-related variable and properties. Filled by
+	 * @drm_atomic_helper_connector_hdmi_check().
+	 */
+	struct {
+	} hdmi;
 };
 
 /**

-- 
2.41.0

