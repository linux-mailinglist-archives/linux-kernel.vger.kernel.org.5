Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A87E7356
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345352AbjKIVE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345326AbjKIVEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:04:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E94C1E;
        Thu,  9 Nov 2023 13:03:59 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07C6F192B;
        Thu,  9 Nov 2023 22:03:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563816;
        bh=u4fIZmKbPXY5oEdoRyck7LP+hiARU9F4laBpyjdLyvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzESIHSSPKdva2+f6soFUTQxUc+rq9EH7BGtR9UDvlHraMumAozHNPkumCAFs3oZP
         9ViQZMt/dJbhazFKIqCSHjceOirC1Si7atDAk8ce421dXTK8NgiGKRwiAT9jdFdQSO
         VOVFlhtmKpUFmK1MvuDyYPpG8hXaWo6yEWNOB5Fk=
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
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 15/15] staging: vc04_services: vchiq: Register bcm2835-isp
Date:   Thu,  9 Nov 2023 16:03:07 -0500
Message-ID: <20231109210309.638594-16-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vchiq device registeration and unregisteration for
the bcm2835-isp devices.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 5a9073480dd3..85dd259e6efc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -70,6 +70,7 @@ struct vchiq_state g_state;
  */
 static struct vchiq_device *bcm2835_audio;
 static struct vchiq_device *bcm2835_camera;
+static struct vchiq_device *bcm2835_isp;
 static struct vchiq_device *vcsm_cma;
 
 struct vchiq_drvdata {
@@ -1844,6 +1845,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	vcsm_cma = vchiq_device_register(&pdev->dev, "vcsm-cma");
 	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
 	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
+	bcm2835_isp = vchiq_device_register(&pdev->dev, "bcm2835-isp");
 
 	return 0;
 
@@ -1857,6 +1859,7 @@ static void vchiq_remove(struct platform_device *pdev)
 {
 	vchiq_device_unregister(bcm2835_audio);
 	vchiq_device_unregister(bcm2835_camera);
+	vchiq_device_unregister(bcm2835_isp);
 	vchiq_device_unregister(vcsm_cma);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
-- 
2.41.0

