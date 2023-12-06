Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C5806FF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378336AbjLFMia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378321AbjLFMi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:38:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52E11F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:38:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFDAC433C8;
        Wed,  6 Dec 2023 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701866314;
        bh=Fj8YObxpZ6Ytr5jvxIskxu3K4FrlW7trloaLma4Dwnk=;
        h=From:To:Cc:Subject:Date:From;
        b=mionK04XCoEyEbBjHqMndI2zOeorIQi2PMaZFCfIo1mYYyTlEIjRFDvbm3WWSK6Xz
         4eERufRZbWwPsaT6F4LrEyr2EDrhWuWZF5+5kY6h5giUmxKs9+SkCP1/IyCcWcYR2o
         7j/NMF2pooxe3dXERIgj+q2lIdPdvinvaiCnKTbiUyxTjWgTzuLkW6f6cywtP6TmE5
         z5AUmRMUchiUjN/DJtgrhCwBFirUd5/NfEjwSlhle6TNHBXP4Oe0Wr36LTxabi1g9+
         3Hq777JBeb/p7i6kLflFKGmq3fgUIwKhWhOgOU3ZykK10t9oUwh4jGbLJn4b8BnK1r
         EGArkXXZ0E0Uw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: nb7vpq904m: add CONFIG_OF dependency
Date:   Wed,  6 Dec 2023 13:38:14 +0100
Message-Id: <20231206123828.587065-1-arnd@kernel.org>
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

DRM_AUX_BRIDGE depends on CONFIG_OF, so the same dependency is needed
here to avoid a build failure:

WARNING: unmet direct dependencies detected for DRM_AUX_BRIDGE
  Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
  Selected by [y]:
  - TYPEC_MUX_NB7VPQ904M [=y] && USB_SUPPORT [=y] && TYPEC [=y] && I2C [=y] && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]
x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_register':
aux-bridge.c:(.text+0x13b): undefined reference to `auxiliary_device_init'
x86_64-linux-ld: aux-bridge.c:(.text+0x14d): undefined reference to `__auxiliary_device_add'
x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_init':
aux-bridge.c:(.init.text+0x15): undefined reference to `__auxiliary_driver_register'
x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_exit':
aux-bridge.c:(.exit.text+0x9): undefined reference to `auxiliary_driver_unregister'

Fixes: c5d296bad640 ("usb: typec: nb7vpq904m: switch to DRM_AUX_BRIDGE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/typec/mux/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 5120942f309d..818624f59120 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -40,6 +40,7 @@ config TYPEC_MUX_NB7VPQ904M
 	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
 	depends on I2C
 	depends on DRM || DRM=n
+	depends on OF
 	select DRM_AUX_BRIDGE if DRM_BRIDGE
 	select REGMAP_I2C
 	help
-- 
2.39.2

