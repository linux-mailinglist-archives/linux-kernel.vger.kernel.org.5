Return-Path: <linux-kernel+bounces-155661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E58AF54B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA95284E47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46A14290C;
	Tue, 23 Apr 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K94Q1JsR"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F391428E6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892778; cv=none; b=X0yzexacEWFYo17E0W1eZoDhIfq/s3WofRcA6vKsxLJ3UC+BtPne5coKcFz2ImoZrXDWauCLuw4OKyuUCVInPDSG4m1h3soJ0DD/oUs/RQlsFEvtpcnVNhjUq2sMKtjaTcV2yJpkRUMPJzO374yUrXGnzXaBMqgLTdi1z+zvGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892778; c=relaxed/simple;
	bh=14sT4ve1hf4VA7R7SLYTcJV6hUvEdx6n6tiFakm+v5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6Ih54HDzdnm17I9EUupxpMwJj6J4ht/H4HtLK87bilUYhIGjJT9NUZ7KeFGyIa5PmuqymE3787julxVZfg+oU9lPmchs2jsD4JNo627lPEPSIcYEK4l6IkwrAOVWBK7JW7uio7oOHGOvGOhnSqYJJurYjfsgCDPFX461ikSFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K94Q1JsR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU8WVgLiJfT+zG1g0Gek4Quem8lI6e2UFlwZo7xAnnk=;
	b=K94Q1JsRsc16CDjbMOTGnJO/IDJukNvHLRVShoEAsPAwDvZYPLTBSFaqNmTrbNDbj1IPaR
	v+t+dAoVutySLiYRAl2mq6dKi0Wwfp8Ii9Zg2hVkZVLYYd4hdrdo2eeEJ8clz/Hy1OyDYY
	Gzgz92WydoYjW2lQgNu9HQAdrFbG7tY=
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
Subject: [PATCH v4 12/13] drm: zynqmp_dp: Take dp->lock in zynqmp_dp_hpd_work_func
Date: Tue, 23 Apr 2024 13:18:58 -0400
Message-Id: <20240423171859.3953024-13-sean.anderson@linux.dev>
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
index d5ee165046f8..fe002fef4662 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1552,14 +1552,13 @@ static int zynqmp_dp_bridge_atomic_check(struct drm_bridge *bridge,
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
@@ -1588,16 +1587,26 @@ static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *brid
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
@@ -1651,7 +1660,10 @@ static void zynqmp_dp_hpd_work_func(struct work_struct *work)
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


