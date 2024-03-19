Return-Path: <linux-kernel+bounces-107163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C487F85B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFB7B21C95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E975381D;
	Tue, 19 Mar 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LR7dTwCl"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC24537E0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833246; cv=none; b=JT6ZLw783l/CRM32KTs6CjbvGGvUiIM8xrI5UiPgl9QJ3+O0cuLQIrvC7qga4zbMHA8HyKmhmJB1bMClv+8l/65XDgU01D0Pgm9kFQ/UvOqZ6L5tLONEMELlx908/6bvIqCfVwHdAw0V89i5Oi3bQ2jaPnTGKSeEuEXYT+AS8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833246; c=relaxed/simple;
	bh=tPFBex1OEevmHxrFo+EdIpjjtTcTDY0gB2JAaQlM4Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=By485OX12I2a4gxmHmeK7pmevc9tWrT3w/i9RygttpQJS/g4rKMo8W3RzS8+2SP6uZwcLqjba0eO88u4ZHeHDbkvyOVWT0hwlwB+y/69sNcWp1+iXFQyV2pGaSpQ3pR/8AajTMqmPwOJXrSszbC1Fh7coQ1EVeNl+35ai0xuZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LR7dTwCl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED1CEBB2;
	Tue, 19 Mar 2024 08:26:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710833216;
	bh=tPFBex1OEevmHxrFo+EdIpjjtTcTDY0gB2JAaQlM4Yw=;
	h=From:To:Cc:Subject:Date:From;
	b=LR7dTwClQyGOIYhqLNnaxShclgx4EabqFHL2EUImiTzmKQmATomzbWBpzfr6Ae79/
	 WnpsWn+0oeXawn2dHU8fq9p8TpDp5OXngRB6BvEZK6LoU6XQmDizow1AEQNTeZNpul
	 qOuEVl9Qmu/9SQ4k1Qmyhxd7KtITZCxfcIOtMM4o=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 0/6] media: imx335: 2/4 lane ops and improvements
Date: Tue, 19 Mar 2024 12:57:06 +0530
Message-ID: <20240319072712.133449-1-umang.jain@ideasonboard.com>
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

Patch 4/5 uses decimal values for sizes registers (instead of
hexadecimal). This improves overall readability

Patch 5/6 fixes the height value discrepency. Accessible height is 1944,
as per the data sheet in all-pixel scan mode.

Patch 6/6 fixes the max analogue gain value.

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
 drivers/media/i2c/imx335.c | 646 ++++++++++++++++++-------------------
 2 files changed, 310 insertions(+), 337 deletions(-)


base-commit: 54ee11761885407056f4ca60309739e2db6b02dc
-- 
2.43.0


