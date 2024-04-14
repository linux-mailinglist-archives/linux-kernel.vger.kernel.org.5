Return-Path: <linux-kernel+bounces-144178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E388A42C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F8D1F2144F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637345A110;
	Sun, 14 Apr 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eHcv+Gmu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6E59B7E;
	Sun, 14 Apr 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103606; cv=none; b=YFSvmTIMLNkXeEOYAwfIr4IP8RyI4LYDAEFlsWz8Cr1Z283ZD87Ti1izRFwOcQ4wIbpcJ1KsF6o1hUxSj6YlTeamlpT2XYXgh+zOe/B6lM3vJWscD4CZEhvT9/V+2VBwOHCw3sz6FWUC4oaY64wbz2gTm0dbLHu/9eC6Ih0NNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103606; c=relaxed/simple;
	bh=oVLTIRnsLiywaaA58tZdbnC3bT4/p5J0VJqlMZgfG0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3dOklXNtg0h2ke+TL47Q9S83/7hnU8gZm015GfP8C6z4PT7bIyh9VOi1EeIChVc+etb15j7qOTmb7YGngsEsuzsO6sPiJ4IT2nJyCjs91YPXoYJxg1gLpdhRVSUO9whTll/oNYQwhP5llp8nWi/E0Lv8eIcsucdAYJKhemdJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eHcv+Gmu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.238])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B783114AF;
	Sun, 14 Apr 2024 16:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713103558;
	bh=oVLTIRnsLiywaaA58tZdbnC3bT4/p5J0VJqlMZgfG0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHcv+GmuS9erBtlSXrR8oljhg4+sDxAD7snKaBy2HMoURgBsaL4Q5/f2QuNrmOF+w
	 btrKX4KSUjBuV+yYkiYAjoUB19XJP4q7ZW6cTVN6jfSQ938bF5JmN6AzG9Z5whBGjq
	 ZKcDE1qNpHHwgHrUeOpCdMJxRQCUYRcktAE1WcWQ=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v7 5/6] media: imx335: Fix active area height discrepency
Date: Sun, 14 Apr 2024 19:36:20 +0530
Message-ID: <20240414140621.167717-6-umang.jain@ideasonboard.com>
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
index d25fb0ecdf20..31d3b95cc0ef 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -255,9 +255,9 @@ static const struct cci_reg_sequence mode_2592x1940_regs[] = {
 	{ IMX335_REG_MODE_SELECT, IMX335_MODE_STANDBY },
 	{ IMX335_REG_MASTER_MODE, 0x00 },
 	{ IMX335_REG_WINMODE, 0x04 },
-	{ IMX335_REG_HTRIMMING_START, 384 },
+	{ IMX335_REG_HTRIMMING_START, 48 },
 	{ IMX335_REG_HNUM, 2592 },
-	{ IMX335_REG_Y_OUT_SIZE, 1940 },
+	{ IMX335_REG_Y_OUT_SIZE, 1944 },
 	{ IMX335_REG_AREA3_ST_ADR_1, 176 },
 	{ IMX335_REG_AREA3_WIDTH_1, 3928 },
 	{ IMX335_REG_OPB_SIZE_V, 0 },
@@ -408,10 +408,10 @@ static const u32 imx335_mbus_codes[] = {
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


