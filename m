Return-Path: <linux-kernel+bounces-108205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C66880777
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BB6B22334
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221FD604A3;
	Tue, 19 Mar 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMzjesS1"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F260250
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888710; cv=none; b=D0ZodjP41Fbj/Edexj3cXZD36fajhv7BchG8N26LDNvhmKz4IhlbmMdp7tm4COIsRVW1/Fmq84TcJLqynlzPEi+8AKSWiJFEcZ4UiuhzW6NnQDWSJIObn8d/2AKejluTYu7Sa6T424bAwT+zAyndr2MEwBA5X9XehEm263icfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888710; c=relaxed/simple;
	bh=s64Pf1BLDbOpOL2f4d7AToLS9pNdSyVcToFfD9BN+Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PoaVCsUW6pyw3FI4G17O6EogSGTLkuA56gGW0lGmV3j/rB3c7QPMaI1ZjY46SJMTuSe1A4uuwX9KlEWWktPLw8NWaDNDzeMzyXdo0UPielUCuCQjED6Xhf8P+F3iNEwstje+nquN8IO2d+mWpBhAs+TrzC5xceq/0shnZT50t9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMzjesS1; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710888706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyA1pp/Og9a0uR7KxvRUeBHWPGqjk6cC2yqaXPFBa2g=;
	b=OMzjesS1g9SgReAooXmXRO+rEeJVZZbO6Fw4R7WVyiz+Aa9xbBeLmtWXnAt5W4EGrFHIuc
	ZcKCCp5Hx1RcmuU3fc+KSCRCbJ+N7vMEMGQiXQsM7vz/qA90NBCUbHwtOSe5SWcia4bzV1
	DhIc4OJlMAb1g4JIKmfOCdsLzRRijLI=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Michal Simek <michal.simek@amd.com>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 5/8] drm: zynqmp_dp: Don't retrain the link in our IRQ
Date: Tue, 19 Mar 2024 18:51:18 -0400
Message-Id: <20240319225122.3048400-6-sean.anderson@linux.dev>
In-Reply-To: <20240319225122.3048400-1-sean.anderson@linux.dev>
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Retraining the link can take a while, and might involve waiting for
DPCD reads/writes to complete. This is inappropriate for an IRQ handler.
Just schedule this work for later completion. This is racy, but will be
fixed in the next commit.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Actually, on second look this IRQ is threaded. So why do we have a
workqueue for HPD events? Maybe we should make it unthreaded?

Changes in v2:
- Document hpd_irq_work
- Split this off from the lcoking changes

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 43 ++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index f1834c8e3c02..f3fcdbf662fa 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -287,6 +287,7 @@ struct zynqmp_dp_config {
  * @phy: PHY handles for DP lanes
  * @num_lanes: number of enabled phy lanes
  * @hpd_work: hot plug detection worker
+ * @hpd_irq_work: hot plug detection IRQ worker
  * @status: connection status
  * @enabled: flag to indicate if the device is enabled
  * @dpcd: DP configuration data from currently connected sink device
@@ -298,6 +299,7 @@ struct zynqmp_dp {
 	struct drm_dp_aux aux;
 	struct drm_bridge bridge;
 	struct delayed_work hpd_work;
+	struct delayed_work hpd_irq_work;
 
 	struct drm_bridge *next_bridge;
 	struct device *dev;
@@ -1611,6 +1613,27 @@ static void zynqmp_dp_hpd_work_func(struct work_struct *work)
 	drm_bridge_hpd_notify(&dp->bridge, status);
 }
 
+static void zynqmp_dp_hpd_irq_work_func(struct work_struct *work)
+{
+	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp,
+					    hpd_irq_work.work);
+	u8 status[DP_LINK_STATUS_SIZE + 2];
+	int err;
+
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
+}
+
 static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 {
 	struct zynqmp_dp *dp = (struct zynqmp_dp *)data;
@@ -1635,23 +1658,9 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 	if (status & ZYNQMP_DP_INT_HPD_EVENT)
 		schedule_delayed_work(&dp->hpd_work, 0);
 
-	if (status & ZYNQMP_DP_INT_HPD_IRQ) {
-		int ret;
-		u8 status[DP_LINK_STATUS_SIZE + 2];
+	if (status & ZYNQMP_DP_INT_HPD_IRQ)
+		schedule_delayed_work(&dp->hpd_irq_work, 0);
 
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
 
@@ -1676,6 +1685,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	dp->status = connector_status_disconnected;
 
 	INIT_DELAYED_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
+	INIT_DELAYED_WORK(&dp->hpd_irq_work, zynqmp_dp_hpd_irq_work_func);
 
 	/* Acquire all resources (IOMEM, IRQ and PHYs). */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dp");
@@ -1775,6 +1785,7 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
 	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, ZYNQMP_DP_INT_ALL);
 	disable_irq(dp->irq);
 
+	cancel_delayed_work_sync(&dp->hpd_irq_work);
 	cancel_delayed_work_sync(&dp->hpd_work);
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_TRANSMITTER_ENABLE, 0);
-- 
2.35.1.1320.gc452695387.dirty


