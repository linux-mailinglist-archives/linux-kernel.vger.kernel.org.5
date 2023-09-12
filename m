Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DEF79D098
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjILMCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjILMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:02:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA8E19B1;
        Tue, 12 Sep 2023 05:02:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC2FC433C7;
        Tue, 12 Sep 2023 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694520126;
        bh=rcwDmaPFBJEQrSd2Ys0Lwa0Qjgtcef3du4K1fAV+R2E=;
        h=From:To:Cc:Subject:Date:From;
        b=K7RGvLx8tUw5F0N6NjsPSSVWspYDdRXf0mowtKDeVECaUhHqB6/nHxfzhLoitLQd0
         8/OPIfDI+cE/LDoZ0G9T4tEWfu50KvqiqlASKG0dKZ9PinBK0OqBkWkueLLIl4GlhG
         W1JWRi8eo7DjIWMsdIs8Ht6R6WWaOVn/Mz/7AbTOhqbnAh/kRpWRivF328jYTwTV2D
         gKcH7jXOT/Wb3n/CbTMpfKOzWQEDkVaulXmhJarQLW+0bYlnNLTI6q6aF6DSFfLPwa
         5kskiiHURKv9f28R2eRFwOOITdhXFh6bEBMM60ShyjhNI9U3NkdMaBgD5UhPWkuaVX
         qtTO4z7YF4vWw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: fix VIDEO_CAMERA_SENSOR dependencies
Date:   Tue, 12 Sep 2023 14:01:42 +0200
Message-Id: <20230912120159.4118842-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new Kconfig submenu now guards the visibility of camera sensor drivers,
and any driver that selects one of them runs into a missing dependency warning
if it's disabled:

WARNING: unmet direct dependencies detected for VIDEO_OV2640
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [y]:
  - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]
  - VIDEO_GO7007 [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && MEDIA_ANALOG_TV_SUPPORT [=y] && VIDEO_DEV [=y] && I2C [=y] && SND [=y] && USB [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]

WARNING: unmet direct dependencies detected for VIDEO_MT9V011
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [y]:
  - VIDEO_EM28XX_V4L2 [=y] && USB [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && (MEDIA_CAMERA_SUPPORT [=y] || MEDIA_ANALOG_TV_SUPPORT [=y] || MEDIA_DIGITAL_TV_SUPPORT [=y]) && VIDEO_EM28XX [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]

WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [y]:
  - VIDEO_CAFE_CCIC [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && PCI [=y] && I2C [=y] && VIDEO_DEV [=y] && COMMON_CLK [=y]
  - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP [=y] || COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - VIDEO_VIA_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && FB_VIA [=y] && VIDEO_DEV [=y]

Some of these are guarded by 'if MEDIA_SUBDRV_AUTOSELECT &&
MEDIA_CAMERA_SUPPORT', which seems to be the right approach, so update
those to use the new VIDEO_CAMERA_SENSOR symbol instead of
MEDIA_CAMERA_SUPPORT and add the same condition to the ones that
don't already have one.

Fixes: 7d3c7d2a2914e ("media: i2c: Add a camera sensor top level menu")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/marvell/Kconfig | 4 ++--
 drivers/media/platform/via/Kconfig     | 2 +-
 drivers/media/usb/em28xx/Kconfig       | 4 ++--
 drivers/media/usb/go7007/Kconfig       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/marvell/Kconfig b/drivers/media/platform/marvell/Kconfig
index ec1a16734a280..d6499ffe30e8b 100644
--- a/drivers/media/platform/marvell/Kconfig
+++ b/drivers/media/platform/marvell/Kconfig
@@ -7,7 +7,7 @@ config VIDEO_CAFE_CCIC
 	depends on V4L_PLATFORM_DRIVERS
 	depends on PCI && I2C && VIDEO_DEV
 	depends on COMMON_CLK
-	select VIDEO_OV7670
+	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_DMA_SG
@@ -22,7 +22,7 @@ config VIDEO_MMP_CAMERA
 	depends on I2C && VIDEO_DEV
 	depends on ARCH_MMP || COMPILE_TEST
 	depends on COMMON_CLK
-	select VIDEO_OV7670
+	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	select I2C_GPIO
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/platform/via/Kconfig b/drivers/media/platform/via/Kconfig
index 8926eb0803b27..ea8dfc0a90756 100644
--- a/drivers/media/platform/via/Kconfig
+++ b/drivers/media/platform/via/Kconfig
@@ -7,7 +7,7 @@ config VIDEO_VIA_CAMERA
 	depends on V4L_PLATFORM_DRIVERS
 	depends on FB_VIA && VIDEO_DEV
 	select VIDEOBUF2_DMA_SG
-	select VIDEO_OV7670
+	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	help
 	   Driver support for the integrated camera controller in VIA
 	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
diff --git a/drivers/media/usb/em28xx/Kconfig b/drivers/media/usb/em28xx/Kconfig
index b3c472b8c5a96..cb61fd6cc6c61 100644
--- a/drivers/media/usb/em28xx/Kconfig
+++ b/drivers/media/usb/em28xx/Kconfig
@@ -12,8 +12,8 @@ config VIDEO_EM28XX_V4L2
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TVP5150 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_MSP3400 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
-	select VIDEO_OV2640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
+	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
+	select VIDEO_OV2640 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	help
 	  This is a video4linux driver for Empia 28xx based TV cards.
 
diff --git a/drivers/media/usb/go7007/Kconfig b/drivers/media/usb/go7007/Kconfig
index 4ff79940ad8d4..478106b751267 100644
--- a/drivers/media/usb/go7007/Kconfig
+++ b/drivers/media/usb/go7007/Kconfig
@@ -12,7 +12,7 @@ config VIDEO_GO7007
 	select VIDEO_TW2804 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9903 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9906 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
+	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	select VIDEO_UDA1342 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  This is a video4linux driver for the WIS GO7007 MPEG
-- 
2.39.2

