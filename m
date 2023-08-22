Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A69783B76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjHVILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjHVILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:11:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE661B5;
        Tue, 22 Aug 2023 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692691887; x=1724227887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I0Xi8EWiHfosLiR78ce7y0rFELPscG4bhDj4AH5OGbo=;
  b=GbS0lrf4YalU97SE0fmN/9Vtf0FRgiLPKhgBYy3mgomR5YSBZU2HXjd9
   q5aEIGWJldje/ez8TRFgtSM/mOdOVZ6x6SihYzFvValVYlN75wiW9gR4B
   Fn5H10UV3XXb3WMC2cL44KGK3XkVxtfx9FXfACgmX1yZGA6uDtZmgeij7
   o4z2oUEaGtlhqgoklTKbWHHCYD0RL/j5fhN2T4wQTSOybsfpvMhZm1fGn
   L0oHXL9BgAE4hmGYqgMd67UYNiCrr0Sy5ouwe7ZXWimE1hfsQjOGSiIM/
   xpt05GPfNDE6tCPd8/be8wzyrbliAPVgF0IqCh2Z6ZvlCaaAELPeXYn85
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404815320"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="404815320"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 01:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739221918"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="739221918"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 01:11:24 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 0992311FAB1;
        Tue, 22 Aug 2023 11:11:22 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1qYMTM-00GEj1-2X;
        Tue, 22 Aug 2023 11:10:44 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     hverkuil@xs4all.nl, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 1/1] media: via: Use correct dependency for camera sensor drivers
Date:   Tue, 22 Aug 2023 11:10:34 +0300
Message-Id: <20230822081034.3869843-1-sakari.ailus@linux.intel.com>
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

The via camera controller driver selected ov7670 driver, however now that
driver has dependencies and may no longer be selected unconditionally.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/platform/via/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/via/Kconfig b/drivers/media/platform/via/Kconfig
index 8926eb0803b2..6e603c038248 100644
--- a/drivers/media/platform/via/Kconfig
+++ b/drivers/media/platform/via/Kconfig
@@ -7,7 +7,7 @@ config VIDEO_VIA_CAMERA
 	depends on V4L_PLATFORM_DRIVERS
 	depends on FB_VIA && VIDEO_DEV
 	select VIDEOBUF2_DMA_SG
-	select VIDEO_OV7670
+	select VIDEO_OV7670 if VIDEO_CAMERA_SENSOR
 	help
 	   Driver support for the integrated camera controller in VIA
 	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
-- 
2.39.2

