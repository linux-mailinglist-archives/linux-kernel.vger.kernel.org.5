Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FE7AC2B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjIWOck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjIWOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:32:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4611B0;
        Sat, 23 Sep 2023 07:32:17 -0700 (PDT)
Received: from umang.lan (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 843398622;
        Sat, 23 Sep 2023 16:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695479432;
        bh=A2Tam7zedvr2m/CrifrP+X/qYDjpbz6xBpyNyE/5KFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQcyfLfOsUCE12770SL8OShaCH3PUbDb1frOfOz74sHgYwOmOlvyoQ3o9w41YR0Ok
         NhuRy/9PKQCkwFNsu+eSkVRaE7NH0cCHfXlmhN8t/L/D6CqcTqapTo7Ho2OCxOWKWD
         nsyjRqZhM/AIrmgTOwXDLOQ2VdwOStCo0ZyD8q1g=
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
Subject: [PATCH v12 6/6] staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
Date:   Sat, 23 Sep 2023 20:02:00 +0530
Message-Id: <20230923143200.268063-7-umang.jain@ideasonboard.com>
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

Similar to how bcm2385-camera device is registered, register the
bcm2835-audio with vchiq_bus_type as well.

Since we moved away bcm2835-audio from platform driver/device,
we have to set the DMA mask explicitly. Set the DMA mask at probe
time.

Meanwhile at it, change the name and module alias from "bcm2835_audio"
to "bcm2835-audio" to be consistent with bcm2835-camera device. This
does not brings any functional change as '-' and '_' are
interchangeable as per modprobe man pages.

Also, drop vchiq_register_child() helper which is no longer
needed after this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/bcm2835-audio/bcm2835.c     | 19 ++++++-------
 .../interface/vchiq_arm/vchiq_arm.c           | 28 ++-----------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index f3ad2543d1c0..06bdc7673d4b 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -1,13 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/platform_device.h>
-
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include "../interface/vchiq_arm/vchiq_bus.h"
 #include "bcm2835.h"
 
 static bool enable_hdmi;
@@ -269,9 +268,9 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 	return 0;
 }
 
-static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
+static int snd_bcm2835_alsa_probe(struct vchiq_device *device)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &device->dev;
 	int err;
 
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -299,32 +298,32 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 
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
index 886025f0a452..eef9c8c06e66 100644
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
@@ -1776,28 +1776,6 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
-static struct platform_device *
-vchiq_register_child(struct platform_device *pdev, const char *name)
-{
-	struct platform_device_info pdevinfo;
-	struct platform_device *child;
-
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-	pdevinfo.parent = &pdev->dev;
-	pdevinfo.name = name;
-	pdevinfo.id = PLATFORM_DEVID_NONE;
-	pdevinfo.dma_mask = DMA_BIT_MASK(32);
-
-	child = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(child)) {
-		dev_warn(&pdev->dev, "%s not registered\n", name);
-		child = NULL;
-	}
-
-	return child;
-}
-
 static int vchiq_probe(struct platform_device *pdev)
 {
 	struct device_node *fw_node;
@@ -1845,7 +1823,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
 	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
 
 	return 0;
@@ -1858,7 +1836,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static void vchiq_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bcm2835_audio);
+	vchiq_device_unregister(bcm2835_audio);
 	vchiq_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
-- 
2.40.1

