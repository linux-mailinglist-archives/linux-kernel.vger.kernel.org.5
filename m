Return-Path: <linux-kernel+bounces-142993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B658A3304
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB322B21A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B5148841;
	Fri, 12 Apr 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dT+Ryr+g"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37484A35;
	Fri, 12 Apr 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937653; cv=none; b=kbOz8pUm1/K1mYVoj1Akb9t3DEfsyF75/dP3NYhbu+Od33Cgj58AUcSqYMih7QZ0KK/Oo3k8CL0CEksj4TUykz6RpokgpMZyi8CT46pV0si1gTNfcKunN18rFYjv1IQOtrdats1KtnzfOihChufv2UiCNZIo9Pm3iuj/aIpDYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937653; c=relaxed/simple;
	bh=VoJ3Y26a2XDlHa6cix2uE+qXKRTMTyo3m8O6z5t12GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SE7AdM+4e/yIxf88WBjgjjxZP3ownLy/ZQASA1kz/4OX5fX+ZoTWVMocL4pMXOxx7Mk00HKkaDdw5BVy9LmIUYMwwZtOveeVeHkbhagIh9CICBG8du/jVZDxANQHxzGkcxsMKY4kFpmc796tcoZi2ecmz49bBJafUiSIUTdnJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dT+Ryr+g; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E25F6149D;
	Fri, 12 Apr 2024 18:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712937605;
	bh=VoJ3Y26a2XDlHa6cix2uE+qXKRTMTyo3m8O6z5t12GM=;
	h=From:To:Cc:Subject:Date:From;
	b=dT+Ryr+g4hGfiv6gPCmYrJQ5lpvl4dHcjWHTLf8L0kKgeqxs3tXo7WHkri5E6pH41
	 PCvYQrA/LGPiYAWjJ2y/nMAhCFTdcmELK+SpH9uOI/vv/xkUgFMPDWG38DrlTaLMTI
	 5Jcea7XbO1CPXP7Q1P9xfUwBday6faUd8Mj7XIE0=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v6 0/6] media: imx335: 2/4 lane ops and improvements
Date: Fri, 12 Apr 2024 21:30:33 +0530
Message-ID: <20240412160039.276743-1-umang.jain@ideasonboard.com>
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

Changes in v6: 
- Modify 2/6 to call v4l2_fwnode_device_parse()
  early in imx335_init_controls() and return early if error.
- Treat v4l2_ctrl_new_fwnode_properties() as one of framework
  functions, hence check ctrl_hdlr->error should be sufficient as
  requested.

Changes in v5:
- Simplify error handling in 2/6. Check for ctrl_hdlr->error
- Space fix around { } in 3/6. Drop /* undocumented * as well

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
 drivers/media/i2c/imx335.c | 628 ++++++++++++++++++-------------------
 2 files changed, 298 insertions(+), 331 deletions(-)

-- 
2.43.0


