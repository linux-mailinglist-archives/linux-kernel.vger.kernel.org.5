Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390E879F26A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjIMTyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjIMTyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:54:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B89E;
        Wed, 13 Sep 2023 12:54:18 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2F8C16B7;
        Wed, 13 Sep 2023 21:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694634764;
        bh=LPrKroR5yvaMCi5yUrTeV3TcH+SVi4IliBcGKe/xNZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVHIo3BT8JJYCSZiTQFHSrCxkmaeFW1ccL9l97hthLz8Vbo+ogKSUdqEockcOz+HG
         V/DnCy+EbW4VeIb/aE8TZ0U9b3F8dM1ktVWiXmxtxxv50UfEB56NmpNxZgU1hHtYHz
         ZPH2jWYrvIiTyY20pIvDANgNYl2TuGfPvPRMMiao=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v11 2/5] staging: vc04_services: vchiq_arm: Register vchiq_bus_type
Date:   Thu, 14 Sep 2023 01:23:51 +0530
Message-Id: <20230913195354.835884-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913195354.835884-1-umang.jain@ideasonboard.com>
References: <20230913195354.835884-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the vchiq_bus_type bus with the vchiq interface.
The bcm2835-camera and bcm2835_audio will be registered to this bus type
going ahead.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 ++++++++++++-
 .../interface/vchiq_arm/vchiq_device.c              |  7 -------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index aa2313f3bcab..d993a91de237 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -12,6 +12,7 @@
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/device/bus.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
@@ -34,6 +35,7 @@
 #include "vchiq_ioctl.h"
 #include "vchiq_arm.h"
 #include "vchiq_debugfs.h"
+#include "vchiq_device.h"
 #include "vchiq_connected.h"
 #include "vchiq_pagelist.h"
 
@@ -1870,9 +1872,17 @@ static int __init vchiq_driver_init(void)
 {
 	int ret;
 
+	ret = bus_register(&vchiq_bus_type);
+	if (ret) {
+		pr_err("Failed to register %s\n", vchiq_bus_type.name);
+		return ret;
+	}
+
 	ret = platform_driver_register(&vchiq_driver);
-	if (ret)
+	if (ret) {
 		pr_err("Failed to register vchiq driver\n");
+		bus_unregister(&vchiq_bus_type);
+	}
 
 	return ret;
 }
@@ -1880,6 +1890,7 @@ module_init(vchiq_driver_init);
 
 static void __exit vchiq_driver_exit(void)
 {
+	bus_unregister(&vchiq_bus_type);
 	platform_driver_unregister(&vchiq_driver);
 }
 module_exit(vchiq_driver_exit);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
index aad55c461905..b8c46f39e74a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
@@ -74,13 +74,6 @@ vchiq_device_register(struct device *parent, const char *name)
 	device->dev.bus = &vchiq_bus_type;
 	device->dev.release = vchiq_device_release;
 
-	of_dma_configure(&device->dev, parent->of_node, true);
-	ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		dev_err(&device->dev, "32-bit DMA enable failed\n");
-		return NULL;
-	}
-
 	ret = device_register(&device->dev);
 	if (ret) {
 		dev_err(parent, "Cannot register %s: %d\n", name, ret);
-- 
2.40.1

