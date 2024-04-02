Return-Path: <linux-kernel+bounces-128115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A9895651
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A601F1F278F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500086ACC;
	Tue,  2 Apr 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CKjMS+lz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D5D132C19;
	Tue,  2 Apr 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066995; cv=none; b=rF9QeiAAtsD2pW5tDNHee6DwTAY3IWK7j3PKx31Ihe4zNmajrqien493qGooWR7zMuUgd1NEnzMRxjLUpUR164JVmsamLuV9XcrYRYgB+luZBwAQSlZU1tcujXnXafFf5HITTYiLe/bnGrQxtAgxETM3iZ3zPS6mtEDF5sGKzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066995; c=relaxed/simple;
	bh=l2R2+ukhGeOdEK5zvxB/TuakwAbZuTzRFW/X96M+/RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4Cdh3ajQTCji5dbSNbB4DeiYKdavZdKjo6h3x339jgJzqTlSTRFi/tsARvvMW1u0oWeVzMDuT4nr3e8Dq6suJHXKR2qS4F/nCtyf2w1/VoI5IRPS6Gz3y4CF+mtDf6964FlAvr6wLhhH9oqYEKbxOPF9AMTbbNf8oaNVXw0eck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CKjMS+lz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 238C266F;
	Tue,  2 Apr 2024 16:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712066955;
	bh=l2R2+ukhGeOdEK5zvxB/TuakwAbZuTzRFW/X96M+/RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKjMS+lz+fDspYkMfyRDBZ+4nFEidcAp8zasjQ/IB5cgjdlUYHPFVm1c05bAc91o3
	 RsJ7uWSGTOPB7S2deXS6/uSHMFEnzlpCDXJX2S/LyN2s2i/Gx+mqVH9WTRJRx7aNJ8
	 GgZO/0Zhfl70FO7Zcz7/vQbuhJhk/BU79tb1602U=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v4 6/6] media: imx335: Limit analogue gain value
Date: Tue,  2 Apr 2024 19:39:24 +0530
Message-ID: <20240402140924.10009-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402140924.10009-1-umang.jain@ideasonboard.com>
References: <20240402140924.10009-1-umang.jain@ideasonboard.com>
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
index dfc24783dc34..aed3efa9f590 100644
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


