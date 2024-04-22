Return-Path: <linux-kernel+bounces-153857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205B88AD440
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8802833D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1744155317;
	Mon, 22 Apr 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWt5zZeO"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EB154C16
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811564; cv=none; b=Fb1zcxL1KViZcg9zuffNmGamBm+93IoDBgTvOrpWyiCrfaCCpIXCFzCqqKQ5BgPVdqcU3CtdK9LtaEl/dQY2MZMW/XeJzUWBCVLQRUmgAtFBSM13NCd/2FhdFI4d8SZJz1uV+OruiLFY0GTKVOPaZxG0JgdYfvIJVEfXvXrwL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811564; c=relaxed/simple;
	bh=y+h2p/+Qjtt7fuR0gzA8elRDXm7rpP7BOs6OsJQMO6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPmMt4Wuz4HB8RJK9x+/bBQkk0umvxNmUxBR8lC7d4OBX8DZQxhOxTIREMoPlEExginUTSmvW98KDBhWBIasPwYJX3SxtscAxkqhcE2snLTAn4Mmm0Qz6cdi2TyNSOPKbR3poXkIelwUB9uGIRZVAZMnbC3wQuLfcBa0qmLgAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWt5zZeO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shxVKbrxy0v2vUv3i82PhMPt5LLErwg9JhDZU0P50jE=;
	b=pWt5zZeOPenMoVfzZgrzuunpn8LEQ723Iegz811HQ70v6dG/aKQk1AAohGTaQ/RokzoAPL
	2qHMTmm2eYsxJLs5LP9OkuhC2P7Hv5wz4hWep7fkCTOXssZTh6UoZscXzXzh9xVib3/ftJ
	kCT+A+J5mMOy/rvHAmO/7n00JEnSmUk=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 01/13] drm: xlnx: Store base pointers in zynqmp_disp directly
Date: Mon, 22 Apr 2024 14:45:41 -0400
Message-Id: <20240422184553.3573009-2-sean.anderson@linux.dev>
In-Reply-To: <20240422184553.3573009-1-sean.anderson@linux.dev>
References: <20240422184553.3573009-1-sean.anderson@linux.dev>
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
---

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_disp.c | 44 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 407bc07cec69..94a3ac046373 100644
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


