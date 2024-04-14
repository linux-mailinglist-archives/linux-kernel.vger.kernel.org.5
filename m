Return-Path: <linux-kernel+bounces-144177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4BC8A42C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B07B20FE4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2159B5A;
	Sun, 14 Apr 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i5f2//Or"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40458AD5;
	Sun, 14 Apr 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103603; cv=none; b=kA2OrQpaSnmz8E1o2+4YMmUdl7R5S/j04VV1VG7fg39Hhfla5FVzO3oG40TZDCcmdMBIcdp/qN96HCU50bVUdQCyz6keDb58X/fLDCtFQ1VemYE8sNPyZw2AA6+MrAIR9XgMvUmB15UsgYD8sIWC+2xcxpdLI6s1ig8WMqXLkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103603; c=relaxed/simple;
	bh=fg6Uq5xNcfarqQSitI83UFpubzA8r2ocMeyrDvpCIBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO4M6wqqiHuAN5O2klMYjiTgKMF40/+JaAOTMm9SPemUFQM5xVJoT/DBl3j7+SwOOF7SM9KUzjXMV5HHiwbtvXePSNw9JoXqgHMvrveZIMtJbJOg7ErhVwFIaMI9Gdn7pZ5zj1WHlkfDhExVCIWMqwGZxymrx82d0q3L6b6Otfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=i5f2//Or; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.238])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AAE44842;
	Sun, 14 Apr 2024 16:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713103556;
	bh=fg6Uq5xNcfarqQSitI83UFpubzA8r2ocMeyrDvpCIBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5f2//OriuRoFyiZdrI0QNtkf4QGMBi4DzyhOu0yZDbiIOuuWuIszirMPruDf2wRl
	 BpOJBXVT1gv5XgjT1ZJYOuIOrMemcVAXq8QcImcth/+f4pj1qQJkE55AXrAaMI944B
	 e+oQhtI0zErBwJsT7G2zU3O9/XftDhg0klBy9D4E=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v7 4/6] media: imx335: Use integer values for size registers
Date: Sun, 14 Apr 2024 19:36:19 +0530
Message-ID: <20240414140621.167717-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240414140621.167717-1-umang.jain@ideasonboard.com>
References: <20240414140621.167717-1-umang.jain@ideasonboard.com>
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
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 52761a3b4d65..d25fb0ecdf20 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -255,12 +255,12 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
 	{ IMX335_REG_MODE_SELECT, IMX335_MODE_STANDBY },
 	{ IMX335_REG_MASTER_MODE, 0x00 },
 	{ IMX335_REG_WINMODE, 0x04 },
-	{ IMX335_REG_HTRIMMING_START, 0x0180 },
-	{ IMX335_REG_HNUM, 0x0a20 },
-	{ IMX335_REG_Y_OUT_SIZE, 0x0794 },
-	{ IMX335_REG_AREA3_ST_ADR_1, 0x00b0 },
-	{ IMX335_REG_AREA3_WIDTH_1, 0x0f58 },
-	{ IMX335_REG_OPB_SIZE_V, 0x00 },
+	{ IMX335_REG_HTRIMMING_START, 384 },
+	{ IMX335_REG_HNUM, 2592 },
+	{ IMX335_REG_Y_OUT_SIZE, 1940 },
+	{ IMX335_REG_AREA3_ST_ADR_1, 176 },
+	{ IMX335_REG_AREA3_WIDTH_1, 3928 },
+	{ IMX335_REG_OPB_SIZE_V, 0 },
 	{ IMX335_REG_XVS_XHS_DRV, 0x00 },
 	{ CCI_REG8(0x3288), 0x21 },
 	{ CCI_REG8(0x328a), 0x02 },
-- 
2.43.0


