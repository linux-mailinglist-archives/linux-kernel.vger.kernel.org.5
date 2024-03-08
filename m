Return-Path: <linux-kernel+bounces-96659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F0875F9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B31F23F16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FC0535D7;
	Fri,  8 Mar 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sm6PajLX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1735339F;
	Fri,  8 Mar 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886821; cv=none; b=iW/bytEw5cY5qtdmYbrgQLBVvBkoik7HuBcInZYt8CTwMd8lsswnsnG9bgxB8a9NnKd3/scbYPV/s9FhisJ9LhiPbSEodEP/zci/lEG73jpYDnvhSAtKFu7uT3X48Xp3XgnsNB16ltmmES41u98whXuZsxNhS92xQkKe6OD0/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886821; c=relaxed/simple;
	bh=MlRH48ZF04z/HajcQIgfxmck3RSeXWbjOHzpdkvshzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKMkTb95yozcs/3Nr/GjRBgFekyfuNj5hwVJ/lwyMyY/ozTXzYGjvQoNeOwI1g+oN6x3VL6lXncLuOxAfG9e2fuwFSfJK8V6WALRAq9LDvuf1KqUMbyT3E65/6TpxMrd+ulxL71gbJiCdXtlUxOkd5YChz2xvvemCcTQY6LwMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sm6PajLX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7067A82A;
	Fri,  8 Mar 2024 09:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709886800;
	bh=MlRH48ZF04z/HajcQIgfxmck3RSeXWbjOHzpdkvshzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sm6PajLX7Ehsy1eJsKoSLZV1JazeFW0W7ZUY/zDaxAD3VIMNkTp1/DFFK9KSuYaK2
	 B9HRJDRWAnu5yIGBuH0mnx8HFxLyiTUsUUA5SWJG/vEG91DM12WQOjORv+WEwahcPz
	 9f0N6VZbkRl6xVNBVOCCxLU2KoK6ndQI8pynnJkU=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 5/6] media: imx335: Fix active area height discrepency
Date: Fri,  8 Mar 2024 14:03:11 +0530
Message-ID: <20240308083312.90279-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308083312.90279-1-umang.jain@ideasonboard.com>
References: <20240308083312.90279-1-umang.jain@ideasonboard.com>
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

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 3c593538f727..85cb53e3d5d4 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -246,13 +246,13 @@ static const int imx335_tpg_val[] = {
 };
 
 /* Sensor mode registers */
-static const struct cci_reg_sequence mode_2592x1940_regs[] = {
+static const struct cci_reg_sequence mode_2592x1944_regs[] = {
 	{IMX335_REG_MODE_SELECT, 0x01},
 	{IMX335_REG_MASTER_MODE, 0x00},
-	{IMX335_REG_WINMODE, 0x04},
-	{IMX335_REG_HTRIMMING_START, 384},
+	{IMX335_REG_WINMODE, 0x00},
+	{IMX335_REG_HTRIMMING_START, 48},
 	{IMX335_REG_HNUM, 2592},
-	{IMX335_REG_Y_OUT_SIZE, 1940},
+	{IMX335_REG_Y_OUT_SIZE, 1944},
 	{IMX335_REG_AREA3_ST_ADR_1, 176},
 	{IMX335_REG_AREA3_WIDTH_1, 3928},
 	{IMX335_REG_OPB_SIZE_V, 0},
@@ -403,15 +403,15 @@ static const u32 imx335_mbus_codes[] = {
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
-		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
-		.regs = mode_2592x1940_regs,
+		.num_of_regs = ARRAY_SIZE(mode_2592x1944_regs),
+		.regs = mode_2592x1944_regs,
 	},
 };
 
-- 
2.43.0


