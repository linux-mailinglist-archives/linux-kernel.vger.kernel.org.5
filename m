Return-Path: <linux-kernel+bounces-108202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2DA880770
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902351F2336F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BC65FDBD;
	Tue, 19 Mar 2024 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LN8mrOGd"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6E5FB97
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888705; cv=none; b=HmEEt+JNCTrACBzem133k/WpYXpR8MewwcJ9Q/VKXL1sOV0Dgu8YH851E/3FLtfpACANiMXWkSIJhOz76PlopFvGZQVHLxwukDP0CM1kcjOSmNXkd88Kh48ImLoKYaWoMZt3p6Fw/H644JvLzZQ7+JKQ3IFLX37UzFYXoZ3yA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888705; c=relaxed/simple;
	bh=MWuTKfjHkHaCEukGyzuOT0/yJ2QmwbAVkuQmjpVP8YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uILqeZ6AjKFK0zJU80p5mCaMF3AzzWMljOMCBYyJEJfdZb7ORyG+54u2G3b3fKvMg3ZBeNiraKcUIXmhcHQgshtjWBB6VBw3U2Yseq/nzH7vWJgUtT0HIsnnrDjFAZUd7IfCb6fJpAVmxrIVlW+RoYqFO/z4vshood5WDBKFr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LN8mrOGd; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710888702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6urapeaZnHdW/DTzeHEHFd6f+TsIuajmiHq4Eb1FjY=;
	b=LN8mrOGdATpuIA+XTvh2wePemRSNcyWEJNCGn+sZpgJEsunJhvJDNJukRMB2ru8j/QBufY
	YiswVT4xw+wAzZencVWtu2RBLy8YbBprJPHn/MNxZ8NK6uxX6ZAG+XiS+29JjbAV5jeAx8
	p/T1eE95awqHrt34Vq1WgHpqYtySunE=
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
Subject: [PATCH v2 3/8] drm: zynqmp_dp: Adjust training values per-lane
Date: Tue, 19 Mar 2024 18:51:16 -0400
Message-Id: <20240319225122.3048400-4-sean.anderson@linux.dev>
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

The feedback we get from the DPRX is per-lane. Make changes using this
information, instead of picking the maximum values from all lanes. This
results in more-consistent training on marginal links.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 98a32e6a0459..8635b5673386 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -605,28 +605,21 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
 				   u8 link_status[DP_LINK_STATUS_SIZE])
 {
 	u8 *train_set = dp->train_set;
-	u8 voltage = 0, preemphasis = 0;
 	u8 i;
 
 	for (i = 0; i < dp->mode.lane_cnt; i++) {
-		u8 v = drm_dp_get_adjust_request_voltage(link_status, i);
-		u8 p = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		u8 voltage = drm_dp_get_adjust_request_voltage(link_status, i);
+		u8 preemphasis =
+			drm_dp_get_adjust_request_pre_emphasis(link_status, i);
 
-		if (v > voltage)
-			voltage = v;
+		if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
+			voltage |= DP_TRAIN_MAX_SWING_REACHED;
 
-		if (p > preemphasis)
-			preemphasis = p;
-	}
+		if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
+			preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
 
-	if (voltage >= DP_TRAIN_VOLTAGE_SWING_LEVEL_3)
-		voltage |= DP_TRAIN_MAX_SWING_REACHED;
-
-	if (preemphasis >= DP_TRAIN_PRE_EMPH_LEVEL_2)
-		preemphasis |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
-
-	for (i = 0; i < dp->mode.lane_cnt; i++)
 		train_set[i] = voltage | preemphasis;
+	}
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


