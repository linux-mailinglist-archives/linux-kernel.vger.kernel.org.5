Return-Path: <linux-kernel+bounces-153866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897FF8AD44A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D8B252B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC82155385;
	Mon, 22 Apr 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WD5t8U12"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE5156C47
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811582; cv=none; b=usRFcQ1LPoUetKRW9Hqsm1bgGa+hsukqBzRY83wN9pe5g/F3tSYfR0nl+FneUPgnMxTKlUWDS+3CQGautyP9PtUZuROupjBZJ74mzKy7/y05L4GaawLYEqKnFMvxpygffLuCJHOYPCSUjz93PDd6RkswnN7CmMfomsFecNkbepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811582; c=relaxed/simple;
	bh=ZYEehqeakgoUs0VCwfCnrjo7TeW/wzyeeIgU0yM7dn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9A4DVAtWSnymnfaFlxCtqNIkeqSqSky4N4nK54oTYFw9x0YNTVQGddOfkywE7/I5H5vmvC6OD5yJjHhKiaBOB4rSOqcfA9nOWLWG7qjBziacbnC0W8HgnXaQ81W+bgXL+htsASnHSY6eXFNlDCC2K2uT1kJcMDsD+Ri3TMs9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WD5t8U12; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjewHQBEUPjjqz3SMp/L8D2Qjzh/VbYimQA2FI37Q7E=;
	b=WD5t8U12C8em01LtErEQjhWhq9kiZETk0IKpS991hjSWpD+5YntRGi/V3VYhwLVLLO6X6e
	xFrbyETDPvGfCm3B6qlFsmq911Abs1Grqz4mSLY5hssx1pwBdn6M94+of/edmZqPfALN+F
	zFMjtMnrFCT1N83Y7o0Qga4HLWsA/4E=
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
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 10/13] drm: zynqmp_dp: Use AUX IRQs instead of polling
Date: Mon, 22 Apr 2024 14:45:50 -0400
Message-Id: <20240422184553.3573009-11-sean.anderson@linux.dev>
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

Instead of polling the status register for the AUX status, just enable
the IRQs and signal a completion.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 35 +++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 3ecfebf35a72..3d90533aefd7 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -285,6 +285,7 @@ struct zynqmp_dp_config {
  * @next_bridge: The downstream bridge
  * @config: IP core configuration from DTS
  * @aux: aux channel
+ * @aux_done: Completed when we get an AUX reply or timeout
  * @phy: PHY handles for DP lanes
  * @num_lanes: number of enabled phy lanes
  * @hpd_work: hot plug detection worker
@@ -305,6 +306,7 @@ struct zynqmp_dp {
 	struct drm_bridge bridge;
 	struct work_struct hpd_work;
 	struct work_struct hpd_irq_work;
+	struct completion aux_done;
 	struct mutex lock;
 
 	struct drm_bridge *next_bridge;
@@ -941,12 +943,15 @@ static int zynqmp_dp_aux_cmd_submit(struct zynqmp_dp *dp, u32 cmd, u16 addr,
 				    u8 *buf, u8 bytes, u8 *reply)
 {
 	bool is_read = (cmd & AUX_READ_BIT) ? true : false;
+	unsigned long time_left;
 	u32 reg, i;
 
 	reg = zynqmp_dp_read(dp, ZYNQMP_DP_INTERRUPT_SIGNAL_STATE);
 	if (reg & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REQUEST)
 		return -EBUSY;
 
+	reinit_completion(&dp->aux_done);
+
 	zynqmp_dp_write(dp, ZYNQMP_DP_AUX_ADDRESS, addr);
 	if (!is_read)
 		for (i = 0; i < bytes; i++)
@@ -961,17 +966,14 @@ static int zynqmp_dp_aux_cmd_submit(struct zynqmp_dp *dp, u32 cmd, u16 addr,
 	zynqmp_dp_write(dp, ZYNQMP_DP_AUX_COMMAND, reg);
 
 	/* Wait for reply to be delivered upto 2ms */
-	for (i = 0; ; i++) {
-		reg = zynqmp_dp_read(dp, ZYNQMP_DP_INTERRUPT_SIGNAL_STATE);
-		if (reg & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REPLY)
-			break;
+	time_left = wait_for_completion_timeout(&dp->aux_done,
+						msecs_to_jiffies(2));
+	if (!time_left)
+		return -ETIMEDOUT;
 
-		if (reg & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REPLY_TIMEOUT ||
-		    i == 2)
-			return -ETIMEDOUT;
-
-		usleep_range(1000, 1100);
-	}
+	reg = zynqmp_dp_read(dp, ZYNQMP_DP_INTERRUPT_SIGNAL_STATE);
+	if (reg & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REPLY_TIMEOUT)
+		return -ETIMEDOUT;
 
 	reg = zynqmp_dp_read(dp, ZYNQMP_DP_AUX_REPLY_CODE);
 	if (reply)
@@ -1055,6 +1057,9 @@ static int zynqmp_dp_aux_init(struct zynqmp_dp *dp)
 			(w << ZYNQMP_DP_AUX_CLK_DIVIDER_AUX_FILTER_SHIFT) |
 			(rate / (1000 * 1000)));
 
+	zynqmp_dp_write(dp, ZYNQMP_DP_INT_EN, ZYNQMP_DP_INT_REPLY_RECEIVED |
+					      ZYNQMP_DP_INT_REPLY_TIMEOUT);
+
 	dp->aux.name = "ZynqMP DP AUX";
 	dp->aux.dev = dp->dev;
 	dp->aux.drm_dev = dp->bridge.dev;
@@ -1072,6 +1077,9 @@ static int zynqmp_dp_aux_init(struct zynqmp_dp *dp)
 static void zynqmp_dp_aux_cleanup(struct zynqmp_dp *dp)
 {
 	drm_dp_aux_unregister(&dp->aux);
+
+	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, ZYNQMP_DP_INT_REPLY_RECEIVED |
+					      ZYNQMP_DP_INT_REPLY_TIMEOUT);
 }
 
 /* -----------------------------------------------------------------------------
@@ -1678,6 +1686,12 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 	if (status & ZYNQMP_DP_INT_HPD_IRQ)
 		schedule_work(&dp->hpd_irq_work);
 
+	if (status & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REPLY)
+		complete(&dp->aux_done);
+
+	if (status & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REPLY_TIMEOUT)
+		complete(&dp->aux_done);
+
 	return IRQ_HANDLED;
 }
 
@@ -1701,6 +1715,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	dp->dpsub = dpsub;
 	dp->status = connector_status_disconnected;
 	mutex_init(&dp->lock);
+	init_completion(&dp->aux_done);
 
 	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
 	INIT_WORK(&dp->hpd_irq_work, zynqmp_dp_hpd_irq_work_func);
-- 
2.35.1.1320.gc452695387.dirty


