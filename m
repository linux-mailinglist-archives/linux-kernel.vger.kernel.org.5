Return-Path: <linux-kernel+bounces-168127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A1C8BB409
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C831F23073
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321E1591FE;
	Fri,  3 May 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEtuohbx"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66915158DDB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764582; cv=none; b=cmsMrzjzJpv/b1fVbU6lvwE268f1BGMAwMCV78uF+NkEiYBvKUaV5dpzi2ZoEQDMY4PdXbpxjKtUxHEGY9++g1s3hySEcq6krVXfwGCpMmJC/+SZiPhb3OJTIZr58TdIIyGIRmXVwxskhdUTmGK52ze5KVO6TuNoCn+xjmoFDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764582; c=relaxed/simple;
	bh=x+wSYNOqgr2hFIz9pBmvTXxnW1v3NMXXowtHGap2lh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMR+WfxXZahtnDQ3YRcsxvTGvTwQWszHwEDM8Bo8NU0i9dOqQ8CzLUVw1a3SX1hR4PPZBiWLiwyHtW/LQVILy8o8o7B2JcngM3jVsi6+r+KzBlpe4nySn8dpH17sx2+lTZyaamSFGTTYexeRot9rj3umxj/uf27VE6LA4slmnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wEtuohbx; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/KsopdPTSQejykMzz4/KUwl6vzi9Fn3LMN3IMFqYkw=;
	b=wEtuohbxJycDDWCyWQE8bx2DRSgStlSDcz2LBVttsise9p1cK/rFnPG0OkG5G3pnUqIttZ
	agtZMAF1Cxrdz8D4pXP4jZrKawVpMv0+Yk7msZX7etzJZeojwyaOAM6mpRfs1UUm2xB9ZM
	lhEH27p7DHq6qRQV1zTNCP9jDLi+LnE=
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
Subject: [PATCH v5 05/10] drm: zynqmp_dp: Don't retrain the link in our IRQ
Date: Fri,  3 May 2024 15:29:17 -0400
Message-Id: <20240503192922.2172314-6-sean.anderson@linux.dev>
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

Retraining the link can take a while, and might involve waiting for
DPCD reads/writes to complete. In preparation for unthreading the IRQ
handler, move this into its own work function.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v2)

Changes in v2:
- Document hpd_irq_work
- Split this off from the locking changes

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 45 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index abfccd8bb5a7..cec5711c7026 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -289,6 +289,7 @@ struct zynqmp_dp_config {
  * @phy: PHY handles for DP lanes
  * @num_lanes: number of enabled phy lanes
  * @hpd_work: hot plug detection worker
+ * @hpd_irq_work: hot plug detection IRQ worker
  * @status: connection status
  * @enabled: flag to indicate if the device is enabled
  * @dpcd: DP configuration data from currently connected sink device
@@ -304,6 +305,7 @@ struct zynqmp_dp {
 	struct drm_dp_aux aux;
 	struct drm_bridge bridge;
 	struct work_struct hpd_work;
+	struct work_struct hpd_irq_work;
 	struct mutex lock;
 
 	struct drm_bridge *next_bridge;
@@ -1671,6 +1673,29 @@ static void zynqmp_dp_hpd_work_func(struct work_struct *work)
 	drm_bridge_hpd_notify(&dp->bridge, status);
 }
 
+static void zynqmp_dp_hpd_irq_work_func(struct work_struct *work)
+{
+	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp,
+					    hpd_irq_work);
+	u8 status[DP_LINK_STATUS_SIZE + 2];
+	int err;
+
+	mutex_lock(&dp->lock);
+	err = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, status,
+			       DP_LINK_STATUS_SIZE + 2);
+	if (err < 0) {
+		dev_dbg_ratelimited(dp->dev,
+				    "could not read sink status: %d\n", err);
+	} else {
+		if (status[4] & DP_LINK_STATUS_UPDATED ||
+		    !drm_dp_clock_recovery_ok(&status[2], dp->mode.lane_cnt) ||
+		    !drm_dp_channel_eq_ok(&status[2], dp->mode.lane_cnt)) {
+			zynqmp_dp_train_loop(dp);
+		}
+	}
+	mutex_unlock(&dp->lock);
+}
+
 static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 {
 	struct zynqmp_dp *dp = (struct zynqmp_dp *)data;
@@ -1702,23 +1727,9 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 	if (status & ZYNQMP_DP_INT_HPD_EVENT)
 		schedule_work(&dp->hpd_work);
 
-	if (status & ZYNQMP_DP_INT_HPD_IRQ) {
-		int ret;
-		u8 status[DP_LINK_STATUS_SIZE + 2];
+	if (status & ZYNQMP_DP_INT_HPD_IRQ)
+		schedule_work(&dp->hpd_irq_work);
 
-		ret = drm_dp_dpcd_read(&dp->aux, DP_SINK_COUNT, status,
-				       DP_LINK_STATUS_SIZE + 2);
-		if (ret < 0)
-			goto handled;
-
-		if (status[4] & DP_LINK_STATUS_UPDATED ||
-		    !drm_dp_clock_recovery_ok(&status[2], dp->mode.lane_cnt) ||
-		    !drm_dp_channel_eq_ok(&status[2], dp->mode.lane_cnt)) {
-			zynqmp_dp_train_loop(dp);
-		}
-	}
-
-handled:
 	return IRQ_HANDLED;
 }
 
@@ -1744,6 +1755,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	mutex_init(&dp->lock);
 
 	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
+	INIT_WORK(&dp->hpd_irq_work, zynqmp_dp_hpd_irq_work_func);
 
 	/* Acquire all resources (IOMEM, IRQ and PHYs). */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dp");
@@ -1848,6 +1860,7 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
 	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, ZYNQMP_DP_INT_ALL);
 	disable_irq(dp->irq);
 
+	cancel_work_sync(&dp->hpd_irq_work);
 	cancel_work_sync(&dp->hpd_work);
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_TRANSMITTER_ENABLE, 0);
-- 
2.35.1.1320.gc452695387.dirty


