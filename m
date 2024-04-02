Return-Path: <linux-kernel+bounces-128107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C389563A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA34E2842FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50A85925;
	Tue,  2 Apr 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vVbYjLtP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093985C46;
	Tue,  2 Apr 2024 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066977; cv=none; b=L1Sc1Ye8PABkITIWePkvI5J20V4z5EXgbDnsMWkIZjRVCBHCT3T4hX96UjpPQ0MWtXBL1leIHLpQOwkDCJtW5ZpFz5n1xw4KDLngjGGdCtiQGn18vQKVOdLGgn3UwLUCFOdki36Eb640wRlpDRyLMwExH4Kllhn3Joe6hJRg2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066977; c=relaxed/simple;
	bh=aGc5dcE7aUaQO/qAQe2vO/xLUnnz35AEw5nLynNCBdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R59zMBWomorDiA5oT/KnwSpXckbe1vEIpDBFKABBKSmwTzTpEl4UPpYzWGxUrRbyeSC17OmTc58TdbKh8cOHuIKOgkr0a8GoOaXTJ6xzdxh/4KwQBomhfJmTrjnhNyB7stwoQq5nvOyZ6eo9j21UyyzVNCiaojgwWlB1lt6FJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vVbYjLtP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A840466F;
	Tue,  2 Apr 2024 16:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712066937;
	bh=aGc5dcE7aUaQO/qAQe2vO/xLUnnz35AEw5nLynNCBdE=;
	h=From:To:Cc:Subject:Date:From;
	b=vVbYjLtPKNPcuqVuFQf5Bg3RgqaiKdraOEtOciOxbymeG71cp3J9dHiwdt97Ixdis
	 A4CQJX3arv4VUd0N6wXIX7K1p6Wu3iv3hgP3OBLWl3twCoI4P7H2XbFNNREtsB3RKh
	 96VQMLDzA0XRKoE7aEVLXsRq3nXaCgLt9vtTgfb0=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 0/6] media: imx335: 2/4 lane ops and improvements
Date: Tue,  2 Apr 2024 19:39:18 +0530
Message-ID: <20240402140924.10009-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another batch of improvements of the imx335 driver.

Patch 1/6 adds support for 2 or 4 lane operation modes.

Patch 2/6 call the V4L2 fwnode device parser to handle controls that are
standardised by the framework.

Patch 3/6 introduces the use of CCI for registers access.

Patch 4/6 uses decimal values for sizes registers (instead of
hexadecimal). This improves overall readability

Patch 5/6 fixes the height value discrepency. Accessible height is 1944,
as per the data sheet

Patch 6/6 fixes the max analogue gain value.

Changes in v4:
- Do not change from window cropping mode in patch 4/6.
  In v3, the sensor was changed to all pixel scan mode to
  achieve height=1944, but it can be achieved in window
  cropping mode as well, by fixing the mode registers

changes in v3:
- fix patch 2/6 where we need to free ctrl handler
  on error path.

changes in v2:
- New patch 4/6
- Drop calculating the pixel clock from link freq.
- CCI register address sort (incremental)
- Fix cci_write for REG_HOLD handling and add a comment.
- Remove  unused macros as part of 3/6

Kieran Bingham (2):
  media: imx335: Support 2 or 4 lane operation modes
  media: imx335: Parse fwnode properties

Umang Jain (4):
  media: imx335: Use V4L2 CCI for accessing sensor registers
  media: imx335: Use integer values for size registers
  media: imx335: Fix active area height discrepency
  media: imx335: Limit analogue gain value

 drivers/media/i2c/Kconfig  |   1 +
 drivers/media/i2c/imx335.c | 642 ++++++++++++++++++-------------------
 2 files changed, 308 insertions(+), 335 deletions(-)

-- 
2.43.0


