Return-Path: <linux-kernel+bounces-128113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0889564C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EF11C224CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95112FB27;
	Tue,  2 Apr 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QJI3rfHG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DD12CD90;
	Tue,  2 Apr 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066988; cv=none; b=XQR8/lKPXq4ICICjbs3Lu//7BWrb4kr1grQnmzSH8DM4EiFW8/SW4qcwz14Q5JGuqldlTyiQNozvHqE/FCMSFlVuu9uXnd5wHFSekModTXaggPTJNpHlhYMtyJxS0zd4pu1x9D2C1qU/6uRKlMtptoJnKiThUwfatyhdygOjFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066988; c=relaxed/simple;
	bh=eQ5uEA5OcnszbHkXkUUDNe07QiOYUc/9WnRknYUTkNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq9QVH46h6vbosMFezYGODjX2bW2l1tznj4TfqI/v4H4VfNumagh/jzs7bfqahFXaOp7X12nErNh/ikCJro68jqHdv9j1Be8imYwOhkcsHlyOhpJYjVP9+MaBvc8eOtaHBlV4dYXPBV0/eDDaYtoMVWvGEgZ+w3EaevdLSbRr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QJI3rfHG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F343D8E1;
	Tue,  2 Apr 2024 16:09:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712066949;
	bh=eQ5uEA5OcnszbHkXkUUDNe07QiOYUc/9WnRknYUTkNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJI3rfHGvHGeemAAbLW23z18aR3DhkIEU+Idzve7IRo6d9Y/iSvjZKZw0hr2c6dce
	 YZWdqC7G3Qdsi5MSamKM+ln+VL0zxU+AHps5O3gtn+r9O6UTPSbwGM45HRyJOi0gZp
	 5A/gQ9XqxY47+HeTEGwc+iw6kXoox6CYE6w7H7cQ=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v4 4/6] media: imx335: Use integer values for size registers
Date: Tue,  2 Apr 2024 19:39:22 +0530
Message-ID: <20240402140924.10009-5-umang.jain@ideasonboard.com>
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


