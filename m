Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7737752EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjGNBiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGNBiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF82D61;
        Thu, 13 Jul 2023 18:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 235DE61B9C;
        Fri, 14 Jul 2023 01:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F38C433C9;
        Fri, 14 Jul 2023 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298684;
        bh=naWE2eIjBBKz4B0jzEm35l9sKG56Gwsd4NcCsuZtNmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ViZ3Xf2bDb4Ex0evOPyohm+RJpRzM1CaULxqTMG9sM4Rf4V0qwdWNz3ro5yQJombh
         s5xcWLyK7rE6Ko+WdBwDxOg5pjbxLIklK31DXLIGVJ+F9JBhJ1HDcmHS90uq1WQaS3
         PgEnCOd/xgUjU/4P4xQXT3B/+dJVtQpOff+6vI6pHPgE2NP/DLXz2ru8ga6OObZc04
         gtDcaNCeQDGHaGAU93qkPLVBvSJ2yHxwXPKtgWcHybBV0VoYCjn26qztzZ9JG4s2Uj
         nZx/SIPQ/rstuL1a3lJja6k5GZxLBVPeFvqOTgH6CTRgpMShVLJKXK8aqIuWifPpd2
         gePG2ekNWgToQ==
Received: by mercury (Postfix, from userid 1000)
        id E509310676F3; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
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
Subject: [PATCH v3 11/19] drm/panel: sitronix-st7789v: avoid hardcoding invert mode
Date:   Fri, 14 Jul 2023 03:37:48 +0200
Message-Id: <20230714013756.1546769-12-sre@kernel.org>
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

While the default panel uses invert mode, some panels
require non-invert mode instead.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index d05d7a9caefc..ee84d7a9019e 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -112,6 +112,7 @@
 struct st7789_panel_info {
 	const struct drm_display_mode *mode;
 	u32 bus_format;
+	bool invert_mode;
 };
 
 struct st7789v {
@@ -171,6 +172,7 @@ static const struct drm_display_mode default_mode = {
 
 static const struct st7789_panel_info default_panel = {
 	.mode = &default_mode,
+	.invert_mode = true,
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
@@ -321,7 +323,13 @@ static int st7789v_prepare(struct drm_panel *panel)
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_NVGAMCTRL_VN61(0x1b)));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_NVGAMCTRL_VN62(0x28)));
 
-	ST7789V_TEST(ret, st7789v_write_command(ctx, MIPI_DCS_ENTER_INVERT_MODE));
+	if (ctx->info->invert_mode) {
+		ST7789V_TEST(ret, st7789v_write_command(ctx,
+						MIPI_DCS_ENTER_INVERT_MODE));
+	} else {
+		ST7789V_TEST(ret, st7789v_write_command(ctx,
+						MIPI_DCS_EXIT_INVERT_MODE));
+	}
 
 	ST7789V_TEST(ret, st7789v_write_command(ctx, ST7789V_RAMCTRL_CMD));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RAMCTRL_DM_RGB |
-- 
2.40.1

