Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B755D77DF69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbjHPKpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjHPKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:03 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A862D73
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:44:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by andre.telenet-ops.be with bizsmtp
        id aAkg2A00H45ualL01AkgCF; Wed, 16 Aug 2023 12:44:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWE0v-000orc-TE;
        Wed, 16 Aug 2023 12:44:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWDAx-00676a-02;
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
Subject: [PATCH v3 31/41] drm: renesas: shmobile: Move shmob_drm_crtc_finish_page_flip()
Date:   Wed, 16 Aug 2023 11:50:38 +0200
Message-Id: <88bcd675b03a109874e1dff24ff0aa4d45ab96ce.1692178020.git.geert+renesas@glider.be>
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

Move the shmob_drm_crtc_finish_page_flip() function up, to avoid having
to move it during the modification in the next change.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v3:
  - No changes,

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

