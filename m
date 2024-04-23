Return-Path: <linux-kernel+bounces-155654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D282E8AF544
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11829B2390A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21BB13FD6E;
	Tue, 23 Apr 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rxNWsgdQ"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6113E8BE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892763; cv=none; b=TtigPXP0JECPB59UC5/6cRStoZU19VEg+iyaxnPCu2uuI+77/zz5b85fjwPghoVSUnXJAPld3ewSI7M/xepexHABFLaOyCRyNbkFonSgBqh6iHlaOxIHGfgG7PMQBQPSJAymfbSYwrkLyxc97ue4vo77tlHLzsI4jE1WwwfSP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892763; c=relaxed/simple;
	bh=ecUQRsM99KEZqVXhAbhY0JNaLKztzKm4innXl9K6a68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KeGB/STTaaU13sf4ThiG1oh7DLL4tmVI1lpolPuWJ0VJMcaqgloXIxXUTrHm98UKHqjvWpDTMB8KCiy9fiVLtRBCekzwFgw2P6dznR0kUXYt4YC2uLZOnURBesg3VHy5jnnfzaLEUxN3mbP25DM+AOK4UEM7FLk8SSLBSjf1FXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rxNWsgdQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HJSpnsUQWd8IMTpbh+5xqR3e7YIet2kA5NKuz6pQyk=;
	b=rxNWsgdQki30F7wRtTp3wbNzHaRRnL7rV+HeIcDVpBkiD00gzSouvS68EwsZwNxHmOR0eg
	ymZeYahD/lPKbJFeu0WvucF6487YzljRe4pai6nw7uoXotcWHfZ6uf6+Iy7+Nwuf1dRYGk
	Y1uXAJluI6Zcgh/0qZzSQ0Nm8frnqhM=
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
Subject: [PATCH v4 05/13] drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
Date: Tue, 23 Apr 2024 13:18:51 -0400
Message-Id: <20240423171859.3953024-6-sean.anderson@linux.dev>
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

Sort the members of struct zynqmp_dp to reduce padding necessary for
alignment.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v2)

Changes in v2:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 79afe4358d06..6e8478d58b02 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -255,10 +255,10 @@ struct zynqmp_dp_link_config {
  * @fmt: format identifier string
  */
 struct zynqmp_dp_mode {
-	u8 bw_code;
-	u8 lane_cnt;
-	int pclock;
 	const char *fmt;
+	int pclock;
+	u8 bw_code;
+	u8 lane_cnt;
 };
 
 /**
@@ -295,27 +295,27 @@ struct zynqmp_dp_config {
  * @train_set: set of training data
  */
 struct zynqmp_dp {
+	struct drm_dp_aux aux;
+	struct drm_bridge bridge;
+	struct delayed_work hpd_work;
+
+	struct drm_bridge *next_bridge;
 	struct device *dev;
 	struct zynqmp_dpsub *dpsub;
 	void __iomem *iomem;
 	struct reset_control *reset;
-	int irq;
-
-	struct drm_bridge bridge;
-	struct drm_bridge *next_bridge;
-
-	struct zynqmp_dp_config config;
-	struct drm_dp_aux aux;
 	struct phy *phy[ZYNQMP_DP_MAX_LANES];
-	u8 num_lanes;
-	struct delayed_work hpd_work;
+
 	enum drm_connector_status status;
+	int irq;
 	bool enabled;
 
-	u8 dpcd[DP_RECEIVER_CAP_SIZE];
-	struct zynqmp_dp_link_config link_config;
 	struct zynqmp_dp_mode mode;
+	struct zynqmp_dp_link_config link_config;
+	struct zynqmp_dp_config config;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	u8 train_set[ZYNQMP_DP_MAX_LANES];
+	u8 num_lanes;
 };
 
 static inline struct zynqmp_dp *bridge_to_dp(struct drm_bridge *bridge)
-- 
2.35.1.1320.gc452695387.dirty


