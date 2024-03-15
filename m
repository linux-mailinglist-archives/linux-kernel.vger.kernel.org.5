Return-Path: <linux-kernel+bounces-104981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A97787D734
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEDCB20E94
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEC25BAF8;
	Fri, 15 Mar 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tTOCd92z"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE425B5C0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544178; cv=none; b=JyOwy08hNXpe8/HmlqJXI92+1Bl6nEQ2KZy2chDxf9HP4/ra7+YCwz4FqAKxkoCtCMEsYpRUF01j7mneTIWu/iFtRUycHuSo//IDaVDOjFTR2OL3QvMwMnsneGL4a1CYcj4vH2A7fOlVFZnxh7pG9jQ82AXzbBwtGHSb5hI3zAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544178; c=relaxed/simple;
	bh=h4cojU8kwWfz/UTtLKse1V3hNWYPjNuN24lw+Cpjhno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIJEyuRI5+RuG4IA8fElcFUOoqRCT8rkFi/4QXqu5K+1kFeNpNqkAPbxUWljxjJIwm+CXnK4ysDbOZGwUefTC4olS+Aq8Uxw7pAzoys7t3XQgtHJkqdwyKtvqWpOgLn6aIODMJqI+jW8iq9FAw5IYRbA4L4pDge0Kpn8itVwCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tTOCd92z; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710544174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iCejvqA5IbzASiXQE6xrf0mIzF3OuUDUKlOJcBerFY=;
	b=tTOCd92zqEXX69LmQS9XAiZrEQdbzzyrOmbVeN3kSGIjYq/h/7Vz38DXpQE72l7TTNH8cC
	2+SgkUQBW8h2oQ2tM+N9gEo393sCF4tto1OlQOcdFOrUagGkmLIm9UF45kodIDTnJy3nsU
	7UoG7DkoiKNQpGH0z4W00x/+zHpRBY4=
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
Subject: [PATCH 5/6] drm: zynqmp_dp: Optionally ignore DPCD errors
Date: Fri, 15 Mar 2024 19:09:15 -0400
Message-Id: <20240315230916.1759060-6-sean.anderson@linux.dev>
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

When testing, it's convenient to be able to ignore DPCD errors if there
is test equipment which can't emulate a DPRX connected to the output.
Add some (currently-unused) options to ignore these errors and just
reconfigure our internal registers as we usually would.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 37 ++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 24043847dab4..040f7b88ee51 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -628,6 +628,7 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
  * zynqmp_dp_update_vs_emph - Update the training values
  * @dp: DisplayPort IP core structure
  * @train_set: A set of training values
+ * @ignore_dpcd: Ignore DPCD errors
  *
  * Update the training values based on the request from sink. The mapped values
  * are predefined, and values(vs, pe, pc) are from the device manual.
@@ -635,15 +636,19 @@ static void zynqmp_dp_adjust_train(struct zynqmp_dp *dp,
  * Return: 0 if vs and emph are updated successfully, or the error code returned
  * by drm_dp_dpcd_write().
  */
-static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp, u8 *train_set)
+static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp, u8 *train_set,
+				    bool ignore_dpcd)
 {
 	unsigned int i;
 	int ret;
 
 	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set,
 				dp->mode.lane_cnt);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		if (!ignore_dpcd)
+			return ret;
+		dev_warn(dp->dev, "failed to update vs/emph\n");
+	}
 
 	for (i = 0; i < dp->mode.lane_cnt; i++) {
 		u32 reg = ZYNQMP_DP_SUB_TX_PHY_PRECURSOR_LANE_0 + i * 4;
@@ -692,7 +697,7 @@ static int zynqmp_dp_link_train_cr(struct zynqmp_dp *dp)
 	 * So, This loop should exit before 512 iterations
 	 */
 	for (max_tries = 0; max_tries < 512; max_tries++) {
-		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
+		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set, false);
 		if (ret)
 			return ret;
 
@@ -757,7 +762,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
 		return ret;
 
 	for (tries = 0; tries < DP_MAX_TRAINING_TRIES; tries++) {
-		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set);
+		ret = zynqmp_dp_update_vs_emph(dp, dp->train_set, false);
 		if (ret)
 			return ret;
 
@@ -785,11 +790,12 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
  * @lane_cnt: The number of lanes to use
  * @enhanced: Use enhanced framing
  * @downspread: Enable spread-spectrum clocking
+ * @ignore_dpcd: Ignore DPCD errors; useful for testing
  *
  * Return: 0 on success, or -errno on failure
  */
 static int zynqmp_dp_setup(struct zynqmp_dp *dp, u8 bw_code, u8 lane_cnt,
-			   bool enhanced, bool downspread)
+			   bool enhanced, bool downspread, bool ignore_dpcd)
 {
 	u32 reg;
 	u8 aux_lane_cnt = lane_cnt;
@@ -812,21 +818,24 @@ static int zynqmp_dp_setup(struct zynqmp_dp *dp, u8 bw_code, u8 lane_cnt,
 
 	ret = drm_dp_dpcd_writeb(&dp->aux, DP_LANE_COUNT_SET, aux_lane_cnt);
 	if (ret < 0) {
-		dev_err(dp->dev, "failed to set lane count\n");
-		return ret;
+		dev_warn(dp->dev, "failed to set lane count\n");
+		if (!ignore_dpcd)
+			return ret;
 	}
 
 	ret = drm_dp_dpcd_writeb(&dp->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
 				 DP_SET_ANSI_8B10B);
 	if (ret < 0) {
-		dev_err(dp->dev, "failed to set ANSI 8B/10B encoding\n");
-		return ret;
+		dev_warn(dp->dev, "failed to set ANSI 8B/10B encoding\n");
+		if (!ignore_dpcd)
+			return ret;
 	}
 
 	ret = drm_dp_dpcd_writeb(&dp->aux, DP_LINK_BW_SET, bw_code);
 	if (ret < 0) {
-		dev_err(dp->dev, "failed to set DP bandwidth\n");
-		return ret;
+		dev_warn(dp->dev, "failed to set DP bandwidth\n");
+		if (!ignore_dpcd)
+			return ret;
 	}
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_LINK_BW_SET, bw_code);
@@ -860,7 +869,7 @@ static int zynqmp_dp_train(struct zynqmp_dp *dp)
 
 	ret = zynqmp_dp_setup(dp, dp->mode.bw_code, dp->mode.lane_cnt,
 			      drm_dp_enhanced_frame_cap(dp->dpcd),
-			      dp->dpcd[3] & 0x1);
+			      dp->dpcd[3] & 0x1, false);
 	if (ret)
 		return ret;
 
@@ -877,7 +886,7 @@ static int zynqmp_dp_train(struct zynqmp_dp *dp)
 	ret = drm_dp_dpcd_writeb(&dp->aux, DP_TRAINING_PATTERN_SET,
 				 DP_TRAINING_PATTERN_DISABLE);
 	if (ret < 0) {
-		dev_err(dp->dev, "failed to disable training pattern\n");
+		dev_warn(dp->dev, "failed to disable training pattern\n");
 		return ret;
 	}
 	zynqmp_dp_write(dp, ZYNQMP_DP_TRAINING_PATTERN_SET,
-- 
2.35.1.1320.gc452695387.dirty


