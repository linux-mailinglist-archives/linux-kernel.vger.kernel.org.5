Return-Path: <linux-kernel+bounces-109929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED058857E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22B91F214D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D05FDD1;
	Thu, 21 Mar 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n674ajER"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA35FDAD;
	Thu, 21 Mar 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019594; cv=none; b=C89bAXrjEgbRKTrO/Jj+bw/J9UfXEU7Vo0a6g/thJorCs6Kd1L5fKdiq0gb/y10SCucii5I0B0e7GD/WxLxFZajPRhpUbJcOimPJ9YLFP9cR4x9Iz9UrRRjY1W9OPFX268fI3JyO59FU5wQ5z2iggzbd1CV1Z5+ISylmEh/Y5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019594; c=relaxed/simple;
	bh=IRwMtyb4x/4E+/zf4v8H5ilEmr4iukiP6112eEdyElc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvDQNELtA7WvA2V/QPO0hN8s1nS2WbOI4iqI/IQzqJdoXbw2jXObxIWSXArcm/67w/sYx9Iiqx3Ca0O1pIW5jLxk1FALOdAjSjzpJRrFSR806Pw+H2t8XM4cY6ND7opb3Jfg8vEn/EIrjQi6kfZmPwROZqz8woMg7xdpR3jIkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=n674ajER; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB33A8CC;
	Thu, 21 Mar 2024 12:12:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711019563;
	bh=IRwMtyb4x/4E+/zf4v8H5ilEmr4iukiP6112eEdyElc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n674ajERnF2D6okJpw3NP6Zi0DrhiY62DoXu2d8IhWuklRVaTOqBu1zCvldsl/YaH
	 SFppBdjMpZMCFx5IE/1lpQIFoFR1veF3e6SG2mJnT3NYR+tyMg+U/7KNB3/Dd2ZLZK
	 vjddEGSzLDc3myVoaghSH/4gHT2cO0wOvE3sZtlQ=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v3 4/6] media: imx335: Use integer values for size registers
Date: Thu, 21 Mar 2024 16:42:37 +0530
Message-ID: <20240321111239.808735-5-umang.jain@ideasonboard.com>
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


