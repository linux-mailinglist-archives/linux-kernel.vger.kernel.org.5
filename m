Return-Path: <linux-kernel+bounces-153860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9268AD443
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FEF283163
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C783155A39;
	Mon, 22 Apr 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kZuQ4Ylo"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008CE15572B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811570; cv=none; b=AAujn9osjL0NvU4YzxuwLv5vvrHHAsqP7EhL6rFnJn+1fFPYpbKzSE4GoCS+RYxAmOGSKmqSiXgniPYs26XB/3kU9s3PgBEBanA9fYmbux3hP1cCz3IFDrgaqttgktUx441TwkfneilI3VOj5SCH1Rp+WyrLFGha+p6O8ACIUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811570; c=relaxed/simple;
	bh=ZCJNB35wygvJm4ZdpNB7+Vnq3rPQcMK2kkpJ5I9upe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfCb+bFDl9ZpN60wKamijkx3mxfuSbhXD3bbQxXW50YhQPw92mK6EOW35o0pB5BoeskLqpDXBz45eYK/+EtTti2d2dNHcX/DhOWo3Oh0EVoRQNzCB4UEuBM6uyuHeT8IZ2koecunnexabd4ATuGBahjz6Z+J1HM76taoHpDyIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kZuQ4Ylo; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nrF6VDUIPcZsD4wFuWM8MT9Kja3bZUkY7wxu3RiboM=;
	b=kZuQ4YloMXzcrRf5AwuW90zYmaJssVI9kiPfHyL5pMj6/RZUXG2W0id0oXFxJlKM5g6B4L
	Ql50xuUwcVdsqEHwSsm3g//Puz9ZlB54vosZZZ4nuy4Rzq1SFttnqOqolRdjjYIaEM4aay
	dUg61JMc6w1fZ75GUosIdRn7YLQ8DVg=
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
	Sean Anderson <sean.anderson@linux.dev>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 04/13] drm: zynqmp_dp: Adjust training values per-lane
Date: Mon, 22 Apr 2024 14:45:44 -0400
Message-Id: <20240422184553.3573009-5-sean.anderson@linux.dev>
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

The feedback we get from the DPRX is per-lane. Make changes using this
information, instead of picking the maximum values from all lanes. This
results in more-consistent training on marginal links.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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


