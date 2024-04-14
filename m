Return-Path: <linux-kernel+bounces-144173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B88A42BF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D41E1F2123F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C33B53E0C;
	Sun, 14 Apr 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="S+2hexO0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF43BB32;
	Sun, 14 Apr 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103593; cv=none; b=kyl8dSSYVvM2TjOeILYKGLPyDNQel/jP1vyYWZ6a8Ss8mRYiYKk1ivnSIX+ga2xOqDrrJ26PejZRea3cvI365qcWGA8M6JGY5LmuBb8KS4Dsy7JmuWGc2t/jPvR3KJwZ/h85RIXwkrR55xmpWdABJrUsMYWguRHQ5dsf9ZucwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103593; c=relaxed/simple;
	bh=97Kfxw2vJLy8VTdAPr/Shlmrhc9IMQ/bCXXl2Bnmxfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kg65VArr6E1ZbXMAQBYwPrQrafjag3sTXWvEF6wyn/JM75nt/EqHeNDLBpgsEgw1VbHKbOcGNKML6gf6tZ1aVOzvzenyHud5L4fljlVCEeRyTsogphdXVdeMhqaGC6E/BX0aTqUX9Ldaz0Rt8RnDwjzHbLTf+w0lFgCU0hDMIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=S+2hexO0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.238])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F344512;
	Sun, 14 Apr 2024 16:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713103544;
	bh=97Kfxw2vJLy8VTdAPr/Shlmrhc9IMQ/bCXXl2Bnmxfo=;
	h=From:To:Cc:Subject:Date:From;
	b=S+2hexO0BrTlysfPDX9VsBVsXOzWhoggaZ38DCENA05Gjj3jsODyiPrVZs2pW+82e
	 tp6n58sPhn7+4HuWhRQjUUGf9i+42DTIRNrjc1oIwpEa7N83KCGGQ14x5Z8XZRIEYQ
	 d6r1N+WFoRxCcLPC6s/S+xKeWMCCpRMzMJQx92YQ=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v7 0/6] media: imx335: 2/4 lane ops and improvements
Date: Sun, 14 Apr 2024 19:36:15 +0530
Message-ID: <20240414140621.167717-1-umang.jain@ideasonboard.com>
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

changes in v7:
- Shuffle CCI regs #defines for TPG and REG_INCLKSEL* in 3/6
- IMX335_REG_AGAIN -> IMX335_REG_GAIN in 6/6 as single gain
  register to handle both analogue and digital gain.

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
 drivers/media/i2c/imx335.c | 636 ++++++++++++++++++-------------------
 2 files changed, 304 insertions(+), 333 deletions(-)

-- 
2.43.0


