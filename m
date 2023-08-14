Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A3777BAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHNN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjHNN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954ABE7D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7FB60EB3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF3BC433C8;
        Mon, 14 Aug 2023 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692021397;
        bh=xncxvAN3MA7dUdThQOc9ObR8DlJZbK6zrzIZ9Rr5e+g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tFOUcoCEblzCovC6vIAmcu6VvgwiC1seZybo15XnOrWKEOdXTeK2U2HBHsjUjyLtt
         kyZb7RIAWXDMNx9ryc+Eap46C6QsEuuWJOtd7T7kbA3fHXCxVpjFtSJgm7G9oNHedD
         5bGA6zrGqmubVE/k423o1ulQs05hDE0e/DRuDZwwZ0iG7AjvEKxY4eB5KaIgUatPNL
         XiEULINTY5sIOv8ssZ6nzpht6n7QzFxPPQPldMbZeOAEWaJyXw54uRUiVku9bNW38N
         sxLA+XeEYwyyydS3w19JEv1quii/x2t7Fu/9Sl48FwOT6QGWzE0kzPNXuF0eeh+qKm
         gMyNn73KNQs8Q==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 14 Aug 2023 15:56:16 +0200
Subject: [PATCH RFC 04/13] drm/connector: hdmi: Add helper to get the RGB
 range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-kms-hdmi-connector-state-v1-4-048054df3654@kernel.org>
References: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
In-Reply-To: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xncxvAN3MA7dUdThQOc9ObR8DlJZbK6zrzIZ9Rr5e+g=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCm3jNp2KO/YWH/ShOOa4b0u7Q8rg56u0Xc91fEs1vzi8
 fY2zSf/OkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjARUWlGhlt7D5bl2Emo7dn9
 +rlCAONJNSGulErfN3ITzrclSV3z3MbIsPVHRua6XtV/1rufbRUrDnn/tefvgzo95gDjyymC111
 4mQE=
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

HDMI controller drivers will need to figure out the RGB range they need
to configure based on a given atomic state.

Let's provide a helper to provide that information.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_hdmi_connector.c | 41 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h          |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_hdmi_connector.c b/drivers/gpu/drm/drm_hdmi_connector.c
index 2b6b9d444774..1fe3f3ebf719 100644
--- a/drivers/gpu/drm/drm_hdmi_connector.c
+++ b/drivers/gpu/drm/drm_hdmi_connector.c
@@ -4,6 +4,7 @@
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_print.h>
 
@@ -217,6 +218,15 @@ int drm_atomic_helper_hdmi_connector_set_property(struct drm_connector *connecto
 }
 EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_set_property);
 
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
  * drm_atomic_helper_hdmi_connector_atomic_check() - Helper to check HDMI connector atomic state
  * @connector: the parent connector this state refers to
@@ -259,6 +269,37 @@ int drm_atomic_helper_hdmi_connector_atomic_check(struct drm_connector *connecto
 }
 EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_atomic_check);
 
+/**
+ * drm_atomic_helper_hdmi_connector_is_full_range() - Checks whether a state uses Full-Range RGB
+ * @hdmi_connector: the HDMI connector this state refers to
+ * @hdmi_state: the HDMI connector state to check
+ *
+ * RETURNS:
+ * True if @hdmi_state requires a Full range RGB output, False otherwise
+ */
+bool
+drm_atomic_helper_hdmi_connector_is_full_range(const struct drm_hdmi_connector *hdmi_connector,
+					       const struct drm_hdmi_connector_state *hdmi_state)
+{
+	const struct drm_connector *connector = &hdmi_connector->base;
+	const struct drm_connector_state *conn_state = &hdmi_state->base;
+	const struct drm_display_mode *mode =
+		connector_state_get_adjusted_mode(conn_state);
+	const struct drm_display_info *display = &connector->display_info;
+
+	if (hdmi_state->broadcast_rgb == DRM_HDMI_BROADCAST_RGB_FULL)
+		return true;
+
+	if (hdmi_state->broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED)
+		return false;
+
+	if (!display->is_hdmi)
+		return true;
+
+	return drm_default_rgb_quant_range(mode);
+}
+EXPORT_SYMBOL(drm_atomic_helper_hdmi_connector_is_full_range);
+
 static const struct drm_prop_enum_list broadcast_rgb_names[] = {
 	{ DRM_HDMI_BROADCAST_RGB_AUTO, "Automatic" },
 	{ DRM_HDMI_BROADCAST_RGB_FULL, "Full" },
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 24a0d33e5148..dff95e6e2b48 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2111,6 +2111,10 @@ int drm_atomic_helper_hdmi_connector_atomic_check(struct drm_connector *connecto
 void drm_atomic_helper_hdmi_connector_print_state(struct drm_printer *p,
 						  const struct drm_connector_state *state);
 
+bool
+drm_atomic_helper_hdmi_connector_is_full_range(const struct drm_hdmi_connector *hdmi_connector,
+					       const struct drm_hdmi_connector_state *hdmi_state);
+
 struct drm_hdmi_connector {
 	/**
 	 * @base: Base Connector

-- 
2.41.0

