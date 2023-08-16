Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70577DF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbjHPKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244027AbjHPKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:11 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A32719
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:44:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by michel.telenet-ops.be with bizsmtp
        id aAkh2A00F45ualL06Akh1o; Wed, 16 Aug 2023 12:44:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWE0w-000osO-UH;
        Wed, 16 Aug 2023 12:44:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWDAw-00675S-Mo;
        Wed, 16 Aug 2023 11:50:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 17/41] drm: renesas: shmobile: Convert to use devm_request_irq()
Date:   Wed, 16 Aug 2023 11:50:24 +0200
Message-Id: <073cc8d262c6d9eaac0d00fca29cf7282c7acf10.1692178020.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692178020.git.geert+renesas@glider.be>
References: <cover.1692178020.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to managed IRQ handling, to simplify cleanup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 91daab80b0ede058..381e184abf552c4c 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -196,7 +196,6 @@ static int shmob_drm_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(ddev);
 	drm_kms_helper_poll_fini(ddev);
-	free_irq(sdev->irq, ddev);
 	drm_dev_put(ddev);
 
 	return 0;
@@ -279,8 +278,8 @@ static int shmob_drm_probe(struct platform_device *pdev)
 		goto err_modeset_cleanup;
 	sdev->irq = ret;
 
-	ret = request_irq(sdev->irq, shmob_drm_irq, 0, ddev->driver->name,
-			  ddev);
+	ret = devm_request_irq(&pdev->dev, sdev->irq, shmob_drm_irq, 0,
+			       ddev->driver->name, ddev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to install IRQ handler\n");
 		goto err_modeset_cleanup;
@@ -292,14 +291,12 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	 */
 	ret = drm_dev_register(ddev, 0);
 	if (ret < 0)
-		goto err_irq_uninstall;
+		goto err_modeset_cleanup;
 
 	drm_fbdev_generic_setup(ddev, 16);
 
 	return 0;
 
-err_irq_uninstall:
-	free_irq(sdev->irq, ddev);
 err_modeset_cleanup:
 	drm_kms_helper_poll_fini(ddev);
 err_free_drm_dev:
-- 
2.34.1

