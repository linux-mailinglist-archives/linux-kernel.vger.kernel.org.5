Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9C759B42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGSQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGSQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:45:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE541FD5;
        Wed, 19 Jul 2023 09:45:02 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9D2E316C4;
        Wed, 19 Jul 2023 18:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689785043;
        bh=L1JGgPAX9gIyD2sHlsEat9aOV8sorwircxkrr2ZqerU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwvhRZXKZwl2v2+94JEIp5+oazmu9+U1XoCRu4Ajm4ZrueVVijOgQ0Gaa12Zj+oHj
         6V56EwmJSbB7h6Ktni+IcDKU7G9Kv8fxb2WsvIGFNpLVr/YOYHyn131/3Citrixrkb
         ZIdTNXZO76sDC0wJfTQJRMl76ElBxytDV+uxcd1w=
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
Subject: [PATCH v9 4/5] staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
Date:   Wed, 19 Jul 2023 22:14:26 +0530
Message-Id: <20230719164427.1383646-5-umang.jain@ideasonboard.com>
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

Similar to how bcm2385-camera device is registered, register the
bcm2835-audio with vchiq_bus_type as well.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/bcm2835-audio/bcm2835.c     | 20 +++++++++----------
 .../interface/vchiq_arm/vchiq_arm.c           |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 00bc898b0189..70e5e0942743 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/platform_device.h>
-
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include "../interface/vchiq_arm/vchiq_arm.h"
+#include "../interface/vchiq_arm/vchiq_device.h"
 #include "bcm2835.h"
 
 static bool enable_hdmi;
@@ -268,9 +268,9 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 	return 0;
 }
 
-static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
+static int snd_bcm2835_alsa_probe(struct vchiq_device *device)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &device->dev;
 	int err;
 
 	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
@@ -292,32 +292,32 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 
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
index d941e9640415..f7c2dce5ab09 100644
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
2.39.1

