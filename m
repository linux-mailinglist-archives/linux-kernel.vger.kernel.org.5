Return-Path: <linux-kernel+bounces-142648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534F8A2E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9302893D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A99858AB2;
	Fri, 12 Apr 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B4LbjRiS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047458208;
	Fri, 12 Apr 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924939; cv=none; b=Bq1TZIsggk5jaPgXyz/zsDyRuGUd0BD/0DX7Y3wmyGly9Gom64XlqPcVLFXD8MxcRh5eygntRxeNB+kzvMWSVgGSOqakfk8BlOKwLeaggAk/SWpIWu2CRsQtAWHE4Xqe4O7ljw/dkevrD9HoHBKDXnAdXJwivj1F1mz53sWbt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924939; c=relaxed/simple;
	bh=xUKhjYne1PQbG8vIO3b05INY/3cYr2+/BJz/lQT/pUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+cGR3F1J9hJnrO9dvzEvC3bLrIhT6Y9y4Zq5mO9gk7gEJeJtmjAYfERPryKaAAurveHJRv9n+6O3/hJvTVOpDmJFxPve2Kdm5ubTqK5vy+w16mCPB04ka0MiaL+SU1DhqWysnY57fh5oHiI7/au5Vr9iYnwyilo9/0JT2idrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B4LbjRiS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D169C8E1;
	Fri, 12 Apr 2024 14:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712924893;
	bh=xUKhjYne1PQbG8vIO3b05INY/3cYr2+/BJz/lQT/pUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4LbjRiS0VYvVKeQ1uZT45rB52wuFroq+0bfMVxwq8Kcau3NvytUICCsXfBGZ+WO1
	 Sc/w7dMbMCENgo0734btEV6b1NZaqb3os2u0qdyrkHjFKQOYheEBwFmmLjHjzFT5Z4
	 tyUnHttQ1M8cd/mWuNAMIPnrOq6JAeNTYC8zo80A=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v5 4/6] media: imx335: Use integer values for size registers
Date: Fri, 12 Apr 2024 17:58:40 +0530
Message-ID: <20240412122842.193713-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412122842.193713-1-umang.jain@ideasonboard.com>
References: <20240412122842.193713-1-umang.jain@ideasonboard.com>
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
index 29af5693eaf2..28ee7154d1f9 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -251,12 +251,12 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
 	{ IMX335_REG_MODE_SELECT, 0x01 },
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


