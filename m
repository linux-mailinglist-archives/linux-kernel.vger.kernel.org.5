Return-Path: <linux-kernel+bounces-93479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1252873058
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D5A1C21F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875EE5D495;
	Wed,  6 Mar 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q52+p6yx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973B5EE6A;
	Wed,  6 Mar 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712675; cv=none; b=qB7eOxoNffofd4n5fkoj+ZQS7S1evE28qXgfVqj+UURMoTZbTj1KthbPZupKBFCZ2CsCiE/eW0l/gmk0HCB10mPpsRqzyiDa06UHhxDVlmDVpKRaD+Ed2LPMKYvjrCclI2HdRQ+qG7PJ2j1VzwaPSwhicy4c2vmqlX88B2YvC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712675; c=relaxed/simple;
	bh=PDUP7rsaMivjiJCXl3vEQPR3PB4cpDd0COkDHIEJVcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU9WVmnF1sV8VK9ReFdBlfnzgiGkKNyHUNAn2+x9DDwC0IIQ+JxzPiCrpv62Q35fnLUTO1pm7TDi3hSmq3MN5vECKoAYTfnKZ2zjRyoe2SnIb7dBTwJCfddebzB6A1FiDNYNUPoDMZr8QEFZFqSG0gsoxL0bbdxR/ob7jbGlK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=q52+p6yx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 343E5BD1;
	Wed,  6 Mar 2024 09:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709712655;
	bh=PDUP7rsaMivjiJCXl3vEQPR3PB4cpDd0COkDHIEJVcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q52+p6yxBTWErRWqmI3++QU0P6LlDUQxPEtjakg4GopBE+zXifdMJR8hV5YBEtfAA
	 QXnMWe11D5A6YUDk8Jk79jKTHvkLTijgSvX7mDKPPlfDkLzaS+i7A0RLhorgnHN2+i
	 /sdoFeBQ4hjeQHfA5gQU04Bp6/Iq/w+6PaimnVR0=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 5/5] media: imx335: Limit analogue gain value
Date: Wed,  6 Mar 2024 13:40:38 +0530
Message-ID: <20240306081038.212412-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306081038.212412-1-umang.jain@ideasonboard.com>
References: <20240306081038.212412-1-umang.jain@ideasonboard.com>
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
---
 drivers/media/i2c/imx335.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index c00e0c2be3f3..701bd5318b45 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -45,7 +45,7 @@
 /* Analog gain control */
 #define IMX335_REG_AGAIN	CCI_REG8(0x30e8)
 #define IMX335_AGAIN_MIN	0
-#define IMX335_AGAIN_MAX	240
+#define IMX335_AGAIN_MAX	100
 #define IMX335_AGAIN_STEP	1
 #define IMX335_AGAIN_DEFAULT	0
 
@@ -1169,6 +1169,14 @@ static int imx335_init_controls(struct imx335 *imx335)
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


