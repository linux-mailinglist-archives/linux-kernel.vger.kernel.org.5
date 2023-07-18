Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA017582E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjGRQzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjGRQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:00 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022741719
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:54 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by xavier.telenet-ops.be with bizsmtp
        id Ngur2A00i1C8whw01gur1W; Tue, 18 Jul 2023 18:54:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nZR-KZ;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gdb-Li;
        Tue, 18 Jul 2023 18:54:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 31/41] drm: renesas: shmobile: Move shmob_drm_crtc_finish_page_flip()
Date:   Tue, 18 Jul 2023 18:54:36 +0200
Message-Id: <cb72002e1f36e176f8ed20c0d6985b5a6393e553.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the shmob_drm_crtc_finish_page_flip() function up, to avoid having
to move it during the modification in the next change.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2:
  - Add Reviewed-by,
  - Move further up.
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index f55b5263e611c782..0adf5d33ba31695e 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -35,6 +35,26 @@
  * TODO: panel support
  */
 
+/* -----------------------------------------------------------------------------
+ * Page Flip
+ */
+
+void shmob_drm_crtc_finish_page_flip(struct shmob_drm_crtc *scrtc)
+{
+	struct drm_pending_vblank_event *event;
+	struct drm_device *dev = scrtc->base.dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	event = scrtc->event;
+	scrtc->event = NULL;
+	if (event) {
+		drm_crtc_send_vblank_event(&scrtc->base, event);
+		drm_crtc_vblank_put(&scrtc->base);
+	}
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
 /* -----------------------------------------------------------------------------
  * CRTC
  */
@@ -364,22 +384,6 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.mode_set_base = shmob_drm_crtc_mode_set_base,
 };
 
-void shmob_drm_crtc_finish_page_flip(struct shmob_drm_crtc *scrtc)
-{
-	struct drm_pending_vblank_event *event;
-	struct drm_device *dev = scrtc->base.dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev->event_lock, flags);
-	event = scrtc->event;
-	scrtc->event = NULL;
-	if (event) {
-		drm_crtc_send_vblank_event(&scrtc->base, event);
-		drm_crtc_vblank_put(&scrtc->base);
-	}
-	spin_unlock_irqrestore(&dev->event_lock, flags);
-}
-
 static int shmob_drm_crtc_page_flip(struct drm_crtc *crtc,
 				    struct drm_framebuffer *fb,
 				    struct drm_pending_vblank_event *event,
-- 
2.34.1

