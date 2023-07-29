Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB72C767A72
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbjG2BCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbjG2BCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:02:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2612D3C33
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:02:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991da766865so368870166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690592519; x=1691197319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW+vdrPDM+RdVg71eRxchKCcF3Il7t8mgNv0e+r+q2g=;
        b=sgJZMUppk51vG9NQLtB6RwoaQNyvkwHnBaeMFnTaBVFsLUM/CuWpYoyaqsfFPspBT0
         sTPY/fw4jOQ0yQQQIBCkZW8clyjaJkbR3hojtql3mlP54YgbkyDTGQaV14sP2prxeNrL
         Fn6fH0Nx7A94g6JMrBD9wLlnQ31WeHapS9AFHXQD/hILOUJ+T0INg6XudXbKJpUBaMfo
         OKOt872ln+siWrPz6ZhnjYiLRQ1yVWAtdLEvb5fiSaeui1heY4p9FQ+4eRiguh4wqDxH
         PQyNu0TdHFqoEOcE16dwuFvuZPVdxTu/YazVoSeh9WQgy7ulIHF/frEfHa63Q4UqArjj
         gF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690592519; x=1691197319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YW+vdrPDM+RdVg71eRxchKCcF3Il7t8mgNv0e+r+q2g=;
        b=VOoagDnezcPRwq157jW+ZPBk3vbVGCOJlX/Xo/vfqM723TdqONqYnujq/OG01oI2GX
         I6aBDRQ8TZjaDCkeP0V1TtCNmdNOdf2IvlrpfKPw6izGvT05C3HfFjKw0U0sofyROeIU
         u7/g7Yn8SPCySM+xfk3iznYopzJnHObPPt5CDZRQI4/SaPALFPu6aebQ7NNagPiE6foA
         qXw/sJJRjHmMEr4DAnsc2YS2lNGVWBMmz/8PWOkIckRZOWYdP4jWdvA31Ec07vrO+YsB
         6nEKCXSyXJeH9XziSKGPHRJD/wDcFRMHjgttAw6pcoPZl0fm5P01iV/nz/0D0usxPV3P
         xYsw==
X-Gm-Message-State: ABy/qLawFV3GP5xivLowKbz6MekUqqkyS9/mYGBCRBkJp7o/RrBE+68e
        3beGcjJokzZT865m0Z5s+YRSpfudHUM/aiU5hl8=
X-Google-Smtp-Source: APBJJlHxkNkwO/iPuYTiXx1h0xuPIgYhC0FuY/A0rwJ8a+n7wJCY6wfeH1lslHO85cVzE3F+Zwgqog==
X-Received: by 2002:a19:915c:0:b0:4f8:711b:18b0 with SMTP id y28-20020a19915c000000b004f8711b18b0mr2325597lfj.3.1690591756020;
        Fri, 28 Jul 2023 17:49:16 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a24-20020a19f818000000b004fe20d1b288sm500702lff.159.2023.07.28.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:49:15 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/bridge-connector: handle subconnector types
Date:   Sat, 29 Jul 2023 03:49:11 +0300
Message-Id: <20230729004913.215872-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the created connector type supports subconnector type property,
create and attach corresponding it. The default subtype value is 0,
which maps to the DRM_MODE_SUBCONNECTOR_Unknown type.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 33 +++++++++++++++++++++++++-
 include/drm/drm_bridge.h               |  4 ++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 07b5930b1282..a7b92f0d2430 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -329,7 +329,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *bridge, *panel_bridge = NULL;
+	enum drm_mode_subconnector subconnector;
 	int connector_type;
+	int ret;
 
 	bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
 	if (!bridge_connector)
@@ -365,8 +367,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (bridge->ops & DRM_BRIDGE_OP_MODES)
 			bridge_connector->bridge_modes = bridge;
 
-		if (!drm_bridge_get_next_bridge(bridge))
+		if (!drm_bridge_get_next_bridge(bridge)) {
 			connector_type = bridge->type;
+			subconnector = bridge->subtype;
+		}
 
 #ifdef CONFIG_OF
 		if (!drm_bridge_get_next_bridge(bridge) &&
@@ -399,6 +403,33 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
+		drm_connector_attach_dp_subconnector_property(connector, subconnector);
+	} else if (connector_type == DRM_MODE_CONNECTOR_DVII) {
+		ret = drm_mode_create_dvi_i_properties(drm);
+		if (ret)
+			return ERR_PTR(ret);
+
+		drm_object_attach_property(&connector->base,
+					   drm->mode_config.dvi_i_subconnector_property,
+					   subconnector);
+	} else if (connector_type == DRM_MODE_CONNECTOR_TV) {
+		ret = drm_mode_create_tv_properties(drm,
+						    BIT(DRM_MODE_TV_MODE_NTSC) |
+						    BIT(DRM_MODE_TV_MODE_NTSC_443) |
+						    BIT(DRM_MODE_TV_MODE_NTSC_J) |
+						    BIT(DRM_MODE_TV_MODE_PAL) |
+						    BIT(DRM_MODE_TV_MODE_PAL_M) |
+						    BIT(DRM_MODE_TV_MODE_PAL_N) |
+						    BIT(DRM_MODE_TV_MODE_SECAM));
+		if (ret)
+			return ERR_PTR(ret);
+
+		drm_object_attach_property(&connector->base,
+					   drm->mode_config.tv_subconnector_property,
+					   subconnector);
+	}
+
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bf964cdfb330..68b14ac5ac0d 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -739,6 +739,10 @@ struct drm_bridge {
 	 * identifies the type of connected display.
 	 */
 	int type;
+	/**
+	 * @subtype: the subtype of the connector for the DP/TV/DVI-I cases.
+	 */
+	enum drm_mode_subconnector subtype;
 	/**
 	 * @interlace_allowed: Indicate that the bridge can handle interlaced
 	 * modes.
-- 
2.39.2

