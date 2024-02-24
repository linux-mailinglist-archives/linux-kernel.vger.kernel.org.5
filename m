Return-Path: <linux-kernel+bounces-79712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A19B8625B5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3330B218C9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1445028;
	Sat, 24 Feb 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="tMfWRFgo"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8B45976
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708787173; cv=none; b=Wj80449blcTgwhmwi94whCDO8tddliuTTjg6kSsSC28W8LaCNq1+QzEXVEwevuCf+7OC6OfGMgw/XLFIfDPP6IO7MV8HB7LnrAMNc9KPhlnMVQLkG6Qw66u0vrdTYK+YN0sxwi5j03fOpG580EmthZjZS5hUtschyNpm6wQGAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708787173; c=relaxed/simple;
	bh=1o4GXfvP6xMrbbr1RM8jSgzNi7t4j6YOvmuIy2AM9jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uvmd9P8bYDiGjI8JFbWYhx6Vk66P0WfB3glzm66nlzLjIxt6ERWHV3GS7egjwJCgoBqqRgFBQ71Zj1w/EQxwyIcxV8XMcpN1JMvzEsp2RWCznVmYN/fuC6GeO8cd2O5VLRWn0VagfUPrK7cPSHU00ukpsrYrfairo+EDL+6zKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=tMfWRFgo; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708787168; bh=1o4GXfvP6xMrbbr1RM8jSgzNi7t4j6YOvmuIy2AM9jE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tMfWRFgoNIuDUYqRsD974N3vcVI89e9R6Zbs7lKepJ7JniADdhZWgOdW7bf6wGDAb
	 TyWdUyTZeQdx4pc6jTxX9ajGxkA2iLRZhlitAZFGDFBG6CdakEl/6NbTU42NVwLeGF
	 t2kkJYHk6wim1WxIR4ud/+05vkpYhKudg4PpvgD0=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Ondrej Jirman <megi@xff.cz>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] drm/sun4i: Add more parameters to sunxi_engine commit callback
Date: Sat, 24 Feb 2024 16:05:59 +0100
Message-ID: <20240224150604.3855534-3-megi@xff.cz>
In-Reply-To: <20240224150604.3855534-1-megi@xff.cz>
References: <20240224150604.3855534-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

These will be needed later on when we move layer configuration to
crtc update.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c |  4 +++-
 drivers/gpu/drm/sun4i/sun4i_crtc.c    |  2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c   |  5 ++++-
 drivers/gpu/drm/sun4i/sunxi_engine.h  | 13 ++++++++++---
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 335fd0edb904..e89eb96d3131 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -69,7 +69,9 @@ static void sun4i_backend_disable_color_correction(struct sunxi_engine *engine)
 			   SUN4I_BACKEND_OCCTL_ENABLE, 0);
 }
 
-static void sun4i_backend_commit(struct sunxi_engine *engine)
+static void sun4i_backend_commit(struct sunxi_engine *engine,
+				 struct drm_crtc *crtc,
+				 struct drm_atomic_state *state)
 {
 	DRM_DEBUG_DRIVER("Committing changes\n");
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index c06d7cd45388..18e74047b0f5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -91,7 +91,7 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	DRM_DEBUG_DRIVER("Committing plane changes\n");
 
-	sunxi_engine_commit(scrtc->engine);
+	sunxi_engine_commit(scrtc->engine, crtc, state);
 
 	if (event) {
 		crtc->state->event = NULL;
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 1e681314e379..bdeb9b80e038 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_framebuffer.h>
@@ -249,7 +250,9 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
 	return -EINVAL;
 }
 
-static void sun8i_mixer_commit(struct sunxi_engine *engine)
+static void sun8i_mixer_commit(struct sunxi_engine *engine,
+			       struct drm_crtc *crtc,
+			       struct drm_atomic_state *state)
 {
 	DRM_DEBUG_DRIVER("Committing changes\n");
 
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index ec8cf9b2bda4..ec0c4932f15c 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -7,6 +7,7 @@
 #define _SUNXI_ENGINE_H_
 
 struct drm_plane;
+struct drm_crtc;
 struct drm_device;
 struct drm_crtc_state;
 struct drm_display_mode;
@@ -59,7 +60,9 @@ struct sunxi_engine_ops {
 	 *
 	 * This function is optional.
 	 */
-	void (*commit)(struct sunxi_engine *engine);
+	void (*commit)(struct sunxi_engine *engine,
+		       struct drm_crtc *crtc,
+		       struct drm_atomic_state *state);
 
 	/**
 	 * @layers_init:
@@ -144,12 +147,16 @@ struct sunxi_engine {
 /**
  * sunxi_engine_commit() - commit all changes of the engine
  * @engine:	pointer to the engine
+ * @crtc:	pointer to crtc the engine is associated with
+ * @state:	atomic state
  */
 static inline void
-sunxi_engine_commit(struct sunxi_engine *engine)
+sunxi_engine_commit(struct sunxi_engine *engine,
+		    struct drm_crtc *crtc,
+		    struct drm_atomic_state *state)
 {
 	if (engine->ops && engine->ops->commit)
-		engine->ops->commit(engine);
+		engine->ops->commit(engine, crtc, state);
 }
 
 /**
-- 
2.44.0


