Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E67AC2AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjIWOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjIWOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:32:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F011D;
        Sat, 23 Sep 2023 07:32:07 -0700 (PDT)
Received: from umang.lan (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C638910FE;
        Sat, 23 Sep 2023 16:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695479427;
        bh=97rsLMbhlIPh3+VcgvhrEUZUnrr2n4j9XSww0+luu9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YU6fSHWGOVySECtHQmD007BAdRgpUBygTtN540U9BRwoDq61OCbJhqooIhR2hxgt3
         4Fy/6QnJ0f1hdr3qrJz6pLuZNrJu+QXgnrCmt/0Bom5usPWWG3aXNOZ3i3l6Bdwb5w
         ZQ7D38drhJ9Cyg6gplbQ0JG1RSsEEe0qVd8EawsI=
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
Subject: [PATCH v12 1/6] staging: vc04_services: bcm2835-camera: Explicitly set DMA mask
Date:   Sat, 23 Sep 2023 20:01:55 +0530
Message-Id: <20230923143200.268063-2-umang.jain@ideasonboard.com>
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

This patch explicitly sets the DMA mask to bcm2835-camera so as not
to introduce a regression when we move away from platform
device/driver model.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 346d00df815a..fcad5118f3e8 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1852,6 +1852,12 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	unsigned int resolutions[MAX_BCM2835_CAMERAS][2];
 	int i;
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_mask_and_coherent failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = vchiq_mmal_init(&instance);
 	if (ret < 0)
 		return ret;
-- 
2.40.1

