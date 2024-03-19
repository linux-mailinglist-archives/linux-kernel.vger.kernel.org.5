Return-Path: <linux-kernel+bounces-107168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710087F863
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C621F2360E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C584D7C6E3;
	Tue, 19 Mar 2024 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h4zSvmL5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB497C093
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833263; cv=none; b=Sb/Qm6754rhVf/zKUUlx94tk+31cWgYacJQANFV7+e5Wvk68hebYxOgmHcFB0xWEam8afu80J5Oydsc0yOJdWFzh0gEcXLTW0enChs7JmlM3ufRtag3lEgOp1YDSmOK2CGrE7L6Gi5nbi4a1rtWpLc0QGcpdDDNUx+GdIv83qeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833263; c=relaxed/simple;
	bh=44YruKIFMTjc0cJLAC1iQg1GbtFM4OBpdvY6e1NRpRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVkgWyidS//ZKB3Nncw/7Y0gi1AdusdRKHUk5oodwSSpIQjGt8i5j+Auj4OC5WCDmG62qfdsTlXy090s1zJbRgjpJ9ccrjjsMBq5QBWI1ml7n57VRt9fAZyXmuie0W47jncbmuV+euii3tYbZ+4H7OzoqR/+viL3ety2TZpnT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=h4zSvmL5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AB6FFC80;
	Tue, 19 Mar 2024 08:27:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710833234;
	bh=44YruKIFMTjc0cJLAC1iQg1GbtFM4OBpdvY6e1NRpRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4zSvmL5jjsgHzVvn8+aA4K3gRg+FMBiX8waAAikkisV3lIBlEKusWPGJQpJN+vdZ
	 KxkhT0ydv2d8yu0pSqZApXX3/i8k/uu03OrhtZ7ONWJSsaPkTujk6zGml5kpB1XBqE
	 kfC/5BYVk/SixUBNSaEEwSQwkzphMqdHtdHh9VXg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 5/6] media: imx335: Fix active area height discrepency
Date: Tue, 19 Mar 2024 12:57:11 +0530
Message-ID: <20240319072712.133449-6-umang.jain@ideasonboard.com>
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


