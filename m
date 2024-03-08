Return-Path: <linux-kernel+bounces-96658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F78875F97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33535284A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172153389;
	Fri,  8 Mar 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JqC4+l0J"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A552F94;
	Fri,  8 Mar 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886818; cv=none; b=hPNteO+442A6OEp5mNfiUSMK20DLjRalC7WKVBr3k9V+5sFUFI0EQs62cIJRvCvxygKw5zUxUxQ63EgdO7YvDS05XmOEDVBAr+HYy1BvmN/h+QVUy5k9wZU/t6Gha28D5zCFEhHRTsMa/5gfpmoF7ngDG5ij/mGRwCJJLRS4Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886818; c=relaxed/simple;
	bh=Ty7xiUSOfFEj7v0WrV6IQaaR5urMXJmbglW6AqDW5nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfyIPvo0A1zkLmX8mwudcbDep+eN2Eti7+IFc6i7mwRMqhAzVwZoOr338gmH6bf2KyT1vdRn7yzbS4qkV322Kw/i60wobOG6LzTewHcriYAACjzTAwa7rjEwfToQlBujIcN8L8yS5VuhcbBPHhac8zYxL5EaFF+3sVO1Vo1hhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JqC4+l0J; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DFC23552;
	Fri,  8 Mar 2024 09:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709886796;
	bh=Ty7xiUSOfFEj7v0WrV6IQaaR5urMXJmbglW6AqDW5nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqC4+l0J7rfCDPEjTgq4HWLsY4COQ7XSTd1w1pbqNUb3OHpxT5/3yA2vNas20faWF
	 zjKNSrrsu0AsbXA5lr+YcsHrTtnopgVsbErpI54sO8tH62k8deOCP5bZOIuP8JHK95
	 80Lsdpwu581FLbyLY+84xN8C+swoZ+bC+8eVRYds=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 4/6] media: imx335: Use integer values for size registers
Date: Fri,  8 Mar 2024 14:03:10 +0530
Message-ID: <20240308083312.90279-5-umang.jain@ideasonboard.com>
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

Consider integer values for registers that are related to various
sizes in the register map. This helps in improving the overall
readability.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index ec27035586f3..3c593538f727 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -250,12 +250,12 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
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


