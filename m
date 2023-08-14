Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5715577BABE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjHNN44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjHNN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA0110D5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7316D61B36
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852F1C433C8;
        Mon, 14 Aug 2023 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692021391;
        bh=x4pLT4i5FibUotLimiVEBeM0gsJhjBOcMTmrY0w2qmc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aculld8D7BcKHRQygtDTdI3aSfkcwfGFlmh0hRuWcM/e/Gl4IpVhlTFRuraPDqxdn
         o5v5trXZj8+1OuC0B3JAJzmy0xialXb/NZfONnmFjITHtxn5HWszITCMyinrwCTRiR
         AZsnIw7WW4OwO7j3WYLbvgk18akYcJQy22ubo0p1+bQuB+QK0KlDpzud5Tlckvck/x
         SndbnjQdte8kP8quANc3A79vJiri35z4PSc2xTk7L20x8/n6n9M8NXy4CLSJpysdi8
         vHgVVAd/m0uAhQcFiAIlX6h+IRDm7h4BghhgXt28v7cgnfdBrIKL4w23M3ZTCzFuJy
         yyMEtLVCfYLsg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 14 Aug 2023 15:56:14 +0200
Subject: [PATCH RFC 02/13] drm/connector: hdmi: Create a custom state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-kms-hdmi-connector-state-v1-2-048054df3654@kernel.org>
References: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
In-Reply-To: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8341; i=mripard@kernel.org;
 h=from:subject:message-id; bh=x4pLT4i5FibUotLimiVEBeM0gsJhjBOcMTmrY0w2qmc=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCm3jNoMNy5+vEWst8j9w/31qV8va57LZdJb/TMi36xmR
 mMN3+E3HaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZjI1mZGhmcTttSI7lv+wWGz
 21ee9Q++Nk677/80hPvK6lUbF1+JdFzNyDBhdcgfjvthnBLbVm9Yayx9U3Jd5UT7Q0cnWRXzNf7
 ilmcHAA==
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

The next features we will need to share across drivers will need to
store some parameters for drivers to use, such as the selected output
format.

Let's create a new connector state dedicated to HDMI controllers, that
will eventually store everything we need.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_hdmi_connector.c | 145 +++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h          |  26 +++++++
 2 files changed, 171 insertions(+)

diff --git a/drivers/gpu/drm/drm_hdmi_connector.c b/drivers/gpu/drm/drm_hdmi_connector.c
index 62f01dd2e6df..ff825c053b27 100644
--- a/drivers/gpu/drm/drm_hdmi_connector.c
+++ b/drivers/gpu/drm/drm_hdmi_connector.c
@@ -1,10 +1,155 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_mode.h>
 
 #include <linux/export.h>
 
+/**
+ * __drm_atomic_helper_hdmi_connector_reset() - Initializes all @drm_hdmi_connector_state resources
+ * @hdmi_connector: the connector this state refers to
+ * @new_hdmi_state: the HDMI connector state to initialize
+ *
+ * Initializes all relevant resources from a @drm_hdmi_connector_state
+ * without actually allocating it. This is useful for drivers that
+ * subclass @drm_hdmi_connector_state.
+ */
+void __drm_atomic_helper_hdmi_connector_reset(struct drm_hdmi_connector *hdmi_connector,
+					      struct drm_hdmi_connector_state *new_hdmi_state)
+{
+	struct drm_connector *connector = &hdmi_connector->base;
+
+	__drm_atomic_helper_connector_reset(connector, &new_hdmi_state->base);
+}
+EXPORT_SYMBOL(__drm_atomic_helper_hdmi_connector_reset);
+
+/**
+ * drm_atomic_helper_hdmi_connector_reset() - Create a @drm_hdmi_connector_state object
+ * @connector: the parent connector
+ *
+ * This helper is meant to be the default &drm_connector_funcs.reset
+ * implementation for @drm_hdmi_connector that don't subclass
+ * @drm_hdmi_connector_state.
+ */
+void drm_atomic_helper_hdmi_connector_reset(struct drm_connector *connector)
+{
+	struct drm_hdmi_connector *hdmi_connector =
+		connector_to_hdmi_connector(connector);
+	struct drm_connector_state *old_state = connector->state;
+	struct drm_hdmi_connector_state *old_hdmi_state =
+		connector_state_to_hdmi_connector_state(old_state);
+	struct drm_hdmi_connector_state *new_hdmi_state;
+
+	if (old_state)
+		__drm_atomic_helper_connector_destroy_state(old_state);
+
+	kfree(old_hdmi_state);
+
+	new_hdmi_state = kzalloc(sizeof(*new_hdmi_state), GFP_KERNEL);
+	if (!new_hdmi_state)
+		return;
+
+	__drm_atomic_helper_hdmi_connector_reset(hdmi_connector, new_hdmi_state);
+}
+EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_reset);
+
+/**
+ * __drm_atomic_helper_hdmi_connector_duplicate_state() - Copies all @drm_hdmi_connector_state resources
+ * @hdmi_connector: the connector this state refers to
+ * @new_hdmi_state: the HDMI connector state to copy to
+ *
+ * Copies all relevant resources from a @drm_hdmi_connector_state to a
+ * new one without actually allocating it. This is useful for drivers
+ * that subclass @drm_hdmi_connector_state.
+ */
+void
+__drm_atomic_helper_hdmi_connector_duplicate_state(struct drm_hdmi_connector *hdmi_connector,
+						   struct drm_hdmi_connector_state *new_hdmi_state)
+{
+	struct drm_connector *connector = &hdmi_connector->base;
+
+	__drm_atomic_helper_connector_duplicate_state(connector, &new_hdmi_state->base);
+}
+EXPORT_SYMBOL(__drm_atomic_helper_hdmi_connector_duplicate_state);
+
+/**
+ * drm_atomic_helper_hdmi_connector_duplicate_state() - Duplicate a @drm_hdmi_connector_state object
+ * @connector: the parent connector this state refers to
+ *
+ * This helper is meant to be the default
+ * &drm_connector_funcs.atomic_duplicate_state implementation for
+ * @drm_hdmi_connector that don't subclass @drm_hdmi_connector_state.
+ */
+struct drm_connector_state *
+drm_atomic_helper_hdmi_connector_duplicate_state(struct drm_connector *connector)
+{
+	struct drm_hdmi_connector *hdmi_connector =
+		connector_to_hdmi_connector(connector);
+	struct drm_hdmi_connector_state *new_hdmi_state;
+
+	new_hdmi_state = kzalloc(sizeof(*new_hdmi_state), GFP_KERNEL);
+	if (!new_hdmi_state)
+		return NULL;
+
+	__drm_atomic_helper_hdmi_connector_duplicate_state(hdmi_connector, new_hdmi_state);
+
+	return &new_hdmi_state->base;
+}
+EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_duplicate_state);
+
+/**
+ * __drm_atomic_helper_hdmi_connector_destroy_state() - Releases all @drm_hdmi_connector_state resources
+ * @hdmi_state: the HDMI connector state to release
+ *
+ * Release all resources stored in @drm_hdmi_connector_state without
+ * actually freeing it. This is useful for drivers that subclass
+ * @drm_hdmi_connector_state.
+ */
+void __drm_atomic_helper_hdmi_connector_destroy_state(struct drm_hdmi_connector_state *hdmi_state)
+{
+	__drm_atomic_helper_connector_destroy_state(&hdmi_state->base);
+}
+EXPORT_SYMBOL(__drm_atomic_helper_hdmi_connector_destroy_state);
+
+/**
+ * drm_atomic_helper_hdmi_connector_destroy_state() - Destroy a @drm_hdmi_connector_state object
+ * @connector: the parent connector this state refers to
+ * @state: the parent connector state to destroy
+ *
+ * Destroys an HDMI connector state previously created by
+ * &drm_atomic_helper_hdmi_connector_reset() or
+ * &drm_atomic_helper_hdmi_connector_duplicate_state().
+ *
+ * This helper is meant to be the default
+ * &drm_connector_funcs.atomic_destroy_state implementation for
+ * @drm_hdmi_connector that don't subclass @drm_hdmi_connector_state.
+ */
+void drm_atomic_helper_hdmi_connector_destroy_state(struct drm_connector *connector,
+						    struct drm_connector_state *state)
+{
+	struct drm_hdmi_connector_state *hdmi_state =
+		connector_state_to_hdmi_connector_state(state);
+
+	__drm_atomic_helper_hdmi_connector_destroy_state(hdmi_state);
+	kfree(hdmi_state);
+}
+EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_destroy_state);
+
+/**
+ * drm_atomic_helper_hdmi_connector_print_state - Prints a @drm_hdmi_connector_state
+ * @p: output printer
+ * @state: Connector state to print
+ *
+ * Default implementation of @drm_connector_funcs.atomic_print_state for
+ * a @drm_hdmi_connector_state.
+ */
+void drm_atomic_helper_hdmi_connector_print_state(struct drm_printer *p,
+						  const struct drm_connector_state *state)
+{
+}
+EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_print_state);
+
 /**
  * drmm_hdmi_connector_init - Init a preallocated HDMI connector
  * @dev: DRM device
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 1859b74083f5..0aa662e0a6ea 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2042,6 +2042,32 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+struct drm_hdmi_connector_state {
+	/**
+	 * @base: Base Connector State
+	 */
+	struct drm_connector_state base;
+};
+
+#define connector_state_to_hdmi_connector_state(state) \
+	container_of_const(state, struct drm_hdmi_connector_state, base)
+
+struct drm_hdmi_connector;
+
+void __drm_atomic_helper_hdmi_connector_reset(struct drm_hdmi_connector *hdmi_connector,
+					      struct drm_hdmi_connector_state *new_hdmi_state);
+void drm_atomic_helper_hdmi_connector_reset(struct drm_connector *connector);
+void
+__drm_atomic_helper_hdmi_connector_duplicate_state(struct drm_hdmi_connector *hdmi_connector,
+						   struct drm_hdmi_connector_state *new_hdmi_state);
+struct drm_connector_state *
+drm_atomic_helper_hdmi_connector_duplicate_state(struct drm_connector *connector);
+void __drm_atomic_helper_hdmi_connector_destroy_state(struct drm_hdmi_connector_state *hdmi_state);
+void drm_atomic_helper_hdmi_connector_destroy_state(struct drm_connector *connector,
+						    struct drm_connector_state *state);
+void drm_atomic_helper_hdmi_connector_print_state(struct drm_printer *p,
+						  const struct drm_connector_state *state);
+
 struct drm_hdmi_connector {
 	/**
 	 * @base: Base Connector

-- 
2.41.0

