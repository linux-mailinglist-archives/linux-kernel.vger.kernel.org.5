Return-Path: <linux-kernel+bounces-142650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B988A2E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FC91C22687
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC225A0FD;
	Fri, 12 Apr 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="klBY45QZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412975914E;
	Fri, 12 Apr 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924943; cv=none; b=KaY6KRYfZyEhnEYWgWAn5Jdspv4uZG4leDHLs0bMTUAFyRBe1PrZ7G5CSXopvtufWEuZAxT6fAib654QQ/v+vCWCgyWueuIh67ttFT3rNvFbRxCBzxD8cvvDVt5DRNv3OyZTmBCjHNNWn7cT3fn5S53PIJg6gfEWQ4e921nCc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924943; c=relaxed/simple;
	bh=8t/bWqXW0zV16/ONeS9vNG6hR8OuIaVv26rvg7gqMdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2o1K7OCtLjJqfIKMDw8S8XICu2mfTace6Z1JIDhCNtvx0uJhimeYHRTlvOVIxTxTuvDBvQQ01gJFYOs9nFV/fnnrkB4ImQx/HBjqDJJXmHG2ubderxxjW2WzD3vRYi0a9XCk0JLRwiHE94el/O8tv5pg54dcP0cwkbYtNb+WXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=klBY45QZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8E2BB0E;
	Fri, 12 Apr 2024 14:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712924897;
	bh=8t/bWqXW0zV16/ONeS9vNG6hR8OuIaVv26rvg7gqMdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klBY45QZDNosDttEr9xoPXwtnkltKCeMoqewLw4zTNJXcswqSgoatq9t7eMmmVAvT
	 RBVBK/EL0XE2VUATrW5k81t+4DTIzR3G5j1dLgrZkChLoHda6H3uSjrnM2gdiyxLw0
	 5UOSM6aArMb6LvVWUjqLiFiD9IqeysacxaEETpfo=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v5 6/6] media: imx335: Limit analogue gain value
Date: Fri, 12 Apr 2024 17:58:42 +0530
Message-ID: <20240412122842.193713-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412122842.193713-1-umang.jain@ideasonboard.com>
References: <20240412122842.193713-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sensor gain (both analog and digital) are controlled by a
single gain value where:
- 0dB to 30dB correspond to analog gain
- 30.3dB to 72dB correspond to digital gain
  (with 0.3dB step)

Hence, limit the analogue gain value to 100.
For digital gain, support can be added later if needed.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/imx335.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 75f4b4e0a5da..4bd547ca71c8 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -52,7 +52,7 @@
 /* Analog gain control */
 #define IMX335_REG_AGAIN		CCI_REG8(0x30e8)
 #define IMX335_AGAIN_MIN		0
-#define IMX335_AGAIN_MAX		240
+#define IMX335_AGAIN_MAX		100
 #define IMX335_AGAIN_STEP		1
 #define IMX335_AGAIN_DEFAULT		0
 
@@ -1175,6 +1175,14 @@ static int imx335_init_controls(struct imx335 *imx335)
 					     IMX335_EXPOSURE_STEP,
 					     IMX335_EXPOSURE_DEFAULT);
 
+	/*
+	 * The sensor has an analog gain and a digital gain, both controlled
+	 * through a single gain value, expressed in 0.3dB increments. Values
+	 * from 0.0dB (0) to 30.0dB (100) apply analog gain only, higher values
+	 * up to 72.0dB (240) add further digital gain. Limit the range to
+	 * analog gain only, support for digital gain can be added separately
+	 * if needed.
+	 */
 	imx335->again_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
 					       &imx335_ctrl_ops,
 					       V4L2_CID_ANALOGUE_GAIN,
-- 
2.43.0


