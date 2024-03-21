Return-Path: <linux-kernel+bounces-109930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF68857E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C9C1C21663
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03196026E;
	Thu, 21 Mar 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SM2LfTqd"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA725FF0E;
	Thu, 21 Mar 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019598; cv=none; b=FX5sYsb3btdA4gsiN9cHV0DxuFlzBUbkPKZYW6MGeMKc0Y3erUJ4I52QUGsnWRKNUIMxvhJtLxLy5pFfSxfkZo0zTYUTfS/pfygFQ4AvP7Irkd6k8TFkEIBm2rAKjtf4GtlLIgkflK6aRyaEowldr9DP4DlNHvlxSAxQLarQfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019598; c=relaxed/simple;
	bh=44YruKIFMTjc0cJLAC1iQg1GbtFM4OBpdvY6e1NRpRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMTE3ClKF0XcnJ2mcceIblk5gJiFuABBuLA6D/ihbtFhHK3hP8cnECxRtm74LWlcQOuUdK2m50AQZzfSmTSlPt6x89Oc5av74P8XxkgMOqM7fZYWrVx/oXXklMRoVI/pNy7nmowynL5q2C6ZW9ohK08HB8lQF8NuIO32M4o4d7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SM2LfTqd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C26A7E9;
	Thu, 21 Mar 2024 12:12:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711019567;
	bh=44YruKIFMTjc0cJLAC1iQg1GbtFM4OBpdvY6e1NRpRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SM2LfTqdemsZOTpaeS2hRoFb6OuXwSN7OB9Oz4BY03i8Wd+pob54j+3Ghhzmyvdwr
	 l1aJFdhYV87ALyHTBPdITSrrflhS7Jwzyds9UGd+a59u2kiw6VFXp6nGhL9vhbSRaL
	 7DXnjOejWSMiOss0yzBSSyRtogzZ9Ak3J/KbgHVY=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 5/6] media: imx335: Fix active area height discrepency
Date: Thu, 21 Mar 2024 16:42:38 +0530
Message-ID: <20240321111239.808735-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321111239.808735-1-umang.jain@ideasonboard.com>
References: <20240321111239.808735-1-umang.jain@ideasonboard.com>
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
index 7609dbc537b1..10a09830dbd6 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -247,13 +247,13 @@ static const int imx335_tpg_val[] = {
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
@@ -404,15 +404,15 @@ static const u32 imx335_mbus_codes[] = {
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


