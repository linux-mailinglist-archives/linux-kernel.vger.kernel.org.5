Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD78A77DF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbjHPKpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbjHPKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:45:03 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB82710
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:44:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
        by albert.telenet-ops.be with bizsmtp
        id aAkh2A00k45ualL06AkhQq; Wed, 16 Aug 2023 12:44:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWE0w-000osK-Ru;
        Wed, 16 Aug 2023 12:44:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWDAw-00675X-NW;
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 18/41] drm: renesas: shmobile: Remove custom plane destroy callback
Date:   Wed, 16 Aug 2023 11:50:25 +0200
Message-Id: <4562ff5880d2d8681d62e0fcdca210bfd4778486.1692178020.git.geert+renesas@glider.be>
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

There is no need to call drm_plane_force_disable() from the plane's
.destroy() callback, as the plane should have been disabled already
before.  See also commit 3c858a33858baa8c ("drm/plane_helper: don't
disable plane in destroy function") for the generic plane helper case.

After removing this call, shmob_drm_plane_destroy() becomes a simple
wrapper around shmob_drm_plane_destroy(), hence replace it by the
latter.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 0b2ab153e9ae76df..3a5db319bad14218 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -176,16 +176,10 @@ static int shmob_drm_plane_disable(struct drm_plane *plane,
 	return 0;
 }
 
-static void shmob_drm_plane_destroy(struct drm_plane *plane)
-{
-	drm_plane_force_disable(plane);
-	drm_plane_cleanup(plane);
-}
-
 static const struct drm_plane_funcs shmob_drm_plane_funcs = {
 	.update_plane = shmob_drm_plane_update,
 	.disable_plane = shmob_drm_plane_disable,
-	.destroy = shmob_drm_plane_destroy,
+	.destroy = drm_plane_cleanup,
 };
 
 static const uint32_t formats[] = {
-- 
2.34.1

