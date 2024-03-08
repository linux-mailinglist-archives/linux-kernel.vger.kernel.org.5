Return-Path: <linux-kernel+bounces-96654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9141875F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF5D284A19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E925720DD0;
	Fri,  8 Mar 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WWW+VkfZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6B1CAB2;
	Fri,  8 Mar 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886806; cv=none; b=UR8eBuUEtVwY/GBplc19E4ls2/o8uYLlY2Xda8lhf+NOtxtPHXpUeXGYHA0/hKFWj+KCL51FBaPSxlq/EbRo9Fn2E2k1f5tm35EHJEL7GzClN6QOOUsZU5AskpG7dbnN1AFrh8pfCmAdU3AJxbXULOw6AIsCBRJZv3k0/SyR/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886806; c=relaxed/simple;
	bh=GQz6FK0fcrLLlq22p/6afNe0BqxB+3Uv8eBSSHivsn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tw8IBYqjYWj/AG7vHNIkOyvsQdOcVNUdXB2spX5QBbja5XOVJxDKyoEdFsIJmOb0oo231wdE/U7NWqKjplH35lmppmZ1QZcAF4PGyNy00XNbXE/l6mDdgT8/bqKpxWW3s53UK6MKiCN36ePpu+f7du8qeS3dwKD8vI/vbVsw+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WWW+VkfZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B683E552;
	Fri,  8 Mar 2024 09:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709886783;
	bh=GQz6FK0fcrLLlq22p/6afNe0BqxB+3Uv8eBSSHivsn8=;
	h=From:To:Cc:Subject:Date:From;
	b=WWW+VkfZ8iRvZmox/qD30FRZ2AMjk68hLb9X857dgvKzHID9jvffwcv6ZTentKzwe
	 aFarvIvySptU2YPP70K+JRYdqWoqK6tcODwnA6cPgGuCrfkB8/OC0M/n1GrsLM1xYY
	 1tW4qunQoW9zUN0c5MBQHNYIyjJ45v/nFjqG7pSA=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/6] media: imx335: 2/4 lane ops and improvements
Date: Fri,  8 Mar 2024 14:03:06 +0530
Message-ID: <20240308083312.90279-1-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 634 ++++++++++++++++++-------------------
 2 files changed, 303 insertions(+), 332 deletions(-)

-- 
2.43.0


