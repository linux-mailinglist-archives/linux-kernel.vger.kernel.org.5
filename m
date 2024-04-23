Return-Path: <linux-kernel+bounces-155655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0E8AF545
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725C2284C31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623E140394;
	Tue, 23 Apr 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VLbmrNLY"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734B13FD74
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892765; cv=none; b=YzfOcUHUOQdVhYqNP7zmghJHSF6/1KxFbi+G6zmMt/rc1tibitUwNhaL5P0m/rRKt5dGXfwZS6ZvSDfs6di9cYi4oDuaIpDQVqOpMcm135yHCqgrBqM2SMcI2doa+esNglfsxLZNXVTLd97xR54k3uTRrrTZ87yAEbee+YimHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892765; c=relaxed/simple;
	bh=j/aakZAfwNtKlY58Q60VEOxkuw96ArnaqrKNW6GQqng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDY9yGN5t2fbxlMvncscTAfHMEw7T6Ih74Gd90DtdSoLFMks2ZrWfD3AdPhADW5Rix17X5OJz3tnJXlwMxrGZl2BgTFX0WrbRwoBIya/OSTsZOZ6lMSc7fEqY3YX2qj2wDVg5dBd3htW1vaDu2ILXhV53weFKciT34PZvsFR9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VLbmrNLY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCz+6XLojO+MPGTMqhwztwipCrwsZS62Wdjup5FevaE=;
	b=VLbmrNLYYvbkNZIctGYSRswQWspGRX8XmtOAsS7hVIlYdmYls5m0dgzRWzgkkP8MH2hQC7
	NAMU7cVHZe6jMP88jkoyPjYQbZLCa+Gxy/VLIS5XDSL+NA9BC9wcqsyb1sHkRgaPbv4TZi
	KvCJO9+fzxnQ9XhAAR3WpYHrQAOc1HY=
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
Subject: [PATCH v4 06/13] drm: zynqmp_dp: Don't delay work
Date: Tue, 23 Apr 2024 13:18:52 -0400
Message-Id: <20240423171859.3953024-7-sean.anderson@linux.dev>
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

We always call scheduled_delayed_work with no delay, so just use a
non-delayed work_struct instead.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

(no changes since v3)

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 6e8478d58b02..677db546169f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -297,7 +297,7 @@ struct zynqmp_dp_config {
 struct zynqmp_dp {
 	struct drm_dp_aux aux;
 	struct drm_bridge bridge;
-	struct delayed_work hpd_work;
+	struct work_struct hpd_work;
 
 	struct drm_bridge *next_bridge;
 	struct device *dev;
@@ -1467,7 +1467,7 @@ static void zynqmp_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 	struct zynqmp_dp *dp = bridge_to_dp(bridge);
 
 	dp->enabled = false;
-	cancel_delayed_work(&dp->hpd_work);
+	cancel_work(&dp->hpd_work);
 	zynqmp_dp_write(dp, ZYNQMP_DP_MAIN_STREAM_ENABLE, 0);
 	drm_dp_dpcd_writeb(&dp->aux, DP_SET_POWER, DP_SET_POWER_D3);
 	zynqmp_dp_write(dp, ZYNQMP_DP_TX_PHY_POWER_DOWN,
@@ -1603,8 +1603,7 @@ void zynqmp_dp_disable_vblank(struct zynqmp_dp *dp)
 
 static void zynqmp_dp_hpd_work_func(struct work_struct *work)
 {
-	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp,
-					    hpd_work.work);
+	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp, hpd_work);
 	enum drm_connector_status status;
 
 	status = zynqmp_dp_bridge_detect(&dp->bridge);
@@ -1640,7 +1639,7 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 		zynqmp_dpsub_drm_handle_vblank(dp->dpsub);
 
 	if (status & ZYNQMP_DP_INT_HPD_EVENT)
-		schedule_delayed_work(&dp->hpd_work, 0);
+		schedule_work(&dp->hpd_work);
 
 	if (status & ZYNQMP_DP_INT_HPD_IRQ) {
 		int ret;
@@ -1682,7 +1681,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	dp->dpsub = dpsub;
 	dp->status = connector_status_disconnected;
 
-	INIT_DELAYED_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
+	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
 
 	/* Acquire all resources (IOMEM, IRQ and PHYs). */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dp");
@@ -1787,7 +1786,7 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
 	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, ZYNQMP_DP_INT_ALL);
 	disable_irq(dp->irq);
 
-	cancel_delayed_work_sync(&dp->hpd_work);
+	cancel_work_sync(&dp->hpd_work);
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_TRANSMITTER_ENABLE, 0);
 	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, 0xffffffff);
-- 
2.35.1.1320.gc452695387.dirty


