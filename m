Return-Path: <linux-kernel+bounces-128114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9EA89564F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD46D1C22A36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859733D1;
	Tue,  2 Apr 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ao6w8NtL"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD2130E54;
	Tue,  2 Apr 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066991; cv=none; b=a9gUtsvFOxP9dIO+Mn4pbIOJVDGgs0D3pT+NfVUrRfos4H91eX9Ukg2yy/D5DPUpz7dKVRD+xM7PjePUNup9cIlU3T3qdUoso/ttlosg3rx0aYDPTRum99xSyI2DnZAKw7jyQZVRxDR5hpGpFHSiKamtHnt290YbMOCnUBGrndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066991; c=relaxed/simple;
	bh=PyIx/UZInzxp7BPcrqcGcDxhndNCO7GRz/DPzLNkSu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvK65QO8J3XBMiIq0PT/EUqSnNAewO3tFFRKWLgJh44ARfNnyXVRcDn8o4kfcUhRdugphARrdzQlSCZdjVfz4XKhKP2mKL/BxrY5o6riQsk4IBHa8qyAXaIv4aI+gFKDQkJv/IhP2SI6AyXHH3j2OxwB+197xpkpSzDV2/4BU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ao6w8NtL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 30CFC9CE;
	Tue,  2 Apr 2024 16:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712066952;
	bh=PyIx/UZInzxp7BPcrqcGcDxhndNCO7GRz/DPzLNkSu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ao6w8NtLclQYuFu+7bX7cUmlAcL8k04jXaZ5vIziROxaBwZNjO4l4x+R6NM6a6R//
	 KYIpvdJOGSQpurU++b/0OIZ/LQkhCpORAMKSB6Pkq/ejI8XxOH8jZXsZ/QHs0tzVEO
	 3REm4MOamzMJsIm/m7Et7poyCLzYG+40Wby6cyu8=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 5/6] media: imx335: Fix active area height discrepency
Date: Tue,  2 Apr 2024 19:39:23 +0530
Message-ID: <20240402140924.10009-6-umang.jain@ideasonboard.com>
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
index 7609dbc537b1..dfc24783dc34 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -251,9 +251,9 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
 	{IMX335_REG_MODE_SELECT, 0x01},
 	{IMX335_REG_MASTER_MODE, 0x00},
 	{IMX335_REG_WINMODE, 0x04},
-	{IMX335_REG_HTRIMMING_START, 384},
+	{IMX335_REG_HTRIMMING_START, 48},
 	{IMX335_REG_HNUM, 2592},
-	{IMX335_REG_Y_OUT_SIZE, 1940},
+	{IMX335_REG_Y_OUT_SIZE, 1944},
 	{IMX335_REG_AREA3_ST_ADR_1, 176},
 	{IMX335_REG_AREA3_WIDTH_1, 3928},
 	{IMX335_REG_OPB_SIZE_V, 0},
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


