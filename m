Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1784752EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjGNBic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjGNBiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39CA2D61;
        Thu, 13 Jul 2023 18:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B230D61BBB;
        Fri, 14 Jul 2023 01:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6E6C433D9;
        Fri, 14 Jul 2023 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298684;
        bh=EyFDzV4ddqw1sjwHBTSR4kWEp2hOqnAjhUV748qVmZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HysJGfs/dIwxuKwN3vBYM0JpBWVvtSNxLGpwu9TNJpI3Ie6yITYRQ5ZlzvdRFhAV1
         sm0BCuMYOalW0M3sx5jvgtizhq9QiQYD1KBjGWpnJvah4OAPEUrnCWSo+FZrM8eHtt
         mxDXBSfDJvl9+GWOBH34u+2mo7sJMRHvPyDI8DlQ37YPjm1AxXoIxejrxJ0sCcjZNN
         u1TMZUeL6nmsrSwibZ/p6SqMifWqJ+L2YO4lQliO9ludKlt/vbAUvZjpB+VuWnFT87
         TDW/iTkCWoikzVAeaLfzkVCAOoFRm6YF6+0jqyp21w+zYH/UQ0snemsabIGtoR1NVx
         kSZvCf/n4GTSg==
Received: by mercury (Postfix, from userid 1000)
        id DAB131067697; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 07/19] drm/panel: sitronix-st7789v: improve error handling
Date:   Fri, 14 Jul 2023 03:37:44 +0200
Message-Id: <20230714013756.1546769-8-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714013756.1546769-1-sre@kernel.org>
References: <20230714013756.1546769-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve error handling in the probe routine, so that probe
defer errors are captured in /sys/kernel/debug/devices_deferred

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 6290bd49d055..a6d6155ef45c 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -348,32 +348,33 @@ static const struct drm_panel_funcs st7789v_drm_funcs = {
 
 static int st7789v_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct st7789v *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(&spi->dev, sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, ctx);
 	ctx->spi = spi;
 
-	drm_panel_init(&ctx->panel, &spi->dev, &st7789v_drm_funcs,
+	drm_panel_init(&ctx->panel, dev, &st7789v_drm_funcs,
 		       DRM_MODE_CONNECTOR_DPI);
 
-	ctx->power = devm_regulator_get(&spi->dev, "power");
-	if (IS_ERR(ctx->power))
-		return PTR_ERR(ctx->power);
+	ctx->power = devm_regulator_get(dev, "power");
+	ret = PTR_ERR_OR_ZERO(ctx->power);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
 
-	ctx->reset = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(ctx->reset)) {
-		dev_err(&spi->dev, "Couldn't get our reset line\n");
-		return PTR_ERR(ctx->reset);
-	}
+	ctx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(ctx->reset);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get reset line\n");
 
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
 	drm_panel_add(&ctx->panel);
 
-- 
2.40.1

