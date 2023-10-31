Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93A27DD2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346296AbjJaQsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbjJaQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:48:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D192;
        Tue, 31 Oct 2023 09:48:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DE0C433C7;
        Tue, 31 Oct 2023 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698770917;
        bh=VPZB/POV7iVmeWtbXi3+KcObCDwbStqo6BKswkAb6p8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cvHZr8l07BS+Y0v93fwcnWqL9hNjBiHp1pgopGN2hm9Q4U7GeKRRyineA8Svs7P4T
         LcWwt5VnlgYKGOQCCFocZseBOD12t9U+ULCfibP0ey5t8r5/mVtyfQR/7/+MGg7Qgu
         UZO26MNEtkDeliJFerKTXpF0wAAAvumK+dqC+B3eQ8cAveteRJfEgiCeI8Sw6KzFM4
         8x5y1Hzny4rE/yc2lCyAdNg8yOMcnTtdma/ODfbrrLMGsQqd7/Du09jWIfy02rP8pH
         30ZxpaK9JQRro7MTiiEGPDmD5XfIEdM8wyURWZu5t7mqjDgQYdQQDZAep7564jSh+g
         tBxip7ab5NAag==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 31 Oct 2023 17:48:14 +0100
Subject: [PATCH RFC v3 01/37] drm/connector: Introduce an HDMI connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-kms-hdmi-connector-state-v3-1-328b0fae43a7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=mripard@kernel.org;
 h=from:subject:message-id; bh=VPZB/POV7iVmeWtbXi3+KcObCDwbStqo6BKswkAb6p8=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmO+ndLbqf1LJsbrPBv38onJ79PmFBYLl/7V9/DUU1FQ
 C0r/65NRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACYyX5OR4eKqC70GV203W2aX
 v48vP7Vg5aXdR2TS1/MGPGd46FXbJczwP55/f9HWlJNaUcve6l1+Mp/NYpPj9JQ6X5XDfSeZ1qy
 v4AQA
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

A lot of the various HDMI drivers duplicate some logic that depends on
the HDMI spec itself and not really a particular hardware
implementation.

Output BPC or format selection, infoframe generation are good examples
of such areas.

This creates a lot of boilerplate, with a lot of variations, which makes
it hard for userspace to rely on, and makes it difficult to get it right
for drivers.

Let's create a new connector variant specifically dedicated to HDMI
controllers that will allow to abstract away the duplicated logic.

Hopefully, this will make drivers simpler to handle, and their behaviour
more consistent.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_connector.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index c44d5bcf1284..997f8ab21d04 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -452,6 +452,45 @@ int drmm_connector_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_connector_init);
 
+/**
+ * drmm_connector_hdmi_init - Init a preallocated HDMI connector
+ * @dev: DRM device
+ * @connector: A pointer to the HDMI connector to init
+ * @funcs: callbacks for this connector
+ * @connector_type: user visible type of the connector
+ * @ddc: optional pointer to the associated ddc adapter
+ *
+ * Initialises a preallocated HDMI connector. Connectors can be
+ * subclassed as part of driver connector objects.
+ *
+ * Cleanup is automatically handled with a call to
+ * drm_connector_cleanup() in a DRM-managed action.
+ *
+ * The connector structure should be allocated with drmm_kzalloc().
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drmm_connector_hdmi_init(struct drm_device *dev,
+			     struct drm_connector *connector,
+			     const struct drm_connector_funcs *funcs,
+			     int connector_type,
+			     struct i2c_adapter *ddc)
+{
+	int ret;
+
+	if (!(connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	      connector_type == DRM_MODE_CONNECTOR_HDMIB))
+		return -EINVAL;
+
+	ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(drmm_connector_hdmi_init);
+
 /**
  * drm_connector_attach_edid_property - attach edid property.
  * @connector: the connector
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index d300fde6c1a4..c86cd363d652 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1894,6 +1894,11 @@ int drmm_connector_init(struct drm_device *dev,
 			const struct drm_connector_funcs *funcs,
 			int connector_type,
 			struct i2c_adapter *ddc);
+int drmm_connector_hdmi_init(struct drm_device *dev,
+			     struct drm_connector *connector,
+			     const struct drm_connector_funcs *funcs,
+			     int connector_type,
+			     struct i2c_adapter *ddc);
 void drm_connector_attach_edid_property(struct drm_connector *connector);
 int drm_connector_register(struct drm_connector *connector);
 void drm_connector_unregister(struct drm_connector *connector);

-- 
2.41.0

