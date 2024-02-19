Return-Path: <linux-kernel+bounces-71096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308E85A093
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3956281E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92B25601;
	Mon, 19 Feb 2024 10:09:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C95288DF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337374; cv=none; b=IAL17uBOiElTKYoFk/fs3sxhoicMgLsw2EahaOEkYT3tviN5cgrgIU4r2yYO6jNBoO0nGyeU8AOEx2KiCRl/+WhPgfWG6M1m+so80FiZpcUHYZ02Lf0j6iE5b/L+hXx/oS6PqQ0GLLb5F0tV0GPnZKfEo04bat54WeaZylp68ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337374; c=relaxed/simple;
	bh=fPKK7lbxTJQg2HozRmLSmLdED3dVOb6syBUEw/ZUhuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiDHcX/I48g/NRQVxrKtPyDMx+94iEOkJ8rUVjVI/gRm2vnzi7nok6Cdwl4TCuCP6ptJXwOrPPDEy0kSADeOwO38yTGy2hB8p5EM1g0FU0L0VPws0SB4y+2C2ETvewgpICNvJpa1eVDStDctHnsfRWIchLJa52yPah2Mhv7wI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D454E1FB;
	Mon, 19 Feb 2024 02:10:11 -0800 (PST)
Received: from a077854.blr.arm.com (a077854.arm.com [10.162.41.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D45B3F762;
	Mon, 19 Feb 2024 02:09:29 -0800 (PST)
From: Faiz Abbas <faiz.abbas@arm.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Faiz Abbas <faiz.abbas@arm.com>
Subject: [PATCH 1/3] drm/arm/komeda: Fix komeda probe failing if there are no links in the secondary pipeline
Date: Mon, 19 Feb 2024 15:39:13 +0530
Message-Id: <20240219100915.192475-2-faiz.abbas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219100915.192475-1-faiz.abbas@arm.com>
References: <20240219100915.192475-1-faiz.abbas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f7936d6beda9 ("drm/arm/komeda: Remove component framework and
add a simple encoder"), the devm_drm_of_get_bridge() call happens
regardless of whether any remote nodes are available on the pipeline. Fix
this by moving the bridge attach to its own function and calling it
conditional on there being an output link.

Fixes: f7936d6beda9 ("drm/arm/komeda: Remove component framework and add a simple encoder")
Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 43 ++++++++++++++-----
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index 2c661f28410e..b645c5998230 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -5,6 +5,7 @@
  *
  */
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
@@ -610,12 +611,34 @@ get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
 	return NULL;
 }
 
+static int komeda_attach_bridge(struct device *dev,
+				struct komeda_pipeline *pipe,
+				struct drm_encoder *encoder)
+{
+	struct drm_bridge *bridge;
+	int err;
+
+	bridge = devm_drm_of_get_bridge(dev, pipe->of_node,
+					KOMEDA_OF_PORT_OUTPUT, 0);
+	if (IS_ERR(bridge))
+		return dev_err_probe(dev, PTR_ERR(bridge), "remote bridge not found for pipe: %s\n",
+				     of_node_full_name(pipe->of_node));
+
+	err = drm_bridge_attach(encoder, bridge, NULL, 0);
+	if (err)
+		dev_err(dev, "bridge_attach() failed for pipe: %s\n",
+			of_node_full_name(pipe->of_node));
+
+	return err;
+}
+
 static int komeda_crtc_add(struct komeda_kms_dev *kms,
 			   struct komeda_crtc *kcrtc)
 {
 	struct drm_crtc *crtc = &kcrtc->base;
 	struct drm_device *base = &kms->base;
-	struct drm_bridge *bridge;
+	struct komeda_pipeline *pipe = kcrtc->master;
+	struct drm_encoder *encoder = &kcrtc->encoder;
 	int err;
 
 	err = drm_crtc_init_with_planes(base, crtc,
@@ -626,27 +649,25 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
 
 	drm_crtc_helper_add(crtc, &komeda_crtc_helper_funcs);
 
-	crtc->port = kcrtc->master->of_output_port;
+	crtc->port = pipe->of_output_port;
 
 	/* Construct an encoder for each pipeline and attach it to the remote
 	 * bridge
 	 */
 	kcrtc->encoder.possible_crtcs = drm_crtc_mask(crtc);
-	err = drm_simple_encoder_init(base, &kcrtc->encoder,
-				      DRM_MODE_ENCODER_TMDS);
+	err = drm_simple_encoder_init(base, encoder, DRM_MODE_ENCODER_TMDS);
 	if (err)
 		return err;
 
-	bridge = devm_drm_of_get_bridge(base->dev, kcrtc->master->of_node,
-					KOMEDA_OF_PORT_OUTPUT, 0);
-	if (IS_ERR(bridge))
-		return PTR_ERR(bridge);
-
-	err = drm_bridge_attach(&kcrtc->encoder, bridge, NULL, 0);
+	if (pipe->of_output_links[0]) {
+		err = komeda_attach_bridge(base->dev, pipe, encoder);
+		if (err)
+			return err;
+	}
 
 	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
 
-	return err;
+	return 0;
 }
 
 int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *mdev)
-- 
2.25.1


