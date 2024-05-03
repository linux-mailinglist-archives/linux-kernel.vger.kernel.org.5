Return-Path: <linux-kernel+bounces-168126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18598BB408
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186681F257C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5531591E4;
	Fri,  3 May 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TS3G3Xdy"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024C158A12
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764581; cv=none; b=p54/HKElazMf3F49xR+fZq19ZcsBxmITxddA3pQB9Pa24hmGkBLmozwl8Zuh1A2PP5jukJuXQSk9TyzjRX/EmOvgOo5ie3KBdWJg6ey4g5cJDJJPBsDFlaYpZp9BURSMvozr42BY4SaqA2GSi7KHgfSmRnX7QADyIgh4nKlUI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764581; c=relaxed/simple;
	bh=9GH8dd6Q1rS60og/Ou29NLpQfxk9EW9ZPhM8wZt55OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqQUITrDjWC+HDzGSroHBLWhe8UnXRMSovFn8k8uO0R8wngNdD2hS+IaJDMZ0Yx0AqZYILE/kkrjd8IKFyNi436QOnOkvcxsNlKR7MCvsSl1tRwSGitGjROs5ABsY+skRR05TtLD6OoJdumkfdlLnGV/IuHPC3BOUJ9VLextHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TS3G3Xdy; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oK3GkwlYIbgKa5E/wcr/BC9b4B3l2udsFuim2xq4G6g=;
	b=TS3G3XdyTPJR1owLMSUwl7i9kGX6OjJbNax2Dxc8+j06khI1KmzalwpZ7PIP7D6WVT3KaY
	JLmKFWp/2dWLtMQbTet/n8zP9ezmyHtXztYNeWaNHu6lacNT0sUyKXRBv5Hnkkh2El6iIv
	jdc9Zm45NheXtDVG/eJ9J8PoKfa+i/Q=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v5 04/10] drm: zynqmp_dp: Add locking
Date: Fri,  3 May 2024 15:29:16 -0400
Message-Id: <20240503192922.2172314-5-sean.anderson@linux.dev>
In-Reply-To: <20240503192922.2172314-1-sean.anderson@linux.dev>
References: <20240503192922.2172314-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add some locking to prevent the IRQ/workers/bridge API calls from stepping
on each other's toes. This lock protects:

- Non-atomic registers configuring the link. That is, everything but the
  IRQ registers (since these are accessed in an atomic fashion), and the DP
  AUX registers (since these don't affect the link). We also access AUX
  while holding this lock, so it would be very tricky to support.
- Link configuration. This is effectively everything in zynqmp_dp which
  isn't read-only after probe time. So from next_bridge onward.

This lock is designed to protect configuration changes so we don't have to
do anything tricky. Configuration should never be in the hot path, so I'm
not worried about performance.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v2)

Changes in v2:
- Split off the HPD IRQ work into another commit
- Expand the commit message

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 129beac4c073..abfccd8bb5a7 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -280,6 +280,7 @@ struct zynqmp_dp_config {
  * @dpsub: Display subsystem
  * @iomem: device I/O memory for register access
  * @reset: reset controller
+ * @lock: Mutex protecting this struct and register access (but not AUX)
  * @irq: irq
  * @bridge: DRM bridge for the DP encoder
  * @next_bridge: The downstream bridge
@@ -294,11 +295,16 @@ struct zynqmp_dp_config {
  * @link_config: common link configuration between IP core and sink device
  * @mode: current mode between IP core and sink device
  * @train_set: set of training data
+ *
+ * @lock covers the link configuration in this struct and the device's
+ * registers. It does not cover @aux. It is not strictly required for any of
+ * the members which are only modified at probe/remove time (e.g. @dev).
  */
 struct zynqmp_dp {
 	struct drm_dp_aux aux;
 	struct drm_bridge bridge;
 	struct work_struct hpd_work;
+	struct mutex lock;
 
 	struct drm_bridge *next_bridge;
 	struct device *dev;
@@ -1386,8 +1392,10 @@ zynqmp_dp_bridge_mode_valid(struct drm_bridge *bridge,
 	}
 
 	/* Check with link rate and lane count */
+	mutex_lock(&dp->lock);
 	rate = zynqmp_dp_max_rate(dp->link_config.max_rate,
 				  dp->link_config.max_lanes, dp->config.bpp);
+	mutex_unlock(&dp->lock);
 	if (mode->clock > rate) {
 		dev_dbg(dp->dev, "filtered mode %s for high pixel rate\n",
 			mode->name);
@@ -1414,6 +1422,7 @@ static void zynqmp_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 
 	pm_runtime_get_sync(dp->dev);
 
+	mutex_lock(&dp->lock);
 	zynqmp_dp_disp_enable(dp, old_bridge_state);
 
 	/*
@@ -1474,6 +1483,7 @@ static void zynqmp_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 	zynqmp_dp_write(dp, ZYNQMP_DP_SOFTWARE_RESET,
 			ZYNQMP_DP_SOFTWARE_RESET_ALL);
 	zynqmp_dp_write(dp, ZYNQMP_DP_MAIN_STREAM_ENABLE, 1);
+	mutex_unlock(&dp->lock);
 }
 
 static void zynqmp_dp_bridge_atomic_disable(struct drm_bridge *bridge,
@@ -1481,6 +1491,7 @@ static void zynqmp_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 {
 	struct zynqmp_dp *dp = bridge_to_dp(bridge);
 
+	mutex_lock(&dp->lock);
 	dp->enabled = false;
 	cancel_work(&dp->hpd_work);
 	zynqmp_dp_write(dp, ZYNQMP_DP_MAIN_STREAM_ENABLE, 0);
@@ -1491,6 +1502,7 @@ static void zynqmp_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 		zynqmp_dp_write(dp, ZYNQMP_DP_TX_AUDIO_CONTROL, 0);
 
 	zynqmp_dp_disp_disable(dp, old_bridge_state);
+	mutex_unlock(&dp->lock);
 
 	pm_runtime_put_sync(dp->dev);
 }
@@ -1533,6 +1545,8 @@ static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *brid
 	u32 state, i;
 	int ret;
 
+	mutex_lock(&dp->lock);
+
 	/*
 	 * This is from heuristic. It takes some delay (ex, 100 ~ 500 msec) to
 	 * get the HPD signal with some monitors.
@@ -1560,11 +1574,13 @@ static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *brid
 					       dp->num_lanes);
 
 		dp->status = connector_status_connected;
+		mutex_unlock(&dp->lock);
 		return connector_status_connected;
 	}
 
 disconnected:
 	dp->status = connector_status_disconnected;
+	mutex_unlock(&dp->lock);
 	return connector_status_disconnected;
 }
 
@@ -1725,6 +1741,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	dp->dev = &pdev->dev;
 	dp->dpsub = dpsub;
 	dp->status = connector_status_disconnected;
+	mutex_init(&dp->lock);
 
 	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
 
@@ -1838,4 +1855,5 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
 
 	zynqmp_dp_phy_exit(dp);
 	zynqmp_dp_reset(dp, true);
+	mutex_destroy(&dp->lock);
 }
-- 
2.35.1.1320.gc452695387.dirty


