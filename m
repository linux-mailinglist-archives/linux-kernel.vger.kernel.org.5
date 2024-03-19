Return-Path: <linux-kernel+bounces-107169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1919A87F865
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A837B22308
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685607CF29;
	Tue, 19 Mar 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bD/vyfbn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8D7CF25
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833266; cv=none; b=RW5na8KKHOypH7EtZAINyDiZGzIUXLVr+42z65Hb0uz723fnElqCeYS98uebUi5UI/qYJ3vGSQJxMEhEBTfRUc2tfWLgozkDIyC9bH2TdELdBU6icxitS6azibYKf2vMfA4Sy3DSoB0sbz7sB8xRdfGPG3LqFJCPfN8w40TtQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833266; c=relaxed/simple;
	bh=xiE+4s/2bcGKpcSbUmB3pNcXJFGnXmhWhAmSMO4hU7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3cUxC7zBEL4Uqqni3QH5+opKKr49pje0zweWRtG390CaijxnH1U7wbHdI35XjMbTgYIBKdHfHn78uco0FuoK08VcQnd/aWQgzgrQsMALhBYa9r/hFkVKXr+RjXDELQwa9DM9whW77GARALrsjzFvLxqs5FtHKt/KI1bSQHz3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bD/vyfbn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CAC05BB2;
	Tue, 19 Mar 2024 08:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710833237;
	bh=xiE+4s/2bcGKpcSbUmB3pNcXJFGnXmhWhAmSMO4hU7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bD/vyfbn1CfLXh+fiOLox190nGNnXjLN1KwCIENMg7wefSoWMmSZHzO8J6F6+mvbZ
	 gg8lppnPfMlfmAYP7nbZki57nFYVLVnXPt0wUfGJ085ASTXwohNhUQMjVPTDv4PSAP
	 w6fw5pUpUWc48rYrE5jgo2fXzej7Pe8bYFSsxQCI=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v3 6/6] media: imx335: Limit analogue gain value
Date: Tue, 19 Mar 2024 12:57:12 +0530
Message-ID: <20240319072712.133449-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319072712.133449-1-umang.jain@ideasonboard.com>
References: <20240319072712.133449-1-umang.jain@ideasonboard.com>
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
index 10a09830dbd6..9eb8f70836fd 100644
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


