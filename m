Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B267AC2B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjIWOcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjIWOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:32:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37701B2;
        Sat, 23 Sep 2023 07:32:16 -0700 (PDT)
Received: from umang.lan (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 954D831B9;
        Sat, 23 Sep 2023 16:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695479431;
        bh=x/pyWDX8yelf+FyDWkZ3SLTfqNu4DBRHODYZ2wiONPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wm/13YRCwq0x2XGphzqOuK0BHCu+qtPu8UrVmMioUc2WFeoC9n93kzjEEXUdK5TJl
         ByN0X2BAQiikdgCkrHP+Lt629OCf2c+Bmp2cqyDu1MKTM4g6jdS9SLkBI34/a0bfxd
         W9dxXYbFns4AZqPFNAlUsP0UeD2Wkeu4W+L+LfRY=
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
Subject: [PATCH v12 5/6] staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
Date:   Sat, 23 Sep 2023 20:01:59 +0530
Message-Id: <20230923143200.268063-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230923143200.268063-1-umang.jain@ideasonboard.com>
References: <20230923143200.268063-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the bcm2835-camera with the vchiq_bus_type instead of using
platform driver/device.

Since we moved away bcm2835-camera from platform driver/device,
we have to set the DMA mask explicitly. Set the DMA mask at probe
time.

Also the VCHIQ firmware doesn't support device enumeration, hence
one has to maintain a list of devices to be registered in the interface.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-camera/bcm2835-camera.c           | 21 ++++++++++---------
 .../interface/vchiq_arm/vchiq_arm.c           | 11 +++++++---
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index fcad5118f3e8..c873eace1437 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -11,6 +11,7 @@
  *          Luke Diamand @ Broadcom
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -24,8 +25,8 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 
+#include "../interface/vchiq_arm/vchiq_bus.h"
 #include "../vchiq-mmal/mmal-common.h"
 #include "../vchiq-mmal/mmal-encodings.h"
 #include "../vchiq-mmal/mmal-vchiq.h"
@@ -1841,7 +1842,7 @@ static struct v4l2_format default_v4l2_format = {
 	.fmt.pix.sizeimage = 1024 * 768,
 };
 
-static int bcm2835_mmal_probe(struct platform_device *pdev)
+static int bcm2835_mmal_probe(struct vchiq_device *device)
 {
 	int ret;
 	struct bcm2835_mmal_dev *dev;
@@ -1852,9 +1853,9 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	unsigned int resolutions[MAX_BCM2835_CAMERAS][2];
 	int i;
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
 	if (ret) {
-		dev_err(&pdev->dev, "dma_set_mask_and_coherent failed: %d\n", ret);
+		dev_err(&device->dev, "dma_set_mask_and_coherent failed: %d\n", ret);
 		return ret;
 	}
 
@@ -1902,7 +1903,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 						       &camera_instance);
 		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
 		if (ret) {
-			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
+			dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
 				__func__, ret);
 			goto free_dev;
 		}
@@ -1982,7 +1983,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void bcm2835_mmal_remove(struct platform_device *pdev)
+static void bcm2835_mmal_remove(struct vchiq_device *device)
 {
 	int camera;
 	struct vchiq_mmal_instance *instance = gdev[0]->instance;
@@ -1994,17 +1995,17 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
 	vchiq_mmal_finalise(instance);
 }
 
-static struct platform_driver bcm2835_camera_driver = {
+static struct vchiq_driver bcm2835_camera_driver = {
 	.probe		= bcm2835_mmal_probe,
-	.remove_new	= bcm2835_mmal_remove,
+	.remove		= bcm2835_mmal_remove,
 	.driver		= {
 		.name	= "bcm2835-camera",
 	},
 };
 
-module_platform_driver(bcm2835_camera_driver)
+module_vchiq_driver(bcm2835_camera_driver)
 
 MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bcm2835-camera");
+MODULE_ALIAS("bcm2835-camera");
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 9388859b9b56..886025f0a452 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -67,8 +67,13 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
-static struct platform_device *bcm2835_camera;
 static struct platform_device *bcm2835_audio;
+/*
+ * The devices implemented in the VCHIQ firmware are not discoverable,
+ * so we need to maintain a list of them in order to register them with
+ * the interface.
+ */
+static struct vchiq_device *bcm2835_camera;
 
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
@@ -1840,8 +1845,8 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
 	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
 
 	return 0;
 
@@ -1854,7 +1859,7 @@ static int vchiq_probe(struct platform_device *pdev)
 static void vchiq_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(bcm2835_audio);
-	platform_device_unregister(bcm2835_camera);
+	vchiq_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 }
-- 
2.40.1

