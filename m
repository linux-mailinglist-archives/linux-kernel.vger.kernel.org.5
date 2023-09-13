Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9192879F26B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjIMTy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjIMTy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:54:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A361BCC;
        Wed, 13 Sep 2023 12:54:23 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D533755;
        Wed, 13 Sep 2023 21:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694634770;
        bh=bjRAkpStJWZ3WMMqqCEhTrsjzJ8pv1Ax01MVq8FcDao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4FO8FZuAzx35phrM+lZXl/o/BgYBG5DKnxPxN5ZJWg0J3h6MAG0j5Xu+KXL1k6gU
         RN93Aq8h3CxtR9QIVH6y5NBr9Tv9vtMByHZksy4U4EPSAsBI6TLP5uCM/fqMalhhRE
         dzQwurmK2K0P24qL/rBM0I4kfWtJubGjnfbKAWWk=
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
Subject: [PATCH v11 3/5] staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
Date:   Thu, 14 Sep 2023 01:23:52 +0530
Message-Id: <20230913195354.835884-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913195354.835884-1-umang.jain@ideasonboard.com>
References: <20230913195354.835884-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../bcm2835-camera/bcm2835-camera.c           | 26 +++++++++++++------
 .../interface/vchiq_arm/vchiq_arm.c           | 11 +++++---
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 346d00df815a..52431b834232 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -11,6 +11,7 @@
  *          Luke Diamand @ Broadcom
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -24,8 +25,9 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 
+#include "../interface/vchiq_arm/vchiq_arm.h"
+#include "../interface/vchiq_arm/vchiq_device.h"
 #include "../vchiq-mmal/mmal-common.h"
 #include "../vchiq-mmal/mmal-encodings.h"
 #include "../vchiq-mmal/mmal-vchiq.h"
@@ -1841,7 +1843,7 @@ static struct v4l2_format default_v4l2_format = {
 	.fmt.pix.sizeimage = 1024 * 768,
 };
 
-static int bcm2835_mmal_probe(struct platform_device *pdev)
+static int bcm2835_mmal_probe(struct vchiq_device *device)
 {
 	int ret;
 	struct bcm2835_mmal_dev *dev;
@@ -1852,6 +1854,14 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	unsigned int resolutions[MAX_BCM2835_CAMERAS][2];
 	int i;
 
+	if (!device->dev.dma_mask)
+		device->dev.dma_mask = &device->dev.coherent_dma_mask;
+	ret = dma_set_coherent_mask(&device->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&device->dev, "can't set coherent DMA mask: %d\n", ret);
+		return ret;
+	}
+
 	ret = vchiq_mmal_init(&instance);
 	if (ret < 0)
 		return ret;
@@ -1896,7 +1906,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 						       &camera_instance);
 		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
 		if (ret) {
-			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
+			dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
 				__func__, ret);
 			goto free_dev;
 		}
@@ -1976,7 +1986,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void bcm2835_mmal_remove(struct platform_device *pdev)
+static void bcm2835_mmal_remove(struct vchiq_device *device)
 {
 	int camera;
 	struct vchiq_mmal_instance *instance = gdev[0]->instance;
@@ -1988,17 +1998,17 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
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
index d993a91de237..14bdde610f3a 100644
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

