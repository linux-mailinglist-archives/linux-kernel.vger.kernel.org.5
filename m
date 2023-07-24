Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3704A75F60B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGXMSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjGXMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3EF1BC2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF86D61137
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6F9C433C9;
        Mon, 24 Jul 2023 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690201075;
        bh=6Wv579trwS5Cciu3iVXhCndFsSYSuaaRiNeiqPnZ2h4=;
        h=From:To:Cc:Subject:Date:From;
        b=k2iu8GNEY+ZXAxiDKfFIUekNEw7/Ij2qXiSCU9PxBQ+dd63AZop4EVo0iqP04CkXP
         Q9MM57FzoPiLkhFMdI1qy2ePfLLbvVY9m8va8a+lmERmOVOw2EZNn+12U3al4IgTPC
         cM6NfVD0pqnfj/NqZko1NIAOlO/SEbkn+vPxAHfXPX/qel5ArKxKAHldxyiaOsAb5R
         5hcopEk0F7keqchPOsjOeOnV21Ie+R6yDmOl2Fn6qqYg3joNtNrY/bOo+JgI1IPRyB
         Plv6HHp16HgWwJ6uP34btPY01z5mmYd5Q79vZp9EokbP5vtdkd4CN+bSMznfwtju7+
         FXeC8sfVsm2Qw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: ld9040: add backlight Kconfig dependency
Date:   Mon, 24 Jul 2023 14:17:05 +0200
Message-Id: <20230724121736.1293270-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver now uses the backlight interface, which breaks when that
is disabled:

ld.lld: error: undefined symbol: devm_backlight_device_register

Enforce the necessary Kconfig dependency to avoid this.

Fixes: c2268daa65fb4 ("drm/panel: ld9040: Register a backlight device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index e8c9f4613a4b4..b097b2507ac5b 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -300,6 +300,7 @@ config DRM_PANEL_LEADTEK_LTK500HD1829
 config DRM_PANEL_SAMSUNG_LD9040
 	tristate "Samsung LD9040 RGB/SPI panel"
 	depends on OF && SPI
+	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 
 config DRM_PANEL_LG_LB035Q02
-- 
2.39.2

