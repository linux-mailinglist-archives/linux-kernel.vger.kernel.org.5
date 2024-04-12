Return-Path: <linux-kernel+bounces-142997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4125B8A330C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7182A1C24591
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9BE149DF7;
	Fri, 12 Apr 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kjPw9QTA"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A4149C6E;
	Fri, 12 Apr 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937666; cv=none; b=ICq2YwGyEP02/ca1CkIxTN+11JMinfsjd40t7EH0V4YFsSsNFsuB25KzNhlCfaJk0YKgcAerlZ56deMDvOW7oeODsiGab2fZWEK2ChyiJxcTNSq5Fc6xEtmyL3cgPdf4FpLIjRTKL4EsXTR+n7bfbka0itBG58xAXGIi3fcUc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937666; c=relaxed/simple;
	bh=nedm6zi8DyZqLwdQGV6XrSR9pKc//sEbjxK8/qHwmRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2G0NebLYYR/vaAHKUM1YcjWvCdRyYDdzi6qOFJy6wdUamRoge0hhCTpqqVq+O/jFyXkiiKG/V9PBM9N5FBMVAOosh/Kxcwe9F/7lgLC/pO2A6yoMYZf/eHfD3e+dU/lUGEwjBG/O6KpDRjvumB8TtYYJPFKV6dM70rxq60hUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kjPw9QTA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77615149D;
	Fri, 12 Apr 2024 18:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712937620;
	bh=nedm6zi8DyZqLwdQGV6XrSR9pKc//sEbjxK8/qHwmRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjPw9QTAFhqqir9sru5BzNgJgCN5jhBiGBua26AAA/JxHht2fu2ewJ1gMNXzHkmud
	 C9g5t1fRMBXcxsh6E0/1RhC66AI78GYGljE2ByIsRycVybwaFX3rWSpyWzRtO4+zGw
	 9MG5JfOm7uH/IswYKCsv5KniNu7aj/tiXIE87CCU=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v6 4/6] media: imx335: Use integer values for size registers
Date: Fri, 12 Apr 2024 21:30:37 +0530
Message-ID: <20240412160039.276743-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412160039.276743-1-umang.jain@ideasonboard.com>
References: <20240412160039.276743-1-umang.jain@ideasonboard.com>
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
index ee22304f827e..7548518359bc 100644
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


