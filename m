Return-Path: <linux-kernel+bounces-153862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0B8AD445
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A38E1F23694
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1C155357;
	Mon, 22 Apr 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="servLFDU"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12387156242
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811574; cv=none; b=JSx8Jdl5C7Z5C5ttMSWSNosLbOq5pQ+aM1SR0naZ28oKm58gCcAh67HINF4SkJyydGRPuOcXZLoKwhIbXKcFTcgXMz/5MRgytlj+iSivw/LV5McvxZI55HjQRhw4QU5MLpKM4LaqqqNTgQV/k6oje9l9Wmgv4ou+nnPvZgZIBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811574; c=relaxed/simple;
	bh=+cIgK4PCNNa+j8g4XKaog16EGRfZoCwc4qRucuuX1s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bkam//qA/rlWN54beX+5N45ILuE8IZobg0ZcdCEyAgSLkJ8/gr7svx8YyD4X4HzUqCOnFYMdAblXZJV8fhIXeZ5rjnvGyOjdaRdgPTGplPrZwVexPccw347Kk3K7InlO7Q+yLldYv/AM3nGKZ2cLAfid2YKFvHJ/jGZvp59BZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=servLFDU; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NI0m4lC2BWpjmQO+TPEk0xEnUCWor0+eWEstT4DfQ4=;
	b=servLFDUgpS8K+61Q7er51bw7Gt6zK/MywpeArZwTkgFtb1joNWycGQl/toNdKfuaa9OWH
	Yecup2QdU4+h6VRqTn29rmn8Y4tspyyI/aSkkeQMJek2YyYfEaHiCflLEbtnxMp9kyQIiY
	bkSSPRsiSkZJroLnnRwFasqDoSrJvF4=
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
Subject: [PATCH v3 06/13] drm: zynqmp_dp: Don't delay work
Date: Mon, 22 Apr 2024 14:45:46 -0400
Message-Id: <20240422184553.3573009-7-sean.anderson@linux.dev>
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

We always call scheduled_delayed_work with no delay, so just use a
non-delayed work_struct instead.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index f1834c8e3c02..59fed00a8f89 100644
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
@@ -1633,7 +1632,7 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 		zynqmp_dpsub_drm_handle_vblank(dp->dpsub);
 
 	if (status & ZYNQMP_DP_INT_HPD_EVENT)
-		schedule_delayed_work(&dp->hpd_work, 0);
+		schedule_work(&dp->hpd_work);
 
 	if (status & ZYNQMP_DP_INT_HPD_IRQ) {
 		int ret;
@@ -1675,7 +1674,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	dp->dpsub = dpsub;
 	dp->status = connector_status_disconnected;
 
-	INIT_DELAYED_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
+	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
 
 	/* Acquire all resources (IOMEM, IRQ and PHYs). */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dp");
@@ -1775,7 +1774,7 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
 	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, ZYNQMP_DP_INT_ALL);
 	disable_irq(dp->irq);
 
-	cancel_delayed_work_sync(&dp->hpd_work);
+	cancel_work_sync(&dp->hpd_work);
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_TRANSMITTER_ENABLE, 0);
 	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, 0xffffffff);
-- 
2.35.1.1320.gc452695387.dirty


