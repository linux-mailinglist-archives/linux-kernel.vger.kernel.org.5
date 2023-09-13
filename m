Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896C79F26D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjIMTyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjIMTyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:54:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA211BDA;
        Wed, 13 Sep 2023 12:54:29 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 018F8BEB;
        Wed, 13 Sep 2023 21:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694634775;
        bh=G84FC09s3O5Jvu4oDBP/nwA2VJODo/pJYynRAYTItC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXeYIKXGL7mA3qyTsoGfJqRz9aGmJk1r1cEzBtJ2MyntknhrF1riUCBo5C94Yatua
         mTpN23aXzIyycOBFZoxXT6CjGSuE8/SdnpdZslcACAcD3mM0ajc7AqIe+ZVFa6fJ5/
         JpwjrKp0Tm+DKmRKdvdMhnf3hsxNe8IjM9M/5wDs=
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
Subject: [PATCH v11 4/5] staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
Date:   Thu, 14 Sep 2023 01:23:53 +0530
Message-Id: <20230913195354.835884-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913195354.835884-1-umang.jain@ideasonboard.com>
References: <20230913195354.835884-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how bcm2385-camera device is registered, register the
bcm2835-audio with vchiq_bus_type as well.

Since we moved away bcm2835-audio from platform driver/device,
we have to set the DMA mask explicitly. Set the DMA mask at probe
time.

Meanwhile at it, change the name and module alias from "bcm2835_audio"
to "bcm2835-audio" to be consistent with bcm2835-camera device. This
does not brings any functional change as '-' and '_' are
interchangeable as per modprobe man pages.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/bcm2835-audio/bcm2835.c     | 29 ++++++++++++-------
 .../interface/vchiq_arm/vchiq_arm.c           |  6 ++--
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 00bc898b0189..7d945703d97f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/platform_device.h>
-
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include "../interface/vchiq_arm/vchiq_arm.h"
+#include "../interface/vchiq_arm/vchiq_device.h"
 #include "bcm2835.h"
 
 static bool enable_hdmi;
@@ -268,11 +269,19 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 	return 0;
 }
 
-static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
+static int snd_bcm2835_alsa_probe(struct vchiq_device *device)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &device->dev;
 	int err;
 
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+	err = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(dev, "can't set coherent DMA mask: %d\n", err);
+		return err;
+	}
+
 	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
 		num_channels = MAX_SUBSTREAMS;
 		dev_warn(dev, "Illegal num_channels value, will use %u\n",
@@ -292,32 +301,32 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PM
 
-static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
+static int snd_bcm2835_alsa_suspend(struct vchiq_device *device,
 				    pm_message_t state)
 {
 	return 0;
 }
 
-static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
+static int snd_bcm2835_alsa_resume(struct vchiq_device *device)
 {
 	return 0;
 }
 
 #endif
 
-static struct platform_driver bcm2835_alsa_driver = {
+static struct vchiq_driver bcm2835_alsa_driver = {
 	.probe = snd_bcm2835_alsa_probe,
 #ifdef CONFIG_PM
 	.suspend = snd_bcm2835_alsa_suspend,
 	.resume = snd_bcm2835_alsa_resume,
 #endif
 	.driver = {
-		.name = "bcm2835_audio",
+		.name = "bcm2835-audio",
 	},
 };
-module_platform_driver(bcm2835_alsa_driver);
+module_vchiq_driver(bcm2835_alsa_driver);
 
 MODULE_AUTHOR("Dom Cobley");
 MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bcm2835_audio");
+MODULE_ALIAS("bcm2835-audio");
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 14bdde610f3a..2da470740cda 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -67,12 +67,12 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
-static struct platform_device *bcm2835_audio;
 /*
  * The devices implemented in the VCHIQ firmware are not discoverable,
  * so we need to maintain a list of them in order to register them with
  * the interface.
  */
+static struct vchiq_device *bcm2835_audio;
 static struct vchiq_device *bcm2835_camera;
 
 struct vchiq_drvdata {
@@ -1845,7 +1845,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
 	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
 
 	return 0;
@@ -1858,7 +1858,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static void vchiq_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bcm2835_audio);
+	vchiq_device_unregister(bcm2835_audio);
 	vchiq_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
-- 
2.40.1

