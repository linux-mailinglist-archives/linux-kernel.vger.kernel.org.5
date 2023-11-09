Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3B7E7350
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345303AbjKIVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345357AbjKIVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:04:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5952349E3;
        Thu,  9 Nov 2023 13:03:54 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84CCF124F;
        Thu,  9 Nov 2023 22:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563810;
        bh=/NhVBkmAZJpXUdV/Jyjhk0OJS8toVJ5blJzkBkbr6Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvgblSuqljkOD0d8324ELh4rRIfsAlfbn5V3NRpTHVKi0qJPcdshB50g24NTFQiPY
         xelivhSZbzi2bS4oFz6nfAFhT1loHvmixQ44aawVULJhQ/3P/xX27u1c7T0fiJMqxB
         fmXZa02gCxm3svoAMFWEOg1QuXCiIjrfZeIWTdO0=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 13/15] staging: vc04_services: bcm2835_isp: Allow multiple users
Date:   Thu,  9 Nov 2023 16:03:05 -0500
Message-ID: <20231109210309.638594-14-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naushir Patuck <naush@raspberrypi.com>

Add a second (identical) set of device nodes to allow concurrent use of
the bcm2835-isp hardware by another user. This change effectively
creates a second state structure (struct bcm2835_isp_dev) to maintain
independent state for the second user. Node and media entity names are
appened with the instance index appropriately.

Further users can be added by changing the BCM2835_ISP_NUM_INSTANCES
define.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../bcm2835-isp/bcm2835-v4l2-isp.c            | 73 +++++++++++++++----
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
index b6ac1ee8f9f3..316d35d5f19d 100644
--- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
+++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
@@ -28,13 +28,19 @@
 
 MODULE_IMPORT_NS(DMA_BUF);
 
+/*
+ * We want to instantiate 2 independent instances allowing 2 simultaneous users
+ * of the ISP hardware.
+ */
+#define BCM2835_ISP_NUM_INSTANCES 2
+
 static unsigned int debug;
 module_param(debug, uint, 0644);
 MODULE_PARM_DESC(debug, "activates debug info");
 
-static unsigned int video_nr = 13;
-module_param(video_nr, uint, 0644);
-MODULE_PARM_DESC(video_nr, "base video device number");
+static unsigned int video_nr[BCM2835_ISP_NUM_INSTANCES] = { 13, 20 };
+module_param_array(video_nr, uint, NULL, 0644);
+MODULE_PARM_DESC(video_nr, "base video device numbers");
 
 #define BCM2835_ISP_NAME "bcm2835-isp"
 #define BCM2835_ISP_ENTITY_NAME_LEN 32
@@ -1287,6 +1293,7 @@ static int bcm2835_isp_get_supported_fmts(struct bcm2835_isp_node *node)
  * or output nodes.
  */
 static int register_node(struct bcm2835_isp_dev *dev,
+			 unsigned int instance,
 			 struct bcm2835_isp_node *node,
 			 int index)
 {
@@ -1448,7 +1455,7 @@ static int register_node(struct bcm2835_isp_dev *dev,
 	snprintf(vfd->name, sizeof(node->vfd.name), "%s-%s%d", BCM2835_ISP_NAME,
 		 node->name, node->id);
 
-	ret = video_register_device(vfd, VFL_TYPE_VIDEO, video_nr + index);
+	ret = video_register_device(vfd, VFL_TYPE_VIDEO, video_nr[instance]);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev,
 			 "Failed to register video %s[%d] device node\n",
@@ -1669,9 +1676,8 @@ static int media_controller_register(struct bcm2835_isp_dev *dev)
 	return ret;
 }
 
-static void bcm2835_isp_remove(struct vchiq_device *device)
+static void bcm2835_isp_remove_instance(struct bcm2835_isp_dev *dev)
 {
-	struct bcm2835_isp_dev *dev = vchiq_get_drvdata(device);
 	unsigned int i;
 
 	media_controller_unregister(dev);
@@ -1688,7 +1694,9 @@ static void bcm2835_isp_remove(struct vchiq_device *device)
 	vchiq_mmal_finalise(dev->mmal_instance);
 }
 
-static int bcm2835_isp_probe(struct vchiq_device *device)
+static int bcm2835_isp_probe_instance(struct vchiq_device *device,
+				      struct bcm2835_isp_dev **dev_int,
+				      unsigned int instance)
 {
 	struct bcm2835_isp_dev *dev;
 	unsigned int i;
@@ -1698,6 +1706,7 @@ static int bcm2835_isp_probe(struct vchiq_device *device)
 	if (!dev)
 		return -ENOMEM;
 
+	*dev_int = dev;
 	dev->dev = &device->dev;
 
 	ret = v4l2_device_register(&device->dev, &dev->v4l2_dev);
@@ -1715,7 +1724,7 @@ static int bcm2835_isp_probe(struct vchiq_device *device)
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev,
 			 "%s: failed to create ril.isp component\n", __func__);
-		goto error;
+		return ret;
 	}
 
 	if (dev->component->inputs < BCM2835_ISP_NUM_OUTPUTS ||
@@ -1727,7 +1736,7 @@ static int bcm2835_isp_probe(struct vchiq_device *device)
 			  BCM2835_ISP_NUM_OUTPUTS,
 			  dev->component->outputs,
 			  BCM2835_ISP_NUM_CAPTURES + BCM2835_ISP_NUM_METADATA);
-		goto error;
+		return -EINVAL;
 	}
 
 	atomic_set(&dev->num_streaming, 0);
@@ -1735,17 +1744,53 @@ static int bcm2835_isp_probe(struct vchiq_device *device)
 	for (i = 0; i < BCM2835_ISP_NUM_NODES; i++) {
 		struct bcm2835_isp_node *node = &dev->node[i];
 
-		ret = register_node(dev, node, i);
+		ret = register_node(dev, instance, node, i);
 		if (ret)
-			goto error;
+			return ret;
 	}
 
 	ret = media_controller_register(dev);
 	if (ret)
-		goto error;
+		return ret;
+
+	return 0;
+}
+
+static void bcm2835_isp_remove(struct vchiq_device *device)
+{
+	struct bcm2835_isp_dev **bcm2835_isp_instances;
+	unsigned int i;
+
+	bcm2835_isp_instances = vchiq_get_drvdata(device);
+	for (i = 0; i < BCM2835_ISP_NUM_INSTANCES; i++) {
+		if (bcm2835_isp_instances[i])
+			bcm2835_isp_remove_instance(bcm2835_isp_instances[i]);
+	}
+}
+
+static int bcm2835_isp_probe(struct vchiq_device *device)
+{
+	struct bcm2835_isp_dev **bcm2835_isp_instances;
+	unsigned int i;
+	int ret;
+
+	bcm2835_isp_instances = devm_kzalloc(&device->dev,
+					     sizeof(bcm2835_isp_instances) *
+						      BCM2835_ISP_NUM_INSTANCES,
+					     GFP_KERNEL);
+	if (!bcm2835_isp_instances)
+		return -ENOMEM;
+
+	vchiq_set_drvdata(device, bcm2835_isp_instances);
+
+	for (i = 0; i < BCM2835_ISP_NUM_INSTANCES; i++) {
+		ret = bcm2835_isp_probe_instance(device,
+						 &bcm2835_isp_instances[i], i);
+		if (ret)
+			goto error;
+	}
 
-	vchiq_set_drvdata(device, dev);
-	v4l2_info(&dev->v4l2_dev, "Loaded V4L2 %s\n", BCM2835_ISP_NAME);
+	dev_info(&device->dev, "Loaded V4L2 %s\n", BCM2835_ISP_NAME);
 	return 0;
 
 error:
-- 
2.41.0

