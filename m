Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7C759B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGSQpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGSQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:45:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A721FD2;
        Wed, 19 Jul 2023 09:44:57 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A7DA10FF;
        Wed, 19 Jul 2023 18:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689785034;
        bh=LeLvy8dmB49ivCc3FmszLDCbTglhyeqRh8+wWDv2694=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGuoBiIE4MMFCAuPr8E/hhUnomzAVazDINXKnNBOSlK8nef5ve0WYt9+RswVEklx+
         jItQQLj17iHf1Dn2nSPCcjRsW8wwlgCZ6WdFC9yfBH1bCrvvERrp5Tb98ouarj9Sbb
         yAqXcbW8x1cc/Fq/mmg0WwvkVlVvguqUhBDvCRYA=
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
Subject: [PATCH v9 2/5] staging: vc04_services: vchiq_arm: Register vchiq_bus_type
Date:   Wed, 19 Jul 2023 22:14:24 +0530
Message-Id: <20230719164427.1383646-3-umang.jain@ideasonboard.com>
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

Register the vchiq_bus_type bus with the vchiq interface.
The bcm2835-camera and bcm2835_audio will be registered to this bus type
going ahead.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index aa2313f3bcab..e8d40f891449 100644
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
@@ -34,6 +35,7 @@
 #include "vchiq_ioctl.h"
 #include "vchiq_arm.h"
 #include "vchiq_debugfs.h"
+#include "vchiq_device.h"
 #include "vchiq_connected.h"
 #include "vchiq_pagelist.h"
 
@@ -1870,6 +1872,12 @@ static int __init vchiq_driver_init(void)
 {
 	int ret;
 
+	ret = bus_register(&vchiq_bus_type);
+	if (ret) {
+		pr_err("Failed to register %s\n", vchiq_bus_type.name);
+		return ret;
+	}
+
 	ret = platform_driver_register(&vchiq_driver);
 	if (ret)
 		pr_err("Failed to register vchiq driver\n");
@@ -1880,6 +1888,7 @@ module_init(vchiq_driver_init);
 
 static void __exit vchiq_driver_exit(void)
 {
+	bus_unregister(&vchiq_bus_type);
 	platform_driver_unregister(&vchiq_driver);
 }
 module_exit(vchiq_driver_exit);
-- 
2.39.1

