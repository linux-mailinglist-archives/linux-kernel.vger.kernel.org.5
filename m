Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143D8752ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjGNBjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjGNBiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192FE30CA;
        Thu, 13 Jul 2023 18:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603F561BCB;
        Fri, 14 Jul 2023 01:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10512C43215;
        Fri, 14 Jul 2023 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298687;
        bh=8EUQj+RIHgeP2CyOzNZK9/zBLRftEAwim2XCQDawxbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqUi8calaC0JhBUS7zv46DVxb/CwAp9PVAgxFZiPUfQcwXiqXZ2VCsMkgZdmNrC8D
         Mj9FPcfGsYtZ77S531Wet8N89jRL9Hul80BaIBbmxIQh81uoRvo+FtvrtQiqjyNbbS
         jc1ZOsRxYsQVd8+zn6cJgokTghm6z6cayNzfiJ0ZfIuRSAyc++vzOuBMhY84b4rrGj
         OloQMFE7XcXJ8fCahwh8ZOef/D/ZfgBaQYHT8eYaQh+XXpj9qtWJKZev/g3G919n/U
         I56NtqPZ6u33dwul39oqihDa7fAtvoUVZuz86n5l/Bek4TBcDcU99zN/QR6PSpbIbt
         rIAAMlIX0Vktg==
Received: by mercury (Postfix, from userid 1000)
        id F34AB10676F8; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
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
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 16/19] drm/panel: sitronix-st7789v: Use 9 bits per spi word by default
Date:   Fri, 14 Jul 2023 03:37:53 +0200
Message-Id: <20230714013756.1546769-17-sre@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

The Sitronix controller expects 9-bit words, provide this as default at
probe time rather than specifying this in each and every access.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Tested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 55e475471f43..33bdf9ee4085 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -142,7 +142,6 @@ static int st7789v_spi_write(struct st7789v *ctx, enum st7789v_prefix prefix,
 	u16 txbuf = ((prefix & 1) << 8) | data;
 
 	xfer.tx_buf = &txbuf;
-	xfer.bits_per_word = 9;
 	xfer.len = sizeof(txbuf);
 
 	return spi_sync_transfer(ctx->spi, &xfer, 1);
@@ -436,6 +435,11 @@ static int st7789v_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, ctx);
 	ctx->spi = spi;
 
+	spi->bits_per_word = 9;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "Failed to setup spi\n");
+
 	ctx->info = device_get_match_data(&spi->dev);
 
 	drm_panel_init(&ctx->panel, dev, &st7789v_drm_funcs,
-- 
2.40.1

