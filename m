Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C47D35EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjJWL4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjJWL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:56:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E5E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92944C433C7;
        Mon, 23 Oct 2023 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698062185;
        bh=1+28/6sjktXSx20VT4aBejWjJno2W+nx1lt9g1Derzk=;
        h=From:To:Cc:Subject:Date:From;
        b=SRZ3njiE1l15k+v4qnnCRkwXcCX87kbZVmWkIKhpZ3uRj59Y6BCHOdYiZjuvQby5X
         gWvJcejUGRaSp62vhX76W2bztZCh3wOnRtbrDBkNcPaEfkZN4vewcNIlYOZHOpapkX
         5h/jb9Zt/3ajC/KfTHEMkE6xq0pqf15yJ1JmdD6qMiaev2jHntSrBfSSilo1bxpNFw
         wKZa/QdgxtBJQxCSpPxw9wFx2rhQ/pHrooNLBYAP9Vq1125uxW84CeFG8hkSW1I8lf
         uunm4ezeRUODmkQQQnDc+TylpuXIhNLnry+GbhkUh9KksfAEg9b7jkQqJko4qW1gXG
         pZpnY4GBLUPBw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel/raydium-rm692e5: select CONFIG_DRM_DISPLAY_DP_HELPER
Date:   Mon, 23 Oct 2023 13:55:58 +0200
Message-Id: <20231023115619.3551348-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As with several other panel drivers, this fails to link without the DP
helper library:

ld: drivers/gpu/drm/panel/panel-raydium-rm692e5.o: in function `rm692e5_prepare':
panel-raydium-rm692e5.c:(.text+0x11f4): undefined reference to `drm_dsc_pps_payload_pack'

Select the same symbols that the others already use.

Fixes: 988d0ff29ecf7 ("drm/panel: Add driver for BOE RM692E5 AMOLED panel")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 99e14dc212ecb..a4ac4b47777fe 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -530,6 +530,8 @@ config DRM_PANEL_RAYDIUM_RM692E5
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Raydium RM692E5-based
 	  display panels, such as the one found in the Fairphone 5 smartphone.
-- 
2.39.2

