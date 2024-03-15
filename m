Return-Path: <linux-kernel+bounces-104979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D99887D732
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F33B1F22887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D315B5D1;
	Fri, 15 Mar 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7Rkcebb"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC955B1F1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544175; cv=none; b=rziQL9lWnnAYhrlaK6I+npXxdEcIyf7I+AD6+CSrt5dJfzPl5FYsp8zL6sYpgWVKPIOInF55FfX3o1qBbLRuBrb0A3kUbkstHFgk+xGaVsN2KohdXX9H+BHHASdmp9laJZFRuZ41B6dxJIa2KhJdrpQ3yEJwIkLUhypB26m7vio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544175; c=relaxed/simple;
	bh=CxjxZmkPwitdXK8b0r1uES32cbnbup5zS4MFPkmsP4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afM5LRx+hggKPSuGX3Fhvu4Xd6OHSY9T/05yFjOQwFM7Wt/0Wy86CgjxgdO7Ojpb/CPTwqXdrQuNja5BXi1+XWRYYh9FFC8ti3HrmOaY4HC2c74vXWOplGXPf5LXLVh/jsn8cokzE7B1q3at98f5psRjNbimbqOvW8AT24dZvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7Rkcebb; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710544171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuGHTETxhmXOcV9deAeLZwjxRa5UHxis9t8GwbgUvBg=;
	b=U7RkcebbeeF0JxQ3NK0tDUhd5nFg5+xGDimuRl5C8+9syvJe/Dao5gZlVOFqPGA8foblDq
	DjWXA6u3aTWi95egf3KpX+h/u/wVLv62F8FQarmCTHAbAk3Ck64Qid+tq/cxM1wg8zvgmA
	zFKMnVoJqvLFUoV7uacLm1rSVEqL/Rc=
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
Subject: [PATCH 4/6] drm: zynqmp_dp: Split off several helper functions
Date: Fri, 15 Mar 2024 19:09:14 -0400
Message-Id: <20240315230916.1759060-5-sean.anderson@linux.dev>
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

In preparation for supporting compliance testing, split off several
helper functions. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 49 +++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index d2dee58e7bf2..24043847dab4 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -627,6 +627,7 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
 /**
  * zynqmp_dp_update_vs_emph - Update the training values
  * @dp: DisplayPort IP core structure
+ * @train_set: A set of training values
  *
  * Update the training values based on the request from sink. The mapped values
  * are predefined, and values(vs, pe, pc) are from the device manual.
@@ -634,12 +635,12 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
  * Return: 0 if vs and emph are updated successfully, or the error code returned
  * by drm_dp_dpcd_write().
  */
-static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp)
+static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp, u8 *train_set)
 {
 	unsigned int i;
 	int ret;
 
-	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, dp->train_set,
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set,
 				dp->mode.lane_cnt);
 	if (ret < 0)
 		return ret;
@@ -647,7 +648,7 @@ static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp)
 	for (i = 0; i < dp->mode.lane_cnt; i++) {
 		u32 reg = ZYNQMP_DP_SUB_TX_PHY_PRECURSOR_LANE_0 + i * 4;
 		union phy_configure_opts opts = { 0 };
-		u8 train = dp->train_set[i];
+		u8 train = train_set[i];
 
 		opts.dp.voltage[0] = (train & DP_TRAIN_VOLTAGE_SWING_MASK)
 				   >> DP_TRAIN_VOLTAGE_SWING_SHIFT;
@@ -691,7 +692,7 @@ static int zynqmp_dp_link_train_cr(struct zynqmp_dp *dp)
 	 * So, This loop should exit before 512 iterations
 	 */
 	for (max_tries = 0; max_tries < 512; max_tries++) {
-		ret = zynqmp_dp_update_vs_emph(dp);
+		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
 		if (ret)
 			return ret;
 
@@ -756,7 +757,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
 		return ret;
 
 	for (tries = 0; tries < DP_MAX_TRAINING_TRIES; tries++) {
-		ret = zynqmp_dp_update_vs_emph(dp);
+		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
 		if (ret)
 			return ret;
 
@@ -779,28 +780,28 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
 }
 
 /**
- * zynqmp_dp_train - Train the link
- * @dp: DisplayPort IP core structure
+ * zynqmp_dp_setup() - Set up major link parameters
+ * @bw_code: The link bandwidth as a multiple of 270 MHz
+ * @lane_cnt: The number of lanes to use
+ * @enhanced: Use enhanced framing
+ * @downspread: Enable spread-spectrum clocking
  *
- * Return: 0 if all trains are done successfully, or corresponding error code.
+ * Return: 0 on success, or -errno on failure
  */
-static int zynqmp_dp_train(struct zynqmp_dp *dp)
+static int zynqmp_dp_setup(struct zynqmp_dp *dp, u8 bw_code, u8 lane_cnt,
+			   bool enhanced, bool downspread)
 {
 	u32 reg;
-	u8 bw_code = dp->mode.bw_code;
-	u8 lane_cnt = dp->mode.lane_cnt;
 	u8 aux_lane_cnt = lane_cnt;
-	bool enhanced;
 	int ret;
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_LANE_COUNT_SET, lane_cnt);
-	enhanced = drm_dp_enhanced_frame_cap(dp->dpcd);
 	if (enhanced) {
 		zynqmp_dp_write(dp, ZYNQMP_DP_ENHANCED_FRAME_EN, 1);
 		aux_lane_cnt |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
 	}
 
-	if (dp->dpcd[3] & 0x1) {
+	if (downspread) {
 		zynqmp_dp_write(dp, ZYNQMP_DP_DOWNSPREAD_CTL, 1);
 		drm_dp_dpcd_writeb(&dp->aux, DP_DOWNSPREAD_CTRL,
 				   DP_SPREAD_AMP_0_5);
@@ -843,8 +844,24 @@ static int zynqmp_dp_train(struct zynqmp_dp *dp)
 	}
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_PHY_CLOCK_SELECT, reg);
-	ret = zynqmp_dp_phy_ready(dp);
-	if (ret < 0)
+	return zynqmp_dp_phy_ready(dp);
+}
+
+
+/**
+ * zynqmp_dp_train - Train the link
+ * @dp: DisplayPort IP core structure
+ *
+ * Return: 0 if all trains are done successfully, or corresponding error code.
+ */
+static int zynqmp_dp_train(struct zynqmp_dp *dp)
+{
+	int ret;
+
+	ret = zynqmp_dp_setup(dp, dp->mode.bw_code, dp->mode.lane_cnt,
+			      drm_dp_enhanced_frame_cap(dp->dpcd),
+			      dp->dpcd[3] & 0x1);
+	if (ret)
 		return ret;
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_SCRAMBLING_DISABLE, 1);
-- 
2.35.1.1320.gc452695387.dirty


