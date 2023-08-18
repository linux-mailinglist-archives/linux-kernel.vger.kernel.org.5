Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879697808FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359387AbjHRJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359381AbjHRJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:52:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CD42684;
        Fri, 18 Aug 2023 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692352355; x=1723888355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=89r1Tcgm0dVg+buxrEGiUacFVVNLeDXV6VH8l4oH+Mc=;
  b=MM/t912p4CNSLh9BBa8iO2Utws44aPMyFNthUjDemgu8XLEnygxLtfg9
   yeDA8D5LYW3MRdGUKO0ztFjgalwMYTiqS9UewQ5HfeRprejfsI4kgg7s7
   1MsFCRUncvBG7vELsbn+RZC2ZqfOikK1ZceQTTHK+Dsq3Hq5t9PskScf+
   /SMMf3wMQpXudBNEZ2HS8VBgZVzSOQtnjxG5zUD3f2J9CV6WO22mElwTc
   OBugtHs9QTa0RkvEwoc9F8DDG8KbqGDQbtgdh0ctII9wsYhWgBvkCgz0E
   aEjNFlJ3I40jxNGY2LPH3ju06XCZdY5EEvbQxQkNihmz06Z4Sh9uCy27Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375840941"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="375840941"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="825063046"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="825063046"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:52:32 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id A7B4812035D;
        Fri, 18 Aug 2023 12:52:29 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1qWw99-00GD1F-1N;
        Fri, 18 Aug 2023 12:51:59 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     hverkuil@xs4all.nl, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 1/1] media: v4l: usb: Use correct dependency for camera sensor drivers
Date:   Fri, 18 Aug 2023 12:51:49 +0300
Message-Id: <20230818095149.3863285-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig option that enables compiling camera sensor drivers is
VIDEO_CAMERA_SENSOR rather than MEDIA_CAMERA_SUPPORT as it was previously.
Fix this.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
since v1:

- Also include MMP camera Kconfig fix.

 drivers/media/platform/marvell/Kconfig | 4 ++--
 drivers/media/usb/em28xx/Kconfig       | 4 ++--
 drivers/media/usb/go7007/Kconfig       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/marvell/Kconfig b/drivers/media/platform/marvell/Kconfig
index ec1a16734a28..d6499ffe30e8 100644
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
diff --git a/drivers/media/usb/em28xx/Kconfig b/drivers/media/usb/em28xx/Kconfig
index b3c472b8c5a9..cb61fd6cc6c6 100644
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
index 4ff79940ad8d..b2a15d9fb1f3 100644
--- a/drivers/media/usb/go7007/Kconfig
+++ b/drivers/media/usb/go7007/Kconfig
@@ -12,8 +12,8 @@ config VIDEO_GO7007
 	select VIDEO_TW2804 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9903 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9906 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 	select VIDEO_UDA1342 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	help
 	  This is a video4linux driver for the WIS GO7007 MPEG
 	  encoder chip.
-- 
2.39.2

