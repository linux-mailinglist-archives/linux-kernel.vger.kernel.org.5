Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D979B1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbjIKWYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbjIKOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB05CF0;
        Mon, 11 Sep 2023 07:07:33 -0700 (PDT)
Received: from www.ideasonboard.com (unknown [103.238.109.17])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7240B1ACE;
        Mon, 11 Sep 2023 16:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694441161;
        bh=XVYefCQU5WcDc2NaRLs9eMQLGiBQNdAD68wR5L9l9h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJYuf1s0KRyevFYsJfAYQ3aRxqT3moxVoEZD6kcdg7DCsV+M4eZTMGEIdY17BVS6X
         G4jfsACMN/bl6I7sgidtCJnpmwDB3O4J4AdG5Ide4Er7YxvG8HldPnLkvyE3DN2RdK
         Gi7V9lJ0ksyBjS31UWD+06wqWLpVuVO7JriPW/aU=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        kieran.bingham@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v10 2/5] staging: vc04_services: vchiq_arm: Register vchiq_bus_type
Date:   Mon, 11 Sep 2023 10:07:09 -0400
Message-ID: <20230911140712.180751-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911140712.180751-1-umang.jain@ideasonboard.com>
References: <20230911140712.180751-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index aa2313f3bcab..d993a91de237 100644
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
2.41.0

