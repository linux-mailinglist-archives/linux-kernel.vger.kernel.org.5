Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B377ACB9D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjIXT0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjIXT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC6103
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c108e106f0so83255011fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583580; x=1696188380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y8h3EEz9VirQFhjmojPuvqBkQuqu/oUUWDuJnG4W+c=;
        b=M490nm+YnzsS6uGhB710H9q5n9pSWJMhz7Du4/0xk4nZK0Ys+uQn4Rm8otYw8m9+1k
         u9xbfRQn1GzqHGa1iKRf6xcTxJzMbHVvJac+dMci9JaGylp++6jSvxebueL4FBTQxqvm
         dHpQ5ybxVUrq87WFvtFvt46SdGr1qYOuTqO2HtH7UH9Z7nB4iuBdMXj5O42c92goH7Nf
         +ak19+ncEObB/QnBYQHPJ6o8ucjL6Ync/7Vo1ZfqN9En8mKIEvahRPbkY0c5n4ICKTJM
         E0dKoHjHlFvHD7KTrFs/jAgx3/qAJW3yLpejl3eLAnGUvWqjt1/4wtwROgkNhPVRisUy
         YspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583580; x=1696188380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8y8h3EEz9VirQFhjmojPuvqBkQuqu/oUUWDuJnG4W+c=;
        b=t+hP4j/ZlJBzOa1G3qZH/WS0/foeZ4OUZvm6f+nlfBe+EzBt/3+g/d5CPOZzwqhoyQ
         yrWb/5esaqa8yd5YJ4lBzyYl40+bGvWT0CN9+EclO9qJHPZKk43OMYqfX8PsGN2lD+JZ
         nALUaNVVFLEVCjUDvxeB6zLETOljcyQYTi+4GRBco6D46jmZEEX/IJXNQ1vmXd2dgUrJ
         6rzSeiGGmAiAplmxOJyu5pWuhcKPK1WOsKw8yT8QHxWD+UXsrhahmm7pfN+dps1JMc9b
         qvaDsRYZyY8IlxKGBGzLQo2FW/5+P5EU/j3PsNWuGeLH4HVg0X2TzyDHHSADrgq8ffZJ
         AdmA==
X-Gm-Message-State: AOJu0Ywfm2lQhyrqwjGwXFnusC3KFDL9mkYEyu45O/o9Myaauhy9j/ze
        D5R4zMRFJz6dduOqnTR0nmQ=
X-Google-Smtp-Source: AGHT+IGnY2zymlYXEbyV+5gsOUvzTU+WsC5ThrC5P4hO3P9yxgQq4BLXWnYLwnhf4fRNeIa24G6f0Q==
X-Received: by 2002:a2e:2417:0:b0:2c0:2ab7:9ab5 with SMTP id k23-20020a2e2417000000b002c02ab79ab5mr4174912ljk.12.1695583579523;
        Sun, 24 Sep 2023 12:26:19 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:19 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 7/7] drm/sun4i: dw-hdmi: check for phy device first
Date:   Sun, 24 Sep 2023 21:26:04 +0200
Message-ID: <20230924192604.3262187-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check for phy device first. Since it uses much of the same clocks
and resets it also lowers amount of possible deferred probes.

While at it, don't report error for deferred phy probe.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 35 +++++++++++++--------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 41f815a1faec..c1becd964326 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -173,11 +173,24 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	struct device_node *phy_node;
 	struct drm_encoder *encoder;
 	struct sun8i_dw_hdmi *hdmi;
+	struct sun8i_hdmi_phy *phy;
 	int ret;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
+	phy_node = of_parse_phandle(dev->of_node, "phys", 0);
+	if (!phy_node) {
+		dev_err(dev, "Can't find PHY phandle\n");
+		return -EINVAL;
+	}
+
+	phy = sun8i_hdmi_phy_get(phy_node);
+	of_node_put(phy_node);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				     "Couldn't get the HDMI PHY\n");
+
 	hdmi = drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
@@ -185,6 +198,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	plat_data = &hdmi->plat_data;
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
+	hdmi->phy = phy;
 
 	hdmi->quirks = of_device_get_match_data(dev);
 
@@ -232,22 +246,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_assert_ctrl_reset;
 	}
 
-	phy_node = of_parse_phandle(dev->of_node, "phys", 0);
-	if (!phy_node) {
-		dev_err(dev, "Can't found PHY phandle\n");
-		ret = -EINVAL;
-		goto err_disable_clk_tmds;
-	}
-
-	hdmi->phy = sun8i_hdmi_phy_get(phy_node);
-	of_node_put(phy_node);
-	if (IS_ERR(hdmi->phy)) {
-		dev_err(dev, "Couldn't get the HDMI PHY\n");
-		ret = PTR_ERR(hdmi->phy);
-		goto err_disable_clk_tmds;
-	}
-
-	ret = sun8i_hdmi_phy_init(hdmi->phy);
+	ret = sun8i_hdmi_phy_init(phy);
 	if (ret)
 		goto err_disable_clk_tmds;
 
@@ -259,7 +258,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	plat_data->mode_valid = hdmi->quirks->mode_valid;
 	plat_data->use_drm_infoframe = hdmi->quirks->use_drm_infoframe;
 	plat_data->output_port = 1;
-	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
+	sun8i_hdmi_phy_set_ops(phy, plat_data);
 
 	platform_set_drvdata(pdev, hdmi);
 
@@ -310,7 +309,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	drm_bridge_remove(&hdmi->enc_bridge);
 	dw_hdmi_remove(hdmi->hdmi);
 err_deinit_phy:
-	sun8i_hdmi_phy_deinit(hdmi->phy);
+	sun8i_hdmi_phy_deinit(phy);
 err_disable_clk_tmds:
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
-- 
2.42.0

