Return-Path: <linux-kernel+bounces-142998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF58A330E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93684286EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737E14A09D;
	Fri, 12 Apr 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nMYekYB4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA565149E1B;
	Fri, 12 Apr 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937670; cv=none; b=mSU+DPdZvgw0D6PTBiaFnAT8g4iEE+yZnlJUmwKKrc9223PvTuyEnvVg1lWZo65Dj8GhBZTJekZ0QiRXYUz5PkK+YgQIhxerHNd7FAry+VwuaD7qRM/cF6JaiFD44hq6Mt9q5iar8j1+D8YGKtQY33DVIsIxf/VJBuwEwJojP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937670; c=relaxed/simple;
	bh=/h8CcxylegMAKWKZugzBnB81wb7Qm9AKKVd/DWM8vBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnA4GtuglzGpofkMVSduUw0lB5D2lwEGNtNN9xh+Prca6AWLDQ+1UFSk1cZJoBeLnKEGzEaGAfSNyRCqO8Iq2tk/PJQRofIjEIzjJTC5n3IIct37I4yqzfRccHzzZpH2Q0w4ZX66SkV5wOEmTlb/mbyIvehEsNOb1rJB4TMKXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nMYekYB4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3485BD01;
	Fri, 12 Apr 2024 18:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712937624;
	bh=/h8CcxylegMAKWKZugzBnB81wb7Qm9AKKVd/DWM8vBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMYekYB4DKMis5bvo+HzYDHb3Ih4gaTA0+NQX6MuyXQk7lVrL7svjKBgW9dtqIrVH
	 iMGRAkFob7HuFs4jLmRZ8Y/8f0sKAeEbvMLSsgnXKZoK+5HU273BFDKVlms/3+mTWj
	 cY8oMlCVBqmGiu6JCXAYGbIPYoKHyGbN/8EyCPXA=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v6 5/6] media: imx335: Fix active area height discrepency
Date: Fri, 12 Apr 2024 21:30:38 +0530
Message-ID: <20240412160039.276743-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412160039.276743-1-umang.jain@ideasonboard.com>
References: <20240412160039.276743-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imx335 reports a recommended pixel area of - 2592x1944.
The driver supported mode however limits it to height=1940.

Fix the height discrepency by correctly the value of height
(with updates to vblank and mode registers).

The IMX335_REG_HTRIMMING should also be corrected to the start
offset(i.e. 48) instead of chosing a abritrary crop start of 384.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 7548518359bc..dfbab39d69b9 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -251,9 +251,9 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
 	{ IMX335_REG_MODE_SELECT, 0x01 },
 	{ IMX335_REG_MASTER_MODE, 0x00 },
 	{ IMX335_REG_WINMODE, 0x04 },
-	{ IMX335_REG_HTRIMMING_START, 384 },
+	{ IMX335_REG_HTRIMMING_START, 48 },
 	{ IMX335_REG_HNUM, 2592 },
-	{ IMX335_REG_Y_OUT_SIZE, 1940 },
+	{ IMX335_REG_Y_OUT_SIZE, 1944 },
 	{ IMX335_REG_AREA3_ST_ADR_1, 176 },
 	{ IMX335_REG_AREA3_WIDTH_1, 3928 },
 	{ IMX335_REG_OPB_SIZE_V, 0 },
@@ -404,10 +404,10 @@ static const u32 imx335_mbus_codes[] = {
 /* Supported sensor mode configurations */
 static const struct imx335_mode supported_mode = {
 	.width = 2592,
-	.height = 1940,
+	.height = 1944,
 	.hblank = 342,
-	.vblank = 2560,
-	.vblank_min = 2560,
+	.vblank = 2556,
+	.vblank_min = 2556,
 	.vblank_max = 133060,
 	.pclk = 396000000,
 	.reg_list = {
-- 
2.43.0


