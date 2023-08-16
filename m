Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7477177DF79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbjHPKpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbjHPKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:10 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04942121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:44:49 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by andre.telenet-ops.be with bizsmtp
        id aAkh2A00745ualL01AkhCf; Wed, 16 Aug 2023 12:44:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWE0w-000os9-Kg;
        Wed, 16 Aug 2023 12:44:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWDAw-00675m-PZ;
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
Subject: [PATCH v3 21/41] drm: renesas: shmobile: Convert container helpers to static inline functions
Date:   Wed, 16 Aug 2023 11:50:28 +0200
Message-Id: <0d74fdda78f548f68c57739844a8fb0412368e15.1692178020.git.geert+renesas@glider.be>
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

Replace to conversion helper macros using container_of() by static
inline functions, to improve type-safety.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  | 11 ++++++++---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |  5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 9c66e00ed70ea582..207fa98fe76d6f88 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -258,7 +258,10 @@ static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
 	lcdc_write(sdev, LDRCNTR, lcdc_read(sdev, LDRCNTR) ^ LDRCNTR_MRS);
 }
 
-#define to_shmob_crtc(c)	container_of(c, struct shmob_drm_crtc, crtc)
+static inline struct shmob_drm_crtc *to_shmob_crtc(struct drm_crtc *crtc)
+{
+	return container_of(crtc, struct shmob_drm_crtc, crtc);
+}
 
 static void shmob_drm_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
@@ -538,8 +541,10 @@ int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
  * Connector
  */
 
-#define to_shmob_connector(c) \
-	container_of(c, struct shmob_drm_connector, connector)
+static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connector *connector)
+{
+	return container_of(connector, struct shmob_drm_connector, connector);
+}
 
 static int shmob_drm_connector_get_modes(struct drm_connector *connector)
 {
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 17e66a018689f648..258288c80756bf16 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -34,7 +34,10 @@ struct shmob_drm_plane {
 	unsigned int crtc_h;
 };
 
-#define to_shmob_plane(p)	container_of(p, struct shmob_drm_plane, plane)
+static inline struct shmob_drm_plane *to_shmob_plane(struct drm_plane *plane)
+{
+	return container_of(plane, struct shmob_drm_plane, plane);
+}
 
 static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
 					 struct drm_framebuffer *fb,
-- 
2.34.1

