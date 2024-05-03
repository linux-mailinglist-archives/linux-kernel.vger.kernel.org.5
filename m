Return-Path: <linux-kernel+bounces-168124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 672F38BB406
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986FA1C21647
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5317158DAA;
	Fri,  3 May 2024 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mVTrx/ik"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1778158D67
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764577; cv=none; b=RFpmnFN5Fgc1nO2vw0DX1YIhMqgecbxDIBeq+jpYwWEZc/0c4zQ0FZpH5mg4G7/4F7RbUNiUruTVP9rqb1EzkWXuxrAfnEQkArVXbPzxLMu2BxWlpXZJQh/ni4lYFpNfOUVMK6IoSbseEvVcxDa3bA39An6nDVZfix61dozBIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764577; c=relaxed/simple;
	bh=NJxnVi08whsfcF8Fiov15N74TeOxpeiPHKcpUCUPy0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PNd/zkVL4RiiKbkXtgtijZdU3Jt8w5WY9aVOo6oE2MWNi1kMWUick1hiJIzfqLWlNBkB+OaZVHTcB2jPZjVYtQn5zw03okbDZYQ6d0LdeU6yNbPx7AcDRjgZUDf8VqSDQpuYbyjYpM8QY5sMmIHZdkwEkSoZeaBGC6gYCbnDn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mVTrx/ik; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uW0i6eKUrBGaUvxjIkM6lg53QGjldQQ1lSdwdv3i8U=;
	b=mVTrx/ikZydOv8ki7W+nLR4D9MohHoKt3cfOtgZgT4xSPbmf3TbSjKCsubg/g0PEnPlnKk
	jp84fh9eZoLimWGUTqDNIAdmGg8ECbdRKDJlhgktLvT1JFc27UllVs8ufGEf9pwnHUz1Yb
	dGPP/ywuHRfutJ96NkWzDRUq42cguFk=
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
Subject: [PATCH v5 02/10] drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
Date: Fri,  3 May 2024 15:29:14 -0400
Message-Id: <20240503192922.2172314-3-sean.anderson@linux.dev>
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
index 9df068a413f3..12a8248ed125 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -256,10 +256,10 @@ struct zynqmp_dp_link_config {
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
@@ -296,27 +296,27 @@ struct zynqmp_dp_config {
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


