Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F8D790E83
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245544AbjICVm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349003AbjICVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:42:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98522103
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:41:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50091b91a83so1453333e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777315; x=1694382115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxzYLYfsMsF6kZIITXju1taC/sMkbxWNFfavaK+QQhU=;
        b=ol2cmF1Ocr6XjMIqA//EXbkHdrd4tbITPgQ9dfba3zCGi4O/YeaSmYsvRpLvXvbew0
         CaJTC2FwS5lXnQkMTf0uNTAI2CZJ7ZrC38V2ZqxxC2DYN6DakeUYsAGoZZzH0LcHTQOq
         i0HCP32Xn4Yf8+AlwQraR/f1hPjJ9yRz4sueO2Pa/HETpcJYWOnN0wTENILYyYgWWcDR
         /OKTfsZs/GTZK3EhuFZxpRKx61Jog+I9Duyr3lKsNynpwQB86pRIdyaZn94yq9Z+X7H9
         Uk0VnJdkGBThj7gVbDQb2WtTX7Yift/0qgnXnpDtoNyq6qTG7ZgzsYQ/s5vVhWgAEA7C
         tjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777315; x=1694382115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxzYLYfsMsF6kZIITXju1taC/sMkbxWNFfavaK+QQhU=;
        b=jGCn+FO2dms5b1/07BxdV0IzWlMn1QUAitsxACZZfOV9GCk0jCMtzVJ/CDMY+E9G1y
         1tKOhFCUD7gQtzXjvN6HtA8yvA3EAyJH0BuHl5nw2SAJMG5yw50ymleFj2Rq4izyyMap
         TuUo9aYSaF3mUMe7xmw5unk81thqcB5v/zzoZW2yEsklYG+idDRwIdu399O4c6jf/6cm
         Dfc38BOE8n92z3+MSY/ZR0lFzLEBqz/zMg/+oicjtyXARU4NbEl9MOBFCXGmZcbicIWO
         2mvdRhCBo5HAlxLyuRb1CpclaPkD9ydtbkeTNfyWj+3uzt+bXexE/il9TkkZQMTYH6ir
         ttdg==
X-Gm-Message-State: AOJu0YxcmaH9PkfVphiIVI64Nwomxpfz4gSsQWQ7SknZcKWa3TqTWfTy
        7qg2zdWtvgiUFJZX9fyYYLbcLg==
X-Google-Smtp-Source: AGHT+IHkhutnflS0UUIMoJstZXZDY/ceuTUjBBh2pmrIlmKpCCqxCMZjLAzGe9MmdoJHda/q0FEUHw==
X-Received: by 2002:a19:4f4f:0:b0:500:a1e4:fc44 with SMTP id a15-20020a194f4f000000b00500a1e4fc44mr4968258lfk.61.1693777315009;
        Sun, 03 Sep 2023 14:41:55 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:54 -0700 (PDT)
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
Subject: [RFC PATCH v1 05/12] drm/bridge: remove conditionals around devicetree pointers
Date:   Mon,  4 Sep 2023 00:41:43 +0300
Message-Id: <20230903214150.2877023-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
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

Remove ifdef CONFIG_OF around the drm_bridge::of_node field. This follow
the correponding change to struct device we had since 2.6.39. Having
conditional around the of_node pointers turns out to make driver code
use ugly #ifdef blocks. Drop the conditionals and remove the #ifdef
blocks from the affected drivers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/panel.c         | 2 --
 drivers/gpu/drm/drm_bridge_connector.c | 2 --
 include/drm/drm_bridge.h               | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 9316384b4474..7f41525f7a6e 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -302,9 +302,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 	panel_bridge->panel = panel;
 
 	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
-#ifdef CONFIG_OF
 	panel_bridge->bridge.of_node = panel->dev->of_node;
-#endif
 	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
 	panel_bridge->bridge.type = connector_type;
 
diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 008d730e1c2f..ca255609fb08 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -372,11 +372,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (!drm_bridge_get_next_bridge(bridge))
 			connector_type = bridge->type;
 
-#ifdef CONFIG_OF
 		if (!drm_bridge_get_next_bridge(bridge) &&
 		    bridge->of_node)
 			connector->fwnode = fwnode_handle_get(of_fwnode_handle(bridge->of_node));
-#endif
 
 		if (bridge->path)
 			path = bridge->path;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 98e9d76474f4..afa1de791075 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -716,10 +716,8 @@ struct drm_bridge {
 	struct drm_encoder *encoder;
 	/** @chain_node: used to form a bridge chain */
 	struct list_head chain_node;
-#ifdef CONFIG_OF
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
-#endif
 	/** @list: to keep track of all added bridges */
 	struct list_head list;
 	/**
-- 
2.39.2

