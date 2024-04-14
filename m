Return-Path: <linux-kernel+bounces-144179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630978A42CB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041061F212CA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C45B209;
	Sun, 14 Apr 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BDdEjnRU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96F5A11A;
	Sun, 14 Apr 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103609; cv=none; b=d31z4bMeab7a5PZYgr3HVacfEfy035QAHNok15P9T8B+ucRhcaHAVJmgOeiTIDNuzJLigqxBp8CnZDHTDsM4EwJPD4aCiB7Q3uuVW3vYAiEXpr8m2s5r0D2pZ4RSt8TW48pOlCBS3lUN+aajSQ1kNkqTQrP3MybU2QSZ5D4BbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103609; c=relaxed/simple;
	bh=NQHxu7CHTJHmaNk7YMBz6tNE/ePJo+5WwMbq0pC/G9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfqiA3J3QYA4W2XcbIQ2cgkQYG4soDX8Jee8ZvHQkpJFxh/1N3JRSiVpdgwqERfpze038mjZir7h0V9wwRU7aAVnVetQqUz67ggd1nK5TRunfNpiABXmsb7JbG8bZHFvW763BxmZf09L/9K0fFoMQLMn9uEALA+rKr4AR1OcR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BDdEjnRU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.238])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5FC5C512;
	Sun, 14 Apr 2024 16:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713103561;
	bh=NQHxu7CHTJHmaNk7YMBz6tNE/ePJo+5WwMbq0pC/G9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDdEjnRUvUJGgIN+3N9OTcJGaXfvRM/UvxS9o8JF91rF9dryKmkU//Va2KXSlO1U7
	 qU/s+zdkNynuUw1aZXf/CFBE0r2JKCoHdRVzMQEUpPdJYFtIqvINhBUfd2yvu8Jus9
	 KJGa4YSCHxIrix5Gzs5YfHyJcX3u28W0B1Y4Ak/8=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v7 6/6] media: imx335: Limit analogue gain value
Date: Sun, 14 Apr 2024 19:36:21 +0530
Message-ID: <20240414140621.167717-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240414140621.167717-1-umang.jain@ideasonboard.com>
References: <20240414140621.167717-1-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 31d3b95cc0ef..0b06e86583f2 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -49,10 +49,10 @@
 #define IMX335_REG_AREA3_ST_ADR_1	CCI_REG16_LE(0x3074)
 #define IMX335_REG_AREA3_WIDTH_1	CCI_REG16_LE(0x3076)
 
-/* Analog gain control */
-#define IMX335_REG_AGAIN		CCI_REG8(0x30e8)
+/* Analog and Digital gain control */
+#define IMX335_REG_GAIN			CCI_REG8(0x30e8)
 #define IMX335_AGAIN_MIN		0
-#define IMX335_AGAIN_MAX		240
+#define IMX335_AGAIN_MAX		100
 #define IMX335_AGAIN_STEP		1
 #define IMX335_AGAIN_DEFAULT		0
 
@@ -479,7 +479,7 @@ static int imx335_update_exp_gain(struct imx335 *imx335, u32 exposure, u32 gain)
 	cci_write(imx335->cci, IMX335_REG_HOLD, 1, &ret);
 	cci_write(imx335->cci, IMX335_REG_VMAX, lpfr, &ret);
 	cci_write(imx335->cci, IMX335_REG_SHUTTER, shutter, &ret);
-	cci_write(imx335->cci, IMX335_REG_AGAIN, gain, &ret);
+	cci_write(imx335->cci, IMX335_REG_GAIN, gain, &ret);
 	/*
 	 * Unconditionally attempt to release the hold, but track the
 	 * error if the unhold itself fails.
@@ -1183,6 +1183,14 @@ static int imx335_init_controls(struct imx335 *imx335)
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


