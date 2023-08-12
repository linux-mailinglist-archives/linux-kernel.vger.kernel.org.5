Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75177A1E9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjHLSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHLSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:53:12 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC019A4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:52:58 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 5C287160D84;
        Sat, 12 Aug 2023 20:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1691866376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p+cYZqPkq2yEiMfVnzXTw563FqsEFK6qc54FcPd8+P0=;
        b=K3MLvFpImbRBT6R7DBzNxwdVTxUCRU1KwWNdGL873rYIcyGGTLP5WDe6SyI5JwTQsX1443
        Id9l0PcuhrNLqcy4AKi/D3cqIlztMyWiCScCihqdTzt7pKcmRcaA079VWJ3yjtdt1L1PU5
        qL5/zP0mBFSLRdzsrzedG/wCGDD6eG8=
From:   David Heidelberg <david@ixit.cz>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     David Heidelberg <david@ixit.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] drm/panel: JDI LT070ME05000 simplify with dev_err_probe()
Date:   Sat, 12 Aug 2023 20:52:39 +0200
Message-Id: <20230812185239.378582-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error is printed.

Fixes error:
panel-jdi-lt070me05000 4700000.dsi.0: cannot get enable-gpio -517

Signed-off-by: David Heidelberg <david@ixit.cz>
---
resend:
 - applies cleanly on -next
v2:
 - original v1 patch name "drm/panel: JDI LT070ME05000 remove useless warning"
 - use dev_err_probe function

 .../gpu/drm/panel/panel-jdi-lt070me05000.c    | 36 ++++++++-----------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index e94c98f00391..f9a69f347068 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -400,38 +400,30 @@ static int jdi_panel_add(struct jdi_panel *jdi)
 
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(jdi->supplies),
 				      jdi->supplies);
-	if (ret < 0) {
-		dev_err(dev, "failed to init regulator, ret=%d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to init regulator, ret=%d\n", ret);
 
 	jdi->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(jdi->enable_gpio)) {
-		ret = PTR_ERR(jdi->enable_gpio);
-		dev_err(dev, "cannot get enable-gpio %d\n", ret);
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(jdi->enable_gpio),
+				     "cannot get enable-gpio %d\n", ret);
 	}
 
 	jdi->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(jdi->reset_gpio)) {
-		ret = PTR_ERR(jdi->reset_gpio);
-		dev_err(dev, "cannot get reset-gpios %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(jdi->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(jdi->reset_gpio),
+				     "cannot get reset-gpios %d\n", ret);
 
 	jdi->dcdc_en_gpio = devm_gpiod_get(dev, "dcdc-en", GPIOD_OUT_LOW);
-	if (IS_ERR(jdi->dcdc_en_gpio)) {
-		ret = PTR_ERR(jdi->dcdc_en_gpio);
-		dev_err(dev, "cannot get dcdc-en-gpio %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(jdi->dcdc_en_gpio))
+		return dev_err_probe(dev, PTR_ERR(jdi->dcdc_en_gpio),
+				     "cannot get dcdc-en-gpio %d\n", ret);
 
 	jdi->backlight = drm_panel_create_dsi_backlight(jdi->dsi);
-	if (IS_ERR(jdi->backlight)) {
-		ret = PTR_ERR(jdi->backlight);
-		dev_err(dev, "failed to register backlight %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(jdi->backlight))
+		return dev_err_probe(dev, PTR_ERR(jdi->backlight),
+				     "failed to register backlight %d\n", ret);
 
 	drm_panel_init(&jdi->base, &jdi->dsi->dev, &jdi_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-- 
2.40.1

