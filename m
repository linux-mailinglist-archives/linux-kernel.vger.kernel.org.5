Return-Path: <linux-kernel+bounces-93478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC1873055
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46201F21332
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8365C057;
	Wed,  6 Mar 2024 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VGypEzCq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C15CDFF;
	Wed,  6 Mar 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712672; cv=none; b=MjtrLzUTcgrV5f2OvtoqRkr1QHquGpJ9AR0K4MgtDd8dkMvvCdKlY8lYu9Zzp1c1p/wZyGIl0yxm6lzcySqmmpNXbmqpDyr6JevommyO6s/0GBHI1T1SBrhMWmN3JUiAxw40n909YSvNORC1iHLL3ma5cjT++iO75GJOdCAoapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712672; c=relaxed/simple;
	bh=qhSfwgByJCp2UJ9Lmg9P2YciIUlKkzafGTiPwMse0eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taF0RdPp0v4LQSYsMhWmpymPrHA0EHHYHJvBAnThrlasVc3T3t1VUspS3VlfpQrwrzpBV+71kmg/SQpCuwOjtUP9+KX+ltWGKdYczeos+rRx0x++emzbugZqc/f5idXUs5aQyM+xoVYLbMjsEbPnMC71hQzMp/EAOdOl92o8kVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VGypEzCq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA9E8C8A;
	Wed,  6 Mar 2024 09:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709712651;
	bh=qhSfwgByJCp2UJ9Lmg9P2YciIUlKkzafGTiPwMse0eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGypEzCqD/L6eiGXH49W8rn9xZDVP0ph03UIdrwG76T1ktoj6b4RhWoka0LBw05dz
	 9OiqM9ZTn3JGvV7RmOwgaA2Nef1aiG0q2UtsJDzyOTsstERg5HDIL1UQC93NQZZoNJ
	 an1XYhg5pjXM4oRUTUAFrTug1npWa+APJo7yAbz0=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 4/5] media: imx335: Fix active area height discrepency
Date: Wed,  6 Mar 2024 13:40:37 +0530
Message-ID: <20240306081038.212412-5-umang.jain@ideasonboard.com>
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

The imx335 reports a recommended pixel area of - 2592x1944.
The driver supported mode however limits it to height=1940.

Fix the height discrepency by correctly the value of height
(with updates to vblank and mode registers).

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 6ea09933e47b..c00e0c2be3f3 100644
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
-	{IMX335_REG_HTRIMMING_START, 0x0180},
+	{IMX335_REG_WINMODE, 0x00},
+	{IMX335_REG_HTRIMMING_START, 0x30},
 	{IMX335_REG_HNUM, 0x0a20},
-	{IMX335_REG_Y_OUT_SIZE, 0x0794},
+	{IMX335_REG_Y_OUT_SIZE, 0x0798},
 	{IMX335_REG_VCROP_POS, 0x00b0},
 	{IMX335_REG_VCROP_SIZE, 0x0f58},
 	{IMX335_REG_OPB_SIZE_V, 0x00},
@@ -403,14 +403,14 @@ static const u32 imx335_mbus_codes[] = {
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
 	.reg_list = {
-		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
-		.regs = mode_2592x1940_regs,
+		.num_of_regs = ARRAY_SIZE(mode_2592x1944_regs),
+		.regs = mode_2592x1944_regs,
 	},
 };
 
-- 
2.43.0


