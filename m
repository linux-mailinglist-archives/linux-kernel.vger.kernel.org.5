Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDEF759642
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGSNJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGSNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026210FE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA4756162A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4A5C433C8;
        Wed, 19 Jul 2023 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689772185;
        bh=emvLdW7AGgXpWhAQUruy5IEnajx3zbwFXE7kJcAzRvk=;
        h=From:To:Cc:Subject:Date:From;
        b=RdCHsQw8isbZoU2ldlm5G9kcGyB4SZBiDMYIUpVgXRyghH1YD7DOgHmbg4Ge8tW+I
         opSlEOYrbLMAUHuak2sqi+Z3JPvlSiuV5uw5wo0v2+pBZlULn2lJeUoS8EAAu9bF1p
         Fe6XJerUfw1UpRMvU0XVBqPmOo6vYogitYxhRU24/oZ/t8HV50NV2Vwju3cR9sEh4P
         6ZY/xuCV9kxlqZAHmWfkuZbCpvlChcMaNDuzmfHsYNPAU+EuDa/DX3Y2MvpLn4xLrY
         OSaM7UeJcFhrdqw2fPFgN2GNHPNzBZhhfxE+/sBvtwGx+FlkTBDLilDGkNRVeo38Vr
         cWL2+qPB6GLkQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: r66451: select CONFIG_DRM_DISPLAY_DP_HELPER
Date:   Wed, 19 Jul 2023 15:09:21 +0200
Message-Id: <20230719130940.659837-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver only builds when DRM_DISPLAY_DP_HELPER is enabled:

x86_64-linux-ld: drivers/gpu/drm/panel/panel-visionox-r66451.o: in function `visionox_r66451_enable':
panel-visionox-r66451.c:(.text+0x105): undefined reference to `drm_dsc_pps_payload_pack'

Select both CONFIG_DRM_DISPLAY_DP_HELPER and CONFIG_DRM_DISPLAY_HELPER to
ensure the helper function is always available.

Fixes: a6dfab2738fc2 ("drm/panel: Add driver for Visionox r66451 panel")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 1a0fd0754692e..e8c9f4613a4b4 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -798,6 +798,8 @@ config DRM_PANEL_VISIONOX_R66451
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Visionox
 	  R66451 1080x2340 AMOLED DSI panel.
-- 
2.39.2

