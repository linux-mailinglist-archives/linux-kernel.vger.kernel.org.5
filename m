Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F6758302
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGRQ4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjGRQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:03 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02751171A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:54 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id Ngur2A00a1C8whw06gurSo; Tue, 18 Jul 2023 18:54:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nYe-Cr;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gcc-Dt;
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 19/41] drm: renesas: shmobile: Use drmm_universal_plane_alloc()
Date:   Tue, 18 Jul 2023 18:54:24 +0200
Message-Id: <ca245e28d56c5439ac82b0affad89f9ee66071d3.1689698048.git.geert+renesas@glider.be>
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

According to the comments for drm_universal_plane_init(), the plane
structure should not be allocated with devm_kzalloc().

Fix lifetime issues by using drmm_universal_plane_alloc() instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Split off removal of call to drm_plane_force_disable().
---
 .../gpu/drm/renesas/shmobile/shmob_drm_plane.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 3a5db319bad14218..1fb68b5fe915b8dc 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -179,7 +179,6 @@ static int shmob_drm_plane_disable(struct drm_plane *plane,
 static const struct drm_plane_funcs shmob_drm_plane_funcs = {
 	.update_plane = shmob_drm_plane_update,
 	.disable_plane = shmob_drm_plane_disable,
-	.destroy = drm_plane_cleanup,
 };
 
 static const uint32_t formats[] = {
@@ -198,19 +197,16 @@ static const uint32_t formats[] = {
 int shmob_drm_plane_create(struct shmob_drm_device *sdev, unsigned int index)
 {
 	struct shmob_drm_plane *splane;
-	int ret;
 
-	splane = devm_kzalloc(sdev->dev, sizeof(*splane), GFP_KERNEL);
-	if (splane == NULL)
-		return -ENOMEM;
+	splane = drmm_universal_plane_alloc(sdev->ddev, struct shmob_drm_plane,
+					    plane, 1, &shmob_drm_plane_funcs,
+					    formats, ARRAY_SIZE(formats), NULL,
+					    DRM_PLANE_TYPE_OVERLAY, NULL);
+	if (IS_ERR(splane))
+		return PTR_ERR(splane);
 
 	splane->index = index;
 	splane->alpha = 255;
 
-	ret = drm_universal_plane_init(sdev->ddev, &splane->plane, 1,
-				       &shmob_drm_plane_funcs,
-				       formats, ARRAY_SIZE(formats), NULL,
-				       DRM_PLANE_TYPE_OVERLAY, NULL);
-
-	return ret;
+	return 0;
 }
-- 
2.34.1

