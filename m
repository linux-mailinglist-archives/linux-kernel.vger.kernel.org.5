Return-Path: <linux-kernel+bounces-32884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CFF836164
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B7E1F27ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995404C3B9;
	Mon, 22 Jan 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="bKNx41Ut"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540194C609
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921925; cv=none; b=LofzYbwQeCtEnaFBBtVMlBoQH/ri0zIdlapKNfW7Q6hm5QXvdnv2/WRqMmrJDMDynNL/uwU3iIcPzNIEZRTaYHBaewTZhRuand+SlqsxvidWmjUaX9P+Rv9NT44+ZDjgPqEV/b9k06bQD6voPz7gN2IsKk0bL3D6BT/8AjxMgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921925; c=relaxed/simple;
	bh=18FXR6Q5xROo9X2pMM68D0Ki8ZVCWsmS1INeFq+vG/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+Eq5rqZShod9zGWu0txnWLZkc+IG265JiGNv+LpyGHC1cv5Rom3OO4R+Sn7FaGyEHb8gzm3TORr5/XgzN6/WCZjEnshe0uJNM55VBj0h+r7XPUhrkZQeAX9didm0mVjlsGxKg8HSIYQTtTzXtYmMp5BMj52gnyj62dD+Ovt8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=bKNx41Ut; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from lvc-arm12.ispras.local (unknown [83.149.199.78])
	by mail.ispras.ru (Postfix) with ESMTPSA id 4A49840F1DE6;
	Mon, 22 Jan 2024 11:11:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4A49840F1DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1705921911;
	bh=4qafhDsstu+fI2ZE276xbjZ5WzhAT+Anma2zk/rbwu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKNx41UtGMHF9O/8QysFpjmNL9P43M+0zzrdWvGjzWA+3/CiYC7WPxZNMocobhdp3
	 mL2KG6x5uDjIfZHuwNdXCB5VhWzvfFwoAVAtaH3yclYjsLzKiKMNvmplCbDSIv6A2A
	 CSnv3AEIBi5nHdsuJB0E6JKg62efRkJUgNnldzLA=
From: Katya Orlova <e.orlova@ispras.ru>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Katya Orlova <e.orlova@ispras.ru>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v3] drm/stm: Avoid use-after-free issues with crtc and plane
Date: Mon, 22 Jan 2024 14:11:28 +0300
Message-Id: <20240122111128.10852-1-e.orlova@ispras.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <76b4dfd8-f8c2-41f1-96df-539b168f9e80@foss.st.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ltdc_load() calls functions drm_crtc_init_with_planes(),
drm_universal_plane_init() and drm_encoder_init(). These functions
should not be called with parameters allocated with devm_kzalloc()
to avoid use-after-free issues [1].

Use allocations managed by the DRM framework.

Found by Linux Verification Center (linuxtesting.org).

[1]
https://lore.kernel.org/lkml/u366i76e3qhh3ra5oxrtngjtm2u5lterkekcz6y2jkndhuxzli@diujon4h7qwb/

Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
---
v3: style problems
v2: use allocations managed by the DRM as
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com> suggested.
Also add a fix for encoder.
 drivers/gpu/drm/stm/drv.c  |  3 +-
 drivers/gpu/drm/stm/ltdc.c | 69 +++++++++-----------------------------
 2 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index e8523abef27a..152bec2c0238 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -25,6 +25,7 @@
 #include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include "ltdc.h"
 
@@ -75,7 +76,7 @@ static int drv_load(struct drm_device *ddev)
 
 	DRM_DEBUG("%s\n", __func__);
 
-	ldev = devm_kzalloc(ddev->dev, sizeof(*ldev), GFP_KERNEL);
+	ldev = drmm_kzalloc(ddev, sizeof(*ldev), GFP_KERNEL);
 	if (!ldev)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5576fdae4962..e050b519ad38 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -36,6 +36,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include <video/videomode.h>
 
@@ -1199,7 +1200,6 @@ static void ltdc_crtc_atomic_print_state(struct drm_printer *p,
 }
 
 static const struct drm_crtc_funcs ltdc_crtc_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
@@ -1212,7 +1212,6 @@ static const struct drm_crtc_funcs ltdc_crtc_funcs = {
 };
 
 static const struct drm_crtc_funcs ltdc_crtc_with_crc_support_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
@@ -1545,7 +1544,6 @@ static void ltdc_plane_atomic_print_state(struct drm_printer *p,
 static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = drm_plane_cleanup,
 	.reset = drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
@@ -1572,7 +1570,6 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	const u64 *modifiers = ltdc_format_modifiers;
 	u32 lofs = index * LAY_OFS;
 	u32 val;
-	int ret;
 
 	/* Allocate the biggest size according to supported color formats */
 	formats = devm_kzalloc(dev, (ldev->caps.pix_fmt_nb +
@@ -1613,14 +1610,10 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 		}
 	}
 
-	plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return NULL;
-
-	ret = drm_universal_plane_init(ddev, plane, possible_crtcs,
-				       &ltdc_plane_funcs, formats, nb_fmt,
-				       modifiers, type, NULL);
-	if (ret < 0)
+	plane = drmm_universal_plane_alloc(ddev, struct drm_plane, dev,
+					   possible_crtcs, &ltdc_plane_funcs, formats,
+					   nb_fmt, modifiers, type, NULL);
+	if (IS_ERR(plane))
 		return NULL;
 
 	if (ldev->caps.ycbcr_input) {
@@ -1643,15 +1636,6 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	return plane;
 }
 
-static void ltdc_plane_destroy_all(struct drm_device *ddev)
-{
-	struct drm_plane *plane, *plane_temp;
-
-	list_for_each_entry_safe(plane, plane_temp,
-				 &ddev->mode_config.plane_list, head)
-		drm_plane_cleanup(plane);
-}
-
 static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 {
 	struct ltdc_device *ldev = ddev->dev_private;
@@ -1677,14 +1661,14 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 
 	/* Init CRTC according to its hardware features */
 	if (ldev->caps.crc)
-		ret = drm_crtc_init_with_planes(ddev, crtc, primary, NULL,
+		ret = drmm_crtc_init_with_planes(ddev, crtc, primary, NULL,
 						 &ltdc_crtc_with_crc_support_funcs, NULL);
 	else
-		ret = drm_crtc_init_with_planes(ddev, crtc, primary, NULL,
+		ret = drmm_crtc_init_with_planes(ddev, crtc, primary, NULL,
 						 &ltdc_crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("Can not initialize CRTC\n");
-		goto cleanup;
+		return ret;
 	}
 
 	drm_crtc_helper_add(crtc, &ltdc_crtc_helper_funcs);
@@ -1698,9 +1682,8 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 	for (i = 1; i < ldev->caps.nb_layers; i++) {
 		overlay = ltdc_plane_create(ddev, DRM_PLANE_TYPE_OVERLAY, i);
 		if (!overlay) {
-			ret = -ENOMEM;
 			DRM_ERROR("Can not create overlay plane %d\n", i);
-			goto cleanup;
+			return -ENOMEM;
 		}
 		if (ldev->caps.dynamic_zorder)
 			drm_plane_create_zpos_property(overlay, i, 0, ldev->caps.nb_layers - 1);
@@ -1713,10 +1696,6 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 	}
 
 	return 0;
-
-cleanup:
-	ltdc_plane_destroy_all(ddev);
-	return ret;
 }
 
 static void ltdc_encoder_disable(struct drm_encoder *encoder)
@@ -1776,23 +1755,19 @@ static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 	struct drm_encoder *encoder;
 	int ret;
 
-	encoder = devm_kzalloc(ddev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
-		return -ENOMEM;
+	encoder = drmm_simple_encoder_alloc(ddev, struct drm_encoder, dev,
+					    DRM_MODE_ENCODER_DPI);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
 
 	encoder->possible_crtcs = CRTC_MASK;
 	encoder->possible_clones = 0;	/* No cloning support */
 
-	drm_simple_encoder_init(ddev, encoder, DRM_MODE_ENCODER_DPI);
-
 	drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
 
 	ret = drm_bridge_attach(encoder, bridge, NULL, 0);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			drm_encoder_cleanup(encoder);
+	if (ret)
 		return ret;
-	}
 
 	DRM_DEBUG_DRIVER("Bridge encoder:%d created\n", encoder->base.id);
 
@@ -1962,8 +1937,7 @@ int ltdc_load(struct drm_device *ddev)
 			goto err;
 
 		if (panel) {
-			bridge = drm_panel_bridge_add_typed(panel,
-							    DRM_MODE_CONNECTOR_DPI);
+			bridge = drmm_panel_bridge_add(ddev, panel);
 			if (IS_ERR(bridge)) {
 				DRM_ERROR("panel-bridge endpoint %d\n", i);
 				ret = PTR_ERR(bridge);
@@ -2045,7 +2019,7 @@ int ltdc_load(struct drm_device *ddev)
 		}
 	}
 
-	crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
+	crtc = drmm_kzalloc(ddev, sizeof(*crtc), GFP_KERNEL);
 	if (!crtc) {
 		DRM_ERROR("Failed to allocate crtc\n");
 		ret = -ENOMEM;
@@ -2072,9 +2046,6 @@ int ltdc_load(struct drm_device *ddev)
 
 	return 0;
 err:
-	for (i = 0; i < nb_endpoints; i++)
-		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
-
 	clk_disable_unprepare(ldev->pixel_clk);
 
 	return ret;
@@ -2082,16 +2053,8 @@ int ltdc_load(struct drm_device *ddev)
 
 void ltdc_unload(struct drm_device *ddev)
 {
-	struct device *dev = ddev->dev;
-	int nb_endpoints, i;
-
 	DRM_DEBUG_DRIVER("\n");
 
-	nb_endpoints = of_graph_get_endpoint_count(dev->of_node);
-
-	for (i = 0; i < nb_endpoints; i++)
-		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
-
 	pm_runtime_disable(ddev->dev);
 }
 
-- 
2.30.2


