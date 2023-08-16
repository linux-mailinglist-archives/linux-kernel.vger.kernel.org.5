Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1477E2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbjHPNgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbjHPNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:36:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026F2136;
        Wed, 16 Aug 2023 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692192970; x=1723728970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4GR5uM0r2IXARSeo3eQq0DsLiDyIiKq3U4ASSd4oGac=;
  b=NPfnmkGQzUjrrUh4lqyYm4Hgj657+AZO+IqYWSuTW+fceC4UOI7qhiRG
   pa0c/HYIc/pELCpRvm6zXurS12C+lr8h7DnD3MWxMbXGyJ+UnXFfP4Hvw
   mMa9dC0N8tUjTkj/9SoW2onN6jQ/lhPkyVVp6YJNJ/qAXX8XHU9d6Y6UO
   DMbDoR6hUyY0pBNpzvIYv51PoDvyEzhoMReCXF/3KG2Enhh8KD1g+slAA
   XioXtfLO2IKIhYCCnF8hPOxj4uc58s3mKWVwttA8aCLD/o7iLz7C3ud6o
   6v1jQzqszV32ECWYS3wCBCitStQciD8xR1+0Mwn0PTHRfeAjLW3vvxsWf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372537576"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372537576"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 06:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980748913"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980748913"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 06:36:06 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id CB2401209BD;
        Wed, 16 Aug 2023 16:36:03 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1qWGgS-00GC1b-2t;
        Wed, 16 Aug 2023 16:35:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 1/2] media: v4l: usb: Use correct dependency for camera sensor drivers
Date:   Wed, 16 Aug 2023 16:35:25 +0300
Message-Id: <20230816133526.3859456-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
References: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/media/usb/em28xx/Kconfig | 4 ++--
 drivers/media/usb/go7007/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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

