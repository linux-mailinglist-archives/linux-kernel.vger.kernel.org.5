Return-Path: <linux-kernel+bounces-108207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC97C880779
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05DD1C22592
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD7605B5;
	Tue, 19 Mar 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GR7oeqIs"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36C604C5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888714; cv=none; b=OJVfvD9W/1Uaa+2yJNvaY2s6TZFFOSKBYQeS21KWkobYCVzA58KlZMWxOKRqvX9esaTYWwKU7+qGcwDRlUES15fy2zxCZVHttY34MxPabErsTCsunn/jsaT43aH7IH+u6yfxASSuC3bMxSc9pSPMa0y0mUBRi/7MKlrx6BsJ5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888714; c=relaxed/simple;
	bh=+yzYZU05JAzyDoz8ppAE2btpTQDYRJfKGBsFBO7T6UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJSzSH1q3ocwnvBHKvlkaGhEXPM7yeWBNx4nUE8c8B9DaXZqjkAb+KwK+qhH4XzXpxGFH1ZUlSr4p7pGMJ/FoyZJbk/EuzGdRIMqk6BnnKbmKkprDLdfOnrA++RU8AsFP4dLiYOGrFZ04T8XEKfDxPx9cyHU3EGcWQBs3Q6zNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GR7oeqIs; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710888711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1+1G3kfP2Ld2oiwl8Q35xi3mNbb5m0/WxmrCMREcLk=;
	b=GR7oeqIsOxYXZiK0aKwnttplqPLnnCrS4Cq/8cm4uR0fUgeV2nhhf2b0YTol14z1ruAf2L
	kfjExK7zpWQY4n08Bal+Db8U/9KYNHSgIbOsYBS4eKEDeQ5iLeZS9pgvHGN8Oyel7KFNYk
	N/a2BfXJlt5ABsq7EZiFzUG68zYnAFQ=
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
Subject: [PATCH v2 7/8] drm: zynqmp_dp: Split off several helper functions
Date: Tue, 19 Mar 2024 18:51:20 -0400
Message-Id: <20240319225122.3048400-8-sean.anderson@linux.dev>
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

In preparation for supporting compliance testing, split off several
helper functions. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

(no changes since v1)

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 49 ++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index a90ab5c0f5cf..6e04dcf61e19 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -633,6 +633,7 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
 /**
  * zynqmp_dp_update_vs_emph - Update the training values
  * @dp: DisplayPort IP core structure
+ * @train_set: A set of training values
  *
  * Update the training values based on the request from sink. The mapped values
  * are predefined, and values(vs, pe, pc) are from the device manual.
@@ -640,12 +641,12 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
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
@@ -653,7 +654,7 @@ static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp)
 	for (i = 0; i < dp->mode.lane_cnt; i++) {
 		u32 reg = ZYNQMP_DP_SUB_TX_PHY_PRECURSOR_LANE_0 + i * 4;
 		union phy_configure_opts opts = { 0 };
-		u8 train = dp->train_set[i];
+		u8 train = train_set[i];
 
 		opts.dp.voltage[0] = (train & DP_TRAIN_VOLTAGE_SWING_MASK)
 				   >> DP_TRAIN_VOLTAGE_SWING_SHIFT;
@@ -697,7 +698,7 @@ static int zynqmp_dp_link_train_cr(struct zynqmp_dp *dp)
 	 * So, This loop should exit before 512 iterations
 	 */
 	for (max_tries = 0; max_tries < 512; max_tries++) {
-		ret = zynqmp_dp_update_vs_emph(dp);
+		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
 		if (ret)
 			return ret;
 
@@ -762,7 +763,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
 		return ret;
 
 	for (tries = 0; tries < DP_MAX_TRAINING_TRIES; tries++) {
-		ret = zynqmp_dp_update_vs_emph(dp);
+		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
 		if (ret)
 			return ret;
 
@@ -785,28 +786,29 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
 }
 
 /**
- * zynqmp_dp_train - Train the link
+ * zynqmp_dp_setup() - Set up major link parameters
  * @dp: DisplayPort IP core structure
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
@@ -849,8 +851,25 @@ static int zynqmp_dp_train(struct zynqmp_dp *dp)
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
+			      dp->dpcd[DP_MAX_DOWNSPREAD] &
+			      DP_MAX_DOWNSPREAD_0_5);
+	if (ret)
 		return ret;
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_SCRAMBLING_DISABLE, 1);
-- 
2.35.1.1320.gc452695387.dirty


