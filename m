Return-Path: <linux-kernel+bounces-107167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D09D787F85F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A940B22125
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D17537F5;
	Tue, 19 Mar 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="btPdLEhI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93736537F2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833260; cv=none; b=Fxp6MSjLsnl69uL0xRj0NFqUUyzoqD6udc0NV95GzY/iJxJety+um20Ji0IPb9sjO9+wHKNrtUQae1FYAM5mj5G1V0sBamznAfvWtz6175RcSbVXq9cK6bdwELkgSBXCGW/FTnjeBm7NSI9MY0+h+8CTch9rIs/2wpgEFmked7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833260; c=relaxed/simple;
	bh=IRwMtyb4x/4E+/zf4v8H5ilEmr4iukiP6112eEdyElc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrVNmS4dHiyu8Bwr8+J1NmzPHv0qtbwyPr5RQrXtt4/EPlqrvSeWftFOwwSMfQm385dFWkTg5PFsJzzv50BK1Cx7FFKvJzmDQ6nJo7BBZjoorw+1iU1h7gEDJD/iPm0lIdz5H61/p3V/AIPp8qrMkEW/GNSDyuaUKR1BbMpYYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=btPdLEhI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04FF5BB2;
	Tue, 19 Mar 2024 08:27:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710833230;
	bh=IRwMtyb4x/4E+/zf4v8H5ilEmr4iukiP6112eEdyElc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btPdLEhIWcfrB8NhBWdbSMxp+dWzZDO0ezbbEsFzT3mRm6INwEapTgpDRWl2Swkdo
	 lLq7mzMyK7W+Fg4GnVb8H04Kujklue9P3KroKFHqyUVvfDa5tJsqcmGWDvAz8//NTb
	 R5TOH2B4o2onTgXoog9qemBrXXzce/NednkojHLA=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v3 4/6] media: imx335: Use integer values for size registers
Date: Tue, 19 Mar 2024 12:57:10 +0530
Message-ID: <20240319072712.133449-5-umang.jain@ideasonboard.com>
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

Consider integer values for registers that are related to various
sizes in the register map. This helps in improving the overall
readability.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/imx335.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index ae4341644a84..7609dbc537b1 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -251,12 +251,12 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
 	{IMX335_REG_MODE_SELECT, 0x01},
 	{IMX335_REG_MASTER_MODE, 0x00},
 	{IMX335_REG_WINMODE, 0x04},
-	{IMX335_REG_HTRIMMING_START, 0x0180},
-	{IMX335_REG_HNUM, 0x0a20},
-	{IMX335_REG_Y_OUT_SIZE, 0x0794},
-	{IMX335_REG_AREA3_ST_ADR_1, 0x00b0},
-	{IMX335_REG_AREA3_WIDTH_1, 0x0f58},
-	{IMX335_REG_OPB_SIZE_V, 0x00},
+	{IMX335_REG_HTRIMMING_START, 384},
+	{IMX335_REG_HNUM, 2592},
+	{IMX335_REG_Y_OUT_SIZE, 1940},
+	{IMX335_REG_AREA3_ST_ADR_1, 176},
+	{IMX335_REG_AREA3_WIDTH_1, 3928},
+	{IMX335_REG_OPB_SIZE_V, 0},
 	{IMX335_REG_XVS_XHS_DRV, 0x00},
 	{CCI_REG8(0x3288), 0x21}, /* undocumented */
 	{CCI_REG8(0x328a), 0x02}, /* undocumented */
-- 
2.43.0


