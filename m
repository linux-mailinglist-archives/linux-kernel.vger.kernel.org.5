Return-Path: <linux-kernel+bounces-168131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD88BB40D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A002872CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2715990D;
	Fri,  3 May 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9GeCfZQ"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D131598ED
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764591; cv=none; b=nELRVes7JIBaqxEQWAJoXNKbFtke22UhullHsQyd6Ih/KcMIXrk7xhjhlZdeNgtpULZDrkHQgXAsfAwG78TeETdomjXbbJ3ozLlkYgkw0hH3ljxjrQfWuqxJAZu6I+8gO/dBt7CbmX6t6Gx0w4+GLRTyUgrJGSRrx6oayFxv1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764591; c=relaxed/simple;
	bh=aSjAhdSR9LarmwINb9KQ4scksGVrnsC32oUhBbn0efQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q36n53bwrSKAHMXsb7MQvy8JevEKT/BbaPGLTQetpel7sB4CDs3YajzH37d8bmvcKHN1nQVvq0eOM9TSy7sD06UxcuapOZbDoI6q3qy0G0yTdp5+v14VEDw+YKzog71wAGuqjmqzjXdKwMPEHuZwezbIc36vvOgdxvfcf0W2rPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9GeCfZQ; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMD5RVBwkMYmGCgYVDFRWe+ej+oru7pO54GULnyHuDg=;
	b=P9GeCfZQ+aq6eQwIwiuL8gqD9ILBdbJs76oSjeSbPeEcrAEr7aEzmHlYqKkXkKpaJVVXxy
	qLawkl4pev9Px3WUOiK+FLs3cb1W+vTm9nHRDmIqsxxQl44ewLBQIg4Mix4lfSInVo+Pbx
	Y/oMkNMtEf1rMsO9cqlPWe05E8BAaHc=
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
Subject: [PATCH v5 09/10] drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
Date: Fri,  3 May 2024 15:29:21 -0400
Message-Id: <20240503192922.2172314-10-sean.anderson@linux.dev>
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

Add a non-locking version of zynqmp_dp_bridge_detect and use it in
zynqmp_dp_hpd_work_func so we can take the lock explicitly. This will
make it easier to check for hpd_ignore when we add debugfs support.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v3)

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 91767ddbe1ce..6f3792dcac28 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1567,14 +1567,13 @@ static int zynqmp_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
-static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *bridge)
+static enum drm_connector_status __zynqmp_dp_bridge_detect(struct zynqmp_dp *dp)
 {
-	struct zynqmp_dp *dp = bridge_to_dp(bridge);
 	struct zynqmp_dp_link_config *link_config = &dp->link_config;
 	u32 state, i;
 	int ret;
 
-	mutex_lock(&dp->lock);
+	lockdep_assert_held(&dp->lock);
 
 	/*
 	 * This is from heuristic. It takes some delay (ex, 100 ~ 500 msec) to
@@ -1603,16 +1602,26 @@ static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *brid
 					       dp->num_lanes);
 
 		dp->status = connector_status_connected;
-		mutex_unlock(&dp->lock);
 		return connector_status_connected;
 	}
 
 disconnected:
 	dp->status = connector_status_disconnected;
-	mutex_unlock(&dp->lock);
 	return connector_status_disconnected;
 }
 
+static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *bridge)
+{
+	struct zynqmp_dp *dp = bridge_to_dp(bridge);
+	enum drm_connector_status ret;
+
+	mutex_lock(&dp->lock);
+	ret = __zynqmp_dp_bridge_detect(dp);
+	mutex_unlock(&dp->lock);
+
+	return ret;
+}
+
 static const struct drm_edid *zynqmp_dp_bridge_edid_read(struct drm_bridge *bridge,
 							 struct drm_connector *connector)
 {
@@ -1696,7 +1705,10 @@ static void zynqmp_dp_hpd_work_func(struct work_struct *work)
 	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp, hpd_work);
 	enum drm_connector_status status;
 
-	status = zynqmp_dp_bridge_detect(&dp->bridge);
+	mutex_lock(&dp->lock);
+	status = __zynqmp_dp_bridge_detect(dp);
+	mutex_unlock(&dp->lock);
+
 	drm_bridge_hpd_notify(&dp->bridge, status);
 }
 
-- 
2.35.1.1320.gc452695387.dirty


