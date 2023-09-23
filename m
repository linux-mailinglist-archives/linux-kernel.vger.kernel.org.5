Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB167AC2B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjIWOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjIWOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:32:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDD113;
        Sat, 23 Sep 2023 07:32:12 -0700 (PDT)
Received: from umang.lan (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A1D831536;
        Sat, 23 Sep 2023 16:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695479430;
        bh=OiS/6vUN9OZ5WEDhF9ICm3EsH9faDTmVyUTUv11Lyjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0Uuzwneh5WRhM44uyo608ZSSywQ7WhkGMFNG8AIQHznLDIuZXZX2EE/aMykvcqxv
         MLE0+DaqVQBKGi2FMYaSmUuSwbAK1CgMGIgGeCbBZBzptmBpXoCGumVYDQAy8GTWo/
         B5NAriMoauRDbuJdeIfB47H7mfaMnK1s/NCKeTjM=
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
Subject: [PATCH v12 4/6] staging: vc04_services: vchiq_arm: Register vchiq_bus_type
Date:   Sat, 23 Sep 2023 20:01:58 +0530
Message-Id: <20230923143200.268063-5-umang.jain@ideasonboard.com>
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

Register the vchiq_bus_type bus with the vchiq interface.
The bcm2835-camera and bcm2835_audio will be registered to this bus type
going ahead.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index aa2313f3bcab..9388859b9b56 100644
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
@@ -33,6 +34,7 @@
 #include "vchiq_core.h"
 #include "vchiq_ioctl.h"
 #include "vchiq_arm.h"
+#include "vchiq_bus.h"
 #include "vchiq_debugfs.h"
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
-- 
2.40.1

