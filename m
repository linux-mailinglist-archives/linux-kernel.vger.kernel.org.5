Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CFC7A19AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjIOIzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjIOIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:54:33 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EEF2D5A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:54:19 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7135:da8b:ba1d:1a7c])
        by albert.telenet-ops.be with bizsmtp
        id m8uF2A00Q3q21w7068uFYl; Fri, 15 Sep 2023 10:54:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4aK-003lI1-3W;
        Fri, 15 Sep 2023 10:54:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4ad-00GddG-3j;
        Fri, 15 Sep 2023 10:54:15 +0200
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
Subject: [PATCH v4 33/41] drm: renesas: shmobile: Turn vblank on/off when enabling/disabling CRTC
Date:   Fri, 15 Sep 2023 10:53:48 +0200
Message-Id: <e5833e5706b7792bfca8e6e56fc154a7c3e0574f.1694767209.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694767208.git.geert+renesas@glider.be>
References: <cover.1694767208.git.geert+renesas@glider.be>
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

The DRM core vblank handling mechanism requires drivers to forcefully
turn vblank reporting off when disabling the CRTC, and to restore the
vblank reporting status when enabling the CRTC.
Implement this using the drm_crtc_vblank_{on,off}() helpers.

Note that drm_crtc_vblank_off() must be called at startup to synchronize
the state of the vblank core code with the hardware, which is initially
disabled.  This is performed at CRTC creation time, requiring vertical
blank initialization to be moved before creating CRTCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v4:
  - No changes,

v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 10 +++++++++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 12 ++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 20adb9d2fa178250..ab42a4999a55c475 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -271,6 +271,9 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 
 	shmob_drm_crtc_start_stop(scrtc, true);
 
+	/* Turn vertical blank interrupt reporting back on. */
+	drm_crtc_vblank_on(crtc);
+
 	scrtc->started = true;
 }
 
@@ -283,10 +286,12 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 		return;
 
 	/*
-	 * Wait for page flip completion before stopping the CRTC as userspace
+	 * Disable vertical blank interrupt reporting.  We first need to wait
+	 * for page flip completion before stopping the CRTC as userspace
 	 * expects page flips to eventually complete.
 	 */
 	shmob_drm_crtc_wait_page_flip(scrtc);
+	drm_crtc_vblank_off(crtc);
 
 	/* Stop the LCDC. */
 	shmob_drm_crtc_start_stop(scrtc, false);
@@ -519,6 +524,9 @@ int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
 
 	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
 
+	/* Start with vertical blank interrupt reporting disabled. */
+	drm_crtc_vblank_off(crtc);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 2bd205f9ea723062..c3a1995403d6c2c9 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -215,17 +215,17 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = shmob_drm_modeset_init(sdev);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to initialize mode setting\n");
-
 	ret = drm_vblank_init(ddev, 1);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to initialize vblank\n");
-		goto err_modeset_cleanup;
+		return ret;
 	}
 
+	ret = shmob_drm_modeset_init(sdev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to initialize mode setting\n");
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		goto err_modeset_cleanup;
-- 
2.34.1

