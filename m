Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D77AC2AE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjIWOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjIWOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:32:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C5192;
        Sat, 23 Sep 2023 07:32:11 -0700 (PDT)
Received: from umang.lan (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B85E811A9;
        Sat, 23 Sep 2023 16:30:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695479428;
        bh=M9/U+rgwmYjuJLbT8lvGfo8PXTj+i0WtoCKKe+50Opo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSNX5JHnKPiUqqd/foqsemkodLQq1WWlJG8HpCZO/G2ScGsj1ai0mJTXp1HFVkbMX
         sfB3la8BTkGPjBfxNurZmz4CsjmPkNY7JmKISjtt7ibRhtduWzumPRgxBTcwL4wV5B
         4ZTZrpxptCLY8yOVRbNI8hS34fJtGFFFWq7Ns9/0=
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
Subject: [PATCH v12 2/6] staging: vc04_services: bcm2835-audio: Explicitly set DMA mask
Date:   Sat, 23 Sep 2023 20:01:56 +0530
Message-Id: <20230923143200.268063-3-umang.jain@ideasonboard.com>
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

In the following patches, vchiq_arm will be migrated to create and use
its own bus and all the vchiq drivers (bcm2835-camera, bcm2835-audio)
will be registered to it. Since the platform driver/device model
internally sets the DMA mask for its registered devices, we would have
to do it ourself when we remove the platform driver/device registration
for vchiq devices.

This patch explicitly sets the DMA mask to bcm2835-audio so as not
to introduce a regression when we move away from platform
device/driver model.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 00bc898b0189..f3ad2543d1c0 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -3,6 +3,7 @@
 
 #include <linux/platform_device.h>
 
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -273,6 +274,12 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int err;
 
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(dev, "dma_set_mask_and_coherent failed: %d\n", err);
+		return err;
+	}
+
 	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
 		num_channels = MAX_SUBSTREAMS;
 		dev_warn(dev, "Illegal num_channels value, will use %u\n",
-- 
2.40.1

