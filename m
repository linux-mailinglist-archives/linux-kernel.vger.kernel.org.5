Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54103759997
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGSPYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjGSPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:23:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2510D2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:23:49 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:51f7:4083:c317:cdf])
        by xavier.telenet-ops.be with bizsmtp
        id P3Pg2A00E2xuRWb013Pgqz; Wed, 19 Jul 2023 17:23:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qM91W-001tYA-6y;
        Wed, 19 Jul 2023 17:23:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qM91g-001Bju-7o;
        Wed, 19 Jul 2023 17:23:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 4/4] drm: Fix references to drm_plane_helper_check_state()
Date:   Wed, 19 Jul 2023 17:23:37 +0200
Message-Id: <8bb42a92fc20e3d11e5847e7f15a47c687b73104.1689779916.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689779916.git.geert+renesas@glider.be>
References: <cover.1689779916.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit a01cb8ba3f628293 ("drm: Move drm_plane_helper_check_state()
into drm_atomic_helper.c"), drm_plane_helper_check_state() no longer
exists, but is part of drm_atomic_helper_check_plane_state().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c | 3 ++-
 drivers/gpu/drm/tidss/tidss_plane.c             | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
index d759e019218181ce..e445fac8e0b46c21 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
@@ -600,7 +600,8 @@ int __rcar_du_plane_atomic_check(struct drm_plane *plane,
 	if (!state->crtc) {
 		/*
 		 * The visible field is not reset by the DRM core but only
-		 * updated by drm_plane_helper_check_state(), set it manually.
+		 * updated by drm_atomic_helper_check_plane_state(), set it
+		 * manually.
 		 */
 		state->visible = false;
 		*format = NULL;
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 6bdd6e4a955ab3cc..e1c0ef0c3894c855 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -38,7 +38,8 @@ static int tidss_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->crtc) {
 		/*
 		 * The visible field is not reset by the DRM core but only
-		 * updated by drm_plane_helper_check_state(), set it manually.
+		 * updated by drm_atomic_helper_check_plane_state(), set it
+		 * manually.
 		 */
 		new_plane_state->visible = false;
 		return 0;
-- 
2.34.1

