Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5C7A35BC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjIQNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbjIQNr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:47:29 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146C131
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:47:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hs7MqNnnjvRSUhs7MqLFyC; Sun, 17 Sep 2023 15:47:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694958442;
        bh=hOGjJOJ5faGeiDJ8M4RMHf63I+hgy05f2bSDAh+zQrY=;
        h=From:To:Cc:Subject:Date;
        b=SLmIQVLAeIsjHjno63AidoYTz4Lvlg+QaN4WAqHJh8HRQ94RkPkTf35hFIdqpAMEw
         lceSC9tVm/O02R31TOE1iP70oU5WJc5GH+Y1F9Eczm2xkIVJReQcbTkEqa+yqzcpQf
         ju1UR2F1QeFroPHbe8WnhgOKd166Z4ipQ1Xyl1I+C/MfvjTiuVPgR65ZW651j3lm/t
         yGVn3aEWrShJ/eLk1OCamV9YWyj06g+XH2Xppqi+7srLVrMZUkTnP3X23Kj+Em2VFh
         L/6kCRqvKdVqRevvN57Fmp5j73n54PNFLlT4VEYk0ZZYLrrxAI6sZy1gXEh5GPKe3F
         IlRYxjziOeXvQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Sep 2023 15:47:22 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: pxa_camera: Fix an error handling path in pxa_camera_probe()
Date:   Sun, 17 Sep 2023 15:47:16 +0200
Message-Id: <30e64707efd739982d3f5747ec3613e4270e7434.1694958384.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has reordered the code and the error handling path.
However one 'goto' was missed.

Fix it and branch at the correct place in the error handling path.

Fixes: 5073d10cbaba ("media: pxa_camera: Register V4L2 device early")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/intel/pxa_camera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/intel/pxa_camera.c b/drivers/media/platform/intel/pxa_camera.c
index 6e6caf50e11e..59b89e421dc2 100644
--- a/drivers/media/platform/intel/pxa_camera.c
+++ b/drivers/media/platform/intel/pxa_camera.c
@@ -2398,7 +2398,7 @@ static int pxa_camera_probe(struct platform_device *pdev)
 			       PXA_CAM_DRV_NAME, pcdev);
 	if (err) {
 		dev_err(&pdev->dev, "Camera interrupt register failed\n");
-		goto exit_v4l2_device_unregister;
+		goto exit_deactivate;
 	}
 
 	pcdev->notifier.ops = &pxa_camera_sensor_ops;
-- 
2.34.1

