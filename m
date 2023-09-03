Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD4790E5A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349395AbjICVmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348987AbjICVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:42:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E401ECC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:41:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ff09632194so1457227e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777314; x=1694382114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp5vM1gl9RU86RuI50kxi2LQD61SiuVQj5J5+OGEdj8=;
        b=LzKuaU5Io7ERItKEqZSokMqcg2iAa7++TcfdkS0yu+CR7wFonJYS7+ZdKr9DSYx/yi
         86mmet212rmoU5Dw9VVnk7lhIeLnn0zaNTGymvSvzYzWAA4XOeWgPSdV/z/2Kqak2aZ9
         NbOyn1woZTbkezEHcfieOJxq2Cc1qlXvrJrNNQ1QNB+y0G+02m8O98romojdQ6SNA6yY
         tezO6y6hXQA986TSsp4iXyKAA+FVwWGyTFqhhqUKreX1L/XTG2Ke8yAaZWsJU9r08Kve
         3ygwAjaBFUJBequ0/hBMcHsCJmbBviNfoNfReeogrLaEqJQxJit6I+6BT/IGngECh0g0
         t9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777314; x=1694382114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp5vM1gl9RU86RuI50kxi2LQD61SiuVQj5J5+OGEdj8=;
        b=f+huO0Ygq4BQR9zxvpiFHZya/4HVqoRouO1PdERgCnU9/V3A+VoPzGM86DWcAgeCMJ
         bZKeJpC93Ms/btUEzpyMpS5qT7eS6JPQcEEjzhe6ucwLwxPuvoyrfFfB1J8g9J0u8zKF
         LGn3Xpp4Q570jnykV/BwUS3kziWduE8dczZ5NsLxt+G65XvqGTTLlhu0ElQW1HURi6GM
         gz5+qWl/GHUSvpJHIwAJQpUO4X1OgiGKCKM6C0BjZHWJjHV//EjIGxuk05QXpmcS3MSW
         pqww4Mercp0Mxo5fAnuGA2U0N4VGbXb5N82gdDMnoUh+lEgygiPnD+RDB+fsAawGPn+m
         9+0Q==
X-Gm-Message-State: AOJu0Yz3OYqcWIjiPQhkWvpIkkofndzKdyg+2CgigfiHsC7KIMlMUKak
        9JErhvqo2uI+IawrlqENsSzA3Q==
X-Google-Smtp-Source: AGHT+IGDQQbfVXjBOtsl8V14iEcrDkjhs9AHs4yCZXqJ/byBpZFqNkhX6ECkcKXY9MxCWwyt+uunZA==
X-Received: by 2002:a05:6512:711:b0:4fe:5860:7abf with SMTP id b17-20020a056512071100b004fe58607abfmr4579227lfs.13.1693777314266;
        Sun, 03 Sep 2023 14:41:54 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH v1 04/12] drm/bridge-connector: set the PATH property for the connector
Date:   Mon,  4 Sep 2023 00:41:42 +0300
Message-Id: <20230903214150.2877023-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to properly identify connectors (in particular, DisplayPort
connectors wrapped into USB-C) allow bridge drivers to specify the value
to be used for connector's PATH property.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 12 ++++++++++++
 include/drm/drm_bridge.h               |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index bf73960c2c2a..008d730e1c2f 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -331,6 +331,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *bridge, *panel_bridge = NULL;
+	const char *path = NULL;
 	int connector_type;
 	int ret;
 
@@ -377,6 +378,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			connector->fwnode = fwnode_handle_get(of_fwnode_handle(bridge->of_node));
 #endif
 
+		if (bridge->path)
+			path = bridge->path;
+
 		if (bridge->ddc)
 			ddc = bridge->ddc;
 
@@ -405,6 +409,14 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
 
+	if (path) {
+		drm_object_attach_property(&connector->base,
+					   drm->mode_config.path_property,
+					   0);
+
+		drm_connector_set_path_property(connector, path);
+	}
+
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c339fc85fd07..98e9d76474f4 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -753,6 +753,13 @@ struct drm_bridge {
 	 * before the peripheral.
 	 */
 	bool pre_enable_prev_first;
+	/**
+	 * @path: the 'path' of the bridge. For bridges at the end of this
+	 * chain this is used to set the 'PATH' property of the connector.
+	 * This string is not freed manually, so one either should use a static
+	 * string here or a devres-allocated one.
+	 */
+	const char *path;
 	/**
 	 * @ddc: Associated I2C adapter for DDC access, if any.
 	 */
-- 
2.39.2

