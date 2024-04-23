Return-Path: <linux-kernel+bounces-155650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0B8AF538
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D131F23DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98D13DDDE;
	Tue, 23 Apr 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KOdnL+Ac"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B813D8B0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892758; cv=none; b=OS4QBbo/lP0qiXcfuzqW8GIo4PhHe8fmS5yNt41EuJ5OURBVL5f2doBds0KeT+rUXKL4/JsWOPS2OJsIa2PuhkjiLPsLHj+vrIW2IVhNK4MPV9v3KgwCNUy1zfgxwtWyrLp+03ayrnNH4q2Floln5+0VUtBSQWUiV2Dfue8lAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892758; c=relaxed/simple;
	bh=VsVfaLDJwUbf4wZb9SlRbtcHLGnKH0YlD3YRgyJ6794=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r//naDjDMj/wq/mc9IeycDF0kjhNFrSYkEMy2fcfqJMLpWU4oaAmikLOomY+xB7QFSfFo3oWuL4ZVw/19TUecxcSSwsVSDSXr6ReApl+Lcvuid6bI8yTYv15RUvUyOeAqkBjXWanxA5aLzOxduChwqFX95SRNJ4RBwKvHcJ/+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KOdnL+Ac; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOGt+jSm9xSy5lxg/d3TOjXUukiXICzPkjr8gC7XjPo=;
	b=KOdnL+AcNlkTtmXsQ0E00qcw3EBV6jUTFnCleZG3VMQyVLZnU3XUHrC+JMa6OsJaIedvjA
	slWI6bPqK+DaX3pIX8ujvDS+C0j4UaI/11EXf6KJ4Eg8c6PFajUHWBpPZsKfvsaPVuKU4M
	KH/xQ+y3aKKnNJUqlQj/jD1TRv/3Hxg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 01/13] drm: xlnx: Store base pointers in zynqmp_disp directly
Date: Tue, 23 Apr 2024 13:18:47 -0400
Message-Id: <20240423171859.3953024-2-sean.anderson@linux.dev>
In-Reply-To: <20240423171859.3953024-1-sean.anderson@linux.dev>
References: <20240423171859.3953024-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The blend, avbuf, and audio members of zynqmp_disp are anonymous structs
with only one member each. This is rather pointless, so move the members
up a level.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

(no changes since v3)

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_disp.c | 44 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 8a39b3accce5..ca164a750ee9 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -128,24 +128,18 @@ struct zynqmp_disp_layer {
  * struct zynqmp_disp - Display controller
  * @dev: Device structure
  * @dpsub: Display subsystem
- * @blend.base: Register I/O base address for the blender
- * @avbuf.base: Register I/O base address for the audio/video buffer manager
- * @audio.base: Registers I/O base address for the audio mixer
+ * @blend: Register I/O base address for the blender
+ * @avbuf: Register I/O base address for the audio/video buffer manager
+ * @audio: Registers I/O base address for the audio mixer
  * @layers: Layers (planes)
  */
 struct zynqmp_disp {
 	struct device *dev;
 	struct zynqmp_dpsub *dpsub;
 
-	struct {
-		void __iomem *base;
-	} blend;
-	struct {
-		void __iomem *base;
-	} avbuf;
-	struct {
-		void __iomem *base;
-	} audio;
+	void __iomem *blend;
+	void __iomem *avbuf;
+	void __iomem *audio;
 
 	struct zynqmp_disp_layer layers[ZYNQMP_DPSUB_NUM_LAYERS];
 };
@@ -356,12 +350,12 @@ static const struct zynqmp_disp_format avbuf_gfx_fmts[] = {
 
 static u32 zynqmp_disp_avbuf_read(struct zynqmp_disp *disp, int reg)
 {
-	return readl(disp->avbuf.base + reg);
+	return readl(disp->avbuf + reg);
 }
 
 static void zynqmp_disp_avbuf_write(struct zynqmp_disp *disp, int reg, u32 val)
 {
-	writel(val, disp->avbuf.base + reg);
+	writel(val, disp->avbuf + reg);
 }
 
 static bool zynqmp_disp_layer_is_video(const struct zynqmp_disp_layer *layer)
@@ -587,7 +581,7 @@ static void zynqmp_disp_avbuf_disable(struct zynqmp_disp *disp)
 
 static void zynqmp_disp_blend_write(struct zynqmp_disp *disp, int reg, u32 val)
 {
-	writel(val, disp->blend.base + reg);
+	writel(val, disp->blend + reg);
 }
 
 /*
@@ -813,7 +807,7 @@ static void zynqmp_disp_blend_layer_disable(struct zynqmp_disp *disp,
 
 static void zynqmp_disp_audio_write(struct zynqmp_disp *disp, int reg, u32 val)
 {
-	writel(val, disp->audio.base + reg);
+	writel(val, disp->audio + reg);
 }
 
 /**
@@ -1237,21 +1231,21 @@ int zynqmp_disp_probe(struct zynqmp_dpsub *dpsub)
 	disp->dev = &pdev->dev;
 	disp->dpsub = dpsub;
 
-	disp->blend.base = devm_platform_ioremap_resource_byname(pdev, "blend");
-	if (IS_ERR(disp->blend.base)) {
-		ret = PTR_ERR(disp->blend.base);
+	disp->blend = devm_platform_ioremap_resource_byname(pdev, "blend");
+	if (IS_ERR(disp->blend)) {
+		ret = PTR_ERR(disp->blend);
 		goto error;
 	}
 
-	disp->avbuf.base = devm_platform_ioremap_resource_byname(pdev, "av_buf");
-	if (IS_ERR(disp->avbuf.base)) {
-		ret = PTR_ERR(disp->avbuf.base);
+	disp->avbuf = devm_platform_ioremap_resource_byname(pdev, "av_buf");
+	if (IS_ERR(disp->avbuf)) {
+		ret = PTR_ERR(disp->avbuf);
 		goto error;
 	}
 
-	disp->audio.base = devm_platform_ioremap_resource_byname(pdev, "aud");
-	if (IS_ERR(disp->audio.base)) {
-		ret = PTR_ERR(disp->audio.base);
+	disp->audio = devm_platform_ioremap_resource_byname(pdev, "aud");
+	if (IS_ERR(disp->audio)) {
+		ret = PTR_ERR(disp->audio);
 		goto error;
 	}
 
-- 
2.35.1.1320.gc452695387.dirty


