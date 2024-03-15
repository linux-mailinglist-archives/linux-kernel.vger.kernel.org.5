Return-Path: <linux-kernel+bounces-104978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3087D731
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07F61F22A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC705B5B2;
	Fri, 15 Mar 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KsbOkTNZ"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AC5A0FC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544174; cv=none; b=O9m7aLL5KrRrF3e6BcTb+5dbyZDIyiIhhTq4ragArVp1/Qfqg4tc3wqRaL6f3fU1GKG4L1Ax+BaweavOCeMwPHrDwpsICgsmaBmLdaCjVBMTpvo+x0nyQp+KfPC3urRWCGN9QXcF4EbOzuyj4hGf716KynqwMLcd2QDdJtCQMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544174; c=relaxed/simple;
	bh=wJuj2LnV7wTCORzUWD0e3tl+Zokc0cUCwwvLx8oI67U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXUxG8GKMSJRGTTFUKd5gTJlhrZcCKNcep5spKzqB8W3PypKo+yENVMWkFgwGQMZ7taHO7t5lNvhWpbouz1riAtKInS71GS6q6Za87P1kyCfnKKtEPbNJariIGLZPkietlsqD4Sk9mrUVBDj2Ji69OKmw7sUEu5YTS6DDLh8/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KsbOkTNZ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710544167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2Qeb73E854SLNNqpfgzZuZinTfxWG3SchDvt92uTCI=;
	b=KsbOkTNZiQeegFXVQDpqlUx8jkW8Z7Ir6x2ewKOI/CqJl/7WHHXmvqtOD63M5XhdZ1wOIl
	DZgfnKLuJS9QqhFmPbDKc6x874/8ClrrkRYiYl3uor0Hsyq+9vuNWNA8mq/V+LNmLZUgdh
	yPixMKOSoUVqdH8WGoTZ/mY3F1Gx1MQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/6] drm: zynqmp_dp: Adjust training values per-lane
Date: Fri, 15 Mar 2024 19:09:12 -0400
Message-Id: <20240315230916.1759060-3-sean.anderson@linux.dev>
In-Reply-To: <20240315230916.1759060-1-sean.anderson@linux.dev>
References: <20240315230916.1759060-1-sean.anderson@linux.dev>
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


