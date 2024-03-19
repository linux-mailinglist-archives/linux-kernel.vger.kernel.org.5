Return-Path: <linux-kernel+bounces-108203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B280D880772
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB5284445
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8AD60253;
	Tue, 19 Mar 2024 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="seV259zX"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573325FDB0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888708; cv=none; b=Rjq9GuxXDtw6MFKi4wQQj9zEn3eG6ov2LQaYeaLH5Eu6LZHQZvz6iwPZWA7MiY/Lal/89nvsgVQ04Un9Nv3UEUG2vB/y6k2RnTCL88LimYHaNUC8p6nJh25EV6ss4bSTFuIAYHnaJui9cEsLDWmml11K5W1RX71mEl7BvMaSMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888708; c=relaxed/simple;
	bh=A9tHoVn2DwQtqBrXofHm2LX1eAtW/NBYudaDgbbXUzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEZtWX4536KqFezFx0JKS9a6q1v6toJ0oHJG8Od919wWq7nIvU49ih4E/pUBY5ksdR24tJtjQldw4QsTw08RB5hhHNbp0ellt6Udoy5iTChKon8nG5lFRuSRx8OQnIDI9lbfKefSYU175v652IEn/IT4HiGS8lY/9pRgDLUoNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=seV259zX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710888704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22MOrFn6Jv82M2hVwDO7x3NptrRxbkjYXXxqCJWSeQI=;
	b=seV259zXIx8RJKOwI0MDotOAEjzP+juNH/bWlbGRbh6ap4CtCnQrsUaDJ0ZK1LsqzBNAjV
	6R1oP+eSNpNZLP01oqbjLCeskK14c85TKt04yQs3Ty35D1obgsbYQjK5Kf7tzGpZDZXMIB
	NJlDPtthqS4EwUN/yPCjp9AFNyIC8WU=
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
Subject: [PATCH v2 4/8] drm: zynqmp_dp: Rearrange zynqmp_dp for better padding
Date: Tue, 19 Mar 2024 18:51:17 -0400
Message-Id: <20240319225122.3048400-5-sean.anderson@linux.dev>
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

Sort the members of struct zynqmp_dp to reduce padding necessary for
alignment.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 8635b5673386..f1834c8e3c02 100644
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


