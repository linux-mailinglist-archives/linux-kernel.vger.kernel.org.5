Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C2D77DF47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbjHPKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244057AbjHPKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:02 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E592210E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:44:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by laurent.telenet-ops.be with bizsmtp
        id aAkg2A00E45ualL01AkgUv; Wed, 16 Aug 2023 12:44:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWE0v-000orW-P8;
        Wed, 16 Aug 2023 12:44:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWDAx-00676k-1U;
        Wed, 16 Aug 2023 11:50:51 +0200
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
Subject: [PATCH v3 33/41] drm: renesas: shmobile: Turn vblank on/off when enabling/disabling CRTC
Date:   Wed, 16 Aug 2023 11:50:40 +0200
Message-Id: <3474fc386331eeb1e4b3122a8811f62adda812b4.1692178020.git.geert+renesas@glider.be>
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
index 44f12bfcb3ce575d..78f9650e3a61365f 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -216,17 +216,17 @@ static int shmob_drm_probe(struct platform_device *pdev)
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

