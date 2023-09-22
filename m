Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9B7AAA69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjIVHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjIVHhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:37:34 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE4F7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=5/L2thHtWZKVXF
        Yu87PpUqSLgjaKxLn7tKqu43zTTQ0=; b=ESd9dfqP1Gin/0Vqzn+Uvd3nrACKlb
        ooXTPhCJvWIWEHbm5olbEsNLmsBbTAMZiI0/yT252y5quyHLPmxD50iCMUB4ue8h
        iApsVdS1I95nrzeiOyB/8VlDlv8mv3UuzzzN95bo8d1st2RNGaz3CjvGz5HhCrgq
        NhfC9HpXqQUBaEpU1Z3Sr+BK07s3wtNBlw6AxD25ePFXcESxrGUsSdFB876nB101
        pIuPkID6FQiwV7L5YaGgBKq40NgdxOXPSEbZb6aeJaxA+ByNljPLwBNUyEvyJf1d
        uz2OaEqkmci+q02W+okDyj4ysMKta21FP2dTE0XnG6dtEe6AqJ6yBmmA==
Received: (qmail 1299584 invoked from network); 22 Sep 2023 09:37:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 09:37:23 +0200
X-UD-Smtp-Session: l3s3148p1@ENbBre0F5NgujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: tilcdc: don't use devm_pinctrl_get_select_default() in probe
Date:   Fri, 22 Sep 2023 09:37:13 +0200
Message-Id: <20230922073714.6164-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ab78029ecc34 ("drivers/pinctrl: grab default handles from
device core"), we can rely on device core for setting the default pins.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 9aefd010acde..68093d6b6b16 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -6,7 +6,6 @@
 
 #include <linux/backlight.h>
 #include <linux/gpio/consumer.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 #include <video/display_timing.h>
@@ -308,7 +307,6 @@ static int panel_probe(struct platform_device *pdev)
 	struct backlight_device *backlight;
 	struct panel_module *panel_mod;
 	struct tilcdc_module *mod;
-	struct pinctrl *pinctrl;
 	int ret;
 
 	/* bail out early if no DT data: */
@@ -342,10 +340,6 @@ static int panel_probe(struct platform_device *pdev)
 
 	tilcdc_module_init(mod, "panel", &panel_module_ops);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev, "pins are not configured\n");
-
 	panel_mod->timings = of_get_display_timings(node);
 	if (!panel_mod->timings) {
 		dev_err(&pdev->dev, "could not get panel timings\n");
-- 
2.30.2

