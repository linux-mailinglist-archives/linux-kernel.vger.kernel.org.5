Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F08D790E38
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbjICV3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348734AbjICV3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:29:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AA118
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:29:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500c63c9625so1400282e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693776581; x=1694381381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5QQwEFqCct7BAxDxlOQzyh1UFNTPO5xvPloHLAel3c=;
        b=bhqdKSGAszqeMRe9e1IFtBKgm5fxEVdjiR9uXlqGf1NCtWNW+rdz/D09zbsUy3ZBcM
         VJoLeBt6yHZauCOxg3+ZusooBODWSW9Cae5vWUCoDIdvJWsJOrvRr0uBjEb+T5iDkBHF
         GKkL6G7eqrjiiBU0DmYG2rM49W1CgcBuXShwsC5J+UG4yj5GdA4g1mN4wiKv8VrvHhe8
         h+eb3CpT8s1TjGr/UTkNsQ/kdV6i0Vi7aOh7R+L1Fg8StGCuUT0CJ7MYuxqDTM7bReeU
         O1kOT001/B/sreMX5c5oxU87okpG60eCwKRcxlQ1k4okr2Ep2RVetKftoPdWnB50DUuW
         8W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693776581; x=1694381381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5QQwEFqCct7BAxDxlOQzyh1UFNTPO5xvPloHLAel3c=;
        b=UmO4q/zEa937hTXCmyhlTfZGwFYt24KPXo+9rmX/+JK9KWQgDv10YyrFmURhSDakJy
         AxTk/F2l7/mJ5AtBwIOitJuNjdf4MS1OfgtbhAhvesQfugEcPlszdQN7AjeQQcvb4SB9
         QdcwzO4lvKWZOeAGPd+IkQ4jhKFXXTWJ3VuptZLMrUvtTpG8QmSdkwleytkkzA9t47ko
         7xPrPlbftp75JAGYer29JdyTG+GXHmVB4t99rlf2vPabSWYHkjq2xMEvnxY/2Zg5WDBL
         NzcuHHnI2il3XuMzmBFM2OacVlqmkw41aHgWJj8lx1NST7XfG/o4SGFl5ylmnSVhEM0w
         TnOg==
X-Gm-Message-State: AOJu0YyAt3DwuYMi0dIQ3WxIQV4vf72sLZID8mY4AXfwMLw42DvMoKGp
        H9zkjsZH25UaPFRAOKJjKGFuxw==
X-Google-Smtp-Source: AGHT+IFzGUwTyKGwD7PSfbMHsP+QYUbDM5UQr/fxVIRAAFQABie93pcvAKUcK3M3a83cjojEciNiLg==
X-Received: by 2002:a05:6512:1316:b0:4fb:90c6:c31a with SMTP id x22-20020a056512131600b004fb90c6c31amr6277330lfu.14.1693776581063;
        Sun, 03 Sep 2023 14:29:41 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id eq11-20020a056512488b00b004ff8d9ed368sm1412352lfb.258.2023.09.03.14.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:29:40 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 3/3] drm/bridge_connector: implement oob_hotplug_event
Date:   Mon,  4 Sep 2023 00:29:37 +0300
Message-Id: <20230903212937.2876815-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903212937.2876815-1-dmitry.baryshkov@linaro.org>
References: <20230903212937.2876815-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the oob_hotplug_event() callback. Translate it to the HPD
notification sent to the HPD bridge in the chain.

Reviewed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 31 +++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 10b52224db37..bf73960c2c2a 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -5,6 +5,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <drm/drm_atomic_state_helper.h>
@@ -107,10 +109,9 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 	}
 }
 
-static void drm_bridge_connector_hpd_cb(void *cb_data,
-					enum drm_connector_status status)
+static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bridge_connector,
+					    enum drm_connector_status status)
 {
-	struct drm_bridge_connector *drm_bridge_connector = cb_data;
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
 
@@ -123,6 +124,21 @@ static void drm_bridge_connector_hpd_cb(void *cb_data,
 	drm_kms_helper_connector_hotplug_event(connector);
 }
 
+static void drm_bridge_connector_hpd_cb(void *cb_data,
+					enum drm_connector_status status)
+{
+	drm_bridge_connector_handle_hpd(cb_data, status);
+}
+
+static void drm_bridge_connector_oob_hotplug_event(struct drm_connector *connector,
+						   enum drm_connector_status status)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+
+	drm_bridge_connector_handle_hpd(bridge_connector, status);
+}
+
 static void drm_bridge_connector_enable_hpd(struct drm_connector *connector)
 {
 	struct drm_bridge_connector *bridge_connector =
@@ -191,6 +207,8 @@ static void drm_bridge_connector_destroy(struct drm_connector *connector)
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 
+	fwnode_handle_put(connector->fwnode);
+
 	kfree(bridge_connector);
 }
 
@@ -216,6 +234,7 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.debugfs_init = drm_bridge_connector_debugfs_init,
+	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
 };
 
 /* -----------------------------------------------------------------------------
@@ -352,6 +371,12 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (!drm_bridge_get_next_bridge(bridge))
 			connector_type = bridge->type;
 
+#ifdef CONFIG_OF
+		if (!drm_bridge_get_next_bridge(bridge) &&
+		    bridge->of_node)
+			connector->fwnode = fwnode_handle_get(of_fwnode_handle(bridge->of_node));
+#endif
+
 		if (bridge->ddc)
 			ddc = bridge->ddc;
 
-- 
2.39.2

