Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A0B759B43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGSQpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGSQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:45:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7B1FD7;
        Wed, 19 Jul 2023 09:45:00 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3950316B4;
        Wed, 19 Jul 2023 18:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689785039;
        bh=DyQQJYltSHGTg2M7880nPkKYdn1yJe9QbLEK7kQN1+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsTiuEPaK5Vctm7Q59nopltV4BYE00fJTe7hrKWsADbxXnjgcJi7rj0Csf+//XKpS
         0x0zmqAMY4uaJcAqakkNMwjSvLYHL7g6J1EvuDijILug5L+/e28jTuPsCoVN63dKTA
         QHE4SS4lJ1vMsge1opLm4HI7VFSCG6hfGrDit3fY=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v9 3/5] staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
Date:   Wed, 19 Jul 2023 22:14:25 +0530
Message-Id: <20230719164427.1383646-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
References: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the bcm2835-camera with the vchiq_bus_type instead of using
platform driver/device.

Also the VCHIQ firmware doesn't support device enumeration, hence
one has to maintain a list of devices to be registered in the interface.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-camera/bcm2835-camera.c             | 17 +++++++++--------
 .../interface/vchiq_arm/vchiq_arm.c             | 11 ++++++++---
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 346d00df815a..58321856cf1a 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -24,8 +24,9 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 
+#include "../interface/vchiq_arm/vchiq_arm.h"
+#include "../interface/vchiq_arm/vchiq_device.h"
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
@@ -1896,7 +1897,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 						       &camera_instance);
 		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
 		if (ret) {
-			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
+			dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
 				__func__, ret);
 			goto free_dev;
 		}
@@ -1976,7 +1977,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void bcm2835_mmal_remove(struct platform_device *pdev)
+static void bcm2835_mmal_remove(struct vchiq_device *device)
 {
 	int camera;
 	struct vchiq_mmal_instance *instance = gdev[0]->instance;
@@ -1988,17 +1989,17 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
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
index e8d40f891449..d941e9640415 100644
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
2.39.1

